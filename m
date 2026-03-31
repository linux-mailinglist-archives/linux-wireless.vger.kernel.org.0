Return-Path: <linux-wireless+bounces-34243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLY5OwUnzGkmQgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:56:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB94370E5F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC3FC3036D6E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13613A8FE1;
	Tue, 31 Mar 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Hzpmazzn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazolkn19010036.outbound.protection.outlook.com [52.103.35.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9E371D04
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986728; cv=fail; b=QAJ/iwnpDz1c6bn0MMaQp+cLyGv7pwM1Px4bNgXagsifDDlreJogpNfAiFkBKDnKXQYMxCli76vrtxOXKbFxdy73uDNXEgU0+JlzqPvIzu/+rIkVEqLiQofAo4eSJK50fSIVClpIGXPJVYS3r8vbH4H8VT2yLRZPBPAimj4Npf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986728; c=relaxed/simple;
	bh=V0U3VzC2+Jhr5YG1pWr9Aiv+vb3i0lL5aLTyGGqZdw0=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=RcZvA4dCIFB0NbgehREx6ZCtZf3ebDHQMHn2l1HjZUm0FY7Trbtx/nP4HDlKIeK8zUPLIchL8dUb86hsHjPBDwu48YDK+cKAWrA4ZacwYCpSGdVGfx2BUawzUO++wHA1MPEBKmhga5+TAxYWDVoXT4nn67ljBt1i+FE+/LC2/ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Hzpmazzn; arc=fail smtp.client-ip=52.103.35.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBYibsLPncO/dzbveOx8zGNNKggwuTn8SNa8RvwQ6SfgSLrKjhQIHBsWS58CwjHJDxkKuoYr6OYxgvAAsrPYD7jYzzvVTvWWGyGnYG3Aux9Hya5GYivl+uPmWeIsggckkeoX+WeGHSIllkJPOcmC2p9gjq47aTGpI5it7rooOgJ+9iZ337GRQjZEPTITLjbaXyGk2NC3uzT7XYp0RePgurO2FpvZxJ6xyFGET4k4kHqlCROZ7jq5hI+eM0Y3mZrcvzdhYQGbNDib3AimLefloL+QmdLdN4d+AYqDaOr/GV1+fEuN2Pq0yb3o8KeMu5BPfJie0SHFG+aOuSKktB8FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1t8x22UBRc+1ux0t4/4Qbk7oonIwK63PaT2T2gAcWI=;
 b=AvkIGJll+Km1yeA6wpFyPk24rb28tFj8iJuFCdK6CkJIoUdLoPgBiD9QculRkq3hNlwOVVSV8EDd8JuMIAs5tRJGPY1M0Wcj98jrqAUOXIJ5ORHDbFZ4sFSM2PQaLN8U6bujTSAoU1riPOY/fFc7bZzQPMuWqJ4L7f0NJMhLr9mXz2P/hhmdQF6U7nIhH9+ulkwKvCg2oUa+0a4xuBhc717p1+uPBwpzxLAjwmxKy5qCVzkD8nnxIax3k1pUuTIXZ9lgmyeCFybPjx+FFdCuaObJ1KAxXbnw/C9QTBNZQ1+Wew9aCvV1c8sygez3Iu76ExGb/sZRcQ9exlmUhZnlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1t8x22UBRc+1ux0t4/4Qbk7oonIwK63PaT2T2gAcWI=;
 b=HzpmazznAH86Ckse5EOQiNWDULd2akiL3uRszmRWBdLp10Ms1VEnuLlARUravuRnVtfnpwSuzIXAmc+Jb/zuhzx/x9+X8/ER8v/EO/SxINAzbXXjZrVLFFgMqRSY7JEaUsZMsKI4ElRs9ohqW4NpTmGrV1Izp+qITFfvDdKqr1DszBRfcFNJKGrsFGd9pP5MU8LDwAPQt50/iosi6DAQgCPolYCrm+nO5gEvpuISSDYjjz+q2+oH1wtWfhXBguRx83WRCINTuvFD63mnA1NaqrA7gC+9Cwd/1n+cLuda8SbAnOFOP6PFGe1D1hRspS1RZqXekDg8Vj9qkOEAk6VziA==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV3P280MB0433.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:52:05 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:52:04 +0000
Message-ID:
 <GVYP280MB1518F512F873D07D70932B089453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH] carl9170: main: guard op_stop() against non-STARTED state
