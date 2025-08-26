Return-Path: <linux-wireless+bounces-26609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE55B35564
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B8216B3B9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516512F8BDF;
	Tue, 26 Aug 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="0am30uEj";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="vjVxew4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38D2D0629;
	Tue, 26 Aug 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192836; cv=fail; b=g5tj5T1p19LadeuZHKG9iAysUoc/KYVAOZx9z8GxGXQTNtk4IYzreeVg6hVrD1qkMqoVL15mcpv7HwSYuTdjAeOcq8OYLlo0m60iLYAf4otb2z1qlpuP/F+hm9Xaaa/IdWF4WVWFieHfihteQeQ7J0LMLK93D1FxhKXblWGIQBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192836; c=relaxed/simple;
	bh=HNb4IOxZCju/cC7+kTiwN8dXv3MPvWD2kD2+RaJp3NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbjdK8JMPKhm22p+9eEoT559vmebODu+XaIydqMz3U3ubM5Q0EGqhzTyq3p//SfvI42i2TcEz82Cg+cCDJdTMRKMUE3ws1OxMANFRipEHQCMDHyTyMsLfQ+Lrl0iBjA/qBLwyC58NpZ39vHCHKFwk81X/LuxfLnn1qnihSRsFoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=0am30uEj; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=vjVxew4X; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57Q5Z1x53419711;
	Tue, 26 Aug 2025 09:20:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	K/TDx82saJe2WDvHYo+hMtaXn0tgyQhoZc3m5XhgXJ0=; b=0am30uEjhsMBlZS7
	nRwvnSycR6pMCfxKIL8rUsSA5FS8YrsWYlAmK/WMGreKuVNMB+kjMn+AB2JJrTWD
	9TffpZi7KQtzUlFP4nRmLdp+eyoyN23ZgO08HrPC1CBcXYKThz49PTevzQw1wQKk
	NpvlEFUfBUGaIq/9zsh1yngciR3/LoJkL0T0PSvm2BYGn2IjozD2GRNvWw9WoTpT
	6l5uGcj89MRddhnvbRO04zkCWwbNqsftz/4ij6vSCqyUrVoYSJB/FlctayqOoEg/
	EPuF5CWoqOeQyPVPK9Z2ET3zzJetZY0/CWdI1hJgRJCkuzzRIE9BdvBaI3I/2eMG
	6QGOIA==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2125.outbound.protection.outlook.com [40.107.241.125])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q32earsg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:20:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeL1037tZh0KpvFINNKp9vNrH5wGZRQ/OiouMnckhoLdOVtjllkQXOGoTEQjRiMHFcoEZJ0Mk+c8wBTL3yM/P7y9EZaYDIK+GTIzWBUMoERWL5eUx81SdLLTEW8LIMRG4y/J1F7W0FMh5tl76QRNU0702au6eRen22aic7tCk1/5XWfslP2Q79g2QCJaDupTBOGlJ/TEeyQAkFMnwboRfKZlKZ8Neh6Z3BaPoTZfO6RsRvURLiAaE0JxpgnUETgrU3jdgMokmqZphmAase+WBbmDDLlEysSnqZBngA6t5kL9Dg04WcPGxlgK2efyCv36I63RbfXeUIhkxLlCmwYFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/TDx82saJe2WDvHYo+hMtaXn0tgyQhoZc3m5XhgXJ0=;
 b=mGxtvXY/6mw0H9Lqb6lXs9xyMJyaXxp9g+6rWPgklm5uRgoaU9+j9tnvlyvvZqTYa8fYLeSwLeTNMQOkkSJmP9OClL411YcTu4EjufoTM2LPxodzOzPzN9853rtpMRyV9ahbMe+D2cAjTFXmVLSPQkHVY+3OP6Xf5wwgns6mREyVUE00uRDMdtFMeNoXnsZjtGK9+ffcugkC6e9uJa0gID3ddzOOl5y/fxGZhywtaJ4oUfLa6xnJBH+AzJ2lFyQHFXG1L4qWQY4dj8UFq12fPS7YlLOy+HY1yIxEPaV1Lxk4HSRM493H0qAs1Xy/qzfk1exlmJuLqzYK4xlvKvqdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/TDx82saJe2WDvHYo+hMtaXn0tgyQhoZc3m5XhgXJ0=;
 b=vjVxew4XoGvh84dqyTGYf3ZeJUimG5ciLjwUG191qP9e4nD6/QUO/skUbhH3jHo197fOS/fxaIYATILOEwyIYT31We0+VDfHr11qnQzzfsnPh6Zs1D46pu9a5F5/zd4TGNHV9WYG15qkajzqeE3M9uoweV+s8Iqu+e+2YzUMWlY=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB3P192MB2107.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:20:11 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:20:11 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/4] soc: qcom: introduce generic QMI encoding/decoding macros
