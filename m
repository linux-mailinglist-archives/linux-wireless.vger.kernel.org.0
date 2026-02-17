Return-Path: <linux-wireless+bounces-31951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNHQDb9ylGnVDwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:53:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193314CC72
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A3F230048C1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC3236074A;
	Tue, 17 Feb 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="POHfhrqO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HOrCoUmq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D21D9346;
	Tue, 17 Feb 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336337; cv=fail; b=CauIGKikFAnhs9XkZaIWC9zlWV8Zx+tNRR/y5o2cTgGfAtxv9+visn4d+j2CZnz/UU5fT27fiPbPeqm47W4lWBAubQoMTHQr2/ti1KAGIB0cuUN9NuxKvAB54kPhyD7SRGxTP+QeZNkqTrzEh/KccCcukgQkqReMTKDABNnzP+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336337; c=relaxed/simple;
	bh=5bo4QAX/69IXxnIRJ2MEeD6QVZMM4/v3A3j9mBVmlsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=de3vsVLzK8o903aEetm8plaITM1f2XLbgaqWTc2pGpjuyd/2S1saF0gUYjPzU8D/1FDVGt3Klw6nKfWB8JaW8FuHgIpuNfWMW5F16LlFBaVJM2Eor32PaQDlhsGJQrz5uhb2sgJzbvpGslSGXwYZTujGmJGLB6LJ1tZdFBhFv4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=POHfhrqO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HOrCoUmq; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d5e4af9e0c0711f1b7fc4fdb8733b2bc-20260217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5bo4QAX/69IXxnIRJ2MEeD6QVZMM4/v3A3j9mBVmlsI=;
	b=POHfhrqOKx8FDCXgWHIeLliAYONfYJjyIoKy7UaZM9TDEKgRqjieeyr4FLLuHaoTZxAegr8MnIN6uhOBd6W0HrPin6zGiRnY8++amuZsjCGiPMIOiKkB5Zk4N8rtZxNYMFCAfPB/D49CugRQ12adMmZZoaooWw07SUWExkkRfqo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:397c6539-5147-4fd0-8a2c-f0a6ad055995,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:d828c2f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5e4af9e0c0711f1b7fc4fdb8733b2bc-20260217
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 111782493; Tue, 17 Feb 2026 21:52:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 17 Feb 2026 21:52:00 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 17 Feb 2026 21:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCTVZTyEcrzRqnX8O1f0sWZG4HS/nYrzzehtrFb7FqA2/xzbZd20hgkNxjPAt1uoc/D+lBR6K8m1/MxMmtmYShUvSgcUG1YfJCBuYzt5EU0OijhLpjlzD31HWDgTgAH2BpQ58XnaCvv7YDdZZbogZY3jP0ab0wke6jkvyj3FkhnruVJqbYJ1wvceqnlKm0PhfRh0mT2nle2c1gQqziuB+t6AX9mEapEYb6wUkY2Kqj2D/9ZVgIC+fd7n78FPRfRDwWKQLhHaACcjeqJhXIPDVJnAcCfQGki31J1bf0oIajtSwg9CnBw+ucMInB2Yc8u1uvsSZiBoTZlX7mxN1FjjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bo4QAX/69IXxnIRJ2MEeD6QVZMM4/v3A3j9mBVmlsI=;
 b=doz7WdqzCHsVyvqwFa6/fz2isy2I3FF2fiGPALNFX2/B/G1lfV5bJoTcEvGTsrtjB5zoaiYFOLSoqb1mxuEFWmOUyCF2Y7+yqVOAOdU3hDVQeJJ0Zrf+8eM9qUiwoZhZ1GL6Hu/bqW4s3gzRFRsYo6RUgAF0aqkyqRwAq8iLucLWYwnAmL6nwG2cCOTNG36Pb3UHiuOt67Xsmfxcg0/nxNzgmA2x0yEK9SsRfU3uN9Xl/5GCSZ0t0yn8015aNFNxEkdHW9MzZBFwgJR66CKl8GNNWkD9WhG3jHeEQj8hr58EFaziEnudUryxWyHvPsYTt35U7EmQ7wUvke2et6ThFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bo4QAX/69IXxnIRJ2MEeD6QVZMM4/v3A3j9mBVmlsI=;
 b=HOrCoUmqLT8l0ecOE+IaO1eTQrXbY3w+Ti4r7rbE/MK302AsmHoD2pusTKF4Am2uKYoQYqw3Il2DU6GLeTCTNgwu1xL9lCXJyyX2JnbdRERXwK5j3l/EjagMuWVce3kQlh3h9usa6ER3iZX7Vvu7TXg4B076Q0Pt1YbXqdXU2Oc=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KUXPR03MB9387.apcprd03.prod.outlook.com (2603:1096:d10:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 13:51:58 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 13:51:56 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: net: wireless: mt76: add more PCI
 devices
Thread-Topic: [PATCH v7 2/3] dt-bindings: net: wireless: mt76: add more PCI
 devices
Thread-Index: AQHcn12I01YO6hJ3A0+IUnDLc+LCmrWGhPoAgABW5ACAAAa6AIAAB9SA
Date: Tue, 17 Feb 2026 13:51:56 +0000
Message-ID: <e3bd7f3844b7e6bdd4805794c5a04374829edc6b.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1771205424.git.ryder.lee@mediatek.com>
	 <5022737c82052132702004ab0fdc073f5cf6df69.1771205424.git.ryder.lee@mediatek.com>
	 <20260217-lavender-dove-from-tartarus-fca40c@quoll>
	 <23f43fb875ca41a945caceba5c9fcf05331afd58.camel@mediatek.com>
	 <af349cc1-cd30-497e-a36a-81d50ef3e659@kernel.org>
In-Reply-To: <af349cc1-cd30-497e-a36a-81d50ef3e659@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KUXPR03MB9387:EE_
x-ms-office365-filtering-correlation-id: a40a2900-b418-412e-27f0-08de6e2bb6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d0oyVGt3emVXRnl0U0FONit4SmNkWkFzbS9PSkg2T3RmaEs0RVdtQUdCU0dB?=
 =?utf-8?B?NTNSaUliL2ZHbk9ZR2ZERDJyYWJJWXNhQjhjeGY4SHdiK0JFNVU1QUloaENL?=
 =?utf-8?B?VTYwSTJOUTZwME9mRXpRN09DaGpudmZOTEQ1RXdFcWhWNVNrRmtVbFZJdVBV?=
 =?utf-8?B?cDZPY2tTbTJ3QytaQkRuRGtmYXlGNHVpOVB4LzlKSmZDdjU1aWJubWNjY2JW?=
 =?utf-8?B?T0lWSjU2SkpUN2NmdXB1MkppeWZQMitpc0tMUkFjSWxOVzJsZHUwRFgya1pZ?=
 =?utf-8?B?M0RHeTFqMGNnQWw1R3V6S1hzTmhmVU9XalRXeVRaa2FnOGVOWGdSTU94ME12?=
 =?utf-8?B?SWhFd1o2RU8yc1RzYWVncEdrNDhQT1J4ZkNaZFh4d3JtY2ZQamoyYjdxZWVZ?=
 =?utf-8?B?VmdHR3g4dktGVStmUjJMK1grVS9TYUlMbXJ5SnZyVGlTT3FvTlRyVXJYNm1a?=
 =?utf-8?B?V2JFSkZJSDhMUmc5akZobTRXbit6U20rZ1JWQXpNNXYyMUdzZEFvakZpK1VE?=
 =?utf-8?B?c0NNSitNTmhaRnFLTVVXOVZsR3VsU3o4QVhRSnd4VmtmaGlPVzhKUEU1NXR3?=
 =?utf-8?B?YlV1N0VyKzc3Z1FzQ3BHU2l1a1hKTUlmYndISmxUNmdxRDVRaGtjamxoYmkw?=
 =?utf-8?B?b0NPVEJ3Q29IZVcwT2ZZOWVTcUNpWmMxazVYMjd4VGpNN2lLNHZBbHNqTW4w?=
 =?utf-8?B?eUVKYTE2Z0YxazN4VmVjQkVqVzh4bC9NeXlDVjFNV210OVVteXU4VE9IWUw2?=
 =?utf-8?B?Y29ka3RVMUNZT2VqV251cXVtKzRxYWhiOFI3U21NY0xBTjZVdW04bjJkZk1X?=
 =?utf-8?B?M3B2cHdDZ0hCaFJYRnhudUFiaWw1OFFIaVY0cEFGVFN5V1EyUnVMVXo2d1lx?=
 =?utf-8?B?WGRPZ3hzMVhDaFhGU3h0WTI1UHVPNXB2OUpsOFVrZTVST29yYUxyMkxpZUh2?=
 =?utf-8?B?aVEvOUJCbnFzNWxqU0s3d2Jib3lSenNkZ2pCRVdXMW5UYjY0ODI0akE2WnFJ?=
 =?utf-8?B?UlRCRUw4OStrN3NBeGZhM0ZPYXVQWWsrR3ZWWTNRSXhMODJHaTR5MXRsWmND?=
 =?utf-8?B?RTR1aDE5N3BUdG9mM2U2dmNNRlI0K2FQVnZ1YW1BY2hFd2pabFIyOWRDSmov?=
 =?utf-8?B?cjg1NXZ2T1NEYXdtRkV3bWF1QmtZOUtUc1FaWG5pY1RXZzdKSlcvVE5HVHdQ?=
 =?utf-8?B?LzJCaTEwM2N3emozZ1F1cDg4M0JIVyszc28zdnB3ckxKTHhHRWN6cG02S2hl?=
 =?utf-8?B?NStHYkhCUnFrVzh4OUVlMzJhbVF2eVVEZzdKdUpXYnB6Y1Fjb3R5RlE1Ty9T?=
 =?utf-8?B?ckZvLzBmV2JnakNzTVF0TjFDaXQwTmtEYTEzTzM4OUQzKzkzcHRESTA3dGlU?=
 =?utf-8?B?M1ovOEJCTDhOdnlxZnlod1k2VWtxay9rVnBDU0xGRWRvVHd6K25ZQnZOZUMr?=
 =?utf-8?B?d09tTHJUcGJkcTN4a2tVRXFsRHREb2tDcmtYOSt6U2xpcjNWeHgvcWs2dHll?=
 =?utf-8?B?UHNuMnZXOElFVlpteEJIMW5pWndUNnlWNlovWVRFWTFXMFpmZDRQemhaOVdn?=
 =?utf-8?B?eXNRYU95TVF4VE56UFNCaCtMUnNSdGcwazRXeStNc0NyUWJTcWlERTUyNElQ?=
 =?utf-8?B?TXphOFNEMzhLVnVSMERlcWlXbTRUeTRVNlVPTGZYVlorcVJmZ0hDZElVSXVU?=
 =?utf-8?B?VVdBVnk5NVl3bCtyTnhYYTRtSWhDbHVlbGFFQ2lkUWdoS3ZzRjNkQnc0T2ZR?=
 =?utf-8?B?dVFFaU5lZjFvQUp5TXhoMGJINlZRMkgvRGxXaVpHYWZzVTNIZ3lvTmVhc0dN?=
 =?utf-8?B?cUJ2aDNkMktHMEpoNElPd0g1bVNRL2wyRm5FcWg3enl6Y3EycCs4Sk41akxl?=
 =?utf-8?B?ZVhWUU5OL3JLMGxQZ2dmWCtxOGErdkMwRUFKQjBuT09pQ3IxZkNRNzl2RzFU?=
 =?utf-8?B?Z2ZzVkJ1QkYvWGRwZnMzQ215MDZVdldUZGd0dFM5Vm1lWUhGWFdaSWJpQkFC?=
 =?utf-8?B?TktHMy9jUXBRUVJUOHJ2UmkvelpDeHZSaGVvR3pmKzRIUjZOYUUwUlM1TEk4?=
 =?utf-8?B?RC82WC9aRko5S0dZQXU3dUJwL2RvbWhmK0U4UUNYOXRYRzgySEh6dHFPdGI1?=
 =?utf-8?B?SFNrK3FiSnFtUWZ5eWlRRlg0QXNoNEMwNEk0a3JMU28rMi84M2VEdnlEWGVQ?=
 =?utf-8?Q?wN4g55MPH/SbyDUdfrJCmmY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjRjRTdvVEJ6Q0cydENFaUMrRkJOdmxySTdHTVc5UldqcGd4RGtYa2hhVnZt?=
 =?utf-8?B?WkFPdXl6NUNmZE5jdXl6VE9DSE1HWFUxSVlIWjVKK0VNZWtrSWE1RnFKQ2hu?=
 =?utf-8?B?TC9NZk5VRDBYSDY5ZFJtSlYrdk1Gcmg1RmdzcHpqMWFzaXhmWWpzdHR0VG1s?=
 =?utf-8?B?THpCRGh2YWI3TlEzOTFRSlVlMGc5cmwzQ0JWSFVIZ3ZKVjZpL1cvMnZnWUlM?=
 =?utf-8?B?ZHJJNVJhdE1CWEs2RUlCWXZZcjRBQXc2VDJYNnNUbGlNNnNQUWREc1ZBZ2Na?=
 =?utf-8?B?T2tZOGYvT3R1QVdmK3VRVzZZdDVEYmNWUldNK09FK0dQN2FJTjBqWUtJNkJr?=
 =?utf-8?B?ZS9kcXlrelkySGl6YWUzSnN3K1paSG9JQzFsTURZMW9uUmRwLzBndUZDVHd4?=
 =?utf-8?B?YkFjUDlQbG4rSjRKUlBVdXg3RU9mTldMUFpZczFqazErNi9HQXoxUFUvc1NL?=
 =?utf-8?B?MzV6ckRLcSs5VzAxRDhnMkcxVGVmTjk3S2pYZ2ppQm1mYXFEK1VweDR2Z2dw?=
 =?utf-8?B?MkhwTmR4M0hCeitoQjkvNTNMcDd0VENHOVpMZmovVVR6VXE1NUFaT3VWbXBO?=
 =?utf-8?B?eGVabmlJaUcyU2ZzYjNqdzlYOThPUkNERWpQZlFzSGxFa2tMNm1ZMEI0Yi9M?=
 =?utf-8?B?ZU1oNjJ3eTM0NUFCTFB5MXNvVGFaVUc2d29UZWhyaEk4Q1dOZmM5SjhRYkx3?=
 =?utf-8?B?NTYvc0xZQU84aE9pVHdJSlZaaHpUVHM3UUdFRDBTd3RkZmQ3LzNXT05MT3dh?=
 =?utf-8?B?OHk1aS90ZmkySjA2NHZiQjlLVyt2aTF6NURqUXhwc3I4QytJWm9YdVdCVXFt?=
 =?utf-8?B?eDUyTUoyQ3RUQjJxREJDUW5ycTZBTmlyZndwQXlOMGdsWkRpcGRxUnhublpr?=
 =?utf-8?B?ZDFwYzZ6Nkw5R2swb2EwZ0lqV3pRc3g4eEdKUWVqbm4rYlN6Vm5mYWlLNmR0?=
 =?utf-8?B?aFRjRlcxUUdIWTNocXNwSUM1L3ZYdmVxU05Vb1J4T1hHbE04Q1JjVExDWm43?=
 =?utf-8?B?TWFVVnk2UkNUY1NYYVpzdUNMOExIZDdoR0UvdjV4L1V4eC9qU1V4YzVaY1Jx?=
 =?utf-8?B?WXZ4cXc2VjVkM3BzY3hycUN6aGhwZ2Zxb3I1Y3EyNFBWSVJnZGtmQTRHQ3JY?=
 =?utf-8?B?UFlzUTd0NjBGeDZRYTFoVndUSURRMGp4NkFwM0tnNm16NXYrRis1RE5Lcnoz?=
 =?utf-8?B?a2pGeEZ0c0hBMlNIMm16UUg4WW9WZ1ljYlI1YXJSZ0tMRmJoc1lGZldXTVFj?=
 =?utf-8?B?UlhJYWtsdWdVb3IrRTdkQWJ3MjVRalJ4VTdnZmIwUnIvQU5McE1paklUMENP?=
 =?utf-8?B?bnhUNzNzc3p4cEd5S05KbHpRVWxxSlVaNjZyYkIyOTFuMmtzTExhcjlPamRy?=
 =?utf-8?B?TFZJOCtFQkJuRlJzbTQ3akhDQWtLeHJOUEpIemIyNDJ3R1dIdEEvUUN1OVZ0?=
 =?utf-8?B?K21LK01QaE04MEcwVjVLdjlOQTFLRXlQMnlYZ2dWQzBtOUhKRnR0SnZLWmE1?=
 =?utf-8?B?bnBML0F3cW1TV2NGSExlS3NQRjUzNm5Tc24zZTVCc0EyMk54MFcvTUVhTzZC?=
 =?utf-8?B?S0cwRTduRFFVVGpWT01rZHVEaE1vMVdvSW5CZHNaWnhSb0dqbnFNczVCYURq?=
 =?utf-8?B?M2ZGNTdPMmdKSTFJUnFVbzdXMlBPaTVuZHp1eWJCTDFBUnhxSk9pZjNRNDFG?=
 =?utf-8?B?TnZ0NGMxS2Z6Mnc1czdXaTNTb0lWeEpNSmhXLy9HOE1aaHRIbnhqODN1YXJY?=
 =?utf-8?B?S3o2N1VXNkRLb0s0cFFKWExNTEFYa0l1VDBkRHhLbGNaWndPSlhldmI3SFQz?=
 =?utf-8?B?d3dYZ3RBV0Z3NFViMEZRY0Q0b2I1VDFsQUQ0aGdJdWFwQ05CZFJQbGZYVHJy?=
 =?utf-8?B?QUJnWkNKWjRVN1NGY09OWURGc3d3QWU2Qm1mN1NXcmpQL0NCRG5yeXdlQW9V?=
 =?utf-8?B?VjY0SXFLSkt4VTJic1p1VEVtOW50ck1RNi9KdGlWenovc05kb3BJMlc0UnQx?=
 =?utf-8?B?MUhYWDdIMWFiZ0kydzd4RGdOV1gyRzFyeGNWbnJCQlhQZFpqMnFZb2NndWgr?=
 =?utf-8?B?U29xN0RiYXZiOVl3WVhMaXlzekZSQVpGZmdtd3ZGenRJeGxhUWNJN25SOUxl?=
 =?utf-8?B?eDFldUFSeXV1THFsdHJiQ0RaQi9pT3VpUG8rQldxb2w5UGdOU3ppR3VkMEYr?=
 =?utf-8?B?RWVBTHhmZ3BncXJPQ0NSWERSenVLRG1VSmlJdUI4RjBtc3NIYmFYSlp4c1Nx?=
 =?utf-8?B?UDdDbS9MZ29ZOThNNDhGQXcvaHduRUg1SHFjWXVta0lvdkFsVGdiUmhnQ3Zv?=
 =?utf-8?B?N3hhVm5UYlVBWGJpNUs1RW9sak90RXBZVVQ5blM3TEZaV0RUWTRpZjJ5MFdE?=
 =?utf-8?Q?p6BGfRoHa3MPhlww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C084929C0FAE4438710CB70DC9DD092@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40a2900-b418-412e-27f0-08de6e2bb6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 13:51:56.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KB8/Y1B1mQuzIfKWENm5bGLYz8k0vXX0JzBGjPHs9Elz3yJE96ahQxr2ZRvpQIgjwBKHcXv7Ld6Hd5OnIJWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9387
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31951-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediateko365.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9193314CC72
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTE3IGF0IDE0OjIzICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNy8wMi8yMDI2IDEzOjU5LCBSeWRlciBMZWUgd3JvdGU6DQo+ID4gT24gVHVl
LCAyMDI2LTAyLTE3IGF0IDA4OjQ4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
PiA+ID4gT24gTW9uLCBGZWIgMTYsIDIwMjYgYXQgMDg6MDE6MTVBTSAtMDgwMCwgUnlkZXIgTGVl
IHdyb3RlOg0KPiA+ID4gPiBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgbXQ3OTE1L210NzkxNi9tdDc5
OTAvbXQ3OTkyL210Nzk5NiBQQ0kNCj4gPiA+ID4gZGV2aWNlcy4NCj4gPiA+IA0KPiA+ID4gTm8s
IGl0IGRvZXMgbm90IGFkZCBhbnkgc3VwcG9ydC4gSSBhc2tlZCB5b3UgdG8gcHJvdmlkZSByYXRp
b25hbGUNCj4gPiA+IHdoeQ0KPiA+ID4gdGhpcyBpcyBuZWVkZWQuDQo+ID4gPiANCj4gPiA+IEFs
c28sIHJlYWQgc3VibWl0dGluZyBwYXRjaGVzIGZpbmFsbHkgLSBpdCBpcyBub3QgIlRoaXMgYWRk
cy4uLiIuDQo+ID4gDQo+ID4gQXJlIHlvdSByZWZlcnJpbmcgdG8gdGhpcyAtIERlc2NyaWJlIHlv
dXIgY2hhbmdlcyBpbiBpbXBlcmF0aXZlDQo+ID4gbW9vZC4uLg0KPiANCj4gWWVzDQo+IA0KPiA+
IFNvLCB3aGF0IHdvdWxkIHlvdSBsaWtlIG1lIHRvIGRlc2NyaWJlIHRoaXMgY2hhbmdlPyB3aGF0
IGFib3V0IHRoaXMNCj4gPiAiQWRkIHBsYXRmb3JtIElEcyBmb3Iga25vd24gZGV2aWNlcyI/DQo+
IA0KPiBGaXJzdCBjb21tZW50IC0gcHJvdmlkZSByYXRpb25hbGUgd2h5IGRpc2NvdmVyYWJsZSBk
ZXZpY2VzIG5lZWRzIHRvDQo+IGJlDQo+IGRlc2NyaWJlZCBpbiBub24tZGlzY292ZXJhYmxlIHdh
eS4uLg0KPiANCg0KIlRoZSByYXRpb25hbGUgZm9yIGRlc2NyaWJpbmcgdGhlc2UgZGV2aWNlcyBp
cyB0aGF0IHRoZSBXaUZpIFRYIHBvd2VyDQpzZXR0aW5ncyBtdXN0IGJlIHByb3ZpZGVkIHZpYSB0
aGUgcGxhdGZvcm0ncyBEVFMgbm9kZS4gRGlmZmVyZW50IGRldmljZQ0KZ2VuZXJhdGlvbnMgaW50
ZXJwcmV0IHRoZXNlIHNldHRpbmdzIGRpZmZlcmVudGx5LCBzbyB3ZSBuZWVkIHRvDQpkaXN0aW5n
dWlzaCB0aGVtIHVzaW5nIFBDSSBJRHMgb3IgY29tcGF0aWJsZSBzdHJpbmdzIGluIHRoZQ0KZG9j
dW1lbnRhdGlvbi4gVGhlIGZvbGxvd2luZyBwYXRjaCB3aWxsIGZ1cnRoZXIgZXhwbGFpbiB0aGUg
ZGlmZmVyZW5jZXMNCmluIFRYIHBvd2VyIGhhbmRsaW5nIGJldHdlZW4gZ2VuZXJhdGlvbnMuIg0K
DQpJZiB5b3UgdGhpbmsgaXQncyBva2F5LCBJJ2xsIHdyaXRlIGl0IHRoaXMgd2F5Lg0KDQpSeWRl
cg0K

