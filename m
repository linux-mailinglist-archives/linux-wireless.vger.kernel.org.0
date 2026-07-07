Return-Path: <linux-wireless+bounces-38719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qXLUOj9qTGq8kAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:53:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4E716E82
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:53:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nfmqnGTQ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38719-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38719-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2454A300B084
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 02:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51937D114;
	Tue,  7 Jul 2026 02:53:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DD37F8C0
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 02:53:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392827; cv=none; b=TEWhZccC5bfoRP+kxPrgWdcxtqRfguePoi5gcvr7ZBLcFEEgcfw9MWPa5H2lcAqN4Px4OyA85TFNjv4e6QfYtn68HZ+Sk1zVczRILPTPQUSoFKONtVLzZQGV9aV+jMcRuYSEEn6lBSi5ufLoGC88/ECe1w2EBqIxJSO8GsMWnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392827; c=relaxed/simple;
	bh=K26KlvCFcp07s8mYWC/JER2242BAzVb71I3EH4YLOjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPe6JEPydtxwJQVDh08dRuQ5Y87vXS2Yj2ljrIDeQqCG8EaOuL06QEKtU4+yDusrxC3wVjiYkaEBVyQu4u53E/P6dejq9RV/5GDooHPPvSEfefrWIzH7mMEeapuf8asVxGnxJltg+4TLmewHvNCJuOyLo9j6Rd8H5IQBPjvxMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfmqnGTQ; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so1950857a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392826; x=1783997626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ST/Uil0tH+wktXYJ7vHGzi8suUAjvLOt6xpdMgK1B2U=;
        b=nfmqnGTQTve0Hrc/5d/wRkFKgJaTahgTQYGigEZtTDbjacTKq+HeDA3cYedtgm42JA
         83h+qjcSOodTMiywJXz122KwTSwuM5VF9zSqK7IgBj5GRlqWd/F+eC0O3ebgMYJZfAzy
         +V3jUYRFf+I60OFSdmbDG8W28kpZvsLCi0Oz/rcPr35nLUpRAx7+mjEL2hlRh/LDLpcm
         Vxb24m1hAWb18SYbyIwYWQi4R/KQjNMBh/Ey2lZpuEM/q7WOlj9SNhJ7ipvWbY2GZoOk
         8zuR+siwb78mjpL0Jbz3J2BocMFpLoUzO+g6naOrLoVGz5yB/OiML+0FVStCiZXQkLx+
         KpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392826; x=1783997626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ST/Uil0tH+wktXYJ7vHGzi8suUAjvLOt6xpdMgK1B2U=;
        b=pqvOTOH537mBsgA9hKkAnGBwS/7pmy/DxCsPRywh36qOXgnHnc/Qn0y8OrBMgN2a2I
         eb2+Xsa64z0VHajkz6Rim3d1EFAeMJQ1y0xWiB+zh2qGLnv+E0XO72V8Gk+jZzfAcwX+
         Nt7tDFX+bCyDhSOiUmyPMwpzVBtKyyhr7uWxc+p/7yhrHyaf9T7UO1GVvHwh0ifmvIv4
         eU2xhxmg/rFqthcyfn5dmW/aqBR+2DNWLkaOgBaa+cpMOF9f+al4RjIQBuLAsrFKIaBP
         o8f7HVT0ZK7DPE7t2hY5gtatPFPnli81xjvpmmP4uV3fZzDGCEdgsuXJ6t2dLVMSyai5
         Wyjg==
X-Gm-Message-State: AOJu0YwLK0M5XXDSqV9tGC2SuRhinw7TAGMLVgAOohG8zgXcdM2DSTgG
	W3CDurY0YD5IaHUbBPG+pwfuBGS3wK3F/MQuOzMDhWc9ip1tbwBKp5HQ/EEPHwq/TnXxGg==
X-Gm-Gg: AfdE7cmLN4ygmL8GLD26uOowJLZLLdeXIDZ8hrBVfXoNgDAdUlS/HSEDxNfEbvJqaw9
	I6DNEpzCWq6VJ2TW2nTqsnFN0u6Am3LHkzCmDPhGUpJ8803e97TnR2ShNI72vd+mhAJzDlo7xeg
	Luk95lPglOujJFUOa/Cw1qSYFsUSWI1q0nlqpzjeOZXHQVNH/kfz9E5gzyenrNvg8uwmF/SnwF7
	qVq/if8BfbZ60HoK3SfbVUfURwF9L4wQwuSweoeuCPcR4hUQ8N89BiPlAHMdET2U+cOLfAot6Wf
	tciiiNuCEqZsr3N8/rh/ApfNhT1oXMPQvUqMvoqMrleNnRYli0qF8cywU+G1l5hu0ogPVz5GlV2
	/TXBU3n/6MJu3WUdTWwurnm5xNHKoGiDZp/YAkom2/jbBXYM9WM5HVL2Zx8r4lIbegA9ZfEXi8r
	9rAoFqmwQKaricA7SC0wF/lGnBJuRS63l0eNoco+qQu0tQLHq4EQ==
