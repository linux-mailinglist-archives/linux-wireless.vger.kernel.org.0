Return-Path: <linux-wireless+bounces-19805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DDAA5034D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2006A1659B8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30A24C668;
	Wed,  5 Mar 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="HX2z2kAB";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="FO5E7EOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC324E005;
	Wed,  5 Mar 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187931; cv=fail; b=BKOv0EtBvYrl01Wbew55eiRo436WeoPsRKrJVh6OBkhr3r694W9DupoOuWxRS5L7d6E2BxNMAC0OvivIJC/LKkhufkapj5qHPW8eJJgsbYuA4Rd4JhaKclXCbFFBqseOJR9ci68oBFhjxUeBKUZrW5DQJZmch+LU9wttHgTzbfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187931; c=relaxed/simple;
	bh=fnL1AXoW1tNl0FqyDceWYeavj76wtRtBUveK6mqF0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYAVvfh9ssdDjlr9oo0TxzELHQhYvChH2g8DZFfs1/6A+yyP5Jn9UNU99Fngvts7IttW8tog1HJ8hg76+WWaE6r9QbniIT/PjAjJHN+0v6O3Kxg1OhUDJm8IKFqTRIipqoPP6Xayo2Iur29DhCYhM8LJ25dIdhb0oFSb78ny6i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=HX2z2kAB; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=FO5E7EOH; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5259tHfg022369;
	Wed, 5 Mar 2025 09:18:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=5ydPaH+P6yWO8Tg4HTignHXqQAu+6mgS9fVXK/OA3uY=; b=HX2z2kABJi+x
	b8vAyxUIylJdCmnXwEGHpezvHNYlMGmqZC8M6rWtv8lkKGmcYSwKmy906l+FVzKH
	qMmDKewRDnbxTuaaDgIqmhrpFtLlV5AbRv35HQN+QOpMiQ8TnBlJY+H3PjmT64+u
	V4MeDei2QEGEqg5+nktu87feDHRN1LiLBmTJyG2+fHJ1df+pcpMYESM9kmfJK3eo
	ZAsRDxmIymJrhTy+GIkBJ9eCOl2exlWit2/CXT2ZeexBDtmt19wSBm2Sp7sZ9+o/
	WZF9s0wDBYzFSvnftQ1f3jCmN4CSIuhzDQa7mwW9WiRQ3i/yrUMm+hlbHSyAJAQA
	W/EUM/SY5Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchknhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 09:18:42 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4BqZro8OE/lWwD+MYXwwTxyHEoAKrp84DzaXrPquzB4e5fdlnWiNJBSqxoih+s4YIeIozxKVOuf5cB/j7eOyUIAnfGdBAsVNDMP7WYFlNcar28HAJQxYxjOh2j2HxnH4HFjvLEnIo3XVTbNsrEiLX8HtK/R9GkZTFfTbw3pPKA3NPHIMDJu0NG/D10UsSwP0kfE8g/ycQkloYqKP3ASWV4utXl82crfr2/OjvF8ahLK3RhMdIlhac88FE8Ep5DYP1GYUR+rilaBuXDF2OXycnENVcLzfxTEDrTWiw3p2FCPD3C4PkNWfbzUDb1+ENyC4TmbVRiF8m22sv4yITV5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ydPaH+P6yWO8Tg4HTignHXqQAu+6mgS9fVXK/OA3uY=;
 b=u2DGhk5k2hskQp9+VmGGziGbb4FPspwgJjTSFZIi7vZg2iZp+CX//w6Vs221qEdAFGAshjv+hY0yClIINUmMhszngGQnANlSMuEUE5ylRQ9ShSr0wYuklP4aPBJW65c/AHgiJX1i/aW5kcqv3toj+LF5IzYQAfGM2XB4acdnUXaoR0KJ/vw2Ki5ebmBg/i7eqt3gG0LG7nkuOf6Pdox0I/8GJkXmbNMCDSrgRH76APMcT5Z4l05mmlE0Jf7ZC430nB6q808xhgO0xEPlt5mC07l6gubSBjmWsfzEW5C8t6SbkCJXkMcYt4RFXnP5zkQ5U6BJYVJ2RrnjD8WZCjRq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ydPaH+P6yWO8Tg4HTignHXqQAu+6mgS9fVXK/OA3uY=;
 b=FO5E7EOHxfBj4ychkqTqOUg26cGu1LW3Yxp5PMeb4mZ39L04B7L6P1C2yfvnQvYxXcC6xlKd3Gksu88vcWXswN+zRIgLj3ILuEcgcf+2lHriLbH114XIAn20iFIT/1dr2+GnrHwOtKiaS6yJy+AM2f+FWP9eCjZ8YSi0SKtt7p0=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 15:18:36 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 15:18:36 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
