Return-Path: <linux-wireless+bounces-7326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADB8BF655
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 08:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C571F237A4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8212FA94D;
	Wed,  8 May 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="dH/bDdUc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2134.outbound.protection.outlook.com [40.107.104.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07378BEC
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150200; cv=fail; b=ndxtwCTTeLUNG21d3HMHZcYHTyhVJEwVWzxLw/3PMLZtAjlnmN+MAT5q6qvPNAvejGZHWaZiXVoDEjk/gw4Dvg91GPfoA6LhH5Pw9pqZZLSc14lMfZP15UxkBY85i1p9qZZMYnkxZM+RmzfX9k5z3xxoy5zkoLGQmaGwQxOiqJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150200; c=relaxed/simple;
	bh=aJ7GsCVzC4iM1NY7VPjkAGtrN54KjlGBibIbCZsws2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrnYNET17QFI23A2p5vK3Qql4FaciLfuwKfn05BxQzAUw2C90RPwM83d+ypUEmp/BNBtKwtJzUo+foz9IpxRKbCew4DTKNo/wCjiNro9PYtS+wgL5u6TGo6S+z0KPPDXq2VqP02gsRIq6N8Rp6U74eNLhZXJKEihFDI2V3tO6Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=dH/bDdUc; arc=fail smtp.client-ip=40.107.104.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHywoS1XGiGdXGryD3rG7YezlDzyweDVu6oWhRbar9qZ6xczLRVSdrB2VIUTYVBuhigmeq/f1l1orXFykr4+GppyUoyOSzrpP3QE8IHv5E3ah6QxNu6BWTYuqUj2/hWRkoEkskEGTixb2u3NBcphk0e2p/ns2oH263rERP9jlOOvcQIrrj1ptebJQLGiqbEyEn0Y7KCD8vpRAdgx1CoF5Jdf9GMqPN4vqyXPF85fkFs79FAL1qjJieRKzCrrDtE1HgRofKErogL7tI5h9yPMzl1LvptwAeIC/Ugqtspgfww1CFynoYzF5ki2rZHaVl4AAN5A4nLqGJ8KogMoB/1XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us91LmKscl7O3yT7btLugnQtY1wllmClF1ZLfxGtVU8=;
 b=ZbxJdJLI6oPdwk7qyk01q+6KXE7T+coa381yRd/gPFzK6zjDaOj5OHNX3ndJSug4f8Hkde6TYyOfV8tsmpjR9KLixR1fqWg/e37eUoX3baUCnIVQs1qDluOa7JHPaswHC8Kz+g6Dm3XCiOwwTij9GvSnLuOTAQRPjBAMMBg8r8QUapTwlJ8FnNi5vetPtkEUAOgiikGkTh9Jwye0s5Sd8/V4txpUdcewU+OAZmKNHtHQoXjS/2RjIVhTO6NH6mGm7Gi986HgBT3bOopyFYqtKorvO56DeIb5x4vbHnkMD3BwjWKBVF3pX7F6z3op9EvFY4xWDZSsQ0RcloDDG/C05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us91LmKscl7O3yT7btLugnQtY1wllmClF1ZLfxGtVU8=;
 b=dH/bDdUcMIBlFa2sAZDlXcjvE3jZIvAVqeTWqaCup38KA+yRDm8Lkxb4koqU9UHY/1iJIrviWe6dgNDlgi8MLNQIOiQyrG60qML5oGrAem9AiqPNIt7eKo8HzKGGrT1mcDQOd5uUZj1oxSAHjsq96kLmLUNbbY55g8EG8Kxsq0M=
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by PAVPR10MB6912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:32f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 06:36:33 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 06:36:33 +0000
From: Heiko Thiery <Heiko.Thiery@kontron.com>
To: BUKSHA Kirill <kirill.buksha@axians.rs>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "alexis.lothore@bootlin.com"
	<alexis.lothore@bootlin.com>
CC: Ajay Kathat <ajay.kathat@microchip.com>, "Heiko Thiery
 (heiko.thiery@gmail.com)" <heiko.thiery@gmail.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>
Subject: AW: wilc1000: error when transferring large files
Thread-Topic: wilc1000: error when transferring large files
Thread-Index: AQHaoJCQi11hvhFXTEOvMHxNDRR8E7GM1LZH
Date: Wed, 8 May 2024 06:36:33 +0000
Message-ID:
 <PAXPR10MB4948B9B69A8D9964B60BB5F68DE52@PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM>
