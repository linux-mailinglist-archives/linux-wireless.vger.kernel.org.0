Return-Path: <linux-wireless+bounces-17753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D644EA16BDA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AE51885C90
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7F1DF27C;
	Mon, 20 Jan 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="h7rsvrRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD1A23;
	Mon, 20 Jan 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374205; cv=fail; b=B7//NhfDzCueoV28mbFBKGq+JIal2Mq9zGBTA8U3xMBbA5OmODc5/kPRyC0hwwi4Hn//9s4k6D9szGi4bLvh9Z3KOj8aCgdasEdvqSI75wwH2xIH0cppBxUSg9aLhboGhObhWv9eG3LqUI424wNnjviieA3hOQ83hXiF67v2BdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374205; c=relaxed/simple;
	bh=feS8u8QZ1P4z9eAZm9F7Y0QoUAJ2H4c3uUpnc57jl8A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KI4kHumGTf1XAoum5N8XB1FL7TV4CPgi8XSd9HdYHzgVL8Kv/mywDYtqi11RgQ1fUFmGKhP0FPlkYU0ZVAXeRkMDSojlDDntKPUtZrA51rbIuEPsWiCNxRFB2NMm4c1CmZxgZfaPMiP/oBbHIJ8goPq7y/QTKIenyKt/O4pa53Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=h7rsvrRR; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg2P/mT8slLdBJOxSLzJ2uD6NSgx5MZwh7zAdA37xnWkAmpy5WDiQDEBu8cmUf6OXKAunpXBE15MBgHkxPJiZm8poH6wspmc6KJkWqAcVS4Q5iBZNg6NWREAVtjXcDYnmbQ9eutYSEkK9q3U1/JhRgYJKp0lWdk+LsdGz537buoa9+XcgyZeebyGzmcUdTfQOxysNcWecy74QSvuZpX9UPHLoqgY2UZPKG2PZ7RIAgEP1qQqT0L5fSBKjiualUL8/MUhsx0juqNQC+9PV91X8VnBqCqPNlFxgmbi7iYnBiOOFTZzGBwk5hvH47DW+ruIWyboLSjf5S/IkVTrVezjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feS8u8QZ1P4z9eAZm9F7Y0QoUAJ2H4c3uUpnc57jl8A=;
 b=Ql0az0zVsg63yO4PL3Z6QSiuRYLGfyI6GEHCgVxOo6n16AiTGfLFMfl4SY4CUc7QXJXq08RLRQTtNChS7OyEvvScuS6mE5SoapWrsBLdiBnY7FQJqi4jY0eK4B3fy8ZoPb16yY1ZN8VNITshbhH+Ohoyocydm2RnulKI0WphYMolbzMcSAix3d6zmbuAxrNA0hYLZwpC1DXtvweNpvCXJcH/TijeeyavYfM5ESjyo8lyXnX10n2BFUvTSmVA79GWYkG1ey2y63QZeZlzT6PUVt1b0ID7ONQV1otT/FXAuTWB9Sd0IaKjLGHJyX01hrzVNF6jbkpSzwES+WrDewdjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feS8u8QZ1P4z9eAZm9F7Y0QoUAJ2H4c3uUpnc57jl8A=;
 b=h7rsvrRRoqN4hEikY2AthhlaIdP2qeuPWxUYqRktvhkk77p7mrY4JMC9Dghh++iDSwymb7ngQU04wDyc5kiiBH105zbbsMzIvg5c/3LdZeL0TO1NXbzOyXyFnLA2hVusRPJXC1kdEN5mmdlgk208Hk72t9MR0GET2B+Lmx/bmDTpzN6Yb9DS4CSq/9R0LaomtXhcrB6FLwFILBfW6DAQiqGiQ3DSs6lj8X8r66iyaY0rSh7qBQCvWyNjh9s5pArdzaEaC8ms4r1d4OIKXt2CPjOYMFbm14On7qTrdIq6EKZSJVXW93Smden0Q08QkH8WltxDH1aZFjdDxRd244hFBw==
Received: from MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:3e::12)
 by MAZPR01MB7199.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 11:56:38 +0000
Received: from MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8d8:4de:ff79:7668]) by MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8d8:4de:ff79:7668%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 11:56:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, "j@jannau.net"
	<j@jannau.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Orlando
 Chamberlain <orlandoch.dev@gmail.com>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [REGRESSION] Wi-Fi broken on Apple MacBook Pro with BCM4364 Chip
 starting from kernel 6.13
Thread-Topic: [REGRESSION] Wi-Fi broken on Apple MacBook Pro with BCM4364 Chip
 starting from kernel 6.13