Date: Wed, 05 Mar 2025 16:18:32 +0100
Message-ID: <23857370.6Emhk5qWAg@nb0018864>
Organization: Silicon Labs
In-Reply-To: <98e39be3351190ec71ffb067c062c82883ebef24.camel@sipsolutions.net>
References:
 <20250302144731.117409-1-jerome.pouiller@silabs.com>
 <2018315.usQuhbGJ8B@nb0018864>
 <98e39be3351190ec71ffb067c062c82883ebef24.camel@sipsolutions.net>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0010.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::6) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: f4da03a3-845e-4c3b-20dc-08dd5bf8ffdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FTB5ruWO+srmh+QOhFgtG/CRSjo7jA3JVYhGGojVLXscHrgqA+9oM8mpER?=
 =?iso-8859-1?Q?Rhy8tmfJYdC/v688JGj6kPT4tk+TrYM4IwacXTkv1aa/A9hrjeBd3bnJkK?=
 =?iso-8859-1?Q?tSA1n+88qfgUb+PTO06urTjFckNGbt8o43m3YkZkMUS+uWbIC30PgAPnii?=
 =?iso-8859-1?Q?pqGHtg/BYQOorKTcaU4ZEmDFPSMKWaHLR4/B4UkciTJV0vBxS7UITiyoR2?=
 =?iso-8859-1?Q?TL+nLz9DwTat4szUM0Rg5ZJKkHJToTy5BWgJx8VfFw3EPOv/NrtjV9Xuwr?=
 =?iso-8859-1?Q?DSdStS8HwGisCuAN/Po6aXISA2m+A+19QofDhC/O5Na/pDeZhFWZgKdYmK?=
 =?iso-8859-1?Q?mC45lrCPFKKwbDCl3l3oqUpTev8n4MDSxDMHtl1B6kMHAPaRZrSevE9JN6?=
 =?iso-8859-1?Q?MYKb4gLss/BBWz4FaGCregR5b9/rrb+aqVGobx6ncDVIhF1TF9ttUiBdEg?=
 =?iso-8859-1?Q?hkM40CdPfjOJZpqlXCPDrJw4iwvrxEgftCrB2CfazdCA1WqsFBbmLYYLbZ?=
 =?iso-8859-1?Q?uNl9XtYnMysA5Dw3fEZe2ew6CLJmK8iGp7trhAoSK68lW9InAiFpTsT6D8?=
 =?iso-8859-1?Q?vwz9RDYteptwvRLvvc/ywx4/vDWacUvcP+SAoH8F+EnUjCoS89y5dCWz3h?=
 =?iso-8859-1?Q?5im3oLMGZR/2UOut44/EXroXCf0jfBHV1uwP/DkHamdBdTCj7Dpha2K7Nv?=
 =?iso-8859-1?Q?mULni/X4BKqc1+XDB75qCw6gV8PO1hwIU9pxFBIx7Tb/IcemQJ6WUskeMS?=
 =?iso-8859-1?Q?wObUVJung6FPERrbHrQQqDt9sbFMX2u67wefAzALhl2ik+d8Qz4k3TH4Vl?=
 =?iso-8859-1?Q?Jlp3fa1oh72UgQMCgB75mCvJuL648y64liIOZtp4w/V50FGCqc/+r7rhF4?=
 =?iso-8859-1?Q?U2ead5sudSpJRlBwf5RTkIX6MBAe6l9R91riH86ne6s3Ab0Hy6sm8Q9ska?=
 =?iso-8859-1?Q?pWz4dpPA60J+g7dr2rZdUnez0Utndz8hxIygG2b6Gf1upT6JRVwW/jwiKj?=
 =?iso-8859-1?Q?7oMiDSyZ0JjLt07qtEkTpmdR9/Tgj35/vdaMPcckdshNObtfnxhkPdZ99x?=
 =?iso-8859-1?Q?MgrviWJCL30oPuVpsS4wYhYOnziKxNOv9VzqkLx5gTSASAnsjiYg2eyh7h?=
 =?iso-8859-1?Q?4SQtIEkhTDziOVqbra2fNBTG6NV047VsBIvu/am1vAce1hmFghTGENURfY?=
 =?iso-8859-1?Q?iKHOO5GPmW9JtYeQjuh5NxOlT16mquLFQ6u35GOiVpfYAcjURmdLpXjskE?=
 =?iso-8859-1?Q?2OFWGc+vaEh1y+5nUoi7aAX0CrGDx7FTeejCH0aFpdoIgYpn43wgjeU99W?=
 =?iso-8859-1?Q?68xsPpAiVEJhEUVZFeKROpq91aFlSOuF5E2AKgKDjqvry95UKyybpDiems?=
 =?iso-8859-1?Q?qtrwdNZHZEH0rbdhmiOihYqClhIrpuzkkdDtrg/B1a7tZDkfxIixAQ3JQf?=
 =?iso-8859-1?Q?ufL7gey9qoTsmrNrNxS6omqLtnJO2p2GLntDKlyUX1+ievfnc7cNgN5Xkc?=
 =?iso-8859-1?Q?RA7ShgLURc85hUi/H/wmtZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1E1hIITczC/a/cw0/Lb9HSa6aL/O1KiclMSxnNRpQAeTbmpxhlrcv1GFQf?=
 =?iso-8859-1?Q?4yJpRKL4W/yk8mfLlfhh+AngoiWO/KJSXbO2v+5uOqvb7j4iUJZAw0F3nY?=
 =?iso-8859-1?Q?eUQPRMaRdm//PaG0/dge11FVJPKSZ6tXujgXVpnf/Wv6ycrbetdE/Cg6Ou?=
 =?iso-8859-1?Q?6G/+bQV1dz64m6MCWD4tzH83balSJdBeGd+jDlkbUUb7OaujSbUTzHMrvj?=
 =?iso-8859-1?Q?lJwWDhCCGK0n92bQ8DRvRPguBaOhhlVqLrGglps/ZQbVXDBJntrcjZx3te?=
 =?iso-8859-1?Q?rvaAKVUL8LjIi6iEyHpYxijPWCItVvxJ4HeOgp+dIJviYc8kBrV3Yho6AB?=
 =?iso-8859-1?Q?9umcsffJoyIplUJAsfvimKKw+0yR5R+J+HoV/lcsEPQAFEYYJEDMoTtHqx?=
 =?iso-8859-1?Q?oh93wDiZV1ExGhrCTeeOQxE55P7nrYmiTDrJg7XByzTRujC+mUAbxsPk/i?=
 =?iso-8859-1?Q?jWyM5uu5tjgdXlhilvshOYFvMR83+lIgIUpOp3fZniD7dn/hhO7YuCfmX3?=
 =?iso-8859-1?Q?g3QAPmbGBDufTZNAvWh5VVr5XolRJB+Vin6Lp8aLmeKbN7ljM5Gp0R1gNX?=
 =?iso-8859-1?Q?37WJRS0hWQyVA7RbSLZoAn9Q6tP37FiQl0VbkLMaHAp3IZ10SDpalsDPdc?=
 =?iso-8859-1?Q?YDfpdOuOBSBU1pZhASSZHxWfrdBjWH9egoHrUSI4Hud9fsFTsqSpaJTaQg?=
 =?iso-8859-1?Q?SBS0/SwtHWmVTqr75P1PezHxXYELA+L5m3ZpAwxJso/Zi3XIKtb715leqQ?=
 =?iso-8859-1?Q?qMF2HK/iltSQIpS1gFi9m9y2vWJfYfspoUEmM/cJ6C50ouP9aMobxVcJbV?=
 =?iso-8859-1?Q?0C6WtzorzOr+qTlKUuiZz9HMOZEbmF+Um0bJSsjPchOATWbXDeYbYh81xp?=
 =?iso-8859-1?Q?LPAF5A3mCRDFGs3mjD6AWFcLIf+1PGZKiL2iTs5CsALD4IutwHGbwGqiod?=
 =?iso-8859-1?Q?Yxw3lJl7/9k4muanZLOEvWN1X+jRoDlCclBDStgJzT5L3Oczo/f4409f7c?=
 =?iso-8859-1?Q?jLuDtWazQeTgHZqn6jWw2pDgg1oxaRVMlC8xWBiPbaVGPg+PF9V5YzLmSW?=
 =?iso-8859-1?Q?0n7KoH5zjmYgah0WHFej3yxKxtDYXzpaM35xb2e9eC1Vnuoov4ofeftSvI?=
 =?iso-8859-1?Q?TIiMpT96PugDRDQ64W0Tc1/PtUw532hEtGMT/YAH0sbedaxSOnnJ+lmR9p?=
 =?iso-8859-1?Q?OrmSQNjZMuxt7U70eM7pF3k6ixd01wi5PHaLjl7oWqw/NetMndEhuXr7Ij?=
 =?iso-8859-1?Q?5qr8okUQRF5JGdIEfPvEMRRcDTki7ztWq+IgIwESGZKhw86Q64f6fd6E0U?=
 =?iso-8859-1?Q?n1gW6w1B0a1iw0PVQpQ2THuvrZFwtsT4kqMPZKh46N896x+lN52/7HS595?=
 =?iso-8859-1?Q?np1RQkSVs+PVlA9VdlGQekomlLvSgxecE7HGEywRH2OdAsZcWk5BT4P2Or?=
 =?iso-8859-1?Q?kHA9SJDbMOnzhkUG4k14wo8EY0cYws/3NkjVkCDw7pqQzA9WboPn1pbL0c?=
 =?iso-8859-1?Q?h7Z8e8kLetASxHV1631U5FYlJvslawCjXTiIQT4F4ThQ1Mz/1mPdO/11al?=
 =?iso-8859-1?Q?UvU/cOOCOVZccp571SY/AzXz5dGONRhk01VqLSn0vomj28BJO3XzGuX88f?=
 =?iso-8859-1?Q?tHy/iKYtYImK1dyN+vVkTVa4d7h9yD9dWj?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4da03a3-845e-4c3b-20dc-08dd5bf8ffdb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:18:36.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAUnD7XACqM1VLNdhOl59CPzdDzFpwVgg7g3HG08VJSgPJX3RrSpYEcYa9/beJn167W+SmCanZVngN++QesJzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c86b52 cx=c_pps a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=UWepBCwRbLjeA3XoiFEA:9 a=wPNLvfGTeEIA:10 a=1oIdJCuH23UA:10 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: _JEVSMWqG5OKlSxxLKN-EZd2mUtYwIUX
