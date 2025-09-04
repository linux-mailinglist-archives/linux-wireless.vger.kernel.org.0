Return-Path: <linux-wireless+bounces-26989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC28B434C5
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C73304E11A6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069D242D92;
	Thu,  4 Sep 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPne19rh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF532F775
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972634; cv=none; b=Sg3vPCajeaQVBPUAGoheN9oh9sYUoz0yrKuF8KJ05rZs5IpUwHWolUGxNpfIaAlb4P3Fpi7/065Bzw8ba/VVlVzH1FOTf11wuP5Z6nW9zjefGcu2XoNft1EjKR7CirUnCeTa1Esvsmpnvj2kRkBfx69V65yhtbQozObsMv/LWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972634; c=relaxed/simple;
	bh=PrHRyzcSKzKMyEeBhSvkydnyJ262xjKrBuA8xcLVjq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oWHW6XXqWdhf2LPMJ5vvDd3MMLoIXwc16zbMD6VNZlTbjVxdbuboWIAekUHUUmSxYQkssZN4Ah3hNN1jUOu1C0Z5t7x8fnz4Pz9rL1utYT2NUyHp6HTsPj8UbT2f9SMbOTXbCqVktExdWwM/hRscV+aZG1XSmqVwKiTc6dj4pDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPne19rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FD7C4CEF0;
	Thu,  4 Sep 2025 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972632;
	bh=PrHRyzcSKzKMyEeBhSvkydnyJ262xjKrBuA8xcLVjq8=;
	h=From:Subject:Date:To:Cc:From;
	b=UPne19rhYUcLZyR6q5sKNVyxPvwYs7xivNv7T+ELHs7UfCy51CAldtOxdRGxYUKEX
	 viFwu7fFUO5iufbUXQqwTgffDQ014izUNdufRZhFmx9AF0OFIe0v70IuvV3CqPAlPm
	 0WErKPbiJqi1BmZyKcohz+818odTr6VsaPvl2E3pVwerfY5amS33O45CmpXKAbCcfY
	 zldI0LKkj31/5xbcM9CX6c6Qmkua7xP8WgHS7Sdok/HXmxo4jY8qAeC6/yjZOi0Zb5
	 hu4b1x7M9U4KHowGqXWyuTBLOedifg4vWmLMJfZQ5hQkoKozMKfnPcdfqKIcCovgpN
	 p7plIUK6ItpZQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/4] wifi: mt76: Some more MLO fixes for MT7996 driver
Date: Thu, 04 Sep 2025 09:56:38 +0200
Message-Id: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZGuWgC/x3LQQqAIBBA0avErBuwgVK7SrSQGmsgMzQiiO6et
 Hx8/gOZk3CGvnog8SVZ4l7Q1BVMq9sXRpmLgRS1yirCcGprOwxbxBATo5ebM2oyqjHkvO4Yyns
 k/kNZh/F9P5y9gnBnAAAA
X-Change-ID: 20250902-mt7996-mlo-more-fixes-7280182af76e
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

Add some missing fixes for MLO in MT7996 driver.

---
Benjamin Lin (1):
      wifi: mt76: mt7996: Temporarily disable EPCS

Lorenzo Bianconi (1):
      wifi: mt76: mt7996: Add all active links to poll list in mt7996_mac_tx_free()

Shayne Chen (2):
      wifi: mt76: mt7996: Fix mt7996_reverse_frag0_hdr_trans for MLO
      wifi: mt76: mt7996: Implement MLD address translation for EAPOL

 drivers/net/wireless/mediatek/mt76/mt7996/init.c |  1 -
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  | 62 ++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 6 deletions(-)
---
base-commit: 12cce7624371dc68245356ae390bde93f84aed3a
change-id: 20250902-mt7996-mlo-more-fixes-7280182af76e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


