Return-Path: <linux-wireless+bounces-20721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0BA6D2F4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 03:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2C3A4BE8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8D33062;
	Mon, 24 Mar 2025 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qp3uFt2L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABB1362
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782062; cv=none; b=oDTNqILssQFGjrAwtUnhlTzl8nALpZigEnbnNMQchEUgqRT/z6yFYJrpvtn8oxCpWYD38ksTTXG1EqAKLmTXR2G5buiL2BpBVycFYJHTbsdvx5wuea6KTDbtBk6nvqCG2tWZwDpYyQAsA8sHSnu4zjjzv7QCgJchWcyCo4S3z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782062; c=relaxed/simple;
	bh=m/am8PBj+z4VxljbNpwoZFyjNIPJkvh1EzWXZRpZRus=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snj1D2bkHRm5V1ztDZvTGG/TqJgZoEEMSF7IrJPNNH4/4S/OnT73sCOz3s6+gkFGbEmQ9bVrxe6GLDfEGODl4Bd7QGTKBgPo/BUztLZwHwm8RkuFzjw3PleqvMaXUd/qHVmRFdF6sWduQSZs4S3uCjCGrt5Nzs099rRKRujFbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qp3uFt2L; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bb151dc8085411f0aae1fd9735fae912-20250324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Cu448PxEK6et1+zNw7r1sNBXlczvVSaKK/4PQCuOVpk=;
	b=Qp3uFt2LZwjDbHNjpkTgL0IL2Hvu7bf7X6UXAswho/X9ZfOgx3zV2pjlT+hgLV18B9GTyU/lxIIv0++0qYgvtd903w2TJslbHJutghpOgFF4ubUKmRfCXgVXIIBGKdhumLQCh7qLYGp9PjiczmG2IjUQclkdtREsfdimXmELnAE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bdc5f4be-b93f-4c66-8963-71951c088647,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:8ee7b3c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bb151dc8085411f0aae1fd9735fae912-20250324
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 420911358; Mon, 24 Mar 2025 10:07:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 24 Mar 2025 10:07:24 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Mon, 24 Mar 2025 10:07:24 +0800
Message-ID: <960af30b800baf02d51333a5bf52de93d2966e2a.camel@mediatek.com>
Subject: Re: [bug report] wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()
From: Shayne Chen <shayne.chen@mediatek.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date: Mon, 24 Mar 2025 10:07:24 +0800
In-Reply-To: <Z92T5j1zmlvG2ssG@lore-desk>
References: <868e456f-10db-4b0c-bb29-76e3c0d03cc8@stanley.mountain>
	 <Z92T5j1zmlvG2ssG@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-21 at 17:29 +0100, Lorenzo Bianconi wrote:
> > Hello Shayne Chen,
> >=20
> > This is a semi-automatic email about new static checker warnings.
> >=20
> > Commit 9890624c1b39 ("wifi: mt76: Check link_conf pointer in
> > mt76_connac_mcu_sta_basic_tlv()") from Mar 11, 2025, leads to the
> > following Smatch complaint:
> >=20
> > =C2=A0=C2=A0=C2=A0 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c=
:394
> > mt76_connac_mcu_sta_basic_tlv()
> > =C2=A0=C2=A0=C2=A0 warn: variable dereferenced before check 'link_conf'=
 (see line
> > 376)
> >=20
> > drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > =C2=A0=C2=A0 375	{
> > =C2=A0=C2=A0 376		struct ieee80211_vif *vif =3D link_conf->vif;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^
>=20
> Reviewing the codebase, it seems to me it is safe to revert
> 9890624c1b39 since
> link_conf is always not NULL running mt76_connac_mcu_sta_basic_tlv().
> @Shayne Chen: agree?
>=20
link_conf won't be NULL in this function at the moment, but it could be
NULL after adding "MLO reconfiguration" support. So in our internal
tree, we directly pass struct ieee80211_vif to this function.

Both methods are fine to me, what do you think?

Regards,
Shayne

> Regards,
> Lorenzo
>=20
> > Dereferenced.
> >=20
> > =C2=A0=C2=A0 377		struct sta_rec_basic *basic;
> > =C2=A0=C2=A0 378		struct tlv *tlv;
> > =C2=A0=C2=A0 379		int conn_type;
> > =C2=A0=C2=A0 380=09
> > =C2=A0=C2=A0 381		tlv =3D mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC,
> > sizeof(*basic));
> > =C2=A0=C2=A0 382=09
> > =C2=A0=C2=A0 383		basic =3D (struct sta_rec_basic *)tlv;
> > =C2=A0=C2=A0 384		basic->extra_info =3D cpu_to_le16(EXTRA_INFO_VER);
> > =C2=A0=C2=A0 385=09
> > =C2=A0=C2=A0 386		if (newly && conn_state !=3D CONN_STATE_DISCONNECT)
> > =C2=A0=C2=A0 387			basic->extra_info |=3D
> > cpu_to_le16(EXTRA_INFO_NEW);
> > =C2=A0=C2=A0 388		basic->conn_state =3D conn_state;
> > =C2=A0=C2=A0 389=09
> > =C2=A0=C2=A0 390		if (!link_sta) {
> > =C2=A0=C2=A0 391			basic->conn_type =3D
> > cpu_to_le32(CONNECTION_INFRA_BC);
> > =C2=A0=C2=A0 392=09
> > =C2=A0=C2=A0 393			if (vif->type =3D=3D NL80211_IFTYPE_STATION &&
> > =C2=A0=C2=A0 394			=C2=A0=C2=A0=C2=A0 link_conf &&
> > !is_zero_ether_addr(link_conf->bssid)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^^^^^^^^^
> > The patch adds a NULL dereference but it's too late.
> >=20
> > =C2=A0=C2=A0 395				memcpy(basic->peer_addr,
> > link_conf->bssid, ETH_ALEN);
> > =C2=A0=C2=A0 396				basic->aid =3D cpu_to_le16(vif-
> > >cfg.aid);
> >=20
> > regards,
> > dan carpenter
> >=20


