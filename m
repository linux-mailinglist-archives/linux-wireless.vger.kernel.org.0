Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1C2838A5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgJEPBF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgJEPBE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 11:01:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84286C0613A8
        for <linux-wireless@vger.kernel.org>; Mon,  5 Oct 2020 08:01:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a1so1205381pjd.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Oct 2020 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwQgWzWi8pW4lGFBA/hNXn44tp/wqyyuzS23wCHudYY=;
        b=hAHwiiCC0apGox5V3MaNpJ6GcRX5A0OUk7i3HfLE+C8KjaKKTVy/P/IA4tDtiRh9Zc
         3iNvD2PYwpn/c0wO+7CGD0/4hC9S6ND2rPDZJGC3jsABHldNc8aZg+IWATL2qoCYxzcs
         rfC6rCuQ2jlQEkVNyOR/4VAwpfrTsGq3d0Ox5KgP9pRUI0zaRSvMccqJ+/N9zo6ATpy5
         3/l2oCcm0rJJ5ZaMwsVgig0mELBi25rEEIwpamTEUP8oS3aeSmOft09sArQhLRUnDGsD
         kNFDM5LcuL8ePSFZ9NZpMC1TkTnNDDbI51rPy2oOpTaRPOSMpt6M4ZZrs2YWdVJw8adn
         gGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwQgWzWi8pW4lGFBA/hNXn44tp/wqyyuzS23wCHudYY=;
        b=aRJLTCG3rtZC7e4/KdPMWUvHSH61p60Av2CMonIO7G10lLnkvBRv7KnQFa9dylarzA
         r12S8T1JrdVyjE1PuSWKcpOVIVvX9lIitz70+ocmA5eTIJ0pNiOmyEvoLbogPS5kqCej
         cIg9B/UurY9BW2NkWbe0yCwJRR/bTKNQ0Fjhno2CDZ3Yxkb7sVKbXOQ++OuwVB7oLm4r
         fEE02yuDu+wc12EBiLE8h4nd9cqEfiHIO80uAr5i2Rc4y1ZkbeO+zWOXoCBtE048ldJN
         qaaatzmUYRC/bzWXikRw2O4TIOgv8p3BNmMf12AmEzK2A4AQDwu1n14zQ+NoHFObM/cQ
         KeIA==
X-Gm-Message-State: AOAM532U4rPhByM7XfbxmTfNw0Y2Oo/t5oO1Vs0QTgXdfQw3Id8crx0d
        JVDkwSugzNk6VgtiR75J/j4kGQ==
X-Google-Smtp-Source: ABdhPJy3LUQ3JCTsBXn9AQU01MEKNSmN2mgdKIpOoBvf8aESLBqoXITrHWbOLTTTIgwaaLejKrcr9g==
X-Received: by 2002:a17:90a:a81:: with SMTP id 1mr267820pjw.174.1601910063866;
        Mon, 05 Oct 2020 08:01:03 -0700 (PDT)
Received: from localhost.localdomain (111-243-25-83.dynamic-ip.hinet.net. [111.243.25.83])
        by smtp.gmail.com with ESMTPSA id c131sm227485pfc.46.2020.10.05.08.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 08:01:02 -0700 (PDT)
From:   Chris Chiu <chiu@endlessos.org>
X-Google-Original-From: Chris Chiu <chiu@endlessm.com>
To:     pkshih@realtek.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 1/3] rtlwifi: rtl8192se: remove duplicated legacy_httxpowerdiff
Date:   Mon,  5 Oct 2020 23:00:48 +0800
Message-Id: <20201005150048.4596-1-chiu@endlessm.com>
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

