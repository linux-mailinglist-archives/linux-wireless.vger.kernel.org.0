Return-Path: <linux-wireless+bounces-19766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F5A4E4D1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D488F8A7710
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D65278178;
	Tue,  4 Mar 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="FAFQcEQ9";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="VuMJ/nue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93943278168;
	Tue,  4 Mar 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102373; cv=fail; b=CtVKWnUAb5eVQ476ViusOtwHFhe1iB8McZyGG2Gzc65/nVHcKboFdOviWaQr5UtbDemJC6r8XprjZuLfyx89PDu3JZlHVa+57ud9WYmbBiVJh2uk/oLC/E8K7Ky6sXeapr+aans9Pmq+Q0jBOrGoVuOpoHKEc2ZhPinvRHB0HjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102373; c=relaxed/simple;
	bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Et+xZamds/yNl/282QpH25dfHyRcAkpST8dkywa0rvrEu6HNvvdT8wqB5/xGzk8zhd3wbCfVHudoILCRF++9/yrKT1MwhXvFRP2+SYK3sArXjctWoiAQgv3TdRW91ybm5DItyU/LFUkNGZCu6nd+QG3/7H8BoewuBsJ0tNc9fYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=FAFQcEQ9; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=VuMJ/nue; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248TYa9028076;
	Tue, 4 Mar 2025 09:32:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=; b=FAFQcEQ9JCF6
	Yh0Wu0IXIHkJtZvBAdCuIPYnlRHPamakApIheCjjQt7N3KR8Jhet+30m2/V4yO0z
	CLBklRMUq11kMCLm6tMvHreEBfEFWX9Q7EehbxGbANRB+3rmF4TpMiQEPlM7moay
	/C5xQMqlJFxIXDIeSCm3Bj6T8MW4C8DCXfImhfxXmldhgVPWCGkU5Mkh2yVqR4qU
	1KTLupWVavrDoZ/V6TvzJpmnRR258GaZqBKCTFDGEH7WKbQc8DwQZ2RRynLgi01h
	cdIwaa9mrnEtcz19Xp6WNcaYcS7f7NwUKHND4aqr5wzeSWX41ldQ99U38Uo2lX9H
	Vw/jLLvcZg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegn158-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:32:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yShPtVOaWUNSv3gbFl46gYezMeIxPEK0ABmJvTjn56kzi7+4juNb1Cp5RO8Ne9Hx5eN5J/2DW+XH+dlPZpMUBrhILabRRe2uRJrlReZD3lNlVzMnFgvJDdB+gI26QrXt/v2cGu6DtsX3cXTnJzr3j3SCimJO4JUpZm2ySFMj/yo4MZx5lub+Slo1DwqFjdCtwVrc0wG5aPrxjnysn73pVhBTPwcU6uxr+lpGWKJ7mqhTnwF7EWIX0XfPFxlZmaa87iVsOtqtwySFxQLV2GX+2uCJFKb08jTbiglbmu4vX4osfvec7Gi6WTWxIrQ0TAv3PhUtFEtvmqu9q0aKhvCoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
 b=x17X1dpVgRZMpKbMKwt+pJBp2KaCAGphaaiiG/AuJye6pCjkLD/TEGJhDYx3wmi8weCsHoT74n9+Mt6sf4VC8wKc4y3HY8jk7+FnSAAIha0wziK1QiAYw5lSYkm4Q/4Ag+HJfRO6sQeUofjYW4lydkpCymKAU1YYtKEcNvFVRtXyJFZGKKt8UN49hqSRavMu8lhI4tV+/bZN5l0av0cs415uaKUtP4qDHqU2yIlhGY8NiTJkfOhR73iMz6+MIL+L0gtV0LWkw/sRmshVGpkXpg59UAWS7zYzP63Zuj0sKtg4dYaxPz7Ge3TfEWqD+7rC61clC3qMMN5tirIS9EaBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
 b=VuMJ/nuecSa/TuFt6RV8OU3Pfw2QwA8D7B1XBsEH1b2I5e6p4wW8KH+/tq1IuRH7XHTOtpKc5XQtoIfaVcPb9cC7rEp7U5pxKzT9gGYwOETrZWIxAuH86gQE3PGnbIEom4NwtKC2yHa7P7NPAyBGQlEU7/z05FzulBzzfZ8YvD0=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:32:35 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:35 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v3 1/5] wifi: wfx: align declarations between bus_spi.c and bus_sdio.c
