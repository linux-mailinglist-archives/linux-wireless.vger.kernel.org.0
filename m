Return-Path: <linux-wireless+bounces-1128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DDB81AC9C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 03:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323BD1F2419A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87473C0F;
	Thu, 21 Dec 2023 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ff/wtxVr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cLg5toQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173B3C02
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6e2facbe9fa811eeba30773df0976c77-20231221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TqAE4/SUae1k4ufJhLu5H6da1ufmLTcl4BNf5WrmSpg=;
	b=Ff/wtxVrCyt+Lh7mV8kAxKI5ka7510HBIXSW8zPX05shjtTfp/i6T2VaSO4VHtqzi2wwJrrEbKImC4f7dr3OC0lh/1Rn4gyYqTCGQwTu4/QHuCwjwTuVL/4Lhg7YIP5YtAuk8RgKfuuk2AANffhYpBgz+AiYyeghJzcuqL5/efM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ea54e670-832f-4470-8ebb-911e16e3d571,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:11c5512e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6e2facbe9fa811eeba30773df0976c77-20231221
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1924092091; Thu, 21 Dec 2023 10:27:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Dec 2023 10:27:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Dec 2023 10:27:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2bBOj6hTqB86MTVi9cNYRBvNuHAsPakRnUqB5JJ4bnotL0SYYY2Y8L4TD1/D3kCof8gmWoXdklmgRDLwc15T1SScrILiqkiaJI3QfBju3kqiql/ln8zd8oHsiyYBAJwF2OgIT90EDEDZmzASzsbciBqHCWJrzbyAsEW83blYDd4da6JqgRkseXh2Aw3aj626Q5JAgMc5x5fsYSGNDQIaF0d4j/ndJqi/tNvOatttDcl30gjyBak12I9O46ZUnbKI358iaZybofUkWT3T4Mlz5kYTFoPKFNLZCCWY/KE3Pgxz5RV+/dK2aaO0ozmJRRt3sL1QPAQ4wkO+kpdXtDtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqAE4/SUae1k4ufJhLu5H6da1ufmLTcl4BNf5WrmSpg=;
 b=D8vq7O/sMa0uHYSL9sZ5j2JHI0Ymx1NZlvK5je703SDP49wonqUzdYmxUxfjggRpEBQrZYhRYiB2OgDFSPw7BDLWCmQAOc+0dRNm/xE0JVznmLpCjuVheVUFmVPOQyqcU2OSmU6J84t5J4F9YwLpwCWZ6f7jUarRzFTIirFk6gLTj4HWHcRfH+eIx3Qg4nEZbEuDwA/RzbP+JS5f/P8gjLFDCuCbblR/xi+DBkKfhfy8ljwQaVV+o4Uo965OUqaUwrPU4mEM0Xv1PPZ7P5efa4JuWZHx20bKpyZql5lYwR6AaC5LrleBF/qh0Zk8LVSpGhrGdhvo25phnzAXWQxH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqAE4/SUae1k4ufJhLu5H6da1ufmLTcl4BNf5WrmSpg=;
 b=cLg5toQ3K6MsYDxT+X0+saQb7ho9ApfR8L60pEIqWRVV0u/aHzPN++dHUiKSEkyaqgKdNJqJxJOYHe712HRBvXyuuzh4EBsdQEGD1x3Km1DjxD/GouoSCYVKGDE0ttSShM3eKsfv0SjUfu2QvIEab6ebwJcTvs0fW1oBXLtYQnM=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TYZPR03MB5453.apcprd03.prod.outlook.com (2603:1096:400:30::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.19; Thu, 21 Dec 2023 02:26:59 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::c9ed:a3ee:92d:7753]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::c9ed:a3ee:92d:7753%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 02:26:59 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "sean.wang@kernel.org" <sean.wang@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>, =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>, =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/4] wifi: mt76: mt7921: fix potential command timeout
 issues when suspend
Thread-Topic: [PATCH 2/4] wifi: mt76: mt7921: fix potential command timeout
 issues when suspend
