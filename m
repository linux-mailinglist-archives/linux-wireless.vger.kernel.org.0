Return-Path: <linux-wireless+bounces-27432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE3B7F0B4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F29188FD2C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890012F25E5;
	Wed, 17 Sep 2025 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="D5AwB3t5";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="qQxXU5hj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8327F75F;
	Wed, 17 Sep 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092702; cv=fail; b=uRJq2bbKoQnsRYxRIxAmUmT58nzVc+WDLQjruiwI/kWeRAVfnMWQJfPBXfkF7dwxFy9+tErWLT0K+npbmNneM5PXqbcoyfhiASbVNhhZKX9E9kZuNXFVBNDGF8R/H9MV/pEB//CyQXYWLtd0nnIYt8/r6z7IWNr15OMotiHI1ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092702; c=relaxed/simple;
	bh=cSlWMov3Q4wCI1jhNu+deHFt9aMG1CUAu5EH0aZhM7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zr+jGeEYa/YKPZAj3BYinllfZ/K5XGefk7JLs088lbVL0eg2ealssehVcAyTYCoFnoa05x2ZKCSR1iI7OmxltXId3Y+Nql6TZVNmumwyW/DxiZNmgH0VEzDnJxsFU40fCjjEeth8l5YaMJPsftsTlRdxSH5MTF2BBIJeCZTD+nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=D5AwB3t5; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=qQxXU5hj; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58H5U2V03493535;
	Wed, 17 Sep 2025 09:04:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	kCR8bebd1vjmuMV5mCxT5Q74sdd9PkMq/qy4Zd2gtDc=; b=D5AwB3t51Xba0Rel
	kEdmrvHaLYY2uung+eKzfyJPabnvEPZVc10zERuSUOD0yt62/HaUF3OuWb4p8Gcx
	Z/Pu9D1kZFEcCAT5Lkgb3KA4gA3tBVjauoztM9Rln0fS/S7DJ8ZundhjMfRivCjC
	/vlePloCEy4nsunYX9M5Bbn8tlYdAbGkAgyljcaAl4yyJJZnjfqCFYcCxZvXY0jm
	mlR8P6/Gsgzd4+7CxtONkY0lvwIlusSUJ+zbbEZQE0/PS5wkzJ8dzlZmtQg3MVE6
	OAH7R5YE01Vunr9Fkphnh/r2dZ/Cdu1GfJdkM8EY+U+ddsZ/hMr8YR+rOWHgIHQP
	2QTI6g==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2093.outbound.protection.outlook.com [40.107.241.93])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd1gaf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:04:40 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1DxRVj1BbBUmqxjV0znSaabZsjBTvecRlWjt2LGR3QVK5JEcdIhqYN+tM2kCirH7Zr7u4zadDrbkm3bTMLGez78wCuO5i26ch4h4beaz+vNNwvkbMVcjR37a2GN5XGtOQlr53ks83Pqu7NTOGDdwEi9FZS4sIF5OvC0ErQO1x1023oilOoBLxz565zj5Fg72O6JXfXi6Hf7J5dx9qa1eMIrPx8O8ztrk5Rda8xbXlcWaXLK0piHnYQ6ipYLyVv2kGBfBrlRTrc4lhY/55aVWWSjL9GjIIdfDNMMe1jv3lnZlWDMivyYMOPgghM+4gm/M27XIXW8SFI/NUnCzSTfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCR8bebd1vjmuMV5mCxT5Q74sdd9PkMq/qy4Zd2gtDc=;
 b=gPAop2FYJ13bQ9Fm8SV7jzfjBDlndKAXO2uj0NZSfdxFaqPLalM/C+2KkPqvf+ZAMYXK3uPIrXM3Bq7/2Im+WgzUwY9QMZnXpAOfwsFkkTVT3zJdwgkZ5k+ccuvy3hAHwkz9XhO2XJWohCpAq+F0sexeypWsHb9ocSMpj576p6/17L/E8Xmmh1RgxM5DuiZI3rAsEedarql4sFZEI82nIufJkTKLLhWCITxMM5NncmxkwvaP6fTt92lApKyM0jPSA8pfe8FDdUppPScD5lzackz7tGoEeNyQpRJPpiSZxAcRttHRVwogdt64vQk66D049t4OHzFiZjHtRMUd0F2k0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCR8bebd1vjmuMV5mCxT5Q74sdd9PkMq/qy4Zd2gtDc=;
 b=qQxXU5hjnpGof1edaLtmHviAuPjzurpylHb+F8X0C/P87h/HNuBUhUiz7ie639qao+gEv2CT/j2Mi63BX2/JGdcG25VWpgc+Rt5anLkSN3t7gtl0A30JqWPcUE0hvyvMZeb8F74fAsWDCB888y7gBhqKbc+XEkjZ5zo+Z5vbEf4=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU2P192MB2171.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:04:39 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:04:39 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 RESEND 3/4] soc: qcom: preserve CPU endianness for QMI_DATA_LEN
