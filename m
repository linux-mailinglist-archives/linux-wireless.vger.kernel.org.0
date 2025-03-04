Return-Path: <linux-wireless+bounces-19767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE439A4E47C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6165319C009E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF1296140;
	Tue,  4 Mar 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="Y3hAIwha";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="TVFAeVH2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA22512ED;
	Tue,  4 Mar 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102374; cv=fail; b=s12GRxEt1RrEqTloNxOihcF772PjrVcPwirStmTwkKd/aXEbwSixrRubvVdhOMyIHrgDp26Sj9/ZaSo9cPvtmVyacRVvE1opxvwKYpkHUkWhqTyRnX97iMi28GAlYGlsepvVVL1UpxGBEnAZuS/Gs8C+qUs4/3ufsWaHG/s63DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102374; c=relaxed/simple;
	bh=FTWE8aiE6pSEDvp6oNUZGQmmeqkXc4EtX2pbVZV9IIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNTgm7Edihdt3A9WCM8wJbIZ7llgHoDjOI/41USkAFrBKfgZ/Mfm92J56Qe1G/fGhu9qr+7EDmOIbpvdvGUxBGlEQ0mn59nUVK1YyAPrf8QZdY4BaQoSzLxD6BbvTXdAtyCwFBR1P7Ztq+bjsrJpsq2SrodPoMon3TArM4++CjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=Y3hAIwha; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=TVFAeVH2; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248TYaA028076;
	Tue, 4 Mar 2025 09:32:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=FTWE8aiE6pSEDvp6oNUZGQmmeqkXc4EtX2pbVZV9IIA=; b=Y3hAIwhadgU4
	uVAL74+Oxb4vLfwS+Yp+KQxX2Z0wLHAZEMP9NOVJXfbkNkfKW6YE6hB24BY5MNBa
	kO5i7FpcXQ0iIDjv7MldiL9esCBJbuitZOLPQoHuMvoWvFGnIPdyXzPfsdolFvls
	oCdlVqQCt1VWb9OqhP7XgE+cWPni/MHVY83y7NsRCkGEcbKN61WSAt809cRV64Dl
	jGfS14dgwSFFSZ2vj9WPGIDUE8Fvk+gecS4b0HVDRO7lzgerwkzP7l4uxdOy9SnS
	PXV9+BjcBZ5I9hKaWNZmZDqH3p2ImpWL/Rg40SnDU9lDVDPvp0lC15YxK6UqoCk3
	rvkMLdlajQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegn158-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:32:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZESpdGoz8dKDSgAX5y2JGX8RyZfjAoGCVHdGDv59xYMCbBXrX/Xtrj+J5ncDpPkd0FlAnrSHyMz+z70LNTok/kap7UdCdT/8TeXAsSH+TVgAOCaRsyiFyEV5RbIjKOav1dcNBAndcUFJJOch209rqNKAZBBtbgBdJKQ1II0oOZZSG/HWqDnCP8GJ2DaiSHUQHt63RYJeH/c+26WvIVLD8YEfQrIVHX6VPXZ4YIZhPfb7wOMpz309Ylmr7F6jmhZlH4+eMBIdiG1pIJMQh7iCInvn3jZ5kBcPes+K5DFrqAA6WLoBlGkOEkWIuO9eMZC8dOckeT4lR7EG8smR3+/fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTWE8aiE6pSEDvp6oNUZGQmmeqkXc4EtX2pbVZV9IIA=;
 b=AThszUmXnCR8mTI/T8BJDXHi6ywUenoMwopDIijqGjMb0/odrMBonFgw+hQ3/N9OWo2G2eGKTbNKfIUwUG8e4wqjc2tXFD0iAo+nuw+9/HyIt2ZKhyL/XiZS51dzjXclAmAYvLcWQXdhp69vw9gAXetIpI3NenT0iH0Qc8vGL3H30Nk4UwT4LwCTpP7PatPWl086WYUvLiOesz+AgCubirtc3/qKRAkobyv4Vdvx4f4zCblRGUKZB5k+PM9dSSWV8uEmPRFiNSagbRgktmEVDxz55mCiejiJ8pVQNVioWZnQplC8AMGxZAX+krIoZzCT8dbRZMxKqVhWsppE9yEHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTWE8aiE6pSEDvp6oNUZGQmmeqkXc4EtX2pbVZV9IIA=;
 b=TVFAeVH2Q+d2OJBOS4DYHa5h1Prik7xUXxMTs9w43J8qDaCfVlMt9YTNARZIauzZZWRO3+3Bm7PcYm25sjdIr5kAB7Ja1F2eMtbHV6sVENcWOKCB821dEqPBugVK+JVq9ar4A5+V+3PRv1ZaBMCS/3jfLgcBTHpcNkGSx5p1cjg=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:32:36 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:36 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v3 2/5] wifi: wfx: declare support for WoWLAN
