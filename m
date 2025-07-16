Return-Path: <linux-wireless+bounces-25528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A86B07041
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227BC1AA3C7A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0228ECD7;
	Wed, 16 Jul 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="G4c1Pgp8";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="hOQI+MLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881DE28CF5E;
	Wed, 16 Jul 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653957; cv=fail; b=FbdLY78dcwokPuWkjv9WFO5rG4Xvqjxjv5Oyj0EMP9ESQBLgF6pPYJ1Mvn8mvbw1Rs5LXrBDTDG4oNAw/XKMuysVGL6q+2ancV8+jdsAFB2yHOQkUjubsLOfaueCioZNv2JgpSJb5OWt49bdrV1JZUFYVKBiaBLorcaDMGnZMi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653957; c=relaxed/simple;
	bh=gjhcuLlnuLg5UtHcpYmDBfgNSi4mvZl/f9k6/V+2KPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tl+txtFjFEwb5TRRx/TGAjovsjjrWtMsqmt5DZ1CNkEHB6dZWS3uVnY1LkDob0TzRfWKTOBzzQkocwsiWvE2Cc4v4CYuMtJXrUPYyVwReKtb1Kb73RA8W/9bQi+fCIWwNX0wgHX86IQ9bSrhwfNxaY3WO75H/fAI1IHfknPtcpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=G4c1Pgp8; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=hOQI+MLm; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G5t3Ul2228410;
	Wed, 16 Jul 2025 09:51:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	girJjPVi15x0XVNyrD5ZV95QMGFpd+3yWj3sYfGeKCU=; b=G4c1Pgp8oGZXAw9i
	/fuEdWamGO1h7o3RVMiTiDH//01jH8ro94vziPVQi63IZIt9vEDfD033xIrSwpPX
	qQOPiT9IblnD/4D5vYpks8+7UNnm8e01by/34gcb25XCcNpStA+zzEjUdONP8BrS
	krAFG3Zi/IDs+TCz0bcEPHitAlOYT9BgJIQCv8+YRNmnU8jCMhuoqn8ay9kYkAbT
	JD1mtlLa70lkpisuSWQARwcLG1OYR9+4ou34Jrl8HTqoQLGdKD2guLq0Y8/vJCuq
	+8Wga7dOJo1z8Ez3N89FLHVPnFRctmxNLMGVOAAnwDAocgHipCFl9WxQwvxBCIZ+
	iGMAtA==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2120.outbound.protection.outlook.com [40.107.104.120])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7ne-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:25 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlLEXeMm3WbM/AOj/u1kYw4QJUBh5IGk1VGPlutkW0NnVRY/EURls4zItlmsuSlvDCQf8xk02a0w4P7hslfjQmEUceTIzB6VTU/9ggzp7oxn41aNwLUOlUs1+joPGUfCv5jl1FR6NqOZ44a56VsZ37bNIi1pwTjeH6zB3FiGZZF2xc+YI29jp/ZyWdvVw62FXJys11qJnOtFf8FjPNKfu3637N3rcFs+9HeZv/fgwldogJnzAG+lNYkSjN5uiND1Xwwl1fRxelAznwpKYbSgngI0BWFAzFhx6K0HS+MfQCVNTuhnLkITDARoaFBFoEQjAnb4blr8anJo04DP/VPF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=girJjPVi15x0XVNyrD5ZV95QMGFpd+3yWj3sYfGeKCU=;
 b=R6PBzKY8di4o+2mMM5ykLjGyfB20upiejsl/aQ4Qy908j6bx1AZ4stdpw4cU8uviltTXFudW7uM1h2Wo9dvrAcWAGPTtU/WEjfDKY20V7gzSa2ago5/qXlNmBBt/GSBQl9h1TN3eeck87GtU9i3O+DHWh+TQt2TYXef5L4HNDyn2qiFbz++0FNuXneY/SA938/a6x5+9R/q0YsZkLegSdrZbOAfr6oggd/u5pzVwqQEmMcPM7HBOcTl2vqi9XP21XYgSZaR2gkIcXrn7ZFQrymim2V9LjUY7SPXr+4tb3pD7zks0jEbm9hvWLvx88Dd4WQYsj0AmoEfdzyVAve/Jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=girJjPVi15x0XVNyrD5ZV95QMGFpd+3yWj3sYfGeKCU=;
 b=hOQI+MLmKHeYQ53fd1RtxS1EoEnBeU50dH6mTCQnLI3aWwnZM396n2MVLBBlWpW3lmjAekNQ7MGd2+peQGhcZ4WTGlDA0kq7/LubPE01dnmCV9p8dQKrmg0U8M6c6eEWsPAodVGnmbEftJRSnSfF08eXQjEI8WyuaIoRb73f8ow=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:23 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:22 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 08/11] wifi: ath12k: fix endianness handling in QMI firmware m3 info
