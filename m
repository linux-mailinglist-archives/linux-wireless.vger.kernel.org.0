Return-Path: <linux-wireless+bounces-31727-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEKEDwNHjGkHkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31727-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:08:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556612288E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B403018C0D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC493542CA;
	Wed, 11 Feb 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E5sMsTMs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NkpdUDAm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8170808;
	Wed, 11 Feb 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800889; cv=fail; b=Z97xGv9VDNMEKtwSopJa3mHmOnUdcUK/mjmDhfUGB44Wf+kCln7MZsCEBkXhVAtFYmvD/kDAPWVv13deUup3NX5t1lg4j1+C0H3ID52RvBv4CS47jRj0jfms+x1ovNjeK7PLznFyHWP52Gj283xQj+SUgoNskxiCcL/+1tKdPjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800889; c=relaxed/simple;
	bh=srml12+ufXPw/5DWKOoH78DyfAVxTQVHHL+jdnn/GY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGyjxOg2eFBHY7AOR8RCsIMp/cXFrcWuderHb5GNF52pu23Rx1RwAzYyFcqrYZG6OHLTTMKVfMSdai6RJsGiPoc1xLp3gPTywpevAiMPT9uq+RCmIU4oNZpqA+jMxMCv4DQPGt2/joF52XuVqI7+UCYMXDHMh1W00VI65I8SwzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E5sMsTMs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NkpdUDAm; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ab4727c072911f1b7fc4fdb8733b2bc-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=srml12+ufXPw/5DWKOoH78DyfAVxTQVHHL+jdnn/GY4=;
	b=E5sMsTMskSjABkiyJh0J/qkcStc02UuUxwrPTUvzBaAyopfMAwoUqcKyrlWj7H1L/GynEiRVLtpt+hK8AMezQOfhLVccTD93454F4shB3d8J1xpzdNR62SF7zI4deB9/TCImGzzVOmc5bFf+0loKn2/jQZDeMyrYbxB/TSSNNYY=;
X-CID-CACHE: Type:Local,Time:202602111613+08,HitQuantity:4
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:b7bec4cc-80e8-4ea4-bf1f-89e230aae7a3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:4c418fe9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ab4727c072911f1b7fc4fdb8733b2bc-20260211
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 426924669; Wed, 11 Feb 2026 17:08:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 17:08:00 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 17:08:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+fcRhglrI0sflkScvPnlF6LGcD+fIIBiunfHUkD6O/dBgCx4vBX/F8fnaXoNmUwXT7bnJi3g1vRx7an1rtHFlUXxL75KnheK8lbtNOSIOmlBkl8vtYEMC/kZkSJKPBoHWbJtHQMC60Kxrt+LvLk0wHrXSB3rZEwtMo+WSvcQN5DSm9Mva5KopUGurD7GqkaYEmxQwTViQMYPkl55YMBvoX7bueE7+s9XjDZdzgGtNJVbOhLX/pal1f/TnEdUZYuSXnqJJwqQUh5N0jktUSaizMHQGWxBlbhG+0jiUmjsa9xEl9LJS2g0R1wbDsrpYUYpLd/4SzPnOJWtNNZ9jVegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srml12+ufXPw/5DWKOoH78DyfAVxTQVHHL+jdnn/GY4=;
 b=LcO3Wy44TXmvW4CQdCk3rfiQxowHUjLWGagaO1UgOc2Kc7gQWj5plAz0RXlbattRtnImrxykq/zITTjY+ZSJWGXh1/cY9Fgl0kgS82LyjHKAZJe71r4VpPOLkNjB12VhDRm9vDyWw/YMZyrPVVL1Rvsfgtjeu6NiHujeqfqJxA5wiBdcgMj83OtSbfGzEx5BCTu5+4cwPH82V+09IAsqU2q4Suu23Z7ZvTjWQTJHZ/iECBapSecKLs+iumt4Liou+90wJVgsepG+mv0Cp1aFASZec4qFgAr3bg0Jl3IUiJ7roSYlhu4DvbvRZqiNeTGxHc/Ps/LQeoOVoN8I2I/zVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srml12+ufXPw/5DWKOoH78DyfAVxTQVHHL+jdnn/GY4=;
 b=NkpdUDAm1SHW9ItbytflbQ6gIGlJHJVJ9KyarJ0L+to6QLtQRBg0qQ4AkLjOkBrnmLoaGL7cTnvh2MSCnbl53dEs5bkgBhjVu8THB/0xrMurwwhir+71lqk8Hiz9vAFAcMuOUx+MU9PueuvyhO9sB7QR993ZkxpY72cCPVJOnzM=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KU2PPF5FB3746AA.apcprd03.prod.outlook.com (2603:1096:d18::412) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Wed, 11 Feb
 2026 09:07:58 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 09:07:57 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "wenst@chromium.org" <wenst@chromium.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbICAAAELgIAABKcAgAACKQCAAAWbAIAAAdKA
