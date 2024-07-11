Return-Path: <linux-wireless+bounces-10187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC892EC04
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA8B220D1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC88479;
	Thu, 11 Jul 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peratonlabs.com header.i=@peratonlabs.com header.b="KQgNX6AC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00317001.pphosted.com (mx0b-00317001.pphosted.com [148.163.142.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756328FF
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.142.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713327; cv=fail; b=aysYFr4fDnRKP5r71F4xqa55UugCZ6MFeexfB9tcdHDSB9JgVQbNBVYtXCyfJrbz8sHZQNq/SNnQrDj7ycodXFXCvSqERlOhfT5KOVsv9BdLqN4Bg5Mb5X3BlQVD5ZuPpTC4iWPHsphDuSPbFTBB+YX6tMUNQIXKSiRZ3NHXv9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713327; c=relaxed/simple;
	bh=zftY34d3RTY0zSdgSWWxF1o/wCGBaRan1ahq8V4AQIQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYu6/e0JfWuLPS10F72WrvCK2OLmig2xw5dlbOZF2Bx1jeub6agMYrDS+12+F9jw0HdKkde1YLkEIgUewG/SYEgLDvXsxOdX4oYZ1IREUMtwumoOeYxnnLVCey6HtmzaPoomnFdDdQP7x80zF4mVwG0bXbTcrOLtYHykfvdPDRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peratonlabs.com; spf=pass smtp.mailfrom=peratonlabs.com; dkim=pass (2048-bit key) header.d=peratonlabs.com header.i=@peratonlabs.com header.b=KQgNX6AC; arc=fail smtp.client-ip=148.163.142.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peratonlabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peratonlabs.com
Received: from pps.filterd (m0269586.ppops.net [127.0.0.1])
	by mx0a-00317001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B9dMTw012057;
	Thu, 11 Jul 2024 11:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peratonlabs.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	POD01092023PLABS; bh=JvnsgfHuyESR/0KNTCqZBwN+OpTGomNSQIXOk/gM1es
	=; b=KQgNX6AC+snUqUzU1uK1bF0E0fL/qZdYjezG90kd5t8rVb+4+fOABskuqad
	D1N8MigoRnVN4zUmzouw1DUhMHrCy6bjkEhvMMBTA20abjeqHnkqKyr9K4SY/sVR
	YFKlcfyziToaxgvjvPQYxQlb7IpKg8jNurg2W38f7CHhns22w8LWOSQxCmooJOls
	7Yhi5b7SPmMgl6IA/4WfAg/mfjF2rSnbTaZNE24Jooy7vzCb3ZCyVu2H+139Khgq
	B7mhR8HWF/Jn0Uvkpqccrn++Oe0DjZMxMrbhV/vi3/d/GETYIAkvKSxcOCE1OOdp
	zoWFh0sKF1n2QV5cfeCX4G1fl3Q==
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0147.outbound.protection.office365.us [23.103.199.147])
	by mx0a-00317001.pphosted.com (PPS) with ESMTPS id 406y89sdj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:02:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=pTMj63TSL42m9iqOyLmtU1iiq5bxOdTTDZ3REI6kBZ7uvuFEdT0Z2bkq3fmMui6zYZT/QiQFpoXAAe9dNwlAhzYpORB0tIc4x/z2aTs6UVKrQP7rEYHOt7f0EgiIPZKZqTROuh8/2vWhjw3xu3G5dJCGnI1UOXJFuhDjnuQUGttpB1o3PkoTZPXRYs/ce7W7Doq6Chm2ACtF1qub/JFboYTkYMkPVHHdvAVMvj6vcmY/UvAggsgUjMQQN3AEXDPQuB9lM91rWk7T5jR6uC2DshlSpV5Sgwv9GkgptAlDcA90fmGom9EXXYLHqhriw5Kuo3/qv8g0YAcWgexB2IeESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvnsgfHuyESR/0KNTCqZBwN+OpTGomNSQIXOk/gM1es=;
 b=om2rTOtHpFw/mPdrBf3mAtjmGfco8Z9V3d0FCqm6T2DLSYlmhqpgqkASPmuPt7AMRmtvVhk89rgMi8+fokIk5Yr8UwMIgjbpaNfrDbZQ9mlfy8IQ6SJgtvFk8VuKGJZaKKZS+COIMvtaRsqdXf53txffTYEGYuaZcIzIaojMP5eOPlMTU9900kTYUx5iek5eGRI4gt3JrevreUr3L3q9YJFTEalJK7LPNw2UHodxMW0UoydO5LfzjPRud7qTclEsHWqNSS49BHUKrl/k1Od4w3sIWJ6MfIQSESQZl81yZhxrvkBbcg2mB6599fLbSMVLhR7qagyzU5UkmBXh8Jx1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peratonlabs.com; dmarc=pass action=none
 header.from=peratonlabs.com; dkim=pass header.d=peratonlabs.com; arc=none
