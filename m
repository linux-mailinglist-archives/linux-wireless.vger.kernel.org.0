Return-Path: <linux-wireless+bounces-29089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA78C68D05
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AE47381D2B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6E34320F;
	Tue, 18 Nov 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="EpniRAwc";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="OH/L/FW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCA340A67;
	Tue, 18 Nov 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461074; cv=fail; b=HvVwf1EpCv16SIP7Cw7iwN1UAhxCtoloYXphk9I1wyjBsUEjQhWN8im1Dy53RskoVh+ibU4QftmlJ+Mz7O5vj9POkbHohp0mshN568iu6bSeshFNihX6figfbAfW5vbPpQmzKDajtiWK+KHqCK5o0eZMM2nSdev+L6Hv8Xhy0vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461074; c=relaxed/simple;
	bh=x+grTkDO1anEPsReXAi6sg08vPap79HlJ5hkG33kXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=emLXDH8atmXls5rtHaOW9fKHZTtoMap+0QVkHuu92yughOmtzNDgTBKkeacxD9HP4gkmNucpjIYodCXv1QbJN2DZ/0Saw9huuxYWf/w5U5MIOjEUJf2QmEM1oi0JHAN1e2psr8FfT7Vlc8Rha6ID16PB6i9np4vtChxsbYuAu4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=EpniRAwc; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=OH/L/FW2; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5Pwwa1657846;
	Tue, 18 Nov 2025 11:17:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=WepsWoJEDW/+mp/pKknOs1
	xosOWWEfSKa55JrSVxuJU=; b=EpniRAwcsoJUrq283jFVZE9mtZKdouN9Dmgx+m
	t6vcdbo5RaiVCXMZsKqYhppwflkxyRcODaN4vvIp8h+ysjlPwhBNBZjz0vawcgka
	kME0u58A74qNbj6siqx+O5YQNO1OTSJL3b+5CH+xYwS+7WstWsZfDEn09H4Gv26B
	05gC5vQi8BBJDVSa038wfnEdyi1LfztN2UOh4+sHd8ZfWi4qFbWG/bHhuoBGX1ws
	AGAZ4NPIeUh55b/+QfyKdAD5hV9hxsSQuoVJ0tunI+yDiUom1EXRm/UdTw0dUmjH
	xoztE9jFDoip2Qn+3JAOQctYsTblPOFQbsGSxl2HF+F85ndA==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11022078.outbound.protection.outlook.com [52.101.66.78])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4aeercb32t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:17:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA+/SOK+KKr95WBq6JCZijNoMNDZW6iUXlfogk/z1E4H+wLfZG8W4/YOqCxHyWzXl0r20y/Xgx58jA4gb0NaOJD9vS0qFFou3uNDaEvM1p+Qn023uMiYrUB7pd99tLDzobGM8fXxb48jJ/0OeOsCpktcYD1lGdOgdxAMIrcHwEjPwI7+h4QBMw6jhT+1orLrJqy0gglaH6XtNvu6m0Tx3VMYs5OU2Z2LqCV2vkgTk9juuZM4WsMyx+vLesTDcByDM6CXgYn4anRFy6UhBZ8p1snFW225/OuDG+0pUHR7KSmwbBGhYAkmJZdQ29fGh8kRj58N8D1Ud7LBxs8aBS10Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WepsWoJEDW/+mp/pKknOs1xosOWWEfSKa55JrSVxuJU=;
 b=dprqv0xlxWOrubaCjWK+Kf6PnMdm6Ne+BjdMsFAQajVLY0M85NnwA84pvoHYxtWn/1MZ6YBpXGhc9URG7CTjvnWnWxc13vHwDorPp+8iAuylQZJhr/jmEYlyM56MSpfWwAlHj+sJNQJLy6xXXxJgdwX51seigYB1jNv6PHm3Dr3nRSRhozfcMzvOnUHdtjJRJ+zoRCSU5SVxhMZp65uSw6oPx/3JCrp7Duo+G2xtqehWoIUy4Sdzo971619p2fZECBU7HM0/8csoejY3rO8c5gKka6P30NxBg0zcVbIIjsWZF8IKYX3mcY2wN9SuWv11mrwIZCsmpxiPgvkAGRBMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WepsWoJEDW/+mp/pKknOs1xosOWWEfSKa55JrSVxuJU=;
 b=OH/L/FW25/+Ljq9+6IoBPMoJIUXF/8nMEMUzU/ryxkn/o1lumYGpybtPzprRbp/tdMygrLDVjGfFzbL36/54k98LFY1KPmXykbhjTBdj+wI9YcaFhYxeFoHcMhfKLPTRvtK/Xdy6zSTx4mVOs4oYQgBf0Xdo7MHehwDjp2IrrBM=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PA3P192MB2988.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Tue, 18 Nov
 2025 10:17:25 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 10:17:25 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: fix endianness handling for SRNG ring pointer accesses
