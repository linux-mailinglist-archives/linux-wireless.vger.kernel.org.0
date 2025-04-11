Return-Path: <linux-wireless+bounces-21438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB33A85927
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0098C18978A6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1E298CC8;
	Fri, 11 Apr 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ROnlQeT7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HTb9w7Ol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C263B9
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365944; cv=fail; b=WEwgubTggvXhCRcubvqCJTuT5RtUjDmff/MJ3q0PJt9I+Kn+R3h1HJb8uNCvgfOpDO+KRQuK8wUsBNYKVej9tVYMZ0w945DvJuzE06OqqlsmJvB9RMV/iP49xuMrKZeJFlLbHRZdiipX+F6E+MiTjzVChgOEe24Jg2Su9Oca/QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365944; c=relaxed/simple;
	bh=GIDmQe4wJJKzS1RdXu9zylCDGnl/yTNg6oT8ZMMmbbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FyGNt3kMzBoSi+bWjprArNgWnja+S16bIXZoioQsuUhuL42mIn6WVCqT9cn3EPOpDX7+BrRFEExyy3Hs6hNCmT5DVg/cM1Tw4DwR1Y+QIW2rYXW5DaP0++RXnyL5ILsvcwMNbuA+lwjnF166n69h5YE/rxYRtS38YmHnf/gDj2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ROnlQeT7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HTb9w7Ol; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9ax4r002304;
	Fri, 11 Apr 2025 10:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bleubSrVJ4WMZlox4U
	ifBbReTN0NxoExMYK6tdU6j1Y=; b=ROnlQeT7vA4fMrYIxM9DJkYdDVgQm2GbFx
	jtlJjNgDjnoI1Hs8vOnSORzVYDhIEqNCGpqExvHwmwYknoF/RPH/mLtoaHFgKMXl
	hhVeDLCPrWit/8CHbnNiMB+XP9njpmpPALiYjdiG1YSyc+uloxru+fk8pr4lRy8U
	fyHUwdOHTSvE/kazdM+mte0pXk1Vkumr2mr034ry0jMiAlsGGUQV0GkwCbZwhyeW
	I0pnobxohmB9HHzvIK8tfnWj4uLJ6unGbYec8uNx7nRni5hlAoYIdSUZa8X+J4Hb
	+1OTGUnBh7N7+gOgp+DM0yTYdVn5k0CxRZ5IB0MW/eX5oi+bHOQA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y0ks0160-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 10:05:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9MUWO023934;
	Fri, 11 Apr 2025 10:05:21 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttykumf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 10:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOMHtGnsbsH55pDwzU6KaFpP3KM/jR0VHgLdpFP6mek11eb3FUq8EReePLD/SB/jHdRzt3BVgTSTWSr0c196yA/2rCwWinI10IEGc0vgXfvV8BqeDkyB5eA2CVqMu2RnVTXo6bmRHAgUkXDl53r0wg5tSMx8Xa0ygMyG+rtLZzfEdR7G6Xs+QbdifBMo99mpdmqASIariBMT/wXxqrC2HrZjVhFrolTV5cAKEfsvhwOuAtMO2Ewul2M2diVA8Nyq9AFn7hRB9v5aMj7Si4mglb0GMLOuwOtlbCrtZ6EHbR8DID3D6PxGhvrwMs/UB2GIJ5/AR1GAT8o8y/sqFDIYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bleubSrVJ4WMZlox4UifBbReTN0NxoExMYK6tdU6j1Y=;
 b=iqz/Z/i0JS3yVMe/8ogwZPuGwll+a9rO4SZP6qSgmDVrpMLY2VNLDxhzePrap9VkhSaGNB2cQaPySCYozzdg5MFkmZHkT43ucQFwk+A26rn+YHYvhkQKaO+kSGcPfNXskG75KJH1LBG9jTRN8PvUJKjPNuW+pUFGYgdC6hEhcax11/wJ12HVAZ7FhiwiQdYG4b8nmdbQ1zNJSRAsp6pp4lJ/dFw5Y+eiOp0u5vFcpcxLnAxFtaCFNbZKE2cTn+ECu527pFLvAK6YYRqoJcRZXj+uH8QamiXKTjFq/QY67KIy1d6WvnJm5roQHok8wj21gIKDxFwCgQHf/NJCkUFHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bleubSrVJ4WMZlox4UifBbReTN0NxoExMYK6tdU6j1Y=;
 b=HTb9w7Ole+z+ZIKC5R5HUAEa0invdaPGDeVQyNLqs6oyuC5OfQCkW17f0nD0bDVxmIcxHInSEPvEecZ0HZ3JhMHPFQr7M/CkS0xYGZFOWm5Jodhep8XotVI7sJWKU7ONpl5jQjDuClov9PbzCl4z5zPZemzBkBJ77LwlG9o8Eeg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Fri, 11 Apr
 2025 10:05:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 10:05:18 +0000