X-Proofpoint-ORIG-GUID: _JEVSMWqG5OKlSxxLKN-EZd2mUtYwIUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=670 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503050119

On Wednesday 5 March 2025 08:40:51 CET Johannes Berg wrote:
> On Tue, 2025-03-04 at 16:22 +0100, J=E9r=F4me Pouiller wrote:
> >
> > Patchwork also reports two warnings that I am going to ignore:
> >
> >   - "Target tree name not specified in the subject", I assume it
> >     is "wireless-next", but in the doubt I prefer to refrain.
>=20
> It should be wireless-next for anything that isn't fixes for the current
> cycle, and please do add it - without it the checker won't always be
> able to pick up the patches to test them:
>=20
> https://urldefense.com/v3/__https://lore.kernel.org/linux-wireless/ec3a3d=
891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net/__;!!N30Cs7Jr!X-P=
jgfbhIZWbgAa9xgbQsoUtAFxrhIPOL3GoEq_3Nan4ktwxzvTu7V17Q3HSxfYgjtdupGn3xRoIJw=
xLu9f0CcZx3Ys$
>=20
> >   - Lines are larger then 80 columns. Checkpatch.pl now accepts up
> >     to 100 columns. I am not aware any local exception in net/, right?
>=20
> It looks like that's not documented
> (https://urldefense.com/v3/__https://docs.kernel.org/process/maintainer-n=
etdev.html__;!!N30Cs7Jr!X-PjgfbhIZWbgAa9xgbQsoUtAFxrhIPOL3GoEq_3Nan4ktwxzvT=
u7V17Q3HSxfYgjtdupGn3xRoIJwxLu9f0sNiJZZA$ ), but I had a
> conversation with Jakub about this in the past and he prefers to have
> the checks still at 80 because people were, in his telling, abusing it
> in a way and making really long lines for no good reason.
>=20
> I'm not going to be super strict about it, but I'd encourage everyone
> who sees that warning to see if they can do better.
>=20
> In this particular case, it's just a comment, so could trivially be
> wrapped, but I'm not going to complain about 85 columns. If someone's
> going to 100 columns with (text) comments though then I think that'd
> raise some eyebrows. Narrower text is easier to read anyway.

Thank you for the detailed answer.

I will send a new version in a couple of days. Thus the various robots
have time to test it.

--=20
J=E9r=F4me Pouiller



