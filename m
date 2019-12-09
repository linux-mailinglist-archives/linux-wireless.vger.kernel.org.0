Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF286117BD0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 00:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLIXws (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 18:52:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43606 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfLIXws (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 18:52:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id h14so8049163pfe.10
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GY/+1o1zLdYfvCqb5s+Ly8hX35JVekQIGLz3reNdQ0w=;
        b=FogYBJaCrQ5GcvCWjiTFxrHKEneYcAB8vY4Tjhcat7UFdWay6/83ZOXe9McWW+X5ig
         Y7813rzWdHgwZpJFd1S09IEXMnWvL3d8TJj4M4sMXrBlbYm2CNcAHMtEmWDl/1ZIltZJ
         qyHpBdGQAXi96ky96uVlmQYgqidE40eTHqsyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GY/+1o1zLdYfvCqb5s+Ly8hX35JVekQIGLz3reNdQ0w=;
        b=lFxtdRxfqdWX5qui6vv1oCiqjpsZK6fWIL0CfRIUk9gN01NWdIw5Fp0mWOfcYg9kSN
         xHCHKh2qCruwhinudieu8LE7/7YleYe4NojxrEtY2fzpWbjKXmJ76Y3H9bBRSramN+60
         9PK8Z6Ikco3VWbLmp9B8vwZEJ/0Z5s/13YuS1/5GfxpgeEWCGBGuZTsQH1ItjHfoavq3
         Iahd6ZlmTQLZTs1nYbRF5+Sbk/WziFrD734AtZAdAzmNSiuDK/ejCWE/+8+XIDVusQdQ
         o92bKsCue91jphT8fr2HshiUqDYs9Lf7IGv9mQAQH+H8aaLT0wXQeIXmnQRlwOoaPYi5
         rOHg==
X-Gm-Message-State: APjAAAWPDecCxR36b8mYRIeXLK6wm9lW1smVdx1yDhOcJWmyvGVBg/SJ
        x3Qt4zGZeokEiaZOtQlX5dG/luO66g4=
X-Google-Smtp-Source: APXvYqy9TUL5rqDcp/B/qy16AJcabYQBNLq0iyZvX4GNbmTFLCh8dcHod2fiqqveCZmOOIunkNEaxw==
X-Received: by 2002:a05:6a00:5b:: with SMTP id i27mr32641625pfk.112.1575935567260;
        Mon, 09 Dec 2019 15:52:47 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id k66sm635587pgk.16.2019.12.09.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:52:46 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: start out with BSS type ANY, not STA
Date:   Mon,  9 Dec 2019 15:51:16 -0800
Message-Id: <20191209235116.142692-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mwifiex starts out by setting up 3 possible interfaces, but usually only
1 of them gets initialized later. Currently, we leave the
"uninitialized" interfaces with bss_type==0, which means
MWIFIEX_BSS_TYPE_STA. This gives misleading results for things like
mwifiex_get_intf_num(..., MWIFIEX_BSS_TYPE_STA), giving the answer "3"
even when we only have 1 initialized STA.

This bug doesn't affect functions like mwifiex_get_unused_bss_num(),
which are looking at the bss_mode field instead (to see
NL80211_IFTYPE_UNSPECIFIED, which happens to be 0...) for finding
uninitialized interfaces.

Let's make mwifiex_get_intf_num() give a proper answer, by making its
initial value the proper uninitialized value -- ANY.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index a9657ae6d782..a9063411d243 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -97,6 +97,8 @@ static int mwifiex_register(void *card, struct device *dev,
 
 		adapter->priv[i]->adapter = adapter;
 		adapter->priv_num++;
+		/* Start out as uninitialized. */
+		adapter->priv[i]->bss_type = MWIFIEX_BSS_TYPE_ANY;
 	}
 	mwifiex_init_lock_list(adapter);
 
-- 
2.24.0.393.g34dc348eaf-goog