Date: Wed, 16 Jul 2025 09:50:57 +0200
Message-Id: <20250716075100.1447352-9-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0036.eurprd09.prod.outlook.com
 (2603:10a6:7:15::25) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: cc101ca5-c92b-4893-3f98-08ddc43d8f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M+O7Yb049c1jyCQBVtxuKGiYvDL3plKUsqsmmVbAVQ1mVcDWwMSMydnQS/ap?=
 =?us-ascii?Q?93sWdsP0WyOO6BQ9YN1gCiqhf60r2W6AU2oc2Jl3IKgQQZx7RQlzqtRbRbUd?=
 =?us-ascii?Q?6eOTElBWvJeOeV5Mw6V4sfrlKgfQKRBLoz2+5EqADyOm7PjfCGC5kXL6vD1g?=
 =?us-ascii?Q?2r9RIyMhv5bkSbo6Ju4g27YcJJlBp6MCkIGYQA+DcEzZzocXzbqxHUE/woVb?=
 =?us-ascii?Q?qIbBRYAJCBwR0VM8kqAwZkAx4ulqEGncb3mXOMohdtFbkfsvo2k3ee49Etf2?=
 =?us-ascii?Q?F6P3IyuUAqpcE4O5FN1eRqiUMr6xy98ZiAxhjkY1enx1NgfoYN9ZRN5TlFF7?=
 =?us-ascii?Q?4BR6KyUzb7RUqMdGih7yc1hg1QUqPj9GuMbU0/pMD+ZMttrdUIPA1iMp/FpG?=
 =?us-ascii?Q?6p+HHLUB7ApHpFt9x01amyz1FR9kCrXKdrr9mzmrPAVepcUGd22S+TlTRsg3?=
 =?us-ascii?Q?jqilfH93W01lkSOIr7GNSpHCUhJGxDQK+1UBMEZ6TO54m0jT5od4isg6IwJq?=
 =?us-ascii?Q?G+7BT/D6MR6vLFC+Lx/f6SL9jxXbugKyxn0CjvRixTf4uvuKw6xHSiDKOI9A?=
 =?us-ascii?Q?6AV8Z+0dymEBceSVckcpU6jgQA7r9K2KN9aLsvEu8LxaJC24dUXUdjmH/kZd?=
 =?us-ascii?Q?ldzUkhPmTzhx8q7MRky9LLt1vNAbQV4tB0/oehFBLUu3n0hPVFXEXIok4ux/?=
 =?us-ascii?Q?+akO7b1wCsct4XWne1KrqMpC6js9faxds+YUTanZ8Sul7FO31jXlrBXz8uG9?=
 =?us-ascii?Q?4a81v8K7Sv/d/mCSPiG9EOnIH7YBQzRUF3u9EN6QpHeKd2muITZZ6R+Q4cHJ?=
 =?us-ascii?Q?WMk4ONT2IWRskfv2hXHqWBtM7OqH5Z3sXSZ9/TZxIZ4VSjIkRY8f8O6AVAB/?=
 =?us-ascii?Q?vESySXXLSYIcOlxSMFTBXqGabsyhx0C3Yos5fkMNgWwXmdHQwsDr/baOx5uo?=
 =?us-ascii?Q?j0zJ2D/WWV+zDCxODZl+scIWm6DUmntgcMfQ+RHxOJOq+HDyD/ffNGug6lQq?=
 =?us-ascii?Q?I0L76d0BIwAXiBN8PiYR5fphS0RAX3RZ644ZStZHRQLSKhz/gQ9a+fmnbpVw?=
 =?us-ascii?Q?gyy0UnCQKM+aRGbsXLYtVFJDe3e4jGLb4G9iWZQ59wJ1X1q0vkZ/nyjHozHc?=
 =?us-ascii?Q?/ioBMF6KIFGiuRLMMppNAesSLFFKQbOrLUe92NkiEiORF3aB+cdj9uw+Ry5O?=
 =?us-ascii?Q?/Kxu+SQujcxp81ynbhQtU3/nEigMPRRe29kC0fp5hEZkJudhTazHOBRkAuj1?=
 =?us-ascii?Q?R3oqxsbRR7W44zaDFdJ8cA8exseFfxeD1b5lYj7zw8FeME49KUUettrb4Y0N?=
 =?us-ascii?Q?QXsK4yDpD0zKPwRndnwvNCObjFqQ9DLDClGPBjHnWqiJeFcmUeo75R7t0C6I?=
 =?us-ascii?Q?144TlLxRrL9509oStxmU7qHnXInxo2cfsoinydcHF/Rm3CIu0k265tnKuRjn?=
 =?us-ascii?Q?gqyZMAWICuM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3jUBnIROJ/ispXCjIaglpGiANLjjwuI5FQjQ437zm7kBlQKG1f7MFFVbvHu?=
 =?us-ascii?Q?47AqMDCPxGAgwoB4PG2xZU09eT885+o7Segcp4W1dFVhl4kxPNvgQfEvaa5s?=
 =?us-ascii?Q?CAB6jfaL7PPB6sO47KsNV/kt4Qj8yJ+QWD956m7eMxriP8qEQ8FMlug+o3gR?=
 =?us-ascii?Q?pUw/g8BIyVsY7VGaSAxbMntlvAXvl6gMXIR+ZOEtVMm5KK9AUQZZ/Xgf5zVt?=
 =?us-ascii?Q?E06q8p+q7SPC9vcVYo5M3KbBh35TzXQN1yqIIPFrZim/sA4FN1Hp7pJ0yWDz?=
 =?us-ascii?Q?pv6S8f3aKoEA6QZvg571TOm4Mrwzd7K6H3qNSOuUIPRwaKDEJ+Epq3Vkh1Yl?=
 =?us-ascii?Q?psLybOA1qHplcD77g+l8qLfRARcdiVULBndw54seC7t+srOsvxHYgiZe33w6?=
 =?us-ascii?Q?EKzJAWjIAhQp3U7M7PCNifYqfxEiPNEuC638nj/7t2TyF5xo0vXdXXi9dRJu?=
 =?us-ascii?Q?iSgpwSY3q5tNv68gnNdvt3zmBl9a3NHLvrP3wb0IeTPtKjViL46LQu94nzX/?=
 =?us-ascii?Q?ETl44HgKlkO4vP48cW3y2pyZjZyK0/p4y/msi2D0/TmfCB7QMK74/9C34UiM?=
 =?us-ascii?Q?o/cxKhTwVnOXZhfvYev2ZGsxJOUpwyShWQn3Zc+c0NCJPbA1/4SwQvXXrkbj?=
 =?us-ascii?Q?xfr+S6z+XJO41NMovCESa/5pSF0QTJ4Et0+3Sk76BZVOgmhplLipnu8Z8AVW?=
 =?us-ascii?Q?V7yNa3ku1HeHTDVVPOO7Su6Cjylvb73uS3XRimkYda3huTQVgpOQjd0AoZGY?=
 =?us-ascii?Q?IkZ17kW2bCaO+tKgr5DEFWr+jmNy5rU0hmjw8S5j0GszrswkeMljBoZst6LK?=
 =?us-ascii?Q?TEV09ZTsG+gee+S0PwctKg8618RjQYkYu8/ljLKEukdkkx/Clweo95GnzAu5?=
 =?us-ascii?Q?DX78cxS1q2rsZt48YU09z0m6RApB6+kNudZVO7JeCEG9oP94N5GoyVgFZ03A?=
 =?us-ascii?Q?5ho7VGxI/UwsCmwlNAssqOF+goLK0lL6wbG/t6OIMAjdMb7XLQ4wYppCOAHg?=
 =?us-ascii?Q?QGvuGswjXo86nLm4942ogBF1LsmN07xUyuH0UWGKclhRSvoUdiBv4uh9/aT0?=
 =?us-ascii?Q?i+Hrs6R2qhlCYB4NKDjnoJQQVVFDNQQ0J8pAsoGTvcNaLiXWboN+Pnr56BqA?=
 =?us-ascii?Q?bdcPR0xCxzNKO4eDoWQS7OQQ3Vh/O7skZ7p/L7zLzLoe5Aq2Uj8DxF56TSSO?=
 =?us-ascii?Q?H+XDyjZvz5+lfP9YdvW0l1NfFbSpMGL69im6E51KF9QkG7Wk8i8w29N7RWMO?=
 =?us-ascii?Q?QFsCgVqQs+V/GrCuVl1SGRCBaSJKOB5GY0WvVdsUJroEbxg3EnAnc36EmYMC?=
 =?us-ascii?Q?mx1XbSTJkN9rKWk975exBJ+sI4zs5zDR1jyP0maa3NvVW5APz63aEyqZYWME?=
 =?us-ascii?Q?2Edn7uRv0eyWqdu/ZP2FAISwzAnXK7xYBPKBHsAIJlSMth6Y8rKbJgD2KWPq?=
 =?us-ascii?Q?Oj43eEEE0EykCVUVo2B+hDQE5VjmXILdyWvOGGidbu0FVTX1iDO2XecbYXoS?=
 =?us-ascii?Q?666U9WOe63tXv5pkfQKxtQ+a0VF0sSJFFhI/4GaHprAY8fmsKTbOwL5K+Qo6?=
 =?us-ascii?Q?/zNbiSW5IlepLGC9JB6Jr2uBvoAeNtTTrMNeyLXA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OuSW6a4cf8baw1g/M9tPbYZfwbN4mVKiyWfPDwpKdwGjcGFhy2S5VNLxsDaYtWftdfTRzaJlW8kOHmqDflnXpseGFzGfqHQF0Kj366Qk0TMOG5ae3XV8l/q2xJslA/2XrburgDQNAVCLjLmIKFzHviCc32EqP8PVyau1+vitL61U575jkIR/ybwYp38/fvkqNWtlMxlnez3uKtvpNHYO81wdx0clmuW+dKcuguIIVTgVScU8IpyHM6hxr1k2BnugN1le7E7Yi4Zn3/DJK6PY2ZY2go9KTGlroAv0FattjfJyXu3yMOOwIWmvob/Xdxn/hzafz+VSh/F6+tSq5sFstbsT5HdMsTGxx0zMdhtX/oTslmLcfLKdfWeoxApu37tr+sroH2DTkL8l6PiS/2XRtbonQcSL5B61lFsQEKGRSPteB/+7t3NnxSvsMkEjldu9haU+IKK0zvOD6SzIyxvVcV/M8qmkq4gUDYTrTCx7AAmTDFtIQpQymq8vNJcROrnCRf8GHa1AwCORwhN5VDAR+hm9aepHUB+1ieRPl9gcX0e3aWHroVqqertsdDaYXA3pw1Tr7I/XgjeqG9wBix31C87Xk5IkJJ/1oY/Hg3NhuJ3jCH3wNSU2EjESMAuQJApN
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc101ca5-c92b-4893-3f98-08ddc43d8f11
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:22.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQVbtTyf2pb7MzkgmApUi7OKwgiQ3yvRNygAu2ODk1b32IwWVFUSs4LtlF8hvwgzLKoZJn1jxhx4nvoU6/imgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1853
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
X-OrganizationHeadersPreserved: GVXP192MB1853.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfXwZAEG5gTKmS9
 R8M6NENP2rpHEEnsr3M8bpxxOKZZ1iz/sv+GaSYMYD6W24kuANOvCAyueQv/nKkO2/WQs7/2XEl
 h9QR7rCLSBfThE3/PVj/MHcp9+hbRjelOHUEVdukPCGXKnV97S2CcILCk/9GIUGG9O+Nlkz6mic
 q0mXdVBq7u8oPlQqaTS1/ykzy4I4dl2MaueTDnRLz2dCByFmVFHM2/4IU3ZdWyna5pAoaOJk7VZ
 VczCqF2EorsbQFLHuCgR0Pueojqd4I4YEO2/H1CWMaT3mNHpeOjwCeD/rUYfWOAtRkAU3ig97kC
 cSS6HFMseNfDKN0QDZpzNwFINK73JobLSolO2x4e2btmZ07EEV56uosyXwgvL6DxVktEENvfUaw
 d5sMQj2i
