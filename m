Return-Path: <linux-wireless+bounces-17328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C26A0926D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 14:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D84F188CD9D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E620D4F2;
	Fri, 10 Jan 2025 13:47:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8E20DD71;
	Fri, 10 Jan 2025 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516845; cv=fail; b=FNTgnbGo7Sj07A5fKxFLyy0R+AZCQXJp54RLw+c9gVRbnH30vkJd1CRkayE5v5N2kDctzS4bsDN06PP2rnvtKVy5MEPu5oSKHMZVIi5pxwPo3Hg/8Ryv+4d0rMNxTWPVz121dJXBrFtV89ziQChCEJgXcaPtgFffv1qWX3FDblw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516845; c=relaxed/simple;
	bh=FA2DK5U55hgp9rZYmaQLK5zq7VLYLyLbVVknfWCkdGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3M5CrfRdi/2NeuEJEm14Tu1HA13XTY8MowIU7Wh/mB4oiHcy4K3/YEESrFYB0dPDyk1vun97tiPhTC02alxaxxOdm635cL/yo8hCGm15efnYD/qoYnVgBpIxNoKrQmeUQZ4CJo2nQ3gq3otvZ4Orf34ldLV+yWcKdTzFspfufY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8t4Fs025676;
	Fri, 10 Jan 2025 13:47:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 441fv3txkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 13:47:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZHaHUMrudwNlubHvFg6DrSB1bnAMPwk05bCbc8t9LQumn7aHWDS01fSs2Mh/eJ9DXM5Pedz9krgiPQf5H+DKzjW5Wmg+gSNMMosm+QTyAo7Qmq9PpcHftQbv7ApVKo0Z4TvyBnPBU7D9+00BcMZh8veb5WT48SOYSzKQwgOFLNO/nyzastcFXTbi4MC0g8f6k8C7gDlHxTp/nlMgJaUwAhKxGXfyND7D3W4Ju/X7Uoff74jNfSgIweUCZb+o3M0XIyyzuVGezKfD5sJF5BPZ/1mPNh1k8lUprJw3WLBNJBgKihfQZKnaXn13ScIB9eIA8+Rj7+7WFhQtWAPntPndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ot9kX+39cCu5jRW3XcfKpdO5zagCRXEjtOXAcdpY0k=;
 b=c3nTy/cCXPOXk/ONrJXh5U9aaK0fUes1Kahi+92mWYuqTbtBFERCBfq+fv3C3e4evW0HXZcGssbmtjXB2xOZxCJ7hzdCqTxSrBDvZ2MQoGjLQlH5xzGM+fnuv0y1CWLJqSg7yKgWNVR3QY/9bEo9gp91RimAXqdd1L1uo8M0Bt7ObHSzYE5TY6nBFf2lF6VFyxWTYGpdxF0K+9MjwkjqjAtcrxrlZcp0zt8pDG+0MjBUvICBxe21uJ5Y4JBIiWaAl5HeSgsxTfxz3ANmR5IUqdQotInKGPNaYOva21CqZoWkD2pVtdIWfCU8xxT+sW5GiwNJdyFHdJw3llmL2628GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 13:47:12 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd%5]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 13:47:12 +0000
