Return-Path: <linux-wireless+bounces-24550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E874AE9FE9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3AD4A4AD8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D52E88B0;
	Thu, 26 Jun 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YcIBgnUL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990632E7F10;
	Thu, 26 Jun 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946906; cv=none; b=pjkoxEmF1you8RmXoxhy9Js2LD5WHXp1rp1XT/8JnjQ6R+y6ojrKkgtK9kCjwRcHGssIEaIhkuqU9IkEnJIlSgWmYSatYjFLntekgkHu5ZfJixKWQcQDX4qQhZGVvIhIL8SLMmbsVcFhUnGJj/xp/Kvb5tF7MbChPsWLlqezIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946906; c=relaxed/simple;
	bh=Ye9E6qmXRgS8ZYKjBGLs+ZMjHxUXnaSg6rPROXafcA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffzzY6KPLWBuoQgYk2MUu+4hRZbuzvdp7gzSUvM+fhP9iMgeFowacXdRRs9/eaVo+DpNbGbfazcHBZYluh7wYIylcguhofG+Cj1ksiKcydHoDJYF2qRc6LJSQ5FF42SV//+TOH/qVXtHKiyVns/hrq/jawEuxvXP8mclQ6fdub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YcIBgnUL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=5igwPeYjKzUcdm/Fbs42E4EG4NJWXIdzB2hW+G9AefY=; b=YcIBgnULd/GMn73b
	nOtyi36NQlHxQaUpVCaDjz7hu/x5tKWYPrnv02BGtsUuw7h+3OGkdrdx4xzlqr4ZwVTpELDhfT3sQ
	6SIOBdlPzfxq37yIYCqvLo3yt5V+ErwQAXAfXZ87IwwNPz1Cz4Dp0+13ceft3H0B4zA/NbqVWpdUh
	tyLHX0tT9jmzup5cHO2rY0OyuqKjGJYTwcbF5sjYoyXYPrMeMfgzeejr90V3AN0CgQs/uzPa5Jzf3
	D04mjev9uNYm2u5XVIRfHcepkqgKtyJRVTsTG/Kx0StM2m4lOTj3CK5GLbIUPKQLylNHZMLE/UePn
	tk78Ef9LSMIKRSBwJg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uUnGw-00CF9J-1C;
	Thu, 26 Jun 2025 14:08:14 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] wifi: brcm80211: Remove unused functions
Date: Thu, 26 Jun 2025 15:08:10 +0100
Message-ID: <20250626140812.56700-2-linux@treblig.org>
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
Then remove two more functions in phy_n.c that were only used
by the ones just removed.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 128 ------------------
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |  11 --
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h |   8 --
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  19 ---
 4 files changed, 166 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index c3d7aa570b4e..2dca926acac6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -2555,27 +2555,6 @@ int wlc_phy_rssi_compute(struct brcms_phy_pub *pih,
 	return rssi;
 }
 
-void wlc_phy_freqtrack_start(struct brcms_phy_pub *pih)
-{
-	return;
-}
-
-void wlc_phy_freqtrack_end(struct brcms_phy_pub *pih)
-{
-	return;
-}
-
-void wlc_phy_set_deaf(struct brcms_phy_pub *ppi, bool user_flag)
-{
-	struct brcms_phy *pi;
-	pi = (struct brcms_phy *) ppi;
-
-	if (ISLCNPHY(pi))
-		wlc_lcnphy_deaf_mode(pi, true);
-	else if (ISNPHY(pi))
-		wlc_nphy_deaf_mode(pi, true);
-}
-
 void wlc_phy_watchdog(struct brcms_phy_pub *pih)
 {
 	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
@@ -2636,28 +2615,6 @@ void wlc_phy_watchdog(struct brcms_phy_pub *pih)
 	}
 }
 
-void wlc_phy_BSSinit(struct brcms_phy_pub *pih, bool bonlyap, int rssi)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-	uint i;
-	uint k;
-
-	for (i = 0; i < MA_WINDOW_SZ; i++)
-		pi->sh->phy_noise_window[i] = (s8) (rssi & 0xff);
-	if (ISLCNPHY(pi)) {
-		for (i = 0; i < MA_WINDOW_SZ; i++)
-			pi->sh->phy_noise_window[i] =
-				PHY_NOISE_FIXED_VAL_LCNPHY;
-	}
-	pi->sh->phy_noise_index = 0;
-
-	for (i = 0; i < PHY_NOISE_WINDOW_SZ; i++) {
-		for (k = WL_ANT_IDX_1; k < WL_ANT_RX_MAX; k++)
-			pi->nphy_noise_win[k][i] = PHY_NOISE_FIXED_VAL_NPHY;
-	}
-	pi->nphy_noise_index = 0;
-}
-
 void
 wlc_phy_papd_decode_epsilon(u32 epsilon, s32 *eps_real, s32 *eps_imag)
 {
@@ -2812,14 +2769,6 @@ void wlc_phy_stf_chain_set(struct brcms_phy_pub *pih, u8 txchain, u8 rxchain)
 	pi->pubpi.phy_corenum = (u8)hweight8(pi->sh->phyrxchain);
 }
 