References: <3b0aa2d8-4e3e-4e50-8c04-f3a2637bb18d@axians.rs>
In-Reply-To: <3b0aa2d8-4e3e-4e50-8c04-f3a2637bb18d@axians.rs>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4948:EE_|PAVPR10MB6912:EE_
x-ms-office365-filtering-correlation-id: 841c2fde-23a6-413c-b794-08dc6f293416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oAUwqSREiNnpB4nOOrDm6GQzOpOHL9xxxRSppluNoU/K//19LyJ7NYbbgN?=
 =?iso-8859-1?Q?AzoooQUixDSuxUNhA+0AV46PVcMYebU5p+07xBhyn5ddU68FG+wBrzaNOk?=
 =?iso-8859-1?Q?biMxT1yzA3NbFmK6j9F1a/56+av65qcaxAN4l/bZU98lJtHy/+2yN1mYb6?=
 =?iso-8859-1?Q?xcgeR0FX/pBge0KVdHczfjC72KXZ2KfEgoflJdH2rggzO/W22THg2denlS?=
 =?iso-8859-1?Q?gaZgkY6dWcljwirFhK8Yda8Q0W5cfDdUPopP1hv1VQ4yMIQYaBoiLOvmL3?=
 =?iso-8859-1?Q?NRnOANrMIy9F746l6FBz6rYBwFR+SYNRjBuzhk9MU74Wjwil0xkDD8McUC?=
 =?iso-8859-1?Q?AxM812XIGBQrXdgptLI6CjKIzu9Q6+24Vcds7btEFSEBEK+tImrYnTrT4v?=
 =?iso-8859-1?Q?L/2sOpZX2InMYIoDCdHhNKdw9suoD0Cv8UDQO+BunCrDDbLL9C0+p9ZOcN?=
 =?iso-8859-1?Q?pruo7KA8yVOs+LW/5CxnrkB752oEMitGyzDsDGqsMp9yrm68Fe6Aa0hbtf?=
 =?iso-8859-1?Q?4kFxaYAHJZcHed3brC25CKJQ+PXP/EGVYPBUX05utWHyRZC2of/7eYeTFf?=
 =?iso-8859-1?Q?Eu0aC76vNPkmWw5DU3wpJgFXNRm/p9+qnPMscDEuyipxGK8JP+fIc/EhxU?=
 =?iso-8859-1?Q?FVKy4ElsVR9cODfp5LwSVYFDd32RAS3Nu3OUclIJ4BXLK6medlAHwjFuke?=
 =?iso-8859-1?Q?08uRrIuelRY2prPx47vXuTpqfukVla+3LEAEschhfHTdy41jdBN3HGwJio?=
 =?iso-8859-1?Q?PAFG+UyTUQ9JV3AiIOASLdGahFVBy0eDbzRa3MMWTN0axxp3uLXgfn+S0e?=
 =?iso-8859-1?Q?M/e9IhRY4c+ARphYbOmfOhI5/eYle9io8b605KLcuSWgRNHTPj/RRcvx7X?=
 =?iso-8859-1?Q?cuVa/k0a3mwjrlfa4HZuq9JRXswJpXULBTypG2oGsSnBXuPJk5S73oMGky?=
 =?iso-8859-1?Q?+LVc7gbJPp7RqCWeqyoC+Wd8TaIt5cVzWUn4brWGpE4OOwWE1J4F3owK0K?=
 =?iso-8859-1?Q?5vCwHMfsEJSUkzU2f4hjWEVnP7gxFU67oOFjQaN/2r54+04HrC/iEOmpnN?=
 =?iso-8859-1?Q?uOB2SdZFIqJk1Nysv+OC3gi9gFnaL5KMCVhR6dkkGAhZzByKjpRHNFS0uh?=
 =?iso-8859-1?Q?lcp18kAff0F0WRwUzPWVmHdS9bVn+5Wi0+wyGCsH6gMba2LARzM0V5OD6E?=
 =?iso-8859-1?Q?hmcgT/zBgGkKkQzt5UlyKxMiOebJTRr8W1V7zwoQa+Cs2QfTg/khsSyIZD?=
 =?iso-8859-1?Q?CcQRU50ZZO7S5Uz3/FaINC3L7omG/K4dphxNpsrtyOgoRDrDCKtCoesNXp?=
 =?iso-8859-1?Q?CCIYZGkqgZiR0S7XjuYJh0t1GzsKK0UIhiAx5uaqSiz3BBsyxyZ89LI4BV?=
 =?iso-8859-1?Q?gNS/r5nl+RRh1KU1+VZrs/CcjXHIK3FQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NtC+F75LjILcQrORDjq3ruC3zG0Gy1yJcprPHB6L9xT62tgumHpiRUB3f1?=
 =?iso-8859-1?Q?w2AiMhYQld96kOj5BIUU9HCvLinnj3euAhrvWMUzM0DpjSfGM7l4YD1WCO?=
 =?iso-8859-1?Q?MZiukUYUGPQ4Or1y9fBtuaKc7GaBrIfZnNIhUkYdohDET709kekd9eNcD1?=
 =?iso-8859-1?Q?hKI1twWqN9UhsYaXkqWx9h85ExgWjmERer+jqNmE+FKnFjzvUDizLpR9jW?=
 =?iso-8859-1?Q?WpIxIOCx9S4Xs3EgaSEXV5TjpzXVOlqSM/Uw/y8UBT74K2qe3O9PItb56F?=
 =?iso-8859-1?Q?2uGpQmFcAYFakW70RNQ1ww+56CPr8E7rdtSCkRv3ksrfwFux/vEx47Ne9Q?=
 =?iso-8859-1?Q?0EdTVVWZfq/GD26uJNc7rRDlieZ5I77Tha/Mk7tSWR7W+qbwgnYuv8D9R0?=
 =?iso-8859-1?Q?+WjkAVCrzoKmjUB40U9+JkcrKQ04g26Vj9iB+NGu0HnBEB5eXHFYMnZ3x2?=
 =?iso-8859-1?Q?QwVTXrrA6s337PDFDynBrc9HkzQCq8R9RsjF8BzTSMHmCsBVioIKZCYD7x?=
 =?iso-8859-1?Q?kY8hK5T5wWbrxcmGWBCoPhUvgXQ/qrha7GXnMPmFM0RM7XSUV9BeSpQSMK?=
 =?iso-8859-1?Q?T+/SmUaVGzwh8rcTUlmkErWIBlvDqIZmn77z+zUn7ICT0IpkE5Egj3bNoV?=
 =?iso-8859-1?Q?DLKK2z48BDhmswtH/DJjAlBu5x2tdksdTS3VzwptdoOHNDD7E8J+d9+Dc9?=
 =?iso-8859-1?Q?DIq3zGL62DIZdAW6tLSOLeqD2Nkl6uIvPvclTqWDJvzChOE6g3EQImD5qz?=
 =?iso-8859-1?Q?cTcZ7LnhRRNWlCOpR5wKSEBvlr5uTZ67JldCm3hmAp7pVK2QU1LP200VSw?=
 =?iso-8859-1?Q?umMMi6BO9SuXV4oHK49ha0aqXQj/yB/pbL9n7UpZdRcPCMxu+gSl5piYyT?=
 =?iso-8859-1?Q?7z6/MuXvaRe2XqBxCeYl6EmvL5cXoIUSNu25RD4Lze+8vNDuIdPZJZp2Wx?=
 =?iso-8859-1?Q?gfG/A7Y9DhtqaFNc7ijXfAI/cCs1nZtUhvOH8sBI+X767I2E6n6Hn7me0c?=
 =?iso-8859-1?Q?zcDg4hSt/gtZlUgcGq3zYUCt4z+bdRiUA2qEGip4NyvMzzIVW0yDQC0oe4?=
 =?iso-8859-1?Q?DK7mDC74RBx93eazaqbw6XupEDy4leEXQbeQYt6Yv9fsV09P7nmjs/XAha?=
 =?iso-8859-1?Q?qwny2IIeURsJwDBA7qXj9s4CLZ2HcvfTMo6oCI1Ylwikqm+AJWynvRFzWc?=
 =?iso-8859-1?Q?sHONCMX3VMXu41vWn4vY7QrAsYW5KR0s5PL/RDTJOAezyn3ZV4XSWdE/L+?=
 =?iso-8859-1?Q?VeVBe3BDD6QU9GxWMYbi50A5s3VhfucjgM+iC34twy3ILPNTwy5wLgnqFm?=
 =?iso-8859-1?Q?M2WTAGEsHPYy1NqoNXIExtIT2IA41UVsZhTOfB2ypUEKONboqUXIqV21y9?=
 =?iso-8859-1?Q?iuxnNWymasE7pkwXx7FMH0XhTbftj1UH0Xa3hIAaD1MQEH0AUGo+Xa0gaW?=
 =?iso-8859-1?Q?QFLIFfZ9x+CZPQ4Y6s9HJe4E9dJCx6hi4WJ49eHwbOOyfBjSqNZQcrz6Pd?=
 =?iso-8859-1?Q?u3jxVfgRrzRxdb3EwrljjaehkxZ9f9SytbOUnC3DbFKnAF+hTwsnhR92X3?=
 =?iso-8859-1?Q?Om9f2BY6OHEOPUI9ujiJq0jCV9P6w0KTqWEI+Azi353k/fp1MKu2vMEV/N?=
 =?iso-8859-1?Q?GQDamySejh19v766NKkE8m0D4fmeFpDR6z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 841c2fde-23a6-413c-b794-08dc6f293416
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 06:36:33.7714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/fKuVkpow8S1I7GHCEC00ad0Kze5JYMou0KpNrMn6HgRs+imfr754SjjH6VD/K3D934JfFMULuiB6xnRfnh0nZa9wC2Jy2vTj16AADGlY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6912