Date: Fri, 11 Apr 2025 11:05:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Abort scan before removing
 link interface to prevent duplicate deletion
Message-ID: <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
References: <20250226113118.7626-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226113118.7626-1-quic_lingbok@quicinc.com>
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf10d60-2a91-4b2d-8098-08dd78e05bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pFxpShELiUDMG9SXzn4HPzDtFQlHC4ExCoiCfC+B+158rbqGRzOTYMfimOXW?=
 =?us-ascii?Q?Ach1bbRGtNwmYVLpaDJa0mDz4EENYyFoMgOHJhvdTHrFPXDMAXOF5E+179NF?=
 =?us-ascii?Q?y5tBqK9k/eF6xwdy+j91W5mzPlRZWtWwICsDWDPnlsUbGyB4iZyTg3Gr5bCH?=
 =?us-ascii?Q?e27Yr2GPvFSVCCGKn9tDMgMReWXqSf/g1GbqosuFikSKs0NGiMn1f2pu6fMX?=
 =?us-ascii?Q?CC4M9DKkjivtUUeLqIo6G458OG2iCdMm3t8ubM7C3Fo3kP2F/FuPt9dJHr/h?=
 =?us-ascii?Q?x5mAZHYMjUok9WhxIT7gxV+Jvr+OUIneuESJ3wi16i+zSqVIKaVhBpNfMynk?=
 =?us-ascii?Q?Pp1J/uUlK48q/4IGTcC0PQJZyLnvMpkHOmIoyW63WKlaQRup+ZKYCjRNvNUF?=
 =?us-ascii?Q?ZK4X7VhLkaaGZ4QPjvhSt2+EmAxiXzdFlyvei8sKorRGiEDDkVzHMVCuO0I8?=
 =?us-ascii?Q?WbiOaVs2TNp+1ZYzgSAaQTlGkHAqgnYawC5ytmKX+wk2R/JY8Gd0d8dIXHkW?=
 =?us-ascii?Q?TbLwrA4Z9QVzYvuNX+sPXQan3T64bvEP1raNfouelfLctPRcquhD/cggLm7E?=
 =?us-ascii?Q?hkKIeHtlkclbwlM+gYBO2kotiM5z7HePu7eZ2QLgUZQADO/mKeoJHIZdkoRv?=
 =?us-ascii?Q?wV77IIus0AVbZH0yNUtF7NV3clCA7+hjA6xI0UlSRLEydLn8yoDWYaJMORaw?=
 =?us-ascii?Q?6LjEQYQS13+nJyOkFnsKrzQg1uDQ7ggGG838lBqGlJvGmFmnfPY+2c2w0FXJ?=
 =?us-ascii?Q?LhR7aeBpE/yV2RrzSgmWm2QoBn9n4pRqdaQ9kceg3knhoBzjx/obGHngjBRx?=
 =?us-ascii?Q?EFWo4IUyLxGdYdrzl6d7afj6TxgiPYdaWc59JtmyHOMe2ukvUOV0cZP/iHvI?=
 =?us-ascii?Q?vXRvkzBbP6ee9PRPq1W4qZ+IT8A6sAJ31vriNKmYiON0t2JF7Wr526Qc8lwX?=
 =?us-ascii?Q?XcUAJvo0S9i9ak4e8FF2Rxu/Bzpd/cZd6j3Wx4wwC5NZVPLTvz75tkOQ2PsK?=
 =?us-ascii?Q?+kEBiN+d46RqN7UetLNTzI2SInwZtZUWwna8d51uzn9xFEgG0hzfjj9klzyP?=
 =?us-ascii?Q?Thj/NTOXnIe7tq88XYT25UYoLKWPylbNDLSxmrl4RVnpGvjNx4Yh2ztF8cWO?=
 =?us-ascii?Q?7a7EF/pbJFz+jgQqUl+Z7pHlv1jQoZTvED5PVd1ca6p6+UmnJcI8mCj/+NUh?=
 =?us-ascii?Q?rygOdXXgpMIszs1Dkz6Cq/NMwIhsCQtkkd4HVXen67ir1EhQfW4ctI067A4Y?=
 =?us-ascii?Q?f4iwXcybfII4mO1rqYdwPnYg38VMNKL8QwBlkd+mShZKUWrTl5Dew8qq5ZJA?=
 =?us-ascii?Q?1y1WFEwbD5e/ZVlcoF81Otw5BarjgenbfiSZmgogT3BoznKptTYS/2fxD9lU?=
 =?us-ascii?Q?2lyMDY36+jDMXLmlRPXUrAnCUXwy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k46QqTCPbc4UUMGkM7QDuLBSB/p1/Zlgs+VM4eiy96so/ubV/AkZGZQOdL/f?=
 =?us-ascii?Q?gw7UjO59f3Wqii+9fFqJdbmiut4aFkPZaJbTzB+kIrtNPVNJKj7RCc2Emk0C?=
 =?us-ascii?Q?1As/AhFahdMsTlPnIFKfcagtXRLOul2VOlD0qgJzXRYGOt0DUeuDdAEpB7bm?=
 =?us-ascii?Q?KL6BvEhMU6NDplopE2rjhXrfObfnp3MYTUHouytQkepsypyi0wfMw+j57AGq?=
 =?us-ascii?Q?4kv06eMn36SYx9okwBUyvYiugHVi+RQlNP6I6Q4OdRVHM7V9uzLAxICc0TeD?=
 =?us-ascii?Q?pLpd09n6J2QjWSM8WbcheKzvXpt4Rs4h8wo2vn64qjVyPSanzlX7BcmnFAMx?=
 =?us-ascii?Q?WekGDRmlVYJ/m4eRHfeZ7SEziz4pOlNlCeWlAmbAWalidJf4agk3tlqon8vb?=
 =?us-ascii?Q?kz7aoZnpILxoINEFbI+9VrBviVANO28umUizCPRTK0ppN5FEt3Y5d/4SxPI8?=
 =?us-ascii?Q?vhBVSBZT3c3HGp2+WeG6ZSSKB/ZcFjnNqfN6v/EVSf/MlDOODa1e7hyLbTZu?=
 =?us-ascii?Q?/Z0pDtGJNU6M8jO0JjqTnzeVLjtueqOqPaFMYkk4BbRdl/XOcBqCoSsTNUPj?=
 =?us-ascii?Q?5JIndS26rgXRkvhpeMoJrUwt+Mxeyj5qd70i1pO3BNgIJik9QT4VwwCGEISt?=
 =?us-ascii?Q?YxVzLN7uuLXc0b2nJH4xZpQTCBidb08owWUA2C38L4OaIUEADCtym4g2U9Vs?=
 =?us-ascii?Q?jzimmiYSyVSdRzPIZ2elorH+t8l3gU4WFK7fJq0VYxnxa9/+XhS2H6tU6Q2X?=
 =?us-ascii?Q?GxpULP60HYz9ujw5cIGdKTGJeE6o0l0ZeTYqGMxMcODUpYRaIIEfeWCs4ZEo?=
 =?us-ascii?Q?jTKtBaDdFJK2OuID/Nzfid3wW29sjk9ST4GtM8QTZkHVl2EwI0z1QVuoyi7Q?=
 =?us-ascii?Q?G+I0wUQnx+6iyctZfh3Cwp4YWzr9rvibM4l1kuSNytpkAZstw+zNhVuEnfux?=
 =?us-ascii?Q?fYFCkuqvqNn2hHRQG7FHqbAtDfkXw8H5TfzgHIZrsTABuVN8If5mTgGp0+oR?=
 =?us-ascii?Q?7f3tM/nRX/p8JJrduMd8c24SgsROXUWCpKLLSkOtJeTqsxxd1J+c3d4hUYto?=
 =?us-ascii?Q?1uFJAnJFW+VT6Elc9QCWL+JXaSX31U1GqkkVNf8mEl1atY2uFAblvaDjuCow?=
 =?us-ascii?Q?bAlNyxeu7LP+FxYQhlmbBmov2HLZWNthTKHeT331BX5oxj/GF+/SJAndyLo+?=
 =?us-ascii?Q?IE18lwc8SBsB1pvMoOLBiq9qJvA874u5TlbdMkOThDbsBYlmHe7XQk1SM4fV?=
 =?us-ascii?Q?FMVpmgETXRefNmB7b/giKsL/lDV6akOC3in0LbFyiC/13yr1dFHfKa9Z4cuS?=
 =?us-ascii?Q?xRCiJIobz5iwpMhsvh1eeyKlRIKUEdD+bTntqyLsm8Tal+w7wgcU1rm0HK8B?=
 =?us-ascii?Q?kKVFu9M+fvqDk4G0+BxILXZSYP5bwPoNvp/L3QVC34BjA0T+vhf+3iLeLphE?=
 =?us-ascii?Q?b2n2fAfOQtZJxMC1RuggFs7be8IvBYZ8qTBwGOOaOSvRKhDWSpLgCw5EXhs7?=
 =?us-ascii?Q?8Mf8lJAXQm/HMoaEJIvk2sb1q1ftjGONhdj+MYdSCEH8vxLP4rWgl3wge0Wd?=
 =?us-ascii?Q?bBcj/nm9yoU7DOy3YnRly8hOc3ZKxunHc47unUobZxzaAHWGYPN+jaeRze6r?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FeC2sR/vKp5cifW4GegTZ8DLzN7123BnfuPWooEGFl/JtZVvRDCtNGr2V29SIuOiTWCMSgUGFa9j5TR24zn81i9vGZNGMFvg3JczBtjtER9/rTtQanUq6aPkkgBgGbV3AfAC1YhoRZ/Lfj2vH+unr339yyBF6wrzlr6KSc6ISAVxM+8Lj3YqMrCnEqveWUJJeBUnu87C1kcnKnexCsYizEF46w46REmjJLY5WjuZHhHuGuqFRzx7HcjUlJR0U1a7oxJmmCsObr2LuKPQpC7GUGUGpFic89aN3bJcBRtC7/0eQTRBYE3LI7r4VvSo4J9w8H1mTNr3/9pT47+9LQxtTRJJLmkr41JdtQtGlYx1t5I7CcDyc0KB4/A/NcOy7JIFgPbw3CUoSZYSJ/XjdmBeBs1PXBKxivcMnWT4oiXVhgr3C3/yPMZr6SH6W5UvvaFXY5e8DVvb3mZv2qyWYjIiOg307m7neoxK9pYIeRXsEGtGE7W9dLrwq7HJIuLvbmGU2YoiarDedhpyavDcH4U2Q02XBbHX0CHqGkGKXnPexThAqS2t2ETwhJhZ0KEwlXg8zGXQBBg+EFzTN92X+hzIiCxi5TSHytMJfwZSd1gSxFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf10d60-2a91-4b2d-8098-08dd78e05bcc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:05:18.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/ntKoz1lRL73vg0mGUiPUHDxMK0iOsblzcPDI1k1K8+ND7Ey4FtGDCafjrdJK7ng4U697RL4rYCMF2KWJ2pZFCFvCm+JKHoPOvXyfbgiko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110062
