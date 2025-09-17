Return-Path: <linux-wireless+bounces-27431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FCDB7F0A2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA1D18908F5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8891C2D6E7D;
	Wed, 17 Sep 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="yUmf5eoM";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Tjq99GEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2D27F16A;
	Wed, 17 Sep 2025 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092701; cv=fail; b=f7C3jLvUJCNSmKch88d/zqPP/TMza5zwY+f0+oPLXBm6nOfVLDSDZsKHf1qHxPbe/wHktzs/gTcQkPVFAzO6Th3AEotBzqq3metbZhUaP9PAp03GjrIZ7YFsmGywJCx2C7gG5KdJ/4KJAMPvVnOvRx1D44Hoot7ioN9F3RQMi8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092701; c=relaxed/simple;
	bh=ns9Pyv+ElmfvsE1lPc65Um16wMYgcHpkBtGP0PxiQ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cHPz+VJ/KgfbBltVrA7m638NSWt3Y3Z62FBfXL31qq8+wa+H38d3wN8A7euITxNUK4yOsz43wdboYY1SRBZnrf7LLHsDzIcIvOkxKKdbfHJZ4wusr0g9FD+Wl7dlQ/2DNURXRaKynQp0QdXc3ajqDMcM64m4IUkedBf4cMDPjBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=yUmf5eoM; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Tjq99GEz; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58H5U2Ux3493535;
	Wed, 17 Sep 2025 09:04:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	J5w+edxl3vDyol9gq+pVmX8KGouBdDktRpjZa0zOIP0=; b=yUmf5eoMK477mIYD
	+IRQ/fRN+1lmKZO2Pd+HOXhL8Ndzlt+Ivd7dx3WKaagBfUA5fzHoW03c97+/vWSV
	82mLfGG14VCeJRQS04DX0mSXTj1ztuFmDZLm789awRapP3+R/Th9A6y4AWFzCtj/
	/Diefl0ttxCkBy/OoVxwrzyley6SCSYxvyvcuLXECcupw9qxzojHTfV8yhs0aBKI
	AV2QYtggO+w5TxMvjmnWwyTqnVuQnoIwIAhh9DBoFC+B3YDzjuVtqBw+5uV9A9PX
	jK0SA84ivnnZ82doPRqnqJGlIHcAK6DN+PerUnWixsBp/+VmMYjANLz2vdRgM2Ay
	4dA2kg==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2139.outbound.protection.outlook.com [40.107.241.139])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd1gae-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:04:38 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieSwLsv/tbIsr11ivNl8AqeetZRpqDcflswWclbtElnbEGqFqpHHX0zxk41PekRHR+xH4sDG6UrE6AlHBOWQic3lrm2z303LyQyEG397NUFbx9B7hDPnSoqluCoEJM/WRZo/vVwul8I8pN/RT2bCHqjg4q8+gNc8qcHeIlfbm5yyvDVOLA/hFzMM8BKU58VLRHVKc0ZLnSEy12WYTCHgSjkIl0SKhC6JvxrmSFfcN5y/BfhJ6O9cBz/rtj16glRDyw3PXtKLWlmI+u037/3Gbd7waTsEZvTCqymiHl6gXPy/2JNfjIlAG9hb4orHlVPu5O/eVtYhJMQCohNyCI8o2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5w+edxl3vDyol9gq+pVmX8KGouBdDktRpjZa0zOIP0=;
 b=dnDgsd+FdJacgd3APgKpGGZNMPeo2oDnt+txd30OwK71WssXV8+kA+ncO2qXq4Q/mDAkcDJuEbHBsitQ4AjySHbspbUSsV3Osgu83boV3RlLQSB3o+q/V8l50KGpxD/eh2ejLYI7X4bMaSR+iSP1x9K0payq/AUT1WiUp+4NsBY9TmcdEcF0fnkpaMDE5eGL04sslNtkkutzt+yPL9Ev58TjuvRG8eNjH1jKZuCfDXk8OVv/BuiRczuq6CWZ4UTrrgM1BC8nmlbQp7VzpGE+c+L7D7coY5NHZaIrZxtibzXx3E/evIAsgvySSclS2PgcnAwZxXZrQ4nsDbs4PridVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5w+edxl3vDyol9gq+pVmX8KGouBdDktRpjZa0zOIP0=;
 b=Tjq99GEzCq6Bg6z7iLuRVrcA42ayyRjAX+XYFx7XldZeDUFYolhdFWE2jTyn9PZQ6UlYX70hRYZbIar23RXgA9lQ4gPhyb1fYTuvS1Q0NE6FqzhFArFJqlddJ6v1VKBzegdpDrc3C6p2ea99GLXWLjlI5Sm92BOtVNKbh9miVeA=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU2P192MB2171.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:04:37 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:04:37 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 RESEND 2/4] soc: qcom: fix QMI encoding/decoding for basic elements
