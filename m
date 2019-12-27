Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA07112B3C5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2019 11:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfL0KCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 05:02:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37015 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfL0KCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 05:02:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so15290087ljg.4
        for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2019 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eox7lEH740PTF6D96eI3HV/UGGPqU91i5ubWo4citZk=;
        b=r+gp22DTWkzSgzAMpTbiOylfpkQd67WQmmo+0oYgza5niAhbeux7h7Px2gXotp9GpX
         CZ/UqfB2Drv0cqj47BsP1tlaVP5kC8/LjAwFbcqV6srVOPR5sl3vCJjEFxVIFnfQCUnW
         P30jwJPN4EyvA4RdrZG3hEUBdc0h/Bh+uWv9sESpbllJJjX+SepEChRfOj6aKBZ5wFzH
         CqXOF/wIJjp5gSgQomt9RqAEe2jHHjD7i2eh/2RGO+C053OhzrPfGeCh8obX6gMK8FBJ
         fAwklMyPnt19Ag7ddEbFed1jHzfxgIfe+lxgxLgItIaiXhC+ukCGVIhlLrfw4TuXnYIA
         yUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eox7lEH740PTF6D96eI3HV/UGGPqU91i5ubWo4citZk=;
        b=Va5Pzc0ok9LcDz5O4sw2u6zJUmyUhevIuNtxvZBdWKqEEzNilEesApu3dEPMqS66mY
         tLE7s2mOa0LBDBYMn03eygIixZBlzDJRbvi/fiV+Lcgr+i9+N+jiCUyGIWX3PBlMgCAz
         PyBQQH2dPP004pfpX8my9YtOyAy0BPF2/GPRvM9e/PVyWKpguH+6A3h56rXBRJdHY2S7
         Wtokjel3SVSRSaI1byeBExBDYQPX18HYpsODoxE+NO4nFTh8Dk+YYxS6gQoGdAcSV9Bp
         vomzUo+RqIZOAgfaCAOHB8U8rGr2jJzN23ywCwarTMDnNV4ue2xpDoEDiAHbLHBQfGbm
         +ltA==
X-Gm-Message-State: APjAAAWfULJQwq8uUIM1jzSvvw5ydOJs0OTuASlHyc2tyYhUhCwhcBtD
        FHTB+kErhZg9l+3YEDWal0K46bmRYkI=
X-Google-Smtp-Source: APXvYqw/8n9exj2PKvPupbAprB2qPrkTg4gVhQq+Zm87NnJxSklJsLgmZSpW6RDP9xVLtiRlYogohg==
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr27216632ljc.84.1577440959667;
        Fri, 27 Dec 2019 02:02:39 -0800 (PST)
Received: from dk.user.kdf.lan ([89.18.140.18])
        by smtp.gmail.com with ESMTPSA id s13sm13492983lje.35.2019.12.27.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 02:02:39 -0800 (PST)
From:   Denis Kalashnikov <denis281089@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [RESEND] ath9k: fix firmware bug in some of Mikrotik R11e-2HPnD cards
Date:   Fri, 27 Dec 2019 13:01:15 +0300
Message-Id: <20191227100115.6870-1-denis281089@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry, first I sent the patch through a Gmail web interface, and spaces
were broken.
---

Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
flashed that a card has 3 chains, but actually all this cards
have only 2. This leads ath9k to write periodically into the logs:
'ath: phy0: Unable to reset channel, reset status -5' and
stations don't see that AP.

Mikrotik R11e-2HPnD is based on AR9582 chip.

Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index b4885a700296..554a81400648 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3373,6 +3373,15 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 		cptr -= (COMP_HDR_LEN + osize + COMP_CKSUM_LEN);
 	}
 
+	/**
+	 * Fix firmware bug of some Mikrotik R11e-2HPnD cards (based on AR9582)
+	 * that claim that they have 3 chains, but actually have only 2.
+	 */
+	if (AR_SREV_9580(ah)) {
+		eep = (struct ar9300_eeprom *)mptr;
+		eep->baseEepHeader.txrxMask &= 0x33;
+	}
+
 	kfree(word);
 	return cptr;
 
-- 
2.23.0