Received: from BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:181::22)
 by BN0P110MB1749.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.41; Thu, 11 Jul
 2024 15:02:35 +0000
Received: from BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM
 ([fe80::52a7:a01d:d3bb:c767]) by BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM
 ([fe80::52a7:a01d:d3bb:c767%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 15:02:35 +0000
From: "Youzwak, Jason A (PERATON LABS)" <jyouzwak@peratonlabs.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Adding EPCS Support
Thread-Topic: [EXTERNAL] Re: Adding EPCS Support
Thread-Index: AQHay/c/68w81c+Vn0q7oPfEApoewbHkpQAAgAm6AVo=
Date: Thu, 11 Jul 2024 15:02:35 +0000
Message-ID: 
 <BN0P110MB1210C5105D4A937AB7526123D4DBA@BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM>
References: 
 <BN0P110MB12102BF7BDD2D28E95373DD9D4D3A@BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM>
 <983953af2a1e68031435c18dc12fedb0c2d82c9b.camel@sipsolutions.net>
In-Reply-To: <983953af2a1e68031435c18dc12fedb0c2d82c9b.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_Enabled=True;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_SiteId=2a6ae295-f13d-4948-ba78-332742ce9097;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_SetDate=2024-07-11T15:02:35.204Z;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_Name=Unrestricted;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_ContentBits=0;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB1210:EE_|BN0P110MB1749:EE_
x-ms-office365-filtering-correlation-id: deaca5c9-6ee2-444c-64ba-08dca1ba7f7f
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?pA8aOULDNK+mOCIWCno94c9SNNT4mCCAKILAgl4cnQ2ciMyh/8CpK2kY8k?=
 =?iso-8859-1?Q?Fmtq8PtenapFFF6tzNvCkqZP0c2FSAJS3QirpGdW6n3fdSX1ZBlZKk01eX?=
 =?iso-8859-1?Q?ICJHJnlwhNtt6VvwtdNwRbwu6N6LJw8V7AYt00R1BaHHmC89d5leovDZnD?=
 =?iso-8859-1?Q?IQI6qqE0WvDBkkUmEr58wd2oM7q6hZlKEctxlUMB+4DWjuBpZb2hvBFKiu?=
 =?iso-8859-1?Q?Nircf7x8N8TPsw9hGMaXQIVFHitnE0ZScNH8iuRVD+4JczZlLgkcH/ofF0?=
 =?iso-8859-1?Q?1gCdiuUdUFCyfWwyH9pHCz/BjLkzML05xC1pWPqhMJ9dX6dhxgOGLP7GUq?=
 =?iso-8859-1?Q?eNWcO1Fyd97k0awdw9H3X3JFXRypADpZ70W++43hUrUfNlFOjFPcp5NH3p?=
 =?iso-8859-1?Q?YRKQigDSFf1E76MRZKw7jHAWnZtm/azCzczbSca013gdL2PX0oFqDTI7Mz?=
 =?iso-8859-1?Q?+mK3DAqAdoxS9wWS7RWA4BpfUcWE5Mq+iuI3v0wU7Cf8a4/ZXZm44uy1qB?=
 =?iso-8859-1?Q?6hJ4rGpxiVsUjqLHtzbDjhjMUwiOkFsZY9MCs1BYbBrlc6Kxe02c7gKod2?=
 =?iso-8859-1?Q?vFcCu7sA61UFM/GXBvzC0R1EbE7cWsI6ymssJvmherbUG/uRYGFfMiTtxI?=
 =?iso-8859-1?Q?WjBFMwZimCiA0RRcvynFq9mVHhxZipbZdX0F+s65JQ6J16vamJglozaQTR?=
 =?iso-8859-1?Q?nmeaGyWLt8BnArdxaAW01WFX2DJTlMGpEQFtT6BvAVD30dtTDFN+TG1Bor?=
 =?iso-8859-1?Q?5An4cinQGyYBPSIIjY4aH6jngH9FQKaJ9NrUCVjXibiKgkiOdKpv0d9GqW?=
 =?iso-8859-1?Q?/N3u6SeXGgc09GppGoLdWt8ZiLTGm8DgOkZqRmwolKpk+2Uqz+YSl0GDmR?=
 =?iso-8859-1?Q?rwHgWb4QnUWSJbh3o0MAcMeyJTeCgnfvRuAspWODIdszUif7A4oqrvepP8?=
 =?iso-8859-1?Q?21xfHH0/2sB84UKOE1Q6aF7HEskvLDIswwpIcIbL+7tHo+adHdzbPwG/3U?=
 =?iso-8859-1?Q?dvXQL0BM25UV1bkd06F/2J9d/xX87tCQIfE0KtEbcnw2g1RPqh1TCcaic/?=
 =?iso-8859-1?Q?1JX4aMwSzrcIKJcsNYOGVlnFHXJ7BlmGn4ChyVSKhPYmrPECUOVjvhKYry?=
 =?iso-8859-1?Q?6pFolpvhC12wa2EVLNRLAKD9i5YkREUAuT2Njs4nxYU87tO3aVw1kClnvM?=
 =?iso-8859-1?Q?8qOlLBmEoXX+iH6gjQ4y4H1qsnYbWirNsXuw/lDuMhos34Rgs7IDzEJTay?=
 =?iso-8859-1?Q?utfRC/Io7IQrz/5pmE/ZbxInJ0YYf4YFVdnwiy84CYnWRj6KYGr32N864Y?=
 =?iso-8859-1?Q?+3UbD1sIhhyFo03ITPDWln2K5ss4MjZGbsPMgNaGjd9ylFY5gRZWeDuNKT?=
 =?iso-8859-1?Q?YOjmLuEKJCJwxUyjZ3WOFOobRfpovFJDRZMJwcDRYKuc/Y9kbflA196wKb?=
 =?iso-8859-1?Q?HlG2lJTDxO8HPUj6YnVvVAHa6M7mdzxURjJkRQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?OHMGYulN2d7/gkfCLaamGnq3kixKLNowH0lTT0/PmqAB9N1RVwII4owoNG?=
 =?iso-8859-1?Q?C9lM9b2/xr1mDdhs5mVkwO2zDxRftTdNsMCcE3MhJKUupAzCj4Kcch2XW6?=
 =?iso-8859-1?Q?tTl1n6732Gn71GmFJGpXPdXUDRUxjzN3t53mETsSrgqBuz5InPndRwWk/e?=
 =?iso-8859-1?Q?DnCyPSOwO0b2w1VDAgfi7br2nfdMCB/jDDUpEryp0+KJYo6HzAz0tC+J2t?=
 =?iso-8859-1?Q?1SSJfZRO6cl/+PDepMxf7J3B0VY15DeaXusLYqYFfr0Nv/uxJq93UOvjhP?=
 =?iso-8859-1?Q?KC5XJ9a7w5XtOOrlunI95P/mj8jiY13IHApxXM2NPJNcYOOev9Xu90Cpy4?=
 =?iso-8859-1?Q?JsUEIUIP6yAI74p/eebKI0jUUh0FdIvbb1pZ+BklYR7RNsgLFouHp70cYw?=
 =?iso-8859-1?Q?acuMQH7aU++MGJwmh7A8+Zkq2r5/Mw9rkGtyyGKxG3aKTABKxvsoxVMbPb?=
 =?iso-8859-1?Q?XNtZkR0UnhNILclU9H7RlqqTDVBeCSbyGbHuZktV8ES/rDSBd2LTPU0Nqb?=
 =?iso-8859-1?Q?uuR7yMgcOFSnxSrTdh+E1dAXn6MM0eOd7QaDeiorTc6edMJzUciNWZL/rF?=
 =?iso-8859-1?Q?8w7dM7KzY5XXPhbqAD34Quh3NHwVnK4bnfsZ8iAJzjPhB56vJNv1PSgBAf?=
 =?iso-8859-1?Q?2ik7X/RmTvH9sLAvP4BBlcZJHe+TimRr6ZxJdtDBrIn+/e2TnEXLnMS8Oc?=
 =?iso-8859-1?Q?JOmjbnyQSPbbyH/+SjwB5Gzz5HScS3uAIYbWRPjqhe7XWOKaLRMz52M0kK?=
 =?iso-8859-1?Q?CWlKTH+6FNLRb/XjEYM+HL+jio3RkPouiu1s8CTM3qSFJlA09hG6ly4KYS?=
 =?iso-8859-1?Q?i5fpgX2gH595CfjDPN+RIBxC9sg8mHp72lniFe+5xeOFy1HCWO5aaIqYb/?=
 =?iso-8859-1?Q?9Dpce1CrAamfxfgkJYEdWLHl7qbWEhlhIEgRAlbwyu7XN1CgFolJF+T7jA?=
 =?iso-8859-1?Q?h7ArksTjxLX0PbVVEXRXWX38ePWn9x4Igak29Q+lNIWLJ+17JwT8xGkdP9?=
 =?iso-8859-1?Q?z3UFE0VW1ka0VMfPgORjOcuawiN05GNDd1vLufS47S69M+om/wJt8BBQDC?=
 =?iso-8859-1?Q?NTEUe4VGopEAGExndXcWomv6z7MA3UtiRuW32FvN89MMu6C4Cx1lUAem39?=
 =?iso-8859-1?Q?Qdmvh7pvpdXmsa49WUTdN5Fv9EStPSy2OhAKrS0QVHo/5lzsLoTlso0M/R?=
 =?iso-8859-1?Q?Jfy0fwKT8zVBpIJdDkPR1+Qv18RehyCHUviiyF1Fpb7/7km3Tn097fMkL6?=
 =?iso-8859-1?Q?jumW0D3wNKOA5EBWm97A/rtKHMGoLSb6WCNVmx8CkvxTJB7aKntcE6ALma?=
 =?iso-8859-1?Q?KpfCUWNH/2EQIFYfOvNW7SUvLGdA3nAgbv16KMUuh3mCtTqQ/wVvjgsjXO?=
 =?iso-8859-1?Q?X9HNdvVBonhZnI0mjgCGoQBKCS4gUzbycDwNIdkGURroenmI3/yn/bPTVM?=
 =?iso-8859-1?Q?GQ7SuZZTaIIDY9AjOYLh8bQ64VqZk59y0phXwQoAwN8QSiu9vrGxKL8+12?=
 =?iso-8859-1?Q?JACVL7b4VbS2ZEDy6DUg/tptcjfaZyAtRPc2iIvFyaq8F6xoLXJ19502BO?=
 =?iso-8859-1?Q?k1YozPo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: peratonlabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: deaca5c9-6ee2-444c-64ba-08dca1ba7f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 15:02:35.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a6ae295-f13d-4948-ba78-332742ce9097
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1749
X-Authority-Analysis: v=2.4 cv=WeReaFhX c=1 sm=1 tr=0 ts=668ff40c cx=c_pps a=k8mYSDI7M9VEM0DbuZd2wg==:117 a=k8mYSDI7M9VEM0DbuZd2wg==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=4kmOji7k6h8A:10 a=HFUoU3P_DP0A:10
 a=DQLf7ZpYAAAA:8 a=wtZ8IkhoYxK8IEOm6jIA:9 a=wPNLvfGTeEIA:10 a=PoDYJoyJVVIA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=_JB4AwcHRRb8W-bhvxYA:22
X-Proofpoint-ORIG-GUID: oDzMzBgJlohkZ7T0jl42bx2Gaq0iMe8J
X-Proofpoint-GUID: oDzMzBgJlohkZ7T0jl42bx2Gaq0iMe8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 mlxlogscore=637
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2406140001
 definitions=main-2407110107

Johannes,=0A=
=0A=
Thank you for your feedback.  Our intention is to implement the changes our=
selves.  I apologize if it appeared otherwise; we are not seeking someone e=
lse to implement the changes, but rather making sure that we are on the rig=
ht track.=0A=
=0A=
Thanks for confirming that kernel module changes will likely be necessary t=
o apply EDCA parameters from userspace.  I intend to build a user-mode Linu=
x kernel for further debugging and add checks for NULL, following your advi=
ce.  Additionally, I have been utilizing the "nlmon" interface for debuggin=
g purposes (https://jvns.ca/blog/2017/09/03/debugging-netlink-requests/) .=
=0A=
=0A=
The code snippet I gave was just a primary attempt.  When calling the NL802=
11_CMD_EPCS_ENABLE, we will need to include the link_id and EDCA settings a=
s parameters.  We plan to use NL80211_ATTR_WIPHY_TXQ_PARAMS per your sugges=
tion.=0A=
=0A=
Thanks again,=0A=
Jason=0A=

