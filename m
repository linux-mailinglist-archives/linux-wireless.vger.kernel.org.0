Return-Path: <linux-wireless+bounces-34098-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGujE/flxmnrPwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34098-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:17:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE83134ACBB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A968F3134444
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF039C00C;
	Fri, 27 Mar 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="i9363nsS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73E399021
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642324; cv=none; b=j0TLfUmPk89wIsyzeAMjhJai8mzVHJ+jeVqVabX8fcqvt5l7JpRZ0NBHxmegd2Vo8ZEpZ6pJtu1xrvMxlfWr4zddrzz12sx4WvdCIPWmqhG/9Iw3DU0EGv8hdsLtRCEBNMy6676AZbYoX6PIAyffZ5TqzLu/9yjTQzZK3ucOdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642324; c=relaxed/simple;
	bh=QYBSdAcl+kV//MY3QMxC0g707BApBhaeLARs+3Hf9yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL3XUnNn6UBwooBIdK/t8qFCYp4mXtrrqVDVYrf8esvkJxFYJ/sZPPR4YjVN2/NkFVX9hzWtgCEYcu9dOeIF5ljwTtEO7o4q4N/RVgdvqLLyWFYesPlysEK2bvYhVlJVXFA0hXxcWVnIbzPoT6XkqQscVeFXzve40nxCBYL68ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=i9363nsS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso22053145e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774642321; x=1775247121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK+IbqF2VD1C3vLGHvBSF2wKOVoIiWL43WozVq7JhV8=;
        b=i9363nsSN/YgpnvLmmhsTf/ndJ0O7D27Akx4P84AqmjV35sCiqZQTjCNmyYDj+Aqcl
         IY44qysYZAExjcJ78EMN5rIlHVT6dyPMafMybDmJv3jmvx/kLQH5ugFXt1wmLugNqAd9
         EDgNTwAJaMFBKpqwME4MLjiD4MNJR0JdRaFzsgZtvGilePGXdUGtTHXtUJraO1yRtbUH
         R6JhYAT1/qHD+aLRoMMDiwu7LlNy9An+CYog0m3N4qbG1IpuHsqROZfV5pXSy/FcSl7G
         0uW58i34ULFpwCDMtre0T2NqfVn3BUmJOdM8U37axs43ffdUu8Gasa8tWFOdc+jz62Uf
         7CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642321; x=1775247121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mK+IbqF2VD1C3vLGHvBSF2wKOVoIiWL43WozVq7JhV8=;
        b=UrSQM5SxS40XrPvI9xqmPrcffdOqdA6mk+EkGyQjjG10eyO5O9XY60/B0TbRiymhbm
         fSq9AWnvKFqvbK1ci0R0Q5oo/aVuyD9A0rsTa7FVTBBr/o/6YBEYmBOz3Ab1OBfZQreO
         vaf+Gby2/O7s5TlaeHl9YuotbXA+KcXORNqknV15t7hKNsYhY817u/Oo7f3AXlOeMwO6
         FfxratE4KlB8FwZgeDC/nQ93eLmLCYVhmvn2/GO9+O7KipAASJgUtmzLXzya5pOWi1XV
         r528BGSedXRVtR6m1wewRAHDkilfYNknOg2lY3o94iLxTgif25td/z4SjmXZpYCNwwo7
         +vuQ==
X-Gm-Message-State: AOJu0YxMK6kJijW7u3yQvoeO/nvWjHME3AJSwLQrc6sXlSl+7FiA4zXD
	tvfyoN3Dr6NumHjT958kKjVf8uvUosEXT42auD21IMkP7aAWP8tRm5Mks3aHLMmT+S8aK8PRqin
	iuVop
X-Gm-Gg: ATEYQzwS5W3XkI1+gp2e2CeL6AFAKc1aIPaD7B00OVk6CHvzW5i1KjWgYjuS1jS7aOE
	7faWI9ESDKLIKC+UkHOVAJPrkdXf7aJGJpVTE/Wz8wTY/oYf1vYqB1PYw7EsYuzwM3WbmyNjW2+
	/mtE3aBsGRUXEVHU5kQ5J2HW/ZMjWD4kONuR5RP+bHrrAhQv9wVbCUeX3RcGfL0Boljkrv7rTDa
	B+yCsPPeY9qFhEMxqIv2LRKwLrUHvq0gpMwYV2j85LdKBKiPzX6MRUFMKHpmjhcihPHRxl1K4x7
	gf7rYptc8voEKJamp6BGET2vU5Ljlet2+HHS3fbSb0G7xzeTz0GchmAEEnXh5A8owBLUkRkNjma
	8wM9ALukkULIzaYA9/dMNQq1RjyVWQ0jTc7yD56QURpLmnvx9BrLXMCjNV7X6fmzblAQWnqYWaP
	tgNTh45XWD3TBNhOXrCeKGVaL4hwVgLm8ZjM/5YqESHdAxZJ1gvAjWUDqmND1LN5JZci7LRMHSA
	c6uyv3/ZFBn
