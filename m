Return-Path: <linux-wireless+bounces-23560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9845ACC936
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879DE166446
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFC1DB366;
	Tue,  3 Jun 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="mjjSDHFD";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="yNGcVyBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE7239E7C
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961413; cv=fail; b=YTu0z8y/zvemllAbtEU9vDLFKpVMKayk3dqOlvdRJSpNiql4CpmXsBlMdyHVqXxDC/9RTAm1zVra2tyw0TaV1xhIhx3vTFuC1QrItTc+txyJ9OCgvhiPJ67aU0X0fM8b/nq4uVh83FVWjIX1IgqD2Xe4yQk17vsyi6Z7QtOvXsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961413; c=relaxed/simple;
	bh=buZ9Men0/bV1JdpqWiBDoEqXhfyRFnJy2Na/Nc4HlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=m4+RvW2n8JGeBWLojdRTmSxFOip9b16YDkm50/Yy3SOOI9dZygYX6Rrch7fauS/e1pjXC+PpEvTNHwM04cbSAZcYz7kxgKPzvlfXScmUCOim7z9T+kwofunDbQbevt43rHlT+8hZdJQB1EL9xxJ/w84KMhT6ilGJjkwX7PiDBd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=mjjSDHFD; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=yNGcVyBh; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5535uTif004212;
	Tue, 3 Jun 2025 16:31:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=2k3p6avdtkQC75u7oF10EgCn8qZBbZ0RQwUnGJRB7MU=; b=mj
	jSDHFDD4BryN8cOoYM8yj8CFrDedAwFldSq8HHaMirMOlRTydj+RXE1ilkU496PF
	s16JmJAAxSU9wA+0MEbFv+f/bRaUgx54SdqALi+BG1EewFRVBo30m7Uw7QIXXs2h
	lLQCBTWE7M6cY16w8/CcWqnJYUvJz9wOVLgeCVuu5vSEYgKuaKBBk3BmKh/cahRL
	d/dckJGY8GIiEuXyvTxsp5G8FHruHv3rw7rDbA4pYvRGwP1gZGFlc5SWyxmlc3gJ
	GZu1zejj3dC6yaMUXgJVTXsMR5TmZrbIJNd+yz6YlB391KjCXLudPoGMZFGqdeTw
	H1sVfYUBbYtUuS13e0HA==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46yp4cbcue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 16:31:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6EZgmYTxk/kwU7k73Z5j5Q2/XO66mbXO3HI+fPqhwk8TlnPAN37wOJhlXZSGtZypCLDHT8o5qV9i1P8J5K/Cn5K7BxglFf/463bAluoqgDv2wogDlTEUoV8ucKTZkUYN27IosvD6bpBrK1afxtGCWKd8Cf/pP3+nDvjnAi7wgxZCnMbK7ELej8zDhJW21NfzPvHo1s9wvIaoLCZkt9xE90M6XuFUjtS+vry2DDHwfSOpbx0rs/w4lWsxZc67sdZIvI5XFUv8uCeT9P/5Cpb7oovMkbY3C9Y85uw26Gd9/E7GwMfq94TKb3kZQjseyMVzWVtQx0nsEQyp+h9uIdlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k3p6avdtkQC75u7oF10EgCn8qZBbZ0RQwUnGJRB7MU=;
 b=YZb5qY1pKgJQZ85MQ0FhmIarwmP2mCq3FEhWeSk8vNO0UgJeoRrVxcGCoNZSqptKP7BieiIaS74k2qhC45B3ZvEZ5/T/L/H/ifiFXWjYrBOWOEe8DOS2cumcIX5n9iqGlEoZga8Zr2m0yBNKQ8LPThxbR3nTw7UNa330CJSNskImIBOqQB9/xZdqmX0wzNQhn/Vmk38jASJ6g091k34TddEnbmhXbV4pCMF6iHSKRBlZgtyJ/LyMTtaUESc6p2i/622P8jPCCdxMyj6n2Pg+k5URiRb9zixFHcugB89o+6gk7+L3W0FKSVIxpQEBjV4QAXuh/UyyPDq5f8LKaEFT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k3p6avdtkQC75u7oF10EgCn8qZBbZ0RQwUnGJRB7MU=;
 b=yNGcVyBh5cg/hytpse16cK2b9yLxiEa4gkmbtk6RXqWC8eR/WlZ355lx0G9Ujb3gLKhK8O1zfc7ofyda3jO+66K0U7/eWixPw5AiAU5odTr3KKk/3OpuTMRpnBnSxqzuvfmjEi/FCGCKFjPanhJBtMCWbIPbvEh6l7osvfbXJn4=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by PA1P192MB2797.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 14:31:13 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8769.029; Tue, 3 Jun 2025
 14:31:13 +0000