X-Proofpoint-GUID: EkBfLOZldPUJeCLgE8q17ibXj5udcPYk
X-Proofpoint-ORIG-GUID: EkBfLOZldPUJeCLgE8q17ibXj5udcPYk

+cc Oleskandr who kindly pointed me at the v1 of this patch (see [0]).

[0]:https://lore.kernel.org/all/20250124093352.481-1-quic_lingbok@quicinc.com/

On Wed, Feb 26, 2025 at 07:31:18PM +0800, Lingbo Kong wrote:
> Currently, when ath12k performs the remove link interface operation, if
> there is an ongoing scan operation on the arvif, ath12k may execute the
> remove link interface operation multiple times on the same arvif. This
> occurs because, during the remove link operation, if a scan operation is
> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
> from the firmware. Upon receiving this event, ath12k will continue to
> execute the ath12k_scan_vdev_clean_work() function, performing the remove
> link interface operation on the same arvif again.
>
> To address this issue, before executing the remove link interface
> operation, ath12k needs to check if there is an ongoing scan operation on
> the current arvif. If such an operation exists, it should be aborted.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

Hey, thanks for this!

Not sure on status of this, has the patch been taken for 6.15? As I don't
see it in Linus's tree (not looking _that_ hard though). I don't think it's
even in -next?

