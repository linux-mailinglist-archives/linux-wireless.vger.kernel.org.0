Return-Path: <linux-wireless+bounces-22787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C22AB1302
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06B11BC5F80
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEC28ECE9;
	Fri,  9 May 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="cv4QUdwU";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="x6NhpINo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4084268C69
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792532; cv=fail; b=TWV/Q3lX8fByv0KtHu64C0NUWv4YvD6Sd8b1amH6FKsqAMe6IrU/ACztIIJOPNOS+LccHaVi6kEnwdB6JDHGCVdOYX10Ff10dg45xISDX4vo3XEifqTlEIlNkZyvHlz7ApnhMTR2c4sZffZA3ZBKvnNYS4TvO3rrDU7Rf8Q8h/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792532; c=relaxed/simple;
	bh=w5cv/GH7r0kmG+2kcOwdi4WKZ4vIuupn0F5Re37m/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BThcjUDoGHkUZA5sX/tkYEBm5JycpfqBaYGvB6+YLazi0AjKJaa1WqylgHQY0JQ/dtZLEOJsGo+qzr1hnP/niqxLdAdH2UlvEkVUtLJeQI7qNT2+UrlAcQSQnbTb+QcPW5P+nfDMFeQg+YNAuAz3JN1Q0JGPcJz2oYf0wVbJpHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=cv4QUdwU; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=x6NhpINo; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549Ak7e5019391;
	Fri, 9 May 2025 13:59:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=uAZw8IOthbJMcx9juHmzKhrl
	LNobW43O7WWvLTMa81g=; b=cv4QUdwURgfS4NuM3F1bMsq8jrT7+A2PoavIFdr/
	fdttvpjt99K6fCAAP+6FzEf5wWLo/xRpE/4tC6j1XlUrXuQIJFmyEbn4ATUpo48T
	xa/0igVbZt0WKlEMwKnP1RZvxzpR+7bYGE1SS98yMzF/nv0dT91EvhFBO2c30fLF
	u36cbklyQJBEApdVcskeQiMoK0ndoyG64gOSf0m7hNUbm9DDYYGRtVlEmuvkqxmM
	cfyXAyQzCY9jONNigUZnhkmNMw79IraZFdzOJDVLE4VQsukZF3AwQzG12gytt+Sg
	2lDP0R9WtEkHhBItEkoNNiSO4FwF1gSOgOpXtZCR8zqmYg==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46h4xd0n7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 13:59:42 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt4YVlSNfi4u8cV2b443LEppwV9iol3wt9ryk8wrMUJl9qIeOg5p7jNJjNTOetMRFZ1vFr7Bjbe06sqQCLNGuaZOOhMIN0pOKP1Cp+vGazIp9W8FH6p6w7z+gxnvAsFUEs++zmMEVI1n2gzQExr+XGO/D5eJIHB7fPNIwYKXZi7z1NYMxgB05Wf8j9s4O8WOuccA8kX5R+fr/ZGW7CKURyWlHnpkSvhOoSVB2dE8KGogEcCk35eDnBLeL1b5RCaE8d/s1XjbvO0YZ/nVMUuUQ2SAX9WkEsRUjbm+In0pidZPeBJU200nTMkExac1O537erGzvfek/4nvAP3+CRzyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAZw8IOthbJMcx9juHmzKhrlLNobW43O7WWvLTMa81g=;
 b=Z9N0oQeQ3gIzoJ/0BgmsujuX+aLuoEqFECqVaBPtjP4nsSjM5ajD47Nv4cFZcWONds5GKa79OUo+jc4ZePDXwtuhKx8yokjD/gW9ch2B/EWYgw5TUu09Qw7IM3zrPDz1r/osxrdFjJiwXxKbq8ebkdrUXHxvPwZuFrbLwvb99RwTdT6ZeaxmTWPUFNEg76P0BEkqHkht0voHgcnyAeCyjdKYd+n8PqrY1lTs+Eg+QH4xARUmW8O+JrWuSdRXg6nNjk/k0s5qwXYj1vHBeApZoEsgnscKnz8gLXdyMYHkQQKLfMqjo1ibBUDqDALddKoQbvwqi8/PZXo+sO9W7+KaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAZw8IOthbJMcx9juHmzKhrlLNobW43O7WWvLTMa81g=;
 b=x6NhpINoRrvRuVET5zfydlVz18P/c6TbL8VLzrFWHqNxfVpMdhS7hKLlkXxwSvKvl02JKw2v7rLLWH732RTP4l1/GzfmKP/fuxEN7z5p+iOgL5521d+nuuQC03yIH85v00FhJyhEzzV99BqL0tVBKVMRGjUdBf0PHG8OOKEo3tg=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by PR3P192MB0588.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 11:59:40 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8722.018; Fri, 9 May 2025
 11:59:40 +0000
