Return-Path: <linux-wireless+bounces-36143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEnBFg1eAGoGHgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 12:29:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1432C503A08
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3ADA300A7EF
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CFD3368B6;
	Sun, 10 May 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdtaF5g7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120272032D
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408970; cv=none; b=SafmwMf8Nb3gCwJHhny/OJg4+MtDflbs6RZZ1n7CccIEM1gfY1MEOXdwb5t8D0rpUjpVkYDBvUH3ee1ARLsneF4+mE80Vjl4hutneun0yjTIgys4Es51CfIzAr6HpTHUryWmgcbBtPbwI1/PhfZxppmfpgJQX+zNO5joUVQRZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408970; c=relaxed/simple;
	bh=xy2+CwIhydcVKMMoS8RkSqHdjchn7QoIRDu4IuwXbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5tlu1o76kZ9JgFRFfW44ifAKoZdmb9sNfwa2tUOC1TIIDfCaJzZssfcUuIg5066VmkWtbm5cCi6hgnbS8lSEH0oloEeQQzVhv1lq4qxAUtPIaA7kAt563rissU+MkO+KqD0AAgV/eSLbvcQhNVnySYIkSisBQ1VjhMGL03j6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdtaF5g7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393da8f389bso31787031fa.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778408966; x=1779013766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx8GM/RHj/cuBV12qSf4om3o67O47ImlKSvlgIRTtzM=;
        b=CdtaF5g7gIjKf7t7HopuVXBpy4R1EnDexyeHV3Q7yWsXlP7lrWy2ulAFr6qqRadxJG
         7TloH4h1ZPcvdItttXA1UxWJcfnVrJ0w8ysFu0GNMODa/HUohx4L6FNuYyOexwxc+KMD
         CJ2BOdnrBbmj3rFzv/N86TsSrLxp946y5IaecBWdPi8qXb+tS2OV2Ch7tShpyzcgMziZ
         YHnIcvYzcWSjfgJ/j+MZ+Bcl93GkTiURXZ91ztJFmj22apsNvmzFWu9t1/lXk9PYzqWA
         gGx2xMCi3r7bHkBPoC6tV6xWNZNyUHLXNOiduYyGQb4FxVtNglGpTVSewWMPt49x1se5
         Hlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778408966; x=1779013766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tx8GM/RHj/cuBV12qSf4om3o67O47ImlKSvlgIRTtzM=;
        b=pNiQt7wWr/qW2gwjzzWnfbZzz1AcyqVL1Lkd+BQn/PVypfjzmr0s0ziGHxPegmidnj
         Iigg5YbDxMPxjVfpWU5++iCG1pHLEVxp8T1PYJiRwqzXm1HgxZaGgwiInIqFsOHAiLvd
         CFMx/6o9NeGWGxyofvHtHKwCyVkhVUEvUBep46VoFrCyPdQTW6UZsFpDG2s9FYG8AkA8
         tjhDahiDoJrJUAuRo9Ehgr+JTl4jEoiyloV9jbeQ1PkwNV+Ib/U5vWLhHvVX0IyavKrS
         AlGdsKp1SUcjIzI4uVCxFsQa0USoLbV0JukbQ3FduU7YrWlOqfXwEl3yu3rWXjIOHrI8
         wJKA==
X-Gm-Message-State: AOJu0YzaNBdgtGZgZddVADRNHyQb4vOhMgVDdCHdvQSbbiPZg8OQ4URc
	Cw/UT0UmBF+vXOMBfLPo/yu9PzKf8p9gGaPqpDX1DPdL9r3S9lxdbcRY4dxGlOHh
X-Gm-Gg: Acq92OHP4wXpdYtZgaQ8bjoLKRICisEBwZRYV1lP6Ya/fAcTjpIrSNu4rOSAGIuK5/X
	quNiQaTA+plJdqKHCOPFsFsFlAvvDIwlO0zJOytzV0WvZSRlsdQlZl6h77ur+9kCpcptRyK9mvZ
	iG3CRil36pYIlEFMAf2Y6aZqEM2gyq1XX/xK5VDVJS5JsIiel70fCC1mvlt6okaqG1LLEKS6Kzd
	evbpTOgFvskZP9Ee8UK6lk1CtG8I6LYdv4Me1vl2WDWj0je9jnG1+EnP/2g0Ozmk0jS/3ihhc2L
	dqfX78bHtH/89sfSu+wuVcBxCBcjDJ2vDfOU7+D5A7ZmzAc+kodh8lSK2pcasuVdxyNRDUDdKgO
	jg/cDIukhidPyfQIfoWChMxvAh9ySdb9T2U2thriTFE5Xha+7ZSqbEUkrdT7/XRpR5R8z6dLQDw
	Tr1EV4p8cGZH8N2lbKmjVgACsG2tkdGQ==
X-Received: by 2002:a05:651c:41ca:b0:38a:27b1:4e60 with SMTP id 38308e7fff4ca-39408176999mr16248611fa.27.1778408966135;
        Sun, 10 May 2026 03:29:26 -0700 (PDT)
Received: from arch ([217.76.176.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db2f3sm17956511fa.22.2026.05.10.03.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 03:29:24 -0700 (PDT)
From: Dmitry Gomzyakov <nicerok11@gmail.com>
X-Google-Original-From: Dmitry Gomzyakov <kyoto1337@protonmail.com>
To: linux-wireless@vger.kernel.org
Cc: Dmitry Gomzyakov <nicerok11@gmail.com>
Subject: [PATCH 2/2] wifi: mt76: mt7996: always fill txwi for 802.3 packets
Date: Sun, 10 May 2026 15:29:11 +0500
Message-ID: <20260510102911.1883849-3-kyoto1337@protonmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510102911.1883849-1-kyoto1337@protonmail.com>
References: <20260510102911.1883849-1-kyoto1337@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1432C503A08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36143-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicerok11@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,protonmail.com:mid]
X-Rspamd-Action: no action

From: Dmitry Gomzyakov <nicerok11@gmail.com>

Commit 55218e636092 reverted host-driven TXD filling to rely on
Software Defined Offload (SDO). However, SDO cannot correctly parse
IPv4 packets modified by NAT (changed TTL and recalculated IP/TCP
checksums), leaving TXWI mostly zero-filled.

This causes the firmware to misinterpret or drop packets,
resulting in severe throughput degradation (30-40 Mbps limit on
WiFi IPv4 download through NAT).

Always fill TXWI via mt7996_mac_write_txwi() and always set
MT_CT_INFO_APPLY_TXD, matching the behavior of mt7915 and the
proprietary driver.

Fixes: 55218e636092 ("Revert \"wifi: mt76: mt7996: fill txd by host driver\"")
Signed-off-by: Dmitry Gomzyakov <nicerok11@gmail.com>
---
 mt7996/mac.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mt7996/mac.c b/mt7996/mac.c
index 7d454e21..a219b063 100644
--- a/mt7996/mac.c
+++ b/mt7996/mac.c
@@ -1093,10 +1093,9 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	memset(txwi_ptr, 0, MT_TXD_SIZE);
-	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
-	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-				      pid, qid, 0);
+	/* Always fill txwi for firmware to avoid incorrect header processing */
+	mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+			      pid, qid, 0);
 
 	/* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
 	 * req
@@ -1145,9 +1144,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->fw.nbuf = nbuf;
 
 		txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
-
-		if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-			txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+		/* Always apply TXD to ensure correct firmware processing */
+		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
 
 		if (!key)
 			txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
-- 
2.54.0


