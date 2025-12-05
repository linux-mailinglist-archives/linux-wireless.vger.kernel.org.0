Return-Path: <linux-wireless+bounces-29542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA3CA7264
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69BB730CC947
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C529313298;
	Fri,  5 Dec 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmU4VHN0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E8322522
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930308; cv=none; b=NzUFlgyLEma8fTOKSHV/UoX87gRMPCLDL5i0Gagdfe8zQQXMJg2/kaVDPK061X7tOG4C521ggTFZIWc60C8kEntGOH1C/WRrPnNzfnGm4NAOZIlsV9IfhfYyidehXESJs6fZvqUS9fEoM5QReBju99TfSJBa5mKwVC3vtQ2iSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930308; c=relaxed/simple;
	bh=xVy6mYUJY3M3YBXRdoJaYabe4kSYexCVeSPnndn/gEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbTH0Q7ndPo8/Kzgp3MCPIDIDva7Q4mPyNycbR1n4ehnwbhN6+cGQdm8JEQgsJb3asdNvvfinOGZD1vsRgZ2oJZrsbmUpvYT6BUQa5b8Z9Nq+krK0xs7k15TeyG/OO5tADK+x7XYv+YmUp0yE0iRhKmG33DKX/fjZm5AAUwJuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmU4VHN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274BEC113D0;
	Fri,  5 Dec 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764930306;
	bh=xVy6mYUJY3M3YBXRdoJaYabe4kSYexCVeSPnndn/gEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bmU4VHN0JTGck/+aXil0P9YXvN2aCQOOMt9WL2epaufp/OQUcWSxh3uwVcReG+OGT
	 l6iIHJ08RPh23wfXYEggWrTWCkU73D0dHUlDwrQ1wBbw4fI7myYWjcknVIed7/h65Y
	 m3QQObZgoRbT6QYYZQEUx72csenXHUbbB9qfvJpwNI/ts8ljuZ9yWBc0ZsYNiT7Ala
	 bzjLqlG8Kn6o/lIGuAYXRQlgjO5Dcb2+A/C8ttLH3kHpwq2AcPpPv+hHHgLkHkkwc1
	 tOYiusms6dVqqJ/jK42XvivjG7rtkDE0I6o0gHDlT3uOHhsZjP4Q0ac4Ja5y5c/lQq
	 ihSdgY0MiAxWA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 05 Dec 2025 11:24:39 +0100
Subject: [PATCH mt76 v2 4/4] wifi: mt76: mt7996: Clear wcid pointer in
 mt7996_mac_sta_deinit_link()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-mt76-txq-wicd-fix-v2-4-f19ba48af7c1@kernel.org>
References: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
In-Reply-To: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Clear WCID pointer removing the sta link in mt7996_mac_sta_deinit_link
routine.

Fixes: dd82a9e02c054 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 1baace971ec3511dba3e8a64c236a2b55f9dbd36..78151197feccb0197e44f3f73c0f01c4589314ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1027,6 +1027,7 @@ void mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
 		list_del_init(&msta_link->rc_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
+	rcu_assign_pointer(dev->mt76.wcid[msta_link->wcid.idx], NULL);
 	mt76_wcid_cleanup(&dev->mt76, &msta_link->wcid);
 	mt76_wcid_mask_clear(dev->mt76.wcid_mask, msta_link->wcid.idx);
 }

-- 
2.52.0


