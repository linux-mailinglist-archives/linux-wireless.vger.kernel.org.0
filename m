Return-Path: <linux-wireless+bounces-12016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD296010E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FBCB208FC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58E54648;
	Tue, 27 Aug 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FnbRqbbI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I2gnS/Ah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A954F87;
	Tue, 27 Aug 2024 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736536; cv=fail; b=o3xlxxoFo4AdkSs38CnJha2O06Uk+CD3vmKG1K7blWCgWWagIQjzSATKBw+YF9eGZ2KTfNfQb9CLWTzgv6Sc8DmAU/IGHakgvW6zJKrBOsFRScEIVm8V8JrjNyn8cn1WeMTFp61cem6xjvcIunWUk9j5XoOqs6XkiuDyVPLsNfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736536; c=relaxed/simple;
	bh=AtXGGNJcSZKtc8n4mjxjv/TPJ25LoYpDwhjhRTP8YEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqB3yrSfXFg4dQhuV3nQmeq5Faeh0te4XD2TD9IfglCkgIWMXVGNLqZhkSHIkVlGpbt/+UQRTPjyJ+O4HaW6L/D2f0Owv8YVSK85ERgUcJ0/f2cVOetkzM+2PIVfdfD2YNSuM9VGhPklYXJnFEFPvblTEDSEV+j4pN6Eksemdss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FnbRqbbI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I2gnS/Ah; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QKtR8L012576;
	Tue, 27 Aug 2024 05:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=AtXGGNJcSZKtc8n4mjxjv/TPJ25LoYpDwhjhRTP8Y
	Ec=; b=FnbRqbbIZOIbfPJxEgNuKOQ8trrvI5OkiRiO55M4Wi7tL5wz+QcINXK6W
	XJ47FEos3l7dmb5UurdvvC9iEbTV1cPFn/vsQP1eJEgwyOvZXSlcz0Mk+Kiy3oPe
	oiOVbvC9s89TMc57YEmF0sJfJUELiGlDKVnz4c27zRzeD7fqMZTP9eGezHIhfnZD
	dFWEEi+V8Z1y8KA/HZNFCm1KfhJbsaAI9lHB3qfM6BzT1g9qJznOwlbR0NgdZNL6
	9Xg9p9k1RUixqFA5+ymzQYYCDDJOJe0YHeJ4xoJIH9wvGWqcbS1YIAi7zF/sXEGJ
	a9XcU3rMkGLOEJnOriz5U2aukzanw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nacp1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 05:28:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47R3o4H9033070;
	Tue, 27 Aug 2024 05:28:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0te929-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 05:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa2dqxHwUzFBZ8Q350E/v430FafKdndKQX0B/NpRKLn+ZIcQ04BKjzV5HZ6+02oQybRsaFHn9KelJv4qMdFyQ7s0XxZyKRRjw7HsvF3ZBSE5/WwwXhNkHB1wymQjk/cjlpFew149cje1c5ZkFTQgQDX1RJUZcfeRYxQWeZlOFQHsN+IzYeo/oL+bVoqNbhtTSn/oIzSCIZqiR0t31sRjWQfuRrsKwEH+zj3toEYUFa4tixtUCoDIhvC0EVtfZC2yZUXHSBl4bGJPWCS+T/ESTLleoesD7krRF1s/Xn0Iuydazs56xUiX9Ofv6LUEZiatVMvMHVKLV5xqE1jxGnFEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtXGGNJcSZKtc8n4mjxjv/TPJ25LoYpDwhjhRTP8YEc=;
 b=jL6+j672/4zWJ3Rhq1Lq0kD9IG6uzgjUdXdGgAE7NU5BZA7HYowJMulQ0uhpm+i6FDW3KbE03zaYcTlMmjyK4mTj3Khwd7sgs/XGEt678WSAFpGreumJCdXCLo+niJ/UL4TleQwefI6peHFVpvjQcbV/mEQJGZOogW1FnI3GzwcOvQPhzM6Wq6w+sKkDY6pohcsP9E4/EMg8/l3cyW6gSjmZQpoOLNr0X4v1/9IDWdiR3W/par1xK3vRig/rHD+2e7vdrdsywbBEjDU8xR7L9Qi7+SCVg2/RwPIHoDLMmGgKIGXPNA9uV8PxDe1z9s96OUPe7iXW+OSAJSxLICIR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtXGGNJcSZKtc8n4mjxjv/TPJ25LoYpDwhjhRTP8YEc=;
 b=I2gnS/Ah1rY+P6VkXh5skemdYrgnv2qKXSNHw1B5Dl1kybEakDwIrVJ+J6tORaVAUZ+KVV65jM6NqrqNodOesdGYmwL5pTnnikd9dAbGnKl0rHlMS5+0DHwDwEy1MI641hgEdWG1As4j+IdUk/KNwDyk8UrRJqOnOUIDC/MsR7A=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 05:28:23 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%6]) with mapi id 15.20.7897.014; Tue, 27 Aug 2024
 05:28:23 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lihongbo22@huawei.com"
	<lihongbo22@huawei.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pshelar@ovn.org"
	<pshelar@ovn.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "dccp@vger.kernel.org"
	<dccp@vger.kernel.org>,
        "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: [PATCH net-next 2/8] net/rds: Use max() to simplify the code
