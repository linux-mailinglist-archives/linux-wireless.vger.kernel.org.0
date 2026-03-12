Return-Path: <linux-wireless+bounces-33101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFvEDNKgsmkOOQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 12:17:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF4270C15
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B5323088318
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988F2DF128;
	Thu, 12 Mar 2026 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="jEkENeAB";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="tzgb8AlT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC0282F15;
	Thu, 12 Mar 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314161; cv=fail; b=fGpbRuPk9V9dkNCvPjffTqiMo5s0wcgjQE/7nqCObTHsH/hFPJKjEBaVYQrt8zGMZcgNAQpSSVf3AbJYO8mPhSg8o+VfCKEpRf7Q4dhlp9uRADznxEiuxJte8e8hPsuCAmje0bT53Kdjt5DkyfoP5eIz+qEYrYCpDjynu7Sl2Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314161; c=relaxed/simple;
	bh=MB+1HAfusup/6MdZcx3FYLbLrO1y8wzk0R4OxJuOclQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E0WMqw/o6rGFDG2bJ0QXeSyYjD19GL632VsBL3J0HVYY+QfKY4rv63ZkB5LkySPNTeMN83OEG1XMNsWA+lUP8RjpsMDW2cY0I1G76bAU+MgrFWdcra3PNclw+gIl8gIfNmtogpgI29PJ5UjJHwFFOJk+Nd8zLFIoxEXIpk91onk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=jEkENeAB; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=tzgb8AlT; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C5XgLV3751703;
	Thu, 12 Mar 2026 11:53:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	8W9nqQ+j3iSVeo+WJ4vR0lz2QqaIuKCIgrpSMq2/+kM=; b=jEkENeABiWYZN7E0
	FYifGsVc5MLsEQlt+b9xz+xGQGy4lccImDH+1U6agSrIc6dLRrqf5TOJm+IKltBF
	8WW37B/RPjTGTd6bJwJUq5o09d0TPtGxN+GpvcQJ3NNk9aN+g/26Iyuztt+bmTCW
	DT+5me2xX4bUf23qhxwZ4HSmJvmYGd+pH/hvPpb++24SXeMGk7JykUIKRGslbyq5
	MSlWXi8OtS91FtK6LpEi1Mq6plXe4r5uVGjnzDXSZB0BD0QWIY5zEP3zfz18CKOa
	8kVrY1ED/jTOL272bWMxxILtmEhuKCtCx6TdnpmXpxO0LAadTF950sKPF8SYxS1g
	GZw0WA==
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11023093.outbound.protection.outlook.com [52.101.72.93])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cty3ghdm2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 11:53:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oesdeq3AWcINQZ5iCZLYYR2e8XS8R53XVy0f0aDmTPVnRYGUHrBNVVczppp43a4cLnfmDsfvNptvraStb95p3jX+RiIwA3dOJjIth2+4MTpvnlwifrVQtetpn31h8Y1vPtlKGX3+cEDRMDaSPCnwgeVz1bXMsHU6AGC1vRkdvJLf5jnpuEsPuqO5ERYErXNFrF4tcbrzqRjtGECCU1veh+yp30tb2/eA/Ucz0ApKsieuJocPPLfMfy/DzpYA90yunvwuErLHda7SUhaI3I7AuLqsysdkFPe5fp/v6iwoBmb2+KioCRiyiL5kpKzOFsD4cCyq11CAKAZXbTe5pRm6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W9nqQ+j3iSVeo+WJ4vR0lz2QqaIuKCIgrpSMq2/+kM=;
 b=sBnTQA3DGUDpGdWw2HhE/8+MR24qllQagGkAw14IaeaHH01LoMDkyODOXqgbyVhwJUQefmjt80a21aKc0BewLfpKU93NgrUpNYv5W1qIGWBdBzdAf0p0h8tnqu9HfxGQFtLgXHPM6kfZE44838m4lHmWh2YXjDjKUU2087J3zQys5ypcitRcALruog5PtyoEYBiQmUWQHNZIxxcwTrg7nwopApa+0ovvEW0RW/5l5l6kbPBIKSISKPoFwlyHCUe4GvyuhRBdQ76mc69CTVgRKrXzRa2ThLs+/M04gnr7ysPegWKEZq9yE6Uir9fc59bMRLjB+I3LGR+A3yucEqzOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W9nqQ+j3iSVeo+WJ4vR0lz2QqaIuKCIgrpSMq2/+kM=;
 b=tzgb8AlT0XRzxJxOdk1Ak70WeoOt2cCHcOF7JGcnEg1dCKGcV40LU9qaMuOkvDlXd4rn/1o1OZ1bG6EvPQnAn61msW68kabrdMAgoLKNA3XFd1Ijyv0iQJY2DANFaZDLVcktCuhYK4YN6skhZRUPuCnUKTazctjhDaIkYKEGCQo=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI0P192MB3175.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:53:39 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:53:39 +0000
