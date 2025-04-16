Return-Path: <linux-wireless+bounces-21580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86851A8ADCD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A61F3A80F8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA381A08DB;
	Wed, 16 Apr 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWOnWcd6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6E15E96
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769048; cv=fail; b=IeBGGg+XIqX0w89jrzG6flgSQKJ8s9vk8cA/HdKm5CLOI+6aT73nN0wjX65FKeViCPhp7oMFmxPKZT8iT95am1S7UucTWmFDZHNbqM9fmpF42co7Wqhw94nugVUyC1kybXtepnOY1Jy5zwONvXVZ3QXjDIJNqh/nlDOvDepO/kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769048; c=relaxed/simple;
	bh=cN4L3P5kQJ6EG9Zp/UBkj9Bv5PvlHBrkiiMfI2Fapgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dwUUBYYN4GFIS0mTCyGVn0Zn9iU6wCIyXkwlToPbPwiv5vxIufWHY8Ib1PLeRGu2Z5FBxYNwM4UoSwiU0VdkVRLGQquw+u1DEUg/te8sECe59hXRNRBwP5Prdlw6jfj+2UzuWZHqhX30k5ZiJvj7x37/Qm40W16FPEgWxbcZvLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWOnWcd6; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FJ5wwp005855;
	Wed, 16 Apr 2025 02:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VvdlS96EDUB9v9Qt5g679WhffP4yWE79UR30dEcAPSE=; b=PWOnWcd6jO327L9i
	kzkVO/Xtk9dqzxNCqMaZTdJ/C6EQG3+gHMmP5KQBN/OGYVA1zVBSjegw5VwmfJba
	QE7KVCbMXOGAvIq4/Z2VTUd9eeItF4FaaQ6vAJE8W4vPIPnJF+YrXIHTIEp9O6fx
	h900fB+HwUme/S+FULbyUBSPJAr+wXpVTgtHKIOzenQ1GKEFu6Jsp0lbA4KR6WH3
	p8iRY62akOfzxGSFuSM9ybi08CZSq9VAM0CDk7LxJZJ9SbJFqvO6w5qCkQ2NLHDc
	flGbxXrY1KHp1GasnRZTM9Z67HvkvRraMRmuLQqGZz6X7Z+tK3LTb0apLNkk8QV6
	Lu4LvA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvja4y7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 02:04:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tN95drvTzshxk9WioPnV5XEMSPVfB8sTR6xs/C/YgGVezAlULB9DVWxFIvIj7ksJTA0kRTwoD+U62D24BkuxSJVIO4eN+WKMLO0HPMyZu5GrRv5IGfk/myPtXZXlqNiqZbSpcg4VHLI75G0bq5x3BrCZzoakjdOWqSMxq0pT5LwQmovWoumug1D/P9EKBp0zdGKgGu+Udu4qo2iOIGxCvkeUr+kMk8wBrgHBL4EaW0dow0yBPFqvMxfewlsLgqg3EaSPZ9U4epk7E7i8BKplR5JndKeaqvijv8xXXPDajlNwmqV8USlPpu/1VlfGlTQMJLhZTXZMsbs0WQ51eU22jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvdlS96EDUB9v9Qt5g679WhffP4yWE79UR30dEcAPSE=;
 b=OoZkx/UDsRKLc3Kvo5YAiuEn21ETZw4G6dNbqPPREuzVpjoKSMtxNFfg73HkoPgeANnanxWl782J4L828uQXDxPhH9D3EkAgecC8FC374dJ0+LMTMZ9exvPvMghIkGaahOb+nLKw2ioMG4L18pCK3qmlyCeySGXe2jRgI5tpv92Ee+RovU+dKRPcdUW4IY5fSBbVEHM/fjVNFMbes8IBSUfD3aFNOehMH57QpZZjNEgsSLsBRGHHRvnnU/pgl0Mw2xmA2UTbafO3uy0IeFBZiY6stz3k5CCXsQWev7ijflbB2BL061oGVF6UjOGMOnhf3ZS7nM/Il9YDMFDwtISTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SA3PR02MB10083.namprd02.prod.outlook.com
 (2603:10b6:806:3a0::14) by CH2PR02MB6918.namprd02.prod.outlook.com
 (2603:10b6:610:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 02:03:57 +0000
Received: from SA3PR02MB10083.namprd02.prod.outlook.com
 ([fe80::1b09:fb03:61a8:a84d]) by SA3PR02MB10083.namprd02.prod.outlook.com
 ([fe80::1b09:fb03:61a8:a84d%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 02:03:57 +0000
From: Maharaja Kennadyrajan <mkenna@qti.qualcomm.com>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: ath12k: Prevent sending WMI commands to firmware
 during firmware crash
Thread-Topic: [PATCH] wifi: ath12k: Prevent sending WMI commands to firmware
 during firmware crash
Thread-Index: AQHbrnOMRrOVkOMVBEmvolYh9+JCE7Olin9w
Date: Wed, 16 Apr 2025 02:03:57 +0000
Message-ID:
 <SA3PR02MB10083899ED181EBFF8A4808EAF0BD2@SA3PR02MB10083.namprd02.prod.outlook.com>
References: <20250416020138.2161484-1-maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <20250416020138.2161484-1-maharaja.kennadyrajan@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR02MB10083:EE_|CH2PR02MB6918:EE_
x-ms-office365-filtering-correlation-id: a78ac120-8474-407b-2c55-08dd7c8af2d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q51wazrGNnswbSU4XEgnJ2/ftUME/A4qkjMMUC95ZCCxA4ew8zy8Wj8d+r6r?=
 =?us-ascii?Q?Y9SS/lz5SUf/Iy7g+lrNpojCncgjiLyXT8rG24DJxM2RQmv+1GdTAvQ7S80S?=
 =?us-ascii?Q?W2NFT5Wjszcs8X2qVXHv/VNn2lC/vZWY/cGfWSWiwgO8HBLbcLppjs4O1n1+?=
 =?us-ascii?Q?Gvz8YY0vRWbh+KNwl9V9lvglTmAgwuAI8cOJ+PnSPpjK9vrhIYZr4rLo3I7q?=
 =?us-ascii?Q?oEelKjCoC5Lr/gFX1VkJfGZOb8jwBIBGWuHspLPWXUEmOzS5jZhl7KQTT6NR?=
 =?us-ascii?Q?zPgS01Qxmbk9Oz8uSw2EHl5KOez6dHA5S8TrXCTBYuJLISSzOqh6A1TKB9JL?=
 =?us-ascii?Q?CaxOqGLt52J+fMLgcApDMuO++y4W+U+SrN/QxUZx/bzUNkYd/K9UXZr3sSgz?=
 =?us-ascii?Q?NOmJRlpZVTVmbfoGGt9REz9b0LP12l1ntb24hXRyXBwAF1deKgm4J2j1VP4a?=
 =?us-ascii?Q?l2fojOCFGdNrX9V2aV8pOWsg4bzQfOdWmO5TNFUNWnIuMMl3Ro57tvUdSGGg?=
 =?us-ascii?Q?PlpJweXthhP3TOO4WGJb7stN30gaCJHiF9uhpWgTwHL/9EO4SA4Z7T7yNdab?=
 =?us-ascii?Q?MV8B2fkNFtkI8PcS7d2tJ3kVJK7/pgtWxHXLoCd0KghNtfgBLynivrxNj/3v?=
 =?us-ascii?Q?gWRjVvB4Mcnvo6metMIBWRpnR11qWGqr31mLNDE3NI0eJ3E9YuavUQsGEzRA?=
 =?us-ascii?Q?Fa9UXi5vl5SgMZZWzpkL56OhBTZq5IQ+R9rfM698MQUnPuSj7qvk70GHulMt?=
 =?us-ascii?Q?LtQXecn1cw3iGWhsUgQR6MoeecCg5rgHIQ/l/5cj0Ni3xy2JJS4T80Orz8j6?=
 =?us-ascii?Q?GGFsboc+2pLVeO0rNuC9OBI7PsvPlm9/7Gh2leAwal+eFkETkjdQ4/cyzICk?=
 =?us-ascii?Q?QKXC5rz3eH2/KxXTf2Jkk6TbrlMeFBDI8Lwxbcv2vzgOcTB5bselj5JEXWpJ?=
 =?us-ascii?Q?PoFBN1yJBfX1MI/XxTY4GBTYURJvAklHE6H0oeby8B07utGJ7m9/MgosC221?=
 =?us-ascii?Q?K0hGMRZWR2TD9Y0GgbmIMdKTTfeiGtvnn3+6NdnqLLqMp4tYabUkLMBsAKiq?=
 =?us-ascii?Q?NkjnEf+KVhdPaabOc5DFhoS9j8c0xbwAvOZr6/jHxHXnJJ7IA0CYT197oWXM?=
 =?us-ascii?Q?hFnmm3n0me+yIMoczsSrjA27MLYAYbMbGPkswPFoZs8n/AcPjPy7VuRgRrl8?=
 =?us-ascii?Q?Lzy3BkY0eYSVu31LgWxjz905BTYo+B6HyHcBmcLWB6dZqr86VoX5JC9ewCQ2?=
 =?us-ascii?Q?yOBjYiFO+nqsmq4mMVOOU6VNH6ua3gthncIXBI2sdsmBbvN3lMRJcUYuuFYI?=
 =?us-ascii?Q?bJ0NWB7oJd1AkXmW6L6sRXm+tPXIlgy0KzsIAY1A+9co6LtMAuwqsNbh+CMU?=
 =?us-ascii?Q?nfKuVwqBZRyEO3141IZ6rOkACmepP0vHeFxFSXPa/xa7f0q73ybn8IZzrX/V?=
 =?us-ascii?Q?M2SLs891OjpPJDta5vPBNAxPQyKilh6xRSiAJvgCG2NRpGWziGQrm9knWZMs?=
 =?us-ascii?Q?BVnFtFFokQkaLTg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR02MB10083.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ACKlFNY+h7UdcyuSuO2UwjQvbVwQNhP5IyBkvvM0If9nvlIAoEkOjF/Nq95W?=
 =?us-ascii?Q?+uOpQ9a9+sgVDWfpwQe0UPneALbCdjdVDYmsrqjtWr1ldnscTb5vnnsFcg/y?=
 =?us-ascii?Q?MD3ZxnP9NMgLpaVupmQWaDyWPrtSoFx+8N6slZyOtRnTjcAexcnkozOLPefE?=
 =?us-ascii?Q?LUEhd+ehEiKD3ZZt88MJyJnD39UaPGYUa1FvAx3ghppkfcIApIhWXxsV++K8?=
 =?us-ascii?Q?DbIqVriZDWQ0Ek+MHNw5NNAdOq0NblDNQ4u5FE/16eZzpbTeAjqLgauZB6B5?=
 =?us-ascii?Q?+mCFv9DtnH092nNgOTPstHkOpcj8ssOAQfo2iZn+ASYezsxcVctDBSgOZ5/v?=
 =?us-ascii?Q?IXvvsmP4WbMpLVDstBURPl/2vt0U+i+su4uzKZ3H0WEbXBiZ+nPyhR03+Bwd?=
 =?us-ascii?Q?msMVRfyvwYbtk0Nmfje1DXvvZKJtQFo5V2s1mNe8wBLT7NbuHXQbatklouAB?=
 =?us-ascii?Q?9atCMuIjGUA4DRtP4TOu3OwAHejsY1H2MiBXrjFCLt8DBOeCbCK/osOzhOK0?=
 =?us-ascii?Q?obRO2pFyO78xxX/znTos0nGcDpIlTWlKX9zjNYVzidbspmUmEiC1ZHQsgD5W?=
 =?us-ascii?Q?RZf7bNXp4N5ufI4eVNP97BD9J4NrSuHIoC7jCxZG6De9J52o/mF1az4jJJzF?=
 =?us-ascii?Q?sctSHowouTrQO7sBWNdq1MIQbEbC/yQPqzcXSyxSSdAmif+Umm8rz9zSONn1?=
 =?us-ascii?Q?z9frZ74kjvxuQEca2Th95ZskxvLWXOz3XRxbMwIBeIY/uQ7WgMFmvdi5TarV?=
 =?us-ascii?Q?Rvg893FUk4AK4TyJ7ROFZ8HbRGbqmwY59tsfbFJkSsBfU8MyGsetVGNJsyuJ?=
 =?us-ascii?Q?HvkHEnAiQ5KS6oAOh8itgmdtMY389GoJ0LEdenVqwdwZYkM2O87YrBUATkqQ?=
 =?us-ascii?Q?/myIp6t8AEZ2tPZYRN2BHicf69DYIV2pBkdHNBKpgpbzHosiy2bT3UkkSW4A?=
 =?us-ascii?Q?Bp2VB/n1C0W6oQRTCsUdvFuVhGo3FwXq5L3buWRTUOIefcLwCwT3YUOeCMAJ?=
 =?us-ascii?Q?uPJAwuoqOpuH3KckO5ahNnjC/JdmMSYHMGYdUJAwi8s19pXtwCj7T1K6D8nN?=
 =?us-ascii?Q?Ljhv1CQe3RxwppWqWStp+xUwaLXyL2XMfeaJ+HUKl9HDVks6iIBLA37PkM8o?=
 =?us-ascii?Q?RZz9p51xcV0pmu74Y4hpdG1B0VNuBFhM2igj/aLkBBl47O2F96SwuC5wOntU?=
 =?us-ascii?Q?g2ugs61fHmGB6XEVtd4Gy8Zxolv3xu0ap5xqogF71SnXiXZLLvCCYzM/KSNT?=
 =?us-ascii?Q?suHWQnGmcQBXS7HmE9p7IwG1FkvswVOZp6qt9wWWEyOdwjHWRSnQ71myC/rT?=
 =?us-ascii?Q?tVecX23AfB+7Q0uzganV2KT9cms8DRfeWKPskKV5Q31HjzcuRpANjU/DyzKb?=
 =?us-ascii?Q?zm1I60jWnZA/0lCi8pC4cUNZuM89nmXATtu3sM5+SpBN7FA0qqkIrTUec9qq?=
 =?us-ascii?Q?XC/OZarkeFzpZCY3kDEhCjlYVPaXDyKYa/VbGFONirwWkCAleu+M6CBvMi5L?=
 =?us-ascii?Q?ftTc0GieDOELBhWfOae0/GOQ3eWMFjtlZd5JbNUmUOWzs3VptBTXoVxupWJe?=
 =?us-ascii?Q?5nzux6D//ZvZpASFgfOVGSunew5AuK7vof0BHSmZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pv65/yCteueYeWEVteJ/0naKVudNpZQotjTsOItFIBttqFzRkXrdPg4NwhrH07ljtqWPNdMk7tIGI1Ak8Yo/JH+YMD4uDS7C909HIkka3do0t4ypjPHU/7/1+hOJHaQSNmTMTXs37krJs2pHYJ4+ONt3HJUCqwZZhNLlZTMv4Azj1L0zoag8l/AgWIJ1oDwsbKy2IdxApiJrW4cDDZPtwXj1fCnKKvU5wXznG6Y3nqLdz4zJYQmxNFO4VcEAbxFgzo4MPKi5Bk2cBCcZbuD5eTJW4a2oU+V0S8H9ogU9HXUdTE55/NayN7z/iHbAYhkTNg9pV58x3vmVDBB7ogltwAd9yYhqGtmyFdegj8tVyuY+0RRrzX64CSI48m34TMeOIwAh4kWmugF79PMfqSHa+hKT1vWbxuLX87CA9RCL4HW3CKu3x7UC21WS2LwysBKFe4tsY2Uq567fg+Z3nXVXqJgh6oxDq7pEbZxH2GGkn4YzjpObVIZegJmf7P33nIrYS1qBnNOZRkTbN935rLDddwH4PU1HUQjgWGVHMYObn9VYYoos/0Aym/vuuj6WqWLMZMVE6in019M84FtwDXwzqOeOqWRNBvwktwNlosQca7wR69+dTWEa9XiebRf9W6GB
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR02MB10083.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78ac120-8474-407b-2c55-08dd7c8af2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 02:03:57.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZlCpXdPWxPvxI6Rea+/eAsCWMV8hsop7S/jL3RzU/M4PdKK9PacWqCmxlM/dgKn2Pkil8Xz5q07MKWci1oa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6918
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67ff1012 cx=c_pps a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=nNx5oXLfKy-Y1_yJJCYA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=vUsbdJjsiYsWhgVz2Rkt:22
X-Proofpoint-GUID: dkrEy0xGtmgYsQdBq-d-esxqsUUOJOsH
X-Proofpoint-ORIG-GUID: dkrEy0xGtmgYsQdBq-d-esxqsUUOJOsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160015

> -----Original Message-----
> From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
> Sent: Wednesday, April 16, 2025 7:32 AM
> To: ath12k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org; Maharaja Kennadyrajan
> <maharaja.kennadyrajan@oss.qualcomm.com>
> Subject: [PATCH] wifi: ath12k: Prevent sending WMI commands to firmware
> during firmware crash

Ignore this patch as tag is missing in the commit title. Will add this and =
send in next version.

>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Currently, we encounter the following kernel call trace when a firmware c=
rash
> occurs. This happens because the host sends WMI commands to the firmware
> while it is in recovery, causing the commands to fail and resulting in th=
e kernel call
> trace.
>=20
> Set the ATH12K_FLAG_CRASH_FLUSH and ATH12K_FLAG_RECOVERY flags when
> the host driver receives the firmware crash notification from MHI. This p=
revents
> sending WMI commands to the firmware during recovery.
>=20
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x75/0xc0
>  register_lock_class+0x6be/0x7a0
>  ? __lock_acquire+0x644/0x19a0
>  __lock_acquire+0x95/0x19a0
>  lock_acquire+0x265/0x310
>  ? ath12k_ce_send+0xa2/0x210 [ath12k]
>  ? find_held_lock+0x34/0xa0
>  ? ath12k_ce_send+0x56/0x210 [ath12k]
>  _raw_spin_lock_bh+0x33/0x70
>  ? ath12k_ce_send+0xa2/0x210 [ath12k]
>  ath12k_ce_send+0xa2/0x210 [ath12k]
>  ath12k_htc_send+0x178/0x390 [ath12k]
>  ath12k_wmi_cmd_send_nowait+0x76/0xa0 [ath12k]
>  ath12k_wmi_cmd_send+0x62/0x190 [ath12k]
>  ath12k_wmi_pdev_bss_chan_info_request+0x62/0xc0 [ath1
>  ath12k_mac_op_get_survey+0x2be/0x310 [ath12k]
>  ieee80211_dump_survey+0x99/0x240 [mac80211]
>  nl80211_dump_survey+0xe7/0x470 [cfg80211]  ? kmalloc_reserve+0x59/0xf0
>  genl_dumpit+0x24/0x70
>  netlink_dump+0x177/0x360
>  __netlink_dump_start+0x206/0x280
>  genl_family_rcv_msg_dumpit.isra.22+0x8a/0xe0
>  ? genl_family_rcv_msg_attrs_parse.isra.23+0xe0/0xe0
>  ? genl_op_lock.part.12+0x10/0x10
>  ? genl_dumpit+0x70/0x70
>  genl_rcv_msg+0x1d0/0x290
>  ? nl80211_del_station+0x330/0x330 [cfg80211]  ?
> genl_get_cmd_both+0x50/0x50
>  netlink_rcv_skb+0x4f/0x100
>  genl_rcv+0x1f/0x30
>  netlink_unicast+0x1b6/0x260
>  netlink_sendmsg+0x31a/0x450
>  __sock_sendmsg+0xa8/0xb0
>  ____sys_sendmsg+0x1e4/0x260
>  ___sys_sendmsg+0x89/0xe0
>  ? local_clock_noinstr+0xb/0xc0
>  ? rcu_is_watching+0xd/0x40
>  ? kfree+0x1de/0x370
>  ? __sys_sendmsg+0x7a/0xc0
>=20
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-
> QCAHKSWPL_SILICONZ-1
>=20
> Fixes: a9b46dd2e483 ("wifi: ath12k: Add firmware coredump collection supp=
ort")
> Signed-off-by: Maharaja Kennadyrajan
> <maharaja.kennadyrajan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mhi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c
> b/drivers/net/wireless/ath/ath12k/mhi.c
> index 9c929c4ad8a8..08f44baf182a 100644
> --- a/drivers/net/wireless/ath/ath12k/mhi.c
> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights r=
eserved.
>   */
>=20
>  #include <linux/msi.h>
> @@ -285,8 +285,11 @@ static void ath12k_mhi_op_status_cb(struct
> mhi_controller *mhi_cntrl,
>                         break;
>                 }
>=20
> -               if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags)=
))
> +               if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags)=
)) {
> +                       set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
> +                       set_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
>                         queue_work(ab->workqueue_aux, &ab->reset_work);
> +               }
>                 break;
>         default:
>                 break;
>=20
> base-commit: 176f3009ae598d0523b267db319fe16f69577231
> --
> 2.17.1
>=20


