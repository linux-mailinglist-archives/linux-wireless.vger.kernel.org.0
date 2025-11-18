Return-Path: <linux-wireless+bounces-29096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC55BC68EA9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA2365833
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEA33CE81;
	Tue, 18 Nov 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="WhPe2pdU";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="qoskpeyn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF923191C2;
	Tue, 18 Nov 2025 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463002; cv=fail; b=WTh3MuIJRbkIH6BJQ50uV0hEKFUt9V+OhZIf+3Hgv8lsO/fPq4wSbxMnnWfa81XW1VpZt3Bp6DUW0O3y4tSljy6MqAfC8L0Gj0136cgDUrHAFTOnBB5rQSrDTjV5WPdSCkBjTGIHw5aQsnrCFhmPG4utBXcPjIYiRhturN6ZTn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463002; c=relaxed/simple;
	bh=6unbSnquB4BB1paCJRPej5zcH0SiQxj7P1dGB+L3CK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uPthhein70gFSQ5LCGgEFqONKHe3VFfWkpZfvEPixvJECDYuB1JbTluOVZbQtbHzDZ8IRQGeGGB+WvhNeHhsRsIPXfQFObEzvdALMaTDbirpBF1Sx3O0cTnT8TnPv0qAGIAgMva54yq6SHyuszXPOTR23veg+4I93amQlEgknZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=WhPe2pdU; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=qoskpeyn; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5WLCx1417229;
	Tue, 18 Nov 2025 11:49:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=E/pTUitZlEUhQyWjQ5W4k7DA
	GPN8aemoffLY0sxXQ0w=; b=WhPe2pdUSBukcrJ8CTXyyO2gppKoPlPZHUbInQuf
	VFkAt66Lap12VN9TxHtXeELWS6d762Dv8d0nysKZaKSec3ETFez2jtLsqOcoO9Yb
	WUZKlhdU69hPfHKxDOSiCyDUxKGwrMl1miXeWNkFCNPSpKazndbb5/FhMnqtIHwf
	ShsNVJVhRMsXXgFmBFD0j2db6cREclzDT5AFWbakttXRW2I5yQQblOZKUn2JHDIw
	PsEJ8zF1Bbq9cO9E5gz873WCGxa9c3MyDgHuljkR7opJOumJAugvYb+c1hd9F2ZJ
	YR6CxuNPyKbZw6kSD37/Unh197HeCD5EDcGfuFUEuzsGNQ==
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11021110.outbound.protection.outlook.com [52.101.70.110])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4aeed52u9v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:49:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvrLjO4RiJG4i+x2TywETKHRFnffNmAU/Udd1xsgS4tJcMHJOV4JL6HvYfc0Olr8QtVFSfvPxrvVQh6TCqhncCbj4ETrP2RfqateJAhf4MAn3oSSHmng5//EuxGUcRRen0qQY8jGPhuW4OFHf1yIwWrJxdRy8YoDqB2Dry4gDQdf4ytvnr5Zd6KAVudxxHE8cSlkdQlAQa9EFGWshDjtK14RFEV0owEWDK2lEM8UdXIhExLtTcB7rD3l9r1ISBwatC7Ljbu6vSJ9nR5669Bjnom6NCwSzBDZMLHS4+m7H4NxdgCo5F+eH+htMTD9nsP6cT7ewyCAO/ox6djyrl5gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/pTUitZlEUhQyWjQ5W4k7DAGPN8aemoffLY0sxXQ0w=;
 b=zFcMZMk4edbNYrOLrXHf3ge2VHkGzQYhsDcLYekNqtDNc/Gozj5AZ71qRf87NClflt/PYDTVqusnMySYgo+zIdRtr/RIhDBwKWkzOUiR63aLKBT2ZaT/WLhBcWUp5mGmstz/Zhfa5EUzd+6fjMD8pZpfXIHNoiLdzdE2y01/X1ohNSC8i98Ts4aCBK7LNLWmsDJ3IwMfz/JvC5ZgEECalSDCTaD2M8sZjwXYJI139gtBkclI8w1k++PKq+84gs7W0JNEkulFacaPRDpWU/1Q/Ka2OeCIYZrZxgO/nmmCMyZH6+7U6MYRpkW8FTruoR91QL839ZaJZmy9nKAC/VVWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/pTUitZlEUhQyWjQ5W4k7DAGPN8aemoffLY0sxXQ0w=;
 b=qoskpeynEbScDVDIL5qC4tBvrypch0evyn3D2ukyoj6qbLK3uV8V9KJn6fdgNNQDCQovaO/ygjePSv06GxqIIht7dbUlG8CWcNTrE4ZnGtolTVKrUNy7Iugum8AA4TJKcek+sR/CSY/oPNxkfMfG3RZFpDQXF3cfLfHuZtwxhVc=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU0P192MB1892.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 10:49:31 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 10:49:31 +0000
