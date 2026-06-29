Return-Path: <linux-wireless+bounces-38267-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZvKIIMklQmrh0wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38267-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:59:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 046816D73DB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:59:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=WinQoFmz;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=WXOj9o4i;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38267-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38267-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FEDA300B194
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275B389118;
	Mon, 29 Jun 2026 07:59:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B82D592C;
	Mon, 29 Jun 2026 07:58:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719941; cv=fail; b=qkPAYke+BbJis28WPNf9qlXPv4Rf/wejw1NA7gHfWKRIhMNOy6jXe0RpldZolZHUBJdUrbnMuKbYu+WjcooEbYfhZ1nc3T2ocN3LkPLFPUxjvQP+S2VBYJmn7lf4L9xrw+06goUD3z/VoIOFwtQdthCIwAYcSi0z5LUCMx+EpRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719941; c=relaxed/simple;
	bh=TobCvgc/f/DrrIKWIJPN9U0RrRgCDj7E2oR51Ww8wig=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=VDTqyNb217whEUsmPlK1lvWHM0GNElsuWXT5dAu6V5vIuXU+4TsLjT4BJcWF7jVorpujfFYuJv2z5/OuyjjwcXxi0ADa8CMxIKCrwADQMmG7LhUjt9MjM00WADsMTy6QuCJgTk1OgzVnQwb9d9wG4b5dE7Hyeq+rB+ctA6EJdtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=WinQoFmz; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=WXOj9o4i; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6lEKD1652265;
	Mon, 29 Jun 2026 09:58:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=UC+qFzwXL6Ivn09X5ou76o
	ieImJnAlO4pawJ4xtbIpA=; b=WinQoFmzLQwBM/RVVZ/YPZ8nQC3brKRcWqXhcx
	NrGh3qEv4pVcMHus/SZNgIMZFmdncumQ7XkU+YPPB4IIa8bvwbAmxbpUXXY5OUL8
	jzbtR4qBBgGsZNpN5j4u/IrNewJl9D4PQeCsQLjZb6fM0JbQK8dv7jA9pBChHUrR
	Aq42FaeI4pW7etxxTl6n6fAQrgEl3isRaC4i0nIF4SEY3OHiVj7PLslEzURy1WsT
	ijn8zxu4oOxr7sMrSmMd13S5B7skXfZnv6ThrFBtvRqeLP2YUXEiHgARmxkAT2MT
	+x4PhEFVn9d94lwK4Snv6hFdrPjXvhjdAcnEQFSduj19zIHw==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11021112.outbound.protection.outlook.com [40.107.130.112])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22v9ad1p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:58:49 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orJDhEPWquqM9wsrkM9NPuxtFDmpPHPwj8igty59hNQezQkOiCo36BTT74vo+fY0uOasLTSmPV2e2R/uJoVguoPw5MDHduf3VeM39KXgtnYFJB2YWudaNkDa8VmY8AUq+al4p9TpwDISCAYlS92ihbj1rpUmVZQyxWIdwHF+K9G8VTkoYw7N7MnhMT2UQefpg3BgWo1KCiIJf1rRRv6Pg/+slHQ4EIKicmJj9U26aws8nY7KLpsyiy8rsuU+7a7IJIPehlbOYkOuK6tHaZ0NYHdX/Ju/2KCzxvGFmJguptHFQIcBYzHkVlbMYtR3raXzAgm2pwEEYbW06oNG6XsO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC+qFzwXL6Ivn09X5ou76oieImJnAlO4pawJ4xtbIpA=;
 b=fRPxUREJJ/r7uS4AyDXNV4JgPkW1eVFzjSiAJdNx5/JkDkJgRbTfVahjcRg/HpOcImkogAoYKR0tUkxU125AHHld3AcSOqsOq6tEuPtm2eTSa6/aSPEdZ9LK0C6o+eJMUU6Pf4l8O6Q1rAKK2TvaP3lysU8hShg/E+PTsyUVRBSMVnonHPl5sHaJ7deD2mFuqbtUbmwYLbEZi5507ptRxlUJ8SsPIvBYTEXdVLxF50NZn7v3O/Og5zKhFeA08fdPuDDoVFCKBZZ0UKuu5lP10blADpauhk5JdK8J5agL6iWkNXUmZC5213Jh3LTnHdZI1rvziMF9XOzrVoIEE3PR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC+qFzwXL6Ivn09X5ou76oieImJnAlO4pawJ4xtbIpA=;
 b=WXOj9o4itqlFSDtfmira/a5KwOqjPYa7KQVma+1BQJ74oTlYzS6QN9MMzVwcr1Sa5zEA6Sn8T/IktOloXHK64Ox/+3Z0cgiD7Hr5UNl+KmY1I0qd9GlW/2zy6CSXPnWRxe3VfDb3BpgF7JcgYBiRs9bBNWsOCP1MxR87bDkJ+pE=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DU0P192MB2075.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:58:46 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:58:46 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Mon, 29 Jun 2026 09:58:44 +0200
