Return-Path: <linux-wireless+bounces-19667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04419A4B28B
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C893C188FD48
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B41DF27C;
	Sun,  2 Mar 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="yYhrFA1L";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="P2yH7IiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646B1D61BB;
	Sun,  2 Mar 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740928450; cv=fail; b=OllhZFsNk3zDe7rnhTMUaLXefgxYGlAmo6TiCUfk551Qn7K7F/tUxq4nD2ymp60xIYEL+monVhZAMG0NBrAnaiqMOC4Xhr4n6/E/ty+xfTh2UPLVTlhe79A/ACyBIVuEbwIfZHZjddVKD9oU1ongPnofb/HRMgcpfn8YBXs0igg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740928450; c=relaxed/simple;
	bh=uWcNIOurnFkWV8pj3AiVbZLacI44pSCi1A8Sy5Hg7Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcBx1vgD/naZEMpM2FYcU+ekMkbu47CbAJQu/nni1wq888ixaALX/HoGfIDJGxKnKCEEK+UXZvmt0GU0guufrFstn1FWyFkhQ/595cR9ECJ1VBchiMHgB6CxG2RweIpDyR8BpJHSsj+LpuPi/k0FRHHAEbpYKkHJIfxH+OTwlGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=yYhrFA1L; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=P2yH7IiF; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522EItXa010648;
	Sun, 2 Mar 2025 08:48:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=uWcNIOurnFkWV8pj3AiVbZLacI44pSCi1A8Sy5Hg7Qk=; b=yYhrFA1Lydk+
	Ymi76dtDoX6u27LItgm3KXF/yY0jbdnSL03wrZYEF3MadaA6kjrKiaxmZ0ObF0BV
	kGVuybKLjbbwaRwqzLTnMaMDr4EGbcoXMiTUF/vN7TOXEov/t0uloP6d3d3MIrsW
	HI8IJPvqzo0EbrEU6se775GU3RIN8kPDRDUsBxHXPzI4sI3cx7U08qNTI/y4/ge8
	feWPYdAxP3UYC1TwKq7ZrBS1wiHF4L5WHna1IUu4f5+XdzLBILge40vW7Lbwu5rs
	poJC4ioZSC/iQBCLLQDBICnMXpJeqilRRkXfwRhuXUg58hNaZAqHis21pTg2457k
	0AbEiDdvuQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegh96p-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 08:48:16 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZfzQj533iB/+P3s1nCrp3XIFZSfzZugsFx2QjazYfAf5HuxZcvMxnnA5ULDdrSBSD8zHojp9ZDW0L07NdD251nVMg8NAcEYwWwQUWgWejuAgEIYdKYgGDOFY2WZWuVfy+Hszj7PEWCnqlnMLeRq+JbrRPM9tsmO/eH4i0y6g5cpWXkXBdYtGwUoDuTPbLR4ob/ZVBVtAH7pMNbDuCu5A7G13g8ATF8LzE3sgjTILaf+1ASr1a9YsApuYOX9HiYt4FxJjPCZdO2oXdY2jlO8ge65ZiW0gLYFZLhdF6YfxHJmUnfV3PH8XT18Tuk3TEo9ZCfhmaJD8GgRMNezVbw1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWcNIOurnFkWV8pj3AiVbZLacI44pSCi1A8Sy5Hg7Qk=;
 b=P7Y5YJ/DjLMeQxXHdNgmPZ5/ml4xKvUNM8sQaHyGN99LcSVR8EG8pyq3HohZl4LEyLKQF4pFBvafcpgYroiWKT9qZK4GSHuZ/P1FHvPYkTJ05j1sKB9BWq/1ukom5yi8PqnIsp87so4iF6koF+SHPs5uWscDRTEjsVof6fYgzFEXZDhItBmxI7Abew3DUEwQpM7keF1c/v1fHiaQq+/bBranVitxHX/mcBD0RIkX1chk47D6fV+tLPPXxNq6XA4s7+qsxoa4RIuoBJpnbxd6EJkQ2lj44KrG68wztY6xMz+CiJHGVw4CKnGTeYDWt84F82+2xzMbPzPw7z0mZZn+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWcNIOurnFkWV8pj3AiVbZLacI44pSCi1A8Sy5Hg7Qk=;
 b=P2yH7IiFO8bYD8GdH0QWPF4Gfp/nK731lejGh+bsUkvs/89+mttcKAAd1H/q7D67B4OIeNff1o0231gfaQkVfPh9FZRWWdupmz1eytECporQiGxBLM4r2Bb5vnjlYmdI9TM85DIPfQ16+MM0VSXhpoiDCbkqGV6aDHQX9SOqW2Q=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 14:48:13 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:13 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v2 5/5] wifi: wfx: allow to enable WoWLAN using NL80211
