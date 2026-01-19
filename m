Return-Path: <linux-wireless+bounces-30944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B773D3A08E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 08:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B475230019CE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60CE337B8C;
	Mon, 19 Jan 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="cZP716US";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="saSW0aSp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFB3321A7;
	Mon, 19 Jan 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809044; cv=fail; b=fEOUsHMkKvA9D5BMtIXqi9E8icnQjWxH6AMIqiFR0AVbszsySVC+87Br91taQYtiQQh3URGmHd5UyrvfG8UrRUt7phvcao4AOlRXql7Y4rztuJhZhliU/qN4UspzdlnxW1DjzHuUkAEQPJ/S2JBokvf2mM2zcJFr2MgL3qS5S+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809044; c=relaxed/simple;
	bh=fyDWUroOa/L3Wq410yBQd+ZWvx1zwFUiUbbH9E0yqjs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mim0Wn9pEDo7mkBL+3Y5mBco42UbGDeau5oQxAoDUyjs8vV7d4hR5N3e93f+y6Ov28ueD3mGTU52LawZ00td+cJGnHtgv0PU5IlPwfBX1PndfFpfcQHozJs/ciLyl/T1yYBhmCZ/eaQcAw//rGTgubMmeCCZjpAOcYkv/yJdqWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=cZP716US; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=saSW0aSp; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J5KcMi386038;
	Mon, 19 Jan 2026 08:39:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=utzfo6GVMXuvBSZ9MIaPRu
	OnOoEBHnGzoZnFzTgpZk8=; b=cZP716USOUYZbe/iyTa/kZovAzK6poMxm3eH1J
	moD49+8UNRsStLbekn+j4ohSc1PJFiU9IXlMA/yj5DSrqb5gNgxgNOIGpH8sObUX
	L7oA7TOBk24fMuxQ5fXfTZyy/dBxvRrL9CuoWH83mpK4PH+Res++1aY3l7pa0fgi
	S6rPKJJzbfhNNYS7R431FT9WD7OOVx7EV8f7jc3UjvuYz5YxhqXVlDZm8ezHyQMn
	ipiaMrR20t4/FgX/ATyepeW9gdbi0rUJJPDsR+rYdPto+Gdc6ObKSdUPuaQlWv+N
	x5uCkVKZmE/KjEIixX/x6SdSpmK87VFOONvCAeT91/LohDYQ==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020097.outbound.protection.outlook.com [52.101.84.97])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4bqya69dq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 08:39:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0owMMJcujbDEiSAGknHIoxUBkBWcMI16vZubKxjcNTUzKoSpic9alKa5Quxu0qI5u2R7swUI1LqmKV5HXdQJD7xpL867HDNa6u+lfNTGvpWBBkQQqb8l0Dls45lwdG6Qvd6WeYqQi3VWHQpg3ZZbD9KUfFwRAHD7C4BIlSEbtg2Q84w4wwNBEKzmnLhI/cTdVn3YPZDxUUXvLnEfX1hyFGtRGMdN2fmAMPMp2YiTMDWZRiSkpBnrGWpsnUHUaTKPRDCFCWHH9GODz/dvFByNifBq26t8aIhu0iTMxLmT2M4aaC6U8Q2wVBTE97BKIOBiAYfk5pm7urj7VsKJALwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utzfo6GVMXuvBSZ9MIaPRuOnOoEBHnGzoZnFzTgpZk8=;
 b=t9RAb0vaXJtqQhkBeC5z7LXD9k+KAgK6Jt+KQmm5VOjp+5+x9PVuJH+lmqQVA2uchAl/CXJgx9Fxl5o1SUkS3nJ6jSSK0JpxTKSGtiZIx4QyxP1gYocpNfdjtNQ987IGROQuKoOO9Y6lfRZWjs1+gaoyH8PCS90bn81c/Pj0AoRLw74BOUKTQRzlTzllvKjym9iwXcprOQL61ZFbKDDYTQDrgf60tU+M3VaNk4Vk4ib16AZ31hFf6tjHfrcXj2FV7T4p8Q385Vuwjc7IetfN9Vta5OVwnxOgmF3Oi5DC7HJKnosXIpj7b7QDU4PvwVA4UCvepXiV2TCGFP5ez9Ky4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utzfo6GVMXuvBSZ9MIaPRuOnOoEBHnGzoZnFzTgpZk8=;
 b=saSW0aSpZkHzT+6gi0JxOgTEdcRtH6717bLwezkrQNqyFOBzBaZv+mFcUDazam3M2HC6uHP46drroWmp8qdC2s5GMEJzrFGTHJhT4a+5bp7fED5VFjAE9lUEwGvqqGW83Vy7fdQU9piXHHjFfO/lvJkb/s5U5g+9xCqQBfhjLd8=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DBAP192MB1018.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 07:39:25 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9499.005; Mon, 19 Jan 2026
 07:39:25 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] wifi: ath12k: fix endianness handling for SRNG ring pointer accesses
