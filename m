Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1FB899E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 05:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392033AbfITDAw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 23:00:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44050 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbfITDAv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 23:00:51 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so12740088iog.11;
        Thu, 19 Sep 2019 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wR9pye3sH3f9c/Ue486PD/cpETKoqUyEfHnMaMiRPdY=;
        b=fzAGUdQVIXP8BO6Um0bEY7aXmxWrofp3WYusEuhMgPmQ27A5ZhIq51xSMAN9gohJey
         xdsD6nXME5ZveH9/lQ1MvNo7e8lxKB+VJiF53+KRWHjYY3yo3CO+r/lMh38wUGe5T120
         NI5FyQ8YmYV/aaqGUTa6/SbDVBDZBSb3F3uOkXNjWxRyI80HGsx60/fhQaY8HNtHHcDb
         511aV1DthYS9mGIh4z56qpebAKs9Q6CMcrqtYaemGR01y1sZsyooYZweWPqYYQ28lZUi
         oVHgUKZHp3jvfYhzZnVc8ousIPPiZiLXszN06Siqs6CGkR6p4m+lf80we8Xi6J0bEISz
         hFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wR9pye3sH3f9c/Ue486PD/cpETKoqUyEfHnMaMiRPdY=;
        b=mUe4i46sJphvT9eHFwqTegYlyqNnE95+R/GbAr/Is0OJfzCFXHu/cUrw5ElaQR4ATd
         ShSEU7xpcL4ISPtNRc3kSBvt3ROv3RHbxdgCw3UYVG+DJLMet3AvPnJT0bwN5UWcCodd
         z7bw4VprjwTZj8WPj+itlX2LdPws17O4C/ROM8RuRJ7MFQLwCg0qLscbxBXwKUsnyoTp
         KIi52u4X85ABBEBFgGrx6ZS/sllG/u+spcSMjf/TVV0UglkLy7sRgZ4gyMBHgbMrzUDO
         tGJQMGon7uU9OTA6a73s3ap8eeQ/c8KZUftJBh6c7xJL7qrH5lfZJSQBjePgKF+RF/rt
         40wQ==
X-Gm-Message-State: APjAAAWUFzu7MpjxWJtu4hgZuo8rk1uE8i27EiFcdjhNEG5ZaOg9jkNB
        zqGym44mT1nF7nFS4RHjg/Y=
X-Google-Smtp-Source: APXvYqwI+IXRu7Lhr0HmMj08qfXGIRkcCHYMdmSMkCW5GIIz+Ml1cQ5Uy6GCUGV2WrCpixMQAv4aog==
X-Received: by 2002:a02:ac82:: with SMTP id x2mr13978167jan.34.1568948450810;
        Thu, 19 Sep 2019 20:00:50 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t9sm380269iop.86.2019.09.19.20.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 20:00:50 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8xxxu: prevent leaking urb
Date:   Thu, 19 Sep 2019 22:00:41 -0500
Message-Id: <20190920030043.30137-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In rtl8xxxu_submit_int_urb if usb_submit_urb fails the allocated urb
should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 8136e268b4e6..4a559c37e208 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5443,6 +5443,7 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 	ret = usb_submit_urb(urb, GFP_KERNEL);
 	if (ret) {
 		usb_unanchor_urb(urb);
+		usb_free_urb(urb);
 		goto error;
 	}
 
-- 
2.17.1