Date: Sun,  2 Mar 2025 15:47:31 +0100
Message-Id: <20250302144731.117409-6-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250302144731.117409-1-jerome.pouiller@silabs.com>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PA7P264CA0241.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::7) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 103f957f-325d-4fa3-56d0-08dd5999427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUs5WjJBblNZT3lQU3g4dzIyMlhGNFZmcWo4cTMvQUx0dkJGZ1dmVVZ6TE9s?=
 =?utf-8?B?Y2Q1QXdHWW9XOTB0Wkc3NVVRLzZtYkNOVVFhMFBhNnZTNlpTcXVLdW9rYzdp?=
 =?utf-8?B?enppejc2MHp3YTJFM3dSNmV0TUZjbW9yaURHVlp6S1J5L21sb3d0SHNkVitq?=
 =?utf-8?B?dCtFc0dzbFRhbkFPNUdEcEIzQXFES2FNcXM3RjFqcmR0U3J5L3JqbE14V1pK?=
 =?utf-8?B?TDZwM3M3ZERJQXgzZU5mNVMyZjV0RWpyMmRnV204NHh3L2xYSVIxVzhGNFdJ?=
 =?utf-8?B?MXJSVExHa0dEaEVIOG56R3JpajBXd2VURkdUNUxhMUE1NlBDc2Z1ZFllL29E?=
 =?utf-8?B?OGpJY2tXdXRMZUdpQ1MzT0xnaklTbExSa0lzWVladWZnT1BYKzNUR2pzdFBa?=
 =?utf-8?B?MFZPLy9vQmZreWdpNklTaTR0QWRKR2ljVjBwVTBjb2hNVzFLVEdoZXd6MGV2?=
 =?utf-8?B?UG5mSnVVeHRKclp6TXY3cGtVQ0Noc0RPYzgrNGN2WHFkaERlRjFvdGg4M2hx?=
 =?utf-8?B?cTNmNldCWHdrWmVFc2dYaVJNc2FRYUhyOElFczl4VmlhUGZud1BlZE1xS1hy?=
 =?utf-8?B?ODRrc1hQSFdZOWM3NElVdUNDQTNlYXFCSHBUdU1TbzNocmVtTVZPak5SUmFH?=
 =?utf-8?B?QkVaN0dQZGcwbi9nR05zdmMwaXUzL1IyWDg0bC92dlBqd1FuZnpVNDJuWHMw?=
 =?utf-8?B?akJkOGNmNWsvVE5DZkl0TFV1VExHbFc0Y3NybjMxRWU3VVl2bC9jR2ZhTFlQ?=
 =?utf-8?B?OTdsbm1KTmNiSERVMVNub0VYU3VCcmRhK1RnMlRPTTcyS2gwcnRRcmhGK003?=
 =?utf-8?B?cGdib0pNSzRZS1NoWkNyeTl6TkM2T0VGa1d4OEgvbWNqRk8yMnd0S0lmTUQz?=
 =?utf-8?B?eTJCeVJxTnBCc1NjaUNKTE95bFJHTCs0L28wd0g5U0NjOUJENWpVVHpYZXM1?=
 =?utf-8?B?ZkRrMDg4VTdnY2UwQ09VMW1OK0VIWHFvTWtKQXdTSndvelIxS09IWm1FaDNw?=
 =?utf-8?B?R1lhTytHTk9RcFVFZHI4TksrbXhDTkxaVzdrODkxRUZLOUdLcU54U3ZZd2NH?=
 =?utf-8?B?dTRaUExZZWk5UmhZTmJzaTAwMWdmaGNzTGNFaFF6T0lLRGVKbXRXcVA0Nldw?=
 =?utf-8?B?RExWNDlHVGFRTjdVY1ovN3ViZmtyNnNpdDdxL1lnVE9ieno3eDVTM2xJOGVM?=
 =?utf-8?B?VWR3bEJwa1VzekhZbDZKSDNGMlFyelpZTDdYTkdxVXFBYXNBZHEzQjRJamlP?=
 =?utf-8?B?cDhVb2FIQnJXaFA5S0VQS3JreWNYQXphalVmbWhjcmRkenNiSlVNMzBzNFBX?=
 =?utf-8?B?aFJQUHVLU0VJZkZucTFsWVd5ckZGWlRGVHNIUmRYN01EWFBodG5QaDUxdlB3?=
 =?utf-8?B?Q2F3N0QvZVVNRllJWGQ1ZG5oUk5DY2d5aDV5S094UTVzSldjTDBDZVRqNjVa?=
 =?utf-8?B?bHpEUGhoRWlqdVVnVUo5dkUyVHdEZkdjWjdsNUdveEdmOHIvSlV6bXQ2T29s?=
 =?utf-8?B?T3doY3B0cEYvUVhPOXFmYXBMSGRjTzFxOUg1UEt5NkcwNmRkTU11bisxV3hu?=
 =?utf-8?B?dEc4aWFXRkVXRGlyRjUzYmYyNVpZYjVoNU1TbGFOU2liYVNnamRIRStVV2Uz?=
 =?utf-8?B?b0xVY21xcVlvVVVPMGxhZ3g0WUtHSXdVMng3a2ZUdDZGM0NLb3JlZXZBSy93?=
 =?utf-8?B?RnpsRXVXL2p0RmJFQy95L3UrVVB4QzU3OFVuaEU5ZStJUkQ5M1JScXg3OGtm?=
 =?utf-8?B?Ui9lbVQxSFZUUWJWWWhtNnNvK2h3S08rWjdNakdVdVBWNFhqVEFzb2l5TEVh?=
 =?utf-8?B?dDRPRGVkaVNKVkZmekxybW5DSmt6NmNUbENpVjQyeEZvNEROMHB0RmttdE54?=
 =?utf-8?Q?/tBVHlWkMdjzv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZJTTJmMWlJYXI3WjlIZ1dhdW5hYVZkb1Y5cHJjVGNVU1I3Z2VCYlNCSnlC?=
 =?utf-8?B?NUNUQzJFYlBDY2UvWlozV2h0dXhrSGwrUE1seDFDc3F4d2IyK1RPTEgrdE81?=
 =?utf-8?B?aFNKeU1MQis5MHREWUZNK0dvSnJrOXZ4Y25lOVhPMkYreWp3UldDR2pmeFRQ?=
 =?utf-8?B?bllrMTJkVmRvMmptNE9Sc3RQQ1piSUxRTVhzVU9lQUJiVGdDNlFRNVZ6Z3Fj?=
 =?utf-8?B?aWJKNTNxZldnN0xlaCtxL25oTTZpNWovQlA2eDVhcW1NZFkrMUZsSWplbXZz?=
 =?utf-8?B?Qkg2V3dBY0RpMFZObTlPZlpXVlVocy9CbktSM3UwclE2UGMxcDh4c0tmb3kr?=
 =?utf-8?B?N0FiM3F2dWg4cGFaU1Z2eDdqeHBvejAydm5RSG0zN3NPS25SL0VDY3RwRW9o?=
 =?utf-8?B?S1lkUmJBbGorNzdYazIrRFV0WXp3UnFmZTljeUlBaHhhU0lCbzFEMXRjQkpa?=
 =?utf-8?B?cW1ZUk0xMDBoL1N4czVXNnA1Yk5udG84aUd2WXY1Q3JteElvWXRiR2NqeU5M?=
 =?utf-8?B?WHhaK2VJWWxSRlBacjNoTmRsekhUS2xHWWZUR1dsMkRlWUs4TzZJN245Ylho?=
 =?utf-8?B?VzFqMFdaUGFQWXIwL0YrdG5hVHQzK3FBWnY0c283MEd2VVloTnR1K29ORHFU?=
 =?utf-8?B?S2E3U1Q4b2JaR1d4YmhvK2xHZmxLMjRrb3kvV21pWVV1UkRKc1ZHOTMzOUV5?=
 =?utf-8?B?aFJSY1N2aCtyL1I1dG9wV3lONThpS0dXbm5nN1ppcEUyMGJBT1VTTU93ZnI2?=
 =?utf-8?B?aFhqQmpkbmt0SWNyZVB3WXB3aTB5YWFaMnlqMmdXVVJETXF1aTgyTS9GdkhP?=
 =?utf-8?B?S2VqeTBmSzZtK2JvYmh4SGFNelJKdlNRNUFnSkFjQTBPL09VY0FZRjc4T0lq?=
 =?utf-8?B?WHJ4QnB6Z1gyK0VSc3VacGFoREFyR2RaZ3dlSWE1d3lGVDZJQlZYczUvNHJU?=
 =?utf-8?B?Q3BjN2V6Y0R3SXFpYnhkOU5GZEh3SWRNWHBqcjMxaGd6V3NQRGJOMlNIQkNa?=
 =?utf-8?B?dGpuWUU3RkEzSE5KYUhZcHhNWS9iK1VkYU5YMGZ2NWNIdDdPaElwczhTK1Uy?=
 =?utf-8?B?eHltWHF0UHJqOWRHRTRsS0h1OENrL2MzWHExakVzNGhmUzBNM21NWkk0ekwv?=
 =?utf-8?B?ajNZNDBZUUlRZ2h1ejNtTDBVZ2tvZ3NiK3g0R1JSQ0lrL2J6TklDbmV0N25p?=
 =?utf-8?B?dUYrRE84b0xGaS84YVZEc3RPbXAyNko4eUpmUk1KcHpQc2JFSm1PZVZIWktJ?=
 =?utf-8?B?SjQ4Y0lLQWpMS1l5ZkVuY2FYcTdQRUQvWStLSUl3ZWFPYTFIclJQZHovdy9W?=
 =?utf-8?B?N3ZmdFlEZHBBd3dDZFVDTUVJUjV4UEM2NDlDUVQ3alJFUStEOW1mc1NzTjFz?=
 =?utf-8?B?VXZoSnBRZno1ams2SmtOZkdJZVplRFBFOEFzaW16YmsyYlF4eFp4UXFWT0FC?=
 =?utf-8?B?NVlFUnBFTDJzTm5iMEtOUmtDODJIb2ZmQ0JrYXNFcHl4UlgyOVZDNG5BZUVs?=
 =?utf-8?B?S213eHd6QmkzRUlOZ0VFdWwxMXBKL1FMZktRcEtodmJERFlBcldLMURmVkZN?=
 =?utf-8?B?c012QXpmNjVZb0RWTTkvU0pxTk5jUVM2QXNCWklnL2l0QjgxSnlmbVUzeFpV?=
 =?utf-8?B?TC9oQVo3M3ViT0xlT3NUSzZVSXhBRVhtQnBNMktBSlRva3k4UGxxQnhsbURD?=
 =?utf-8?B?bzY2djNZczFtMGxSWTRwWVB2ckc5VWU2SFlsYzV4Mjc3WkNVQlMyY3BqYUp5?=
 =?utf-8?B?U1ZYZjY3MExnRnZFN3A1ZkI2YnNVZnlwZk9VTEVpbjZIbnBDUmlNVDFzdVY5?=
 =?utf-8?B?c2ZPNEV0Nkd4cjI1VG1iQUlETlZ1cHZGdzVJQUpRVDZaNjhTZjNGcW11dnVl?=
 =?utf-8?B?cXU3emM2ZVNlVWwxcy9kSXFHd3JOOWc3M2lSbzNyMkxZWHA2RUFhbW8vcU1i?=
 =?utf-8?B?bnFRUENhWmIvOTZJanBqQ0gvTkk2K3NwTDlOUGJHUGFmNTYrc2dGdUdCTmVH?=
 =?utf-8?B?NUtucFMwUENYREQ0ZW5PeEQwZHNidEdFY1FVU0lWQkI0bVdPajlnSVRzOHBr?=
 =?utf-8?B?emdZb1JBbGhqc1E5Q0N1bm12RjFvUGNrbkVKeTNiUFJ1QnE1dGxDS055Ukxn?=
 =?utf-8?B?N0ozTjdoRWJXUnlHN3orRytqNTlKZCtEeGJyTVhqRVVzYnY4M3NKU2lWNDJp?=
 =?utf-8?Q?6NRaFdQgWxAPHcdvqs4zGyIvW5SWf3h/YXB+3yddHVSs?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f957f-325d-4fa3-56d0-08dd5999427d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:13.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pIQm+9NLlqUuiRGQZnvPzdAkOjJ7zjFaITpUXUopnYFKs+DycvG+fhT8yj+dePm3rwhweQpDKATQ18fnX5jMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-Proofpoint-GUID: EXZZECXiA8LbGesOboLMfnOg1FNXpKcB
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c46fb0 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=OlggIWMgOj6OOkBI_M4A:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: EXZZECXiA8LbGesOboLMfnOg1FNXpKcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_04,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503020120

