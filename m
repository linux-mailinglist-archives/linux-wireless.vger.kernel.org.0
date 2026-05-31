Return-Path: <linux-wireless+bounces-37215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLihHpaRHGpdPQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 21:52:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9C617C4C
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 21:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6442E30022FC
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6E2F3C07;
	Sun, 31 May 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hD8w1Syj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VkFGIjkQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777FE33D4F3;
	Sun, 31 May 2026 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257170; cv=fail; b=aALebVBjEfl9TqKaOi67QHHCM3CjuwomYsBMb0bVWJpPDmQxmyfQkYDuJERfc6um+Jbwcs7HGcvSWZyPIL2nkA4bIQqBWUQe8Hcw2jzKeCgjzItX6fU14pG8SB3anNyKezOZofJ7jNLYy/nfnSrQg82aTP/vVAJruUOcnqYGMp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257170; c=relaxed/simple;
	bh=6+AFgEQ+PAPz47/S59YhZqWLe1/qv/y8uh54iL9k3CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBoIISvQLjQiQXnlydHKcyGTuosryccCYRmNnAkbqWNRuSTLODAJ5bdXaG7fjpKpylXcqn/0AIBWzxKALfyDSiHPnh7v25pYwDKg72YEgEDuakFz3BLHqmk6P8lTeG+xtFpq6yoOUbZOmmmVM+8tbuOc8cGYuq1xpWFAWOBf3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hD8w1Syj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VkFGIjkQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 481f722e5d2a11f18dc8c9802ae25ab1-20260601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6+AFgEQ+PAPz47/S59YhZqWLe1/qv/y8uh54iL9k3CA=;
	b=hD8w1Syj+wwVR4ufTQ+pK2pfH7OhyuDNDfhfDjzaBpKH929KZv4UIVRf9YXljpu49Ync7JqxTa5qk/LsyGNLzf6+DwFAm+3aP0DxccpwzuC0COa/is71c5QNdbXR/7j4Ui45u6M/OhgCdBw2/bBZiIGX67exbDx/fxTbiHT4UtM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:a488fdf5-d7fc-43f0-9fd4-a88b07772e92,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:7c208230-3aec-4081-ae32-d2e919a47e1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|136|836|865|
	888|898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:ni
	l,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 481f722e5d2a11f18dc8c9802ae25ab1-20260601
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 164644158; Mon, 01 Jun 2026 03:52:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Jun 2026 03:52:39 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 1 Jun 2026 03:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDkVP+p8bUdBg2L4xRpFsXQ32Jlkcm27kxqIzv1j5kZocSUfPrI9nH2+eO5NUywut/p/RSTn8+YFqUM+AK5UubvpUmu5lI81fZ7SOPYPYbpWifAaPE2zKEMm8F9geMk8dRGuvWeqQup/R1e6055tW8H6Ss8TORD5t4IXfRNNlP42yeovsWiR/2L6sZ7dmpxih1/w6k7+3hUbGM2OxkHxqgsoMrI7KqJpZQZanEJgK6IwPRfPwu+nO4I9UM7bwajZ7TrfDl1CI9IzAL/eQaZDlkNPYKVWVL76EcAXjdhfrApxDT8ucuhJdyztI6PuvF/Adfr7cBVRSaLe3/6lzFF/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+AFgEQ+PAPz47/S59YhZqWLe1/qv/y8uh54iL9k3CA=;
 b=cGOmL1mgQrf9uiEBH1ujkED4SwR9tJSUuom7pmmdiFhllqI13qg7fr2N8PL4VOC7t6Y/vgnYiuuZaO96LZxvNCSZYnG/DBcr3ENs8q9/ZFBc+ILuhcQRbK4VYzV+HR0OSqAEuh2MS3OTcTY7Z1Uy2roP321WvWLI2vx1iy0+7HqyVVzmRq7scOUqAHpoMsGWEao9EsCNmYewWXyljJrsRDvBo/yWjAfD6NQRyaOuysr3I7FZyoqYFxd3xGGT4mnQxo/T219LMI/zNfnouXIrqhzFQruE1OfwJzJBqFbJQmYTvbVtMvqLPCUPF+tTCMhDBfE/YO+g/7rezPiAphub1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+AFgEQ+PAPz47/S59YhZqWLe1/qv/y8uh54iL9k3CA=;
 b=VkFGIjkQEZFPTYUgnrQsl2FcXu6UAo6GnFNjd2rf7WrOA1nIIjq3EPV2y8idAo7hgs2VZboqqY33dw0vepHfbXW9iOWLQqOKBbT+7nQbimTeLx1DE9an2W9GNONd5IH4L0I1rgHdBOU9cpSS5ISUcb52cgI1VZAXr2nZoyARUeU=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by PS1PPFB74B4D42D.apcprd03.prod.outlook.com (2603:1096:308::2e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.4; Sun, 31 May 2026
 19:52:36 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%6]) with mapi id 15.21.0092.005; Sun, 31 May 2026
 19:52:36 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	=?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?=
	<Chui-hao.Chiu@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Topic: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Index: AQHc8NtWBQF4NsneqEql9Op9RanVZrYn7TOAgAAeR4CAAATmgIAADDAAgABvxoA=
