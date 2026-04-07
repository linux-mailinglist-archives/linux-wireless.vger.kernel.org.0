Return-Path: <linux-wireless+bounces-34432-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAeBCbOY1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34432-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:40:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC43AA027
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC63305E310
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB9238C1A;
	Tue,  7 Apr 2026 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDDfLNVt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF523EABC
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540351; cv=none; b=PbiKFfdK4GL2uR/Yg7fDHtgSBANBpoEuLTCEh7iSweZJbjCTMotjAYLApEffX/ZQgW0h97NZLTVdKrgs+gTEldVYD5LhhOlFouFmLSGYNKYLYokZlpsGgQV2duNQTBv+CbU+Iq5pTxPNEojbMs3PkJFNqOH/T6ml3ulcfPDGThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540351; c=relaxed/simple;
	bh=uoCTypa9PxCD3+/Y3yVtl2HrvV2hrgDNN8Do9TgBeyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poPImD3dBeKBgpF1gp9Fv84NtX60Ip3w91eBh2WBbX5NTHJ5MfsNgDqhzRN7aTIxqplg3Nie8NakHYs7Vt82f30soE9TXjF0nlXZ8L48N3PZosKFq6BjvfywfpyiMA/Ke+AG+Ehk/aTR+dOJ0Ioa7badBXl00Y31C/OE3QvheQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDDfLNVt; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79ee5037d44so62193507b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540349; x=1776145149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgqqoYUdUqAVnlXiVxrrYZRPdWxQLwzdIl5g7t/74/8=;
        b=YDDfLNVtTfgICJpEeDbqFymZZDpto+2HINYbugP8zZTknDNUMn0lNCBzOva3m05Faw
         DtuaJaDtJyjbicgd/T3ZXVDTPqMwboL9CeR0XKIfpVyyrJCdMi/E5hd4BZS51Q9DTL66
         uR6A7ikNv20jJ1mA5FN9liTH5nksyXaX6g+qM87S/UgJd0INJpV9mxdmrGVcckTEt9gc
         uv9l2VLR/cEITgblhXU3+xecXBiV1mez9HHwWo2bLo1OTW4BqELl8C9K5voz128wlxUl
         JVxdHnVgcw9cN0kTSY6ODF+z5gMKoYTTqyHqzNVVzAxAt0/R57kqXOtQIXCLYWr5dbjw
         /EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540349; x=1776145149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgqqoYUdUqAVnlXiVxrrYZRPdWxQLwzdIl5g7t/74/8=;
        b=rDxsKxzBI+y4OeZtyTBFKZkyIP4DIzQoyRLdQB5SgxhFZAnwDhjMNk2Vpy2KYKdwPe
         ea3YLmraRLzciNnrGXm3Iarrxuk9ymc4KkbjcN9DTFYAbMzPgU3QkUNSAZMxeFI+JlgG
         Q9ZNV23b4MrMUzr9SFGzkg3FAjHkIlp/6F+9g+0aT1ew0AfiqwiXTFuvDwekS9F3jdPu
         wOoRos8+ufwyzHvwURT/IJSldnv2eM546Cr3YuY3YnX0ng1bHMGO282A3PXPGnaz5Vmh
         TF1i6kj9DBcq1Q9oc6upjH5NYPzN5kyjOzRREUkbR7gx29vNDfRFPHnSE0IUMnlpc3Tm
         j4Nw==
X-Gm-Message-State: AOJu0YzfLpSl5ToqqTqlWigz+tyfEalr7WHNrDOJDHz5T7m3OOGuJRl/
	jVkYDHcg6f0E3zc33hqxn9cBxAeA7qF3CBQ1aRGnoU3QQNGzdXCiML5RecGi9lAi
X-Gm-Gg: AeBDieuBxHyyvfeE2KLatOPH702mif+mJoDX72061zOnKkVetzCLBihgQgZWOVLLnAL
	HXJ8Hs+OyvA0Ug/ZtFP+7CwNYjQN6qtuRONlE0LtqOIXHPtM5Rco6OY/KU0spmV5ozZUsEyEIHa
	54YWhLMA20j3v/6G0JkLJcR2UvpM5YHlg1pYiYcbi8IRg/EjnwkTa8C/YHnZraUiRJyZT65fHbu
	81IN+tAQznOJZtEd9AtlNEy5Zxo7yGXKUJODPEM7HJRAeTT8WnsKbGEkpiIgmyZ4rLDP8CBb29l
	DKpfFa3jElWShtr+xSvqiB1r9aNIqVGCbMmB9JpQU29yQ8wtVjU5gLVwnQOMI4zb9ovL2pX/bJW
	SIAfmO/0/mtD+smx0tIpci0RVQbNVcWy8FsdDv1LiiqwWX4LafeihrJhjdON6QJE8YKJIYH6H9z
	OhZjHkZmBgMzOoHiE980ehjftAe7yPixehgaCVTHbTBp7ylmu24bGEIaASkPHT
X-Received: by 2002:a05:690c:4903:b0:7a2:46b8:3858 with SMTP id 00721157ae682-7a3be360aaamr142535067b3.24.1775540349026;
        Mon, 06 Apr 2026 22:39:09 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm62717857b3.40.2026.04.06.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:08 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 1/2] wifi: mt76: mt7915: validate WCID index before WTBL lookup
Date: Tue,  7 Apr 2026 01:39:02 -0400
Message-ID: <20260407053903.75861-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407053903.75861-1-joshuaklinesmith@gmail.com>
References: <20260407053903.75861-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34432-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93EC43AA027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mt7915 driver does not validate WCID indices extracted from
hardware TX free events and TX status reports before using them
for WTBL MMIO register accesses. The hardware WCID field is 10
bits wide (max 1023) but actual WTBL capacity is only 288
(MT7915) or 544 (MT7916). An out-of-range index causes
mt7915_mac_wtbl_lmac_addr() to compute an invalid MMIO address,
leading to a kernel data abort:

  Unable to handle kernel paging request at virtual address
  ffffff88d5ab0010

The mt7615, mt7921, and mt7925 drivers already validate WCID
indices against their WTBL size before use. Add the same bounds
checks in mt7915_mac_tx_free() and mt7915_mac_add_txs().

Additionally, when a WCID pair lookup in the TX free path
resolves to a valid WCID that is not a station (wcid_to_sta()
returns NULL), or the WCID index is out of range, clear both
wcid and sta so that subsequent non-pair MSDU entries do not
attribute TX statistics or pass a stale station pointer to
mt76_connac2_txwi_free().

Fixes: c17780e7b21e ("mt76: mt7915: add txfree event v3")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2f307c4caff1..19435f3c6fa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -913,10 +913,19 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			if (idx >= mt7915_wtbl_size(dev)) {
+				wcid = NULL;
+				sta = NULL;
+				continue;
+			}
+
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
-			if (!sta)
+			if (!sta) {
+				wcid = NULL;
+				sta = NULL;
 				continue;
+			}
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
 			mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
@@ -1004,6 +1013,9 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	u8 pid;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	if (wcidx >= mt7915_wtbl_size(dev))
+		return;
+
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
 	if (pid < MT_PACKET_ID_WED)
-- 
2.43.0


