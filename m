Return-Path: <linux-wireless+bounces-28984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F89C5D535
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 092C14E352F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38621C16E;
	Fri, 14 Nov 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk+qqsFI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670301CDFD5
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126194; cv=none; b=DpLKlZrFGH8DUIItLgGhNJWtLnPpZoYYfq6vwx+qb12qZA0LUtRlHZZqELGHm42WzFdETtDeEt9CElX220nD9Z4OayUldBbgB3mMy4muKMEhx/LUYWbp6cw6RAyiYhBVIMWMCLmaDrcrJBo7KJo8KEb0knDG1kVDSLyhLONNHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126194; c=relaxed/simple;
	bh=CLK/yWeDsqVN1DIRZoE5Vml27ZShImehp87AK62LvAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EHsb58DOZe7c4NABLZO4tz/I/VX1l7MKHkiqgb9rdZ7RH9yaZn3hQWyz5tsyVofUA1VMWAAHwewtU1Jsjr56ONnbTIB8/e4LWTZi2jqWSj+x0GO0EQGCKZDXLaju/DVFEr2Yc9D620xK/rUMDogBf8MDMiHETu6BL/5+LymUS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk+qqsFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7399FC4CEF1;
	Fri, 14 Nov 2025 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763126194;
	bh=CLK/yWeDsqVN1DIRZoE5Vml27ZShImehp87AK62LvAo=;
	h=From:Subject:Date:To:Cc:From;
	b=Mk+qqsFI9O3sBP3KGHUO4j9NrPbSTc3NX9haka5+3IZZkz2KW3H4pqAG7wDBE6Mjt
	 jSjHON3J6fP4ovFPq6dOtPznXSxGZ6XwT98r7EwRedCts8WmPb34SM0xvAqpWLe7Zm
	 j/U7RK5x576dQiypPFTtMf6k/eBn6C1SeFPG9/lkZOI5o5AP4h2SbeLBHEaviM7bw0
	 2xsB4q/8l9Te+E1ggCwu3u05ch9lYxsz4tM/ZdxQ7t6z3jF6lawNpi9a7B9GcBw9aX
	 mEEYKHQeIWiXinE1JGegR3piXLd6TgO61/ZYK63A6BXrOQ9HC+DEqR+zsQCrRoTuIx
	 XWFdq0HtOKcQg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/4] wifi: mt76: mt7996: Fix some locking issues for
 MLO
Date: Fri, 14 Nov 2025 14:16:20 +0100
Message-Id: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQrF2kC/x2MQQqAMAwEvyI5GzCiFfyKeNCaag5WaUQK4t8NH
 meZnQeUk7BCXzyQ+BaVIxpQWYDfprgyymIMdVW3RNTgfnUOg2TcRVXiakPGZXauCcF7pgnseiY
 25c8O4/t+BZlV4GYAAAA=
X-Change-ID: 20251114-mt76-fix-missing-mtx-db664ffcce1a
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2


---
Lorenzo Bianconi (4):
      wifi: mt76: mt7996: grab mt76 mutex in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Move mt7996_update_beacons inside mt76 mutex critical section
      wifi: mt76: Move mt76_abort_scan out of mt76_reset_device()
      wifi: mt76: mt7996: skip deflink accounting for offchannel links

 drivers/net/wireless/mediatek/mt76/mac80211.c    |  2 --
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 21 ++++++++++++++-------
 4 files changed, 19 insertions(+), 11 deletions(-)
---
base-commit: c99ebb6132595b4b288a413981197eb076547c5a
change-id: 20251114-mt76-fix-missing-mtx-db664ffcce1a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


