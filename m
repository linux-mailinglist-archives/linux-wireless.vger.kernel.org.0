Return-Path: <linux-wireless+bounces-24551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE2AEA006
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97F11890CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C72E7F1A;
	Thu, 26 Jun 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GyRrB2od"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2132E7648;
	Thu, 26 Jun 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946915; cv=none; b=ods3BNx0nGz7SXdZzViHvv6Deco5ljWeeRQhUPh05oYFQKa1fVlcs3vM7GQvllyuzZx4FBCkE8bC+/nY8licIEhtB0LoZ3yq44QFOvGUEZz9/KcEoX4f6Rkamy0gu7TzFGkBkC8XXbR8NhQ3tq5iKHt5qDf4chcdKFURCbZhuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946915; c=relaxed/simple;
	bh=xHiUY3U+QrvZin10lHcqu0WEDSU9sl2FDa4xXKuoFuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn1/WElH+ftjJAWogvdXEDPzOtXNhAugj4NQaFRwOEboQf3x+dLUeLeJRuTHbPx0/cdBr4B2Q/qkjQwJzvqw2g+LC9CALuLlTZWA+E2dPA2uCYEZXym/JR77YfENKpxATdj/IXnoZFqKW+tPdUHhzJeEFG+NAQ69dg+cU6NXN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GyRrB2od; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=AoUxy535CJj8gsdeOz6+ET3ZYnXhRMS/YTtAgqZs77k=; b=GyRrB2odp7vw/mZU
	u9Q4xz4mi9YC1PffiPxdNg1QGirpN/3KfnizMezmbvMYhYAQusKwyfKAWyErEkSv7qeI8/aKRTOr6
	ryc8U+rnTigJby3C+/9z7h/sX0t0G+YbB/kwe7k088Xpcf6H1BcTFdmNhWjfEf8dMXvglHuj5g2sM
	tRWN41+N2r6pUY8lh7cPEx/XVWEB3hgqTRwagb3Qv+HPmgtqDtZPgjsb7zqs5h52TU7pqngZ5/Hgo
	A+GWiH2jVadJwM6bP9zYtdhVCO+XJeeATVqcrfSzgOn+6M9sgdUVPiPeAA1OpqQ0UGof0CE17r6Cx
	H0czg6Ao0FTPpTsS/g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uUnGx-00CF9J-12;
	Thu, 26 Jun 2025 14:08:15 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] wifi: brcm80211: Remove yet more unused functions
Date: Thu, 26 Jun 2025 15:08:12 +0100
Message-ID: <20250626140812.56700-4-linux@treblig.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626140812.56700-1-linux@treblig.org>
References: <20250626140812.56700-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This is a subset of unused functions in bcrmsmac phy_cmn.c,
They're unused since the original 2010
commit a9533e7ea3c4 ("Staging: Add initial release of brcm80211 - Broadcom
802.11n wireless LAN driver.")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 129 ------------------
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |   4 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h |   3 -
 3 files changed, 136 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index 0dbf239400c3..ce6ce2dea39c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -127,23 +127,6 @@ void wlc_phyreg_exit(struct brcms_phy_pub *pih)
 	wlapi_bmac_ucode_wake_override_phyreg_clear(pi->sh->physhim);
 }
 
-void wlc_radioreg_enter(struct brcms_phy_pub *pih)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-	wlapi_bmac_mctrl(pi->sh->physhim, MCTL_LOCK_RADIO, MCTL_LOCK_RADIO);
-
-	udelay(10);
-}
-
-void wlc_radioreg_exit(struct brcms_phy_pub *pih)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-
-	(void)bcma_read16(pi->d11core, D11REGOFFS(phyversion));
-	pi->phy_wreg = 0;
-	wlapi_bmac_mctrl(pi->sh->physhim, MCTL_LOCK_RADIO, 0);
-}
-
 u16 read_radio_reg(struct brcms_phy *pi, u16 addr)
 {
 	u16 data;
@@ -263,11 +246,6 @@ void mod_radio_reg(struct brcms_phy *pi, u16 addr, u16 mask, u16 val)
 	write_radio_reg(pi, addr, (rval & ~mask) | (val & mask));
 }
 
-void write_phy_channel_reg(struct brcms_phy *pi, uint val)
-{
-	bcma_write16(pi->d11core, D11REGOFFS(phychannel), val);
-}
-
 u16 read_phy_reg(struct brcms_phy *pi, u16 addr)
 {
 	bcma_wflush16(pi->d11core, D11REGOFFS(phyregaddr), addr);
@@ -692,18 +670,6 @@ void wlc_phy_por_inform(struct brcms_phy_pub *ppi)
 	pi->phy_init_por = true;
 }
 
