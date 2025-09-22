Return-Path: <linux-wireless+bounces-27561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0FB8F173
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA3A163DA5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968042EE27D;
	Mon, 22 Sep 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="lSfSc4Av";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="fPwJcVKU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FB34BA39;
	Mon, 22 Sep 2025 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521782; cv=fail; b=SDihXw0v1r2m9HIrigTvZGXx3WdrcwfjAxn2+5iY+RYFiJHXCO7dLaaEFTV1Z9UT9sWo72ipgAIvyauNc8M0TI16c4X+CsFO1U/DU5Ga2/6cGRH9RLbSoikLVavmYk+m7ZnD4o43ZVAr+AFNGBIGraRczFKQhzRzEwuBgoZqJrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521782; c=relaxed/simple;
	bh=Q605QaeRxQ7UPY+AHFBw1wl42EP4VTo6cO5b7dkPKyY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E0TQhFIoZkCDr3WWVmVQFOGb698rxcRy8WO+A/pxiUdrLTAeMYomkwXBDZXbLu6giju3NJbhht4/5EWJsFr4jB1JzvikT2XaoJ0ZK/ZuO0x4Da0tTiu709lhZf2S7r4GliJPkCIlei9dSXBKwa1miARmbD/fUyiReuDPdrCsO/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=lSfSc4Av; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=fPwJcVKU; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58M3f0Td3855770;
	Mon, 22 Sep 2025 08:16:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=ZiBr0XOSyq4DsYSV8sGwL0
	xIYvBvcEHAkDNeJUNBU3M=; b=lSfSc4AvcwhX+rK/choRMCj32pFc4kPunG569A
	uUC429GTh/5JRtdz9mvgO5/DX61Evyg3qas7IHx2PzOBtr4MxBLIrElkNFohh00h
	yv9JZ7TSr80CvvC0Z1kb1ZGd5AEvuEmZIEHvmxZh8ERbyOUFEk6tHPsxV2mUTJd/
	7D8OjTgIr8wnHBSbB0QR+qXHfE3BTraPZpCXYb8l8GPX6ptO1Db0AeuMAtT7MDhR
	kgYxCkRPqSaJQtjsDPBIwcCyK22y83X4MmMmV0s3sXCkmnz0GTMd2sgLDi+m6DqF
	7CtMGZnlYvsdqhZZkovBWY3fHRZ6Nnn8TbxTh7GS3FOvrPLA==
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03on2096.outbound.protection.outlook.com [40.107.103.96])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 499gm89t81-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 08:16:10 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnxmQcQs5GGDYDWopj5qV0kbJd1/BotjeHJ/ouB43iA6YHf7K9I4VNG0m6oDKL5h9gS0Wrx0U58OyuWnwWuDahC3d9k86djoEANMQQYy9/KGN91PwxMi+zrvdnZMBkJBhq1SWMvtIBRzuouGgZgFD8yG5LGpDltA2ePK44BbvH7hK5nkcvUvSH7du+yANRd4RoGYlDPua50S7bG+4eXgDPy8bXKJzkqS2acOskEGvRiExp4TKbVoIzUB9H9wqgJYZDkjSjxqNoSXnlo4hC6rYIAFXDcab6m1PE+kLCljCdSZofqXkHvlFMaUOO/IF3HRHPYCvhdvsHE4jhS7V81rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiBr0XOSyq4DsYSV8sGwL0xIYvBvcEHAkDNeJUNBU3M=;
 b=SLa9E6BhpJ5i/H5hDhatQzHJon8MndDPnvecQaRc/SQPjoeykIK2E8ODt+5g9N29HaufzpgxoBeg7mYB3YHqRSHO3VZtDNDbef4ddlioHG2ARAKtTwa/Ccfig7TArNGYAzhcZKG2i/v19lF+m1Z04Vci8/Hcn5w6qjWAihl9Dmr5aR8L8D6Km7G8298GfZb1vODnII+0ZT1zFByqbTnwa3b3yp/Xp6DbENxqkuEMs1Fd2JvGxQqilnwZhcxtre6ULE295Pc+UTsv3Qtg5l1JMdwIftY2bPSKVMQS+4v7hn41FtLnHtNPxdQuSQKYi45ThkcLcygeHkFPunASbxYUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiBr0XOSyq4DsYSV8sGwL0xIYvBvcEHAkDNeJUNBU3M=;
 b=fPwJcVKUhnS9rURMsv8ketgvrIZNmlV10z+UVDVZzgb9OmawybXgG0+bmHbQIDgyTgfdzWrNSLszyaGaIMIPR1R/lJGHF5WuydGJCJ8aB8lZMh6D95uHoPhtDpznEQPyAO4hMMvyEzcHlmaOynS/siKYbX34GwczeMOIehsTfzE=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB9P192MB1827.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:39b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 06:16:09 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 06:16:09 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: enforce CPU endian format for all QMI data
