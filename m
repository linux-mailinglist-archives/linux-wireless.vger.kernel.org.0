Return-Path: <linux-wireless+bounces-30319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB34CF09AC
	for <lists+linux-wireless@lfdr.de>; Sun, 04 Jan 2026 05:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C57300CBB4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jan 2026 04:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431523536B;
	Sun,  4 Jan 2026 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sPhKnLaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742779443;
	Sun,  4 Jan 2026 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767501771; cv=fail; b=bsxp0d/3TF6mpHwZuNcMG3S9zLXbT0kkeDAtcFREMxMd3+U1Z0HWDPVT3GesjMGs+fnmGyb95zCWEU7IPFmNr0sgNfH6AwENkPtgye2I5BKupMyAUc4q46z2VkAFPmZX5mEDsrLUdROZwm8ie1XUW4yDa/Y0UP5UaHkYyDqcrno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767501771; c=relaxed/simple;
	bh=svojLVeUGnUJyCxLWy7riemi9adYzw4L/eRdV7/oj+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCkW1GQzQsjGqxWjLZaF8rzsFOc18QCqZlWig+ynKxzuRdKrujkbO1lte9D4YiK56kBHqw18osvzBNIsgBu3PI1tsI4N+1OgcW3xIMtbZxHO9XIieBknQLSzJ83UKgUhCaL2/d0ewzSG1uS32Vj/QB7pwZiUnLzj60DNS3X7GkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sPhKnLaJ; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA4c6m9Wn2cEbGlDchBvbGeDLVplEByIxjMPPdrOJIsWyjTgNJTCaKTHEWyLABmyJLa34vzffv5Y6ns74gU4X/RtrmT78mmZGRjW0Hw2N6BqZgn5DQLoKmOsOxHWj3ftxpwLhI0XYYTnGlX5Y8OO5IQjJPt5qYNABZsJ+m4oSLEpvrQxQ44lj+dF4cj0Hd5vo2FKxGNOE3DkbLZlb1NaNb3lPu7P0W8h9iQjRiGw+SKtCXMzFpdHYxq+WEoGmgoF6IgRv+MNt2zLeyNWRKs1V2mq5Th5piEdJWUsT/9zeLTEOv8DOYz+exq1ydUnMPbKWDAMwNbAPk73hmgG6YHMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWCj2njxckuL4Shk+dAOQKSldRxc6dfyF9FtTYiPjGo=;
 b=WNM2XfvZotDE2yR/VrgC8p4QgBZ4QRDpNdWPJDa1Owi1Mk8gO1meMXPbBV/t+Q5TgVD8OV3uCfrYIIImoBmCcb7P0HvITUFv0s5axqJw5k45Jo8FqSmlH2sH8LhVFBk+AThfcdEPgPjn+CdLS5teXUf0az2C/E7nrnI8l7mQaqc8RrU6Xu3OHWYCpt1GWlaXy18F6BeNP7kHKVR4I6yy9E5fNx4fLVTbQ0wcuVyfSwGq4sBHmH1DbLOUtsP94IaCdxezs8vJSLVmWcBAIoFWFotgrqcKowayA9rFTMZvEbT+9WV7LOvUGlRWsxZeEwV7tE0rmbiooOYDTueWIHZZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWCj2njxckuL4Shk+dAOQKSldRxc6dfyF9FtTYiPjGo=;
 b=sPhKnLaJrQUn8uP3fjqESvLmDNaFFr92CcAFsRgM0TVYxqpDoTfeG+Z1l7aw5jA+loXUQ8azk+5J3y0fZf3OhXvApLtzJMh5qzRa/E2DN594mHzWkt2R/8+4UBb4Bg0QJOOgZrWFHcWVL2E0RTkL9hlDJXWvjxEYz0g0ZkaMSUWV+FeSoaD80zV3fFplfyA/tF/GIAMzoYnoE+F9XWJJbXfZzUdIJf36B3nZ1583qKMtG2lskaidmKgGvUxOR7335j9KsAzWSMfmgTO6q0Xi5YhILQbcdo8h6moEJ5wEm1K4Jo4oAQA10tYUSrBxaD5/k/TeJnfK+EsWkxYyIaBFmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 04:42:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 04:42:42 +0000
