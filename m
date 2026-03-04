Return-Path: <linux-wireless+bounces-32484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BqDILPFqGlaxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 242BA20927A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1552A3024168
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401735F5EE;
	Wed,  4 Mar 2026 23:50:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410035E939
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668249; cv=none; b=DHwZ92zvB66nUOqFPPBWq5PdBTE9wFcLxY0u+7jU2X2RCX20ZT4TCh3/WdwE2E+VBItrzpmlm8r6xPn/zHt/gsApyYvSVirI3l+neuAGG5x0MPzZ20AyxSvDDpR35LiYPLBPXwQDLnPiC9tRu6+l2cSHdwdqG0tqbyCRMa1pRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668249; c=relaxed/simple;
	bh=iKM01090q2qtreUR1j4aVFgzdOYE6eDBF2Rh9wOorEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF4w/wjHgFyXA/JqMPhK5ZfuKa60L0REUcc5I06BjtD7XBN2I9TvG7ae9WoMHHgHY/siASXc3uY/Cjkr7+iru36o1sICV6Si2x8PJnmfIwBCON05GK62B52SfxHHf1b7gC1jj9kwNu0fZ4ZObjY9r9bwog30qRvrxC3eCa31Wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4c307db9aso4735011a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668247; x=1773273047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Ifn8MRmL2Rzzn2OVQLCOQAsiMkzCVLXoTf/UR06PTs=;
        b=XtU4EMS7PPVr7p58InmGsHO/vn3NKz4NldiyaubqKNxBNxPSJ1gyl+yvIahC8W8TAn
         xUjShuXr9HlNvFK04RNkeqYPkmICwxkL9ZHAv2FGpe7g5AEscgj8TkJ5dGKbUd+t4g67
         NNRa1DBOWJnixKuCGTm8EcOXoMg/upwHIWuK1kslyzBjUE38KZiUasiDy5Kbst0/9IlJ
         DJjG9ywTABpqth13G8XOUexkiS1gMvJKA9IKFZt44i0RYlIqwZpXN9+NzmLPLQ6x/I5r
         MyUzvTYDh84vtnqE6oQLviGZDD4TMEd0jjCga5r/qgom/oLvWSD2owHauBfSfbMRWqyv
         AVEw==
X-Gm-Message-State: AOJu0YzRGwVg44rtAymE1G0VG16lWXwUzHjUyVs8ZCT0LgdFFLX8358/
	Xl3yx/6veIAxiJqs/D+yK6uMtnwChuba8DIJY+9Uk6IK8ZNTgSXfx3K+
X-Gm-Gg: ATEYQzyG2F36TQb5RUBXnrKYbktki04klCbPUJ8h98Di2lWggeINfRcooIG+saaaSIq
	MJdFkGiKtV71aGw9NOa5gKEMp1hqGMefAGV1548AOfDBcANREUNHrucoz2fZgd3UPK40RgtZGmq
	otoDEBShAIf6LUldFIcZse9cv0GQ/mkNMiH6Cuda0B+UTFZmZy8EmX+eAOCSi0f3y084LCx45tW
	NSBqLuT2mInMaVH626lm2vgQ2q1Hwe/l5TLLB7d08LUK4p5j6/J1Pdzt0w1tmbWYOMk+WGFviAx
	z1VzmgDrUjjDzsWesecNRv8Lx7D20ecK9zLdbwd7NuDvzbK87r0o362e+HYbre72eSjtYg1MvGJ
	QYvIdIvYR2RxyQ54EE761LczZkOnFBj6dezEFIr/KVycOTZaZQBrTLo5Ied9KFjhoopuve+AjJ9
	OenTow2958UTPi4mlwwH5vFgGMIBrsORT11LV+U8QMA49Fai8=
X-Received: by 2002:a05:6820:488b:b0:67a:2305:5e4e with SMTP id 006d021491bc7-67b176f8840mr1723687eaf.17.1772668246921;
        Wed, 04 Mar 2026 15:50:46 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm14410687eaf.7.2026.03.04.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:50:46 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	yu-ching.liu@mediatek.com,
	yuchi.wang@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/7] wifi: mt76: mt7925: guard against NULL chandef in BSS RLM TLV
Date: Wed,  4 Mar 2026 17:50:15 -0600
Message-ID: <20260304235020.40451-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304235020.40451-1-sean.wang@kernel.org>
References: <20260304235020.40451-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 242BA20927A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32484-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

mt7925_mcu_bss_rlm_tlv() dereferences chandef->chan without verifying
that chandef and chandef->chan are present.

While current callers normally provide a valid chandef, future call
paths or partially configured interfaces may result in missing channel
information and lead to a NULL pointer dereference.

Add a defensive check and bail out early when channel information is
not available. This does not change behaviour for normal operation.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1379bf6a26b5..e050c2795cb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2291,11 +2291,18 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
 {
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
 						  &link_conf->chanreq.oper;
-	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
-	enum nl80211_band band = chandef->chan->band;
 	struct bss_rlm_tlv *req;
+	enum nl80211_band band;
+	int freq1, freq2;
 	struct tlv *tlv;
 
+	if (WARN_ON_ONCE(!chandef || !chandef->chan))
+		return;
+
+	freq1 = chandef->center_freq1;
+	freq2 = chandef->center_freq2;
+	band = chandef->chan->band;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*req));
 	req = (struct bss_rlm_tlv *)tlv;
 	req->control_channel = chandef->chan->hw_value;
-- 
2.43.0


