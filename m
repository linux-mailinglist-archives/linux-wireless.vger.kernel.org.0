Return-Path: <linux-wireless+bounces-27474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE3B839AD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 10:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBBB1C022E3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF642F2918;
	Thu, 18 Sep 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="QfyzKky2";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="vJ7FvExG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB141E32D6;
	Thu, 18 Sep 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185677; cv=fail; b=Tp+QaVYV+Aavdz6LANjhzlORTUsvUqGet7RA9F3F4wFPtE0AdWqeWX0b6DgjJQpEqKW36ZCEXwfH5XnX8MXq2vmy5CDAzXLYBIO5frobzBAbJc2OB9CS35F0Fof8SMFiKcmddCFFTz0qXqfVVfgXVf+SWwz72kwj91GF1WO+ms0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185677; c=relaxed/simple;
	bh=jdkuU5vdCns2jU55Oj/9OfxbkEsaXWeXLRFZNN7J4aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1tUPT2JiSUHNZZtWRZxyckTv7BmC+U8JZif/6MyW/fF9hQTk099145C65zmnzpa/BFJqLtNe2al6CPiN2tBdLo5r55OhP2D6d/jgFIdXpN2WnXaOglMo7AkmPWt89xjRt8k73CXccbB2+FQ2x4YNAHWgeUhm91ToGXIsD3JC6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=QfyzKky2; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=vJ7FvExG; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I4fRvF4142392;
	Thu, 18 Sep 2025 10:54:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	xUJcEPaf0uuZPx6Nl1Jt7EZSbLeRE+goCuIPyVY051Y=; b=QfyzKky2CCSrHKjZ
	hdVZyctb7jfpQydhBinKm3CBaBhvzDepPUJ4R8hTHPYTHmrn9QwxVVhCxwFqcylP
	VMVQ2Y1bbRkxUhd/fEJOqMAsHt6JiUEjMTlcpc98vXFiIb8aPBAk70PhmnjSJ2F8
	tH3bYzPh6IhDZRde8TP2yBIbbMOWtsD9lwM1fFZZUPHwpjiGlZA8rnpsV6b0K5ed
	88+jHCVWQnYwkX4Q1m0EiXnlTdHA9DN866TGMa0lHd2OIkaLODNbG6v0pi/CHziB
	tU/sL76kOvG4HOH7zAlwx0k6falFp0pAtVWmM0KLKDND20BptCn0b5pV8bMotTiU
	qAmq1Q==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 497tac91h7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 10:54:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOahcouZA7LKJ2wUYHfA6npb3Rmv5/asVCrjhbtjxvwRSUTkMAfH5Ly1AXmB68UPKo5du9228Z4BWfwBMmzVyU0NS6bMkcNBcMpfJ8MjWvcWBRWeOl+d43uqC5RSzTBtNRTj5kXMU4bL/caWP4XSeU2Efghn3A25+WtxlIyNGhR9CmauBiQrMbPCIDx0rkysK5eADst6Mjeeys0cDLrOqOUpgwEJdNBTF9coKZ9MNWhNge2hPGkWrrpvGQXZ5nH2Ssvhthx9EEPgBgJHPUqRbD/D2mkS2BzdoejJm5StAMzan5/+GOOBJltcAYVuslk6Jd9t1qSxfycsqusmS7szew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUJcEPaf0uuZPx6Nl1Jt7EZSbLeRE+goCuIPyVY051Y=;
 b=w/0pMy9Yz8nCBbEOZlx2DjUHCU9c0OOak8m6lLnR59fon2p9yAuzx3kyA7mVLA5J6D31u0/IMjG77HfiwrMavntgMZyFamT4qQWOpC56WDTLKSdRj/45EgL0vMfqM/kFZDizNNPQ+tYsM8Lst///IXmJtgleSiEdelxFEKDZdVvafwyiQW4Raqdmr/AlF6GyrCB/ehfe6js2pYcr0yVDMdlRtTtD9lSqv4uDzpsUhSwFCWP4XfB6TmqLE1iqtXFIpxTL24GdXSSZb0Q4FJyf6Ac52DSrb1PNf26+OJH7c2SWJjtRGs8YNDQikNZuSbFwO4Dm2nmJElFUCz5DWuqr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUJcEPaf0uuZPx6Nl1Jt7EZSbLeRE+goCuIPyVY051Y=;
 b=vJ7FvExGKPwwGD2nVNYDckyaJW4ZFYXZGWD2ZMHx3x+tIDDVn4Z7k2v+xX4A+RypzlOJEY9MZI1/b5fa+40TbJC49aYV5j/DdgB/CGv64UOSWyj9RxYcaHUdPLEuVSlWQMFeTIe2IqJ2DHB7awztujbEZRzPYdEfDhZV7jbh3mA=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:54:13 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:54:13 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/4] soc: qcom: introduce new QMI encode/decode macros
