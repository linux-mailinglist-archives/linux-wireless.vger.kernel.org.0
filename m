Return-Path: <linux-wireless+bounces-37181-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0gupOCaXG2rvEQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37181-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 04:04:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB3614328
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93953026163
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919F2FD1A5;
	Sun, 31 May 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Zye69Gc3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="d84Qk2Tv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7602F0C7E
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193058; cv=fail; b=Z0iRCJu4kwQN0O4w8MAQ098xYwTiMlv933ikydd3uwGoiZHGcURXWsWWUMGrpnpOm5Wg2DFOcem4BlGyMANJe9Ac39u2SD7I33gygA/xHxmMCXvZY05+bRwOKgu3XAShOX2ci5gmADTqVhJcWiU4UpfycDmFRYXANn5aOY9TptE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193058; c=relaxed/simple;
	bh=mT8e49WcBKdcRbcEZenXllK3pHqACyayyQpjm+YC/Eo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oZ6ud8SWFVcNGKhthJCV+C+MlJeak5HPABG0e0JswwG6Bzhye2w1Sr+BOoXBNVb9wPngqSjJkFjbS/CpggejLn05VuBoBwS0Bwe3nhG14rFeKEIzVfFOuF7vgsudXCm9HjRd8F4j7HUEHdkAbnrHNVa7JoPGcWm1O08l07hIzyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Zye69Gc3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=d84Qk2Tv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fe564e005c9411f18dc8c9802ae25ab1-20260531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mT8e49WcBKdcRbcEZenXllK3pHqACyayyQpjm+YC/Eo=;
	b=Zye69Gc3xrPji9eY9PkctKK72jw/UZFgn5mINZO7YcjXt3b0oS6xbPA/cJYUxdZfvQo+mKKgkolAz8j0KxiSt1M91GlngrdPDmI+4mxQEwtiaM8PLO15tWQuKvuGacQqTYvkbNV8sZDsbaA3ohYIsmT9TVWvmkLxJ4oj0hk2xpc=;
X-CID-CACHE: Type:Local,Time:202605311004+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:fe821e6e-d814-4eaf-8533-4d149db9497b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:32177c30-3aec-4081-ae32-d2e919a47e1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|136|836|865|
	888|898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fe564e005c9411f18dc8c9802ae25ab1-20260531
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 199218067; Sun, 31 May 2026 10:04:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 31 May 2026 10:04:00 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sun, 31 May 2026 10:04:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh+CV3qFBsfTvt4se7MSxHvYOX+PrdA26hGvOFJRC8PNQf0SR/T3pRU7jkgXE/WYB9mNgIez6Ncgai/C8ihajBQMhq6A677wLoamAWpcTm9HgSZjdlh3bRuujLw2iZlRPQfqct1tqvXOxneAuwfN78Ew+jmLnoW+aExYv6pHRmDV5y0ODI4FX+l4cewFwPigFyFgTV3jZgOpoSTtbtQwsmU5xdXW4oVze2k/92R+0XOmvkBbDVPL7ZA+/zaPQaJrj9gOVwEUAeD8pG+H8T5XJLhr7YeWIC3esBDiStr+J//XhH3huqsTL+YlFWJlIFzneBO1IMoi1OiIuX+UifAq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT8e49WcBKdcRbcEZenXllK3pHqACyayyQpjm+YC/Eo=;
 b=YNkq3YjmKyeEVKQ7hNTK343lauxp2a/D085mxrKTiGKcFOK63Ksv6YNwOezaVpMKzdAyUt8UMDZHVlUOX89/KXOidH1QVUdl+t6RJzfwkgpsYQxIzTms4OLyuC+/VqIp8IcMtYzFmrgJFbU4t4oEIoTNeQUTtkd8BMG4BYSk3h6UKFW2X16V5+jmboW2lYA7hX4u5fz2UDmTNuVprSAdBmsbc9J58Cx7lstJ9HnOIcMcx+6BHvJYDWWxx13nQzCB3otG/9W30o2tpAzCqs6lUxhc+OSB6sS9sOwCK7gq5yBXwpfe/t34TVyA3vifV5RuAR26o33r1LJmKgWx3oileg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT8e49WcBKdcRbcEZenXllK3pHqACyayyQpjm+YC/Eo=;
 b=d84Qk2TvZISQpZ9yU9X+ZBFEE0oSx6wpyJZgFAgZ+Witwv+NDXZvawxRsKgH+IlnH5k32ygr41I1Zoa4eKUIsZ5yA/sxxPCUcWeogT1bvbgx+yruYcWPfOPPY099dIDBwUDWlqdjMhCccmIs6n0bi2Q9DAQEnNYpTmP3G/lfAq0=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEYPR03MB7012.apcprd03.prod.outlook.com (2603:1096:101:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.6; Sun, 31 May 2026
 02:03:54 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%6]) with mapi id 15.21.0092.005; Sun, 31 May 2026
 02:03:54 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?=
	<Chui-hao.Chiu@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Topic: [PATCH] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Thread-Index: AQHc8EibITbtuDCi7Ue2BeD1yvMve7YnYuMA
