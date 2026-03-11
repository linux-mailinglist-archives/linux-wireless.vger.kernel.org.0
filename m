Return-Path: <linux-wireless+bounces-32981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF/gB0tIsWlCtAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:47:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84526280E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D67F33077D5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D0A3C8721;
	Wed, 11 Mar 2026 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="izpZgbwF";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="g47T6oYW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430A3C9426;
	Wed, 11 Mar 2026 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224679; cv=fail; b=MhmSxx8lwWRi5mFvoo0J2xCOBd1cX1zrW82cpwWl1VTphPM8HSHRKqvo7Eir759xnshDWT/zZm721dqumwWRwZveOIrtCoPpENAHQLCebBPsMHnVFsZqRxGrwEDJF5eThn2sHNWWH0Sq5GJZbvtOrZvEZq9mJba4M4iLL5i1VZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224679; c=relaxed/simple;
	bh=EaUVA89pcZzXff62m8uJdaSXLyytR1wCuMOROrz3RoA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jedHfO4y7MHoeMtKOF1VZXfZMXnFaadyIt/SO6I75twnM9CsSYSWqV/PWYQpbSrYiR16iGW4MnAVBWCxbKE0/JcJ0704zAbduavmno9CT+m+AO39opuK9crLxNqobxtigyrhqTkF8JjFtwbZ0Ryi3bnaMcIjLZ8x9HSth67zUVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=izpZgbwF; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=g47T6oYW; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B509hk1115727;
	Wed, 11 Mar 2026 11:24:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=s1iFyfm+Wgp9q9rDmT6m1R
	iUvaj4gT4bow2twyb+lHI=; b=izpZgbwFS3F1eSicw5OoYwi2LDpDYarkXsCVvR
	dPS75K6aGaSZz9wIOwiCBg00ja09CQ+vfHnOfWVNLtdSMCsuqWupFZ/hU+qC0wih
	L1yaaQ5Xfvt8Vw6IuAfABywTDND3ApNEWD2jxJl2cg7bKaQoKytXxa0yMbAJeHJY
	LWL6DugHngW7XG0T0wulbDx7axL13xLzfT9TwmK8pVhXEYfDBGjle+TLEkAO36Yh
	QrL2MPrPlRLwuhu5/liShNuuNjFntzV6GaDB94sjP2dRE5uuk1ciJyKvSW6pFsNp
	dQF6ZAZGfdhGeW564MOn6jVyecyUMGC9gtvKrB1lVVULsKIw==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4ctxy4gd34-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 11:24:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRQ88lPH0GlljZ7gv3hHPsYgFmNQJQ3e0brGCXTtwkmVL/o5XZUOTYJGQm6s/4y+TNFeU/3rg1MUtQ31jRUyl6Ct9ryMj6032oRkoIuS5KF6XWTPUDmuMH4Qq/j/ea2Q+g2B9i/gUCoZF+Jrk+EvyjIUck3McLSfj6WZsC25fSHBiSX3J15Jn0M4bzp9YJw8kiXGdRBWl91IV6QFboAPA312ulqEIFvINUAVMzctORKwKcJp4veOf9uq81vLj2auJ/H9vZjXYOL1pUn+Ktcn5DIXmYMzWR5blOHrSJcLk7hV30p1R7Z4W51/om1is2b9kVfdZRplb16CNwZnnPQrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1iFyfm+Wgp9q9rDmT6m1RiUvaj4gT4bow2twyb+lHI=;
 b=FocBTFcNst5nfnMKpe1o0KPiWqwHtr74AW5Ldwkkr4Jp+7phz1D7HsOA/JQMrzOs+ukTIuqIFur6vboG3JgaF7giIUoeqtUYujTE1ENzq3OTQVB4ffCgCrIkWY9/VMkL3rPggoRUPJTHpDeaCFvIifpHrd43Fef/CRJRVwxNjivg/niHY6AjHzKPTCHzTICfM8SVwQpT5UxktJ2EqECDZUEo7o1sfUcII7rP1YYeCh6jx+mRFaZTgEoCfxULtUOrhgkt3O4tH7I5C9tSCUMow5MPAX/LyL+dxsjx4HPZDBEARhnT68R7XswBepwO0fTH5e6lsWwDpFuoWsRco2N7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1iFyfm+Wgp9q9rDmT6m1RiUvaj4gT4bow2twyb+lHI=;
 b=g47T6oYWkaCpXgsPySSZSvK9eFUKiProk8/tcW4tVa/TZkK/RNOAv1rdQqDCupuWEdTK+sBp5eKvnChzGCn6a1Fwt7eBQRiwzZwO29SHN/ReSWpRu/YMQ5VivEHXp4V+UNGVqG182qboPiLhVM1opXc5IFzQVsJzAFvnnHWqgUo=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PA2P192MB2334.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:415::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:24:22 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9678.020; Wed, 11 Mar 2026
 10:24:22 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] wifi: ath12k: fix endianness handling for SRNG ring pointer accesses
