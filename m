Return-Path: <linux-wireless+bounces-8001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63F8CD007
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5C21F238DB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D631411E0;
	Thu, 23 May 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o1Rn61+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DA140373
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458996; cv=none; b=Y56cDQdcWI9JHGbsDHuyvRY2DwSqpaiRF0FRmZGOZH+giWvnzLrMx2PtAt8r1kYg7vFdOwNKXlXRAuIA4oX1JG4/VnpXQB3eiMNNYOEXAzCK4NSZjBrIT369ZgKtD+RKd32sqqfbQStli/dzuoKCGslAY6++uOmcCQM8UW3KYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458996; c=relaxed/simple;
	bh=qb0zfcDAluIoxpxsf9svJ8hAhgG95Y4DT7iSWNu7CjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPOhB8wpYJsec9VtPjw6sFDnaGdglzytKUAbifi6cfnvQ4rsOlK6+VyPkyKTBd+5QNzfxiukto+/n33zQE81IS0sumYMKi8Xl1bVJqnmc6byOyBzBgAwpfSGRtfK6TMusdZvWQM5GKplXauI8Anc43VbvXB2Qamw6d9oJALZPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o1Rn61+j; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=27QM72yIeEtS5RAaR9cyyygI+g9ay1smfkgXlIhD2B4=;
	t=1716458995; x=1717668595; b=o1Rn61+jijTJffUQ0aHv8TX7dO/9IvgsAt84TRk/ah6zlUf
	9167WLPU/DoGGhgqtZGi8FO3qYjewjv/CnTLzPnEYasmyyUBec+6edEBpbt5MELkIhxVLwMeBPdg+
	NoIQY3aKWU44qVLUTwUSRPY8CvzxpzfE+bzDwFKvXQICrgSLNuEBwlGVAqAv3uTQTg1iLgR8fnXjS
	MpG0UWN6Jo7HLQJysNGf30v+io8/whgX9aYGu8WIWbvgz+aJhWsf/U7Q18zRn+sIyxxUAiNw2luwO
	mYZXGwSEYqDwwtr/p5O4z40dCmrrz2LgQifjpcdM1SuQt+ffwc6LW1wjZZhTHriQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OS-00000005wvn-3Gc4;
	Thu, 23 May 2024 12:09:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 6/8] wifi: cfg80211: refactor 6 GHz AP power type parsing
Date: Thu, 23 May 2024 12:09:47 +0200
Message-ID: <20240523120945.84cdffd94085.I76f434ee12552e8be91273f3b2d776179eaa62f1@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add cfg80211_get_6ghz_power_type() to parse the 6 GHz
power type from a given set of elements, which is now
only inside cfg80211_6ghz_power_type_valid().

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.h |  4 +++
 net/wireless/scan.c | 65 ++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 470a18dc4cbf..41c8c0e3ba2e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -533,6 +533,10 @@ struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 		    struct cfg80211_internal_bss *tmp,
 		    bool signal_valid, unsigned long ts);
+
+enum ieee80211_ap_reg_power
+cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len);
+
 #ifdef CONFIG_CFG80211_DEVELOPER_WARNINGS
 #define CFG80211_DEV_WARN_ON(cond)	WARN_ON(cond)
 #else
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 8daed8232b05..c77312175ca3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2121,38 +2121,53 @@ struct cfg80211_inform_single_bss_data {
 	u64 cannot_use_reasons;
 };
 
-static bool cfg80211_6ghz_power_type_valid(const u8 *ie, size_t ielen,
-					   const u32 flags)
+enum ieee80211_ap_reg_power
+cfg80211_get_6ghz_power_type(const u8 *elems, size_t elems_len)
 {
-	const struct element *tmp;
+	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 	struct ieee80211_he_operation *he_oper;
+	const struct element *tmp;
 
-	tmp = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie, ielen);
-	if (tmp && tmp->datalen >= sizeof(*he_oper) + 1 &&
-	    tmp->datalen >= ieee80211_he_oper_size(tmp->data + 1)) {
-		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	tmp = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
+				     elems, elems_len);
+	if (!tmp || tmp->datalen < sizeof(*he_oper) + 1 ||
+	    tmp->datalen < ieee80211_he_oper_size(tmp->data + 1))
+		return IEEE80211_REG_UNSET_AP;
 
-		he_oper = (void *)&tmp->data[1];
-		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+	he_oper = (void *)&tmp->data[1];
+	he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
 
-		if (!he_6ghz_oper)
-			return false;
+	if (!he_6ghz_oper)
+		return IEEE80211_REG_UNSET_AP;
 
-		switch (u8_get_bits(he_6ghz_oper->control,
-				    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-		case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-		case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
-			return true;
-		case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-		case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
-			return !(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT);
-		case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-			return !(flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT);
-		default:
-			return false;
-		}
+	switch (u8_get_bits(he_6ghz_oper->control,
+			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
+		return IEEE80211_REG_LPI_AP;
+	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
+		return IEEE80211_REG_SP_AP;
+	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
+		return IEEE80211_REG_VLP_AP;
+	default:
+		return IEEE80211_REG_UNSET_AP;
+	}
+}
+
+static bool cfg80211_6ghz_power_type_valid(const u8 *elems, size_t elems_len,
+					   const u32 flags)
+{
+	switch (cfg80211_get_6ghz_power_type(elems, elems_len)) {
+	case IEEE80211_REG_LPI_AP:
+		return true;
+	case IEEE80211_REG_SP_AP:
+		return !(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT);
+	case IEEE80211_REG_VLP_AP:
+		return !(flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT);
+	default:
+		return false;
 	}
-	return false;
 }
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
-- 
2.45.1