Date: Mon, 19 Jan 2026 08:39:21 +0100
Message-ID: <20260119073923.764245-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006637.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d4) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DBAP192MB1018:EE_
X-MS-Office365-Filtering-Correlation-Id: e739962f-c869-4bde-22cf-08de572dde6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+CT5k8ZSgP9Tpcxle4RKYk2TL9yx9PK2Oh+LBE9ymIlDk58G5waeEgOyfXX?=
 =?us-ascii?Q?zoI98NJe7+GcWL9wSyQo7paROlngAdGikixL5DFoSZOXFlBHs1OaMVB6VzY+?=
 =?us-ascii?Q?Xm9DCj0w2vCWxNK9YEMubsAceJ69d0+dvhNNrloB/MYwB3jEnABJ8BEosJcf?=
 =?us-ascii?Q?G/hw445Ew4ffwlpI/9/jeuX9ufg4NZtEFgsvxAcmKiWl2LA1KRHOSrj1VeVH?=
 =?us-ascii?Q?8wIUX0CnPPSI0ge9HdCi0GAf40Hb+gxirLzlh6L3mIBxRwPEz41S6exenlcA?=
 =?us-ascii?Q?lXsJIu7haS2tGp9CklnwBEc1KCE0daY7J0aURsrv2v4Vht9DHf0pWH+ZUSLW?=
 =?us-ascii?Q?dtd0/32aFYiGPcmz9NsISzsM/la38dn26wJvEdfoK7no0U5t2Qrl5B/iQ8eZ?=
 =?us-ascii?Q?f4sUXBJZLZ1a5CONILdVrnClit8FZCSGFjrGf7jej98oKejl/7B89zfIZCP0?=
 =?us-ascii?Q?yoKaAiR2Irr/SDI+nsn2m84/+SMabOwVXDxvbfx54HF8VWYmRlxnF6V/OhJE?=
 =?us-ascii?Q?3SXzXheYuxKHtcHEjOPGBgZVjK9IIaSsesiV9MMVTLUxVJcIobw0CzZ6AdX9?=
 =?us-ascii?Q?0gpvCOEU+fVbypGPJ29SD+3gm4ukqoEe5q/jgIlC3EafZUV2bK43eiCrLtN6?=
 =?us-ascii?Q?p9LQlAfociOxH2AWhM7ZSUFn8Y0jLhnfbeSf2iRVqBpZPT7yLr4LEFWcj0SS?=
 =?us-ascii?Q?w3pvgdf8qArt94LxzpcBcpL4srOzulpH7Qd4b+q/cYsJCBbZMAZAeD0vm6Fn?=
 =?us-ascii?Q?nGbs2j5Pzi9rV8KUcG2RNx2zSGXB/FQIg4KcWdqESY0SWrAw1QjivL4y+4cM?=
 =?us-ascii?Q?rbbafqKF1QF1u+7wLkoki2MWS9soEAkStvB9SWugiIjQtuIeDQi+eaBqpSNl?=
 =?us-ascii?Q?w7/CYKGHJ9EONo/grsoj9s4cKB/JkwyHbOSFbzHZkD+A4TSsFtvnM7CDpmKG?=
 =?us-ascii?Q?YMDyGUfAl3Bt1BjX6n9qLDFNYpNmprbm2HiEdiymOvMRZ9AlfrfL/u1KVbyj?=
 =?us-ascii?Q?0qTL1elpZ1ec+8orbOyCLt8VV/R9UCNpywYfiw9yQWv21pg+ucr3gwK47pRu?=
 =?us-ascii?Q?vCJUbkyNAl/AsvxdaBKr23HtqhdXx8QZNiL40gDFZIHZYM0/FDeiFzMLawAx?=
 =?us-ascii?Q?cgmH5ByPXJrKA105Uku6+6NGLmTizjiZdKa/ac/vY3LcZFQERj48IkffR7lH?=
 =?us-ascii?Q?970Fja66D/7ifnGoL4WqFSlXpYREl4ql+omehDhlTl/IQSO2/vKuKzUW5GyS?=
 =?us-ascii?Q?jNIEKoOcS2d+YF4f30kECi7H3LWektnTV+htyfqJgslYaUWIiz2XBpAg19bz?=
 =?us-ascii?Q?jlvN4x0FCWoLz+9d4+Pee9NlwyYtM2lXAh4fESjjvWMG1JIQDojaaEayv9zo?=
 =?us-ascii?Q?UZRTQ4YBVYFOUpHqkwjXZM6mlI3iN7/uOsfFxgdQHSAbjD6RVXVPaZhNhf3u?=
 =?us-ascii?Q?DuVQZcS4VB5C9WYBdqELKRYsJtQxG13vG1FsdH3aKXKIO7sshwYTdQ1L1Q0H?=
 =?us-ascii?Q?Gzeq2ayOQSbJIGaDMvWEGYoOF2Vr3MakYAsRgzLui3EIBbAsmYCQua1uS+zy?=
 =?us-ascii?Q?2uX3oBGt5DdlGKi9tOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ovvEuI68p6EydJbu2LnOjMyeqRytICN2Hrc0xs3DYGlvXeeASeFDIo5jJwnq?=
 =?us-ascii?Q?Pf48orzVDs70C3kKj8m5yt8EFwcZ74KaP+EsBYhVwMQd3J9dMXYD483TrG7J?=
 =?us-ascii?Q?QORKrNMcEWhTVHZXUzY/0WRDsxo38wcI+6hx0DfWVHvN34E5z9O3s3nSPSE6?=
 =?us-ascii?Q?FSJBBizpNChoxT+jA30gwdqlKUHy722ZKHsjP5Y/EKfPpDp/gF6K9tsi9VGf?=
 =?us-ascii?Q?sEJBm8PGvlRjzbwU0ViF6u3/q4ytH6G6YRejNZiIy91/leSG02R4e6SnoEYT?=
 =?us-ascii?Q?jjzBqBLhaqNFFURaRrW7gjteesIY4F5BmOEE1XX5K9Gob1fq2SPVflGqUCGy?=
 =?us-ascii?Q?AZdBAfd2yaftTbugbn3MavlEdyj7My20vXDUdM0PzekW7pweSQTa3QSKr3uP?=
 =?us-ascii?Q?jOfxCeWfOrb8/8vJg3MEwM+SqtI6R3uLta59LfC05r/miOkEJVQYIpTb/rFk?=
 =?us-ascii?Q?AdG6J2rsx/A+PMNUYZT3oruTJaKnSufuIseMqHD4Rd1b3zzp3lSZTOHHz+6M?=
 =?us-ascii?Q?2P6ArILLQMrguAmMJufwB0igkYeACAMZpFXfoEwjJ/3KaYSUaPf8ACcWdX9q?=
 =?us-ascii?Q?n4YQyA8wSN7qeGIjiMOlhBDwibBmQt6YAQiawv9IsZnLgxlSXCAfboP5mefF?=
 =?us-ascii?Q?vd9tvzH8XrlwYQAkINXbyvRfZdjxXA+STaSuQhJhdIWyBq6Gc1b/s1lnOLmS?=
 =?us-ascii?Q?b/R/9nYVaB1dfT2VErLLzhaxuCx/rpcIB5hVHle8iSHt8jkCD6yNAEYvOeD0?=
 =?us-ascii?Q?PL5RlRnhTa6B23wxcu/IEAlBMfTpfk66lD6tcQtcjNbRH/iuxYrhtWra3JW3?=
 =?us-ascii?Q?G298VviBKmBlQ1oWvpY5TeUM6I96NbfAFzBATrgi0Mx64jf7UGT5oOTcjx74?=
 =?us-ascii?Q?qWv2KtFVyTpml0LF6Q2Okn4VeI1TXnLri+KnG8S6Gw4tGbnIOBSudjYsDzb5?=
 =?us-ascii?Q?nIyxlS//pAlJsrF6RiC2FYkxHTz5974VQZPFioMLBcGhO5f5fGSdjsN4Jq58?=
 =?us-ascii?Q?qswccTsreXfDyvFjwPkCMRjQsBU0IRBSslqXVG32TW3oRXfq+oIHYIdx2RtJ?=
 =?us-ascii?Q?mj0C4lwwzqIshOO+vIt4bQ+cDtCCFyADs+iu9jiQHa4iiF3n8IgzoLVtTThY?=
 =?us-ascii?Q?ka/HIxNmoiiV2Xq+gmqazcqDdG7yvfu8/EsEWzNb4bTUbvptIN526uobXpgn?=
 =?us-ascii?Q?mlh2Uj/Thmu42SRT4a9Qh8S6nzQkQdhZLmLA+DQCEgyknYahe5HOGGwuOcth?=
 =?us-ascii?Q?KLX+6l2lgArDbGMOXD42wBgOmzjNTPb3qLOEcSH5sB5M7JVa1s3ViRDpuXuL?=
 =?us-ascii?Q?KjqJ3r3T0MFeEufO0rFyeqhwGUNGS9QItq4jFs21e31oqU381NyerGgm3YxQ?=
 =?us-ascii?Q?7lJp4AOQFM1EF+mGha9zxkuy8Gas2BgTmiDrJG/V2sAK1qdPdbu4EBgyvIYm?=
 =?us-ascii?Q?/+0YYpCxHu+whn5d2T9Wd4Xnve9wyHFw3CHJtzJEKG3+1D+wThxzas67YQoO?=
 =?us-ascii?Q?W3G+Pt9T/k5QriyPrALOaZEgoYq+rIsVP4rgEsvrw0bdIvTQjhcGl6PPLZr5?=
 =?us-ascii?Q?ZqNyMtxbP0pE11Mnf49oGrrzIQ4qiaoFlKy50C0PJ9ullyxahJdzCx4t82tU?=
 =?us-ascii?Q?MVF3QZgbm/gLMaNKYy9bTolgwp3cL8BJ4dSSknGmSuMuqEZ89PLM97HDysvw?=
 =?us-ascii?Q?LPRGzQdoUjiKG49KCkDLSdXauHAizUVJLW5VPK3CrG3otVdhhbj80pUwrbhO?=
 =?us-ascii?Q?QEs+g+DCVA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x/xzZXAohNDnuQilG5GbcUvIenjETrg2QyQcOGTkZeblYMHcsa7HLy5CA0baMQ0dca1648V6U2Ta8vERmeNHACIl4GhLXhkUr4oybv/OjRytHHEbf7zY9aBoIx0zCKNRJF9ameUnf1RiGpZRukK/q221ide/YUFfabm9uLJnSoUS0gKNJOsqcRBIrs5cIVAQpHdbUb/BrZI6cDwHVBY9AqSp8b+9YIS5Mo9ssLKqoUURBfsdAhAoXUeYEU8EpNKSITVVKRbeKjX7bo+GHkOhvr+Xpv9zRqCdVavhuc3wOeUh5SRAx7cthfHtV0JkN4+fvrGwGB/w7GMX5Ism9RM5u9CDsf8sAxIQofeK3MDvO5t/hV0CqIPE0yWSeoid9DOAARZrpI46FnJ3WcQdOOYToBx7LBTSTyzIxcbPtDfKOnCwq5UJcekLMUdhexvyUG53Z+quGgTYqy+6gMXJiEdEBoME0rDqvDcWMcr+8fL3Z/o7AKUuRqpVQ7fvLEinxrUnYJALaOMoHSD/egRIRdHewhHE1J9dKzdxlzTXj/DA1U4LOW4/d0dqmJwizSfdl7ajRtR9DfDmLnvPGVe0Dg8SLRlLQSeB7wdhy5bBaGegHyKnjPWqAs+Wn7KTJ2/NKs/P
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e739962f-c869-4bde-22cf-08de572dde6c
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 07:39:25.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD8scieS1WOiNsO+nwpsbaeL+lDp0XgxLrI04Uk4GcfeVtXGx2mu4LgMXbPViS9yeiMKpW8bnfb32JXcmw+9ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB1018
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
X-OrganizationHeadersPreserved: DBAP192MB1018.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA2MiBTYWx0ZWRfXwmUeoWHCQLgP
 8gAwx4Ysp6Xlo4aw/BYk/XP1GtbXEK4pYd3tiprHiFMOz6zX2cH+3Ceflr3yHQm3ETv0WtU79TO
 Sz/OIwAzkdOOWcW6YJEmGs02aR7i4lTz5txDFNXqTDlOEtWUNOM0WyDPsxTrdtOFI1lynLGvSGa
 nMFex3omTFvIT5oK3qEgWlQLN/c3rM8DAqMS99y33HKO77vxZvX2ue1Bv5pZ0IpOIS6KOYk3a4d
 aaN08E8wTmghtYldO0noqnUuMgio9Cn7ZhVsFtqqLVtXZAgx0KRNqEwUzs/mTFS4jp6tg6Zb3cu
 ZrgEd/+ULDvgYJ6ds/RIEIX/tu8lsgfJvcTu9ll92LrTuKl6YI6vr/EuaTL1G+t6wPcC71gQc7R
 s5NFbHSqXyv8gjH9IbnKKZgmYDK5Vd7g6IxQw6e51p9F/mimpvkOhDUNE6ujZYw75yEaqZZkhue
 93A+stq06bXRCZObPoQ==
