Return-Path: <linux-wireless+bounces-32957-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGRUAc4SsWkZqgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32957-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:59:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC425D1E1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F6D30FC412
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835121FF38;
	Wed, 11 Mar 2026 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="N6viWSfB";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="XT3gVb/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2141EDA0F;
	Wed, 11 Mar 2026 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212363; cv=fail; b=gpX+fBlrhtw1epK4QfIiR8jpHnAeEZdkKnqs8OlodWZkTQKIdIemvlj0ppinAEiNily/0f9mJrBuun5IBYM9AEOTCwTZdWKtekIykseXsx8/pAg1L08WhSV9w+KpevI4ogHOoT6zsraJ63xtornVrZDh+8yf1EtP2x51+joN1t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212363; c=relaxed/simple;
	bh=X4ClUBlp7+Ayv1+EAmpDX/rpArOXvOdK7GypAte/Sqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAer/83STUpSK7MKJq3EvqZZyVYM95Kwg9G013bf0oI//Y4pDXd4vmLH4nb1hJWiMwLIutwkAKca0lwl/1qtnetWL5pmJ8ZUJn1lxZLRBDY2YaIh+VOF/qZw9pp8LvcabJNRcaD/qVpvBwjEY/k09mpbiirg1fKYWv0rkxrpvR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=N6viWSfB; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=XT3gVb/D; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B509Zj1115727;
	Wed, 11 Mar 2026 07:58:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	vt0fuotzFD7M6TOs4stw6PIQgRS1llRblJuI64iZfcg=; b=N6viWSfB401mTC8Y
	whYQshlrw+bHvMRNp0aps/pcdq6s4C0mBiBac++3creFQ3aDtjpHW3ewAinsRppg
	UyFcOTuixj9RZ8x1/1Y/zPbWSixuN+iVmHqPyQnBGMgLg2A+ljFR/+zeaNYQUbx7
	G1xfKK/XRAn+hn8rneLcczbDf0gR1XB1V/aeyRWeiTJD3Gnd04Kv7TgafwGXQD4n
	Sb0e1GInDdybowXMgw24+FHOnvI35wu6itP4mLpc5GgwmqhV+haC1g94va/nDKzW
	IuW9UEPBiupRYlpiTsNOwNBqnQUqj4lNXZJuU3wBFyQ4Qm/dHPmE8ocUxkcBuztE
	ImqvUA==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020097.outbound.protection.outlook.com [52.101.84.97])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4ctxy4g6r0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 07:58:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVDKzrnijS7VPPC3EERTIeIgHE6a9ztbOe7dSCXLeNdi/ePIOjWYDqGDW+rlrOJJlkNjCISqbbr7NOb/eh2/Dqn9U/U0MPjP3MEZd9JTCy57xohFg0OLonYVqXFcxPKro8ZUAHvRX1YJoKihGrZSK82ISV8fWGuRYC6aDrCzoEEAnrcMVMwRSRLObd1iBZG96vmziScojBOnKqdRGXl5EOb8N1JEWdhV8xyjuOjjiiT2BC7OKdxvge4KB5q544QjOk3AP3yJ0S/WI2nrndIIZodQjvd9M09Wti5SsaEC2UqMcf55XE1HvMK0qZesWQSovdF0e5ag2iP7QoCsDLeRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt0fuotzFD7M6TOs4stw6PIQgRS1llRblJuI64iZfcg=;
 b=ZLEVw53v7+nVU7Ae4+WHrbGCnDVppE+B5gGOl61ZwIsVvoyHHkbxlk8/vTtBZ5uyAq07/kneqyVzB9YE37EtEZWYNt7pSladev2cnsZfslGbini2mjkh+PocCvlDu6rmBbgSHqR3grTUFbZqamHrFt//jUsQkGolsMypJ/fa9A6cVRNdciJvvAmiVaDT0GOTDFd2kg9/8bCdTXHBPdJcvjkVQRkfDNUmCfieOTKRT7yOUa9F8BAuwREvvIp73PYFuqzbkih1m1YFecH2SyTHv5jnU0cAcU3GCTvIuXQHpeGV2SpWA7Y20Zd8hGIGFeU+IMLLZv2E3xspeKprHBnN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt0fuotzFD7M6TOs4stw6PIQgRS1llRblJuI64iZfcg=;
 b=XT3gVb/DWge2rNII9QhvTXj8kNX06SuQ/w1Nvhi7hIc3OZQorlqJoTCnkCxlWeYYKbypoxRQc4RMI3q7uJ9Rja9jKYTs20E5+3bDn9fUVt8ygpv5Cc0b1qa5DrqF6WMVz8+1Vm+1WVbM95luJ37MZ/zCNyRfIG7vw4U2z0gQmZ4=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AS1P192MB1592.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:58:54 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9678.020; Wed, 11 Mar 2026
 06:58:53 +0000