X-Received: by 2002:a05:600c:810a:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-48727e91110mr68157765e9.14.1774642321359;
        Fri, 27 Mar 2026 13:12:01 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb5417sm35670035e9.3.2026.03.27.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:12:01 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH 3/3] wifi: Transition/Padding delay subfields are for both EMLSR and EMLMR
Date: Fri, 27 Mar 2026 21:11:33 +0100
Message-ID: <20260327201135.905852-4-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34098-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:email,freebox.fr:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BE83134ACBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the final version of 802.11be-2024, Transition Delay and Padding
Delay subfield are for both EMLSR and EMLMR. Check the EMLSR Support
subfield is set before assuming the delays values are for EMLSR.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  4 ++--
 include/linux/ieee80211-eht.h                 | 20 +++++++++++++++----
 net/mac80211/eht.c                            |  4 ++--
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e3aec814aa0d..8becd80689d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -115,9 +115,9 @@ static const u8 ext_capa_base[IWL_MLD_STA_EXT_CAPA_SIZE] = {
 
 #define IWL_MLD_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
 				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+					__bf_shf(IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+					__bf_shf(IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY))
 #define IWL_MLD_CAPA_OPS (FIELD_PREP_CONST( \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1ec9807e4827..099c0dbfd4eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -264,9 +264,9 @@ static const u8 tm_if_types_ext_capa_sta[] = {
 
 #define IWL_MVM_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
 				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+					__bf_shf(IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+					__bf_shf(IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY))
 #define IWL_MVM_MLD_CAPA_OPS (FIELD_PREP_CONST( \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 37cdf3e8a067..b54a10418ce3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1880,8 +1880,8 @@ mt7925_mcu_sta_eht_mld_tlv(struct sk_buff *skb,
 
 	eml_cap = (vif->cfg.eml_cap & (IEEE80211_EML_CAP_EMLSR_SUPP |
 				       IEEE80211_EML_CAP_TRANSITION_TIMEOUT)) |
-		  (ext_capa->eml_capabilities & (IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
-						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY));
+		  (ext_capa->eml_capabilities & (IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY |
+						IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY));
 
 	if (eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP) {
 		eht_mld->eml_cap[0] = u16_get_bits(eml_cap, GENMASK(7, 0));
diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 6324d888073b..b52cab33bcf1 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -485,13 +485,13 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MED_SYNC_DELAY_DEFAULT		0x10ac
 
 #define IEEE80211_EML_CAP_EMLSR_SUPP			0x0001
-#define IEEE80211_EML_CAP_EMLSR_PADDING_DELAY		0x000e
+#define IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY		0x000e
 #define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_0US		0
 #define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US		1
 #define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_64US		2
 #define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_128US		3
 #define  IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US		4
-#define IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY	0x0070
+#define IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY	0x0070
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US		0
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US		1
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US		2
@@ -1114,11 +1114,17 @@ static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
 
 static inline u32 ieee80211_emlsr_pad_delay_in_us(u16 eml_cap)
 {
+	u32 elmsr_supp =
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP);
+
+	if (!elmsr_supp)
+		return 0;
+
 	/* IEEE Std 802.11be-2024 Table 9-417i—Encoding of the EMLSR
 	 * Padding Delay subfield.
 	 */
 	u32 pad_delay = u16_get_bits(eml_cap,
-				     IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+				     IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY);
 
 	if (!pad_delay ||
 	    pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
@@ -1138,12 +1144,18 @@ static inline u32 ieee80211_emlsr_pad_delay_in_us(u16 eml_cap)
 
 static inline u32 ieee80211_emlsr_trans_delay_in_us(u16 eml_cap)
 {
+	u32 elmsr_supp =
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP);
+
+	if (!elmsr_supp)
+		return 0;
+
 	/* IEEE Std 802.11be-2024 Table 9-417j—Encoding of the EMLSR
 	 * Transition Delay subfield.
 	 */
 	u32 trans_delay =
 		u16_get_bits(eml_cap,
-			     IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+			     IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY);
 
 	/* invalid values also just use 0 */
 	if (!trans_delay ||
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 768bfc4e737d..89c4b7b7e8c8 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -217,11 +217,11 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 			sta->sta.eml_cap =
 				u8_replace_bits(sta->sta.eml_cap,
 						pad_delay,
-						IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+						IEEE80211_EML_CAP_EMLSR_EMLMR_PADDING_DELAY);
 			sta->sta.eml_cap =
 				u8_replace_bits(sta->sta.eml_cap,
 						trans_delay,
-						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+						IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY);
 		}
 	}
 
-- 
2.43.0


