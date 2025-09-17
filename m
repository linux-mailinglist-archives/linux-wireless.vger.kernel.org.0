Return-Path: <linux-wireless+bounces-27429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A7B7C813
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773CC18821B8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2782BD020;
	Wed, 17 Sep 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="yvRc5MPA";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="jzq3SBKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B9248861;
	Wed, 17 Sep 2025 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092700; cv=fail; b=N6qRCMvR5mPDcjc24XSQPzdeil2FE0+rfHrrG36wa2Dq2SSN9etetq4qqf0KC3h21S7k7yACzoE3hOtlug00Ruc+bzq72xuTbL8jIMm5wSs1ym2M/2ahX36XoCxFsIL3F8jcNinJYSDCjsjXVJNl90iaVyH2k0VQEdGH82BCcFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092700; c=relaxed/simple;
	bh=qzmMa79n2rfkqFNNLGdX8jQipFBsLWOGJklIQUOK1uA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vo18DkWsOxrlDErC1s0fky9DAUO3BTFHomzeW2ltADOUb8KJK2G7TbryKBO9vJ6/Mf15vmDYjJWaleO8hkAjqI/qAw4jk1Rdi0d1eiTEJ1TYHzkz1+cVn6afRZNdhcJwIX+6my5vo5lDtGb6cZ1qHTuWoY3RiWPcJmc1yc5OPHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=yvRc5MPA; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=jzq3SBKc; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58H5CnpH3466226;
	Wed, 17 Sep 2025 09:04:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=gBi2+GwBmt5L0HbcV28AxF
	SQg9zed1NP242QXGMr9os=; b=yvRc5MPAqVOETmWaMkjbO3usPdTkZ4EsPDYPQX
	qACruE0QlIHj3oDMLwJ8U0+W+dRypI0nyhmEiB7CY303RiOyYaiEGUPTiB8lYHC6
	oL28A3SKmHVDo7MvlGxIGiDbPwb7A2tZD/QZ4R9ZGlOJnAz/EipJ41WwfaXS40Ru
	/6TAF2oG0j8jzol/C006zcc7jnMPii9f/5fGHb2Sr9b0xaWjMFXnAZXqC1AeOUNw
	UkHjGC02/YlaD8nOSS3urxBgNiqnqzNY2EkD1xaDdxsNya0o9vFPoJ7sFVIWSfsI
	MgSVvqbElQbLdOX7UBSn64Nuo0pp3aNCS+jD/Cx92khxnAvA==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2111.outbound.protection.outlook.com [40.107.241.111])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd1gad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:04:36 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH8pXEWLDCs13xrxActC0H8bUw/bnFbub0la0x7zlUARZBGMw+c5ngt6t5nqpd9mVJ6A6s4LQNFJa90zmcE3z3LqMfbRByyiRCuWDEvlUR+FvyOyb2zXpCWlEp7gwMaj1CojxPdWqSWUJz/EfwhIGDFfcI6ItfRJ/foGoqf9S1pVyEgIwY+NBF0XcW6YZtut8CEJUtV40+mvHNeK9ZG2EXMALWpa+vfHtI/bWN50QdhR935kvDByBQt0289R+h4TX5ydYz+SOIobO++JEgLa3RmucF+1yKymFkVUkKRN7xNIT3gRaNWCpPBUDK5Pe+A0FW2IDhBJBGIaz1TolWKYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBi2+GwBmt5L0HbcV28AxFSQg9zed1NP242QXGMr9os=;
 b=TRV5o74LphAQjhNNQXm0rUp8bKw3BwERwAI500K+uOaEfVF/fJR8/BnVlTbd1psQykteHfwLznuKSfAnPqr8K10VkO57uEAwd9W+ok98I6cHiVb1dtLUde8ZTA1UEtmDVnExeflwUy3TmNGdkJZZZnqDiDjf+7FYqx18fpWTWBWgB2UVlcm2XRi+zLu8C9Wh1p8QtPFTogM8XB9kukokhlcI1XJgIrNRAhm4YXI/CisMwJh0Etpa50KfqV6yX3OR/pMguR8MPVA6v/UfwHRIbQRdPR9jybm8R84Pa7dMtTrxkzxReK+ZVZAQsAG0sjTYGSnrXiWP6bn/kVKxYN8EKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBi2+GwBmt5L0HbcV28AxFSQg9zed1NP242QXGMr9os=;
 b=jzq3SBKcok3o5kKx5wdkCJmNqfpf8UrBXkRUgr8lRNEfPe+yV3Dz5U0XCrIsNqkniBLT1yYOOK6cvwg3hiysw2hXO95KSEBx0PaQOLQ9UefAdyY7Le/271hgPfjBtgNK58QnPyrE4bi6lbOAMFRjPKf4nSKUL3I24qvjWI0lEzs=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU2P192MB2171.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:04:33 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:04:33 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 RESEND 0/4] wifi: ath12k: Fix endianness handling in QMI