Subject: [PATCH RESEND v5] wifi: ath12k: fix endianness handling for SRNG
 ring pointer accesses
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-fix-srng-ring-pointer-accesses-v5-1-c5c2ea87d960@westermo.com>
X-B4-Tracking: v=1; b=H4sIALMlQmoC/52PMQ+CMBCF/4rp7JECUqOTg6wOOhqGWg+5BFpyR
 1BD+O9WJmeXS95L3vflJiXIhKL2q0kxjiQUfAzFeqVcY/0Dge4xq0xnRueZgZpeIOwfwBRPH8g
 PyGCdQxEUMMW2Lna31KX6piKkZ4yLRXBV5/JSno6qin3NoYOhYbQ/+DTXpoiEJNe50RtIwbb4s
 v6OnDypbbDtDk+UKOxC4kL3FTQkQ+D38sBoFs2fsGqe5w+eFtlpEAEAAA==
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GV2PEPF0002399B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::18d) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DU0P192MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: b0664f0f-3896-49ea-226e-08ded5b43f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6ogDDyF12eW6/goQgoEpRflYH5HeJKw2gxBEJfG52vVP5qJBUn/yny+0BzWKWDTOeY4xA/Vs2e1QOU+CHhoE5re0Zm6+lQNBFTvspnpIAYt4gQ5/HN3pZc2Mj8MBvqT2BozWvgNjReMXMLZaVk7gDuYc2nKGLVe9dDIrWo30wkkKsWW+sm5TeEfmN7w43PZ4UrxMLf2Tc9SLIsXEaLn+H3zUhh0HdEUiv4F0iH/bkMkfxrIMGxKGNV0Nh3PNAq66exN/MY0iSSqHpnzaICP84AvH2ZkgIViJr8OU90bTP0qK4sAIEIwkOg3nD5ueRV7/e+74vEvtqA6X1XuLazRWW6LdNn/27iNDO8OXofqu0K/2W8VFXM+6My6Vi6CSr/4ejcn+6sJnLTT4QPwnJ9mwG6dr4zYd7Zb1ndcM3bamAAA78/JKMs4pnFo3dFC2oZURyL4eJxNyveg9H/gefwauoEI99C6Nf+ZCgNASR0eh9jPGtdV20+lUbFd+fNUcxTwU5A1MIC7cMMfwgVl6id1EePZQoMO+xaDBoA9ewuJk+xmb2MjtT71Yh7RkpLXLYB8a/k1uN/2P0Gh5zAztQljxLHzZ6skEmAziIaRKr5KzY+Z32iaclOuB/3OfRM90c3K6UcKZcn5JOFBEetKwKt+OiLcCDkEAFKYPk6UrwXcVWZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmdNRGVUWFlpK1J4eTIvLytabER2RForSXBNZmY5aTVtZ0tmNUlDbHE0QkVa?=
 =?utf-8?B?K2srbU9kZmJITFgyOVl1MzUxVmFFQWlMRW10R0hVMjVSam5iZzROL1BiOHc1?=
 =?utf-8?B?OWlWdWJiZ3lGNlhCYXN0UW44aVM0SWU5WTFWZisrZzZWKzRGbTE5K3hHOHQ0?=
 =?utf-8?B?RUlnZC9UdmtSdXQxYkcxWVo5UktBM1htWHcrbC85Q25YNUhnR2JYajM0Q0Ji?=
 =?utf-8?B?eVQrd3cwN2lDN3RoblVIdERlL2lyNkx1QUZnbjIwNTdTWEdJNkVpSjNuSVg1?=
 =?utf-8?B?ZmgvS2NsNXhLZUlmWUZFRnF1aFRZdDRVOU9RTklFc0lLdzRnVVFQazVSd01Z?=
 =?utf-8?B?UUdZaUlXZUF2Q29HOUJOdWZLV0ZuR3V4anhZQ3p1ZFYxcWhnWGx4TkJtSHNI?=
 =?utf-8?B?R2phaUpldEphQTRRdWxmaE5rWVJ4TGYzbjB2SzBEWjBaVTdFOHpPZ05IN0po?=
 =?utf-8?B?aE0zNzg3OU8wNWlMZGRzdGpXeFV4SUFlZ1JuT2JjVnpvcStjc1ZPelRVYUY5?=
 =?utf-8?B?SzMvVmV1eU5SVExjUzArZG1lSFZjVmREWXo5bzNsZjV3b2cvUytRazZmbnRx?=
 =?utf-8?B?cGZEN3FjQzhScnVKeUFhNW1XYlRZYkorajJUWlRZSi80aURQWFlmKzR3SnRN?=
 =?utf-8?B?dGNGSGM1M2s2UFo2VmsvS1lDOGtLVVZhYmhYREJkb3JUVCtVOXNUQldiZDVa?=
 =?utf-8?B?aXBBRjhuOFVkaC9tTUJBb1hMU0FPZGJKR1Z0QUtjdUJmQ2oydHpVUEMyWjNl?=
 =?utf-8?B?THE3SEQ0c1JtSC9mMFhydlZwOFdjbVAwcHJmSGlmWU1NMStOdENnWkIzN0ZZ?=
 =?utf-8?B?S1NZOFI2amVyb09NeVl0eG8yUGkzSlUzTEp1Wkx0VzdXS2RHWFFrZzRzbkNx?=
 =?utf-8?B?ZytyUk83azlaU2tpZjU2aWlTY1ZPbGg1M2ltMEpOOEhXeFMrTmNwNWNrenBv?=
 =?utf-8?B?bTdUMHQ0WkpLdGZTWE8remplV1FWTWpRNTVsTlQ4V3B3RloyTTViVjRsWk5r?=
 =?utf-8?B?NGRFNmlNOVJEcE8rRmdMSFp4aktQRzYzMzc5SmZMQ3pURVJjSlQrUWtWY2NE?=
 =?utf-8?B?bFBFK0pYUkh6OGttc1MxZFpUQVVSSUFXVlJES3hxSS9weTJlRHRTY0wrU2p1?=
 =?utf-8?B?MGk3cG5JR2ZMWUg5c0lNUmNFT1dRWGdHdWgySUpVbjNsUFArTFJIUTR2MDVk?=
 =?utf-8?B?eDdWdFhaRkt6U2l5OUwyRmlaM0w5cWltZzkrOHlDZnl6QkMzVnNGcDJSNnBk?=
 =?utf-8?B?V3dNSWUxbWFpSjNxSVhHSHB4N0tOcWJlWWpMWmtEbEtSOUdsandLUnpGL1JY?=
 =?utf-8?B?QnlNUy9wa1ZielFIRFdJelc2bEhHRXpkWWlpQm1TcDNNYTY2RmtqRG41cDZ2?=
 =?utf-8?B?bG5GK1NiZ2d5RWJjQmxpWGFjRUQxbndHUTZYMCt5cVZPM1NMR3c1TFhsbmFW?=
 =?utf-8?B?NTR6SVo3VjhIN1QwZEVRenljQzF0bXpzQUdQaTZXTkJFM3kxZzZOQUVyRWdK?=
 =?utf-8?B?V3FnWnJpZ2NmTE9ZMjJtOTczTDl6UGhJNHBaNkJRUHAyOGlSZ21Eck80QTdi?=
 =?utf-8?B?Z0l5blJHa2dOS1BuWHpZTi9tMk52Yjh2dEdWQ2xlVHZZZGp1dDViZlNPVFZV?=
 =?utf-8?B?eFBHWXRpcSsyLzVmOUwveGpQaUxuckdKdVF3VG40QTVuUVFKRzZDQ0dLaWEw?=
 =?utf-8?B?YVpVQUM5ckdQQmpONmRwTHRFQWF4Wk5iVWlEb3NreUVtaHg2MllrenphSjBO?=
 =?utf-8?B?dzE5RWFvWlk1NXZOSlgrWm5OekoxUHlNUlhJcUdYZGZmbHpRVHBRUHF5SVpT?=
 =?utf-8?B?cWRUSmEyOGU0NXhETmNSWmxNbmF6TXZFOHIxWWJTVnNTa2NoMGwyM1pId3hh?=
 =?utf-8?B?eE1vNmV1KzYrbkMzUVd5T2RwNTVOT3FiVnR0QUdldFFlbENZSlFpdC9wc01j?=
 =?utf-8?B?b084SzJqRVZLMXlDQTFlTEl4SE81YU9uQU9mc29Ob3B6LzR0TmJCK2xwZlhO?=
 =?utf-8?B?dGQ1bDBhdmtiQlNvb1REOVZZR1FKRkw2bEswdnVqU0xqOWhXMUFIendBTnVk?=
 =?utf-8?B?ak11L3FuWTNsQUJxUjlyaGlpeE1FNUg5TFhISWZHSjYwRGtkbmVHYmdnclcr?=
 =?utf-8?B?MEh4dU55OWhQZ0FrUmx3b2w0clZlZ2FiUHFuMk0wa2NiS1QwRGVmS2plYXlo?=
 =?utf-8?B?V1hnRkQ4b012V2R5RlEwQXFnRlowc0xHWFF4NkpKZk04bUZpWHhhR2R5NUpH?=
 =?utf-8?B?bUE0WGg5M2hlTGtCWWJYOXhVVm4xNllkOVdRV3lDOU9BKzhCMnMxWVB4dG56?=
 =?utf-8?B?eWpSUlgyWXhOWWV5ZWNiVU5MUGpERlRUZTNKWUV1cnJpU3pVQTNudz09?=
