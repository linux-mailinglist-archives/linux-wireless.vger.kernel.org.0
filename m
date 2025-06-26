Return-Path: <linux-wireless+bounces-24549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361F6AE9FE7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4238517CFB3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E72E7F3A;
	Thu, 26 Jun 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Es5++TV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8A249F9;
	Thu, 26 Jun 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946905; cv=none; b=N670IJtvHYFT83NIzKIUuqL1n9aIJt3xXmofBIusdto4aSBCNwfyyk3HMsfn7cY6vgSWa3xt2oKktPPIjkQ5XhZG1yVTMYelDyfaGWyrW9pSE0CchKjpxSQ5SnbGwE3E5FaC5ia+VIoA+v54X63TJq1PPHuVknOZCTf8eCEHyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946905; c=relaxed/simple;
	bh=tUBl3/+5OUqMf8A25bSfwc6qZLx3mmbFz53TrNqSXI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnW3gss0a2X+/VcfbxmL8Xbr1B3uyooB9jSEbnCfpPUGetrDmAHI9XR2EyDSxshT3CUzsK56O3dl/sXLPbXHbki9Ep8sRceYFBLKY2Dr9cujGhRVLmbgXQtaWyEiFMvAFRXZ0dJiCb55lMcyLPBYdZ9p6OQKuZpFxOx013hw5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Es5++TV1; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=l8y3xxi75s06RxRa4UiF6jCDuy+pZDEsMzs8mWVDNNo=; b=Es5++TV14JsXNUox
	/DZEn+h4jXiobQ5blTkfPfz0jgrN0s9pP2WghVhcbOB6pwLgfeuXncDzKlfCWg/RR60Fr0bY5qszi
	DTtVZkmRrcHD5OOiAclsYtmx0+F8LGyDEIY21xwxNFskIZqJkn206QjfsePr39lFJE0yu8u5cmkRp
	m1TVp9diNd5MuRs/ynhlkCWiCZZPBg1hdrEocaLLMqdDnc406YW/yqQozscR353lxap01gDX8F/u4
	NrKCdRLFuIDIrSCF9oZ02iIDbEVOpm0sBkhjB8YXueCXGFZls70vQGkovVnAanzlTSM25uJWVHL73
	GSBbBKhVoX6e1Tq3tQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uUnGw-00CF9J-2l;
	Thu, 26 Jun 2025 14:08:14 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] wifi: brcm80211: Remove more unused functions
Date: Thu, 26 Jun 2025 15:08:11 +0100
Message-ID: <20250626140812.56700-3-linux@treblig.org>
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
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 186 ------------------
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |  12 --
 2 files changed, 198 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index 2dca926acac6..0dbf239400c3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -1308,56 +1308,6 @@ int wlc_phy_txpower_get(struct brcms_phy_pub *ppi, uint *qdbm, bool *override)
 	return 0;
 }
 