Date: Tue, 3 Jun 2025 16:31:07 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Subject: ath12k: big endian bringup
Message-ID: <aD8HK4Iagc99skN5@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00002BB5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:a) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|PA1P192MB2797:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfc258b-bf78-42c8-f348-08dda2ab4a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSKmGm/OO402TfLdiGBAOo9AUtEzZu3xicP90Yh18bIKzjgY/Qvwvomtsghc?=
 =?us-ascii?Q?DbGjrreM+3jlmfcpICQX7A9HujMtjP8U8fzaBIJTaJCO3LR10npl6xbaWGQm?=
 =?us-ascii?Q?cS/2QTAiDidBLl324V67O1edcKoLlI8KXMnu2VtXj9WBquHbTeYZCYbhFf3b?=
 =?us-ascii?Q?zLAkeY8egJYrKHvTOHh3XsgzpCp2TwBxmlhINPcFLdQ6Escg+PWQ4rx+BPNG?=
 =?us-ascii?Q?NbQFr78Es+gTVqQcbSA1SQO+B/NsbKPMyoUEmpMxDhKJmpTygctMWnlOmlVB?=
 =?us-ascii?Q?nL7BI5a/r0q6Bt+6yFGUb6NiD46Q+Kc7bWfB57mFvBwXeSIA98SbUHmOKBDA?=
 =?us-ascii?Q?6eKHNd6hNo0vK153Eoer9u4EJpdVzFVaIvD3MXZh4K1LyTxI9xcSd0vTiIpq?=
 =?us-ascii?Q?s1S0FyX3InYtTAl0h0WCc7XeE7mXJ4nHIYZ9u1stTFik/dLLO+Au38hk9rE1?=
 =?us-ascii?Q?tEw3AAvliM6sAskxLXG7Fm2+kQPwGUIsAHwFBD1PQ6UJFSxRA2sBLe/ps7SI?=
 =?us-ascii?Q?7lz9PTAWCdhJSNwElTrM/eRJGo+UUr4nIJSZvudadXPw8dDdWU/sHqEnQoFf?=
 =?us-ascii?Q?5Hm4NlS+TK1YwoFWBn52hVT2aaShYcTn4HIlvaWC4mNeTdizW6+UZ+jSde+P?=
 =?us-ascii?Q?C+J9ekFOF7psUGh/3vJMd4yzCQfmum5vVaFTMWqqxZzwjAY642S+Fbuvv0nl?=
 =?us-ascii?Q?G7JIAJO8n4liEsZ5HTSRhi+BBkG5fEJKocsm5IbgwJ1BV8FVzq8+uKTL1bqs?=
 =?us-ascii?Q?dAc7uqJxse+qgLwQiW0FjEnwvBgL2PW/OTs0ritiJAYg53q2iMpeNbtBSp1U?=
 =?us-ascii?Q?XsrBLKzMbs2WTXeaM4knylceYGwsgtKUDq3TRAHSW2YKJCPWtd2qyFV8mvWz?=
 =?us-ascii?Q?Z2oxPZrNHuPwEHS2hWPI5T0fR5MQe3T3JLtamaOH1+MkusxXTqP7eJ2JHfKr?=
 =?us-ascii?Q?3XJZdE99gUgn/D0rPN12QDXQejXir2XWnan3q1mFK3quV+5Da1roqV51K+8n?=
 =?us-ascii?Q?jiTBLoUq2g1msvv+LLdcOKrf+Fqyr7NmcurgcGDs9+ILrhtP445y23HLnred?=
 =?us-ascii?Q?hs3IQByW1Ee1pI54jjCJrrJ/RcYmLY5FfVq9NFH/G2gQLi/LaMppxLi13VpQ?=
 =?us-ascii?Q?CSBs9cctw8uRGUJRUcJcXfLcHlEfEa3V5v2uD9eEGn5h1kh2xUngbnVa16yI?=
 =?us-ascii?Q?UW+ZpusHoh1h00Ojlu1WtWn4uNLDY2tQxhXlTkZKMffELWUaMnPHeGS8QS15?=
 =?us-ascii?Q?YnZC0c3n2TLsfUydXW17YwS/Klv9X0XP7Y/tuXS5vrjtbFPuxnLAkF0xb2Qx?=
 =?us-ascii?Q?stm98VlbppFXwpFWJ5gQe2va15dz2yRu8ItlBt5obOAhemHL6+xQbKUP3AKi?=
 =?us-ascii?Q?/+9livRes5931Rtagz3oxUeBs0oEiIeKkHWHiBkjwM+kd8ZP8TBr+rg2msS+?=
 =?us-ascii?Q?EMs7e2hWHPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2A+CI4EQ118584E7EfrIzg7OduW/zjY/Upw8tuXK35+dfeDaIPsf6u3Ok7wE?=
 =?us-ascii?Q?vUy/ix4jLarUZbZcBWJ8CLxeRebwzXnwKS6Bm7nPyRFaFPUnAxuHqmv9u+fH?=
 =?us-ascii?Q?EuwZam15PI9/VLQL2evFBLTtWHqSxe9Dt1tJnMOR0dG+pC3Gu4sj86xg1/n/?=
 =?us-ascii?Q?ST3cAhA3XOZ/ac4mgib9LKS9e9GM1Jd4i3wjIMifv4QWCS+cVtrkkFtv9zo2?=
 =?us-ascii?Q?EMLqV+jdrmoec0Pg5ekSCJUmYCPpUiDN0WytGOZUhghq5GaO+9PLBkFm7hT7?=
 =?us-ascii?Q?I9oC3cBSr/T8CyX5XokGiPx9SHDX6vS1Dn0fuStS2Jtc3Xq9hJtSyUUxwTkc?=
 =?us-ascii?Q?sXUfvmApRYNVK35BF2Au0O0+jsQUanYjjWkiA4SXf9REZimo/0Q4O7J4pLWd?=
 =?us-ascii?Q?IcQ2hvNRIVNI/w0EBEGI8NALLLbTrhMD6yG+rHueXZvOVEOsV1qLpAdGSWfR?=
 =?us-ascii?Q?RyaLIOFauZq61impQyo50RNhRPM9HZQu9gGZ8CGCxU6j/8otYViVa+gqWiwF?=
 =?us-ascii?Q?SeiAjxT8IiSSdjPNm1F74/J5oKIRpI6JHmLivzVE/iA4LhOBf6pvQRILqQsy?=
 =?us-ascii?Q?lyYrARrrlXfvHNeaFyMA7ST08YibB2pz+uJEPX28m8Lm8/uXHbaBK8JopyiU?=
 =?us-ascii?Q?FoJR+1jl+/qtT7fP+HXWpDfU/wxS6dbp/CXiy6fXgFgcvHz4ILvFz0KVHWgp?=
 =?us-ascii?Q?RagS2/Tva/Yh1A1S15ZRNtCdS2KHzGT71oKB5gnnR4AmK8gQn5NzGw3Ax2qL?=
 =?us-ascii?Q?81+Zk5eiUJOUXQpnwC/nkSmFjWgItgt/uLk1p7LAkfv+vcI3jOlVaVOgeO+e?=
 =?us-ascii?Q?FzB0OyRDQQRYXWGpIRww1c5eKzogrdEFcg/nXHmG/V0cvGhYra6CmrA9q/SL?=
 =?us-ascii?Q?QQJ9gUL+b60myAlYhyD4HASOVsd0l20LkEI7WvBgrLNrVDS3iWMId7Rj8aFQ?=
 =?us-ascii?Q?/0MP6seCcBlrjWdupMu7pp41N9z9zYNOj+k7ES7teKdbYQPxTJEFYqesIjA6?=
 =?us-ascii?Q?Abpdg3hZframv5hkcZ71ZlyK5rFXTKG+QbmJEs1TertEkAp5pBHq7FfQLm1O?=
 =?us-ascii?Q?oUaHU8pDylaPfF8xz5tinKfHjhrIfp/9G751QKMtXF3VbBU7gesX0xzHWbyZ?=
 =?us-ascii?Q?mY9ovkG+Lwzv7z+tEbcj6D+O/wGPZUYiYRwvXsrJ6FwzpIk/ZiyNEmopL5jZ?=
 =?us-ascii?Q?xcEU9JyXaxct76bq34rillw3HcutaUldDaS0niULUeaNkF7QpaeIDe8fU3pb?=
 =?us-ascii?Q?+22wfTaV0ABIIv2hXCj/b/sLEhJpzLsDcmQc8uvisiGrECA/dT54sRK8psL+?=
 =?us-ascii?Q?pfHRJBHtRNSXNDJIYgnSOOMjm529q5Zlxcl3ISoAXq4w1JevOpFj0g++M/ow?=
 =?us-ascii?Q?h9f3ibABfAONiWwS4n83ajM4BMU0SsPZE5pscN0IdUwLzEL70bQsiq+JUObM?=
 =?us-ascii?Q?l+bGofmjlSgpEGdZ6rKRhzKqD5oJT01MKEANDSX2c06md93wVPtxXUsWqVEo?=
 =?us-ascii?Q?etahlk1gBJKDNlcbUctmFX0gdfvxEhIT2KF0MWv4ya95sFPd86wapwOA8mR/?=
 =?us-ascii?Q?iTxrx0VimToEQMo/z4Qlb8CPsJr/csKvgXfdE77k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CZJg91OVN1e9uwgTiS7FMZUybx0Uk/Cxzc9nu/rK4SZrGoZghUA5Og4r0MwAbqIFnsRTPu8G2JCITAdR3t4D33YafqOg33Aw9Du9S5Ruf4MEe7Y4ilYpG8yG8w6/wxbzCAcQNa6ckOtjWLW1WPviFaqDwdr6dk/aSEuIY0IzeiXcXJm6iYOyJSUeQcIZ3vHbm6Qmo+p3Y6Q3mS2rKdmNHApInHCxv+3LS31Io27puFBeivlaDAoLffpSN21LnkKXpjNa89ShZ6rVCu2yoM8/M5HNY70kAR/WbHR/q8krGNcKR4Y2ojocTe9Pj0QDvnHegI3G4Dz7XgRkyTh8W0XhOTUb9tlwHxidXj98nce9XFj85aZa8o2q66BPKHqBCB6wdmOUAhCtv11kjGnh7RhgmTkmgowALkucBPOwPaVL3bgbSBsdFis9TfEn2Pi1mtdfmzQzxyUjn7M5pulNBxdajUAskbmIivoPWpOl3fBklzXVWkmVps8Z6ggnWDhGIOqyLsHuwyfTvCIsG2xk9QVUIeITTRHrJvZ/sy3Bc9MCmiKynSJ4hINKLTmWoAG4+sbhabIdA/rUfu5e7nSz4xTZg/wIVWjFNxJs0L9c00iz+oMngmNRyar6xWyPKKzsFVtp
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfc258b-bf78-42c8-f348-08dda2ab4a78
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:31:13.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v49I6lr98T6R1RU5+IQ2s/ki9TlfgEYAzPeGdv3iMmAy85UuPNDkq0Ur8Ay2ENVLivby/A9bL+lyF/WrhV2A3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P192MB2797
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: PA1P192MB2797.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyNiBTYWx0ZWRfXxWOTEA6LESQE iSme6nNYQUOcnazc6UbDYoboSS9+Ctmuu9fYV92IwVFYnfVsnB3ITeulHtw7smYLby2ftOD7XVH EB+ihL5m34J5MzVVDFi3a58PCzreLUQAQni7OQpqSq0ArEKsyHDm5LMgzAYTSM8VQ5XYKWfT0ig
 zickybM2tmP/HF+/vUUt8BmRC6LfUxwjiniBcSXaAlQFBMYl4+AC4jDeSOF8DZDuZZV/hc1D+bs NFPcMyrynou093Jf24lPHvYgI3g6AUeGyDyFn02zXcOcAJpfiEhTAoUJU/K9YVyczzazk7SeHjI 0sOzmik+abQR1tWUx3hjkYQjERN9D595Sn9M4iiVUgUtds/aX/CLuvq2UUZO6Mth1DgerJ9b5p7
 c/9NFGCJogqXJB2duD4XPXM0WmFJZRK8zDf8o+TYg4l77vnu9mBXfCkBc3OaDcGi+kbUR+An