Date: Wed, 11 Mar 2026 11:24:15 +0100
Message-ID: <20260311102416.224621-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::14) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PA2P192MB2334:EE_
X-MS-Office365-Filtering-Correlation-Id: 216b1158-d180-4585-bfa2-08de7f585c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bgATdXc9JFuRMJL1UmBAE/6zCZ4wHktH285BJswV76mOYIA8bIj8uRcc6QdKCcvyCpwz0OV9mLXgaogp4hxPZWI2hH7UeYNqVMPlzONXm51Jg6+Y03c3g7IB10f3Hhl93cHsJIUdn2kB3HuU8wIT5Cpq9Wv+IvuVD6rOdEW1oPlePFRl1aWT9gGmne+61mb2QdY1lozBBg10OTMEa8EbhXF78ObLoKzyIdhlgNSPHa8qGH6UKLeZHOAMcksiDKIJHKG7gmWTusyM1DsFL5ZbZ8VV9D1w451wfJMrIHxVj7jBviawpX+2dxhS9xcXMllih1QEC/mMI+H9SCCZBAT8Ewl1YZpE+3U9Usne98YPRLcXFRsJQamgR4UvgjCivXFHg2WpRF2V71sbP4iNE5xec9PDe7LvW6fGpbJlth4mQj0CRYn/W/FcWmsJH96eSKl6HAgaIeaOdW/TND76yv2j/JSFsLQHJ70l3IL27RTBAXiDTZRfQEPC+lnyMjWwmeNKDdLsIzxZ8141ilGp9taJAHPecba6SeRHjNCEdEyWGtY3GoMtreZ0Gf+plxjc3vxX3s0rESU6RXSmfxVAGx7QaYOoaI1bKHLI5R/xSGqOIXAoqDYvQYVDLenxhfC/eliQffnH+CD+k0fYh5sg7TIqNTc0u9A8gYKNCLhiOT4PNCOdQUE55xPo8wqSUD0nzRB005LDSsuCGuEJAz2tk6txhNUtabtywS/s4qlfhu1GJ4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/DtX08d52XD5suIRNNi+g0d8tEm+S0GGiAqRQn4WJdQFlbF156Yvq4TTUXk?=
 =?us-ascii?Q?ZA2dM2OXKK5bPaZvBLCRBk41SvYH0ehur53oj9uaINf3UDtv0x41ylRHBdBI?=
 =?us-ascii?Q?YxJo0kk72Hb8Hj1weYY6deNv94iXO7Txz9AC53aEEGhzyAldwXBsTzCzLdjJ?=
 =?us-ascii?Q?s3lTwzdR7338lr2XMlWPwaGp+VV34gbIHtbQP3mJ/T2MpHq1q7OY1WVoZT4y?=
 =?us-ascii?Q?bZmumUGXS2Dn7ABsVnxvg4CkFYBn393moYTXYnFaoL6ADvBuW2rssNB203/v?=
 =?us-ascii?Q?u9e+pxuAqvhqokpTFeGwQBpmGCBbNrDb9lcoz7A5iud7/8NgK3z0Dv5bynl8?=
 =?us-ascii?Q?ZB6gV1Bg6MyimP1WD+spc5xHF91VtBHpmxv+7hQpBRcMqunWxcBiXbKKO5P5?=
 =?us-ascii?Q?t/3j5jXx/GhZ6w+V+6DFuUWp5mg6IvJ2yGDAEyG7va6us+1D51WUmIgCUuDf?=
 =?us-ascii?Q?YwvGGSm/OmLKIwUTcNWjbCTn/TmkAsdy6P/TXyILhUajvD2vG1h3wv7NB0Hb?=
 =?us-ascii?Q?xhqFR4gyjaGATLk2xNa+RwHGpk/lNgtCAqzpZy4G+fkBs1LZJG9Gpk8gA+vc?=
 =?us-ascii?Q?aPXzHi1lkZ2zJsAnxjIsZ5uDR9cdqzpIqxAiDWdbePZPeNR1EDBgos25cNx6?=
 =?us-ascii?Q?SpqkCUQlrMGtizXCYb4oiKWL3ZF9Mu9RCrIFJlY9IJBnqHiXIHM18ukQ35yF?=
 =?us-ascii?Q?xxcUqxjAhMmmczJIhtGPQstf2S7jzWy2F7a0zuyw52QS8leDsgUcNpr8HP3N?=
 =?us-ascii?Q?V9CYGuk5gS09kMWHYGRl3BfUlPFk/sv/b33YXfsnRcd1yTcymxkEnStRWwZf?=
 =?us-ascii?Q?tBkg9McVlYtoBqLzST4Uv1977tjEdNfP4+caQbL6Uustu2dk4C3oQqOy75YI?=
 =?us-ascii?Q?NPDaYb+MBV8eKfe+D85bq1vhLDow/3yFhXbPDH9rXeeiJz61G4wCEq6pD9+N?=
 =?us-ascii?Q?Nqxn7oXL6hj/w0IAWDxfgm9rBwWzAU5h5oDoUFRaE9rT3D+ONQiEfOljcm5B?=
 =?us-ascii?Q?bQKXL9kALjc7grAWvqiakycfio6Z3ikCNQpnTZgQhWT9rK2vfyeqDl0OFpim?=
 =?us-ascii?Q?MNN5/3wFQLN+iLmQ4FBr0MCV8nZaxfwfc1ZA/M/UbPNzkoLLzszjV6BV8R75?=
 =?us-ascii?Q?qxW6ZhiG5tcj1QmInKmGUH7IuGHX0kbFM6r7X29QhVvF0aaok6cyqB7HC3uA?=
 =?us-ascii?Q?GYgqMG/MKEFwHVT4Iq05gAaOlGwtKO0H8qRTveetqCHP+L34H0IlayHUdrKR?=
 =?us-ascii?Q?BEKubXjFm3VJKYx2Tlhj2hPOgOR9yR5v1PcT2ZomnDnqEv8TTeLDkhRr68yr?=
 =?us-ascii?Q?zaICwFzJno6Uk8DFO8+04Yg2ZK2T9gehbrfBwjXCc1o/5VayXkvu1MQeD1Z9?=
 =?us-ascii?Q?nBGv/0VrUJzn51SFOlDjqrmkkdwW+NHdFmDtyvpMscl21rmY02WV1+t6oeX3?=
 =?us-ascii?Q?hRCfCTQutksBBrNJm1YHKSaR6rdCCspeCdDCZswKux4kOfU2f+CZRVI6WhHG?=
 =?us-ascii?Q?7g82hwb+fJbl8atyUjsJM0UKxhEF1/xAyK2NqLrns54WfMS3QTgCThIGzHG3?=
 =?us-ascii?Q?ARzU3LUByopECY7sfKCm/nPdSKiZiJtXEfNVVRZCRl7/u3vmQr2jFpyecs3d?=
 =?us-ascii?Q?oXsu89j/CcM0RIP4FpqxWCLEztPlB0dC9Mcpwx6bNL/+4Y3CJGbpldLQwey8?=
 =?us-ascii?Q?39ZpvxHKuaqH0AgXSIhci9qWuqyxL5UvB0RDJf7vFP9Djf9t0IZydtnjGkty?=
 =?us-ascii?Q?Lq/Hp9gCUw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	t9KQOKxMYA8JCuUlebs6peF+42xWCQipZgtGKTNyKIwavfcYuZlcXITgzqVoSIq0CMmdPD+ENzvYK8q2UFmsSZpL+cpDV/wT1GVoVraKMGB51jHMnwh6Dmt/y2FVoFbdR5/206/g/G3CrXpV/xwnON+3duY9vMC0IPLkA7oCSFWSUU7qtyNMX11KzpyKizEy48C5Tc7blH78E5uEGWDlmlQdQYENI+31D1NaYNlDBngxKwN94Uy2IbPVOnTJZY9WjiNcy2IHRgUIZ+2nfoUrRFed7iCsBjIX+95qIUNg+8kNRs3/gMpSrbP4ec0vVNhTOlctaEw7iTvAWBSEtQ3eGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EmbKOau1NYGXtpYAhatZernvajWvtaV/wKdGu1i207EKA2bmeh3YeWy7L/srp1J9EgOR+fr7wvXL2LpsBb7aeocDn1bTPFmPfAj+R01u8cfmLvKqqycVfuXMNWdmY8DsHcio1Jiq+vJb1gAk/SCoofkkW1E+sRmWfgKwYLYc388Qoziqofs9uBqCnKieqTOW8WxNBU8Dl9JxCZzK4VYy5LFHJM0cWwEQmxhCJ2rhO/iA1itJc4mHdZUyJJXVkUJMBXUEWPOFLgLbIVqSpBT+O8eaTVbZOL0QhWl9qEe5XEtoa8mZYLna7SFpuyM3YTK/1yE5Z9d+l3X15HzDztntNQbWRbFWE+7tSco1ewqayWCuiytcW2HdT89OXch+8d372LweOOego3Xc8TBxE7S7SSpNQNPfeanYN5/4WEmjjAuSuncXK/VxpkAVNtiJM/6zt9KgL+S93Fo0t4I1M/sQkOORelofAJbTz9qcRTzMslWHVyMPiJYBHkTO7TT2osztLg+bdcPfy3DPt9yD5xNJ0BxUw9umsMvDz0wWZmCmaV1j4veqZxfbYSQRxbun0O/ZGe7oXIul9JnhjPOyn6vd/MqIiuAmGXm4ztVd64ZhVDEF0KMMx4gXHlQHzrxvSG0T
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216b1158-d180-4585-bfa2-08de7f585c94
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:24:22.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFNzbdYELss6QDLL11TX1MRj4KZgyJ3PHloiLmkCGN8U1A7KxvwoKtvszeatPY4eVmIM7N3wDMbUg6UXFwQaGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P192MB2334
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
X-OrganizationHeadersPreserved: PA2P192MB2334.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=deaNHHXe c=1 sm=1 tr=0 ts=69b142d9 cx=c_pps
 a=LdThStfLQ9CbqahNFmeyQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=xIER7TDS9NvsDhoS_LkA:9
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX/p1FcLqZlUtu
 ZSP4C7mH6t3jV21MyPJ/+D+T5jGJ2MQGN4YyeCH3mxYAiQNuXT56EiFMSqoQRGJKk74jQ0cQ3Uy
 n1dDg0nJOb4+dF5qaKgeDl5GNEroDZl2yhOhFle3QyghC/7a9yGTw0NUF0t3Ww8NBEpVPchdvTX
 cJKcI3XPP1GROaq0XWAJ0bLPGD5Aap/vMzG/RO2nAYEoQKlGL5ZpDf0Uy/BTWklDaViNoZ1bdTs
 Lbo4swu/jas2eoUHr235hWMp1SPMvifAkeJ4UIwklOePiiL0RUkWnM50MmJkfs6erjN1ok/H60H
 HOZ69Z2XlUCxuAna2bMF5PWjvQKizIcSkUgj3czabQEg/wiKsQ5snuaK+k/W3sjpgWSdqMYMAZx
 MreY5RfLrFtsOxI9PJHlpnfav4RT/HBHr6PM5Zuan3FeQFL/6qUv6C5zrIlemzRR1w/ryr0vGMN
 XdKq0TEHfKYlgyykIGQ==
