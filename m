Return-Path: <linux-wireless+bounces-24803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16344AF84CF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 02:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766D11C83C6E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 00:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52E35977;
	Fri,  4 Jul 2025 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="TpaPV9c4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023118.outbound.protection.outlook.com [40.107.159.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC63595D
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751588751; cv=fail; b=ltzFaKp7wXeqnBkh7vo+RZUmOMCSq98so0wr+KjhiUhCWFGKjeCh099E/a5Q1pfWOfp3OB4qk256nuSbYuKVyWo5veSZHx9kDMREgEQLh5nxkmusc702qFgrEBzXm0aRAeRaGMxqKhiMoDp1gRblqIwepd7Me9ec9SCtli+kblk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751588751; c=relaxed/simple;
	bh=kH+Fhur2iP9xinv+n8+g2OYnNs/1L5/THUZ2AYkm1gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3+5Z7TqDD6H4FbduBt4DNCh/XrkcO2skCU6y4EHaSvzTsHq/uW5Yy5Xy1PCFfVRS78K1nBAmsZW0rEZMOt5mkXlYpoZiK3z3cKlJKJXOfxHbZuoNYBe+kV84TBroJ9YkmyGpEijXSMI44MS3VES1TvrwjJSJpxS48TAE/uuTLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuleuven.be; spf=pass smtp.mailfrom=kuleuven.be; dkim=pass (1024-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=TpaPV9c4; arc=fail smtp.client-ip=40.107.159.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTNxmdaX6ZZwzp7+IbIqkX9JN8FoeC4E2ftnyA7a21lvOG4Gq5UOJrZ+QZKeXKryTYKSyEf1EraconOFra6EW3+/vm7A6Hjl70E9ugV2PBpU2QQg0tqTsHf+6hZ1S3xzwped5RJ0936E+6xsrfu6Yd57msvt0pAoKD/hyU5H7CGeTdv2Wm1KzUnnf8WDYYk5QppebByh6/EnuZ25ljZkBrHWq2m1izVTZc3cw2020Wg1OAFLGdFvtq9vCG1cHHZC/ZIZIJkMBZT74BjrLLrc7TMdMW2GAo+L9ES16R27oNKbZNNR7WMtQ3mayVNC+4DTk/Vu0nQA9J9IgSj/MzxPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BBQWqghehrnAjrJJdiP3K3ADekAZp/6OClwbW5larQ=;
 b=o7Kjz/2ejmb3EnXFmJepaUp7dZauzr3eIPkXqMJ5ofjxQoVbLC2ZgFmjePjFP+KE6SzO4qeGWJqvynJRLuSt30KA/APCp79+PF+YY6MOlhuKCG0hHUTcVYmtFmqzfAeVaCJuiLpYdx2EsZCnQRLSzZnDknGXTH6+ix+Bd/TFQseypJJe8TUft9e9mDSO6SbWSc7U8Hsqexqi2paZ9K5nXVnlvet7fo4Xp++CA6gSN1IRtXERI03kjnxtVSX4lBN9Hx5mG7Anq3UghkOuGCXx98jR7XE5hxsqQbVXHqiTLQ+Tkye98M1/igvImlnjT5BCPyy9+v4wqlqjpUnqFMhpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BBQWqghehrnAjrJJdiP3K3ADekAZp/6OClwbW5larQ=;
 b=TpaPV9c4tpaPWp7Yo20TMfcE0zXXHis5zy57kvLLvUPfdzRheKEMQ8uSYxgE66xKe0ZKPW5CZdC4SHMXVCFv7UbUwYKxiQoskWgGrwU2O/AEPbgWk3m0asnMx2RGttiPCZlQTf8ax7W1ZfHK4HJSe5QUu017hY0nQp0G8//aJVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from AS8PR08MB9768.eurprd08.prod.outlook.com (2603:10a6:20b:613::21)
 by GV1PR08MB8132.eurprd08.prod.outlook.com (2603:10a6:150:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Fri, 4 Jul
 2025 00:25:41 +0000
Received: from AS8PR08MB9768.eurprd08.prod.outlook.com
 ([fe80::2b46:d268:abe9:b0e9]) by AS8PR08MB9768.eurprd08.prod.outlook.com
 ([fe80::2b46:d268:abe9:b0e9%4]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 00:25:41 +0000
Message-ID: <ae8b089d-5963-4d49-92e6-458a368dcac7@kuleuven.be>
Date: Fri, 4 Jul 2025 02:25:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: prevent A-MSDU attacks in mesh networks
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
References: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
 <b62bf1d140eaebe6dbc75e83541fe45347c8e6bf.camel@sipsolutions.net>
 <f7729305-1345-405b-a5f9-671213057a16@kuleuven.be>
 <fec2006bf674b7be32e98acfccea295c581e079e.camel@sipsolutions.net>
Content-Language: en-US
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Autocrypt: addr=Mathy.Vanhoef@kuleuven.be; keydata=
 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
In-Reply-To: <fec2006bf674b7be32e98acfccea295c581e079e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To AS8PR08MB9768.eurprd08.prod.outlook.com
 (2603:10a6:20b:613::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB9768:EE_|GV1PR08MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 119e687d-a1f9-4fae-9b67-08ddba914ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDJtWHpkSmZrSGR1OXEyb0RrdEYzN090N0cvL1ZPRGpWejNZL2RGWGR0ZWg1?=
 =?utf-8?B?eWgraHdjcjVnV3pvRHowTWUzb2FjSjBXSHUweWcxd2xJdUx5UFg5WkFVdXNY?=
 =?utf-8?B?MXNpQTgwc1ltUGdXQVhpdzd6Qzk0Tktsc00yYjNvWTY3ZGtxUG5vbXdDSjY3?=
 =?utf-8?B?aTAxVlB2NnFraGpRck1VUmxPZ2U5N0VHWkFoVlFEbDVNTGxndVU5ZmRCak05?=
 =?utf-8?B?MUxWTHdVK1hIRm5DSkZtVDBOckpJQlVoY0M5aWFBdTducjgzaGwvVjhUdkg5?=
 =?utf-8?B?Q1F3VjRKWVZBcWlnMWFnV0FqVUhxNjB6aWNLUnZjaGVRMDcrRWl2UjkvNmNX?=
 =?utf-8?B?Z1FzYkpjaEN4Q0ZuaS9VRUJKMkNJL0d1eGo5ODE3dDFmYlJyTGV2OThoSHB4?=
 =?utf-8?B?MHlmcmN5MEEwQWI0THR1dDVpN2Z5ZTdnZ2d1bmpZM2RDL0g1MjJqWW1YaUVy?=
 =?utf-8?B?a2ZWQ2FqTXJqa1N1cjVHdE9IR1ZaZ0wvTWhoWW4xNmlhQXhZSjJmOWdDT0JT?=
 =?utf-8?B?b0k0L1VQNXN1ZkVORGFldGJmZXh2VEs4cUVVUFRTdGhscElOekdVUm5sMFNa?=
 =?utf-8?B?alcvUDRnUEtwVXQrTTB5N0dZNXk5d0E4czFLaXB0MDJUZ1dBTGFGQ1BNVDdR?=
 =?utf-8?B?SHZmUkY5RlNrbmhTZUkrNHgxa1Z4MVZGb1piMU4waTdLUjVncG9la1NHNktS?=
 =?utf-8?B?YVFWTzQ0ck0xcktPdlYwRyt2T1Jvd2Q0M2JoUWUvTEZhdmlONW9pQnBMWTU2?=
 =?utf-8?B?YVVXTHprVkZYN01ET0RvVDZjMDRiMEVPbVZqTmtiVTJvemRXSG12aENsdWRH?=
 =?utf-8?B?bk11b2YxbkJDSHZINkJqMWJBcE5UME13RXhHc3V5R0lzVUNLNWNycmNiTUNU?=
 =?utf-8?B?UUN6Z0ZaR0liMzNLWW1ad3FlWlYxQkRDVDlOMzduaW5EdFE5MXVDVjJqWisx?=
 =?utf-8?B?WTh4YkY4amgrUFVrOHAySnNDUzdmbUZKV1hWV0t4NEhpcHp1b3U0WVpwYk0x?=
 =?utf-8?B?d3FtSkU3cGRFd2hNSkNocFZ6UzFoaVhTYWR3RUVSUCt3R0lXMEZLMmhlQUFj?=
 =?utf-8?B?RnlOdDU5UENNTWc5ME1xN3Z0ek5Bb3RJNENsanBSMlAvRERnamNJdzM2Zi9r?=
 =?utf-8?B?d2hzUUpjRWpudk4wUXdzUllUQmsyODJ6WmpIUWg5UENMOTRoaHRUWGI3Y0xn?=
 =?utf-8?B?ankwZ2tVa0dYUE5Ja3ZoN2FFMFk2UG1qZ1dxajRSWHMzSHMvUHRyblRzM3l5?=
 =?utf-8?B?OEZ6N081VUwxa2Jmd2RsTjVvTFdlQmptWTNmSG1yZW5kWHgzTDBhclZDODV4?=
 =?utf-8?B?MUtzSi9BWTRWeGxnNm9BWTZreHBGc0E5VVo4SVdYc28rM0RHMmhRaWFMc3ZJ?=
 =?utf-8?B?U3ZWZHFjdWd4YU1FVndDZEt0U3NaVU1YWnRVRVRDMFRQRDNTT0xvS3k4UlJ1?=
 =?utf-8?B?Q0s3V3VCREtxdVFGQU01QzJKa0ZPQTJxK285R2pGSU1PditGVVpzc1NUUThD?=
 =?utf-8?B?N1ZWWjRFNXVTemMzVlZKYzZEdlBNNWt2YjBvVjh6RWp6UVUwWmVQUGhxUHVK?=
 =?utf-8?B?SzhEVVYzZjB4YVdGYjF1ZXUxNHN5SUxrb1JNRG1vTmNZREVtU0YzRVl5cFVI?=
 =?utf-8?B?UjNZWUs0TlNLenFYeTQwVHh0RDgwc251SWtwSDRpdjF0VUR4YnBWbHp1ZEpD?=
 =?utf-8?B?WXIxWk9VVUJnUHl1a0dMSkNBbEFHbFgxQTVOMGlkUW90TFREMEIzZzBtVGJS?=
 =?utf-8?B?Y3JKM1BPN092c2ZqK3VWTy9xdnprbWZSMFpMbHlmUE9FK1hhbDg1V1FuNHlV?=
 =?utf-8?B?MEwzQ0NOZGl5TnY0VnIzWU5OZzFNL2VDQ0R5THZHRXBuZ0hNdlRvamNFYVZv?=
 =?utf-8?B?UkdONXVuUTNoRlhQSVBTK0pBY0dySE8xbmlraFI0Q2xhU2lCY3loTHgwYnh4?=
 =?utf-8?Q?vGLyZU7o194=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9768.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmJiN1cvdFJsTnJDY1E0OHU4WXpYemNCSzBreTZITXdnc2g3RXEvL0JDWU10?=
 =?utf-8?B?T1B2RVBrV1kxcTgrMGFNSVovVWJHQU12RFJRN1RrK2ZUVTg3QXQ1dzNDUk1G?=
 =?utf-8?B?ZDlpT3Q1VTBmd2E5Njk5ZmVsQ1lyQS8wVFVGeWd2QWdRbGdGcm95K0dNMDU5?=
 =?utf-8?B?TTZyc24zSVh3MTh1ZXlRTTBLeXBKbmQ4MGlFWXFVck1IVzhXV2F2TDFreWlv?=
 =?utf-8?B?emhFTlFzbGxTcjJnVjdlZXpCeU9GUHhmNHFjckpOc05sWDIzQW5KYnc3YkM3?=
 =?utf-8?B?TVB4N2VUZzBrSmt0NEQzaXQyOTNxYWE1SjJvcDhKdExJNjdxaCtFNUhDbWIr?=
 =?utf-8?B?T2h3SHJTb2gzWW1LaGlJTGp4MjhwRDk2UkZBdEs1UDFDM2xTT09GVFRDc2w4?=
 =?utf-8?B?b1RwclVEY2NndTVGY0V0WWFtdUFGRmd5dWpVY2VwNG0xNitWV2htYVZvMjN0?=
 =?utf-8?B?N2I1bEVnS2ZzU3RyM0JScVVkZGNqNHZXVi9SVEpnOVF2blc0UlcraWFyKzRk?=
 =?utf-8?B?K0U2VWk3TDVMbzBSWmxPb0t5NFVGL3lwQWlYT05xSXpZVVE2OTI1Mi9iTUhm?=
 =?utf-8?B?MWFmWlh4QTN4YktXeUdaUEFLU1VkelNHWm5Nd2ZWRkZGeHpNT2szNWdzZVZv?=
 =?utf-8?B?amMxRFJLMFhYVFhFYkEyVWhnUUE0SFFSYy9PSDVEV0lkbi9IcXpPeUtoVzIw?=
 =?utf-8?B?RVNaVWFldDNyN2QzbmxBK1pOKzMwM0dWNXJCOVc5WXY0TzRMRlF3SGlMaExm?=
 =?utf-8?B?a1VoYWRrN2pxRjNZekN1VCtHUGhQanQzUGovSkVEMnI2WnJNMjNxZElyTDlq?=
 =?utf-8?B?VzN5MVNIZjZuZGJZc05zWVU0d0VxcEo0d2FpT01VMW1lYU1RKzFUSEQ1NnJh?=
 =?utf-8?B?VlliWlQ0eDdXOG8wQ1J3ZXNwR2hWTnNab2I2bUllNkpTZGF5bVpwZXlUUU5U?=
 =?utf-8?B?R3Vwb3FlWUdvaGpSQTd4cHpuemlpTy93Z3BqME5ZeWFVMzJCcDlUdTZGV1pQ?=
 =?utf-8?B?alpKd3ovam9UWVhwdGF0OStDMjVrZWtSeFQ5UHpXTGFBdGxVSjRrNmE5RDEr?=
 =?utf-8?B?TVJ3ZjVWTnNhMHZvcHZ4NXQyemltOUQ4Vm53Y1U4dXM5R1NFaDh6UFlRVDlj?=
 =?utf-8?B?K29QZk9QYVpNUFNTK3liN05rK09HdjZOblQ3cmNvaVZLaW1oU1Zzd05WSVFi?=
 =?utf-8?B?bUM5SVhPdFhoSXgxck5CT0l0dTRqNWQxK3Y3YVJDc1J1dEMvdWhxMm9KYlBN?=
 =?utf-8?B?alBQYjlNc0twckp2VE4xTUgycjJPNndnR0pIS2l0cUFUck5qM1hTZHNGdytE?=
 =?utf-8?B?OWR5dXgzOWJ6TktCT3RtSkUzVGhNUFI3MjdEdStTVWQwMVdVODY1cVVJS29K?=
 =?utf-8?B?T3F5VGNGUjVTS0VQSGREcDJBakEvR09ra0JWR0ZxTXNWU20yUmYzSU14cHNp?=
 =?utf-8?B?VWtxbmlOWUlwZTJzMldvN2o4dlRDUE55VDQ0YUZUYjc4bFN5bFRvTjZrRTgw?=
 =?utf-8?B?S2w5K3RvNUdKYkNlUWhnOGxJRFUwcWlBc3EvMXpzNEhoVXNmRzFFcWVzWE42?=
 =?utf-8?B?YWlxdWNKOVdzb2lwblI2TldXM0Y5NGdmdFRmSC81UFFSYWNpMks5NjFWbmI5?=
 =?utf-8?B?eThhK3IzeFUyZkYwU3cxYlVDNEMreFFsamFhU3k3akVzR3h5WDcvU0RxVGhU?=
 =?utf-8?B?V3VjaGlYZU9VUk1YOHRKNFJqQmRHeTFXdzBvblJ2R0VhZ2pVQnFsRUx1NTVF?=
 =?utf-8?B?Q3YzSFRLcnczOGoxTlFPNUs0bGhwaHpMSkxabVRPZ1dIWXFIcVpPeDhMc252?=
 =?utf-8?B?Y0VVRVc2bWxBd2JRYWNtcWxEcmVabU40S0UrSWxCVmpUUlo2blhZYmpEL0Va?=
 =?utf-8?B?UU04bVFFbC93QzdQUElzMmdDM0xPVEpwSUhra0xRTjJWbk9hYU1iTVlkTjB0?=
 =?utf-8?B?M2FEWGZva0hUd0VCZ2VqSHIrblh3cVZOTUc0NG91NWNoUGF0L1VkT2tMeHY1?=
 =?utf-8?B?R2dsUWJZaVY4VDBxQS9CWjNvK1BqUFhIc0ppQ1pSbjZoYVFxY1NMWHNkK3Nj?=
 =?utf-8?B?MUUvNE52SG9wcU5WWk5ObjZJWmt0NStHTVl2K1JIYzcvZ0RibUVMc0kyME1h?=
 =?utf-8?B?RkdlR21mM1FpYWlhNGVXUTVTcmE2TXlhVHE5QXFGZy9FNkJtcU5aNE5JSUg3?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 119e687d-a1f9-4fae-9b67-08ddba914ecb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB9768.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 00:25:41.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROWOercWeqSzlFqSuPJQVOSXuzzDY9clH27roe2EtvvQ/33x7EbFxWQ/mYQPGhctqXr2kceiaBtXZ5BOxHBmJdye5Lz6yVZSTS+BcaBP5Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8132

Hello,

Looking back at this, the added function could have indeed used extra 
documentation, since this is a special case. Others trying to understand 
this function will likely have the same questions otherwise. A first 
suggestion as a comment to add is the following:

/*
  * Detects if an MSDU frame was maliciously converted into an A-MSDU
  * frame by an adversary. This is done by parsing the received frame
  * as if it were a regular MSDU, even though the A-MSDU flag is set.
  *
  * For non-mesh interfaces, detection involves checking whether the
  * payload, when interpreted as an MSDU, begins with a valid RFC1042
  * header. This is done by comparing the A-MSDU subheader's destination
  * address to the start of the RFC1042 header.
  *
  * For mesh interfaces, the MSDU includes a 6-byte Mesh Control field
  * and an optional variable-length Mesh Address Extension field before
  * the RFC1042 header. The position of the RFC1042 header must therefore
  * be calculated based on the mesh header length.
  *
  * Since this function intentionally parses an A-MSDU frame as an MSDU,
  * it only assumes that the A-MSDU subframe header is present, and
  * beyond this it performs its own bounds checks under the assumption
  * that the frame is instead parsed as a non-aggregated MSDU.
  */

It's a longer comment, but has the most important info, you can see what 
makes sense to add/remove. Let me know if you want me to resubmit a 
patch or whether you can include this directly.

Best regards,
Mathy

On 6/24/25 10:10, Johannes Berg wrote:
> Hi,
> 
> Uh, sorry, looks like I dropped the ball on this.
> 
> On Mon, 2025-06-16 at 18:19 +0200, Mathy Vanhoef wrote:
>> On 6/16/25 13:27, Johannes Berg wrote:
>>>
>>>> +static bool
>>>> +is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
>>>> +			    enum nl80211_iftype iftype)
>>>> +{
>>>> +	int offset;
>>>> +
>>>> +	/* Non-mesh case can be directly compared */
>>>> +	if (iftype != NL80211_IFTYPE_MESH_POINT)
>>>> +		return ether_addr_equal(eth->h_dest, rfc1042_header);
>>>> +
>>>> +	offset = __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
>>>
>>> This seems awkward? Not only was this calculated by the caller before:
>>>
>>>                   if (iftype == NL80211_IFTYPE_MESH_POINT)
>>>                           mesh_len = __ieee80211_get_mesh_hdrlen(hdr.flags);
>>>
>>> but also h_dest[0] is just taking advantage of the aliasing when we
>>> already had a union in the caller to avoid exactly that.
>>
>> Here hdr.flags is not an alias of h_dest[0].
> 
> Huh, indeed, I misread the struct as a union.
> 
>> The caller is parsing the frame as an A-MSDU, and because of that, the
>> caller assumes that the Mesh Control header starts after the A-MSDU
>> subframe header, i.e., after the `struct ethhdr`.
>>
>> The added function is_amsdu_aggregation_attack is instead treating the
>> frame as if it were an MSDU, to detect if an attacker flipped the
>> "is-AMSDU" flag of an MSDU frame. For mesh networks, the MSDU
>> immediately starts with the Mesh Control header.
>>
>> So the caller is passing the byte at offset 14 as argument to
>> __ieee80211_get_mesh_hdrlen while the added function is passing the byte
>> at offset 0 as an argument to __ieee80211_get_mesh_hdrlen.
> 
> Right.
> 
>>> We could just pass 'mesh_len' or hdr.flags from the caller? I'd prefer
>>> mesh_len, and perhaps also changing the code to pass mesh_len to
>>> ieee80211_amsdu_subframe_length() instead of recalculating it, since
>>> it's not obvious (without looking into that) right now that we even
>>> check for the necessary length of the frame.
>>>
>>>> +	if (offset == 6) {
>>>> +		/* Mesh case with empty address extension field */
>>>> +		return ether_addr_equal(eth->h_source, rfc1042_header);
>>>> +	} else if (offset + ETH_ALEN <= skb->len) {
>>>
>>> And it looks like you didn't really understand that either, or am I
>>> completely confused? I don't see how this test could ever fail:
>>
>> Those checks are largely irrelevant. The caller performs those length
>> checks based on an A-MSDU while the added function parses the frame as
>> an MSDU. This means the caller is checking a different (optional) Mesh
>> Address Extension header length.
> 
> Ah, so the caller check could've resulted in no AE flags (6 bytes) and
> the other one 18 bytes, which is a large enough difference that we _do_
> need to check explicitly I guess.
> 
>>> We previously have
>>>
>>>                   len = ieee80211_amsdu_subframe_length(&hdr.eth.h_proto, hdr.flags,
>>>                                                         mesh_control);
>>>                   subframe_len = sizeof(struct ethhdr) + len;
>>>                   padding = (4 - subframe_len) & 0x3;
>>>
>>>                   /* the last MSDU has no padding */
>>>                   if (subframe_len > remaining)
>>>                           goto purge;
>>>
>>> where 'len' includes __ieee80211_get_mesh_hdrlen() if the mesh_control
>>> is non-zero (where admittedly it's a bit messy to have different kinds
>>> of checks for mesh - iftype and mesh_control), so we definitely have a
>>> full ethhdr after the 'offset' you calculated?
>>
>> Is there really a *guarantee* that mesh_control is non-zero? A
>> misbehaving mesh client could still be sending frames such that
>> __ieee80211_rx_h_amsdu will set amsdu_mesh_control to zero, even though
>> its iftype is a mesh client.
> 
> Yeah, there should be, but I agree it's a mess now.
> 
>>   From what I see, this code in the caller guarantees space for the
>> following bytes:
>> - sizeof(struct ethhdr): 6+6+2 bytes A-MSDU subframe header
>> - ieee80211_amsdu_subframe_length: can return zero
>> - padding: presence of enough padding is not yet checked
>> That's 14 bytes that are guaranteed to be there when calling the
>> function is_amsdu_aggregation_attack.
>>
>> Note that the earlier check `if (copy_len > remaining)` actually
>> guarantees 15 bytes to be present.
>>
>> Then is_amsdu_aggregation_attack needs the following to be present:
>> - Mesh Control field and Mesh Address Extension field with a combined
>> length equal to 'offset'
>> - The first 6 bytes of the LCC/SNAP header (when treating the frame as
>> an MSDU)
>> When 'offset' is 6 this means we know there is enough space. But when
>> offset > 6 there has to be a length check.
> 
> Right.
> 
>> I'd actually be inclined to just always perform this length check for
>> mesh clients in is_amsdu_aggregation_attack, since this function is
>> parsing the frame as an MSDU instead, and because it's too easy to make
>> a mistake in these length checks (either now or in the future, e.g., if
>> the caller code ever changes).
> 
> Makes sense.
> 
>>> Or maybe it should just not be separated out into a new function, then
>>> it might be easier to see that indeed the length check isn't necessary,
>>> and also easier to reuse the mesh_len.
>>
>> I'd still be inclined to keep it a different function. The new function
>> is parsing the frame as an MSDU instead, to detect a possible attack.
>> Perhaps a comment can be added that this function is now treating the
>> frame as an MSDU instead.
> 
> Yeah, I'll add something.
> 
>>> In fact, given that mesh_len==0 for non-mesh, doesn't that make the
>>> change at least theoretically simply collapse down to pulling 6 bytes at
>>> mesh_len offset and comparing those? In practice probably better to
>>> compare against the already-pulled bytes if mesh_len==0, but that'd also
>>> be simpler to understand as a check?
>>
>> In non-mesh networks the check is indeed much easier. The existing code
>> always assumed non-mesh networks and did a comparison against the
>> already-pulled bytes. This comparison against the already-pulled bytes
>> is still present at the start of is_amsdu_aggregation_attack
>>
> 
> Right.
> 
> johannes


