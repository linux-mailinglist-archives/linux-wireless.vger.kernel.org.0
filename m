Return-Path: <linux-wireless+bounces-34627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II/qLsMt2Wl+nAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:05:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7F3DADD4
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A36B23006032
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591F3E2769;
	Fri, 10 Apr 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="kN1xF0Ki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9DD3E2765
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840686; cv=none; b=NSeMoW0gIzp6L2RNYaHgb52yWYweVAE7IB2J3XAItNJcEPvE0bOuyrGW0U6H+P9oDxlXAv6BHpTFiQkBW8o5773zNtMrOVtymo8zwAgOevAJg94ZE0rrAm3s5zghGvxRO/4b+C1GQtuab0TTgwhVqFFLfuTyNIyFj4L6SlCxhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840686; c=relaxed/simple;
	bh=M3zHIh5RYqD4ZcC+/VhhU9yM1vYfVeeojnlBt0gVhwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL+tmPU0ilT0Mkg9doXjxxdtf7mBneA+ZoCx3Qk2ils2c3Gmtd7JK2/8y1PhqISyIjmqUb0l8Ao9aRFSTQgXffz51FYWhJWMJz+57olOAnQlaSHD3C3hjnArLyv8dbwEMRbQySYC6UTyNmJ/FygftBN4dbTHDWyxv9kczXXxyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=kN1xF0Ki; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so35241125e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775840681; x=1776445481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwiYMaVMKT8Fwz2kEWGlUmPWE6NqEXYBCgqVBt+6tuk=;
        b=kN1xF0Ki1zxEaeq3GsJ96Of9q6f3jIAbgqw32hRHb7m/6iHqvC1japi1uoh+XN005c
         uDDjVbPnDoMg5x2nf3BY074J5MCUskGQXTPG/Vaus7TEIi//bbXVjI0gOX9Q79zRvbU3
         oiJtiM0THs7TYAw/OHjvG4KgrnkNkFDQ0WVaah00LqVFRs1/PUXuAvrs1CLTb1RS0mlu
         7Q/W5QeNofC4nkj695p3FpWa46+rBzrjAZr5UYN51hDCxYuxze+bWTGcWIY2Ygq2P8hq
         pBZ/a6QIMze/VyPGhQAHLt5keI5pD/koj1TBtsBDXhfhkwKCBRwUKVZJzLajEjGbC/3P
         JUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840681; x=1776445481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwiYMaVMKT8Fwz2kEWGlUmPWE6NqEXYBCgqVBt+6tuk=;
        b=evwnHxZdPvdrLl+OEOhQUznspEtQ5tJot4SPZC1+Dvx0nnekLC9CORysMy4c2wEw88
         qI8heCtBhNE35qJTSPURAITvJScP/m6qQnQiFQMX2WEittprciWc2emsHllK9ImTsCvb
         y17vd39CTMokNY+fqLl/8TkzV7AwZ5+ERa7Co4sxBMcLWeNja+lFsrKULfnoK2d6xAdw
         /BG23yvtQVp6IaAQtTtHlwA1AgeIMcUfbrPZOlQsU2J0mh0g7kUN+vCqqLQ1/6AX/zob
         Nbi5zXpyqylj8NmnJwwPhiNVqJudXDaMP4tdEyWkjq0KOwct2MnBVis6rg9vwID7Hutu
         +IRg==
X-Gm-Message-State: AOJu0YytD5/wGLFYgFYnlPNudTQs+cBU1kl71HDYKZt8r0l+VOYhibP7
	EIn9yKzLWRcFABsyKCUZJ6QsXRilAcN0XdgELbHblWRkuYJPyNItTLimyta1tKpl8WM=
X-Gm-Gg: AeBDieusXvw7n7nWdrgyEZK76jSU0uhPuRqNn4KbqB7sTLYk3Un5sg3/zhXPUlQ8CoH
	nbPR0Sh7CVaiFY7jDYhx1mZsylcelapKuYN/v2Q3FX+piwGdH+pu1gNc22gGOQ+bqzsJTHWvVYh
	/03GIv6leZqGabkMEAe9110apMXAw+uTeY0OvtuPKuoXyxdQoH3HOOPC7o5j3URj6ccIlMNkn4d
	MPj6SeXs9yW7VacEAu2nrRUHmZe0I36pG3VIev9Tk0o3yHz6rWEWCYtUIA5Gdwdy581P3A4xP3L
	/WSMFqBwogoObNJmDK6s7IX1zTt52/9FsnqD2LgQFwkb2txQkM7tkC4enBDzNCApGaKb0Onhln+
	lf0csAleDyf0//Qa/leVfdHHAXT9DMKK7X8Z4Cs8iPyeXxCcmxIAoiDtMWSiNLS+E2YCYZ4H1HN
	5KiZgr1D9/E/IN/C9Sq5eYH81Y8R+VF/c6bQ5C77JCrucGaVgY3V0Hl45/ILDB3LrJe0YDBdW0m
	KBKABSyu6MO
