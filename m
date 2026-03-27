Return-Path: <linux-wireless+bounces-34096-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MalA6nmxmnrPwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34096-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:20:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6834ADAB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73FC0314773E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49313914E6;
	Fri, 27 Mar 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="qpLMgDpa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C51391832
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642318; cv=none; b=UAp50xyECdoaGbUqRkOskt474/pRMA2AMhaBQBszy4zOmt8m6+ZFMgVhN4kk/Cqbp6HaTpufsmxghLESFVWJSH14tSwU3i9E6u3IwjcwZzqbtFmjm6Mki7gGSugSfFBECaI+syIFw4Ddc07Tc7Pegv+3rDnuGdvrGO6fH+oBwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642318; c=relaxed/simple;
	bh=kR9/g+4srNmON2WchDZ6dla1dVVp1KYnxOCF2cSRJHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oqx2BS2/CiL94lMRUY19AMuUgEedE9gr/FV48a9WEJi8Qatnm09DZ+Pt+gVaXnDA+CfyEFURyFk0Fn4O1mfTgqzU4NhfadihiyP7wzkD85GkhB529DfNFaA4k6UMs/yN3t8iGlEa8jlgfl3vD1gYuDC78HCp/UnyTFasHu8RHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=qpLMgDpa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so29985165e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774642315; x=1775247115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nju+mfhzV8pO+UWdlU5Z+vT6A6KgC7sAyFotg5T0ax4=;
        b=qpLMgDpauxGbosABZtB1Bgc0HGzRTQe93i9ZxgxvF/YWk3MHHZ+//paKn9cnx5uLy+
         H0OJcyZ2ri+AI5VF7Rad//9x6y4d5wI9iA6qJh3QSRbKWS6k+KjX9nAxlD4TfAHhfdLe
         dhP/YJY+gKijQMyUcgKk4jaKOXnduQGB4VMSwMnGzdLKFJAmLV1G7a4el59adKcQxA7h
         GUfGOWk+o2ftDWOUGnVUlRIzd4HV0uC9B2RaCxPkLWvnfVbAnBg0sZIglmmpM46wEsMr
         ZuySZ9bL4GtfZgrjEDtCczJlGha8F3ZlPcWk9ZR6EEmSV1P3cGQ3PqMBWhsICMBAkP88
         r2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642315; x=1775247115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nju+mfhzV8pO+UWdlU5Z+vT6A6KgC7sAyFotg5T0ax4=;
        b=gC9Vef+05L9oCJOpkwwrDyo/l7WmhrUGbBXWddY2vobeXgIcwL5ah52AorZnPr8vwU
         162Vu2jx1YzQaIx7ObcgHDM+aHccKJFwHJeI8O6xjAKAXhYC3gceqxo81bruXL5TCIqV
         tpQp3GJOVTywXpaUI+CDfNTD0gk0mdzn5KMSErXV3+2KQQNy0q944QWUuxYS8Z1z0xrS
         bEipH+Vl0KPEOsvYff+5bhXgIFWkAJaNpAgWv8dQz3Z/5gnWem/Zms3vFMLKaoxW0Bgg
         HEHjci/dDoXBe2cyfm3pn6DumfKBqgCbVuxZ0wlaK47ChesoYDT75blLsPFfGAL4DpKF
         T7NQ==
X-Gm-Message-State: AOJu0Yxs1kVyRztaI2y2UhCWf8l1rXvP5+BFNV7opZWnIDvmK9DR4Tfi
	+VO/IP9W91FH26R/PQTwNG8UkmM7PyvHheER0yjqiRyS9FwDIEGuIIUv39EjklnuGW4=
X-Gm-Gg: ATEYQzwAqHWUqX7XOw21MZFrEJREJjDJrgXesTPBCSq1PpJCVkRkCsFbIibzv5lazo+
	lly198TndT4sPDXiWoxOcj/qaWfLw73JUO+oqGT9AJUwQZRF0+tTxUoBjjiPkkY7LycA2SjbOP0
	UdNEtDjG9+tf2dTeZmuFQDMH/yYDqg0fwwHjFpBVQdX8pqKUibWPbEKfyp+gc63SZqIZWgiXQKb
	9EFtolkCMJwkccl8El0oTEWaaS1A7joRNc6HQ74+162lOmFPDfiL6CE25r8er2VKYDVJ41Or6XE
	GuV79HhTGc4gYkbhG6k1O5Fyi4Todqs7CBAFHFWChtV8yIxXFNZZZnEy/qqjI0/dAtxM0dV6au6
	28mB60KP87KPLe2rEgtNbbd6+mUrNa8pemqDoz4wMJClByodXTNtFom61/h2PDqPk0YeZrKTdUf
	ma2aQfor/+wKaKUYS+Tkky2+rfwXdy9llviXIMBGf5LVjw7ER71SHAss8Ygf+26779Z+SS8ByEW
	2c+K2h8E9Rx
X-Received: by 2002:a05:600c:a407:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-48727e8bd95mr54551075e9.11.1774642315484;
        Fri, 27 Mar 2026 13:11:55 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb5417sm35670035e9.3.2026.03.27.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:11:54 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH 1/3] wifi: Transition Timeout of 128TUs is not defined
Date: Fri, 27 Mar 2026 21:11:31 +0100
Message-ID: <20260327201135.905852-2-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34096-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:email,freebox.fr:mid,freebox-fr.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BC6834ADAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In Table 9-417m of 802.11be-2024, Transition Timeout is defined up
to value 10 for a Transition Timeout of 64TUs. The value 11 is reserved
and does not correspond to a Transition Timeout of 128TUs.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 2 +-
 include/linux/ieee80211-eht.h                  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 46c8d943fd55..756b3ca36105 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -220,7 +220,7 @@ static void iwl_mld_fill_mac_cmd_sta(struct iwl_mld *mld,
 				     IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
 
 		cmd->client.esr_transition_timeout =
-			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU,
+			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_64TU,
 			      esr_transition_timeout);
 		cmd->client.medium_sync_delay =
 			cpu_to_le16(vif->cfg.eml_med_sync_delay);
diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index a97b1d01f3ac..bbff10a05b48 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -517,7 +517,6 @@ struct ieee80211_multi_link_elem {
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_16TU		8
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_32TU		9
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_64TU		10
-#define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU		11
 
 #define IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS		0x000f
 #define IEEE80211_MLD_CAP_OP_SRS_SUPPORT		0x0010
@@ -1178,7 +1177,7 @@ static inline u32 ieee80211_eml_trans_timeout_in_us(u16 eml_cap)
 				  IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
 
 	/* invalid values also just use 0 */
-	if (!timeout || timeout > IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU)
+	if (!timeout || timeout > IEEE80211_EML_CAP_TRANSITION_TIMEOUT_64TU)
 		return 0;
 
 	return 128 * (1 << (timeout - 1));
-- 
2.43.0