-void wlc_phy_txpower_target_set(struct brcms_phy_pub *ppi,
-				struct txpwr_limits *txpwr)
-{
-	bool mac_enabled = false;
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	memcpy(&pi->tx_user_target[TXP_FIRST_CCK],
-	       &txpwr->cck[0], BRCMS_NUM_RATES_CCK);
-
-	memcpy(&pi->tx_user_target[TXP_FIRST_OFDM],
-	       &txpwr->ofdm[0], BRCMS_NUM_RATES_OFDM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_OFDM_20_CDD],
-	       &txpwr->ofdm_cdd[0], BRCMS_NUM_RATES_OFDM);
-
-	memcpy(&pi->tx_user_target[TXP_FIRST_OFDM_40_SISO],
-	       &txpwr->ofdm_40_siso[0], BRCMS_NUM_RATES_OFDM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_OFDM_40_CDD],
-	       &txpwr->ofdm_40_cdd[0], BRCMS_NUM_RATES_OFDM);
-
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_20_SISO],
-	       &txpwr->mcs_20_siso[0], BRCMS_NUM_RATES_MCS_1_STREAM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_20_CDD],
-	       &txpwr->mcs_20_cdd[0], BRCMS_NUM_RATES_MCS_1_STREAM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_20_STBC],
-	       &txpwr->mcs_20_stbc[0], BRCMS_NUM_RATES_MCS_1_STREAM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_20_SDM],
-	       &txpwr->mcs_20_mimo[0], BRCMS_NUM_RATES_MCS_2_STREAM);
-
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_40_SISO],
-	       &txpwr->mcs_40_siso[0], BRCMS_NUM_RATES_MCS_1_STREAM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_40_CDD],
-	       &txpwr->mcs_40_cdd[0], BRCMS_NUM_RATES_MCS_1_STREAM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_40_STBC],
-	       &txpwr->mcs_40_stbc[0], BRCMS_NUM_RATES_MCS_1_STREAM);
-	memcpy(&pi->tx_user_target[TXP_FIRST_MCS_40_SDM],
-	       &txpwr->mcs_40_mimo[0], BRCMS_NUM_RATES_MCS_2_STREAM);
-
-	if (bcma_read32(pi->d11core, D11REGOFFS(maccontrol)) & MCTL_EN_MAC)
-		mac_enabled = true;
-
-	if (mac_enabled)
-		wlapi_suspend_mac_and_wait(pi->sh->physhim);
-
-	wlc_phy_txpower_recalc_target(pi);
-	wlc_phy_cal_txpower_recalc_sw(pi);
-
-	if (mac_enabled)
-		wlapi_enable_mac(pi->sh->physhim);
-}
-
 int wlc_phy_txpower_set(struct brcms_phy_pub *ppi, uint qdbm, bool override)
 {
 	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
@@ -1441,59 +1391,6 @@ wlc_phy_txpower_sromlimit(struct brcms_phy_pub *ppi, uint channel, u8 *min_pwr,
 	}
 }
 
-void
-wlc_phy_txpower_sromlimit_max_get(struct brcms_phy_pub *ppi, uint chan,
-				  u8 *max_txpwr, u8 *min_txpwr)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-	u8 tx_pwr_max = 0;
-	u8 tx_pwr_min = 255;
-	u8 max_num_rate;
-	u8 maxtxpwr, mintxpwr, rate, pactrl;
-
-	pactrl = 0;
-
-	max_num_rate = ISNPHY(pi) ? TXP_NUM_RATES :
-		       ISLCNPHY(pi) ? (TXP_LAST_SISO_MCS_20 +
-				       1) : (TXP_LAST_OFDM + 1);
-
-	for (rate = 0; rate < max_num_rate; rate++) {
-
-		wlc_phy_txpower_sromlimit(ppi, chan, &mintxpwr, &maxtxpwr,
-					  rate);
-
-		maxtxpwr = (maxtxpwr > pactrl) ? (maxtxpwr - pactrl) : 0;
-
-		maxtxpwr = (maxtxpwr > 6) ? (maxtxpwr - 6) : 0;
-
-		tx_pwr_max = max(tx_pwr_max, maxtxpwr);
-		tx_pwr_min = min(tx_pwr_min, maxtxpwr);
-	}
-	*max_txpwr = tx_pwr_max;
-	*min_txpwr = tx_pwr_min;
-}
-
-void
-wlc_phy_txpower_boardlimit_band(struct brcms_phy_pub *ppi, uint bandunit,
-				s32 *max_pwr, s32 *min_pwr, u32 *step_pwr)
-{
-	return;
-}
-
-u8 wlc_phy_txpower_get_target_min(struct brcms_phy_pub *ppi)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	return pi->tx_power_min;
-}
-
-u8 wlc_phy_txpower_get_target_max(struct brcms_phy_pub *ppi)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	return pi->tx_power_max;
-}
-
 static s8 wlc_phy_env_measure_vbat(struct brcms_phy *pi)
 {
 	if (ISLCNPHY(pi))
@@ -1797,13 +1694,6 @@ wlc_phy_txpower_reg_limit_calc(struct brcms_phy *pi, struct txpwr_limits *txpwr,
 	}
 }
 