Message-ID: <c92ccb99-3766-46d3-8a8a-1e8a6cb79d07@nvidia.com>
Date: Sat, 3 Jan 2026 23:42:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] RCU stall in mac80211_hwsim during clone() syscall on
 6.18.0
To: =?UTF-8?B?546L5b+X?= <wangzhi_xd@stu.xidian.edu.cn>,
 linux-wireless@vger.kernel.org
Cc: paulmck@kernel.org, johannes@sipsolutions.net,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Benjamin Berg <benjamin@sipsolutions.net>
References: <37b368f9.92b3.19b87161d5b.Coremail.wangzhi_xd@stu.xidian.edu.cn>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <37b368f9.92b3.19b87161d5b.Coremail.wangzhi_xd@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0448.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a49b9d-d529-4083-b5fd-08de4b4bb2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y09xZkdPS0VlcTNHTVRyd3dDWlpZMUh2YnlpVzZ6M1BlcW9UOFlQSml3UE9y?=
 =?utf-8?B?MHNZc0NoOUExTk4yR1lzeVJ0alFPenpkbWtwRG5LV2NPUUpHc1pyNkZVOTk2?=
 =?utf-8?B?NTFaUkN2TktMOSt5bkUvKzBwM3k0aHNvalMzeGpXY3hDaXdEWW83Z0JSemNl?=
 =?utf-8?B?am1TUHpiZXNwUER5dTNLSldzL1V1cHowcVF0NUFHMlZ5ZHZuUjFuaUxOcnBQ?=
 =?utf-8?B?TFlZRGFMZlZVOEZ3R3lqOTFseUo4YmZQMnJsR200UTlNZzltWjc5aHVrOHJZ?=
 =?utf-8?B?QWkzV1Rxc3JpMEduVEFPVHJMTzE1WTV6bUtCdW1QbThkVXlWeW5OOS95d1Rz?=
 =?utf-8?B?NTZZMk1sMGVFVS9QUFFEck9ldnpGR2FjdXJ2SWRjL00wa1QwekJCM2hybmF1?=
 =?utf-8?B?UVEzRktKOXBrTm1aZmk3UWc1WjFFY3JFcE1Tcm83L1VBK0YrQ09hZ0FKQkhq?=
 =?utf-8?B?cDR4bGZCMEtiUDYzSzlLdC8yTkprSGlMZndSOEhQaWVRYVZlNktvQjNZZHYv?=
 =?utf-8?B?ZzVyY1A2OUtJRHozNitZMnJYQm5GWEszTXMvNDFMWWR5blNjT0tMZ3BSYUNi?=
 =?utf-8?B?aE5udWUxazYwdGc5L1J1RGFsTktsT0g5a2N5eklhclRadG0vNytNblBDRHJx?=
 =?utf-8?B?Yjg2U3F1SU9KYmtVcXhLcVoveXozUzMzRzZSVFh3VitFblk3SmhwWFBFRVlJ?=
 =?utf-8?B?TTRTTnpjUm5Sd1hBSmFIMHdYRjNwbjFieVFIRS8wTElnSEFyUEl6UWRLTjln?=
 =?utf-8?B?K0dueGdzUmgvejdVRjNQcm9uUkpHT2o2blgzdzBOdklsTExZaFZoRXdGeXZT?=
 =?utf-8?B?VWFPeFVqMUVaMWNOdUowRDN2RzZvMGtsazd0Wm9lSThGak1keGhtbGI5Z1hR?=
 =?utf-8?B?OXhRQ0NpanJnMzZlbnBNU3FNdjZsN2pqODFQSVVCVEVJNUxqTHdIN0VPdThG?=
 =?utf-8?B?NCtWNHVUK0Z5bXk3UWRmanUxbkhiREpuRFh3QVVYcXQrZllCTmdzU2N6S0xH?=
 =?utf-8?B?WE8vTWdpVG9ucko0eEVIbUJaU0wrTE9TMUdIZXgwaU0xeDhFbEtWUGVOa2VO?=
 =?utf-8?B?ZlZnWGhGanVkS0k3NGk5VFl2clI3M0JFcG5pZ1JFa1QyZzBpaHp6dnNhdWg1?=
 =?utf-8?B?UnRxTU0rMlRWOHhLR1hWRW9HY2xldm5rVjRIWWtOSS83SktJMldEUXYwZ2ov?=
 =?utf-8?B?TUZzN2dpWEN3ZnpmQXZ1bEpoZWtkUHZRYXlIbUVUeHRFcXZKOXZ5ZkczRmpH?=
 =?utf-8?B?YXBJOE5xaXVnb0pNS2JyMlFTc0xKdERIY254dWNXalU5cndSbm5MRXRJdm41?=
 =?utf-8?B?YitmQjl1U2sxR0JtN200aG52MmtKZkNSb2tKemE5aUM3TEZMV2taSUxhYVQ4?=
 =?utf-8?B?Q1BCMjA2aG5KaUFKaUw5K0tJU2NmL2Z4RGtmUTJLZzBrek1WWk9YcnpNaGJC?=
 =?utf-8?B?NngrY2dmZWRmL3Y3R2xPREFTUDhqeWx1dGQ4enZ4dHh6UHRZbE5QR2l6Wm9Z?=
 =?utf-8?B?eDArUElQRkUxWDc2R1VUTm5yMDBueW9iTC9ycWplRHdhRGt0UXdFTG9Ia2N1?=
 =?utf-8?B?SXh6TUVJTkRBeWNodXQ2SWlvd2JJbVJIaVo4QnFHL0gyMldaYlhOQVdRYUM2?=
 =?utf-8?B?dGljSm5meFBxNlRFbVNEN1o0N1c2T29JK0lXZVBuaTRiMDFjdktBSTd5MkRQ?=
 =?utf-8?B?S1VlMGQ3d1BCcHZTc2VoemQ4blliZHRKWUJ6R3JvY0hJb25XaG9jSzJSVmFC?=
 =?utf-8?B?WmNxeHRKV3JpcWJ1Ri9GS012WWhzdHo5Uy9JV2d0aVZtaWUwS1gzRGhYVndD?=
 =?utf-8?B?MldXb01FOUpNeTlsVytsbTRwZ1RVN3FvdXo4UEgwRkNrSlFIcDhpOWx4MFJQ?=
 =?utf-8?B?M3g3ZTVFRWhZOW5INWlidjJHSTdEVEhsM3gyN3ErRHhMYURlK0wxRVBmMXl2?=
 =?utf-8?B?VkZlQ3NXK3ZPb1cvOThwTXpDN1pwN2E1QjNvNEdHYTZHOHp5S1gvQ1VzNmZB?=
 =?utf-8?B?S3hxaC9ia0pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3Y2NXR2WVZ3MnE3elZDTEh5Ynk4QVVNN1ZYdTh5M3lHT09WR3FPTnhBeG84?=
 =?utf-8?B?TXEraGExQnkzenNPQVRNb2RIUnN0Wk93bWduaWswNm15MHNMQTJacWtVQjk5?=
 =?utf-8?B?NzdYdS94SlAxVDlkUXMvOVg0NnpncXVKWjRhL3h4d0FWVlVlejFRT0ZTVEpw?=
 =?utf-8?B?MDNjcmxyaXN5R050ZDlLYTRZWENaQll3MEllMzRMbHI0L2o5YzlPazBHZzZm?=
 =?utf-8?B?bFdQc3hDaDN6amMxeXluaEJmUTMxVC9OMC9ORmdjQlVKUnBML204QXdudTAv?=
 =?utf-8?B?OU1Fenp3KzRGNUNkbTJUMXg5b1o2MTJsVmpTczczd09NRm9YU2RxUWFFSTUr?=
 =?utf-8?B?cXVMcmZLT1pVc3crVVFiTzJTL1Q5cmkvUTk0ODl0RHZyQmIrdkFCOXdGcUZR?=
 =?utf-8?B?aGZqcUlMK296a3RuWWw0M052ZzRhaURhdE9LRWNubkJzRXBwbFVKWWZ3ZGFz?=
 =?utf-8?B?elh2SUlhbXMwTWp0VG9ycW9VVzcrVkJOWlBzNzlSOThPa0Z3MTFnV0owS3ZE?=
 =?utf-8?B?UjVlRFY0THRnZUc4NXhXT2JzRWdlSEpxcGd2SGFmOXFMWG5pNjRqUk9UcDJ1?=
 =?utf-8?B?endLeWJ0cmRlazRaSnRkZ01VNG1GVUYwTEdqMHdyYkJ5MEZmb3h4cGlnWElS?=
 =?utf-8?B?emZEWHlZcEJWRzdMdnhIQjZCQldBL25Uc3hFaXdEVENHOVNtcWl0Tmw0cjJy?=
 =?utf-8?B?TXJrdXhhUW5rcHJjeG9ic2pFR2xxeDJHTzVpdWV4QnRPQnhwOTJDd1NLWXhT?=
 =?utf-8?B?MHloZThWQ2x3TEhlVytCRlhBamg3UGJnZXlWMTUvb1YxNjd2TUk0c0JXTW85?=
 =?utf-8?B?dlZ5M3BqdkNCZVIxbXhad1VjMXZhRzdVZUVKblJrRHZCbzJxdUdXcCtKSEho?=
 =?utf-8?B?RmFtUEVDUDFxemF2dUs1aFpDakt2SFFHL2FGTityQjk5Y2wva3Foemd5M2hr?=
 =?utf-8?B?eTJhV3cvSkRoczU0OHQ3eE4rV1lZdENZMi9DU091NVBJa1o1U1lCbklpSmdI?=
 =?utf-8?B?VnhTbnpSRld2SDd0d0pUTEI3dzI1b2V3N0lnRi9PS1MrMGJvZVlpTmxUaEFh?=
 =?utf-8?B?REpBTDlwU3d2eGxIZkhVQWJ6bCtLOUp0V3RYMENJTDhZbUZpWG5NQW1qVThy?=
 =?utf-8?B?b1gwT2Vsb2V3bVdSSmxnTWdjZDNHK2prRVF1MVZNbkZsMlNmYVBxTkUyWGlS?=
 =?utf-8?B?aFhiQjUrU2VVZ1dIK1VxckE0djlCbUJZMkU1MzN3VEpLaFRiSEZqOG5vaFZE?=
 =?utf-8?B?OGZZck1PYzhEa0FmbWZ0cjh2MjVpTTZNdEErRTJ2eXM3MnRVdHUrbXBobmVi?=
 =?utf-8?B?VEtwbDQrZnk2a2s3Nmo2ZWw1K1hveTRvR3BxVkF4aThPeTJONG9KMStFN09w?=
 =?utf-8?B?M1BpazlLN2FXUnkxVDhuMC9qYkttcXcxNjc2KzY1M3ZwMVRzdHBhM2dTWjFv?=
 =?utf-8?B?UEpzZ09LeTBod3k2SEQwc3RtSUh5NDlaRmxXT3ZYN2dhRU5LbWlsS0IwNy9R?=
 =?utf-8?B?Sk9Hd3M0NSs4MDgreThNZGlxYXJrcTF1c01uUWpVbXd4bTcwYXFoVGloWTl5?=
 =?utf-8?B?d2M2S0NMbHFlL1Z4a295c1VKVUxSellVVGI0RzVGMHdxRVRUcHhsa2RFZWUv?=
 =?utf-8?B?SUZkVldzUkJHKzUwRWIrc1I5U1c4alJhRXZKQTUzUENSYmpYME1aTDlNOTFV?=
 =?utf-8?B?aFJBTTlQUVpZWEcwTmVZYVloVDduSHpGSXYxdFJDcFlvU3lJYjB2RUo2YXpu?=
 =?utf-8?B?VHZxUU9KMzYrd1M1U0R2Wmx0Qmc1OUVrelZmSHhDSGNmSkZxNm1BYzdxcVZU?=
 =?utf-8?B?QUN4VnlkcC9SRlZ3ajFmTEVTYmc1Y2lZdXdjZ3ArTk4yd0lCWjAvcldLQkJQ?=
 =?utf-8?B?OEIxMWtiWFBNcGdhR1E0SFI0S0VLaDFpZnIwOFlyeENYN0l0eFJKNDFreTFk?=
 =?utf-8?B?dFZidjQ2VjNwODVscHRzaWZmODF0SUlOSXRiYWd6MVlmdVRxR0t4SWtzWXcw?=
 =?utf-8?B?SlNkRTF5dDZRK2JoTzhlRzFpNGp2dlIydWhqYmRGSGFqM0VnN1FXajFjQldl?=
 =?utf-8?B?dUhuNkxoUGRweUR2ZVBGUjR2MGl2Y3hqZWI1a21tV0xCQzliMWlzemlTb3Bu?=
 =?utf-8?B?eFBoNDVVUFVsTEFPOGpUN0wrZUlMZ0cyT05uQ1hTVjQrcU00dmJGbU91MGQ4?=
 =?utf-8?B?UGdmWVo3c09UMFdSLzJXRFUzQnR6Mno2ZmIrVURqWmsxMDJOc3B0WG5sbXJy?=
 =?utf-8?B?SjNqdmR1TkR6SW5YcjBacVd6Ynl5Ym1RaW1uUkFqV05TVXpVZ2c0SDdKVzFi?=
 =?utf-8?B?SWdpSm9wY2pvQk5xNnJUYU9oNzhXWmlDTm9EbS9aaTYyckhwMlZqdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a49b9d-d529-4083-b5fd-08de4b4bb2c4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 04:42:42.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ansabp6igMYV64TC0zFxDYJ5BrsUrIMcLQjT3vTiUTW9T4155S40rTDekPvmffVIKH7TY9gmnf0scvfstd81Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

