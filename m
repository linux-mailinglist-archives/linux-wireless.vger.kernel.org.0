Return-Path: <linux-wireless+bounces-27783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C62BB41AC
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C54321E9A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2183C23D7DF;
	Thu,  2 Oct 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=GoodmillSystems.onmicrosoft.com header.i=@GoodmillSystems.onmicrosoft.com header.b="iBPWJ7CI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021103.outbound.protection.outlook.com [40.107.130.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC930FF27
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413380; cv=fail; b=AgUFupVixKj+tojY/cY90DaP+vlWZK7qUtabYVxeslfrxJgGoWINnPEKsRhbdMJIib9BNJvb7GdoCLF0CCQdEXeFezLWr5BKYBZLdzCW9G8rZgFshbENMo4CYyOAyU76pLialc22vFKPrezQJnSGYuwq1Fv91hDo/l2FSYlXeRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413380; c=relaxed/simple;
	bh=aBpJSPaovAMICfbXwWopEATtcMpO+EoQ8PNuxXBnd0A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XihopOkDRT1/VDIgNuEBcE88ohLZgD6nd0jeAHpMA/+2Vc8G5nY59MDVobfRoodfyzvh52c5Pz8iHEylaYttbyHQzSHleODmZ0D53UqjAv+wjxvxBrJneOsI7MlkySp6K+qujG9OlAVJVoW+zxrNd7TOlGO5PUB27p/ufsOT7ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmillsystems.com; spf=pass smtp.mailfrom=goodmillsystems.com; dkim=pass (1024-bit key) header.d=GoodmillSystems.onmicrosoft.com header.i=@GoodmillSystems.onmicrosoft.com header.b=iBPWJ7CI; arc=fail smtp.client-ip=40.107.130.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmillsystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmillsystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx1MAsdm8DtvndTVRQiifesmrz9QqDbioxLVQrBvKGWtG3iqlGJ9raRK1/HYPosO2xS+tebpXQX0PPWBN0uY26D9Mhuvf506G1U192VCMFLcopdufikBuBRHO1ow3F6CfUly18Mjzpkv9UaAbelC2q2kADJBSJOS5wieLdHpE+0xijVlqskMDwkHOeOFgS9Yva2rXc8sbizd0ayGERj5OKwIlDYcm90fmdzsZPZe36Gto88twaGqUQOmwCWQ6zlXg5i+GA9VgMAQ9Civ7prfrAea6sabxxzKtobDfWG1Xb9weuswxgMhrF+LKjvlOi8tHp0VIvMUqMffFdRZ1mlCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBpJSPaovAMICfbXwWopEATtcMpO+EoQ8PNuxXBnd0A=;
 b=SMkwGhMQyK50kF9XRtxGhkmk9Cldrcw6vklENFnHe9ppxdu5I8wg9+RfnFkkMYy3JcCjD1aPanNIGPebsL0m8vbWuOfzrVdPlzHQhD6Dw6dAhbzhHfw+0kXMmTA6Hk3vOoUAX5EpM10/HQGpiZuKwkI1M4I85VDBSEV/KABrFzkpNagFMggT6gE8fGs1VW3jsFzD7ESkg9jnPgL2zwp4+tVYzu+QACpjUIUfKHd5+Z3IBlg5IILoYxbBwv8gaIS7nb2FPtMcu+sDz2bQNf4TflW9pkc/YqqTgEORGHnKKthOOuVwr/LHc9AUIP7WiyTpa0SOUm/nPyBKBATUp1R6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goodmillsystems.com; dmarc=pass action=none
 header.from=goodmillsystems.com; dkim=pass header.d=goodmillsystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=GoodmillSystems.onmicrosoft.com;
 s=selector2-GoodmillSystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBpJSPaovAMICfbXwWopEATtcMpO+EoQ8PNuxXBnd0A=;
 b=iBPWJ7CIjnbLbWVZCkYvU8Xrjx3ryu8H36yeGaemfJimYc9h6OYwDRW22fJSgt+Vsw08IgDx8WzqhXGzsv8l2uuAug503OQFbcb1fXXxqmlxsUSRojAr3UQ4xbDAZaKXCU9lVObiKY9EIg0i8wD3Ld5GBg6iFQ4rGtxpMpD8hE0=