Date: Tue, 18 Nov 2025 11:49:28 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
Message-ID: <aRxPOLxQkOUCDK1B@FUE-ALEWI-WINX>
References: <20251118101723.69279-1-alexander.wilhelm@westermo.com>
 <25dc40e9-6fe6-4e8d-b767-02f8a304e1ca@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25dc40e9-6fe6-4e8d-b767-02f8a304e1ca@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: HE1PR05CA0143.eurprd05.prod.outlook.com
 (2603:10a6:7:28::30) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU0P192MB1892:EE_
X-MS-Office365-Filtering-Correlation-Id: 077dccdb-0105-4f2b-df1d-08de26902788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1hCi6WW5pSUuyJ/UZMOb2TAXgn1XuRAe5F1iFUTkhWGHjqMSbuLP5vS3RK4?=
 =?us-ascii?Q?XpIoXRhWfXThZgdTfM8y9P9t2ikNLNBvy7AM0jkLQOxJG6Xoec5zq1HAMXd7?=
 =?us-ascii?Q?LNOCkiAHvGZCMmvVCg6a/Ae8PDsMPsCEYcER6XsUJP5yoEQD7cymTngtJzwa?=
 =?us-ascii?Q?6X0CVBnBiPeyMzMiySz3DV+ct/LbkGunanCJZBGNfhcESJjpDCnEWkDWM4tj?=
 =?us-ascii?Q?zSLl9DG80dlTihEk1cj6+ZvEyONvEtuMVa/lsVEI7oYgl+Pa0E0X1gHPj46c?=
 =?us-ascii?Q?hWZkMJ4wcANcf2qOc2RcLqD+UprjYLRtDGyouq3O+P9a2GxLPeW8YbhMPnFp?=
 =?us-ascii?Q?YUBiCnnXA6PdbT0yV6eIOPCKe15/m6axv5I7jns1DeTmGFW2hKfmvwxNQB59?=
 =?us-ascii?Q?aHPtj3EypGHgD3KVUC75C+7QG8M4An42cqHp4JyfuQnAbsYXsLWkBTeDPQp2?=
 =?us-ascii?Q?eneffR2vqkb9jKn+Ub1aBwHoDgT2WnMF/Fu9qSCQP1NHgKZTjZRhTlibXvPF?=
 =?us-ascii?Q?6gMzYDQ/cEARWvyYFXjgOKV9fKVS7Dp7ifk0NeLQEN8/JPQZTc+MHqb5hFFx?=
 =?us-ascii?Q?4QOBC8SKtlMqARIUiE2rqAsZ1GFym/3XknI3Q81fe/KiO94xzvwFdDmSo2Wx?=
 =?us-ascii?Q?zv28xIfM9lqhU+qgyDPi+coS3iz5XAVSxh8+kJYqZSh9pDCZ0efC/+RU8rZ8?=
 =?us-ascii?Q?UQOCjBHhYR+eUDaPmUZnQCbQP/ekS/40i9QPwVrffQaxcyDGBROi37ZaqRNR?=
 =?us-ascii?Q?DaHUhuGDhIBfBFNt0v1DBaIH/YIpTKO1H0r0PDziP31mus8zgASSd3iTRTic?=
 =?us-ascii?Q?Bdiup4OSfaBBBYNN2iGJzhFNIpzi0i5/uzIVjAHtpc1I0R/982h3Pv3kQ7Pn?=
 =?us-ascii?Q?/UsSZm1xw0N4N5+y9qm/rfZDd/xiAObO1MfgfWQ+eY/9p2FwlGnjUwofCpXl?=
 =?us-ascii?Q?3GoEA3IfjtIXmcvvn28/wLFehXVADy+/wVgyjFNK+CW3suXPnjR/YGjWPod3?=
 =?us-ascii?Q?CAaeH4umpbGLfAxHHmpaRmUlHHVw8YcQ4UFZIOz5X8WQf2TlicJTyp25jLQm?=
 =?us-ascii?Q?XtpgQaJHwQKty9Z0LkJ1lcMggHcpCPAQwGvbTL7i/+GH3lhAkMpCmg+y2R41?=
 =?us-ascii?Q?ztJZhkdH3Md4GD2KwaFjFIVuLUe4hM0XxHPKx+YGf/7XZwnvY/HJokBypbIx?=
 =?us-ascii?Q?3v+0q02O/cRX0QVYuVUWv7tKV9/71FvS8MDxdgyyCDS05qB6/1jLPOqAKX6m?=
 =?us-ascii?Q?KGF4FPjnvMIakVu6TIy/vCei1DVrv+A6FNxXgt/iyRJii3Twe5fhYkmfhjCy?=
 =?us-ascii?Q?kFD5yd451Ciux631CSJ+w5VMu59187v6z1omVXM4GLTfsNRaLD+S8x1R0Ijq?=
 =?us-ascii?Q?7K9vRsipCFvCoCKy9eXSHDnslpflQET2sV22a393m+KJ4PrIIbQVJzy8WS5x?=
 =?us-ascii?Q?Ha8qWTnMq2sq6qhpTZ4yVcdXhpyKWku8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4z2IUlhG/E8RHkoEDeXgD9Z811t3dgFlTNrbU+M8FDGoDbH2yM1c4R05st4M?=
 =?us-ascii?Q?/aL1jVFD+AzyhZ4jTJjyI+DoSb6zYp4GKnpQzuoIVkRIyUGMMIQMkYF7t+TC?=
 =?us-ascii?Q?RAycmoJxOZpsZbZ1EZcHSOP18rl1oxyfT9n7+2K5kI0HjVW79z6CVqLSKpfA?=
 =?us-ascii?Q?a+l4zzqCzehAt/NN5kw/nTE7bFypr9sJrXfJxm/8xz1/3V831c+F8WAAX6gJ?=
 =?us-ascii?Q?s4+KwQ3rK+9AwkVjjggkZKH65Z067/2up0v3auZdNWZ+Wrc68HZwGZfKDYmo?=
 =?us-ascii?Q?tk5rGy/cQNfkfAZQ3U5hX87FSeMyb866ZR2YwmDqNwgYeH8TfgkXZFQIgP98?=
 =?us-ascii?Q?fkr8o09+7/gO0bNmWYeuDyk7/K8WREW3Qwlq37h0oc2C4UOGYNMgQRip1hFM?=
 =?us-ascii?Q?batIcTHKaZ4ToNTvK2Nxn/N0mRF0dT6a4tmpdifsTAS6Xdma+dC5f7Zt8msk?=
 =?us-ascii?Q?ZiIx/Tl15ut77Nid4pBFZPaU5Ir7AiX/z0PxOC4N0fsnBC8MtB15swdXa3KV?=
 =?us-ascii?Q?C6Yrb6tgWW0hkO1Z/bN5ccCnOinQd1MVqJzz2wvzzPl6xTwYywmavLoguc6r?=
 =?us-ascii?Q?7kNocRFtbIUw9soGBgvebskVzdMGz5pGma+apUUd2PmBxc+KDOstsVlBEv1u?=
 =?us-ascii?Q?8ybZHmuwR+Wd/V09du+dcWxj6RTtkAsu1QElflrxGbbuK6/pvv8/UbME9UN4?=
 =?us-ascii?Q?daubWLxh0pggjfJ/XUi+7TI5GaGjBdJxJYRANGUL8o23epZqSMIXCAqBXFNA?=
 =?us-ascii?Q?Rf9lfYUihR5hirbWSqyPcqD1ipQzJxz/nWx4j9bdpff7SiekZjxp0lCsGrki?=
 =?us-ascii?Q?B7SpSmeF/tLdn3vRRwNbNtcgGfRLkHRbCExh+mwbU8iA4yQsNyBpteNZqUoS?=
 =?us-ascii?Q?FM/rxTdIvznCTRwAllFtaahlKrbNi4pKDVsQ22EhsfjydEZUG3je3o9XWwMg?=
 =?us-ascii?Q?xLZwMLhZyHj9Zyb1EYD/294+XXwcbQeEDCkym6PQdqgIdkQ6goA4m8PrhnSc?=
 =?us-ascii?Q?l8nhXdGlfAPxLzAzuS5tInSjxf0jyPizo0Iw75t/UVXbtFFGUrh+Uf05MxWI?=
 =?us-ascii?Q?w5k9s/GcetsMYWu7oAU9XIH8Xtn34Ch9AaTBS29LaRwGuJ4Qz4FeblXUZF52?=
 =?us-ascii?Q?fV2+kjtQQLeAUONS4udUMUe6+JUWjbGR2JFNppcKHiSlhoXBRC+DCWuCru9N?=
 =?us-ascii?Q?LQUAH5Tx9Kf1ynQcQ3JvPpViwaqBsPwC6DBOcXVTbxjVWJMogQm3HpzQj40p?=
 =?us-ascii?Q?ImBk0PrjuAiM4DyONN7HPKvyQ1o81/dW9gc2I2z5DktfDK9jQGnHRLO8xLQ3?=
 =?us-ascii?Q?vIpUEUaiG94EmQfgl4zw9WGnjZJkYZl+cSlOe4K6NZS5xyAbZrFkAyPj0sGr?=
 =?us-ascii?Q?niXqhtqZwi8LqfMnTGKG0HW1k13Tv++G2VjDYA58FuPuoLHhsC67d7SYs6K6?=
 =?us-ascii?Q?qSjdYppBrhibbGXQSWDLrcqg2HK1S5izK0q4MEt4p3G+qyIQEc9aOhGf+dNp?=
 =?us-ascii?Q?qS3+ApspvM1rCDe4/alEfH8wr3mhMt6FTBhI/0/IFO6qkeRpL/uCABMslfEu?=
 =?us-ascii?Q?plieJYG9AEWwBTRNrjTwSKhCr2Z/J5SLjbTkeSyn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jWrG8D5D8niaAUYxRWWDaGbhpwIX1XkPz7sgtNRDmmLRV8mIrb10jiBD4dI8xb+/zcZhGqUrCssmEKlQ5Vd7jPsM1tUiurCyYX5/Dha3YaclhdVoBMsL8uj122lWknj4BN0gTy+08sxKLQbg87bJmI/bC/5kj6bhvGxdyMqkIEU2xjGbjHqcAds4nIUAnREZxlcytoS48+97IfOd2xqhr01MP9H7h66Uyyercl1R9H52yM6BDqiKW8sYLijCtfUNrlTt4tssj59S9HRWIee7eNwH9IqOtLyv6Hc5sOVJOwq7L6BFmwxFmmpgcOpDbO3rzpry+mE9s3KCw2fSV2cETrIjoHrOyGz8xE91BvfUM3rpUxJoLuvJWKs91uaGyGan8PGCahbr2Ch9p9u+M5t+Z+aZbsvpZ6W3aLbGdBYkIvGtwHvxPHVpescxS9RpdO4HE85vcpCNgUP63Is7pIo62XoyGEDn5lfSc9shgZxkOgx39UZya4teGtw5M26lmV/PpIKeQYhPDp9UmghrthEwBgAGmy/kwtAHPsQdC6DSCboxxccD23lBVn1fSHteEvNsc2b3IuTrKoPbNdV7BAde8iMt5lj02Aojs86eQpZtxQE1bz1v4tr1jyTzMV4qNgbE
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077dccdb-0105-4f2b-df1d-08de26902788
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:49:31.4130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLiFeeEZRgTnNe1++cdULnF9FT7H4tfdZScXP5kOOlu3BSZeCnHcZ3zCLANgwkM2mx80bD5cIeVySRpnheWbrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1892
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
X-OrganizationHeadersPreserved: DU0P192MB1892.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=dr/Wylg4 c=1 sm=1 tr=0 ts=691c4f3d cx=c_pps
 a=Oj7/LPfRnoqhgsfYH6y4OQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=tVGQfdcHmBmzZXzbeHcA:9
 a=CjuIK1q_8ugA:10 a=PZhj9NlD-CKO8hVp7yCs:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: -X8cC_mRsfScy2s_ktGQDg0FmEpP9hVE
