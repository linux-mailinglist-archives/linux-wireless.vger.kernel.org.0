Return-Path: <linux-wireless+bounces-27476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C1B839BA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D93C4A3B3B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C342FF17F;
	Thu, 18 Sep 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="oW3iUEmS";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="rSufYzLq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F52F5315;
	Thu, 18 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185679; cv=fail; b=XOFmrDooGuduPjMn0jzaVoo4H49dewQ7bacbhrWHARQxY2ftXlNKJQLbkg1ibBSIV44SOE8ZU5jjzfekICAeWLbAjmJ3vdK2JPOP6EcjbKEM2Jn9B1ctS2fA1uclWiuC6fyLCed8j+crVOAJdNenNxoMKivs8qh7eyuPPX68nVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185679; c=relaxed/simple;
	bh=NgewLwlBUkjf5AFEaUiaumSilBGDfzIeV6qOQbqNTrw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UwLvzgpDVcLah6WYkFD7OjgtJKMcKur28/VoPci963t/rcHbeqcJmQODDTAh51dYWDgdT50QrbtDTqt1P4K/pYVDXETu5QymKwOHt0uFFGT6mpaXKA0AufIFpzaFwZOQjBDmXzBEEW7WiHIhQ6M5cCFNgohSQbmPNxZdW/khtts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=oW3iUEmS; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=rSufYzLq; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I4TIhM1538395;
	Thu, 18 Sep 2025 10:54:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=9jYPfjD418Z8mHzeLmkq7K
	gJZZiUxl4oAbLbyCFtgr4=; b=oW3iUEmSq38PHQPjO90mevcGER4HYPu/wNdrdX
	EO9Om0Ye/xOMOejSRmL3RLlsWzbc6ZizEqZMvJIAvdQT9oHTig5fQBdGnGUk+De8
	7EpFLXCMuXupPQS9Wct9azHRqenEvoPoalZMVfHDMd8vYhA8u7PZMSxwfsRrmJp5
	jl3Qp1gCJ/e4fat0UI78dKvMepWkpKIVRqgHtF6UtJ+hs1eLfHc2gvZ7rG7+167S
	j7KucalVKbZ9uK/5QHdx6b0ZivpGfpggdWasbyjyCiwAhNcmTNb2lW88FrSDdlOR
	xuAiJoE3qpbaQ9scIzzMoBErnrtzNm0QPcsoTo4UlGrJWcew==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd2t91-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 10:54:16 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUPmrXGPJysPnOs/RLsLgIRwOHmBVKeZrgNZDGMZZrqy53pMoWEER6Qf/EuaAYGXHPIjPxNXt1OVDKpqq6MdtE+NcE7b6q2ofxLwZVZnQwAGjQn0WgrNDuhRSt3NfIhGxtPLOT/qBX8tuSLd8ZSCdNJJtiHExEIMbjMs7n710K6mj+1yJBpo2Ygi7EJbST3WkwLxKWAAalV5qtDOOcbRBnSngmUYO8BrRbbLrhzy0/irp3UGoWyDvCbnQ85wmWnAaICVdEhmWqozieiPUe+ro2PqiFp/jXSSN0W0iXL8DDxnnDb3cNUPMPA7jwadcatF+wBaWAhb1e4k7uIKskM5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jYPfjD418Z8mHzeLmkq7KgJZZiUxl4oAbLbyCFtgr4=;
 b=cWisCAR2NpKGUXdjAzxvTFV8ARfAdoVfr488xkrvq4556y1tdWHJ9gPDzgqSmy6PXIHAcBq9f4HBYfjqU4PGada9lXKIsfFpFEd5KQHKdlGA96FgPjkhddkOqq4WBxvXGUBsSg2eGnwPS5r1z02rTT0gjajqWUaFsTFPtfqHsJNSOeKUrohqRtKsAZgjv+8HYRjuA6B09lSNGCUMZIqlAs53InUnxP2TIuF7A1rx6qzC3GY1lKKhO6srHr23G7DNMDIHLP89zr/HmDdal50eYzmoM+t1DkcZFkvPlcBrJ95EDvKgm4NqGGOyLLD7VTndr3Q5Qx/ypAPX34/yXys6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jYPfjD418Z8mHzeLmkq7KgJZZiUxl4oAbLbyCFtgr4=;
 b=rSufYzLqVI44Ye2lC/38xhySttBcJ9j3jVwMT8BbrqMIM1k95XQFZtwc5JqKUw8HffDiDsj+RCPReOwm4uiXBR7B/CTaFBTtgXFDm/7VRKxQ/IC+a29ygVt4ZZbpZrf81S6GHIaIxfsLHixknYt9ly/X8uPRUANT4ReVsr62nRs=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI2P192MB3195.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:54:11 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:54:11 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/4] wifi: ath12k: Fix endianness handling in QMI
