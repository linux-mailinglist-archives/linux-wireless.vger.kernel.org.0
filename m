Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8D357220
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbhDGQ2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhDGQ2K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 12:28:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9249C061756
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 09:28:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s11so13276904pfm.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Apr 2021 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZ+xiZOpRc4/cuZiE69tk9aJLUf4L6Cl6hXfMv3w5kc=;
        b=PP/KjVVwcDXI7CFYm4MiGqZ8jTR8t+2FCE4Ss6uukwV7LhonoZSpXdyRmoX+4luWhD
         1hRb8wsJ33zOfiByvj8WlSYbD/fVb4QRfcKLr7SEgJESYbemsjcOj3/5F28/tt1EF4gL
         hzbZIK6VXs2pjCj+dh3RhkVq6dYLrf0m1aCmVGsN1ghd5HGMmFRXMMWJoanz3qeUpmY/
         QdD/w5PaSSXXsHMmAhcg53FeH+CYT0cW34pWNPIKFuCgpHrOfwStFiqkcCmDzWvSD0ZF
         2PkhvL19+mkdFkI3koETUTe0osFLTrGT9cuE4UFLV4j8s3UdZTcNkTnnoy9e8c5vVira
         NJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZ+xiZOpRc4/cuZiE69tk9aJLUf4L6Cl6hXfMv3w5kc=;
        b=uDTGojH+aMZeL5xbJvqQT02ErNvh5PRtzYP1qBUr6XLkB9CdYpUh2NhiE99bITCmUe
         3Nqc4IJcEiIwaTIdhWpUxu09KwCyNBqdzjFDjaQ3eJcjIyhH0xGMBKglxqrB0X6+orBQ
         Soh4uAD8nry5WjFXb/SPT77ata/ybEdSDy1z+yBHQu0GT1KNpJVOioyTZRwunmsHSPJ/
         Y3dTmVD54cg3R0yOez9xqDIWhUoX1PoFsXpDrgEgMAjxs/m1Jcp7wpqjCnXcdJrYbtta
         nVJJZC5F6tnrt3IYXli/xcTB59KQvXXj5oH9jRhytEqzSsAou1H1NlmUH9m29xaWKN16
         SQwg==
X-Gm-Message-State: AOAM532nmrf8wkhQmeI4tbyxT16Fc57KdbWustPECVy+yegJmtAHwqh5
        QylvzhvhRchQbbMHPV8skKI=
X-Google-Smtp-Source: ABdhPJxe4+9cHRK9bziPh4t2NQtWqUVT83B00l6nmQOK7/cduqDHEUYKHBZuAUO0MTE8Ofb/RL2cMw==
X-Received: by 2002:a63:6a84:: with SMTP id f126mr3994000pgc.352.1617812880450;
        Wed, 07 Apr 2021 09:28:00 -0700 (PDT)
Received: from nuc.wg.ducheng.me ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id g8sm5138969pjb.25.2021.04.07.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:28:00 -0700 (PDT)
From:   Du Cheng <ducheng2@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Subject: [PATCH v2] net: wireless: remove WARN_ON() in cfg80211_sme_connect
Date:   Thu,  8 Apr 2021 00:27:56 +0800
Message-Id: <20210407162756.6101-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A WARN_ON(wdev->conn) would trigger in cfg80211_sme_connect(), if multiple
send_msg(NL80211_CMD_CONNECT) system calls are made from the userland, which
should be anticipated and handled by the wireless driver. Remove this WARN_ON()
to prevent kernel panic if kernel is configured to "panic_on_warn".

Bug reported by syzbot.

Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
---
change log
v1: convert WARN_ON() to pr_warn()
https://lore.kernel.org/linux-wireless/YG3bYPSB7Guv%2FKEe@carbon/T/#t
v2: just drop the WARN_ON()
 net/wireless/sme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 07756ca5e3b5..08a70b4f090c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -529,7 +529,7 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 		cfg80211_sme_free(wdev);
 	}
 
-	if (WARN_ON(wdev->conn))
+	if (wdev->conn)
 		return -EINPROGRESS;
 
 	wdev->conn = kzalloc(sizeof(*wdev->conn), GFP_KERNEL);
-- 
2.30.2