-void wlc_phy_stf_chain_get(struct brcms_phy_pub *pih, u8 *txchain, u8 *rxchain)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-
-	*txchain = pi->sh->phytxchain;
-	*rxchain = pi->sh->phyrxchain;
-}
-
 u8 wlc_phy_stf_chain_active_get(struct brcms_phy_pub *pih)
 {
 	s16 nphy_currtemp;
@@ -2852,89 +2801,12 @@ u8 wlc_phy_stf_chain_active_get(struct brcms_phy_pub *pih)
 	return active_bitmap;
 }
 
-s8 wlc_phy_stf_ssmode_get(struct brcms_phy_pub *pih, u16 chanspec)
-{
-	struct brcms_phy *pi = container_of(pih, struct brcms_phy, pubpi_ro);
-	u8 siso_mcs_id, cdd_mcs_id;
-
-	siso_mcs_id =
-		(CHSPEC_IS40(chanspec)) ? TXP_FIRST_MCS_40_SISO :
-		TXP_FIRST_MCS_20_SISO;
-	cdd_mcs_id =
-		(CHSPEC_IS40(chanspec)) ? TXP_FIRST_MCS_40_CDD :
-		TXP_FIRST_MCS_20_CDD;
-
-	if (pi->tx_power_target[siso_mcs_id] >
-	    (pi->tx_power_target[cdd_mcs_id] + 12))
-		return PHY_TXC1_MODE_SISO;
-	else
-		return PHY_TXC1_MODE_CDD;
-}
-
 const u8 *wlc_phy_get_ofdm_rate_lookup(void)
 {
 	return ofdm_rate_lookup;
 }
 
-void wlc_lcnphy_epa_switch(struct brcms_phy *pi, bool mode)
-{
-	if ((pi->sh->chip == BCMA_CHIP_ID_BCM4313) &&
-	    (pi->sh->boardflags & BFL_FEM)) {
-		if (mode) {
-			u16 txant = 0;
-			txant = wlapi_bmac_get_txant(pi->sh->physhim);
-			if (txant == 1) {
-				mod_phy_reg(pi, 0x44d, (0x1 << 2), (1) << 2);
-
-				mod_phy_reg(pi, 0x44c, (0x1 << 2), (1) << 2);
-
-			}
-
-			bcma_chipco_gpio_control(&pi->d11core->bus->drv_cc,
-						 0x0, 0x0);
-			bcma_chipco_gpio_out(&pi->d11core->bus->drv_cc,
-					     ~0x40, 0x40);
-			bcma_chipco_gpio_outen(&pi->d11core->bus->drv_cc,
-					       ~0x40, 0x40);
-		} else {
-			mod_phy_reg(pi, 0x44c, (0x1 << 2), (0) << 2);
-
-			mod_phy_reg(pi, 0x44d, (0x1 << 2), (0) << 2);
-
-			bcma_chipco_gpio_out(&pi->d11core->bus->drv_cc,
-					     ~0x40, 0x00);
-			bcma_chipco_gpio_outen(&pi->d11core->bus->drv_cc,
-					       ~0x40, 0x00);
-			bcma_chipco_gpio_control(&pi->d11core->bus->drv_cc,
-						 0x0, 0x40);
-		}
-	}
-}
-
 void wlc_phy_ldpc_override_set(struct brcms_phy_pub *ppi, bool ldpc)
 {
 	return;
 }
-
-void
-wlc_phy_get_pwrdet_offsets(struct brcms_phy *pi, s8 *cckoffset, s8 *ofdmoffset)
-{
-	*cckoffset = 0;
-	*ofdmoffset = 0;
-}
-
-s8 wlc_phy_upd_rssi_offset(struct brcms_phy *pi, s8 rssi, u16 chanspec)
-{
-
-	return rssi;
-}
-
-bool wlc_phy_txpower_ipa_ison(struct brcms_phy_pub *ppi)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	if (ISNPHY(pi))
-		return wlc_phy_n_txpower_ipa_ison(pi);
-	else
-		return false;
-}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
index 1efc92fd1671..8388eea8b17f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
@@ -194,14 +194,9 @@ void wlc_phy_por_inform(struct brcms_phy_pub *ppi);
 void wlc_phy_noise_sample_intr(struct brcms_phy_pub *ppi);
 bool wlc_phy_bist_check_phy(struct brcms_phy_pub *ppi);
 
-void wlc_phy_set_deaf(struct brcms_phy_pub *ppi, bool user_flag);
-
 void wlc_phy_switch_radio(struct brcms_phy_pub *ppi, bool on);
 void wlc_phy_anacore(struct brcms_phy_pub *ppi, bool on);
 