Date: Wed, 17 Sep 2025 09:04:23 +0200
Message-ID: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::13) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU2P192MB2171:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c71fc03-9991-4588-41d2-08ddf5b87494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPivRwfZTt+Epbp1LBTce4nTl/4RXUpBE3LFvqmQ8v5QyEjmdjRbaRM63tav?=
 =?us-ascii?Q?ThApy9KYazOmrF0iXsx7L2yuFjQycs5beK0fWNtz2np/T1sp73xvcbb5U4o9?=
 =?us-ascii?Q?B7+Zt3/ojHl64vaaXE/gDfPpn/H2QUWwPYX5JYmJ1Ld9CRasvwcBTKjqh2Oj?=
 =?us-ascii?Q?LtWvVW+ryXUNoUn3kVl+FcSwcdKi1J3jssRnZSAyd0pi3B1AjfaGJR5nZom6?=
 =?us-ascii?Q?4GgV0XHovzSUXrQwNwy4yE5ondFF3jc1oArf4pnUuKUWs52WytKrrPdS49lF?=
 =?us-ascii?Q?d7S3sFSfN9r+ZDcYDlJaTa5OIfRGmk63FXmxrXWC2yRkxqb5A9iWIO0Yd7q4?=
 =?us-ascii?Q?qp6cHDV4eXkYiUb5lxamxYPtcKwuEDcFEWKhH3p/D/FkhhcghVjJcj+uBi0V?=
 =?us-ascii?Q?urDNmEpx7mS1kqENv3n3O4MJ9vgfr+49oV7yfRqUO1P7u7MAgc5qDDGaqNsq?=
 =?us-ascii?Q?dNFNP5Yp21dRsh4OjwRRlFRe30pfMNF4SlAM609/oxbCrkNEAvOXnWhau1zF?=
 =?us-ascii?Q?o6bTCbbq8tnRp7aYP6CzJAdWKqB1EzzbSeqtI9WuDixvViKE7ESf41m1rqtL?=
 =?us-ascii?Q?WbVrlXlcFuUypGzZojq5b8cOnl0rbY7ctWWadJyBdd/rvqwNyFkq+oscQzzq?=
 =?us-ascii?Q?TYoQsxQTIuaGMRpceJUSkvxt+po7m7DZaif+WYYpzZl7GVKnssfIv6V1Oc20?=
 =?us-ascii?Q?4pUb9EnZXuGRZUnXabJ9eMfbb6CkkdfD0ytkJCuC+oCbAYerhP1MfVI42/Dl?=
 =?us-ascii?Q?qZhdUGivWBZ0hRHY7XBdqTq0nJRLoCOajI+TOhehkMbELtrdTG5qx+K6p68i?=
 =?us-ascii?Q?Ed1qHYI2BTbZccVkyHMc1l8JzJJutj3mi4t4Zh7VO0zgTo/f3GTf4Vm/M6cl?=
 =?us-ascii?Q?7hbnSRojvKRPejl/Kte8EPaP/GQ6LtX5TAbcKZtOJXDSgUjrh8iLef6b39Pj?=
 =?us-ascii?Q?zC91MnNPjRn+3JknuoeHjzFmTJLuH5ML1qPlxYdfj22MzONexgjt0j3438b2?=
 =?us-ascii?Q?dgUyo7ujkaBoaFbMEswhFaLFKpMXeuzHVKGMm6WY5/96Pv1C8XHIJM68Or8D?=
 =?us-ascii?Q?aJmhn9g8s0AKnUJhR3eCZ0ln7t89+DkoZBfQzH8cR+wPGKJflHh/hltHoVB2?=
 =?us-ascii?Q?k+is/Jt6tIIYiHCrB6V2zYHIEQGPvRKNp517ITjz0K/1+VXFi/x6kJ+Vv5kp?=
 =?us-ascii?Q?16bN3IoS/6rPGAKBblDRrVVRGqSqrUhKvFMHOSEy7LBsDczBMum6HLXuXUlk?=
 =?us-ascii?Q?YsmwU0L0Gp/sZ+K7LuVZuTnIGvk6gs+/lh8FhK2CUz1DsGQS486FQfhLvE8b?=
 =?us-ascii?Q?dMKAYbSpOzTmgcol7G7QtgmpWfSJzbf0AopdKUrfy0CW2U0V7uo87QWcWmo6?=
 =?us-ascii?Q?7yUaO5pjfj3HxrbuD9rwAThZSl3gmBu+VKIhhxn4P92eEOEdxEGKDvc6FqSC?=
 =?us-ascii?Q?2cOBh+4bwlM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPRd1iqqg/XONJA7e6RtwrnUpRSF48vPJUGn04Tn7yPfXPf7do25vrqRbBpO?=
 =?us-ascii?Q?h8T8xqQHYBlnTcRz6rWEotuH3xsMlXUvruHQmiDb6+OpJ0ZSsIWbA16ZWerO?=
 =?us-ascii?Q?8wnJ8qnPfLwUXtPqGPWouiCl3KaA22MroT+Spm3N4Ci3qxKdsJnvbp/TdaWW?=
 =?us-ascii?Q?eH3L9H9PPKE868Gxo/CeD4k/zInkLcfkV0xAPwI6IbtASIwzAZsSbZ+QSrrP?=
 =?us-ascii?Q?yGbf+z5sjXVkjB969IAJ8lDLrs4ziVc1TyRoj/gXGQAQIcxNObgFCheCUGq8?=
 =?us-ascii?Q?EmIOUAaJfqLsw+NsW3uOavEgnE7RC7MP7cn1ofvx+pcnB7XtVWrW7PRya0f3?=
 =?us-ascii?Q?vgvXqgtFwzPDp7EPZySZwb4dmKPzVGqmRfhXlAAGf04khe3HU4eIf+Eb2rgh?=
 =?us-ascii?Q?IdyGZPQnK1xNKXNm0bnbxzfek4PIhoydq227+oYfDKpQzWbjbXczj941UBJS?=
 =?us-ascii?Q?PS8gSUc0T9G1qAdD4rHWaQPB2EOqSByjfNqdsDRLB7geyl0IJ2r3z9uf9YOn?=
 =?us-ascii?Q?fZCVsUjtGoKhvBOh2L+Lc2vaZr+I3niiLejz9zyqSBJLbsexC0kuW8Hfqnpz?=
 =?us-ascii?Q?gWKEg5wRroXXIsTBjSAgUfP1VJJlGIRniIlPXZl134LZIsYLYvgFTeOmJ3v+?=
 =?us-ascii?Q?4uD61j3vrZcofn1Fbo2WvQY4+HmF1P62XxojBek1Q2UL+JP7M77IbsgO3LNm?=
 =?us-ascii?Q?4nZ4jfEjE/HhhAqGh95+O7Go7iPKrJ51mDVVrM9+q6moe7+dAKskESZSzqQw?=
 =?us-ascii?Q?bw0t4VDGSTXDcXEQxsOAjlsFi/pikQrfcwYe3WPCsK3F8ASCLG6O0wJisACK?=
 =?us-ascii?Q?WRPYUMggPxUrGGPBi/xfvtDZ5D/9kMvfYgqnIsmrPF5YTAkDCMcwGuXR461l?=
 =?us-ascii?Q?2AWZlXLZq349/WQfy+emj5dk7wtN7YLPy/2vxtm4mSVuY6CnOeWDuKaKo8SL?=
 =?us-ascii?Q?Hh6Mm47hvYiaTYXw1FTu+fA4IJEK7ShCmONbTaJPhZOnq3Hihx1vUIO+p9Vf?=
 =?us-ascii?Q?Z2pGICLqjZEKsFQtPGv0Zm/K5IFWL3bsGD8O7Tv6j2FwzH0atEc54GbbepK+?=
 =?us-ascii?Q?Qb+urXpeM3HSLWLCu9HOG4oWfZU6ybNJuiJXPCNqsCnQT/55Mtl92Iu6l9z7?=
 =?us-ascii?Q?rAY1S8qPnYGadIsg9B63tTuk/lMhsX1lyl/aaY8l11OLCh6tPKswBnHoQUEw?=
 =?us-ascii?Q?jwPPDbZ0lgT3oehQNe+Ac54ivtnrtWOFu9MeqmC6cE1wW08tHjzcL9obSgZb?=
 =?us-ascii?Q?OnjA1+YKR9q7BIG6o6z2H+HNmjBEVh0I6qMGXzJdCzeQX+S1BfxNLGjHBvR/?=
 =?us-ascii?Q?RFdC/o34nmraBAD7Z/hp+uQjX5h1cR/Kfku2UTO4yg56Lp9sUOSerAtVJNVi?=
 =?us-ascii?Q?ntJeekaS6sExvIy4HzJte2xaYJu1gpPiq1/jOaBJoR2z5WmT5m9370AH3jmk?=
 =?us-ascii?Q?hGpe71Z0TRsoCzT4dQGtZHBX2EuG3qJvgWPYQuA1TF5oZeopN52zHHJ+tmqD?=
 =?us-ascii?Q?uXq3omr3SkxtxLKZQ5Ot85xkmqqB7hI1SS+Rqir+61zTzR7QC2NO19FnJVRV?=
 =?us-ascii?Q?LL/uZDdPze+44fs9c+mk4y7Q11/ZNbW+8ybkfXl7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r+hIDXdrO5jJdCF+ttPOB/uCazISUMDOwdj4rqjbMTLjZGjofZsyIbvS2WdnhWd7D+wP7eQywkPLdyG6fjpzU5rDahQs+3zABTmkJSHNdTqusGlnLtq7vfqwBN0i8DRO9iqfhWT4YlXm2Y5ammF7u1r3cfl34ci3ItmPsjN1JrS2Nxmom01qhIcQFkYVzVzseVnviKomeMxPE37+4JpSqEXH4ogfrsEH0y4/PHex4lNgGa4DV/VMhMbRctLfStOoH473SoYgao+FLTMuXlnSkvyVXaX2PT83buDL7BNB0yVRItkAZ4hq2QqC7wCNVO2fZoXD4vHzQoKhPjhDhWtgufmYQVOGyCn46JSBkadvktdJmLhFwCi0NGCN5moj52ki/WZnyMG1xer4U0eTNEc7gP3DUxqyE6pQaRihoRj7y8+X0SFL4gHkW+EHUxmEaFmEXjJNTvmEsJ6X4JiKjboCchW0NliVdLoTBChKV0/324JxB3qWjs3EGN02TgQ3imrJJyEG4+Qzyr6m+F0UVpNlGRS5Dm08kXY9WDvU65YJo5NcrWfAsAcsEk8YCPiPT17cA176NTlPyQEiXpziOC95XJlepF+ic+OTBLssKgGEB8sOhFJo28MCM7H1TpESVRKB
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c71fc03-9991-4588-41d2-08ddf5b87494
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:04:33.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOTixwYYEH9mFrjztZFS5iTDCABW2yEz54aePr0SIKtL3D0TfUaY/je3gy4+iQXDTN0X+nhMeZ1awMX21AovZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P192MB2171
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
X-OrganizationHeadersPreserved: DU2P192MB2171.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68ca5d84 cx=c_pps
 a=Ai8SrW5E0xaLXO3EKqmJtQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=fIT4UxgXLIuBAtv1WeEA:9
