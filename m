Return-Path: <linux-wireless+bounces-22527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6795AAA6A3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0691916417F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D132ABA4;
	Mon,  5 May 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXKK/NL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C832AB90;
	Mon,  5 May 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484502; cv=none; b=HQNCckeGEwC55xWdiZH5c+VqDgyfOqnONgcuYeq/WSe+S2IJD2GURwc7PgmqwTlqL5TNJmhbfJ99wG7iByXrrZYWIW/9a9jGPF/EuYS7DswTsMVvw5/8ibb4J3kadHP1chuNFZUt6P6TCTiAG5vyYpuCPVe+Qgw8OetHt2Rv6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484502; c=relaxed/simple;
	bh=1pPZD/AZBY2vAbtfHSxBwZNxaxFCsPhS4ZMv5mU0+M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCvKY/1Wy2q8TB3XD+2tyC35IfpS6OFQNAtx0o/dcKX/+XNE9deyXSKFHFoePxXhjcAo6+j6cBXVqd3EqkqAl/TlPLONbMAK9zrdGUy5pRKoXO1j3YYc3Qce0xSA7U+Uwr26fQUrRv54X9LwwHBhk2NVRXlDFNtw9nfXzTEqWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXKK/NL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6906C4CEEF;
	Mon,  5 May 2025 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484501;
	bh=1pPZD/AZBY2vAbtfHSxBwZNxaxFCsPhS4ZMv5mU0+M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXKK/NL1byTUYCEInYh8pxPH9Upi112QuSOC8ksn2JpmOLLHU0IEFPC7LRz40WuR9
	 +DOaKuXMbyk1qhx8J9PnRLuWUqj2Wy3RFjkKh20uNwGnzWkkuTgnNg0GfHuNL3LAy3
	 wLsctt7tsn+CPZagyFHEvHQLJ7Cy942iBrbH93k+5GK/+JGCZ8KyBevr2vgSpK9vIB
	 ysM9DhoYEt2e8mDRzatqxa7gaWik6JPaPUpHYJ31SHCQavuxtygcF3qZ8geYOybfW8
	 kP8pcRHRrGStBCrl6da+Ij0wSkHEQaKlRiqnU8xwZYOINfV68OFr/H74A9+ttVJ5bf
	 cxYQoSCoh35dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 505/642] wifi: mac80211: add HT and VHT basic set verification
Date: Mon,  5 May 2025 18:12:01 -0400
Message-Id: <20250505221419.2672473-505-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 574faa0e936d12718e2cadad11ce1e184d9e5a32 ]

So far we did not verify the HT and VHT basic MCS set. However, in
P802.11REVme/D7.0 (6.5.4.2.4) says that the MLME-JOIN.request shall
return an error if the VHT and HT basic set requirements are not met.

Given broken APs, apply VHT basic MCS/NSS set checks only in
strict mode.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.e2d8d4095f6b.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9904018383fc9..9eccf86e9254e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -345,6 +345,115 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	return IEEE80211_CONN_MODE_EHT;
 }
 
