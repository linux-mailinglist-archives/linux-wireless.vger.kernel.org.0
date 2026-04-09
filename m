Return-Path: <linux-wireless+bounces-34548-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IjFMCCw12kORggAu9opvQ
	(envelope-from <linux-wireless+bounces-34548-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 232033CBA4E
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98BB430784B6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD633D3CFB;
	Thu,  9 Apr 2026 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="kK5uboSG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF13D1CCD
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742656; cv=none; b=KXmv+cMSvAlzVlCGUmVYBLxWlt7DKVIZb/lJYbFnxwPgwPQu/GR1i8MSeBcfDbUe8sJv2nxo77Mss/Dkxy1eUWl9WKIg3kYghaaVuLjEkyLK7NUZjINc5dVZYMNRJHXD4BjL4xXEWcXrcIR3OGvP/lxCfoWJ7Y2BLE83tDoaQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742656; c=relaxed/simple;
	bh=jxRNcctxmwX0MkbRBA7kRSZ8C+8QwgU4iQWou+hwTXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTbEW5jJn3L3RQnc0pcpNYuO5TIdH5iBE/iTx9+qVSlEsxclln3bcUMK/8pCaKQFEHRCGZ6sud55WSWqs4VihIJeO3uwGOXAowUbcZPOU0CwSUp28g/s29i9rJtflr7UBn7AU7Qqz8VeCxMPaT1KtBJYqab0whEJvRgNRlBU4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=kK5uboSG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a041eae5so6690835e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775742646; x=1776347446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XrCmJO+rlVwhZWjPhf3xql5fGSti8sETJzpduZisds=;
        b=kK5uboSGxoaQCTuwG7iWNouALnw1ya75pJCFBts2BUJ5x/gUKVOjlVDOIztmjTRrUR
         nIdBdRCF35GQJ2LkEr4Sm78MzSKikh2DGa1Kd/WiS3Q0z5YAnlmqblJ7ShpCoIn1aeCV
         imeSDojK8GBdDmAL+tzQIl64Zs4ir/avMSW9KXRrLGLAMKJKF/YsG8QwKZTsO2sZFZBB
         tw6TrnGkl9iJdmfdrvBoADBLlsaMpgKl8uDJynfFDmRK6iwXR63TojUJvvMVyqShrLX3
         MJwvC1HftzWFq9EIQJCKvpzMUYUKQ2/xk2iAlUQhzdoG9y4kPBNTaiLg4DoShRE8D7Sl
         +20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775742646; x=1776347446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XrCmJO+rlVwhZWjPhf3xql5fGSti8sETJzpduZisds=;
        b=HkszhrQAlMMux6zrh2C7rkfftBMCJb9fmwPyR5tO+MB+7cdrKM3k4opjX7NEWB1l4d
         9DsOhqTfoETdwFx5Mpa8EfFojYFQPslAeRZvb4E7h5KG+Rh/riolMQ9rbZ2ovWRLHJTc
         QA3DvR/JZWZ3eE7/B8IzA++Tmkh7CJxpX7ySgWAHO6HVhEBZBRI/oWVMIy5ekD+T2ad3
         YZ4WYoOV5Dn7YpOwuIJdLTE+9aJ6xJ15BTY4aMebF9DdN6sELVWV9TcIeP14PtjgpYof
         uzGO/mbnsqTdIQbJyX7Jq8rBNQmjOEWMyIhV1+Ske2h6Wo7hhq34rVQMcMth44mnI9V0
         6/bA==
X-Gm-Message-State: AOJu0YwlKB53vQIQNChfXKCy3OO1Qt3ZznKXZFxFWB2qXDexRrYdlfZC
	N3BdJsBRw5/9dNgPUML4d1w0WXATOyBhvVrjf10BXr8sAeqwQ7LKLThpKAgAbqaiIbc=
X-Gm-Gg: AeBDievgcScdQ+1rWQ/NZkacFjzzvtddlxffsmF19UTTNOk+IFPENQnFEsKpG80piFk
	I6mp9jpTXG7Gzg31UVFjQGU1mtOAgZ0VaQYuKiXb1+fPTTVcFo2AFyIcwSBpx7MC82VMrxugZ0l
	x42BZ8LYpHbQQonARgCek4nTpj2ELuUJ2y0kUPnqIH201fZ3zdJKKCcIlrcqIHkLgthzddYblr/
	ZjGxkoJDwNowW9gvGejVdPKM5p0a71FI9BUYkMjteMrVb74QIHQLfoc7C1tWK4sY5yv+bF+b6f9
	h9/Bn/9S724ea52SPAto5vA1p3GkQrIDNdekZRGAg7SOH099IbX/vUB9WPbryCk7CMGmlCXpGpG
	cO4Lo6B56L9XgTgxdLr0EeR2rmyZ36bmyZf8IAYf8BpH6IK6T7vtc8YKuO4yrpoD8q8L81QNueD
	ekvVj0PZkK9egSgyTUggXvJL+Qs6fcQfGpR+5V2o811i9rDdOLXBtTx1Nnqz3cvuNM8ecXO9eii
	kmpd/WNneLX
X-Received: by 2002:a05:600c:3f0a:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488996f9414mr376056335e9.7.1775742646336;
        Thu, 09 Apr 2026 06:50:46 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cf9e8808sm57815625e9.5.2026.04.09.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:50:45 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v2 3/4] wifi: Rename EMLSR delay constants and add EMLMR helpers and definitions
