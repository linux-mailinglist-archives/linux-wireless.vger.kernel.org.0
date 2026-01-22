Return-Path: <linux-wireless+bounces-31068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IveGEgCcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:56:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E429A65928
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84FF7828355
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269A40FDB8;
	Thu, 22 Jan 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIFQJRF1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4460740FDA0
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078424; cv=none; b=nTOvj8n/plDFE6c6hf2GgoGM44EOOfCnF3UQUc0ZiWrgaw07+6q1vqNRomGDFn5VeBDxlKOV1sWwAFGyepprhuulBYHW7Beef0+RdKzK27QzsCXvu/iLySEMJVyCHMh9Gx44WIjWSP6suMJd2MOwu4UvgwgUElXMuy2FlucJiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078424; c=relaxed/simple;
	bh=C1Q2M20w5iprpmF2hd7cvREVmh5k4IY7m3ETKgzcQ6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/O5dxAgWGJQ46T3PnfC88wsUCVXQ43Y3uE/1VNbsDB/GwIrrRHSlsQBUCrhKkWI2Us0swXu2NdGRc4Er7KSg1iT/Ktk+GBjiFlmJWND3gtyzJQi8/tBPpASn1hisdEFvoDLGiUXhQ+DbpKhwtA+LvalhYvkgcqK2QPlLOydqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIFQJRF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6024EC19423;
	Thu, 22 Jan 2026 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078423;
	bh=C1Q2M20w5iprpmF2hd7cvREVmh5k4IY7m3ETKgzcQ6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sIFQJRF1fVhLCnTsnH5+gxMNoBlQg2KtUYZsZ3Veviw0CzTXjPujVDSz9iUIknGdS
	 1bRHorfphYnNHB8awi2+hVzxleOaRQ7pm939zalOUzH4QKqjfywX7vpUH2STXRNuMY
	 mUiBNMzZ5F1JwDU8EAd9ovomoCvJvGGcXZVDxgHuldoslOrz7FCgTIOyrNrGhVKr9P
	 TIiaAvlrbyMv9cN1h3nPKJegQP0++/m1gFiec/rHkf1P7J6vWXWNQrzW1/df6M956N
	 SHeH+LCVP5bhhKLypHTGOzCXnv/2WFlVR90yYDEK2l3tnI3ZXR124sxLTOHeTtkDBW
	 wlGuQhzNPx9IA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:51 +0100
Subject: [PATCH mt76 v2 07/17] wifi: mt76: mt7996: Rename
 mt7996_npu_rxd_init() in mt7992_npu_rxd_init()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-7-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31068-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: E429A65928
X-Rspamd-Action: no action

This is a preliminary patch to enable NPU offload for MT7996 (Eagle)
chipset.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index d79f8dfbd7faa7695ea54b632ac86063fa8ffe3a..a9569278f73bf83454a0357e93602837c6ccaa86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -122,7 +122,7 @@ static int mt7996_npu_offload_init(struct mt7996_dev *dev,
 	return 0;
 }
 
-static int mt7996_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
+static int mt7992_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 {
 	u32 val;
 	int err;
@@ -304,7 +304,7 @@ int mt7996_npu_hw_init(struct mt7996_dev *dev)
 	if (err)
 		goto unlock;
 
-	err = mt7996_npu_rxd_init(dev, npu);
+	err = mt7992_npu_rxd_init(dev, npu);
 	if (err)
 		goto unlock;
 

-- 
2.52.0


