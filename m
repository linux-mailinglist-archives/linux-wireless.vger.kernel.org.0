Return-Path: <linux-wireless+bounces-16706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAB9FA8FA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE41885C1C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572B26ACB;
	Mon, 23 Dec 2024 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KCCMcgdC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BB7E9;
	Mon, 23 Dec 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917532; cv=none; b=lTsnh01LDlkTaNnzoeHJSIEVzyvfyIgHjqNCVqMAaXcPwqK+lDcj7chBHjZJZQrRKUEiXoWaCUr3Biu9bd1G/QNDjV0UOmeeu13Dsl298qow56WQiBmxNddX4NY2/ksRkv1+rM7bccEn7YekCxR8+scVUfH3c4xWo3zd1mYM2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917532; c=relaxed/simple;
	bh=o5RIeT7MkZFYXc6BGMHCVtapxftfYvUxakhqVnJWYXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaP3kAy9/fkatB2Z3QzxEDoa/TljAyllQLyW7iOBkGaXMK+VKFdWASmMbGQLnKytsuUEwHqDK7BKiUoHCfRJpQz/0EExp/rH4ymHl/oaSh0x3GdeA2OAJXe9WMEu9Daxd73mmkiB4nAoxYRJSekchSiCnBJ7cJwJQLy++8VYO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KCCMcgdC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=h+ehaO7Boqzy8Jmz/u5/15SgX8z1xPg7iANY/4tHMLY=; b=KCCMcgdCqpDHXWZO
	byVM8qcOHoLLtr5ugScVI4ki0XHTDSZQqhlFjeT71Dl7dUI1K3k0mpUovfQf9tm5aqouYyDIfPHzP
	6pn+gmu0oJHAyxEfPufJd6s13ZuGm5hJl2qLu60LAOffvdOOMVVy3LPASXikGN1eVDd+sD1MiGgh+
	RxoQ2srq6OmXm3V+jNdAQU9OhkF76/SjNAqIMLXRHQGqHSnQADdG8iu8bgCMNyzg4s4A+oqzA6QR6
	qPc2bbmBqXQrrp+V5TPw1STFSnd47omdcKMONP6lrvPTE1qPF90Zvzme+ijwz9yovYXBSvyhQ5wFp
	nfAAiuOKxIAqby8Jpg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIk-006oGv-0U;
	Mon, 23 Dec 2024 01:32:06 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/6] iwlwifi: Remove unused iwl_mvm_ftm_*_add_pasn_sta functions
Date: Mon, 23 Dec 2024 01:31:59 +0000
Message-ID: <20241223013202.340180-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223013202.340180-1-linux@treblig.org>
References: <20241223013202.340180-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

iwl_mvm_ftm_respoder_add_pasn_sta() and
iwl_mvm_ftm_resp_remove_pasn_sta() were added in 2020 by
commit be82ecd3a5c8 ("iwlwifi: mvm: add an option to add PASN station")
but have remained unused.

Remove them.

After that removal iwl_mvm_add_pasn_sta() is now unused.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../intel/iwlwifi/mvm/ftm-responder.c         | 86 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 --
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 61 -------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  4 -
 4 files changed, 157 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index e6e468e81ab3..83f6e508a094 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -324,92 +324,6 @@ static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
 	kfree(sta);
 }
 
