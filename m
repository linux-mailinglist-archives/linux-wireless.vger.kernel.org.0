Return-Path: <linux-wireless+bounces-29597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF9CAD749
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61EFC303C9BA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B432A3FB;
	Mon,  8 Dec 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="Xx6BeAva"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865731ED7B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204309; cv=none; b=KdPa5svvhCEPgHf7FezYV6H/BCRl486P6LESchfKkjigHZrw7ioDHWV9RkF0R+5c6ytbrAx1XJfMz4jPIrEzNAKIn9altNtMXi9rEeBH5uCYmF1KbTG0KeIGieYwcKpjnG5HlaVGgHbaDl4vlVWNIgaW+KDCTQy0WXiKgfiA834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204309; c=relaxed/simple;
	bh=ZsE3CdRQ+3grrM6WF7MuIJ1sPwbybpt2XCstWGTlnDE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dPb5tJiOrWoTpXNUiUxmi70ggcjjDbj22uPNTBbFFGfpsM2sAorPc82GnM1awPlZHpdfUebACZ6r6AfM6+MXTlw0bNy7eSRwfoV0nSEW5ojXeRE145TAWg1ixyyXUivACajDFzZcsJdOUJuOImYgHYJcxYNSjo02E9lNkRlDtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=Xx6BeAva; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765204297; x=1765463497;
	bh=cRO9Kqg8GbjtDmjFLSeM+ZO7W/jE+wxbkiid/1tn0KY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xx6BeAvaoD12KtUQQsFXKIol4dBchAPFvK/uoVPlM2pnkaMCG2HXlyL6Vt8YkfJ2Z
	 PEENxh1QPTL2PbkdxW/mn7QMcK00vMdW4Ro8EAqEnaTAj4vPknAKW5ovBXnP4hICXD
	 jTf4aL6n7E2PeLfe+D5tzdnCYn3Z5lqzbysRbHv7tfy+hGdkucO9JoHlOUmrUAIHZo
	 QgCPIrMJ/OiXQa6WEXd5iHbGWOxoiPinZAPwM5VkKWto6yN1fB4G2OjjAChKGxB9NM
	 3xZGMzKB4SlxzXF0m48fdUD58oGarbsN6rEc+KTv1vrNUQ/mfRCXAducdKeS+tgOeB
	 KK5uJaJ6TfrnQ==
Date: Mon, 08 Dec 2025 14:31:32 +0000
To: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>
From: Chad Monroe <chad@monroe.io>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Chad Monroe <chad@monroe.io>
Subject: [PATCH v2] wifi: mt76: fix deadlock in remain-on-channel
Message-ID: <ace737e7b621af7c2adb33b0188011a5c1de2166.1765204256.git.chad@monroe.io>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: 362a418e2bcec1466ff1882611bf28884d5db41e
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

Fixes: a8f424c1287c ("wifi: mt76: add multi-radio remain_on_channel functio=
ns")
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