+static bool
+ieee80211_verify_sta_ht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_ht_operation *ht_op)
+{
+	struct ieee80211_sta_ht_cap sta_ht_cap;
+	int i;
+
+	if (sband->band == NL80211_BAND_6GHZ)
+		return true;
+
+	if (!ht_op)
+		return false;
+
+	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+
+	/*
+	 * P802.11REVme/D7.0 - 6.5.4.2.4
+	 * ...
+	 * If the MLME of an HT STA receives an MLME-JOIN.request primitive
+	 * with the SelectedBSS parameter containing a Basic HT-MCS Set field
+	 * in the HT Operation parameter that contains any unsupported MCSs,
+	 * the MLME response in the resulting MLME-JOIN.confirm primitive shall
+	 * contain a ResultCode parameter that is not set to the value SUCCESS.
+	 * ...
+	 */
+
+	/* Simply check that all basic rates are in the STA RX mask */
+	for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++) {
+		if ((ht_op->basic_set[i] & sta_ht_cap.mcs.rx_mask[i]) !=
+		    ht_op->basic_set[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool
+ieee80211_verify_sta_vht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     int link_id,
+				     struct ieee80211_supported_band *sband,
+				     const struct ieee80211_vht_operation *vht_op)
+{
+	struct ieee80211_sta_vht_cap sta_vht_cap;
+	u16 ap_min_req_set, sta_rx_mcs_map, sta_tx_mcs_map;
+	int nss;
+
+	if (sband->band != NL80211_BAND_5GHZ)
+		return true;
+
+	if (!vht_op)
+		return false;
+
+	memcpy(&sta_vht_cap, &sband->vht_cap, sizeof(sta_vht_cap));
+	ieee80211_apply_vhtcap_overrides(sdata, &sta_vht_cap);
+
+	ap_min_req_set = le16_to_cpu(vht_op->basic_mcs_set);
+	sta_rx_mcs_map = le16_to_cpu(sta_vht_cap.vht_mcs.rx_mcs_map);
+	sta_tx_mcs_map = le16_to_cpu(sta_vht_cap.vht_mcs.tx_mcs_map);
+
+	/*
+	 * Many APs are incorrectly advertising an all-zero value here,
+	 * which really means MCS 0-7 are required for 1-8 streams, but
+	 * they don't really mean it that way.
+	 * Some other APs are incorrectly advertising 3 spatial streams
+	 * with MCS 0-7 are required, but don't really mean it that way
+	 * and we'll connect only with HT, rather than even HE.
+	 * As a result, unfortunately the VHT basic MCS/NSS set cannot
+	 * be used at all, so check it only in strict mode.
+	 */
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT))
+		return true;
+
+	/*
+	 * P802.11REVme/D7.0 - 6.5.4.2.4
+	 * ...
+	 * If the MLME of a VHT STA receives an MLME-JOIN.request primitive
+	 * with a SelectedBSS parameter containing a Basic VHT-MCS And NSS Set
+	 * field in the VHT Operation parameter that contains any unsupported
+	 * <VHT-MCS, NSS> tuple, the MLME response in the resulting
+	 * MLME-JOIN.confirm primitive shall contain a ResultCode parameter
+	 * that is not set to the value SUCCESS.
+	 * ...
+	 */
+	for (nss = 8; nss > 0; nss--) {
+		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+		u8 sta_rx_val;
+		u8 sta_tx_val;
+
+		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+			continue;
+
+		sta_rx_val = (sta_rx_mcs_map >> (2 * (nss - 1))) & 3;
+		sta_tx_val = (sta_tx_mcs_map >> (2 * (nss - 1))) & 3;
+
+		if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    sta_rx_val < ap_op_val || sta_tx_val < ap_op_val) {
+			link_id_info(sdata, link_id,
+				     "Missing mandatory rates for %d Nss, rx %d, tx %d oper %d, disable VHT\n",
+				     nss, sta_rx_val, sta_tx_val, ap_op_val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool
 ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 				     int link_id,
@@ -1042,6 +1151,26 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		link_id_info(sdata, link_id,
 			     "regulatory prevented using AP config, downgraded\n");
 
+	if (conn->mode >= IEEE80211_CONN_MODE_HT &&
+	    !ieee80211_verify_sta_ht_mcs_support(sdata, sband,
+						 elems->ht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_LEGACY;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling HT\n");
+	}
+
+	if (conn->mode >= IEEE80211_CONN_MODE_VHT &&
+	    !ieee80211_verify_sta_vht_mcs_support(sdata, link_id, sband,
+						  elems->vht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_HT;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_40);
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling VHT\n");
+	}
+
 	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
 	    (!ieee80211_verify_peer_he_mcs_support(sdata, link_id,
 						   (void *)elems->he_cap,
-- 
2.39.5