Date: Tue,  4 Mar 2025 16:32:20 +0100
Message-Id: <20250304153224.39083-2-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304153224.39083-1-jerome.pouiller@silabs.com>
References: <20250304153224.39083-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::11) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 3beb7b84-fa94-4ee6-45ce-08dd5b31c980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkJJYnJTT3RsZkZUM2pyaUwxempIenhvTW9TL29PcEZGeFRNSnNCUWsvc0RD?=
 =?utf-8?B?QmVJK3lFMWttc3kxTFNjMFFvU1c1bFNlbnRyV0RRZmZBN3hmMXFQK1gyTXRY?=
 =?utf-8?B?MWc5c0RlU245OGExTmxCMHlIY1U3L25jblcxSjVuczRkLzM1NlFzNnIzYSs3?=
 =?utf-8?B?L2h6NnljMm1NQTgrTE5ESWNjOHBJY0RSbXVyNWVsaDNKb2ZXZTlnUjNnOVFC?=
 =?utf-8?B?WVdUVEhkRUU5bnl2MHVQMytsNmYyN2tnVTg3NmlxN1lqZ0RXQWtpR3VWMHBu?=
 =?utf-8?B?WXpVcXQ1dHZMM2kvc0doTXdkZDJXRjl5cVdna2FSWWVQTUE1RDBpNVlPWG0r?=
 =?utf-8?B?TFIyaXdJUU51cHRTdmtVa2VCTTFyWnJNNVYxRTZSa0tjcW42QllSUE4zMk1j?=
 =?utf-8?B?UGl3bEVxalo3eUFCVnBtWHM5bk16ZkQ5MjdUMExqcTU3U0VsbFV2dTlQdUlT?=
 =?utf-8?B?Lzc4SGRUbDl2aUxuNHQrenVrLzBabTk1OEQ3MW9DMWRkTkhmVUlGN2VCdWFi?=
 =?utf-8?B?cnd3aFk1bS9DOHo0N3hON3FjdWQrakZNbUlranZFN2grN2sxV0pSSHdVaGlK?=
 =?utf-8?B?amhTaHFKZFE2YlNLS2hkR1d4MXVCeENPbHp1bFhMaGhHd1BBbjd2VGRiZkRw?=
 =?utf-8?B?SXB6Y3VuRXcvUGVKKzJwSGJzNjBYK1o2ODNjN2YxOE5VbGt3UG0wR283em9t?=
 =?utf-8?B?b2kvQ25Ma3FXMHBEODdwV0hUSUtLNzJmOTFJTXJreVlYdW01TG9DaUxCMGxn?=
 =?utf-8?B?N3ZPc1NTWWQvRUxlaTlPTmlLTVJqYTlvcEtDbnFPOU94TTRFb0JpQlBNZXFn?=
 =?utf-8?B?M25YaWlFL1ltNTdRbmxaTTh0dEtDWGI2dWRxYmxPMmVDOHFvUUVlM0lhZVpJ?=
 =?utf-8?B?WUR3elpiMi9Xc2t4TUZZZjFoSE9wZHBKOHBBTFFsT1lWR0t5NHRmeFp1QlFa?=
 =?utf-8?B?SjJLalFDcFUwdVJZdjd2TjJZRWhzWEJjUzdoZ0RLUWJIaWxaU3dTQzJabzZU?=
 =?utf-8?B?MGt2bTBvaWN6d2szSGFnQkJ6YjJrRVNrdm5jSFh3OUZjQnlKb1AzREkvTmFL?=
 =?utf-8?B?TmF0K2VEZ1ZuS3RYQkY2M0pSOERkL0dvenJuNXgyZy9ZdDJEdzAzeWhvSnJC?=
 =?utf-8?B?OXROYXVtYnQvWk9NUlMzR3lpemM2dXhhU2tPZHRRenJaTCtPSEk0M3BESGFM?=
 =?utf-8?B?VXRMRlVpa1hqZWRsQ0cxYlI4R3lsc3RDempIZkhxWGRxc3piSTYrRFhKeDdF?=
 =?utf-8?B?SkVDMlQ5bUpKS0pFeVpUbGFpcGZSaS9mQXZmemFJTzQxejJLTUc3L1E0QWtB?=
 =?utf-8?B?VTQyWnZNVElweWszbDVGTit0YUIrd2FkSXlqVGw2MVVQdmoxeXRKWlBMMStF?=
 =?utf-8?B?dUZkTEp4YUJFdTVVcUhlWllySnFEYXJnNXRqaWJnU0NMTjc5c0VQWndrRGt1?=
 =?utf-8?B?MlJGUzZmZk9lOUxJWDhGL2lJcXhXeVJ5YjYzSGJpL0E3OFFVdXEvTEdLNk9i?=
 =?utf-8?B?cnJKM2RxQ20rUDdPL0FveFJQaUcvNURhYnFQNGtSc0xXSjVwS3U3SlpKeUQ5?=
 =?utf-8?B?ZmU3Z3UyWkRqQ1I1TmtlNXdCRXRUNkk3VnVPVFhyNGw4TmhLaW82c3NzTVFl?=
 =?utf-8?B?UFErZGVkQ3JMMDYyS2QyY2FIMmRpeEthaHlrQWxGV2FXUjVxODUzY3laV2xv?=
 =?utf-8?B?NlFFSC9jUVVQS2NYOTc3QjNBYmI4V0VWWklMRzVTN1RSZXhJQkd1ZkRZSkJ1?=
 =?utf-8?B?bUNvOGpkMEpEeld4THR1QTNqc0ZXUmJac2VNUFZORUJOUXVMa3pGMUxkNmZY?=
 =?utf-8?B?RFplQjNWSzMzRXZ6TEVMOERCVHlUc2ZXNjZOOEJCTmpjd0RPY1psSzFmSy82?=
 =?utf-8?B?bGJET0JKQ2pyZ3NNK0FUMnZIclZTdzZ6ZUQ5a2xRclBCbmxlZWVsMTArc3Z3?=
 =?utf-8?Q?wr2nHhvqvmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTlLY003RXJ2WjRDKzVCQmo3NmJKMEFJVUJqN3VVTHF1T2pNRVpTSjNnakdU?=
 =?utf-8?B?Ymk0Szd3bUlBWDd6Mi8rQVVWenN4TUdEVFRnZlZkanFVL253NVZPa1V1Mmtn?=
 =?utf-8?B?TlNFd1dpdHE5dUlOdkUvTnpSKzNaaFkyNllZRGtOdUptVGtlN0o1WXgxaFFU?=
 =?utf-8?B?aHRvdDd1U0pVYzdpKzFkaHhEd2VERjhCdzE5YXk3ZXYwdHIzdVVwZC8xV1VV?=
 =?utf-8?B?SW0rTlhuejIrdWt3aTUwYUlTQWM2Tm1VZEZkMU4xTXZhN0h6MjZzZjlIcGJy?=
 =?utf-8?B?bmxJYUExVXZTR2ttR3VKWi9tVmlqT0YrbUhsY0RUZy9rbDVPd0J1SDFjVWlP?=
 =?utf-8?B?L1pYRC9Jd0pObkdhcU8yckFzN3Z2WTJMU3RXWVdabG9CcUhBb05yYWhCbmx1?=
 =?utf-8?B?aWd0SE4zckhCK1RlM3dLT01pRkdtaDlZRHV0b05iWkVBaXhWWVZMKzMyNVVG?=
 =?utf-8?B?UUozOEJDdlNxNXh2bnBGdHphN1UxZDA5b0w0SE5iSS94SVJSVGRyWThDQnF2?=
 =?utf-8?B?d0g5RmtlMVJVQUR1cTVtK2ZFcEdEUGdjMWhweG9udUN6MUQwbldBM0wvMUtB?=
 =?utf-8?B?YnZBeHEyazEwS3k4cXYxWURtYnFzMG9LSGIxVVM3WForbEJxeUxxOElEYWha?=
 =?utf-8?B?b2dKdVQ2QkQ3L3BZWlpSMmI4UE5DU2JyeUl6U2lxRUplY3hSQ0lRSlBlODU5?=
 =?utf-8?B?UWtOM3dpMTRTSXVYZFNXZEJsckt1RDVMY3kzMXNtV2pORUlXOVdKOTROR1Vx?=
 =?utf-8?B?eUc5NHNlZlYwNllWQjhPMVJYNzBVWHlWb2xBZnhQYm5xZ2hSdnVHYmM3cUw1?=
 =?utf-8?B?QkJjdzA5SFhrdGdNSm9HcWtlN214VDlUUGxqd3gxVEJZTHg5bUtGV3dPWlFm?=
 =?utf-8?B?MEFKQ0VFZ3RkbDJmWjVIL3I3YTI1Q1o5Q2RjdUZRN0UyMkhjdDM5c2FESExF?=
 =?utf-8?B?Rm00RmM4aURBVkQ1enc2RmVvTVpNazNYc2NiWk9MUEhiLzE5ejg0NVo1VlRZ?=
 =?utf-8?B?d2FNRXh0S3lwMnVjc0dTY1pzejlEMytIRnREemcyTHVsVERTWE5KS2Z1Y2VN?=
 =?utf-8?B?ek5PV0IwREpLNmdDK0VhcG9sMWxPM1FWRW41Tk1qV3dOcWU1ZkVzN0U2a3J1?=
 =?utf-8?B?Z0tIRXdCa3V6b3Nwb0tLWU8zWU9idUkzNGhYMHRDWEVZa3FGejFRaUw0ZVZi?=
 =?utf-8?B?WHRSQjZScjNaSGhyY1hBS1NNZFNlQ1MvRDJnbDRBYnh6aTJlUjhlUXIyc2hS?=
 =?utf-8?B?SlpUWURNR2J2S1VJVXovSHA3LzNHbzJ3NWRDa24zV3pVZjdFaWdFV3VnRHYz?=
 =?utf-8?B?bDVPZ1ZPM2dsSDBrdTFESFZ1SXo5ZVBmNDFQbjBWTThzeGV3MStrL1FkQk82?=
 =?utf-8?B?NWdMQXdrYnJDeE9maFJxVlpiSVJIMTEzcGZIVjNLOHdjdDhIeGxacEV4RmEy?=
 =?utf-8?B?V2dTVDdnOGJCSnhJNkxCa1pld1MxZk1UVjhBRFRySDRSYVJtbzZiQk5UOVR3?=
 =?utf-8?B?eTIyN3RkajBGbkVHekFzUlVPcWNScDFsOU92dnBCaDZPdFdtVFNXY3BZQnNM?=
 =?utf-8?B?c2M5OXkvb29WMkQ2VXI3eHpKam5LMWRyQ3c0MXp0TE56L3M4UmJVZWo4RTVP?=
 =?utf-8?B?eHRrMktxMGVQS3o0dW1RMDdXUUdIYldXWldMSlp1Qm0vS1hVLzNoYVZOS1Fj?=
 =?utf-8?B?OWFmR3RnMmtNcHZybDZJVzFUekpmMElXekpXQWNHREN0TW12QUhCRjQ5em16?=
 =?utf-8?B?Q0RPQWxPZmxtMjZId1JaVm4yL3QyQ2hMcHp1dGhRU2w2UU1qL2RGTlJDZHh3?=
 =?utf-8?B?T0xNWlhCZUQwMVBhdkg3NWZTV1M1dEZuYTMyMXNGZ1lTTERHQ2NhazJYSGRG?=
 =?utf-8?B?K0ljRXJTYnA3TndKNTR1UFVNclRRWnZHcE1sdmlpNkxac0RGODlJdHpzcHlu?=
 =?utf-8?B?aUwwL2tXWVU3ZEdRTjBIWGwwKzZVVk9IMzk5N0xWTUVVUVovQnF3Y0I2aGtu?=
 =?utf-8?B?UDh5VDFUeHNJSWJrOU8yMGlZRWRnOFNwL3hNWkMrMGQ1V0JISUFvWjFlRTUy?=
 =?utf-8?B?SEZmekVPcFdDNUNSa2JXdkJpNnNoTW5kYitWK0NDNEtHakN4Qk5OT0FMR2wv?=
 =?utf-8?Q?BIrIKYHOIduEoVN3IITEVHs5e?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beb7b84-fa94-4ee6-45ce-08dd5b31c980
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:35.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckOtcyfuP/nkbLV2GBpiNg1/f0An6jXIjj+A0ZRN7Enk7mANbwp/hEeqdfEO37+14e5HdsaxByMD4DkWwaCJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-Proofpoint-GUID: _2LlDO7XIwQeMqJIObW0gKG1IYVL2X-2
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c71d15 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=94Nz2Nw6my-I-Yvh_ZUA:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: _2LlDO7XIwQeMqJIObW0gKG1IYVL2X-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=624 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040126

SnVzdCBkZWNsYXJlIGZpZWxkcyBpbiB0aGUgc2FtZSBvcmRlciBpbiBidXNfc3BpLmMgYW5kIGJ1
c19zZGlvLmMKClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxs
ZXJAc2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
cGkuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVz
X3NwaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc3BpLmMKaW5kZXgg
MTYwYjkwMTE0YWFkLi40NjI3OGRjZTdmZmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvYnVzX3NwaS5jCkBAIC0yNzQsMTEgKzI3NCwxMSBAQCBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCB3Znhfc3BpX29mX21hdGNoKTsKICNlbmRpZgogCiBzdHJ1Y3Qgc3BpX2RyaXZlciB3Znhf
c3BpX2RyaXZlciA9IHsKKwkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAorCS5wcm9iZSA9IHdmeF9z
cGlfcHJvYmUsCisJLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAogCS5kcml2ZXIgPSB7CiAJCS5u
YW1lID0gIndmeC1zcGkiLAogCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIod2Z4X3Nw
aV9vZl9tYXRjaCksCiAJfSwKLQkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAotCS5wcm9iZSA9IHdm
eF9zcGlfcHJvYmUsCi0JLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAogfTsKLS0gCjIuMzkuNQoK

