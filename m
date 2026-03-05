Return-Path: <linux-wireless+bounces-32542-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CHsG9aZqWm7AgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32542-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:57:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9E213F8D
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 787263085353
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D13BD62A;
	Thu,  5 Mar 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NZ3hg6Ve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011A3ACA41;
	Thu,  5 Mar 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721777; cv=fail; b=UQyiwJJNzU0A4B0Srp+ZdciUbDx2ikr3e7DftjzBwKKMBPJ0BBnj8bcc44zj0XlA5ErSwxfgn7AtATqfrzzLI0K/qFw4XJyaY7VVFmlwZlhLvCdMwfN49PZfrHX/NmdAbnE+8/W0MnwKcLR7f8Mq0/9mw5J/Zuth+5qfR35zzHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721777; c=relaxed/simple;
	bh=eqYdI2sUnDz9zazWnyvj7s/9CszSRz2PEQJVgxZQzhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rFFnSLbedy2BxR+7omjLQClLTL2XNay51p3vekI0WmRSwaI5dVcMD8UU6n+54APrdqd40SIjHB7sELjPT7KLDxP8+yUK37A+/LSfdlUR+dVOfDBEALDbPwQ52YqQoFgHHm3/uJHUr+s2nb+4llCI66mn/cQ9pnrV366W92ccx/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NZ3hg6Ve; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkIZzGsXLN6vwlgC71PAv/s++/wTjMXuaIP+Ty6CoQWpfPHLVfWe1LC/3k0ooUjPjkabDl2LRj4vHqWfyV6OVEnKVYCKDMfuVlJ/g7WkCaDBN94bIrk6wafjBd4ulc46TC3AUs6pwmfNcs261+shKUpnKJRfmUx2ONotdS0VbJIerXVeRxqKvb67SMFun9pqzN9/GkTztxquNcjcJz/et2BcV9V78nyLvAsffp8tXxg3THK0QGT4QfCKyLmRBkUxVtp35BnTYGsPP+mH522KWYCdGVzabINVd9gC2X5f7VTwfBB+PWlboCAuNcR45V6SGIvwBgyrofSasFQuS0Dttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMix0xz6EeC8tyUDjiX2s213e76CWqJ6+AKXhW7Qye4=;
 b=trCBLRvdW9AzJcN59zK1OfrynPoV0ZO0GPZ2zIlhHFGwDrZuZDVbRkkAelUyqICtqbwy85+BJZirll9DAErialeexuO5xJuyieG3WSpLhk+/KrUvs4kWfp1JB6r8yHEk+aZZVD2FYU7fOEUBYulk+tLW36BPz/tQCwnrqqh9ex6tshbe5ALetCcFq9eq7eXXInizDq6icNMDCh7I+LGNc5Qr+pQONwr+JojhSLyrJXyU8MMuKQbSlblNpEhSzaNWYRKP9nVuNIZ176zkR49HJWrlURyfQ5ZpNmjQqbKXlwpws4zM3UCaYJjIzQ5sDVd23KktwJo2Jd9UaROBmgzTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMix0xz6EeC8tyUDjiX2s213e76CWqJ6+AKXhW7Qye4=;
 b=NZ3hg6Ve1DthRMxrABw641W0SG4mKWGRmB2BhDRgSUTl5Gl66UbPZb/NLMwYuJRadD3PRyVLBqmLF6Gp/L8ZMaJIvhaf6Q+kE8DjkYBuJRgugTAb8xeeNgMvwH2GBxM8yFmzsSbADV6E2D9raw9nptNsagncUneTCcoX6irVD98xehmo9D8sbiU7Ke5gk8wclWtdP/jhUR3Fr/UJiNg7nptVztwOr5o9+ROppj4AMrmIwsvnmVyqNnzaXOMz6pmHYSkBgYa76YHLAss+aOf4GosGHTszBWwSo4nX3U14l89qeXVSyqTahloXKlWiLyTMGw+Q2U1mo4y4YmWF4xgPFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB9679.eurprd04.prod.outlook.com (2603:10a6:102:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:42:47 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:44 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 21/21] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Thu,  5 Mar 2026 22:39:39 +0800
