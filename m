Return-Path: <linux-wireless+bounces-4490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F3876615
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D46D1F25539
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0201DA5F;
	Fri,  8 Mar 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onway.ch header.i=@onway.ch header.b="d1thcARs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022018.outbound.protection.outlook.com [52.101.186.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2333DBBF
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907192; cv=fail; b=UAGSxQkp/hclhJw+12+TV3FV3zhQUhs9gkLqkaAkcqZFBFKLC9OSnTcFVcsdy9OE+Cy2gECWR+DWA7EurJuKwU5mXM2em9IlDgCb5kZPCh+zSJuBBqDudA0Ogz/kjwdlDDg4jXgXtyhlgec+WBvkg/dAtPR6/Qyr5PMP5Yt+EBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907192; c=relaxed/simple;
	bh=VR2jW1jpIqdBWl7NsY7DbyoYDEygyq/wo95a2IQX0qo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OEdZda2a/hYTmk0mR2u/IAlocC4pvh/HLKn5xy9zKHVJGXhdXORPaW7f2eF1T4cgsVLoHVe2eCAsHN3iLmVFf0eGmeydHq7h9AOlvEDJxL62TxAPmZTltMJGWn+vJWvWy9zJ7YzshP6vd/cPO1wp995PNgJ28Dks4kKSu7NKMc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onway.ch; spf=pass smtp.mailfrom=onway.ch; dkim=pass (2048-bit key) header.d=onway.ch header.i=@onway.ch header.b=d1thcARs; arc=fail smtp.client-ip=52.101.186.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onway.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onway.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od7qpAMfKQn1psW68AtfaKqv6B2iZVkGVNUpItAFb6F6VTRCnrE/Nywk1f9dGvlrEk1J5thHRIaf2IZkKFPOWvnMBO1i5WfH2mYuNTbwKHBXZ+dk08+jbuiEupexY6kQS+BYZ+SLi8b3UV3N2mkPC752BkNAHs1S5uWEeqKZHIp/dtFs3UWbXTa5Clefxeq4roDXhC/j7c0MRwFJfTB93c3olAFfLaGsy81vSVHHkX+FEcM2AZAHViZ1jIhnpFKDP0EleX+iGC4ljd8e7l/l5J75/iuOHIvYJ1sepKyLuGwx25foyFLpJA7HYKL4Y6bFf/omaiuwaYjz/NePsNzioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znCbPt0sgrVpolGjj4GgdQHlZVjsFBfsZw1Z5mYx7hA=;
 b=NsxuKREqRxH9Fa0oiQm2O+oHcYrpMv0zTmuvylfU8zjqPZATTrcJ1qMDtZ5EkrPmAOPwJqpbfdNNmV85EtX5MMJvXhPJePEAK6OSDWTTGHlFC+P+jmnTlI1ZZakFnnSL42dYJ4ppWErDVq5NK+LWVk4vK7yuQqerKMlkdjjCfuYfTezIO2nFVP8wdmrZR0MY9My/tacKGG0XBZ3Cd+npFpqNRn2gE0rChE2hk5gzfPquJiTA9vNlh3VLOnA0k8EY/kE9zIuiVbQhy3MlyVesD+Q5UwVHCmtm6tjDQOECMc3LWecFf33kgwe2kjXhN/nnd36az0UaA+Qmw0ylKOKOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onway.ch; dmarc=pass action=none header.from=onway.ch;
 dkim=pass header.d=onway.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onway.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znCbPt0sgrVpolGjj4GgdQHlZVjsFBfsZw1Z5mYx7hA=;
 b=d1thcARsl8O4hKBcL2//BoyODTLLXsZyQHZEbq8+ZXd8ikZmW/cWhC7ilVO/ESveqMO7kEe9pzth8UFhcwCSLZYx4o9BgkDvjD/xMRESTjzQHppShaj1b0chFGMoNWusx8yqwNnr/2zr2Hq5gazY0teIFlXO/NTf0K9RTxzfL9Mp8Jy20F7MWZXVN1/FJS9r6ebBKfsvuVWmgN/X4y5Mz9P42F81MLn0aalT//zmMoG5qUPWQzu7cyK+MoxdHaYtrpvx9E7IjLbeHwAjpcsh14MvlNwCWltPOzToMrjqjVTYlQzLg+MEJBZTBuzcEppN3Xgyz3vww5MeubrzDSwAVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=onway.ch;