-void wlc_phy_edcrs_lock(struct brcms_phy_pub *pih, bool lock)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-
-	pi->edcrs_threshold_lock = lock;
-
-	write_phy_reg(pi, 0x22c, 0x46b);
-	write_phy_reg(pi, 0x22d, 0x46b);
-	write_phy_reg(pi, 0x22e, 0x3c0);
-	write_phy_reg(pi, 0x22f, 0x3c0);
-}
-
 void wlc_phy_initcal_enable(struct brcms_phy_pub *pih, bool initcal)
 {
 	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
@@ -1083,20 +1049,6 @@ void wlc_phy_mute_upd(struct brcms_phy_pub *pih, bool mute, u32 flags)
 	return;
 }
 
-void wlc_phy_clear_tssi(struct brcms_phy_pub *pih)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-
-	if (ISNPHY(pi)) {
-		return;
-	} else {
-		wlapi_bmac_write_shm(pi->sh->physhim, M_B_TSSI_0, NULL_TSSI_W);
-		wlapi_bmac_write_shm(pi->sh->physhim, M_B_TSSI_1, NULL_TSSI_W);
-		wlapi_bmac_write_shm(pi->sh->physhim, M_G_TSSI_0, NULL_TSSI_W);
-		wlapi_bmac_write_shm(pi->sh->physhim, M_G_TSSI_1, NULL_TSSI_W);
-	}
-}
-
 static bool wlc_phy_cal_txpower_recalc_sw(struct brcms_phy *pi)
 {
 	return false;
@@ -1136,13 +1088,6 @@ void wlc_phy_switch_radio(struct brcms_phy_pub *pih, bool on)
 	}
 }
 
-u16 wlc_phy_bw_state_get(struct brcms_phy_pub *ppi)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	return pi->bw;
-}
-
 void wlc_phy_bw_state_set(struct brcms_phy_pub *ppi, u16 bw)
 {
 	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
@@ -1182,36 +1127,6 @@ void wlc_phy_chanspec_set(struct brcms_phy_pub *ppi, u16 chanspec)
 
 }
 
-int wlc_phy_chanspec_freq2bandrange_lpssn(uint freq)
-{
-	int range = -1;
-
-	if (freq < 2500)
-		range = WL_CHAN_FREQ_RANGE_2G;
-	else if (freq <= 5320)
-		range = WL_CHAN_FREQ_RANGE_5GL;
-	else if (freq <= 5700)
-		range = WL_CHAN_FREQ_RANGE_5GM;
-	else
-		range = WL_CHAN_FREQ_RANGE_5GH;
-
-	return range;
-}
-
-int wlc_phy_chanspec_bandrange_get(struct brcms_phy *pi, u16 chanspec)
-{
-	int range = -1;
-	uint channel = CHSPEC_CHANNEL(chanspec);
-	uint freq = wlc_phy_channel2freq(channel);
-
-	if (ISNPHY(pi))
-		range = wlc_phy_get_chan_freq_range_nphy(pi, channel);
-	else if (ISLCNPHY(pi))
-		range = wlc_phy_chanspec_freq2bandrange_lpssn(freq);
-
-	return range;
-}
-
 void wlc_phy_chanspec_ch14_widefilter_set(struct brcms_phy_pub *ppi,
 					  bool wide_filter)
 {
@@ -1254,50 +1169,6 @@ wlc_phy_chanspec_band_validch(struct brcms_phy_pub *ppi, uint band,
 	}
 }
 
