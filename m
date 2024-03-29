Return-Path: <linux-wireless+bounces-5682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC048933BA
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F99CB21F92
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3631448ED;
	Sun, 31 Mar 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="nlhY+zMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8C1474D7
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903193; cv=pass; b=Rzk9Ej0D8fPx2YOlDV/97ievZWk/b50gJNP9Fkj0Wph49zJtuAdRMnCbAuIuBHuTo16DbfjVnDIVOjgn10j4f2ycOgWfFxnbts9OSrSfr8EM5eVviqJOAD4o2gaO36jIdtn49RHGF7CjLgj6HU7FeU5TMrITh13l9QMT5TlNwOg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903193; c=relaxed/simple;
	bh=7pGYrMUiSkjwH5TCTNsKKcFYxT8HoHviqEpyPHDJo98=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=pZAgXnXdoYGFVafBGa5f+x1mEx0hVo0Lj2QIVToF2whw3bDxxGyKJ9L7LSrCAXThqZUEh9X3phhf4dZXAPpYq1I/J0JtRbe0g/k55kwPOGRDdNW3hH5qI1gSVLosoCQDdFTwQNyO3DjuduE6aw9huWR9mCCMKe3cL/3GvdQ/upo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=fail smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=nlhY+zMq; arc=pass smtp.client-ip=96.47.72.81; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=FreeBSD.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 513C02087B;
	Sun, 31 Mar 2024 18:39:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9i--duvVKweb; Sun, 31 Mar 2024 18:39:49 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 79FBC2083B;
	Sun, 31 Mar 2024 18:39:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 79FBC2083B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6D2A480004A;
	Sun, 31 Mar 2024 18:39:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <linux-wireless+bounces-5627-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAKkmmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 17709
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5627-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1382520883
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752039; cv=pass; b=tk9RYQCCgh9SQhYtCCWcK7FM9rYQHFrjCifuSXfV2ZKYBRZddXb+H+5JBQqkRIYKCcOMOcjySHzqpanduRVzZIkaOliFwMw4D8yVnbSEneXQf5JYqjZRxGXOroAUXStbTan6KFfSmlWez/pTDLhL5Tk9ipn7gZiQuqjLXGduXLE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752039; c=relaxed/simple;
	bh=7pGYrMUiSkjwH5TCTNsKKcFYxT8HoHviqEpyPHDJo98=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=SJMCEY9dfTKY7srUdInOMe3OS/dRYkraA6cbNp5hl4/FLvIcbPWPzmf1XH3SYs+on3KCYhoijAOKCqeV+pihL39qZiiemvJeMHaFuzkyOfb55Bxh30mGmrCqMTWFj8w+boREspGE9i1l5No1me75oPUX/lvcb1M2O0NUKRmsE5Y=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=nlhY+zMq; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711752036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NCVKXUNR3QTD61lMq3BrVIdn17RB8M4l5LHckoatSYM=;
	b=nlhY+zMquuM9Dk2L1xJoFy63Ikn11pRM8HKL3K/DllVbhqm3QS1C+2VqOUY+yoUzWOuUrL
	whcEennMqkSsLlSkxWwhzdosLTZpvAPHY3tKp6N/oZhrQZj0zjIx22kR7hyAGjxVBeN8cM
	g//lMbXNfL+FkzfcOIyco5QcpPT13nsa4SF+PPVktNPgPfp5TdwYlY5ne7MHoH4yDlvfsA
	GiDCzt5gPcTDdNl3xgqJBl76vlu2mrGEc/T9Y702wQigCOeOGlrfaBy7UugbabRK5Chk4g
	jFz5XiYyctMDmPfBLAMTqZa1maS79lHYf0EQ8q9aIf+zcSv9iek/60OyV1walw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711752036; a=rsa-sha256; cv=none;
	b=Y+G0KevYLkzTZJViYyJXEmhALqMrv8lx7hmyqNO71OoagPTdsFyS+0Fzo5YEQy7vjYRDzU
	C2CcrL7D6AnqmCb/4Gjts5LU5JaczAjcGyLO8ncLCYzXizZiK2kIRBBDDWOvqNSV37VHWA
	zJZNZ6M2j/79US9Am26wibzYzhbEBcyPOrqJ+LsxO93VeEXbLOHzryk7xWXm6KltHBOQG8
	2cGFoxbCG8pE7zTk2gSqDfqCRwrAJldDDqSganjAoPzwjjllj5y6FpgOeuz1vIzsTRvJYK
	r34+bJKcPylhxcfNrHRSjjbla5KyO1ZqmYORIuhpaz+DsiTI1tDXr8uQ+yPwqg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711752036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NCVKXUNR3QTD61lMq3BrVIdn17RB8M4l5LHckoatSYM=;
	b=U9F49Dfks3auHb3WWMqG78HoVX02iGp/mod7oPzrZKOzPKg9y1AOsNEKGmRH9kzWPGFP0C
	KTQOX626BTbSJN+zaoV8ktm8c2l1SKqtWoSpwNWOLtVhvVi5q8rfvDvv2ZJ3irbUqqeDQh
	mVgJxrjMossvPuvnKUbqZc/Ohk/IrubY1iHnru+WUwWuwWHufkps7CY6iDv/46rnb0NIyT
	0Cz3QiXaPJFVWWl7yjbCuGlnI26xHklqJlHjLbKVSuHmPxAfbcRBYSR6zMwI1Z60iu+iLT
	ss4WjBMQXP0eT2d1mC42NxLLGJHUGEV8Bxrhei26KSJzL4EqBk0utbTrOfB3mw==