Date: Fri, 9 May 2025 13:59:37 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: Question about TX power
Message-ID: <aB3uKfu3frLyJ/2c@FUE-ALEWI-WINX>
References: <aB3AK83USvOdTvDv@FUE-ALEWI-WINX>
 <73b2bd16-66aa-405c-acda-237d56be63dd@dd-wrt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b2bd16-66aa-405c-acda-237d56be63dd@dd-wrt.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV2PEPF0000756A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e8) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|PR3P192MB0588:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f732e2-bfc7-4468-0daa-08dd8ef0fa6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYW9i9NoZ5Ng4MGmghjmfHSIW/Y56V6+8ChvVekl4BffU3NxPWxenPkD1Ify?=
 =?us-ascii?Q?iwJt9MvdJlXQSbEs/6+WbzJ/w4cPgbY51Wm28JoYIwZOmxNJonR7AbJr3k9U?=
 =?us-ascii?Q?HM7q+lur6t38oB83G38Wrop7F08TlGhk+VP/Tv8MHOtVZ9I6mQonA1xOEBYy?=
 =?us-ascii?Q?nahuxi5Etyb+TzxRgJl4dgmzCuj+PURkWSAe4m/pdCy9C31VZytS3EqW04/0?=
 =?us-ascii?Q?uX5KZQdEAkF9zTmP378kSRzi+MhJgUOeqTTjczmWYFGnjiYd5NLtUuBg9fXX?=
 =?us-ascii?Q?lwIhKWaq440Nzc0q3Lf6OnC14mvrtWWFTXGWpYe7dZLZQLBZbNtP4RQu2cUC?=
 =?us-ascii?Q?lCkzBzO46NF7hg2LcCHv+NgWAtrCE6iknGhMuGDw1zcgVtjiwapzwJ5WKKog?=
 =?us-ascii?Q?PeSB+8lk87sgdxaUO5+m4kdkzpxhXjKafWwQcq3lr8Rw5i+SxVlw76uY9Mh7?=
 =?us-ascii?Q?W9i7s7VxVZ1N6udjrDz6LH4UV+gezWOj0aI20ezq3jmMQfRsn7UlTbXB0Qba?=
 =?us-ascii?Q?U5AhAXNdWlSRHhSYumsT+HozKjOH9/CEnoRNk/st4cHfg3co3aOoVY0w75yK?=
 =?us-ascii?Q?TjC1kKGjZIu9lmTfIDtmj1Rp5YYyb/Ukl+voRPLTIKAA05Iucz7OjmR2+0M2?=
 =?us-ascii?Q?R2aqEM8EgFgo+2sEg5xzUH/XHgedWB3appHpBmRwXMv0ZjSqaB7pDxMSEkIw?=
 =?us-ascii?Q?EzhJVSqFXl4dTw8QLyhXI21xpVqbvlRqlRPIKw6eEJ947b9fA0R/uAw7lxX4?=
 =?us-ascii?Q?44DHHVQCfw2lJt94lfjeW9ATmwiTDqS3ezsSymnyjQ15vH6gPVyL9VM4V3rZ?=
 =?us-ascii?Q?tOMhLTsNOB94oBQoSKIREFAKpQAaZoMp7pGkx1DqCroAJ6vqc49F0J3fcAuT?=
 =?us-ascii?Q?z6FC50fWkXFiRImNqbk8oY5pJrxzg+sTKdMTvqQnFtoOvA2sm2CC2qtYsfde?=
 =?us-ascii?Q?QEdxyq2SlQYVUUiT7UZjSrsg9ju3lTUWvElH9oVXbue/9z7qA8rbbjj6tlFV?=
 =?us-ascii?Q?PrLF+7u7aUAJnwBQyQKmFCgai9gzMO8RWYUsrFVmLD4U2NinMcW2MJKBrlQq?=
 =?us-ascii?Q?X5DIiSHcQ+uShcR4zr7g3j0k7LNO7tS8+qOz8n7cSyg/LpKAPIiEonTtlFcy?=
 =?us-ascii?Q?saCqaxEwIKSVgBD5nOeM8EoWGO6Pdj+DE04Zf/HOGCLgTMYSWmVSz/PPw4fr?=
 =?us-ascii?Q?0ODSDxEXH1cC0Q60BCxwbPf2ZCteTOCrcDtf/I+/1g4XIj2w89SJ3v+e05Fi?=
 =?us-ascii?Q?VIAa+eLcarrreceU2nl6lZF6WWDYKkwUemkRcaqhWSNjgkSNV5y9p0aJ3iSB?=
 =?us-ascii?Q?NeFeXJ04ZNRKQ7nVpPzS57EHQv2tskaR4tJYRJhjhqQ1hGCm9w58r+8H3dYA?=
 =?us-ascii?Q?2kWz2YDL3ltMMx6sFH7siJ29UyXWxqyuvBZndAlooydy0hX2raUrciYlKjlY?=
 =?us-ascii?Q?XVG3rIiJ+7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xw9jN8HiHZRMjXP+VcEhNdRQupSENy7a1Y9wowyWN9SlyJxriRIrm3vK+69n?=
 =?us-ascii?Q?i1a9xNPGTEYURpldlk2dIO//BvVP4XpQ7CoM5qLM7ryFNitgRFkkKhydpBu0?=
 =?us-ascii?Q?78uKDeWqww6URoGcDMbChZWEf43xW/zMgmV2tLCMb/taI8YzHiJQBu1w1JRm?=
 =?us-ascii?Q?bPBSUPm1ayT+QKXz2vU85HgpwB7XAk8rivCGJSFiLgYKrc/+HskQXf4rl9dP?=
 =?us-ascii?Q?xLVJlGkHlhugJEXDZbXSGDbIXMqXGkc74OfoRvtBsHMMIPa+9b09s57xam12?=
 =?us-ascii?Q?bGsPueIt5wyrK6b0yS/7IEQmWoE3odc5s+ETS4BKOGz1HAl60Sd83NBGKhY8?=
 =?us-ascii?Q?KAL2oMdtfsZXOknlUKTmO+vyPhbCznl6aqBjbrgLjjWL3sV99mwuieIFDNAC?=
 =?us-ascii?Q?UCzi9FjjQznN2TTQnpOwbsxO9QkS5lSRxbVkbdUZ/rKjORM8viZAeso2q1cJ?=
 =?us-ascii?Q?RyfbG2apkKjPVhpkfoIHiTN0odsuIApNVDjU0Ry2S1lemB9t6KYEnrT5erZh?=
 =?us-ascii?Q?ojJ5x/88c2/hUwr+t8oPLWmIWyB4JfSsCd1Gor4XZs2vXqL5p5+4i2yz6lfD?=
 =?us-ascii?Q?2AzBG13kOq8WuIsIibG7z4L01+Blyf8gal2J/oxsrYhKvdDgZ1GfA0ujW/vh?=
 =?us-ascii?Q?ftRP7HQpHkAvWPdILbiz54QIpdXiXSsl3grRssIQhzKIDouomb/q2kU7vMSN?=
 =?us-ascii?Q?WZVt4XturyNm2HAlXPvm73JzCFHoI1JsxHnzgoylDFl5sk4F4xfGb1tq0voc?=
 =?us-ascii?Q?BOXxSoY45O3wM0taE2eud0B8gEhXehMFP7/LJ5aW1bT6xNaKpUTNfNKWCItF?=
 =?us-ascii?Q?ypLh4CVPWQ8N7gfFyzPYogal0tLDRoebdQR2wUh9W+wdwo2MO+e4Vo9hFpST?=
 =?us-ascii?Q?euenNS/f60MHCX9quCMQFL0uiZvujdSgB11HLldJ8vdvwQ2HxWeQHHK0ekKT?=
 =?us-ascii?Q?FF5OLmF4bsrTUOdL+LccZ3of+a9jkAKL8oOPLtr/pYQxxlV2SH7Z8QCdjsOs?=
 =?us-ascii?Q?Emy769aBAba+1l0PBx/lF/VUEgTX6Vcfdrs6S2HYR8LKQKDZTbji6ogW6z6P?=
 =?us-ascii?Q?J9yriYLly1RiMv2NgMDFD8xDBeBR9aQnMK1VqTEP34hrASrtPfmlW/+JTCG3?=
 =?us-ascii?Q?aqDuI8Bi0gmn7PjyspYt9NUZLoojiDiqyKkizq0cH8pBtTsW7eQOIv8taXlz?=
 =?us-ascii?Q?1hBgmfbriLXyIRtou+reaqCoM7/QTWTAOBs+8B0vZXEuCnmMYf14U39wDdcV?=
 =?us-ascii?Q?6t1JBWC+hNHXUS7VfCEVJ0vlDTTqfVg3y+Vr0EhXkSO0YllukP0EoIj/fiWM?=
 =?us-ascii?Q?8q5Jm0rRi9Qtr++L1ucItyRy6xfLJE+CQsgHcNlFTs83HwHUJVa3wrxBAFf9?=
 =?us-ascii?Q?aa2pmE6xSlqAILZZUmJXa5L2UBaQ16nuIrymNff71e9j0qy5BlEbMwJSOXYt?=
 =?us-ascii?Q?Snsg4oTEbpbYvruvYTHB3A4ahebqs59yWshPD7FAJOyX8akIfTnV0KEBIcT+?=
 =?us-ascii?Q?xSfZZECHvu7JFmjnBGl0Ey/S8JlX8Hy48nLffPswMYVKEHW0a5m5WfhbkI00?=
 =?us-ascii?Q?FBPsGSMwKHcsb9pYccavjY94Xq1eOigRGTMo2umS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QjXu2NXjhCBjG9ofRWhjcEGM3Ljegat1YxxTvCJd3/4obiHwIHOKcqMUAXpQv692MQpD4GoDGLYdeh0p6pufE57q8c+TG7KNo3fb6lpFx93gcA/jIzT2q0T02leveLesvMwGeB7fyi6FF0zyjDsXNJ+9afEMwV9XKRSw9eykDYIe1FSG7yOG9gP/TdIw3rzE1ATuqgzjY/VZx5Fr73y1bvsqPq0FblzOO41+BsrPWx8RXxylMnTZ9c9pBH6HilQ6SLjTXUcv6nSNGW1s6uNIbdh4q/bwtNj8T4PTYajLuHIc6WrFOI1G5pLprgdBSxo0UGwzTu28FKBLFQGSRSe9w52A3SunHXVabP8JeBLohhZZRtOOhLRD3Y+6RXtQchMowIN7IE4c60XIGEIQR+Yypyu39TgKX0Nr85oNF97cGMmROxbQ7aoFzXTpxviyIGIitzeAqk++IoNg7ypzPei6pxV1JqUPanDrL1RWyUYXvlwRJwwno+z5B3EYBf73gmVO7+0t83ELpcbc806dLtQbVwh1oWmwNW3OpqxTkPG7tRB1GUE7vf248zAWlFqME6Z6QwHfYtWny8gkXKqMeOkQFBLwIXcVaNdyoOVGifTPg1f9XVqGJnxDE/hZIMd+Vjra
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f732e2-bfc7-4468-0daa-08dd8ef0fa6f
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:59:40.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UKXX1+LLtgLpB5vKuh/Dc7P3Nl9Zf7u+g++9gCyDyMiuKGL5puyi9vPDCeHtuDqXZ9WkVzxVjCB8dZo4IwEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0588
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
X-OrganizationHeadersPreserved: PR3P192MB0588.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExNiBTYWx0ZWRfX9pj+RccC7hWH 27ifbj23ShftY+bBwn4PkU5CMFwGX3dekadj4mL3kyFLc44lGivMSHADqMmx0Iy9YIrY5suRMY4 XUPTSE+RD9/v6Xg3lY827TI1wOQezVV0XOBXuLGAgeWJbAzwqSI+NzTaPWXr/neIYy9GAGm5/lT
 O36UpNL1GTSEuWkMgMxRAh033wpUZ7wJZ4jI48lCJOSzznmCGkUgwmGE9GfpxMc4DuTX0FypyOs V1cru+VRqA63R4NlRpewDPmb9ilp+KXmIVM+7Gz2FL5LeVERkTYL5WDpyURlZzzt0WBV+wi5fEJ JrvyQw4oPk0Vtgq2ebB/cBGNBMLhBryqvPu2FqocO3SGmpiP0dD3JqhV6KyE2QbyniSPBRaijmk
 D6CvaY3p+l3oNE/FDk89181kotC8mq6GT56X9tI8pyfGxd4AxRLYDejkVGQfUrrAvnBXvNEM
