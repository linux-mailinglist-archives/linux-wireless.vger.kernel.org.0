Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2E284479
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 05:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgJFD7m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 23:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJFD7l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 23:59:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D3C0613A8
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 20:59:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i3so962313pjz.4
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 20:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwQgWzWi8pW4lGFBA/hNXn44tp/wqyyuzS23wCHudYY=;
        b=WN2jLYS6d66X6qKUYp9LHZ0kkOpP4DlC4ERhY0B2thBryPz0dFWJZ0MvKDmd7HCRTk
         +Ui1TI7bInIXJzpW29t5spz8EkOUqFrRbL/mtwthHAPr7mlfdoi7ONZ2gbPTaJP7KPnA
         xSnlXzVRJEiVDpvaXNKn/H8VFm6LcmfDbdP9dYBxXCH7DTKRJBS+MgFr+DHaoxDYs5ny
         b7VmjywRDYcGu76G8XmxCtLo++Lhr29SgFYA22c9Sp6DvJF4cPiWWOXOtRL1HNtanBYF
         AB43xwz+/TFajficUTK9peGERcwgCSeEOKu3k+MhxxPVS4NGznBdbydoEiqVuVt6Rs9g
         ssHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwQgWzWi8pW4lGFBA/hNXn44tp/wqyyuzS23wCHudYY=;
        b=mpCwQ3cLaJJUwqSXbQwzoMa8grMfrjKJKyg48kHAXUj7JGB3nBDLrRmmco4mp4LdlM
         mUKVOz3/1QDodhRnCRtFbaHBCDsz9cBEcnzIsnyjdniHtTRx0JWjcRPvOG8NjiBzxFX+
         sNx8fR04o2PAdpjS73V09HQjcFHE84TkyAf/MF/MYyypTmxA4r9xtPEvccUCyKDURG/s
         AEah8mR1CbWvxc6AcshZV9j7zQr2YPiAZ5ZCLZl/CDEZCZYxUMju/dvzauaBKxU7NMiv
         NFghCdvHFTMwz8ekrajEMFELa+NE/in/PUNkKLDmp58Mgjx1ZBzRCNVx1Q7VagEop7/M
         d5sQ==
X-Gm-Message-State: AOAM5318x/BDkwZtIXlWiDttZDXTcibrHxGBR7k13RNwbZqYHdps+aXO
        aycNhF3aTvkn2SSH1oj5MLqEKw==
X-Google-Smtp-Source: ABdhPJwxeQePmlkOqsSZMu0AnnoQqt62AYUlhHtNR3aTgcgxKS6eopsUdGayn73I2AS5/7QT2bpLUQ==
X-Received: by 2002:a17:90a:2c05:: with SMTP id m5mr2518492pjd.9.1601956780021;
        Mon, 05 Oct 2020 20:59:40 -0700 (PDT)
Received: from localhost.localdomain (111-240-119-203.dynamic-ip.hinet.net. [111.240.119.203])
        by smtp.gmail.com with ESMTPSA id u18sm1238540pgk.18.2020.10.05.20.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 20:59:39 -0700 (PDT)
From:   Chris Chiu <chiu@endlessos.org>
X-Google-Original-From: Chris Chiu <chiu@endlessm.com>
To:     pkshih@realtek.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] rtlwifi: rtl8192se: remove duplicated legacy_httxpowerdiff
Date:   Tue,  6 Oct 2020 11:59:28 +0800
Message-Id: <20201006035928.5566-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chris Chiu <chiu@endlessos.org>

The legacy_httxpowerdiff in rtl8192se is pretty much the same as
the legacy_ht_txpowerdiff for other chips. Use the same name to
keep the consistency.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
index 81313e0ca834..0cdcddfebca9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
@@ -1906,7 +1906,7 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 	 * index diff of legacy to HT OFDM rate. */
 	tempval = hwinfo[EEPROM_RFIND_POWERDIFF] & 0xff;
 	rtlefuse->eeprom_txpowerdiff = tempval;
-	rtlefuse->legacy_httxpowerdiff =
+	rtlefuse->legacy_ht_txpowerdiff =
 		rtlefuse->txpwr_legacyhtdiff[RF90_PATH_A][0];
 
 	RTPRINT(rtlpriv, FINIT, INIT_TXPOWER,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
index a37855f57e76..54576566083c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
@@ -25,7 +25,7 @@ static void _rtl92s_get_powerbase(struct ieee80211_hw *hw, u8 *p_pwrlevel,
 
 	/* We only care about the path A for legacy. */
 	if (rtlefuse->eeprom_version < 2) {
-		pwrbase0 = pwrlevel[0] + (rtlefuse->legacy_httxpowerdiff & 0xf);
+		pwrbase0 = pwrlevel[0] + (rtlefuse->legacy_ht_txpowerdiff & 0xf);
 	} else {
 		legacy_pwrdiff = rtlefuse->txpwr_legacyhtdiff
 						[RF90_PATH_A][chnl - 1];
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 13421cf2d201..0a516c3c7cea 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1966,7 +1966,6 @@ struct rtl_efuse {
 
 	u8 txpwr_safetyflag;			/* Band edge enable flag */
 	u16 eeprom_txpowerdiff;
-	u8 legacy_httxpowerdiff;	/* Legacy to HT rate power diff */
 	u8 antenna_txpwdiff[3];
 
 	u8 eeprom_regulatory;
-- 
2.20.1