-int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
-				      u8 *hltk, u32 hltk_len)
-{
-	int ret;
-	struct iwl_mvm_pasn_sta *sta = NULL;
-	struct iwl_mvm_pasn_hltk_data hltk_data = {
-		.addr = addr,
-		.hltk = hltk,
-	};
-	struct iwl_mvm_pasn_hltk_data *hltk_data_ptr = NULL;
-
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-					   WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_DYN_CONFIG_CMD),
-					   2);
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (cmd_ver < 3) {
-		IWL_ERR(mvm, "Adding PASN station not supported by FW\n");
-		return -EOPNOTSUPP;
-	}
-
-	if ((!hltk || !hltk_len) && (!tk || !tk_len)) {
-		IWL_ERR(mvm, "TK and HLTK not set\n");
-		return -EINVAL;
-	}
-
-	if (hltk && hltk_len) {
-		if (!fw_has_capa(&mvm->fw->ucode_capa,
-				 IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT)) {
-			IWL_ERR(mvm, "No support for secure LTF measurement\n");
-			return -EINVAL;
-		}
-
-		hltk_data.cipher = iwl_mvm_cipher_to_location_cipher(cipher);
-		if (hltk_data.cipher == IWL_LOCATION_CIPHER_INVALID) {
-			IWL_ERR(mvm, "invalid cipher: %u\n", cipher);
-			return -EINVAL;
-		}
-
-		hltk_data_ptr = &hltk_data;
-	}
-
-	if (tk && tk_len) {
-		sta = kzalloc(sizeof(*sta) + tk_len, GFP_KERNEL);
-		if (!sta)
-			return -ENOBUFS;
-
-		ret = iwl_mvm_add_pasn_sta(mvm, vif, &sta->int_sta, addr,
-					   cipher, tk, tk_len, &sta->keyconf);
-		if (ret) {
-			kfree(sta);
-			return ret;
-		}
-
-		memcpy(sta->addr, addr, ETH_ALEN);
-		list_add_tail(&sta->list, &mvm->resp_pasn_list);
-	}
-
-	ret = iwl_mvm_ftm_responder_dyn_cfg_v3(mvm, vif, NULL, hltk_data_ptr);
-	if (ret && sta)
-		iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
-
-	return ret;
-}
-
-int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif, u8 *addr)
-{
-	struct iwl_mvm_pasn_sta *sta, *prev;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	list_for_each_entry_safe(sta, prev, &mvm->resp_pasn_list, list) {
-		if (!memcmp(sta->addr, addr, ETH_ALEN)) {
-			iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
-			return 0;
-		}
-	}
-
-	IWL_ERR(mvm, "FTM: PASN station %pM not found\n", addr);
-	return -EINVAL;
-}
-
 int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				struct ieee80211_bss_conf *bss_conf)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 79771c9d4557..e8a82dc49892 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2516,12 +2516,6 @@ void iwl_mvm_ftm_restart_responder(struct iwl_mvm *mvm,
 				   struct ieee80211_bss_conf *bss_conf);
 void iwl_mvm_ftm_responder_stats(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb);
-int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif, u8 *addr);
-int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
-				      u8 *hltk, u32 hltk_len);
 void iwl_mvm_ftm_responder_clear(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cd74c181c260..1c65e285bc81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4317,67 +4317,6 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
 	return ieee80211_sn_sub(sn, tid_data->next_reclaimed);
 }
 
-int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-			 u8 *key, u32 key_len,
-			 struct ieee80211_key_conf *keyconf)
-{
-	int ret;
-	u16 queue;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, vif);
-	bool mld = iwl_mvm_has_mld_api(mvm->fw);
-	u32 type = IWL_STA_LINK;
-
-	if (mld)
-		type = STATION_TYPE_PEER;
-
-	ret = iwl_mvm_allocate_int_sta(mvm, sta, 0,
-				       NL80211_IFTYPE_UNSPECIFIED, type);
-	if (ret)
-		return ret;
-
-	if (mld)
-		ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, sta, addr,
-							 mvmvif->deflink.fw_link_id,
-							 &queue,
-							 IWL_MAX_TID_COUNT,
-							 &wdg_timeout);
-	else
-		ret = iwl_mvm_add_int_sta_with_queue(mvm, mvmvif->id,
-						     mvmvif->color, addr, sta,
-						     &queue,
-						     IWL_MVM_TX_FIFO_BE);
-	if (ret)
-		goto out;
-
-	keyconf->cipher = cipher;
-	memcpy(keyconf->key, key, key_len);
-	keyconf->keylen = key_len;
-	keyconf->flags = IEEE80211_KEY_FLAG_PAIRWISE;
-
-	if (mld) {
-		/* The MFP flag is set according to the station mfp field. Since
-		 * we don't have a station, set it manually.
-		 */
-		u32 key_flags =
-			iwl_mvm_get_sec_flags(mvm, vif, NULL, keyconf) |
-			IWL_SEC_KEY_FLAG_MFP;
-		u32 sta_mask = BIT(sta->sta_id);
-
-		ret = iwl_mvm_mld_send_key(mvm, sta_mask, key_flags, keyconf);
-	} else {
-		ret = iwl_mvm_send_sta_key(mvm, sta->sta_id, keyconf, false,
-					   0, NULL, 0, 0, true);
-	}
-
-out:
-	if (ret)
-		iwl_mvm_dealloc_int_sta(mvm, sta);
-	return ret;
-}
-
 void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   u32 id)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 4a3799ae7c18..4abc3ad0e6eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -597,10 +597,6 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm, struct ieee80211_txq *txq);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
-int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-			 u8 *key, u32 key_len,
-			 struct ieee80211_key_conf *key_conf_out);
 void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
 				   u32 id);
-- 
2.47.1