Date: Tue, 26 Aug 2025 09:20:04 +0200
Message-Id: <20250826072007.1395416-2-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
References: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0147.eurprd05.prod.outlook.com
 (2603:10a6:7:28::34) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB3P192MB2107:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6752fc-d40f-4af8-38bd-08dde470fe8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQ0lTy/n5+d/EjOfRgxrxzU9jyGePQNV0EV97M2FeBeDZsagut0hAPxZcIcK?=
 =?us-ascii?Q?svfngEvWcCUpnjZ1LFdtJhk5Uu2KRT/CPy8fkzLwNQ5RftNv/XwbwAfqEzmG?=
 =?us-ascii?Q?6Q+2iZGhsqJEjtAXtl3ExyAnu+bjGfFRgo0fa/WE+oY8ho4wVsSPjY0tkoFt?=
 =?us-ascii?Q?0UYNai7DRdaLE34ddEgHb96Kd+/lqidvolqxznFZkj0fUZIWH32tbyvPVbNx?=
 =?us-ascii?Q?M3AHyz5UempmpiPwhzN25KPzuzPgJ6N+u6XXzpynhyHrBnNdPtdA22XHf2nT?=
 =?us-ascii?Q?ccR3m0kcZbMlslW4sSONUmdc+G4FKUtAbeLnJxYEbzkdlqG8akPNMFjpdYKb?=
 =?us-ascii?Q?UIFbG+J6p0AfQ+e25YnkzIVfOtCZ4sVBC+I8L9S1/r2N92CX7u/ciqL85HzI?=
 =?us-ascii?Q?x5yD2atE89vK3+pUz9xq65hGuaoFykI3gWKAsD99TTQlfwkByl/RM7Q/2Nix?=
 =?us-ascii?Q?52bOgDHVTER/SUUNjiu6DjLxoNY/eDV6uuQwh5/EPfcCURh4p2gu6I3Ia6mk?=
 =?us-ascii?Q?btCEvdGg6vjLXva4WU6gEabz+9hvfb362aW3C4G+Y/AC4V65MrBIzbB+Kxzr?=
 =?us-ascii?Q?EUaGtKthwrAT+F+6D1t+xlA/SD8Bfzf/SZ6N1G6r0S1N6mtJzftXwQ31XLrT?=
 =?us-ascii?Q?eDeEDhsl8CMU9iAG/w36X+VIactimkg4+UdRuSUzzQFRjQWkrWZRMAal0Sjh?=
 =?us-ascii?Q?tp+HD5tYB+d3ouKG4C0YmPNPGfwFj4Dqc8gexzbKkjOWSyz2yeY9BiyHt4tI?=
 =?us-ascii?Q?Hj6AlBrHOHVnxsXyv8MSYucUrSRkj977mN0GkraZraXlEvGdM8AxslVrBbmk?=
 =?us-ascii?Q?F+B0KmihToX1KLlXEIby4/5omNDBO026kx7zMlXzddOtvxKi2SfeLvX5mtDH?=
 =?us-ascii?Q?MVGrC/DGP4BY76CWa+uponLzwlzVX44wjzzs9o5S5h6iYuOqQocxG5pjwRew?=
 =?us-ascii?Q?9O7AL54i1JRpEKRLbjFRZOT1xw7dh+QNyGko3EBKkBHRaab4DWjOhD5MxS3/?=
 =?us-ascii?Q?URHnVYwrO06sniORLsYd6r4g37VnwnCRozByAvegByzS8TFzRs3w70bD3UAy?=
 =?us-ascii?Q?qFwBtI8Simc9Bk3radXpdnRR6iEZjwVQkCrd2baE+MHHR5UB9WcGtjeenc2F?=
 =?us-ascii?Q?LR5fQKfHS8Wt8PQZi6WnmslGnSgwDvbv7VRJ9zpkGO+yPEZsB41TFSaU/yPC?=
 =?us-ascii?Q?iBDB7ZAapuALB8ANYH0BnPWrrAakuEhoeCCWS86eyaFSNyMWGwxvkcRVjXD9?=
 =?us-ascii?Q?MWHiQJ5/J1h47Sus711UcVdDNHyDqXPer4QPIBm0tvYJdBzMYidhqorAX9ja?=
 =?us-ascii?Q?Eg1Ipye9HGh44VL4q7hp8xa7oXJG65CJi+VPP3YsWYam2SoaT71ahZbHdXrh?=
 =?us-ascii?Q?8bWawYxEZPzjZqFLZFzb5a98Y0phEY/s4HSF1ENLGYD/8whHVz+2brI6bJBb?=
 =?us-ascii?Q?qKWHKPrA9BU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LA7zCMCAAcvgk8QPZBlyr0P5CFw7KYGbY6kd5Ivm1NrXiM51YfSYlAyGfDFB?=
 =?us-ascii?Q?eOoQuIPZE7BIsYdWeoQi3tz59SAVV3mwizbrnLBUD37vha27j1EPanyswICy?=
 =?us-ascii?Q?SMc/UXzsii30OtvHoAUQTRC6MgzTUdzYHwtTslLJxwIFyTxW42Zrmbu2qrip?=
 =?us-ascii?Q?1c78TwxztmZKHHDgDBSU7HCWvTSCPJX7kceJdvqZwKhrrzTG5gSYVAjpPboW?=
 =?us-ascii?Q?eWZVhGMj9Gql1E31znwzkunKWeqpbetg5pby1ES+XX/YxzopUcHLSHMAWEZw?=
 =?us-ascii?Q?R8mAurkUryTwC+toinv3lEdsKtpWIYe/YwxSzPAModzj5ENLPqkf8Z2VVR5Q?=
 =?us-ascii?Q?0pGE1DY6eH34wijfz+v4q0pNGGXqNj6XcHw6a1be6HOiEjVySPu4wFz/kc3F?=
 =?us-ascii?Q?SQEREK9OLgXqJxvawdMcGMBDcUgGy1cGdK8fmlu110e5guA2VwJ3RmIfrR90?=
 =?us-ascii?Q?mlVra2eO/Lctsm4Ur2/AKgYK4MbQZDHVObyUV7LugGx5G5Hqsvaqcpdg3CzL?=
 =?us-ascii?Q?NEZagKP4VTJvtNEKrQnpPk8Aq4B8jLL+ZyolE4fxBJbY22LWkaEtwYywWIZs?=
 =?us-ascii?Q?3mCC4net/RjvGvbzEK8EgwcIIXkIp/qrlUQOAngxzw3iESop5TqFfkFQ9kXM?=
 =?us-ascii?Q?F1YeDYnUZDU5sntVrgB82pwkI7VttZfrL10LsSG8/TTSs8ba18/ha7n0jQ+C?=
 =?us-ascii?Q?28qZQLuhlmz74P+jFvmifLY++Y7kGPabIKYD3KnApbBq3zPL/qhieJOUm+/2?=
 =?us-ascii?Q?2R0i9d6ZNDi4x8YEGBr/r1zXhpEcjg3q7FXslRnnp37fd+YHuPws/O8jAMZr?=
 =?us-ascii?Q?D76pzQ3gtxFFz3MY56FQhx2LpXfwMYiK/dH+6g9+CHYZOMg1JG5zmcXb7w9L?=
 =?us-ascii?Q?uM4krldEKRiYRf/Y0zwB0zow8yqiTtYPwzlXOWJv64lqS/N/ti6KB01oLq3J?=
 =?us-ascii?Q?uAi/SxfZYGpKjkqqo9dkwnsBLfnwB2guurgxY050CmdPuWW6C/HdwrCSRnJ6?=
 =?us-ascii?Q?0hLBpRwnsv6zrYA2f1CQcgn7NBTXtR+DHMPZjpUjFSAJ1dpWHvJR2x0hP5d5?=
 =?us-ascii?Q?gFxE1r4JCaO+hDEIHkON3/ANFsvMbK6/aCYTOgf1iX016xDXIxWJb4u8FDtq?=
 =?us-ascii?Q?AMCzIQEnVF0Ji6vhdb31zLYpXp8y9febMok+K1qRbIfmz81U3ZIeAMS2UiYp?=
 =?us-ascii?Q?R1o6KgKP5sB2GV0ZKrym+nXi0HW4nmC8xEH2KFiDs+gfF/YW2JOGoQhEztzN?=
 =?us-ascii?Q?kgc1bkHALqvqtWI2G5cg0TYeBt/cRAR+EjUG1lKPro97aPPWzkrhfDz5YbdU?=
 =?us-ascii?Q?t964Z5miXz4RK2VpiiA3S0tL54g6K7HnTkw4XnU62vqnTRqyCdAyjPZbWlpk?=
 =?us-ascii?Q?jaEiDI++9cXcyHSndxV5BVTvPGS2FaPBsKHJ8HsnYC7LFTflOcN12jTmW7Xu?=
 =?us-ascii?Q?bkX44simd3A3ipD8DOYhERTFrFXxHC8A15FW79XKcrviv0is0FxjIarwc3Ro?=
 =?us-ascii?Q?nGQGeSeWkcM9jOvnAj9J78QVs/v/5IO2bwdV70UHEvxdHZh4GrKGCmQtQGwp?=
 =?us-ascii?Q?c4eUYMr6vEW5UbV+h8R13mVc/eO7q6xluZ4OervJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N91QbLFNimFoVCFAj0a7ex5u4S4wgPbxYctHyUO/QUtEtDlC49HUcUBGMqby5XCAhGUTa9oGKfZ4G7Lam9pCjvg/vzS15XJsbjZxuf+Q5wWSTlOJC7ezhrY0So5jKXDpI6uBSDoggxMxepsdRgJh0JLRFzXWX4MTG9wH/6zjxH5vaGDO5ZOhSuj+NaqRa8w442bZMvq3ToN9t7Ez7SFfiGNR4i1BqZbHaSgj4Snuigc0icrszqEbUA1ijWDeeJ6P8xNZv6z8wT5PZriztyqdmej5mq7vUPuH1Ojn4vtZ0OFbV4XlexvAbYrQ8XTBNbb7NOMtJoxe0CjjhJ9eDnR+dY1YruSCfM2u72aJFhKo4+8h8TRSYt0/cEZehuRCD3FapynHeu1XUC31c00rh3Ac8mQbvuKjYlypTiCwj4s/03+NANb0QQawO34SHLz0wIagJrD69P7pdTcABJtAzLyBgWyVTU8Uzfl4j874sDmbt/BBTB/bM+R4Qf9rHLjyHz6bgWMkTtTnFDs7KHJkdbjbPeqA7yZ8dsm/gatSHl71OtU0F+TN6geecI+Sy1R3aeecSNSWCRg0sXna+SkCEFBySyK2dkCZzbQMGCP4rBtxMn/hMHQA2PH5X6NxNBKY/W5J
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6752fc-d40f-4af8-38bd-08dde470fe8a
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:20:11.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sM/hsgqI9llbjg4c2PXMSY/L+e+eeHz66mu/3paFYAKcChMY1OrF6w+oLmq1ytTZayDvzy3LedzIDdWvwbWohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P192MB2107
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
X-OrganizationHeadersPreserved: DB3P192MB2107.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: x1MKGdzS7ajbVXzlBxETtSSPCJQkr427
X-Proofpoint-ORIG-GUID: x1MKGdzS7ajbVXzlBxETtSSPCJQkr427
X-Authority-Analysis: v=2.4 cv=P+U6hjAu c=1 sm=1 tr=0 ts=68ad602d cx=c_pps
 a=7wlwatGhICSr6ykXQ1JdrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=ezTdE78XDLEDAIlXh4cA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA2NCBTYWx0ZWRfX9wwXMBU3igSQ
 tV/ui1Ij+JzhPjob9iH2fat8qsUPI8aBkPsieGIwhIzM6qTJuXrT3NBvpJEhNyobokVCYbqYdzT
 fmaa8z/rNH9u0zwCVIdEczL8wkXnaRUbnsaRQrj/E8m8Vy9ru4JSBC076o5HbjkH7FJpnSFsazl
 ko3OUkoiJn0mQKkZPQct/roGYKd+7cUwwOzS9RSwfjNHfysN7QPuiQfapPX9kFQeKkOoZIbOV1h
 5DwTKzWy5M8K6y6OpP6N6SK3dTcWU8pvGbp9y9p0xOSiBsk536cCM+zknw1oE9IND5a45Xp2/ts
 IIaOwDbEOZMKj/zzgLkEpliN1AvHnaN74YcZsNT71kSMmOfD+CPysu9U7XSaZ8=

