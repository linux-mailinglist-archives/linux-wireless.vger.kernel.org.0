Return-Path: <linux-wireless+bounces-29593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B5CAD713
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 15:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6514D30C4EEA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B43101A3;
	Mon,  8 Dec 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="H9KbloPe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E0313539
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203304; cv=none; b=FXl1F2aunHRng/5g9XOuwHMhSbK9jxE1n5Ud4xgrCtIINLK0k51GE7BQndS6MalkJVF3ZBY1S5HQn75NK6DIRaztJtPgEDC/CWmPQIYes9FJymLwRHcW+f1s04d9vVErTH2mY9qDX3rXuwFSoIRhYJgAY7doYvoF3wGhfzkeZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203304; c=relaxed/simple;
	bh=ioJR3HvY95MFa1H5oC3LXKyjjKQkofpBY9nnFT13BBI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mN2m2EqwLbMXre7eou3TNavR80N+G8YrCLR70b/Z1VHHvkKvkOFEfJW23S+GYFwA4ELR2JrCyEVPvhu/a7U51RjYxg9/SwiqP/UvhYEPQjcfFID3uHP+sFvoFtsfmzak+akiWHhTVyCGdGlW7zQ03Mt1W5uIIEBm1GRq12iHj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=H9KbloPe; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765203293; x=1765462493;
	bh=ioJR3HvY95MFa1H5oC3LXKyjjKQkofpBY9nnFT13BBI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=H9KbloPedYf7OIR2JF3t4gOjdYNJSBfVqOecIP+7iJyElugXv94uwr5dkhx15qAHZ
	 1lZAg8pgJK6QOxtfxI0Euqw1VPYSDpJ9Ja6si23Z0fl00evZ54r6GYhXEXn7CEmYlJ
	 vn4zUR72wtFh7m/ascm91e6uB/0LztkhNk7OPYVJ7rXYOuUbNoA1l+fIv6qTeBFW7V
	 fzIWeBSqXyIX5bQEMD3EvwVZpxpseSsQoH0/2rGmMp+2GBy2RvMJUcoZPSOS4ztcz9
	 XUCBV46U7qtK3j7o8megKkomdlC7fhrtfX+t0VJZfJWUoEicReQ9Fq6HlDEvfPsbLV
	 LK4fX+Kkyz3jQ==
Date: Mon, 08 Dec 2025 14:14:50 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH] mt76: mt7996: increase txq memory limit to 32 MiB
Message-ID: <acfe2e25768b414518be2db22b1d3ba6f5db6fa1.1765203249.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: 03ab75c6190e4ee54eaadf543b2174c48cc519a7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Prior to this change, both 2G and 6G radios would fall back to the
mac80211 default of 4MB which is not enough for high data rates.

Signed-off-by: Chad Monroe <chad@monroe.io>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net=
/wireless/mediatek/mt76/mt7996/init.c
index 00a8286bd136..b5ea997fd75c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -523,6 +523,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_w=
ed_device *wed)
 =09ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
=20
 =09hw->max_tx_fragments =3D 4;
+=09wiphy->txq_memory_limit =3D 32 << 20; /* 32 MiB */
=20
 =09/* init led callbacks */
 =09if (IS_ENABLED(CONFIG_MT76_LEDS)) {
--=20
2.47.3