Date: Wed, 11 Mar 2026 07:58:50 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
Message-ID: <abESqgbpr3wt1_14@FUE-ALEWI-WINX>
References: <20260119073923.764245-1-alexander.wilhelm@westermo.com>
 <8aaacbb2-8ce6-42b4-923d-78491df6d31a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aaacbb2-8ce6-42b4-923d-78491df6d31a@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF0001DBBA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6fa) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AS1P192MB1592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5663a8cf-325e-48b7-1b64-08de7f3ba7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rR6Y/T0P/SPBPhrgS+7mIAJ8wXYvY9+OG/A2NNgHJkmHo2up2TVqsWfAE9znsGRUUKyP7QGbjOE9FyABjajRxYm/lSa+eYiQQ5GzGzFYraUxH9KRlgcA4eLSMzD86Rj+ZnC2xE2x+BWW1TLtVmoTXXXZd4TpgJlYLW6ck2dBFPqOE2+tQtjWGzw1S2Ri28hwq8WHNLzGGMZomeR2Xq1WGOxcU4UQ9HvikEYXY60IiP7UCKEZPOZOLUj7YSAZrGG8ECG57Z1hQEsRf1RNnjrNtt5fVTTPpHsp9BMOAw47+j15RdztNg9h1HtgVUZeLPO53Yn+O7qR6j7qJ1l9lcQN8AWKE0akprnufzxel2A/5l9ZOnpQRjw3xmYFIJHacWGKipsRS6aopbjTVNeJEg5kctVVjhz/JzkkRhC/3N2ySHMkF0lDALMDoSNY15VtyLA5lOjniaB4PSy1Geh5cXIaHVy96uAzT7fNqDDqa2AWUVAYNdO6mfaG2oltB/xynj31UUP7orhPeadCSbE6MD4ymsPxSHW9Yf5X8zJfc3P2P8eAQz2mcL4VintOw83Rd2wV9/Qebcg6fxwjaRJ/9tFAMrdxgOdtK9biGZI7zOfKPAxAB4Dzv/Dg+hMz9BWOcF8/vnha4zY9hyVLIgqd9wloCPY9rLA16Sj1FZ8rNw20hTO7tUZ5KZspRPsJK3OyM2eS6IIposxS6PWo9GTmln8FRUY91mrLJOVnyhnIqttlw9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGRTZFFneG0rbGVCUXRtTmJlMTBoTHM0b25uL0puWFc4ZnlLOW5QOEpuNTEz?=
 =?utf-8?B?ek5QU1VGc1ExVnlpSmNTSENGMFpiMnBGbHZoVkJpT3RoR005L092NU12c2Vx?=
 =?utf-8?B?SG9GYWNpaC8xbkJ4YmpoeHVZazloYldFemlIVFkyL1BOeTdzMGdGb0VEeFZj?=
 =?utf-8?B?UTlESDhWOXNJaGdKMkF6eVBCV3BoSzd4eHF5T05UQ1dubk41L0I4eDF5S09T?=
 =?utf-8?B?UWNrWDhiU3F3ZzgyL2JjWlM1VGZ0WG51a2s1VXlKVUNLc2VTZVZ1WFVoa3lV?=
 =?utf-8?B?Q25GWUR0TStRd3o0UnprRHE5NTIrajJ5dG5pZ0xndWZBSVprV2ZuVmg5NHlJ?=
 =?utf-8?B?SDFLSmNmRmczMGdEa0ExOGY4MDUxRkNneXd2SitiVi9SRWVraUxIMDhxYU0w?=
 =?utf-8?B?RTU5U1dwNWMrRlQ1RW9QQzBMNWc4WTRNb0lhM2VMZ1BIcXltQmhxTFBmMUZ6?=
 =?utf-8?B?YVZyMzZEMUlMb05jOWsySGljbXFWS1ZjR0xBYWh0YkRBNzFOUklkMmxTM1kv?=
 =?utf-8?B?Wm5zdlRMNjZWajRjWnVzR2hvVWRWNE1jYmZmOHpUeTJJM244RHJnUDczUjE5?=
 =?utf-8?B?anF1WDV1cnNKSWtobUYwU3RNN2RHLzBuRW53bm5EOStabWQyUno2RW85dzRN?=
 =?utf-8?B?ZGpxaXR5dHRpOVBuTEQ5NXd5ZEk0UE8xWEF4YStxek8xc3RFYi9VMko3bkR2?=
 =?utf-8?B?bnNmK3VPeTJhTm8zV1VZZGZxaitSOUdMOHg4Y0VTa3podDQ4cWgxbnRYbk5F?=
 =?utf-8?B?Rmc4WDZweW9zemRDM09oS1pFbVhrSnhkUE04UGFZanVhU0tCOFRaRGpzRmlm?=
 =?utf-8?B?Mk03dllFdk1FMDgxMDRTMmMrTkpYT1gxdUNHWXBONlkra1JSSWNoTzlMeU1K?=
 =?utf-8?B?WllTaEdtcDFxcjRtWHpJcVJNNHNkVTZvWTVHd2M0c1B0NjhSdWRaVTZrcGM4?=
 =?utf-8?B?N2dyeDFhOTdSb1F3dkNzSjdjRnJtbGRWL1F2U2QrNm9pL0FhZThBWXUzcFRT?=
 =?utf-8?B?NFlwNzl2SVo0alYzR2F3NVMybDVFUDZZVVR2QUx0MGVNZGpHUzFqdysrbnYv?=
 =?utf-8?B?bjhEZFJodlcxWlp5NTJGeDFKbVZ4SDVWRVV0cGd0dWFzbmptWWJtaE9FMm50?=
 =?utf-8?B?R0cwSzBhWGRXcHdmQmpoWGcvaE9PZjZIOWNmRVdsM3llUGxWaGNiOUZ4bjJa?=
 =?utf-8?B?c0EzNElKdk15NXRDUEdjZW1UK2tqQ001Wm8wRWM3YTVha3dxRU1TR3E5dlVG?=
 =?utf-8?B?RUxYUFFhUUxBS0VXb3pJUWNaMU9ZdWlGa3JvZlpETjlJRmlPSklBTDZKcTV4?=
 =?utf-8?B?WUFhNkczSmFRcWUzRitvcXRPbUxNcU4weGZvYk1reXF0YzlYdDR3dktESGgr?=
 =?utf-8?B?VmV2ZGdVcERWR2QzTmxjUEkzUnBEeUlGcXM5UEE4ZTJsaVdVVk1FR04vMU1j?=
 =?utf-8?B?RXlmcnliOU9nZCswQ2tyRVlvU2NUandSNzVucFBtRk9QZkdoTWFHV3RXSWZU?=
 =?utf-8?B?OGlldFFaTHQ2d3c3eHBhSHhGVVRnWEVsM3oyODVzLzR6cCs5NnNPKzdwTnQ0?=
 =?utf-8?B?dnYzUEhvL3VJNlA5OTlvdTlKV0wzMEUveWdQSzh5MmV2Tk03aWI2WjROM3pj?=
 =?utf-8?B?OXFRNzAyQ3RrRTV6NVFFTEx2R0t0eG5ya1Iwa29tR3hyUGg0SDBHZEFWQXZL?=
 =?utf-8?B?Q3VFcStONFk5a0F4SnMvNVZoVU1EenE0MXZZUUZrekhrZ29iUTYwcGZqbGp6?=
 =?utf-8?B?cUJQdVZIODZEOTZBbXloa2pMRUpYK25sanRaYUhreldjczlVYk1TaXRjck5U?=
 =?utf-8?B?ZXRmWmc5bXlCTk16SlcyckphRGZaMXJadVRaSERXMXFKM1BXejlhbHhHTjgw?=
 =?utf-8?B?b0tid2xFc2pJNWErL3EvZ0kzNUxGYUYzSmxrcThsbmNEQzViK1ZFRE5zb2Rv?=
 =?utf-8?B?TnZ3LzUvdWt2RWYxUmFlNkRsTUNtRmo4U3lFUGFnVGVzL0tYcUswWGZXTldI?=
 =?utf-8?B?WUFZblBPVjZsSzlkUkl2UXJZMVNwT3lqRjh2eS81aU52SE5UaWFJanlVaVIx?=
 =?utf-8?B?TFFtNzR0M3A2L1doQWhxeGRiZnFSYlZDa1EwRzFIR1hFVW1BY1BGZ3c0STB2?=
 =?utf-8?B?Q25GQXo1NG52SVFib24yZGdqdHNkRVYyNmJ6M0ZGZEtvNnlFd1RraDcydDN0?=
 =?utf-8?B?TmJoOUYrdzdSNUxwdFJCM090M05yYjFvaC9lc1VPeHNoY1R3dndtVTM1WTBW?=
 =?utf-8?B?blBSTlRvN3g2NlFIaUZ5c0FwQXdKQlU0a3RBc3hDRHdlVDBGSkxLVWpoakU2?=
 =?utf-8?B?S09ZWm1ZYWdOYnBxN1pzRmVEUjVwdVV4YWx5angzVmFiWVhDd3NFZz09?=