X-Exchange-RoutingPolicyChecked:
	M/WUmxHFOFSJiyXeQoWxinlWrHqRFejNz4act7R2gBYi/0VxngW0eakLHlfyGriAMzlRtXjcrpzY9P8TB5TvGV6YVxmi3GpGaLq25PyZ4WBZORzphCSug7K+dqa8G488jxUvXKMNAXx/91cgsBNqHW/OVjsnD8/8N5ZqEyzDD2CYDf2kj5zZiwnS/pEaLWIerooD/qMXtLnCzeJ4RRbGn9LuCRoyTWWMjxwSZFgqNdqFnHP3ZqJYejJwr8naTNUq8ewNL+IVYQ4mlJUry/ZwrPhmgYG9auaoPFtZGoEyC1PaDHN31rHI7sIeJr4qCT3yl7RZbBPXoKayxW/ukxE2lA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d+bleG8u+fOx/IyMYMwRuzI8nfK+NQEG+8nbnZ8AD5eXx8Jjq99+9Sgw7V13qLCYp/I1Obyi079NvZg0CzLmsuMl/EAW8WqLDKFFGfb96NAAyrTzArIW4AprtDwpv8H+rx9l/7/f97vAUr+NCLH3cDp4RRZYp13yTvjUUkA7oWYxAXQsu1puUjbBFtF+AM1O+nhrPAjoE36mSVbhlCg8d/cLX8dHR5duKRk/uOKDCya1m+X6mxdRfHQ5bAp2gZkbEWiXWdXbYeNTDy7lgdpoNMu3nyCYsJ77mTSNM4KZ0t2tMVYmPB7zTeF7XVuT44OGzjfT7ihdfAT0vz95yF1UfwOJcwLpDIf59Wr0crTRSV3h8rrAjuwG9rpjq2ndb/iF6d1mLnpohKbVy1yJAhhhKNAcT4h3VXICQ+RwujcrkBUBh+PKv0NLFlouXHX8v2xfnQwd9yd0cRxRAOn+ErRn/w/il5UN472m0defMh2oAyadxGco2EEZisPgYp+2VubejOxyHvA8DypjtHuM2zzJkU9o5zp81Vy3iONhnRnNSMsRywQgfEI7aEoFTKA6SoQj5DlMZE9Jqna+LLsIvB/xQldBbCrM1DpzJXXEMkiFMy5JedfGkOeQJ5lwLopj1ohH
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0664f0f-3896-49ea-226e-08ded5b43f14
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:58:46.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaI/Eq9+Mzp9MiU7gHUAKSnDFGZYM4so+zVHvSsMpdBbX2+8K9DnDwDN78WLdIJZmDZS/JSQpnSbM3ZUAAIGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB2075
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: DU0P192MB2075.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX0soTEnUvtHyZ
 WZR9orB/2+HyjUZ7rL7Ni2uFUUb1TuBXVwMWRg5yx5GQ7e58zx9I7BFVIDqGRvzHSllbOzccm2R
 UTCisjBXbZQwTePolK4JqtpI0SN9LDB6IbzHwl8BJOT57+C6JwouVeS4uHP8BzflZPPGOUGTz1t
 Kx+UTzXBtae/q19CS8Rd5ao8o94aIzbMFBEh8QJj+1oeJyz5gr/yo49zDYFy8gDgy19a09ZTiM0
 CXUs0v+2k3YZozitXvzj2hJeYDnsl/vO0IeqZSbH/FXhfsl3iE1W/3GcZTyYe/mGWpBIFp+wqJu
 MpAeCCqJRmosY/+Oex3fdjknhEXCErotY7o7g7WDrCnbfNXA3zP3h+2ySsjY5eGYTFDjP/mGzIA
 0Prqi+9AEP1PDTjYKdSp/qSpOdo7QMIRzcPN+s3tEiCXP+3DDjrn0f7Mb6E3SR2smhSBTfbNXcX
 ffioQBNsIIt6Qv/1t9Q==
