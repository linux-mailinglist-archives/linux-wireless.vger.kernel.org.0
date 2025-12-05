Return-Path: <linux-wireless+bounces-29538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79CCA7255
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 11:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 010B63017395
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAE3148CC;
	Fri,  5 Dec 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxB4ml/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C02FE04F
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930297; cv=none; b=kM/oh364h5iBmkdKhev1qHxnbwPWDssiLtXT1b8fHTV6cu1JdQ2rnmtyLIi0PGvBgGtsiF4v6fA5Axm7McRIm14n13JGpZGKhcF5Rp/dBc9Yp2yzaX0dRRbBndF3mJ6cY7fdCtIV5+Ozn1caho7LqFTOyKlLisR+EeUNuNKPcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930297; c=relaxed/simple;
	bh=QoqGL3t+IzslFi3fJoCRUrQYkQAMnqJUdwxlYp3/A1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mv6GRLYBAwwLKwZPsmagNYCaXhLuk7JSkA4sNEXeyU0TMBfa+la+cYSkdH0t8BnDv6J/SRIY9bWZRchrAhTTevX0zBrZ1KCvHorpw2lOrGL7Vg2qXoHThzTWN/JmwhIRZv9G4tsXvq1n5oIpW31ZniC666Ig7fXuvAWK8FWE9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxB4ml/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65067C4CEF1;
	Fri,  5 Dec 2025 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764930295;
	bh=QoqGL3t+IzslFi3fJoCRUrQYkQAMnqJUdwxlYp3/A1Q=;
	h=From:Subject:Date:To:Cc:From;
	b=BxB4ml/q+mWTTucdlAEc5griRYi/lhxVKbDHjTV7kc40RhwuqhY6M5usV9eqocvDl
	 3fwH7b4JyVjB0GnFpnk2aiOXkU/qk1ccwRv8B8Csi50xMieZ+gY2qcYj9tqJ+XNfR1
	 hSGzlp+psnWFURyxH4G7P3OM8S7YRaEUp72I+Fp6nco5o7ayAL255UuPdGPnrcXKrG
	 Mylx1BSXxBuRqbOjdsIIJtaFg6qJz14fkNKKoZmolws56kt/JrHmLQUQsoIA4o8I3u
	 4rJ0nfV7aIy2xJECsC55Axg+l83+KPHf2Ts+8CLpGDaYssGzEGA/njHXwOtNUmkNOA
	 EUw+SmcUBO0YQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 v2 0/4] wifi: mt76: mt7996: Some MLO link management
 fixes
Date: Fri, 05 Dec 2025 11:24:35 +0100
Message-Id: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Rg6VoiuvIdhQWEKE7XVllQM4
 e5WDuDyveS/v0DkIBzhXCwQOEkU7zLQroBubN3AKH1moJKOikqNj6mucJpf+JauRyszUlW3+qR
 VRcSQd8/AWW/Na5N5lDj58NkukvrZf7WksERltSFL5mCou9w4OL7vfRigWdf1C1bQePuzAAAA
X-Change-ID: 20251204-mt76-txq-wicd-fix-267a4941622e
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2


---
Changes in v2:
- Add missing changes in mt7996_mac_reset_sta_iter() for patch 3/4
- Add patch 4/4 to the series
- Link to v1: https://lore.kernel.org/r/20251204-mt76-txq-wicd-fix-v1-0-1f4b2f2b3b2c@kernel.org

---
Lorenzo Bianconi (4):
      wifi: mt76: mt7996: Set mtxq->wcid just for primary link
      wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Switch to the secondary link if the default one is removed
      wifi: mt76: mt7996: Clear wcid pointer in mt7996_mac_sta_deinit_link()

 drivers/net/wireless/mediatek/mt76/mt7996/mac.c  | 12 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 85 ++++++++++++++++--------
 2 files changed, 64 insertions(+), 33 deletions(-)
---
base-commit: 53d1548612670aa8b5d89745116cc33d9d172863
change-id: 20251204-mt76-txq-wicd-fix-267a4941622e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