Date: Tue,  4 Mar 2025 16:32:21 +0100
Message-Id: <20250304153224.39083-3-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e2fb430-0ba9-49b3-4052-08dd5b31ca26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU5aTGtEakEvVVNzVVh5VUErVURsa3RiVEZXdVNhVFdtdVlpczVOUHNkN2c5?=
 =?utf-8?B?QmJSWmgweVFRbkV0bGNPTU14K1o1VWxpT3hiditVUFM4MDljazMyV0s4V0tF?=
 =?utf-8?B?NlE4bDd3SFpUUmVOU0x0cGpDODFlcnlZMWhuRHpOU3pZQ1oyNWtGSW9lZXF2?=
 =?utf-8?B?eU9OL05aaGc4TWx4VnZXTTllY2hMZnZ2cUtpVlhDZjYwaUI2b1ZlMHNNTmI4?=
 =?utf-8?B?MHZ0b2dYVVFCSVJIYnZmRXg3U1VzbXl4ZVlaOTZVcExjUWxCN3F3NUZuWWJJ?=
 =?utf-8?B?a0RSN3pVaExhY1NZSm8rdVdnN2ladGovY0dEUDJ2WTNYbGowakNCWmJMb0RU?=
 =?utf-8?B?TGliMkI0alQ2dzJoa2xSMGUzeDRWZ0c4RU5QNDBaeC9QOFBIQzUrTmltVVJj?=
 =?utf-8?B?YVVVak5HOWYwa2JkSGxwb2kvTHYrRGcydTRmbUxGN2xkUUhBZlpLdDNLUWRy?=
 =?utf-8?B?V2t1SHNuaTlETnJUemR1UUtvV3U4ZTQyeTNTNGVrU0E4S3JSUjJMR3h2RVZL?=
 =?utf-8?B?VjE5eG0yaDFuNWN1anZnRlZJNUw5eFBUOGhsU0RZcllrMTRTa2dOanVqbk15?=
 =?utf-8?B?bVhuY2hzbTQya1YyRWNralhVM21ZRzVpTFV0VERzUzJBWjEwcWNaSVBxMVlT?=
 =?utf-8?B?eDlTZm5zUU1rYkRyRXFkWWZ3Y0VtUU9kd3ZXMHRBTDYzQzA2QzJma2hiaHN4?=
 =?utf-8?B?NWNmdWJOM1RldjcrUnVORU0zQWNYRkptakpXK2RkUE1vYkNhTnVLTVR2VlVp?=
 =?utf-8?B?K2dJNnJTalFySVpnZWw1cFp0emNLZDZNamZsUURld2w4dEJaVEVLRE03YS9V?=
 =?utf-8?B?anlQYWRzTjZKT1BJdjF5YUFGTEpVNTRMRTVnTkt0RVVVOElQSExBdC9QVG5L?=
 =?utf-8?B?SHlac3NrZ3l0ZHBKUjNsMW1yeG1UOEVaUFdJbzR6RjhRVm53ME9GaTVNRzVl?=
 =?utf-8?B?dkdHZkpmeVRjMCs1bU16Ny9aZk5HaVlacHUzaFBDdGJhZGZqQ3h0L1hMUmxT?=
 =?utf-8?B?RzlqNWtIU29mRzRFanhZUk1Hdm8xWHhwMXo5RTl6Q2FrRCtxYXIvQUs3Z2Jv?=
 =?utf-8?B?RWk4RWdFS3VmQ2w0ZndLTFFnTklxQ3Vad3JlN2wvTTVVMlNwYVZDa0wyZDE3?=
 =?utf-8?B?ZWRrb00xNCtVNGJvbGRnelhBem9UYkNzVUVidmg0YzBUY242U2Q3Tkp3SGlY?=
 =?utf-8?B?UDUzanFiNjZJV3FFZDg5cWZuekFOQW84WWRWZU4vVElyazJsVjZESFAxRDRH?=
 =?utf-8?B?emVWekwyVDhzcDJzVnlOTUVldFhVUUFPOFc3NWRxT2dDRHF0WmZYN25NWXA4?=
 =?utf-8?B?WnUzaVo1Mkl5STk0VUJLN2ZjQmVSb0pzbjV6Nkl6ZnRPOEFvR2dhTHNrdjNw?=
 =?utf-8?B?aG9HWFQ0UzUzbEtseDNWb0d2T0J4ODJib0ZpNUlnN0xQcFJxNlRUdXN3S3Rz?=
 =?utf-8?B?c2xQenRuS3lYaFBsbHljUmdBcHlybmhTRk5NOXJjSEM4bW02Q2dwc0dPY3pF?=
 =?utf-8?B?bGxPZW5uakZWZWpLZXlqd2ZUYURVWEhHYi81N0VaQTg0a3NGdE02VE9pZzB4?=
 =?utf-8?B?V3o2SDRaQWhqRklHM2NYN3BwRkplVEl2S3hIbXlUUFN5M2QrdDJBUWtFTmFX?=
 =?utf-8?B?eGdnY0VyVE4wU2x2Ulc1dFNONkVjYWRnVUQrU2pNaEZqZkppRDdOMjdHUU9F?=
 =?utf-8?B?alNtS2JQTXBDSjhCUHAvVjd4dlN2c0ZNRjdQVk5pRml2SG9iWVpzUmFWMUtE?=
 =?utf-8?B?WVlERnZJMXV1YWcyVytxdFlTaXlWaUdza04vWVVWVDZ1bDlobG5NRFJwNk84?=
 =?utf-8?B?UlYzSy9ZVDk5OUkxaWhiaTA4c0FpREg4cmxuL3JodDNkOFdZMWYvR2cwUzhj?=
 =?utf-8?B?SmNlWFVUZ1hocEx0UHRsNXFnSXVTdU5mOUtablg0UUcyOXdPMzlITkVuSWlh?=
 =?utf-8?Q?H5Y0L0ynlDXitkmx48MAZXl9w488+ddM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHJyQ1pEbi8xRk01Y1FmTVY5MklZVDBIb2VjVEhsQk12amxKNjJvSXN4YUZY?=
 =?utf-8?B?bVZKVXA2SDJVRDVJTCtySnVSdFVXZzlKRkFMMURJSUVOd3hHaG1NVFhYcHdz?=
 =?utf-8?B?MU4zRmVvSWRXbDRVZGlWOTlJektCTWJtUUorR3Fmd0pwYUx6UTd1dXBtK1VR?=
 =?utf-8?B?dVQyZTd5RXlBemN1RGJsQ0ZzMFZUckRSSTV5QjlYcnVkNnR5cVE5UElwaWFM?=
 =?utf-8?B?ZjgyN2V1QnRDbi83emtBTXlsbHpiOGdUZXlMWHVaeHIzZ2xnbVBnRmQ2MmZm?=
 =?utf-8?B?d0dmWWVGeFpJTnFmZHlTU3ptUEFyM2dBbjUvalZWdk5GODBGR2Y4TnVseGRV?=
 =?utf-8?B?OVY0VDVNV05xdHVCa2MwSkpmeXluTDVqMUhlYk1zU1dlN1Fja0R2bHJRTlNx?=
 =?utf-8?B?SVpuK1F6d3FkVDlyNnYwUGQ1czdXYm9nanVhc0preDEweUl6Rit4U0RQUVJm?=
 =?utf-8?B?VHh4N1ZxMllVWFJPN3NKWWZHTU1rUjFoektOa2dtaUlxSmd6WnRHZWx2Rkd2?=
 =?utf-8?B?NFJWRkpQT05DQ25CN3NScVpKbUNxRHRtT0Jxd3JXVWNyOEIyMklZdndxUGo4?=
 =?utf-8?B?b0UzSVVVYXFjRzM3T05LK2NsVlFwMFR4czVxa3RzQTVHWmVjNzJmaGt3clZT?=
 =?utf-8?B?V1RpQm1yS0YyQjV1Z0ZubXZZNFh5b0F6dGN3RURMb2N6RXZRTGlHNnhhWmVj?=
 =?utf-8?B?eDhmcUtneGFaTDZ6NEQ2dFBTVi9NU2w2M1ZNSlZ3KzZDUktsQ0FuVEZtWE0v?=
 =?utf-8?B?Z1l4Q1pOUWc0d1V0emIyR0FuNDJTbk5zalp0SC9icWYyNGFIMzVMTDRFK1ds?=
 =?utf-8?B?RkJhVS9Wbm1ZZzQ4RW9qeEZHTnBCZlljNURhSmtDSnUxTzNzNS9ZOEowbGZz?=
 =?utf-8?B?NVA2aFVZQndZUWJjbitHdkl5UzY0TzRSZUJKc2N3QXBLc0V2RUlYdE8zQlIw?=
 =?utf-8?B?emlvTU5POTZvazZNL00vRlJGNHdKMGt3TmJrL2c1TmlxUUpHN2F4eWxvZHJL?=
 =?utf-8?B?WTZZWCtlUGMrVldhOG10WEMzQmpjMlJmUzFXeStKUzZLcVhycHVqdlNKTUl4?=
 =?utf-8?B?M0x1UjhEYXZ4VzB3TWhQSWROTDVrUE1uVTVSN281M1UybExIZVZVeDdBdmUr?=
 =?utf-8?B?M1V6N3BBT3FEcFNTdWkvbGxaMCtyYWNrWURjYS9GcEdoZGdOeG5XazJrdS9O?=
 =?utf-8?B?VklrTnMxL0Y0OFJuWUxiVW4vUFFEWHYvaXVYRXYzRFNtUEthVkYySGp4S2U0?=
 =?utf-8?B?cytBbFI5M3pkU085TDdLT0xaOXZ5RnZzM1crZlpVeEZEWWFNempCdUlzZVov?=
 =?utf-8?B?NGpRZHVKQmNvd2xGWDFsdWlpamJURTJubGNxRDRMazd3UHVPVkQxMVc0TkdK?=
 =?utf-8?B?WlJ1TWhsMlQrWS9UYU45cHRZcUVJYXJ3SFpsZE1FditTQVhXQzdONVZBcy8w?=
 =?utf-8?B?bDNCNlMyQmRhMGVUL1pRM0xwSmxMQ3RBeWVwOHVzUG1BNXJBSTB6M0ZjV1J3?=
 =?utf-8?B?cExyaWV2dXhsUVdNaWRETmFvSmRjTXVPZS9NaVhtM3BSZDlZTEIwN0ltZENF?=
 =?utf-8?B?QVQxUGNhdWxLeWxDREQxYVBJL0hYSnh1YWpHcXBXT0FVYTlXUUNoaVA5aE1i?=
 =?utf-8?B?ZVUvYlJvZ1ExNDJXZ1BvRUNySWJ3MU04KzMzbXVsUWlVRld1cmh4M1VpTWRO?=
 =?utf-8?B?U21LWWdtWHFuRzl1RFFucjBwRFFPdDlWdTBmWVNwc2NGWllpZ1FBbTVWMzU3?=
 =?utf-8?B?a3RaZ0w4dk9SY0JjRDRGdmlLL3orNEErM2ZyTVJ1aVhnR0svWTlWdXlqV3N6?=
 =?utf-8?B?c3dJZkdOZjlBUU1CeHIzdHZLK253UEdWWUNKYVpwOWtiMm51aGhmQyttOVZl?=
 =?utf-8?B?aGticFptM1BkdkxRUlA0QTVYT2t3WDlaN3NMSllnNmgwaEFTeTR0b25RbEtj?=
 =?utf-8?B?aTdSb2ttb3U5OU5HTDJQbHhnYnlSU3JEU3JEV3VqeGVlZlFTTkpVang4ek5k?=
 =?utf-8?B?dFZ5S2RjUmxRenRZSHA5dHMxY2xjeThEWVg5eDN3N3M0bVk2VTR6NUNnams3?=
 =?utf-8?B?NlJMZmhOc2x3ZGlOUmZUZkRkanZXK3dYRFNmOUt5T3VGYnIyK3JJM3BFcmRo?=
 =?utf-8?Q?5BLVVuWK/h1AplSqEsMB7Cqln?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2fb430-0ba9-49b3-4052-08dd5b31ca26
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:36.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hEXgo8Us/C30sYJuCOEnCPozcm/bkgHwo6oN5AJVt7DYew6JgUer43EVClvbCNsU+9ztATdVo/IkUattWepaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-Proofpoint-GUID: QGizQOS8ziwvmCL7UQxVU8GC9_HEkn6h
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c71d15 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=PNO-vrL7TU_s0Guw4cUA:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: QGizQOS8ziwvmCL7UQxVU8GC9_HEkn6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040126