Date: Wed, 17 Sep 2025 09:04:26 +0200
Message-ID: <20250917070428.2909-4-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
References: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0002.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::27) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU2P192MB2171:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f7ea62-92e4-4bf2-6816-08ddf5b8780e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QFS7jpdO+6qoixfgtMSiRjTD9Db7P1lAomwYmoQ73RuUTUpG4y+iFfdvK6lk?=
 =?us-ascii?Q?E3rvS4SOL8Nvsg0YpQ1Oa/zomOAMU36QKpP3f2yG3bOpJk2aQCda3Y8phMwG?=
 =?us-ascii?Q?JROVj0SoZNC66fe5F5oOLdJGCiklUr/cwAG7PI41O+yfsteIGbEbBCQD1RuH?=
 =?us-ascii?Q?XfH/xl4z/WdG5/0RoWmB8g37hfuYVXTtIadLMnGee9YW1j11twTzr1bTwDYc?=
 =?us-ascii?Q?i0D9T3bW1Ym0GMzTsq+2RUEdQqtVyqGi9XMcjRwCTx32zmNkNLD9pWRS18b/?=
 =?us-ascii?Q?btmEebgToWWubdQ4ucmtYpqLfN8Gxt+uFqWgNbhf09BuKyRii2aD5wLqpqkK?=
 =?us-ascii?Q?8wPMkfCa0NpEZI2ovUxVXR8ONGZQ4lg0tq33/NrrLKWPoE+hgI6935fdYhP0?=
 =?us-ascii?Q?fpkUWDpNyFcmbQcYQjsgniTOsnUJKYXcEoB61FqlNnIjM6OrLhR154QxDZ7g?=
 =?us-ascii?Q?yu236QVZnSd3uzhBZy9IGiurBJaGlM+EYDuLrSGviuM5a1xo6sjQSFobcJhE?=
 =?us-ascii?Q?6/TjhdXWkEqcNCzK55vauUTYpElGZjD+zJwSnjzjhMlXp1yXiK1Hlbna+2lQ?=
 =?us-ascii?Q?ojsytAbApWKDI9KCrHvmQR2fId6oLwIhQpNxsgqbOlaFCDsLET2TERLp0Taj?=
 =?us-ascii?Q?6R+UiwtcLHJC8rvvDvZH96vvz0//CbYR5blOsYkafHuUfIuC15zpacgePHS9?=
 =?us-ascii?Q?fTSEdWjpQiOxWvQ09TkJxz+PELO0Zpf0DVcz41Q0xzaJnfc0oAI9rOqucKrm?=
 =?us-ascii?Q?eJ6w7lJapmr3scu5Nyy8kZDz0EMK2hZxUohUSzuNaqYG+CwlGlEj67zOiN7c?=
 =?us-ascii?Q?XX6iU81rvt3TRorc63StNgI+YOFKur1la2emOQheWtbQUTw0IRkTRhl8SQtX?=
 =?us-ascii?Q?xTG43FZbnzWeZ5B3yEFTxHNNeBSWXoCrR3ou7dgZIluslreJBxg7PlMI3yAd?=
 =?us-ascii?Q?3YcMP46OWE59jmjyKkhfkRMaLcADIrRU8sxN9zwer3FGrE3u2sZgBaQMiAS9?=
 =?us-ascii?Q?2SlVkhTgk8v24CVpHmN5zsxDgjRyIwy14E+usp1Vbh0DosWllyPqMocOEFDV?=
 =?us-ascii?Q?sTnR7s8b1Y7p3UutTRO9EtmNtODiRxG34Ac56G8jOa33WVlhbZnBFF0Ti7q8?=
 =?us-ascii?Q?sCQywqJ56uQUimQ//VxEaHuQ0d/mg8IzO//MpNqktyRHp2xd9HKEDd9ufvTV?=
 =?us-ascii?Q?VJKstGFa0ruu1zFSA2Qxdd2XLdLS0y/SC6ZLgZ9qRfpJKqh+PKvXKCv881w6?=
 =?us-ascii?Q?P3inmVkBg2rbkPS+shfXzM+8Ib9FOmkjBfc1rDE2hZjgHDEr3fS+6qVv+VyY?=
 =?us-ascii?Q?x15GVQm370bNRMdvDRot+eKmx3JZsRaUrveddMlknP5fKekzGJ/BVbaf2TgL?=
 =?us-ascii?Q?pLO+lW0hBWT2vcdU6NxIuqcq4w2MixFd4vX52ybRibrn7z4MzGzKxL0A09/I?=
 =?us-ascii?Q?AWfjkT/+28o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xq4VNiM9dMWnrvyEI3jvm8r6GLRMOdaNYGTwqhgGH+6Aety2MtsWoIkZJ3GX?=
 =?us-ascii?Q?sxOEJuHgj2f8U4sg5taszqkqKnKY65M0bPH7topxBeAKyk/0P0St8U6jRrNT?=
 =?us-ascii?Q?GYEwj83h91NfkZ3BkMBtgkCU/7QGzH3oUaoGidsugZ+Ak0gJwDs5wqcNAWJb?=
 =?us-ascii?Q?ytGTDkgjUIn+2I4KafVIIaJ5x75O7xLdSdnJeyZRkVnYG7B+sb4jB1023ge2?=
 =?us-ascii?Q?cR1feqL1uwxCjPh0En+JAXj4v5ni1JbRf3Z3rWwKeVwnrlIo/ujOjjw4dnzT?=
 =?us-ascii?Q?QdmQMG0qs/CtnN5wQVAAwe+VG5kKla3leje2pvVGNVbza4g0TYEVIwIHy+ju?=
 =?us-ascii?Q?0zijYRg1Qbfty6zSanbmSdmSFSTpXATeMyHL96V+K6+Vpe3596kuFiSiMemj?=
 =?us-ascii?Q?sgQofronF0HMDr+sCLV7l8AFkCNTe66euI6nGYeTJf1d3xCjTLZkBixhMsP2?=
 =?us-ascii?Q?sfgZSfGvOmZax8RF7Zptby5KvCwegOeflBCTJmLLEPaiiBU/QxNSQjrDwt7V?=
 =?us-ascii?Q?MnEdtbq6+ow9FltCkLQIoGXj/EYSCz1jw1xbvHy6JgWHsAjtLnlIMC6gfzy2?=
 =?us-ascii?Q?+u++HfLJ5SYTeIahNCdWPBF/9DIySOl0WBjJGTSVv2QsGuN+YbFEgOoYjsdm?=
 =?us-ascii?Q?ZMJnDno7hiykV99VIYUbxzfXpQnrYna2G6Q7c2X2RryWTOt4bDzqfshS/i2C?=
 =?us-ascii?Q?UdKGD1X9I4bi6iGwiOFJXLax3WAhKZLKp4wa3795GHIoygGbKEeeOo7GFi+H?=
 =?us-ascii?Q?VoGSTSgIVlBGgBj+MXAktuZUZIzaW3fJTXab8+c5e8m6EAs3O1GMt+SGru9v?=
 =?us-ascii?Q?6pPHVvP+aCy5mncw1dOCVRtb7NkreiCsIEMolCom1gX+0BcCa28N+yfEEQL4?=
 =?us-ascii?Q?zjsoqfj2TVHrVpWej5FwkSXqDb6210FurHw2ATzhvsIjQ5OdPNBGAluvLWnm?=
 =?us-ascii?Q?8JQpR1sLztVCcJVcS/altyfg3b3WWPKrp1UABNDGcT/Y6tNctiPSCLWaHZ06?=
 =?us-ascii?Q?hz6H9+6RFod1Usc3NWn7IjfrmnmqHN6W8oQXZpqzXyZ/OLU8upDjaq6wg4JB?=
 =?us-ascii?Q?wR6gk5pRg94mnpAmcPiXBJxOQ08Qcr9nRLKaxbwzrXtDgvxbpd2yN0txfz53?=
 =?us-ascii?Q?36JVfn9Hw2DgsKgZpBJQXmSQ4nrDtkUUvvJJHXyFNVS6/1qeaYUF1PCvpLP1?=
 =?us-ascii?Q?ei3BKVfLDeZpVk+H+8uRI0hYRRQnb6truTPTzTvgKP4THh6iiRPFIyo8edPO?=
 =?us-ascii?Q?36KD1Y6ppofKuhYp2z9ZwCTjjIQweO1VXNvYDfs9rnYRULDYxe9BrFKHoZfg?=
 =?us-ascii?Q?tKYuLGFgc0AoSC6BtGHq4daGb6gaQFjdRE/5wJ1KtPyR0EoO74C6j476gOWB?=
 =?us-ascii?Q?Z1y/cdhqcV9Q8eSt1k7B6B/haFbecVDRSonrmj7OEcYwjMFubb2aHpC1g8mW?=
 =?us-ascii?Q?GmcqxiybOUBKVSZ8LHrP/0R2bzbQdsvGv5oCQgewgi03vAwhSotcDAiWsrRn?=
 =?us-ascii?Q?ykMHULd0fdTY0DXXUZ1ySxAveCUb66oUPTaWIkqIADu7tEsXdy7j8xPStOkq?=
 =?us-ascii?Q?ZzG+bOI0onBVWkxiw80WGV3Z1Gl4RmVA0USTCpZU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ka+4wP71+ILWKqnUW3iO3eZ8/lbF6/HufmgR7PfAgiSpnV/wGxvv0tO2O+PxJnohIncZ2zjUCMqkCgwaHhqlDZfavcTlmHTZxtlKAkpsmtU1s1G1dikPLbkrW6w5PZ0UHY/N4wIVdPkRIG+73hE+0GZa9FqA4TPCMr77xoPkwsMA0hrwGDWHkYxehk1wlHd8AN2FPWoObbAzjqjcMCDSNIMHR8JQr0gLx6Dy8uWZWrrCzrslkrG3727lsB4RRDodeLbQ+CIMZtcrls7eyfnHf6jqOwSNfnpG5bfz2LJPQCVmwoRdctEb961MfOElFWI9Fm5APWGUulamaitfI1HVe0jWKV12hOeAiuqQEterAZYfp8UZXi2Ve31AY4dz/M7gn9kSOu3UQt1lU4RgzARSE0io4fYOZHeSONrU1EkC+dH7ZFVXls39tHOdgrf/ukfvkqWvRIYVSU79RjcLGxhr5p8Ri/54CZAoaZdsB80f4s+N4u5yVSAFkrrzgbhR0eXOcTOmciuNjx9rS4MoV/7n93k2DQj+pwriWG9e2NU4nWV0n82UnzFd6aE2pNUd6FO1pT1P5cm8IB917RJem+YSTx/9hTihKc3UKUoeuB32g9rmJAkIZvajpeMxdlV4LVJR
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f7ea62-92e4-4bf2-6816-08ddf5b8780e
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:04:39.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Urn4FV6rAVezIaesimQojLo0VJb62E9k4O9+HzrPwfLYYNsDTF6EdaQIqia+B2erIfiSzIXRD189lzGsAsEb1A==
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
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68ca5d88 cx=c_pps
 a=9PBua6xsuWuOPIsb3eUxOw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: V93u-WiX8TC20uWWtJK9EHZsP5-jMgl-