Date: Thu, 12 Mar 2026 11:53:32 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: handling of HE and EHT capabilities
Message-ID: <abKbLNK0YrT6dr96@FUE-ALEWI-WINX>
References: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
 <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF000239D3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1b0) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI0P192MB3175:EE_
X-MS-Office365-Filtering-Correlation-Id: 83db350a-4fec-476d-cdf3-08de80259e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bjJK91Dx3v0rsBHBH6WfCNab9p2KsJ7aglK86BZc0etm4kfzpigST8ubgvGWsRkf9ehBOs88AOmey2/2UgwT+3km+nMs9y2ZPJcEom/Jtqds2LzooxxCbKVc781XPgtrfuMZTa9O436mldi/06SDf6D+EUQjSvONlKkWeR3qz2BgdpTBXAW/1jG+pqCkXfT/VDN8CxWliVRPQZGB3q7d1wDoJ6xUeUpl6LxyQF1St4c8jbS2T80wdgI7e5aqUmzHlrQJx+ogLquI0Gt0DviQX42xGLvWoFZKm1dbnPraIbnWmAAiPYpTlZA8/IanPou58lnS34pj59UmcRouxwzSbQW5t9vmALa9eMu73RxaWx5CdaIOQIel3Uy23AzsbXfiIy3NrHc5wr9TOCSHyly/ZnJfPvhSqjXkOF3hk1+jHDzrwFWskUkNipiuk2vZmVs1w1XQoQPNI1crcnIZBacgrJeAPrc60pkzFRd8gjC/amCxuqQd0dmq8r+Z2Y8tYFwhilvl0I3vDsRoF299WqSZHCL+PZ+9+y6F+v6Wrz/qovivTMUdC1XXEiFBB6buAN+DqBMgh/wtDMzNjWHPICVhx3yt9xaZ2B7Kn3govqyzDRDPUlzfTEvlbARXI54KH5b7KxD13NDAvR52EPi75TcHn58X2HqtG87aZHHPraoc9iIO5R8gvaSgFYK5uHbCLCdf+gZEFeWpA1fWrNtnN6isir13DVkpv2HtuX7WMrRx2so=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlJkWk9xSk1WSCt5OHE3OTNIazJtVHRnZDlQRUxSUWQrRTdDMFVRdUdUZEgz?=
 =?utf-8?B?dU5CTFZiVzNocjlYWmNJT1U2YmJ1b1JjSzVFRHUxSlQvUUJZUzg3NXdIUFhh?=
 =?utf-8?B?ZEQ4QWNLWWlodzI0ZCtRMHExU25Nc1BwODlEdC82Y0JQZXdxRHVCTHI1Y2VL?=
 =?utf-8?B?dGFlV0JmeUlPWThLNXJNKzhyOXFwU3NNbWZBK0ZNS1ZyclFqMHowTDJZT0Y0?=
 =?utf-8?B?cy9XaVZjTjFnYzE1QUo5OWJOaXlrYzBmZmFkcHkzTVRubWx1ZGxnc1NFSDB6?=
 =?utf-8?B?Wmo2SlAxaFpzeXV4WkVybXhjYkNuejZBcnNKeXI1cG1xQXNuMmtxTzRkMlZI?=
 =?utf-8?B?Yk95ZCtsemJQTGJKV0dhK0RHUUlRMTY3QTgvN2ZiVkV0NEtYdjJnS0d3aWJ4?=
 =?utf-8?B?ZnZobDJoSFBsSVdZSGdCWlc4QlFlc3dPVmlod3BtQXpiOFJoaG1Xd2JPWnJ3?=
 =?utf-8?B?V1dLV2cwd0kvdmNydURObHJlNW1kc0FVd0puNHkwQlZSU1NLdFlwT29JZVU3?=
 =?utf-8?B?WjVZVTZLNXo4R1VWNC9mYjdncURNWm1iVmVRcDZFcFBIZUVVQzkrUkVaWXZF?=
 =?utf-8?B?eURUM0NZaUMrN3RWMjZhaGJSS2RlSzN5TFA3SGc1OFB1cWhSbGJYc2tuZjVs?=
 =?utf-8?B?aTVodEpvdFNaQUo3MDBnek40V3RVV041WG5KWWtVVm1RSmFyR1doazFDdDA5?=
 =?utf-8?B?OHpxQVRwazZ0dnhEL3FGU3RrT05Ma2lDVG5ZY2dYcHdFZFhRRTFxWmlRQndU?=
 =?utf-8?B?QllHcWYrL0NYRG0rME9xeHBDRzdLcDBiSFpVUW5aN3Fsa29JWU5BZ0N6OXdp?=
 =?utf-8?B?VnVnczlFVEdRdXBzNGVYVVRPQUpDd2N4VGlENlJEVzFJY2E1eCs0dHA3WGtl?=
 =?utf-8?B?RHVITHRrNHFiN1BJWnFKUTRjWkQyVG5FUEdQWE9mZ0E2Tm93WTV5czZHWitF?=
 =?utf-8?B?V2JRTC9JbjZXMU5mTi81ZnMybWFFNno0NytrL3I4MktRc0g0SHVsb3VQajBB?=
 =?utf-8?B?QzRTMjRRTHJ6ODZPWTk3TlQ1ZTB6bGlNaXpoZytOUHBKejlFUENRZG5MR2Mv?=
 =?utf-8?B?akxnSzNRdWlaZzdTKzRDWlROWGErR29oMGhuRFFsTVhsUUJNME9LU3FrSGEz?=
 =?utf-8?B?UnIvUGJoNzRUYnpCSU9rSjFwVjllMmtmcS9QSFRRMGwxdEY5aExSRzBHQ0RL?=
 =?utf-8?B?Uk42MnM2SEYySWozUHhYQkNab2ZDMnMyc01TNjlxWkdQQnBrbnZ6dFBuOE1F?=
 =?utf-8?B?d2x6bkpzVWVleEdlR1ZrQnh0cnV2OEVDQnlnWGkxNU9XQjROQXZXT3NBc1RT?=
 =?utf-8?B?SEIyNVA1VndqaDdTNHNhbUpTTFFSYzkzR1JwQUhnQnpjKzlPQU9FM1IyR2dB?=
 =?utf-8?B?MTdwQmpnamlGKzJXd0dXQXdxMy9XcjRrQkJFWmk0QkU4WEJ4bFZjZDFuOFdY?=
 =?utf-8?B?UE0yWDN0K3Y2N3RYMVlrQUdSSE4wZEpHRXFFbm45NlhVN25oU2Z4UlhXaVpO?=
 =?utf-8?B?amFHWlV2WVdyeXBnUStCZGowY0FCeU5qVDltWENGT1o2ZjB0SVlQaXVRZit2?=
 =?utf-8?B?bVV4cXk5OGdMR0ppQ0xMc3p3NExuTGdSQW9ORHc1QjhGbFJsdndtNmlOUEV1?=
 =?utf-8?B?STBKNncxQ3ZNbUdHcXpMUUpmcVo1ZGo1dk1YeHZOY3NFaFU1eHVCenNaUDVR?=
 =?utf-8?B?czg1Y3JMS2orV0xLdDJmSmxmb0oyT1pqei84R1RlSDNiUi84b0xhNjRYdDl2?=
 =?utf-8?B?SGdVeEcwWDduNkovT3ZiTzdmWGNTOGxBTyt4ZXpxanNOck93NzdzaEVzVVp3?=
 =?utf-8?B?bWgvMmFFTmszcTRNZUUvU2hVSVUxckNTZmpHMXIyUnVJb05FK3ZDeTFuV0c2?=
 =?utf-8?B?dGt4NEVIZHZZbXhQTnFIUVBJRk5GSnE3Y3YvNFRoOUpWWnJ1ZnFMMXRlNHIz?=
 =?utf-8?B?VFNyVVhpNzJCVXN6TDN3eldmQndHV3pGTmFEZXFZR2I1NnhsWWRkbm1GdDFZ?=
 =?utf-8?B?TWtJV0RhZlZvTTdTeWxTK0FDNzRVS2MxVmFXQVJTa216QTRTeC9UUlZZazNE?=
 =?utf-8?B?ME5XaVZKaHlubGs3T2hFSkdqcjFTZUxNSVozRjAzSHRFVzErQnhIcTBMbFM3?=
 =?utf-8?B?R0k5VHp3M0FSd2QrOGJvelp1TGZZK2VtRjc2Zk02KzYvSWdZNmhDRTVRaStZ?=
 =?utf-8?B?dmo3Z0o2akFtdjgxOEN3alp6cHFXS0lNUXA4T3dodTljQ3dxSDFTL1laQXNM?=
 =?utf-8?B?T3dlUGo1Q2oxMnJzbEFtV25DVWwwV1d5cWlpcUNqdU5EeVN4eTZpNnZRWEpL?=
 =?utf-8?B?R3NaYk8wZnUzbWlaZlFtejJtQmkwV1JzSXVEdjNZY29wZ1Z1T1VGdz09?=