These macros enable future support for encoding and decoding primitive data
types in a generic way. They handle host CPU endianness while ensuring
little-endian format on the QMI wire, as required by the protocol.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 7660a960fb45..cb43531a8b66 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -11,6 +11,19 @@
 #include <linux/string.h>
 #include <linux/soc/qcom/qmi.h>
 
+#define QMI_ENCDEC_ENCODE_u8(x)			(x)
+#define QMI_ENCDEC_ENCODE_u16(x)		__cpu_to_le16(x)
+#define QMI_ENCDEC_ENCODE_u32(x)		__cpu_to_le32(x)
+#define QMI_ENCDEC_ENCODE_u64(x)		__cpu_to_le64(x)
+
+#define QMI_ENCDEC_DECODE_u8(x)			(x)
+#define QMI_ENCDEC_DECODE_u16(x)		__le16_to_cpu(x)
+#define QMI_ENCDEC_DECODE_u32(x)		__le32_to_cpu(x)
+#define QMI_ENCDEC_DECODE_u64(x)		__le64_to_cpu(x)
+
+#define QMI_ENCDEC_ENCODE(val, type)		QMI_ENCDEC_ENCODE_##type(val)
+#define QMI_ENCDEC_DECODE(val, type)		QMI_ENCDEC_DECODE_##type(val)
+
 #define QMI_ENCDEC_ENCODE_TLV(type, length, p_dst) do { \
 	*p_dst++ = type; \
 	*p_dst++ = ((u8)((length) & 0xFF)); \
-- 
2.34.1


