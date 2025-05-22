Return-Path: <linux-wireless+bounces-23304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D2AC0A5C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 13:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5C3189D2DF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A1289369;
	Thu, 22 May 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I56XybIu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uK0BO5mK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B897289812
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912353; cv=fail; b=qbYko5IdEYzyWcf5GBfw9xh8QNPGv2T01JAuj6GGF+lR49H3lcwSSuXlQTWyW26JCnmSVf+CgAemg2DtS8tAi+I1cAC5KkbzkevE+R+b9liMOq5JVP2enLtux82rILWvb/xL3Datr4vf2AtTywuOObRj9VhCo7/3/Ib9z2Cpw3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912353; c=relaxed/simple;
	bh=8ShZ4n/L8nzxlHjEk1tlNr0Kb0RTYi/YyjxuPt64gNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRs71hVDXTwJJMPhEq3H0qkZPX1L0Zl0V0eg4iyd7U+W2C54Y3MnWkn/RNO6LsH2ot6ZZzQ61PiOgiWhHWteCT+rdTSqadncuUVdldLXroIqgIN7cE5w/MC4lw8CP6QWRfGup8QIYv58seTD2nKjanp05jw4BdWtPDXZwX6rcBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I56XybIu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uK0BO5mK; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9fe3da0836fd11f0813e4fe1310efc19-20250522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8ShZ4n/L8nzxlHjEk1tlNr0Kb0RTYi/YyjxuPt64gNY=;
	b=I56XybIuU+alW4PtwEQIbZxVdlXtluVJHfj3uO2Q3Ww67eJ1rJ1HqDds5poG9kuajBjlclgPnjSVh7icpfMmkHT0tQAMwjj2Epf86wECf4JPR43BZUVdCxnXZgpprfcw6rXl2y+aR1bCIUlYCHoNbxlfKafLWoPzdFDlXuz+gFs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ccac490b-04d4-4983-9d74-fd7bee5994e4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:5b7b9c47-ee4f-4716-aedb-66601021a588,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9fe3da0836fd11f0813e4fe1310efc19-20250522
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1501414576; Thu, 22 May 2025 19:12:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 22 May 2025 19:12:16 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 22 May 2025 19:12:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5yrnEyRAO16S4RxbkrEVBVGfnDOo4cuQhtN476xIzpGtGM4fHTrzEJ6+eJnjJZX8pLlhCx6ntVa7O6fDnE6bHSSSqNLg3fM++CSzdiWA0mNcuyw6CcJZtcOOR8XnBY7DrSuLeboJOCAx5o52Pj8NeM+ccbOAyMFZYypMNQ6y/HKMnGcsnCooxAmDpu3hoxFBFaDRJdvLFkuiv5eCjrYA5KoRP7icWMxoX7+wDs68n3juh7GViZaqdap3WYGq+m0RGi8Ssv3lQQTLh9fszIDxHpKBWmnM7UApa07k698Mc0Gm+QqotyYX5zM3LHdtWX90F/ByQdCZPBNPRAgBipZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ShZ4n/L8nzxlHjEk1tlNr0Kb0RTYi/YyjxuPt64gNY=;
 b=hfuTi5U5Zeh79ki0EdUV7ZI17wTgosyTuJy37PUM9wJ9K0l6zAIqiM5W5XLKygzKdIo8rabw6NIS4ArPwUDzCNagVZmJlM6qd/VWcHHobi5QS2EIhfPZkixD0p7OzzO5hZ5r5lZJy9CPXjV4jyuN/3DV3l5IiJ2JbdXkSCarTHXgI2ZnPTLnlmjTHE0cgciG/mj48ogk+C8XQ/d6c2P9Db0qvu6iMYq5gmU5VSrDCWaxHzr5rs4BOASOcXFuWMXmRPii4P2wnXeDqO/YY4V9j9Et0iw7J435xKxPDNH6GL42LnCvBsEU2KyLZZIoCBT2UUPSwVXThR5DE1Kk0zsWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ShZ4n/L8nzxlHjEk1tlNr0Kb0RTYi/YyjxuPt64gNY=;
 b=uK0BO5mKi/Ckj7R3hYBKxXsrbx9OAgizE5V793uq3LMeRQckhUaX6UozqgcgpvVBqJf8VcPk7Ura8DkFGwRqF/WbbWk1T+wZ+zyoKzWdcUKKj+avC6rff08kmjpCu/QKS4+4trazRGQdM1LPfJX2tebIRTOLL862NANV0O/YAjw=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 TY0PR03MB8223.apcprd03.prod.outlook.com (2603:1096:405:15::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Thu, 22 May 2025 11:12:14 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 11:12:14 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
	=?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"Sean Wang" <Sean.Wang@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
Thread-Topic: [PATCH v2 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
Thread-Index: AQHbmgH3qUaZxpkpfkqF8B68qU1ENbPe2n2AgAAGO4A=
Date: Thu, 22 May 2025 11:12:14 +0000
Message-ID: <2727d1a0598247fb379347165979c160a79b9965.camel@mediatek.com>
References: <20250321013829.3598-1-mingyen.hsieh@mediatek.com>
	 <20250321013829.3598-2-mingyen.hsieh@mediatek.com>
	 <5a659f60-896e-4f2f-89c0-141e530c44d5@nbd.name>
In-Reply-To: <5a659f60-896e-4f2f-89c0-141e530c44d5@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|TY0PR03MB8223:EE_
x-ms-office365-filtering-correlation-id: 1a92a4d7-2ded-43ba-a5d5-08dd9921819d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TW1CdzBvNU9nWkwwSWRaYUprem5RRkFvWmFMMnpjOEVtcDN4VjRCaUZmQjBH?=
 =?utf-8?B?UmJiYnVVSjVybXJvTlRtRHpvVHdTaGMvUW13SDg1aFN1TTJ2RmVHdXRUTURC?=
 =?utf-8?B?bXlHUG9mTmhhYlpDNmdUMHp6TWkreVVPbzA4dnVpUVJYS1NwdHNjakJSOEF3?=
 =?utf-8?B?ZnVSRUlBYTZ3T05saVFua3NFMGhMVDg1aEVyaDRYdXpaMkc5K0N2azUvSHg1?=
 =?utf-8?B?MW5tbnh5WUVKNFZUSllGVU5tYjlkdTlMQW5mOVA3akpEMjZwT3ZJLzEwWEY5?=
 =?utf-8?B?WGRPN2pyVTFqZ3pRSHRvZVBTY2dVYUxrc3dESEtsc0F4eTc0a09GaEk0bTk4?=
 =?utf-8?B?QlBUYnJDZUwxSnBjdlRpMkdNQ1hjR3UvZHJIVlVUSWdCbmRNUlRZNHhqSGl4?=
 =?utf-8?B?Y2xhWWppWkhpTS8rNHNzR1RlZmJZbXh4NDdHMUJvZC9WV3drRnlTZk14a0xD?=
 =?utf-8?B?azQ2cTNxeU1lQlJJNUVNdFQ5VUIvN3pmSHFFUTdUZXRJdzEzVjBVMXdjdkpN?=
 =?utf-8?B?U0wrY0h2K0pYeGpBZmgzc0o3Q3NCc1ozRzRERlFBa0ExaHhBeGl6Y0JBMXp3?=
 =?utf-8?B?aGlFYUdLQzV1U0l6UXNCV2JEUHBMYkxxRnI1emFsdUVkRDNQbCsxNnhhWWZS?=
 =?utf-8?B?MW9tZlJ5a3hrNEo5d0UvcWx0R3dqQVErYWhrVlJ5N25sNGNpdDJMczQ1akM2?=
 =?utf-8?B?YitKVVl6VlJPOVpURk1GcFU3RjRYdCtCcVEzc1lXWGs3dGFEck1wWU90WmlS?=
 =?utf-8?B?U1RRdHFOTlB5VkljQW9Dc3p2TWRDTVA4c3MwWG52UFY4dmhtZkgwTEUvdDk3?=
 =?utf-8?B?REZ3dTdNa3VTTE1rZDRZelRUSnBVVGhzcktCbVNqNTNQeHFtUHg2eHBPSnIz?=
 =?utf-8?B?aTlmd1ZPVWYzaEZJVVRRRFFwTDNwY2ZsMzJiWFo5d3NlTk9aWUZkMDltZ2x1?=
 =?utf-8?B?WmF2TVlPc2Z6SDhldkZrbXhMNVdBOW5FTkJKM2tCTlJUZktYc050dlQyK0dx?=
 =?utf-8?B?bjRINGNOS2ZGZ2lTUUl5eWFsWjBuYlh6ZEJoQ3lXMTdFQk80NXVrYTdLU2F3?=
 =?utf-8?B?UzdLamNqRW53QzJnR2x3T0FDb3gvcG5Pa2ZCWXNNeGJQU3Vud2FHOVFrbk0z?=
 =?utf-8?B?cnFKRlpaNDMxenJkM3FtdWVCWEl5bzdEckFaSkJzOWJVS1g4dXBXOHJTY2Nq?=
 =?utf-8?B?Rk1kQU81WndramV2a2NibWt5ajUveE9vWkV4NEExWG9wRjhkN1prQU1mUGJJ?=
 =?utf-8?B?bGxvRW5lcy83RnRoMUQ3UHlETkpMNm1ZQWFsekZPcjlPMWIzNEZuT3VNdzNG?=
 =?utf-8?B?ejJvbDZlekJZV0FBcDFvQzJ6R09TUmk2WHo3cHI3RXZNQ3drb2VzTVBPRXgy?=
 =?utf-8?B?Q01GWnFFcVdsZWlxZFZySG5nZDNja1dRNWRHNUdmNWpXUmFSOVVoZXpqS3V0?=
 =?utf-8?B?WE01MjA1d2JJR2g4SlBkSWUwUEs3dDVnK1ZGc0o5NHRsUUZPdHZvVldmeDVN?=
 =?utf-8?B?WGY3MDNsYTVrM2lXUXZYWmJJWG4ydzlGNms0Q0duSXloT2luRkJKOWFac3k4?=
 =?utf-8?B?Qk5uNy9qR1BKajgxNzBYWWhuNVhzNWFhR1ZYUStFNEhheG51K2xIcDdhV3li?=
 =?utf-8?B?RGpxNHVVY3IvZHZVc2NSOXluVmwvTXNFRFh1eFFtNEJLNXNTUGdiZmtLUjd0?=
 =?utf-8?B?T3M0eThUbyt0SmtLNGFqZTZpb0ZjZE1rMDlZeVlmdGp0dDNaTTVoMXRmdkVN?=
 =?utf-8?B?YXMzRVR3UVpzZTB4cm9YMkNxR0owT1RBZXRpWEtzdVdiWW9pajNMUmVsOFJK?=
 =?utf-8?B?QjdlbTNIdVlhcXhJUmVwREhXUytud0ZJMEVySUI3bG1FRkkrYW5DbWRmR1BS?=
 =?utf-8?B?UFhrd0ZKY1NRZkFOSG02eUh4bVBHbHN1OTFobE5pdXRYK3N1SDZXTWFUcStP?=
 =?utf-8?B?cmJ4MG1yaEhZTkhpN2R3TlRWUVhiWVVRWExiQmE5YVZ6NGNsV1BzVCtQb0JB?=
 =?utf-8?Q?lqWZfKxyFBPDGcSEH0PWtPLCg4sXLs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG53aU1OUWZmSWxKa1NVSUJJeEgrcUZKaktLbGdMTzM4N3BVTjBMN3NXWkRH?=
 =?utf-8?B?YWZpR2dmb3FUa1kzTkkxVDhBTnRsZk9VcmNpMlBOczhvbjJFZGxGaFBFMTJF?=
 =?utf-8?B?MmZETm1ZSks4aUtaNWN6Z1cwNW1wSktGTDNWNUxXd0pjM3BxUnRZVXBSM0t0?=
 =?utf-8?B?eS81OG9vMVhkbjRxZHhXc3l5WHJmVWxwWmQzYm9NQUhwaUZGQWtHbFo2eE5i?=
 =?utf-8?B?R1Arb2k1Q21pL3JsZ3pCc08vZkZjelpsWVd5emJhY1JIaVdLYzFncGgrRFZJ?=
 =?utf-8?B?T29YWUlGVHp5TVVuRThNSGUvdEtrb0djNmthQmZLVWEwdlN6cS9VU1g1bXFG?=
 =?utf-8?B?ZXZ1N1FNR2xscWg1b0lLK1pDVTRCS1RTOXVvamVlcWJVek9iT05rYzVuVWUx?=
 =?utf-8?B?cXY2TitVTWJQZ3pDZzhMUlRrQWttbzN4MDBLNDU3N0puNXdaSGpKMDhYcUlW?=
 =?utf-8?B?VVJDUlNFalE3b3MySmY2OXlhKzdyWU1ZSDVyRUN2V2FnUnNNRTJLQVBCMXFz?=
 =?utf-8?B?czVDdWdNT085NVNoNE8vVmlvN3ViZlU1TlhEZEpWYnhzcWxsYUlTSS9acW9n?=
 =?utf-8?B?cjF4VWJZNVJhQUhiTzJaY291VzIrNXlTUE00bytsbW4xZHZxU3Vwc3B6WXlW?=
 =?utf-8?B?RFRXS2pJbWtuaVZMMVUzNitHb2ZTZDBGdlhhbldocnpOa05CNDFaMkVyNm8v?=
 =?utf-8?B?TzlvWi9UTkhzbFZzL3docGwyUVZIR2p4amttdWlhMFlDNkNHUVc1VHlMNlpi?=
 =?utf-8?B?b0s1cEJKaVRTazJVMlRHczZjanpBTzdhaXllZ05aZTJ1OEFlWG1kUVNSWjFs?=
 =?utf-8?B?RmUxNStIcmVyNjg1TzlWR1FHaHpjZ2dHblpHYm9FTWtpTWhreGs1WUJaMHVm?=
 =?utf-8?B?UkFzRnIvbFQ2M2ZJSzVCcitQRDFBWGZjbXVQS3MyTUZ4ZG40djBobTc3WklQ?=
 =?utf-8?B?UC9CRXN4OXo3MjY2c1RqVGNWM0xma3lLUE9TQi91ZmFvWHlrZzdVVVBOeWhP?=
 =?utf-8?B?eGdPWUR2TTlJNEhPOXRxQnhkRWxuWU1ENm5QcWFFaFdhN29RZEpveUZKWmZM?=
 =?utf-8?B?WjVCaXpaYnhveEFKVG5GYXd0QlMzOUE1L2RoWkRWeXVrZlB6N3NPZWw4bDVp?=
 =?utf-8?B?VG5wei9xL0JqY1dyb2xGYmw5OGl2em1UOWsveXh3MnFreVJjN2ExZmo4bk9U?=
 =?utf-8?B?Q1NwWkliY0RpY3lLcFlCYVl3MHN6b2IwTFJXVmFhcmZTY3dBRVhqeVJEZ2Zu?=
 =?utf-8?B?d2lYOWhQaE1zWnZrZ1BBcHpnQ1pWaHMzY0RYT1hnbE9qOWJzN2s0OFZRUXh0?=
 =?utf-8?B?SnpoKzB1SHlybXhWMGhIbDViTDFTUDRrMWo2dTdQQWNqUkw0UW9aN09LcDBO?=
 =?utf-8?B?aUNERFBsa2l3ZElLSkU0SEo5UGw5VmRiWWlhR3F1bEFGTGt1UDIzMjE5VHpp?=
 =?utf-8?B?Z1hkNXgvRFN2NERTait1cGUrOXR0YURNR2k5K21VV1g4d3lvMWx5R3dESmtu?=
 =?utf-8?B?Nk5ubDlsZk1RUVNLQjIxVWNxY29Bd3F5T3RhMFlESFRLSm5XaDY1eXFQdU5k?=
 =?utf-8?B?REMwOU9mRVh2bHIrQjNBZVpGR2VRWmwvdXNhN0pNMVhIcGh1b0NlVXRQL3ZG?=
 =?utf-8?B?cGhSQTR1VTZST1l3TktCc0xMY1FweDFwVHY2OVZqZFFqSlBqSjdNeFlmbFds?=
 =?utf-8?B?NzZIa2xQejl4L1JKSWN5MldRMXVBZksyRjZvK0c4Ri9YSWN3clU5dFpGRzJG?=
 =?utf-8?B?SDBlMGIrSHlCbHFSeDlaZGRlWkxBOFlKcWI5b1VQejhyNkhmaW5vMVk5dTdF?=
 =?utf-8?B?QmlSUGZNM3UwYVBlV2ZJTU8vVENrOHAyaTduUmRlalVrRGJ6eGlFRndQSEk3?=
 =?utf-8?B?VkZPU0tZejNnQjVOMjhwUHVLeTFzcE54ZWlBY0hmZ1hZWFdwMmxzMWNVN1da?=
 =?utf-8?B?WmVtdlpNQTdWRzFXTFUvRC80Q3VNZE00WDFjTDNqbndOWDJ1eFdmOEVicXdO?=
 =?utf-8?B?Y2s2RVFQOElGT2R3eWtrN1kzVWFzeVMwWjdPMnlEdW1aaGUyWjRoTzZYaG9I?=
 =?utf-8?B?SlRETjNRNFNEckUwUHppenFzWisrcnB6UlEydVVMdnNkdythWUN0bWcyQno0?=
 =?utf-8?B?THVESEJ2blp5emFRMjNkWXBkZzFyc0JQR2Q3Nno4VjVHL2hUT0ltU1pxcUdu?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2FEAD65B085134ABBC603E47FE17791@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a92a4d7-2ded-43ba-a5d5-08dd9921819d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 11:12:14.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5XDus09S4QlEJPCrp9TP1mPO4MZTJ4iog6phKGFW9AGcZbGdfpITyqnGh8XJcgCHtcSe8OdenaikoHennYwwGiGIEyH8WMl3Bp5mFPfCvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8223

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDEyOjQ5ICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAyMS4wMy4yNSAwMjozOCwgTWluZ3llbiBIc2llaCB3cm90
ZToNCj4gPiBGcm9tOiBNaW5nIFllbiBIc2llaCA8bWluZ3llbi5oc2llaEBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gRW5oYW5jZSB0aGUgbXQ3OTI1IHRvIGluY2x1ZGUgUk5SIHNjYW4gc3VwcG9y
dC4gSXQgYWRkcw0KPiA+IHRoZSBuZWNlc3NhcnkgUk5SIGluZm9ybWF0aW9uIHRvIHRoZSBzY2Fu
IGNvbW1hbmQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZyBZZW4gSHNpZWggPG1pbmd5
ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+IMKgwqAgLSB1c2Ug
Jz0ge30nIHRvIHJlcGxhY2UgdGhlICc9IHswfScgZm9yIHNob3J0X3NzaWQgYXJyYXkuDQo+ID4g
wqDCoCAtIGFsaWduIHdpdGggdGhlIG9wZW4gcGFyYW50aGVzaXMgZm9yIGNyYzMyX2xlLg0KPiA+
IMKgwqAgLSB1c2UgZXRoZXJfYWRkcl9jb3B5KCkgdG8gcmVwbGFjZSB0aGUgbWVtY3B5IG9mIGJz
c2lkLg0KPiA+IC0tLQ0KPiA+IMKgIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MjUvbWN1LmPCoMKgIHwgMzYNCj4gPiArKysrKysrKysrKysrKysrLS0tDQo+ID4gwqAgLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9tY3UuaMKgwqAgfCAxNyArKysrKy0tLS0N
Cj4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkyNS9tY3UuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MjUvbWN1LmMNCj4gPiBpbmRleCAyNDNhZGFjZTg3OTkuLjIyNjg2ZmFjYTFhZiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyNS9t
Y3UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTI1
L21jdS5jDQo+ID4gQEAgLTMwNzgsNyArMzA3OSwxMSBAQCBpbnQgbXQ3OTI1X21jdV9od19zY2Fu
KHN0cnVjdCBtdDc2X3BoeSAqcGh5LA0KPiA+IHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQo+
ID4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgc3JlcS0+bl9zc2lkczsgaSsrKSB7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFzcmVxLT5zc2lkc1tpXS5zc2lkX2xlbikN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaSA+IE1UNzkyNV9STlJfU0NBTl9N
QVhfQlNTSURTKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJyZWFrOw0KPiA+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2hvcnRfc3NpZFtp
XSA9IH5jcmMzMl9sZSh+MCwgc3JlcS0+c3NpZHNbaV0uc3NpZCwNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzcmVxLT5zc2lkc1tpXS5zc2lkX2xlbik7DQo+IA0KPiBJIGhhZCB0byByZW1vdmUg
dGhpcyB2YXJpYWJsZSBkdWUgdG8gYSB1bnVzZWQtYnV0LXNldCB3YXJuaW5nLiBJJ20NCj4gbm90
DQo+IHN1cmUgaWYgdGhlIGNvbnRlbnRzIG9mIGl0IHNob3VsZCBoYXZlIGJlZW4gc3RvcmVkIHNv
bWV3aGVyZSBpbiB0aGUNCj4gTUNVDQo+IG1lc3NhZ2UsIG9yIGlmIHRoaXMgd2FzIHNvbWV0aGlu
ZyB0aGF0IGVuZGVkIHVwIG5vdCBiZWluZyBuZWNlc3NhcnkuDQo+IFBsZWFzZSByZXZpZXcgYW5k
IHNlbmQgYSBmb2xsb3ctdXAgZml4IGlmIG5lZWRlZC4NCj4gDQo+IC0gRmVsaXgNCg0KSGkgRmVs
aXgsDQoNClRoaXMgdmFyaWFibGUgaXMgY3VycmVudGx5IG5vdCBiZWluZyB1c2VkLiBJIGFwb2xv
Z2l6ZSBmb3IgbXkgb3ZlcnNpZ2h0DQp0aGF0IGNhdXNlZCB0aGlzIHdhcm5pbmcuIFNob3VsZCBp
IHN1Ym1pdCBhIHYzIHRvIHJlbW92ZSBpdCwgb3Igd2lsbA0KeW91IGhlbHAgcmVtb3ZlIGl0Pw0K
DQpZZW4uDQo=