X-Exchange-RoutingPolicyChecked:
	ckSai1PgAGMx/WmJX5MwmcHeKuPKRaa0hV/MeML1iCuyuiVCY8RZOYUNYTYcF/QaCBsIqOBwknMVwj+5BqkBF4MZkLN8I/lse3ctsDqI1o1XTXKHz56Zt5U968SgGhV99LL1INlZYvSkqeGLcoJpj1DJRk3jYOkdhkw5rGbZFd38pRRGmxxK6kd8tj2V5GzA2JcK6LJnHHUvThOhRqDBwEZAj/YykdKv467Vsh+HRx9VyudDV6+3VxaLNnAPyldwuqc6YiW6VcICH9fy/EUlJSyyZc4mDoe54pt211JH0/KDR4V8iAU4W6loQW3a6Rlcvulue+X5aYuQV8/5WLrBcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gz02Guyoosfo8E34wPtsgLwEvBeKvSoKzIxFy1bU+8xbVbozcbFMTvxCQfG5o6Gr1f+u7mGxH0YIH5TzK21zDMiQw2ZZo4dMHsTgNKSQ09/TLB6uGvFzskjgNoQBjDlnoRP/Z6xrZ3VroGGI6kb8H/BU2RlnmQz8zngiLXbdI4W+xUWR/rBypk0BkFemxedCCPjAMXUcBgqUOjGl3flt7jYxfn/Zn85OWNp7RQ6s7OddZROLntKipBxoEJwBiYroPGSKJv8qRtuP1hoUH1iwR3g4/1teze/e/hhAJRbeOiLmZQkMf2kDwOj0idToxPOAdZoKsazR/pi3j3kneQw0ZjxlNwxYCl84URom+If2sYJQ/Iwd427iEGO+bRmm30SOiymITsqhXx7F081Fx7E9dLN2Qmk8qG6PIzS80ILQE40qRZGhLKXZUlAjRi/KYrY8Atxsbz4BaHSgfmXWTeNgYKFxcmKwOBjqgILtZ4l93sRcOgZ3DbPOcyxlRXR95wQ8ajJWxaQKLVZ3SZJWg9zwntlLieXVJflH1mEhoe8tTIAU0CmsafPO0wY5qQEsw4zwhbdvMzn0PqZhSRFwN/LlUs1TugLcN2AcuuDqbOOTXcsyRMMmcdU0Nw0O0V+RASes
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83db350a-4fec-476d-cdf3-08de80259e44
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:53:39.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdeUYS5JOo1wzOacF/1Unh6ImSy+rmaPVgFtu77MoPJBzEJ3iI0FPMA4T0SufNGgTb2DBV18ulCWw2Cu69co8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB3175
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
X-OrganizationHeadersPreserved: VI0P192MB3175.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: w-O7l7jIc97MunSriA56eJSNepN-OomJ
X-Proofpoint-ORIG-GUID: w-O7l7jIc97MunSriA56eJSNepN-OomJ
X-Authority-Analysis: v=2.4 cv=MIhtWcZl c=1 sm=1 tr=0 ts=69b29b36 cx=c_pps
 a=oPqA/Tq+JjH8vr8F0VMm+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=r-rn_B5BpjGCgIkgO9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA4NSBTYWx0ZWRfXys28A8qww6Md
 bT4kuW9udsaKOoqbUGVSAbY0TGG2vVUCfrFb1iVf2HNwDCnklnZF1ufrl5HAE5bm//B7qjWdD0C
 O1MgcaSWxI5Mj4ltl/aFam1J/fpouX890v3vIMJ4dHQKoVt0xxQzupxSp9kjJ8qKo4u07upakHX
 M35byG22iGYJb4hKC7ZT3+lKO3jn1ox09Dux/Bfr+43zzDhAiP8KbDgltItgS5ExgTh4dTN7cSQ
 hLJxYqlcwbUjNhfT5tdAFkRf0+Q2cO9+uZbmsnZQ+W4e45YiV2AtRzrcVKoNibPxljadZe3glAk
 Iwwz4631cn0tUehqioL4obFOIzK8ItPbdIvwDnwZHtWeLYm4F4EW7jXR6mzgkJeM9Y2B5nfOZCA
 H8K3uYkU5zUPN/orIwyvTDa7x5unxWzVpxW18GovG07KL0hSkzIGuGzvm3/4ba1UTw3GYvIsFXs
 3N+0erKi08UEQWck3ng==
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33101-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86AF4270C15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 10:37:46AM +0100, Johannes Berg wrote:
> Hi,
> > For example, I use the `iw` tool to display the capabilities and their
> > descriptions. The code for that has the following function prototypes:
> > 
> >     * void print_ht_capability(__u16 cap);
> >     * void print_vht_info(__u32 capa, const __u8 *mcs);
> >     * static void __print_he_capa(const __u16 *mac_cap,
> >                                   const __u16 *phy_cap,
> >                                   const __u16 *mcs_set, size_t mcs_len,
> >                                   const __u8 *ppet, int ppet_len,
> >                                   bool indent);
> >     * static void __print_eht_capa(int band,
> >                                    const __u8 *mac_cap,
> >                                    const __u32 *phy_cap,
> >                                    const __u8 *mcs_set, size_t mcs_len,
> >                                    const __u8 *ppet, size_t ppet_len,
> >                                    const __u16 *he_phy_cap,
> >                                    bool indent);
> 
> This is perhaps a bit unfortunate, but note that the HE and EHT __u16
> and __u32 here are really little endian pointers, and the functions do
> byte-order conversion.