-
-void wlc_phy_BSSinit(struct brcms_phy_pub *ppi, bool bonlyap, int rssi);
-
 void wlc_phy_chanspec_ch14_widefilter_set(struct brcms_phy_pub *ppi,
 					  bool wide_filter);
 void wlc_phy_chanspec_band_validch(struct brcms_phy_pub *ppi, uint band,
@@ -224,13 +219,10 @@ bool wlc_phy_txpower_hw_ctrl_get(struct brcms_phy_pub *ppi);
 void wlc_phy_txpower_hw_ctrl_set(struct brcms_phy_pub *ppi, bool hwpwrctrl);
 u8 wlc_phy_txpower_get_target_min(struct brcms_phy_pub *ppi);
 u8 wlc_phy_txpower_get_target_max(struct brcms_phy_pub *ppi);
-bool wlc_phy_txpower_ipa_ison(struct brcms_phy_pub *pih);
 
 void wlc_phy_stf_chain_init(struct brcms_phy_pub *pih, u8 txchain, u8 rxchain);
 void wlc_phy_stf_chain_set(struct brcms_phy_pub *pih, u8 txchain, u8 rxchain);
-void wlc_phy_stf_chain_get(struct brcms_phy_pub *pih, u8 *txchain, u8 *rxchain);
 u8 wlc_phy_stf_chain_active_get(struct brcms_phy_pub *pih);
-s8 wlc_phy_stf_ssmode_get(struct brcms_phy_pub *pih, u16 chanspec);
 void wlc_phy_ldpc_override_set(struct brcms_phy_pub *ppi, bool val);
 
 void wlc_phy_cal_perical(struct brcms_phy_pub *ppi, u8 reason);
@@ -257,9 +249,6 @@ void wlc_phy_machwcap_set(struct brcms_phy_pub *ppi, u32 machwcap);
 
 void wlc_phy_runbist_config(struct brcms_phy_pub *ppi, bool start_end);
 
-void wlc_phy_freqtrack_start(struct brcms_phy_pub *ppi);
-void wlc_phy_freqtrack_end(struct brcms_phy_pub *ppi);
-
 const u8 *wlc_phy_get_ofdm_rate_lookup(void);
 
 s8 wlc_phy_get_tx_power_offset_by_mcs(struct brcms_phy_pub *ppi,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
index 70a9ec050717..18028f673574 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h
@@ -985,7 +985,6 @@ s8 wlc_lcnphy_tempsense_degree(struct brcms_phy *pi, bool mode);
 s8 wlc_lcnphy_vbatsense(struct brcms_phy *pi, bool mode);
 void wlc_phy_carrier_suppress_lcnphy(struct brcms_phy *pi);
 void wlc_lcnphy_crsuprs(struct brcms_phy *pi, int channel);
-void wlc_lcnphy_epa_switch(struct brcms_phy *pi, bool mode);
 void wlc_2064_vco_cal(struct brcms_phy *pi);
 
 void wlc_phy_txpower_recalc_target(struct brcms_phy *pi);
@@ -1031,7 +1030,6 @@ struct phy_iq_est {
 };
 
 void wlc_phy_stay_in_carriersearch_nphy(struct brcms_phy *pi, bool enable);
-void wlc_nphy_deaf_mode(struct brcms_phy *pi, bool mode);
 
 #define wlc_phy_write_table_nphy(pi, pti) \
 	wlc_phy_write_table(pi, pti, 0x72, 0x74, 0x73)
@@ -1115,10 +1113,4 @@ int wlc_phy_rssi_compute_nphy(struct brcms_phy *pi, struct d11rxhdr *rxh);
 #define NPHY_TESTPATTERN_BPHY_RFCS  1
 
 void wlc_phy_nphy_tkip_rifs_war(struct brcms_phy *pi, u8 rifs);
-
-void wlc_phy_get_pwrdet_offsets(struct brcms_phy *pi, s8 *cckoffset,
-				s8 *ofdmoffset);
-s8 wlc_phy_upd_rssi_offset(struct brcms_phy *pi, s8 rssi, u16 chanspec);
-
-bool wlc_phy_n_txpower_ipa_ison(struct brcms_phy *pih);
 #endif				/* _BRCM_PHY_INT_H_ */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index d362c4337616..09e2e8bdd804 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -19713,11 +19713,6 @@ u8 wlc_phy_rxcore_getstate_nphy(struct brcms_phy_pub *pih)
 	return (u8) rxen_bits;
 }
 
-bool wlc_phy_n_txpower_ipa_ison(struct brcms_phy *pi)
-{
-	return PHY_IPA(pi);
-}
-
 void wlc_phy_cal_init_nphy(struct brcms_phy *pi)
 {
 }
@@ -28577,17 +28572,3 @@ void wlc_phy_stay_in_carriersearch_nphy(struct brcms_phy *pi, bool enable)
 		}
 	}
 }
-
-void wlc_nphy_deaf_mode(struct brcms_phy *pi, bool mode)
-{
-	wlapi_suspend_mac_and_wait(pi->sh->physhim);
-
-	if (mode) {
-		if (pi->nphy_deaf_count == 0)
-			wlc_phy_stay_in_carriersearch_nphy(pi, true);
-	} else if (pi->nphy_deaf_count > 0) {
-		wlc_phy_stay_in_carriersearch_nphy(pi, false);
-	}
-
-	wlapi_enable_mac(pi->sh->physhim);
-}
-- 
2.50.0


