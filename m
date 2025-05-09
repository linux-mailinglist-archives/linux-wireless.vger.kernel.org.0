Return-Path: <linux-wireless+bounces-22767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A8AB0DBB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68ECB9E5C7F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 08:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442B27A934;
	Fri,  9 May 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="IO+tcUTp";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="vLrAva1V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9AF27A930
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780238; cv=fail; b=QsyHFm1sc9j3eHoiJrKjLtM87p3eQAQkes0PErtguGz6LjFO+Jtfckuq7QjREOi3W73XKa16K3kLA3zj2mpLSCJODE8LghkCa4GA4/QTrITz9eSaELkFli+DkNcR6ZWJ1VqjsXHtHahjNp+afD4eHD9ri/Y7uUYlR6r5nLpL8Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780238; c=relaxed/simple;
	bh=1GtJZYa7NVs7Rm55GG52ED9Ki6NAB6eJoRc0nYWcpic=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QGiFqIwHfgjSpLtPbS8ioAijFMaECNWl5YF2F4MGNHJQunUSKFftL3gb/KIhZW/B7q7dn2ZGNqhPII4t2VO/a2vx5lAAQLsq6kTpDgMUPU6egVUkryvj7yadqwEFBzrphXFs+LSLCqnPDc9rpibKdzTR9nqZJdhvOSnFb0p+3ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=IO+tcUTp; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=vLrAva1V; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494od5s022605;
	Fri, 9 May 2025 10:43:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=1GtJZYa7NVs7Rm55GG52ED9Ki6NAB6eJoRc0nYWcpic=; b=IO
	+tcUTpdAacRztYP+dxkQarhrVvz3vmrZxHJOeGLNORGcNHswL3ICQOTwKHztmfhi
	IhLCJB2MsONNgnBokknF0RHRF4w/b31ycf89+vqTPkaGEJLanEliPNJp0/ycDOve
	uvTSwweppEhM7NlIYjrRghmzo2O0hesv05dIGB5lTW7ueifdLIf0pgJCl6gTf/7r
	7V2vHsucUZkgD5AmN9/16tetbGvuu63sCknazLAmzIWRxQ2CzQ+YJerQ3CBdFnQ3
	runTaKaMJ5bVax4z7jH2CNIXw0DwaoA2DnFHZq9KZbMePqvvTbv6QCBuM66iBEBd
	7Mt1pVwBKdUdDnJuNvWg==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 46h4xeged4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 10:43:32 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoSCyKRc6gPxvxovzQFaQ438+mEi7qMuBdtL4cIWCYEO6HId5HAMYGs92vdpODmGdfgIbGxbQzswAUHZH7HLZIdMH+Ky+gd8zUemfpInFuQdPbumiISEF2pXGkT8utsipo2w/35MzYkLl2uSo0mbRFRjE99nkzw4xC2P0zWC67L4Eay9F8a9Dfiw6tiLn1SwsLs2FAOwBTalAh6/VQZuRqMS+XIWl/T6lJtu/o/KYNb4u40iYSZ1tppLOArOfTCESxbOBL3FikgtUCWWQaHE6eK9cXrrEv6SIcyKgKchy/cIill4o1XDjBYBKlPAQeO6H0/ZoPaWcoVN/GBQVTIxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GtJZYa7NVs7Rm55GG52ED9Ki6NAB6eJoRc0nYWcpic=;
 b=FPXPAeeE/S8cbSdaFEX+f6nS3hIqtbz4fzz2OkgMbL+NdF/ce0jAe7Vw8lH1pXnTqUQFHuzdByc3qr2bDjYz38i3V4nvqN58kGYvGicbaFNKrIY2+IYm2gHgnO41cu/BfuC0EWp8BY2cPQdV9D6umfRGJe+0uIovdqk8hUDbW22uQV/OY0B6rTaK+BLIJKKjDCXgeNB1dSZCQgyqgT/gm/MTyi83NsNojUQMACXjCU1lPsr7ivNEji6pNKiq/yCQDUq1fi0pJWtBeKD5xzd4xhCeDruWsXEZ+DFr0dVIP3jYmkWxaJcWlk4cd6cuGFMObv9rCVCJj5EDK+lYfpKr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GtJZYa7NVs7Rm55GG52ED9Ki6NAB6eJoRc0nYWcpic=;
 b=vLrAva1VQQ9QDr/sxXuNU1lvP7LtVcRwxZRMiiCidvbvvDDD900vkSFAEOBkfsDKszFt1/yxqFZtXpefKDcVy/vhdPK8wM+NMS4EKZatoOds9wWwv6ak0GX87mV3uWLBJGotT6xj1acV2gNFZLajkEE43a6aIhKDRTw8UQMGCm4=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by AS2P192MB1936.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:553::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 08:43:30 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%3]) with mapi id 15.20.8722.018; Fri, 9 May 2025
 08:43:29 +0000