Date: Thu, 18 Sep 2025 10:53:55 +0200
Message-ID: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::18) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI2P192MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d21b4a6-d8a5-4c6e-7690-08ddf690efc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mEyDYpVTaP3CArhaUvVSIPa/Oob/u9RrZZR49jpOFGsurN6FBOj4bmtkKwrH?=
 =?us-ascii?Q?j2XKcWvMHuJbjrByWnXagtraMyUXSF9/hCe8OeavMyJt/N9UabYvmVI/lXkN?=
 =?us-ascii?Q?oueQnkwNiBnrTWzBm18m3vtd/vP69BcLQioKuJbo90mgg/jFevv3gcsZgF9a?=
 =?us-ascii?Q?teQg0hlu6rAiOjTeLMdNsN3Ja5PvMeEC/yYZdi69Gkuj+U+P3tM3NsHB487i?=
 =?us-ascii?Q?IXzP3PAW+OVokYUbIuJEQSl3uLrYF7IIAkP/PkLHPg3RkW898jZJGMNtU6Dl?=
 =?us-ascii?Q?WENAKQGCXuVAxIBIoV7bm/jmMG35k6cQhNlxbgt2RChTa6C23ZNEk0Oz+Kav?=
 =?us-ascii?Q?ivQVikVCVBg1k9dm0Qs2/K2QnkO7LY+DREZoQ1r2yJkaTQkKAo4ZsgcG6lu6?=
 =?us-ascii?Q?KD3qAGc9YRg8YC9ag4947pOGzQ/UANtp/Ym5bYE4pG5gB8ebESZaH+gaJb4a?=
 =?us-ascii?Q?msk2eOnnkaKIFshrT7andHBg7tv6a8MREA/1nPtgvXFLq+Y+NPTWvlHGYLUx?=
 =?us-ascii?Q?Q4OHM1WmG4KfrMdARBz3QGxW6pShf9+/eDh/RFItSOPSKrC3sPOf33O/vin4?=
 =?us-ascii?Q?EY2DPrzTXtCiQnSIJ1ktb1nXllS08TsYdPpbaETgXlN+NPcE1ebno7FOJHmD?=
 =?us-ascii?Q?R8eCeXI86iXJpe1AIvsL2Ccn1qncPHiZb+U1mF+rS8grCl1gAmPu4QZ10sSy?=
 =?us-ascii?Q?qp9kS+XUOYC+UOm393vZ2cwXlMaMHhupSis09PMQ1ADiKg2zQd7O3W42sw2O?=
 =?us-ascii?Q?IK3jqOZl8CP05pAr3eB+6qIER+jxu+YFnVXRYAtRH16NrE3GGSOB2dl4tbgs?=
 =?us-ascii?Q?5X5on4NW4yB8ze+pr1LW2Nzak0dNcB2t+zQ2+lqzf84L2ge4VSsxm/DW3V5n?=
 =?us-ascii?Q?ZjO52KYBw1kTylC63H17+9gyw9/ZTG0PSuspFesRKv3Usd3e6QjJ+cQnr0Gk?=
 =?us-ascii?Q?uuGWNeVJo7u8xSIjUjUtwLwHeqh56eBSv/SsX0Jtir2fYdxi0eK8+xcbYk3E?=
 =?us-ascii?Q?wWBjPaiJcnJ9A7OPg4CQnB388oc+4/myz6gimOR2ppG8873sOme3v1maSwgG?=
 =?us-ascii?Q?UPEvBp06BthWMT0msPOruorJaPIZgSuxDEbQ25En/JqjkxEYIM2nxoJWv62y?=
 =?us-ascii?Q?N7RvGpk4IOZQMpIZikP0Ux+jT05MXPlvVdDpXCSJEH/EMNdQXzVqIAV7eugr?=
 =?us-ascii?Q?P+f6/WLBOXQUDcbtjE67xF/Cfd1HRggIk79MYW0TyMKnR+jVP1VXiLFCSu3o?=
 =?us-ascii?Q?FHYTWVt3jCzpLWZ+nJpD9Sj3Qt1eUozJ3MjEctQXciQruq6EsIGpuseDIHXB?=
 =?us-ascii?Q?k5dp8t9GbsxBcZAJHfcy2tFFla6ALx0GFZu/wGitu0KgalcNCODskFDIptkA?=
 =?us-ascii?Q?vNE6zDm7M8rLTqr42qwMZGaYOsUvPFjgMDntL4nKXZOdjO7Z3A2ABlGyP+SH?=
 =?us-ascii?Q?H+/rswaCsCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwsE6TwHCF3M6iuShXYiiyVv03S2Oxab0jREAdlLWX27jWk2DHWruxGIxXA4?=
 =?us-ascii?Q?+BXad59rkPFFHD/qgkgtRVwJLROvT5GVjXwG13ApZtm49Os+91mjqHliVtE1?=
 =?us-ascii?Q?mQYTOBchf35NqIP3k1Q6qTY7cSZ0Qlt+6ymcx3vzwBvZ2psdbl2gmcZwHM4n?=
 =?us-ascii?Q?3B1KDr+vofxmvRPDI3aqG2LTufOnQY3ReuSxyhE+gGaSt5euLuSgUPOuc81m?=
 =?us-ascii?Q?wShe2rFxbXv+HOe4TYesDTJurIuq1thxI0ZtPfxY1vYWUKaUVaWNGA74JLJD?=
 =?us-ascii?Q?ZI+Jpwm2UeXUrpHXWM2YN9ot5zwPSxAjuNdSmN/RB/HbSwqiMlhVA/Zvcx63?=
 =?us-ascii?Q?jyb60h0sURUi/E78sGjK+4BXVI2++f7ermK3VK/gSnfJ8vEOdP5FmmUu4qqk?=
 =?us-ascii?Q?Fp7NWHBbqDSZSBodNlm4hOxGjiEe5UcUo/38jtc9XUJwbSQjLdQk8tbGknlR?=
 =?us-ascii?Q?TY6HUBNIB8Xk1V2YcquaYhFRsL0bzkh37fqlbiQE40wKk8KKIzRE3H8+o689?=
 =?us-ascii?Q?nLRK/lVtbqogxsiCYStNPnDYAAipwwJyXfD95O8q8JYigLHjBmTkwVyoRO8Z?=
 =?us-ascii?Q?jyaKiPwJw1JT2PqhrCU4sPfTFpXN7GmxKmI4Aq/n24/UG6huA3q8DaJsFz5l?=
 =?us-ascii?Q?ujFjEgfS8pbbs5fqMWjBWev/JVvoReuYHwywaoiJXgG/AXxevWGIhWCuIx6k?=
 =?us-ascii?Q?EQBDOoVbkBNGW50hfs4Tx5ZEjlXTo8tR85iAk3cw4q0s1ElY6nWZZQILERNV?=
 =?us-ascii?Q?bQRQpGRX9Qv9shhuGCOHIiurZ5qxsRrKCcepWlcJf4ykDKt0SZ+ANwkv2NXL?=
 =?us-ascii?Q?XrO+QNDVZRR8KnlBN7VyPR4QFZjIBqg2nbfJOpUwnd527q2pK9ELJlYIWN5I?=
 =?us-ascii?Q?EnTwrgycmRfjhyaRAspOg7t3de1qah7yATrkrLbYvIV9flqY/KJo1NQbzis3?=
 =?us-ascii?Q?UMMZBZJra7yBgB5txANELqqDIWu93HcSFOSX17hG4W6K3Oe5esAfdeEVYUqQ?=
 =?us-ascii?Q?lfH7ywmAbH5k913iUR7V9EZgwrE45j2QsHoItRncW6GpXS6GW18kR06Cq7u8?=
 =?us-ascii?Q?GdVFQwqFutMbHsxBHI6L9JA4FRl0tSGSuLeuU20rRydgSCbc4jsI6ga7CZu5?=
 =?us-ascii?Q?wu2aceEMxK0oE4TnBYZ/pZWGHffBIiMYCTwS3mUqFgjqIPQfxoBlp5zdg9g7?=
 =?us-ascii?Q?BcssSUYj6nNKIhX20B6E6uLF5mU1jKKD3gOU1C1r/pLzpfsQGQUKcR/T9X1Y?=
 =?us-ascii?Q?lWgRCRunqWMqiOk+BhmoqCj0q4c9I7evASGENM5SBeNUmdA7g23AQ2UtQI7p?=
 =?us-ascii?Q?23RvDJz+uLtOdYsWKLE0ZX2t0PFxSsMYERVWq8bPiduHH9snkJyow4qf7Uk0?=
 =?us-ascii?Q?jLVitq5K3BP+57b7WRbK5p23JwIsfAZN6eCwJ45of00U3nxoazijl+c4RfPS?=
 =?us-ascii?Q?eB/BYU0DuSC91f95bMv19vdIOW9mkBPsdAai5ZUYgeoA+ZbxEj2BHd30xXMr?=
 =?us-ascii?Q?eqRMopD/0/h7vrYbxXp0lz0//92aoLyubsL7sNNngrlkOFjqdKqp6GJ0ux8Y?=
 =?us-ascii?Q?wM09jAiZOi+LYJ34OZex7a0QpmgUzPfzCRscGK3w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pK2FzNw3azkiY+68sQwzvuVV5bVzr6l0VnHijtPqq1cRxmJFeJ4CuusrD+1I/aJkIPsTbCaiZHDJR4F/VaEF9uQTZ24EVg3SWnovtjsvgN8zW5Yz8bkwY6IOUcFOCfjZLTb+TAawL0wpdy0yvpeDmQqfuLHOjeBExpykBH826jhyyDlgUyvsimcqh+7wGguXjldTuqKtOvRO8bLFjKDeNpcrBGE6ECej4SMa17Go5ft1wOTU31SdHjbWUDMdtjHD0yGtxhd/etO3t6lhEzApLns9sSKkTcM5vt0EPTH3N/COoOT4Q/pjSN9Qxk0DvhNbjIL4Zg3xUounL8LfiLQkR9U02Lp9fXDLhWwebX6PWlw5ccAg1u5wlNfnFjI9LSorBtKmT1gCGv8zlUzs62WTZERB/2gjbPaX9r7HE0LFYvR0xuISHg0N4L8HqM/SPtCd0JfO1zZRz3N1oSZ/cRNJ+PhqFx9bwE1v3qCinp/NyeLS6ai9MGrCklVXTDaljGhSn6gag0kpjiD7N9QeYSBV+uYfqRyNfKalV/3VAmFPzTHBBzuNJH8bkiR45I2zv09xR7xnnwU+dLFRlnK9CFZiBjGcknURZ64O8Y3Ayxa3TRhhw1lWs8PsXSgl/Q2ULYHu
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d21b4a6-d8a5-4c6e-7690-08ddf690efc2
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:54:11.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goFlthasZScIUluHIZ+G7VJg7fmBWomv4dHuMID2BU6ydeEksfGSRRkB97wUOmoN1T0Qqb+ScHve0hj0Sux6Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P192MB3195
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
X-OrganizationHeadersPreserved: VI2P192MB3195.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68cbc8b8 cx=c_pps
 a=oHpv3qKjZIMSKjhKdcSMwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=Yd8HllbCdjvYV8kqp-4A:9