SXQgaXMgcG9zc2libGUgdG8gdXNlIG5sODAyMTEgdG8gcmVxdWVzdCB0byB0aGUgZHJpdmVyIHRv
IGRvIGFsbG93IHRoZQpyZXF1aXJlZCBidXMgY29uZmlndXJhdGlvbiB0byB3YWtlLXVwIHRoZSBo
b3N0LgoKVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXF1aXJlZCBBUEkgZm9yIG5sODAyMTEu
CgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFi
cy5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaCAgICAgIHwg
IDEgKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgIDggKysr
KysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jICB8ICA4ICsr
KysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYyAgICAgfCAgMSAr
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jICAgICAgfCAxMCArKysrKysr
KysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICAgICAgfCAgMSArCiA2
IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1cy5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9idXMuaAppbmRleCBjY2FkZmRkNjg3M2MuLjc5ZWRhZWYyMDg4MSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXMuaAorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L2J1cy5oCkBAIC0yOCw2ICsyOCw3IEBAIHN0cnVjdCB3ZnhfaHdi
dXNfb3BzIHsKIAl2b2lkICgqbG9jaykodm9pZCAqYnVzX3ByaXYpOwogCXZvaWQgKCp1bmxvY2sp
KHZvaWQgKmJ1c19wcml2KTsKIAlzaXplX3QgKCphbGlnbl9zaXplKSh2b2lkICpidXNfcHJpdiwg
c2l6ZV90IHNpemUpOworCXZvaWQgKCpzZXRfd2FrZXVwKSh2b2lkICpwcml2LCBib29sIGVuYWJs
ZWQpOwogfTsKIAogZXh0ZXJuIHN0cnVjdCBzZGlvX2RyaXZlciB3Znhfc2Rpb19kcml2ZXI7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMKaW5kZXggYmQ4ZTFmZmI2
MWJiLi41NTQwZjJjNjYwNzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1
c19zZGlvLmMKQEAgLTE3Myw2ICsxNzMsMTMgQEAgc3RhdGljIHNpemVfdCB3Znhfc2Rpb19hbGln
bl9zaXplKHZvaWQgKnByaXYsIHNpemVfdCBzaXplKQogCXJldHVybiBzZGlvX2FsaWduX3NpemUo
YnVzLT5mdW5jLCBzaXplKTsKIH0KIAorc3RhdGljIHZvaWQgd2Z4X3NkaW9fc2V0X3dha2V1cCh2
b2lkICpwcml2LCBib29sIGVuYWJsZWQpCit7CisJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cyA9
IHByaXY7CisKKwlkZXZpY2Vfc2V0X3dha2V1cF9lbmFibGUoJmJ1cy0+ZnVuYy0+ZGV2LCBlbmFi
bGVkKTsKK30KKwogc3RhdGljIGNvbnN0IHN0cnVjdCB3ZnhfaHdidXNfb3BzIHdmeF9zZGlvX2h3
YnVzX29wcyA9IHsKIAkuY29weV9mcm9tX2lvICAgID0gd2Z4X3NkaW9fY29weV9mcm9tX2lvLAog
CS5jb3B5X3RvX2lvICAgICAgPSB3Znhfc2Rpb19jb3B5X3RvX2lvLApAQCAtMTgxLDYgKzE4OCw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgd2Z4X2h3YnVzX29wcyB3Znhfc2Rpb19od2J1c19vcHMg
PSB7CiAJLmxvY2sgICAgICAgICAgICA9IHdmeF9zZGlvX2xvY2ssCiAJLnVubG9jayAgICAgICAg
ICA9IHdmeF9zZGlvX3VubG9jaywKIAkuYWxpZ25fc2l6ZSAgICAgID0gd2Z4X3NkaW9fYWxpZ25f
c2l6ZSwKKwkuc2V0X3dha2V1cCAgICAgID0gd2Z4X3NkaW9fc2V0X3dha2V1cCwKIH07CiAKIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHdmeF9zZGlvX29mX21hdGNoW10gPSB7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCmluZGV4IDFkNmJmMzUyNWY0
ZS4uMjU3YmMzY2QxMTk3IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L2J1c19zcGkuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
cGkuYwpAQCAtMTgwLDYgKzE4MCwxMyBAQCBzdGF0aWMgc2l6ZV90IHdmeF9zcGlfYWxpZ25fc2l6
ZSh2b2lkICpwcml2LCBzaXplX3Qgc2l6ZSkKIAlyZXR1cm4gQUxJR04oc2l6ZSwgNCk7CiB9CiAK
K3N0YXRpYyB2b2lkIHdmeF9zcGlfc2V0X3dha2V1cCh2b2lkICpwcml2LCBib29sIGVuYWJsZWQp
Cit7CisJc3RydWN0IHdmeF9zcGlfcHJpdiAqYnVzID0gcHJpdjsKKworCWRldmljZV9zZXRfd2Fr
ZXVwX2VuYWJsZSgmYnVzLT5mdW5jLT5kZXYsIGVuYWJsZWQpOworfQorCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHdmeF9od2J1c19vcHMgd2Z4X3NwaV9od2J1c19vcHMgPSB7CiAJLmNvcHlfZnJvbV9p
byAgICA9IHdmeF9zcGlfY29weV9mcm9tX2lvLAogCS5jb3B5X3RvX2lvICAgICAgPSB3Znhfc3Bp
X2NvcHlfdG9faW8sCkBAIC0xODgsNiArMTk1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB3Znhf
aHdidXNfb3BzIHdmeF9zcGlfaHdidXNfb3BzID0gewogCS5sb2NrICAgICAgICAgICAgPSB3Znhf
c3BpX2xvY2ssCiAJLnVubG9jayAgICAgICAgICA9IHdmeF9zcGlfdW5sb2NrLAogCS5hbGlnbl9z
aXplICAgICAgPSB3Znhfc3BpX2FsaWduX3NpemUsCisJLnNldF93YWtldXAgICAgICA9IHdmeF9z
cGlfc2V0X3dha2V1cCwKIH07CiAKIHN0YXRpYyBpbnQgd2Z4X3NwaV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
bWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMKaW5kZXggNjI1
ODY3ODZhNDVjLi5iZDBjZjRkMjllNWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
bWFpbi5jCkBAIC0xNjAsNiArMTYwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
b3BzIHdmeF9vcHMgPSB7CiAjaWZkZWYgQ09ORklHX1BNCiAJLnN1c3BlbmQgICAgICAgICAgICAg
ICAgID0gd2Z4X3N1c3BlbmQsCiAJLnJlc3VtZSAgICAgICAgICAgICAgICAgID0gd2Z4X3Jlc3Vt
ZSwKKwkuc2V0X3dha2V1cCAgICAgICAgICAgICAgPSB3Znhfc2V0X3dha2V1cCwKICNlbmRpZgog
fTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKaW5kZXggOWUwNmY4YjhiOTBk
Li5lOTViOWRlZDE3ZDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAt
MTAsNiArMTAsNyBAQAogCiAjaW5jbHVkZSAic3RhLmgiCiAjaW5jbHVkZSAid2Z4LmgiCisjaW5j
bHVkZSAiYnVzLmgiCiAjaW5jbHVkZSAiZndpby5oIgogI2luY2x1ZGUgImJoLmgiCiAjaW5jbHVk
ZSAia2V5LmgiCkBAIC04MTYsNiArODE3LDE1IEBAIGludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3KQogewogCXJldHVybiAwOwogfQorCit2b2lkIHdmeF9zZXRfd2FrZXVwKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBib29sIGVuYWJsZWQpCit7CisJc3RydWN0IHdmeF9kZXYg
KndkZXYgPSBody0+cHJpdjsKKworCWlmIChlbmFibGVkKQorCQlkZXZfaW5mbyh3ZGV2LT5kZXYs
ICJzdXBwb3J0IGZvciBXb1dMQU4gaXMgZXhwZXJpbWVudGFsXG4iKTsKKwl3ZGV2LT5od2J1c19v
cHMtPnNldF93YWtldXAod2Rldi0+aHdidXNfcHJpdiwgZW5hYmxlZCk7Cit9CiAjZW5kaWYKIAog
aW50IHdmeF9zdGFydChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9z
aWxhYnMvd2Z4L3N0YS5oCmluZGV4IDcwY2NjOGNiN2VjNy4uODcwMmVlZDUyNjdmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKQEAgLTU4LDYgKzU4LDcgQEAgdm9pZCB3Znhf
dW5hc3NpZ25fdmlmX2NoYW5jdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYKIAkJCSAgICAgIHN0cnVjdCBpZWVlODAyMTFfY2hhbmN0eF9jb25mICpj
b25mKTsKIGludCB3Znhfc3VzcGVuZChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGNm
ZzgwMjExX3dvd2xhbiAqd293bGFuKTsKIGludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3KTsKK3ZvaWQgd2Z4X3NldF93YWtldXAoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIGJv
b2wgZW5hYmxlZCk7CiAKIC8qIEhhcmR3YXJlIEFQSSBDYWxsYmFja3MgKi8KIHZvaWQgd2Z4X2Nv
b2xpbmdfdGltZW91dF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7Ci0tIAoyLjM5LjUK
Cg==