-u16 wlc_phy_chanspec_band_firstch(struct brcms_phy_pub *ppi, uint band)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-	uint i;
-	uint channel;
-	u16 chspec;
-
-	for (i = 0; i < ARRAY_SIZE(chan_info_all); i++) {
-		channel = chan_info_all[i].chan;
-
-		if (ISNPHY(pi) && pi->bw == WL_CHANSPEC_BW_40) {
-			uint j;
-
-			for (j = 0; j < ARRAY_SIZE(chan_info_all); j++) {
-				if (chan_info_all[j].chan ==
-				    channel + CH_10MHZ_APART)
-					break;
-			}
-
-			if (j == ARRAY_SIZE(chan_info_all))
-				continue;
-
-			channel = upper_20_sb(channel);
-			chspec =  channel | WL_CHANSPEC_BW_40 |
-				  WL_CHANSPEC_CTL_SB_LOWER;
-			if (band == BRCM_BAND_2G)
-				chspec |= WL_CHANSPEC_BAND_2G;
-			else
-				chspec |= WL_CHANSPEC_BAND_5G;
-		} else
-			chspec = ch20mhz_chspec(channel);
-
-		if ((pi->a_band_high_disable) && (channel >= FIRST_REF5_CHANNUM)
-		    && (channel <= LAST_REF5_CHANNUM))
-			continue;
-
-		if ((band == BRCM_BAND_2G && channel <= CH_MAX_2G_CHANNEL) ||
-		    (band == BRCM_BAND_5G && channel > CH_MAX_2G_CHANNEL))
-			return chspec;
-	}
-
-	return (u16) INVCHANSPEC;
-}
-
 int wlc_phy_txpower_get(struct brcms_phy_pub *ppi, uint *qdbm, bool *override)
 {
 	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
index 1dbec80194a7..cab08f0669d1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
@@ -186,7 +186,6 @@ void wlc_phy_antsel_init(struct brcms_phy_pub *ppi, bool lut_init);
 void wlc_phy_chanspec_set(struct brcms_phy_pub *ppi, u16 chanspec);
 u16 wlc_phy_chanspec_get(struct brcms_phy_pub *ppi);
 void wlc_phy_chanspec_radio_set(struct brcms_phy_pub *ppi, u16 newch);
-u16 wlc_phy_bw_state_get(struct brcms_phy_pub *ppi);
 void wlc_phy_bw_state_set(struct brcms_phy_pub *ppi, u16 bw);
 
 int wlc_phy_rssi_compute(struct brcms_phy_pub *pih, struct d11rxhdr *rxh);
@@ -201,7 +200,6 @@ void wlc_phy_chanspec_ch14_widefilter_set(struct brcms_phy_pub *ppi,
 					  bool wide_filter);
 void wlc_phy_chanspec_band_validch(struct brcms_phy_pub *ppi, uint band,
 				   struct brcms_chanvec *channels);
-u16 wlc_phy_chanspec_band_firstch(struct brcms_phy_pub *ppi, uint band);
 
 void wlc_phy_txpower_sromlimit(struct brcms_phy_pub *ppi, uint chan, u8 *_min_,
 			       u8 *_max_, int rate);
@@ -219,11 +217,9 @@ u8 wlc_phy_stf_chain_active_get(struct brcms_phy_pub *pih);
 void wlc_phy_ldpc_override_set(struct brcms_phy_pub *ppi, bool val);
 
 void wlc_phy_cal_perical(struct brcms_phy_pub *ppi, u8 reason);
-void wlc_phy_edcrs_lock(struct brcms_phy_pub *pih, bool lock);
 void wlc_phy_cal_papd_recal(struct brcms_phy_pub *ppi);
 
 void wlc_phy_ant_rxdiv_set(struct brcms_phy_pub *ppi, u8 val);
-void wlc_phy_clear_tssi(struct brcms_phy_pub *ppi);
 void wlc_phy_hold_upd(struct brcms_phy_pub *ppi, u32 id, bool val);
 void wlc_phy_mute_upd(struct brcms_phy_pub *ppi, bool val, u32 flags);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
index 18028f673574..4e80f4d27949 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
@@ -908,8 +908,6 @@ void write_radio_reg(struct brcms_phy *pi, u16 addr, u16 val);
 
 void wlc_phyreg_enter(struct brcms_phy_pub *pih);
 void wlc_phyreg_exit(struct brcms_phy_pub *pih);
-void wlc_radioreg_enter(struct brcms_phy_pub *pih);
-void wlc_radioreg_exit(struct brcms_phy_pub *pih);
 
 void wlc_phy_read_table(struct brcms_phy *pi,
 			const struct phytbl_info *ptbl_info,
@@ -921,7 +919,6 @@ void wlc_phy_table_addr(struct brcms_phy *pi, uint tbl_id, uint tbl_offset,
 			u16 tblAddr, u16 tblDataHi, u16 tblDataLo);
 void wlc_phy_table_data_write(struct brcms_phy *pi, uint width, u32 val);
 
-void write_phy_channel_reg(struct brcms_phy *pi, uint val);
 void wlc_phy_txpower_update_shm(struct brcms_phy *pi);
 
 u8 wlc_phy_nbits(s32 value);
-- 
2.50.0