I don’t see this in the function. For example, the MAC capabilities are a
`u16 *` in CPU endianness, which is simply memcpy’d from the parsed
`NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC`. Later, they are treated as `u16 *`,
as shown in the following code:

    printf("%s\t\tHE MAC Capabilities (0x", pre);
    for (i = 0; i < 3; i++)
        printf("%04x", mac_cap[i]);
    printf("):\n");

Here is the result on little‑ vs. big‑endian platforms:

    Little endian:
    HE MAC Capabilities (0x081a010d030f):

    Big endian:
    HE MAC Capabilities (0x0b00189a4010):

For the PHY capabilities, they are also a `u16 *`, but they are treated as
a `u8 *`. However, later in the description printing, `PRINT_HE_CAP` does
not take endianness into account. This prints the correct hex values, but
the interpretation/description is wrong:

    Little endian:
    HE PHY Capabilities: (0x1c604c89ffdb839c110c00):
        HE40/HE80/5GHz
        HE160/5GHz
        HE160/HE80+80/5GHz
        LDPC Coding in Payload
        HE SU PPDU with 1x HE-LTF and 0.8us GI
        STBC Tx <= 80MHz
        STBC Rx <= 80MHz
        Full Bandwidth UL MU-MIMO
        DCM Max Constellation: 1
        DCM Max Constellation Rx: 1
        SU Beamformer
        SU Beamformee
        MU Beamformer
        Beamformee STS <= 80Mhz: 7
        Beamformee STS > 80Mhz: 7
        Sounding Dimensions <= 80Mhz: 3
        Sounding Dimensions > 80Mhz: 3
        Ng = 16 SU Feedback
        Ng = 16 MU Feedback
        Codebook Size SU Feedback
        Codebook Size MU Feedback
        PPE Threshold Present
        HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
        Max NC: 3
        STBC Rx > 80MHz
        HE ER SU PPDU 4x HE-LTF 0.8us GI
        HE ER SU PPDU 1x HE-LTF 0.8us GI
        TX 1024-QAM
        RX 1024-QAM

    Big endian:
    HE PHY Capabilities: (0x1c604c89ffda839c110c00):
        Punctured Preamble RX: 12
        HE SU PPDU with 1x HE-LTF and 0.8us GI
        Doppler Rx
        Full Bandwidth UL MU-MIMO
        DCM Max Constellation: 3
        DCM Max NSS Tx: 1
        DCM Max Constellation Rx: 3
        DCM Max NSS Rx: 1
        Rx HE MU PPDU from Non-AP STA
        SU Beamformer
        SU Beamformee
        Beamformee STS <= 80Mhz: 2
        Beamformee STS > 80Mhz: 4
        Sounding Dimensions <= 80Mhz: 3
        Ng = 16 MU Feedback
        Codebook Size MU Feedback
        Triggered MU Beamforming Feedback
        Triggered CQI Feedback
        Partial Bandwidth DL MU-MIMO
        PPE Threshold Present
        SRP-based SR
        Max NC: 2
        20MHz in 160/80+80MHz HE PPDU
        80MHz in 160/80+80MHz HE PPDU
        HE ER SU PPDU 1x HE-LTF 0.8us GI
        DCM Max BW: 2

