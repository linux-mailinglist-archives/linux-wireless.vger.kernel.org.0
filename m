Return-Path: <linux-wireless+bounces-29262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C00B1C7E135
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 14:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C662341510
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB07224245;
	Sun, 23 Nov 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLeyOcOW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CE120ADF8
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763903452; cv=none; b=IAP1CxvIMroHZcJ8gSsY1hzwv97c6MaHUJYgSCItlEcEhxi07mUlwfZGmuQPEMNYeBbnacn1LRDOeTPERase25kpRb41x6ssp2WSlE4aQDg8BdcqpJpUYeLwmAa099Y+e0484TCSNWk5VeSAPpI5BAYxq+8eXQTYB9iuf0Jc3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763903452; c=relaxed/simple;
	bh=tCzm5CbDo44gclV/TPOEMHiNBz2jMCaxD/51uIQiEW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A+ACJAoT464UfHbYymlLpnBTdYmjnzWo9ELaRX+2hlQ4/zNwdf2kRIdQNEo9PLUZIV70kKv7IgMRGAwaR+cGY64BOGN/Syk+93NXWhgLkM4CXpArWK9R3s44SPvFoioV3nfjwuJPnSDB/qYeAp6v2kjk7IJYyWvrLU3/4pVNGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLeyOcOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32731C113D0;
	Sun, 23 Nov 2025 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763903452;
	bh=tCzm5CbDo44gclV/TPOEMHiNBz2jMCaxD/51uIQiEW0=;
	h=From:Date:Subject:To:Cc:From;
	b=GLeyOcOWF0ZHq3xl+eCV/n05OIndaqtkPT2r1BcrCQO//I8pF4m9Fo1ZHXZ6XYr0i
	 69Idg6APhyYjty9vA4G7Pi/rssut9SU7ptbCDVZkogC/yIy7UoBFQJwg6SxoogH3vN
	 CFa59vABmbEqf3ziqH9htlJk/dt7vv/RExayhWJY+Pz4c9Bga0prrrLufEy5J5W6NM
	 ImLznhygM1+4H1+HiLPbenkoXyzc/OpRTgz9mrUpxrekbMAN4+OaDHc1OkESjuUWw+
	 45BGNBsrvP5akGjuZ41iTlqQP8RHwjokbSsoJoM41GKlQFF8/FhHg50u/V03M7/3Aq
	 WlEXU6i90IrOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 23 Nov 2025 14:10:16 +0100
Subject: [PATCH mt76] wifi: mt76: dma: Initialize return value in Q_READ()
 for NPU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-mt76-npu-fix-warning-v1-1-455856b1e99d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23EIaKfQr0UF0qz20hfaC8N+Tj
 sMw80KiyJSgr16IdHHiTQqougK/OJkJORQG3ehOKd3ieliDsp848YO3i8Iyo3MmBO+J7OShpHu
 kov/tMOb8AXrg4wxmAAAA
X-Change-ID: 20251123-mt76-npu-fix-warning-aa6ddccee7fc
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel test robot <lkp@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Even if this is just a theoretical issue since NPU queues are
initialized just if npu pointer is not NULL, fix the sparse warning
initializing return value in Q_READ macro if CONFIG_MT76_NPU is enabled.

Fixes: 62f1347fa5bf6 ("wifi: mt76: Introduce the NPU generic layer")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511231550.NHSRTxxd-lkp@intel.com/
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 4fd779e1aa0f8f9c7a465b948e8bcce5f52711cf..4a63de6c5bf5a34cb76f10a427649bc04ebe78b2 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -74,7 +74,7 @@
 
 #define Q_READ(_q, _field) ({						\
 	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
-	u32 _val;							\
+	u32 _val = 0;							\
 	if ((_q)->flags & MT_QFLAG_NPU) {				\
 		struct airoha_npu *npu;					\
 									\

---
base-commit: e1ed98b1836e2bf0aba98f9790be4f3c6bca9d0d
change-id: 20251123-mt76-npu-fix-warning-aa6ddccee7fc

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