Date: Fri, 9 May 2025 10:43:23 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Question about TX power
Message-ID: <aB3AK83USvOdTvDv@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: HE1P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::47)
 To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|AS2P192MB1936:EE_
X-MS-Office365-Filtering-Correlation-Id: daa3c242-b1ca-4108-73ae-08dd8ed592aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1GPvh9icWo5wdFsHe3z2FMok+ccBhRokAYzUELxH5GAuwGx8x4aDeVLENGW?=
 =?us-ascii?Q?2lP5Bdnuo/j4bNsXMIFJ1VZuMbRl004QJxaDcdXaYpF9xzS+WKqdiodhgVkW?=
 =?us-ascii?Q?9+C6x7MWh4wCEJLisCpnalGJl0lPxCRe2/oQOyYTqrU42gfOfmN7HQiilj4a?=
 =?us-ascii?Q?DPHxEXGxGLxRTZtPwfNeKqpvzk70nQ836dfP7yl1azH/K9A1i+moTHa58xzp?=
 =?us-ascii?Q?VctGhloJIF9mk3+dmk1lUKsYhXmqrPmeNKcVL0EqkoOKPlNYDT2ZJ3g9tBAc?=
 =?us-ascii?Q?cf+bof5B289/trprhHTfUZxjBg/a/0RxGuJcgxUtx/tCiP7R8ed/iXls7e7j?=
 =?us-ascii?Q?+VoJMg5BWeZrzg2XPNfT31dpWK/gBDef9b7qI2UdQ+j5WMxgeDsI5lBUJWP8?=
 =?us-ascii?Q?QeannHPxDrHrWpbp4+IjPlFeBRkjKJqo4ZZFWeYTFTGbXlCXnteHOZTBB14N?=
 =?us-ascii?Q?fJq7au4CHSqt5cgQOKbHKr02LYFpdKtSdkSlI19ATHJIFrfK7tc85yShgVQn?=
 =?us-ascii?Q?5cW+jLxFTJC1ERC3COrxub6Xp1Whs4zLxT5LXSarhMkXPyD/xHL7H2PCFRN/?=
 =?us-ascii?Q?ST+cBxtkqbG99VpWiDcibCXZ+B//H9Y8Z8au48zcx+J0dDmXkDidk/hf9vkZ?=
 =?us-ascii?Q?DtVuxGP0vK6dGQsx3tVARJln5eJPOD5ID05TID2JkjTa4kkzMxFAokxdXIZ9?=
 =?us-ascii?Q?gi8w/0TxGTA+kaAkMQkJBotZNHN1B9H1bpS2KH6rU/T1Q+gMRQ6aoBW9aB9M?=
 =?us-ascii?Q?gTMNDPSehiKe7NCsop5FE7DDqZ1z9HI5pfM48zlUXP+hSNfbNd32Z7v0YCn3?=
 =?us-ascii?Q?uUfnJJu0Lf4Eiy1vaUQi5SsjdUz5nYC9Ck1dsAct/XvXRDRr6fOhEnKD4BGN?=
 =?us-ascii?Q?LSaHGyqmDSoRremTqjVNGc1npZx/QwAGdkhiaUIqZWBsSF98yW01pptuWfD7?=
 =?us-ascii?Q?V6/R/+pJt/2qYP93/XymD+FLiGBjbqdSbXNGTAkG2Vjdg2tNQMB1fUow5jJk?=
 =?us-ascii?Q?BR3GeLEFZC3MVkkRZYK5xj6vK2D28s8HtJ1MQmElps96AqilFV7ytXE7mstS?=
 =?us-ascii?Q?xKXq20+DpPXJ3pZXJR0K3fxO32Uvo+NHh9ooOlDJpcDkMUvX8K1Ofeo+GwlH?=
 =?us-ascii?Q?ZAHMTpmvtUMKwg1KGVazrYlRlW2oO+iT3AaFY2COCdbE6gqpJpaJJHvkZH7J?=
 =?us-ascii?Q?uaZNpy+9iC3m5cpDVmSIxEiUT02oE8yg116DMaJFOqekLOjwRm10Pzs7bgix?=
 =?us-ascii?Q?R7prY0rCWuH7tnvhMYVx5H5hfFHN1rhAc+a685gjHs2CWtiu3wGW53Xg5sYq?=
 =?us-ascii?Q?2ksYi3XekH+P6LRrzjNUwQp4dfbOJpCY/vFR5D9DHOrbMQcKAweRP9++ivHp?=
 =?us-ascii?Q?M6WoW38IzZYZr8qqktusgl4N7GjlWfJJNGda/rRDfanGr9i4SCvvcN5D2yW0?=
 =?us-ascii?Q?p6qn9XaLkSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9Z5pMEc2dv7gJJFwBAvkcPcFegWs5zp4sNGbnYgR0tIBWOYXEM0eXYysbbA?=
 =?us-ascii?Q?9B8/JdC4G0J3CUir41FeXX9Lmdqs5HJj8UxAw8tHjYkr/JzoGhAlAZP5t16H?=
 =?us-ascii?Q?X9bt8rAqBWCQTRPLulWMLOTnT6PV06oK0xnzgq3TtIMG11cFsS2G2BR88lwC?=
 =?us-ascii?Q?nrnZiSDnTP+fXZHq8azI72Bf4B+M+lOAKsJGOWyNeATKec3KjeGPW/7yjzOU?=
 =?us-ascii?Q?OEoWQPu3aipMDGrizHePjOmZyqGl+enRPgNPepMKfiOYGo6aQK9JlU0KcHhq?=
 =?us-ascii?Q?nH/GagkV1FQRlSnf7YpxQaY2jasG6Od3W4/AL2olUW5nXxPm3lXJwjUNsGAN?=
 =?us-ascii?Q?DE0xUqZv8/IsVl6IXtcmgUl+CwIKk1bJMLfVXO88R9FBE5rAriWwXiwSiaWN?=
 =?us-ascii?Q?uJzpu3hArv6Qe/WOx2Qx+gB5jRDCHwQVbzhenlji3blgOQc7jxtPkUNJdH6a?=
 =?us-ascii?Q?WfOs+6WXxAB941RNiw9l9Q+YgItFjGoaVAlLCzqp+GdWuGDGx/lRz3gLNlmB?=
 =?us-ascii?Q?w3eja7V/3zxfo38uDwP5BKcM7lS9SFrR2Ec6blCfIakIKGlJHD3SYbAd57E3?=
 =?us-ascii?Q?5QpFVUdaz1i+slASMo5urA/tGfy1ybgIrDa1EYsldud2nkMej9y4foqZ38n2?=
 =?us-ascii?Q?WXT+eDd2vlSPMIuecOZlqJ2dJBgL+h6NsNI5Rp+4qVQsFweVc9rKv5saTNRC?=
 =?us-ascii?Q?ACXZoPgSkzO7o0TG8Qtddry6t1OUqzAEzwEaZMyswjo5mpGP6cyOawtqAZPR?=
 =?us-ascii?Q?+WOnWd/SCZubXawDJTZj61T0vXpfYpU5DeGFzGKzrhkcsdC03KPbUesNEVIH?=
 =?us-ascii?Q?T59n7rW1hiheduXs5hXgmLOlp95LlUuke3DSvl6TC8Utf5KY30kHpn6mjBFx?=
 =?us-ascii?Q?XeQJxLxnGR2wFGGd+/v9Thred+OSVLS1XHM+t7O/v5xLPV/pc/Pb/G8FRCxK?=
 =?us-ascii?Q?46NuDUGgPyBlahIusAuJYAxxR/LpXphEdb1MAaG8hipsnRWky2VLlcQ2VxHh?=
 =?us-ascii?Q?FcyImlwsAVnJMnFLK9tU+V0MSGSU7eYYsbHXzz/vHw4kAqPRWkt7kFvQm1kN?=
 =?us-ascii?Q?kZLNctZsCfEGo8DhkrwJUWjylVQNsReYnYgP7Ne3TMlCtXEkLbpBcJFztDae?=
 =?us-ascii?Q?b7tsCt/ExtrJfwIl6H2S+FvwJhPCBEhDs6k7X5cuJL4K4ipDin9qUMz9T/ue?=
 =?us-ascii?Q?/tdvaYCmD4j/BdA9Vj8xnscNMcq5zgUNkE2Fa2KwyodqpDVhOctyT7fk/mZc?=
 =?us-ascii?Q?bcL81+o40e+4d7azUeiMQOXxuY8nvOeRLMquI4GOdrdpn9WCj3Mhnci3ai97?=
 =?us-ascii?Q?S4jlZqd6HVcmUnv06O4ty8rIrEqVTUXL7Q5c84l1xuDIB0liu3p6yvHS/5EU?=
 =?us-ascii?Q?F9egdsLgIq+Z622L+4WhaQ+EWLOo2sQ4sCZs58qbmOkDOd3Ll2ZEwb+1aySD?=
 =?us-ascii?Q?Um3dXv5RWFFiwTW+Rp1o8zoUmZP1lDKGYZ0CxQ/Y228k6u57giYz6oL0el6o?=
 =?us-ascii?Q?wXXPtGLt5FFj1GFTCgRi2cDmGVrEggDwVO0aXiYaCyVbas4v+SzkURKDiv3t?=
 =?us-ascii?Q?UWeg1QdqpkxmRhqiYhoKmGiVani6vNojq8w9ClJr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0oTQ0ZfLSEA8rBMAhiQ5m9NOVnPSMuUW5vmIQ7aBXpLqEPvdqabMY0iPr1dj4G3NDnvYNMMoMxjCEsu1Bp/mPwAXIPj8oExahvdvM0n1W2kc4fPs285PadgLNBiF7C8cWZziW4ShpOc57CYwtGrIdi5vcJNFkpz2b/kIFMb3mL+14S8BHulZ7XL5TdcxeqnSdZLsRwGaV4kvUsErzQm8K2jFeE4O+PdDEkB0kzOOcpwgA8VmWj8cKe1XT/0dtbT3amcWHVUq8x+zbwPSuUlqa6pzvW5odoSiKfxUgco2al9EmNScIB3sY+Of6DGcwR11ZgBY674XTXp+UPQgAohBLEPw5sesGOT3R4DUKX42/HzOojBY7l0WBU8esLqlpfFE4XUQXhnZoiXSpcnMXQdkhrWXZQ4FBiCAeIV+Kor9rAQX1yz4mOkSZu3cD6YotLgbrvngo/eCvUX9LQWrYVQrnmpvhDISa9QD01wsuoBGzChgKmoJt08qOcbePITDWBfs27AvwNuItDLGz3wJD3rGVZjWt7szEsbhTw4+v2tz7UE37KWexjC9MQkTtFIyD+K3AK+dTud1c2HE5FDuMwvOKj03KjIwfIWlrTgS1dAsulW/5K/9zUd0ZF0j17MTAdvf
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa3c242-b1ca-4108-73ae-08dd8ed592aa
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:43:29.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMKLUqPhjbBLWg9hpB/+f3betI77+Q52UNiLz9ZRkpSl3BOSF8DjFPVUA7xl6zPWu1dxEB9iTmSAsU1rC2IK1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB1936
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: AS2P192MB1936.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA4NCBTYWx0ZWRfX7XQt86Nnrd/A Jc9MgPnrFzF2x6+jqcHqIEexEBV6q2OrMKrNUk/r42ARBAtracETbVuQaeuR79SkTMzlsiP8PFU Jc4g3NRwrLM6denXwomo/bM/jAJf2MA//cbgPqw3uzkkeD+s+Xr+OGdpfraRWnoP3fSPeVAWCnm
 D1JhfOSHOB/BHD4TzyEMl4JmuuwjcjtFQpjH2KLz9Ee3tmRKdYov4Tb3oX2qS4ltPQuPH0Ic1Jo BH1wRCp9I9xped4hq2JZ3VG9wL9xuPdm4kMrElf1jyowT27HMds1949vSoqwjQqqb/3uApVhBr2 Fnr3gUtC+JnhOWi8CFh7P2wtfkXQW2j9xkHKQMjX2fCyUANdguA/sLtS9ELV8UI8m10D5Wwcb2E
 Xnc5NIcFJ50tJf5OlOsc50+bjqCGLwlABHKNkswtFaWrt97u8qv71mfKD0MfdnJuAq404gQK
X-Proofpoint-GUID: QcDryioIcbm6dp3cnanugzB3G4kCTlAO
X-Authority-Analysis: v=2.4 cv=dqfbC0g4 c=1 sm=1 tr=0 ts=681dc035 cx=c_pps a=D21qXYjmxBfra4Dx/gklFw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=8gLI3H-aZtYA:10 a=HiUPb64sakz0t4vP_FkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QcDryioIcbm6dp3cnanugzB3G4kCTlAO

Hello devs,

I'd like to understand how TX power setting works on ath11k devices. For example
when I'm using channel 36 for ETSI based regulatory domain, I can set up to 23
dBm. But then I get only 20 dBm as a result. On different channels and/or
regulatory domains I get different reductions. I tried to follow the source
code. As far as I understood is that 'ath11k_mac_txpower_recalc' sets the
correct values and 'ath11k_mac_op_get_txpower' return the different one.

My question is where this reduction offset is encoded. Is it in the module's
firmware or is it part of the boardfile? Thank you in advance.


Best regards
Alexander Wilhelm