X-Proofpoint-GUID: wwVOc8xwfRKwticNyQYTd1nnprn6HJVS
X-Proofpoint-ORIG-GUID: wwVOc8xwfRKwticNyQYTd1nnprn6HJVS
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759fd cx=c_pps
 a=1T+Jk3iLsGfRLyt5uBfG9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI firmware M3 info request message. Add missing byte
swaps wherever this structure is accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 4 ++--
 drivers/net/wireless/ath/ath12k/qmi.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index d18ffb86f7bc..5043d0c39b56 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3198,8 +3198,8 @@ int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 			ath12k_err(ab, "failed to load m3 firmware: %d", ret);
 			return ret;
 		}
-		req.addr = m3_mem->paddr;
-		req.size = m3_mem->size;
+		req.addr = cpu_to_le64(m3_mem->paddr);
+		req.size = cpu_to_le32(m3_mem->size);
 	}
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index a48850ec0296..101d91131ef0 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -529,8 +529,8 @@ struct qmi_wlanfw_bdf_download_resp_msg_v01 {
 #define QMI_WLANFW_M3_INFO_REQ_V01		0x003C
 
 struct qmi_wlanfw_m3_info_req_msg_v01 {
-	u64 addr;
-	u32 size;
+	__le64 addr;
+	__le32 size;
 };
 
 struct qmi_wlanfw_m3_info_resp_msg_v01 {
-- 
2.34.1