Thread-Index: AQHbazJc1jubzydgJ0+JyWK4yov8iw==
Date: Mon, 20 Jan 2025 11:56:38 +0000
Message-ID: <B606F666-4A6F-44D9-B956-0B3E88E286E9@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA1PR01MB2555:EE_|MAZPR01MB7199:EE_
x-ms-office365-filtering-correlation-id: f389bc03-8631-441a-8e0c-08dd39497ef7
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|7092599003|8060799006|15080799006|8022599003|8062599003|461199028|440099028|10035399004|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ak8HszKiRvdc9F9Txynuh9Cy6ZowgG74dsQJp13XQ14GBV0fG3LdCVctc5QB?=
 =?us-ascii?Q?DiLUDonVBW2k1aeljZ9N+p+4MdGTqjwrIoCvVsIqfS8heHXa0tVHyqoAOrR3?=
 =?us-ascii?Q?cXr54ECZ3UeW5LAgH4Q7U5Vnjt3u8u0jDjId+ml92iVUJZcPpCSD4YCA6EXX?=
 =?us-ascii?Q?AikqcJQRPhfxvg5GjdUAvFy2JSXNBWGe64fg7PWeqYgpSAFgVll8TonMoDqX?=
 =?us-ascii?Q?6zb9NOm5CWLv99SD/Z8yl6Q2Djmy1NRjMR6fkGoEmXnTdY/9mbi+PC5LqkQt?=
 =?us-ascii?Q?6a1QrQasKq8DYWKfDrjcOE45HMOxXjVrpZkI/N3nBN5kA3WeVUu4XAJBtGSQ?=
 =?us-ascii?Q?j0SfCPBwzMOndwhpf4my7b7+gkaoPwkXEm+2/SKXhuIQllJkjYYz6l9rWnss?=
 =?us-ascii?Q?atGO9e+uHNqSR4p9O4COLHGga5TrYuLAm6OFpGtCvdvJORAcHT4PpRPDJ5kC?=
 =?us-ascii?Q?c3YhhMPYSYuOa0fny8hv4el6K20PGDJjs42QXsW2J0+s+PtsIPE5Ej7zzw2b?=
 =?us-ascii?Q?sP0hy72tB214w4uXxGuM5QbCDCBKaK+iCR8JtDVzxGBlD1dpAiu0Di/zIhkU?=
 =?us-ascii?Q?t44/DTQOhBnYlr2FJbhoqxNj8vZsKIjW3PrAqQqhrAf2M2LHODMuOm4GK0J4?=
 =?us-ascii?Q?1uTOrpC7/44Sy8MNu10opNrLsx8YzwaBUz8Wf6+LMEyay+An2tSFUN7sRX2M?=
 =?us-ascii?Q?n4us0UpPIHlSwCI+XuoLoqair3VCpoDlZkIk4U8rw5dACTNanJbb5o7t60z7?=
 =?us-ascii?Q?haUCWM53omCUhiu+waiibCVPHYzGPwR+8/9KRBRoefsnQT+ofbZc36algXS+?=
 =?us-ascii?Q?wiBSk+AGWfaLI3GivCVPM6/JnBAidYpYjwI+YwxIHgo+ITyY/5fSmk/ycPVO?=
 =?us-ascii?Q?gX/gPGtxAMjIHxQMyZROhj6B97jesag9pO3E7rNo1ffi5CJY5FalHeeLGSu6?=
 =?us-ascii?Q?dNlRtO3PVmg/n2s2FGI85j+MIv+bzTRdJ6/JOM9JmrniGhBDFxusDXUJa8dd?=
 =?us-ascii?Q?5DFKWj1aH2fSBhE/3a2LySIf+UE/jzglUvkCHQgwbsM+FB3TV9DDCxpeXpBl?=
 =?us-ascii?Q?mcaG6jDBm/py92UXlATpzTnFcSTxWSayVn0cm9qQHKD0gtjWkqJDHxY/tax+?=
 =?us-ascii?Q?jzK4nP9OLfYcdtUnwp9QhDoQjzH50nelFKZxxgGburehfVMlj+13258=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3TOrLgQxSwV2Pzg55AtbecGBKW0ThZpiLacVUhLxSrxDPxm5WoLNlc2CCW2+?=
 =?us-ascii?Q?zWdzA6xLxE5sqJ3PIYx5iWgDyMcwP4yqZOeGM5FhAqCUEZ+/B0wdoKcN8kO8?=
 =?us-ascii?Q?wZX0b6Jil+5GPNpvWLmE/bzMMMfpUeJN1ca6L8enpO9smFmvZUzt25Q+kiml?=
 =?us-ascii?Q?4wMJDdaGF3RdOiaUt0WVDlJS6iDonpXPvZgoDqGrYndFme0s2s13FKXvFYbs?=
 =?us-ascii?Q?H9sTETkZgVAzzpHU6wkDkUbaOiCcfeunNw/rjPUNvhUKIkHpZ/DixbdNYBk9?=
 =?us-ascii?Q?nEP/faJaRWemxS8mUG05R3VfjWCzrNqf0m8a79giJgrApd+9/0H3jj92Tk05?=
 =?us-ascii?Q?FhXdbzWfzFGsLTanBjzwu2JoHOrLCbLwmUbBucRAHD1As1Gd31DiXwhpynVV?=
 =?us-ascii?Q?Bk8pSQWXz822a1HB2EORf06D9inURdxgMFIeiniy7fCs49i9qMN+7QO1sBAA?=
 =?us-ascii?Q?XuLLyAXi825KbXYwWZWs7ia6moL5jf8zyUP9R5blOSHE6DYVB7bPIffV1HUF?=
 =?us-ascii?Q?BJQRxI+ZNSRNhI6WMqZ0MFT+yz/r4ztavEnxYahxgLoSWO7a9b8NQzHbMtwX?=
 =?us-ascii?Q?euTgF/dUpO9nXu7T7E7Ea/An2Tix2Ik9SZRy0PyWoKfDtahaMgTlAPQCvdbC?=
 =?us-ascii?Q?ftFg45FwT7LNsuvJe6QmkN6WFMvaW73YwuuLCK3OqCZ8zQLpouXlmectb0Gm?=
 =?us-ascii?Q?6OxLPqCVHbz6rIWeffr4XtjAyw5rkH5Pj2lWPLUtL1jHlSt4RgTk1ng5sVA3?=
 =?us-ascii?Q?MMghE2l3egbWyJyN1yKqlkmj0p2MYKXJuDYLnFihV11UI+jQPp75gikI5Akd?=
 =?us-ascii?Q?sQ+8yMf2aW4EO37erZsER95hDly9SAd1AJ7B6H1VHmOJX8cMciwUZ+XjtUnF?=
 =?us-ascii?Q?5oWRRbxpPxsyFxbE9Ovcokkhe68QZKUg9VF75hhOWiZvxLIMLQTMl//aKX78?=
 =?us-ascii?Q?E/7tJH3vMuoDRToVgAcCZpHVdr8iU09IegAeocXxChMaJjD8JgqBAKJesn0z?=
 =?us-ascii?Q?OXA/liEWk/c7dtoJ5HdwgwokiUNgv+nxrOmQL5HGle0NtAMqpzImx3hjvpI0?=
 =?us-ascii?Q?qv5EbGXZaVE8PcmavK2/tNUtJzCPewY2WxffglDNJhH8MAhW0ea3Sulz6TPF?=
 =?us-ascii?Q?G5tEnrtChcge2ZfSnLQTX7fPpvAVcS+rpnr/xbnlRlb2FEzz3MUiogkvANT7?=
 =?us-ascii?Q?65+AkLxuI4XSU33y1FofYdceJII81XLwf7FJCwibdmOBcwcE5ZHzR889sr6I?=
 =?us-ascii?Q?qBnvUxfjZJOT2ZT44twHhufYUzfSCwXhMincVHZLgNXXuWDTGbMJ+xS+k6LP?=
 =?us-ascii?Q?NP0wXnfefvfvOCN8CbXbjtjL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79EF6DC81969EC43B53FF91B818373EA@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f389bc03-8631-441a-8e0c-08dd39497ef7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 11:56:38.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7199

Starting from kernel 6.13, the wifi adapter is no longer recognised on kern=
el 6.13. Judging from the logs, it seems that the firmware is no longer bei=
ng recognised.

Some logs that might be useful:

Kernel config:

https://gist.githubusercontent.com/AdityaGarg8/4ade19da205266a2a8042fbfc078=
f75e/raw/bb4aa010daa8cff03e4a2202a8f23480cf168b77/config-6.13.0-1-t2-noble

journalctl -k :

https://gist.githubusercontent.com/AdityaGarg8/4ade19da205266a2a8042fbfc078=
f75e/raw/bb4aa010daa8cff03e4a2202a8f23480cf168b77/journalctl

ls /lib/firmware/brcm:

https://gist.githubusercontent.com/AdityaGarg8/4ade19da205266a2a8042fbfc078=
f75e/raw/bb4aa010daa8cff03e4a2202a8f23480cf168b77/firmware


I assume the Asahi Linux folks also have the issue.

Let me know if some other information is needed

Thanks
Aditya=

