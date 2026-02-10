Return-Path: <linux-wireless+bounces-31708-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIiuJHx2i2nuUQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31708-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 19:18:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7527211E4A6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 19:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9919305B086
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB9B31355C;
	Tue, 10 Feb 2026 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MQ0csmcU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X8ySXyPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DD385EE9;
	Tue, 10 Feb 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747419; cv=fail; b=a7l+/AeAPFhBhYPI7WOQu80UzXR6YWhuguqZrC66FSYUC6I0wLEaSFcHKc/uXFFKx8fYY+YjbGn3j6YqsHaPBWrE7xPwTlpoXcQaiwb+/KOZEnOHE+CK/S/Chrk1Y6KsBsBORwt1//BgOBnN+DGEZ9Pq3TCcdQSDV+fA2fJT2K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747419; c=relaxed/simple;
	bh=zQTDOkdVcQw9/E1pZITO7GP5wH92hVsZaXJnRinKd7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVyD/TQ5WrpMHMeWZFRL0OfMQenekGLXw0w1b78nscOfqeNw4LaYIbRd2UkAdPKahlZAw92p3G4uHWIT5TKuLFHgBworLiD4pbng0g1aa3fFh/pwFimt1Izcgt1Jq6PfypPALftiZxYVIUAlj7w/A37g04K6qyyUrPdI2eNQ23o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MQ0csmcU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=X8ySXyPW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: abb6050206ac11f185319dbc3099e8fb-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zQTDOkdVcQw9/E1pZITO7GP5wH92hVsZaXJnRinKd7g=;
	b=MQ0csmcUGSJFy+f1xuGgc7rK+LfNJZjXxJoAJIrlmErb4Mjf55vom0cmXvosNuGtOMQO7M/s+b8mpVkwYPMIZ1W6BPPdRQDbsOVFNP3VKT4ZmqWdIG1qg3nHqJd85tx6fCktJnQTF7st0tYMVlV2M76UHZNK5oIyRM9z7z8rp0A=;