Date: Tue, 18 Nov 2025 11:17:22 +0100
Message-ID: <20251118101723.69279-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::12) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PA3P192MB2988:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da67cda-7163-439f-bf26-08de268baba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdU4QUedo0r1Oi8Pjcspa8OVxvmPC6jLDlp1d+U6SIU4aZ/dpcj48CQQwAdJ?=
 =?us-ascii?Q?xafapRuMcFBqkdyjb+F0/jB5f051l1bsqV0CS429W8rtVI3P6bs4elhLY2Az?=
 =?us-ascii?Q?FsI6Nn59rtLWU0d9BWchWEGEl+3bGysukAAjM0nI5ZU6+Fek9NZYUjblDUaP?=
 =?us-ascii?Q?MRM2/DBkBAC2Rqiv8jWoHg+G24uq7Y8npgM5m4NLqb+6Ibbu2V2AlDk1B+rx?=
 =?us-ascii?Q?5N0nb89L2ef//qbT7DeEY0mQu4Jwm+uMnVfaG9rN5n2w+CF54NB4KlZBTG+I?=
 =?us-ascii?Q?ql8XpG+jgwcJ8Pzs+aC2C+wehFqcyYP/zGft85hLtRRbmD6jZEJR5IktPKVS?=
 =?us-ascii?Q?nV3NAcsM0OAMD1dcCbbjv+2PuV49oMiz6ZzUrdiru3UnK3alQ8N7Jj5949gD?=
 =?us-ascii?Q?TujJnBp0x/iGTNajXmC6WSysxOS9FoRC6is1B5pgj6QnT1/vyC3+O/nb+kF4?=
 =?us-ascii?Q?X7z9BqcErw/VUwvctZICuDUxY/28JCBBaYThRaHPSY501ihpWSJ1eqaF5gMa?=
 =?us-ascii?Q?+Y2OghY88JbBr84aRipWZXwHDvZnt2nuwbn7iMSyS6JeYck6ipFL2Ree4J2Y?=
 =?us-ascii?Q?4n01WjN18zAYOXfrLKr8zENwa+zJsj/7eRIS5M8yRmKAksjxm9qWz/QKMQOi?=
 =?us-ascii?Q?LSi4qXV1OQPqE4/Alyn3WjsUPnJLu10VGMFYPvk4cpZJLjbFUnBIVOcgR/9P?=
 =?us-ascii?Q?gw8M2Oz2+khlYS4T0T82kvIx8ull9U/lJ56oRIERPlPGL3cZIMPy9rUBP620?=
 =?us-ascii?Q?2doCOhxp1jUc4POqYwVQ6S7B85QF+FOsAXuKRXWYGS+nDU0r0mCrJAmpdkYB?=
 =?us-ascii?Q?R/apG6bIKZ12k/oVgOqY6jS51eR/BgNcpfS3B6M/wqzHkG5V31UDRTNBUsam?=
 =?us-ascii?Q?ZOL3mOCrTaIDGuggDsvNEwvz01UPvobHcI3G56rtC/7HtRqnI/RN9deiPdcX?=
 =?us-ascii?Q?ICBZa0Vz+s8ouLHvm/CV2DTLgrTtm79EEtt5gRFhOL+xBJXuVs9tpffyUc+T?=
 =?us-ascii?Q?78iACjVg4dSVtgjzklhajStPVoq4fZe2x/YRbl/f1ld0cTtAPIoyJ+Bn5cFz?=
 =?us-ascii?Q?ok70eGWdb0wHEZXR73Mqhz8wY1bt5XaT6Pr+iNRUQMDUlrPCqFA21QXiwqhR?=
 =?us-ascii?Q?CTZBA1RjWP50U9HaFs1TPeX80wEke8yEbnauuw5nUWJ7d/JH8FrJNVep3iIb?=
 =?us-ascii?Q?0Go1hISNz4EBqm9WQ6VRBhz/GIwW4B+JT7r/XuGH2e05cp4gKWnVKUcMcjFs?=
 =?us-ascii?Q?fM3AuGMWiufuI3HingVxpsO1105h3oBrhtfYRRxESquqD0SQAGgGTyxFJDtu?=
 =?us-ascii?Q?E35uHyWLaBfk6lqwG/kL0xDZWrGe+qGMLrGzvCz1LgURxXIy88Zo5vqfjPYT?=
 =?us-ascii?Q?fUdo0EFFFrcPusLvU89co5eW9dKXNzsvf/SRo49ByJyfdoRJDHDVT01lSLeM?=
 =?us-ascii?Q?6V15wfH1Cdy9y0xryLygQwRO9J1LgqXk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oMUceHADjN16/G8xa7luS/N/XntSGAu26EaFYnruyewlz4aRIABp4iTYt/hi?=
 =?us-ascii?Q?kUic+DPEQbzAM/8BPMdBILtEoqp9QzE8phVnvYbo03uOl1jrnJcQi4F1K2Mz?=
 =?us-ascii?Q?fGnLFtAj+ui0Etzi5s2Lv4LbKmrqrWJRspMByUm9T3+/B/Gn9/s2cuFJ9NHF?=
 =?us-ascii?Q?qK9MuGywR6jXq4Qj+hf3y/SP3k+HnVhy2vStYi6Q+B0POcbtVfRHwAhxATaz?=
 =?us-ascii?Q?Zy4RwRUZWzju9FvhX7wv88Pyy1xHR+Bi8OOnHcs3bO7jESdxIyh+EJJtXdJQ?=
 =?us-ascii?Q?ZxaLgVNiQDzkWT5Vr4xkjInFtRTlDu0td0NomNcSMMobEIHh4DZdLQ9a1sZc?=
 =?us-ascii?Q?CWLUdgYN7ZuC2egwhf4+URng+myQChkZVgVgjrdSWtTpXrt06p7FrJ2RRPRl?=
 =?us-ascii?Q?U/ICC/s/jEUIMdsv1PcYTDrZnQpAfF6qKQ4waCsWeNToDjVNii1Ax22XaNiT?=
 =?us-ascii?Q?zx9UfEV35nzdLyrdyKzbK5TbcTCsNytYCQprXG0MlGjRb3Q2qjeqjfTCZHqT?=
 =?us-ascii?Q?mJQgDLtniSY8szBe2QDwLuFUdT5bRjIwlCt+WiPU/UucouIhZxEn1Nw0Y4FS?=
 =?us-ascii?Q?pbXQNNBBU4cRvEykqLoVytVVtDg2Dux878VfMPNfmzVnA4XyHaBHz5fr0YKH?=
 =?us-ascii?Q?iHX64PaGkmF8oEjk5mdzgBCzu6YevPXZg8th7vbB403ZpMhkCQHgUaPtE5dU?=
 =?us-ascii?Q?wE71OxQ3fdVPJaGZPo+zydV2UhBOXQNh2+GXJ6ksOrACpCygdCYSTDaCFXM1?=
 =?us-ascii?Q?poNeN4LFcDO7Cegvb4Pls+vmoSn1MZYFuAcwnbR+lteCN5RASTb96cYRKIfF?=
 =?us-ascii?Q?OU74C2y5RWVZPzhjyDNdEgLt7N7HvaM3ir5ftQPpFZw5nPBkrqdm0OMEPJc5?=
 =?us-ascii?Q?ktLxoend2+XXxh5rRSCAePvpLSzGIdMEg1q1mLYPKTJw7NVNxzyv/k8zMieq?=
 =?us-ascii?Q?qkwyp/hL1DFgffCIvpGscXfmn1abaJSMab+92s/OuKEAs5jNV9KBo9u0BvQl?=
 =?us-ascii?Q?xwGVoZLzOrWdr+nUBJj2+l4iJqCl2trXoDH83S1agRZcXA6GmZorlJN5P7M4?=
 =?us-ascii?Q?RxXWLCtAPLMWBMQkktoayHpg36n36deeHrcpzUjGrvm3HgpcHvMGWcbxAP70?=
 =?us-ascii?Q?utFrAFd1t1xnuyfv4WR0pd7RrPSosWNIOmYQtVlHTR61bckAuPINjyik/HqD?=
 =?us-ascii?Q?TN7J3s0XfE0nup18QujRJ1hW62ax3saV/+UseKYgnhvP733hfosJzAvw7XPm?=
 =?us-ascii?Q?utgJRFp56JDmEotkk5dKYHSEmk5ppKQQHGWiDa5/C9R9n9zHnO857x8f7eiO?=
 =?us-ascii?Q?NY9HFs0m8wjtSRMbgejpRjjSaLzC4fQ17WKZxzTBloAFhqSr6eqh1k16hZKi?=
 =?us-ascii?Q?3JqVzIVK514DpY0RY1yyWhwTR+yPR6/iRNlstl2PNjrYb29KsXONFxHgVshO?=
 =?us-ascii?Q?SahrHkzLROX2Y/6K+94BiegFKxpOSQ8NV8GQI1Jtbfafl/48FijqmTynSM0a?=
 =?us-ascii?Q?Pmw86ZkfI/8vve6payO2IY4AgWNaGdPNb0AwP7Sq/N6aW427EdMu1RhgIeo6?=
 =?us-ascii?Q?By0kji1iX55Nux0MD9Wb5Eo3COtD2rQ2qSw87mTU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A1gcxm9S5r0QLPY8hg8/iGZnBvcEYvChjMPd/V38y7cO0Wf3prnzdbBoamiZo15nHIxIjtMffxK6L0hYnIBhAsduiFVCFwRcse+zUxnDgq9kkOI84LCVUx4ndXUhiMfCLofgrUeEDjfYg9fw90oI3YuPHf22lExgGYx3iRPhcSnzbsE4gBk+kqqYO++H9x1w4UQwfeMnvFYvYoqlJCTZLvugJrdm8g46xVCgc8b1/fVPdt6yn9NE4iCo9I0PaXERw1vw0jHX+wpxqKtHrrF6X7gcI1Nwqo6Pe8Jm1tiFY1xbQlOld7nAGk0i4MGCno5ASCsQXKZg6VUpYwIFmFG4iBO1D1jcUX47Meds1oeZXml280QONKFkyIVMm9HRyBRSNlXsUlf+6dndTa5QGfONdHP8hsyH4XV66276ebLLWc8Qc4DSvRrHj7//AlI3qhnCK0yvVLP/3m1cTInlBowFFC0iT83xYo1nGbrL7va0lEyQF73J/mKo1IM0N7uWqD0AL0E5H/5Ig5ryatzMrnWq8Lj+SLRUAPSeGeJqPq3r9eV/5K60Qt75NbgkzbRoi9UF1OGsRbab7jMBjXd6D9aGfLVB5e7XPOYcQ4qFzzzbTto6tWiJM4rX+YoipLdSYRE3
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da67cda-7163-439f-bf26-08de268baba6
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:17:25.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1faJuaFdon7Ssoub7NYZZJZr6DRCORt3jGlZQWbO5yA20NCFFxQColb+HvTOc7d+2WGMm3/7ksk93LpynfMzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P192MB2988
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
X-OrganizationHeadersPreserved: PA3P192MB2988.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: FPOTnkDacVl1Z_emayKOcbvuNZgEWHD2
X-Proofpoint-ORIG-GUID: FPOTnkDacVl1Z_emayKOcbvuNZgEWHD2
X-Authority-Analysis: v=2.4 cv=Qflrf8bv c=1 sm=1 tr=0 ts=691c47b7 cx=c_pps
 a=xTNNa3dkdEHSULvH5VBIfg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=1rdzW29a38CeVRWDwfcA:9
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4MSBTYWx0ZWRfXx6+VpM9Dx6xT
 8cvPSQAxDAit9L+xpMwzdoeF0Uvy/gIY3nZD/ZyTRjTNis4jcMC8PEZ9yi/0qYGQ7tJCSYB8Jc2
 seqBqGEjQh8V7dlGNpWTW44RA9mZEXQtHF5gHGSKLh5Lx0+drr+NGqw6CU9wzW28BWoHio0mPXa
 2E83bJ9Ueb++tMoZM9dTjEK6o6nDJurOv9GIzkcd0lKPG1NJaEGgh2LHOkxyjxgaBoYMmg8NmUV
 J17qjfEes51CTXRVxIGkHXaQK7FZqbY6fLm4zQV/VhlsL/r9Pe6Il0kJsGNpvobqDA1xC5ZZFRq
 SXSNVHgy3tzwO6f17n5zadGg19TXQhNT3dLv/K8e95sfl2/FzqmQbGOzuS0DFAwagCc/vu+gZJ2
 V20WHthhD2uUS6DjTK2ZKb8RKyk98g==

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
Changes in v2:
- Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
---
 drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
 2 files changed, 24 insertions(+), 19 deletions(-)

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
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index efe00e167998..63657d727808 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -709,7 +709,7 @@ struct hal_srng {
 			u32 tp;
 
 			/* Shadow head pointer location to be updated by HW */
-			volatile u32 *hp_addr;
+			volatile __le32 *hp_addr;
 
 			/* Cached head pointer */
 			u32 cached_hp;
@@ -718,7 +718,7 @@ struct hal_srng {
 			 * will be a register address and need not be
 			 * accessed through SW structure
 			 */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Current SW loop cnt */
 			u32 loop_cnt;
@@ -738,7 +738,7 @@ struct hal_srng {
 			u32 reap_hp;
 
 			/* Shadow tail pointer location to be updated by HW */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Cached tail pointer */
 			u32 cached_tp;
@@ -747,7 +747,7 @@ struct hal_srng {
 			 * will be a register address and need not be accessed
 			 * through SW structure
 			 */
-			u32 *hp_addr;
+			__le32 *hp_addr;
 
 			/* Low threshold - in number of ring entries */
 			u32 low_threshold;

base-commit: be83ff7549057d184b693a85cafc10fbd520f3d7
-- 
2.43.0