Date: Fri, 10 Jan 2025 14:47:06 +0100
From: Marcel Hamer <marcel.hamer@windriver.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: NULL pointer dereference on tx statistic update
Message-ID: <Z4Ek2uyi+87yZzlh@windriver.com>
References: <20250109155201.3661298-1-marcel.hamer@windriver.com>
 <CAOiHx=kVXbKB9VXCZzz-2vmBi+wRBdWGg6HUFcDf6j-aQMxoVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=kVXbKB9VXCZzz-2vmBi+wRBdWGg6HUFcDf6j-aQMxoVw@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e042fd-cf9a-4fb6-837b-08dd317d48b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MC9YTkJhRGV5SmtFWXQ1TDRHenJFTndoU1BNbGVTa240ZlR4NzhuSUNDSC9E?=
 =?utf-8?B?eW1GQ1p1Z29RVUxjNFRETUJpL1NrVHhMWktBaHF3TGw3NzVvOXdWVjNoVGN0?=
 =?utf-8?B?c3FobzRvUE5aOGQ0azlCbVUrU3JtZ2xlaXA4Snl1MXNLT1QwNjJiMFRCeUNW?=
 =?utf-8?B?NFdnVXBrTGg5cG1jeThnSG9kUllVeDdwT3FxejAyb1M5anA2dzdxMDByRFNy?=
 =?utf-8?B?VVBUQU1ENTVwSko4ZVY4a29GOXh2L3BGaEpDaGdNWUx6L1R1cWV4UHgwNFdZ?=
 =?utf-8?B?MWo4cXRPYlBMOGtoY1Fzbk1WN3hHT085ODViQlYzLzZxdW8wZmhRSHRYSDN3?=
 =?utf-8?B?RFczd2xuUDJZY05YUGtsTUFrcTV5SjFpVXBjTVNNeDVuakhkQzllVmdnNG03?=
 =?utf-8?B?dmZNL2RPUjV1VXNKWjQ0V3NSdkNRUExKSGlOL1VFbCtDaGp4enFnYVFvQ3B2?=
 =?utf-8?B?TU42VnhKY1I0cVhLZ1ZaWVVWRlE0QmNEMWNZOHJPd2hLMnZpKzBKZTBscE5y?=
 =?utf-8?B?M3dPWXJWSzdwVmsyRlpPMW9lNUNWL0FrOXdZb2JXVlQrNDZuaHUvbUo1VGR2?=
 =?utf-8?B?dk0wUGZSYkh2VEE1UEk3Y0lnWFFsNTZyUC9iZU0vSUtUWnRQSHY4aHNLYktU?=
 =?utf-8?B?TDVYU0hsSnI2U2lkem1KcjJKa0pTN0IrNGVxSENHT1dwU1pNK3Z2aVo5SjhR?=
 =?utf-8?B?ZW00MUpoQ1R3Ly9JMlJkV3o5VnhZWUExV0IwWmh5M0lORmlXRVhNeVNkRVVu?=
 =?utf-8?B?bDMxaFhYQ2ZlaitBUG1VZ2QxL3E4WTI2NnY4ZFJsWWEzTXlRKzJzQnRKVWZ5?=
 =?utf-8?B?eUprUXlMQko4QlIyQzVwUEhJNjBBMVJBUHdpdlVVWmhiUkQ5cklZSExmU2dt?=
 =?utf-8?B?OVJBYXAzYVVTT0daTitQTVBRdUpZQzcrNTdPYzA4S2FzMkJ3Mit6UjdGanNo?=
 =?utf-8?B?NUhabGhZRm4zUWozTTNnUXh1T25UOUh3REVsODFuQ3Q0aGMxeFhBblVzWXFy?=
 =?utf-8?B?blpnL0F1dURmc0JoUnFVMkFYSFRrU25ZK3M2d2Fnb0tqa296aUZXU3BWd3hk?=
 =?utf-8?B?OVZ5OWVFZUIvT0lyN2I1dEFpYVYwR25qdE9HT3BsWVlCNUJtRUVCUjhHcXNF?=
 =?utf-8?B?YmkyQjd6N3YzTXB5UmZhQzFiUlV4RTNtTlgybnVaWlIvUWgxN1QwTGM4RUFx?=
 =?utf-8?B?ampVb1VqTFV3WlM4MkwyOHRMOWdWZWpCakVzeXdhMDh6ME1HZ1dnazQ2b2l0?=
 =?utf-8?B?N015V0FNakNHYnZ2aEVvOXl1TnVBWldaSURIS3B2bjd3MlBNSGsxNUpCOTdP?=
 =?utf-8?B?M3ZGQ1J5cklNZFFXbHFxaVNIWU0wajlnZ3BYbDAwNHlMTkFxZVVVazVMc2pJ?=
 =?utf-8?B?Wi9ZTEdFZ243UFRsa3hrUURodGQ0dFZaakpINGFTc3pmZWtmVHBXTWlmMjZi?=
 =?utf-8?B?dklWNU1EREk3VUN5QVpCd0xSdUxFeEFVRE55ay9aMkNFNHZIV0ExRG5Pd0xt?=
 =?utf-8?B?TE4ycEF5VXBNWVBQaXRXRE5xeXd3SExnSzNIREE0eTZlSllkQnB5c1dDSWl0?=
 =?utf-8?B?UmozeUl4MTlHSFFPWmtzSHFxYjdyOEZCZmU3YjA3TVlJenQ2OUozdEtHZlps?=
 =?utf-8?B?Yy9FRSttNjQ2RDhRdkVJVUZkMUVCaUNtOXZuWUU0Y3JqQW1FOThYeWY2c1Fm?=
 =?utf-8?B?K0d1WE5XRXZ0RjcwSU5IQTRtcUgrZkRzL3dXckdGTnV3RmF1SXJZQ2dDOFFQ?=
 =?utf-8?B?L1BueG9NdDF2OG52VS9RVmVqWUllWjBka2thYUdhcVVGOTlHUGVyVGNjL2lB?=
 =?utf-8?B?YmlJb2JMRnJYc3dyNWRSQ2RSOGlqbTlablRpcTRydmNtVFM4M3hsajhHZHhi?=
 =?utf-8?Q?zN9cvHWt236mP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFRU2syM0lFRjJoQlVXdUhIV2VhSTFVRHRNVkhRQjFZaERWZHNtT1Z4RmtJ?=
 =?utf-8?B?MTh6R0ZoYW85MG1lb0k3WU1Ya0x6eldUU1dCb1gzU3lMVk5IU3NKdGszTWFp?=
 =?utf-8?B?ZUhSYnBnSGNuV2VmQkNOUXlTV1FjTDhoSnFyK250a1hNbXVKV0t5ei8vaHhj?=
 =?utf-8?B?d0Q3a3RKdUx2RG1vVjJjWUVpK1pRVUlrKzcvamdmVkNaOGtpUzB3aVowNTV5?=
 =?utf-8?B?dWx3RTRnTXUrQWdFMXVxOWVCQnl3WXNXQ1JOU3lnSm9sUmgvcVc3bXprNzRw?=
 =?utf-8?B?N0hZYWJTLy9pVURoaXZyd1hidjVLcklZdTE3UTNjbVhsWG5KRnNYcHZGMTNQ?=
 =?utf-8?B?Yk9oYStZZlNGZ0lQMlNUZ3Y5V3RnWTFvUGRneDlTQlR1d3dJaDRjY2dBaHlY?=
 =?utf-8?B?c0swS1lYNDI4VFZUWFRFZis5RmJjMzR6a2h5N0hlTTNqZ1F0a3JUaGRjb2NS?=
 =?utf-8?B?NC80VU9ReDdSTmlUcDhvQ20waXpKdWk2b2NMSlNOdjBlTE1lTk9YUDh1Q3Er?=
 =?utf-8?B?cDJnZzZmUk9XL0ljcWdnN3lEazlodWlhM2JGczl2Z1VkbC9ZNjdDNVdjL0J4?=
 =?utf-8?B?Z1ZNd21BK3N2c0pvNFlPOCttbkNpWXNDTkxYakVVNllzZ0ozd2hFcU9hN3JF?=
 =?utf-8?B?OS9ROGhMZlhVeGZBRi9tQjB1cWNuTXBDTzhwdi8wKzFyR214eHNmQ3EyUytN?=
 =?utf-8?B?TUJwTDRDNk1tVVBGZWE5aEdHaEp4emRyTmpOSWI4UFJqL05KY1pnL2J0cXR2?=
 =?utf-8?B?VzJ3c1Z5dFltb3dxNlFaQ1FjZmYxYWo3aDJVVm5pamZRZVZwenY0bXN3MW9K?=
 =?utf-8?B?T2VVRUhXa2JuUVo1WHBQNmtaMTYxV3VDQVV5OUx3L3VJK0tRcWhnRWt5ak9N?=
 =?utf-8?B?WWR5MnFIcXJvdDFCU0t3SzR2cjRPb3ZIRXh0Q2dqZ3lFeS9mUjJIeGZXTDBK?=
 =?utf-8?B?cTZnblVXeDV3NlVJR3FWN3FPTlBuKy9XSXFvNk9tV3FWenVtYzdRTkdWSG4w?=
 =?utf-8?B?MFVBamtIY2tWUWVhOVFYYmRHMkVIZCtnSEh3RlFZQkg3K0N5NkIvWG1GQXZE?=
 =?utf-8?B?Z3ZHZUJRZ1J5RHNwWVFCVnNMRGlCNURwVmEyRStHTlVQOXAxMjMybXhoZHgx?=
 =?utf-8?B?aCttTlFLWDZPd2ZWN2VMcHdIMGh5enNKSHNxaVJPMThTVDRGeWJtK0l6V01z?=
 =?utf-8?B?OGI0YXBkaDJ6RU5vcmxkVXJ1S0lEcWZTdG95YklSaUxnVENONnZveGVKU0g3?=
 =?utf-8?B?V3VQM25zTjZrV090QkFYb3RiV1pLOG5UZTU4NkQ5QU9INkJLNHprWE9VVklp?=
 =?utf-8?B?WmhQQ21RMHlJaGg0dmFFYWNKZ0tMa3JtSXFseEZQK3drRHdqeGdlN0N1elcz?=
 =?utf-8?B?ZmxIZnlKcCt6NU5UWXBpUk1MeUNYRldDcWo3SXUwYXJOTjFZdCtNUXZ3RlZZ?=
 =?utf-8?B?TkVLSHdPN0ZSNllkT1B6eHRWWnd2ekNvMWw3YlNncXBJV2RBMEtNSXZQUnBK?=
 =?utf-8?B?VlhGZHRsaGQ5cFp1OFhONjRSUjFvNFZzclRaWXhOMW12QnoxS1NYSTkzZmp0?=
 =?utf-8?B?MmpOOWVtOW0yUGpuWWVxWjJSZEswYUlBUjEyZllMYXZCa3AyU0ZBTHQ3N0RF?=
 =?utf-8?B?QmVzaG13QkFJb0xweHZpRXJyL3ZreDV6em0xY09iODJaUU1HSzJDQ3FyR1oz?=
 =?utf-8?B?NW1hZkg5NXIwdTU0aXl0djl5WHVGMkw4R1NMdm1paEQvQzhUeTl5VUVCbjVu?=
 =?utf-8?B?RDRiRHkwV1d4TGFUOG9KREFNSFhITXQ1NFBjWi83L2dWcUVNSWFmT3p1N2dQ?=
 =?utf-8?B?NERkcWFPbXg2ZWs1WGhDZ0h3WEdhcTgveVJjU3drenBZaTNkbVoraVdxZzZa?=
 =?utf-8?B?UUdwdUNlMkQwa2tMaHFOUGVTbjhBMVhxVTVqWnJQRXhaZzAwZW10S2ZBYnZT?=
 =?utf-8?B?YVh6bGU0dDNUYmxLZHpHN2lObEJNL3hCTVdtaHB3c2tiRFpLbzZaemYxdGFs?=
 =?utf-8?B?YXlwM0xzRHpKTEJBamUycGlvUGE5OXFvWUFpRnVUK0NPaDh5NU1MTzJQVXV2?=
 =?utf-8?B?L3VKaGN6N1ZGY2EzL1NPSVcyUWdXV1FXeUhhVE5ObUxIRlNkT0JpekZkc2Fq?=
 =?utf-8?B?cXlKcmYwaWJCczNJeUl5ekY0U2dGbkY1bG1zdjNUTTJHR29lWFRGTy9LMUdu?=
 =?utf-8?B?QTJmZVpQNXFyMXkwRWZaMkRlbWtPaUdrME5pOFhQYlo5eXMvRU1iNkltZy83?=
 =?utf-8?B?T05aM0lhTEFUZWlVRFNHc1FyWXVnPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e042fd-cf9a-4fb6-837b-08dd317d48b9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 13:47:12.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRm4iMhUqPMB3qkK9na8y5VMrsLgq/An6nQCMmnt2VSkZFBccw9jZFov1xM+oMG5a4otXrOzpcnYS6/9+C5d0cRCMpfY/V3vDCznfEao2Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-Proofpoint-GUID: drtg4Eg_v5RdlMHGnttbd_aQiux9Yu7p