V0YyMDAgaXMgYWJsZSB0byBrZWVwIHRoZSBjb25uZWN0aW9uIHdpdGggdGhlIEFQIGFsaXZlIHdo
aWxlIHRoZSBob3N0IGlzCmFzbGVlcC4gU28sIGxldCdzIGV4cG9zZSB0aGlzIGNhcGFiaWxpdHkg
dG8gdGhlIHVzZXIuCgpGb3Igbm93LCB3ZSBkb24ndCBwcm92aWRlIGFueSB3YXkgdG8gY29udHJv
bCB0aGUgZGV2aWNlIGZpbHRlcmluZwpmZWF0dXJlcy4gVGhlIHVzZXIgaGFzIHRvIGFsbG93IHdh
a2UtdXAgb24gYW55IHJlY2VpdmVkIHBhY2tldHMgYW5kIG9uCmRpc2Nvbm5lY3Rpb25zLgoKU2ln
bmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29t
PgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jIHwgMTMgKysrKysr
KysrKysrKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyAgfCAxNSArKysr
KysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmggIHwgIDIg
KysKIDMgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
c2lsYWJzL3dmeC9tYWluLmMKaW5kZXggNjQ0NDFjOGJjNDYwLi41NTU3M2Q5NzVjZjkgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCkBAIC0xMjEsNiArMTIxLDEyIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX2lmYWNlX2NvbWJpbmF0aW9uIHdmeF9pZmFjZV9j
b21iaW5hdGlvbnNbXSA9IHsKIAl9CiB9OwogCisjaWZkZWYgQ09ORklHX1BNCitzdGF0aWMgY29u
c3Qgc3RydWN0IHdpcGh5X3dvd2xhbl9zdXBwb3J0IHdmeF93b3dsYW5fc3VwcG9ydCA9IHsKKwku
ZmxhZ3MgPSBXSVBIWV9XT1dMQU5fQU5ZIHwgV0lQSFlfV09XTEFOX0RJU0NPTk5FQ1QsCit9Owor
I2VuZGlmCisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX29wcyB3Znhfb3BzID0gewog
CS5zdGFydCAgICAgICAgICAgICAgICAgICA9IHdmeF9zdGFydCwKIAkuc3RvcCAgICAgICAgICAg
ICAgICAgICAgPSB3Znhfc3RvcCwKQEAgLTE1Myw2ICsxNTksMTAgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBpZWVlODAyMTFfb3BzIHdmeF9vcHMgPSB7CiAJLnVuYXNzaWduX3ZpZl9jaGFuY3R4ICAg
ID0gd2Z4X3VuYXNzaWduX3ZpZl9jaGFuY3R4LAogCS5yZW1haW5fb25fY2hhbm5lbCAgICAgICA9
IHdmeF9yZW1haW5fb25fY2hhbm5lbCwKIAkuY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsID0gd2Z4
X2NhbmNlbF9yZW1haW5fb25fY2hhbm5lbCwKKyNpZmRlZiBDT05GSUdfUE0KKwkuc3VzcGVuZCAg
ICAgICAgICAgICAgICAgPSB3Znhfc3VzcGVuZCwKKwkucmVzdW1lICAgICAgICAgICAgICAgICAg
PSB3ZnhfcmVzdW1lLAorI2VuZGlmCiB9OwogCiBib29sIHdmeF9hcGlfb2xkZXJfdGhhbihzdHJ1
Y3Qgd2Z4X2RldiAqd2RldiwgaW50IG1ham9yLCBpbnQgbWlub3IpCkBAIC0yODksNiArMjk5LDkg
QEAgc3RydWN0IHdmeF9kZXYgKndmeF9pbml0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIGNv
bnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGEKIAkJCQkJTkw4MDIxMV9QUk9CRV9SRVNQX09GRkxP
QURfU1VQUE9SVF9QMlAgfAogCQkJCQlOTDgwMjExX1BST0JFX1JFU1BfT0ZGTE9BRF9TVVBQT1JU
XzgwMjExVTsKIAlody0+d2lwaHktPmZlYXR1cmVzIHw9IE5MODAyMTFfRkVBVFVSRV9BUF9TQ0FO
OworI2lmZGVmIENPTkZJR19QTQorCWh3LT53aXBoeS0+d293bGFuID0gJndmeF93b3dsYW5fc3Vw
cG9ydDsKKyNlbmRpZgogCWh3LT53aXBoeS0+ZmxhZ3MgfD0gV0lQSFlfRkxBR19BUF9QUk9CRV9S
RVNQX09GRkxPQUQ7CiAJaHctPndpcGh5LT5mbGFncyB8PSBXSVBIWV9GTEFHX0FQX1VBUFNEOwog
CWh3LT53aXBoeS0+bWF4X3JlbWFpbl9vbl9jaGFubmVsX2R1cmF0aW9uID0gNTAwMDsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCmluZGV4IDdjMDQ4MTBkYmYzZC4uOWUwNmY4Yjhi
OTBkIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKQEAgLTgwMyw2ICs4MDMs
MjEgQEAgdm9pZCB3ZnhfcmVtb3ZlX2ludGVyZmFjZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywg
c3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikKIAl9CiB9CiAKKyNpZmRlZiBDT05GSUdfUE0KK2lu
dCB3Znhfc3VzcGVuZChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGNmZzgwMjExX3dv
d2xhbiAqd293bGFuKQoreworCS8qIEZJWE1FOiBoYXJkd2FyZSBhbHNvIHN1cHBvcnQgV0lQSFlf
V09XTEFOX01BR0lDX1BLVCBhbmQgb3RoZXIgZmlsdGVycyAqLworCWlmICghd293bGFuLT5hbnkg
fHwgIXdvd2xhbi0+ZGlzY29ubmVjdCkKKwkJcmV0dXJuIC1FSU5WQUw7CisJcmV0dXJuIDA7Cit9
CisKK2ludCB3ZnhfcmVzdW1lKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQoreworCXJldHVybiAw
OworfQorI2VuZGlmCisKIGludCB3Znhfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpCiB7
CiAJcmV0dXJuIDA7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4
L3N0YS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuaAppbmRleCA3ODE3
YzdjNmYzZGQuLjcwY2NjOGNiN2VjNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
c2lsYWJzL3dmeC9zdGEuaAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0
YS5oCkBAIC01Niw2ICs1Niw4IEBAIGludCB3ZnhfYXNzaWduX3ZpZl9jaGFuY3R4KHN0cnVjdCBp
ZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAogdm9pZCB3ZnhfdW5h
c3NpZ25fdmlmX2NoYW5jdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAy
MTFfdmlmICp2aWYsCiAJCQkgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2Jzc19jb25mICpsaW5rX2Nv
bmYsCiAJCQkgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5jdHhfY29uZiAqY29uZik7CitpbnQg
d2Z4X3N1c3BlbmQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBjZmc4MDIxMV93b3ds
YW4gKndvd2xhbik7CitpbnQgd2Z4X3Jlc3VtZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodyk7CiAK
IC8qIEhhcmR3YXJlIEFQSSBDYWxsYmFja3MgKi8KIHZvaWQgd2Z4X2Nvb2xpbmdfdGltZW91dF93
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7Ci0tIAoyLjM5LjUKCg==