Date: Mon, 22 Sep 2025 08:16:06 +0200
Message-ID: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0070.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::8) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB9P192MB1827:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c611190-4691-4340-1d0d-08ddf99f85a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOR5cHeJaFkubQB5tZJeH7OGtpYOr4L+ZVXAYOXNlP6oS6xgONOYr8IfAY2H?=
 =?us-ascii?Q?iWDOZLU8M1WChftjcu0uSF1OXOlvoZaVIa4s9rdJQDP33dK3iOEovn5cSh3w?=
 =?us-ascii?Q?SqCFsZrSF76cdA1u4MMVxveH9+CatA57GRa1W4rxUWh52GBUT/wFeBYXTpnc?=
 =?us-ascii?Q?nwa3cEsnaziD2A20R5emFPzrGklq7oyVK2fsHebKpd3IGRn3euueTpnNyTDs?=
 =?us-ascii?Q?+FzhnVFIts2qN6LD4GKoJuRDBK1OXfEcY0VORtHBeA7xdfCGtFVZv/rYa5rf?=
 =?us-ascii?Q?Mvjpzj/S1JT5HAf6iCxAj+LWdGgxhyDnlcI26Eo8yc5nPfnggOjXfD/POFGj?=
 =?us-ascii?Q?iUEPHAC+KeaVjT2sGT63PdqG25PCzH2wk9xPy4LBs+0nVe+NbBfelubQO2FG?=
 =?us-ascii?Q?oCb+JdUC8epY7O2lihvDFG70e7yh6f+f6MoSjeLn70qR8oEnCgPRW5uf5Pzg?=
 =?us-ascii?Q?h+c0dnT/Z5cwpAeD76dEYdd7y3uDTpsBrxUH57OIR2WYtmZwUTidrQv7Zn0c?=
 =?us-ascii?Q?YwsLtMjH51CpeQr0jgjNzGePhr6q9e4zbB267Dvx2JudARKl6bXXPc4QjCsH?=
 =?us-ascii?Q?tTvgRzXjX1LxcbF8snLHkrg7Ppz6UFRwPNrMlvwanPMDzH/bQnWXs6FNH1Iy?=
 =?us-ascii?Q?k+i53NzEsKmScG+vm+rV57FtVkVIwdK3eNXoXCFZ+V4fj717If9LkTIea1QQ?=
 =?us-ascii?Q?HT8asmvhU0s8nk56iMiEKvAzb3BZcv3dxXu7YoKSY+h7pgye+1nQapyFinCe?=
 =?us-ascii?Q?oJBKkirpdLGVrriemDvrTnpf1EFXM/sCj7V+Qm+W3LVkXRJ86QEp+SRE6Z+G?=
 =?us-ascii?Q?9/yuWhV+RJ7dT+yrISX+9gyyiddO+dD8tLnmktiWrPWp2ZA2oFT701m50dm+?=
 =?us-ascii?Q?Kc9nRuSG41DDGRcPvopb101joW/YBax0e+qDUprFkhp4GSAQ9wZppCDa6daD?=
 =?us-ascii?Q?lwbuXU/gReLTwgapJMcXupvUW6lyfh+eOuo8+av3zTUDVLCRTCQ1dTpe4cZV?=
 =?us-ascii?Q?0ENrtOu3ulZyWPGMBDf1tlaRdxjZ8ryGVf9pN4G95MRBcD+T/YROGXSfpJcO?=
 =?us-ascii?Q?uYQJgancaXkZ+vpq11cmXaQAqZLyE9vCNphIR6VVt3zmPwg1+0UCSg29kp8w?=
 =?us-ascii?Q?Ymzh8BuFFPwTjR4cWD1OyNiTIR8Uhl0d66IoVV/+8AwjpsqN0KGw6JdfQTna?=
 =?us-ascii?Q?+LQxpdPj/0or2JVIzpkNFVZPY81GkMLTFOi8EVArzfrkbXabhWKPbC1E6FlJ?=
 =?us-ascii?Q?Vv1KI3R1uKK4EuvCrQS8TKUofI6VmTjGzpEh8xQcCWhettyI+ROFVDgrdUWM?=
 =?us-ascii?Q?2scCH2NrEMaBtLzXkp6aeVzbGuUPMXhIwvqLTlaUWz2s1n41hPiav3Rh+o+I?=
 =?us-ascii?Q?+3VSjjRtBer18V4LzQszp2hhOmFX50OfESj/+8+GHNRNyuNoxVB5B6fN1eFb?=
 =?us-ascii?Q?2Lp36ub7hEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGIhlRxPL1QmsmyQ5RwhpdAHbjaEonPVML/oxpp6QSgAyM22aBICdkze2pcm?=
 =?us-ascii?Q?MZXCndsQkrsLe3eOxjpsdRHP5PxhPywnJ+9wB2m+AS6ysH8iBvEceiQdsQx6?=
 =?us-ascii?Q?2bPs2/2CEczrSotC5jDvqLJ4Yhc9Nz9l1L+vdWfIPED+Tt7JnfgQQeNu4hgw?=
 =?us-ascii?Q?Np4N12pasg8iOhLxg2tlkxI/3+KO8X9SZy75QlEU+n0qhr3IDKvM1ImjmCmI?=
 =?us-ascii?Q?hs7JRUMZJxedsNzDYx6fJvA7uOjQWGjVBvurfESFE5eZQjemq0I9YPk7rcRz?=
 =?us-ascii?Q?Z9Cix2DzcOM2+M87e5wnTDvqswwi9YLKi7d007NDmohY+udLtetXP8KfNwhd?=
 =?us-ascii?Q?my9e13Q9T9J1pyLX34roX2zRoOs88h2gUTl57gtw38Ms8LkrJnZ3ObZtL4XC?=
 =?us-ascii?Q?VyBTssb10SY1N3uNk0zRg8CAvZEEuG9Og+YUrEF539b42xDogXLR4TZIZr4s?=
 =?us-ascii?Q?o1ZsYQnFY4M+SjGuovq9rVZ8C6ZopoJAM5VD12SRdenMQXC1tzXqlULBUOdy?=
 =?us-ascii?Q?wXoq02pMNxX7y9WQLxwtJJ5SmEV81BZkxVNDZw6fG25xVUum1p4IaBFvvMqN?=
 =?us-ascii?Q?8pBA98r69zut48AwkbuZQt8GT+2+COMGy+9AoVVpAdKs1bsxxLjhEGYbydt9?=
 =?us-ascii?Q?D5QMs+vGEimI1e5XrvlebIB5/QswvdEIhyozK8nL1/8zQyVd88LsDgufDa9r?=
 =?us-ascii?Q?eXtfgxUzJKaXu1syoBnfDsRanvJDsKZNChxvzOarW3TmuZfaGQKvfKJMWAdG?=
 =?us-ascii?Q?kDIlIXW3r0hv7LcAHUrCqsUhOPLisPpWoGJU5RpFwogZsuYfGwUjDknkMBHD?=
 =?us-ascii?Q?Hr5xQXG2OturigVo+3lUAItTpCSFmx548ArWVu5SYCIxq+0hPlk77lz+6Fl/?=
 =?us-ascii?Q?YUtRHt4wMQx3s1UjzyIPZSydEd0miUJVrZo1u9iYIY48/BX2Hge2cpTrzPKp?=
 =?us-ascii?Q?c24bSONnKBFA08YiItae6EaEszWQ3IHNaSseyqSHEqM8USHpvhlW7J4dYELU?=
 =?us-ascii?Q?VO2Tf55m6uisEQ3GAx2Bd6s7Vv+RevlZOvf+VvjC0r76nOVY9Ha/69ry6fiu?=
 =?us-ascii?Q?9a7JchQyZ/9kzMkcph86C7Epk/tgiLT3j/HeCkEERzdd5vqQ+789yG+KgYl+?=
 =?us-ascii?Q?zw/ODxNJN56tUm4W/R8pBx6K+XSdx7Qv9v4K8RQg2oKeBkzatHxn7cOLdMgH?=
 =?us-ascii?Q?nHC97fSgyGztZKtrgk8oADQ/bpjuL6E0wpQkHRRzKd91iOIUYxTnei6CtF9X?=
 =?us-ascii?Q?noYt2aOUj3f7iV++U5KyggatWtqHQvh8AeRLdDpKo8RtpHVgawa+aY4AcG6Y?=
 =?us-ascii?Q?kFUKtDyLvKDQ0v6eYa5a258J1cJ4OXSjyV5EPkegKI7Z/tZOSOgOd6iRZ3n1?=
 =?us-ascii?Q?W9b4WE3QrgiAe10PQ0AkN07M7lPdSGKk0PbH0BRx0E+x44rubXQjuEUnq295?=
 =?us-ascii?Q?htM4N6YY6o23sZgFQRDU/4LoEDxONgjgQc4Z7rNwIrabjAWcjZ3qnWsKCL8E?=
 =?us-ascii?Q?PsF+ZpzjfM/nJE4qBS7tKb9yn5r644IZSN48Yejmws3oZkcd60bxBzt7Bclq?=
 =?us-ascii?Q?FgpMqPreFzRwEdH52fLz7kj1/kDCy+z3k8g2gkiq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T2B6X5vzK+qJLQ9DlKiyWc2CzAJhwRI62OzuU+jx/1zsinFE5IacQ6zQVuz/MG7iX2yo2vHZDMMNcS74usCrkfWLXs02ygrntjyxWNWZ1jsE5qiuQ4aCfUCkbNHk+6icr76pYBiV/KQudLMgl7PI++DFIcslPKqe6md8/zfbu2r36j4OmoJ08HqoDudFMtJGXXFhVViq+bNV2JKQY7bPoEGFoGAsRKOqWxFIYeSwzsWZoAHdtTeam9ZassoFN80oshvr4uHb0vfsBrnIljcf+R110dVu5AeLV4sWcpJMHxZ+WA14fYmIvqlLqnycSI//t5y7H+oXmBS1vtUovSYNj/APfuYenI+FTac1RQ7tV7zTTqw1C5VC7NWC+a/E3+wmwCz6Wqv8c1QvhRiTuK9WmNoD2W69sNfQIvjE+reNt2+P5HggqD5YwqVX2vympxi8xK2I+RfGOm33QTud0cXroZ7+o7LP/ZMUq6xx+SGIBsZTPOgS4XsFQESfy9xfbX4xoNNZKKEYs+dY4ARRdBAkOrHicjLFalpPm/IOJJOOI06wCjcg27kyYzB8wq8DSJptz5zskeSns4HRAiw/O2/yvhZXkw7GsRE5prMS9Lmud20E2gxt4Lu8d3seiWWRqgul
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c611190-4691-4340-1d0d-08ddf99f85a1
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:16:09.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVe0kOlX+G/E2A6eWaW71uwJyAPjdW12ZTvvzw18mWiAGDo0lqC2UaSphlulLRir0QIB0/pLjayfCPNBDnPjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1827
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
X-OrganizationHeadersPreserved: DB9P192MB1827.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 1NIt7_Ok5YysWZ1TsO--lT6fe45k3gUy
X-Proofpoint-ORIG-GUID: 1NIt7_Ok5YysWZ1TsO--lT6fe45k3gUy
X-Authority-Analysis: v=2.4 cv=B/W50PtM c=1 sm=1 tr=0 ts=68d0e9aa cx=c_pps
 a=J2aj8mry6DFhUoDGrFBtiA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=g2gty-AKM3KxiX33rxwA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA1OCBTYWx0ZWRfX3ylmXtVVxjsL
 +MX5yWWcPXseiUkgNF3EQdd17CyCVnXe9VRg4TQJ/HoZ9zmLPIxjzGxslPn+aJZtOOiE2CLaWDt
 vt1zlpIwWSxull5fuuiQPqe/tYim85erZJ7x6whKdGLR40jzdFY0Yv1rCQOnQLFhOg3QxATBiDC
 v/SkwK7c2Sd7IyBTTmvFwtwu6EzFVQZ+OfGy5LDsUFlXK1BHkS9RQQzpeWW9lbnaLc0YdwSDVmM
 W7kthtPZtQKWXZcGTvbhdJJci87QJSFMAZlRCa0AOASNmr0oDeunhDc8D7klbb2pMx0plZ9fUxa
 BDqzFjI02MPKKYBsScHEIqToebiyE/ftJRd7J7KQKrlLp1IVjpldSOiQrUBZJI=

