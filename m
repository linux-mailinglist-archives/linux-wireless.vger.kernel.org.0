Return-Path: <linux-wireless+bounces-24781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46CBAF673E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 03:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1424C4A734E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257845009;
	Thu,  3 Jul 2025 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rm2EqQIv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1124B26
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506873; cv=none; b=f6Iu7DdQyuxP8i6od6+VF0MNarvRRnR1Vsj1MAXkEXkbaLuuleGaYiyoqyvcYfMNbzONBE8tC074p5zpzhtjvZ7xoQJyYDWO/vCaMa/VppKAZCnRTjTGoLD2oqRaeqWlKlJESIlEcE2WohGA/BYSH3AV3d9ouMttxAL4gEATqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506873; c=relaxed/simple;
	bh=TV1TFdaES918kkyGvC7VR2bzxava0AY06W5g62VEFas=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1YSx5l5HuCyaW0+2yZZI3dMPR6smT9bmv7eWGGJeqLszS7zMHGak8O2U1c+uA965EZ7RUgkBCIH3823Khdw9caUSJvC2mac86V6FKoHFyTrLn8vsS3KJAmyWFGVlE+e1e1zwfFaXHKLnrlCEWZoVU8cyHuPWxdlNzu6tkT2NvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rm2EqQIv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c8f40bb257ae11f0b1510d84776b8c0b-20250703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TV1TFdaES918kkyGvC7VR2bzxava0AY06W5g62VEFas=;
	b=rm2EqQIv7Tu0mZb4a0GSBY5NstNEn94r0a/5mSghubLjrHbQufx/ySPQOAUYNHF0LUIH7VuNlTvj7qX3MqeKaF9gStuHUhj1VzIWE/pT40RIrn9jnscdAdvfAb5nWXzk8Yf6Muz/CDz/dX/OELd1hssmFnTrS0WvIwpmeZeA4Lw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:f484561b-53cb-451f-bc87-cd0e200ee624,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:6530d273-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c8f40bb257ae11f0b1510d84776b8c0b-20250703
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1168072121; Thu, 03 Jul 2025 09:41:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 3 Jul 2025 09:41:03 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Thu, 3 Jul 2025 09:41:03 +0800
Message-ID: <54df1d3fe61bb861b97c897aaa4a2a3e08f71e62.camel@mediatek.com>
Subject: Re: [PATCH] wifi: mac80211: determine missing link_id in
 ieee80211_rx_for_interface() based on band
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless
	<linux-wireless@vger.kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
	<Evelyn.Tsai@mediatek.com>, Money Wang
 =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?= <Money.Wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Date: Thu, 3 Jul 2025 09:41:04 +0800
In-Reply-To: <6c666ab6d83ba45f9f15643eeffed5d0f4770867.camel@sipsolutions.net>
References: <20250702104403.2738634-1-michael-cy.lee@mediatek.com>
	 <6c666ab6d83ba45f9f15643eeffed5d0f4770867.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 12:52 +0200, Johannes Berg wrote:
>=20
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
>=20
>=20
> On Wed, 2025-07-02 at 18:44 +0800, Michael-CY Lee wrote:
> > For broadcast frames, every interface might have to process it and
> > therefore the link_id cannot be determined in the driver.
> >=20
> > When the frame is about to be forwarded to each interface, we can
> > use the member "band" in struct ieee80211_rx_status to determine
> > the
> > "link_id" for each interface.
>=20
> Hm. Qualcomm has a similar thing with frequency, I think, and that
> probably makes more sense for them since 'band' isn't unique for the
> radio:
>=20
> https://lore.kernel.org/linux-wireless/20250612121127.1960948-3-maharaja.=
kennadyrajan@oss.qualcomm.com/
>=20
> Or is it not related?
>=20
> johannes

Hi Johannes,

I think they're related but address different issues about group-
addressed frames.

The Qualcomm patch seems to focus on preventing frames from getting
processed on an interface running on a different band. (referred from
their commit message)
For example, a frame from frequency 6135 MHz should not be processed by
an interface that does not have a link on frequency 6135 MHz.

On the other hand, the problem we encountered is that the interface is
going to process the frame, but the "status->link_valid" is unset
because the driver is incapable of determining the "link_id". The
"link_id" remains its default value of -1, and the frame is handled by
the interface's default link and is dropped because an AP MLD interface
is not using its default link (sdata->deflink).

In summary, the Qualcomm patch focuses on avoiding frames being
processed by unsuitable interfaces, while our patch aims to determine
the "link_id" so that the interface can correctly handle it.

Additionally, we also think the 'link_id' can be determined based on
'freq' rather than 'band'. What do you think?

Best,
Michael