Message-Id: <20260305143939.3724868-22-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbce83b-c480-43a1-1701-08de7ac575fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	eI0oedk9zz4TRNJQezBeowh+3llRMIzmR2Km4LE5SQ/OUdExuKlfjXi0j11ybsJnCO3afoMy7nIKWtat8Guu66j/WlmrlCVnNtLNdNwleMeAEqKfWy0cEs9QtTk9Bj7qfnZ7/UxD7F9r+xV79FkPJ7sXiL+XD9xxAk+rlnWR3Nqe6LmwqL3zuZctmyCo6ijm0pOa9NjQTwtQhDb9LGekdyemsSswmjs3lmoKmiAHy+mKiUgbqYvBCyXSA1jJgNMjG1PEERl+U836p+l43WnXYurvaK7EE9/NQYc/WtFuIWsfTP5m1MTp4q0Vj9Tika4EeWbZTvXbetjs7IByrMad8BFL7PBYL6TPJslU+l9C0Zoy+hpQG7ecMG5H/c2NjR5bchErNYXAUPYOGGDQubkFkBR16rC6Ec8ES7Yhax/OzBdrl8pySKQ9s0kpIJE2AoX/s25v8ld1zRIkd2ylfcvCGsJAmhNRz0Tfq8tQwWrmlSSl7Q1MA8Ee8Ctt/9jrbMfKOOod+zlD10N+bBnxtdzTfW3UYoyG9W3Ef9NiqjwJLFWhIcHc4qVxl5Wvh3k7BWjU/hq6ikNgCBGYdfLW1QQ93TXNkXPkUfMMRhtqCuVRfSeKZ+9+4YpGLBKcE6Zh1tl2MhNsiATknCsmbEQlaLcS1OE1+R1EnMJQo9xcuDY/Z57B9rUq8d5d1dEqyT4JlsaEWOQqV5Htlt6g/gD8YRWNXSjKxFlQ3StVsh29sB69A+eha8Tu0r2sYQOKcoqZaDpy7/VhT/UFiHanRavldroYwIPdmsEKPYusFqXDjl0anmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vP5oVHMh2frwkXBbox0MqGvVzSjF5t/BAjDBZ0nSbw0jpTxtyh8XSK+PXHcl?=
 =?us-ascii?Q?2+fk2XI7AhU3fGxluWpo2qvJYjVQIdrGPZvmGVzHbguIkLk+E9U/EiUceMNM?=
 =?us-ascii?Q?Yj6VnnYcueHBiS0v8WKCwzj4U0K4pasdGnAdkuBWbtZARrOaz+wibllRjnlq?=
 =?us-ascii?Q?r+LXbRmxHNO5kUPZr4mTcr4cdVQw0N0jvV02WcFWIhlfAutYFOij8uIVstwH?=
 =?us-ascii?Q?3n4yX2NMhXUnkCNzxswzaYRv1R0PVdWmvxkIWV0TxnnEzlFUBaE3ARtU4eWx?=
 =?us-ascii?Q?GM9hHyrRi59HRZpn0p3rFd+5wboe3ThjtCv5lhjbDkIzOkpnqHoP3Mq7Ooiy?=
 =?us-ascii?Q?+bX2ECnJwWtKFaeLNBOdHD8sUsMGH5nq+ul5lXEjmwAZSRirJi8XlOCT2vBL?=
 =?us-ascii?Q?Z/+S5aQI1sL6BE/9ZUaOwsk8svptBM5fr2UKZSdYIYZPrGtcbznivmTKaaP7?=
 =?us-ascii?Q?dkUgXyMwGWnRdxO9efXv6iWgDtkIBhUcnOtkG9luA04hTRRItbOQEorPzuRq?=
 =?us-ascii?Q?nyfjB3eE2jlJG/92HqNSuuxVl1sCO+NwAS+pX3PQxzvgrWobp/WX7BY6LDT2?=
 =?us-ascii?Q?6/hm2/S/sUGro87rB0fhPcuguNZjqu1MbDaaMW9VOqFhsslYbTuxpu26QO1l?=
 =?us-ascii?Q?FG7L9bSuK8TxnFxzm6TLmcn36lu11mMdt7SWzQsgzD3E1X1AbuVKP8GARXPy?=
 =?us-ascii?Q?mExUaSCpf/76EhcURqKBoC6LXLfzK7g5AdLItASaSU7V5Y7+3SB39dIQIm1R?=
 =?us-ascii?Q?9nBs/dH8oHMxy1vxrbFA/khvzN366eZEIILLKcXvYgjQSQQ0kRQS9oU3nDVq?=
 =?us-ascii?Q?gVUIw044z/HL/REpc3A2LHPagRseNH4K7uZ6GJWDxjBDXwXWbDL1v2LGpqHN?=
 =?us-ascii?Q?g+6SW06FxXtEGTxYr4euqbURZsxcYuBqzofNHNWVhXdIohED/MxztqhafMbW?=
 =?us-ascii?Q?andHPUNURVJqmZPY8WuIE834LcgfYiWYs3r2tqlLI2XxsJcfa+iQrn7ijBh3?=
 =?us-ascii?Q?JfUYiKTv3ynJUNki9WE6dNPl7RyvaGMLs2TVhpSEXqr8G+wFuVv50fLheLfw?=
 =?us-ascii?Q?rUhEQ/LQPm8Qr4Vx1fAfGalpInHOSitGZwEqN1FEnvbWQXKEwrqWsY9NaWoW?=
 =?us-ascii?Q?1dBCI7rwAKrQb4uTml2uiKdRfIl8P+8N+3te2uWgqUNFI0ehSFHfhSa51SG1?=
 =?us-ascii?Q?PN3XMaXc2klOS7N8hNBytc57Dpj855wCiHfHd7EdntHhbmJGXYMhji5TyjqQ?=
 =?us-ascii?Q?uEzt8qWg63yccBKf/MczUBM+Dqv1Z8XiZayfEPHbi8TWrc8zFo5UihCvtqXd?=
 =?us-ascii?Q?IzHMqmsI8XpIzMZ22UWie14vHejbgA8CyvWYfhAZC91r89qU9j7Ct92FqPm0?=
 =?us-ascii?Q?1PfnAbU7V++W4IAc3zN1kg5c7R7vRxK7VMENecv4zjnyoG2JOvlohnfsnYyz?=
 =?us-ascii?Q?/v2KeNLaEY8sGJJyjoRA8aqMBkBXW4uvXLdMCqpx4cBvOBEiMtOM56vic21O?=
 =?us-ascii?Q?OWCU/i4+L8/A9aPSMqjyUFG0qKKSMeNSWZWiK/69V4noSjYI5q7354YPy4W2?=
 =?us-ascii?Q?oVtWWbUHD1gI5VqeVZ49XW/bxHaLaMtY2CBUT9gAaXFWRTXGzPdXau3isojn?=
 =?us-ascii?Q?KCqAN5E+jTpdIlU2DQj9Zlk/SG/Q2nDPMgotsCpJikszTKlywuYv/3T5Z8Vv?=
 =?us-ascii?Q?ixj6Gb+ClDAxPdjVDH3AIm8mcc30H6d+wraM8MjY2Ipz/7VofUIvbyGHH9l9?=
 =?us-ascii?Q?LL6kCmXFFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbce83b-c480-43a1-1701-08de7ac575fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:44.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9I9pDEWeuD+KlP+tObksxBXgtO1n/ZAoIwNQIgWzkxage9THMO06NNyPzRRJ3c8qJ/nFXC7Hj8ER0IRbMadoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9679
X-Rspamd-Queue-Id: 72A9E213F8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32542-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,carnegierobotics.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,dolcini.it:email]
X-Rspamd-Action: no action

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2265e2c9bfbe..9d61e9936fce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19105,6 +19105,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 F:	drivers/ptp/ptp_netc.c
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	Jeff Chen <jeff.chen_1@nxp.com>
+R:	Francesco Dolcini <francesco@dolcini.it>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
 M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
 S:	Maintained
-- 
2.34.1


