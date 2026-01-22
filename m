Return-Path: <linux-wireless+bounces-31066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMBAGXwCcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:57:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD586594E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D94B44B7E9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5813F23B5;
	Thu, 22 Jan 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnmmjHfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26A40F8CE
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078419; cv=none; b=JLo32xsln1p7CksrUrAUuZ3MhnssPNeOcE9iY7slF6zlcWwbX44GKdy3BJ372e/1kcDsSDsal4sJmo+H7TgXfBEX4GAWmAhm9hys9z7zXCTdvyXUJXsGmEYRCo1jzTYxoBgFvDMJzjZslb/SFgrs7/nXHCpXesVHlD+nrBQZ0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078419; c=relaxed/simple;
	bh=0+Uz7U0K2hAVNFxVHZqznnMry9ZhYLXUD0TV1aT9XQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hv6hZvDhv6pSOtb9i7yDBY/0H5GzFoGtdcneKpUMRee7qhgKJSvtLM5A5VOE2HOwDYqvZlnv/DcC5U02zXGDVO/VH4itiTZ9+z3cbSFe1XBysL2Y8/OaRlTbPybsGTZdHMBCa6qYbssDBdGRLPKHttlav9sGRn/JQvSHQC36occ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnmmjHfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63304C19423;
	Thu, 22 Jan 2026 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078418;
	bh=0+Uz7U0K2hAVNFxVHZqznnMry9ZhYLXUD0TV1aT9XQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YnmmjHfmcgQkM/2XkMRxUoHmYESTfT7qhstYh0nzkLp03Alqci7O23+Z4XkFjNiXr
	 R95utEE05/ZouqIi1koR5W17LX4nyxSK8oBQ3PsGG6+dZzkYX1Sa25tSRBfcl+A9Lt
	 vE+0TXtz1uhvgdIUznBXt7EffdaNE5o0BdIlzsTqZmj7s4yDS+g+Z0xh4u5/otQKE2
	 9xOALLNhHxrtep/4qtqlzy2tyBRYQPodghqE301A7dkI4qrnGhXq+afX3wnGUQoP7Z
	 VCVf6GGlAOHz01fRZY3y/sy8Pt2ZISe8EoocPprJcSRUzejdt0XGBhxyfylK0gWUxx
	 FcoH3jaFVmzaQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:49 +0100
Subject: [PATCH mt76 v2 05/17] wifi: mt76: mt7996: Fix wdma_idx for MT7996
 device if NPU is enabled
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-5-2374614c0de6@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31066-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AD586594E
X-Rspamd-Action: no action

This is a preliminary patch to enable NPU offload for MT7996 (Eagle)
chipset.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 78151197feccb0197e44f3f73c0f01c4589314ae..3aa0a7bf830550a05c6f5925014c7c34e0e99f78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2237,6 +2237,10 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 		path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	else
 #endif
+	if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76) &&
+	    msta_link->wcid.phy_idx == MT_BAND2)
+		path->mtk_wdma.wdma_idx = 1;
+	else
 		path->mtk_wdma.wdma_idx = link->mt76.band_idx;
 	path->mtk_wdma.bss = link->mt76.idx;
 	path->mtk_wdma.queue = 0;

-- 
2.52.0


