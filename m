Return-Path: <linux-wireless+bounces-4894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF51387F91D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F115C1C21233
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E453E17;
	Tue, 19 Mar 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJuohz80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABE7D3EF
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835874; cv=none; b=ne8vZs7c3S2SeAHJ1FiAAh1/9y8pHC6TwazM2WfOvyQcmkn3FJLGLBjSuFnFLCWnryF9yt/uZc/HV2++9YyKsF+AkFmMSzbfX3V+i35riNlc5++eMxn0b2lKLGEwPmVcdSCC0auUGzlRCm7KtQf4DohhG7PJXIB/UtyuIOuEGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835874; c=relaxed/simple;
	bh=od78+znxHAnSVuUk72rFVQ021RnoZ/k7wyQoNilzcUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSeOwIUyIvX+wIt2bX07XHMnGMzD6K6X8TwfJg83DyQ2MAshBbjCJdZFAcTQp/IbFhEb8jGTkQl6Tf8+8TQy7K+PplxGZlDs/L0cHVQP09Lb4xf6mwWwuigfGx9DvSPCicJmb6iJ2AY129vssY5NA2vgKCtJaeV8F4P+lxIgyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJuohz80; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835873; x=1742371873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=od78+znxHAnSVuUk72rFVQ021RnoZ/k7wyQoNilzcUg=;
  b=NJuohz80byOFv1iWvKa2adW4x4l9Uizs29I2dUrrqlTupadzKz7oPTog
   88UamPLd+aJcpfcEnvrPWTyKWXMdgt/RA/7vvQyAk+lVYMk6+drlZMh56
   zLYc75lEnJR+zmyEbyHZEJagOHfG9m8XlfZ3AJkvIIU+s4gsxGMDE5XgF
   nX9YvgITX1/tGWOQH0PWTieney6m8rtqeYUSsphsqZtlbSeX1pydg1yQj
   rwT24tcbIPYR5Q95zlfCqypBLLpF34JDg7wifXVwKrIe6WfQJNns0xIiZ
   /b9s281ZrQgJoACMBPUAXHmwJ0EBhsCTYesNfTCPDA673i7BnRnpX2PVS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810589"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447673"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: enable monitor on passive/inactive channels
Date: Tue, 19 Mar 2024 10:10:26 +0200
Message-Id: <20240319100755.7c62f421f03e.I9969d3a46fed48e67fa28a7d00080b0dd314dabd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If firmware supports pure passive monitor on passive/inactive
channels, enable that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |  3 +++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index f69d29e531c8..ae05227b6153 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -395,6 +395,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  * @IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT: Support SPP (signaling and payload
  *	protected) A-MSDU.
  * @IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT: Support secure LTF measurement.
+ * @IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS: Support monitor mode on otherwise
+ *	passive channels
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -494,6 +496,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
 	IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)117,
 	IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT		= (__force iwl_ucode_tlv_capa_t)121,
+	IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS	= (__force iwl_ucode_tlv_capa_t)122,
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 047f77aad367..9a8d2b69f154 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -392,11 +392,14 @@ static enum nl80211_band iwl_nl80211_band_from_channel_idx(int ch_idx)
 	return NL80211_BAND_2GHZ;
 }
 
-static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
+static int iwl_init_channel_map(struct iwl_trans *trans,
+				const struct iwl_fw *fw,
 				struct iwl_nvm_data *data,
 				const void * const nvm_ch_flags,
 				u32 sbands_flags, bool v4)
 {
+	const struct iwl_cfg *cfg = trans->cfg;
+	struct device *dev = trans->dev;
 	int ch_idx;
 	int n_channels = 0;
 	struct ieee80211_channel *channel;
@@ -478,6 +481,10 @@ static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
 		else
 			channel->flags = 0;
 
+		if (fw_has_capa(&fw->ucode_capa,
+				IWL_UCODE_TLV_CAPA_MONITOR_PASSIVE_CHANS))
+			channel->flags |= IEEE80211_CHAN_CAN_MONITOR;
+
 		iwl_nvm_print_channel_flags(dev, IWL_DL_EEPROM,
 					    channel->hw_value, ch_flags);
 		IWL_DEBUG_EEPROM(dev, "Ch. %d: %ddBm\n",
@@ -1171,12 +1178,11 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 			    const struct iwl_fw *fw)
 {
 	struct device *dev = trans->dev;
-	const struct iwl_cfg *cfg = trans->cfg;
 	int n_channels;
 	int n_used = 0;
 	struct ieee80211_supported_band *sband;
 
-	n_channels = iwl_init_channel_map(dev, cfg, data, nvm_ch_flags,
+	n_channels = iwl_init_channel_map(trans, fw, data, nvm_ch_flags,
 					  sbands_flags, v4);
 	sband = &data->bands[NL80211_BAND_2GHZ];
 	sband->band = NL80211_BAND_2GHZ;
-- 
2.34.1