Received: from ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:25::12)
 by GV0P278MB0832.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 14:13:03 +0000
Received: from ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8472:67b5:d1a2:4bb2]) by ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8472:67b5:d1a2:4bb2%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 14:13:02 +0000
Message-ID: <81fda000-4562-431d-ad47-7fdec469b0dc@onway.ch>
Date: Fri, 8 Mar 2024 15:13:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: regression: [PATCH] wifi: mac80211: set station RX-NSS on
 reconfig
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <014a25e4-5609-4e3e-a593-8a2bf1bd5568@onway.ch>
 <29f7aa2c233277ab4bb56bcff8e228036ee96a2e.camel@sipsolutions.net>
From: Andreas Tobler <andreas.tobler@onway.ch>
In-Reply-To: <29f7aa2c233277ab4bb56bcff8e228036ee96a2e.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms000504060602090003020104"
X-ClientProxiedBy: ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::19) To ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:25::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR0P278MB0202:EE_|GV0P278MB0832:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b4067-b8fe-4daf-31ed-08dc3f79ddb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LuyUkhYnsDZqJ9DZpx/LPGVh6wXcFT+DJSMvbnusQHqmBoVl4KK60PcFEbqcpru1jmS748S6LmlqtCyHpkHtW1EZM5coXVhjtZYmBDomWBdh4ZL6knyO4Vn/UzdUjomLfarYivDww00NS1ztwO+nIh3tN9aRvsO0rHonsi3xqkikg8VUw7S24P+V5HmHldSeHPyKmiWDoV4Wu68d17DGWQGjdfxRy4E5y+Bj/T36+YM3AUv7wMHu3g5MIHOvuGG+L/zIbPZbs5OOydB5cDtXpmoGaWQM6ru/Wuzj0dut4M4fg4IOyCse12KTVRUcn+DBB5cicBIGGq4GMG1xy5q3KoxSSC6XJ1K9VecPQk9UwlVoCjpZ7BkmXq8NpRTjVZ4tq6HCzE73anRrVNL9fUKVVrn290vmLI+IIiyzpJknMSVaBX3HdrEMEgW1cbcbiu1LZORBJiCZVwttoKV3pcoQVEPuKmcvinqj3alw7f/LvwD+97c0zFwkyvhTEv62fcKGSTZA8iOxvbQFnFy3ZLqsyM+du5JYsI/0te94YuXTI6+Agdwts5pBlIEjVbKhJJG5cNU2mv+XB7lB94VW4tYgYi5Ytm53btv1RRFF1P8NkSeXOr9uv8MlkjNtZBVGPQ4LKf8SsVHZJN/Ci2ntoWJW2ItdnWSzp36zxb1c6YL2I8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhxR0hBcGtrWlA5S2pLeUEzdW9LQytnWHFBd0cwUERxZFBpeisxNWFTbTFz?=
 =?utf-8?B?U1Q5L0Jna2xSeVBpQnJCSWdXSW5jcE9TZmIxSGQyVmNlZURNT1JPWGV0UU1U?=
 =?utf-8?B?YkZrQjB1TU8yd0RHNXZDUnhSM21ZOWNwa2hUOGxvMVVaVUJPNVRRRk56WGtu?=
 =?utf-8?B?alZXTi93NUhPU2lRUU83Zm5IWnlJSXJlUnJwSEFaV3RZVFQxY0xuVElCR08y?=
 =?utf-8?B?a2xsb2F0YVVUUGNIeWFoT3BiWXg4R3JoVTM2NW80UndpUGs1c0owTHp0RFpu?=
 =?utf-8?B?OGdvNzFGZnd1czVzeGRiMVpBNFdzbUpWOFpSTksyWGhncFcyczZwUDloSnpV?=
 =?utf-8?B?VkEzTjEyYkVKRENueGlqcXB5eTF4Q2ZOa0hITVBZdW5UUnJTczB5Z29zRUt1?=
 =?utf-8?B?TXRxdXF3SHhhSXlLUWhZT01aeG9mQWxGSXlJYTl5VU04ZEhCYktNdnU0K2dl?=
 =?utf-8?B?NVBRTUlSbnROc0kzcFdQZ1hvczVoWGhvUEhpaEI1YUkzelJNaUY1U0VjNG83?=
 =?utf-8?B?L3Vwd3F6bmY2ZG9TaDhaNGl0WXV5blNTUVZsTVZNL1d5VGw3bGFOU1V4d29Q?=
 =?utf-8?B?a3F0My93TEFIb1YxQjZMQTdsNSt5L2RKUzI4c3hkVnQyVk9oWlBUVEYvZFZX?=
 =?utf-8?B?VU1YcGl5U2RBWi9iRWVld1d0aVc0cWdGeDJlNG13K0RNNWVCRktDQk9KL0Ez?=
 =?utf-8?B?bEtPc0VZZGFJK1F0SVM5YWNPekhlN29wRnEvMXZkWk1RTjJ5VnBaR0dKREVP?=
 =?utf-8?B?NU9UQ3Z6eUwrZ2pZZVkyaWZ5QWJVTkVaenpTaGVLcEZLQ2tEY0NtZ295aUox?=
 =?utf-8?B?UjNkZFIvbDMxaGFBV3J1TWdFMUlKeTFmcGJSSjlUMnBoT241RzRydWVTR0Zx?=
 =?utf-8?B?Um5IVE5rSVFXVWRyb09VL21wdjM5aWtkdUNVeWFMQXQyc1l5K25tYUsyMlMy?=
 =?utf-8?B?U0Vaa1FCUEF0d2JyVktoQkJwZHBEVVRKRk9iVkx4M2N3Ymp1MEw4MFZSQjk5?=
 =?utf-8?B?Mld2Ukt1MHgyZmpFZlduNkw2RXFkNCtzcUxwajVWVUxwYWxiTVZFcEhoWFZH?=
 =?utf-8?B?S2RQL1ZjTDg4Mm5PZlZ1a2NiSFFhYU5uaWFrczM4c1Z6bjJYSDhSR01NOEhI?=
 =?utf-8?B?ejd4eGxIcWxaM2NWNWNubDBBWDZjOE5wT2Y3aGFnMndQSTlYRnRRZVpCeWRm?=
 =?utf-8?B?Z25yWHczN1g5Z1VQTXJabXhrdWtCV09INlNGOEJqQStBMk9yU3ZmQnlvU2NN?=
 =?utf-8?B?NWhEdFNNWVZnSlpEcnRBSnlraE1wOU9zZmMrZWRTMzY1QVZKK0NXWWF5OVZ0?=
 =?utf-8?B?VlJoMnFjaUlKcGMvVGhTbngrOG9qb1BOZ3QrL2lqRUd6NXNiUVE2c1ZPS0Vt?=
 =?utf-8?B?RzQwY3QyczFRNXViOVFnOFhWeVJpU3hpamNWaGo5VkkzaU5uaDZIVzJyMlN2?=
 =?utf-8?B?TGhpVENWOUZhdFFKU2NZQlRpUHNlZklvSWxGb2REdmRPKzdOMFZoMmRQc3pV?=
 =?utf-8?B?Wk0rWU1xMVlKR2tPc3ZqK1pMSVFSdXJYQUVnQ1IzbWZOYXpFbTRmOXpnNWw1?=
 =?utf-8?B?eXNreGVNaCt4eG9STmFkcURlV1lhd25zd0doNytqTDFwWHM2b3pUZlhPUXFa?=
 =?utf-8?B?V3ZEeGVkWExNeXVacldjUGhOajk4YkFBR0lHMXJ4dWM5RkNmMlZENnF3enVs?=
 =?utf-8?B?emVYZFB4MEswT2dnM2RZYjVMbEttVWdvOS84TyswWW4xVTYwcWxSelgzNFFT?=
 =?utf-8?B?a3NsbGJ0U21UT2o1TEF3Vm45TjVsREs3NC8yaEczRDN1ZTg4VnAvc09uY0Nr?=
 =?utf-8?B?RXAxMjBaU1B5ZmxVdTNIa1daaGIxYkFzTlMranVlM0l2aUFmNWZKQkF2V2hm?=
 =?utf-8?B?bWhocWM4bytrVVJkZm1WQWpTckg5eWZjR0s5MTE3NzdZVDNjalpaaEZNTmEr?=
 =?utf-8?B?bVVLUXJTQ09CS0UxbFZVOU1neFBNSG40QUZIMDdJc1Rtc1grVzNtRFNGNkJ6?=
 =?utf-8?B?b1NyS2YyV3RZUkNKYllhZWw0VHpyVDJOcUdwMGtNVGNkeEk0Y3ByQXcwcWtX?=
 =?utf-8?B?ZDZsVWxjai9zcERBQlhKODM5WC9zYXE2WU9ORXBFbktwd1gwaFpuRXpwcUY2?=
 =?utf-8?B?Q3NiVWMzZkI4MUpzVzkrZ21aSXloNnVzenpiN1IrTENNLzJ1MnlDcEVodStN?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: onway.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b4067-b8fe-4daf-31ed-08dc3f79ddb8
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0202.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:13:02.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6609f251-fcb7-49e1-90a9-db1acfa508db
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNnlTPapHo5JrJRHShH7ORJ5ImxRh/SXKdcPIxTZlIEBFDGRGVHPHKCANBJqmvPqYn+VIia461OySW7ISOyNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0832