X-Exchange-RoutingPolicyChecked:
	J5lvhnV739Zbtdic/jiZZoS0c6HVYmrtvdKxcHNGEE4ixqGmlSze+Y1nzZTR4uFfHZcb/ni7n/P8KQsuHDfK/vvjsr6hip3ktl29MtCxXMFb0CRS/K/q4io42xBAHXPh7+VxAVdY6qYL/eZsL+Y2IV8MrDkf78d/BIU72puwvJtEV/Of4LQqJZMv+7dgFqK4jOZZ72tOkv8rSkVhs0LLmyhi1KzUu8FA5YwxKUOvbuNWJAyaUOh9oqOgtRPo/CZN/JsvbLage26hJtQ3+7J7itsvmJrDOSEZbXvbm42OPHTXQ6gaRtL1OMAFlDzpfcaFLcPWEbEnEDvu9F0a0Krf2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b127bSsB5rUjoeexMMO/AiA8uqw0XuL4OFTYbyhTAuQlN7O2iyrpmGb7SdKPY430l9wpWHGHmNJEDD0NDGFlbl0OTnPxxLJmugIHegTcxvwhwli1qQ7tvYlbcGd918UZCBWWIrcHLOmWMPvX+ha1omk//G21NuuUsIxs/5th5qZ4PncC2zhG3BH/ucCuoRm1fuwt8rMEnww6L8TYDHmpNFnf87B/WEGnRX3joB2HaLDJn0Qb4QLDrBbTktkyCMALPB09icPaNbarfjT6yeLnwjzrSTMQRmRsd2wnWooJz4oz53S1VlKVF9lYsXLSzPLR01qu/z+f9Vjr7Yj7uKUFPKsaXiG4cBGnmorr7okOe+vr9YqV2uGY2jdn1vb/lNAlyvxySToPxG+pjSXj8VMPkzlteiKb7Ru6I1QBWPotI8Yn9MsvucVR5O4XqHMJTFeFBMrqSvOjvJ/3ThLsIDqkHeqKop3DRhKJEtyhmAWleXbyikIDROAiqIYOCOvmJpeVeVnEz7wnMT/Ux1O3uZZHNuENl6CdyBGzuV6utb5h8rVZXc1ZtJGH9+9Xsza5Z3XMzyiYtoFaI42eIEfU2PBmh72c7zdsW4V4nU3PtwGqW47W3lFD65+BDlPK4bP8IIik
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5663a8cf-325e-48b7-1b64-08de7f3ba7f5
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:58:53.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I52f7V+Pxbnr8KJSQ0c085nZdhACCgMY4kcL2wGZLhDy06Nf/HQEeJfb6NRBRhbk0bFaPppwvG3lV340BDaeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P192MB1592
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AS1P192MB1592.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=deaNHHXe c=1 sm=1 tr=0 ts=69b112b0 cx=c_pps
 a=Tlr9z+0oJFk4eulJi4tZwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=X5vwq--YyQtpY6zdO7wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NyBTYWx0ZWRfX6qpNRhUYUyPJ
 qrS1YREHbxFJQ2mvJ8Ja9Mx1QIfOwqvXWdryWWhsKGTmAvzAyFBgF+VzygdiipFTIHBc1iV8RyK
 3zNmyS7O6z62rjFGkdbsg4I47Ai7khb7tKJSu4lo823G4zGrnfUlU1TBel8O8tFg/50a7LrVULy
 d6Es5NpW28XEV9/r7YzDKgPeEMQzfTtn+w4l37ndlr0tqPPLgzABNaFJxlhV2sY4SOjwONNW+q1
 j9yqbzIst/hNLIksWFQ67t/2QQ87ZzIM37erc6xomVmBNEhvjFqaU1MC/bedMPBDkUw+oIquAfl
 W3IaMsPFoLMOstEwdqsbBJkWQH0sAfGhcKnMSLypv+tp8jxoRd7dMdGfVYgi48T4PgTwD5FPMp1
 SNvU+KaWwuil7OcoYaUKp1LFKqFCTa1WdjCqOz9LqVI8G+c3kgfY2XpWaf4hrZDehRM/begfAeN
 oWj5ipZFuN8XNugwIQA==
