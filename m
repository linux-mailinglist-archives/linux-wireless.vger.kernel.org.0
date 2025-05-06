Return-Path: <linux-wireless+bounces-22657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1645AABD1D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1951C22206
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A04250C0F;
	Tue,  6 May 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=global.tencent.com header.i=@global.tencent.com header.b="pVS82Mtf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537C24C66E
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520022; cv=fail; b=NVA3z8RvG+hyRkzGMtQAgub65Fnqqzxrxdm5GgKFv/g2ZwADwwGwSLiQY3UNip3WBId0nmMfryrXGK7UU3tHYL69Lijx9hpn3ZUxSkBanQ5cj55U8TZOabtn/jYruJ7ia8rzR7LoiYCINCqz+1iOMj8rQBp9JeFBBZggDeHtJSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520022; c=relaxed/simple;
	bh=vIscQKW0iuXY4MbQ/6c9SMveg3VuVgMUxgLNmgPjoiU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YmgyASfTiGUkSLsI9cJvaZqOuZMJftfK6IvYoiM33uyYzmO7w4zYkOLHd+conUi33j+o7STCelD7xs0I8xRruYz9GRITSYBe3gwokrxZjLWZjdJxnzTfLIXDu/JbcwUQdUssbpvuCRLY9fCPouPWqGy1ru2BNftUhaDrjihzdOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=global.tencent.com; spf=pass smtp.mailfrom=global.tencent.com; dkim=pass (1024-bit key) header.d=global.tencent.com header.i=@global.tencent.com header.b=pVS82Mtf; arc=fail smtp.client-ip=40.107.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=global.tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=global.tencent.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ1J5SyOn8Khm3Y9wpt8H+Stq1IMoORis1kkQ1S1h/dLXmZ/xkIuC+91T/QXp2MWqLXM5tQCQ+NHCK3oHYjIeJeSvEibSbS+f2eCGQCDmGMRdPkbmDu/zHUSuXcMNAlkz0/J6tx1CXVX+kMK2WIQXHFZB5WX5kk+3d9jsTFdxFZxNFDvBrTrxCsPWLvOz7K3thNS0TgUKdbNIVS5TWgpC8pvgYbMeEsy2wbfowxlfqmYg8DSju6IrAqQhpV9j3kMaqq0J2pijj6rKDZP9dhwhLpQVhYPU/9y+SKayUKClpZuYwFOALsQKf+7VpwNL79DR9C2GaDUFGFah8bRyUXmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIscQKW0iuXY4MbQ/6c9SMveg3VuVgMUxgLNmgPjoiU=;
 b=wANyO2g044qHnytt/70C5GcEoVZT9mfYQF4pKWU38Q7ZfHNR9jZbNZiXwyBD2YHm7K285//nHJRp6J8ss9y9am6xBNLxTmZ9fDIDiieYgu+oDbJly0xxarO7waRD5uy4QV78bBfA3AXSEuluhYtdMsoJzGbJ/UrdvztQ6DWcBKMZtAMcPmBKSZxZzYHHUl02PZXSM3I3SwFoFLF2oxU511cSrrLdks4+9xJlPjneGXhgmNdiAwvHbk09rAoQTBNG4YZ1gB+vhw7Oz2h8pVdNCxKbH3c1JIxAOA6i9N5+MeLSRJKPpKIyq3pKOmu4TegGqTnV9WYP55ry0vytbi3fNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=global.tencent.com; dmarc=pass action=none
 header.from=global.tencent.com; dkim=pass header.d=global.tencent.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=global.tencent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIscQKW0iuXY4MbQ/6c9SMveg3VuVgMUxgLNmgPjoiU=;
 b=pVS82MtfnSSQ59pWWg1wJlp43zZcJdyE8fL/91+F9BeNqWvOqZc0A6rxN0YS3wPiqR9C1dtEXNGqXpEDf0EuQz+Zwv+EEC9di5U0bSROVfkMDbexjzrvelJmnob1AtHtEzW8AZmaw99zAbeZnGl2vyePwqdLqJj/U0MYvGgRTb8=