X-Received: by 2002:a05:6000:4026:b0:43c:fb6b:b7f with SMTP id ffacd0b85a97d-43d642b1a17mr5443052f8f.40.1775840680957;
        Fri, 10 Apr 2026 10:04:40 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm8847200f8f.25.2026.04.10.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:04:40 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v3 3/4] wifi: Rename EMLSR delay constants and add EMLMR helpers and definitions
Date: Fri, 10 Apr 2026 19:04:25 +0200
Message-ID: <20260410170429.343617-4-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410170429.343617-1-pmartin-gomez@freebox.fr>
References: <20260410170429.343617-1-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34627-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebox.fr:email,freebox.fr:mid]
X-Rspamd-Queue-Id: C1B7F3DADD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the final version of 802.11be-2024, Transition Delay and Padding
Delay subfield are for both EMLSR and EMLMR. Depending if the mode is
EMLSR or EMLMR, the interpretation of the encoded value might change.

Define all the constants and helpers to interpret delay subfields both
in EMLSR and EMLMR mode.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   2 +-
 include/linux/ieee80211-eht.h                 | 102 ++++++++++++++++--
 net/mac80211/eht.c                            |   6 +-
 6 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e3aec814aa0d..5a7a6377b2b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -114,10 +114,10 @@ static const u8 ext_capa_base[IWL_MLD_STA_EXT_CAPA_SIZE] = {
 };
 
 #define IWL_MLD_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
-				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+				 IEEE80211_EML_CAP_EML_PADDING_DELAY_32US << \
+					__bf_shf(IEEE80211_EML_CAP_EML_PADDING_DELAY) | \
 				 IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_64US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY))
+					__bf_shf(IEEE80211_EML_CAP_EML_TRANSITION_DELAY))
 #define IWL_MLD_CAPA_OPS (FIELD_PREP_CONST( \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
 			IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1ec9807e4827..214e6d10081b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -263,10 +263,10 @@ static const u8 tm_if_types_ext_capa_sta[] = {
  */
 
 #define IWL_MVM_EMLSR_CAPA	(IEEE80211_EML_CAP_EMLSR_SUPP | \
-				 IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_32US << \
-					__bf_shf(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY) | \
+				 IEEE80211_EML_CAP_EML_PADDING_DELAY_32US << \
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
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c52f9e11a8b2..1f624ea8cece 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5022,7 +5022,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_EMLSR_CAB) |
 		     le32_encode_bits(0, RTW89_H2C_JOININFO_W1_NSTR_EN) |
 		     le32_encode_bits(init_ps, RTW89_H2C_JOININFO_W1_INIT_PWR_STATE) |
-		     le32_encode_bits(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US,
+		     le32_encode_bits(IEEE80211_EML_CAP_EML_PADDING_DELAY_256US,
 				      RTW89_H2C_JOININFO_W1_EMLSR_PADDING) |
 		     le32_encode_bits(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US,
 				      RTW89_H2C_JOININFO_W1_EMLSR_TRANS_DELAY) |
diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 6324d888073b..e24f95db6087 100644
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
@@ -1114,14 +1122,20 @@ static inline bool ieee80211_tid_to_link_map_size_ok(const u8 *data, size_t len)
 
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
-	    pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
+	    pad_delay > IEEE80211_EML_CAP_EML_PADDING_DELAY_256US)
 		return 0;
 
 	return 32 * (1 << (pad_delay - 1));
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
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLMR_SUPPORT);
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
+	    pad_delay > IEEE80211_EML_CAP_EML_PADDING_DELAY_256US)
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
+		u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLMR_SUPPORT);
+
+	if (!emlmr_supp)
+		return 0;
+
+	/* IEEE Std 802.11be-2024 Table 9-417l—Encoding of the EMLMR
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
index 768bfc4e737d..e88f28edfd57 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -204,7 +204,7 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 			pad_delay = u8_get_bits(ptr[2],
 						IEEE80211_EML_EMLSR_PAD_DELAY);
 			if (pad_delay >
-			    IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
+			    IEEE80211_EML_CAP_EML_PADDING_DELAY_256US)
 				return;
 
 			trans_delay = u8_get_bits(ptr[2],
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


