Return-Path: <linux-wireless+bounces-21021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC81A7759D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DB13A3D5F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14971E47A6;
	Tue,  1 Apr 2025 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nPzNJp8H";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QblCqnJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674652D05E
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493823; cv=fail; b=GU9O0YAY0kHL7mC/KXD6VC8wiZPmttA/doYwEmWKJ1XDHn8hSoN/hDBTPdjzFVXvcLywzuiQw8kXzngNLnB9b1fTo1gVtiG1LSMJ090jsH0CPZfaK6vbsBu4OU2MfpLTRAF+OMaj7MJU6Hd58rny+8e0nd9dIboF1jtGH0XhS8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493823; c=relaxed/simple;
	bh=D6G90OFF/ZryOhWoTDCBzb137Py6NjrH4IzzZKqd6Ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNyeHn9NFQGPepNXCbAD40U/mHkXw3VmQXj9mCs4ROUeNyv8qA2X/tuoaL2R2EfHEVhhMMr1/9/dg+ikTGadjZ+3bpuzrVmMf+Vg1lMXLJWg5YytF039KBJGyJbmCmqHPyjyu6SwC6fxQFRK4rdnyY4YX84Yd/3xgyOkZsM5Txw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nPzNJp8H; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QblCqnJm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f30ba2cc0ecd11f0aae1fd9735fae912-20250401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=D6G90OFF/ZryOhWoTDCBzb137Py6NjrH4IzzZKqd6Ww=;
	b=nPzNJp8HCD9QESnwODF1tU0HFkLVVmKCUD+p2JcPEeB/f+BFQiD40zXx+UoIXIc01nWjCPr6d7BXx/A432y1e9Jn4ZfhrWwkYJ0iqH40D7xFmpK575kbfWzosPVjTImMM6puwIyvOWCvwnORRQtBvdmwYV0sdGVVX8JHD5CHB0o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ad606128-04c9-462a-931a-190d813f1d22,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:2d47d14a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f30ba2cc0ecd11f0aae1fd9735fae912-20250401
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <allan.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 657538548; Tue, 01 Apr 2025 15:50:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 1 Apr 2025 15:50:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 1 Apr 2025 15:50:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C36lLmUZdmwcnudKogTUUdDd2ioZsUJqY+rBCMIiGPoJZvPJaqMYsoxc7pog+qpbM08dIoMPk1QDwWgqlmy62HZpbOgyEw6UiE5SU69loD87edeJ7zrg1tQgObS/nxfRhirICyI1Zuq+/P/mds7BzUK7j4IpcXE9EmaV3lxd/sfGB5s05+aD8hbdswWNRGM6dmvjaYlZN/wDcPxSSTV/y5DcEQkR3koyRbvFfB8/RQv8Bnz4+4Wu4ri5IfpIMM7OtMT+qcG1nT9AArEK7/3P5TKrzIALVa/0Jy0QMiYBMHxVU7w8EIn45TEFZqe6ZM7WRPoY1+dBF6iGmL99uhydgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6G90OFF/ZryOhWoTDCBzb137Py6NjrH4IzzZKqd6Ww=;
 b=bW4zEJA3Wm68pGSQAU7ktoF7f+8Ve681j9RtefLpAH/5c23uoc8iocoPy+RUsfkPqmQpRgfQN7r7wakwHObj5IP/svq0d6z3TvgDmagYCowFkLDM/3BGnilF6CbSlkWqGaKOjSsUIT0BB4ymiwOHKBhxeKYP9DQHY6Zso0GkvmquHdFTCFlLitIp78fDViL23dNH3/UMop3+EdwBmDiStMNkQlutAaT0/r/YzOiYPE/GFkrlzMelQ88uM13hsE9lNZITxX7Tg0LR7XP+P563P21cyW8rhvpyauq+Z0I/mMh5zlgWaRgxzfDasD2EH3SxBj9horOqEAu+3XyiqoZ+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6G90OFF/ZryOhWoTDCBzb137Py6NjrH4IzzZKqd6Ww=;
 b=QblCqnJmLOqo0upnKSxnmwDnZtZ8+jppde4/6mFv4S0Ro9UunfRxhk+ueYt3tECpARY80OJrdyhPPda7KkLs7R6eP6oDin5F8yW4Cp0CpKmcVb3WvswdIc7ace9G+UL6SNJwyX2xgOwl+gvjYi8AR0k+xCQmFRtZvPWO78jSLkY=
