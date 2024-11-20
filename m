Return-Path: <linux-wireless+bounces-15533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7769D3F53
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C730284642
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBF913B59E;
	Wed, 20 Nov 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growy.nl header.i=@growy.nl header.b="uS1S1H3Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2136.outbound.protection.outlook.com [40.107.21.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79A824A0
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117643; cv=fail; b=edw3oK6I8r8B/176IRNpyN0GK3kAZtbciIba8a08tckTNpE1s32C6buAoNndTLBXwjCPXGsIv8F2K1CMIDB6Rhurif4UDMbMCNfPAQNIK+Ig5DK5TJjkIeclodHRTIH/PnzIE7LdXisHeyehv4Km96EpVQgu5Mar7B1bXyrUtMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117643; c=relaxed/simple;
	bh=LWdcKM4DIQzzZb3kdznHCX1ZLqlLGDe57EQ9sKnuOtg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OWYTri36+dCT0kxSrCwqXAom6Vk7NFqGEZ6s55Gf58RpUzj0JxElOrIAIT0Dexiz4TLQDWUSux8ZShOnps+f2Z5w+RDZE2odEgVaKZfrCfU1FzIaFoWgLces064CGCKxRQqnkB2J/l4wfw8UixRKq5VPJnzvLOmWNmes+sfJPwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=growy.nl; spf=pass smtp.mailfrom=growy.nl; dkim=pass (2048-bit key) header.d=growy.nl header.i=@growy.nl header.b=uS1S1H3Y; arc=fail smtp.client-ip=40.107.21.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=growy.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growy.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0Vvsoalauaw2tyaacIQJQ8r6dY46sLRHdmQ0rNmNDCPKEot0ZfWDPnt4zJNaxOTMfVUI2luJeun+LSPRoE5eBtYbxf0rb6/37mbo2YypUB/XXNeo98+vatjghElF+KbxBVtKavYEqJtzQQNZwPK+dOJsmluTTnKcoiCZUN8CTi3xVMoRad/tnBMm3oGKN4KJBXezVK6T1Cvxtx1S/FbVoNJ5NrhQHEIOucrqkif3KLeK7QHV8xk4fEuDnzOgKGCDK2Rn/e8snqMARqplgVu5tjaLqrsAHKChUnGEbU5cKAWswUjyNz6CI2iO8D6tPtPbH4Tti3bIEriWCQ1Rd9Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTm64I35pAIoiqnhGK8iL6OknTb87P4ssrfWv/aakpc=;
 b=KzGtWsgPv8EZH2yoRpSwtcnK8h5Bfppf82MNvg2S4ynQRB2ATn/Zh0qmCXxV7jyZL4PGJCsESkTzvGq5J7A5TcG2ar4ECc5T5mOb3VNsrohnqwW9ylT4Hxi/usJZaypaV/tFvnM5fPD1brPiKhGOACugIx9emPAVrv1lCWFAMQmj8fGIwivKj1hiH5CYSBEyal7C5kdQ9Qet2pMtenw8ssWyWetSvuKkzy2GckIkyuYL/n2upBeMuJQOsFMp0Adozq2dd5h0OhLys18UV//LyW8ZHykOy/rZC7p9qghwHIXJP/DeQsyf5VAth+SAM9OgtQIrUkKO1MSY7JzrtISr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=growy.nl; dmarc=pass action=none header.from=growy.nl;
 dkim=pass header.d=growy.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=growy.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTm64I35pAIoiqnhGK8iL6OknTb87P4ssrfWv/aakpc=;
 b=uS1S1H3Y7wWJfStpXmdYylVwCn4JDrAbuK2ywliSgd/4FLaEJR6TeNEbVhzxDCiioBxEvEKR7DSpsUNn9CwAg43CN9GvWMf4JmvcgxQcMKbPOMysrE1LSd4E5IzRZXL1M3rtTMyxUwWqESH2NNL6Bkv3wFyX5BkvqEGONFnwA42NagEZnJufCgG1ZBKLablPjgxuUHzwnHdVsat9MvyGrCDVZCCaKE0BP9tnA5STjmqZY/MJavlMFim0GvRPaZZ117ZcKqfM8YhYmxrMJWkp2JxLbm0pUjKStra0AukGfw6/BIIP/fyAXwZ8G+NGSmnl5+hJWEMFE5ueR0mDJv0D7A==
