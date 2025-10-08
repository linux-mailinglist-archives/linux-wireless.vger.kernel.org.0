Return-Path: <linux-wireless+bounces-27881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321FBC4637
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513B840104C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BA2F6168;
	Wed,  8 Oct 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRUEUgzi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB12F6162
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920137; cv=none; b=FIPJyKVa0P5hLGUH3QgBxspA+EH6bRXVW9C1xOGb2BTYm7iYRj3EZGdJ7+LuqCCL74p4IyUFEc4j3fOPS83luN3OI1inQDpihDbd/h0ba94gT6fHtYc/OrN+i6BxQD9LXEGgYdLiZC0h7JKL+h0wNGLuJMEo2VFmDsTqE+PURJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920137; c=relaxed/simple;
	bh=zCzqtx8PrsUZlytdxWSC6x4RVhvhP271Uny0qjitfKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OU/VWNr8jDVyIp70wuO2e5DGPh3Sz/qoZkRKCIOO6Lz7GRMBOA+XCefujoSjQyJ4xzcMAq/6IWkb81nnPut4gH/XEkxl/lyee1pp72Pf9HRkVBlKLTFbJyPTtTQYxCm3P/PROyEosl6wHdyTyMaQ9Wfv96IO58JPLln3ssZccj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRUEUgzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E9C4CEF4;
	Wed,  8 Oct 2025 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759920137;
	bh=zCzqtx8PrsUZlytdxWSC6x4RVhvhP271Uny0qjitfKY=;
	h=From:Subject:Date:To:Cc:From;
	b=eRUEUgzi0Dr5Y0l1F7iAybam94bhUKuISp8kWW/pJ3NCfJldHz7OKyJgMHN+kZkmO
	 /2dgjotT4IdRmz4P0gWmd39g5Daj16IfGkbHYHN62+HihzdVaxBdxOGUZKZtCSAskm
	 jJN8LrFXE/0n2eFLWxBn2Mg+9GgjJBHfyj6VlqgNFY32r5F/r6VW8aB4PtpxSCHfGG
	 6ftFh34BF09ifEcXSiZwoYav0mMkF1axA2ZKMxrvrH+O0UVJCyEeoDfU+TgFKE1+Un
	 DZKAmRZe9TepJIY2emlFi3a5aIuK88XtxWXSLyHSR9ZU/S5id37xcuqvsiIPj8JdNe
	 O4m9zpvBJnKng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/2] wifi: mt76: Some WED fixes
Date: Wed, 08 Oct 2025 12:41:47 +0200
Message-Id: <20251008-wed-fixes-v1-0-8f7678583385@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOs/5mgC/x3KQQqAIBBA0avIrBN0yIyuEi0ix5qNhUIF4t0bW
 j7+r1AoMxWYVIVMNxc+k8B2CrZjTTtpDmJAg84a4/VDQUd+qejYD6NHJLTOgfxXpj/IPi+tfdN
 plUdbAAAA
X-Change-ID: 20251007-wed-fixes-f468722e2155
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Daniel Pawlik <pawlik.dan@gmail.com>, 
 Matteo Croce <teknoraver@meta.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

- use GFP_DMA32 for page_pool buffer allocation
- fix wed crash on 6GHz band

---
Lorenzo Bianconi (1):
      wifi: mt76: wed: use proper wed reference in mt76 wed driver callabacks

Peter Chiu (1):
      wifi: mt76: use GFP_DMA32 for page_pool buffer allocation

 drivers/net/wireless/mediatek/mt76/mt76.h        | 12 +++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c |  1 +
 drivers/net/wireless/mediatek/mt76/wed.c         | 10 +++++-----
 include/linux/soc/mediatek/mtk_wed.h             |  1 +
 4 files changed, 18 insertions(+), 6 deletions(-)
---
base-commit: f4c70f6e7bdbffce882bed0fb8c78d135458a029
change-id: 20251007-wed-fixes-f468722e2155

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


