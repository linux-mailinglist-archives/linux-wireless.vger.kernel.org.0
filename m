Return-Path: <linux-wireless+bounces-27880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3ADBC4252
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D9A3B2532
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29722C0260;
	Wed,  8 Oct 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lK8+4Wcb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32D1AAA1C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915251; cv=none; b=DhVBOtfJCdSNM5lV6C48rjcsytuviVmUcthhq8cWQsQ/QORlAPBmE5Re6SnFvAQfY1/SJWmjrs32l4dmB/TMLNAZHI1ANoeFpRzpeAKhn2pZdIT9BFk08JUMy4qyZvfI7533XJKJeARGQjgEUqNmDrkE8A9x5nQnJ+AivNgNfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915251; c=relaxed/simple;
	bh=my+SpFOay0mdz8lxH/lTGMhuomoeUpY5SGPindTkeYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPZOugui9bolipQ8PIMuhtQybYDjL5ASxfFOtCeilYVpS3XdZ9Q4jaQsxj4SF1DIMjg/7z8pdgoUUJ4mNH7z1jIYfibYXlX/V8Gxj/QXzWfQ2Gjhs6qbtTWtW/ngMKT7A7jreBMmgZr8vcUUNzhyehdqjR6hI+uB6DJR7Sma3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lK8+4Wcb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=9+l0BjOP0bHMkcQNeG+mJbpoJkWMJ2C3T7sFre5jtsc=; t=1759915250; x=1761124850; 
	b=lK8+4WcbrrvEvS+RmKAdxJRLdVZKvJHGnO0SBuGBjaHKoOKDVT2huuf7vOmB54KCOoTb1SVUydi
	/wokDzlDoasu5SYXW1AbbjWPvXAbypRwYBipHHCrdRRn8jg/Rbvx376lPy3DsX44D1+1Ai+w3ENNN
	4dz6/FxBzT7Pv4NiCLT85hzDa3CADVaXlt6G8XCtgxbtqJU4znd6mlmXA05c4pV2z9hL9zOo5KDDV
	H7Nu5jQhyFIP428B9+EycEFs4bkWY6LVQ9beiKWXBWYV0ougSsx2ZM0Q+2ZbNkS09MfelVaavkd2Z
	5vmZbI6G5Nh6y5OQ0eK7k3aglBLDsZXhENSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v6QLn-00000000G5c-0NQM;
	Wed, 08 Oct 2025 11:20:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: mvm: fix beacon template/fixed rate
Date: Wed,  8 Oct 2025 11:20:44 +0200
Message-ID: <20251008112044.3bb8ea849d8d.I90f4d2b2c1f62eaedaf304a61d2ab9e50c491c2d@changeid>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During the development of the rate changes, I evidently made
some changes that shouldn't have been there; beacon templates
with rate_n_flags are only in old versions, so no changes to
them should have been necessary, and evidently broke on some
devices. This also would have broken fixed (injection) rates,
it would seem. Restore the old handling of this.

Fixes: dabc88cb3b78 ("wifi: iwlwifi: handle v3 rates")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220558
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 13 +++----------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    | 12 +++++++++---
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 8805ab344895..0065c2ead56b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -938,19 +938,12 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 
 u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 {
+	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
 	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw, BEACON_TEMPLATE_CMD, 0) > 10;
-	u16 flags, cck_flag;
-
-	if (is_new_rate) {
-		flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
-		cck_flag = IWL_MAC_BEACON_CCK;
-	} else {
-		cck_flag = IWL_MAC_BEACON_CCK_V1;
-		flags = iwl_fw_rate_idx_to_plcp(rate_idx);
-	}
 
 	if (rate_idx <= IWL_LAST_CCK_RATE)
-		flags |= cck_flag;
+		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
+			  : IWL_MAC_BEACON_CCK_V1;
 
 	return flags;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 62da0132f383..a62f5288dfd0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -169,9 +169,15 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx)
 {
-	return (rate_idx >= IWL_FIRST_OFDM_RATE ?
-		rate_idx - IWL_FIRST_OFDM_RATE :
-		rate_idx);
+	if (iwl_fw_lookup_cmd_ver(fw, TX_CMD, 0) > 8)
+		/* In the new rate legacy rates are indexed:
+		 * 0 - 3 for CCK and 0 - 7 for OFDM.
+		 */
+		return (rate_idx >= IWL_FIRST_OFDM_RATE ?
+			rate_idx - IWL_FIRST_OFDM_RATE :
+			rate_idx);
+
+	return iwl_fw_rate_idx_to_plcp(rate_idx);
 }
 
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac)
-- 
2.51.0


