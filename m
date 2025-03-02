Return-Path: <linux-wireless+bounces-19666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D2A4B287
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D0D3A8354
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6B1E522;
	Sun,  2 Mar 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="sXKrhOpm";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Gzorqp3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780411DF27C;
	Sun,  2 Mar 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740928090; cv=fail; b=BbVrNkz26Epsq5QHrgJFcW3m9BP8PePoFEEy6OTPdaSwZnSMSz/T/pcB/yMpHybCp/RBYZ5meyIoYn2TJrEf5nHdtX7d77cXo3vUNTG5DvU6WX3UhutFMBrbKXGr+BsRceivh+CA7fzn+1mfoD8rXRfY45Fm2pl13i2hwyirUMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740928090; c=relaxed/simple;
	bh=6UmdweTbepTNevVyEOrLmWW/3oI+yx9K5hTh7FFK2qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyONrSn8tbV0Z3/5jbfz9XCpBNHyuTDdSjRcMx3swcLsgHSufd2req0LmiDHaqpMvEvTkqcBP9terVnGI2guJ9ZgMK4Y+Gpg1h2We+DJfH7i6n93oCGhtjNKKXOvSwNM2vITh6+sUgX/CSxMxBtIcLcREvpZc4UnGlK+J+KGh4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=sXKrhOpm; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Gzorqp3X; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522DawgP009523;
	Sun, 2 Mar 2025 08:48:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=6UmdweTbepTNevVyEOrLmWW/3oI+yx9K5hTh7FFK2qo=; b=sXKrhOpmtbFu
	GFNcM8vY/PtNTqAk0VZBmHgVCTX7kFDwJRZ35aZUCFol+rnZaCc2bw1PEVDgXOrd
	L+F0vmCgClEVlM6lHbw8EDkU3riprF2zhjDQ7TvyhYq4Bo0pFc/jfwHMMm42ny7l
	vIR3tVUxx1k0nyb9u0VW/kKKMs6gVAZdaglDC7Ld8KImHOT9EyOy9rlQBf8dquwL
	2PxL+vKcJUkGxoWD8Xce0y36OcMFKF7xsyou87R66t+Nqvh5tXvRWAymB+fo+I83
	flZWiWlLJX9UR5WAsygBVCF48CQA+Salj3mHaU+DJK58zJFYXWjL1ITpzSrzA99M
	g7zHzz2law==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegh96n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 08:48:14 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqHe7EXqU5iJM5BKTf+TA1bJAgsf8EA8n2FAjfuSk74BsbGrzg3KSnl+NPsTurIFeiwttmPxt8Hc33ivQIRINQWFS0T5Y8Xl81iuri4DGmIIpYbdlXa1r38VYMHD0OKn6dm7bIFGtrjqNMkiV3hBVNEAFv/H6TmSQ4RFPlXFnfaeVnfuecv90HPRtwk+C6thlljOULQ1sE5reWCUoWOqJfPJiWb3nMV9hm2kT8FpM6MEGeR2w9x1YAXNVvyvCIvT6ixvfU39mQQr/Pq/vRsSL2lKU6fCffBeMFugeQ94j1XvRyf3TfgzdSNGqniMgkqvOzdfDR3kLMZ2rzhJ4v+5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UmdweTbepTNevVyEOrLmWW/3oI+yx9K5hTh7FFK2qo=;
 b=yaMBCfsWo3FTmYP6qMAw8RUmgsItscV7lBvdQ0R9YmDtU4+OaTIapsyVIRsHIM5BYW3VZt68F312NR4xl/1MvmMuqIrrN5jcB56ENj14il5ijwjhNiKwW7M5/FudWn6xRXFmUL1uR1oU7lIQAsHlCr+46G2oa7xlmACR6eMLx+U+PPBWehg/Se7sThkP900eRgmUKHDq9oaDeeC9w3QgioMfJ8Feuyjytq1S3vjbc9xljH89O/TMT9VU5YSvU/EZqPMzrU8A5ua0oJ4P+8jWar7sNWm6nhsykTI/AvuBunsx8mBXLP7G+HJguk6rTogxSYlnmQR9K4pdxnALBbS+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UmdweTbepTNevVyEOrLmWW/3oI+yx9K5hTh7FFK2qo=;
 b=Gzorqp3XDGyfLgg9B7aWErqrakCBRxs0kOA29tcAshiJO7eV+rwmfJCsT7XcHWVajp2EMWN9M7iyPorbrGl3EtWptCAJsuKvQNTMGEk/yYctbE5FBrqx48WDt07dtEKLieeoOPL2iIkEA8C12M138xdqdC56s6DtLGQWHMRpBAM=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 14:48:11 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:10 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v2 2/5] wifi: wfx: declare support for WoWLAN
