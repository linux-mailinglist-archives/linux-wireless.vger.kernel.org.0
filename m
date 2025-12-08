Return-Path: <linux-wireless+bounces-29601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0DCADEE5
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 18:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3BF3088BB4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3341A4F3C;
	Mon,  8 Dec 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b="XpSaItvh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4A218845
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765215399; cv=none; b=kS68XiV5iH+c6KdvHA5LUt85UObCO96w4Q3aVK/dNDv2+zMRQkgl0sp2WKOjKahM8VEJ1vfn+OG3TwTY2aEAEBl3KQQtf7lWm6b+ikzFIDA9y8eJxjVszhGsm9A9q0TL1G8idim3ZEorUD4/aAwSxZ5IAj0e7ILrJnSPfKFOBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765215399; c=relaxed/simple;
	bh=1KyMDe1GoufKei4kPSkgs6XMcqhF7whbI00vNsmAC7Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abLHXF2Mf14K92Y8IouoFBz3JpYm9Usqe2A8R+Jru8jaXvm+lbiFf8wWtcmP/XQVs55XdOvxdFUb7nxHpwdfxilRagnhXilIjapis/ZwZOVzmTUwPk29Cm7NEjasbakH/kdcw4NHgezYctadanM+7qplJU/td/T61LdDnnKGpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io; spf=pass smtp.mailfrom=monroe.io; dkim=pass (2048-bit key) header.d=monroe.io header.i=@monroe.io header.b=XpSaItvh; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monroe.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monroe.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monroe.io;
	s=protonmail3; t=1765215394; x=1765474594;
	bh=XfhVptDWr1QW2ircHDGHYcKFnDVil044CT7xBlzhjmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XpSaItvhr0l9nGt3AZ/CaglPurffUtb75I08wVN4vET9Jh3uX/9w+1Op0Dlzplstb
	 12OkCIuihD76+Hvw2Uazt2MrQ7u9vPNNq8gMY0PY81Qt9+FKf2K7ntUziFyHiSHuPU
	 rU0BKhTzVbM5/dfH9XE+zpOWFKKkCszjlZvB+HEXG13DndUJG2j0jYMaQYP2jNtnH2
	 pWgVGORi9H9kH9vvaUNOqKA/sSMhwC+FO0xypeCiVQO2/7TlKcwrH6Jy+HmhyfpBR4
	 egUN9rM1wx9SV8kVA83kz3MjbwrkabKOvnnsHaAVGt/e6uzKW3Q9jEJpniJu4fal+n
	 nRbgCwhflGsnQ==
Date: Mon, 08 Dec 2025 17:36:29 +0000
To: Lorenzo Bianconi <lorenzo@kernel.org>
From: Chad Monroe <chad@monroe.io>
Cc: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7996: reset device after MCU message timeout
Message-ID: <STMznQ8BXsvf185OAGs7UAEpv2RIo1G6sws27GVInBYxtAT6Er7qb48T_YNBSF_L3dM_UwaCQXU_5bZy7b5AJQ8u1e1aSlzlx4LVSR9vnxc=@monroe.io>
In-Reply-To: <aTbeOResfSpMk6hZ@lore-desk>
References: <27bebda195599b55d097f4586a034dddce5d2cc0.1765202889.git.chad@monroe.io> <aTbeOResfSpMk6hZ@lore-desk>
Feedback-ID: 9731019:user:proton
X-Pm-Message-ID: a4a1882d1857bea674e625d12e73c7d8c9b21116
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Monday, December 8th, 2025 at 6:18 AM, Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:

>=20
>=20
> > Trigger a full reset after MCU message timeout.
>=20
> > Signed-off-by: Chad Monroe chad@monroe.io
> > ---
> > drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++++
> > drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++++++
> > 2 files changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7996/mac.c
> > index 2560e2f46e89..07b0a694c1bb 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> > @@ -2736,6 +2736,11 @@ void mt7996_reset(struct mt7996_dev *dev)
> > return;
> > }
> >=20
> > + if ((READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA)) {
>=20
>=20
> nit: you do not need double brackets here.
>=20
> Regards,
> Lorenzo

Thanks! I submitted a v2 patch. The logic was copied from an inverse condit=
ion in mt7915 and I missed the extra brackets.

    -Chad

>=20
> > + set_bit(MT76_MCU_RESET, &dev->mphy.state);
> > + wake_up(&dev->mt76.mcu.wait);
> > + }
> > +
> > queue_work(dev->mt76.wq, &dev->reset_work);
> > wake_up(&dev->reset_wait);
> > }
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7996/mcu.c
> > index 14a88ef79b6c..40ebda9a3f12 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > @@ -209,6 +209,7 @@ static int
> > mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
> > struct sk_buff *skb, int seq)
> > {
> > + struct mt7996_dev *dev =3D container_of(mdev, struct mt7996_dev, mt76=
);
> > struct mt7996_mcu_rxd *rxd;
> > struct mt7996_mcu_uni_event *event;
> > int mcu_cmd =3D FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
> > @@ -217,6 +218,14 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, i=
nt cmd,
> > if (!skb) {
> > dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
> > cmd, seq);
> > +
> > + if (!test_and_set_bit(MT76_MCU_RESET, &dev->mphy.state)) {
> > + dev->recovery.restart =3D true;
> > + wake_up(&dev->mt76.mcu.wait);
> > + queue_work(dev->mt76.wq, &dev->reset_work);
> > + wake_up(&dev->reset_wait);
> > + }
> > +
> > return -ETIMEDOUT;
> > }
> >=20
> > --
> > 2.47.3