Date: Sun, 31 May 2026 19:52:36 +0000
Message-ID: <7f02be7c4f919413718a0218b3792d4b0a222ca3.camel@mediatek.com>
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
	 <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
	 <ahwla_obwnwr2cZo@lore-desk>
	 <44c54ed4da0d294c567b3b0ad750f082a6f1be9f.camel@mediatek.com>
	 <ahwzwHDF7fT9t7hP@lore-desk>
In-Reply-To: <ahwzwHDF7fT9t7hP@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|PS1PPFB74B4D42D:EE_
x-ms-office365-filtering-correlation-id: b66cd214-344f-4bc8-7146-08debf4e29ba
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|11063799006|4143699003|18002099003|22082099003|6133799003|56012099006|38070700021;
x-microsoft-antispam-message-info: SAuBi04xkJrnE9XrVOalm7D1wDnB9RjBe3MS2iyTFX8oCd6S3hSnqvO3tDX2etukLCuTbxt7kQcoZ6CX4jLOZnCLwpPMaU48ITAJ3P/5gnVExPiMst9KxvB6rTzyFMUCfvUOnqfY/XiGAYHuVlie7GhuIxbldUkiHYU4oTHVxctiFOwQboBECz4wcepG7ubECsnjvfhhW2Xm7SdWEfUhk4qLhydJky4Ev1nTIginREOcBbt6VUhLjTBaKBa96GJPG4Ye1chs0BZBtVyJFtvGbAEZulj89K7UMksOYxoW3+J2f6BT67zPWnyW7yZlZdUFr0gr5TuqpTs3ucb0mN8ubMsClTioKBajJ/LJnwWP/kc1tqmAnjF1dsinT6iSYxNqV5jI/0dEK2kn7XjmYamAPB0K1UauwNEMrDNdUHWcSHi31uNOnmTdPi2KkcXm7Esc5ZRKGZzbAgh/YCzLEaYOA0wRnP2lOOBSOGjQwC8xV4dfZlHF57LuU9v8ybqFkSuNjGDC+yd6bmprlzwSxP7USPEqP6zRX9wzaedMArllCFrAe9mZE7MtUdlBNSO0pSv2CpxSRdW2u+W5FPtK0giCVU165oQwK5H/wR0eqwhRLpntrnJppgUMWMYmx4uu3xLU5Gr1P/fVJ2DLQmrc9yWpOeVFlLYMQUZMPeRNm/kprVWIei0EfWTSDrcpYpks6HmItSchERvBX2GDtIJ4BynNCjiTxmPxLcarTy9A2dCWqK5RUjiDvAqS1D3zjQGpMQbQ9WXkoSZJeid7sGfAkQDO4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG5TWXpnaHZlZ05LNUczcnNwS3VLOHo1Q3l3N290blQ3aUI0V2Y4eFlvSTR3?=
 =?utf-8?B?WHQyNG1pL1o3cXIzL1lZR1o2SHNyNVMyTXNzeEYxUWFubXBtdzNkWHhiWVhQ?=
 =?utf-8?B?T096aW1VK0xxakFNRlZRckgxTnNBQXhrSW5nM2NxUEFuMGQ3aU9wMWdVQVhO?=
 =?utf-8?B?SWVBOFpqcG1sSnpFenFxOWJ3bU9rbHJVM0ZjQWpZL2cyWUpiNVZnd1Z2bFlZ?=
 =?utf-8?B?YmFVT1d2UzFZY3lNMHBaWGduVUFsL2p1TzAvVS9MaWppTWVOQVdQWUNFWDF5?=
 =?utf-8?B?c1FCU1FSOXM4anROQUF3MmtGNHd1ODhDYWo1UzZrK1RVY3dCaUJtOVVGeWlH?=
 =?utf-8?B?NDFFSHJTU1RxcWt6aTdBa2dOSG1XYUNaTHM1ODRWWGd2L2lqVUczZWZrZFZ2?=
 =?utf-8?B?enk1aHdYZmVWaStiS1VmQ3hSbWV2dUl2UlNQeUdqaFN4WlJsTVNnMWlRakhR?=
 =?utf-8?B?bitrMHA3VG5NMFBZaFBrMU1XckRGQmtGMDhzcGdjTTUxR1A4WFllSEwyUSts?=
 =?utf-8?B?MWJYb29tRTV0QjA2OXExWnpmZXkweWYvbkY2WkFxNXN2cGZnVmdwZWRNZW94?=
 =?utf-8?B?Um1iNnUvZXM4UkdOdHRrSjZBRjhCc3JRaHJnZ3hpaU4xNEg0am90RVJzU2Vh?=
 =?utf-8?B?UkZGYkFOdlYyUFZ5ZDN1YjdUN3dOYXUzNVp4KzBrWkhjWjc4TjBUSG9sSGdr?=
 =?utf-8?B?RldseEFwV0JTektEZE0xY3h4T0lSbVc3TnZKMHoyNXhzR0V4ajJsSlVXMFVi?=
 =?utf-8?B?MVhXdlpRSzNWL05IUUpMbnFRSGtCRUZCZXdQbWIrV3htQ2czcXFkcFR0Q0pD?=
 =?utf-8?B?SHRtc3dCOGJ6RDU3VUZBeGNHK0ZQVUdsWUdDOGhMR1hJTnRQUzhHa3l3dTB0?=
 =?utf-8?B?S2NmQ2x3b2tWOW5EbmFyVXJ5SmxnSDB6Mm03bTJyVVRROFJSN2k0bWROZVVP?=
 =?utf-8?B?SEt3cEhEazlMOGpwOXJsUnFHMVBkbktkV0piS3YvL3E2OEYzcThpV3cyYktz?=
 =?utf-8?B?ekJ1WUFkWTdlOW1JZ0hBNlFtc0tDTVZyWXBKVjRwYVFZR21BbVJJUitaQU4z?=
 =?utf-8?B?RHFpSDBmdEYxT1dEd2h0TzFTZy9pSWhNWlFuVmRYRXUxZFBTK2pWL3NJQ0Fi?=
 =?utf-8?B?dHFIblU2R3FOc2JVZmZON1pwTW5rdDZLNHdlMDVJckRJdm9wWDdKUEI1S2ZP?=
 =?utf-8?B?WStpYUFJM2lMbjBWaHMrSWtsQ25jQkxpQWZsOGhmRUFIWFpuNFNSalp4V1J2?=
 =?utf-8?B?bVdRenBYaldaNksrUjVMcndmak5JemFvVDU0MmxQSXdYWEpiR1VlNllLcDRx?=
 =?utf-8?B?VWxKaTk0QldwN3FuVmVGdEtFK2NKNTVJLzFoWGVKQW14TlhXN05UY1pVRGo4?=
 =?utf-8?B?VytDL21DeTB3WkN6TnNtRkdFbWJvK0Mxb0lDYlRmQUhBeHNxa2FEejJGVXZD?=
 =?utf-8?B?U1ZQVVJWQzArU1ZCU0VoanJpQkdVRllJZGJIaVU4Y1JwSlprV000cTFXa1pk?=
 =?utf-8?B?VVlmbWhQQjQ0WDg1TFpEQ0djQ1g2TUQ3UGVrR1c3ZE1Ic0tMdlpyL20rRE9p?=
 =?utf-8?B?Um1DaWpJUkd0T2NKV01MSFFzVHUyNjJOZTd2REZrK3BxeGg5RC9zWGlCZXV4?=
 =?utf-8?B?VnkrOUtNZ2hVR3FJeDNaOUwyVUJ6VnkwNXpYeGduUVFDYnUveko5b1ZURHBs?=
 =?utf-8?B?dWhMRmZsZ1cvRzdaTFFBYTl3b2FkSW0vWUpxZ1FmcWNGR2tBQzZYSmtzSDVp?=
 =?utf-8?B?QzZpdXNEZHNIWEJVbGFwS1BRYjZ6SEhSQlF1MjdCUHRFNUNpWHQ4MGl2SE9W?=
 =?utf-8?B?TnhTZGFxZTRDeVdmRHl6NUl3U3IwblNSQkN6dEFGQ3lDNGpyQnRBNW9VWFRl?=
 =?utf-8?B?WE5mSTdmNnNkT1RsZ1c1L0Z6SjZhdERJdHNQU2RTQlowZ1J4a2FBVWxta25N?=
 =?utf-8?B?Y3FIeHMvYUpUbGpaTDh1T3hsRnAwbkEvWDBhYmt6emJGblFxSytXVXVSdXov?=
 =?utf-8?B?aE1JY2NweE9ZdUVjQ3NmNStKNWV0ZGZCMm5yTVhuVnNsWlpXd3JkQXk1d0RY?=
 =?utf-8?B?QjNRclBVa2MrZ2NrQVd5amptUnRoQm95clZycHVHcEw2bkoxcDR2b0tWc0Vu?=
 =?utf-8?B?YnVKaUlNN3l5STJZaXRFRldaSUZvRzY2eHdyWVBmNEcvcnZrOFI3Z0ZpZmN6?=
 =?utf-8?B?SGNNRExtenNCbXA2MUZ3T2xUallHSjBlVU9PZldHeXFxRndjWmhZRXZ6WG1E?=
 =?utf-8?B?NEJCVDgvbGxVWDM4YXBkY3NFU2svUGpONFNwYmRnWEJWdlpKV1hNTVI3MFNj?=
 =?utf-8?B?OGJpSXdLQXdkSmh4WFYvaitTOG42dmRmVlo0ekpDN3lUY3lLOFRLMmRtU2pQ?=
 =?utf-8?Q?9koMHPIZ9AsqhjGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F5FE3761B308240BBFEB6FAF5B9C17B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W65VHKDLzNS4+1PEk21DF2hIAE0vrzOCCXml3AUSB8/LWGRiLaCms2ZTGPzs3nI4r+lHRouGWitGk2k0ecGCtw3GlBeVUeRKJb7vkUSAnsnindwirFju5dVW4aXWsRrbrF/hoxPthxEAURTZ3JKmXaLsqv+yh40MC34t9ot9r10ni1g1Z7e8dTVuwV8hjuAjRVbWsJQyFsCDKTqyw5pPQCp6Nd6Du48Lq2fLhdkD1ymccvtQ1wXyGYf7t+pprnrEpBYGrjD9rAvAIdE4lsyPdg4t4aw6nOc124MDLdaoV5F6ZH+TDdpIyoDxlG0Gr/P87vTaZ8O8fZ/zmJqZoPi40Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66cd214-344f-4bc8-7146-08debf4e29ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 19:52:36.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RHUI9DZTEfbiPI8aFzNEVVtYciHynPWPZ1wWsrM7njCajJyIu+ryC23vSRG0qdt1hDQg98Sxjw0V5EfHrIhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFB74B4D42D
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37215-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,collabora.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8FD9C617C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU3VuLCAyMDI2LTA1LTMxIGF0IDE1OjEyICswMjAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IE9uIE1heSAzMSwgUnlkZXIgTGVlIHdyb3RlOg0KPiA+IE9uIFN1biwgMjAyNi0wNS0z
MSBhdCAxNDoxMSArMDIwMCwgbG9yZW56b0BrZXJuZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gT24g
U3VuLCAyMDI2LTA1LTMxIGF0IDEwOjU1ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0K
PiA+ID4gPiA+IG10NzZfdHhfc3RhdHVzX3NrYl9hZGQoKSB6ZXJvZXMgdGhlIG10NzZfdHhfY2Ig
c3RydWN0IHN0b3JlZA0KPiA+ID4gPiA+IGF0DQo+ID4gPiA+ID4gaW5mby0+c3RhdHVzLnN0YXR1
c19kcml2ZXJfZGF0YSB2aWEgbWVtc2V0KCkuIFNpbmNlIGluZm8tDQo+ID4gPiA+ID4gPmNvbnRy
b2wNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiBpbmZvLT5zdGF0dXMgYXJlIG1lbWJlcnMgb2Yg
dGhlIHNhbWUgdW5pb24gaW4NCj4gPiA+ID4gPiBpZWVlODAyMTFfdHhfaW5mbywNCj4gPiA+ID4g
PiB0aGlzIG92ZXJ3cml0ZXMgaW5mby0+Y29udHJvbC5mbGFncy4NCj4gPiA+ID4gPiBJbiBtdDc5
OTZfdHhfcHJlcGFyZV9za2IoKSwgbXQ3Nl90eF9zdGF0dXNfc2tiX2FkZCgpIGlzDQo+ID4gPiA+
ID4gY2FsbGVkDQo+ID4gPiA+ID4gYmVmb3JlDQo+ID4gPiA+ID4gbXQ3OTk2X21hY193cml0ZV90
eHdpKCksIHdoaWNoIHJlLXJlYWRzIGluZm8tPmNvbnRyb2wuZmxhZ3MNCj4gPiA+ID4gPiB0bw0K
PiA+ID4gPiA+IGV4dHJhY3QNCj4gPiA+ID4gPiBJRUVFODAyMTFfVFhfQ1RSTF9NTE9fTElOSy4g
QmVjYXVzZSB0aGUgZmllbGQgaGFzIGJlZW4NCj4gPiA+ID4gPiB6ZXJvZWQsDQo+ID4gPiA+ID4g
dGhlDQo+ID4gPiA+ID4gbGlua19pZCBhbHdheXMgcmVzb2x2ZXMgdG8gMCBmb3IgZnJhbWVzIHVz
aW5nIGdsb2JhbF93Y2lkLA0KPiA+ID4gPiA+IGxlYWRpbmcgdG8NCj4gPiA+ID4gPiBpbmNvcnJl
Y3QgVFhXSSBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiA+IEZpeCB0aGlzIGJ5IHBhc3NpbmcgbGlu
a19pZCBhcyBhbiBleHBsaWNpdCBwYXJhbWV0ZXIgdG8NCj4gPiA+ID4gPiBtdDc5OTZfbWFjX3dy
aXRlX3R4d2koKS4gSW4gbXQ3OTk2X3R4X3ByZXBhcmVfc2tiKCksIHRoZQ0KPiA+ID4gPiA+IGxp
bmtfaWQNCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IGFscmVhZHkgZXh0cmFjdGVkIGZyb20gaW5m
by0+Y29udHJvbC5mbGFncyBiZWZvcmUgdGhlDQo+ID4gPiA+ID4gZGVzdHJ1Y3RpdmUNCj4gPiA+
ID4gPiBtdDc2X3R4X3N0YXR1c19za2JfYWRkKCkgY2FsbC4gRm9yIHRoZSBiZWFjb24gYW5kIGlu
YmFuZA0KPiA+ID4gPiA+IGRpc2NvdmVyeQ0KPiA+ID4gPiA+IGNhbGxlcnMgaW4gbWN1LmMsIHVz
ZSBsaW5rX2NvbmYtPmxpbmtfaWQgZGlyZWN0bHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRml4
ZXM6IGYwYjBiMjM5YjhmMzYgKCJ3aWZpOiBtdDc2OiBtdDc5OTY6IHJld29yaw0KPiA+ID4gPiA+
IG10Nzk5Nl9tYWNfd3JpdGVfdHh3aSgpIGZvciBNTE8gc3VwcG9ydCIpDQo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiA+ID4g
PiA+IC0tLQ0KPiA+ID4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiA+ID4gLSBEbyBub3QgdXNl
IGxpbmtfaWQgaW4gbXQ3OTk2X21hY193cml0ZV90eHdpIGlmIGl0IGlzDQo+ID4gPiA+ID4gSUVF
RTgwMjExX0xJTktfVU5TUEVDSUZJRUQNCj4gPiA+ID4gPiAtIEluIG10Nzk5Nl9tYWNfd3JpdGVf
dHh3aSgpIHJlbHkgb24gbGlua19pZCBjYWxjdWxhdGVkIGluDQo+ID4gPiA+ID4gwqAgbXQ3OTk2
X3R4X3ByZXBhcmVfc2tiKCkuDQo+ID4gPiA+ID4gLSBMaW5rIHRvIHYxOg0KPiA+ID4gPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MzAtbXQ3Nl90eF9zdGF0dXNfc2tiX2FkZC1v
dmVyd3JpdGUtZml4LXYxLTEtZTJjMzE1MWMzOTFhQGtlcm5lbC5vcmcNCj4gPiA+ID4gPiDCoA0K
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5OTYvbWFjLmPCoMKgwqAgfCAxNA0KPiA+ID4gPiA+ICsrKystLS0tDQo+ID4gPiA+
ID4gLS0tLQ0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuY8KgwqDCoCB8wqAgNSArKystDQo+ID4gPiA+ID4gLQ0K
PiA+ID4gPiA+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3
OTk2LmggfMKgIDMgKystDQo+ID4gPiA+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jDQo+ID4gPiA+
ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tYWMuYw0KPiA+
ID4gPiA+IGluZGV4IGM5ODQ0NjA1NzI4Mi4uOTViMzA3OGQ5NjY3IDEwMDY0NA0KPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jDQo+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bWFjLmMNCj4gPiA+ID4gPiBAQCAtODU2LDcgKzg1Niw4IEBAIG10Nzk5Nl9tYWNfd3JpdGVfdHh3
aV84MDIxMShzdHJ1Y3QNCj4gPiA+ID4gPiBtdDc5OTZfZGV2DQo+ID4gPiA+ID4gKmRldiwgX19s
ZTMyICp0eHdpLA0KPiA+ID4gPiA+IMKgdm9pZCBtdDc5OTZfbWFjX3dyaXRlX3R4d2koc3RydWN0
IG10Nzk5Nl9kZXYgKmRldiwgX19sZTMyDQo+ID4gPiA+ID4gKnR4d2ksDQo+ID4gPiA+ID4gwqAJ
CQnCoMKgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdA0KPiA+ID4gPiA+IG10NzZfd2NpZA0K
PiA+ID4gPiA+ICp3Y2lkLA0KPiA+ID4gPiA+IMKgCQkJwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX2tl
eV9jb25mICprZXksDQo+ID4gPiA+ID4gaW50DQo+ID4gPiA+ID4gcGlkLA0KPiA+ID4gPiA+IC0J
CQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlkLCB1MzINCj4gPiA+ID4gPiBjaGFuZ2VkKQ0KPiA+
ID4gPiA+ICsJCQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlkLCB1MzINCj4gPiA+ID4gPiBjaGFu
Z2VkLA0KPiA+ID4gPiA+ICsJCQnCoMKgIHVuc2lnbmVkIGludCBsaW5rX2lkKQ0KPiA+ID4gPiA+
IMKgew0KPiA+ID4gPiA+IMKgCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAoc3RydWN0IGll
ZWU4MDIxMV9oZHINCj4gPiA+ID4gPiAqKXNrYi0NCj4gPiA+ID4gPiA+IGRhdGE7DQo+ID4gPiA+
ID4gwqAJc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICppbmZvID0NCj4gPiA+ID4gPiBJRUVFODAy
MTFfU0tCX0NCKHNrYik7DQo+ID4gPiA+ID4gQEAgLTg2Niw3ICs4NjcsNiBAQCB2b2lkIG10Nzk5
Nl9tYWNfd3JpdGVfdHh3aShzdHJ1Y3QNCj4gPiA+ID4gPiBtdDc5OTZfZGV2DQo+ID4gPiA+ID4g
KmRldiwgX19sZTMyICp0eHdpLA0KPiA+ID4gPiA+IMKgCWJvb2wgaXNfODAyMyA9IGluZm8tPmZs
YWdzICYNCj4gPiA+ID4gPiBJRUVFODAyMTFfVFhfQ1RMX0hXXzgwMjExX0VOQ0FQOw0KPiA+ID4g
PiA+IMKgCXN0cnVjdCBtdDc2X3ZpZl9saW5rICptbGluayA9IE5VTEw7DQo+ID4gPiA+ID4gwqAJ
c3RydWN0IG10Nzk5Nl92aWYgKm12aWY7DQo+ID4gPiA+ID4gLQl1bnNpZ25lZCBpbnQgbGlua19p
ZDsNCj4gPiA+ID4gPiDCoAl1MTYgdHhfY291bnQgPSAxNTsNCj4gPiA+ID4gPiDCoAl1MzIgdmFs
Ow0KPiA+ID4gPiA+IMKgCWJvb2wgaW5iYW5kX2Rpc2MgPSAhIShjaGFuZ2VkICYNCj4gPiA+ID4g
PiAoQlNTX0NIQU5HRURfVU5TT0xfQkNBU1RfUFJPQkVfUkVTUCB8DQo+ID4gPiA+ID4gQEAgLTg3
NCwxNyArODc0LDExIEBAIHZvaWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdA0KPiA+ID4g
PiA+IG10Nzk5Nl9kZXYNCj4gPiA+ID4gPiAqZGV2LCBfX2xlMzIgKnR4d2ksDQo+ID4gPiA+ID4g
wqAJYm9vbCBiZWFjb24gPSAhIShjaGFuZ2VkICYgKEJTU19DSEFOR0VEX0JFQUNPTiB8DQo+ID4g
PiA+ID4gwqAJCQkJwqDCoMKgDQo+ID4gPiA+ID4gQlNTX0NIQU5HRURfQkVBQ09OX0VOQUJMRUQp
KQ0KPiA+ID4gPiA+ICYmDQo+ID4gPiA+ID4gKCFpbmJhbmRfZGlzYyk7DQo+ID4gPiA+ID4gwqAN
Cj4gPiA+ID4gPiAtCWlmICh3Y2lkICE9ICZkZXYtPm10NzYuZ2xvYmFsX3djaWQpDQo+ID4gPiA+
ID4gLQkJbGlua19pZCA9IHdjaWQtPmxpbmtfaWQ7DQo+ID4gPiA+ID4gLQllbHNlDQo+ID4gPiA+
ID4gLQkJbGlua19pZCA9IHUzMl9nZXRfYml0cyhpbmZvLT5jb250cm9sLmZsYWdzLA0KPiA+ID4g
PiA+IC0JCQkJwqDCoMKgwqDCoMKgDQo+ID4gPiA+ID4gSUVFRTgwMjExX1RYX0NUUkxfTUxPX0xJ
TkspOw0KPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiDCoAltdmlmID0gdmlmID8gKHN0cnVjdCBtdDc5
OTZfdmlmICopdmlmLT5kcnZfcHJpdiA6DQo+ID4gPiA+ID4gTlVMTDsNCj4gPiA+ID4gPiDCoAlp
ZiAobXZpZikgew0KPiA+ID4gPiA+IMKgCQlpZiAod2NpZC0+b2ZmY2hhbm5lbCkNCj4gPiA+ID4g
PiDCoAkJCW1saW5rID0gcmN1X2RlcmVmZXJlbmNlKG12aWYtDQo+ID4gPiA+ID4gPiBtdDc2Lm9m
ZmNoYW5uZWxfbGluayk7DQo+ID4gPiA+ID4gLQkJaWYgKCFtbGluaykNCj4gPiA+ID4gPiArCQlp
ZiAoIW1saW5rICYmIGxpbmtfaWQgIT0NCj4gPiA+ID4gPiBJRUVFODAyMTFfTElOS19VTlNQRUNJ
RklFRCkNCj4gPiA+ID4gPiDCoAkJCW1saW5rID0gcmN1X2RlcmVmZXJlbmNlKG12aWYtDQo+ID4g
PiA+ID4gPiBtdDc2LmxpbmtbbGlua19pZF0pOw0KPiA+ID4gPiA+IMKgCX0NCj4gPiA+ID4gPiDC
oA0KPiA+ID4gPiA+IEBAIC0xMDk2LDcgKzEwOTAsNyBAQCBpbnQgbXQ3OTk2X3R4X3ByZXBhcmVf
c2tiKHN0cnVjdA0KPiA+ID4gPiA+IG10NzZfZGV2DQo+ID4gPiA+ID4gKm1kZXYsIHZvaWQgKnR4
d2lfcHRyLA0KPiA+ID4gPiA+IMKgCS8qIFRyYW5zbWl0IG5vbiBxb3MgZGF0YSBieSA4MDIuMTEg
aGVhZGVyIGFuZCBuZWVkDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiBmaWxsDQo+ID4gPiA+ID4g
dHhkIGJ5IGhvc3QqLw0KPiA+ID4gPiA+IMKgCWlmICghaXNfODAyMyB8fCBwaWQgPj0gTVRfUEFD
S0VUX0lEX0ZJUlNUKQ0KPiA+ID4gPiA+IMKgCQltdDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCB0
eHdpX3B0ciwNCj4gPiA+ID4gPiB0eF9pbmZvLQ0KPiA+ID4gPiA+ID4gc2tiLA0KPiA+ID4gPiA+
IHdjaWQsIGtleSwNCj4gPiA+ID4gPiAtCQkJCcKgwqDCoMKgwqAgcGlkLCBxaWQsIDApOw0KPiA+
ID4gPiA+ICsJCQkJwqDCoMKgwqDCoCBwaWQsIHFpZCwgMCwgbGlua19pZCk7DQo+ID4gPiA+ID4g
wqANCj4gPiA+ID4gPiDCoAkvKiBNVDc5OTYgYW5kIE1UNzk5MiByZXF1aXJlIGRyaXZlciB0byBw
cm92aWRlIHRoZQ0KPiA+ID4gPiA+IE1BQw0KPiA+ID4gPiA+IFRYUA0KPiA+ID4gPiA+IGZvciBB
ZGRCQQ0KPiA+ID4gPiA+IMKgCSAqIHJlcQ0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+ID4gPiA+IGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gPiA+ID4gPiBp
bmRleCA4YmU0MGQ2MGFkMjkuLmExNGM2MzQzODkyMyAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jDQo+
ID4gPiA+ID4gQEAgLTMxMDMsNyArMzEwMyw3IEBAIG10Nzk5Nl9tY3VfYmVhY29uX2NvbnQoc3Ry
dWN0DQo+ID4gPiA+ID4gbXQ3OTk2X2Rldg0KPiA+ID4gPiA+ICpkZXYsDQo+ID4gPiA+ID4gwqAN
Cj4gPiA+ID4gPiDCoAlidWYgPSAodTggKiliY24gKyBzaXplb2YoKmJjbik7DQo+ID4gPiA+ID4g
wqAJbXQ3OTk2X21hY193cml0ZV90eHdpKGRldiwgKF9fbGUzMiAqKWJ1Ziwgc2tiLCB3Y2lkLA0K
PiA+ID4gPiA+IE5VTEwsDQo+ID4gPiA+ID4gMCwgMCwNCj4gPiA+ID4gPiAtCQkJwqDCoMKgwqDC
oCBCU1NfQ0hBTkdFRF9CRUFDT04pOw0KPiA+ID4gPiA+ICsJCQnCoMKgwqDCoMKgIEJTU19DSEFO
R0VEX0JFQUNPTiwgbGlua19jb25mLQ0KPiA+ID4gPiA+ID4gbGlua19pZCk7DQo+ID4gPiA+ID4g
wqANCj4gPiA+ID4gPiDCoAltZW1jcHkoYnVmICsgTVRfVFhEX1NJWkUsIHNrYi0+ZGF0YSwgc2ti
LT5sZW4pOw0KPiA+ID4gPiA+IMKgfQ0KPiA+ID4gPiA+IEBAIC0zMjQ5LDcgKzMyNDksOCBAQCBp
bnQNCj4gPiA+ID4gPiBtdDc5OTZfbWN1X2JlYWNvbl9pbmJhbmRfZGlzY292KHN0cnVjdA0KPiA+
ID4gPiA+IG10Nzk5Nl9kZXYgKmRldiwNCj4gPiA+ID4gPiDCoA0KPiA+ID4gPiA+IMKgCWJ1ZiA9
ICh1OCAqKXRsdiArIHNpemVvZigqZGlzY292KTsNCj4gPiA+ID4gPiDCoA0KPiA+ID4gPiA+IC0J
bXQ3OTk2X21hY193cml0ZV90eHdpKGRldiwgKF9fbGUzMiAqKWJ1Ziwgc2tiLCB3Y2lkLA0KPiA+
ID4gPiA+IE5VTEwsDQo+ID4gPiA+ID4gMCwgMCwgY2hhbmdlZCk7DQo+ID4gPiA+ID4gKwltdDc5
OTZfbWFjX3dyaXRlX3R4d2koZGV2LCAoX19sZTMyICopYnVmLCBza2IsIHdjaWQsDQo+ID4gPiA+
ID4gTlVMTCwNCj4gPiA+ID4gPiAwLCAwLA0KPiA+ID4gPiA+ICsJCQnCoMKgwqDCoMKgIGNoYW5n
ZWQsIGxpbmtfY29uZi0+bGlua19pZCk7DQo+ID4gPiA+ID4gwqANCj4gPiA+ID4gPiDCoAltZW1j
cHkoYnVmICsgTVRfVFhEX1NJWkUsIHNrYi0+ZGF0YSwgc2tiLT5sZW4pOw0KPiA+ID4gPiA+IMKg
DQo+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gPiA+ID4gPiBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L210Nzk5Ni5oDQo+ID4gPiA+ID4gaW5kZXggMGRj
NDE5OGZjZjhiLi4wZDY0ODg1MjJiYTcgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gPiA+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaA0KPiA+
ID4gPiA+IEBAIC04NzQsNyArODc0LDggQEAgdm9pZCBtdDc5OTZfbWFjX2VuYWJsZV9uZihzdHJ1
Y3QNCj4gPiA+ID4gPiBtdDc5OTZfZGV2DQo+ID4gPiA+ID4gKmRldiwNCj4gPiA+ID4gPiB1OCBi
YW5kKTsNCj4gPiA+ID4gPiDCoHZvaWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5
OTZfZGV2ICpkZXYsIF9fbGUzMg0KPiA+ID4gPiA+ICp0eHdpLA0KPiA+ID4gPiA+IMKgCQkJwqDC
oCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QNCj4gPiA+ID4gPiBtdDc2X3djaWQNCj4gPiA+
ID4gPiAqd2NpZCwNCj4gPiA+ID4gPiDCoAkJCcKgwqAgc3RydWN0IGllZWU4MDIxMV9rZXlfY29u
ZiAqa2V5LA0KPiA+ID4gPiA+IGludA0KPiA+ID4gPiA+IHBpZCwNCj4gPiA+ID4gPiAtCQkJwqDC
oCBlbnVtIG10NzZfdHhxX2lkIHFpZCwgdTMyDQo+ID4gPiA+ID4gY2hhbmdlZCk7DQo+ID4gPiA+
ID4gKwkJCcKgwqAgZW51bSBtdDc2X3R4cV9pZCBxaWQsIHUzMg0KPiA+ID4gPiA+IGNoYW5nZWQs
DQo+ID4gPiA+ID4gKwkJCcKgwqAgdW5zaWduZWQgaW50IGxpbmtfaWQpOw0KPiA+ID4gPiA+IMKg
dm9pZCBtdDc5OTZfbWFjX3VwZGF0ZV9iZWFjb25zKHN0cnVjdCBtdDc5OTZfcGh5ICpwaHkpOw0K
PiA+ID4gPiA+IMKgdm9pZCBtdDc5OTZfbWFjX3NldF9jb3ZlcmFnZV9jbGFzcyhzdHJ1Y3QgbXQ3
OTk2X3BoeSAqcGh5KTsNCj4gPiA+ID4gPiDCoHZvaWQgbXQ3OTk2X21hY193b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yayk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
YmFzZS1jb21taXQ6IDQ5MTNmNDQxNjdjZjM1YTk1MzZlOWVlYzczNTJlMTViMmRlMGM1NzMNCj4g
PiA+ID4gPiBjaGFuZ2UtaWQ6IDIwMjYwNTMwLW10NzZfdHhfc3RhdHVzX3NrYl9hZGQtb3Zlcndy
aXRlLWZpeC0NCj4gPiA+ID4gPiA4NTgxOGE5YmIzMWYNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBC
ZXN0IHJlZ2FyZHMsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IFdlIG1pZ2h0IGV4
cGFuZCBmbGFncyBmdXJ0aGVyIHNvIHRoaXMgc3RpbGwgZG9lc24ndCBzb2x2ZSB0aGUNCj4gPiA+
ID4gaXNzdWUNCj4gPiA+ID4gb2YNCj4gPiA+ID4gZmxhZ3MgYmVpbmcgY2xlYXJlZCAtIGl0IG9u
bHkgd29ya3MgZm9yIE1MTyBmbGFnLiBBbmQgdGhlDQo+ID4gPiA+IGRldmVsb3BlcnMNCj4gPiA+
ID4gc3RpbGwgd29uJ3QgZWFzaWx5IG5vdGljZSB0aGF0IHRoZSBmbGFncyBhcmUgYmVpbmcgY2xl
YXJlZC4NCj4gPiA+IA0KPiA+ID4gTXkgb3BpbmlvbiBpcyB3ZSBzaG91bGQgY29uc2lkZXIganVz
dCB1cHN0cmVhbSBjb2RlIGFuZCB0aGVuDQo+ID4gPiBjaGFuZ2UNCj4gPiA+IGl0IGFzIHNvb24N
Cj4gPiA+IGFzIHlvdSBwb3N0IHRoaXMgbmV3IGZlYXR1cmUgdXBzdHJlYW0sIGJ1dCBJIHdpbGwg
bGV0IEZlbGl4DQo+ID4gPiBjb21tZW50cw0KPiA+ID4gb24gaXQuDQo+ID4gPiBNb3Jlb3Zlciwg
dGhlIHByb3Bvc2VkIGFwcHJvYWNoIGFsaWducyBsaW5rX2lkIHVzZWQgaW4NCj4gPiA+IG10Nzk5
Nl90eF9wcmVwYXJlX3NrYigpDQo+ID4gPiB0byB0aGUgb25lIHVzZWQgaW4gbXQ3OTk2X21hY193
cml0ZV90eHdpKCkgYW5kIGZpeCBhIHBvc3NpYmxlIE9PQg0KPiA+ID4gYnVnDQo+ID4gPiBpbg0K
PiA+ID4gbXQ3OTk2X21hY193cml0ZV90eHdpKCkuDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+
ID4gPiBMb3JlbnpvDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gDQo+ID4gSnVzdCB0byB0aWUgaW4g
d2l0aCB0aGlzIHBhdGNoIHN1YmplY3QgLSBJJ20ganVzdCB0aGlua2luZyBvZiBhIHdheQ0KPiA+
IHRvDQo+ID4gc29sdmUgdGhpcyBvbmNlIGFuZCBmb3IgYWxsLiBJZiB0aGUgcHJvYmxlbSBpcyBy
ZWFkaW5nIHplcm9lZCBpbmZvLQ0KPiA+ID4gY29udHJvbC5mbGFncywgd291bGRuJ3QgaXQgYmUg
YmV0dGVyIHRvIGp1c3QgcGFzcyBhIHUzMiBmbGFncywNCj4gPiBzb21ldGhpbmcgbGlrZSB0aGlz
Og0KPiA+IA0KPiA+IHUzMiBmbGFncyA9IGluZm8tPmNvbnRyb2wuZmxhZ3MNCj4gPiANCj4gPiBt
dDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCAoX19sZTMyICopYnVmLCBza2IsIHdjaWQsIE5VTEws
IDAsIDAsDQo+ID4gCQkJwqDCoMKgwqDCoCBjaGFuZ2VkLCBmbGFncyk7DQo+ID4gDQo+ID4gV2Ug
Y2FuIHVzZSBhbGwgZmxhZ3MgdGhlbi4NCj4gDQo+IHdoYXQgYWJvdXQgbGlua19pZD8gU2hvdWxk
IGl0IGJlIHRoZSBzYW1lIGJldHdlZW4NCj4gbXQ3OTk2X3R4X3ByZXBhcmVfc2tiKCkNCj4gYW5k
IG10Nzk5Nl9tYWNfd3JpdGVfdHh3aSgpPw0KPiANCj4gDQogDQpJIG1lYW4gdGhlIGxpbmtfaWQg
aXMgb25seSBjb3JyZXNwb25kcyB0byBvbmUgc3BlY2lmaWMgZmxhZ3MgYml0IG9mDQptYWM4MDIx
MV90eF9jb250cm9sX2ZsYWdzLiBCdXQgdGhlcmUgYXJlIG90aGVyIGJpdHMgdGhhdCBhcmVuJ3QN
CmhhbmRsZWQuIFdvdWxkbid0IHUzMiBmbGFncyBtYWtlIGl0IG1vcmUgY2xlYW5lcj8NCg0KUnlk
ZXINCg0KDQo=