X-Proofpoint-GUID: qxC0pid6ORalJS4d3nfA7gZvjZBy2rk8
X-Proofpoint-ORIG-GUID: qxC0pid6ORalJS4d3nfA7gZvjZBy2rk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDA2NyBTYWx0ZWRfX70qWD3EycoaY
 ChZXumwFRf+9sWD5R5Gn4qSIEk7jTgEOymTJUk2cuZ07ATsutNBfYUor1ECcX1iJUqGEt5jM3n8
 7kW8P+b4VpMzktwVDBK4ngGZrA5i6N6A4P2o5IwJnkw8BX4sKUmJY6zJMmYEadWVr1Evn2741g9
 23i5ITbDTDq5qifFvLkaxigi2cTuRm+drRHC3mOjuSoEqhxbtTs/xFXu5plWzUzj1Jy+08lzopY
 8x4QUisxqw06uUEjpOobCjw9sTlk81SNPHJgGf7f3hY7x+R+neIvNoynBkDd0PSktBngxbJtjAp
 jXM9w1HDJTvqLJVz7FwTPhAQekUbyKNkZby/0h3yjBk2LoTyJibYha9mOvUZZg=

Fix endianness handling in QMI firmware transfer on big-endian
platforms. Without this fix, the firmware download fails due to
misinterpreted data structures exchanged between the host and the
wireless module.

