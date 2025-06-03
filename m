Return-Path: <linux-wireless+bounces-23580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188CACCEB5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 23:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A071621A2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99802248A6;
	Tue,  3 Jun 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="bC/Z1xyu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013080.outbound.protection.outlook.com [52.103.51.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3254918
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985192; cv=fail; b=j5CFcpCdETiBY1p60DHLbiZj5deKE1/uwzK/jISMA+i9ZdJzHWBh33evHN0i6pCV6/TK9rl5Y+yXCxJCMhd7iY4QJjD+2gXWtqhHpHKM5fMCJFd8f5lXTE9dyuRCEYCAog1fidsCortllptCmFZQocKs059eT2NI2+nbI4U6Koo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985192; c=relaxed/simple;
	bh=vQsaI0wMyO5UVX+HEqa4z43DaIur8oJ82x9i1Ovb4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eH4taYT2GDaTUfUWqTeNI/ce8T+jHH3X3F5KgPwXZ9jHNxSFoSLXTlCU4MV6Q7W5yN7zrHU3EMaqfMmlZQ7WTit8AVb51kwNZlSSlkz5UDZLEUGdYhLkTs3ufb2A50Tta1ILz3Q4MVFTrHbGi1MKS+SLwIOWDngg/PAPj6jwN1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=bC/Z1xyu; arc=fail smtp.client-ip=52.103.51.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/mH+TsnmudTkoLlaPIdnmbUZFY+Ag1vkv1olgDM1IYh/iIUwORz4CeL5xlG64ivat9iCMBqIZJE2TnxHzVfRU7wzJVW6kvECWoNTns13/B1vhCPxG1V0/QvntCxszqlf1sPSC+0lja6ykUnYp9/xsyqQ3ZixBwatNt35ok57abiFr1hTIgh83X5kM4HkepwMFtkqwNdb1qPpS0QTVDUxZrsFV28SCco/aCQEoCpl5IaG0fLJPu1Yeb8roHE4OiYMFecGIyZQ+Yx+yrCYlvA4OSGh1b0EbGd7LMukQxIB2VzQ23Cg0YHlIa5mmiKXcFtrQvkVpkiIclJpNkq+C4wwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyCzYTtWCbrcu5neR6jcSOv7hybsCf1wrhWeu9256XU=;
 b=tAI9inmFH6NMx+Cm2J/VyYYTUQn6Ja9QqciWZJ1O9tP7TnLD2BH+rc4XcH3NlYwR4unvR52pq0WsmdShZCsBoD8Kt2Ss6w2MaCm77F0kDkO1BNKYWKhsqHnv1mnsubBcOpkfK5DVUGzwnWBtG1apEynMuXDSnFN9pVQYMU3AVC1kai9crdXzyFn8djGX1DYF8U+pqt+e4O4TNItuqDZwDr6IINEoD+GE5T/h5ih/G0b1KVQ3Fk4ogPGMJvh6QepiTdKwaBNf/PfV8vbU0LyfLJP5cfrXbMCndRTIuTueBOm6p+NLzrK0GNwkiYTEJqUf5h+zDobYW74d7LdQ1Vl3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyCzYTtWCbrcu5neR6jcSOv7hybsCf1wrhWeu9256XU=;
 b=bC/Z1xyuo4sSPR/gjft3ycrOp9NMI5f9m90mB1IgekyIvKmyGeNBMF36BZ5kxHikP/vUml0bMC2C64iMeBT3ggnqiZCetVZiQqaJV7s+WY/aPQCnrUb0OdnosJ339XeQoJlNOGbJ8folm7CjiPqVOhuzaS73UK/pAYoMC+Y21VfVD/9yu+oCOrSsMhhFq15HnC/18S4OJ09rs1f9LevMpedxHUjyuPae6KwVuUizivguvYAOJlb3qSZgRTC4V1sbqN83Bg+mspSr5zoR39UMXu1pK5sUfejQ+b1EAyvLmFVbs8GbdwC4KjjqDdD/pAd4Ml1xB6+5/kbq9DoYF6V5vg==
