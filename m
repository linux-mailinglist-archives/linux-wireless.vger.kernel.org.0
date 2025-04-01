Return-Path: <linux-wireless+bounces-21025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31516A77C06
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 15:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E047C168733
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088D2036FE;
	Tue,  1 Apr 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aB1wUZ4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F032E339C
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513955; cv=none; b=pktD1P/+/ubsmFOaC36aAPjwVdCsniHg2HfENwUg+5TZrB/LocCIuCd32aAH0nnJgmfBTvlqJwm4lxIOGicG7H6wkfZYArQY10xdetS+PGHRNm3APfIS9gWtifkZVbeb1av7dqSlGU2X5+ZqKLwrN8hHTScZz88uw/1WjmTJ+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513955; c=relaxed/simple;
	bh=WnbTGdC1nckjCkTxkzO584mZEF4AjiIhUXBjL+x1FQ4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBCN38odKJE7h+QYM7Q8JJPbOj9fN/aePBH1jLEjnNAaMMXNlAgtY5oCrJG1IgSFGKQGbnJgzoMH8ZqGA40R1K54xChOHJfwx1pRriSJ1LdpilipVo3fJIKtJ5803PN/oHXRj5ckH+Yw02xtD7xNLGpDLqEHEAhboHPTsgbvCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aB1wUZ4p; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d24fa3c40efc11f0aae1fd9735fae912-20250401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WnbTGdC1nckjCkTxkzO584mZEF4AjiIhUXBjL+x1FQ4=;
	b=aB1wUZ4pWWfH+Y7OVC8HvPzvh6LWzC24sdKKJ+XzlerXN0CSkOve9XRfROo3uAKIEIQoyzq5djp+kouHWaFMdmVvs/Q+WO6OMQbUh09nDuuJ5uzF9loUclrF0vis3FylFCkcQ+6cQCV60cNtQ5QLtEHGdhhgZEXxq8P7qG58pLk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2154f467-7fc6-4c8f-9337-00a45dbd80d9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:9b4a10c7-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d24fa3c40efc11f0aae1fd9735fae912-20250401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 987279419; Tue, 01 Apr 2025 21:25:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 1 Apr 2025 21:25:45 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Tue, 1 Apr 2025 21:25:45 +0800
Message-ID: <2cb3376205353e98384ca8faa4454fa0511d47b5.camel@mediatek.com>
Subject: Re: [PATCH 02/10] wifi: mt76: connac: add support to load firmware
 for mt7990
From: Shayne Chen <shayne.chen@mediatek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Date: Tue, 1 Apr 2025 21:25:45 +0800
In-Reply-To: <7ec7c486728d490caef7dcdac3c1c8e4@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
	 <20250328055058.1648755-3-shayne.chen@mediatek.com>
	 <7ec7c486728d490caef7dcdac3c1c8e4@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ping-Ke,

On Mon, 2025-03-31 at 04:40 +0000, Ping-Ke Shih wrote:
>=20
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
>=20
>=20
> Shayne Chen <shayne.chen@mediatek.com> wrote:
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > @@ -232,9 +232,14 @@ static inline bool is_mt7992(struct mt76_dev
> > *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mt76_chip(dev) =3D=3D=
 0x7992;
> > =C2=A0}
> >=20
> > +static inline bool is_mt7990(struct mt76_dev *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mt76_chip(dev) =3D=3D 0x79=
93;
>=20
> It seems like patch 01/10 want to avoid this kind of confusion.
>=20
This helper is added in mt76_connac.h, which can be used by mt76 common
part and mt7996 per-chip folder.

> Also, there are two IDs for MT7990:
>=20
> #define MT7990_DEVICE_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7993
> #define MT7990_DEVICE_ID_2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x799b
>=20
These two are only used by mt7996 per-chip folder.

Regards,
Shayne

> > +}
> > +
> > =C2=A0static inline bool is_mt799x(struct mt76_dev *dev)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return is_mt7996(dev) || is_mt799=
2(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return is_mt7996(dev) || is_mt799=
2(dev) || is_mt7990(dev);
> > =C2=A0}
> >=20