X-Proofpoint-ORIG-GUID: cad_41vnFLrLdnIbqRKJvzf1xixMXDXo
X-Proofpoint-GUID: cad_41vnFLrLdnIbqRKJvzf1xixMXDXo
X-Rspamd-Queue-Id: 43BC425D1E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32957-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:dkim,westermo.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:55:37AM -0700, Jeff Johnson wrote:
> On 1/18/2026 11:39 PM, Alexander Wilhelm wrote:
> > The SRNG head and tail ring pointers are stored in device memory as
> > little-endian values. On big-endian systems, direct dereferencing of these
> > pointers leads to incorrect values being read or written, causing ring
> > management issues and potentially breaking data flow.
> > 
> > This patch ensures all accesses to SRNG ring pointers use the appropriate
> > endianness conversions. This affects both read and write paths for source
> > and destination rings, as well as debug output. The changes guarantee
> > correct operation on both little- and big-endian architectures.
> > 
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > ---
> > Changes in v3:
> > - Rebase on latest 'ath' master
> > - Use always 'le32_to_cpu()' macro for conversions
> > 
> > Changes in v2:
> > - Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
> > ---
> >  drivers/net/wireless/ath/ath12k/hal.c | 37 +++++++++++++++------------
> >  drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
> >  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> I really hope to get your changes in.
> 
> With your changes sparse reports:
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:322:50: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:322:50:    expected restricted __le32 [usertype] *hp_addr
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:322:50:    got unsigned int [usertype] *
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:333:50: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:333:50:    expected restricted __le32 [usertype] *tp_addr
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:333:50:    got unsigned int [usertype] *
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:387:42: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:387:42:    expected restricted __le32 [usertype] *tp_addr
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:387:42:    got unsigned int [usertype] *
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:390:42: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:390:42:    expected restricted __le32 [usertype] *hp_addr
> drivers/net/wireless/ath/ath12k/wifi7/hal.c:390:42:    got unsigned int [usertype] *
> 
> I'm also getting checkpatch issues:
> drivers/net/wireless/ath/ath12k/hal.c:503: Lines should not end with a '('
> drivers/net/wireless/ath/ath12k/hal.c:531: Lines should not end with a '('
> drivers/net/wireless/ath/ath12k/hal.c:551: Lines should not end with a '('
> 
> Can you address these issues?

Hi Jeff,

Sure. It looks like I missed something. I’ll fix it as soon as possible.


Best regards
Alexander Wilhelm