Currently, the QMI interface only works on little endian systems due to how
it encodes and decodes data. Most QMI related data structures do not use
endian specific types and are already defined in CPU native order. The
ath12k specific QMI structs are an exception: they use partially endian
specific types, which prevents the QMI interface from being extended to
support big endian systems.

Update the two affected ath12k QMI structs to use CPU order types instead.
This is required because the QMI interface is being extended to support big
endian system, and that support depends on QMI data structures being
defined in CPU native order.

This change:
* preserves compatibility with existing kernels, which only support little
  endian system
* enables future support for big endian systems
* aligns ath12k QMI handling with the general QMI design

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/qmi.h | 16 ++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7c611a1fd6d0..36325e62aa24 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3307,20 +3307,28 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	/* This is number of CE configs */
 	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
 	for (pipe_num = 0; pipe_num < req->tgt_cfg_len ; pipe_num++) {
-		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
-		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
-		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
-		req->tgt_cfg[pipe_num].nbytes_max = ce_cfg[pipe_num].nbytes_max;
-		req->tgt_cfg[pipe_num].flags = ce_cfg[pipe_num].flags;
+		req->tgt_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(ce_cfg[pipe_num].pipenum);
+		req->tgt_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(ce_cfg[pipe_num].pipedir);
+		req->tgt_cfg[pipe_num].nentries =
+			__le32_to_cpu(ce_cfg[pipe_num].nentries);
+		req->tgt_cfg[pipe_num].nbytes_max =
+			__le32_to_cpu(ce_cfg[pipe_num].nbytes_max);
+		req->tgt_cfg[pipe_num].flags =
+			__le32_to_cpu(ce_cfg[pipe_num].flags);
 	}
 
 	req->svc_cfg_valid = 1;
 	/* This is number of Service/CE configs */
 	req->svc_cfg_len = ab->qmi.ce_cfg.svc_to_ce_map_len;
 	for (pipe_num = 0; pipe_num < req->svc_cfg_len; pipe_num++) {
-		req->svc_cfg[pipe_num].service_id = svc_cfg[pipe_num].service_id;
-		req->svc_cfg[pipe_num].pipe_dir = svc_cfg[pipe_num].pipedir;
-		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
+		req->svc_cfg[pipe_num].service_id =
+			__le32_to_cpu(svc_cfg[pipe_num].service_id);
+		req->svc_cfg[pipe_num].pipe_dir =
+			__le32_to_cpu(svc_cfg[pipe_num].pipedir);
+		req->svc_cfg[pipe_num].pipe_num =
+			__le32_to_cpu(svc_cfg[pipe_num].pipenum);
 	}
 
 	/* set shadow v3 configuration */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index abdaade3b542..4767d9a2e309 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -392,17 +392,17 @@ enum qmi_wlanfw_pipedir_enum_v01 {
 };
 
 struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01 {
-	__le32 pipe_num;
-	__le32 pipe_dir;
-	__le32 nentries;
-	__le32 nbytes_max;
-	__le32 flags;
+	u32 pipe_num;
+	u32 pipe_dir;
+	u32 nentries;
+	u32 nbytes_max;
+	u32 flags;
 };
 
 struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
-	__le32 service_id;
-	__le32 pipe_dir;
-	__le32 pipe_num;
+	u32 service_id;
+	u32 pipe_dir;
+	u32 pipe_num;
 };
 
 struct qmi_wlanfw_shadow_reg_cfg_s_v01 {

base-commit: 38cf754c15eeb0d80fbf52c933da10edb33d7906
-- 
2.43.0