Date: Thu, 18 Sep 2025 10:53:56 +0200
Message-ID: <20250918085406.2049559-2-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::7) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DBAP192MB1033:EE_
X-MS-Office365-Filtering-Correlation-Id: a00f44cd-c6f6-4d16-5eac-08ddf690f0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDWsb7DBpc9CG6Zdwu/DPQsAkCnvS1e0JwKCrRVmO02JuPAyUT/+ZKiD9pvQ?=
 =?us-ascii?Q?WFcf9/0WsYLvnsk7EqaxMKr6x3ete9S5rop52myUTXPcPUsJYBZCatCiZPyb?=
 =?us-ascii?Q?/Ij5EacoZNHPeFC+aG0fA2y8DHlFpw6eOddp5PRNQXrbbHjQDUXuTIdOgaYM?=
 =?us-ascii?Q?ZHB8VtXNl7H5vbrbmdBJZ2FcjkQntU8e/btFakqAncre+5I3ZvHFpTxmQXao?=
 =?us-ascii?Q?2xLj5kNc7ULZTHfs9nH/FtD5WrODyvEp2eR04djC1KKtL1eWM3qC+AUm97QM?=
 =?us-ascii?Q?S/KurzhEyLjWu4tAHE+aw4tc674U04DYSXZWchPZOaM7J7kgrp3JTRA16tZn?=
 =?us-ascii?Q?3SCpfU/dNZL+YhYXG4pnqmtOrB6ETXPxM8SCUtRDUbU1CPRnvI/7Hp0PcgM2?=
 =?us-ascii?Q?/LrF/KKRHlDrv7p+F2YBezn288crBGs+36iggHE70Q8Vn1LmyJVJ4pGcqQPh?=
 =?us-ascii?Q?8bqeiou645VEe6GvkQ8pTlGDfbnwNVYZQf4fVd49nfqgyuTgXORJN7pgWhVl?=
 =?us-ascii?Q?5kb0caLHMGwoZTMG9EL0ewdyY+SSzXYuEUNIIICB0N7SHJavxIGlBliMWnae?=
 =?us-ascii?Q?RnjVFRRLl9yi2UYDdrMDFDh2QUW8RFjFM3AgPMgNmor2eGozgTNxmUoabha5?=
 =?us-ascii?Q?u2m57JRDPfvxuLICVdwjhv4+8tWOUQ57FR7516VHUpfTzCNISKVpMsSV2OBO?=
 =?us-ascii?Q?hY9BannQ80BHGVd6TNjlypo6rLJiNORPyZlCyQe3NM77bdKYp4XDjzib7JLQ?=
 =?us-ascii?Q?I2Mo8vM6sO42rEhOLwZTbDAhQCnSq0OcTufcLxMaXCYT0y5F9Z8ADh2tqaxe?=
 =?us-ascii?Q?ynmyq3RSNRgeaCnCndUayHI0SoY75FUJPmxB0XkvTemLia/FNLm92scFESm3?=
 =?us-ascii?Q?c2DreQAblbmKkZIwG19t1CRUwBsBsta++ll9wc6Lk/YapycKPpy9B0v9yw63?=
 =?us-ascii?Q?9vkqlsP6D+2po+YiSgwFERAft7ofdZpLWJGHam08kHEWWA9JGjNVqYSkMByI?=
 =?us-ascii?Q?ec9S7wtKDmMsSLkAGtOFlUo2QMpVi1kjgUSg8yp3yswQJtS7V8ntZg5WFrEe?=
 =?us-ascii?Q?ZN2DoSohM/HqGk85X8dL8Sx6Z/r6QkICTbUYIZnI4rJx0r4pCd0KCqLysPmB?=
 =?us-ascii?Q?itkkajcGGCJlD8zpfbh6KxR3aWtbPGaxF/ljnoDKBAiAJ49pu9Ct9coV6xHW?=
 =?us-ascii?Q?x8N1nB/LUJekK8hWsRQ5TL5O1gAzCMqPEqDMkRjRGC9WFGwbFziGHkwd3SLb?=
 =?us-ascii?Q?uNbQ8umkPNZFr0d4h8rGSEO1vNj+uos4joUvHXwnbU4iHcAsyLqHpVZ9Zabi?=
 =?us-ascii?Q?chrTd5HkoSZXseyAzYOJK5ie7xCGuUEfB1s75xxlTj3XLXC9LHwhW6YqE56R?=
 =?us-ascii?Q?C0dljA0eVvtvZYzfJTc2jr4CgJG77PGtRvNjyZxD4oii7frPYqgn5z5zkhQy?=
 =?us-ascii?Q?WUhsbOtJFl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FjWfoEjGaFyrfEWnmKCQACHbWe84LPH3hEh3e9no7qlmHSK5QdLSUPveinA5?=
 =?us-ascii?Q?F0VAtHl1h7X/vbHA5xgbTYQ8Sr42oT6lxWzGQNRVL6Rj2MF1zXzE93wkLIhe?=
 =?us-ascii?Q?rjuXTHS5qgKbNUkQzVxv9DPqmLLnQcznzV6nXiAsLqEYO+VO5HssAmqokkKv?=
 =?us-ascii?Q?YpPiAvCNHUr0MP6uVek0LkMD5GCOi7VVyGOGafKwyPblhu6pDx4oyOPC2RO/?=
 =?us-ascii?Q?Iqj3pMTZApHjCi9eRrcxbDgJppwJicJV/MFJUQQ0p5IwN7MP+4a7tDbbWp/+?=
 =?us-ascii?Q?d8OqgAK4gv0V4xIBnMEHfkNe3mx/6AP59yS7RaSh8EKUajr3+p0eUIWS8ccL?=
 =?us-ascii?Q?mKOD3HmJlTG6A81C67HHyT6Ng9D/n+qOcfWZbUiytmGhMHGfqFCb94LR/NFG?=
 =?us-ascii?Q?7H54MdoLTpy2px2lel5jPJLMngw7DxP4q5Kfh2JzbMXenLJf4VnOEFmMcAxZ?=
 =?us-ascii?Q?yhnVbhDzYC7N9uCHqvVCzjnlvnLgHfqvE0Z4mpAPQtLIcZuXCdDmi1A6mEfi?=
 =?us-ascii?Q?AWTcWm9g3um62HfghYUgwxVPyJI74+AlT42SKLgGeoPcXOmC3DeCf12y/giy?=
 =?us-ascii?Q?Ivark5aoBa+YGSENgDAsuW0SX0EK4WypHxmQ3vSzKVQnGz9PMVkZSC0o+Gvz?=
 =?us-ascii?Q?z6TQlGJR4PvBEYlHIuIyjvC0ypoCHg2u8fi2iyGBSyK3ptFySwH0OXXejwrH?=
 =?us-ascii?Q?e1DdwNn/9an/ZqX6ntsb9XU/IRbj3LB2iMEQZ15OythD0itV4WGEwAt6StYC?=
 =?us-ascii?Q?0Ru+bRJE1DDeAJIGcOVXY05BCp8jdlQgjvsBzXIfMOytnTHlHnaCFQ7ZGz4k?=
 =?us-ascii?Q?htKCOItGV0mQScHqBTSHHJp1gD2PdRWMYgFeFpqq1F0t28wOasYg3VsFJUWd?=
 =?us-ascii?Q?qXTL1k4l5ExDt52LgQrbJGkPOTsj738WqGbXHZuPrVWQrZVQYdQCFP/ozCmb?=
 =?us-ascii?Q?lijAskZelrITtBqjPLjt0YSzWVYjmg0x4DG7yBw4D85oTF/Jk2cs5sL9exdB?=
 =?us-ascii?Q?MtxYHk2vyMgfhDorGCvrOdEejwP3I+wxE/N2HEzYyuP2bNvWgKPVfO75zDgf?=
 =?us-ascii?Q?5imatB2+0TWv2SOBf2KIX+UOm9tCYo8f3cOsALudJhMgDHQDiVQNKRbDej0W?=
 =?us-ascii?Q?Fv+2uqNoHyFh6i+wpHXTgObnAPEUbrtD6vyilh05aPgw2TbiNFvBnecNFhd7?=
 =?us-ascii?Q?bAnHEpF5rqb/PBh6yFvQg6eDERV9Aq2bnQUyvxAcImos2+mMsY1n3yK6/KBO?=
 =?us-ascii?Q?Du3/iPT2d5Umsjz7+oA8R9CUaW16hyQq8INR66xTCacv7hX5rQ7wfZ2F5ayD?=
 =?us-ascii?Q?yXoDoIfoE+ubMbtakSR828AmH6iClLReoVcDejpotPuSCGC6OPk0t6ATOGGX?=
 =?us-ascii?Q?vKY5btCWIolN26IP/xo9FWoBRhRmBitIBr4v9uqiK8VvbzecIgUv+P7gNxin?=
 =?us-ascii?Q?x/Ilc2yfHzc5cCXvlrki3hL0PWsua9R2jKnabp8W8G2QqMQz7RJn22w8Lg61?=
 =?us-ascii?Q?MKOm+1Lmu+qt2Jx/ulQxKtOTA+U8J8nFtVAsCqy6U+BPwPuPFUx4SxgDZAOy?=
 =?us-ascii?Q?kMGFNLu+VIX19ZjAm2pWr102i3mGfz2Sw/rNpfY1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7rzV98/HSOcl4ga1Rr9pREZUXqa6S0YM5RFkN/jZdV5kLzpvLqfCKJkpgSgBLnHFf4A/h7J9TnTiCROLPlg4U8VxsTZhz5RiNP0WT5mileR7CUd1ByypV/zw2RwtmucgvvaFtYUEeF//d6k8OIrwQhkrYUxPaNHl+2ANMev4RwmNbSTLFF21sKiAE647fqgTM0q+xSJzwqTdAfRP/WQw+Lv7Uh9KRFCzrmXrt6Z0ID3aOzlhbHg94hpUmVBnkYyw0cPzHH/ETKfXofvM+X3a1dS2Gl3soOPI+GwYxMsu2CFHOm6itYX4FdBUr6LkoBirvnN4TTKKwkFklHcF7t2hluRonCkxkOWKzrCdeiDZWFUT7HeA/RmzO/vAvhkGiP4KypbMFqB3fpG5OKvcng4V6fIAyElrd1eKzR/atEFA6+tUOupkoPC5BkfqAs3HWxADRMI+5Bq4zCCQ1B8zWr7+xoqF6jwCwuiUoCzphGzv3KFkQ38QAhikTr3/odeUITMk2Q0Oy7fAxymlKsVb4IywVten25uqwAjBbCyV2y549wFErkPJonwQqjkgo1yZFLPd2a6dgNw3P4s+8+ydeJsK3HJT7gFXe2UQIa6nP0x/qBlloCojLcOYUolEXxzP0EVt
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00f44cd-c6f6-4d16-5eac-08ddf690f0c4
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:54:13.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hXujpi9NLDqUkfS1k5E/7JKCVT4wSQ7sWa7z52ZI3cSFzdwem1RGPV4klvK32c/76Lm5KihbCB+0fxsIUmFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB1033
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
X-OrganizationHeadersPreserved: DBAP192MB1033.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=d8L1yQjE c=1 sm=1 tr=0 ts=68cbc8b7 cx=c_pps
 a=9jQwobZG1rv2jIBEQdMNQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: 3NPZWF6P9ZQUzW14l1ereued-4M8NCB4
