Return-Path: <linux-wireless+bounces-29081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7729C6811F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 08:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6BE14E1815
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B4285406;
	Tue, 18 Nov 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="d5VwVFmh";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="oaXMmKmx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9C27B4EB;
	Tue, 18 Nov 2025 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452265; cv=fail; b=DADGWqBubxTYs1mQl+MFj5CjeSYsaDPEgKmM4cLSvcKVB7XQj4mvuYPu7qlDbOEwf51zgmmwmMxB3bD55UF0lfXV7oJiermA/kCJm67lK8o9dxj9lNlWAE9aX2OaMIZ2sCLt2BnfC2ZXlFvigZBmQ/0vC6s1DnoazBPc80FRUtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452265; c=relaxed/simple;
	bh=yLUG7hkp/TJPgnIGpOQNMG5JCcr6pcAYDtRYvmyyg48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i3r7th/1g1GKAd+dK290tLILCmn6qLQGJeQMGDBnOZq4vQ+W5ohhINV54H3ZSemHORBTVLPbJe96bPSnoWl2tdJHc6+qIQ4ciMnBA0sVobiJINUJIis+JTGxBP0GdWHK46FPk/u8aYBpWsEiBIVMsiSnaecULfzFYcKRFM8wLwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=d5VwVFmh; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=oaXMmKmx; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI4xg4w1616082;
	Tue, 18 Nov 2025 08:21:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=DBboLab0AR8P5A6Cgs895W
	ft4Y5VWKqyrEnS3qGrpWM=; b=d5VwVFmh6oRBsxSFWKFqkP8BOzGT77s0cxHVMM
	PuhiNkJEArJgt00SriibpoDQDSriu2YDZsuOirVjve5DOLxS6dP7fduf13ibHrbK
	0d6oyx8NOchxRYaWGasMmQQXgDb12DOsHG8UApfdJfbPLgoGgiwt7BefA0OBkgmW
	9vd5ZuRvT6IbMeJuQNobjIWcErlOS8uNKq8kztQOkFhVSs8Y3BfZ4SEsVAjy7KUH
	fV3jFsto3+5MPGjn56IoS39Fq5eaNcuuYwyJxFIFsorHp82KtsxGAfWYCX4yTuU1
	DMyKPv+oOdRH2aXiBSo2/am4P3mS+whut291twYWm8aivwCA==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023072.outbound.protection.outlook.com [52.101.83.72])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4aeercawpn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 08:21:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTnuYprxbslTi3IB5/Kibh3OFyyPiQHjfvDI/iY5CkcIOFO/3dOZz3hI9UoqPHADAGeTDNdFeaMw9ux1OLfIeevZ0mqsFy1F13CUv8iyhMqVxwYnfyTtiJGfQbP1ZAlkxATarefsab3PNGlZLD3DCAP8cMTnHkHkNAHiYfRe/s7aSgFC1ivPKcn3mZ0KK79+5vTev0AKGkyyUmzA+PQc/wssqp4vTTH8vwfj6rXLLiHKeML6kZDgPNbhhnTFGLKQDqWDGdxoxydM5Mp32U2VcPfsfG2gPQpfdVxwqhxtlGhZQmysJ0/wRvp+OLE2+3lJQFz6sX3j0Rt6JJUbA5Pzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBboLab0AR8P5A6Cgs895Wft4Y5VWKqyrEnS3qGrpWM=;
 b=mkpoMawTG896OvFItBWtzIOB7IV+gZ9et9gcGfXqiGM/jeE8lReFiqs2E0/76eCNfobXizTOwGxe0CtIWj6jsFxK54ykecHcEQ09h47feuD1vQ+uM/tEzSpIppi/Hdfi+mKQ+TzsKqQAScus91G2fxIUhRVZoULLSl73OIga8X9PebT8HJZoMyaC7f3DEimEGfIJkA+QfgxOtVDfnEXU3dbZnKks9xQOjAD5PH7iszlCR+t3wrWldwGlfhFzGdfYO0xetkpTymJwRLQUL9UtD4/48Vi0sefsGpNx97EVryuZ9ioOZqjjWBXUm4fAaNdoVdtxMAZcDDXo7MnnbfUsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBboLab0AR8P5A6Cgs895Wft4Y5VWKqyrEnS3qGrpWM=;
 b=oaXMmKmxz5cb915r8DzHU8/Y/w8eB/M61mA2d/HhuZmvgSPbX4bthQOdcEigK0FUFFu7woZBlVz2g1jmZ/tPW2uqGgKyABZATJV/GEG701cKd0sjjwxJ6eg+SwYUrHYiydePw2f0ZuM/Hcnu+AeuApX6/XG6gSkDQm+FdwvZscM=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AM7PPF9D10A4C88.EURP192.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 07:21:25 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 07:21:25 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix endianness handling for SRNG ring pointer accesses