Received: from AM0PR02MB3793.eurprd02.prod.outlook.com (2603:10a6:208:41::14)
 by PRAPR02MB7978.eurprd02.prod.outlook.com (2603:10a6:102:295::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.16; Tue, 3 Jun
 2025 21:13:07 +0000
Received: from AM0PR02MB3793.eurprd02.prod.outlook.com
 ([fe80::e01e:5e25:e074:79a0]) by AM0PR02MB3793.eurprd02.prod.outlook.com
 ([fe80::e01e:5e25:e074:79a0%7]) with mapi id 15.20.8813.018; Tue, 3 Jun 2025
 21:13:07 +0000
Date: Tue, 3 Jun 2025 22:13:00 +0100
From: Cameron Williams <cang1@live.co.uk>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, regressions@lists.linux.dev
Subject: [git bisect] rsi_usb oops
Message-ID:
 <AM0PR02MB37936431F3602A64BAF8550DC46DA@AM0PR02MB3793.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To AM0PR02MB3793.eurprd02.prod.outlook.com
 (2603:10a6:208:41::14)
X-Microsoft-Original-Message-ID: <aD9lXLCuCGjhvyfF@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB3793:EE_|PRAPR02MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca20b51-bd9f-41d7-066b-08dda2e36cb8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7072599006|5072599009|461199028|6090799003|41001999006|19110799006|15080799009|7092599006|8060799009|56899033|440099028|3412199025|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q9+K0MST64ISCL7/gEn5J7uio+jNL9IexQGFrGo59UjdP6FAFBBMIejyb1Gs?=
 =?us-ascii?Q?8Kxhz8RyLgArU5c3K5t9zutxeUT5RFpqWibEb0XcdJ5yfb6vvzUQ1h1p7VOL?=
 =?us-ascii?Q?IdHgVLcDTBclEzWha/tK69aEviO+357OdH6eRaQN1iB2RXrwfNbuaqpQogCO?=
 =?us-ascii?Q?5bZW20o4unKOLXzmuyx7FO/m5HyHkug+nXprcpZgBM8SPW/93NvKJKprFkVe?=
 =?us-ascii?Q?2s83kbafE/IYRNkVpKG4rrC5BL1gJFfo0MaATPDDhaVuedUFZ3OZb+nmaYap?=
 =?us-ascii?Q?hBLDgb3CMGe3RZQhZf2WyvjiyJNjzxxRVR7FiupDw/MGWrIltbldKv9HE7ZN?=
 =?us-ascii?Q?/6bbNNxcYI0gls3fTurXAYPJiEhBzgWQ6iI9Kw14aotLPJi454N8QemBFapA?=
 =?us-ascii?Q?s/hi1sOinPx2lOrcIEwdjCk6ilt4+BERHngOmTU0XHUMW2+VZqWKmfj5DdyH?=
 =?us-ascii?Q?EC1x4skZu3wnebqVlppnyYYn+RBB8Tv/Eb3PzdAf+zgN8gOF9WiKqudcEhbF?=
 =?us-ascii?Q?k1sYb6+uJmGwovZf3VYHoYGPm9b1ayqy0GoYHcgW6yCIUA7gvamsSV5S1/nH?=
 =?us-ascii?Q?5j5eitk/nU2M6MvxmxhXnD5RWbEBPPT0jXt+v8OFkbWJIDwrRdmfQtnQ59E/?=
 =?us-ascii?Q?ZcJ7Hc5+L6RiGlRcOz9f5e4V652rQCSPRKpLTAaWLfznfsl89AuKh5iywiic?=
 =?us-ascii?Q?XE2Zj/KJN/ZDslE6O0YxByMZ1q9F3f/htAM2sHUC/ANNxGMK1SjKqJ1LdL8V?=
 =?us-ascii?Q?jGaEg8LL5bTi6HwReuE0II0G+BOMuS82P/NIjQ/PtouMoSj1+NXg1irpvTFj?=
 =?us-ascii?Q?+oBOyB5uaL8YrGf4uiWp2L3p8id/LlNqT64PrFFUl7K10jtu0TJ3TflG4KVS?=
 =?us-ascii?Q?7MHt6RB4y+8U6QXoRVPmHWgQ24pjPmhKDPUM3NYvA2prZX5ym7a1AhYzbKOr?=
 =?us-ascii?Q?hBJ0CL4XvF2Vgw6B4QfoljGY6D5+Y80eTxY8p3Nx1Qk7DgtkNjCHKgq6XIlS?=
 =?us-ascii?Q?RE9nN5iQRZiGE2co3APxY2hqlsxOrUYxVA7zogWxxQf2917+thagcHYUB81S?=
 =?us-ascii?Q?2h4otQkwdolkqYNfRC37HrzK2EEN86fBNu6OyC+vSMWBABGl+kWp6Q5ZsoXK?=
 =?us-ascii?Q?EvRo/mBIjb8xwqLu4z7O7A0fuY/6mHM+xA4J08nQIWP1gvW+kT/8YcETRb5G?=
 =?us-ascii?Q?SIpBCtGDG/4UXrHX7jNb1ELSBhrRy7PGYOyd9MlNIB98Tgs2+pkckdvwWH4?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lI3ssuNtI1lWEyiyxYIw0cS6RNVLfr3UY4tER2pziuBTSKu7ywROfAHAS+CC?=
 =?us-ascii?Q?BRBxFssS0uWJiPFfX6wD4+nOQdB0Lqnvn0ZAF17MmbfEoUXvpYG0YlNGkjBr?=
 =?us-ascii?Q?BOZRIEz+g6xbJxzQDi7HXwJkrSaxAJ8L/2KCY32adRfZjqysMvSSDv+Jitts?=
 =?us-ascii?Q?vKvw96QCvVzt3+Med/bBeKwWfqridb9fcZ426dHcMipympsyzWJfc6RlqXSB?=
 =?us-ascii?Q?jYBd8IYpA2IJxRTHsbFAMyMiwyQlHoG3KsSwuEdmkXpaH1qJATf4HLc9Mf8c?=
 =?us-ascii?Q?9CQ2Oy36cYxDpThZwkfGKGG42D4RVENNnh3K7b7scmRIZbgIpIgwmp+28ivf?=
 =?us-ascii?Q?ShaTJbK8EWR6dlLTZBJilai4o4hCN13XAmunD95pDAPkGCZBJz2/Me6OeRtc?=
 =?us-ascii?Q?DkSZJrP+1z/twgx0YtuvUcLALK/l7mE/g7D3jmT1oqxme/yH7hmN6BdJrsxs?=
 =?us-ascii?Q?268B0FpV/G2lyr6R92MdUPKyTOGgiaGML0oKxkouW8SLSlTZsAMEYCoArBXs?=
 =?us-ascii?Q?frTvtvCdL9clOZ4xy5bs5LoOWah11p/zkimnS3l7/CiynQ7fTcodvzWXzylr?=
 =?us-ascii?Q?yqKfLVkBISGFgBRXghMx4AgBJvtmQAWWlEFlgfXB0Npc/TsF3/LO25Jkq3Ig?=
 =?us-ascii?Q?mxs3wFL9Jf4Jt07rX8mYs0z4daO//wANX+nXOGijCaSfSb3hWww8ZyOtFIE3?=
 =?us-ascii?Q?imlbpAomEBnm4e7eHyZkkfpOcT5IvNvFXQXVnZEb0b9M2/hAGuCW+MsRLuZ+?=
 =?us-ascii?Q?xxYrMsCtyx3hdAM4N0csddjw2SHSH7/NCbRQy4sGktKQduihe9W6cRFbL8Af?=
 =?us-ascii?Q?kzw4YPHwYJyGLqhh+x298+VPluAJSHRGe+STqv6m6gp0uWVYIbvScH/R5U2T?=
 =?us-ascii?Q?OcNgbo2szjQu2vrFNsiJda+YmxpVMZImDesWfkWYRrz1A7CDFBzdqaF6goRR?=
 =?us-ascii?Q?rmuQevLdzmLXGrvo60A/YGddb86f5hVGe0ec6/NQoR2JTqtSrHppGTC3rFQS?=
 =?us-ascii?Q?qtIGtfSq20+nxIjFuxxDsE4TXsh+YCIKOcz1eor2I8vWGnsWXwJN08dvwjGd?=
 =?us-ascii?Q?8l4517zYBXyhRHD9z6pm9ju56nYdW2B40vY6CnV+CBn2tI08ymX6HawAdbLS?=
 =?us-ascii?Q?nq4yhqtbauB/8fEUqlhh/fV3ikwSDDLaK4r9D1ATinRxzd01D77Glt7PLyWi?=
 =?us-ascii?Q?J1kqvY4s+Lr2dWphZ0dFLWMxq65vYv/xmHWaAW0ZKsfIcA1a8vJArvXiw7k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca20b51-bd9f-41d7-066b-08dda2e36cb8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB3793.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 21:13:06.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7978

Hi all.

Commit 378677eb8f44621ecc9ce659f7af61e5baa94d81 ("wifi:
mac80211: Purge vif txq in ieee80211_do_stop()") seems to
have made rsi_usb/rsi_91x cause a kernel panic when
removing the USB while the interface is up.

With the dmesg below and kdump, the issue is somewhere when
ieee80211_txq_purge calls fq_tin_reset, which is going over
my head. I've tried to follow the code path as well as I can
but I am lost in this code.

=3D=3D USB connected =3D=3D
[   67.332615] [     T11] usb 1-2: New USB device found, idVendor=3D1618, i=
dProduct=3D9113, bcdDevice=3D 0.02
[   67.332895] [     T11] usb 1-2: New USB device strings: Mfr=3D1, Product=
=3D2, SerialNumber=3D6
[   67.333156] [     T11] usb 1-2: Product: Wireless USB Network Module
[   67.333417] [     T11] usb 1-2: Manufacturer: Redpine Signals, Inc.
[   67.333673] [     T11] usb 1-2: SerialNumber: 000000000001
[   67.338763] [     T11] rsi_91x: rsi_probe: Initialized os intf ops
[   67.345650] [     T11] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.345920] [     T11] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D RSI Version Info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.346181] [     T11] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.346444] [     T11] rsi_91x: FW Version	: 1.6.2
[   67.346707] [     T11] rsi_91x: Operating mode	: 1 [Wi-Fi alone]
[   67.346708] [     T11] rsi_91x: Firmware file	: rsi/rs9113_wlan_qspi.rps
[   67.346974] [     T11] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.434534] [     T11] rsi_91x: ***** Firmware Loading successful *****
[   67.452334] [    T788] rsi_91x: Max Stations Allowed =3D 32
[   67.490729] [    T734] RSI-USB WLAN 1-2:1.0 wlp0s20u2: renamed from wlan=
0
=3D=3D Interface brought up with `ip` =3D=3D
[   78.459327] [    T827] rsi_91x: =3D=3D=3D> Interface UP <=3D=3D=3D
[   78.459625] [    T827] rsi_91x: rsi_disable_ps: Cannot accept disable PS=
 in PS_NONE state