Hi Alexis,=0A=
=0A=
> Hello,=0A=
> =0A=
> I'm part of a team working on a BSP for a board with a WILC1000 module fr=
om Microchip (connected via SDIO interface). Currently we are having issues=
 when transferring large files over a WiFi connection. Here is our steps to=
 reproduce:=0A=
> =0A=
> # generating file to transfer=0A=
> dd if=3D/dev/random of=3D./test_300mb_file bs=3D1M count=3D300=0A=
> =0A=
> # transferring a file from a linux laptop to the test board=0A=
> scp test_300mb_file user@192.168.1.25:~/=0A=
> =0A=
> During transmission, the connection speed drops to almost zero and return=
s to usual values after a while. At the moment of the drop, we see the foll=
owing messages in the kernel log:=0A=
> =0A=
> ------------------------------------=0A=
> [=A0 138.016229] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 140.001682] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 140.009719] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 142.003636] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 142.011670] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 144.006676] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 144.014709] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 146.007049] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 146.015082] NOHZ tick-stop error: Non-RCU local softirq work is pend=
ing, handler #08!!!=0A=
> [=A0 156.123890] mmc0: Timeout waiting for hardware interrupt.=0A=
> [=A0 156.129318] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> [=A0 156.135764] mmc0: sdhci: Sys addr:  0x4cef1400 | Version:  0x0000000=
2=0A=
> [=A0 156.142211] mmc0: sdhci: Blk size:  0x00000170 | Blk cnt:  0x0000000=
1=0A=
> [=A0 156.148655] mmc0: sdhci: Argument:  0x14000170 | Trn mode: 0x0000001=
3=0A=
> [=A0 156.155102] mmc0: sdhci: Present:   0x01d88a0a | Host ctl: 0x0000001=
3=0A=
> [=A0 156.161547] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x0000008=
0=0A=
> [=A0 156.167992] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000003=
f=0A=
> [=A0 156.174438] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x0000000=
0=0A=
> [=A0 156.180883] mmc0: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100=
b=0A=
> [=A0 156.187330] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x0000050=
2=0A=
> [=A0 156.193776] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b40=
7=0A=
> [=A0 156.200223] mmc0: sdhci: Cmd:       0x0000353a | Max curr: 0x00fffff=
f=0A=
> [=A0 156.206669] mmc0: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x0000000=
0=0A=
> [=A0 156.213113] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x0000000=
0=0A=
> [=A0 156.219557] mmc0: sdhci: Host ctl2: 0x00000000=0A=
> [=A0 156.224005] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x4088120=
0=0A=
> [=A0 156.230450] mmc0: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDHC=
 IMX DEBUG STATUS DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> [=A0 156.238024] mmc0: sdhci-esdhc-imx: cmd debug status:  0x3100=0A=
