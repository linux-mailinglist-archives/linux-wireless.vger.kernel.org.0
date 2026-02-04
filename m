Return-Path: <linux-wireless+bounces-31552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNxLBnCLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:09:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA40EB6FF
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA2530BAF32
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4342316D;
	Wed,  4 Feb 2026 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bDokfarA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E632F5A34;
	Wed,  4 Feb 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228321; cv=fail; b=ASPGPqEOCRU2cHZan85gave5ehxO3CwCksWgKfsrH4uNucAy1yMZh0sSDDyQOh1FEunB5+3qsjquSQ2h9Z7Vu1ZofWg0lKQ94zqP0UuEoTiUa6Q/ThhGZTPn+78ymYnzF7SmpnROSHpyI5UBcuTPHS9Lg077RMXkkOdl9tlhtBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228321; c=relaxed/simple;
	bh=CbYz/ZeIINRUKnQ9ekC0du+IXVhFM4urc2vtYyjEzWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4WbFtJoe7r2b2w5ilvmZRE12DzPfbnnJZZNtkbS/Eb62284WziJLDvqE2pjbnfLiUj3QwVjhQxxsAsZW2mqPN89mYjuSHP+5Dq0zrZsuMt+t1Om0kMapE2uzfmQslLx52QkCYXYgK0geyPNyTJDLPJC86w0ejEJciMBjMxbBAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bDokfarA; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkL+x4rexK/Z+hZ3r6ccWmz1dv3SEAx06Ax0aWAQHb4CqhDZrCZvrVxeYZRrQCt9+f1MXSJZDuqUWiMS+MqJVoyv99DAg67865j36WhFx/uCEQ9V1vcb9dC/1Xe96/2M2rfOiwrFxCnDxHLAcWljy2nfEjLogbjRoySlEOzvmC9elWULNMlDsI51xqpnmUSNAsZta2uCZKijHousaRRg7FvBQWwKJ0Y/admhNDo/qcwSxzm5sORJRW5MqIWRZZIMrj5Z2k8A51JSW0QY/V8kRVnneJVa7OLH94vsHnld03yW6ADVldCoGkEFe/s/ecQfpATlSz4d/z49FX/cKMvAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPmSvMu8tHEYTCLFXeCjKiueukdBN+EQYEAOZqyURZw=;
 b=pwGJhiIQpT/mD/9PVhWTqoD2n81XXjc4foF+CqyP59X3kalT4ZLFJsrn7kEELVCGD7ps9Kebzr16PC+Ldm8ACpvwC19tUw9lzwAKvsWsQslloV+y/qSqy/04uO+hmPWxfBVTl3Kp+ZfQgXPXw4VRxQkkbdouSWsM6x9+jTNitL2CwJBktZdCY5DQ9YxQ84uaxCf139pIQYZ0uTPakIj0JSTCXkvHq6+bblnkg/Rz6J2C4JJ1nNRmDl0P0xCQZGTm6+yxfVXSwCajkiVyV6DbYoGlLyNwIGPbR3e9hV+2yTYh3nG2TJV2WsD0N6lcSnjpbJJ6QzHxu8QQwHzjMPAZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPmSvMu8tHEYTCLFXeCjKiueukdBN+EQYEAOZqyURZw=;
 b=bDokfarAxuoyi+bi1sX1NleVTvXTgv6YTa6n90l2y80KGZReRPThzDYIVS/yZYiOwY0K7cY1xEUDxFTGu8ORAvBqButRNNaSDtf8Ze9hp2yM008Iu4RJAcjl7Ip7ZpWCBUkhepGCsqJF74dQb/bUSsEhYa5kgYfjxbvVr4qE6CJSeamtcnCobgEJhAGq3WjVNUtRq+w4julSlDeVCi0sFa4WQAu/7kuabtDhOjnDpe2q2ngY54lZljEq2jsl28YfNjzWA4kMBVQdaHpzeqbHCs+4a52fQYzkounly3iAI2NBsb3LHpK28bGN5Mm/elxGAl/L7M6vzt3pljBDCqumFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB12314.eurprd04.prod.outlook.com (2603:10a6:150:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 4 Feb
 2026 18:05:18 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:18 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 03/21] wifi: nxpwifi: add initial support for 802.11ax