X-Proofpoint-ORIG-GUID: EW4eGKyFMAsRWbezoeSU0wuINCWlAkKO
X-Proofpoint-GUID: EW4eGKyFMAsRWbezoeSU0wuINCWlAkKO
X-Rspamd-Queue-Id: 6C84526280E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32981-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,westermo.com:dkim,westermo.com:email,westermo.com:mid,beijerelectronicsab.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The SRNG head and tail ring pointers are stored in device memory as
little-endian values. On big-endian systems, direct dereferencing of these
pointers leads to incorrect values being read or written, causing ring
management issues and potentially breaking data flow.

This patch ensures all accesses to SRNG ring pointers use the appropriate
endianness conversions. This affects both read and write paths for source
and destination rings, as well as debug output. The changes guarantee
correct operation on both little- and big-endian architectures.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Changes in v4:
- Rebase on latest 'ath' master
- Remove volatile from `hp_addr` due to the `checkpatch.pl` warning
- Fix opening braces at the end of line due to the `checkpatch.pl` error
- Fix `u32 *` cast in `wifi7/hal.c` due to the `sparse` error

Changes in v3:
- Rebase on latest 'ath' master
- Use always 'le32_to_cpu()' macro for conversions

Changes in v2:
- Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
---
 drivers/net/wireless/ath/ath12k/hal.c       | 31 ++++++++++++---------
 drivers/net/wireless/ath/ath12k/hal.h       |  8 +++---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c | 14 ++++++----
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a164563fff28..a9c9311538b0 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -355,7 +355,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	tp = srng->u.dst_ring.tp;
 
 	if (sync_hw_ptr) {
-		hp = *srng->u.dst_ring.hp_addr;
+		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
 		srng->u.dst_ring.cached_hp = hp;
 	} else {
 		hp = srng->u.dst_ring.cached_hp;
@@ -379,7 +379,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	hp = srng->u.src_ring.hp;
 
 	if (sync_hw_ptr) {
-		tp = *srng->u.src_ring.tp_addr;
+		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
 		srng->u.src_ring.cached_tp = tp;
 	} else {
 		tp = srng->u.src_ring.cached_tp;
@@ -501,9 +501,9 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
-			*(volatile u32 *)srng->u.src_ring.tp_addr;
+			le32_to_cpu(*srng->u.src_ring.tp_addr);
 	} else {
-		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
 
 		if (hp != srng->u.dst_ring.cached_hp) {
 			srng->u.dst_ring.cached_hp = hp;
@@ -529,24 +529,27 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 		 */
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+				le32_to_cpu(*srng->u.src_ring.tp_addr);
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
 			srng->u.src_ring.last_tp =
-				*(volatile u32 *)srng->u.src_ring.tp_addr;
+				le32_to_cpu(*srng->u.src_ring.tp_addr);
 			/* Assume implementation use an MMIO write accessor
 			 * which has the required wmb() so that the descriptor
 			 * is written before the updating the head pointer.
@@ -556,7 +559,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
-			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			srng->u.dst_ring.last_hp =
+				le32_to_cpu(*srng->u.dst_ring.hp_addr);
 			/* Make sure descriptor is read before updating the
 			 * tail pointer.
 			 */
@@ -711,7 +715,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 	 * HP only when then ring isn't' empty.
 	 */
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
-	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
+	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
 		ath12k_hal_srng_access_end(ab, srng);
 }
 
@@ -810,14 +814,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
 				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.src_ring.hp,
 				   srng->u.src_ring.reap_hp,
-				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
+				   le32_to_cpu(*srng->u.src_ring.tp_addr),
+				   srng->u.src_ring.cached_tp,
 				   srng->u.src_ring.last_tp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
 		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
 			ath12k_err(ab,
 				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
 				   srng->ring_id, srng->u.dst_ring.tp,
-				   *srng->u.dst_ring.hp_addr,
+				   le32_to_cpu(*srng->u.dst_ring.hp_addr),
 				   srng->u.dst_ring.cached_hp,
 				   srng->u.dst_ring.last_hp,
 				   jiffies_to_msecs(jiffies - srng->timestamp));
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index bf4f7dbae866..d8dbcc846387 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -921,7 +921,7 @@ struct hal_srng {
 			u32 tp;
 
 			/* Shadow head pointer location to be updated by HW */
-			volatile u32 *hp_addr;
+			__le32 *hp_addr;
 
 			/* Cached head pointer */
 			u32 cached_hp;
@@ -930,7 +930,7 @@ struct hal_srng {
 			 * will be a register address and need not be
 			 * accessed through SW structure
 			 */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Current SW loop cnt */
 			u32 loop_cnt;
@@ -950,7 +950,7 @@ struct hal_srng {
 			u32 reap_hp;
 
 			/* Shadow tail pointer location to be updated by HW */
-			u32 *tp_addr;
+			__le32 *tp_addr;
 
 			/* Cached tail pointer */
 			u32 cached_tp;
@@ -959,7 +959,7 @@ struct hal_srng {
 			 * will be a register address and need not be accessed
 			 * through SW structure
 			 */
-			u32 *hp_addr;
+			__le32 *hp_addr;
 
 			/* Low threshold - in number of ring entries */
 			u32 low_threshold;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index bd1753ca0db6..c05bfcffdf5c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -320,7 +320,7 @@ void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		if (!ab->hw_params->supports_shadow_regs) {
 			srng->u.src_ring.hp_addr =
-				(u32 *)((unsigned long)ab->mem + reg_base);
+				(__le32 *)((unsigned long)ab->mem + reg_base);
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_HAL,
 				   "hal reg_base 0x%x shadow 0x%lx\n",
@@ -331,7 +331,7 @@ void ath12k_wifi7_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 	} else  {
 		if (!ab->hw_params->supports_shadow_regs) {
 			srng->u.dst_ring.tp_addr =
-				(u32 *)((unsigned long)ab->mem + reg_base +
+				(__le32 *)((unsigned long)ab->mem + reg_base +
 						(HAL_REO1_RING_TP - HAL_REO1_RING_HP));
 		} else {
 			ath12k_dbg(ab, ATH12K_DBG_HAL,
@@ -384,11 +384,13 @@ void ath12k_wifi7_hal_srng_update_hp_tp_addr(struct ath12k_base *ab,
 	srng = &hal->srng_list[ring_id];
 
 	if (srng_config->ring_dir == HAL_SRNG_DIR_DST)
-		srng->u.dst_ring.tp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
-						   (unsigned long)ab->mem);
+		srng->u.dst_ring.tp_addr =
+			(__le32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+				   (unsigned long)ab->mem);
 	else
-		srng->u.src_ring.hp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
-						   (unsigned long)ab->mem);
+		srng->u.src_ring.hp_addr =
+			(__le32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+				   (unsigned long)ab->mem);
 }
 
 u32 ath12k_wifi7_hal_ce_get_desc_size(enum hal_ce_desc type)

base-commit: c2bcd89db970ee73cccfb9c619b7287d6da4bf88
-- 
2.43.0