> [=A0 156.243687] mmc0: sdhci-esdhc-imx: data debug status:  0x3200=0A=
> [=A0 156.249438] mmc0: sdhci-esdhc-imx: trans debug status:  0x3300=0A=
> [=A0 156.255276] mmc0: sdhci-esdhc-imx: dma debug status:  0x3400=0A=
> [=A0 156.260938] mmc0: sdhci-esdhc-imx: adma debug status:  0x35b4=0A=
> [=A0 156.266690] mmc0: sdhci-esdhc-imx: fifo debug status:  0x3610=0A=
> [=A0 156.272439] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x3751=
=0A=
> [=A0 156.278710] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
> [=A0 156.287352] wilc1000_sdio mmc0:0001:1: wilc_sdio_cmd53..failed, err(=
-110)=0A=
> [=A0 156.294177] wilc1000_sdio mmc0:0001:1: Failed cmd53 [0], bytes read.=
..=0A=
> ------------------------------------=0A=
=0A=
since you are also using the WILC1000 device, I wanted to ask if you have e=
ver seen such behavior?=0A=
As Kirill wrote, with newer kernel versions it only occurs with longer tran=
sfers. =0A=
=0A=
=0A=
> We are using kernel 5.15 and the problem reproduces after a 5-15 seconds =
of each file transfer. For a testing purposes we compiled v6.9-rc5 and with=
 a newer kernel the issue only occurs from time to time. About 3 out of 10 =
transfers show the same errors in the kernel log.=0A=
> =0A=
> In addition:=0A=
> - We do not think this issue is related to the FW used in the WILC1000. W=
e tested different versions (including the latest from the official FW repo=
sitory) and all showed the same results;=0A=
> - We tried turning off Power Saving mode, but it doesn't change anything.=
=0A=
> =0A=
> Are you aware of this issue? Do you have ideas/tips how to debug/solve th=
is issue?=0A=
> =0A=
> Best regards,=0A=
> Kirill=0A=