X-Virus-Scanned: amavisd-new at sbone.de
Date: Fri, 29 Mar 2024 22:40:33 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 1/3] wifi: iwlwifi: mvm: remove dead code
Message-ID: <185p689r-ppo9-172r-sq32-5794rs0054qn@SerrOFQ.bet>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Both iwl_mvm_ftm_resp_remove_pasn_sta() and
iwl_mvm_ftm_respoder_add_pasn_sta() are not used anywhere, so
remove dead code.
That also orphans iwl_mvm_add_pasn_sta(). Remove that too.

Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored by:	The FreeBSD Foundation
---
  .../intel/iwlwifi/mvm/ftm-responder.c         | 80 -------------------
  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 --
  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 65 ---------------
  drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 -
  4 files changed, 154 deletions(-)

diff --git drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 8f10590f9cdd..5bcaeecb8ab4 100644
--- drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -312,86 +312,6 @@ static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
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
-		sta = kzalloc(sizeof(*sta), GFP_KERNEL);
-		if (!sta)
-			return -ENOBUFS;
-
-		ret = iwl_mvm_add_pasn_sta(mvm, vif, &sta->int_sta, addr,
-					   cipher, tk, tk_len);
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
diff --git drivers/net/wireless/intel/iwlwifi/mvm/mvm.h drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 81dbef6947f5..6c6c3516687f 100644
--- drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2279,12 +2279,6 @@ void iwl_mvm_ftm_restart_responder(struct iwl_mvm *mvm,
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

diff --git drivers/net/wireless/intel/iwlwifi/mvm/sta.c drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index c2e0cff740e9..decafdbc2f5b 100644
--- drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4324,71 +4324,6 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
  	return ieee80211_sn_sub(sn, tid_data->next_reclaimed);
  }

-int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-			 u8 *key, u32 key_len)
-{
-	int ret;
-	u16 queue;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct ieee80211_key_conf *keyconf;
-	unsigned int wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, vif, false, false);
-	bool mld = iwl_mvm_has_mld_api(mvm->fw);
-	u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
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
-	keyconf = kzalloc(sizeof(*keyconf) + key_len, GFP_KERNEL);
-	if (!keyconf) {
-		ret = -ENOBUFS;
-		goto out;
-	}
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
-	kfree(keyconf);
-	return 0;
-out:
-	iwl_mvm_dealloc_int_sta(mvm, sta);
-	return ret;
-}
-
  void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
  				   struct ieee80211_vif *vif,
  				   u32 id)
diff --git drivers/net/wireless/intel/iwlwifi/mvm/sta.h drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 3cf8a70274ce..f4c901bded70 100644
--- drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -573,9 +573,6 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
  void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
  int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm, struct ieee80211_txq *txq);
  void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
-int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-			 u8 *key, u32 key_len);
  void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
  				   struct ieee80211_vif *vif,
  				   u32 id);
-- 
2.40.0