X-Proofpoint-GUID: 6kpObnMr5InPBxE28KCjzQnYOavzzg03
X-Proofpoint-ORIG-GUID: 6kpObnMr5InPBxE28KCjzQnYOavzzg03
X-Authority-Analysis: v=2.4 cv=RsTFLDmK c=1 sm=1 tr=0 ts=681dee2e cx=c_pps a=MBBEci2b1g52hIjBbyaGQw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=8gLI3H-aZtYA:10 a=B01c5VG4UlEyimFmcIYA:9 a=CjuIK1q_8ugA:10

Am Fri, May 09, 2025 at 12:54:47PM +0200 schrieb Sebastian Gottschall:
> 
> Am 09.05.2025 um 10:43 schrieb Alexander Wilhelm:
> > Hello devs,
> > 
> > I'd like to understand how TX power setting works on ath11k devices. For example
> > when I'm using channel 36 for ETSI based regulatory domain, I can set up to 23
> > dBm. But then I get only 20 dBm as a result. On different channels and/or
> > regulatory domains I get different reductions. I tried to follow the source
> > code. As far as I understood is that 'ath11k_mac_txpower_recalc' sets the
> > correct values and 'ath11k_mac_op_get_txpower' return the different one.
> > 
> > My question is where this reduction offset is encoded. Is it in the module's
> > firmware or is it part of the boardfile? Thank you in advance.
> > 
> > 
> > Best regards
> > Alexander Wilhelm
> 
> the boardfile contains chipset specific calibration data which also defines
> the hardware power limits (more specific data also included in the on board
> calibration flash of the device or if its a router, in flash memory of the
> router itself. in addition it includes a regulatory database which is used
> by the firmware for managing the total power. you have also to consider that
> the 23dbm are specified without antenna gain.
> so if the antenna gain is 3 dbm, you get 20 dbm in total. this antenna gain
> may again be specified in the boardfile.
> so you will not find your answers in any sourcecode. its all encoded in
> binary data.
> 
> Sebastian
> 

Alright, thank you Sebastian. Since I'm not using any calibration data on my
router/AP device, all data come from the boardfile. I've also understood that
the power limit reduction is related to antenna gain. I'll ask the radio module
manufacturer to create another boardfile for me that matches the required
antenna gain for my router/AP device.

Best regards
Alexander Wilhelm