X-Authority-Analysis: v=2.4 cv=H/nbw/Yi c=1 sm=1 tr=0 ts=683f0733 cx=c_pps a=TQmCtGXhpfpr3GzAR7BQpQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=8gLI3H-aZtYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N9GNhs4bAAAA:8 a=_-NMhzJMYwYokYfeWIkA:9 a=CjuIK1q_8ugA:10 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: WocA7uKl3OWBWauwPZqk1qTpPYixXu47
X-Proofpoint-ORIG-GUID: WocA7uKl3OWBWauwPZqk1qTpPYixXu47

Hello devs,

I need help to bring up the QCN9274 with ath12k driver on big endian PowerPC
platform. I've already found some issues and fixed the MHI start procedure [1]
and QMI conversion [2]. Furthermore I added some endianness fixes on 'qmi.c'
file and could successfully transfer the firmware and boardfile to the wireless
module. But the firmware does not start properly.

I'm trying to analyze the error and don't fully understand what is happening.
While 'ath12k_htc_connect_service' I expect a successful response from
'ath12k_htc_send', but the connection then is timeout. It seems that I should
receive a message with length of 20 and at least I get one. But then the driver
remains endless in the 'ath12k_ce_recv_process_cb' and I always get a message of
length 0 from the 'ath12k_hal_ce_dst_status_get_length' until RCU stall happens.

