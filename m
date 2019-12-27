Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF512B254
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2019 08:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL0HTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 02:19:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46643 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0HTi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 02:19:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id k8so18114417otl.13
        for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2019 23:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iI5a2I7+cd4Vv2Crlew/v0aivZjOlOMXtTEMnRbC6d0=;
        b=fSFU+51U5ju5r3a3fNt4heUaY7S5gqQ/Um68xgn4SL+AGRX6AD1EJyK0rRmdDN/mjF
         58CNvZzsVCPhoGNLcKISTs2QjXtXp/7bovw4gThprkFKbqIAstqir5+qy05B5Bae02Z8
         ZnxC95+yknkpqDAO8wShE0h8cyZm2YGoFWuaRCGnWbTVRlREoPLJv0orb945jzzqHc1V
         IHE/6v0g5QnSqkECXbgjsWwPPwEINj7k0BbjhY+SqV+lsdXMsC1MJ094Wp3IlgWWPAV/
         /K7WREPXxal2pVL4WIrlA3MCGZC+ceinOMWLxE8lSmBWDyZ8Yi49H2f1oRsSgVmVjBMQ
         YH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iI5a2I7+cd4Vv2Crlew/v0aivZjOlOMXtTEMnRbC6d0=;
        b=F1QO39QV5S+vCZeBXrYTqf1Or/M+nmTFi9O2ASPklOOz8W4mB8y4tmx1eR0Rpia+V3
         TRdzfXNa6TzstlbDuDM8TRtRALVmcZ6y0jK2UwrfEa6gMtJwHb+O2mBS5NUWzNlMmpjD
         daOWnmtbtPfIeBzghBoXj+/ceXLSCKL6EDvRT1J7YbZJXjac13qIxyFUhLyhD39A0kUR
         Xnzc2bPV6qQeBYyJwQxk66pe4L6KnQWXH2DTfb9hRViayOIVb0tnZ6Q5+0wFt4Uv33/e
         6lbi84TatfPnfMabptEI/xxbmMzBcfSK+vqcENFM9hqa5U9T2ILCWkl/w1mnpSLOkwon
         1AhQ==
X-Gm-Message-State: APjAAAUUT5BcVIsCdLp/G6cXbleeQ4Ojt6r4tuByR6SpNurhPJNK3PNq
        VGwnRC1CMiVanq7lWvR5+GAsgkL2DiEl9h3aw2/bu+FW
X-Google-Smtp-Source: APXvYqz6WDb1El9wbzU2T2hLLnpFI2sh6FMlpENzBnVroPC3UJlrhyHX5IOWdO5yGDmauNBerHDjAX6LZtdi427oDIY=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr41775888oto.289.1577431177224;
 Thu, 26 Dec 2019 23:19:37 -0800 (PST)
MIME-Version: 1.0
From:   Denis Kalashnikov <denis281089@gmail.com>
Date:   Fri, 27 Dec 2019 10:18:05 +0300
Message-ID: <CAKoLU8M+QU-96vnfet-759nnXyxxJmsf1Csba4FgNas8ZVOnOQ@mail.gmail.com>
Subject: [PATCH 1/1] ath9k: fix firmware bug in some of Mikrotik R11e-2HPnD cards
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index b4885a700296..554a81400648 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3373,6 +3373,15 @@ static int
ar9300_eeprom_restore_internal(struct ath_hw *ah,
                cptr -= (COMP_HDR_LEN + osize + COMP_CKSUM_LEN);
        }

+       /**
+        * Fix firmware bug of some Mikrotik R11e-2HPnD cards (based on AR9582)
+        * that claim that they have 3 chains, but actually have only 2.
+        */
+       if (AR_SREV_9580(ah)) {
+               eep = (struct ar9300_eeprom *)mptr;
+               eep->baseEepHeader.txrxMask &= 0x33;
+       }
+
        kfree(word);
        return cptr;

-- 
2.23.0