Received: from DM6PR13MB3324.namprd13.prod.outlook.com (2603:10b6:5:1cd::16)
 by DS1PR13MB7025.namprd13.prod.outlook.com (2603:10b6:8:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 08:26:51 +0000
Received: from DM6PR13MB3324.namprd13.prod.outlook.com
 ([fe80::7b39:5c4:142e:c680]) by DM6PR13MB3324.namprd13.prod.outlook.com
 ([fe80::7b39:5c4:142e:c680%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:26:51 +0000
From: "zhengyushi(ZHENGYU SHI)" <zhengyushi@global.tencent.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [BUG] rtw89: high latency jitter on AzureWave Device 6110 (RTL8851BE)
 under Linux 6.14.4
Thread-Topic: [BUG] rtw89: high latency jitter on AzureWave Device 6110
 (RTL8851BE) under Linux 6.14.4
Thread-Index: AQHbvl9He46pkUrVxEWfnGKUw2rIog==
Date: Tue, 6 May 2025 08:26:51 +0000
Message-ID:
 <DM6PR13MB3324CB742CF4CE86B4B363ACF3892@DM6PR13MB3324.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=global.tencent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3324:EE_|DS1PR13MB7025:EE_
x-ms-office365-filtering-correlation-id: e00992a6-a542-4a41-41c9-08dd8c77c08d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?bHFjcWxtdHZZK0t6TWN0UDUxaW5jTlVmUWltVU1SZE00SGd6TTA3UCtoa1Ay?=
 =?gb2312?B?U0hWQmpHRmVaeFV3Nm9vODFKc0l1Yy95TEthMmhpcVhyVUJ3VFQ0ZEJVOHJN?=
 =?gb2312?B?T2VIdkE0ZHk2aFI1MkVRYkFaWFFIdkx4QVMxSzg4YjJPb1UrUEJONWNGc0dT?=
 =?gb2312?B?RXorZysvVlgzUHdZTjk2cWhWOWJOa0gxZVNuS00yUnRvRElUb2VxRUNsZE00?=
 =?gb2312?B?ZlIwMldOZ0MvT0F5NGNGb1NrNkhpQWduenJqZm8rK2RzdTRneE9obEJTK1U2?=
 =?gb2312?B?QkJpazRPQmhQdmtocmcxS2pIL2RMSVl6UTB2YUJsVmcySURJL1NMRGRJVmc1?=
 =?gb2312?B?NWJnSTdtVmlVcDdJTHhzWS96U2pCc3FROHVUUkFGdzFYZGVacTRQK3gxNk9X?=
 =?gb2312?B?WGMydWZKYUtOWlJSQlBiTGE4SlF2NzVNT295N1pNbXVHcXhWZVRpUWx4SGdD?=
 =?gb2312?B?Mmt3VC9JOTdxeGh3N0p0Syt5M3M0d1lyTHQzZTJGRWVNS0kzZnh4UFU3TDNS?=
 =?gb2312?B?V3dNUld5MEFjM0dYL0UrVHlxWEsxRmx5N1pjMzltWStVS0RBdHJ5NS9yRUk5?=
 =?gb2312?B?OGZCc0FSczNUc2dydjFXSGdGaFJXY0d2clJJemZVT0xMa215dmY0MnVMaHI1?=
 =?gb2312?B?aTZFVEtvLzRzdm9JanBLSVgwUVBJZkt6QkNFM2RYZmt1alU5M3R4ME9YK2o3?=
 =?gb2312?B?V2Fya1JZZGNVTG5pbFJVcjZZS1JxVHFoazVySlJqYVFkNk14WFBTb3Q0SVRk?=
 =?gb2312?B?VW9ralliVkNzR1NsWWZ6a3JEcUI4bWw3SCtWcVd4QzFUOVRBYmIwNnhNTkZN?=
 =?gb2312?B?bmRWSVJ5bnJDb2ptV0hZWU9jc0psV25DenBjMStpajFpdXBGK0dMZUFLN2pC?=
 =?gb2312?B?OW9GeS9NOER4TFE1blBveWoyRTdzT1FJeTRSUVRZaDQ0eUY3Z0E1M2Npc2Y2?=
 =?gb2312?B?TmRmV0dJekdPL0pDbUtJdm9WZEhxSXVuenVJZUxyc0xxcU1nejFGa2JEVElV?=
 =?gb2312?B?V1ZzcjVIYkQyNFpGY2ZJaXBIbEdmUDQ1OGZIQThkcFkxL3NIcEx1UG9vRjBP?=
 =?gb2312?B?VTc4UGllek9qbDdHNk93cHhvMWR5OFB5aHJlTStqZmZDZGV5bFB4cTBoUzMz?=
 =?gb2312?B?QXRMNmpuaGp4ZTNWUlc4MmYvOG1wb2xhUlEwa2JmRnhueUlpY2dJYjdVT3d4?=
 =?gb2312?B?K2NwTVYzSmUyaUlaTkh1eXB1NHdsaitWOURhZFdwTkNMamt4elZESzljaE9T?=
 =?gb2312?B?M1RQbDIrbSttRGlYWjVsL0NiaHR1VjhuMHdLT3F2eGhoQXllRzZjUFcycE5Z?=
 =?gb2312?B?dVRFcUJNM05qTUw3RUJUZEpsN1pQamJqa2F5OVB1YTBZRzc1eXhXd0haMDdq?=
 =?gb2312?B?YUhuOVh6SUZQdjRjODlOS2E0ZG5jUE5wUmxuRXVZVTQzWkVqOW9RN1ozUHhi?=
 =?gb2312?B?dEU5OHpGbDMyQWlaOGQrMGpDdFlqOGJwTkF0a09NamM3Rk5MUDNZbTFubVZl?=
 =?gb2312?B?U1pqMHhrc0VwNWN3YmoxL3IwbGc5d1RVYk1UUXhIVEszMXZEMjM4RERQODll?=
 =?gb2312?B?Y09WZUdUMWdMMXc2TXR4NkZsZXJEbWxSdjhVSFJ5Y28vQVRTUytpK1ZNQUZL?=
 =?gb2312?B?clNRbHQ1SDVhdGdXeis3NXlIK1hNOTJ2Ky9lbFhOTEd1cmN0WTlzVjI5OVRW?=
 =?gb2312?B?SW9rUDBYYXZjQU81WE80YVdvQ3RqMWlKZjlrVVA5bmdvVmc5UXNoZmxHS3ZO?=
 =?gb2312?B?MWVvVytEdGZOOUkvbkFIMiszMVI4dzlDbnYzakwrem1Ga0kvVGpCblJnWWVJ?=
 =?gb2312?B?NlRTY2o3bW9RdlNnZjIwN3lHVGxFWk9JOW0wVm9FbXNzMGJLbXk0bEloOEhS?=
 =?gb2312?B?ODdvUTJHM1ZSQzRjaDhZamV4M2d0YXJlNG11czBiRTl2SzlPQkhFdUw1WUZz?=
 =?gb2312?B?cVhjbURhZ05nV1VHTkxsdnJrSFZESnhzazdKWkwwaENuN0RVNXcrakR1OUUy?=
 =?gb2312?B?NXMrQVczajBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3324.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?amtNTTh4QlkvMEp5VS9Od3BUdzYzM3l6MS9ReFRUQU5lT3k0dlhEdHU0R2cx?=
 =?gb2312?B?WjZtS3V4dlhwVjRMMndqY1o0b1NDdDRibjZzUWoyWnI1VFZNK2MxY2RPOGlY?=
 =?gb2312?B?ZVl4d2pETnkyWTF6N3d3M3FBM3BtSzlMczlWNTdCZ2VqUzEwa1J5NVh1VGpZ?=
 =?gb2312?B?WXpiNHhTMlh3VFZoSWNEbVhsT3FxU0tIMEVxWVc0eTBiV2FKZTRaOGpHdDNy?=
 =?gb2312?B?S1ZpUldsbTdzMUtRVm1tZDdPZWpDeGpydzU5aWlFQ09lOHU1YnN2QzVGUWVS?=
 =?gb2312?B?SXpLQ2xTYjI5NDNralkyMzQyR1dPSWxvV2pvVDBjTlVOSURDZEtwa3MySnJS?=
 =?gb2312?B?bmNIOExGWEE0VHd1V2J5U0RMd3pYWjA3TTQ0RzdRMEVTWldJNGU3RitFUDUz?=
 =?gb2312?B?NHJvSnlwUkc5TmpWQ1hOWGRxSEVHVWdLVDR4di82NERUaEtiOGw2Q0MybjFl?=
 =?gb2312?B?alhoMzZwVEdCamtvVUhtNjJZMlJxK2dNbk5vMTBmMGFveHFHSHN0MGlMQTZS?=
 =?gb2312?B?c3owZlZjUkR1dlpXR1pBb0J6bWcyNjZueGNRVXFvMGtUbDZISWhYT1J2U0p4?=
 =?gb2312?B?ZFFXU3JtMTh3TE52KzREdHI1Tm02YjByeGQ1bnpvNW55MXFTS291OE54N09Q?=
 =?gb2312?B?dmxrbXpLa1VWMU1tVTR6WkIzS0dpOHdEaVU3aDVSQVRiNi9KTTNnRW5IdFpx?=
 =?gb2312?B?N1JxQ0M2MW5rcnF0a0tYV1o2NWUzWFBQZmRSVE9TVU5RYXBLa0hjN2dtMEZ5?=
 =?gb2312?B?dDJNcGRFb2RmdSswUHh1VUEzSUQxK0lzN3BjbDZpOUlrTW5uK0FtRThGMUxl?=
 =?gb2312?B?ckE5MjhyUU81bHFqU2N2bGFzSDZUTzI3QkxLdE5VTVUvZE1ETk5VTzJFRmhi?=
 =?gb2312?B?RStGV3NNR2RmQXkyRi9peHdod2dSZndqaXpDNXpZZjFZM0ZkZFZlMDdJSXJO?=
 =?gb2312?B?eGt5bG1WVXNQVmRIajVZMlJCWkhMVk9FNTNHU1VJZFBLVmgxVWZ0M1U4dWVK?=
 =?gb2312?B?Q21pcE90V2kwdDJNRExYbnJoOHc0RHFGTFNnRVhuK2NFbGFTd1FPSWRBcW5G?=
 =?gb2312?B?U3kvWGR2QUhDUnF1MmJvbzdPK2pNeDUydithMTBPdktRTjVDSk1iZmJFN2xJ?=
 =?gb2312?B?ZmQ4N0ZZbk9VWmt4MVdHT0FnK0R4d2FYTlhnTVJaM0J3NXRLSEM4dE9JY2xB?=
 =?gb2312?B?YUZBbExJb015S2pldEE0ZGVIcisrL3lhV2Fua3YwKy81QklMdmR1OGx4YWJX?=
 =?gb2312?B?L2ZsUGtERkhGK0x5MytDYzRvd0Q2Z0xGbGFDbmhXcnNVcUY0VU5KbGVJZXc5?=
 =?gb2312?B?SzhtdXFucGZQY2s4cGh3L1d4SGRqckFQT1NWTDh1d2xPNC92QVRCQ0VuMUx6?=
 =?gb2312?B?djkybzFXRnhFM0VmdzlMRWZWbHRQTHR4T3M3bmttcUY5dkJBY3NmMGR5REs3?=
 =?gb2312?B?NUJxbWljdytLUFZSV0lTWWpGSTlnYjgwajJwb3dUaStqMmRXL3RjelNwZlRW?=
 =?gb2312?B?dC9VSW1wM0FZRjBWMUtteUV1QkozZVhKS2NhNXU1bFBTY0tSbG5MN0ZVVkcy?=
 =?gb2312?B?YnFMQkFVTW9ZeWNlaFFYc2IrbTVsVXEwZjBMWFdjblRBd3YzSE9keHZ1Y09w?=
 =?gb2312?B?S0hOMXFqOEo4R1pSeXNEU013Q3FBczQ2U2xNV0lqWld0eThoMWRYVk5SamQ1?=
 =?gb2312?B?NGJZSFRDQnhzWXIreEwwWlgxNnB1VkpyN3c5UkdZWU40anA0eWpGRzZ3cjl5?=
 =?gb2312?B?ZDRPakVxZy9ZOE9RS0hrM3U1L1N3TkRDSXFGWW5YQUlOamo1THVJUzkrK3dZ?=
 =?gb2312?B?a3BtdVltL0F5ZTM4L1g0dnBmeUJ5cXFxTFY1bEwrNHcrRER5N0I2M2JPTlNM?=
 =?gb2312?B?bzJxZ2VIdVU4RElsRitLT1FMbVJNbGF5MmNNSjdMbERySHFWRWNWSlptRm8x?=
 =?gb2312?B?QmlLWU4xaDg3TC9vcjdrdkd4MVpnRkZaNUR1ckVEYnJrcWFuakFqMk9ycit2?=
 =?gb2312?B?V1pkNmlpMjYvWE96N3ZFdzlNK2phSHRTQVBzZ1Nod1NCRFpWTzE2ekI3cm1E?=
 =?gb2312?B?UHBmK2ladC8vcE03WFgvZVZybnRweElieWVxMTV1bGNMNzV2bG5KTDNaM2ll?=
 =?gb2312?B?ZzF6Y25lNHFENWlHTTJzWDF1eDJYRFpnTGpTelhweHl4MFprWVl0cHArWi94?=
 =?gb2312?B?U0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: global.tencent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3324.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00992a6-a542-4a41-41c9-08dd8c77c08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:26:51.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a32856f2-1731-405c-b53d-480e26413adf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/V11jlYRGHqjbaJnDKcMQNDhgoDrqrdLwFs897eVnHUOVTNeoAHTPWISoSQrmbvZYvqox5+omJs4LGolpFYkbpwmM8mfL93vURD9KY5px0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB7025

SaGvbSBzZWVpbmcgc2V2ZXJlIHBpbmcgc3Bpa2VzICgxqEM5MCBtcykgd2hlbiB1c2luZyB0aGUg
b25ib2FyZCBSZWFsdGVrIFJUTDg4NTFCRSBXaS1GaSAoRGV2aWNlIGI4NTEsIHJ0dzg5Xzg4NTFi
ZSkgb24gQXJjaCBMaW51eC4gU3dpdGNoaW5nIHRvIGEgVVNCLXRldGhlcmVkIHBob25lIChzYW1l
IEFQKSBjb21wbGV0ZWx5IGVsaW1pbmF0ZXMgdGhlIGppdHRlciAoPDUgbXMpLiBUaGUgYmVoYXZp
b3IgaXMgY29tcGxldGVseSByZXByb2R1Y2libGUuIEkgc3VzcGVjdCBhbiBpc3N1ZSBpbiB0aGUg
cnR3ODkgZHJpdmVyoa9zIHBvd2VyLW1hbmFnZW1lbnQgb3IgUENJZSBoYW5kbGluZy4KCkkgdHJp
ZWQKLSBEaXNhYmxpbmcgcG93ZXIgbWFuYWdlbWVudCB2aWEgaW5qZWN0aW5nIEFTUE0vTDEvTDFT
UyBhbmQgQ0xLUkVRIHZpYSBydHc4OV9wY2kuZGlzYWJsZV9jbGtyZXE9eSBydHc4OV9wY2kuZGlz
YWJsZV9hc3BtX2wxPXkgcnR3ODlfcGNpLmRpc2FibGVfYXNwbV9sMXNzPXkKLSBWZXJpZmllZCBu
byBmaXJtd2FyZalcZHJpdmVuIHJvYW1pbmcgb3IgcmVhc3NvY2lhdGlvbiBpbiBsb2dzCgpEZXZp
Y2UgSW5mbzoKJSBsc3BjaSB8IGF3ayAnL1tObl1ldC8ge3ByaW50ICQxfScgfCB4YXJncyAtaSUg
bHNwY2kgLWtzICUKMDc6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25k
dWN0b3IgQ28uLCBMdGQuIFJUTDgxMTEvODE2OC84MjExLzg0MTEgUENJIEV4cHJlc3MgR2lnYWJp
dCBFdGhlcm5ldCBDb250cm9sbGVyIChyZXYgMTUpCglEZXZpY2VOYW1lOiBSZWFsdGVrIFJUTDgx
MjVCRyBMQU4KCVN1YnN5c3RlbTogQVNVU1RlSyBDb21wdXRlciBJbmMuIE9uYm9hcmQgUlRMODEx
MUggRXRoZXJuZXQKCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiByODE2OQoJS2VybmVsIG1vZHVsZXM6
IHI4MTY5CjA4OjAwLjAgTmV0d29yayBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3Ig
Q28uLCBMdGQuIERldmljZSBiODUxCglTdWJzeXN0ZW06IEF6dXJlV2F2ZSBEZXZpY2UgNjExMAoJ
S2VybmVsIGRyaXZlciBpbiB1c2U6IHJ0dzg5Xzg4NTFiZQoJS2VybmVsIG1vZHVsZXM6IHJ0dzg5
Xzg4NTFiZQoKJSB1bmFtZSAtcgo2LjE0LjQtYXJjaDEtMQoKJSBtdHIgOC44LjguOApBcG90aGVv
c2lzICgxOTIuMTY4LjAuNDIpIKH6IDguOC44LjggKDguOC44LjgpICAyMDI1LTA1LTA1VDIxOjE1
OjQ3KzA4MDAKIEhvc3QgICAgICAgICAgICAgICAgICAgIExvc3MlICBTbnQgIExhc3QgICBBdmcg
IEJlc3QgIFdyc3QgIFN0RGV2CiAxLiBfZ2F0ZXdheSAgICAgICAgICAgICAgMC4zJSAgIDMzMCAg
IDAuNyAgIDEuNiAgIDAuMyAgODIuNCAgIDUuOAogMi4gMTAwLjY2LjAuMyAgICAgICAgICAgIDEu
MiUgICAzMzAgICAyLjAgICAzLjEgICAxLjIgMTA5LjkgICA5LjUKIDMuIGNoai1kc2w5LnZxYm4u
Y29tICAgICAwLjMlICAgMzMwICAgMi4wICAgMy4zICAgMS4zICA5NS4zICAgOC41CiA0LiAxMzIu
MTQ3LjExMi4xMDkgICAgICAgMC4wJSAgIDMyOSAgIDIuNiAgIDQuMCAgIDEuNyAxMDIuOCAgIDku
NAogNS4gMTMyLjE0Ny4xMTIuMTk0ICAgICAgMjQuMCUgICAzMjkgICA0LjcgICA3LjkgICAzLjQg
MTI3LjEgIDE2LjAKIDYuIDIwOS44NS4yNTUuOTcgICAgICAgICAwLjAlICAgMzI5ICAgMi41ICAg
My41ICAgMS42IDEzMS4xICAgOC42CiA3LiAxNDIuMjUxLjI0MS4xICAgICAgICAgMC4wJSAgIDMy
OSAgIDIuNCAgIDMuNCAgIDIuMCAxMDkuNyAgIDcuMwogOC4gZG5zLmdvb2dsZSAgICAgICAgICAg
IDAuMCUgICAzMjkgICAyLjggICAzLjAgICAxLjUgMTA1LjkgICA3LjIKCmpvdXJuYWxjdGwgc2hv
d3Mgbm8gcm9hbWluZyBvciBkaXNhc3NvY2lhdGlvbgpNYXkgMDUgMjM6NDE6MzQgQXBvdGhlb3Np
cyBrZXJuZWw6IHdscDhzMDogYXNzb2NpYXRlIHdpdGggNzQ6MDU6YTU6NzU6MjA6YzcgKHRyeSAx
LzMpCk1heSAwNSAyMzo0MTozNCBBcG90aGVvc2lzIGtlcm5lbDogd2xwOHMwOiBhc3NvY2lhdGVk
CgqhqgpDb3VsZCBzb21lb25lIGFkdmlzZSB3aGV0aGVyIHRoaXMgaXMgYSBrbm93biBpc3N1ZSBp
biB0aGUgcnR3ODkgZHJpdmVyPyBBcmUgdGhlcmUgYWRkaXRpb25hbCBkZWJ1ZyBzdHVmZiBJIHNo
b3VsZCB0ZXN0PyBIYXBweSB0byBwcm92aWRlIG1vcmUgbG9ncyBpZiBuZWVkZWQuCgpUaGFua3Mg
aW4gYWR2YW5jZSBmb3IgYW55IGd1aWRhbmNlLgoKoaoKWmhlbmd5dSBTaGkKZXRoZXJuZXQvUENJ
IElEczogUmVhbHRlayBSVEw4ODUxQkUgKGI4NTEpIG9uIEF6dXJlV2F2ZSA2MTEwCkFyY2ggTGlu
dXggNi4xNC40LWFyY2gxLTEKRW1haWw6IHpoZW5neXVzaGlAZ2xvYmFsLnRlbmNlbnQuY29t