X-Authority-Analysis: v=2.4 cv=cJrtc1eN c=1 sm=1 tr=0 ts=696ddfb7 cx=c_pps
 a=Tlr9z+0oJFk4eulJi4tZwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=lEIG9Xwd9i7OvzUI7HEA:9
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: ecWmgBLYIpYe3vbrec3ncVV2RHGz89Mw
X-Proofpoint-ORIG-GUID: ecWmgBLYIpYe3vbrec3ncVV2RHGz89Mw

The SRNG head and tail ring pointers are stored in device memory as
little-endian values. On big-endian systems, direct dereferencing of these
pointers leads to incorrect values being read or written, causing ring
management issues and potentially breaking data flow.

This patch ensures all accesses to SRNG ring pointers use the appropriate
endianness conversions. This affects both read and write paths for source
and destination rings, as well as debug output. The changes guarantee
correct operation on both little- and big-endian architectures.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
Changes in v3:
- Rebase on latest 'ath' master
- Use always 'le32_to_cpu()' macro for conversions

Changes in v2:
- Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
---
 drivers/net/wireless/ath/ath12k/hal.c | 37 +++++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a164563fff28..28d0ff524fc6 100644
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
@@ -500,10 +500,10 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 	lockdep_assert_held(&srng->lock);
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
-		srng->u.src_ring.cached_tp =
-			*(volatile u32 *)srng->u.src_ring.tp_addr;
+		srng->u.src_ring.cached_tp = le32_to_cpu(
+			*(volatile __le32 *)srng->u.src_ring.tp_addr);
 	} else {
-		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
 
 		if (hp != srng->u.dst_ring.cached_hp) {
 			srng->u.dst_ring.cached_hp = hp;
@@ -528,25 +528,28 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 		 * hence written to a shared memory location that is read by FW
 		 */
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
-			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			srng->u.src_ring.last_tp = le32_to_cpu(
+				*(volatile __le32 *)srng->u.src_ring.tp_addr);
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
-			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			srng->u.src_ring.last_tp = le32_to_cpu(
+				*(volatile __le32 *)srng->u.src_ring.tp_addr);
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

base-commit: 758064145fe77e06d07661b27dfa9c24fe0309a3
-- 
2.43.0