I keep hitting issues with my X870E CARBON wifi onboard motherboard wifi -
most recently I saw a null pointer deref in ath12k_mac_remove_link_interface().

This occurred when I tried changing the network interface, in fact I had
first clicked on 'available networks' in network manager so quite likely a
concurrent scan.

I rather stupidly didn't copy/paste the text of it, but you can see the
report in screenshot form at [1]. Apologies for shade being case on ath12k
driver but you know, frustrations :))

It's difficult for me to test your patch as I am having pretty awful
firmware issue with this motherboard - if I powercycle in any way that gets
interrupted, or especially if a kernel issue arises, then the ath12k module
will not load on next boot, or at all going forward.

Updating the kernel to, I think, a recent 6.13 (and now 6.14-1 where I
observed this issue), got the wifi working again, seemingly randomly.

Usually I have to try to reset the CMOS state, but doing so causes other
issues so I generally try to avoid (I have a network workaround involving
an ethernet wifi adapater, it's pretty... yeah).

So I assume some non-volatile state gets corrupted somehow, I'm not sure if
you had any insights into how I might more sanely reset that?

Anyway regardless thanks for your efforts, if the wifi adapter appears
again then I will test this and can give T-b tags if so.

Cheers, Lorenzo

[1]:https://fosstodon.org/@ljs/114318530969496869

> ---
> 1.rebase to ath-next
>
>  drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 3e3afdc56fc9..551133483f44 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -9578,6 +9578,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>  	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
>  	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
>  		ath12k_mac_monitor_stop(ar);
> +
> +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
> +		ath12k_scan_abort(ar);
> +		ar->scan.arvif = NULL;
> +	}
>  }
>
>  static int
>
> base-commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3
> --
> 2.34.1
>
>