> >     struct ieee80211_sta_ht_cap {
> >         u16 cap; /* use IEEE80211_HT_CAP_ */
> >         bool ht_supported;
> >         u8 ampdu_factor;
> >         u8 ampdu_density;
> >         struct ieee80211_mcs_info mcs;
> >     };
> > 
> >     struct ieee80211_sta_vht_cap {
> >         bool vht_supported;
> >         u32 cap; /* use IEEE80211_VHT_CAP_ */
> >         struct ieee80211_vht_mcs_info vht_mcs;
> >     };
> > 
> > The structs for HT and VHT use `u16` and `u32` data types for the `cap`
> > variable, matching what `iw` does. That part is consistent.
> 
> Careful. There are different structs used in different places, notably
> HT/VHT and HE/EHT differ.
> 
> For HT and VHT, look at the start of nl80211_send_band_rateinfo(), which
> sends themas individual attributes, defined in enum nl80211_band_attr,
> and the values that are u16 (NL80211_BAND_ATTR_HT_CAPA) or u32
> (NL80211_BAND_ATTR_VHT_CAPA) are in host byte order, though both are
> actually documented misleadingly ("as in [V]HT information IE" is just
> all around wrong.)
> 
> For HE/EHT, you have it in nl80211_send_iftype_data() since it's per
> interface type, and all the individual values are just as they appear in
> the spec, regardless of their size.