Date: Tue, 31 Mar 2026 12:02:00 +0200
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <5cfe7d0ae331426b56f18f00a4a042a2@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV3P280MB0433:EE_
X-MS-Office365-Filtering-Correlation-Id: 64206871-e708-4917-206e-08de8f5efb90
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|23021999003|5072599009|51005399006|6090799003|5062599005|8060799015|15080799012|461199028|3412199025|440099028|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NENKOEU0UzJFWnErOEJxRWNTanphamhRQzRuelNQYWFjWWJIa09oZWNKTzRv?=
 =?utf-8?B?VXhHVFc0aFRwZkhGeTFMUDBKVXk4Z2VWdW41Q2RsSVpaeTF1aDdkV0hnakxW?=
 =?utf-8?B?WTluOGs1R1B4cURucEo2a1M0bHk5ZGRsQjJCS0ttcXR1YkRMMDMwVXREMWF0?=
 =?utf-8?B?UUQrS0RDSVk5Rm9LMmtReWtFb0JqWklxeXVSVFJtWmo2V3ZCMFdHNERRcVVq?=
 =?utf-8?B?bDh3L01wLzlWOXo2WElZZkpIK2VVNExVb0tjT3RTVVk2dG5KMTdsTXFZazJF?=
 =?utf-8?B?WjVNUm1oaUlQeGtVT3U4V0dvVnpXdEIzckhZaE5MOGdhUVk0a2xTTGR6Sy9j?=
 =?utf-8?B?OExzRC9tYkpqcHFDT0daaWxUb1NsYTJtNm9Ca2FaQU5sT2V0RkZGQ3R1OUZy?=
 =?utf-8?B?YytmRm5zRTVXa2NVeFNUMXhtWmVyR1NJV25RUTVnT2RGU2RyY0xoTExPeVhM?=
 =?utf-8?B?QmhaUzNyVWk2S0pVeXgreUwremptUytrM0xkRWVuZHovM0YwNkRBTmNkSjM2?=
 =?utf-8?B?TTlVeWhkaFQzZU1UR245eVgwUW1wcWtJdFNiQzErTmQ1MEtQMm52YXZhRWpv?=
 =?utf-8?B?S2xXQ1BEMTF3M1pxUW1KL0FUMVpPanZuTEg0VTZiakY0NHhCQndOWGQwSjZL?=
 =?utf-8?B?K0gxcm5TenJkSTdSV0xza3poOFJKaktEQnlib1l5c1dQZjN4SksyV3hqaU9L?=
 =?utf-8?B?aGQvQkpMWGxxY0dHdTNsZTRrcU5qZkpkRVFEUmZNZ0s0dmRORytKUVNqVUxN?=
 =?utf-8?B?Y28zUDh5cjhNVkhUaVMxYXBjNjlDMjM5SUUyc2Z3M0xpWUloNS81Z3hjSFU1?=
 =?utf-8?B?blY2MDkrSDBldXRITzYwMitjbi9vNUw0WUR4eG1HSzVGQW11Z0V4TzgwQnQr?=
 =?utf-8?B?bjVuRWJSamxDMWM2VmpjNUVmeVZmUWpxV0M5VmRzY0p1d1F2bU5sTEtJdFNR?=
 =?utf-8?B?dHhLcFBvdXVJcXJQL1lBZXhXdks0MlZESjdvQThKTVZ2M2RCV3NaRG5keTRm?=
 =?utf-8?B?OVJSQUErRnJsQ3ptVjZKRnptWitrNi9TTlVJTzNqaURUYVV1Q1FIcWUzUmNU?=
 =?utf-8?B?SnlDa2thMXNHRjV2S3krVEN6bWRxcHFzaHR1eTJFU04vc0JvWjByaCsrMWVR?=
 =?utf-8?B?emhwN2svU1U2cytPUEZzL24ycTBLU250RG9ycTVyS0xIeFNMVnFGWUJWdzJL?=
 =?utf-8?B?L240VDZwZS9XUGd0UWZQVkRlai9pR0YxU1AwZjFGSlc4bDI2dzNtS0pRa0RV?=
 =?utf-8?B?dkI1VkRSVFRZWnVaQmRuWUpWb1VKSVFRMjdFbXBLVFU3UG9TOXNXbWFuZHZU?=
 =?utf-8?Q?0BdPrHxLOmfdb+PTcPNSdmq/EATt0dsjh9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW9WUmZqWE5SOHV0SkttN3R5SmFiS1NrWXhYQUhwL2E2VU1pa3dEQXhJWUE5?=
 =?utf-8?B?Y0t4SGZ3cThUNVI3bExQcTRZb3NLd2pWWWVOakVFYVVKclQzbFFnMWhNZ2Z5?=
 =?utf-8?B?aUxlRTd5TDAvM0tyem5NOXhOSGtkREcxeWhZWHU2WG1QQnYyak0vMVc5cmsz?=
 =?utf-8?B?QWJSSU5ia2ZhQlo2VTdFRlRiRXpHM2Fiam5BYjMzSlFZSUlMV2lzQkVhZHlR?=
 =?utf-8?B?WDV4T2ZoanI0OGtDREdGZGxmdExieTVkdzNyMFpoUVBvY28xN1AxR0ZWM1pP?=
 =?utf-8?B?dFYrNEJUbTE2YTV4Ykhwc2twUjU1Y3lyN3NaR2dTV3JialVjNjBvRHdIN0hV?=
 =?utf-8?B?ZE5hRU1NaWNzR1VFOVJnSFpkMVprMlpqSHo1MzRtOFhxZllvVWU0LzBhYzNs?=
 =?utf-8?B?S2UrUTdtVlNIMDhVOFNWZWxWS1o3RG41djBtNE5hOE5RN1lWbUVERzE4Ukpp?=
 =?utf-8?B?dGFKQ3I1ZjVMSzUvQSt4bHZlemQ3S1BtY042K3ZEL2NrSFY4dVczSi84cW1R?=
 =?utf-8?B?VmhtZi95TitxNWh4cDdRTFNwNENJb25IRElRMFlaa21CeW8rWUdId3BMK1hI?=
 =?utf-8?B?c210THFxeTRGMFArTEFuMTlBN2x4eWpneUJWK1p5RmJ2aVRabkJLZXNmRERI?=
 =?utf-8?B?YnVYYW1VS0xQTmErWUxsbkFUOFltbWFMTTZBWWRkRmNUSU50bWxJSkVqeHcy?=
 =?utf-8?B?cmN4VDg4Y0hUYXg1ZS9hM0xhZlFOMVF2RU5nSVdJK0ptTUYwcjBhZlhDNWRV?=
 =?utf-8?B?L0NyeFUwZXE2VnUwaFJkMjJsZm1xUU5nenBBUkdoM1l0OGtsdmMwT1lHSnI4?=
 =?utf-8?B?MnF2cy93d2tETHJ0alhKVlRJN3dFVTRKYVNGSnF5eEl2VUloU2VvV0MveDZw?=
 =?utf-8?B?SHJONUdMVzVYR2l6bGUrVThicU5pNmg5SHNBN1o3K3RYYTcweGVTZFBUWS9X?=
 =?utf-8?B?MlNsMkc4M0RlaElycjlFUGhnQXF5US9VdUhKMHFlNVRKMXlDMlFGN2E1b2JO?=
 =?utf-8?B?VkVPYkk3MjViS3Ivd1FIOTNpU2Q2SWZSdi9Zc05WZTR2UTNiYlVtRG5odDBC?=
 =?utf-8?B?SUlrbjVyYkFOZkM1RmNhWjN2WS81dUdUdUVYMW9OQ0xSdjF0N0d6U29aeTZr?=
 =?utf-8?B?c0ZQaGk5Vnhxald2cVlnYUhwdjloMUY1cjM2WlZJQmx6MENxMGNZUlVNWFJ4?=
 =?utf-8?B?YWo3ck5jWjJqcEIxbys5a0NiVVlib3ZvS1lUbWJ1Y0I3azV4dVF5RUU5bU85?=
 =?utf-8?B?Y1k3ZGJ0NWFodm1uWVdMR25jVzVUdTc2SnhlZlBoamNPTVdRcGJvK1hWSy9K?=
 =?utf-8?B?QUoxeDVPd2RKdU9iZEpyNmpzaTlMT2VNN29JYzA3SlczUkc3SGJWVm5QanBj?=
 =?utf-8?B?a001T3JtQUh1VldDTHZmVTVoWlFEcVlXZkU0cFhwMWZoc2svS1NZdnd0dnhy?=
 =?utf-8?B?SGErOTdzSWhmMGlxT2hRWU5BdHZsVVRUTmZ5U1FQZUVib1hoSU9Fa0ZtOXU1?=
 =?utf-8?B?OHN6MFJmUmxHdlZEU2tCdy8wdkpTaUxQOWV4WmZzbUduSVBwaUNja3FMZ2V4?=
 =?utf-8?B?TzJsVCtwR0Q0Wm91Yk0xL1JWcGtQMFdaU1RFdFlxK09yUmtXS01hZ201OUda?=
 =?utf-8?B?QXNlWVEzcHdoK2NyTFVOSTlxRkQ4ZWY1UGkwbTRNLzVQcVQxdmQrajFIMjBF?=
 =?utf-8?B?RCtyZXE0YTNOSXZobEV2Q0p2SEpPRWRnK0p5Tmc4SVJ2eWhDK202TndGYVcw?=
 =?utf-8?B?MWJZV3ZHLzkvckVCOEt0V0xtbk96WDJiazBSeFdQRHFXNFBUVGFPdGVQc2RT?=
 =?utf-8?B?bGloc1FPVGhyQnExQUVUZ2tMSXp6Z21ZN2h6US90cnFXbW8va1haQS9VYlZG?=
 =?utf-8?Q?PwJR8r/QOFsl+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 64206871-e708-4917-206e-08de8f5efb90
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:52:04.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0433
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34243-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,hotmail.de:email,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 4AB94370E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When carl9170_op_start() fails partway through (e.g. after
carl9170_usb_open() but before carl9170_set_state_when() transitions
to CARL9170_STARTED), the device state remains CARL9170_IDLE.
mac80211 may still call carl9170_op_stop() in this case as part of
error cleanup.

