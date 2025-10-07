Return-Path: <linux-wireless+bounces-27850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA5BC0901
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FABD4E512D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D525785B;
	Tue,  7 Oct 2025 08:11:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A625392C;
	Tue,  7 Oct 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824695; cv=none; b=hGPoeFcgGCdQzaoL7fUDjIqK9ceL1/yDU2nuAM7234mS4m3mvEo8ajebFQ05cEMgAxSS8jTM9cjs3slOhEPJjiFaHwKQNJzbJOWKgfri3Sngjxy63mjGtxezHGWu0u4b4CTiY+lDxET/tEsp8iVtYQwQ+pq4pJrBgzq4oa81v5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824695; c=relaxed/simple;
	bh=D7WzneyyiTFiOknwaG8a1/dFFbUemyH6aw259znERf8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=blhjI7yyHsfylqnUsZnV7y73kBmu6+LjpPH3pJXFFwDU0Q3HRWrbTHHJzZn35fFdeCB14z41Uepj2wfNp79+uvwZ0c4id8S/35jmTVIIId5Ze3CCpk1Ib3lytwNXzfV+9sYbEamMGHtXlaimnLULZFeNrAb/eWozKbbONcl3UQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from sven-desktop.home.narfation.org (p200300C597021Ae00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:9702:1ae0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 458EEFA12C;
	Tue,  7 Oct 2025 10:11:31 +0200 (CEST)
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Subject: [PATCH mt76 v3 0/3] wifi: mt76: mt7915: Beamforming backoff limit
 table
Date: Tue, 07 Oct 2025 10:11:13 +0200
Message-Id: <20251007-backoff-table-support-v3-0-fd6e2684988f@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHL5GgC/3WPwW7DIBBEf8XiXCrAZjE+9T+qHgysa9TYOICdV
 pH/vdSpoh6a4+xo3sxeScLoMZGuupKIm08+zEXUTxWxYz+/I/WuaCKYkExzRU1vP8Iw0NybE9K
 0LkuImWoteNuKWipwpGSXiIP/PLivZMoKyNvtGvG8lpL8a907uureUIJ0CReM9OQnnxOVFpkyW
 tfQ8m4TP3zTJ6Q2TMXvKlODkxI4E1z2WoEAxbVyzmreaCZsoxvFpFPHhtGnHOLX8fDGjxG3ZtE
 8+G3jlFHBULLBWKkdviQ/hfmyzg7jydvx2eGBLtP+4OARThQcB1crAdCAbf7F7fv+DbcBB26cA
 QAA
X-Change-ID: 20250917-backoff-table-support-99218823576d
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org, 
 "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=D7WzneyyiTFiOknwaG8a1/dFFbUemyH6aw259znERf8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBlPTutsvfbt/LMYJ6meS+eFHhr8264x4/hiSz1mn/U3P
 O2fHjl2u6OUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwER93Rob5Pb4Hck1/89r6
 cjwMbZz/Z3bOwssyz89Z1DlMjm4yNz7IyHDstRgPw/KN/TxbXQM9V5idfT+l0umLwq7Zkcr8jb/
 vSPEAAA==
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

It was noticed that Mediatek's MT7915 does not only require calibration of
the normal rates (configured via DT) but also some backoff values for
beamforming. The proprietary driver loads this from some file in the
firmware folder. But for the the upstream driver, it is necessary to get
them from the same place as the normal limits - in this case from the
devicetree.

They released the support for this [1,2] in their own SDK but
without any kind of documentation. And it was (to my knowledge) never
forwarded to upstream. But since also (in my case) OpenWrt needs correct
calibration for this WiFi chip, we should get this upstreamed.

I try to my best to provide some sensible information about the patch and
the DT entries. If anyone else has more information about it (to improve
the descriptions), please feel free to comment and provide some
enhanced/corrected version.

The patch from Shayne Chen was only rebased and modified to perform byte
reads from the DT [3]. Besides this, only a commit message was added,
MTK_DEBUG parts were dropped and some checkpatch problems were fixed.

Regards,
	Sven

[1] https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/f0d2527deb4f91592b6486a5c98ea3f584f76a61
[2] https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/737340322ab22b138fd200e020d61ffdbe3e36a9/autobuild/autobuild_5.4_mac80211_release/package/kernel/mt76/patches/1022-wifi-mt76-mt7915-add-bf-backoff-limit-table-support.patch
[3] https://lore.kernel.org/r/20250917-fix-power-limits-v1-1-616e859a9881@simonwunderlich.de

Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
Changes in v3:
- Add pattern for country property, Thanks Rob Herring
- Add Robs' Reviewed-by to "introduce backoff limit properties" dt-schema patch
- Link to v2: https://lore.kernel.org/r/20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de

Changes in v2:
- add [PATCH mt76] as requested by Zhi-Jun You
- Link to v1: https://lore.kernel.org/r/20250924-backoff-table-support-v1-0-20e50fbc59de@simonwunderlich.de

---
Shayne Chen (1):
      wifi: mt76: mt7915: add bf backoff limit table support

Sven Eckelmann (Plasma Cloud) (2):
      dt-bindings: net: wireless: mt76: Document power-limits country property
      dt-bindings: net: wireless: mt76: introduce backoff limit properties

 .../bindings/net/wireless/mediatek,mt76.yaml       |  66 ++++++++
 drivers/net/wireless/mediatek/mt76/debugfs.c       |   4 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |  38 ++++-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   8 +
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |  74 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   7 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 182 ++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   6 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   9 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |   2 +-
 11 files changed, 343 insertions(+), 55 deletions(-)
---
base-commit: b36d55610215a976267197ddc914902c494705d7
change-id: 20250917-backoff-table-support-99218823576d
prerequisite-change-id: 20250917-fix-power-limits-5ce07b993681:v2
prerequisite-patch-id: 964626eea847052cefc907ef0f01286a080fdc3c

Best regards,
-- 
Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>


