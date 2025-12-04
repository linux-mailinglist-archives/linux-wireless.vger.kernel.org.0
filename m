Return-Path: <linux-wireless+bounces-29502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1BCA3BD7
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 14:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C6F3006FEB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61F341057;
	Thu,  4 Dec 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/aDWsxu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CE340279
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854029; cv=none; b=tc9uBlx+HBKj9zi9BTmbI2FEW/PjMITLmK6E6sgE25sp7t/g39gYMZQgMcYXVU/CTN1yvh3htdaLveyqZL7aFYX7yE6fCHLDuX1YxngjZLW7xSEviZnyGDPeiYTg38z4DWCYWcj6f2FFe7v5gG5bhQVvVOwYTzDogwp8+GHWIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854029; c=relaxed/simple;
	bh=LX5m6gmwF2s+hTAWnWC6SZ5hgbfLK8EmTlC3zSOFwfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OxcejS+9hNn+K2yyG73Xw1jPyc6Ltv3zrxrMriry0cH5T5Gy06pHYH+oYBRkrsoehpFsbMnq1+VQ/yIKAMgwbUO9wVl4Bn8+BP3bIrrdX+h/+0/IZ9SQW77+04uUMhIphf5wxRKakyCS5G/1YiVShc3NURkbD8ldBrweupG1ALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/aDWsxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF0C4CEFB;
	Thu,  4 Dec 2025 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854027;
	bh=LX5m6gmwF2s+hTAWnWC6SZ5hgbfLK8EmTlC3zSOFwfA=;
	h=From:Subject:Date:To:Cc:From;
	b=E/aDWsxu6fzANFFFSSV7NbiDgPUyieLItRp5Zo+HplFWE3rwdBZpTGZdQUoU/ftrd
	 yGYNniyAzs1b0SCzXgPKJyECpfKy5sFMiYyE62KCbzdtQ80vszsNW3kikIyvQoQK/v
	 dZnkExaXSThnrIkRFzT8Hv9uuxhVdCXB/G7TqSkb+/v7njZScPECqeu7liw/7J/YvR
	 GKdTXIQkGlJ21yLQlkr0PsBlteJzupaZgnRrRyIMLbRWVcNEoYrqB+fdYh8NS5a3eU
	 vUEK7fvZpyebiWixNJCe7QB5DQPv6KoGug9iy+gZeG48UIcP7kLt/Byf2Zr9qqPAE0
	 AsWn91dxxhUKg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/3] wifi: mt76: mt7996: Some MLO link management
 fixes
Date: Thu, 04 Dec 2025 14:13:27 +0100
Message-Id: <20251204-mt76-txq-wicd-fix-v1-0-1f4b2f2b3b2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7biEXM+or0SFyqz1kpVGC9Pek4
 wzMJAjshQN0RQLPtwTZXQZVFjCto1sYxWYGqqhWVGncrsbgFU98ZLI4S0QyzahbrQwRQ+4Oz1n
 /z3543w+C1aQ2YwAAAA==
X-Change-ID: 20251204-mt76-txq-wicd-fix-267a4941622e
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2


---
Lorenzo Bianconi (3):
      wifi: mt76: mt7996: Set mtxq->wcid just for primary link
      wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Switch to the secondary link if the default one is removed

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 84 ++++++++++++++++--------
 1 file changed, 58 insertions(+), 26 deletions(-)
---
base-commit: 53d1548612670aa8b5d89745116cc33d9d172863
change-id: 20251204-mt76-txq-wicd-fix-267a4941622e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