X-Proofpoint-GUID: 3NPZWF6P9ZQUzW14l1ereued-4M8NCB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4MSBTYWx0ZWRfX2IU80squsNZL
 7mfOGJFxr6chxaxBOVTUbw+CXXJeZXTitsbAcbglj4mrL+fNDHzAAzrUEBz9qz2I+R+dtuVWa1n
 sevRHP3umU3fdQgVbOcbjHkihLDPO2V5o5x/QVux/0GsWUYgXeEO4IJrIP6phkZWi1An8uCDWQo
 vDtb/q9bDzPhHHQjZNv2Z04nPNzmcSkRhzZP/gfegbtJ7HRJKb+M+VTeEj8IeXixzX7V26cWJjM
 f+i+Oj9op/OSOmGG9OnU1kxlmp6tzKivYE2gVG10ngAu2iUzog7ILbyFWKWKP5AeypY6rM5GNO5
 3oMz6bx9MpPAk3T/e/IOijXmH9wks17FfPz4W0ekpnarA9ZDlCazbAsqEbVtA4=

Introduce new QMI encode/decode macros for each basic element type. It
allows us to further distribute and handle endianness conversion of basic
element types of different size.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 7660a960fb45..1f9091458d72 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -30,6 +30,34 @@ do { \
 	p_src = (u8 *)p_src + size; \
 } while (0)
 