X-Authority-Analysis: v=2.4 cv=NIUv+16g c=1 sm=1 tr=0 ts=678124e1 cx=c_pps a=ybfeQeV9t1qutTZukg5VSg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=gkEyKUcQ2NRFztCQ7-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: drtg4Eg_v5RdlMHGnttbd_aQiux9Yu7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_06,2025-01-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501100108

Hello,

On Thu, Jan 09, 2025 at 08:33:37PM +0100, Jonas Gorski wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> Hi,
> 
> On Thu, Jan 9, 2025 at 4:53 PM Marcel Hamer <marcel.hamer@windriver.com> wrote:
> >
> > On removal of the device or unloading of the kernel module a potential
> > NULL pointer dereference occurs.
> >
> > The following sequence deletes the interface:
> >
> >   brcmf_detach()
> >     brcmf_remove_interface()
> >       brcmf_del_if()
> >
> > Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> > BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
> >
> > After brcmf_remove_interface() call the brcmf_proto_detach() function is
> > called providing the following sequence:
> >
> >   brcmf_detach()
> >     brcmf_proto_detach()
> >       brcmf_proto_msgbuf_detach()
> >         brcmf_flowring_detach()
> >           brcmf_msgbuf_delete_flowring()
> >             brcmf_msgbuf_remove_flowring()
> >               brcmf_flowring_delete()
> >                 brcmf_get_ifp()
> >                 brcmf_txfinalize()
> >
> > Since brcmf_get_ip() can and actually will return NULL in this case the
> > call to brcmf_txfinalize() will result in a NULL pointer dereference
> > inside brcmf_txfinalize() when trying to update
> > ifp->ndev->stats.tx_errors.
> >
> > This will only happen if a flowring still has an skb.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> > Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
> > ---
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > index c3a57e30c855..cf731bc7ae24 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > @@ -549,7 +549,7 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
> >                         wake_up(&ifp->pend_8021x_wait);
> 
> Here is some additional potential ifp access, which happens if the
> ethtype is ETH_P_PAE. Should this also be guarded? To me it looks it
> might also break there, just with lower probability. Or is this
> impossible to reach when detaching?
> 
> >         }
> >
> > -       if (!success)
> > +       if (!success && ifp)
> >                 ifp->ndev->stats.tx_errors++;
> >
> >         brcmu_pkt_buf_free_skb(txp);
> 
> Best Regards,
> Jonas

Thank you for pointing this out, I actually missed that.

I have added this in v2 of the patch.

Kind regards,

Marcel