Thread-Index: AQHaMyX2c1BfzAX68kKJiite+E/56rCyvIcAgABHhAA=
Date: Thu, 21 Dec 2023 02:26:59 +0000
Message-ID: <8d13d7442f8c3c17b7238f5da8dafa5b6c12fcc8.camel@mediatek.com>
References: <20231220092138.12830-1-mingyen.hsieh@mediatek.com>
	 <20231220092138.12830-3-mingyen.hsieh@mediatek.com>
	 <CAGp9LzoB5FRiectZD4RL2m6twBicSZvk3TvBM9EQgrsPyHG69g@mail.gmail.com>
In-Reply-To: <CAGp9LzoB5FRiectZD4RL2m6twBicSZvk3TvBM9EQgrsPyHG69g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TYZPR03MB5453:EE_
x-ms-office365-filtering-correlation-id: 37bc095a-2651-45d7-63b5-08dc01cc4f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EW9CJAINAdmxLIxMu2KrMUqkBdjtNucXJho7dLionTgVPHrDOmv8nfkELgeBdcSpnVTZyYA5NaUKBzuTamrqfYh7PvWGarv/N2vlCdsRQ+rNx+A1IR31enWKTEL0GELPWei3rNVUesSmkTX6/VluRh2pDb4jET/UX2mDQI6lN6O1hfnX5AWd45D4GZjeHcBSEkqur0Psg+PCiUxG0atDctQ6jDNO/4woXtNqf4UNiKtLs4h8VDug1fKL3wJexYrlw23fMtUlAk79V91z19ipC0ErgJzpdeqnyWaoWcjy4H07W20PC4WH75uZx4//AcqjhagPdqCWyDoAEMyzvmdPLDuuG+vFE8oZeBUytAFesQDa/n/4tkgQ9wwBXjX1+ocZkwTNQKFy4qVri6Q12KOvEJBHLPhayQrRFAmj2GDEvk8bBY0yls/72nB8NFJs+HIXGPLnxiMc6PNIL64lvVCRi4Y6asOULq5SXgSOtKV7oTQHe6NkrAl41OovHLqwtPCAHlQd8hkSbXO6zAcuCMarhIInhLhtGi9mZ/701weCIIwUqnxvMaOzinOVX7PAbbI7N6ZoOFdOV24iYYLPja8UElL52dPlE95N9Jxaj/MYXzR+Tb/VmClDyF0lfq98JCsSJFpwAHOB11LziGouO3BRr0be69QjlwHzf+eCWHAicm9+AQJLWpsYvHJ2SXq3ehtUNXA0yYNnktcek6vFDmxSiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(122000001)(38100700002)(91956017)(316002)(54906003)(8936002)(66556008)(6506007)(71200400001)(66446008)(76116006)(66476007)(64756008)(66946007)(2616005)(6512007)(6916009)(86362001)(2906002)(8676002)(26005)(4326008)(478600001)(53546011)(6486002)(4001150100001)(15650500001)(5660300002)(83380400001)(85182001)(36756003)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJQeVo3YXZyODF5RVUxb2dUeU5YTXhLZFdlb1I2bktWREt2NGNzcWorNVlU?=
 =?utf-8?B?S09pWWg1K1dvLyszQWxDS1pPaTFwNjZROENyODg5Sm1NcnBSZm83cUwxZmVT?=
 =?utf-8?B?YmNRRVVOVXpEWVNUUmhyKzJKT2NjRTY3akljbUpCYjRxeHpMOGJkVkQ1T21R?=
 =?utf-8?B?cWpKeFZwZit2N1dENkNGbWQwZ0VVcDJlS0MyRXBNZGhhdkgwVk9lYTg3Y0hi?=
 =?utf-8?B?SHJ3T1R0aFNwWEFld2NEZGJWYTI2dVNyU1lzbFZsQjFXcTcrU0I5ZVU4Tzk4?=
 =?utf-8?B?QWNBeUxGaXBiZndkYnQwSmRyK3ZoYWoxVVRjMDRXL24rMGg3WkhVT2pGbDRB?=
 =?utf-8?B?RE1sa1I4YnEreHBPTHdpSEVMOStzZkhVdjdkcEdXZ0VSTzIwSk1TdFdROVhi?=
 =?utf-8?B?UXhUQ3h2V3NxYjhwUjAySHFtMUFMUHBIbDF1NUpDNGpqZE0wcE0vUU53UjEz?=
 =?utf-8?B?K0QzQVNXUUdOeEdOUWZkSGcwYkJZejhVQUttV1Fkak42ckdxRVVyRDF6Tys4?=
 =?utf-8?B?VmFOUEh3MFJLNG1rQkZOejNwcUhRY0Q3ZTNpUk5seGVmQ0NFL0h6bTgvK2Ji?=
 =?utf-8?B?U3pPakh5RDdhSXl6QnZyZExhN2dmYnp2OFlJMFByclRqckFHOVIwK0RIT3lz?=
 =?utf-8?B?QlJoYVBRU2UvY3FSODRqRERCMnRuME0yYVZPZEZ6VE16bUFHK0QvVmtlLzZv?=
 =?utf-8?B?WUltMkEwVU9BK0IwVmJTN1NXNlhFd256TnNqa2FGM3NlTUI2Q3pTWUFWRVo1?=
 =?utf-8?B?QjJseHhzYjViNnhpSmp1emF3TFJYTXMyZDh3SEV5ZlRCNnVHbU9uSHNIMWEv?=
 =?utf-8?B?MEZncGVtMGNLd3BtczdUZHE4V3lOWkRtYzQvNEtpRmNReTVEbHJRMEk2THBF?=
 =?utf-8?B?V2ZicklUUm15Ty9KSEdWdnpXZnhidlQ2VU9HS1dTWHdzVVR5eHZoMDJhRU0r?=
 =?utf-8?B?NnJRd2pRbGdhTFo0dzh1MVAyZDhwa1lkMFdEV2tzcGtrdEp2Ym5KRmtuTS96?=
 =?utf-8?B?V2FwRXlsWjNYZVpKeDlCU0liOEVNdEtRVUNSNmJRdGtBQjd1aGNQYjlOQkov?=
 =?utf-8?B?VGZxZU1PZUtkNldNbkZvYUIvSEdDS1h2ZHJzVTJ1dmZZYm8ycGhoNGNEYk5Z?=
 =?utf-8?B?Wk1ZUTU1cXIyV0tEL1FrbVg1d21oTFVsMnBPbmNZWFl4NTZTTFNNMDQ2Z2pF?=
 =?utf-8?B?QXVzejJORWtjRm5JZTA1bnYycUJ1M0FqRklXUVFyMm5ia1E0TW1TYnZKckJP?=
 =?utf-8?B?dTREMUFPWEVHVkZHbXB2VWlZZkVUQ3AzMWRCNjlIamxyazNFUGJPSUhJT0Zw?=
 =?utf-8?B?Si9Wc3ZBREFUYlZoemloK1JSd1lBaUZKSUh0OUtZZWhUbnBUSnM2eDByaFFO?=
 =?utf-8?B?cG9Jem5jaTkyWXcvZUxQcTZJZ01YemlwQzlqUDk4cE96TzNod0ZRVXoxcGUz?=
 =?utf-8?B?QnozSnNCbXA2N1o1Y2ZRdU9pekpSSkpKRStCclBxNmpPSm94SXAyTkYxbGw5?=
 =?utf-8?B?RzZHcWlnYmkybkxrTi94WkxPZHgxUERQTXl6ZTd4KzFIMGZxZXRXNGRYTE1o?=
 =?utf-8?B?TTBVb2N0RnhQWXV5M0JNRWV2STl5YnFwVldHWTY2Y0REeWVkWnNxanhmU29D?=
 =?utf-8?B?NFlvYW1xUXRNWnVRTXJ1QkljUkdhSlZzWDhsdDhCcllXVm1UZ3lSSEQ0ekpy?=
 =?utf-8?B?WHdNUWJKVmdnazFsRTFnSXRjSkpiUjlhR2RCMzVyZkFpWE9xU0YyM2dGTVU3?=
 =?utf-8?B?RmZnaTlDRVNYSG9wN09FVGNkaGk4enFiN3ExbnhFQVoxQy82L3NLaStjSHNu?=
 =?utf-8?B?U055YWZGT0JjZGZFbFRxd2RoRTNiVFpaMFllNXhFS2lrWHJSdjN0MEVXbjZZ?=
 =?utf-8?B?RGxmMmxMK3JTdG5Wckk2R0FHb1BmZUQ3ZDlLZ0dQR0dYUFpRdGxWVUJZaUts?=
 =?utf-8?B?eHRYelhTb2ticytJbENKWFhCUHJySXA0OXNmeHorSFlWczlTbXRtWHNsVkRM?=
 =?utf-8?B?SFNHQktOMnBUa29ncEFSZGdZTWRzUzhLbjMxeWZKMStRRDhTNTFURDNaZXFi?=
 =?utf-8?B?ZktjUlg4TE1JUnRxc29hTWtTMmRPWWhtTThIOG5rWGJkS1FrREpKajBjby93?=
 =?utf-8?B?ek1LVDIzdTFuaDNxK0tla3I5L0MwTDhDNmVsbTVvY3YxM2t6K1RvREU0MEFR?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19D4A0F60C16B24B83392BA8B591FCF6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc095a-2651-45d7-63b5-08dc01cc4f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 02:26:59.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVQOL2lzHtB7C9mTHzQhnR6MmIywjJoTPX6wf1RKbOnfS/LaeEj4dcpT9kZdhVS04Kz3r14k8X2Ts99pdWnmuwzTLVMKXz7Q2wRHZ2XF290=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5453
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.536000-8.000000
X-TMASE-MatchedRID: yxAmdCLMIs3UL3YCMmnG4reiCVGXv/W5gDRlwc+wR6cNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CzZ7G9IOccodJ722hDqHosTGzj
	pHB/c7HmmqTewdTVd4SNwJCYMmgXfrRlLslggfyo0JY9d6s3vaRyDrkIwjihb5cW089Vzj0f5WK
	Feqf3EscF9H9ZT7pg42VNcF3VnxXwevkYX4sJVnbN1X1PclxBIqCwfyXYE0mqBUG0e6KtgoOph8
	zS0iA+p3fUXMgqsPWCtK8q1sM7kcRZK05xEkCkCfoNDZMQOpmwt5hHxk0yte23D6f6IpbLINSLa
	tMg7EYbvdIhHDFppL4ccwYD1OIGLfrCVjQeoDBA6N/cDgNNi4bvHoEoNlEQf5Tb+T4oaGfyjxYy
	RBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKTpcQTtiHDgWlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.536000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A57F05566F741A81BDFA80FE10CF2A7F346BE47C3105EF553E913DF08EAA659B2000:8

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDE2OjExIC0wNjAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgSGkgTWluZ3llbiwNCj4gDQo+IE9uIFdlZCwgRGVjIDIwLCAyMDIzIGF0IDM6
MjLigK9BTSBNaW5neWVuIEhzaWVoDQo+IDxtaW5neWVuLmhzaWVoQG1lZGlhdGVrLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBGcm9tOiBNaW5nIFllbiBIc2llaCA8bWluZ3llbi5oc2llaEBtZWRpYXRl
ay5jb20+DQo+ID4NCj4gPiBBbiBvbmdvaW5nIGNvbW1hbmQgbWF5IGJlIGludGVycnVwdGVkIGlm
IHN1c3BlbmRlZCwgbGVhZGluZyB0byBhDQo+ID4gY29tbWFuZCB0aW1lb3V0LiBBZGQgYSBsb2Nr
IHRvIHRoZSBzdXNwZW5kIGZ1bmN0aW9uIGluIG9yZGVyIHRvDQo+ID4gcHJvdGVjdCB0aGUgb25n
b2luZyBjb21tYW5kIGZyb20gYmVpbmcgaW50ZXJydXB0ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMZW9uIFllbiA8bGVvbi55ZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IE1pbmcgWWVuIEhzaWVoIDxtaW5neWVuLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvcGNpLmMgfCAyICsr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYw0KPiBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL3BjaS5jDQo+ID4gaW5k
ZXggNTc5MDNjNmU0ZjExLi5lMWM1M2YxOGFiZGMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvcGNpLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYw0KPiA+IEBAIC00MDksNyAr
NDA5LDkgQEAgc3RhdGljIGludCBtdDc5MjFfcGNpX3N1c3BlbmQoc3RydWN0IGRldmljZQ0KPiAq
ZGV2aWNlKQ0KPiA+ICAgICAgICAgaWYgKGVyciA8IDApDQo+ID4gICAgICAgICAgICAgICAgIGdv
dG8gcmVzdG9yZV9zdXNwZW5kOw0KPiA+DQo+ID4gKyAgICAgICBtdDc5MnhfbXV0ZXhfYWNxdWly
ZShkZXYpOw0KPiA+ICAgICAgICAgZXJyID0gbXQ3Nl9jb25uYWNfbWN1X3NldF9oaWZfc3VzcGVu
ZChtZGV2LCB0cnVlKTsNCj4gPiArICAgICAgIG10NzkyeF9tdXRleF9yZWxlYXNlKGRldik7DQo+
IA0KPiBJIGhhZCBhc3N1bWVkIHRoYXQgYWxsIGNvbW1hbmRzIHdvdWxkIGZpbmlzaCB1cCBiZWZv
cmUgdGhlIHN1c3BlbmQNCj4gaGFuZGxlciBpcyBjYWxsZWQsIGdpdmVuIHRoYXQgcHJvY2Vzc2Vz
IGFyZSBmcm96ZW4gYmVmb3JlIHRoZQ0KPiBzdXNwZW5zaW9uIGNhbiBwcm9ncmVzcy4gQ291bGQg
eW91IHByb3ZpZGUgbW9yZSBkZXRhaWxzIG9uIHRoZQ0KPiBzcGVjaWZpYyBjb25mbGljdCBiZXR3
ZWVuIHRoZXNlIHR3byBjb21tYW5kcyBhbmQgaG93IGl0IHJlc3VsdHMgaW4NCj4gdGhlDQo+IGNv
bW1hbmQgdGltZW91dD8NCj4gDQo+IE1vcmVvdmVyLCB3aGlsZSBJIHVuZGVyc3RhbmQgeW91J3Zl
IGlkZW50aWZpZWQgc29tZSBwb3RlbnRpYWwgaXNzdWVzLA0KPiBJIHN1Z2dlc3Qgd2Ugd29yayB0
b3dhcmRzIGEgY29tcHJlaGVuc2l2ZSBzb2x1dGlvbiB0byBhZGRyZXNzDQo+IHRpbWVvdXRzDQo+
IGNhdXNlZCBieSBwb3RlbnRpYWwgY29tbWFuZCBjb25mbGljdHMsIG5vdCBqdXN0IGZvciB0aGUg
c3BlY2lmaWMNCj4gY29tbWFuZC4gRm9yIGluc3RhbmNlLCB3ZSBzaG91bGQgdGFrZSBpbnRvIGFj
Y291bnQgb3RoZXIgTUNVIGNvbW1hbmRzDQo+IGR1cmluZyBzdXNwZW5zaW9uIGFuZCBleHRlbmQg
dGhpcyBjb25zaWRlcmF0aW9uIHRvIHNpbWlsYXIgc2NlbmFyaW9zDQo+IGluIFNESU8gc3VzcGVu
c2lvbi4NCj4gDQo+ID4gICAgICAgICBpZiAoZXJyKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3Rv
IHJlc3RvcmVfc3VzcGVuZDsNCj4gPg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+ID4NCj4gPg0KDQpI
aSBTZWFuLA0KDQpUaGlzIGNhc2Ugb2NjdXJzIHdoZW4gZW50ZXJpbmcgc3VzcGVuZCBtb2RlIGR1
cmluZyBhIGNvbm5lY3Rpb24uIEFzIHRoZQ0Kc3lzdGVtIHRyYW5zaXRpb25zIGZyb20gYSBjb25u
ZWN0ZWQgc3RhdGUgdG8gYSBkaXNjb25uZWN0ZWQgc3RhdGUgdXBvbg0KZW50ZXJpbmcgc3VzcGVu
ZCwgaXQgY2FsbHMgdGhlIC5yZWdkX25vdGlmaWVyKCkgZnVuY3Rpb24uIENvbnNlcXVlbnRseSwN
CnRoZSBtdDc5MjEgZXhlY3V0ZXMgdGhlIENMQyBjbWQuIE1lYW53aGlsZSwgYmVjYXVzZSB0aGUg
c3VzcGVuZCBjbWQgaXMNCm5vdCBwcm90ZWN0ZWQgYnkgYSBsb2NrLCB0aGUgc3lzdGVtIHByb2Nl
ZWRzIHRvIHN1c3BlbmQsIHJlc3VsdGluZyBpbg0KdGhlIENMQyBjbWQgbm90IGNvbXBsZXRpbmcg
YW5kIGNhdXNpbmcgYSBjb21tYW5kIHRpbWVvdXQuDQo=