Okay, I think I understand so far. I had also initially wondered why HE/EHT
capabilities were treated separately from the HT/VHT capabilities.

> Note that spec is generally in little endian, but sometimes has strange
> field lengths like MAC capabilities being 6 bytes in HE:
> 
> >     struct ieee80211_he_cap_elem {
> >         u8 mac_cap_info[6];
> >         u8 phy_cap_info[11];
> >     } __packed;
> > 
> >     struct ieee80211_he_6ghz_capa {
> >         /* uses IEEE80211_HE_6GHZ_CAP_* below */
> >         __le16 capa; }
> >     __packed;
> > 
> > However, for HE the types differ from the `iw` implementation. Here, `u8`
> > arrays are used instead of `u16` for MAC and PHY capabilities. The 6 GHz
> > capabilities use `u16`, which is also different.
> 
> That doesn't really matter, they're just a set of 6 or 11 bytes, and
> e.g. the HE MAC capabilities are treated by the kernel as a set of 6
> bytes, but by iw as a set of 3 __le16, which results in the same
> interpretation, or at least should.

Sure. I agree with you, it makes no difference whether I use `u8[6]` or
`__le16[3]`, as long as I use `memcpy` and don’t perform any CPU‑endian
swapping at this point.

> >     struct ieee80211_eht_cap_elem_fixed {
> >         u8 mac_cap_info[2];
> >         u8 phy_cap_info[9];
> >     } __packed;
> > 
> > For EHT, `u8` arrays are also used for both MAC and PHY caps, instead of
> > `u32` for the PHY caps as in the `iw` implementation.
> 
> Same thing here.
> 
> > The current `ath12k` implementation always uses `u32` values, which does
> > not work on big‑endian platforms:
> 
> Yeah, that seems problematic and not really fitting for something that's
> 6, 11, 2 or 9 bytes long?
> 
> > I want to address and fix this issue. However, I cannot apply the “never
> > break the userspace” rule here, as it seems, it is already broken.
> 
> I don't think it's broken, why do you say so?

Well, if `ath12k` uses `u32` in CPU‑native order, that’s a bug, and I can’t
get `ieee80211_hw` registered. If I use `__le32` in little-endian order
instead, I end up with incorrect capabilities and mismatched descriptions
shown by the `iw` tool (but I can get the driver running). So neither
approach seems to be a 100% solution at first glance. Did I misinterpret
the rule?

> What's (clearly) broken is how ath12k puts the data into the HE/EHT
> structs that the kernel expects, but per your dmesg:
> 
> >     ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
> >     ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22
> 
> it seems that even mac80211 doesn't like the capabilities, so the byte
> order issue already exists there.
> 
> It seems to me the issue is that ath12k_band_cap is in u32, converted,
> but then memcpy()d.

The `ath12k` driver uses `u32` arrays in CPU‑native order for this, so the
swap is effectively happening. Later, in `ieee80211_register_hw`, the
values are compared at the bit level, and that’s where it fails. I
understand that technically `__le32` could be used in `ath12k`, meaning no
swap, but since `u8` arrays are used in `cfg80211`, that might actually be
the better approach. I just wanted to provide a solution that is clean and
acceptable. The `iw` tool still needs to be updated accordingly.


Best regards
Alexander Wilhelm