X-CID-CACHE: Type:Local,Time:202602110212+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:aff99a94-9dec-4e1b-9e8f-12dfcbb39a72,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:a36488e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: abb6050206ac11f185319dbc3099e8fb-20260211
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1800208212; Wed, 11 Feb 2026 02:16:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 02:16:49 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 02:16:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fThUnqj9fHaSQSRbgynejXIIUGyIediruP8Zj3eJMAHIEclSfzE/0pK/tzJG3qO9c5q8S5f3qqmulrEPdtozY6YyWrtjvIpBMzzYcmob6m8IuCJgqvgoB1uX7LL1i985YA1xYPMiT3SyfL+N64bi4tlUNjr0zsrk2vZ/f4mWXd3GgmjhDtX0gZuOZvZvz/0juV2uoW3K4mJ/02O8aJfVH3K+GDiOSJZiicsZ3bogNlXP7ihB6TQkAXBpZsnYxADXN9FmMyjkWaO/E5m4AJFfhIDZoPw0cOw2I6tO0KTLpGuUs9TKK/Muf5ynJoEMM1dKEc+QfFtxlEYYVZ7g/c58cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQTDOkdVcQw9/E1pZITO7GP5wH92hVsZaXJnRinKd7g=;
 b=TigUgZ0CrtKO3Ci5ROR17WtOY439Uuv6V2YYtzuTGeBDhl2rAp7bS7ZMs0fIasEnMHrHjUSgiQjId4c4yojtU9z8ksvZZgOMy5oP4tL4ETtmTZrU0sebdgWCZI8OSokwGaVtWT0UPUmtqPT1kEV9tq9umV6jXnNo82rKTd/RopornBKSolk90FMPLP29dYgyo89IdyN//QugnRI5A14BkAL2FmNYdN9WA1A2yNtA3C6oN3F59pIunJK+DZOAq+oTQLSNbkIVWbp+plzl3JNmwtxjJE+yR9DE84Mn3QMRuVZ3OeC9aVdvO874PMFCoj8WLxJp434Pv7aRrLtO0w3COA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQTDOkdVcQw9/E1pZITO7GP5wH92hVsZaXJnRinKd7g=;
 b=X8ySXyPWB/fnTKQOj4LgpQaVHxnAVlcDHntcYSlgPpQ17Td+ZlgxqykAqdq0YMXdn54IFtRTliaipP3NRJc9sZz8nTccgBZJl13K12iwyHm6xQCd9Bq8s5P/zxFdXpH97kw0+Op5eNDy0kuDYJH2NSlK9WQFZsqHD60FAwRGurA=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KUZPR03MB9442.apcprd03.prod.outlook.com (2603:1096:d10:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 18:16:47 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 18:16:47 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V8PESAgAABHoA=
Date: Tue, 10 Feb 2026 18:16:47 +0000
Message-ID: <2d333fa847c31fc41917f07e8aafce86da7ba0af.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <52244d9cbd63ff6b660074d0f44724896d1e88e3.camel@mediatek.com>
In-Reply-To: <52244d9cbd63ff6b660074d0f44724896d1e88e3.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KUZPR03MB9442:EE_
x-ms-office365-filtering-correlation-id: 755d2d23-1e67-4131-3d6b-08de68d08d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dStHcFdtYjZOVVFoWHo5NVg5UmFpRzM5Qi9tNWJoeG5wMVE5NEovbFgyeG96?=
 =?utf-8?B?blR5UUNlaDdjRm9RZXRDeVMzZU1GaWU1WEdoQUZPNFZ6TlRma3NLWVQ5ZGNH?=
 =?utf-8?B?SjFia3E2bS9LMkNlNWZSVjhmb29kdWIzR0xyeTlDWXR1VG92N2daWEdhV2xy?=
 =?utf-8?B?SDYxUjZSUXhDQzJHNXJpYWtHbXd6KzdkZ0ZIUWQwY2VwSXZWbHNDb3AybGFY?=
 =?utf-8?B?R1BhVjM1VlRWd29zMThVb0xDU2xwdnJ3WE1ZUXp6d0kxNmlJc0I2c0RCV1Ev?=
 =?utf-8?B?ZCtNNjJ1d1d4M1FyQVMwNHgzK3hOQUZ5dTNuMTdSZWVMenhRazJPQmgrVDQy?=
 =?utf-8?B?clJ5RDBURWxsdlMycmNBTURGRFBwakJOTlk0bW4vYlYxeE1pUjVJYkJxNzJV?=
 =?utf-8?B?dm1nK0oxTW9SeVpCdStEei83VTRJVnUrTzl5K0ZPNnFWNFRoM00vZ0IrdjlN?=
 =?utf-8?B?WUVIRWszblJzbVRxWkhKNVZDVzFNRGV1VXQvYWJhZm1SQ2VXakJ0Z1cwSUJZ?=
 =?utf-8?B?NWJtUTNlUnVQWlQxZDhlOEFwL1A3ak9vVURTQzNyUTgrN1QyWXBlYzl2QkVS?=
 =?utf-8?B?Z20zWjhiRkh6T0Y1TVkwWGVFYkFPaWV2OWVmZWxSbENObkJWTjVILzRUZ0ov?=
 =?utf-8?B?d1h1RkJyK3NpYnd2UU90Vnl2cm9WelRjbDRFeWloekl1cUJic2VhdDBvYXMv?=
 =?utf-8?B?RDY0Vm9aS1RwSDJrbnVFSktmUlRhUndSZmVHdEhsR3ljSFdQbnEzWFlxcUxk?=
 =?utf-8?B?cG1GQzczeEF1bDVRem11SWNFTCsxZUVaOEtiNzZHRjgvcXYwbnZsOGhXOWVM?=
 =?utf-8?B?anMweHhTSDVvM3RGbGUyNjl5TVhZQ05RWVhvWXNSUGY0SXN0Y3psdTUzWVRY?=
 =?utf-8?B?U3picVplTCsyaEtWYi84QzNqWGRxcUFaZDVtOTFwbDltMDN3M1l0eXgrdTAx?=
 =?utf-8?B?SWlvZ1REQTBPT1lVZFpucGhIV2FmQUFOTzdmbXEveXNHcjJKR21lMjZOWjVI?=
 =?utf-8?B?RHN2ZzQ2alAzUlBSanBhZUJybEJDR0M2QmR5SVljczNFWWtydkxORzlsMjkv?=
 =?utf-8?B?dW1tZ0ExM0o0QWppc25YTFM4R3NCZnhGd0VPYS9tWm0yZWlaZ2o0U3QvL3dQ?=
 =?utf-8?B?dklGeWI4MmJZQWcwNkpHNTN2U0FwN3crZElPWGdPRFFsQW1oeEhMV3NIYjBi?=
 =?utf-8?B?ZGw1OGhMSHd2UG1lT2ZnTW9IbWdScjZlTXRTaVloc3lmMCt1Znd6Y0pPeEdT?=
 =?utf-8?B?bGUrc1NwVW02eTBSdXBJN2tRNUZlZUVXbEJReWVSODJORjFXRGVFYU4yaGRo?=
 =?utf-8?B?bVRKYmdsWGlZTjRNbVBlajNEb2ZnWnBERVJ6eVZuUTVNQ2JyYVZXczZKQkp6?=
 =?utf-8?B?RWZseURJRENwWTNsNU1LRmhHSVhGY0RHRnJTeUZTd1FCcVVob05jd2ltaFV4?=
 =?utf-8?B?Tjc2NWxwUE56Q2tLZzVlSGF0ZTJQamo1RXZYcjg0dU00MnpFNDdBZFZvd094?=
 =?utf-8?B?STVGVXZ1dFpiMjNzNlR3RVVxWGw3eko3U1kyLzIremlCNlFmNXZXRmJSdmI2?=
 =?utf-8?B?Z1pEL0dJL1lZMmVRM2UzVlFRVStTbXJuRXdmUlFBd0plZVBxQmdUd3VZQ0VE?=
 =?utf-8?B?c3BtN0MzbDIybUQ1Z2hLV04wNnNUNStXcS9DOUFrckoxTnRaa3g1NmlLWk5D?=
 =?utf-8?B?TkxuZjR1SjVzeitVd1BKT2ZjVUI3QXQ1NE1Yend4WTlSbzVjK3k3K3c3ZmdN?=
 =?utf-8?B?WGxPUUFJMU5jNnVkTGNrOGF3YjNJRXZ2OGVHQU5qUjQ5eWRCeGhYRzZPcnZO?=
 =?utf-8?B?WE5WVFVuWGREQmFpSG85OHFEK2MvMEw4ZkpQWUhzSTNUVnZoajgxOEtvOUVq?=
 =?utf-8?B?LytDWDF1ZWJzanNYc095cUxDMFExTThHK3Q3Z1d1VjdxWVJteVd2UjZlOW0y?=
 =?utf-8?B?WEJtd3crdnhxTlZHUHNIdTdMM0dlK3UrcHBvR3FnUFkyWHBHQUNVNDB1T0Nj?=
 =?utf-8?B?cEtBUkZ6TUFnTnpkRTR2eHVjNEhLOEp1TUhKTjZldy9rVU5QQlZ2dXE4Q2tR?=
 =?utf-8?B?OEU1bVg1VmdTNjByeVAyUUFLRkVjUnk1eUQrcFpybUYrY2g2cVJiQTIrZ3Rv?=
 =?utf-8?B?SFc3djJmR3psdUQ1MmRITkdlZ2ZKZlBGc0JhZDlVdkRKeVA0UFdXUzN0anZX?=
 =?utf-8?Q?H6Dp4EcDE03fJjEMamTUYok=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0d1ejBXY2JxeEJyVnFrMGIxTUpGem9JbDhueXkreSsrV3Y4cVFuVlhnM0Fv?=
 =?utf-8?B?SkpmMys1a0JHTUtzeDVjNEVNcUN4NjMvWWs3TVc4ZHYraUtDeEx0WEVrSnlL?=
 =?utf-8?B?Nmt2VE1CV3AyZ0RvRVhsZUZQcCtPbmpNbm12R1pldWtTbmNLc01rdlZYbDBU?=
 =?utf-8?B?K1I3NjF1U3VpZVVrZzlrVVAzZUNuS01yczVvSmFRbUFIRUZJWmpTL0ZBT1Ny?=
 =?utf-8?B?a1g4dDRZdWJ0cUFMNityQWg3MGN4YW53VURqRW16ZlptT0UyWTdkVjNpL2hR?=
 =?utf-8?B?UkFocTlEZ0dWY3V2R2luRGIybEhJaWRocnVIREJwczhub2h2OThydW5TMFRB?=
 =?utf-8?B?azZJeUFYWDBsUTBnT0R1ZEJyWWQ4UnAyUGF5MUM4VDNRSGRvUkV0LzJuRmNV?=
 =?utf-8?B?MC81T1FCOUc3UDVZRjd0Rmd3VmRST1F4NFJMbWpOTmxpN1lRLytDdVVJTis0?=
 =?utf-8?B?WEE4cUM3TzZqeDl0Q0FxTGhrdTV2M3FqWnZNdVZOVjNEUG1LZlZERGVLQjRn?=
 =?utf-8?B?YnZlR3htNFhvZjZKM0pESnRuc1dET1FaS1dVdFh4WGtkNVR5eGl5VFNHM2g4?=
 =?utf-8?B?RTgrbC9GSVNUTlZrV2Exc3ozb2Z3ano2bnhWTXhPNFJQYVNTQnU2OHFBQzJu?=
 =?utf-8?B?V1MwdkN0emJLWGEwS2R6cFE1aWpueW1uM1NPcDVxZTZOZEJzRlFVd0M1THNj?=
 =?utf-8?B?Q3FzakhSejlzUnpBUGJsQVVpZ2c2TlorZjVvV2JqeGwwZEt2WFFIQkJwNHdx?=
 =?utf-8?B?dk44LzBHWDEzRVYvR3ZpNTllS0p0OUtSVDJaOEJMN1RUR1F0YjF4b3doM216?=
 =?utf-8?B?RktuVWoraUc3SThkMHAvK3ZyQWpQWm54UnRXTUJKSmdNYWMydXJocGVzSVlZ?=
 =?utf-8?B?eHlTNGtjMzBQM016VEhPTERqQmpyZnBCTDdRdk1zQnlLcWQ2K1M2NFpIV0l3?=
 =?utf-8?B?d1BnZFpNbEtPN0F1dlNSN3NXakRwRmVKMVRHaXYzdC85RTc4UGJBblZ2cXd1?=
 =?utf-8?B?ZkxXd0tvb2NZV0NuSGs0dHViUk1Dck83MDl6Q0xNcVhyZTVxT1ozSnlzanlE?=
 =?utf-8?B?WUlEUUZnWC9yYkZFcjJKOUxCc2tCWmgweEFITzNuaGJjZ1ZkVjVNSjZYaGN1?=
 =?utf-8?B?Tk5ETktRZGNvMEU0MWhHNldhM0hvMVBEYW1NNXI2dnVsVGliS04rS1R6ZGc3?=
 =?utf-8?B?VEtlTEFRZU5JQlB6bGZVVEE4a29uYlB5TjE3VFgyNTRPM2pKcGF3blFlRmlh?=
 =?utf-8?B?ZGdzWFZSRU9VSlo1UkRyM0c4cEFrOXpJNU5TWm5TSElmcFkvRGg3cHFCUnYy?=
 =?utf-8?B?S1h1dFY4TDl0clRzM1k0RWdZNDFOamN0c0MxdmMxeDlWMDRpLzBjMVhaRklj?=
 =?utf-8?B?WDV2VTd6RW8zL0Jzc2tvVDAxSG8yRG1tNXBUODgwdkdKdlZVUnpSUVF6aFJv?=
 =?utf-8?B?OVBsRU43am1uOHNzM0d2c2M1MU1ibzVnOXNpdjRGTHpLdEJieFRxSnZqbTht?=
 =?utf-8?B?aTJmQmFNYUE5aDRacytRRnhleDdpU1I3ZU0xVmV1SE8zckF3enN5K0FjRjQ0?=
 =?utf-8?B?K0dQRldEQXRhYWs2REp4VUREdWZlZnR6VnBQQm1IOTNLaVNUM2FDQWRQMERO?=
 =?utf-8?B?d3VoRXVSdnJ4WEFOckMveW0rSnVtRUdrQnZyYnZ0aVdYdEdaNmlYdDlEeUFQ?=
 =?utf-8?B?d2NXTGRPVWhWanY0VWJ3U1pneWh1RzNpSzlHTTA0WDJmOFY2WjRTNE1kUElt?=
 =?utf-8?B?MG9GaUFjSmhrUDM1UDNFMkNwaGFkNzh5a2UzYS93LzllbzZyeC9OR0N6TDJJ?=
 =?utf-8?B?WG42bzQ5c05KS1dzT2FFbTluaGxjSnc4WWJLRWVaZGxDbVFaeTlMblJsSXND?=
 =?utf-8?B?aC9oVU1YdldCeHZ1Z2UyVSttSkVaSUNTYmF0Y20zYURLNGFEbkpUMTlaaU03?=
 =?utf-8?B?L2dJQ0lGUndOSWFlTnowRzljMXpZTUJaTzZTS2hzSWFXTGFsVVpqVjJZOTdV?=
 =?utf-8?B?OHBmNjBWR1FTdC9ScUxpRlowMXk0VG9HUCtRL3NlQk94eXVDZTJRVklwUkpa?=
 =?utf-8?B?ZTNLNHUxTzVabnRPRXc1V3hRd3greVU2UWVsVTZYQlVnTDZ1cVpIUkN3d282?=
 =?utf-8?B?TjhCbk5nM3FiN040TVFsWm9wdGhhSHdHT1JjcGJDS0g3U2VldUFvRDZVYjds?=
 =?utf-8?B?QXNnbWxVNnFNYUMxWVN0WnJGSjlIOHRodkhIUlZwZCtnSUJLRTV3b2xCdHRM?=
 =?utf-8?B?MDlKdUJtQUpFaXZ3SXNDME9DRFFBcmpmdEEwTlk3dTlpNnJxNzBsR1BmWjMr?=
 =?utf-8?B?N2tmTkdjODBIdmJOS2Zkb0o0Z1ZXVWtkbDdXV2VCdEZSNi9hY0VGZWZ6djR0?=
 =?utf-8?Q?oET8Xsd/YekANNPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7364D9D097AA1A4F971C0AFD5B44F6A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755d2d23-1e67-4131-3d6b-08de68d08d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:16:47.0506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9YiElKBV7QFvL7H4GGfw7h1Aqp4Bu3lS83k6om0GpRc5y4rXD1MthNOCMeKvoK2qagH1JkEInfPsL6dtJwSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9442
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31708-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediateko365.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7527211E4A6
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDE4OjEyICswMDAwLCBSeWRlciBMZWUgd3JvdGU6Cj4gT24g
VHVlLCAyMDI2LTAyLTEwIGF0IDEwOjA4IC0wODAwLCBSeWRlciBMZWUgd3JvdGU6Cj4gPiBDbGFy
aWZ5IHRoZSBmb3JtYXQgb2YgcGF0aCBiYWNrb2ZmIGxpbWl0IHByb3BlcnRpZXMgaW4gbXQ3Ngo+
ID4gYmluZGluZy4KPiA+IEFkZCBleHBsaWNpdCBkb2N1bWVudGF0aW9uIGZvciBjb25uYWMyICht
dDc5MTUsIG10Nzk4MSwgbXQ3OTg2KSBhbmQKPiA+IGNvbm5hYzMgKG10Nzk5MCwgbXQ3OTkyLCBt
dDc5OTYuLi4pIGRldmljZXMsIGluY2x1ZGluZyB0aGUKPiA+IGRpZmZlcmVuY2UKPiA+IGluIGJl
YW1mb3JtaW5nIGFuZCBub24tYmVhbWZvcm1pbmcgZW50cmllcy4KPiA+IAo+ID4gQWxzbyByZWZv
cm1hdCB0aGUgZGVzY3JpcHRpb24gdG8gbWFrZSBpcyBtb3JlIHByZWNpc2UuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IEFsbGVuIFllIDxhbGxlbi55ZUBtZWRpYXRlay5jb20+Cj4gPiBDby1kZXZl
bG9wZWQtYnk6IEFsbGVuIFllIDxhbGxlbi55ZUBtZWRpYXRlay5jb20+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+Cj4gPiAtLS0KPiA+IMKgLi4u
L2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2LnlhbWzCoCB8IDIwCj4gPiArKysr
KysrKysrKysrKysrKysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspCj4g
PiAKPiA+IGRpZmYgLS1naXQKPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2LnlhbWwKPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxtdDc2LnlhbWwKPiA+IGluZGV4
IGFlNmI5N2NkYy4uNDE1NmUxYzk3IDEwMDY0NAo+ID4gLS0tCj4gPiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWssbXQ3Ni55YW1sCj4gPiAr
KysKPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9t
ZWRpYXRlayxtdDc2LnlhbWwKPiA+IEBAIC0yNTIsNiArMjUyLDE2IEBAIHByb3BlcnRpZXM6Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb2xsb3dlZCBi
eSAxMCBwb3dlciBsaW1pdCB2YWx1ZXMuIFRoZSBvcmRlcgo+ID4gb2YgdGhlCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFubmVsIHJlc291cmNlIHVu
aXQgc2V0dGluZ3MgaXMgUlUyNiwKPiA+IFJVNTIsCj4gPiBSVTEwNiwKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJVMjQyL1NVMjAsIFJVNDg0L1NVNDAs
IFJVOTk2L1NVODAgYW5kCj4gPiBSVTJ4OTk2L1NVMTYwLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEZvciBjb25uYWMyCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEJlYW1mb3JtaW5nIGVudHJpZXMg
Zm9yIEJXMjB+QlcxNjAgYW5kCj4gPiBPRkRNIGRvIG5vdAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluY2x1ZGUgMVQxc3MuCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIFdoZW4gMVQxc3Mg
aXMgbm90IHVzZWQsIGl0IHNob3VsZCBiZQo+ID4gZmlsbGVkIHdpdGggMC4KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBGb3IgY29ubmFjMwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBCZWFtZm9ybWlu
ZyBlbnRyaWVzIGZvciBCVzIwfkJXMTYwIGFuZAo+ID4gUlUKPiA+IGluY2x1ZGUKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxVDFzcywgYnV0
IE9GRE0gZG9lcyBub3QgaW5jbHVkZSAxVDFzcy4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gMVQxc3MgaXMgdGFrZW4gaW50byBhY2NvdW50LCBz
byBubyBuZWVkCj4gPiB0bwo+ID4gZmlsbCB3aXRoIDAuCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vbi1iZWFtZm9ybWluZyBhbmQgUlUgZW50cmllcyBm
b3IgYm90aAo+ID4gY29ubmFjMiBhbmQKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29ubmFjMyBpbmNsdWRlIDFUMXNzLgo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaW5JdGVtczogMQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogNwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVtczoKPiA+IEBAIC0yNzAsNiArMjgwLDE2IEBA
IHByb3BlcnRpZXM6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBmb2xsb3dlZCBieSAxMCBwb3dlciBsaW1pdCB2YWx1ZXMuIFRoZSBvcmRlcgo+ID4gb2Yg
dGhlCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFu
bmVsIHJlc291cmNlIHVuaXQgc2V0dGluZ3MgaXMgUlUyNiwKPiA+IFJVNTIsCj4gPiBSVTEwNiwK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJVMjQyL1NV
MjAsIFJVNDg0L1NVNDAsIFJVOTk2L1NVODAgYW5kCj4gPiBSVTJ4OTk2L1NVMTYwLgo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEZvciBjb25uYWMyCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEJlYW1m
b3JtaW5nIGVudHJpZXMgZm9yIEJXMjB+QlcxNjAgYW5kCj4gPiBPRkRNIGRvIG5vdAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluY2x1ZGUg
MVQxc3MuCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAtIFdoZW4gMVQxc3MgaXMgbm90IHVzZWQsIGl0IHNob3VsZCBiZQo+ID4gZmlsbGVkIHdpdGgg
MC4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBGb3Ig
Y29ubmFjMwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSBCZWFtZm9ybWluZyBlbnRyaWVzIGZvciBCVzIwfkJXMTYwIGFuZAo+ID4gUlUKPiA+IGlu
Y2x1ZGUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAxVDFzcywgYnV0IE9GRE0gZG9lcyBub3QgaW5jbHVkZSAxVDFzcy4KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gMVQxc3MgaXMgdGFrZW4g
aW50byBhY2NvdW50LCBzbyBubyBuZWVkCj4gPiB0bwo+ID4gZmlsbCB3aXRoIDAuCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vbi1iZWFtZm9ybWluZyBh
bmQgUlUgZW50cmllcyBmb3IgYm90aAo+ID4gY29ubmFjMiBhbmQKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29ubmFjMyBpbmNsdWRlIDFUMXNzLgo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaW5JdGVtczogMQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogNwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVtczoKPiAKPiBPb3Bz
LiBQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIEkgbWlzdGFrZW5seSBhZGRlZCB0aGUgd3Jvbmcg
ZW50cmllcy4KPiAKPiBSeWRlcgoKT2gsIG5ldmVyIG1pbmQuIFRoaXMgaXMgYWN0dWFsbHkgY29y
cmVjdC4gSSBtdXN0IGhhdmUgYmVlbiBhIGJpdCBkaXp6eS4KClJ5ZGVyCgo=

