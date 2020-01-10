Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3FA136DE1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgAJNXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 08:23:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41994 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbgAJNXY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 08:23:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so2112281ljj.9
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2020 05:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGIL7xB5vL/1N3b42c5s3EEu3HqzAh3oOl0k2K1LYTw=;
        b=mGvHcYmNxDS0zt5KHZiDP9DgEokfLGQ74WZLN9hhD3jDh+8B531T641nAXhQ4bcTLh
         +eQd0GRLv8EQRY0DMsIuU9eDGDHrVZZbyinqsBUFOy813S1kI2n7XsYWQyjLvhddIwPw
         j7+YVT7I7EbBS4Kt1VW+rSk1Hhx+knBZRgqvCxXuBMxqIaj8C+B3+V6+oC4q0xRwT2sB
         Cd6FWFJRQWVBGCQFFiXLzCyrr4D2mJFlk+fsAUqCpztyDn0RShAQ5RilivKdw5p/lYw1
         TbPTlPiiPWMsW75PMIqST8R50vQDpawoBd9nkYxY4nUWquLvye3layG0aXleE0JxTlp4
         j4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGIL7xB5vL/1N3b42c5s3EEu3HqzAh3oOl0k2K1LYTw=;
        b=a+R0BJB6Y/1XVqnmJYVl9d3x9aRkbgd0+QpOqP/58HpP6lshxzyRrMaEYKkjbbnKF0
         lH8MmVWi5PeH/AMy7T2hMglNIYLFTfmteB7ZmrAnAQSoeoQFHw/fdePohZoR7lGvmiMs
         RabwnhTprLO+nb8fkADNGm8vO/JQPTLtrP1sHLFOOt/I/WjJKgF6TwQKIox1HkKvnNXZ
         kDEQIEwbxqtbFsU+ofzNKHOwwcH8bTOFLmKMnDNrkseT1m30SnC4h67UFlORE9jWIy7I
         UMKV2eJwdS/D0RZ7IP62LSH9Ef4OSLVPmbh0eWitmDgBfqdTZ5uEsyXy8XGDgsgEt9zj
         zxyg==
X-Gm-Message-State: APjAAAVWIvPY6sgK/3u5ahBkCXfZs8lBKxI1QN07ymvYtlLic9rDa1WI
        gM9rUswTS7grTYiaaArau/47TeHW
X-Google-Smtp-Source: APXvYqw4TtiuajtBw1Yk0JwLuari0T2llLxZxioQGgrwHjkJhba4DS2fi6ijNKO/4HtGFuseY+s7Ww==
X-Received: by 2002:a2e:b555:: with SMTP id a21mr2716241ljn.170.1578662602669;
        Fri, 10 Jan 2020 05:23:22 -0800 (PST)
Received: from dk.user.kdf.lan ([89.18.140.18])
        by smtp.gmail.com with ESMTPSA id p136sm1039641lfa.8.2020.01.10.05.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 05:23:22 -0800 (PST)
From:   Denis Kalashnikov <denis281089@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD cards
Date:   Fri, 10 Jan 2020 16:21:42 +0300
Message-Id: <20200110132142.7737-1-denis281089@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
flashed that a card has 3 chains, but actually all this cards
have only 2. This leads ath9k to write into the logs:
'ath: phy0: Unable to reset channel, reset status -5' and
stations don't see that AP.

Mikrotik R11e-2HPnD is based on AR9582 chip.

Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
---

Changelog:

Changes since v2:
  Use macros AR_SREV_9580_10 to select only AR9582 chips (they all
  have only 2 chains) instead of more general macros AR_SREV_9580
  that selects not only AR9582 but also AR9580 chips with 3 chains.

Changes since v1:
  No changes, only resending through 'git send-email' instead of Gmail.

 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index b4885a700296..86a9f49ae0d0 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3373,6 +3373,15 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 		cptr -= (COMP_HDR_LEN + osize + COMP_CKSUM_LEN);
 	}
 
+	/**
+	 * Fix firmware bug of some Mikrotik R11e-2HPnD cards (based on AR9582)
+	 * that claim that they have 3 chains, but actually have only 2.
+	 */
+	if (AR_SREV_9580_10(ah)) {
+		eep = (struct ar9300_eeprom *)mptr;
+		eep->baseEepHeader.txrxMask &= 0x33;
+	}
+
 	kfree(word);
 	return cptr;
 
-- 
2.23.0