Received: from PAVPR07MB9311.eurprd07.prod.outlook.com (2603:10a6:102:312::22)
 by AS8PR07MB7960.eurprd07.prod.outlook.com (2603:10a6:20b:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:56:13 +0000
Received: from PAVPR07MB9311.eurprd07.prod.outlook.com
 ([fe80::8d2e:f7f8:9db6:b2ad]) by PAVPR07MB9311.eurprd07.prod.outlook.com
 ([fe80::8d2e:f7f8:9db6:b2ad%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 13:56:12 +0000
From: Juha-Matti Tilli <juha-matti.tilli@goodmillsystems.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Mihai Moldovan <ionic@ionic.de>, Denis Kenzior <denkenz@gmail.com>
Subject: Dual ath11k and ath12k, mergeable code on top of 6.6 kernel
Thread-Topic: Dual ath11k and ath12k, mergeable code on top of 6.6 kernel
Thread-Index: AQHcM6Ij9T8qLBhN4kyZyVJqmpFjoA==
Date: Thu, 2 Oct 2025 13:56:12 +0000
Message-ID:
 <PAVPR07MB931189F077F0372A93902637C0E7A@PAVPR07MB9311.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goodmillsystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR07MB9311:EE_|AS8PR07MB7960:EE_
x-ms-office365-filtering-correlation-id: e51cc117-403d-4b1c-eade-08de01bb72ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Nk2whVH63S4CjAbQug255HX6RRZmfoYpAdgljO+dLL2fMl0LAABiyMIa2L?=
 =?iso-8859-1?Q?gF54dfqHRMk3bcZtDobubwTvP8PK0a5e2w07Ry5v7vPOcibFDuFPT1/EQs?=
 =?iso-8859-1?Q?id/LDgOKFtTXzFigUQqV4NlTVDApxPcH6laF3aFxZy7qr7qU7j7MXWt1zB?=
 =?iso-8859-1?Q?GvnK03geHD75yHy+K7cEAAG7Z91ZifGEr+xTSm1MC3PXwCVejqJZO/KioI?=
 =?iso-8859-1?Q?2fbtrpGOtX8OCQs5d+D9IVYbKVjuIXUhE+RUSfdszPeGxNYMOXZ9+acF91?=
 =?iso-8859-1?Q?iR7GgePQIq3YCAKVkNoa31D6ypXFa7wmsKlX+YbMBKiYgWX26HYNM9vVAz?=
 =?iso-8859-1?Q?hDQW2dayZkMo4PB5QFKRZYwKdbHa+tCk4P5jqwVv6dsiz+3WEy6rYU0u+P?=
 =?iso-8859-1?Q?CRkUWtS27O9B0W+h7dZW1z8zCgauY2nx6CdWX5hZx6ksi56evknCLLUGJ+?=
 =?iso-8859-1?Q?+rrhs8Xz+kygoP2BdoOSF8XGbaqK53SNPSCNaUVHy/x8fM9Fk9hYJ6qROT?=
 =?iso-8859-1?Q?R4gemgr35nSf1vAt8MjJG++8fR4KNM31IMmbSlt4PFUwPFIx+PnTZyKPqC?=
 =?iso-8859-1?Q?0uwdp+SSO6GOMzQopH1kvpJoXi6DlrTue5j/ybU4hqegrGGGmNZl4TuRBI?=
 =?iso-8859-1?Q?eJu5Nmy2eAXNa6jY0el0YRna++jIUZ4ZvDXoB2UbLA1FEklG3yHEI60NON?=
 =?iso-8859-1?Q?LGmQVu5P7KUucJI6wWdzN0UbS4Q9lTu5ZP4IJrt+niWJpubyFGjyIR7lue?=
 =?iso-8859-1?Q?E6gCv5kO+BjcCYOefbkfCLfVbSHasmrU9c9K35vIkl9YrJn2rjQxQ9kzTq?=
 =?iso-8859-1?Q?UAOTwM8XksyA0Ngg9idY1Jrz0JbG8rcjVj2tkMK03kOb68SA6AakIMfymh?=
 =?iso-8859-1?Q?Y8yegcFLS8eLOeQ+KOCHqCEHjAQxbCIUSVndXjmVyU62A9cts+ADG9SgTv?=
 =?iso-8859-1?Q?LMFdz8PpquvWGMcxnAQM8cg9K3+yhPExCmUd67MeGKxgfrrsS/XHhKgq+O?=
 =?iso-8859-1?Q?x6zZh/uNWBsc/Up5sh48br3HqzXUnMbxNzlyKjAKylLlSGpFcUH5+Wdtem?=
 =?iso-8859-1?Q?ymLI3bYdttOCd0Lb8ocQ0OVQK/fOoCbjdGWCwyG3+RdPdjjEam4qyOtuc6?=
 =?iso-8859-1?Q?L8vTM4EN/Cwe/Z/kQMut/Z/q8CCJkxQ8wiKzcvY9+L7ipuxxCRprSkLnNY?=
 =?iso-8859-1?Q?R2pX6DyW+zD4DiKYn4wniKDc9NL6VnF53QqaE34OPci+REjPzGkK9DwsUS?=
 =?iso-8859-1?Q?jYSFoptO/ctGDMFXon8JBNHcggXUzdMNLEeulXyaJZ3OdwFcPZ+f8QW9SF?=
 =?iso-8859-1?Q?OUYVQPw+YdrUtLmaTmPCEDBaL9W8ExsJnGCZOPdshRT316BzRhhJK8mUlr?=
 =?iso-8859-1?Q?IYcrf3syN0WaL01iidCfaVyXnQZ6Z89B86nNrhm2xJAPnU1+nl7ScIbh0W?=
 =?iso-8859-1?Q?UXZGxoA1GOU+ZZWtODaQsrUhFBJw/G9jjDF5ptV6981VMQVcxx1NbNAnoj?=
 =?iso-8859-1?Q?CF7ZLe3SIj097g12nXE/I03q9tTEETjSby0mTpn6Dq9dAWTwdXE/Wy4F/Q?=
 =?iso-8859-1?Q?JurK3fgVeyuYfh/cbEXh4apluNfz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR07MB9311.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Pq2WIsYRxm6iOtL4gVlArhjFwVDLvpagw6TOoSYkdTxCxT25mLPMuAJ9CE?=
 =?iso-8859-1?Q?tuB3mWCrm6Vh48n6GQW1Q0CZnShnQfKFzmTcGTg5BffyWAWMyBiRi0wMp3?=
 =?iso-8859-1?Q?sT9RvfW3CO21z61iGSukvUrDiTZdiYnBH+P1Ethh+s0lNH0n/Lz0fTbfCY?=
 =?iso-8859-1?Q?/fLblFc4b4obZp2zyNDzpD9abnCXSt8AXK0CEH5qp8/Bfgxwdie/cqk2vN?=
 =?iso-8859-1?Q?DtmDt8Z8HkmyyOm6h66tQrYKAv3UED33fwdFYT5NAFJInBCa55XLAv9lw/?=
 =?iso-8859-1?Q?4v7ZA+QSBVAjARIEm29Or9sv6XQ9llq0qm455F+KWVADUWtORIpoLozRe+?=
 =?iso-8859-1?Q?l1qss9g6y9the+4EtbkiivB/69Z2GZpQiweitN6rEP25vQnP5ELjEDqyGf?=
 =?iso-8859-1?Q?E7HhcZPkAbRU4waRKHyP8vMenn1Jl0DCkjM+hCaek5pq7fPwLz1fZlsaim?=
 =?iso-8859-1?Q?iaVX6aPbMdl1LLoLoSnJEHEZkVu1Eviem3DGFV3pvz7p3ksyVBsomCXKvF?=
 =?iso-8859-1?Q?jbCCbMstDHuvUKq0SgpBbjlpnwlGK4edvWHnJwrwMX3BgWmPZ0s1Sn3+G4?=
 =?iso-8859-1?Q?EopY7xEkIUOGDRHl4klNzX/DwoBEaCxO6GCfuXsCTPAI7W4SuT31uGk7EZ?=
 =?iso-8859-1?Q?L+yWc0St762RXAEj5gmZ/PQMeimW22h+GY+hQ3dO+35j7euPvrhgAXmKwM?=
 =?iso-8859-1?Q?gRqGVlrqFHi5yydhK4uTCefs1B+JNzxpD156CT5OnS8rhsBjelJEtANjPK?=
 =?iso-8859-1?Q?EHbsOYMoOaSizPPmHXdMRmxUZk1vi4UT1y9Z29Zp72MHdoOqr816fvpR+v?=
 =?iso-8859-1?Q?W3OGy269DGPTAhdWfd8pnE1ubi9f+U5wO/kYgh2B6WunuhofZFdUT/3a9g?=
 =?iso-8859-1?Q?Z7rCDmeiCLOOhJ4K0Xis0UWsZcW1bgXcd3w5eq+1MnMoCYKAgRm5bsgT+s?=
 =?iso-8859-1?Q?DyWBMqQS5TTZ6EUHt+cfsUU1/jhJFGis9GAu3mLwtp3WIuKIio8sm7XFvw?=
 =?iso-8859-1?Q?qQmmJ7tBJuQGfThb9gIzcD5WvPEWL7Cx3+1a2m0bPL3cFAHdiEJb3YkU8v?=
 =?iso-8859-1?Q?fcGfCEtpGiyvRoOxORHDtFTInEQfRff7ZZPaknJaR+XGDY4vFE8HDaocvT?=
 =?iso-8859-1?Q?UpF5GTcuhxJKhKZHPDvT6CoEvrqqMhwtV56guM3KXE1meDmauDQx69gXVX?=
 =?iso-8859-1?Q?0c7i/A7J+KMtR8GYNnOZtJ2Dx3k1ZTpkL7/Jq7nRFdgqej0UfKJtMhRn6r?=
 =?iso-8859-1?Q?9Q/M0htX0GGoKRnQSm/8OkL+TZsLW3aMvIr/c4ZEeV9skGkN0A6/0QDqnT?=
 =?iso-8859-1?Q?Hmo0lEm7wvDEDJ1yrG4gqIU1M7O3/Kbc+Is3tuxTKIjYc2uHyuvFZI7l2F?=
 =?iso-8859-1?Q?GSlu0snyCfhgaTRX2SPEbWVpxRTzZ6cHH8z0HMF+V4qsmg+0s8LBPgPqzJ?=
 =?iso-8859-1?Q?ZCs74roI7KnVwHYz5iqBTiXtgLmzhuiBD4OTgDHclPE/BFNG2HX/wQrEly?=
 =?iso-8859-1?Q?XxK+xZb2Ceojkp1b1qC1mgeNtNqLadplvmcJJJbOo3Y0poK8QGKd7I0JY5?=
 =?iso-8859-1?Q?cZ6YD8JZw4IwO9TW7N7H65s1fmDlU3UtBr8SY9JJzOtNTEDAvJ/u6oNiXm?=
 =?iso-8859-1?Q?zQJ8u2DOxc9bc6zq4O3uev6OpEXT/HiU9sUJ8Ge8Kfe1bfMiQG/aQN+Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: goodmillsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR07MB9311.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51cc117-403d-4b1c-eade-08de01bb72ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 13:56:12.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b0b299c-c929-4337-91ad-1ac71dc8c96b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoQ8w4rJpeiLzd3F+U4l4MktqraENJcSU82hbiZCfRIaicV3IGd+0b7kZ43/lNcBF8+rQr5qqNcmbKE2FcKW0wlaIIROcVt6K21iK+RoHD2EeKv+cZPRCR4pXwveeftW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7960

Hello,=0A=
=0A=
Current Linux kernel has the problem that at most one ath11k / ath12k =0A=
WLAN module can be present. If two such modules are added to the system,=0A=
neither of them works, and this kind of message appears:=0A=
=0A=
ath11k_pci 0000:01:00.0: host capability request failed: 1 90=0A=
ath11k_pci 0000:01:00.0: failed to send qmi host cap: -22=0A=
ath11k_pci 0001:01:00.0: host capability request failed: 1 90=0A=
ath11k_pci 0001:01:00.0: failed to send qmi host cap: -22=0A=
ath11k_pci 0001:01:00.0: host capability request failed: 1 90=0A=
ath11k_pci 0001:01:00.0: failed to send qmi host cap: -22=0A=
=0A=
Also, a reboot causes kernel panic.=0A=
=0A=
I found two series of patches, which implement support for multiple WLAN =
=0A=
ath11k/ath12k modules. Unfortunately, applying the patches wasn't easy, =0A=
as I'm used to merging but not used to applying patches from an e-mail.=0A=
After several hours of work, I was able to come up with this, a=0A=
mergeable code based on 6.6, which should be easy to merge to latest 6.6=0A=
LTS version, and probably also to latest 6.12 LTS version.=0A=
=0A=
I can confirm that these patches work. I also publish these to fulfill =0A=
the requirements of GPL, since while the patches are available, backport=0A=
of them to over 6.6 or another LTS version wasn't available.=0A=
=0A=
Sorry, some commit dates and commit authors may contain incorrect =0A=
information, so alone based on this, merging my code to Linux isn't=0A=
advised; instead, the patches should be applied from the e-mails.=0A=
=0A=
I hope this backport could be helpful to people who want multiple ath11k =
=0A=
or ath12k devices on top of whatever LTS kernel they're using.=0A=
=0A=
Here's the backport: =0A=
=0A=
https://github.com/jmtilli/linux/tree/multiple_ath11k_ath12k=0A=
=0A=
I'm not on the list so please maintain Cc: if you want me to read it.=0A=
=0A=
I hope official kernel will have the patches soon.=0A=
=0A=
BR, Juha-Matti=

