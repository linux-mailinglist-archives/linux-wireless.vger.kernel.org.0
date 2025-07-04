Return-Path: <linux-wireless+bounces-24819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDC7AF93A3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190717B5538
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69222D8DA6;
	Fri,  4 Jul 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTX1TZp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DE2D63E8
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634504; cv=none; b=UlQ7dxF6f98hWUbDgAWAmqh0AGqBOS5Of7CGSb3DvsesecDE+X+uAKW5O3Cvl21pk5weac5WpvIt6iDXXzUhn/Cikm4HQVLQOXXN4qwbQDvlwUXWwyOhSR8PUDxPRJKMI3goAB4cfa3bzW/JeNciWg+cA29az0aNL4/KKkUw4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634504; c=relaxed/simple;
	bh=rwGfwl3S3wpFQNg2aerUj0nTT3rck9I4bSEbo7X2vVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G+1gNuzdeDt0DMDgXNEDgiBbvgCkGhme/xRbeU/RyaGZLbPa38CKx3NUS4Thg81MuM4gNXGUsLhhhbtYJt39DVZAO2zkv+c2/EHsSKIcctOh5WDB/vFU2fhrEoKy1wzzylloYoBvU4cttXf5PqYtEzFcFzhVcjCpzh8TUVzWZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTX1TZp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E9BC4CEE3;
	Fri,  4 Jul 2025 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634504;
	bh=rwGfwl3S3wpFQNg2aerUj0nTT3rck9I4bSEbo7X2vVs=;
	h=From:Subject:Date:To:Cc:From;
	b=MTX1TZp8TpXwdII2TqdUEKGpeKsqpt7DFXDOxQk0/KHTV5ez1pvZRgnlderHW5j4p
	 7DEQj6Myxs9ZD31lk7RuniDQmmWoPpyhzhjKxDodxdd1zQePJBTrmdWjKuZd2uJGy9
	 DC1m4bNyzKW+4W96Ti8ookVPzvkgtQBddFltMq9uN3sChJvoQr7CM33UxaA0Qs0mVn
	 85VHpxSQH0mj5wzrHMbZ4xsLcBxqcGQK5tzItYDXbv/9rEWget5fgf1g9lsZ8ryxa6
	 LOHViadmk4Xktrtl2CjjB9brt9MyjO5hVj8ALORIZ6fWJN77eT6TYEw/cSNnIkCBVK
	 I9A+yreWtC21w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/9] wifi: mt76: mt7996: Various MLO fixes
Date: Fri, 04 Jul 2025 15:08:04 +0200
Message-Id: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTSZ2gC/x3LTQqAIBBA4avErBswsdSuEi3SphroD40IpLsnL
 T8eL0GkwBShLRIEujnysWdUZQF+GfaZkMdskELWQguF26WtbXBbD5z4oYjkjZLOe2OFg7ydgf6
 Qr65/3w//ApAxYgAAAA==
X-Change-ID: 20250704-mt7996-mlo-fixes-ec842bcc890b
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Multiple MLO fixes for MT7996 driver in the mixed MLO/non-MLO scenario.

---
Felix Fietkau (1):
      wifi: mt76: fix vif link allocation

Lorenzo Bianconi (8):
      wifi: mt76: mt7996: Fix secondary link lookup in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Rely on for_each_sta_active_link() in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Do not set wcid.sta to 1 in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Fix mlink lookup in mt7996_tx_prepare_skb
      wifi: mt76: mt7996: Fix possible OOB access in mt7996_tx()
      wifi: mt76: mt7996: Fix valid_links bitmask in mt7996_mac_sta_{add,remove}
      wifi: mt76: mt7996: Add MLO support to mt7996_tx_check_aggr()
      wifi: mt76: mt7996: Move num_sta accounting in mt7996_mac_sta_{add,remove}_links

 drivers/net/wireless/mediatek/mt76/channel.c     |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h        |  5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  | 48 +++++++-------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 80 ++++++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c  | 17 +++--
 5 files changed, 83 insertions(+), 71 deletions(-)
---
base-commit: b3a431fe2e399b2e0cc5f43f7e9d63d63d3710ee
change-id: 20250704-mt7996-mlo-fixes-ec842bcc890b

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