X-Proofpoint-ORIG-GUID: ACT-nl7JuRyXY8RAXoK_NZXWPUoIqVmg
X-Proofpoint-GUID: ACT-nl7JuRyXY8RAXoK_NZXWPUoIqVmg
X-Authority-Analysis: v=2.4 cv=ZNznX37b c=1 sm=1 tr=0 ts=6a4225b9 cx=c_pps
 a=PWafkdTFPpR4iz/D5OZcbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=xIER7TDS9NvsDhoS_LkA:9 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfXzSQU2GpLetEA
 u9HyoUCVYjhpgFVjWHvKIJ5itK4WQv9LiAaqXhavo4FXuOQsF5F4NftBc2Sy8M1HLF2nh/VCFYh
 ZA2N1CodiRYHNt0p6B4QkKSNRnaques=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38267-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[beijerelectronicsab.onmicrosoft.com:dkim,westermo.com:dkim,westermo.com:email,westermo.com:mid,westermo.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 046816D73DB

The SRNG head and tail ring pointers are stored in device memory as
little-endian values. On big-endian systems, direct dereferencing of these
pointers leads to incorrect values being read or written, causing ring
management issues and potentially breaking data flow.

This patch ensures all accesses to SRNG ring pointers use the appropriate
endianness conversions. This affects both read and write paths for source
and destination rings, as well as debug output. The changes guarantee
correct operation on both little- and big-endian architectures.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Changes in v5:
- Revert removing volatile from `hp_addr`

Changes in v4:
- Rebase on latest 'ath' master
- Remove volatile from `hp_addr` due to the `checkpatch.pl` warning
- Fix opening braces at the end of line due to the `checkpatch.pl` error
- Fix `u32 *` cast in `wifi7/hal.c` due to the `sparse` error

Changes in v3:
- Rebase on latest 'ath' master
- Use always 'le32_to_cpu()' macro for conversions

Changes in v2:
- Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
---
 drivers/net/wireless/ath/ath12k/hal.c       | 31 +++++++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.h       |  8 ++++----
 drivers/net/wireless/ath/ath12k/wifi7/hal.c | 14 +++++++------
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a164563fff28..9b55c516c9eb 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -355,7 +355,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	tp = srng->u.dst_ring.tp;
 
 	if (sync_hw_ptr) {
-		hp = *srng->u.dst_ring.hp_addr;
+		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
 		srng->u.dst_ring.cached_hp = hp;
 	} else {
 		hp = srng->u.dst_ring.cached_hp;
@@ -379,7 +379,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	hp = srng->u.src_ring.hp;
 
 	if (sync_hw_ptr) {
-		tp = *srng->u.src_ring.tp_addr;
+		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
 		srng->u.src_ring.cached_tp = tp;
 	} else {
 		tp = srng->u.src_ring.cached_tp;
@@ -501,9 +501,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
-			*(volatile u32 *)srng->u.src_ring.tp_addr;
+			le32_to_cpu(*(volatile __le32 *)srng->u.src_ring.tp_addr);
 	} else {
-		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
 
 		if (hp != srng->u.dst_ring.cached_hp) {
 			srng->u.dst_ring.cached_hp = hp;
@@ -529,24 +529,27 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 		 */
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+				le32_to_cpu(*(volatile __le32 *)srng->u.src_ring.tp_addr);
 			/* Make sure descriptor is written before updating the
 			 * head pointer.
 			 */
 			dma_wmb();
-			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
+			WRITE_ONCE(*srng->u.src_ring.hp_addr,
+				   cpu_to_le32(srng->u.src_ring.hp));
 		} else {
-			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			srng->u.dst_ring.last_hp =
+				le32_to_cpu(*srng->u.dst_ring.hp_addr);
 			/* Make sure descriptor is read before updating the
 			 * tail pointer.
 			 */
 			dma_mb();
-			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr,
+				   cpu_to_le32(srng->u.dst_ring.tp));
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+				le32_to_cpu(*(volatile __le32 *)srng->u.src_ring.tp_addr);
 			/* Assume implementation use an MMIO write accessor
 			 * which has the required wmb() so that the descriptor
 			 * is written before the updating the head pointer.
@@ -556,7 +559,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
-			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			srng->u.dst_ring.last_hp =
+				le32_to_cpu(*srng->u.dst_ring.hp_addr);
 			/* Make sure descriptor is read before updating the
 			 * tail pointer.
 			 */
@@ -711,7 +715,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 	 * HP only when then ring isn't' empty.
 	 */
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
-	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
+	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
 		ath12k_hal_srng_access_end(ab, srng);
 }
 
@@ -810,14 +814,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
 				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.src_ring.hp,
 				   srng->u.src_ring.reap_hp,
-				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
+				   le32_to_cpu(*srng->u.src_ring.tp_addr),
+				   srng->u.src_ring.cached_tp,
 				   srng->u.src_ring.last_tp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
 		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
 			ath12k_err(ab,
 				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.dst_ring.tp,
-				   *srng->u.dst_ring.hp_addr,
+				   le32_to_cpu(*srng->u.dst_ring.hp_addr),
 				   srng->u.dst_ring.cached_hp,
 				   srng->u.dst_ring.last_hp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 43e3880f8257..ff6148be94c8 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -914,7 +914,7 @@ struct hal_srng {
 			u32 tp;
 
 			/* Shadow head pointer location to be updated by HW */
-			volatile u32 *hp_addr;
+			volatile __le32 *hp_addr;
 
 			/* Cached head pointer */
 			u32 cached_hp;
@@ -923,7 +923,7 @@ struct hal_srng {
 			 * will be a register address and need not be
 			 * accessed through SW structure
 			 */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Current SW loop cnt */
 			u32 loop_cnt;
@@ -943,7 +943,7 @@ struct hal_srng {
 			u32 reap_hp;
 
 			/* Shadow tail pointer location to be updated by HW */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Cached tail pointer */
 			u32 cached_tp;
@@ -952,7 +952,7 @@ struct hal_srng {
 			 * will be a register address and need not be accessed
 			 * through SW structure
 			 */
-			u32 *hp_addr;
+			__le32 *hp_addr;
 
 			/* Low threshold - in number of ring entries */
 			u32 low_threshold;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index bd1753ca0db6..c05bfcffdf5c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -320,7 +320,7 @@ void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		if (!ab->hw_params->supports_shadow_regs) {
 			srng->u.src_ring.hp_addr =
-				(u32 *)((unsigned long)ab->mem + reg_base);
+				(__le32 *)((unsigned long)ab->mem + reg_base);
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_HAL,
 				   "hal reg_base 0x%x shadow 0x%lx\n",
@@ -331,7 +331,7 @@ void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 	} else  {
 		if (!ab->hw_params->supports_shadow_regs) {
 			srng->u.dst_ring.tp_addr =
-				(u32 *)((unsigned long)ab->mem + reg_base +
+				(__le32 *)((unsigned long)ab->mem + reg_base +
 						(HAL_REO1_RING_TP - HAL_REO1_RING_HP));
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_HAL,
@@ -384,11 +384,13 @@ void ath12k_wifi7_hal_srng_update_hp_tp_addr(struct ath12k_base *ab,
 	srng = &hal->srng_list[ring_id];
 
 	if (srng_config->ring_dir == HAL_SRNG_DIR_DST)
-		srng->u.dst_ring.tp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
-						   (unsigned long)ab->mem);
+		srng->u.dst_ring.tp_addr =
+			(__le32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+				   (unsigned long)ab->mem);
 	else
-		srng->u.src_ring.hp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
-						   (unsigned long)ab->mem);
+		srng->u.src_ring.hp_addr =
+			(__le32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+				   (unsigned long)ab->mem);
 }
 
 u32 ath12k_wifi7_hal_ce_get_desc_size(enum hal_ce_desc type)

---
base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
change-id: 20260326-fix-srng-ring-pointer-accesses-657f59b1c10b

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


