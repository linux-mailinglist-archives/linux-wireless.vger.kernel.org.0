Return-Path: <linux-wireless+bounces-29591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B996CAD331
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB453004B8D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A62DA759;
	Mon,  8 Dec 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="kmLnE9ov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A752D9494
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765198194; cv=none; b=IOUIALhdFucLHU6mLNvYTdwb3t8WtJh6lQj6WKqDu5QVU3tcEqexG8j51110Vr2MBAnF3WkGN6bZ5eLCiZLJRJBUVRuTVZUaqmxYl30+vfbDLFtdNEoLTKcDzlJi+y4vWTyIryduy3SZq5uuNn5ECtmDItmU45HzqbdsVkdAgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765198194; c=relaxed/simple;
	bh=9TtrWvCT7+61AvANO5G3xCi++QaN0fmo50QVl8atTqU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oApuJ0gk+LJRCMtY1Fre7Ky9ag7zv3FxGTr6dV5zOEIPsuEiRpbrFmugZqM3c/1uOw5ObJrsp23DUr2q0YcdPFLbZH+n6Hm+/KhRSmX/o7S2Xi0AXSJ7lcqcJHVDffWcwvd42t9qITB/dcj6xNSsYBmIKuJbdyiUuyna7ALigXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=kmLnE9ov; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765198176; x=1765457376;
	bh=4ielOwlDxL2L7lk5YGwC5L8CwD0WFlxwAppk74gylQg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kmLnE9ovbCz9QK+7W+dfRDIQ3a/62XjWCDtE3Kpuq8mDb2ZXtV/TM5XgCpZLXA7Vg
	 t9jlQbd+javYqth9POroIVQwFXWMFNdDtcw3awtfB5/S+hhwnLKIhoAZ6zbhhFtgQD
	 FmBGGV3Hz55nJLP24hLMzgMp+bOmHX7YaCZpt3chyuYyNNSLHK+hzvhNISLig4uMw0
	 3T6TTejugUEoHbWAtKdIMp8S79TVl1hyfWO5bpg+oE+4u9odYkwOC9Mb26YE/JXBW9
	 7ksuhU0NiYpzfxR5wsJDL9WdarDboHtL+rouHXZO8ZmMsk/fDVLdi/E+Qlm8+Zm8pi
	 YA3rQxfrCSvHA==
Date: Mon, 08 Dec 2025 12:49:33 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH] wifi: mt76: fix deadlock in remain-on-channel
Message-ID: <3fceebb12dcb672cfae11f993a373b457a35e228.1765198130.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: 4ef7cc0db196e4f44ce46c8c17aac75224e9cf07
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

mt76_remain_on_channel() and mt76_roc_complete() call mt76_set_channel()
while already holding dev->mutex. Since mt76_set_channel() also acquires
dev->mutex, this results in a deadlock.

Use __mt76_set_channel() instead of mt76_set_channel().
Add cancel_delayed_work_sync() for mac_work before acquiring the mutex
in mt76_remain_on_channel() to prevent a secondary deadlock with the
mac_work workqueue.

Signed-off-by: Chad Monroe <chad@monroe.io>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wir=
eless/mediatek/mt76/channel.c
index 2b705bdb7993..d9f8529db7ed 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -326,7 +326,7 @@ void mt76_roc_complete(struct mt76_phy *phy)
 =09=09mlink->mvif->roc_phy =3D NULL;
 =09if (phy->main_chandef.chan &&
 =09    !test_bit(MT76_MCU_RESET, &dev->phy.state))
-=09=09mt76_set_channel(phy, &phy->main_chandef, false);
+=09=09__mt76_set_channel(phy, &phy->main_chandef, false);
 =09mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
 =09phy->roc_vif =3D NULL;
 =09phy->roc_link =3D NULL;
@@ -370,6 +370,8 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, str=
uct ieee80211_vif *vif,
 =09if (!phy)
 =09=09return -EINVAL;
=20
+=09cancel_delayed_work_sync(&phy->mac_work);
+
 =09mutex_lock(&dev->mutex);
=20
 =09if (phy->roc_vif || dev->scan.phy =3D=3D phy ||
@@ -388,7 +390,14 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, st=
ruct ieee80211_vif *vif,
 =09phy->roc_vif =3D vif;
 =09phy->roc_link =3D mlink;
 =09cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
-=09mt76_set_channel(phy, &chandef, true);
+=09ret =3D __mt76_set_channel(phy, &chandef, true);
+=09if (ret) {
+=09=09mlink->mvif->roc_phy =3D NULL;
+=09=09phy->roc_vif =3D NULL;
+=09=09phy->roc_link =3D NULL;
+=09=09mt76_put_vif_phy_link(phy, vif, mlink);
+=09=09goto out;
+=09}
 =09ieee80211_ready_on_channel(hw);
 =09ieee80211_queue_delayed_work(phy->hw, &phy->roc_work,
 =09=09=09=09     msecs_to_jiffies(duration));
--=20
2.47.3



