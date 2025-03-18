Return-Path: <linux-wireless+bounces-20487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43781A66E3D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9463B185A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309A13C8F3;
	Tue, 18 Mar 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kQpLHWWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A042C0B
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286659; cv=none; b=iBgKZRKtfCTbkVl1Xq5EvLpAGcpQK5rOXULvfFvJzahew1f+ur5oE5SiJoIiCpclNuOuYpUO+1Msb6ycWUNWj+1a040GJqIZuYFR8APGbyAksWVOu/O72fhTEWDaC8kb55PXRyaI24t7WeD5v9bF+8BfZSdjGKdyxsVSEHyRp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286659; c=relaxed/simple;
	bh=ADnmFXFeM1/2YdPFG8HlA3L1YPgI8t5WD1M+og9aon4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iocDRf1RrA2ax/U1dlPiw/TUaF/ib/QZwAwwE4U3QDsb9uNYhFeSeMlTyRf9ZiL20RfI60QModSMOwwrjYNEDmiVf07HZgHCrG7f4+Q/epnImuhODZlNiuEpinXfJVoU5GQ6v6BYIWOTo1K583RHy+SPSHatFB3D8FH76pV+mMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kQpLHWWJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4dc723cc03d311f0aae1fd9735fae912-20250318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ADnmFXFeM1/2YdPFG8HlA3L1YPgI8t5WD1M+og9aon4=;
	b=kQpLHWWJ0FQnHPDGf+NzIqPlSDDM+JhEa/NJ8rZq3YifWCE+bIlZ0GgnkJ0Dl6WGWo3SJGWMvwrC1xBzMhrZOeNkWLaMAXXphD+1YsgWw85/6PzZfeqDCxhZZ0jvy7ZvTjJD60T25aKaZBG7KnDFmE2HhcGowkUJuDQXm2WotcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:3a785ff4-7101-4679-ae56-bca9bbcc4e76,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:5c264de1-3561-4519-9a12-e2c881788b70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4dc723cc03d311f0aae1fd9735fae912-20250318
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 240455289; Tue, 18 Mar 2025 16:30:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 18 Mar 2025 16:30:51 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Tue, 18 Mar 2025 16:30:51 +0800
Message-ID: <d584cae48470cf08b1029e0fef1383f92444970b.camel@mediatek.com>
Subject: Re: [PATCH 20/21] wifi: mt76: mt7996: rework mt7996_ampdu_action to
 support MLO
From: Shayne Chen <shayne.chen@mediatek.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Ryder
 Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Johannes
 Berg <johannes@sipsolutions.net>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Date: Tue, 18 Mar 2025 16:30:51 +0800
In-Reply-To: <38ab11261debaf7e0884080031412808396eea5b.camel@mediatek.com>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
	 <20250312-b4-mt7996-mlo-p2-v1-20-015b3d6fd928@kernel.org>
	 <38ab11261debaf7e0884080031412808396eea5b.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Lorenzo,

Sorry, please ignore the previous mail.
I just aware that the deflink is now used as the primary/assoc link, so
it should work.

Regards,
Shayne

On Tue, 2025-03-18 at 14:28 +0800, Shayne Chen wrote:
> Hi Lorenzo,
>=20
> On Wed, 2025-03-12 at 12:14 +0100, Lorenzo Bianconi wrote:
> >=20
>=20
> Regards,
> Shayne