--------------ms000504060602090003020104
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08.03.2024 13:19, Johannes Berg wrote:
> On Fri, 2024-03-08 at 12:58 +0100, Andreas Tobler wrote:
>> Hello Johannes, all.
>>
>> with this commit[0] we encounter a performance regression in one of our
>> AP/STA tests. The performance drop is about 100Mbps+
>>
>> Our setup is a hostap (2.10) configured AP on 802.11ac, channel 46.
>> (40MHz). The client connects via wpa (2.10) and then we produce traffic.
>> Before this commit, the throughput was around 250 Mbps, with this commit
>> the performance is now down to 135 Mbps.
>>
>> The wifi cards we use are WLE600VX from compex, a ath10k based one. The
>> kernel we're on is 6.1.80. We've seen it on 6.6 too but didn't investigate.
>>
>> Now, the ieee80211_sta_set_rx_nss() function has two FIXME comments. One
>> in where it handles the ht capability and one in the vht part. Both
>> FIXME's are: 'consider rx_highest?'
>>
> 
> I think you'll find that all that is unrelated, and this fixes it:

[link dropped since outlook garbles it completely]

Amazing! I can confirm that my performance drop has gone.
Thank you very much!
Andreas

--------------ms000504060602090003020104
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
DekwggaoMIIEkKADAgECAhB+h8MJLtdm7y8h4qjQp5j0MA0GCSqGSIb3DQEBDAUAMEwxIDAe
BgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMw
EQYDVQQDEwpHbG9iYWxTaWduMB4XDTIzMDQxOTAzNTM1M1oXDTI5MDQxOTAwMDAwMFowUjEL
MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2Jh
bFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDCMARtKQ9xLKfbpmf1W2gT/EG/NiY1bb1tbWklnuOvMrA8mb8ZqQK/LQgiA5syzH1u
kVqrfRfWQQlmctTO4TX+GVyFq1irI5FUF4eW/lXRBFJdjh9pHR0KQiFeGgaSdnY7RtQmK2Fw
3UiwQAM2LNnUAkhpaxZtDi1gRiPK0R29+THPVa1fdKO15xlH73Asku3oc1riwL/9Ap2PJ+v8
2EMLNit0jMCyyhcWeni34dwzJBOuPSukPwqQ+P3qzL1rHN6AtvO17vCBMdtYF4kanSwqDsEC
74bRGTq147XI93vlqtsK99j81pFFAeTq2YbvWCkt0HVmE/0hw1jJ5MpciB8yHa1Ur0OdcZqS
xgLKLpaKwlrU5r6mhSuhfYRJc7qjTeVXGIDXHJ8byVTOlQ1micZWtSOEbn4x1jXr/pvS4p6N
kItuC7ocs+8jKp1Nv1eoXhdZYq744wOz+tbJDri/ea9JrS17lDm1yGbib0rQ970uUgoGT+Cy
B9o4ckOniFjHjChwOvwN4Jl7l3nAIWTGgZzVyQzxmgyClRzimCRATlKHFgyYps+81E9rlgXN
sW1wWflEyvUyO7yC3wnRz53FhyjaGLt0Rbf3UorEaG/swkFxz7THcUVOeaFT7m3r4KeQoyWu
bPJqh5WvJFO86IfgWdM0e1UpRgOwIzQIsN0w2CjGCQIDAQABo4IBfjCCAXowDgYDVR0PAQH/
BAQDAgGGMEwGA1UdJQRFMEMGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYB
BAGCNwoDDAYKKwYBBAGCNwoDBAYJKwYBBAGCNxUGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFAApNp5ceroPry1QLdugI4UYsKCSMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMHsGCCsGAQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2Jh
bHNpZ24uY29tL3Jvb3RyNjA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvcm9vdC1yNi5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5n
bG9iYWxzaWduLmNvbS9yb290LXI2LmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcN
AQEMBQADggIBAJGRR2vVogNGaQ0jmPHmCBqkZROGrQpwzZ3Oky7fXiYmd7zIpVfDN8oG2psG
NtQ0w4OcGSG9lydsdRK26vb+e3W0/d57wrI2FjHO/gOQjQ1tX3ckKFeKl+xqftiN18STm8jY
Wr7ClsYAvLJYGB/Lv1giBthYBMHXny28SHlQ7ySkamNj3nG/7TvRfcVi4bJ5nIi9qjbqY3zv
YW7FHFiE0vAYcjLfw30BJrVDcFM0pKsetmeBp2h8eCUblbdMwVHXUk4Q4BQeFSCltVW+AJiA
YDp1JfTLnPuTetdXKMU6zsoFJet0k8pp2mXi+pimEfv4/jSfMFFzEkeu/kV5eVOtv52uPJc2
NlIKbN+Q64Ko+ykG4nu9pvT/2h40RGCfPpIsKMspwNdsxspxFeA2EUGXM3g5QGqJ5IFeTzTD
Y3PHXYq82PvnxZq/E6xchtfRnHCjWHe7DvkAja/yrAVZc1yU7ypbZVeirqSKFal6K68OYV9I
DBEvHDAiOBS7Mb1JpD6k6ia5oLtBMpYwjSEvRviYQ+r0aw89CrVSbCRxgUn9ngj3cNm4pxeY
oya4A1NLrDHAgTDxDkxDrL19snEYQ6A6BgvhAio1QtvkJg+e3Yt6IiISeHxS6Hy1rCpKOdHS
HsG/mriaCjcvVn1BC57FSe1YP3q3ijSrWNdYvKumA/tlye4LMIIHOTCCBSGgAwIBAgIMPCNU
nd1E+SA9mL8PMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
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
UwP3w9QAAAAAAAA=

--------------ms000504060602090003020104--