-void wlc_phy_txpwr_percent_set(struct brcms_phy_pub *ppi, u8 txpwr_percent)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	pi->txpwr_percent = txpwr_percent;
-}
-
 void wlc_phy_machwcap_set(struct brcms_phy_pub *ppi, u32 machwcap)
 {
 	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
@@ -1811,35 +1701,6 @@ void wlc_phy_machwcap_set(struct brcms_phy_pub *ppi, u32 machwcap)
 	pi->sh->machwcap = machwcap;
 }
 
-void wlc_phy_runbist_config(struct brcms_phy_pub *ppi, bool start_end)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-	u16 rxc;
-	rxc = 0;
-
-	if (start_end == ON) {
-		if (!ISNPHY(pi))
-			return;
-
-		if (NREV_IS(pi->pubpi.phy_rev, 3)
-		    || NREV_IS(pi->pubpi.phy_rev, 4)) {
-			bcma_wflush16(pi->d11core, D11REGOFFS(phyregaddr),
-				      0xa0);
-			bcma_set16(pi->d11core, D11REGOFFS(phyregdata),
-				   0x1 << 15);
-		}
-	} else {
-		if (NREV_IS(pi->pubpi.phy_rev, 3)
-		    || NREV_IS(pi->pubpi.phy_rev, 4)) {
-			bcma_wflush16(pi->d11core, D11REGOFFS(phyregaddr),
-				      0xa0);
-			bcma_write16(pi->d11core, D11REGOFFS(phyregdata), rxc);
-		}
-
-		wlc_phy_por_inform(ppi);
-	}
-}
-
 void
 wlc_phy_txpower_limit_set(struct brcms_phy_pub *ppi, struct txpwr_limits *txpwr,
 			  u16 chanspec)
@@ -1940,37 +1801,6 @@ bool wlc_phy_txpower_hw_ctrl_get(struct brcms_phy_pub *ppi)
 		return pi->hwpwrctrl;
 }
 
-void wlc_phy_txpower_hw_ctrl_set(struct brcms_phy_pub *ppi, bool hwpwrctrl)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-	bool suspend;
-
-	if (!pi->hwpwrctrl_capable)
-		return;
-
-	pi->hwpwrctrl = hwpwrctrl;
-	pi->nphy_txpwrctrl = hwpwrctrl;
-	pi->txpwrctrl = hwpwrctrl;
-
-	if (ISNPHY(pi)) {
-		suspend = (0 == (bcma_read32(pi->d11core,
-					     D11REGOFFS(maccontrol)) &
-				 MCTL_EN_MAC));
-		if (!suspend)
-			wlapi_suspend_mac_and_wait(pi->sh->physhim);
-
-		wlc_phy_txpwrctrl_enable_nphy(pi, pi->nphy_txpwrctrl);
-		if (pi->nphy_txpwrctrl == PHY_TPC_HW_OFF)
-			wlc_phy_txpwr_fixpower_nphy(pi);
-		else
-			mod_phy_reg(pi, 0x1e7, (0x7f << 0),
-				    pi->saved_txpwr_idx);
-
-		if (!suspend)
-			wlapi_enable_mac(pi->sh->physhim);
-	}
-}
-
 void wlc_phy_txpower_ipa_upd(struct brcms_phy *pi)
 {
 
@@ -2128,13 +1958,6 @@ void wlc_phy_antsel_type_set(struct brcms_phy_pub *ppi, u8 antsel_type)
 	pi->antsel_type = antsel_type;
 }
 
-bool wlc_phy_test_ison(struct brcms_phy_pub *ppi)
-{
-	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
-
-	return pi->phytest_on;
-}
-
 void wlc_phy_ant_rxdiv_set(struct brcms_phy_pub *ppi, u8 val)
 {
 	struct brcms_phy *pi = container_of(ppi, struct brcms_phy, pubpi_ro);
@@ -2448,15 +2271,6 @@ wlc_phy_noise_sample_request(struct brcms_phy_pub *pih, u8 reason, u8 ch)
 
 }
 