Date: Thu,  5 Feb 2026 02:03:40 +0800
Message-Id: <20260204180358.632281-4-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB12314:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff45faa-e27c-4b6a-6dda-08de6417f466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sPIn7VPFCyqe3S+5c1c6pYuOy3A6ZBFGHRMyu1WZYK63XVPENmkFj1tIzZdZ?=
 =?us-ascii?Q?Xymkk/awS7pIuJSoycfl1iSZjwIB7FMniXbO2IXFwP9AMClx+FBSGThAwivV?=
 =?us-ascii?Q?s2QYO2cE024IKwRAg8HoI+4GWDZJeKNYTvapNEumHwhxDD1xbdglwk/BlsHq?=
 =?us-ascii?Q?xmGTsry7rGPU9hhpOnIrhVvIyN1oqWTUf7mxRiRKsaw4nFwZI3pgkzubnphY?=
 =?us-ascii?Q?b6sx91S1p3VU8B68EfAzwABi/qqos8eZiFSLGW+CSPNEdZU1Pc/vMwO+0Rbw?=
 =?us-ascii?Q?KEoIeG6MQ/lla3yuZxhDjBV9c3/ymckEnn2OrjLhuQQtO0guRUr+qxIeB/in?=
 =?us-ascii?Q?xaQZl+Z1Gqlild1yzvZs/VH1IOIEw29BnY7x6+FtsZa8GE5H0Y2GXqgMGRXP?=
 =?us-ascii?Q?fnsmQylhs/wVRESGx091kx30k/pZA7L38jTHOca1UBm03EdSeIriUf6GwHG2?=
 =?us-ascii?Q?WAZavvCMCEF2gQXuzTNcaSLko3V11jX0hxvnkdK28knJnN6rdzy3sSiRgsWL?=
 =?us-ascii?Q?Ak4pbP+1jW6XxD0L2TofFgQkRBHqLT49IL7Z/YciQAkAEL+SR9jzHC7s3cHV?=
 =?us-ascii?Q?RHQYJO3CfDkImvwY3kGzxOzm2/G+t5aPHtc7s4u4DFfIIpUKkaKGZ8eMMl+5?=
 =?us-ascii?Q?kYnm4hJUaLBGBPMA6S7I5GT7PrtJqDdh2yj4hUw90z4kYs8/4ePm7u7TYj8Z?=
 =?us-ascii?Q?pTqG5hMOQEyGLrtIq9ro/MaN1cxRO99GsYYQKrcqrN6fKav/8TPbxv7oXiho?=
 =?us-ascii?Q?iqnAsVXWBRbnXsYYecAr1pkNjTB/QPw8MfsdR5aEvYyMhtREZAlfHYajcq+Q?=
 =?us-ascii?Q?kmQHd1RvKxZmxOdpVc58Dzz7p8GYFTCQGAzvE17m0k8KjzqDh1g48FAVD0Ac?=
 =?us-ascii?Q?1ArqqsYeV70BsvSzsf1k6iX0JPvxElaKaEbMCZHYG7UDra9HtH5jJ3ycbNi5?=
 =?us-ascii?Q?UrZI66uq3nJrwogIAtugdVb0mEpgPSxTSsTqJgOVJvo6xff6NIRNV/ChvGry?=
 =?us-ascii?Q?CiAWKr8snEU9elwU7Obo7Qyy+8sGme8z5um/nncZMzyQE4Jda8jSPtAHP/Dy?=
 =?us-ascii?Q?CHrjHTp14KbAUphZi3WMNTnJYNe0/x7V0Mj+stJjNbOHXcMH8SLI2xN5JQj4?=
 =?us-ascii?Q?zBu0SE/7pA8zhkZFH9WDJGtRK0QMDNg4uG9MnwqhURJWPwKle4SeRv+PKpgT?=
 =?us-ascii?Q?Scv2gmvHe+N1d6Vy/rR3Kir7ptS6/QxobP/jVbb4zgtGsCQQxjksBg7Gu/Bx?=
 =?us-ascii?Q?NkEraZWPFvdPod2XTwFuKqpg7nl8hudB/UaK0kaNAeIQfyWNnCWejScj9PHA?=
 =?us-ascii?Q?8SV7w9zR9mPC1jGIublkrfALA4M3TaZalk769gfxCRkxax+S617AYpQccyGG?=
 =?us-ascii?Q?4GkOpQVgJDV2uDC21KyMvc9TKbzQOiZZ7H3QAMPhFlrO7oZGAwNcJgyhQ9WH?=
 =?us-ascii?Q?HUVvq9VaEuFurndnzrTYDRs4mCC6+zIBCoEJb8hGFKx6ZZ2AgAov7HuBJ+p3?=
 =?us-ascii?Q?efAdd3PjyuNJuylDAKMRgNAERW83cx4lZD5z+knmqklVj1YgDphMt/NoTIb6?=
 =?us-ascii?Q?K70zcGEaBTCv7qHm0W7aSW712QtHB3xG/Ml6L74UWio8nrROAvlEUL6iMxBN?=
 =?us-ascii?Q?ZLXctN/cz7sCFip7GSeeQ+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3P31ObcappxmdGsxgpHgw3OHK9mWU06HZD8AA+XPYGDUV7938t4uZyrlipD?=
 =?us-ascii?Q?6/RgqJ23eUwGMCk870Ief1DlHPW2e2CNOLhx6Mj8wJmX1FWCTM8TLXG9Cqnw?=
 =?us-ascii?Q?kwGoJVX6DgJ+ay4pwZKqJ3RLBc0l+NMAfT76QPKpwt/tFlmkGEF4JHRAxj9/?=
 =?us-ascii?Q?NB+dAKaArW4DpFlPktI6mg5ZiD/lZF3cY91RPCipNWuWY3dUI56g1qd3JbBM?=
 =?us-ascii?Q?Kja9ONme4ThRHINeb8tgb0cJohAoAS+4Efq4gyLYfQKiktDZsH3k84oWS7pf?=
 =?us-ascii?Q?mVjcjEAPDmqiwCqcuyuN4k3ffr+xKU7lYrCQevZlQ3MreGdjxglIO7jSdT/c?=
 =?us-ascii?Q?HHKw3wB5neVtUQkMrJLl9Y/pja0zqSID+Z6p7y8xjSCI2V4SEP+Fbj5vWid/?=
 =?us-ascii?Q?8e4mbvdq8ZXM6nfPi4FeO8RxAfOw+NxxHBEvA7v2VQkThAW3ukiaDtIetzzY?=
 =?us-ascii?Q?7eWSKUiIFUTwWOHG1L6QfbwAmd4HEeH0JUrH1bw+oMuEzVaYeAOgyYw/AJOm?=
 =?us-ascii?Q?DwxFNX3lUHNES+01g+ImT1DKQqunjrVZd6PMTGPLQxABLh2fAm+2AwlgoYh7?=
 =?us-ascii?Q?BfXqHrBEZ6SSvDkIKSMya95roQIJC+PaUbm0X/AIXxAuxBggvXoBrxhaXQAV?=
 =?us-ascii?Q?GZmeaEB3zUQSP3FzBjpum0Talx152sjmd5p49o1Xt8MnGWwGA6FuyzXIN7VB?=
 =?us-ascii?Q?PGwBUZn9ir4YOrp0ljFBx10h805XsAwu9XduWtcOOx3HPnlfEk7nJbLk+crb?=
 =?us-ascii?Q?6+IQ5lLNdgZwBBFFh/st09A0Cw13aJNqVVO5BApFk/N7O40IqDMC5yQM/hGt?=
 =?us-ascii?Q?ENnm4Ere2TZ7q5w1sItF1H52Ln5Td2PA7heCMRi+D/KkFhVm1ftZ95lpkCOQ?=
 =?us-ascii?Q?iIDeVYtuofjz7CVMK65Qcnl+nq4i1jWjKDqam6RXBbDJY0ujSbmqNKW6LR3j?=
 =?us-ascii?Q?bsLISe0KfdOZjhO7ko1ECn1/mSEqAuLatEo1sU4iR/9df3vh08KH/aW2WuGh?=
 =?us-ascii?Q?Lcd50sAtbJxRTe9dG+G/QeBV9LhNDYdcjC5CwfWm2+m8XVZtAvNx5dgcRsV1?=
 =?us-ascii?Q?x6x6duawK4p48D5tZ3jbmfoBz0k7elUgCJMQDMsoVS9YHaPdbbJfKpa5OviQ?=
 =?us-ascii?Q?GseX3hOqKnxcsbSdtPijlyKSb+SKFI8kuKpAzUpB2oKfE1ulzB8BQ9h8nrMq?=
 =?us-ascii?Q?RPtiFsjjQMdBowJ9a5iLvB9OwcKc9Jvq1smOOFAGjArwW/vgtK2OaqxKnTt1?=
 =?us-ascii?Q?U6R9Di7aPWuKEAngYEO6t61TiO9HwBW0ja07/JLTL5fCKhSWL/5qLkmG1NYi?=
 =?us-ascii?Q?dd9VWjuRA+GKGDVCyLXDTcCjK9sNJcEHZ2SgaFi2Svnva6CtU9OpZBiCvP9z?=
 =?us-ascii?Q?GK+F10/bxziQhmEBIao9OUcBllxmkamHKAAEVa933PwUzWdA75TBI5fLrJ8s?=
 =?us-ascii?Q?94XDw3oC79AGckkmo9sMEaQhudmXuhos8B+gJPEygw/anHduoXprUC1lvuBr?=
 =?us-ascii?Q?/oW1IRNCZK2GyY0fg8u/h4f1T79eYq9Px5LRdefeyfnWiuu0McS2Of4ZlThn?=
 =?us-ascii?Q?v34m7qk3qxpcjVooCegxyG27iRiV9MclE9pX9YS8ti7b9qGky8cLxUOhG6gx?=
 =?us-ascii?Q?+rtOSLRba2zzXP4s4rFhKatrfTqiBW0TOKfdP7Kj2FCOcsXRGCnu3/IEf6M/?=
 =?us-ascii?Q?3Sl49Fv+f7bt2gLkkTDpRzGYnJX7OKIPqhVqyN2DAiVkD6KpD2gtMSpYXzu5?=
 =?us-ascii?Q?qPy5YaY/Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff45faa-e27c-4b6a-6dda-08de6417f466
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:18.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20co8UwZ3qTYiktVvNxv63Z6EabnGPTJdlGEOZV8zqrGSQNnHA+SPUlLSrr8B65OswEuG+fpbv+egn4Z+cjUIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31552-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8EA40EB6FF
X-Rspamd-Action: no action