X-Proofpoint-GUID: _WjNSLqJuoVudJlqBpPvs87N1jSWbtpp
X-Proofpoint-ORIG-GUID: _WjNSLqJuoVudJlqBpPvs87N1jSWbtpp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4MSBTYWx0ZWRfXxaZIIC3j8rI4
 LxS4YXi/tnc2meVctz9ssMvWP44Vt4dAe8CNRZpyUVfGGlbzCBgoUjdzyrNcX3dx5RcQjxvMgPT
 /pZsVyyPFs/XyNx0RphA0zjnDjF7wXoSIJMpqjoJlaM7V4UPQfSFAw4buLgzaxhSMuhtrn2vNSw
 NclDR/KAF3vZpNMzMhKfMUhkjiog4DWSFbhzDc3jdngWBABxbUpz9tsB0dM2F2ELlyYfteNK407
 DdQkAbfBhs8TERI4gPRgotAzEIxjMRU+iebpnmcvL3q6kdCA9+/vdXR2b82zE8htWdVjPUFyRTk
 I8AL95fuCPmQOHIAL4XqnHzSJFdat1eiyVpVSI/exLFlM3Qe/Z7KR64dAaglOA=

Fix endianness handling in QMI firmware transfer on big-endian platforms.
Without this fix, the firmware download fails due to misinterpreted data
structures exchanged between the host and the wireless module.

The issue occurs during early bring-up on big endian systems, where QMI
messages are not correctly parsed by the driver, leading to failed
initialization sequences. Ensure all relevant fields are properly converted
between CPU and little-endian format in request and response messages, as
expected by the firmware. Attached logs showing the failure before the fix:

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
Changes in v3:
- Rebase on latest ath master
- Using a generic encoding/decoding macro causes sparse to complain about
  type violations. Use separate macros for each basic element type instead.

Changes in v2:
- Handle QMI conversion within the QMI subsystem instead of the driver.

Alexander Wilhelm (4):
  soc: qcom: introduce new QMI encode/decode macros
  soc: qcom: fix QMI encoding/decoding for basic elements
  soc: qcom: preserve CPU endianness for QMI_DATA_LEN
  wifi: ath12k: enforce CPU-endian format for all QMI

 drivers/net/wireless/ath/ath12k/qmi.c |  24 ++++--
 drivers/net/wireless/ath/ath12k/qmi.h |  16 ++--
 drivers/soc/qcom/qmi_encdec.c         | 101 +++++++++++++++++++++-----
 3 files changed, 108 insertions(+), 33 deletions(-)


base-commit: d9d70d689fb6b06a59d95831981258729cbfc209
-- 
2.43.0