Date: Wed, 11 Feb 2026 09:07:57 +0000
Message-ID: <622c89592f5fdc7fb8547c3cd9ed66cc63c3cf92.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <20260211-miniature-chital-of-plenty-1a71df@quoll>
	 <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
	 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
	 <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
	 <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
	 <CAGXv+5EY=8Xta4OdnS9Skjx3Ls3ZnW7oNS38cK1Ch=wL6JJJ0g@mail.gmail.com>
In-Reply-To: <CAGXv+5EY=8Xta4OdnS9Skjx3Ls3ZnW7oNS38cK1Ch=wL6JJJ0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KU2PPF5FB3746AA:EE_
x-ms-office365-filtering-correlation-id: d1dd4d6d-6a2f-4db3-03cc-08de694d0ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QnVwbnNNV2pYQ2NVQnAyb1pRZ21aSFZ5cjJnTUYrU2R6U0F6bm00SEtndHoz?=
 =?utf-8?B?R2RBVGllZGR4WXlCUnRBWVREWGpISUNIWGpLV1JiVkNTS213ZnRJbXd2RmJq?=
 =?utf-8?B?V3NqMHN1WkZOWTh3cW8zK0VsVWVZc3F5c0VJcGY5T245R05UZkFoa3lFZXh0?=
 =?utf-8?B?cmgxempnUEppQ1dldFNnS1psT2ZKMnFWZGxQWWhqZTZzL2g3Qzh6ZDNjN1F1?=
 =?utf-8?B?Z29NcW1XNDVscW1GbDhZczhiVXR5VEoza1VDOHEzRHYxdkdOTFNHbVdDemVI?=
 =?utf-8?B?bklHQ1lHWkFsbVFBOUowT3BDcHFNZVcxRENiRkdUVDZwcjg2aE1ld29PcmRo?=
 =?utf-8?B?ZVdiOVhzKytsc0pKMUNqTEtMR1ZnNjk3SUtwM0xYNWxMUzNOSW9MZVlHUVpr?=
 =?utf-8?B?NkNnOHdETExMVGJyVkpyV0RlcXh5UTFjSU5nN20wMU4xNE4xb25TQndpaFJh?=
 =?utf-8?B?bndjVmQ5NzJYemR1elVJaFFtdk4wN1ZXZEk5QW9QcUFOK2Jwb3o4L3VZTG5l?=
 =?utf-8?B?TkhmNXhVZldmVEJyQU9rNk05L2lFdEtMNFdOSzJHVnBOeW5aZ01ielVrTzU3?=
 =?utf-8?B?cEdKSmo5M1BQUS9oL0xWNkhvQzNrdDRWM3BWQWJVcjdjbXZYV0ZXTTU5U2FT?=
 =?utf-8?B?YXQ4YmxrbEdKTFcrZk1ZVXRVeU9Vek9IUW5oK1EwZEFKbUszOVk3UHE3T2Zs?=
 =?utf-8?B?UWErc24wYXhjV09VYm52d1R6QkhUVWcyNXVBd21IT3VUWFdaK3NNYUJHaVNM?=
 =?utf-8?B?eHJSeXoyM1g4a1VxcjNzWElJZ3VpdVVpMUxLd05kU1VLWHZOU1Noc3hIL1RC?=
 =?utf-8?B?Z2FRTWxsN09KL0UzT2RhK0xOdWpDWDIxSGFaN3FYRmJvcXBMald4b2FJYlNL?=
 =?utf-8?B?RXNOWTkvRkZ5NUZtc05LclF3QkFqOHMwNExreDl3NjBpM1Jqa1NXamhlKzlt?=
 =?utf-8?B?OEQrQWtEUTNZdFN6TGJFVUk5NE55ZXB3M0xFVjF0RFhQenFaWnJabXZyQlNh?=
 =?utf-8?B?WERTMGZiNEJ3dHk3Smo0MW85NVc1NDU3SzlVT2wxbkVPS1BBUDNkZTVFbmpn?=
 =?utf-8?B?bHM3TVlUK3IwYjVWd1JsT1NQbnZBZ1N2SFlMTzAyb2REa2tMTkpxY2xZQ2hh?=
 =?utf-8?B?ZGhRQkRvL3U2bVZhT0EwdmIxZ0lzemNabFpDeGRoVWFTNzVjYlJaNVFYSlNa?=
 =?utf-8?B?eUNZMzQycEkyVXI3Mi84M2xNaUlHVEYyeWh1UElDVHU2dXRrY3M3bnpOS0lX?=
 =?utf-8?B?UEtWNUVDeGFaTHBHemtnNjJhYzF1dFlqN3lNQnYwRmpCWWU3M1JJblE3OXox?=
 =?utf-8?B?SGFBS2dXMWZWb2g4WnJYem04U1JQQWhPTUdYV1RaV2hmNWVnNkxSZmRSSVdU?=
 =?utf-8?B?THJubnNhaUluUC95YW9ScDFVQU1FbzhHK3BZTlhOd0hPOVljN3E3OXBSWjZH?=
 =?utf-8?B?b3kza0Q2eXJqUS9xa3RIczZESDhxeEdodGwreGtUdTVqaGN5L3N6aTlQQ1po?=
 =?utf-8?B?TU1zcThxalJLMU9MYWVrRW41Y1dCTHZhTGxqU3hza011Q1JLRm5xaG4wQy9o?=
 =?utf-8?B?NkN6VTh4YkYrZGYvWU5HdjFUNG1TTStKT016KzY5QmI5RVpnN1M2VVhBWmNC?=
 =?utf-8?B?bGVtNkRmdkZhUGdVKytDMHlkbEhvMmNQUHI3VitNcHNUVFVhSG5vK2FIcm1E?=
 =?utf-8?B?aVlTOVl4KzBqc0szeHlhKzd3SmtTRGs5R01hWUhvbmVQYUFwTkNSaGJlMHJ5?=
 =?utf-8?B?eVRCdFhnL1U3bzJxNC9UblA3bWhWMUlpWWdOSEgyQmdtaGxyeVdReWpyZFMy?=
 =?utf-8?B?V0wrQXBLQmFYNWhHUG5nOEc3VTZ6L0VYRGxhWk9tcnZhcmMxRDhpNTlWek42?=
 =?utf-8?B?YURaVXpNbFNmRmcvVEpteGdmZTNTRVh3VWs1dnBWSlBRNjBIeXI1Z0hTa3lX?=
 =?utf-8?B?NzFoLzlHYkhmNHZlZ2NWMWt1MGNVU084Q0tJRHN0eks4UHJCVlloTGw5SFNn?=
 =?utf-8?B?c2hXdCtINFNWSFJvZGVBdEROMzdwcy94c3VGUm9KOU9tQ0R0QldNaG1VTXF6?=
 =?utf-8?B?VXFuZ3BZNnFNUmczRWxlVmNZRlpDc3VYZ1BjY21oVXdmV0xadGN2LzRqRzRK?=
 =?utf-8?B?NU50WVZiMjYxMzM5ZHE5N1FBRDVJZnVwMm1BcHE0QWRiS0lLZFRKZ0lYMndU?=
 =?utf-8?Q?4aq82c1Avulv4gBfax+11QM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpsUFVVYmdxSjNaTGhaMGY4LzZkd1BNdFMrMENXR1YvYVMvYXhLNEo1a2Jz?=
 =?utf-8?B?NkVnTkw2RUR0N0d0a0NYUS9sOE55Und3ajRkM0drTUNVU1RXbWYvYS80UGE2?=
 =?utf-8?B?Zmk2a21xd2tYNzRTOEMrWXllbTlyRXV4NDJ5bVNMZmJ4U00zYzFUdWZ1Wkd4?=
 =?utf-8?B?ZU0zaVNvTHRNaEhaclNLdGR6cmNDVFNSYU54VUVjWjMyS083MHRwdnJ6bElk?=
 =?utf-8?B?UkpSYmhOcE50RkpRaTNjUGdtdGVZTy95Mm04WlpoS3NEdEkxckZ6TEN1eWxi?=
 =?utf-8?B?Y29pZ3dNRkFBMzRBdkd5V1dJcUVMZFliRkhPbTNFQWhtcDB2ZEhjNlNabWNl?=
 =?utf-8?B?MWt0VStWcFpWNE5zMnlDQ21ZTDJYMDJpNGVBN01UVUpVVEJGSzNLVTZtZ2k1?=
 =?utf-8?B?dGQxSG1QZm1tek54YXJoYy9JcVBJaXhqT0pGSFIwa0tSbzNsMEdWbG1jc0FN?=
 =?utf-8?B?QmVyVkhzLzl1YkQxRmljQ1c3REt4VmpmdXhpZjlzNnBLMzhvWDNTOE1yS2R6?=
 =?utf-8?B?czRlT0hodTJWVy9PRk1MdDhxQTJJY0ZIdk9lell0YjEvbkhlM21jcXRWcVpw?=
 =?utf-8?B?WFVLdWcwZWUxdDRRNWx4cTBHb3FXdG1CSE9SNHoxMjdJeVV0bCtuK3JYUXJz?=
 =?utf-8?B?UDlPSmthQUxPd2dwMm4vOHdwS2xNWnhhY3dYMGFLV005bGhmM0FBT1JqY3FY?=
 =?utf-8?B?V0pucytuQVhiRVN1aHNBYUV5dVY3OHVqQzFtTFFZQmV4bmYxbWhEUUMwSGlR?=
 =?utf-8?B?eU1FT0xGVEhCUTRIRzN3cGpCR1pvMTk1Y2xqSUlnK3VWTG5EVHVadTNNVk1v?=
 =?utf-8?B?dDk2T25PdnVTZFN1Z0s0R2Nsa3NZZm1ydnBaNDFLTTlLWEpTVHdUVFN4cGJQ?=
 =?utf-8?B?MFAvTi9oL052SVpOMEo4a2huYnBQOURGcy9YQ1BuSUFFbFBaVWsrUldvQk9w?=
 =?utf-8?B?QVhSd2I5NVI1MktvOG9kMmhLSWZ1ZGpWa3YveWFrcFBwbXBXREZ4TG9zMS9y?=
 =?utf-8?B?ZHNvOWNhRXRkU29tdEt1K2tSeHZSVWd1VFRCZU9zTk5nTnBnWmdwNG5YdU0v?=
 =?utf-8?B?UFhDQkZaZjdqM3FTeUZ1eS9YaDRlZy9VeFdhMlcxcUZDS1VKb0Y2Z3hHOU82?=
 =?utf-8?B?SlN4VU9hbk02dzVRVEFDREVPcGYwMk5xVk1MM1ByNzBoNHFIQ2lvS1pmMnZz?=
 =?utf-8?B?aFNGSFpvUkNFWmowMS9raFZuL3pjWmx3RHVLWHVVRDJ2N2pIcHNzSUMrY2pv?=
 =?utf-8?B?c2k3b0JCMk5IRS9WRXJDaXNRU0xWRjY3VHpOcmJrdHd2UFlUejlSblFEaW1C?=
 =?utf-8?B?QTZIOTdRUXJETVVEZEV5NFc4UTRJY3N3YUp5Z2R2RDRHcnlnRnlvUlpNUXJk?=
 =?utf-8?B?a3hZNkE4MlR5bVpGU3FjL1I5Z2N1aURSOE1wOFJobFRsWFA4TUdxc2JDOTE0?=
 =?utf-8?B?TmwwREQ3Q0RHNDFZR2lJVEQ5YmtTYTJyNHNyYUJpbHlzLzg2ZjIrY3gzRWds?=
 =?utf-8?B?YVJFY3RQM2x0cy9jQ2lhWEhnK2I5amdVRXdHdUp5Nkh3Yjg5RTMvckxnenU3?=
 =?utf-8?B?blEzM1RIdm5UU2RGcUpBWVZKVGZ6dWs1c3VROWVVaDdwYkVXRFQ1UGVyTmNh?=
 =?utf-8?B?US8reVZQSDRIeUVCZmpmckRtMTZWV21NL0ROU1loSnMvdE1MQ0E4TUNpNTBW?=
 =?utf-8?B?bmQrV09xdHhmVkRGZUo5aVVQYUE3NVloSjR6RXIwZHgrVE9qeXIxdkRPd1dl?=
 =?utf-8?B?RWYxc2tjUWdXRzQ0WXlKMHh3cGlaUTEyOFN5bXE1TXB2ajkwOFF2eURzK2xw?=
 =?utf-8?B?a1grTitqWCtZeUZXbkZHRHpMQjVBWXljaTg0VlEzNlJhOEdoSTg5dlRnZkZi?=
 =?utf-8?B?QzJKaDhQRWVXdjB5b2JFdTNTcTgvZmtJclNrL25lTEhwbXlWT0RCWUpVRndw?=
 =?utf-8?B?cW4rek1VZGlrKzU5NjAxRzlHbHQ3OEVWRldWak5IalZ5U2dFVzFTWWhrVVNG?=
 =?utf-8?B?R0lyYmJsTjF3Z0g1R0dxRUJXRjBRczNMbnp4M0I4TXNRTmdpTUd3VGJEMVBx?=
 =?utf-8?B?cTZvZkxDNkdIZFdCVXR5UWcwL1VkejErZ1Rpd0VsMnU1Z2hUbkg4NkZtQXF4?=
 =?utf-8?B?U1V4TzJoeVYxbU5POGZGRDdpRWo5NVB5aE91RXRNeEJPbENwNSt2bnVUYUYy?=
 =?utf-8?B?U0JvbCtWeG9DbWJic2JYaEV1NDVSQVVYVVo5WGgzL2REWllub2g1MTQvRWtX?=
 =?utf-8?B?ZXAvWFlZUkJ0KzNXTzdvTk16cUR6MmxXVEpRRnR3TjlRTFNyV3hwZjU1VGpq?=
 =?utf-8?B?bFh4NWxXNVdTTDVNS2lBOVNpR3YrS09nYjJwcFM3SjdMN0VQbFl0RUl4SEEy?=
 =?utf-8?Q?bWxtRRzFpaqhcKSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3A995377249444AB49A6659F74CC5F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dd4d6d-6a2f-4db3-03cc-08de694d0ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:07:57.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +APx36PPyltN4pI7TvTpmUPxvFmuBd06kFOu3hU7Q/DsDPEcERbEtYqgHrER2l9p9c1rS/MXeIWeOwMxnegctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF5FB3746AA
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31727-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediateko365.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3556612288E
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDE3OjAxICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IE9uIFdlZCwgRmViIDExLCAyMDI2IGF0IDQ6NDHigK9QTSBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnprQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIDExLzAyLzIwMjYgMDk6MzMs
IFJ5ZGVyIExlZSB3cm90ZToNCj4gPiA+ID4gPiA+IFdoeSB0aGlzIGNhbm5vdCBiZSBhIHNjaGVt
YT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2VsbCwgYWN0dWFsbHks
IGl0J3MgYWxyZWFkeSBhIHNjaGVtYS4gVGhpcyBpcyBqdXN0IGFuDQo+ID4gPiA+ID4gZXhwYW5k
ZWQNCj4gPiA+ID4gDQo+ID4gPiA+IFdoZXJlIGV4YWN0bHk/DQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBIb3cgMVQxc3MgaXMgdXNlZCBhY3Jvc3MgZGlmZmVyZW50IGdlbmVyYXRpb25zIGlzIHdo
YXQgbXkgZXhhbXBsZQ0KPiA+ID4gYWJvdmUNCj4gPiA+IHdhcyB0YWxraW5nIGFib3V0Lg0KPiA+
IA0KPiA+IFdoZXJlIGV4YWN0bHkgaXQgaXMgYWxyZWFkeSBhIHNjaGVtYT8gUGxlYXNlIHBvaW50
IG1lIGxpbmUgZW5jb2RpbmcNCj4gPiB0aGlzLg0KPiANCj4gSSB0aGluayB3aGF0IEtyenlzenRv
ZiBpcyBhc2tpbmcgaXMgd2h5IGNhbid0IHlvdSBoYXZlIGRpZmZlcmVudA0KPiBjb21wYXRpYmxl
DQo+IHN0cmluZ3MgZm9yIGVhY2ggZ2VuZXJhdGlvbiAoY29ubmFjLCBjb25uYWMyLCBjb25uYWMz
KSwgYW5kIHRoZW4gaGF2ZQ0KPiBjb25kaXRpb25hbHMgaW4gdGhpcyBkb2N1bWVudCB0byBkZXNj
cmliZSBpbiBwcm9wZXIgRFQgc2NoZW1hLCBub3QNCj4gdGV4dCwNCj4gdGhlIGxlbmd0aCByZXF1
aXJlbWVudHMgb2YgZWFjaCBwcm9wZXJ0eSBmb3IgZWFjaCBnZW5lcmF0aW9uLg0KPiANCj4gDQo+
IENoZW5ZdQ0KPiANCg0KT2gsIHNvIHRoaXMgaXMgZXhhY3RseSBteSBvcmlnaW5hbCBxdWVzdGlv
bjogaG93IGRvIEkgZGVzY3JpYmUgYSBQQ0llDQpkZXZpY2UgaW4gdGhlIHBsYXRmb3JtIGJpbmRp
bmcgd2hlbiB0aGVyZSBpcyBubyBjb21wYXRpYmxlIHN0cmluZyBmb3INCml0IChhIE5JQyBjYXJk
KT8NCg0KUnlkZXINCg==