+#define QMI_ENCDEC_ENCODE_U8(p_dst, p_src) \
+do { \
+	memcpy(p_dst, p_src, sizeof(u8)); \
+	p_dst = (u8 *)p_dst + sizeof(u8); \
+	p_src = (u8 *)p_src + sizeof(u8); \
+} while (0)
+
+#define QMI_ENCDEC_ENCODE_U16(p_dst, p_src) \
+do { \
+	*(__le16 *)p_dst = __cpu_to_le16(*(u16 *)p_src); \
+	p_dst = (u8 *)p_dst + sizeof(u16); \
+	p_src = (u8 *)p_src + sizeof(u16); \
+} while (0)
+
+#define QMI_ENCDEC_ENCODE_U32(p_dst, p_src) \
+do { \
+	*(__le32 *)p_dst = __cpu_to_le32(*(u32 *)p_src); \
+	p_dst = (u8 *)p_dst + sizeof(u32); \
+	p_src = (u8 *)p_src + sizeof(u32); \
+} while (0)
+
+#define QMI_ENCDEC_ENCODE_U64(p_dst, p_src) \
+do { \
+	*(__le64 *)p_dst = __cpu_to_le64(*(u64 *)p_src); \
+	p_dst = (u8 *)p_dst + sizeof(u64); \
+	p_src = (u8 *)p_src + sizeof(u64); \
+} while (0)
+
 #define QMI_ENCDEC_DECODE_N_BYTES(p_dst, p_src, size) \
 do { \
 	memcpy(p_dst, p_src, size); \
@@ -37,6 +65,34 @@ do { \
 	p_src = (u8 *)p_src + size; \
 } while (0)
 
+#define QMI_ENCDEC_DECODE_U8(p_dst, p_src) \
+do { \
+	memcpy(p_dst, p_src, sizeof(u8)); \
+	p_dst = (u8 *)p_dst + sizeof(u8); \
+	p_src = (u8 *)p_src + sizeof(u8); \
+} while (0)
+
+#define QMI_ENCDEC_DECODE_U16(p_dst, p_src) \
+do { \
+	*(u16 *)p_dst = __le16_to_cpu(*(__le16 *)p_src); \
+	p_dst = (u8 *)p_dst + sizeof(u16); \
+	p_src = (u8 *)p_src + sizeof(u16); \
+} while (0)
+
+#define QMI_ENCDEC_DECODE_U32(p_dst, p_src) \
+do { \
+	*(u32 *)p_dst = __le32_to_cpu(*(__le32 *)p_src); \
+	p_dst = (u8 *)p_dst + sizeof(u32); \
+	p_src = (u8 *)p_src + sizeof(u32); \
+} while (0)
+
+#define QMI_ENCDEC_DECODE_U64(p_dst, p_src) \
+do { \
+	*(u64 *)p_dst = __le64_to_cpu(*(__le64 *)p_src); \
+	p_dst = (u8 *)p_dst + sizeof(u64); \
+	p_src = (u8 *)p_src + sizeof(u64); \
+} while (0)
+
 #define UPDATE_ENCODE_VARIABLES(temp_si, buf_dst, \
 				encoded_bytes, tlv_len, encode_tlv, rc) \
 do { \
-- 
2.43.0