Received: from PAWPR02MB10212.eurprd02.prod.outlook.com (2603:10a6:102:364::9)
 by AS2PR02MB9512.eurprd02.prod.outlook.com (2603:10a6:20b:598::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 15:47:15 +0000
Received: from PAWPR02MB10212.eurprd02.prod.outlook.com
 ([fe80::354d:4cbf:498d:7faa]) by PAWPR02MB10212.eurprd02.prod.outlook.com
 ([fe80::354d:4cbf:498d:7faa%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 15:47:15 +0000
From: Marco Louter <marco@growy.nl>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: iwlwifi AX210 Failed to start RT ucode: -110
Thread-Topic: iwlwifi AX210 Failed to start RT ucode: -110
Thread-Index: AQHbO2DHxpHkNf1YM06A63/DD31+2Q==
Date: Wed, 20 Nov 2024 15:47:15 +0000
Message-ID:
 <PAWPR02MB10212AC4893D92FDB31006334D0212@PAWPR02MB10212.eurprd02.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=growy.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10212:EE_|AS2PR02MB9512:EE_
x-ms-office365-filtering-correlation-id: bd278575-40f9-4cd4-5773-08dd097a9b81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3mcNCYGvhvY8/940BnchkNz8XbxcD/2VvLrTVUOdUxBfRU54KtS4cN50ID?=
 =?iso-8859-1?Q?DXJAlEEX8BjizYQ8kJD/U3rWqdLJ+527Ay0PLD9rpZWRa2ziN8QRDRT2dK?=
 =?iso-8859-1?Q?8XNRnZOHIhNoNQ8fyFcdKtvAr0Ki6m3vXESyrY5rs562+O+4fmHAPz5nUX?=
 =?iso-8859-1?Q?OvQeQ01aM4kVxr24Is2UEi3Ca0odtIjgdMkgfzPbNpAft5q91RzLAjpGCT?=
 =?iso-8859-1?Q?KTtCBcnCpacXgEzk5O8a3LDH0J6MT5xOSrv9MY2Y3Ci+JOocqKvWbzMx0L?=
 =?iso-8859-1?Q?XFZeFwrzm9PtP2coDzPBhSj0nvUPxa9ArosLPqG6nXOwTCXSeLOlKc4DIo?=
 =?iso-8859-1?Q?kUDdwGmIF6drDtoTT/YYNcKebzyBmAEeIiK7ZXZxk2fOHqbmQIWL1F9L0b?=
 =?iso-8859-1?Q?aNjyLcN+7nG+1NeygE2L4tK6lfKSepNa3XqHVKhUEmtQyilCPV4TgLkj3N?=
 =?iso-8859-1?Q?hHUPccnfVwsWde/3vP1UXZHR59CQrIwHqAx25Q2rljG6dDXEvxJDTdc/Yx?=
 =?iso-8859-1?Q?5SzyssWL7v9ukA0IsDAPAI0mizxBr5bM4AAoK2l+SvmXneci0vIZg3ZFx4?=
 =?iso-8859-1?Q?HJckx6lnEFdipu0ONbUVmYRgpG8RMYl5Sit6lfQLpQSvQbb+DyCTQYFYYs?=
 =?iso-8859-1?Q?4RonTMUbH+P2/Cn42pxXS6a82HQdGIR+c6tY5Q4Ak6WPpNRlTxkorMfiDk?=
 =?iso-8859-1?Q?HZBp2X3D0komSKRvcaTVScg2cYNmpTRpbPS0gqlkGlB8u9yA71NKYtdY9m?=
 =?iso-8859-1?Q?I5OZescgFWrfNhFqA5Xf+HzMrCaQpihhD6WNoVM/trDqSGEk/li4o6eEZ7?=
 =?iso-8859-1?Q?NXlnVj07HGG1A+rmfWXUKkJM04IM5iXfyXKOVgqCgnKAAD9o6W2HqR/2SL?=
 =?iso-8859-1?Q?qJ/MGAMaXtJHqKij8f8Tn+THTl2w1CIrkOIiveB3aFkUDedcvAwVEMgO8G?=
 =?iso-8859-1?Q?Aq6NjIGJdPiRL6nVNRhIyjH3cbFQxzuOwLcQpWEXpGKlkPKYBbMtLsUmqL?=
 =?iso-8859-1?Q?/I503C86vFuiSNBo6xJLpFgc8UabbTxHc1VaZAHX9F9rqRpHw7RxyNbxAB?=
 =?iso-8859-1?Q?m2i2/G85LVMXtCf4HkMjay9XuaNtMPMzdj1jLzvLXylGoFyzKdwhk1tJf+?=
 =?iso-8859-1?Q?kCIUllEM7p1oXuXI9cwNMJ5KdGJ+eEXUHtIp3Mz3NTxFDhI4zSIPAmxRf3?=
 =?iso-8859-1?Q?sWz3oX0elzhnhUWfmGp4P+7s7rmjIa9ZdbJ3yBTMg2I7AMa2bOTGjiiWob?=
 =?iso-8859-1?Q?ZLm5lZtrDs8HrpszV14i63gWEMrUccRma0P/eqeF2A21k5MRjS90j+ZS75?=
 =?iso-8859-1?Q?hJKOWgjUq44ca5oZbYDKd/rK4T6Au+VqeHcUxpswuZUA+2yEBI+ceWg6LE?=
 =?iso-8859-1?Q?Iq/q3Za0kE4a6/PZVKbShJgPOyHpgdv8j02Gtp96a/eAmVOzHJcXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10212.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bpZQHOMJNE9hUPHRUu7PJ2wKiQBkVWb3jQ5Io6CepAmCqypukrxU82POjC?=
 =?iso-8859-1?Q?xBQVAAdasbrHJVacOWZVuP1TxfLgAlkSCkrQydKLKmY9DllNOvH9PCbXv0?=
 =?iso-8859-1?Q?ieibgqtO5ZXAex2j64LK83Qf6yLU+24XFMNIzMxB7e0R6L4nLj8a7IxeDl?=
 =?iso-8859-1?Q?zFshjb3z/qS+FMWcNNb8iuc5PW3YqLb4bl9neCG6AZ5MUkMSLkW88uvnbB?=
 =?iso-8859-1?Q?NUIJcrmdGcIjg1TLovfrEa+GcHLZgBi7+lBtbp2vGPh0oec6YThEgf00h5?=
 =?iso-8859-1?Q?s6u8t+OugjrJqXvaIgMIJcYa3vHrGFIqquuQ19E+wnA4F+c6O6xAJqa7PY?=
 =?iso-8859-1?Q?wRkxnhZS+lWrEwkoSjMUFZhJzDIrcnOAwL5N+GeIJLJo/PkjpjYoy0ZV94?=
 =?iso-8859-1?Q?tzO+KGhqEcEf3FT0E4JrTASgQJaSaUSSfMcYq57vpI/TgWk233JyDmS6tQ?=
 =?iso-8859-1?Q?xxAiBkdN4aOmcgQP2P6M7N0nUhNySxg7bshNSRTD27+2K2LPLuuK0zhtO3?=
 =?iso-8859-1?Q?Ioy1FE8l78j6rhLdVack3SlCGX9sCMfA5LuBoTfwYsubKgSbdTPEEHtY3G?=
 =?iso-8859-1?Q?HTkwk4ZGF+O9EmhIV1jjV5h3PpYKRBArlDqAogfJ15w2X1CisH33yyPpdr?=
 =?iso-8859-1?Q?draHFzfmbPPCGorT0usoygeW/Pu6bJsq4iGMPezJYUUyCslhC2j3DsgDRE?=
 =?iso-8859-1?Q?SlJgET6nH1bplt/rK3kOAr5Hbowq2B4sI3aRboC47PJlKpdVL/moBOmyn1?=
 =?iso-8859-1?Q?sZ/buy8hOzLjyfnPdNTHOh9ZW1MLrqDFI3m1/x75HLQMT4dMVBnavGOuUa?=
 =?iso-8859-1?Q?d6F3Y15wP+7hdb5DJX14P0MHfq48Q1Jc1se4vKiL6NMGrey2/azrEiC0Oi?=
 =?iso-8859-1?Q?muhgeVhGwz8yKReX47Ifz4d52fUei9U5VBrfyW+aa4xBHui2ucbTHQg/rE?=
 =?iso-8859-1?Q?hE5oizooTJqmJ4spRGQqb7FavrfMeN9vp5Z6f+NBZ27I0NTfxHzCd0owm0?=
 =?iso-8859-1?Q?X5Wck384Q0F93k4vV5UQCrnjlMvQ4xddt0c3b93DojELrUWZtV19W7tymc?=
 =?iso-8859-1?Q?F8gYQxDSuURmERV7ky+2py4mZVlOTjdhbDqzd9MszcHlQiG1oC/nBxTA7e?=
 =?iso-8859-1?Q?HT7JWZFM7swz5oS6toHcQcMvmYyX/tPdtoxMizyaTBG1VTxVrpsEygUZGk?=
 =?iso-8859-1?Q?WYxbysNzIF5EbjghC4nY5q2409xpLzSCrzdkDpa70uf4bU+bH1tuaI2Kq2?=
 =?iso-8859-1?Q?bjlSq54d1uj0VkFPsBMvLYLl2TW4W2owWdYESjFnq11H24DLvD3TZVawpI?=
 =?iso-8859-1?Q?A9zFyAPQKkZlZpcAnRvkHA1x+fPnSoojFTxr2pXGQPXEEGK9AotlrYJG9M?=
 =?iso-8859-1?Q?6x10+9EIhyJvD7QgFOLDUsQ9uJbIbQYYJ1kVYFBNr7/he/cbzjMe6IcTvR?=
 =?iso-8859-1?Q?QFajdQpBhKdHp7GdCxVQGzLAckAGpoxNk5XbwMQcZYDmwYGYTldB7b/gHU?=
 =?iso-8859-1?Q?4WMHBIEv0cNovLY3T6mdh+kNdY+JuIi3kJL0FwdIYmnsKII0gg6eTgoXaU?=
 =?iso-8859-1?Q?d7PF69WCKIXR5SNcaC9prQGQrPu/C9ipdwHD7ZbcbDH6XwzxU7Wi8hS6fB?=
 =?iso-8859-1?Q?l7w4hM8ttxeCU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: growy.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10212.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd278575-40f9-4cd4-5773-08dd097a9b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 15:47:15.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 788050b5-a803-4a89-b95e-8c418dc9f341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7UR02Dt4dclk9WzjNEOqSXJ5zSXsvku9Se/BXDJ1u+vmRxrB3JUqgzFU//1TnkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9512

Hi,=0A=
=0A=
I'm having an issue with an Intel AX210 wireless module connected to a Rasp=
berry Pi Compute Module 4 using PCI Express.=0A=
Kernel version is: 6.12.0-1.g52785e2-default (using OpenSUSE microOS 202411=
14)=0A=
=0A=
After boot there is no WIFI interface present. dmesg shows the following er=
ror:=0A=
[   10.459327] [    T712] iwlwifi 0000:01:00.0: Timeout waiting for PNVM lo=
ad!=0A=
[   10.467497] [    T712] iwlwifi 0000:01:00.0: Failed to start RT ucode: -=
110=0A=
=0A=
The same error occurs with kernel 6.11.7.  However when I flash the CM4 wit=
h Ubuntu Server 24.04.1 LTS (using kernel 6.8.0-1010-raspi and firmware ty-=
a0-gf-a0-86.ucode) then there are no issues and the WIFI interface is prese=
nt.=0A=
=0A=
Full dmesg output for iwlwifi (kernel 6.12.0):=0A=
[    9.338062] [    T651] iwlwifi 0000:01:00.0: enabling device (0000 -> 00=
02)=0A=
[    9.350164] [    T651] iwlwifi 0000:01:00.0: Detected crf-id 0x400410, c=
nv-id 0x400410 wfpm id 0x80000000=0A=
[    9.350186] [    T651] iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=3D0x=
420, rfid=3D0x10d000=0A=
[    9.350197] [    T651] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 A=
X210 160MHz=0A=
[    9.526723] [     T62] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ V=
ersion: 0.0.2.42=0A=
[    9.528898] [     T62] iwlwifi 0000:01:00.0: loaded firmware version 89.=
6b44fa0b.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm=0A=
[   10.186016] [    T712] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: =
0x20=0A=
[   10.186041] [    T712] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION:=
 0x1f=0A=
[   10.186055] [    T712] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90=0A=
[   10.186068] [    T712] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0=
=0A=
[   10.193797] [    T712] iwlwifi 0000:01:00.0: loaded PNVM version 16611aa=
6=0A=
[   10.459327] [    T712] iwlwifi 0000:01:00.0: Timeout waiting for PNVM lo=
ad!=0A=
[   10.467497] [    T712] iwlwifi 0000:01:00.0: Failed to start RT ucode: -=
110=0A=
[   10.475355] [    T712] iwlwifi 0000:01:00.0: WRT: Collecting data: ini t=
rigger 13 fired (delay=3D0ms).=0A=
[   10.476456] [    T712] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:=
=0A=
[   10.484210] [    T712] iwlwifi 0000:01:00.0: Transport status: 0x0000004=
2, valid: 6=0A=
[   10.492907] [    T712] iwlwifi 0000:01:00.0: Loaded firmware version: 89=
.6b44fa0b.0 ty-a0-gf-a0-89.ucode=0A=
[   10.503500] [    T712] iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_=
UNKNOWN       =0A=
[   10.512350] [    T712] iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0=
=0A=
[   10.519953] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1=
=0A=
[   10.527855] [    T712] iwlwifi 0000:01:00.0: 0x004DACF8 | branchlink2=0A=
[   10.535211] [    T712] iwlwifi 0000:01:00.0: 0x004D091A | interruptlink1=
=0A=
[   10.543222] [    T712] iwlwifi 0000:01:00.0: 0x004D091A | interruptlink2=
=0A=
[   10.551029] [    T712] iwlwifi 0000:01:00.0: 0x0001668E | data1=0A=
[   10.557982] [    T712] iwlwifi 0000:01:00.0: 0x01000000 | data2=0A=
[   10.565081] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | data3=0A=
[   10.571881] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | beacon time=0A=
[   10.579297] [    T712] iwlwifi 0000:01:00.0: 0x00058301 | tsf low=0A=
[   10.586281] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi=0A=
[   10.593195] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | time gp1=0A=
[   10.600305] [    T712] iwlwifi 0000:01:00.0: 0x0006C52A | time gp2=0A=
[   10.607526] [    T712] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision=
 type=0A=
[   10.615551] [    T712] iwlwifi 0000:01:00.0: 0x00000059 | uCode version =
major=0A=
[   10.623838] [    T712] iwlwifi 0000:01:00.0: 0x6B44FA0B | uCode version =
minor=0A=
[   10.631882] [    T712] iwlwifi 0000:01:00.0: 0x00000420 | hw version=0A=
[   10.639508] [    T712] iwlwifi 0000:01:00.0: 0x18C80002 | board version=
=0A=
[   10.646996] [    T712] iwlwifi 0000:01:00.0: 0x8005FC12 | hcmd=0A=
[   10.653651] [    T712] iwlwifi 0000:01:00.0: 0x00020000 | isr0=0A=
[   10.660391] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | isr1=0A=
[   10.667051] [    T712] iwlwifi 0000:01:00.0: 0x48F00002 | isr2=0A=
[   10.673870] [    T712] iwlwifi 0000:01:00.0: 0x00C0001C | isr3=0A=
[   10.680539] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | isr4=0A=
[   10.687360] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id=0A=
[   10.694651] [    T712] iwlwifi 0000:01:00.0: 0x0001668E | wait_event=0A=
[   10.701909] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control=0A=
[   10.709181] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration=
=0A=
[   10.716662] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid=0A=
[   10.724139] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match=
=0A=
[   10.732254] [    T712] iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel=
=0A=
[   10.740375] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | timestamp=0A=
[   10.748045] [    T712] iwlwifi 0000:01:00.0: 0x00000020 | flow_handler=
=0A=
[   10.755531] [    T712] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:=
=0A=
[   10.762914] [    T712] iwlwifi 0000:01:00.0: Transport status: 0x0000004=
2, valid: 7=0A=
[   10.771539] [    T712] iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_=
HOST=0A=
[   10.779443] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlin=
k1=0A=
[   10.787267] [    T712] iwlwifi 0000:01:00.0: 0x804838BE | umac branchlin=
k2=0A=
[   10.795007] [    T712] iwlwifi 0000:01:00.0: 0x804A5CC6 | umac interrupt=
link1=0A=
[   10.803052] [    T712] iwlwifi 0000:01:00.0: 0x804A5CC6 | umac interrupt=
link2=0A=
[   10.811014] [    T712] iwlwifi 0000:01:00.0: 0x01000000 | umac data1=0A=
[   10.818189] [    T712] iwlwifi 0000:01:00.0: 0x804A5CC6 | umac data2=0A=
[   10.825441] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | umac data3=0A=
[   10.832599] [    T712] iwlwifi 0000:01:00.0: 0x00000059 | umac major=0A=
[   10.839830] [    T712] iwlwifi 0000:01:00.0: 0x6B44FA0B | umac minor=0A=
[   10.846991] [    T712] iwlwifi 0000:01:00.0: 0x0006C528 | frame pointer=
=0A=
[   10.854392] [    T712] iwlwifi 0000:01:00.0: 0xC0886258 | stack pointer=
=0A=
[   10.861847] [    T712] iwlwifi 0000:01:00.0: 0x00000000 | last host cmd=
=0A=
[   10.869230] [    T712] iwlwifi 0000:01:00.0: 0x00000400 | isr status reg=
=0A=
[   10.876752] [    T712] iwlwifi 0000:01:00.0: IML/ROM dump:=0A=
[   10.882952] [    T712] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/=
state=0A=
[   10.890861] [    T712] iwlwifi 0000:01:00.0: 0x000081A9 | IML/ROM data1=
=0A=
[   10.898233] [    T712] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_A=
UTH_KEY_0=0A=
[   10.906561] [    T712] iwlwifi 0000:01:00.0: Fseq Registers:=0A=
[   10.913166] [    T712] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_COD=
E=0A=
[   10.921065] [    T712] iwlwifi 0000:01:00.0: 0x80440007 | FSEQ_TOP_INIT_=
VERSION=0A=
[   10.929367] [    T712] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INI=
T_VERSION=0A=
[   10.937761] [    T712] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSI=
ON=0A=
[   10.945464] [    T712] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTE=
NT_VERSION=0A=
[   10.953772] [    T712] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOK=
EN=0A=
[   10.961335] [    T712] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID=
=0A=
[   10.961342] [    T712] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID=
=0A=
[   10.961348] [    T712] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_=
CHIP=0A=
[   10.961355] [    T712] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_=
CHIP=0A=
[   10.961364] [    T712] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_RE=
GS_SD_REG_DIG_DCDC_VTRIM=0A=
[   10.961372] [    T712] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_RE=
GS_SD_REG_ACTIVE_VDIG_MIRROR=0A=
[   10.961379] [    T712] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVI=
O_INIT_VERSION=0A=
[   10.961384] [    T712] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ=
_VERSION=0A=
[   11.027076] [    T712] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_V=
ERSION=0A=
[   11.027085] [    T712] iwlwifi 0000:01:00.0: 0x000000F0 | FSEQ_CLASS_TP_=
VERSION=0A=
[   11.042961] [    T712] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x804a578c=
=0A=
[   11.042973] [    T712] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0=0A=
[   11.510561] [    T712] iwlwifi 0000:01:00.0: Failed to run INIT ucode: -=
110=0A=
[   11.530473] [    T712] iwlwifi 0000:01:00.0: retry init count 0=0A=
[   11.743073] [    T712] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: =
0x20=0A=
[   11.743102] [    T712] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION:=
 0x1f=0A=
[   11.743117] [    T712] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90=0A=
[   11.743131] [    T712] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0=
=0A=
=0A=
Please let me know in case any more output/information is required.=0A=
=0A=
Kind regards,=0A=
Marco Louter=

