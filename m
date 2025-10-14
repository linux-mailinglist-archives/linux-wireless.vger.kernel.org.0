Return-Path: <linux-wireless+bounces-27971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C2BD9BC3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6783A189085F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EA2D248A;
	Tue, 14 Oct 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRvpWAu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763D2D8DB5
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448552; cv=none; b=r1UaM0u98Ba1TcjJhnRlpRTKn/xWU5AcFt8ucLS/LUCZAEiThuzsBi8OlXSgLMc4ZPiia1XR7fco7mWbE58kFEGNcKwnrDqO7pY45x2ymXnkCsSSh2Loq3Z369v/7L/W2T0lA5cSw/O5gCCiYN2lyk3iuk7haHvqvdzArMddTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448552; c=relaxed/simple;
	bh=yrU/wVuLdmgKHx45LWjxxFJNQ2uyG8EC9y0uqLydue4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZCKTKXhhwsJWsuQkunRZrp/C2ZETq3mQPAD2F8nIsWPQk6OAn659QkfhuVLzvSpzUfA2aRDkfR1SRkKDiyZ0venz4tpzvz8H1C/O08R7W3Oi+5IjQxKgKTYItVKXFOq3lnAODX/8qYD1WD4foOIzUs4M+u4+CeN/r/vE6tRemx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRvpWAu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B5AC4CEE7;
	Tue, 14 Oct 2025 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760448550;
	bh=yrU/wVuLdmgKHx45LWjxxFJNQ2uyG8EC9y0uqLydue4=;
	h=From:Date:Subject:To:Cc:From;
	b=hRvpWAu13U8ZgPlwKZJ1kACJFoY1FOfAtWwgaAO5STTY4NbZUniTde/HKDDIoOpFp
	 rNB9oIhVaM+i25hdQssI1VR44PBfyXuTQ6ws/6DzvnOVNi0IexyI8zttZI8gWyiIOa
	 /khIwGPWg5R4+woqcJUK9HJWUY8cOO6k0rGEdX0FIPoiXaI/qsdOPzF3RohbL7hQee
	 Goa4njmgj4mJ2R/DdrQ3NcsfFKSR3LG6/8aG3ou+UUIZ2ne6F0/IgbvTRNZRhR0zgo
	 lwbKQ4XA/aZmpt4FjPmzYKlKO92d3dtGvkj82CYKDVDcPfgeGMee9u4/BBe/iMShcG
	 dzL2D/tdP9f2Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 14 Oct 2025 15:28:53 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Remove useless check in
 mt7996_msdu_page_get_from_cache()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-mt7996_msdu_page_get_from_cache-remove-null-ptr-check-v1-1-fbeb7881e192@kernel.org>
X-B4-Tracking: v=1; b=H4sIABRQ7mgC/x2NSwrDIBQArxJc94FKY2qvUoqIeTHS+OFpQiHk7
 pUuZxYzJ6tIASt7DicjPEINOXUQt4G51SaPEObOTHI5Ci7uENuktTKxzrsp1qPx2MxCORpn3Yp
 AGPOBkPZtg9IIunMfeOiRc2Unh0qy3i6ES/j+v6/3df0A4F66gIcAAAA=
X-Change-ID: 20251014-mt7996_msdu_page_get_from_cache-remove-null-ptr-check-895006a7ce62
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rex Lu <rex.lu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel test robot <lkp@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Get rid of useless null-pointer check in mt7996_msdu_page_get_from_cache
since we have already verfied the list is not empty.

Fixes: b1e58e137b616 ("wifi: mt76: mt7996: Introduce RRO MSDU callbacks")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202510100155.MS0IXhzm-lkp@intel.com/
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9501def3e0e3e20132fdbcfe0b1f489694afdc5f..284f2eea71e5bf0a34c7fe84084d998164a31a05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1681,8 +1681,7 @@ mt7996_msdu_page_get_from_cache(struct mt7996_dev *dev)
 	if (!list_empty(&dev->wed_rro.page_cache)) {
 		p = list_first_entry(&dev->wed_rro.page_cache,
 				     struct mt7996_msdu_page, list);
-		if (p)
-			list_del(&p->list);
+		list_del(&p->list);
 	}
 
 	spin_unlock(&dev->wed_rro.lock);

---
base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
change-id: 20251014-mt7996_msdu_page_get_from_cache-remove-null-ptr-check-895006a7ce62

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