Date: Wed, 17 Sep 2025 09:04:25 +0200
Message-ID: <20250917070428.2909-3-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
References: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
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
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU2P192MB2171:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd0b81d-0449-4497-5a91-08ddf5b876bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z4C6p6DsBjocRFVTqxSJwFV8te3Sqa3iI3sgDTHgpAdVRLdFnKNm4s7uCBvk?=
 =?us-ascii?Q?yoVpqBZS0VbjyZ1wTnj6siHqiUBBwqGH2Zo5dDaX0nILhv5NeqozmVok2c/x?=
 =?us-ascii?Q?kmSfM67OJK2vE+W/Npa29OOdIWyKrq/b29w8uQxNU8JK+Ow+8bCewuSNMlwO?=
 =?us-ascii?Q?FJXZWj7BIWVODGl6XGBW5HndAiBrE+6CQxwrdr4qJXIZ91hReOa34lB3UvHR?=
 =?us-ascii?Q?xWOngByUSuPnGtuVoV8sTkGLnwduR/vfUDaI6T3PGiJwIfWeSX4qTSmAy0LX?=
 =?us-ascii?Q?Tz81ZOIpd9xoXD7bdQcecXSouIC4vWp9aUlcw1Kv/55rZq+DoJO2Bo6YDIuF?=
 =?us-ascii?Q?Q/iXZH5e6UHb1Dh9WadfgzqCuzqv+4JKx8I7Zj/fsHCcudHXOzrTW0DDPyeC?=
 =?us-ascii?Q?fufKhgFBwkbbC6o1Elei1JIg9VqqkJDu2DLkiKZuOOHO+FWe3HIqmqzNwi7Q?=
 =?us-ascii?Q?R6T1Yo4pHSB+/u9Oaxzpq8ql2hefcy2X+hm5osq4Zk/zLujnXXT3qfmt1up2?=
 =?us-ascii?Q?XaIx9jydE1UJjAh8skZibUgDA9gDQvDJYgZJSCsxC9AIvnWziIWu3ihFhNsj?=
 =?us-ascii?Q?adzzl67kREqtu/ZL2+o2QoNp2HSthUR1dDrhGOj1AZ339okHNr1qrKT5TAh4?=
 =?us-ascii?Q?ouwpXvsfeevD9tkCcnS3kfyETCx31XAo+HBI3rlgm8ZrUjHmQ2j1WZFoNYhZ?=
 =?us-ascii?Q?wbSO2VL4WG0JYpXW6eERNZ44XAwXGOkZLj+VzmS2IW7qijjLsJ4Gds87Tlre?=
 =?us-ascii?Q?nBay+fJ1rnjXkUKnWrsDLyxHjYvdZEsuj4feybA7lNUVzIKd0HPDRWGIOat6?=
 =?us-ascii?Q?g3aZ5bqzT6PvknUS8ZmPdQL4CNDUzClM4NhsZhwAOKZXn2bT44uXQq3a+KR/?=
 =?us-ascii?Q?FJSxRT/3UR/9oe/3o1eqPWe7uaj+F8DAv6s6DxfX/avATp2bLxaLsP5mks/Y?=
 =?us-ascii?Q?9HwNBNAskcacGowS7LBfXII1FC9GvRf9I6lkO/Aqu3OzmLK29E3ToCs8DuUk?=
 =?us-ascii?Q?a/gs5ayoL4Iyr2IzyDz7MGo5+o4niXpHayzhL7jchPkfsCasmi9lQe/LHC/j?=
 =?us-ascii?Q?59+qGOTIDlBCFV4CYkJqZC/PDid7DfH5ZdcZVAt2aRP8PjA+Cz4WRftuvHYW?=
 =?us-ascii?Q?hsnWwZMLa2ZRRft9UBkP7PnCEz8VQ6jEKB1eeERUZl+9k6rHJ+E3SOTbeXpK?=
 =?us-ascii?Q?aNg/TG41py+S45p8pfNtz2h3kS6lcmOqDbyoJXD3T/JWIuy5qchMXgan1/AM?=
 =?us-ascii?Q?8oSBRaFnFXCN1owvN3RrZPlvKfFKxJL06pfvT3AOzTrFBYE0V3QhP6nS3M0j?=
 =?us-ascii?Q?YCEZAyBsBzr4RpmEECuI8+Fp/mg96eas+/olXtqfRthJQ6SdPeapNU2AJMvY?=
 =?us-ascii?Q?OozAsTwvFrHTqY0i33V50mT/oJoST4ibR5aTwd2s1GWES+dC6dIvT53/PPnR?=
 =?us-ascii?Q?2i0/VTmy4Qw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHzWpTkbHnGyEUxTfcugT43uzQy4U4V0RMj0NrvPk/NPCcNFX4bcIlhtG+ii?=
 =?us-ascii?Q?czl1hZB5zHHN/wxBnTjsp2hqtN6T1KDxHKCsaaADWs8rEpcZdtKXQwP872s7?=
 =?us-ascii?Q?/Iju6USRBRa0T2Sids9grHF33o5UDnqKMm05g+sxVjvGxZsZdVUFU68Hg0OQ?=
 =?us-ascii?Q?qe9wfr5zz+Bud7/lxp4aXRl6Pz+oBrLIwGOiu1AeCnhfIPHGjLdLi+CaEbD2?=
 =?us-ascii?Q?fFyQd0nQRMscvHsVraoBOz6UWT7/yMItsdpaKNeL6+SzSBPioT8Fp8+n4OG8?=
 =?us-ascii?Q?p61MyXl9+VP/BWjwyZdFaeIEqQhs87kjM0A3Sj+4PPy3abSNKJL2gSV5eXYJ?=
 =?us-ascii?Q?RqqqEcXUXBk8UAmVlJrmrpaXvzJB8Cpr+IKMRp+gqwiKa7Syl/oqmZQczEUr?=
 =?us-ascii?Q?XQaGBJc7ldVtYeaJd7ZaP0PrqlALmw1rodE+gPIryTdhi+KHoBlP9N86BSn1?=
 =?us-ascii?Q?m/w+23tYQ79VB7FHMJAcpCnolTu2PnPc0ztQgiFWaBVMG7ErKYBC1BiIWVVa?=
 =?us-ascii?Q?tbgHsq1E+v5PLQwdjcptBlsQkscm/djG8GXrdCJZjA3+rkvur90eWTUlGA+r?=
 =?us-ascii?Q?UZP4QJ8fkic3dIp0a6AbrrOrnafNwW07TefEkb1G3YxQ7qHWVjRx4twOsexN?=
 =?us-ascii?Q?0ZTQdoZV6da/ABImAop77ode+kbV4xtNKzK1k/lFbKBEBsYJDcL7heY0JWpI?=
 =?us-ascii?Q?6/FH2bB1ppxoHbJfpDsUlgq9qxYTnYAY8izDE5Sugdw9n034qBmFYhJuiIDO?=
 =?us-ascii?Q?rx3t8kI0hhhfjC1BvhrlOW3h2Fq4brn7xJDtS7tdvAUriOULZv54pBRaTZYH?=
 =?us-ascii?Q?n0l3vipYcz/XS6I7wI1DSP/vJh9LXFLTJEm0wHHBO1qTcFlMUdW0mxOQW+Wi?=
 =?us-ascii?Q?SOaBcVjo/wJGmaXsRyqAxCsjZyZBPoDMNY89x8fZaK4B49uBOSPMWayolOf1?=
 =?us-ascii?Q?9pOm7riMYYyPEQbpLQCVMC4HoXKvn668Lv3fErPvgE6ZcNRY7TfUPK+FXWp5?=
 =?us-ascii?Q?UMu6lSrplad5LCy3+DEiTKH1zNSkUTGX/j77GWgUCkeYLtEQ40QKM/pSLc7Q?=
 =?us-ascii?Q?7388SPOlFejDQb98wNgCi26u67ZmGvNgGUBbHoJqT/ZbFnJLZhn1KM42iSNg?=
 =?us-ascii?Q?cjTvC146nH6JKY0MNQHYHZ0Oi+ZoWDDZoXRu1ag41y/QS7R54En68GTR7GsN?=
 =?us-ascii?Q?5Q7gggrR/14G1jqY+cnzQ1gwMBu4o0xHIthhHCA8j4eI00bY+ump2FMzicBX?=
 =?us-ascii?Q?0hl46KiIT/FeEGQYwnid23gloGPnUPXiOvZZHfXA8haFuHfMXZp4ctaqUfrs?=
 =?us-ascii?Q?j0D8+iScIPbtZn1kew+H1HHOPwFGUnlGKsmmECQWVnMZulQrsFcEpfY1DU5u?=
 =?us-ascii?Q?1N51mAyD2KNRxKLAKZFkjlktar783qODnrfnpp2jFVr6nSC7MWJY6lS51J77?=
 =?us-ascii?Q?m6YZJ/JpUkj/4rbQ7g+ssX3ASHv9AxG/Ugv463kw1g5Cedz9/kaUC7Z2k00O?=
 =?us-ascii?Q?m8ykJvW6NAxq9Yf6ZwVesHInzAtEHZRmPw1IXMzkoG1QZdmsXN8GPZRtdz0Q?=
 =?us-ascii?Q?sW6xoHRz9SqAckhwWQ1QgshgO80R5QWA2e6pi5kC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kcNqfdo50Mp5lz+F0L2bNMFyRSfhMEtYeWBuhqSjVNMKbfJx3jS0PQPbmVZ5VfDSc2rhTgrpgROc7y6gta3iJqDesODVBLlFG/SDT5ts1VQZ8c1Ybnhmk0/nlEKVWJA8XJht2KSr+KM9yKf/WuWhQf/cABJPpH7T9U3TMGjseYJdxy59oJpbR+jD/4S5nWQIATxkzz6OFDcHfn3rdhOLF5mFbbZXYheSPnV15JXtsSn9PL5ozgOOb+qIMVm8PeIqgOdWs6XnHADgu8ydJE6eZIkzYHee9j39bgYLjuhfhYtyFkHVjzHeDKiTSKbK67mGtuzVvjtKSZA0jBAggFNnwOUeDszmM7tIa837zqB1w323Bpxs7suyC0mLJ9qdwzaq6rK/mhFhGbG/OsYGnabEKDpEeNIRjqjNxkYQTTuG+OolM747Zby7GU52L9NEmi+PuTZX/k4t5TSCsJoQ6LFgdXRP0BLoT4upVPql92jnCbULVCZ0s2rtKHC/ckZVOy7kdP4GHMTOD41Dc0z7QvIdF7Aqs9HhL8XfxTW2oRn1eiW0GLrMhaPBnVUXiuA1DZckdyKFYkgPSUlZWo6IM6PG4cg+idimboYWX1Cu2qeD9w6rioyv4S6dqRGhPve/6qgj
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd0b81d-0449-4497-5a91-08ddf5b876bb
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:04:37.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guchAhrSWjmbNReC6A3CP07TcZjkllq2wmAtW3L6a+JHtkhzCOEWZq7wte+JhDo7uzI5tgvJ4GljlZPNZZKrAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P192MB2171
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
X-OrganizationHeadersPreserved: DU2P192MB2171.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68ca5d86 cx=c_pps
 a=k9o3rqwAubfXSH4DRDcJDg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: tB-hjwY0csZRgwL1C57nJdP4EqIq3Dgw
