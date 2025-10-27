Return-Path: <linux-wireless+bounces-28298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0C1C0D207
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 708CC34C3D2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042B2C08BA;
	Mon, 27 Oct 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="lXFVNCPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C01DDC37;
	Mon, 27 Oct 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564011; cv=none; b=q7tCi8vnPHTdu3+NFay6BekFuNIAhoGq12s+RoE1ovT/Ri89oqYMD2knsRdXLSBDPln0pZhY+kyx80+vvDpCIAGfKPFe7UUUknaH+XUw4vYffRWAapqLu+qyTsY8OEP2WOKfx3NAafPj6kR1IzoZ2bB73cwizrPxabVu+PZm6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564011; c=relaxed/simple;
	bh=t36QMpF0kEbGNXKZ3u8Zsyc7RpiO5imYNK6PSTqUunM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WO44EJNJsKXcsJ2Mr/UqcLdeBkfe6dtzFFvA7aybmUK6dvgxJNfR6kad7be2trwb+jhamtpmAO6k0x0dyUN3CHs6ba21OiBYnNpIfPoeMSxW2dv8FTDBxpL6iiFc65hy3l0A/1453DQOTJ7QyJt8vXSLl3ENaFfwXGYjwoaqv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=lXFVNCPH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.19])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8072B40777A0;
	Mon, 27 Oct 2025 11:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8072B40777A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761563996;
	bh=lKOBSb5QX4VrNquz+dxI5NiKAxDsYKH/pxf6fpROs3A=;
	h=From:To:Cc:Subject:Date:From;
	b=lXFVNCPHHbyperB7SeuC0y6a5FeWyKJqjV6/gdWrKstFnqjuMqqzfAPO77gGPFOXW
	 jeJ5qBGTRu5TkTZQQzVwl1cbEbvXFnyQNfcMh5DF3IPoxzGWQaOLCJZmqH69nIQCRw
	 e6whrZ+GEwRSd4U/lIIbIVveaCfcEPq/qP96wjBM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matvey Kovalev <matvey.kovalev@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH mt76 1/2] Revert "wifi: mt76: mt792x: improve monitor interface handling"
Date: Mon, 27 Oct 2025 14:18:39 +0300
Message-ID: <20251027111843.38975-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 55e95ce469d0c61041bae48b2ebb7fcbf6d1ba7f.

mt792x drivers don't seem to support multi-radio devices yet.  At least
they don't mess with `struct wiphy_radio` at the moment.

Packet capturing on monitor interface doesn't work after the blamed patch:

  tcpdump -i wls6mon -n -vvv

Revert the NO_VIRTUAL_MONITOR feature for now to resolve the issue.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 55e95ce469d0 ("wifi: mt76: mt792x: improve monitor interface handling")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Can't answer exactly *why* the capturing doesn't work after the patch:
probably because the driver is just not prepared for NO_VIRTUAL_MONITOR.
The feature isn't too obvious, especially that for some reason it was set
in mt792x alongside WANT_MONITOR_VIF.  With a quick glance I might
conclude that NO_VIRTUAL_MONITOR overrides WANT_MONITOR_VIF, they don't
look compatible.

 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 5b50bf94996e..f2ed16feb6c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -688,7 +688,6 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
-	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
 
-- 
2.51.0