The issue occurs during early bring-up on big endian systems, where QMI
messages are not correctly parsed by the driver, leading to failed
initialization sequences. Ensure all relevant fields are properly
converted between CPU and little-endian format in request and response
messages, as expected by the firmware. Attached logs showing the failure
before the fix:

    ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
    ath12k_pci 0001:01:00.0: boot pci_mem 0xcd4148e9
    ath12k_pci 0001:01:00.0: pci probe 17cb:1109 17cb:1109
    ath12k_pci 0001:01:00.0: pci tcsr_soc_hw_version major 2 minor 0
    ath12k_pci 0001:01:00.0: request MSI one vector
    ath12k_pci 0001:01:00.0: MSI vectors: 1
    ath12k_pci 0001:01:00.0: msi base data is 0
    ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
    ath12k_pci 0001:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/firmware-2.bin size 15134776
    ath12k_pci 0001:01:00.0: found fw timestamp 1722934582
    ath12k_pci 0001:01:00.0: found m3 image ie (421880 B)
    ath12k_pci 0001:01:00.0: found fw image ie (7229440 B)
    ath12k_pci 0001:01:00.0: found dualmac fw image ie (7483392 B)
    ath12k_pci 0001:01:00.0: found firmware features ie (1 B)
    ath12k_pci 0001:01:00.0: features
    ath12k_pci 0001:01:00.0: using fw api 2
    ath12k_pci 0001:01:00.0: dualmac fw selected for board id: 1005
    ath12k_pci 0001:01:00.0: Assign MSI to user: MHI, num_vectors: 3, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: Number of assigned MSI for MHI is 3, base vector is 0
    ath12k_pci 0001:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
    ath12k_pci 0001:01:00.0: irq:18 group:0
    ath12k_pci 0001:01:00.0: irq:18 group:1
    ath12k_pci 0001:01:00.0: irq:18 group:2
    ath12k_pci 0001:01:00.0: irq:18 group:3
    ath12k_pci 0001:01:00.0: irq:18 group:4
    ath12k_pci 0001:01:00.0: irq:18 group:5
    ath12k_pci 0001:01:00.0: irq:18 group:6
    ath12k_pci 0001:01:00.0: irq:18 group:7
    ath12k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
    ath12k_pci 0001:01:00.0: cookie:0x0
    ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
    ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
    ath12k_pci 0001:01:00.0: soc reset cause:0
    ath12k_pci 0001:01:00.0: MHISTATUS 0xff04
    ath12k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
    ath12k_pci 0001:01:00.0: pci reg 0x3164 instance 0x11 read val 0x11
    ath12k_pci 0001:01:00.0: setting mhi state: INIT(0)
    ath12k_pci 0001:01:00.0: setting mhi state: POWER_ON(2)
    ath12k_pci 0001:01:00.0: mhi notify status reason UNKNOWN
    ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_MISSION_MODE
    ath12k_pci 0001:01:00.0: qmi wifi fw qmi service connected
    ath12k_pci 0001:01:00.0: phy capability resp valid 1 num_phy 2 valid 1 board_id 84934656 valid 1 single_chip_mlo_support 0
    ath12k_pci 0001:01:00.0: intra device MLO is disabled hence skip QMI MLO cap
---
Changes in v2:
- Handle QMI conversion within the QMI subsystem instead of the driver.

Alexander Wilhelm (4):
  soc: qcom: introduce generic QMI encoding/decoding macros
  soc: qcom: fix QMI encoding/decoding for basic elements
  soc: qcom: preserve CPU endianness for QMI_DATA_LEN
  wifi: ath12k: enforce CPU-endian format for all QMI messages

 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++---
 drivers/net/wireless/ath/ath12k/qmi.h | 16 +++---
 drivers/soc/qcom/qmi_encdec.c         | 74 ++++++++++++++++++++-------
 3 files changed, 79 insertions(+), 35 deletions(-)

-- 
2.43.0


