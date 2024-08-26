Return-Path: <linux-wireless+bounces-11997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76EB95F56A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5CD1C20CDB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF71940A1;
	Mon, 26 Aug 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="v0MS9t5R";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="VcklQoxV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722A1EEE0;
	Mon, 26 Aug 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686985; cv=fail; b=QFiocJ2XrvrX3pPbnx/khcwU+W42KlAkwPLady4qUfb56moONVl/TPENaMVspm7DE9KxxyB1HjISSOu4cvQBg0WrJrHZH5pD2+HuzLtpDDPubfEWdQAwpIQv+C1qbFq1XWnltKjOZ/IBLk+I4GDvMjaXFKwYk3ENL1XqVvUoTJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686985; c=relaxed/simple;
	bh=E5Mb0eEIByM5xon+EjOdRL0rXF4dAuGouc6qlL8VHlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8ZfBR7NheEoqaY30UQrFp7CzzhkzbMb9//xWxuTKrp7mmSZrysmOVUyin+JQEbnSIGiTyfH8ekH3YVNZwlN3TdKwEG5s71e/sj/bxfzrzF2D/eTkwBmxRnnyBvL5ybLQ2VS2qScFy8+xSMsW3q8YxDUDyHNj7JSugEglQ3CkGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=v0MS9t5R; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=VcklQoxV; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QB4tw1004577;
	Mon, 26 Aug 2024 10:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=LXGyWaRJI0h9CuTREbaNGvzGX5vypv4BWCTMCSkzWR0=; b=v0MS9t5RhTJW
	kKFkm3Nk7dBucx9wmp14L1xHxyjURt/i/B0E/ziIS/uJr9sRURBXP1mlSos21YvJ
	Iwm4prdAPACe0mlrfsK7QXvDzABTcUOLTHj1GafklqcRDbaDSENL2MEZqwRBcat7
	SG3GAPS+NBtgVr5y9gRxP4Ljkv6kiIQDNrb6OWSnAospFEbEgO/JmLPew0hBQy1c
	koz6i+egBhrh5lF+a039yt8Dua/jsBfk6MqywFPY/1m9eBBpfMKbawon9VUUw70E
	4FcbxFuhk9KUEtthqq7/GF8UDoiFkML4Dyh96WGK5Lm50hOZfO9ovye9pTEcomlj
	WTCZZLVdUg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 417bu9u7ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 10:12:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqUhMRMIBbsUzBbmJb6+Dxk95MZk400VPIfi4Z+6R/Q3x/jj3Ce7fdqmayvJFAjPzonABjjhxQ32DxEAUnZxWo3+EZQPhTPyVHh0h/nzVLfF2sID0Nx0ixRZ4zQ0+JsijcnYXkUVw10FjRNPu3+5MqN7Lc418Vpglxy4htlhIBXBmHR1RMT5YnrA3zl9W3MEcvT/TjNLxkd3sMdSutg2J3LRV+JGNY80Y9lBLyKsHZy4peN6g8pBHMRQqbo4eW1zsnRM2SU2Ebj1ejNBaAjd3qcNk4RVkYV1BVyEYUJktGtWXoTFcAAec5m4M1f/NJOeC42Qatrf7JmJtfwkeY9CoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXGyWaRJI0h9CuTREbaNGvzGX5vypv4BWCTMCSkzWR0=;
 b=SBIogmMsjo750hWvf5yRR+fcqxuisKCKSS2/Bnt5EdWmLKE5809iBtqC7loY1rKoRW7OAFSdUd1sylBxSto4mi+Ta4zCKe0wThz6lJViRi0gUJtp9SOK91qMNYYc7bK9uhBDgiguOhfmvLIBjEmE3mbC/JpIu+L/KSg+O27QcLyzh8U7+d56VkE1Zr2Pvx5JhQ/RU4hCHGAvZQ+2D4Qp9dXeoajkb9sTu2q7oSZrBTEbUmXQ7cDoFVZnnz7q8DLr7hB79rcEC8kW6LViksVdNKcfrPMY8FNzR15jxdmgObC+naqIsB9yw/0PQse0+6WupomnX0F7AJ+/aNL01TSYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXGyWaRJI0h9CuTREbaNGvzGX5vypv4BWCTMCSkzWR0=;
 b=VcklQoxVWS2LnBWbuOM9SxfkWZNNyEgHBpUTqNM99HfoLFSHO8+xmn7J6M8yqCEbZSIGrQpoNJoJ/JkFWOWyto9WIaLZzA4hgutGvwsjg9ME8sreDyH7CLoXe0S5ZtCt2UsWHhPn5Z/IzBFXhlDF3FJAFzus1zMQGzN0QS9WOKo=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7467.namprd11.prod.outlook.com (2603:10b6:806:34f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:12:24 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:12:23 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org,
        "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
        stable@vger.kernel.org
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
Date: Mon, 26 Aug 2024 17:12:16 +0200
Message-ID: <13597832.uLZWGnKmhe@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e47d0e-dcda-4dc3-91b0-08dcc5e17d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?rmfD7twl9V/fXCzLUzjMgF0W6RfQWal15OT4BCccAYXG7l182rUjBH3i0v?=
 =?iso-8859-1?Q?oH+gYJsE9ebjuRf4GaAy+4+LK/Wt+9EPqiPZebHScoiYxAg8dxn9EqAT2K?=
 =?iso-8859-1?Q?700IwbpH22lHzu275HYQ+i0Z555xQBkf+ADl/DcUesCN0Xhy68YpmJ1eQb?=
 =?iso-8859-1?Q?5DkJ53Y936h1hAf1AcoAiFNEuQhbbTY3Ax+lYcRtcMfyltlhdfQYaq2PrS?=
 =?iso-8859-1?Q?KvfIc1ghgQn9gcenPtvPN875evWBZAAdYUPFtCrTMSsgDp7Z0O03WRH8cC?=
 =?iso-8859-1?Q?WkVYFrzy8W7AJmFfoPFlKy4dJqiqxG+jRTexe1JS66ByMQwrr2Ebc9yc/K?=
 =?iso-8859-1?Q?ayZcSny9W7wibZDvHR/FCkWlzRCBRoImE4gHVhd1eAg0H/DyCxa5OHp04G?=
 =?iso-8859-1?Q?VALIaM6I8JCy6EjAj9yekirVqAUaIyi2nRNjpRC8X62Ga2C+t6wqLLAFF4?=
 =?iso-8859-1?Q?zDdWCUmRuOtT7sVTlJurhPIZHKxGxbm5gBXNaa+Uma5K5XJJN2QtSGEpZU?=
 =?iso-8859-1?Q?BdywnNTHAZbDMIIFWzxl+BS+55Q+6oEnEZ2Au/ipELwhdm0i3jX4ANjVNv?=
 =?iso-8859-1?Q?8TmwlNf7gw+wCfM3z2wU1+fjxpXw0WtuPzxZYngA1JY84zwusH3q2Kk7fZ?=
 =?iso-8859-1?Q?JavcqiNx5jTERKFVaKHIk/eICmHkuTBFQbqHyj3h4iFVCSmzvTi8ZJCUK+?=
 =?iso-8859-1?Q?h9DvnO0iFuFLZN2sShqVVfGC6rzDl9iH9Gwau2J8ftC5MzJeMWIde3JYuL?=
 =?iso-8859-1?Q?Mdzu7ZKTjQw0Guy8izfWgYXTPQAKt1jMDQzSH0dW4XqZNbhWwN6qYUch50?=
 =?iso-8859-1?Q?2ka6C2RIlLU0whnG4rrWvb61/LtSZ0lhAFViiq6gSoAdxhQrYarmiafyD3?=
 =?iso-8859-1?Q?t7O0uCV/e0ACHe84ueo0XWN0H9uXdqNEEAQS1v4Rn74ctRXok1RDKQoCM5?=
 =?iso-8859-1?Q?KrgxRkvcy6M7mL+svDxehhxdfZZe7mKECxZj3zULmh05rAyWMzWD7T26+o?=
 =?iso-8859-1?Q?yA4/+QWMkb9k80zdGDb3dE5aORY1/a/A3nwUV6ZCteAbX3CuxYaIz6iynN?=
 =?iso-8859-1?Q?RqXEKBcsIRCfZROAvyaDuvM01VSIYSd8dioP3v+Xqu9ihbW/nfB4uQg/KI?=
 =?iso-8859-1?Q?XAEh645EdEAEvPVb3NKFb7YguUmXR+Y151gPtsfCU0ygArdDmZcOUobMtk?=
 =?iso-8859-1?Q?11re5hvFplZy7mVXd6tjhKYRuxlkSIZxYGFXQ6zoVt0M3nGJeBic+3aOk7?=
 =?iso-8859-1?Q?iyQziVl25we5kPoVwJywk1HHpGPXnfHO3VvXhCgnBkLhatIoWl2JhYbMew?=
 =?iso-8859-1?Q?snoou30exPOJJ3zWZcOLV67XyrzOPi7P3HdGA5LsYmikT9UZW2nzBDMib2?=
 =?iso-8859-1?Q?mqVuBL6jJ3N+cGhBvJUhiOz4/6CS3vHOOrmWJb+S5YQE0lbrcyjJTNCnWd?=
 =?iso-8859-1?Q?FLQ2qzu6jt6PjryWkUh/x9GYOI1BKp7gDeg7dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ZdU6prz+X//18ezDdQGvzC6CaRnsaUuJ+Ir0Rhwb1NRTeY6tQ67gCTC0td?=
 =?iso-8859-1?Q?Hvm3Fzkp6hcGANHeieldTOwmSwOMD1ztwrg0Zqiihroi+cr5vUvC7YV/Hz?=
 =?iso-8859-1?Q?T/rIFLb9I1BnQZhYLsbm1QPTpvTkXLP3wqkSgN6eZedd9LQfcjpcYj4Bil?=
 =?iso-8859-1?Q?EZQ0QcxE/0tIWZiBiyNlMv5pzigMycrca+QIr6Fg7SvA1IB4fypa7d2+3a?=
 =?iso-8859-1?Q?DxXdX33Mr/ph3NxZLxeK6SWrg6CgAFzcr8tt+MjjUghYgdGcTflPhKu/Jh?=
 =?iso-8859-1?Q?k9ehsSlf9K8hXmUSHkjxtqFMoHEKJqYiE7ytEg0Hfyk4K0VgSrofD4QqHp?=
 =?iso-8859-1?Q?/RNB05C4/BfcNfC7RQaw8lfVtgoN/JVH8grIaHmBOVseOvdA8y6j4jvuzh?=
 =?iso-8859-1?Q?PFaiYZt+UL5udkFd9PgpNOS82+1Hp5Kcf41EcOlWkryk6qZvn0oBscevAs?=
 =?iso-8859-1?Q?BJn6p6IpxKGpsifQiTEV2zzFFiuhJMrGxuPxpmtdTXyuir+Cuzwxkw/J3O?=
 =?iso-8859-1?Q?M9bOkaOW6IiZpbVKJU9OGXLAJV62Q/fsDjM/NpuMHLFom/i1rrBJsO6t7K?=
 =?iso-8859-1?Q?nYICXIZAIYM0I+XtV25foa3SQ3tX4ar62GbF8tpSVr9ajFtQuYe7sWRfBq?=
 =?iso-8859-1?Q?tATFkEZChTCbF+YuRIFQiNfyhRa43YfE6yxzc/jJkdx2xjxErJsxEfa/w7?=
 =?iso-8859-1?Q?FxI3MuIwL1A5Z0AzKnOVKy632IL5OSLencdX2/UgPYT98pn0mBY4R1NxHM?=
 =?iso-8859-1?Q?+PIt2EK4mXzn+JeGkPUqdGcDbOaANj65yXWgbo/cFHMDws8gDTd2VldCcI?=
 =?iso-8859-1?Q?awpu0Zw9S42X7qLlQylI1GKwPFAdORdHiImgSvh5fLgiI4PIEKbVmoHDhn?=
 =?iso-8859-1?Q?fq6EEKec2hXxX5czGrzzsjO0VNYf3XTR4WhukDteuy8dxXSu7AEGq8IsUZ?=
 =?iso-8859-1?Q?4Gvge2jR2vOpo5ldmf0HJorZgwqSExtVcud8yveG/sXP/Swyoy2iazQWCV?=
 =?iso-8859-1?Q?5XVgWsYUJ8YtOmzio3jZYgMOh5LzcBcDygqA9YfEFnt2dtnT7atlGLf6mA?=
 =?iso-8859-1?Q?mMKycxfGoXlm2NX3yzFACNl+C2RFI3zZse2XzwOOYtTVtGfa3dPMHgxdx1?=
 =?iso-8859-1?Q?ol1VhzE8gxowgeBxEz4xel99jIv61qtS2RgSKoqdmU8OBQmkjpgIinhkDG?=
 =?iso-8859-1?Q?WgT+cmYJfBINYG4uddC8Ok1qehR+K6/T9Q9ReyxwOmhvSYukkaIIorbnU7?=
 =?iso-8859-1?Q?TdkT0FoSvt3WzsRJKsbfyo/O7+MZAVsJDrCfO0oXrWqCDUw9qqmkTof4B2?=
 =?iso-8859-1?Q?TwriDTh6mooU5opgQzqT+iZtiSIJYtCp2WkdppKeBXBgk1FQp0yNDrucXk?=
 =?iso-8859-1?Q?BHP1nYiKYzEQOe8GZYX/YNnvtUzKyMjSlT1Ofg7rJfAgXAdx7V/kEhj+2a?=
 =?iso-8859-1?Q?O2f0wb8e84Bod31TNVIBj9sZlICW1T3ZbhLn3L7Cg9aNEL26etRS/GITme?=
 =?iso-8859-1?Q?zubOJhS2eALvrBTL8eHC/n/yPud/O7b+0v89rkT/SVvWuiyHGwtr7FiiP4?=
 =?iso-8859-1?Q?wEUZ/dugmxDnJp8CqiPddEzDJy1XdXjDBVr6sbZJZgos7la5o7idWVgO+b?=
 =?iso-8859-1?Q?73i7KquvlHDt8h1LZTe3EpEyxngisQMimF?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e47d0e-dcda-4dc3-91b0-08dcc5e17d21
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:12:23.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p67/ACCuQVruJ31Z1xv3q5Mmicv+Oz1a0WyjXusrT0XCav7fgtFxh6ctwpRUnFkr2S/RJTNkWw3NQxFrFVZlZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7467
X-Proofpoint-ORIG-GUID: bwlm9NujwH_pu7Apea_baaOvmUvD2-72
X-Proofpoint-GUID: bwlm9NujwH_pu7Apea_baaOvmUvD2-72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408260116

On Friday 23 August 2024 15:15:20 CEST A. Sverdlin wrote:
>=20
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> RSN IE missing in beacon is normal in open networks.
> Avoid returning -ENODEV in this case.
>=20
> Steps to reproduce:
>=20
> $ cat /etc/wpa_supplicant.conf
> network=3D{
>         ssid=3D"testNet"
>         mode=3D2
>         key_mgmt=3DNONE
> }
>=20
> $ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
> nl80211: Beacon set failed: -22 (Invalid argument)
> Failed to set beacon parameters
> Interface initialization failed
> wlan0: interface state UNINITIALIZED->DISABLED
> wlan0: AP-DISABLED
> wlan0: Unable to setup interface.
> Failed to initialize AP interface
>=20
> After the change:
>=20
> $ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
> Successfully initialized wpa_supplicant
> wlan0: interface state UNINITIALIZED->ENABLED
> wlan0: AP-ENABLED

Good catch, thank you.

>=20
> Cc: stable@vger.kernel.org
> Fixes: fe0a7776d4d1 ("wifi: wfx: fix possible NULL pointer dereference in=
 wfx_set_mfp_ap()")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/wireless/silabs/wfx/sta.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless=
/silabs/wfx/sta.c
> index 216d43c8bd6e..7c04810dbf3d 100644
> --- a/drivers/net/wireless/silabs/wfx/sta.c
> +++ b/drivers/net/wireless/silabs/wfx/sta.c
> @@ -352,8 +352,11 @@ static int wfx_set_mfp_ap(struct wfx_vif *wvif)
>=20
>         ptr =3D (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffse=
t,
>                                       skb->len - ieoffset);
> -       if (unlikely(!ptr))
> +       if (!ptr) {
> +               /* No RSN IE is fine in open networks */
> +               ret =3D 0;
>                 goto free_skb;
> +       }
>=20
>         ptr +=3D pairwise_cipher_suite_count_offset;
>         if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))

wfx_hif_set_mfp() is no more called when open network is started. Normally,
wfx_hif_reset() is sufficient to avoid any side effect with previous calls
to wfx_hif_set_mfp().

However, if you don't mind, I would prefer to call wfx_hif_set_mfp() in all
cases.

--=20
J=E9r=F4me Pouiller