X-Proofpoint-ORIG-GUID: V93u-WiX8TC20uWWtJK9EHZsP5-jMgl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDA2NyBTYWx0ZWRfX32rFSzVzsv7a
 SX3/x80r/mfGosVNDFU+I1jmk9Ng72+F9/uqMikw5O853/+Ry6Rr7kFl1va58cTkj/BF4Kp48pK
 1ZaJIDOdy8J1bd9BVh8BjNbPXHijvc+9FinQSoQqu/Xmzsg3gpNOzCyg7YXxEydxvfIVPnNhezT
 I8/mZQq6FSvxVutOlGRkfVaZnqCZLaReHaQdqK9hy3wDjsvrma3j1QacVRaEqZTW4kdMe6OKOkc
 QslG3EYDntxmwWBA0cOQuepiIFcoPXodp3ugUVO36AqV/iRiYDSbEIaYUBp32m+RF3MlcFI1iPF
 4O+mx8J4Afw42l7SQVNPDuFv1POVpi3AQq3v0z3gorptzeAMUhAjFoCaMXMPuw=

To ensure correct handling of endianness in the QMI subsystem, the
QMI_DATA_LEN field used in host-side drivers remains in CPU-native byte
order. Remove unnecessary endianness conversions, considering that
QMI_DATA_LEN is always of type `u32` on the host. On the QMI wire
interface, however, its representation is variable and may use either 1 or
2 bytes.