On 1/3/2026 10:38 PM, 王志 wrote:
> Dear Developers,
> I am reporting an RCU CPU stall detected during fuzzing with Syzkaller on Linux 6.18.0-rc. 
> 
> Technical Summary: The stall occurs on CPU 0 while executing a clone syscall. The task was interrupted by a timer softirq which then invoked mac80211_hwsim_beacon. The trace shows it is stuck waiting for a spinlock in mac80211_hwsim_tx_frame_no_nl. 
> 
> Key Logs:
> RCU GP Starvation: 10509 jiffies
> Call Trace: native_queued_spin_lock_slowpath <- mac80211_hwsim_tx_frame_no_nl <- hrtimer_run_softirq
> Environment:
[...]
>  native_queued_spin_lock_slowpath+0xae/0x9c0
>  debug_spin_lock_before home/wmy/Fuzzer/third_tool/linux-6.18/kernel/locking/spinlock_debug.c:87 [inline]
>  do_raw_spin_lock+0x20d/0x2b0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/locking/spinlock_debug.c:115
>  mac80211_hwsim_tx_frame_no_nl.isra.0+0x6f1/0x12c0

This seems to be a case of softirq context acquiring a lock without
spin_lock_bh. That explains the stall.

A quick search on the mailing list showed this was fixed recently:
https://lore.kernel.org/all/20251128151537.0b4006217137.I688f8b19346e94c1f8de0cdadde072054d4b861c@changeid/