-void wlc_phy_noise_sample_request_external(struct brcms_phy_pub *pih)
-{
-	u8 channel;
-
-	channel = CHSPEC_CHANNEL(wlc_phy_chanspec_get(pih));
-
-	wlc_phy_noise_sample_request(pih, PHY_NOISE_SAMPLE_EXTERNAL, channel);
-}
-
 static const s8 lcnphy_gain_index_offset_for_pkt_rssi[] = {
 	8,
 	8,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
index 8388eea8b17f..1dbec80194a7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_hal.h
@@ -205,10 +205,6 @@ u16 wlc_phy_chanspec_band_firstch(struct brcms_phy_pub *ppi, uint band);
 
 void wlc_phy_txpower_sromlimit(struct brcms_phy_pub *ppi, uint chan, u8 *_min_,
 			       u8 *_max_, int rate);
-void wlc_phy_txpower_sromlimit_max_get(struct brcms_phy_pub *ppi, uint chan,
-				       u8 *_max_, u8 *_min_);
-void wlc_phy_txpower_boardlimit_band(struct brcms_phy_pub *ppi, uint band,
-				     s32 *, s32 *, u32 *);
 void wlc_phy_txpower_limit_set(struct brcms_phy_pub *ppi, struct txpwr_limits *,
 			       u16 chanspec);
 int wlc_phy_txpower_get(struct brcms_phy_pub *ppi, uint *qdbm, bool *override);
@@ -216,9 +212,6 @@ int wlc_phy_txpower_set(struct brcms_phy_pub *ppi, uint qdbm, bool override);
 void wlc_phy_txpower_target_set(struct brcms_phy_pub *ppi,
 				struct txpwr_limits *);
 bool wlc_phy_txpower_hw_ctrl_get(struct brcms_phy_pub *ppi);
-void wlc_phy_txpower_hw_ctrl_set(struct brcms_phy_pub *ppi, bool hwpwrctrl);
-u8 wlc_phy_txpower_get_target_min(struct brcms_phy_pub *ppi);
-u8 wlc_phy_txpower_get_target_max(struct brcms_phy_pub *ppi);
 
 void wlc_phy_stf_chain_init(struct brcms_phy_pub *pih, u8 txchain, u8 rxchain);
 void wlc_phy_stf_chain_set(struct brcms_phy_pub *pih, u8 txchain, u8 rxchain);
@@ -226,7 +219,6 @@ u8 wlc_phy_stf_chain_active_get(struct brcms_phy_pub *pih);
 void wlc_phy_ldpc_override_set(struct brcms_phy_pub *ppi, bool val);
 
 void wlc_phy_cal_perical(struct brcms_phy_pub *ppi, u8 reason);
-void wlc_phy_noise_sample_request_external(struct brcms_phy_pub *ppi);
 void wlc_phy_edcrs_lock(struct brcms_phy_pub *pih, bool lock);
 void wlc_phy_cal_papd_recal(struct brcms_phy_pub *ppi);
 
@@ -241,14 +233,10 @@ void wlc_phy_txpower_get_current(struct brcms_phy_pub *ppi,
 				 struct tx_power *power, uint channel);
 
 void wlc_phy_initcal_enable(struct brcms_phy_pub *pih, bool initcal);
-bool wlc_phy_test_ison(struct brcms_phy_pub *ppi);
-void wlc_phy_txpwr_percent_set(struct brcms_phy_pub *ppi, u8 txpwr_percent);
 void wlc_phy_ofdm_rateset_war(struct brcms_phy_pub *pih, bool war);
 void wlc_phy_bf_preempt_enable(struct brcms_phy_pub *pih, bool bf_preempt);
 void wlc_phy_machwcap_set(struct brcms_phy_pub *ppi, u32 machwcap);
 
-void wlc_phy_runbist_config(struct brcms_phy_pub *ppi, bool start_end);
-
 const u8 *wlc_phy_get_ofdm_rate_lookup(void);
 
 s8 wlc_phy_get_tx_power_offset_by_mcs(struct brcms_phy_pub *ppi,
-- 
2.50.0