Date: Sun,  2 Mar 2025 15:47:28 +0100
Message-Id: <20250302144731.117409-3-jerome.pouiller@silabs.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: c3427afd-7199-4394-6246-08dd599940cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0UwVWlaay85TlNZNFdDQVZ6UEZCTFlZSmg2TG9iN2ZXOVlXdlJhNC8wU1Rt?=
 =?utf-8?B?UllHNnU1K1N0OSsrRjEzL0RHS0dPK1RQY0NJZFhJdWZWQ1NKRWc4YkwxYzJY?=
 =?utf-8?B?YVE2L2NzRHhiQVBobVJnMXZWUi9aWklFMTVrSWM1YVVLWEhRcTlWbDlGa0VN?=
 =?utf-8?B?SVNzbGxXcTQ5dE1SMU1Dc1haUWpLQkxJWFhCUEc0d3RDYjBwMmdTY1l1bDZp?=
 =?utf-8?B?SzJOc1kxN202WHNmT2podnJOTVN6US82ZWVEZnRhZmpGSGVwNGJ2RHVGL2ky?=
 =?utf-8?B?VlVDMDcvUHVmTjRIVjNjTkNIbTFDN3d4WmpwM25Nb3h6NEZaNlAzWVArd05w?=
 =?utf-8?B?ZWVEbVFKeU01SmtpblM2MWErNWNkR1l6emZJYUUvQm1xOGFqbUNOZFFHTXBS?=
 =?utf-8?B?TGtuTXlRbEJFVmt1cTZBRWVVZ0x2OUFycWJoUDlDNmhXUmdZOEdtZFl6U2g3?=
 =?utf-8?B?Q3hjb0h6bzBPTWQrWUt4NjVaWDF2ZnlTOEtMd0RYS3pXc1BCdlp0RjRzL0VQ?=
 =?utf-8?B?bnZUdnhydnA4NVJiK1l5ckVOWTdaNTZ5eHo0aEg2M2V3YmhxaUNWNEV3aStJ?=
 =?utf-8?B?ZnMvSEl1RVRXaUdJdklTc1Vjc1JzeUdialB0R1JTZnByNkpUS2ttWWRwSko2?=
 =?utf-8?B?KzdXNE82Z3RVcUdKdGU0eUpKaDVpRS9jQjUyRVFWZHRZRC9ONFQyMEozVE1B?=
 =?utf-8?B?L2lNNTNoVjg5c1FMVVAzQVEvRUM1QWZXb2NpOTNBbTdGK1IxWkxadUZ6UEJn?=
 =?utf-8?B?WUdSRkoraHNPQ3NJN2tYcWFNK0RVU1pjcWkyOE5kY3JMU0psbFNVMUxuUFBO?=
 =?utf-8?B?V0dVempibzFTaTFXQlVqNEtWUEFQeWFQZXY4alpnaENIWTREbStTTjlxUEMw?=
 =?utf-8?B?TlprdzllVEZYc1MwNUc1bmMxdlRXTzd3UXUxb2VTN1VHcVNpR3R2NERNVlNr?=
 =?utf-8?B?U2gvSEpBbUt6alZlYTl5SERDWFJ1b1pIUzdaMk5vb2RTVkEyUGw2WmVQQ29D?=
 =?utf-8?B?SE1TTXg2aHBXWjRoVjdTVS9pdW5neGh0U3NWYk1Celg3NGZZandUaHZUajZk?=
 =?utf-8?B?UG1MUWo1cUJnajAzVHhFS2V6cXZoVktXOWRrcmh3azBPTW1wRVZwOXc1MFF5?=
 =?utf-8?B?V1FOdEl1YWJUY2pjL3NiZjZuaU1hVk9CaC9Mc0hFUFhmTUdJU0svaU1JT3My?=
 =?utf-8?B?ekptNHkzcm5DcGJvUkpBS2UzYVhjZkU4T25pRE54WlpsRUM3eUNIRXF6V2Zi?=
 =?utf-8?B?aVZmaHM2WEswZy8vdFc3U1lOYVpYUTZnQzNNNjRTNTJmNU1rU3dVWkdzcFM0?=
 =?utf-8?B?aEZVakRCdk4vb0dzZDJPTlRHbFEzSDlHRkpaN3RDQ0VzYVovOUpRWk1TaUtu?=
 =?utf-8?B?R3FCYkVqOStYbGcxWmJnaGErNUE2d1lmR3BXbGU3VU44QXQrUEMrMUNKTnZJ?=
 =?utf-8?B?ajdHV0JLblErZEFDZ1FPdlJabHo1L2pQald6WnM3aHlWWVYxRGw2VlRRZFBx?=
 =?utf-8?B?MnBhZTltUWxWTkgwVzVieUJoc3BtMGhMbjc0NWxJZG5KVTZPcSsvN0tOMmNn?=
 =?utf-8?B?NzVoRGxPTFpKaEN1Q1RLY3lFOFZHSzJYMTladk5vbEU3YXAvYStpWlFQRmVv?=
 =?utf-8?B?dk9NUFFPem5oS3RqK2FOcm01OFIrYjdMVXpZN1ZnSE9DaEJucXVQUTJhcFcv?=
 =?utf-8?B?RmFldm85RG8zQ2FvanhPSFFMS2dFR1hkcXVGYWpPRWc5TjZDNW1VTi9hSGNF?=
 =?utf-8?B?by9NVlZMcWFOcVlyM2N2TTJ1NGc0MkVnc2xpdlZXQTJVRm5jYVZjTFlmbDVK?=
 =?utf-8?B?bHNtdjg4U1o5Z3hXVS9tVXQxdlNiZkcyV3Q3NWYxNlJqL09TMWlrVm4vazhs?=
 =?utf-8?Q?/ckuN05/JvhVO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkt4K2RFR0d2NTNKcUtkSkVVVkhsblFVOENjTW92UkxXTGl0dXVnQ2lQM3Jk?=
 =?utf-8?B?NytSL1ltQUkrMFhkQmxZQUZYRjFvSEhxYUphd3JaQ3lveGRCZ1FMMEdubDBl?=
 =?utf-8?B?cytaRzlFZVAxenorNlU2Nzg3cTdOZFlBbTlqZlpCMG10aFRzVndIQmU4ZXZQ?=
 =?utf-8?B?Rk9hWDhXcXZMZWFtNjJTUk1wSE4walBxWUU3cjRoWFRrS3Q5eTN3M0QyaW1Q?=
 =?utf-8?B?dlB0RDJ3UUZlOVFvTHhQeWVKemxIQ1A5SjYyYWpUM3BkQllTSWRQZ041SGF3?=
 =?utf-8?B?WTJsOU0vNkxwUTJMd3hZdFhMR3I2cHQ3Vm9rR0l0dEk3NWlCUTRVN1BOc0FX?=
 =?utf-8?B?ckJlRzg4eHB3b2gxMmxPeVJjQ0xHZVVUaGIxeTZDSmF0elFVTngya2liNmRR?=
 =?utf-8?B?RExweDZNYVNxMHFYZFBSdFB6WkRkMHg0b0hTSnNNRWpnYmNFeVF3R3lxNkww?=
 =?utf-8?B?eUZKQUd3a2RIUVRjUlBEVUdXOXZVVXVqQzJrWGNXY2hwdm5jZzlidUxtakFa?=
 =?utf-8?B?bko0My91RTNKVG1QaTB0MVMrZkxVbGZSS2M4eXdNU2x1czA1Q0ZPanQzT0c5?=
 =?utf-8?B?MktUenRSU2JoTjgrYUo0enVNUVF5c1hGRTdSbk1mNXhxODRGRHFqMzlObHln?=
 =?utf-8?B?UEo1VjZESStzdFd1cGx6SnNrN2RZTmhFUVpzd2tyZ093bDRDMDVzb29oOERP?=
 =?utf-8?B?b3VEU1dGUzE5aEVrYjY5VXNzRXJlb1BHeUJHbmR3bjRqQnhWUTZINzlBUmcr?=
 =?utf-8?B?Vy9XdkVnZ3BCZW5wREU5T0UvRTFGRDFNLzN6ZVgwcFhtNzlMeTBjTnlmOCtx?=
 =?utf-8?B?OW5ndmJnZHNTQVZxcDJkQVcyeXJSRkpXT0pPa1FlOVZVRytzbWtId1ZwTEFp?=
 =?utf-8?B?SVppdGNBYldXbzJHZnovb2lBSVY1djZtaGJ0UFRSYlZpSUpyVnVwS2w3TVVv?=
 =?utf-8?B?T1dwN1VVNGYxeXU1L0dVRkFZMGQyckFSYjhIaFRzeUV4R3VBdVV0RTNZMzZn?=
 =?utf-8?B?dHN1Q29FRVd3R1M1M1lxb3BlVmJadWR2Mjd6Y0Rna1dHRXdjclJTM3RtTktX?=
 =?utf-8?B?bjIrQ1Q3WGc1dk4ySkpBMVBHaWZZeS9Ed3NMOEQ1c29DVnB6M1Y1UFVaaFhi?=
 =?utf-8?B?RWNJMFpKL2cwSUlOcU1mckVDaWUyQ3ZRTWtra1ZIMFY4MjdkcTNoMmdVOWpn?=
 =?utf-8?B?d2FMaWdSMjlXZ0xET3N0WFZvWXJpSWc4eWRjZWsvekRsSWFic1NpNEFQK3R0?=
 =?utf-8?B?LzhBM2E5Y2xkUUVpVk15dU9TUjlJNWFpOFBpb2JhYnRlZU0zUFRSRmI0N2JI?=
 =?utf-8?B?WGNFbUNSWmlPYllWOTY1UWxweTVoM0RuM2VENytLbHBqTjNwdHY3Zk41bWwy?=
 =?utf-8?B?TTBMS0tFb0pQeEFsMVR1bHRrZlNEb3p4NytTY243MFdleFV2RjNVQ012U0RS?=
 =?utf-8?B?OGVpWWN4c0pIa3NSdEc5bjZJbXA5WktrNHRJTTMycTB4OXo0WStPV203enhI?=
 =?utf-8?B?L1JRWlNuUzRSTWJmS0RlaDhnbDVNSEZ2Ti9mQ0JzSDRSYVVTMEVQSWhKczJk?=
 =?utf-8?B?Y0ZaSm9uMEExUzdjZEZTb2lWaVVMRkdCRHFlcjl3SndFbTQ0dHJscnB2Sm5m?=
 =?utf-8?B?V1hrdEdhVkNGK2dyWVZpcWRMT3pyMStHL1pKSks2N1gxOEVYK2NkWWNsY3p4?=
 =?utf-8?B?SWxtM1pwS3VlM3ljaituRy93RzFud1c0aTdQa2lLbXBITXJEdHhkR1hqc2J2?=
 =?utf-8?B?WDIvWEsyQmF6R2pNdzAzdWVPdTFaMHU4dWdvNytveXFLZWo3NkVWOThYL2lm?=
 =?utf-8?B?NFFycnErMzRpZmFFb1lwcVNiYWo2RE5wZWRsUXgvQndLQk0wTzNCZ0FaNzdC?=
 =?utf-8?B?RzFnSXZPbmNjSDBhdDVUZlhFTGo0d1ZQMFBSL1FjZnF2Z1ErTm8wSlJadEt1?=
 =?utf-8?B?akVjMmE1eGNQK2FWTzhFcmZrTkEvaVl3VThkM0wyS3Z0UVZCRkxLUmpFZVp0?=
 =?utf-8?B?VlYrZ1M0ekxETVVJMGI3bmdWNktqZFFkdUFnVUFqUEU1aE9RdWwzZGxvSm1u?=
 =?utf-8?B?M0ZyeTh0a3ZBdXpnd1dENENScWl3bVhpZDZydGRkelZjcm91R3lOS3dkWnlY?=
 =?utf-8?B?bHlUY0tBMGliVDg4SkYrNGtIQlhsNGYxZUhaenZrMjd1Y0ViYzNyOXI0MGRm?=
 =?utf-8?Q?BKq4TlnPStjG4HuhBadnVTF0j8cH71pgHydrIwb71dNP?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3427afd-7199-4394-6246-08dd599940cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:10.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eyLyI1pCTixEQy4x4IxzoOsbt/HJic/wVVtMsYDJ1SErix9OZsu5m5W+rfsG/X2CsEY0637ocC5p6UbH4hOkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-Proofpoint-GUID: LZTUvNehKiGO-JIlxV6NyRgsY5HtKskQ
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c46fae cx=c_pps a=CmjB6Nkc3E8pi8fe8piFzA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=JJM1JWLTSaUvPDQ1ZrsA:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: LZTUvNehKiGO-JIlxV6NyRgsY5HtKskQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_04,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503020120