Can you try the patch and see if it fixes? Also CC'ing the author of the patch.

 - Joel



>  mac80211_hwsim_tx_frame+0x1ed/0x2a0
>  mac80211_hwsim_beacon_tx+0x56d/0x9e0
>  __iterate_interfaces+0x2e0/0x650 home/wmy/Fuzzer/third_tool/linux-6.18/net/mac80211/util.c:761
>  ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 home/wmy/Fuzzer/third_tool/linux-6.18/net/mac80211/util.c:797
>  mac80211_hwsim_beacon+0x105/0x1b0
>  __run_hrtimer home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1779 [inline]
>  __hrtimer_run_queues+0x1f5/0xb30 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1841
>  __hrtimer_get_next_event home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:578 [inline]
>  hrtimer_update_softirq_timer home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1193 [inline]
>  hrtimer_run_softirq+0x17f/0x350 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1861
>  _test_bit home/wmy/Fuzzer/third_tool/linux-6.18/include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>  cpumask_test_cpu home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/cpumask.h:646 [inline]
>  cpu_online home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/cpumask.h:1205 [inline]
>  trace_softirq_exit home/wmy/Fuzzer/third_tool/linux-6.18/include/trace/events/irq.h:142 [inline]
>  handle_softirqs+0x1d4/0x870 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/softirq.c:623
>  __irq_exit_rcu+0x109/0x170 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/include/asm/bitops.h:202
>  irq_exit_rcu+0x9/0x30 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/softirq.c:738
>  sysvec_apic_timer_interrupt+0xa8/0xc0 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/kernel/apic/apic.c:2145
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/include/asm/idtentry.h:697
> RIP: 0010:__sanitizer_cov_trace_pc+0x4b/0x80 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/kcov.c:217
> Code: 74 1d a9 00 00 0f 00 75 16 a9 00 00 f0 00 74 05 c3 cc cc cc cc 8b 82 7c 16 00 00 85 c0 75 05 e9 5b dc 89 09 8b 82 58 16 00 00 <83> f8 02 75 f0 48 8b 8a 60 16 00 00 8b 92 5c 16 00 00 48 8b 01 48
> RSP: 0018:ffffc90002d47698 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82075ed9
> RDX: ffff88802a758000 RSI: ffffffff82075ee7 RDI: 0000000000000007
> RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff940002a92c6
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0001549630
> R13: ffffea0001549600 R14: ffffea0001549618 R15: ffffea0001549600
>  copy_pte_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1284 [inline]
>  copy_pmd_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1390 [inline]
>  copy_pud_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1427 [inline]
>  copy_p4d_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1451 [inline]
>  copy_page_range+0x1c67/0x63a0 home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1539
>  rwsem_assert_held_write home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/rwsem.h:215 [inline]
>  mmap_assert_write_locked home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/mmap_lock.h:76 [inline]
>  vma_end_write_all home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/mmap_lock.h:347 [inline]
>  mmap_write_unlock home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/mmap_lock.h:354 [inline]
>  dup_mmap+0xd9e/0x20d0 home/wmy/Fuzzer/third_tool/linux-6.18/mm/mmap.c:1872
>  futex_init_task home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/futex.h:73 [inline]
>  copy_process+0x36ba/0x76c0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/fork.c:2230
>  kernel_clone+0xea/0x8b0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/fork.c:2609
>  __do_sys_clone+0xce/0x120 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/fork.c:2750
>  do_syscall_64+0xcb/0xfa0 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/entry/syscall_64.c:99
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f00649a6d07
> Code: 00 00 90 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
> RSP: 002b:00007ffe2d0a2b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f006575d680 RCX: 00007f00649a6d07
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000555572e6d7d0 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000032 R14: 00007ffe2d0a2d80 R15: 00000000000e717e
>  </TASK>
> rcu: rcu_preempt kthread starved for 10509 jiffies! g98817 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28520 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
> Call Trace:
>  <TASK>
>  sched_info_arrive home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/stats.h:267 [inline]
>  sched_info_switch home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/stats.h:330 [inline]
>  prepare_task_switch home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:5122 [inline]
>  context_switch home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:5272 [inline]
>  __schedule+0x1044/0x5bb0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:6929
>  __schedule_loop home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:7011 [inline]
>  schedule+0xe7/0x3a0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:7026
>  schedule_timeout+0x113/0x280 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/sleep_timeout.c:98
>  rcu_gp_fqs_check_wake home/wmy/Fuzzer/third_tool/linux-6.18/kernel/rcu/tree.c:2007 [inline]
>  rcu_gp_fqs_loop+0x18c/0xa00 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/rcu/tree.c:2083
>  rcu_gp_kthread+0x26f/0x370 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/rcu/tree.c:2280
>  kthread+0x3d0/0x780 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/kthread.c:463
>  ret_from_fork+0x676/0x7d0 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/kernel/process.c:195
>  ret_from_fork_asm+0x1a/0x30 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Best regards,
> Zhi Wang
> 
> 