Fixes: 3ced38da5f7d ("soc: qcom: QMI encoding/decoding for big endian")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index d8575e92dbf6..01f7045e91dc 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -365,6 +365,7 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 			break;
 
 		case QMI_DATA_LEN:
+			memcpy(&data_len_value, buf_src, sizeof(u32));
 			data_len_sz = temp_ei->elem_size == sizeof(u8) ?
 					sizeof(u8) : sizeof(u16);
 			/* Check to avoid out of range buffer access */
@@ -375,13 +376,11 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 				return -ETOOSMALL;
 			}
 			if (data_len_sz == sizeof(u8)) {
-				val8 = *(u8 *)buf_src;
-				data_len_value = (u32)val8;
+				val8 = data_len_value;
 				rc = qmi_encode_basic_elem(buf_dst, &val8,
 							   1, data_len_sz);
 			} else {
-				val16 = *(u16 *)buf_src;
-				data_len_value = (u32)le16_to_cpu(val16);
+				val16 = data_len_value;
 				rc = qmi_encode_basic_elem(buf_dst, &val16,
 							   1, data_len_sz);
 			}
@@ -664,7 +663,6 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 	int rc;
 	u8 val8;
 	u16 val16;
-	u32 val32;
 
 	while (decoded_bytes < in_buf_len) {
 		if (dec_level >= 2 && temp_ei->data_type == QMI_EOTI)
@@ -712,8 +710,7 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 							   1, data_len_sz);
 				data_len_value = (u32)val16;
 			}
-			val32 = cpu_to_le32(data_len_value);
-			memcpy(buf_dst, &val32, sizeof(u32));
+			memcpy(buf_dst, &data_len_value, sizeof(u32));
 			temp_ei = temp_ei + 1;
 			buf_dst = out_c_struct + temp_ei->offset;
 			tlv_len -= data_len_sz;
-- 
2.43.0