Date: Sun, 31 May 2026 02:03:53 +0000
Message-ID: <6be1d6e67bcb5500c9d1e92449ce7757f6166d22.camel@mediatek.com>
References: <20260530-mt76_tx_status_skb_add-overwrite-fix-v1-1-e2c3151c391a@kernel.org>
In-Reply-To: <20260530-mt76_tx_status_skb_add-overwrite-fix-v1-1-e2c3151c391a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEYPR03MB7012:EE_
x-ms-office365-filtering-correlation-id: 5db6cd13-7b9c-46fd-5ac5-08debeb8ddfc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|11063799006|18002099003|56012099006|22082099003|38070700021;
x-microsoft-antispam-message-info: 1Oup33RsjQs28EdAoon4j6rN6b8KmvdSyM61b3N6IHlJZJd+FWQ6DA7R98lqy7DEdACzhUI1sIfE3+mn9U5UCeFEB6JbNXn3Oy4kheFhRnFdUbJXUvu2p5jHYvxiksImcqkL71ElK76yjRRwWrIASsCX6EL7doVPi163Sl29gUwDWayoubKJQ08siaAtY+ptJPGnpPfuohhlAwbKcut+tbahmNuRx2AoPSxXGPgm/ujYC7vvA/zb2V/2nIKUdEdZ+TmvaGIxaq2FOAKD0GoN+xkVRBAEuzzd0N0+amQImS7KGxc2rxsgu4mQ/gZ5Ze1p2SdDak/LVn+ku/C+FS7f9kRHY5uE5BKlJEppww48K0tIRSjb7vFhHp4MxlMb6pQun0coQ1+o7LBhcUCXZWkhE/CmsL6G7tgQB1YzI12zFJkey9aVqt5zOwx4B27IJ4ZUze8h8uuUFEsjBh8NZU9nSwrXJG41QpfUIzG04Q3jxKb65JsrS10bPiV+qranuEn8+fBLV/N6uQBIdcg06CtlUIqj/u4b+mhTKhc17JFt5jEvkRUyDJFO0fQ8J+LsxmPE5+a4jJV6c0lTOe/GI/n+Gp2Li3cXc++oyp8uYCi1EUB6UuT/nr15H5SW/GCnv5JBuFgO8CFEN8rZPFiLExFdSOLBZbaQUOzQZ2vCeH4BqJB1Of6S7SHUk8X0h0EfWWvH3JSy1Wljj51mIyNaSiqtKASSmgQ+upA6najc3BmfitMcrqiH+X7UnTAApAMZrclr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(11063799006)(18002099003)(56012099006)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmhRQ3gwY0FuelhWbWtEZFRHMDg5ekFqNk5Kc3NMYlovaDk2U0hlaklBeklJ?=
 =?utf-8?B?NCtZZHpwWjdkR0g1UmpzUEVlS3d3VWlPSEcrQS9mcE0yeWtGR2NWNnAydEJ4?=
 =?utf-8?B?bVFzRGt1ajdrYVVGckgvMFdFdnNvclJvdHVTdzNXajlIZHpCSmlwT0NwUEpU?=
 =?utf-8?B?cU1ycWFFN1RUSGVuWkhMTzhuL251QVBJK3QrbERGZTQwbHNjWlVTUkwvQjFW?=
 =?utf-8?B?WWZKV1V1Q1RSekVCczZ1NXR6Wm5NRXF3dXA4elJEZnlyZDB0V3RoRGpsUDYz?=
 =?utf-8?B?MFhZUU5kbGphWWZ5NnMwblE3bFBERStrZlJNK3h3c1VpK2t2M291eUczS2Q1?=
 =?utf-8?B?eCs2a2xlaDR0eXFzeWR3Mm1yazNxWXJyekJ3K2RJYVBIU2M0bldPRUZFT2w4?=
 =?utf-8?B?Unk1T016NW1GdXZMZ2lESXYyVWFndGZBWTBURDFkMVg4ZDRrcWFQM04rZ3dD?=
 =?utf-8?B?Q1lEMTM3UCtNQTlnVER2MmoxU0FqcnBKZ0hJN0FBcUkwYk9jK08zTFNSV2Y4?=
 =?utf-8?B?RU55REJJck9rcjV2aisvZUxmTE5DMVRvMEZJa0l0ZTB4MHlneTlkR1Zwb2s5?=
 =?utf-8?B?eldWMWFJVEtGYlE0QWFEaGV2dCsxaGVURzdIWDZqZm5rS2ZIWldLKzRUSnBn?=
 =?utf-8?B?NmVUVnI4OFlmUFdmaXlSeTBJWjYxM2Z1VVNuMTMvRVpIaFVOZFh5dTVSTExN?=
 =?utf-8?B?aDJxcTBxRFkralBjZ3NyWEV0YzB3ZUhzZEl3b2hTSU1zdHRzMER4YXVzTi8z?=
 =?utf-8?B?SUZUTDMwazlPaFlHUHk1bW45WmU4cVN4SXJPSCtoODYyMjM0SU14dTFmcXRE?=
 =?utf-8?B?OGVNeCtGQUl2UGcrTDVVZWE0czF0UDIrZ1ZodFB1L0toTEpJSXJHNTVpM2dO?=
 =?utf-8?B?N0JqY3BWUnhleks4TVZxWGNTZ0dscU5wb0R6eFlmdUFnckVOOExsM1BYbTJ2?=
 =?utf-8?B?ZnRBTHZrR2t2ajdoN1MwWmNKQzBzZnZQS0NERG5ETlJBWGViZGZPU1d0b005?=
 =?utf-8?B?ZXpLcDFiVjRQYXh2WERyVVd0V2MrT2JuWGhIMnJPNGd0VTNWL2FGZVZ5aDQ0?=
 =?utf-8?B?STUvVzNaZmVOLzcwNmxmU1AyT1hvNG84aXF3RGpuT1lCSjVOTW92V1JiZHZU?=
 =?utf-8?B?ZWkrTnJLOHB1VTlpSWZFcytGWEw5UEptSlZkbVRQaTRsMWU0MUJMS3BjREdW?=
 =?utf-8?B?bWU3ZlRESDRvbm1qRFgyZWxWamtVd1YzeHV1eHVTS2lLQ1hLK2wvZ01aSUtt?=
 =?utf-8?B?akZWc2NXQTJJQi84ZXRNcWNuSTBNZ010REdxM1BzTWxvUmtQeEE2LzRJMDVD?=
 =?utf-8?B?RlRvaEJsQXNZZnZQcnJUcXRtamgwakNaSDNGYWhaa2FpODNONGppTXRMNnEy?=
 =?utf-8?B?ZVBQTWpnSnlxYUp2LzBocmRibEJxc2FxaHUzUTJBTnlyN012MDhXckZwVC9t?=
 =?utf-8?B?cFo1T2xGVXZNQUFLT0tPYThwM0ROdTRUWWliUHFQa0VjRUxVVXhsM3Q0cWtj?=
 =?utf-8?B?UGFxQVVOOEFwOS9tdlVYTk80Y3lPLzUrc2tTV1FFbkpUMVJyWXhCUEI1UDBW?=
 =?utf-8?B?T3lUSG9rbDk3b2hTSU51eGVlQU5mSlFQaG9XLzNldzBSUFZ3UGNUU3JLNDMz?=
 =?utf-8?B?c2N6UnJSRHNDdTN3ZTJ5aFRWU29vZXZ5Z0FybjN4aG1LYW1tSHJDc2tGQ2V5?=
 =?utf-8?B?TWxOU1o3amc3cUt3OFhCRkczSzcwSUFnNy9rMDlmeWJncWxEOVVRTURyMjNt?=
 =?utf-8?B?V3dycmkycm5GeWJreTZTRld4ZFJ1bzNYWU1odUhaYWphbXRZaDBUVnRkd3E3?=
 =?utf-8?B?RVFXZTlXYUZOTGR2ZHhNNGZpblJ6UWhkREduUEJzSmE0TURkbVB4bHVlWTEy?=
 =?utf-8?B?Q1NxMU04dTdrQ3pDUFYzR1QyMFBMOHkrZnpYQ1pUOTJkVW5BcE5IRVhTaGFn?=
 =?utf-8?B?a05nUE1HeURSdFVrcUNSSFhNdGp4N2VRR0c0bDdYOGw1azdyTHpjNlJsRDVV?=
 =?utf-8?B?eGozTlp2OUVQTVFxdUp2cUN5d1dGVlF3WEtKamZFYVlsRU5nemdiNW9mVklr?=
 =?utf-8?B?V3E3TkR2UnVlVUdMd2JDcXNKSXpsZFRheFJJR05XY1Z3dlhzWWNmQ1I3Ymxa?=
 =?utf-8?B?SGM5bEZwa3c3TERlempoSmdybnB1ZWdUQlI2NE01S3YrM0RDZ2Z1RTNOMUlv?=
 =?utf-8?B?V1N3ZjFOTTBVaWNtbGlYeE9TeHh1eWNTZ2JUWlZpWk55M1pBYkdiZElzbVJV?=
 =?utf-8?B?cDFYUGVDeUFMVXZ1d1JjT1c1ckc5SGs0cDNPQUFXRHpjVDMyblVSNjFaVDBF?=
 =?utf-8?B?elJRSVlWcTdaK3dSa2lPRHpQNWhUbG9iWWJJeUlUSC9DaGJUOTlaZzZMd3Y5?=
 =?utf-8?Q?Htp8ONRa2YKPFAUw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDBE8D1A23DB63489F7A0C4EE11E4BE4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d08v6129JNKx241fKNG2dAA4+i2Zq4rOM2pctD34W8DfQV+SBQ9ctKgyAZ/WoalUiH5A+DbRVf0dgLi5faQAV26AFpNOEjOzRosh1lzKa6DxaC75C1FKawbhEMW2lhwcWUPGHe++gFZkTxbSpwNIZur902sKz0w5Vx48KOrbekO2RcYPWcdH4DPkJy+H5+nV4OyKri7wEJQE/H5mELI3mg8lAvge/X3+JXn188dnRakwjz/62HD5hC/acwX01L4lUnfJaTIamI/zqTZ1EPDt2suD3z9OPNAhwF3bP5/1kZFjnk1Htk05DX04e0Wso36VtEDL7hWiG/gMH9geWOI7hw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db6cd13-7b9c-46fd-5ac5-08debeb8ddfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 02:03:54.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R+X94Xr+ohhWUBZA0PcL6SCeLezQVksWdItjowA7TBxaLaFRmkdpRSZS0avicawrLaGVS+K278mfa7XtUEWeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7012
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37181-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,nbd.name,collabora.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B7AB3614328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCAyMDI2LTA1LTMwIGF0IDE3OjI1ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBtdDc2X3R4X3N0YXR1c19za2JfYWRkKCkgemVyb2VzIHRoZSBtdDc2X3R4X2NiIHN0cnVj
dCBzdG9yZWQgYXQNCj4gaW5mby0+c3RhdHVzLnN0YXR1c19kcml2ZXJfZGF0YSB2aWEgbWVtc2V0
KCkuIFNpbmNlIGluZm8tPmNvbnRyb2wgYW5kDQo+IGluZm8tPnN0YXR1cyBhcmUgbWVtYmVycyBv
ZiB0aGUgc2FtZSB1bmlvbiBpbiBpZWVlODAyMTFfdHhfaW5mbywNCj4gdGhpcyBvdmVyd3JpdGVz
IGluZm8tPmNvbnRyb2wuZmxhZ3MuDQo+IEluIG10Nzk5Nl90eF9wcmVwYXJlX3NrYigpLCBtdDc2
X3R4X3N0YXR1c19za2JfYWRkKCkgaXMgY2FsbGVkIGJlZm9yZQ0KPiBtdDc5OTZfbWFjX3dyaXRl
X3R4d2koKSwgd2hpY2ggcmUtcmVhZHMgaW5mby0+Y29udHJvbC5mbGFncyB0bw0KPiBleHRyYWN0
DQo+IElFRUU4MDIxMV9UWF9DVFJMX01MT19MSU5LLiBCZWNhdXNlIHRoZSBmaWVsZCBoYXMgYmVl
biB6ZXJvZWQsIHRoZQ0KPiBsaW5rX2lkIGFsd2F5cyByZXNvbHZlcyB0byAwIGZvciBmcmFtZXMg
dXNpbmcgZ2xvYmFsX3djaWQsIGxlYWRpbmcgdG8NCj4gaW5jb3JyZWN0IFRYV0kgY29uZmlndXJh
dGlvbi4NCj4gRml4IHRoaXMgYnkgcGFzc2luZyBsaW5rX2lkIGFzIGFuIGV4cGxpY2l0IHBhcmFt
ZXRlciB0bw0KPiBtdDc5OTZfbWFjX3dyaXRlX3R4d2koKS4gSW4gbXQ3OTk2X3R4X3ByZXBhcmVf
c2tiKCksIHRoZSBsaW5rX2lkIGlzDQo+IGFscmVhZHkgZXh0cmFjdGVkIGZyb20gaW5mby0+Y29u
dHJvbC5mbGFncyBiZWZvcmUgdGhlIGRlc3RydWN0aXZlDQo+IG10NzZfdHhfc3RhdHVzX3NrYl9h
ZGQoKSBjYWxsLiBGb3IgdGhlIGJlYWNvbiBhbmQgaW5iYW5kIGRpc2NvdmVyeQ0KPiBjYWxsZXJz
IGluIG1jdS5jLCB1c2UgbGlua19jb25mLT5saW5rX2lkIGRpcmVjdGx5Lg0KPiANCj4gRml4ZXM6
IGYwYjBiMjM5YjhmMzYgKCJ3aWZpOiBtdDc2OiBtdDc5OTY6IHJld29yaw0KPiBtdDc5OTZfbWFj
X3dyaXRlX3R4d2koKSBmb3IgTUxPIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMb3Jlbnpv
IEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21hYy5jwqDCoMKgIHwgOSArKystLS0tLS0NCj4g
wqBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuY8KgwqDCoCB8
IDUgKysrLS0NCj4gwqBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9t
dDc5OTYuaCB8IDMgKystDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5OTYvbWFjLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210Nzk5Ni9tYWMuYw0KPiBpbmRleCBjOTg0NDYwNTcyODIuLjJkM2Y4MGIzZTQxYSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bWFjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYv
bWFjLmMNCj4gQEAgLTg1Niw3ICs4NTYsOCBAQCBtdDc5OTZfbWFjX3dyaXRlX3R4d2lfODAyMTEo
c3RydWN0IG10Nzk5Nl9kZXYNCj4gKmRldiwgX19sZTMyICp0eHdpLA0KPiDCoHZvaWQgbXQ3OTk2
X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIF9fbGUzMiAqdHh3aSwNCj4g
wqAJCQnCoMKgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBtdDc2X3djaWQNCj4gKndjaWQs
DQo+IMKgCQkJwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIGludCBwaWQsDQo+
IC0JCQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlkLCB1MzIgY2hhbmdlZCkNCj4gKwkJCcKgwqAg
ZW51bSBtdDc2X3R4cV9pZCBxaWQsIHUzMiBjaGFuZ2VkLA0KPiArCQkJwqDCoCB1bnNpZ25lZCBp
bnQgbGlua19pZCkNCj4gwqB7DQo+IMKgCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAoc3Ry
dWN0IGllZWU4MDIxMV9oZHIgKilza2ItDQo+ID5kYXRhOw0KPiDCoAlzdHJ1Y3QgaWVlZTgwMjEx
X3R4X2luZm8gKmluZm8gPSBJRUVFODAyMTFfU0tCX0NCKHNrYik7DQo+IEBAIC04NjYsNyArODY3
LDYgQEAgdm9pZCBtdDc5OTZfbWFjX3dyaXRlX3R4d2koc3RydWN0IG10Nzk5Nl9kZXYNCj4gKmRl
diwgX19sZTMyICp0eHdpLA0KPiDCoAlib29sIGlzXzgwMjMgPSBpbmZvLT5mbGFncyAmDQo+IElF
RUU4MDIxMV9UWF9DVExfSFdfODAyMTFfRU5DQVA7DQo+IMKgCXN0cnVjdCBtdDc2X3ZpZl9saW5r
ICptbGluayA9IE5VTEw7DQo+IMKgCXN0cnVjdCBtdDc5OTZfdmlmICptdmlmOw0KPiAtCXVuc2ln
bmVkIGludCBsaW5rX2lkOw0KPiDCoAl1MTYgdHhfY291bnQgPSAxNTsNCj4gwqAJdTMyIHZhbDsN
Cj4gwqAJYm9vbCBpbmJhbmRfZGlzYyA9ICEhKGNoYW5nZWQgJg0KPiAoQlNTX0NIQU5HRURfVU5T
T0xfQkNBU1RfUFJPQkVfUkVTUCB8DQo+IEBAIC04NzYsOSArODc2LDYgQEAgdm9pZCBtdDc5OTZf
bWFjX3dyaXRlX3R4d2koc3RydWN0IG10Nzk5Nl9kZXYNCj4gKmRldiwgX19sZTMyICp0eHdpLA0K
PiDCoA0KPiDCoAlpZiAod2NpZCAhPSAmZGV2LT5tdDc2Lmdsb2JhbF93Y2lkKQ0KPiDCoAkJbGlu
a19pZCA9IHdjaWQtPmxpbmtfaWQ7DQo+IC0JZWxzZQ0KPiAtCQlsaW5rX2lkID0gdTMyX2dldF9i
aXRzKGluZm8tPmNvbnRyb2wuZmxhZ3MsDQo+IC0JCQkJwqDCoMKgwqDCoMKgIElFRUU4MDIxMV9U
WF9DVFJMX01MT19MSU5LKTsNCj4gwqANCj4gwqAJbXZpZiA9IHZpZiA/IChzdHJ1Y3QgbXQ3OTk2
X3ZpZiAqKXZpZi0+ZHJ2X3ByaXYgOiBOVUxMOw0KPiDCoAlpZiAobXZpZikgew0KPiBAQCAtMTA5
Niw3ICsxMDkzLDcgQEAgaW50IG10Nzk5Nl90eF9wcmVwYXJlX3NrYihzdHJ1Y3QgbXQ3Nl9kZXYN
Cj4gKm1kZXYsIHZvaWQgKnR4d2lfcHRyLA0KPiDCoAkvKiBUcmFuc21pdCBub24gcW9zIGRhdGEg
YnkgODAyLjExIGhlYWRlciBhbmQgbmVlZCB0byBmaWxsDQo+IHR4ZCBieSBob3N0Ki8NCj4gwqAJ
aWYgKCFpc184MDIzIHx8IHBpZCA+PSBNVF9QQUNLRVRfSURfRklSU1QpDQo+IMKgCQltdDc5OTZf
bWFjX3dyaXRlX3R4d2koZGV2LCB0eHdpX3B0ciwgdHhfaW5mby0+c2tiLA0KPiB3Y2lkLCBrZXks
DQo+IC0JCQkJwqDCoMKgwqDCoCBwaWQsIHFpZCwgMCk7DQo+ICsJCQkJwqDCoMKgwqDCoCBwaWQs
IHFpZCwgMCwgbGlua19pZCk7DQo+IMKgDQo+IMKgCS8qIE1UNzk5NiBhbmQgTVQ3OTkyIHJlcXVp
cmUgZHJpdmVyIHRvIHByb3ZpZGUgdGhlIE1BQyBUWFANCj4gZm9yIEFkZEJBDQo+IMKgCSAqIHJl
cQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
OTYvbWN1LmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9t
Y3UuYw0KPiBpbmRleCA4YmU0MGQ2MGFkMjkuLmExNGM2MzQzODkyMyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gQEAgLTMx
MDMsNyArMzEwMyw3IEBAIG10Nzk5Nl9tY3VfYmVhY29uX2NvbnQoc3RydWN0IG10Nzk5Nl9kZXYg
KmRldiwNCj4gwqANCj4gwqAJYnVmID0gKHU4ICopYmNuICsgc2l6ZW9mKCpiY24pOw0KPiDCoAlt
dDc5OTZfbWFjX3dyaXRlX3R4d2koZGV2LCAoX19sZTMyICopYnVmLCBza2IsIHdjaWQsIE5VTEws
DQo+IDAsIDAsDQo+IC0JCQnCoMKgwqDCoMKgIEJTU19DSEFOR0VEX0JFQUNPTik7DQo+ICsJCQnC
oMKgwqDCoMKgIEJTU19DSEFOR0VEX0JFQUNPTiwgbGlua19jb25mLQ0KPiA+bGlua19pZCk7DQo+
IMKgDQo+IMKgCW1lbWNweShidWYgKyBNVF9UWERfU0laRSwgc2tiLT5kYXRhLCBza2ItPmxlbik7
DQo+IMKgfQ0KPiBAQCAtMzI0OSw3ICszMjQ5LDggQEAgaW50IG10Nzk5Nl9tY3VfYmVhY29uX2lu
YmFuZF9kaXNjb3Yoc3RydWN0DQo+IG10Nzk5Nl9kZXYgKmRldiwNCj4gwqANCj4gwqAJYnVmID0g
KHU4ICopdGx2ICsgc2l6ZW9mKCpkaXNjb3YpOw0KPiDCoA0KPiAtCW10Nzk5Nl9tYWNfd3JpdGVf
dHh3aShkZXYsIChfX2xlMzIgKilidWYsIHNrYiwgd2NpZCwgTlVMTCwNCj4gMCwgMCwgY2hhbmdl
ZCk7DQo+ICsJbXQ3OTk2X21hY193cml0ZV90eHdpKGRldiwgKF9fbGUzMiAqKWJ1Ziwgc2tiLCB3
Y2lkLCBOVUxMLA0KPiAwLCAwLA0KPiArCQkJwqDCoMKgwqDCoCBjaGFuZ2VkLCBsaW5rX2NvbmYt
PmxpbmtfaWQpOw0KPiDCoA0KPiDCoAltZW1jcHkoYnVmICsgTVRfVFhEX1NJWkUsIHNrYi0+ZGF0
YSwgc2tiLT5sZW4pOw0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaA0KPiBpbmRleCAwZGM0MTk4ZmNmOGIuLjBkNjQ4
ODUyMmJhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gQEAgLTg3NCw3ICs4NzQsOCBAQCB2b2lkIG10Nzk5Nl9t
YWNfZW5hYmxlX25mKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsDQo+IHU4IGJhbmQpOw0KPiDCoHZv
aWQgbXQ3OTk2X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5OTZfZGV2ICpkZXYsIF9fbGUzMiAq
dHh3aSwNCj4gwqAJCQnCoMKgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBtdDc2X3djaWQN
Cj4gKndjaWQsDQo+IMKgCQkJwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIGlu
dCBwaWQsDQo+IC0JCQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlkLCB1MzIgY2hhbmdlZCk7DQo+
ICsJCQnCoMKgIGVudW0gbXQ3Nl90eHFfaWQgcWlkLCB1MzIgY2hhbmdlZCwNCj4gKwkJCcKgwqAg
dW5zaWduZWQgaW50IGxpbmtfaWQpOw0KPiDCoHZvaWQgbXQ3OTk2X21hY191cGRhdGVfYmVhY29u
cyhzdHJ1Y3QgbXQ3OTk2X3BoeSAqcGh5KTsNCj4gwqB2b2lkIG10Nzk5Nl9tYWNfc2V0X2NvdmVy
YWdlX2NsYXNzKHN0cnVjdCBtdDc5OTZfcGh5ICpwaHkpOw0KPiDCoHZvaWQgbXQ3OTk2X21hY193
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7DQoNClRoZSByZWFzb24gd2UgZGlkbid0IG1h
a2UgdGhlIHNhbWUgY2hhbmdlIGlzIGJlY2F1c2Ugd2UgdXNlIG90aGVyDQpjb250cm9sIGZsYWdz
IChJRUVFODAyMTFfVFhfQ1RSTCopIG9mIGluZm8tPmNvbnRyb2wuZmxhZ3Mgbm90IGp1c3QgTUxP
DQpvbmUuIFNvIHdpdGggdGhpcyBjaGFuZ2Ugd2Ugc3RpbGwgbmVlZCB0byBjb3B5IG92ZXIgdGhl
IG90aGVyIGZsYWdzIGFuZA0KcGFzcyB0aGVtIGluIGFzIHdlbGwuDQoNClJ5ZGVyDQo+IA0KPiAt
LS0NCj4gYmFzZS1jb21taXQ6IDQ5MTNmNDQxNjdjZjM1YTk1MzZlOWVlYzczNTJlMTViMmRlMGM1
NzMNCj4gY2hhbmdlLWlkOiAyMDI2MDUzMC1tdDc2X3R4X3N0YXR1c19za2JfYWRkLW92ZXJ3cml0
ZS1maXgtODU4MThhOWJiMzFmDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg==