Date: Tue, 18 Nov 2025 08:21:21 +0100
Message-ID: <20251118072123.19355-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000167FC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::679) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AM7PPF9D10A4C88:EE_
X-MS-Office365-Filtering-Correlation-Id: d91a227d-8647-4a54-7f5d-08de26731522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANI4pPuZWsXgI5aP2TzliPSTne3p25993O/gaRQKNXjpRcIFu56hJxmDdTyy?=
 =?us-ascii?Q?xUJ7nopgYIE7XLZ6iEgZ5YBQ76caJbRJ/u98LLx0EjoE3rbCJMTjQpu7ZgqD?=
 =?us-ascii?Q?T1ShunfbmB9iZU721n8WPNJj/uWn5itdGX7NA4wHgFUncK5wp/BKdFQnwc0C?=
 =?us-ascii?Q?tK61SR7U0+RYfaSwGqcycbpOEOZSHqtebQL8y7pMpITzFDCo+BpqjbF3WKTt?=
 =?us-ascii?Q?Afgv/rvMOzifitiOZkgksMELf6TPbnq57QtJ/vbIj3Iwr24J3Pnwcp0v1rrw?=
 =?us-ascii?Q?tQSIqXsw8691skHGzCYmLvZD7LBFhwPh5pvEyi51Tx4zv0cifxs8Tn68Z53B?=
 =?us-ascii?Q?jtsq5kfxW3RCr1g9piXAKyzH2GtB2HQnbnK3jMPhMFMjOL7Hhc8CnWMBi9y7?=
 =?us-ascii?Q?5ispg7Rd8SOQDalUDAr9vTnG522sIOcBUnywFzGIyA2hku1sv3UREe1FFyY3?=
 =?us-ascii?Q?Y0lcFIYKLXoPDx60JPyTO0a3uUtM16bGPb7rt0XLqgwNBFefG5H3RIkPyYui?=
 =?us-ascii?Q?WodrY2+aMvv/jmTTvY9EDiZGwSxsxAzaxu5ncC9QyKr0s/x+aCym0rpeWLK3?=
 =?us-ascii?Q?aOwUFWK2nALexGncqBABPw6fY5FUqT5z0aMs8hXN96XUXM8Jzob4Myi25hGj?=
 =?us-ascii?Q?dr6QvUxnen2g5yxaC8BWNo7kJ356syAWVGS7cxusjKYBr3JCkpOYuq5XIk2D?=
 =?us-ascii?Q?4pMnnZupQzxFx+VNwfuA9Dc5zLXElUcJBCia1DQiJnjdnhZVraadUTUuh+X7?=
 =?us-ascii?Q?wslT4aPRDFJrg/eoZ31Cv8ABVvw06vh3n4sp7/NPjz8O2X0OvvrsqvM75BSA?=
 =?us-ascii?Q?xyoWx3iZyxe22S7qD9+C9pnmV0G/MOcy1bWLgNwabo/EaUwHMzHeGCCnrvnA?=
 =?us-ascii?Q?ZAQckIPmTkq2NJ01oHn2sfIT/7SkV8ROyY2zSkLKMlUyLNNGG7mMoDwa6hp2?=
 =?us-ascii?Q?QMp/lQAjkYKl87HYC2pRT40mxv6JfTp9oMncrZlRbVUP/gPRvRzETiAxTlVn?=
 =?us-ascii?Q?zwEMmY7/Kl0AFwQEJNQCx3pXLMLyELjigq1TV7VdOOUasZlNVGRMuGy5pF1F?=
 =?us-ascii?Q?Gm1a+7IHL+8uGIXufUmn2ROp//1j2b5MJyrXK1Qc0JcXONonB0El6m5WORQ7?=
 =?us-ascii?Q?OO1o/Yg2i4ah3MRPGT5glLvwPfjXhS438E29co4GxIFVSr03apDSIQF6Ec3W?=
 =?us-ascii?Q?iWBVg6HHnzzhcTvRTOgOu+ATsJFJ5B+N9sXQM73SKV+3R3ddW5DXM4BHAgpK?=
 =?us-ascii?Q?VYlTOPaiL+RIM1YJe2CpjDNJJmghqvtZzbWr/Nfu61fOkLQT9282kyc45Q0C?=
 =?us-ascii?Q?2lSnfPb5OPbi5g2eNd7KRXJDJJIsQgwA7uIULmtOPJoH2ZcNUQGkIMVTmX7S?=
 =?us-ascii?Q?TbD7nrVvgZIAfy/sBM06CGziVtyGWIS1VLG6rb33mlE9rlC1pGvAi3QwUHyN?=
 =?us-ascii?Q?6OodM1L+uyICGPjhOHWE0YhboBNQEnzb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XghLI9wHAwt134XtuNHwvY9N9TjKJm83WdYBknSd2MeQApmlvG8/BJNCEKpl?=
 =?us-ascii?Q?IoZPg1+5Ta51v7zRLfB8PvbG89u+FGc50D58bybNhHKk52YXCYoDxA4HsrLo?=
 =?us-ascii?Q?En0adBwwyUBN/oB8Vorp4OaiDO2eHJ7WU9xnjxtfY5rpmVMg0EM+DCyl63TT?=
 =?us-ascii?Q?VHIe34EZsiBE17OxcTnd0f9TwBy102WAdMVy9zJZnwwB3dLxkVx1p673qBqr?=
 =?us-ascii?Q?m9Xk1KxwHodAvKtp9QxQdMHOZnKwZaa/NO3n1HXi+KJHgp3PUiX36UCAlHq2?=
 =?us-ascii?Q?9SRNxPyOZZjaXhFqVZi5iiMFiJ6icOEltF3yaymdr7xN/2p3HkLqtBvCQc52?=
 =?us-ascii?Q?E7rBYEXhcYO9aqV1E/lvawZvD9LIly1jWvwOt3/4hh1L3AlZGNUNZrPo9GFh?=
 =?us-ascii?Q?txs+fZqn7h1ZhvCyEdh4Bxxy0y8RhUWxUOmT7Fouu6ykWqgvNWNiTh8z1yYV?=
 =?us-ascii?Q?/qUVgzvPsZLGpX6Dp7b9sPif8XJ4xa1rAwt5PXGW/Fm0jVRik671vbVj0LWY?=
 =?us-ascii?Q?gxkimat3ZMjHKdJ7HNm4DJM/tTsOkNxICoX8IDQvdbFNHko+hJrp8T3cRmP1?=
 =?us-ascii?Q?7Ro/x2RP5QLKC+WHPN0Kfh4XkVN5+/014OURtYz98X2+dbBIurh2Kp6wlv1L?=
 =?us-ascii?Q?JnasqPtvWBeqoVW3VZG14YC6nu02UvY2Nbgku5ezVdw7SLkITsZ0Icd1KMae?=
 =?us-ascii?Q?05vnOmGASooR9oBVWrmt1XbTACzFdTFgdNSwP46HJs1xmmfgXVmdCa5JD8Td?=
 =?us-ascii?Q?lw7q1Wrp1pllI8CvbSXR3C1UcjArVyDrScsF503kwB9vRl7gKrkwx/vp3fHB?=
 =?us-ascii?Q?4GQBlNsL6A9BpTyEyE22MDj+DH+b2tW5Es0RU5e19jziSz/xFp4SJBNPDz7E?=
 =?us-ascii?Q?y7MWQz5VoKJbWWRFy+ATb88tr+m8cgLigMjsCLQsWLPpj+KzjSJyEeP0MrWV?=
 =?us-ascii?Q?slnSZ1pu4eIXiNyLQg3ax4/NHcZRd3Nz4YQ/a1/WMm5poIKU2+HQWkNp1N2a?=
 =?us-ascii?Q?9P+B5eSj8e8IDi+j/O+v0E7XmXbl/Gh1BEkszSggsIWQxTZnJ3QjjKVYY48Z?=
 =?us-ascii?Q?SMYuDjEPnAq/TzwVD9k4wMSD314aybpAaWMg1XhnvyFaw8T0LqZOSetEJoO/?=
 =?us-ascii?Q?VyUjcRDmFxNuw3zWOUNmaoaVU3em27PddVK7dJ2gnsQTLHOglXcuF46ZHuOc?=
 =?us-ascii?Q?0gGwpo1tjGOJhIciRxRNlgdzLlosDGjMEqqBboadzqhgnWZmHBuL5M2olQTz?=
 =?us-ascii?Q?J/kXBt2uS5sqH7OSIP3NXCAoqTjgPWtG4lW+SUNS0WfzN5Mt6yfXbFWLn/h7?=
 =?us-ascii?Q?tmdzQ1iHNZG4wx6SY9zUQb507/zQOKc8AQ3BWVCVaqSuoG5VSLxUCC8lUyrt?=
 =?us-ascii?Q?zwqAnBDgJW7AxcCBQ0fgACzndK11TRl/HoZw2hdEeOWIeJ3Uiq3BQwYPw5Hd?=
 =?us-ascii?Q?kIQHcwLOBBE5SdIWNOBGftKO/45vwLJDRb7SFm1IvcxjZa5nwc71cxlYm7hp?=
 =?us-ascii?Q?slM4H/QrLvfhDA4JleJ58HY0Ka+BAXl189/YdYMbmDiQk8vjUU67C70X+cVb?=
 =?us-ascii?Q?kx+Oc2iMQIlRs23zf6x7SLh7Y4eO0xflfVdB8Fj9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fcNVCq6QNUM0XOvMtaY/TUJASnoGhIb+JB9whwYRJsG5JIskU4IlUavsp1sbSJF73EXXxNQjUVyExZQfHcUwOyN7vjyuTfpmwTj8XEjZtmmHMkBamp7fZ7DpPR4RHM/tXwF80WihBNvRMlxuApHpDnyTewpq3NPooYZh3FdrkKYPosOP8aWqmzfMEfdARHIKMhYUzRBh28tiOlxsqSnR4Of26TRAIuPclCgC9DOGIzJ7oOnpW9NOoH89XQth9YYk3CpfHTjeQZxSnqNRSED85PA1jTbAtFJRwRevXae407LeF14XnVMBUUqsouuVw80Xk1rolTK5KgUi1OE/0f+oBZIHwK+SBCjDQEOvhan80UOD55Y+8WCyr3Pp4xX0xNqHRuN2IODz61F0sUutZBkU0VDKzeN+N2Bbq2jEjKLZhFb8VwRCZgHn5ykX6G5FANkB00DcZrE+zrGPYsUygAS2q5ldkgA1kQTBW66lQqmObNUA/MJxLBXVm2FTO+O5ZgdYN/MnnEoH9TXPwBv8rGO3hK3pGTXmR4LtaPEuqGaVCohgCOvW1Ln03XWzx9/ZKGBWfZ3mUsS3O9V+vOpuY3yY7Ll5LTsz4+XuhKOuOhh1VThY9ACAMd7D1kctvHt8sSAk
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91a227d-8647-4a54-7f5d-08de26731522
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 07:21:25.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKvRt/AJe1v86ZDIdKnd5IHkZnFSl06FwU2R3e6qumgM50vTFqWlYQsrFhWU3rJpCEMt7RIZdxvI4VAZZWEfmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF9D10A4C88
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
X-OrganizationHeadersPreserved: AM7PPF9D10A4C88.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: QwtjtoVLgpkxT6YsZvJMitixJpNKs4wS
X-Proofpoint-ORIG-GUID: QwtjtoVLgpkxT6YsZvJMitixJpNKs4wS
X-Authority-Analysis: v=2.4 cv=Qflrf8bv c=1 sm=1 tr=0 ts=691c1e77 cx=c_pps
 a=XzJWp150oNq7pZvwL9YYVg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=HarDYBM2GIbeBqPcLDsA:9
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA1NyBTYWx0ZWRfXwZhvvr1Pq4hR
 +6rrwbfTP8cQhEPAI3UsvxkF3N44r7wC+GiGEG7pf7ZfZSO+89wqcbcBJ5RcKwuzXL5stwvUmB+
 eNdGCfEb9NwyAFA+NbhxCQqrWS81h0+Jc+p7iXR8bMrgkTs9LhNHB+i4ZpfSisiUlmWZWxEiHi0
 Btq6P2c+d37m48I1LXi3EqhN73CMqLzIeHOtP8BtRcAxOx3nh5CuMfzyA6qje+DYwRME1EhXrDI
 FWD/q31/NaLdRkUyIIBqrody3AMI8Zxx1zfwgN5/DXU9z4BRDg+bh73lZ7nZJC7j1JyIya1TRzc
 K5/07klR/K0c7oUm5ddUiBhp+yvPTIvn1mX4pNRyZbrB58dvHgH4IPJXRY1I9cf/+4+8L26KOsI
 8oSPqkhaRmHgmUpsNeRiYxzkFMxI8g==

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
 drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 6406fcf5d69f..bd4d1de9eb1a 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -2007,7 +2007,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	tp = srng->u.dst_ring.tp;
 
 	if (sync_hw_ptr) {
-		hp = *srng->u.dst_ring.hp_addr;
+		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
 		srng->u.dst_ring.cached_hp = hp;
 	} else {
 		hp = srng->u.dst_ring.cached_hp;
@@ -2030,7 +2030,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	hp = srng->u.src_ring.hp;
 
 	if (sync_hw_ptr) {
-		tp = *srng->u.src_ring.tp_addr;
+		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
 		srng->u.src_ring.cached_tp = tp;
 	} else {
 		tp = srng->u.src_ring.cached_tp;
@@ -2149,9 +2149,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
-			*(volatile u32 *)srng->u.src_ring.tp_addr;
+			le32_to_cpu(*(volatile u32 *)srng->u.src_ring.tp_addr);
 	} else {
-		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
 
 		if (hp != srng->u.dst_ring.cached_hp) {
 			srng->u.dst_ring.cached_hp = hp;
@@ -2175,25 +2175,28 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 		 * hence written to a shared memory location that is read by FW
 		 */
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
-			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			srng->u.src_ring.last_tp = le32_to_cpu(
+				*(volatile u32 *)srng->u.src_ring.tp_addr);
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
+				*(volatile u32 *)srng->u.src_ring.tp_addr);
 			/* Assume implementation use an MMIO write accessor
 			 * which has the required wmb() so that the descriptor
 			 * is written before the updating the head pointer.
@@ -2203,7 +2206,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
-			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			srng->u.dst_ring.last_hp =
+				le32_to_cpu(*srng->u.dst_ring.hp_addr);
 			/* Make sure descriptor is read before updating the
 			 * tail pointer.
 			 */
@@ -2547,7 +2551,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 	 * HP only when then ring isn't' empty.
 	 */
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
-	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
+	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
 		ath12k_hal_srng_access_end(ab, srng);
 }
 
@@ -2648,14 +2652,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
 				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.src_ring.hp,
 				   srng->u.src_ring.reap_hp,
-				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
+				   __le32_to_cpu(*srng->u.src_ring.tp_addr),
+				   srng->u.src_ring.cached_tp,
 				   srng->u.src_ring.last_tp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
 		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
 			ath12k_err(ab,
 				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.dst_ring.tp,
-				   *srng->u.dst_ring.hp_addr,
+				   __le32_to_cpu(*srng->u.dst_ring.hp_addr),
 				   srng->u.dst_ring.cached_hp,
 				   srng->u.dst_ring.last_hp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));

base-commit: be83ff7549057d184b693a85cafc10fbd520f3d7
-- 
2.43.0


