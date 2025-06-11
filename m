Return-Path: <linux-wireless+bounces-23988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C355CAD576A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718F23A1F8B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270371EE033;
	Wed, 11 Jun 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="TQNwUR8t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783E28314A
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649373; cv=none; b=cfhSJSKeminbPf4VI0rxbbLU8iLHeNI6j3BbXIFwj4XseOgbIDSO02maUyns4xHIoHtz7iMlQ2RPJwkPKEeJfPucL0o6VEw/37VyotUmqN1b13mtKNTOFIbei4CbHWnD8+SFQI+c3tUlVRNuTJ6kbNzlqsmhGGrHZbRd74Aui6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649373; c=relaxed/simple;
	bh=HqYbK1Zn5pXaEcXcUsyIIvDhhRKRUhcVBQwOLA2hEuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C+xLUGNJOvzMNWPAiMzlvKgTRg8jK431Xmc6nIo2qTYCbiuGD7jEHJt8rpXwB0K2MNMer9uLVeh9tPUtAABhTCSPBR5h2rT2KXTyHNODwX2ckRin75toXtH9OzN6DLa8mZMGm9lmW90n2XQnaUQdAQ1qH+SXCuimqh+C5SV5Fq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=TQNwUR8t reason="key not found in DNS"; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=jIqZLsu+/x
	5dRvLruSMuPxmHqtGPMhfj7ymBrDEk+WE=; b=TQNwUR8tkbjh1dpIlORcRUJ5qF
	Y1byt/FvSSlBwwu31laElZBE4leJVreP37JSr8glFH4H2UT0B21OHrv2jV96M/PG
	nDA6aQqTYiyFSwIA51B4/kE7pFl8Up7EBVBwm8CKEAfbeSWSSw4DzTTBKK8DtX0b
	PnAdKzgz2lSUOTsLA=
Received: from f76011e66543.. (unknown [10.133.16.49])
	by coremail-app1 (Coremail) with SMTP id OCz+CgD3vVOvh0loTAypBQ--.57342S2;
	Wed, 11 Jun 2025 21:42:07 +0800 (CST)
From: hzy15610046011 <houzhanyi61@buaa.edu.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	StanleyYP.Wang@mediatek.com,
	mingyen.hsieh@mediatek.com,
	chad@monroe.io,
	razvan.grigore@vampirebyte.ro
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	houzhanyi61@buaa.edu.cn,
	zhanyihou6011@gmail.com
Subject: [PATCH] Add non-null judgement branch for return value of  mt76_connac_get_he_phy_cap().
Date: Wed, 11 Jun 2025 13:42:09 +0000
Message-Id: <20250611134209.312009-1-houzhanyi61@buaa.edu.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgD3vVOvh0loTAypBQ--.57342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fAryxZw4rKw45KF4fAFb_yoW8JF4xpF
	Wjg34Y9w4UGr4Dta18Aa1vyFWrJ3ZYgry2grn5Xwn8u39ayFn3Gr4IvFy3Ar1rAFZ2k347
	XF4qvry3GrnYv37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_JF0_Jw1l
	c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfWrJUUUUU==
X-CM-SenderInfo: 1v1siiaurqmqpexdthxhgxhubq/

From: H-Mole <houzhanyi61@buaa.edu.cn>

Since commit https://github.com/torvalds/linux/commit/f503ae90c7355e8506e68498fe84c1357894cd5b
 showed that drivers/net/wireless/mediatek/mt76/mt7996/mcu.c misses a non-null judgement for the
 return value of mt76_connac_get_he_phy_cap on variable vc, this null-pointer problem may also happen
 on mt7915. This commit added such non-null judgement like what was added to function mt7996_mcu_sta_bfer_he()
 in commit f503ae90c7355e8506e68498fe84c1357894cd5b.

Signed-off-by: H-Mole <houzhanyi61@buaa.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 427542777abc..5dca50d40080 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1184,6 +1184,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 	u8 snd_dim, sts;
 
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
 	mt7915_mcu_sta_sounding_rate(bf);
-- 
2.39.5