IS_ACCEPTING_CMD() checks state >= CARL9170_IDLE, so the existing
guard in op_stop() does not prevent register writes when op_start()
never completed.  Sending USB commands to hardware that was never
fully initialized causes unnecessary command timeouts and misleading
error messages in dmesg.

Capture IS_STARTED() into a local variable before
carl9170_set_state_when() transitions CARL9170_STARTED -> IDLE.
Gate the register write block on both was_started and IS_ACCEPTING_CMD()
so that teardown register writes only occur when op_start() fully
succeeded.  carl9170_zap_queues() and carl9170_cancel_worker() are
safe to call regardless of state and remain ungated.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -442,11 +442,12 @@ static void carl9170_op_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct ar9170 *ar = hw->priv;
+	bool was_started = IS_STARTED(ar);

 	carl9170_set_state_when(ar, CARL9170_STARTED, CARL9170_IDLE);

 	ieee80211_stop_queues(ar->hw);

 	mutex_lock(&ar->mutex);
-	if (IS_ACCEPTING_CMD(ar)) {
+	if (was_started && IS_ACCEPTING_CMD(ar)) {
 		RCU_INIT_POINTER(ar->beacon_iter, NULL);

 		carl9170_led_set_state(ar, 0);

--
Regards,
Masi Osmani