Introduce 802.11ax feature support for both client and AP modes,
with coordination between the driver and NXP firmware.

- In client mode, the firmware assists the association process via
  HOST_CMD_802_11_ASSOCIATE. The driver converts 802.11ax IEs from
  cfg80211 parameters into TLVs and appends them to the host command.

- In AP mode, the driver converts 802.11ax IEs into parameters for
  HOST_CMD_11AX_CFG, which are passed to the firmware for configuration.

This patch adds logic to handle HE (High Efficiency) capabilities,
including MAC/PHY features, MCS maps, and TWT (Target Wake Time)
negotiation. It also includes support for various 11ax-specific
firmware commands such as OBSS PD, beamforming, TXOMI, and BTWT.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 594 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  73 +++
 2 files changed, 667 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..cc47c435eb70
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* nxpwifi: 802.11ax (HE) support
+ * Copyright (C) 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ax.h"
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *user_he_cap = NULL;
+	u8 header_len = sizeof(struct nxpwifi_ie_types_header);
+	u16 data_len = le16_to_cpu(hw_he_cap->header.len);
+	bool he_cap_2g = false;
+	int i;
+
+	if ((data_len + header_len) > sizeof(adapter->hw_he_cap)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hw_he_cap too big, len=%d\n",
+			    data_len);
+		return;
+	}
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)hw_he_cap;
+
+	if (he_cap->he_phy_cap[0] &
+	    (AX_2G_40MHZ_SUPPORT | AX_2G_20MHZ_SUPPORT)) {
+		adapter->hw_2g_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_2g_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_2g_he_cap_len);
+		adapter->fw_bands |= BAND_GAX;
+		he_cap_2g = true;
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability element ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability element ",
+				 adapter->hw_he_cap,
+				 adapter->hw_he_cap_len);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (he_cap_2g) {
+			priv->user_2g_he_cap_len = adapter->hw_2g_he_cap_len;
+			memcpy(priv->user_2g_he_cap, adapter->hw_2g_he_cap,
+			       sizeof(adapter->hw_2g_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_2g_he_cap;
+		} else {
+			priv->user_he_cap_len = adapter->hw_he_cap_len;
+			memcpy(priv->user_he_cap, adapter->hw_he_cap,
+			       sizeof(adapter->hw_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_he_cap;
+		}
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	adapter->is_hw_11ax_capable = true;
+}
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u16 bss_band = bss_desc->bss_band;
+
+	if (bss_desc->disable_11n)
+		return false;
+
+	if (bss_band & BAND_G)
+		return (priv->config_bands & BAND_GAX);
+	else if (bss_band & BAND_A)
+		return (priv->config_bands & BAND_AAX);
+
+	return false;
+}
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+	int ret_len;
+
+	if (bands & BAND_A) {
+		memcpy(he_cap, priv->user_he_cap, priv->user_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_he_cap;
+		ret_len = priv->user_he_cap_len;
+	} else {
+		memcpy(he_cap, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_2g_he_cap;
+		ret_len = priv->user_2g_he_cap_len;
+	}
+
+	if (bands & BAND_A) {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream >> 8);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream >> 8) & 0x0f;
+	} else {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream) & 0x0f;
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->rx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->rx_mcs_80, nss);
+		if (rx_nss != 0 && nss > rx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->tx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->tx_mcs_80, nss);
+		if (tx_nss != 0 && nss > tx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	int ret_len;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	ret_len = nxpwifi_fill_he_cap_tlv(priv, he_cap, bss_desc->bss_band);
+	*buffer += ret_len;
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &cmd->params.ax_cfg;
+	u16 cmd_size;
+	struct nxpwifi_ie_types_header *header;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CFG);
+	cmd_size = sizeof(struct host_cmd_11ax_cfg) + S_DS_GEN;
+
+	he_cfg->action = cpu_to_le16(cmd_action);
+	he_cfg->band_config = ax_cfg->band;
+
+	if (ax_cfg->he_cap_cfg.len &&
+	    ax_cfg->he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+		header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+		header->type = cpu_to_le16(ax_cfg->he_cap_cfg.id);
+		header->len = cpu_to_le16(ax_cfg->he_cap_cfg.len);
+		memcpy(he_cfg->tlv + sizeof(*header),
+		       &ax_cfg->he_cap_cfg.ext_id,
+		       ax_cfg->he_cap_cfg.len);
+		cmd_size += (sizeof(*header) + ax_cfg->he_cap_cfg.len);
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
+	struct nxpwifi_ie_types_header *header;
+	u16 left_len, tlv_type, tlv_len;
+	u8 ext_id;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
+
+	left_len = le16_to_cpu(resp->size) - sizeof(*he_cfg) - S_DS_GEN;
+	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+
+	while (left_len > sizeof(*header)) {
+		tlv_type = le16_to_cpu(header->type);
+		tlv_len = le16_to_cpu(header->len);
+
+		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
+			ext_id = *((u8 *)header + sizeof(*header) + 1);
+			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+				he_cap->id = tlv_type;
+				he_cap->len = tlv_len;
+				memcpy((u8 *)&he_cap->ext_id,
+				       (u8 *)header + sizeof(*header) + 1,
+				       tlv_len);
+				if (he_cfg->band_config & BIT(1)) {
+					memcpy(priv->user_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_he_cap_len =
+						sizeof(*header) + tlv_len;
+				} else {
+					memcpy(priv->user_2g_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_2g_he_cap_len =
+						sizeof(*header) + tlv_len;
+				}
+			}
+		}
+
+		left_len -= (sizeof(*header) + tlv_len);
+		header = (struct nxpwifi_ie_types_header *)((u8 *)header +
+							    sizeof(*header) +
+							    tlv_len);
+	}
+
+	return 0;
+}
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &cmd->params.ax_cmd;
+	u16 cmd_size;
+	struct nxpwifi_11ax_sr_cmd *sr_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+	struct nxpwifi_11ax_beam_cmd *beam_cmd;
+	struct nxpwifi_11ax_htc_cmd *htc_cmd;
+	struct nxpwifi_11ax_txomi_cmd *txmoi_cmd;
+	struct nxpwifi_11ax_toltime_cmd *toltime_cmd;
+	struct nxpwifi_11ax_txop_cmd *txop_cmd;
+	struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd;
+	struct nxpwifi_11ax_llde_cmd *llde_cmd;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		sr_cmd = (struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		beam_cmd = (struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		htc_cmd = (struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		txmoi_cmd =	(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, txmoi_cmd, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		toltime_cmd = (struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		txop_cmd = (struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		set_bsrp_cmd = (struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		llde_cmd = (struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, llde_cmd, sizeof(*llde_cmd));
+		cmd_size += sizeof(*llde_cmd);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		memcpy(ax_cmd->param.sr_cfg.param.obss_pd_offset.offset,
+		       tlv->data,
+		       ax_cmd->param.sr_cfg.len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		ax_cmd->param.beam_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		ax_cmd->param.htc_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		memcpy(&ax_cmd->param.txomi_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.txomi_cfg));
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		memcpy(&ax_cmd->param.toltime_cfg.tol_time,
+		       he_cmd->val, sizeof(ax_cmd->param.toltime_cfg));
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		memcpy(&ax_cmd->param.txop_cfg.rts_thres,
+		       he_cmd->val, sizeof(ax_cmd->param.txop_cfg));
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		ax_cmd->param.setbsrp_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		memcpy(&ax_cmd->param.llde_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.llde_cfg));
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 nxpwifi_is_ap_11ax_twt_supported(struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct element *ext_cap;
+
+	if (!bss_desc->bcn_he_cap)
+		return false;
+	if (!(bss_desc->bcn_he_cap->mac_cap_info[0] & HE_MAC_CAP_TWT_RESP_SUPPORT))
+		return false;
+	if (!bss_desc->bcn_ext_cap)
+		return false;
+	ext_cap = (struct element *)bss_desc->bcn_ext_cap;
+
+	if (!(ext_cap->data[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
+		return false;
+	return true;
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap;
+
+	if (bss_desc && (!nxpwifi_is_ap_11ax_twt_supported(bss_desc))) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "AP don't support twt feature\n");
+		return false;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_he_cap;
+	} else {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_2g_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_2g_he_cap;
+	}
+
+	if (!(hw_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "FW don't support TWT\n");
+		return false;
+	}
+
+	if (!(user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "USER HE_MAC_CAP don't support TWT\n");
+		return false;
+	}
+
+	return true;
+}
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	u8 ret = 0;
+
+	if (ISSUPP_11AXENABLED(priv->adapter->fw_cap_ext) &&
+	    (priv->config_bands & BAND_GAX || priv->config_bands & BAND_AAX)) {
+		if (priv->config_bands & BAND_AAX)
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_he_cap;
+		else
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_2g_he_cap;
+		ret = user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	return ret;
+}
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &cmd->params.twt_cfg;
+	struct nxpwifi_twt_setup *twt_setup;
+	struct nxpwifi_twt_teardown *twt_teardown;
+	struct nxpwifi_twt_report *twt_report;
+	struct nxpwifi_twt_information *twt_information;
+	struct nxpwifi_btwt_ap_config *btwt_ap_config;
+	u8 i;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TWT_CFG);
+	cmd_size = sizeof(struct host_cmd_twt_cfg) + S_DS_GEN;
+
+	twt_cfg_cmd->action = cpu_to_le16(cmd_action);
+	twt_cfg_cmd->sub_id = cpu_to_le16(twt_cfg->sub_id);
+
+	switch (twt_cfg->sub_id) {
+	case NXPWIFI_11AX_TWT_SETUP_SUBID:
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+
+		memset(twt_setup, 0x00, sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit = twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced = twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled = twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled = twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type = twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier = twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint = twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent = twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = twt_cfg->param.twt_setup.twt_mantissa;
+		twt_setup->twt_request = twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold = twt_cfg->param.twt_setup.bcn_miss_threshold;
+		cmd_size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		twt_teardown = (struct nxpwifi_twt_teardown *)
+			twt_cfg_cmd->val;
+		memset(twt_teardown, 0x00,
+		       sizeof(struct nxpwifi_twt_teardown));
+		twt_teardown->flow_identifier =
+			twt_cfg->param.twt_teardown.flow_identifier;
+		twt_teardown->negotiation_type =
+			twt_cfg->param.twt_teardown.negotiation_type;
+		twt_teardown->teardown_all_twt =
+			twt_cfg->param.twt_teardown.teardown_all_twt;
+		cmd_size += sizeof(struct nxpwifi_twt_teardown);
+		break;
+	case NXPWIFI_11AX_TWT_REPORT_SUBID:
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd_size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			twt_cfg->param.twt_information.suspend_duration;
+		cmd_size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			twt_cfg->param.btwt_ap_config.ap_bcast_offset;
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa;
+			btwt_ap_config->btwt_sets[i].ap_bcast_exponent =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_exponent;
+			btwt_ap_config->btwt_sets[i].nominalwake =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].nominalwake;
+		}
+
+		cmd_size += sizeof(struct nxpwifi_btwt_ap_config);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "Unknown sub id: %d\n", twt_cfg->sub_id);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &resp->params.twt_cfg;
+	u16 action;
+
+	action = le16_to_cpu(twt_cfg_cmd->action);
+	twt_cfg->sub_id = le16_to_cpu(twt_cfg_cmd->sub_id);
+
+	if (action == HOST_ACT_GEN_GET &&
+	    twt_cfg->sub_id == NXPWIFI_11AX_TWT_REPORT_SUBID) {
+		struct nxpwifi_twt_report *twt_report =
+			(struct nxpwifi_twt_report *)twt_cfg_cmd->val;
+
+		memcpy(&twt_cfg->param.twt_report, twt_report, sizeof(struct nxpwifi_twt_report));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.h b/drivers/net/wireless/nxp/nxpwifi/11ax.h
new file mode 100644
index 000000000000..2eda69f19763
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ax support
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ */
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* Get HE MCS map code for n spatial streams (0..3). */
+static inline u16
+nxpwifi_get_he_nss_mcs(__le16 mcs_map_set, int nss) {
+	return ((le16_to_cpu(mcs_map_set) >> (2 * (nss - 1))) & 0x3);
+}
+
+static inline void
+nxpwifi_set_he_nss_mcs(__le16 *mcs_map_set, int nss, int value) {
+	u16 temp;
+
+	temp = le16_to_cpu(*mcs_map_set);
+	temp |= ((value & 0x3) << (2 * (nss - 1)));
+	*mcs_map_set = cpu_to_le16(temp);
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct  nxpwifi_bssdescriptor *bss_desc);
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap);
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc);
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands);
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv);
+
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