V0YyMDAgaXMgYWJsZSB0byBrZWVwIHRoZSBjb25uZWN0aW9uIHdpdGggdGhlIEFQIGFsaXZlIHdo
aWxlIHRoZSBob3N0IGlzCmFzbGVlcC4gU28sIGxldCdzIGV4cG9zZSB0aGlzIGNhcGFiaWxpdHkg
dG8gdGhlIHVzZXIuCgpGb3Igbm93LCB3ZSBkb24ndCBwcm92aWRlIGFueSB3YXkgdG8gY29udHJv
bCB0aGUgZGV2aWNlIGZpbHRlcmluZwpmZWF0dXJlcy4gVGhlIHVzZXIgaGFzIHRvIGFsbG93IHdh
a2UtdXAgb24gYW55IHJlY2VpdmVkIHBhY2tldHMgYW5kIG9uCmRpc2Nvbm5lY3Rpb25zLgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jIHwgMTEgKysrKysr
KysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgIHwgMTUgKysrKysr
KysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICB8ICAyICsr
CiAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvbWFpbi5jCmluZGV4IDY0NDQxYzhiYzQ2MC4uNjI1ODY3ODZhNDVjIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYworKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L21haW4uYwpAQCAtMTIxLDYgKzEyMSwxMCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9pZmFjZV9jb21iaW5hdGlvbiB3ZnhfaWZhY2VfY29t
YmluYXRpb25zW10gPSB7CiAJfQogfTsKIAorc3RhdGljIGNvbnN0IHN0cnVjdCB3aXBoeV93b3ds
YW5fc3VwcG9ydCB3Znhfd293bGFuX3N1cHBvcnQgPSB7CisJLmZsYWdzID0gV0lQSFlfV09XTEFO
X0FOWSB8IFdJUEhZX1dPV0xBTl9ESVNDT05ORUNULAorfTsKKwogc3RhdGljIGNvbnN0IHN0cnVj
dCBpZWVlODAyMTFfb3BzIHdmeF9vcHMgPSB7CiAJLnN0YXJ0ICAgICAgICAgICAgICAgICAgID0g
d2Z4X3N0YXJ0LAogCS5zdG9wICAgICAgICAgICAgICAgICAgICA9IHdmeF9zdG9wLApAQCAtMTUz
LDYgKzE1NywxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9vcHMgd2Z4X29wcyA9
IHsKIAkudW5hc3NpZ25fdmlmX2NoYW5jdHggICAgPSB3ZnhfdW5hc3NpZ25fdmlmX2NoYW5jdHgs
CiAJLnJlbWFpbl9vbl9jaGFubmVsICAgICAgID0gd2Z4X3JlbWFpbl9vbl9jaGFubmVsLAogCS5j
YW5jZWxfcmVtYWluX29uX2NoYW5uZWwgPSB3ZnhfY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsLAor
I2lmZGVmIENPTkZJR19QTQorCS5zdXNwZW5kICAgICAgICAgICAgICAgICA9IHdmeF9zdXNwZW5k
LAorCS5yZXN1bWUgICAgICAgICAgICAgICAgICA9IHdmeF9yZXN1bWUsCisjZW5kaWYKIH07CiAK
IGJvb2wgd2Z4X2FwaV9vbGRlcl90aGFuKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBpbnQgbWFqb3Is
IGludCBtaW5vcikKQEAgLTI4OSw2ICsyOTcsOSBAQCBzdHJ1Y3Qgd2Z4X2RldiAqd2Z4X2luaXRf
Y29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IHdmeF9wbGF0Zm9ybV9kYQog
CQkJCQlOTDgwMjExX1BST0JFX1JFU1BfT0ZGTE9BRF9TVVBQT1JUX1AyUCB8CiAJCQkJCU5MODAy
MTFfUFJPQkVfUkVTUF9PRkZMT0FEX1NVUFBPUlRfODAyMTFVOwogCWh3LT53aXBoeS0+ZmVhdHVy
ZXMgfD0gTkw4MDIxMV9GRUFUVVJFX0FQX1NDQU47CisjaWZkZWYgQ09ORklHX1BNCisJaHctPndp
cGh5LT53b3dsYW4gPSAmd2Z4X3dvd2xhbl9zdXBwb3J0OworI2VuZGlmCiAJaHctPndpcGh5LT5m
bGFncyB8PSBXSVBIWV9GTEFHX0FQX1BST0JFX1JFU1BfT0ZGTE9BRDsKIAlody0+d2lwaHktPmZs
YWdzIHw9IFdJUEhZX0ZMQUdfQVBfVUFQU0Q7CiAJaHctPndpcGh5LT5tYXhfcmVtYWluX29uX2No
YW5uZWxfZHVyYXRpb24gPSA1MDAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
c2lsYWJzL3dmeC9zdGEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMK
aW5kZXggN2MwNDgxMGRiZjNkLi45ZTA2ZjhiOGI5MGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9zdGEuYwpAQCAtODAzLDYgKzgwMywyMSBAQCB2b2lkIHdmeF9yZW1vdmVfaW50ZXJm
YWNlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKQog
CX0KIH0KIAorI2lmZGVmIENPTkZJR19QTQoraW50IHdmeF9zdXNwZW5kKHN0cnVjdCBpZWVlODAy
MTFfaHcgKmh3LCBzdHJ1Y3QgY2ZnODAyMTFfd293bGFuICp3b3dsYW4pCit7CisJLyogRklYTUU6
IGhhcmR3YXJlIGFsc28gc3VwcG9ydCBXSVBIWV9XT1dMQU5fTUFHSUNfUEtUIGFuZCBvdGhlciBm
aWx0ZXJzICovCisJaWYgKCF3b3dsYW4tPmFueSB8fCAhd293bGFuLT5kaXNjb25uZWN0KQorCQly
ZXR1cm4gLUVJTlZBTDsKKwlyZXR1cm4gMDsKK30KKworaW50IHdmeF9yZXN1bWUoc3RydWN0IGll
ZWU4MDIxMV9odyAqaHcpCit7CisJcmV0dXJuIDA7Cit9CisjZW5kaWYKKwogaW50IHdmeF9zdGFy
dChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykKIHsKIAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmggYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9zaWxhYnMvd2Z4L3N0YS5oCmluZGV4IDc4MTdjN2M2ZjNkZC4uNzBjY2M4Y2I3ZWM3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKQEAgLTU2LDYgKzU2LDggQEAgaW50IHdm
eF9hc3NpZ25fdmlmX2NoYW5jdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYsCiB2b2lkIHdmeF91bmFzc2lnbl92aWZfY2hhbmN0eChzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIAkJCSAgICAgIHN0cnVj
dCBpZWVlODAyMTFfYnNzX2NvbmYgKmxpbmtfY29uZiwKIAkJCSAgICAgIHN0cnVjdCBpZWVlODAy
MTFfY2hhbmN0eF9jb25mICpjb25mKTsKK2ludCB3Znhfc3VzcGVuZChzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodywgc3RydWN0IGNmZzgwMjExX3dvd2xhbiAqd293bGFuKTsKK2ludCB3ZnhfcmVzdW1l
KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KTsKIAogLyogSGFyZHdhcmUgQVBJIENhbGxiYWNrcyAq
Lwogdm9pZCB3ZnhfY29vbGluZ190aW1lb3V0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KTsKLS0gCjIuMzkuNQoK