More interesting is the 'CE_ATTR_BYTE_SWAP_DATA' from ath11k, that is still used
in ath12k code, but HAL structures now are swapped in driver itself at the same
time. Is that correct?

Please, if anyone could give me a hint, what do I need to look for to fix the
problem? Here are the logs with ATH12K_DBG_ANY level:

    user@host:~# modprobe ath12k && logread -fe ath12k_pci
    ath12k_pci 0002:01:00.0: qmi firmware request memory request
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 29360128
    ath12k_pci 0002:01:00.0: qmi mem seg type 4 size 4145152
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 12582912
    ath12k_pci 0002:01:00.0: qmi mem seg type 3 size 1048576
    ath12k_pci 0002:01:00.0: qmi mem seg type 10 size 8192
    ath12k_pci 0002:01:00.0: qmi dma allocation failed (29360128 B type 1), will try later with small size
    ath12k_pci 0002:01:00.0: qmi delays mem_request 5
    ath12k_pci 0002:01:00.0: qmi firmware request memory request
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 1048576
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 1 size 1048576
    ath12k_pci 0002:01:00.0: qmi mem seg type 4 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 4 size 2048000
    ath12k_pci 0002:01:00.0: qmi mem seg type 3 size 1048576
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 9 size 2097152
    ath12k_pci 0002:01:00.0: qmi mem seg type 10 size 8192
    ath12k_pci 0002:01:00.0: memory type 10 not supported
    ath12k_pci 0002:01:00.0: qmi req mem_seg[0] 0x0000000003e00000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[1] 0x0000000004000000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[2] 0x0000000004200000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[3] 0x0000000004400000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[4] 0x0000000004600000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[5] 0x0000000004800000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[6] 0x0000000004a00000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[7] 0x0000000004c00000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[8] 0x0000000004e00000 1048576 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[9] 0x0000000005000000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[10] 0x0000000005200000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[11] 0x0000000005400000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[12] 0x0000000005600000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[13] 0x0000000005800000 2097152 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[14] 0x0000000004f00000 1048576 1
    ath12k_pci 0002:01:00.0: qmi req mem_seg[15] 0x0000000005a00000 2097152 4
    ath12k_pci 0002:01:00.0: qmi req mem_seg[16] 0x0000000005c00000 2048000 4
    ath12k_pci 0002:01:00.0: qmi req mem_seg[17] 0x0000000005e00000 1048576 3
    ath12k_pci 0002:01:00.0: qmi req mem_seg[18] 0x0000000006000000 2097152 9
    ath12k_pci 0002:01:00.0: qmi req mem_seg[19] 0x0000000006200000 2097152 9
    ath12k_pci 0002:01:00.0: qmi req mem_seg[20] 0x0000000006400000 2097152 9
    ath12k_pci 0002:01:00.0: qmi req mem_seg[21] 0x0000000006600000 2097152 9
    ath12k_pci 0002:01:00.0: qmi req mem_seg[22] 0x0000000006800000 2097152 9
    ath12k_pci 0002:01:00.0: qmi req mem_seg[23] 0x0000000006a00000 2097152 9
    ath12k_pci 0002:01:00.0: qmi req mem_seg[24] 0x0000000000000000 8192 10
    ath12k_pci 0002:01:00.0: qmi firmware memory ready indication
    ath12k_pci 0002:01:00.0: devmem [0] start 0x10e000 size 8192
    ath12k_pci 0002:01:00.0: devmem [1] start 0x0 size 0
    ath12k_pci 0002:01:00.0: devmem [2] start 0x0 size 0
    ath12k_pci 0002:01:00.0: devmem [3] start 0x0 size 0
    ath12k_pci 0002:01:00.0: qmi cal data supported from eeprom
    ath12k_pci 0002:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x3 soc_id 0x401a2200
    ath12k_pci 0002:01:00.0: fw_version 0x111300d6 fw_build_timestamp 2024-08-06 08:43 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
    ath12k_pci 0002:01:00.0: SMBIOS bdf variant name not set.
    ath12k_pci 0002:01:00.0: boot using board name 'bus=pci,qmi-chip-id=0,qmi-board-id=3'
    ath12k_pci 0002:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/board-2.bin size 374164
    ath12k_pci 0002:01:00.0: board name
    ath12k_pci 0002:01:00.0: board name
    ath12k_pci 0002:01:00.0: board name
    ath12k_pci 0002:01:00.0: boot found match regdb data for name 'bus=pci,qmi-chip-id=0,qmi-board-id=3'
    ath12k_pci 0002:01:00.0: boot found regdb data for 'bus=pci,qmi-chip-id=0,qmi-board-id=3'
    ath12k_pci 0002:01:00.0: fetched regdb
    ath12k_pci 0002:01:00.0: qmi bdf_type 4
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 4
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 19512
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 4
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 13368
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 4
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 7224
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 4
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 1080
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 4
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 0
    ath12k_pci 0002:01:00.0: qmi BDF download sequence completed
    ath12k_pci 0002:01:00.0: boot using board name 'bus=pci,qmi-chip-id=0,qmi-board-id=3'
    ath12k_pci 0002:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/board-2.bin size 374164
    ath12k_pci 0002:01:00.0: board name
    ath12k_pci 0002:01:00.0: board name
    ath12k_pci 0002:01:00.0: board name
    ath12k_pci 0002:01:00.0: boot found match board data for name 'bus=pci,qmi-chip-id=0,qmi-board-id=3'
    ath12k_pci 0002:01:00.0: boot found board data for 'bus=pci,qmi-chip-id=0,qmi-board-id=3'
    ath12k_pci 0002:01:00.0: using board api 2
    ath12k_pci 0002:01:00.0: qmi bdf_type 0
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 94208
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 88064
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 81920
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 75776
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 69632
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 63488
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 57344
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 51200
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 45056
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 38912
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 32768
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 26624
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 20480
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 14336
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 8192
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 2048
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 0
    ath12k_pci 0002:01:00.0: qmi bdf download request remaining 0
    ath12k_pci 0002:01:00.0: qmi BDF download sequence completed
    ath12k_pci 0002:01:00.0: qmi bdf download req fixed addr type 3
    ath12k_pci 0002:01:00.0: qmi caldata downloaded: type: 3
    ath12k_pci 0002:01:00.0: qmi firmware ready
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 11,ring_num 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 12,ring_num 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 5,ring_num 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 5,ring_num 1
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 5,ring_num 2
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: multiple msi_groups share one msi, msi_group_num 2
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 5,ring_num 3
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: multiple msi_groups share one msi, msi_group_num 3
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 2,ring_num 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: multiple msi_groups share one msi, msi_group_num 3
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: multiple msi_groups share one msi, msi_group_num 3
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: ring not part of an ext_group; ring_type: 3,ring_num 0
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: multiple msi_groups share one msi, msi_group_num 3
    ath12k_pci 0002:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0002:01:00.0: multiple msi_groups share one msi, msi_group_num 3
    ath12k_pci 0002:01:00.0: boot htc service 'Control' ul pipe 0 dl pipe 1 eid 0 ready
    ath12k_pci 0002:01:00.0: boot htc service 'Control' eid 0 TX flow control disabled
    ath12k_pci 0002:01:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems
    ath12k_pci 0002:01:00.0: rx ce pipe 1 len 20
    ath12k_pci 0002:01:00.0: Target ready! transmit resources: 4 size:4096
    ath12k_pci 0002:01:00.0: boot htc service HTT Data does not allocate target credits
    ath12k_pci 0002:01:00.0: Service connect timeout
    ath12k_pci 0002:01:00.0: failed to connect to HTT: -110


Best regards
Alexander Wilhelm

---
[1] https://lore.kernel.org/mhi/48a98603-d2b0-c279-6b04-0c89baf32d05@oss.qualcomm.com
[2] https://lore.kernel.org/linux-arm-msm/20250522143530.3623809-1-alexander.wilhelm@westermo.com