Thread-Topic: [PATCH net-next 2/8] net/rds: Use max() to simplify the code
Thread-Index: AQHa9fftnxk229IcFUuglnINIM85ULI6l+0A
Date: Tue, 27 Aug 2024 05:28:22 +0000
Message-ID: <c01f55d7dc493f46cccd317666899a1272de607b.camel@oracle.com>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
	 <20240824074033.2134514-3-lihongbo22@huawei.com>
In-Reply-To: <20240824074033.2134514-3-lihongbo22@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SJ0PR10MB5671:EE_
x-ms-office365-filtering-correlation-id: 5ad7c110-7b6d-48a9-8ccd-08dcc65911b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVFUZ2RoM3ZDVFNYYyt3Qjl1VVN3ZXZqaHBtSFBQazVBWm5ZWXArK0ZMK0h2?=
 =?utf-8?B?b3lEUnlZdlBDelFnVkRaRGsxdE8yTS85M1BJQStwYjg0SGlTRVJUVW5qZXIy?=
 =?utf-8?B?MHBLbVJGZ2dEMFdtT3FzTHYycGRGcitHdzExL1NRb1Q4R2lXZGpsSmJEWjZT?=
 =?utf-8?B?ckdVcHJkUEgzQktMTjdXZTIxTXh1OWVrcVFzZER5alFBRGNRZnlzSkMrczk5?=
 =?utf-8?B?T0x5UGIvRWV4UHBjWGpubVV5OGJsM1JrR1k4OGxlTTBrS25KbHhMODJhSjhK?=
 =?utf-8?B?RWVVcmsyajJOZjdrbG9zaE95SytDeXVFd0tsaVltSWEwMVViaUFsVmIxWHJK?=
 =?utf-8?B?bEI2a096emJYZm1ER1UweXVBdDJCREtZZlN3U2tBQmU0VzRqSVdhOVhGWlZr?=
 =?utf-8?B?UjNmNUJ4WkZyUXhiZXFrL3RIcTdnYUp6Y3VwTE9aMG80VEVsNDhnUmNaNVNM?=
 =?utf-8?B?enZDa2JSSUJmNGRocnQxK0hibjdZaTFZb3dGa3BCbHNaSlJERGJaeVMxSEpG?=
 =?utf-8?B?N1NXN2p1Mm9hWUNkSm15OVZzM2Y0d2tjdXZDVmZLZ0F6ZXZld0t6Wm1aWVNL?=
 =?utf-8?B?VmQ0dmY1ZTdOSVZCQnFUL2tqNFhxdGNJL3lUSEZ4dkxmT3BMRCtic3lzbXRN?=
 =?utf-8?B?R0JkcTFXUHNYWVZtSk9sV3NxSnp2SVNoZzFGajA5MXZuOUpEYkVVNWY4Z25P?=
 =?utf-8?B?aVNvc0pXenp4aFpwdXArcWFSWnl0aFhWOXFZSzEzV3VTenVhcmpmaEJEOHp1?=
 =?utf-8?B?enFFcUsxQ2RhWGVQQ0VvL2k2M05SNU5qY3hWdFo4bEJydkluclhrZDA4NTYx?=
 =?utf-8?B?K0EvaUgydGRwZTNUUXlNS1pTYUphRHc1aFBOZzk0UHp0dEdONnh5RDRnYWlh?=
 =?utf-8?B?N0V5SXdJaVhncDlXdGJkUVcvOVJxM0pUL3lRV3diZCszWW1jT3RXY3B0Vjd2?=
 =?utf-8?B?dnkrMlJUVXkyZnlURGxHZ0x6ZWkyR1FaSk12MkhuL0xCd0VaTk9HTlljSXlz?=
 =?utf-8?B?MXdtQm1VU2oyN1Q0NW1GeWZTTktUTVNlY1NsTmdpd1FyRUZPV29NV0RnL3Fu?=
 =?utf-8?B?aSs3NkZremIwaXgwdDlVZ3FPVXBjeEhQd2J5dytuY2NlQjhkeFVBTmRiMDE3?=
 =?utf-8?B?Qkc5a2tRUXJGVWFKVkJ2RkJWR29NMTZqRGJlR0xuN2w2RlhWZEFwc3FzbHMy?=
 =?utf-8?B?QWdJdXdrUGpxYWJJdGZ0ZFZRY1p6bHNNWUFhUS9uWkRxa2FQU1FTQTA0bUdh?=
 =?utf-8?B?cGZZcFBpRk1NTDFpVm5pUU9EaTVUeWdUZEcvdEJhUVUvb01HbmVBcXJCSmJU?=
 =?utf-8?B?L2c2cUQ0UDViYUk5eGZlVmliMFRFWVRhTDBTRlF5bi9ZZ2pncUhJUjZnYnND?=
 =?utf-8?B?Z2k2akhRdW5uNERyZlRJd0xyYXZwNXcyditCd1Rva1VyTmtmTUhkWHJQVDRv?=
 =?utf-8?B?MU9SK2pac0dySEV3VEhEVW1haUJtSCs0QXhPT21nYmRUajltYWRadmswYXYr?=
 =?utf-8?B?dzRLajdEaTVjVmwxY01LMDhnbzdBaVFuRGJLRXJIU2JJWUQybUZzMjlYWXhG?=
 =?utf-8?B?ZW44YkdRbmk5cm53VzlZODZMVm5iN2F5eDNHWTA2WFdnYlR3NkRMdDF4OXA5?=
 =?utf-8?B?TjhVV0o4NmQ2bFR1RnhGck5qVGZLN09lWHB4U1h2TkRBTmhUNWx3eUR6cWRN?=
 =?utf-8?B?cDVtRkFYcHVDTDg0Y0VZSnpTRkZKc0R1UEszKzFzUlU1MDBiS2NYSXRuSjZK?=
 =?utf-8?B?VnNONGFWSUVMaUcyRm9ITFJlZzczTDNqWm4zM0YxSEdneHhIMThoQ2k4RHJr?=
 =?utf-8?B?ZGhlYUZBRVQ3TWU1dGVRV3NvZ3VMN3dYbGR6SFh0SjZESjVVejhWRVFBYWdG?=
 =?utf-8?B?MmpkUGNxSlBpV3B5bVNYYWFyYUpzK3ZGelhFZUxMTFpjdXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFY4enFpV21KOE5rZGV1SUlkc0lmSjA0ekVicWpiUE1HY0pUZUZrRVBHamtk?=
 =?utf-8?B?UmNMc0dyamlYeEI4czFkZGxTVTVkbWhGS2crbC9xNnR4L1V4aks0VGVzRG1k?=
 =?utf-8?B?VGloUlg4UUdhSmM1cGZKZGlvTm9jRjlGWllVVUFBZFZtYVJWZU4wRXYzVkJT?=
 =?utf-8?B?OFdvWHd6UHhtUVBtMGdtdG1XSklOb0djaXE3OHZTRHUxRHR3d2RqWHRiN0NO?=
 =?utf-8?B?NmtudlJYeEp4WGkwaFJTWmJxV01aTVFvTjNDYkpCMHhMVm9uczN1cUZ3SVBO?=
 =?utf-8?B?RkxtclZrSllxT0FVM2EvY3JZeXJsemlQbUJOZSs4Z2IxcGUvZ1J3eHhtOGFG?=
 =?utf-8?B?b2haNUlrenFFRnpGQ2UyVmRPdC81VWVZSXVDR0lwcTcweUR4Q3l6NWRtS1lE?=
 =?utf-8?B?QUpCKzlpNGVwNFcwWG42M0hObnNjbi9EUVFSYkFFa2lHWEVYWFZDK3dKUVQv?=
 =?utf-8?B?RXFleWloRENUL1NRdEZlMjQ5KzljVTAraE5MYnpPZis1UkdJQjY0RUF3SHNM?=
 =?utf-8?B?L21mK1ArYUp1NUg5ZyszU3BWL092VXJMa3VBOVQrZW13NTZIRGpBaDBKTmk3?=
 =?utf-8?B?NGJoMGFBQnN6aFBVMForaGx0bTFVdlExM3RpOC9KUFd0QmNwMDZtU2o5NXNv?=
 =?utf-8?B?SGtFL0hnSkRtR0l5MVhBbm5kSDFVL25TbzNwTW1ET1dWcjY2aThERFQrTTBY?=
 =?utf-8?B?dU9HenZReTIxYnNnTjAzWGFxV0VudjNGMkVhNktMNTRzY3ZMUEJBNXhqNU0r?=
 =?utf-8?B?RnZkV2xabDZrZTZjaEFVVnA0djNCZWRRRHEvendlRTQyNEhiU0FpNThTb1VE?=
 =?utf-8?B?OGRrM1d6ZVQvRjk2cTFPcEZpMjhJMjd3M0NGbzVpODBBdHA0ZTlrcWZtWWtG?=
 =?utf-8?B?SjBQRE5UNzZrQWlld2RLeUpCRWZRL09pWm82d0Zzd0JCcUIxZUYvSXlYL01z?=
 =?utf-8?B?b21kZ2dEUVhSdEltb0J2TXpPbjhsdEsvT2RCbnorUEtaTXZpUnZoQ0IrL09E?=
 =?utf-8?B?ZzVKN3Y5UW5rVjBnZEtLQWRoMmZ6eWlXRGE1b3NvcHJhZDNHYnZZa3RQVnBw?=
 =?utf-8?B?NzV5akhVUkthbHd0OUw0d1FacEtNa0RKc08vc0p4SUNtTWVUQU5kVm9IVTda?=
 =?utf-8?B?ak1NYUF0dm9xSXpkVUcvb1NXcTRsUEovNVBLS2FITTBUUVVQbENXS0JrSVRj?=
 =?utf-8?B?L3BjNkhIa21QQkxoTXlmdVN2WDdjM1ZZMHM1QlBQUk5tbFV1MmtWTUQxcVZN?=
 =?utf-8?B?Sm1WemROU3I5T3d5ZEk3K1RwSis0TkZGVXpaYy9ycEhDdnFzaExNeS9mWito?=
 =?utf-8?B?Ny85ZFF1VUNFNFBqdVNKRlB6K0RFL1AwS3hCQWNDQXZ0ZjN4RGprRmZDNXlW?=
 =?utf-8?B?R3IxNGUra01Ea09hbHRJYzdhalhxOWpVemQyY3FweG84MzdsOGhXb3BnZStT?=
 =?utf-8?B?NHc0Wkp6cFRSQjN4YlZ6Z0RVK2w3emdZYkp0VVlybVdBUjlnK3l0aTZMTzBI?=
 =?utf-8?B?MUhBZHRxV0R1YWVqRE1aZFY5N3ZQWll0enBELzc2bE92cFBTeG5WbnJaaHNy?=
 =?utf-8?B?bzRWTzZzbTdjeFdFMDJsbHF6SVpnVXFHbmtYUkVsa0EwczliWjY3M0dOaWNr?=
 =?utf-8?B?RDJKcFJFTVl6eFNILzZTaXN5Q1d3cG9ib3Z6dzRUVUtqZEZJQzkwRXMydG81?=
 =?utf-8?B?OHV2RUp5RURaMTlHaEl1ZGVOVFRrQTNKUjJCQWNOdW9nQTJvZTNHN0FaL1Ez?=
 =?utf-8?B?MkdJTDBiRTVwdlZiMWtpV0JVRlJhNnpZYmVvMWVCVjB0TmM4bjdVZ0FPalg3?=
 =?utf-8?B?TjdSZUI4R241RWRmczhnWXVhNGFxREUyOHpFSDVqbFErOHc1bVBEZ1RYRFZv?=
 =?utf-8?B?ZlVJNWQ3MUFKczIxNjRFaUEzVFdLbnc4YjNBWHBBVERnd2NDdHBCOVlMMXl2?=
 =?utf-8?B?OGlaaElFMXZKQ0w3alVQUUxCYkorUzlSLzcxcU9SanRwdXlQREw2NEdSWjF4?=
 =?utf-8?B?c3BobFdpTTB4U0diZ05jOWVpei95aFRUVkF3elIxTUNUOVJGSmJlSjJHcmdZ?=
 =?utf-8?B?RG9rSVpiZjNoN1lOQUU3YksvcGp0WnpjUlVFelZxL1dtc3hDWFIydDJ0SWp4?=
 =?utf-8?B?b1EyUVQzMkZnaXp1SHpVTE8wSThOL3pOVitycEkrV1B5OVJic3p1QkQxZ2FL?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <015AE303B97E4648B08F2B5DFE66DAEF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wFCb4k7Wn6noccB7DKYnxnTW6bXlpVs/097aBWizu6VOpDja65Ar+v3LiYJ/wfwBUvW4SNcbDrLfwjEpqV1sjMSo7iSwp7XcOnD0/ZL6eHVUK2X8z2JrYLVxUdiaSl1pRBqzuuxKoiIsZQp+1MN504EhJNxmU9AN6oBqIRkLv287aEE8c049qL1XwKJ9OYgKrS4kXkjsND0JdSTki606iNTxAtiUjL9OswgjiSym/BxlcYmaYV2BrxP3/XupM3zmWmXJVsxfEMu3s5SECsAMQUpsZpIMPOCv2yNNEBZ4ErR7vw53LhholBBBK8OvMLxLAbJsLh7GKviwNHDP84oLhMw8vi+SVftI3VJ6QQrCkb22dve1Y2qtDxWVrkpvvJS+YlLnLz8kv4LNYoxQevbn/KSB6U0BO3PX0Rgjp9tWL4FpqsQsvXqib5H9MDzLKsYBhuQ3GxQWuKjjq0EA6FfIyb52pIChgOSR0TzpAuhUMLCsvKh0fxKtheupb7TkDTnd8EXUIvODD6dW570znGK4nNSK22glIRq0+s/08LUbG6htqv1rq3klT46RokYJi2yf6lnKhYwBSD+Gxy3Zj+Tb/fGRJCvEUdSxd1fO4PH9BWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad7c110-7b6d-48a9-8ccd-08dcc65911b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 05:28:23.0890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4u0RWA95mJeaQg/sHTzgHmQYVM+jDbzPSFdDLALrkYX2Tcb+77smnWQMa81KAWZfwuugyxnE+3GQNoYJ05CM66De0xk6AY54ePkkcbdkrP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270038