X-Proofpoint-ORIG-GUID: -X8cC_mRsfScy2s_ktGQDg0FmEpP9hVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4NiBTYWx0ZWRfX0tKieRKQdEXi
 YUk32tD+dKvBrOKHUcHkRq3yCaZo+53jpTPj3y8bO5lDqYW53gYpXCgc8lHl3ZsJm7IrNuaSoMR
 CsdsVlOl2EyniuxFcHtylxanDnkyJVEdZB2qxdyjtSNdETYv2RX3w/CQPIry6Gr95cm5+lo9fcR
 iuYerDy6EKHu69UWjlTx4HjLGcjii+qALnXkvIJhUOu+6fgnpYLf1u9dyjoRwV9Ge0ewcaCkE6e
 UYSrj5Bugq//I/fJ5uLIGgM8VmSR7sHvyRh3T78UPDtvhI0bSAQMon/D6KXB8Ve8JOEYo+Kwlcm
 kOjE1ulxxjZoHyVvWnbZG9uFegPmeFZEcX4qyf1WdM5zopaVfGk10kUFCuEJUjaFE36yF9VqDkb
 QAL+DT2l2SWBaaYJvhmYDd9S9nYHjg==

On Tue, Nov 18, 2025 at 06:43:44PM +0800, Baochen Qiang wrote:
> 
> 
> On 11/18/2025 6:17 PM, Alexander Wilhelm wrote:
> > The SRNG head and tail ring pointers are stored in device memory as
> > little-endian values. On big-endian systems, direct dereferencing of these
> > pointers leads to incorrect values being read or written, causing ring
> > management issues and potentially breaking data flow.
> > 
> > This patch ensures all accesses to SRNG ring pointers use the appropriate
> > endianness conversions. This affects both read and write paths for source
> > and destination rings, as well as debug output. The changes guarantee
> > correct operation on both little- and big-endian architectures.
> > 
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > ---
> > Changes in v2:
> > - Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
> > ---
> >  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
> >  drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
> >  2 files changed, 24 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> > index 6406fcf5d69f..bd4d1de9eb1a 100644
> > --- a/drivers/net/wireless/ath/ath12k/hal.c
> > +++ b/drivers/net/wireless/ath/ath12k/hal.c
> > @@ -2007,7 +2007,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
> >  	tp = srng->u.dst_ring.tp;
> >  
> >  	if (sync_hw_ptr) {
> > -		hp = *srng->u.dst_ring.hp_addr;
> > +		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
> >  		srng->u.dst_ring.cached_hp = hp;
> >  	} else {
> >  		hp = srng->u.dst_ring.cached_hp;
> > @@ -2030,7 +2030,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
> >  	hp = srng->u.src_ring.hp;
> >  
> >  	if (sync_hw_ptr) {
> > -		tp = *srng->u.src_ring.tp_addr;
> > +		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
> >  		srng->u.src_ring.cached_tp = tp;
> >  	} else {
> >  		tp = srng->u.src_ring.cached_tp;
> > @@ -2149,9 +2149,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
> >  
> >  	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> >  		srng->u.src_ring.cached_tp =
> > -			*(volatile u32 *)srng->u.src_ring.tp_addr;
> > +			le32_to_cpu(*(volatile u32 *)srng->u.src_ring.tp_addr);
> 
> s/volatile u32 */volatile __le32 */ ?

I got it. I'll fix it in v3.

> >  	} else {
> > -		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> > +		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
> >  
> >  		if (hp != srng->u.dst_ring.cached_hp) {
> >  			srng->u.dst_ring.cached_hp = hp;
> > @@ -2175,25 +2175,28 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
> >  		 * hence written to a shared memory location that is read by FW
> >  		 */
> >  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> > -			srng->u.src_ring.last_tp =
> > -				*(volatile u32 *)srng->u.src_ring.tp_addr;
> > +			srng->u.src_ring.last_tp = le32_to_cpu(
> > +				*(volatile u32 *)srng->u.src_ring.tp_addr);
> 
> s/volatile u32 */volatile __le32 */ ?

Same as above, sure!

> >  			/* Make sure descriptor is written before updating the
> >  			 * head pointer.
> >  			 */
> >  			dma_wmb();
> > -			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
> > +			WRITE_ONCE(*srng->u.src_ring.hp_addr,
> > +				   cpu_to_le32(srng->u.src_ring.hp));
> >  		} else {
> > -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> > +			srng->u.dst_ring.last_hp =
> > +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
> >  			/* Make sure descriptor is read before updating the
> >  			 * tail pointer.
> >  			 */
> >  			dma_mb();
> > -			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
> > +			WRITE_ONCE(*srng->u.dst_ring.tp_addr,
> > +				   cpu_to_le32(srng->u.dst_ring.tp));
> >  		}
> >  	} else {
> >  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> > -			srng->u.src_ring.last_tp =
> > -				*(volatile u32 *)srng->u.src_ring.tp_addr;
> > +			srng->u.src_ring.last_tp = le32_to_cpu(
> > +				*(volatile u32 *)srng->u.src_ring.tp_addr);

Same as above, sure!

> >  			/* Assume implementation use an MMIO write accessor
> >  			 * which has the required wmb() so that the descriptor
> >  			 * is written before the updating the head pointer.
> > @@ -2203,7 +2206,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
> >  					   (unsigned long)ab->mem,
> >  					   srng->u.src_ring.hp);
> >  		} else {
> > -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> > +			srng->u.dst_ring.last_hp =
> > +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
> >  			/* Make sure descriptor is read before updating the
> >  			 * tail pointer.
> >  			 */
> > @@ -2547,7 +2551,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
> >  	 * HP only when then ring isn't' empty.
> >  	 */
> >  	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
> > -	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
> > +	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
> >  		ath12k_hal_srng_access_end(ab, srng);
> >  }
> >  
> > @@ -2648,14 +2652,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
> >  				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
> >  				   srng->ring_id, srng->u.src_ring.hp,
> >  				   srng->u.src_ring.reap_hp,
> > -				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
> > +				   __le32_to_cpu(*srng->u.src_ring.tp_addr),
> > +				   srng->u.src_ring.cached_tp,
> >  				   srng->u.src_ring.last_tp,
> >  				   jiffies_to_msecs(jiffies - srng->timestamp));
> >  		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
> >  			ath12k_err(ab,
> >  				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
> >  				   srng->ring_id, srng->u.dst_ring.tp,
> > -				   *srng->u.dst_ring.hp_addr,
> > +				   __le32_to_cpu(*srng->u.dst_ring.hp_addr),
> 
> still my v1 comment does not get addressed:
> 
> 
> why __le32_to_cpu() only in logging, while le32_to_cpu() elsewhere?

Sorry, I was confused with the previous issue. Yes, I saw this form on an
upstream patch where '__le32_to_cpu()' was used instead of 'le32_to_cpu()'.
Which one should I prefer? I'll unify that in v3.


Best regards
Alexander Wilhelm