X-Proofpoint-ORIG-GUID: tB-hjwY0csZRgwL1C57nJdP4EqIq3Dgw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDA2NyBTYWx0ZWRfX02x6c4YVRVp4
 +g1DQO3Z/+b+AYwf8TRzbfVH6ytDmpvpMqgcsXGNGx9t917xEUVCYtGn8MgTp1uekVLW5cXEkMw
 OG+XfPrfQdlJGXB9ilmT5GVmVXslRdoN2WfEx3T+1vM18qbFaXw2SOYvBSw/rtYl7AWrKZIYZH3
 CLTJFGX9rh5CB8AM/V0uxqBUKhvHgjKkPslUPBEFX79LrvS1MRrjx2iNr5DYZxSawkUIR1AZenb
 3TjG0BGJSQ+LePt2p/xtYiTs2dLKW5m40LDovLT6rNuZ8SF4RBnEdYUoTY1zISraisVtngdsC4o
 06IS+S9/sAPYjuPMiM5C7T0zoswew6oJpcNuphOFMvWruNtx5Z7LpWVv6BEKkA=

Extend the QMI byte encoding and decoding logic to support multiple basic
data type sizes (u8, u16, u32, u64) using existing macros for generic
access. Ensure correct handling of data sizes and proper byte order
conversion on big-endian platforms by consistently applying these macros
during encoding and decoding of basic elements.

Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 50 ++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index cb43531a8b66..d8575e92dbf6 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -36,18 +36,16 @@
 	*p_length |= ((u8)*p_src) << 8; \
 } while (0)
 