=3D=3D USB disconnected =3D=3D
[   81.093884] [     T11] usb 1-2: USB disconnect, device number 4
[   81.145395] [     T11] BUG: unable to handle page fault for address: 000=
000009dff2338
[   81.145637] [     T11] #PF: supervisor read access in kernel mode
[   81.145868] [     T11] #PF: error_code(0x0000) - not-present page
[   81.146096] [     T11] PGD 0 P4D 0=20
[   81.146323] [     T11] Oops: Oops: 0000 [#1] SMP NOPTI
[   81.146548] [     T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Kdump: lo=
aded Not tainted 6.15.0 #1 PREEMPT(voluntary)  c74d5f1746d8801a78fe4695a51c=
a9b00b89ab7e
[   81.146790] [     T11] Hardware name: Dell Inc. Latitude E7250/0TPHC4, B=
IOS A19 01/23/2018
[   81.147026] [     T11] Workqueue: usb_hub_wq hub_event
[   81.147267] [     T11] RIP: 0010:fq_flow_reset.constprop.0+0x12/0x140 [m=
ac80211]
[   81.147608] [     T11] Code: 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 8=
9 f5 53 <48> 8b 5e 18 4c 8b 3e 48 85 db 74 6a 4c 8d 6e 18 49 89 fc 49 39 dd
[   81.148175] [     T11] RSP: 0018:ffffcb54c009b918 EFLAGS: 00010202
[   81.148466] [     T11] RAX: ffff89629dff2328 RBX: ffff89629dff2328 RCX: =
ffff89628cb49210
[   81.148757] [     T11] RDX: 000000009dff2328 RSI: 000000009dff2320 RDI: =
ffff89628cb489c0
[   81.149048] [     T11] RBP: 000000009dff2320 R08: 0000000000000000 R09: =
0000000000000000
[   81.149340] [     T11] R10: ffff89628cb49210 R11: 0000000000000246 R12: =
ffff89629dff2338
[   81.149630] [     T11] R13: ffff89628cb48900 R14: ffffcb54c009bad0 R15: =
ffffcb54c009b9b0
[   81.149918] [     T11] FS:  0000000000000000(0000) GS:ffff8963fbe8e000(0=
000) knlGS:0000000000000000
[   81.150211] [     T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.150502] [     T11] CR2: 000000009dff2338 CR3: 0000000098224003 CR4: =
00000000003706f0
[   81.150797] [     T11] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[   81.151093] [     T11] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[   81.151390] [     T11] Call Trace:
[   81.151688] [     T11]  <TASK>
[   81.151984] [     T11]  ieee80211_txq_purge+0x3f/0x130 [mac80211 43c4902=
366977cd272d3ef7b3fb48467d12f0d58]
[   81.152357] [     T11]  ieee80211_do_stop+0x5ad/0x970 [mac80211 43c49023=
66977cd272d3ef7b3fb48467d12f0d58]
[   81.152727] [     T11]  ? synchronize_rcu_expedited+0x1df/0x220
[   81.153042] [     T11]  ieee80211_stop+0x58/0x1b0 [mac80211 43c490236697=
7cd272d3ef7b3fb48467d12f0d58]
[   81.153418] [     T11]  __dev_close_many+0xd5/0x1c0
[   81.153736] [     T11]  dev_close_many+0xec/0x1d0
[   81.154052] [     T11]  netif_close+0x68/0xa0
[   81.154369] [     T11]  dev_close+0x34/0x60
[   81.154685] [     T11]  cfg80211_shutdown_all_interfaces+0x46/0xf0 [cfg8=
0211 1825d75722fcd8fde2c6ea3f10f47ac1aa42aa46]
[   81.155073] [     T11]  ieee80211_remove_interfaces+0x4c/0x220 [mac80211=
 43c4902366977cd272d3ef7b3fb48467d12f0d58]
[   81.155505] [     T11]  ieee80211_unregister_hw+0x4a/0x130 [mac80211 43c=
4902366977cd272d3ef7b3fb48467d12f0d58]
[   81.155923] [     T11]  rsi_mac80211_detach+0x29/0x80 [rsi_91x 7941f49e8=
f9c981e468dee219553f955496db722]
[   81.156294] [     T11]  rsi_disconnect+0x22/0x220 [rsi_usb 2859e71050df9=
b30e3728380acc6137b8ab08c1f]
[   81.156666] [     T11]  usb_unbind_interface+0x90/0x280
[   81.157043] [     T11]  device_release_driver_internal+0x19e/0x200
[   81.157412] [     T11]  bus_remove_device+0xc2/0x130
[   81.157782] [     T11]  device_del+0x160/0x3d0
[   81.158148] [     T11]  ? kobject_put+0xa2/0x200
[   81.158487] [     T11]  usb_disable_device+0xf4/0x220
[   81.158822] [     T11]  usb_disconnect+0xe3/0x310
[   81.159153] [     T11]  hub_event+0x802/0x1940
[   81.159484] [     T11]  process_one_work+0x190/0x350
[   81.159815] [     T11]  worker_thread+0x2d7/0x410
[   81.160137] [     T11]  ? __pfx_worker_thread+0x10/0x10
[   81.160459] [     T11]  kthread+0xf9/0x240
[   81.160778] [     T11]  ? __pfx_kthread+0x10/0x10
[   81.161093] [     T11]  ret_from_fork+0x31/0x50
[   81.161410] [     T11]  ? __pfx_kthread+0x10/0x10
[   81.161724] [     T11]  ret_from_fork_asm+0x1a/0x30
[   81.162031] [     T11]  </TASK>
[   81.162325] [     T11] Modules linked in: rsi_usb rsi_91x iwlmvm uvcvide=
o x86_pkg_temp_thermal intel_powerclamp videobuf2_vmalloc cdc_mbim videobuf=
2_memops coretemp uvc videobuf2_v4l2 cdc_wdm kvm_intel mac80211 videodev cd=
c_ncm cdc_ether usbnet videobuf2_common kvm qcserial mii usb_wwan mc irqbyp=
ass polyval_clmulni dell_pc spi_nor polyval_generic joydev libarc4 ghash_cl=
mulni_intel platform_profile snd_hda_codec_realtek ext4 snd_ctl_led snd_hda=
_codec_generic mousedev mtd sha512_ssse3 snd_hda_scodec_component iwlwifi s=
ha1_ssse3 snd_hda_codec_hdmi aesni_intel snd_hda_intel iTCO_wdt dell_laptop=
 processor_thermal_device_pci_legacy crypto_simd mei_pxp mei_wdt at24 intel=
_rapl_msr snd_intel_dspcfg spi_intel_platform crc16 intel_pmc_bxt mei_hdcp =
intel_soc_dts_iosf cryptd mbcache ppdev jbd2 snd_hda_codec rapl iTCO_vendor=
_support spi_intel processor_thermal_device snd_hwdep dell_wmi dell_smm_hwm=
on processor_thermal_wt_hint intel_cstate dell_smbios processor_thermal_rfi=
m snd_hda_core cfg80211 processor_thermal_rapl dcdbas snd_pcm mei_me
[   81.162379] [     T11]  e1000e intel_rapl_common psmouse snd_timer intel=
_uncore sparse_keymap i2c_i801 processor_thermal_wt_req pcspkr dell_wmi_des=
criptor wmi_bmof mei ptp snd i2c_smbus processor_thermal_power_floor lpc_ic=
h soundcore pps_core processor_thermal_mbox parport_pc parport int3403_ther=
mal dell_rbtn int3400_thermal int3402_thermal acpi_pad rfkill int340x_therm=
al_zone acpi_thermal_rel i2c_dev sg dm_mod crypto_user loop nfnetlink bpf_p=
reload ip_tables x_tables crc32c_generic i915 btrfs sdhci_pci i2c_algo_bit =
drm_buddy ttm sdhci_uhs2 sdhci blake2b_generic cqhci xor intel_gtt raid6_pq=
 serio_raw drm_display_helper mmc_core atkbd libps2 vivaldi_fmap sha256_sss=
e3 cec video i8042 serio wmi
[   81.166351] [     T11] CR2: 000000009dff2338

I am unsure where to go from here. The driver itself is orphaned
and the chip is not very common. If anyone with knowledge of
the mac80211 codebase has any input, it is welcomed.
But as of now, this USB driver is unusable.

I have kernel dumps, vmcore dumps, whatever you may need,
any help is appreciated!