Received: from KL1PR03MB6170.apcprd03.prod.outlook.com (2603:1096:820:91::12)
 by TYZPR03MB7531.apcprd03.prod.outlook.com (2603:1096:400:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Tue, 1 Apr
 2025 07:50:12 +0000
Received: from KL1PR03MB6170.apcprd03.prod.outlook.com
 ([fe80::7b0c:45ca:7525:93bf]) by KL1PR03MB6170.apcprd03.prod.outlook.com
 ([fe80::7b0c:45ca:7525:93bf%4]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 07:50:11 +0000
From: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>
To: "nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
	=?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>, =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?=
	<Quan.Zhou@mediatek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>, =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?=
	<Shayne.Chen@mediatek.com>, =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>, =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= <Soul.Huang@mediatek.com>,
	=?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
	"Ryder Lee" <Ryder.Lee@mediatek.com>,
	=?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= <robin.chiu@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7925: add EHT preamble puncturing
Thread-Topic: [PATCH] wifi: mt76: mt7925: add EHT preamble puncturing
Thread-Index: AQHboh3LcTdo2amUv06k4haSARbCKLONAKmAgAFwfgA=
Date: Tue, 1 Apr 2025 07:50:11 +0000
Message-ID: <aa5c71fe08572f578f322a6ef9bb7727fe8f4023.camel@mediatek.com>
References: <20250331091747.2592021-1-allan.wang@mediatek.com>
	 <bb2c561c7b849dcf9c129520a28f8d5667e5bd8e.camel@sipsolutions.net>
In-Reply-To: <bb2c561c7b849dcf9c129520a28f8d5667e5bd8e.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6170:EE_|TYZPR03MB7531:EE_
x-ms-office365-filtering-correlation-id: 525d9fd2-7f3f-4726-13f4-08dd70f1d4d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzZ1ZkVwR2wyRXRJWjBGZ1dueEQyY3JSM0tuUmNkWEJKcDd1VUZXL2JpUXlS?=
 =?utf-8?B?WDN1Ny9ndnZrN1lKN3pjb25hSzNaUDZuU2Q5cGw0MGQzTVpDaHorcDV4U05n?=
 =?utf-8?B?ZHZaV1VsWlcwbHR2NlhRbjZCY2lQMWtRR3o1ZzVVOTFsK1dBb1IvNitPOWdZ?=
 =?utf-8?B?RmVJb2NtVVJXZDdTbjhLaUVGbUI1Zk95MTJhZHMybmwraVlHbE5ueDR5RUpa?=
 =?utf-8?B?aU1aS25rNHBLZnZvaktHN295TS9QY2tYaHRvSHVhR0pDeWhEL0ZBOHZqRHoz?=
 =?utf-8?B?UnVXbm5ucVB4Sk9YU3dLUUpDc1IvUHpEbDFiMk9iMTVGTTFZUExtanRwVGFm?=
 =?utf-8?B?TG1Za29XSllPZ3k5TmlFRWVISzliUThWY0d2dTJucWREV0l0amNOM3NCRjVY?=
 =?utf-8?B?SWp3M2xuMTBpakt0VTZDUGxCNXRvYndidS9YT3phVlhnODFoVWw1OGZadjZr?=
 =?utf-8?B?UWZNbnFUbVJWcU1nZUp2R3JxZ0pRa0dxNWlML2hNbjlSM2M0alVhVCtEMm1i?=
 =?utf-8?B?QmVRN0dzcWpwazAvWWUyQWs0QWFZUE1mTlpaVTh3dlA3UlpERkkvNFV3djFr?=
 =?utf-8?B?SVFVQmNVWVdPT1Fad2dLZCtMSFAxOXQzeUk1MEoxNk5qMGtpQlI2dGpsU0No?=
 =?utf-8?B?N0RNRWZ1cDUvZHAzRFdON09Ed3FnWWc5TVpodEdTZXpmNmV6cWx1OHVPbE1l?=
 =?utf-8?B?UzZkV1M3TnVnaE00dGNuS3JPY1pYY0RyTnN4eFQ3b3VSNXp4aDhkc0xpWU5D?=
 =?utf-8?B?Z2IzYVRhTDdhWG4xMFhhSW9pUmltU1hXa2dZR3dMbFp3R2hkeENZL2cyM3d0?=
 =?utf-8?B?WHh5YXUwRjRGcE80bGFidTU5YUJSN3hrVk53dVhXNDJoeFFVNHFyNTlDSzNi?=
 =?utf-8?B?eGFUS2c4TFhUMU8yYVdRTURXL3dQQktmTmlVSWUzdi9xSklrOTJNMDE3UEhw?=
 =?utf-8?B?S3Z5YU43OTBXUXR2MFFoMXAwV1h6akUrOUJKRlR6enU4QXM5c0JteXBkT2ZX?=
 =?utf-8?B?TzR1NjhYcDhkeEJGUVdMWDFONkRGek5TZ29HeEdqREVJY2Z5b2ZOQjhpNUl1?=
 =?utf-8?B?RjhadktJSi9YNEpTRGQ1Q2lmRVhOUWtQUnl2WHUxRWJMZWx5eUpSSnBsTlQ0?=
 =?utf-8?B?U2JWMnB2Z2hYSThXWDlhcVRKaW1OMXR5VGFHc0tiUURUZVNLRHFtVEtZR09U?=
 =?utf-8?B?RFd1L21mSjVrclg1Skx5RUpDdzh6cUU0RC9jVGc3aitSNlNaVzIxYmQyVWJM?=
 =?utf-8?B?SEdBTG5Ma1pldVRMdEd1dUZwbktOY2V5MTd0WU54eXRoLy9TbVIrU3hDOUVK?=
 =?utf-8?B?U3UzRjVVVXpFM2pCK0lXUE1WK2QyK0N3UEt4UkV3MU8vLzU2Zk5XMjd5MllO?=
 =?utf-8?B?bWpTSG1lZHQrMHlxYkhWSVRIQURSZlZPUit2VUF3c1ZIdHc1MTNGNWwxRHdL?=
 =?utf-8?B?MFFCeGc3MU9RQ2poVDQxcFR2VVI1UXppWWxYWmM2K29MUkNWUmFXMmRKQS95?=
 =?utf-8?B?UDhRb1grS1pMQjRRT2NTK0lnNGdtTGN3UHVEOGloakNEZWtDalNpMDlFQ1dN?=
 =?utf-8?B?MUFQV3JzRkwwNmd1UG56VlVjZDljOUdMaWhhd0R0T3RvS1ladnhDYkhCZURj?=
 =?utf-8?B?aUFYQ3pGYUZaTnhXQTNzSlV6UWhnYmZkcWRCdDU2emhSYm8weDFLUHRmYjFM?=
 =?utf-8?B?ZDVjSWljOXduc0loaXkwbUZzb2JpbE5UUVZaMXIxSG9FMTUyWHhVZ2ZqSzlm?=
 =?utf-8?B?bjJLS3B3NHlCNXhyL1NnNk03R0lQM3B5M0NUbFByNWpRWTNHUHhHWGx5VlJs?=
 =?utf-8?B?aGJaZ21YU0VKT3N6UWhlMGdDTDkybEpVUGNwUE5tZEtJV0lLK0Y5bisvZE52?=
 =?utf-8?B?bmprdkp1c2dXeXBlWG1kRVo2Mm5IMFpudzJ4QW5ZVWRpRWVKTS93YnAzRkhp?=
 =?utf-8?B?Y1V1aXNJaStqTFhsUWNhb3orVDNjQS9hbHFiT04zZXI5MEJtLzNFQW8zWElu?=
 =?utf-8?B?RHFXb3FwUVp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6170.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNveW13cUFWMHczVVdiaDBEZjcwNVF4dW9vVkxJQjl0UCttNkFTMUY5cmRi?=
 =?utf-8?B?WW5GKzhSU2RDOHU2TDVNdzFYWUdUd0ZVOEd5Wkt1VlloMzdMSEE3M3dUdkc1?=
 =?utf-8?B?L2VFeUUyYjJQM1Y3MHlKV01GN1NxMVlXbjhVa091UnB1a0g4c0haZEEwTjFJ?=
 =?utf-8?B?TDBaTjRZdmhuZmlDRDNXYndKdmFqdkFSOUpFdy9iWjBzZUluZEJMRDFMMkt1?=
 =?utf-8?B?UmpZVjRzaXQ0cnVGTyt0NmxrWnNLa2NndEtKdmVaVWNRMkNpdEVoVDMwRVU2?=
 =?utf-8?B?Ulk1dkpocDQ0a2FlZXVvVHptdHFOUVR0RjVmVWpMdk5mYzRMVEp3eXJtUDdI?=
 =?utf-8?B?QXJTTDk1T09mb0owUHlUdEFUNkIyempNUVB0VnZlL0hiVlUwZ2x2UERYU0dv?=
 =?utf-8?B?VTdnQ0VydnpZWjJSbXMyS3g5c0FiVWJtTk1haGsrMWErZm1ETUoybHRGUFRR?=
 =?utf-8?B?TEE1b0hKSjhTUWticmtsdkJKN0V2QU5FU2phR1pzMmVOZ2pTM082UEdsQ3No?=
 =?utf-8?B?T0htWjJyNURrZlJsV0VaZWZYQ3lPUWNLNHZ1aW1veVp1VXM1WE5obVlURTRQ?=
 =?utf-8?B?aC9JQ3prK3g5WmEydW9LR1NSZTA2eS9mL3ZvN0dYMGJiUWZKeHBIOTZSNDhY?=
 =?utf-8?B?WThsdmozeHNzbkgyWnVTVDBFVEwxY3Ztc25DOVMwWDdyaHJmY0RrbWt2MXor?=
 =?utf-8?B?TUJJMnRnYnlOcjJRN3kxZVhYbERHRkxHQUZSTUlkTW5RWENndG16K3U0OVBD?=
 =?utf-8?B?WWlGelJrTGVrUU1LcXliemozU3dCbUw3cmhoTmUzbW9mYi9QcDhEaUx1VVQ2?=
 =?utf-8?B?TDhoeHVXRWR0Wjd0c1NkbVp6K2w1SnYzK1RvUC9CUHFhOVhIcWcwWUFOM0dv?=
 =?utf-8?B?V2luWTZqV25USktwVjdxVUIrc0t3WTNGam1QSktpS3QwVVM4ZGFrT3B2K2dr?=
 =?utf-8?B?RWZuVlJ2Z1JQTytGT0h6MVN1a0NhM2wxOHNTR0dudU9pUXFpemYrc0xmdkdS?=
 =?utf-8?B?NWxRcXcxSmpkdzY0cmpxMjJBRWhmN1lqaWVFZnBmZ0NQbnRyQVNpdWF6R3pU?=
 =?utf-8?B?ZVZqYndUdlVDSFpzRmtKeS9pTTEwN3VON2x1cVN3c0RqUkV0KzVaTnBHekpL?=
 =?utf-8?B?RnBWdTFlaWIrM2d6VmFqajNSZW9pWHRjUExnQTdSV3d1VUxvSUlNQ1R1TDJo?=
 =?utf-8?B?N1ZRL0d3Y2hRZDlhejlCZG05YVNFc21MeXFEcXpsQys5ZUgweFZhNGdrMEla?=
 =?utf-8?B?OE1kbW5YQ25mV29DNWZicG5FS3E4K0hnaDJESTI3YXZuWUQwODVPV1o3bWN1?=
 =?utf-8?B?NWV4aG0vTmx5TlBhYzBkSmJ3ekhlQmQ5bW4yMUkwR25wRFloSDZ6UlN5VS9y?=
 =?utf-8?B?VFBqY2FmcEF2cTlNb1ZyRHNJUEk5dmZMMU1RUjY4NDhTdjlSNXM5Z2NjOHFk?=
 =?utf-8?B?WlJiN04xaGhTSndtb1cyd21Cd0pmMmlGaWRRSmVzWkJpKzlNb1M3dGdlR2N5?=
 =?utf-8?B?b3lQUUlwOG5FT3gxMDlmbHlzMGpZRWFnK1RlWHpIamdIRENKSDlRdTZTZFg0?=
 =?utf-8?B?Z1lMdmh3ME1sV0J2NlRrcitWVzJLa2JCSGpYK2R2UWVlYUx2VDBkTUFGTG90?=
 =?utf-8?B?RGxVRHdLb1dPNW9GSjljUW0vZlFhN2F3MS9hQmNCWUtpL1dqYUpXRUcxZjZQ?=
 =?utf-8?B?OGZpK2lNaWZvbE1icEV6OWltV3lOdHJBb1RuN1AxTTJod1FRVmhpQVF5RVlH?=
 =?utf-8?B?Y1FpVHc1STU3dklLTU4yVWpvTWxqU2NSWWFnYm9oUzZTUHR3SFg1Vk8wOGV1?=
 =?utf-8?B?RE1GeFBscGVkTEFLbWFXemJlVmdlSkpYQkMxTzlCNjZwOXdpRFVWdmVmODdn?=
 =?utf-8?B?bE5UOXRzZFBQM0IxSjNIaWluSkhTME9jdjJmMWEzYzIwNzg4OEJCanNlNlJt?=
 =?utf-8?B?UmhzLzBFN1NFVGlSUk51ajkzdDNzME9FUzFEWm4zeEZMVXJWOWVuY1ZTUjlp?=
 =?utf-8?B?bjJLOHdWbXo1MGtWbms2cUF2cVdsVnJwbjNBVXZCQmwyVGpqZS9TY0ZPNEEw?=
 =?utf-8?B?Nk5ObGFlMm5jNzJFQVVnK2hZSnpoSWJhVkg4VmpxVHlQODc2S28yK2ZHNzdR?=
 =?utf-8?B?UzcrV0JOK05GQjkrOHpjdmlEUHpHbzVBTXdPalk4enFUQml2ZHZTeFB4M0FX?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E455A8667AF844982133DD92E1D2189@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6170.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525d9fd2-7f3f-4726-13f4-08dd70f1d4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 07:50:11.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O06k8eGd52ULi6zY1BgMJwI1q/eJ3xztDhH895ZhZG/nuGlMjGZR77nsAiAYK79F1dFfTK3yz6Q9GbD7kHfAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7531

SGkgSm9oYW5uZXMsDQoNClRvIGNvbXBhdGlibGUgd2l0aCBmaXJtd2FyZSBjb250cm9sLCBkc2Ni
IHByZXNlbnQgaXMgcmVxdWlyZWQgdG8gMQ0Kd2hpbGUgYml0bWFwIGlzIG5vbi16ZXJvLCBhbmQg
MCB3aGlsZSBiaXRtYXAgaXMgemVyby4NCg0KQWxsYW4NCg0KT24gTW9uLCAyMDI1LTAzLTMxIGF0
IDExOjUxICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBX
YXMganVzdCBpZGx5IHdvbmRlcmluZyB3aGF0IHlvdSB3ZXJlIGRvaW5nIGFuZCBpdCdzIHlvdXIg
ZHJpdmVyIGFuZA0KPiBhbGwsIGJ1dCAuLi4NCj4gDQo+IE9uIE1vbiwgMjAyNS0wMy0zMSBhdCAx
NzoxNyArMDgwMCwgQWxsYW4gV2FuZyB3cm90ZToNCj4gPiANCj4gPiArwqDCoMKgwqAgcmVxLT5p
c19ldGhfZHNjYl9wcmVzZW50ID0gY2hhbmRlZi0+cHVuY3R1cmVkID8gMSA6IDA7DQo+ID4gK8Kg
wqDCoMKgIHJlcS0+ZWh0X2Rpc19zdWJfY2hhbl9iaXRtYXAgPSBjaGFuZGVmLT5wdW5jdHVyZWQ7
DQo+IA0KPiBUaGF0IGNhbid0IGJlIHJpZ2h0Pw0KPiANCj4gam9oYW5uZXMNCg0K