X-Proofpoint-GUID: 0gE8GyqHgQWBroOD4ndyrvL8Ta_m5X_r
X-Proofpoint-ORIG-GUID: 0gE8GyqHgQWBroOD4ndyrvL8Ta_m5X_r

T24gU2F0LCAyMDI0LTA4LTI0IGF0IDE1OjQwICswODAwLCBIb25nYm8gTGkgd3JvdGU6Cj4gVGhl
IHRhcmdldCBpZi1lbHNlIGNhbiBiZSByZXBsYWNlZCB3aXRoIG1heCgpLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEhvbmdibyBMaSA8bGlob25nYm8yMkBodWF3ZWkuY29tPgoKTG9va3Mgc2ltcGxlIGVu
b3VnaCB0byBtZS4gIFRoYW5rcyBIb25nYm8hCgpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJz
b24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+Cgo+IC0tLQo+IMKgbmV0L3Jkcy9pbmZv
LmMgfCA1ICstLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvaW5mby5jIGIvbmV0L3Jkcy9pbmZvLmMK
PiBpbmRleCBiNmI0NmE4MjE0YTAuLjg1NThiMGE0NjZiNCAxMDA2NDQKPiAtLS0gYS9uZXQvcmRz
L2luZm8uYwo+ICsrKyBiL25ldC9yZHMvaW5mby5jCj4gQEAgLTE5NCwxMCArMTk0LDcgQEAgaW50
IHJkc19pbmZvX2dldHNvY2tvcHQoc3RydWN0IHNvY2tldCAqc29jaywgaW50Cj4gb3B0bmFtZSwg
Y2hhciBfX3VzZXIgKm9wdHZhbCwKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKg
wqByZXQgPSBwaW5fdXNlcl9wYWdlc19mYXN0KHN0YXJ0LCBucl9wYWdlcywgRk9MTF9XUklURSwK
PiBwYWdlcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgIT0gbnJfcGFnZXMpIHsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCA+IDApCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9wYWdlcyA9IHJldDsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbnJfcGFnZXMgPSAwOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBucl9wYWdlcyA9IG1heChyZXQsIDApOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0ID0gLUVBR0FJTjsgLyogWFhYID8gKi8KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cgo=