X-Received: by 2002:a05:6a21:4c0e:b0:3b2:a8cd:ef4a with SMTP id adf61e73a8af0-3c08ee36470mr4075132637.30.1783392825534;
        Mon, 06 Jul 2026 19:53:45 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([2407:cdc0:606d:ba36:a6c6:36ae:a290:5cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f598dsm2755235eec.6.2026.07.06.19.53.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 19:53:45 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: cfg80211: validate assoc response length before status and IE access
Date: Tue,  7 Jul 2026 10:53:35 +0800
Message-ID: <20260707025336.22557-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260707025336.22557-1-enderaoelyther@gmail.com>
References: <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
 <20260707025336.22557-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38719-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECC4E716E82

cfg80211_rx_assoc_resp() initialises the status and response-IE fields
of cfg80211_connect_resp_params from the management frame before
proving that the frame is long enough for those offsets. S1G and
regular association responses also have different IE offsets, but the
S1G path only patched resp_ie after the unsafe initialiser had already
run.

Defer resp_ie, resp_ie_len, and status to after the link-iteration
loop. Use a bool to remember whether the frame is S1G, then validate
the appropriate minimum length and set all three fields in a single
if/else block. Funnel short-frame and SME-reject cleanup through a
shared free_bss label for the abandon paths.

Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
v2: No change.

 net/wireless/mlme.c | 56 ++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index a0f7b08bfcc9c..097b66f758ba2 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -32,14 +32,10 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 		.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED,
 		.req_ie = data->req_ies,
 		.req_ie_len = data->req_ies_len,
-		.resp_ie = mgmt->u.assoc_resp.variable,
-		.resp_ie_len = data->len -
-			       offsetof(struct ieee80211_mgmt,
-					u.assoc_resp.variable),
-		.status = le16_to_cpu(mgmt->u.assoc_resp.status_code),
 		.ap_mld_addr = data->ap_mld_addr,
 	};
 	unsigned int link_id;
+	bool is_s1g = false;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
 		cr.links[link_id].status = data->links[link_id].status;
@@ -60,16 +56,32 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 
 		if (cr.links[link_id].bss->channel->band == NL80211_BAND_S1GHZ) {
 			WARN_ON(link_id);
-			cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
-			cr.resp_ie_len = data->len -
-					 offsetof(struct ieee80211_mgmt,
-						  u.s1g_assoc_resp.variable);
+			is_s1g = true;
 		}
 
 		if (cr.ap_mld_addr)
 			cr.valid_links |= BIT(link_id);
 	}
 
+	if (is_s1g) {
+		if (data->len < offsetof(struct ieee80211_mgmt,
+					 u.s1g_assoc_resp.variable))
+			goto free_bss;
+		cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
+		cr.resp_ie_len = data->len -
+				 offsetof(struct ieee80211_mgmt,
+					  u.s1g_assoc_resp.variable);
+	} else {
+		if (data->len < offsetof(struct ieee80211_mgmt,
+					 u.assoc_resp.variable))
+			goto free_bss;
+		cr.resp_ie = mgmt->u.assoc_resp.variable;
+		cr.resp_ie_len = data->len -
+				 offsetof(struct ieee80211_mgmt,
+					  u.assoc_resp.variable);
+	}
+	cr.status = le16_to_cpu(mgmt->u.assoc_resp.status_code);
+
 	trace_cfg80211_send_rx_assoc(dev, data);
 
 	/*
@@ -78,22 +90,24 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 	 * and got a reject -- we only try again with an assoc
 	 * frame instead of reassoc.
 	 */
-	if (cfg80211_sme_rx_assoc_resp(wdev, cr.status)) {
-		for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
-			struct cfg80211_bss *bss = data->links[link_id].bss;
-
-			if (!bss)
-				continue;
-
-			cfg80211_unhold_bss(bss_from_pub(bss));
-			cfg80211_put_bss(wiphy, bss);
-		}
-		return;
-	}
+	if (cfg80211_sme_rx_assoc_resp(wdev, cr.status))
+		goto free_bss;
 
 	nl80211_send_rx_assoc(rdev, dev, data);
 	/* update current_bss etc., consumes the bss reference */
 	__cfg80211_connect_result(dev, &cr, cr.status == WLAN_STATUS_SUCCESS);
+	return;
+
+free_bss:
+	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+		struct cfg80211_bss *bss = data->links[link_id].bss;
+
+		if (!bss)
+			continue;
+
+		cfg80211_unhold_bss(bss_from_pub(bss));
+		cfg80211_put_bss(wiphy, bss);
+	}
 }
 EXPORT_SYMBOL(cfg80211_rx_assoc_resp);
 
-- 
2.50.1 (Apple Git-155)