-#define QMI_ENCDEC_ENCODE_N_BYTES(p_dst, p_src, size) \
-do { \
-	memcpy(p_dst, p_src, size); \
-	p_dst = (u8 *)p_dst + size; \
-	p_src = (u8 *)p_src + size; \
+#define QMI_ENCDEC_ENCODE_N_BYTES(p_dst, p_src, type) do { \
+	*(type *)(p_dst) = QMI_ENCDEC_ENCODE(*(type *)(p_src), type); \
+	p_dst = (u8 *)(p_dst) + sizeof(type); \
+	p_src = (u8 *)(p_src) + sizeof(type); \
 } while (0)
 
-#define QMI_ENCDEC_DECODE_N_BYTES(p_dst, p_src, size) \
-do { \
-	memcpy(p_dst, p_src, size); \
-	p_dst = (u8 *)p_dst + size; \
-	p_src = (u8 *)p_src + size; \
+#define QMI_ENCDEC_DECODE_N_BYTES(p_dst, p_src, type) do { \
+	*(type *)(p_dst) = QMI_ENCDEC_DECODE(*(type *)(p_src), type); \
+	p_dst = (u8 *)(p_dst) + sizeof(type); \
+	p_src = (u8 *)(p_src) + sizeof(type); \
 } while (0)
 
 #define UPDATE_ENCODE_VARIABLES(temp_si, buf_dst, \
@@ -182,7 +180,21 @@ static int qmi_encode_basic_elem(void *buf_dst, const void *buf_src,
 	u32 i, rc = 0;
 
 	for (i = 0; i < elem_len; i++) {
-		QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, elem_size);
+		switch (elem_size) {
+		case sizeof(u8):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u8);
+			break;
+		case sizeof(u16):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u16);
+			break;
+		case sizeof(u32):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u32);
+			break;
+		case sizeof(u64):
+			QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, u64);
+			break;
+		}
+
 		rc += elem_size;
 	}
 
@@ -465,7 +477,21 @@ static int qmi_decode_basic_elem(void *buf_dst, const void *buf_src,
 	u32 i, rc = 0;
 
 	for (i = 0; i < elem_len; i++) {
-		QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, elem_size);
+		switch (elem_size) {
+		case sizeof(u8):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u8);
+			break;
+		case sizeof(u16):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u16);
+			break;
+		case sizeof(u32):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u32);
+			break;
+		case sizeof(u64):
+			QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, u64);
+			break;
+		}
+
 		rc += elem_size;
 	}
 
-- 
2.43.0