Date: Thu,  9 Apr 2026 15:50:31 +0200
Message-ID: <20260409135035.4018725-4-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409135035.4018725-1-pmartin-gomez@freebox.fr>
References: <20260409135035.4018725-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34548-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox.fr:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 232033CBA4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the final version of 802.11be-2024, Transition Delay and Padding
Delay subfields are for both EMLSR and EMLMR. Depending on whether the
mode is EMLSR or EMLMR, the interpretation of the encoded value might
change.

This patch defines the constants and helpers to interpret delay
subfields both in EMLSR and EMLMR modes.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   4 +-
 include/linux/ieee80211-eht.h                 | 100 ++++++++++++++++--
 net/mac80211/eht.c                            |   4 +-
 5 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e3aec814aa0d..4510caed82a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -115,9 +115,9 @@ static const u8 ext_capa_base[IWL_MLD_STA_EXT_CAPA_SIZE] = {
 
 #define IWL_MLD_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
 				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+					__bf_shf(IEEE80211_EML_CAP_EML_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+					__bf_shf(IEEE80211_EML_CAP_EML_TRANSITION_DELAY))
 #define IWL_MLD_CAPA_OPS (FIELD_PREP_CONST( \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1ec9807e4827..eece3c871203 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -264,9 +264,9 @@ static const u8 tm_if_types_ext_capa_sta[] = {
 
 #define IWL_MVM_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
 				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+					__bf_shf(IEEE80211_EML_CAP_EML_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+					__bf_shf(IEEE80211_EML_CAP_EML_TRANSITION_DELAY))
 #define IWL_MVM_MLD_CAPA_OPS (FIELD_PREP_CONST( \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 37cdf3e8a067..22bad3cba8df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1880,8 +1880,8 @@ mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
 
 	eml_cap = (vif->cfg.eml_cap & (IEEE80211_EML_CAP_EMLSR_SUPP |
 				       IEEE80211_EML_CAP_TRANSITION_TIMEOUT)) |
-		  (ext_capa->eml_capabilities & (IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
-						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY));
+		  (ext_capa->eml_capabilities & (IEEE80211_EML_CAP_EML_PADDING_DELAY |
+						IEEE80211_EML_CAP_EML_TRANSITION_DELAY));
 
 	if (eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP) {
 		eht_mld->eml_cap[0] = u16_get_bits(eml_cap, GENMASK(7, 0));
diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 6324d888073b..82efd01d7708 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -485,19 +485,27 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MED_SYNC_DELAY_DEFAULT		0x10ac
 
 #define IEEE80211_EML_CAP_EMLSR_SUPP			0x0001
-#define IEEE80211_EML_CAP_EMLSR_PADDING_DELAY		0x000e
-#define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_0US		0
-#define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US		1
-#define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_64US		2
-#define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_128US		3
-#define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US		4
-#define IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY	0x0070
+#define IEEE80211_EML_CAP_EML_PADDING_DELAY		0x000e
+/* Described Tables 9-417i & 9-417k in 802.11be-2024, which have the same values */
+#define  IEEE80211_EML_CAP_EML_PADDING_DELAY_0US		0
+#define  IEEE80211_EML_CAP_EML_PADDING_DELAY_32US		1
+#define  IEEE80211_EML_CAP_EML_PADDING_DELAY_64US		2
+#define  IEEE80211_EML_CAP_EML_PADDING_DELAY_128US		3
+#define  IEEE80211_EML_CAP_EML_PADDING_DELAY_256US		4
+#define IEEE80211_EML_CAP_EML_TRANSITION_DELAY	0x0070
+/* Described in Table 9-417j in 802.11be-2024 */
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US		0
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US		1
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US		2
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US		3
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_128US		4
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US		5
+/* Described in Table 9-417l in 802.11be-2024 */
+#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_0US		0
+#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_32US		1
+#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_64US		2
+#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_128US		3
+#define  IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_256US		4
 #define IEEE80211_EML_CAP_EMLMR_SUPPORT			0x0080
 #define IEEE80211_EML_CAP_TRANSITION_TIMEOUT		0x7800
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_0			0
@@ -1114,11 +1122,17 @@ static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
 
 static inline u32 ieee80211_emlsr_pad_delay_in_us(u16 eml_cap)
 {
+	u32 emlsr_supp =
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP);
+
+	if (!emlsr_supp)
+		return 0;
+
 	/* IEEE Std 802.11be-2024 Table 9-417i—Encoding of the EMLSR
 	 * Padding Delay subfield.
 	 */
 	u32 pad_delay = u16_get_bits(eml_cap,
-				     IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+				     IEEE80211_EML_CAP_EML_PADDING_DELAY);
 
 	if (!pad_delay ||
 	    pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
@@ -1138,12 +1152,18 @@ static inline u32 ieee80211_emlsr_pad_delay_in_us(u16 eml_cap)
 
 static inline u32 ieee80211_emlsr_trans_delay_in_us(u16 eml_cap)
 {
+	u32 emlsr_supp =
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP);
+
+	if (!emlsr_supp)
+		return 0;
+
 	/* IEEE Std 802.11be-2024 Table 9-417j—Encoding of the EMLSR
 	 * Transition Delay subfield.
 	 */
 	u32 trans_delay =
 		u16_get_bits(eml_cap,
-			     IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+			     IEEE80211_EML_CAP_EML_TRANSITION_DELAY);
 
 	/* invalid values also just use 0 */
 	if (!trans_delay ||
@@ -1153,6 +1173,68 @@ static inline u32 ieee80211_emlsr_trans_delay_in_us(u16 eml_cap)
 	return 16 * (1 << (trans_delay - 1));
 }
 
+/**
+ * ieee80211_emlmr_pad_delay_in_us - Fetch the EMLMR Padding delay
+ *	in microseconds
+ * @eml_cap: EML capabilities field value from common info field of
+ *	the Multi-link element
+ * Return: the EMLMR Padding delay (in microseconds) encoded in the
+ *	EML Capabilities field
+ */
+
+static inline u32 ieee80211_emlmr_pad_delay_in_us(u16 eml_cap)
+{
+	u32 emlmr_supp =
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLMR_SUPP);
+
+	if (!emlmr_supp)
+		return 0;
+
+	/* IEEE Std 802.11be-2024 Table 9-417k—Encoding of the EMLMR
+	 * Padding Delay subfield.
+	 */
+	u32 pad_delay = u16_get_bits(eml_cap,
+				     IEEE80211_EML_CAP_EML_PADDING_DELAY);
+
+	if (!pad_delay ||
+	    pad_delay > IEEE80211_EML_CAP_EMLMR_PADDING_DELAY_256US)
+		return 0;
+
+	return 32 * (1 << (pad_delay - 1));
+}
+
+/**
+ * ieee80211_emlmr_trans_delay_in_us - Fetch the EMLMR Transition
+ *	delay in microseconds
+ * @eml_cap: EML capabilities field value from common info field of
+ *	the Multi-link element
+ * Return: the EMLMR Transition delay (in microseconds) encoded in the
+ *	EML Capabilities field
+ */
+
+static inline u32 ieee80211_emlmr_trans_delay_in_us(u16 eml_cap)
+{
+	u32 emlmr_supp =
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLMR_SUPP);
+
+	if (!emlmr_supp)
+		return 0;
+
+	/* IEEE Std 802.11be-2024 Table 9-417l—Encoding of the EMLSR
+	 * Transition Delay subfield.
+	 */
+	u32 trans_delay =
+		u16_get_bits(eml_cap,
+			     IEEE80211_EML_CAP_EML_TRANSITION_DELAY);
+
+	/* invalid values also just use 0 */
+	if (!trans_delay ||
+	    trans_delay > IEEE80211_EML_CAP_EMLMR_TRANSITION_DELAY_256US)
+		return 0;
+
+	return 32 * (1 << (trans_delay - 1));
+}
+
 /**
  * ieee80211_eml_trans_timeout_in_us - Fetch the EMLSR Transition
  *	timeout value in microseconds
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 768bfc4e737d..1e412405ae44 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -217,11 +217,11 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 			sta->sta.eml_cap =
 				u8_replace_bits(sta->sta.eml_cap,
 						pad_delay,
-						IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+						IEEE80211_EML_CAP_EML_PADDING_DELAY);
 			sta->sta.eml_cap =
 				u8_replace_bits(sta->sta.eml_cap,
 						trans_delay,
-						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+						IEEE80211_EML_CAP_EML_TRANSITION_DELAY);
 		}
 	}
 
-- 
2.43.0


