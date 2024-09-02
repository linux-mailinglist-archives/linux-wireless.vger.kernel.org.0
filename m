Return-Path: <linux-wireless+bounces-12353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4696907A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 01:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0E8B2172A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 23:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025A18786D;
	Mon,  2 Sep 2024 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="eNGa+FHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020105.outbound.protection.outlook.com [52.101.69.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E517D377;
	Mon,  2 Sep 2024 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725320310; cv=fail; b=atlRc3LKrwkC7ybqnzU/7m9a/CvcKYKvTF5JKmv1HLzdecpNpkI2Iqtto40AdC4RdurmdKGWqn2KoVpCwNED8U2ewjkg77lDSDtxfA/7Yx6+k0L0fn27l+xXTWZC66Bq3koYt5vVEwohGfeNNezKwt+pGLyCRWdwYkefzBiS8rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725320310; c=relaxed/simple;
	bh=7hRJ/M5ykDk7F+LUiikIi00GMLcNWH570MuV/ICwFW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4Pb4KKG4nY0+CEQB5dX2hj/XAnMqiGuCF8xAHNlT3Urq/S1XWUPKpAO/VZ7rFBzQCQi1+B2C1J+K3A2RqUYj2NQYqrTm2Hhgo3LDXwiuwBAGPY4tEwFjDBkno2je5jD2kYaIkZ2k5j54NszQFvPCeSy0BEFfCUHDCa2BMpj/3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=eNGa+FHd; arc=fail smtp.client-ip=52.101.69.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQqO+z5V/5BdKWT57HpLL2KzSrLMpl1nRqaUwrJ1x+98bRwzxsNtkweJmvTOj5sPtJl/xcIymjC9fqHC2STX3jRKpN12Z9ZHsQ9MdHUi0YcpSQgF2ey3IxFLE6x/AVeWNPrhyTm//beoo7lKkuasr39GcEBo7sRxyeOKwbdrlgen+5ji0TcHo/eQap0nxpym4o1j7j7XDSt/g1i7pDcKADRdmIwvSYRMLY/HHv4EwE+UXAQSRGFlNxFYH7gvru4R7LO5iCW3MeuoERthqSaYqFO/BxUsnXMaotUcWmQIDy1ZxTYN+Hwu1lOyULo6KJi7ZIisrPSLvM2lCThg3L3JGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hRJ/M5ykDk7F+LUiikIi00GMLcNWH570MuV/ICwFW8=;
 b=Gu54S+YfSrTrKF/D/3j3K9duB0fAvt8Tj6dowTXRlJPOotuhB9JPCqDibEZNj4w0vfkwtpGX2HUADveuMaexf8ZicHy8ZpZIevqv1uk01Mi7ZoM6LMY8CLzoSzSrUvDfF4lyQEqNCRrxItWFaJ0oimq8M8e1nczlNMR2eb6lT2UcgNY+RCMPH2AdZRbMNhy1ykzUbw7QBOEq+R4T7wpcqS+4RWuGU396erXT+FFMFWOYPmXPtrpMsRQqpqNq24NQfeDZa3Cj6PCquE5HJGBeq1zCIVble5Rvf5oUpdER3MIMkJVw9ZtXyOQFBIiDdsTWwR9f3JaQZdevAj8BhYmyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hRJ/M5ykDk7F+LUiikIi00GMLcNWH570MuV/ICwFW8=;
 b=eNGa+FHdRZdkO0jJdD9rBipCEfBViLwgXnr2vImAFSLZQjTkMG0VNUDd3nNOARcLIgZpriVjsVDWzCxqZTRT1VQDstYkmTZeRrzlT3urA1LPb0PV1pEZn1+s6V5TdAumd3IWKvCYBl78wNjn+KWAWXqRosM+wpfyTcelAW+PmIA=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS4PR03MB8700.eurprd03.prod.outlook.com (2603:10a6:20b:58f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 23:38:26 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 23:38:26 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"nico@fluxnic.net" <nico@fluxnic.net>, "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "saravanak@google.com"
	<saravanak@google.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] net: dsa: realtek: rtl8366rb: Make use of
 irq_get_trigger_type()
Thread-Topic: [PATCH v1 3/7] net: dsa: realtek: rtl8366rb: Make use of
 irq_get_trigger_type()
Thread-Index: AQHa/YtBP9An+qjVMEunKFUX+bdQ2bJFJ1MA
Date: Mon, 2 Sep 2024 23:38:26 +0000
Message-ID: <cdqdaiqccyynr44635d43srvsampqktvttolvlfkli23mubri7@tjyvui25hepl>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-4-vassilisamir@gmail.com>
In-Reply-To: <20240902225534.130383-4-vassilisamir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS4PR03MB8700:EE_
x-ms-office365-filtering-correlation-id: f7002979-bf89-4655-4a39-08dccba85794
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzZuWmY5eFoyT3F5RGkvOGZHNVprQ0JzbHVtbHpqLy9DWURJZ0d2SHlVQ0FE?=
 =?utf-8?B?cFlwd1hSbis4aXpsQVpwTEN4c1ZQYkQvdGNWZ0hFenFhZzN1bXBoOE5rYXAz?=
 =?utf-8?B?aXVMc0pQTGhvUUc0TWdna1h4Z2VMSFlVTklJYlZsUmFWNVhQaThKQlFMOFdS?=
 =?utf-8?B?RU13Z2FUZ0FBTTdiQ2NKeU1ENytKN0Q0US9RRUFSNE1JQmV6bTRDSnVEOG1w?=
 =?utf-8?B?czZvSC9rVzh6R0lHd2V2N3hxUC9YM0gwM3pDL2Zud1p0VnB6ZkFXKzhMRnhL?=
 =?utf-8?B?YnFyeTRSTTNvb2U2SUZlMXo2ekZTOEFNc0JVclRyVzc3aWdGRFZnRmxPOFR6?=
 =?utf-8?B?RGRKcGxpRjF1S0t3VW1vVUJMNW83NkFCcXZYM2ZvemI5YVhPNmJxUVRwVzFl?=
 =?utf-8?B?ZWJpSGdBZzJvSGRhbWcxZXh0a1ZxdzN3djhGSEhwMzhMUlB6T0xRNi95WHhU?=
 =?utf-8?B?eTBXS3E1bkExMkFWMm83U3lyQ1piVWJiN0tVNkZXSkFlcWNWOUVRL1l3VXVG?=
 =?utf-8?B?VitvMzN6bTF0ZWc1aGhsVDZRZ1NaVG5CMWc1L0QvZGZPRVhlNjA4K1R1RmZy?=
 =?utf-8?B?NnJEQ2ZPYXlXWlRLNnkzTTFUQ05XakVQOTdxbUVFTG1samx6RTcyUGNDWHhM?=
 =?utf-8?B?ai9paHB5VnQyb3V6cWJVVndYZVZUL2lDZXRYZ3IveDZPRFhocXdaQ3F3c2Ir?=
 =?utf-8?B?TkxRK1k4K3JMN1Y5WmNLQXphOUJGVGJseW4rYjNWTWJmVGhvSXNkdFgwaDBV?=
 =?utf-8?B?cFVpZG1CeTdHVkVEK1RuNDl4Z0g2NzlqY2hNbnhkZE1lLzdCcEd3VUVBQXRR?=
 =?utf-8?B?VE5WRm9ZRHlLSlFqOHVOOTREYWlXZTB1cDVnTUJGUWVtSU5ueWRsL3I0YkFR?=
 =?utf-8?B?QlhMNVFGOS9lS3ZYMEhtdUZmZEluRVIxS1ZYSGkyRmhxaDhybzVYbUJuQWs0?=
 =?utf-8?B?ZTZUNVJ6WkJVSU5TTi9ic0xrOXVHc0Y2TWRnNi94WmtkRDBTVy9uemxveWRq?=
 =?utf-8?B?a3hLRUVDWXR4aHI3UG1RenJaVUcybEhIUVFkUCtmRlpDcVM1T0xpVThBZ2hn?=
 =?utf-8?B?UVJwdURXWXB1bWphL0N0RDdLRXJKb2lxTy9WU3ZmOHZnMTNSU2pQaWhMV3Qy?=
 =?utf-8?B?Zi9TcFNmbnZydW9NZnpkTXVaVHZaTkVLSjBjUG8rYzFXSFd1bERwNUZUSXZV?=
 =?utf-8?B?V091TXVmUjlZZTA1NkRKT1RUSzlZV1AxbDNIcEFlVGNKQ2lvbmNpOCt3bktK?=
 =?utf-8?B?OWFlVlUydDBvMktaUHQvQzRadWp1aHBqdjQzSWdOYXRMMG1QTHVhNSt0bG44?=
 =?utf-8?B?NVEwb3A1QWNvR1JwVE40YW85M1NyOG9rejk0MnhsOUwxYnNsWE94ZDJzV0FT?=
 =?utf-8?B?UHJRUlhaRGJScDNoaHFRR0lQTFlMMGpPekpmblRiaUdVQzMrNXp0QnRIODRF?=
 =?utf-8?B?OHFYOW5iVGphb0U3ZjhieDVRZ2VmMmx4cTE1VlllYVlkK2xUeS9YVzZ3Ty9C?=
 =?utf-8?B?aDJ1czFiUFIwWjArQkZCaGxSajkrM25yNzVGTmZYQk9USDZhOXppbGFaNzdH?=
 =?utf-8?B?WDVDS0xMWVhyWFltMVQxR0N6K0pNSmhHZ2w2UnNJeWZ2R2xZOW43WWJDTWVz?=
 =?utf-8?B?SjJneDJpWTEydm9TdkRCUVNVWnZ3NVh5N3pZeWVNbnhXV3pNbE40VmRyOURR?=
 =?utf-8?B?VUFmZmpiWDJ4SjVPQ1B4Z3VkcEY2RlFYMU5FNitIdE9VRGpNbG1OWDk1ZFBa?=
 =?utf-8?B?R2VXeDRSNkZGRk5UL2FrK2NZZGpUMU1SdzlWLzlnN1dVbjR3SXhBbmhQT0Va?=
 =?utf-8?B?eW5PNDlMRnl2dXUwTDBzWnlxSkdac0syMTIyWElwUHhTRDZqVEhtSE04MXBI?=
 =?utf-8?B?Mm1XRnBRWmVIbFo0OTNEemxMdTh5UDNrTVNFOWo1cmV5aGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHlmZ0N2YkFoUTc0ekZvQUVjdTA4bit4elBZMHp2cTRuSmtqcDEvVld4V29H?=
 =?utf-8?B?Nk14UGJvUnZicm9wRkRwWXpqWXd3YmpOR0hMUGxrNnlJb05LcnBXM3JEOFhx?=
 =?utf-8?B?ZHdXTDMzR3NzZmdyREpxSjdzUWxwKzBKeXo4WUEwbGwzTkFZdHg0Q1hJNW9V?=
 =?utf-8?B?Zmlwc1JmZXhoQ0UwbnIzTWYwR3VEbXF1REo2OHR4WjNSM0xpL2YxN0FEa3Q4?=
 =?utf-8?B?MDJDUTV4bXkvSmIrRTg4Y1BCRjNUeGFZTzFvZHJCUE01S0p6c0JwazhXSmlW?=
 =?utf-8?B?VmkvaXNFaHJjRSt6WHJndStzQlJ3MlhrSml0OEYyOTlDczhMaDNvMUtlTzBR?=
 =?utf-8?B?TXZDdHROVGVobFVXQ1lxUUZjMzFweERNbjI1eCtjeldTOG9uZWEzRHFYYjdK?=
 =?utf-8?B?aGRXdHZkV05IMnBXWi9RNGFDc2VNK1UvN2pLblVvWDB6cVYrKzl5QmF1NW5q?=
 =?utf-8?B?WUR2dFhYd1RBZ1gwelgvR1o4bzJib2lyTk12Z29zRHRFRS9NR1hTQ1ZsQ3lC?=
 =?utf-8?B?U1dEcStEdWdyZXR6dGxRZGoyTDVYQjRaNk5pemJiTzFVaXJoNTVva0pjTjR6?=
 =?utf-8?B?MzlReEMvanNmNlVIYnVTakNUNkREZFhpaE5yRHlzNjJzUTBoeEphdkNORmRX?=
 =?utf-8?B?VGZ4WHlJazdxWkxqdjBDUzdnOFArU1A2eW5KbGpiUDlvMWxnUnZydlZSWUdR?=
 =?utf-8?B?RFBsdUo4ZGI2QzVpMExTVkUxYW82QWJHeXVqNXRDdUhPY01jSlhHNERFK0Jt?=
 =?utf-8?B?TDhmQjY4OS91OFkrM2libVhHdGl3aE5QbHJlOTJ2SGdFUCtDMFJDb0xKSW92?=
 =?utf-8?B?c010UENRVGV2U3Rubm5aK2wyUFhYZGdHNFNSUmdwZFhzb3pSUm9aR2xrcjJq?=
 =?utf-8?B?YWJOVlZ3Z2FLVGc4Yk11V0ZFN2NVMWk1SUlmSkcvL0cwMmN1cGJVd2lnc3dr?=
 =?utf-8?B?TkhRZ1Zia09Mc25mMzhmdUVSRlRUTDdFYUxVUzN0UFo5eW9HQXJuQi9NMGdi?=
 =?utf-8?B?SWw5cGFvTmdVZ0MzN1ZqTkZEcFZGTmJuWlRRR1RQNnROeUZqdVFJOU9iTVBr?=
 =?utf-8?B?aU4raFI4VUxLZGZnekQ2Zk9LYTJoblNnOTd6QU1CT2JqcWtPQmhBbjZNMnJV?=
 =?utf-8?B?UTVkWE1BWFJCcDljYWlpVjVyeUFNMExwY3h4SlhqOTdleWx5cWtlc3pzRGtv?=
 =?utf-8?B?bTJ0TStPYm9hN01pUzl3Zk91dVJTd1NxMkxlS3hxNnpZbFo4QVhWMzN5Mmx6?=
 =?utf-8?B?NWw5YWxWRDRvS0doSHNibDg0RjZPU29ldFdhUjNpN2l0UzY2WUwweFZoSzFO?=
 =?utf-8?B?VTVmSmJtVytzMUdEd2xCSnlTWEpuQUFuSHpyeFVEYW9sUXVkQXRjaUgyMnpl?=
 =?utf-8?B?UnVKRVlsS29xampEWGJXSXRlNzNteUZSTTNGSHJoUXMza2x2T0tWaDRvQThr?=
 =?utf-8?B?ejNJaWNYdDd0SEhuTGZiVzZncktSZHNhY2gyM0s0ODJ1MnBQaGJNcy9XM3VJ?=
 =?utf-8?B?ZFJid2ZsTFhhRDJZbktBVTFHbFJZUnhaWHJPU052K0VqY3dLdTFCWVJOS0FO?=
 =?utf-8?B?ZjRqK1ZjZTdIelZZOXAzZFZXSlh0TEZmM2NMSHgzc1piNHFhVUhXMmZ6OU5P?=
 =?utf-8?B?SWtjc2FpV3dRcDJrYXBLeDU3d2FJek81UGE0S0xhZVo3QUFoWTAyVUlVb3Ba?=
 =?utf-8?B?QnlIR1hpT0lOaDFFYWFRQ2RtekJUUlVFdk5ickNHK3FiNlFmY2E4Tlh1YkpQ?=
 =?utf-8?B?S0UwcENDOGduMGJ5WnJJV3MzV3dxUTNoaTNTYlZ1SDJzcVZCZ0RoVHVrTVQv?=
 =?utf-8?B?NXB5SUl0dTZjdm4yNDd4RnJDRHBJN0ZTQ003OWl0bG9kYkVqaCtIajl1WXZL?=
 =?utf-8?B?SVYzak4wUHZodWhFRHN4dU1LMXljWlpvY0FHaUxqbGlhNkpCeXFYZVg1V0ZE?=
 =?utf-8?B?NkFFdFRMcHgvNm03VlZhUjNkN05CQkh5czRvakYxWXJrMER4QWdSZGhmTVJD?=
 =?utf-8?B?ZzZ5RVJhVFF6WWhvSGVTWUpjclZrWW1adUZYTW1SWHBpd1N3S1ZaS3NHQXJs?=
 =?utf-8?B?M3JaYm44d05rN016Tm9ZVDA4elc0bk5JZmk0SXZLdmtMN05JMnJNaTRmTTNm?=
 =?utf-8?Q?vhJX0IPfkJgwz7c3J8+lFeQcw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38BE3FF8FDFDA54FB5087CAC9E41BF8C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7002979-bf89-4655-4a39-08dccba85794
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 23:38:26.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpIyOTwbG3UrF1jP2RbxyUqOuX6kgbDMsiV/oQrD9J4d1sx6O7CcVmihjQI1IxoQ9wlOh2m/Q7WUCZLD1XYtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8700

T24gVHVlLCBTZXAgMDMsIDIwMjQgYXQgMTI6NTU6MzBBTSBHTVQsIFZhc2lsZWlvcyBBbW9pcmlk
aXMgd3JvdGU6DQo+IENvbnZlcnQgaXJxZF9nZXRfdHJpZ2dlcl90eXBlKGlycV9nZXRfaXJxX2Rh
dGEoaXJxKSkgY2FzZXMgdG8gdGhlIG1vcmUNCj4gc2ltcGxlIGlycV9nZXRfdHJpZ2dlcl90eXBl
KGlycSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWYXNpbGVpb3MgQW1vaXJpZGlzIDx2YXNzaWxp
c2FtaXJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgz
NjZyYi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4u
ZGs+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4MzY2
cmIuYyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjZyYi5jDQo+IGluZGV4IDllODIx
YjQyZTVmMy4uZTQ5Y2ZkZmI4NWNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvcmVh
bHRlay9ydGw4MzY2cmIuYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4MzY2
cmIuYw0KPiBAQCAtNTk5LDcgKzU5OSw3IEBAIHN0YXRpYyBpbnQgcnRsODM2NnJiX3NldHVwX2Nh
c2NhZGVkX2lycShzdHJ1Y3QgcmVhbHRla19wcml2ICpwcml2KQ0KPiAgCX0NCj4gIA0KPiAgCS8q
IEZldGNoIElSUSBlZGdlIGluZm9ybWF0aW9uIGZyb20gdGhlIGRlc2NyaXB0b3IgKi8NCj4gLQlp
cnFfdHJpZyA9IGlycWRfZ2V0X3RyaWdnZXJfdHlwZShpcnFfZ2V0X2lycV9kYXRhKGlycSkpOw0K
PiArCWlycV90cmlnID0gaXJxX2dldF90cmlnZ2VyX3R5cGUoaXJxKTsNCj4gIAlzd2l0Y2ggKGly
cV90cmlnKSB7DQo+ICAJY2FzZSBJUlFGX1RSSUdHRVJfUklTSU5HOg0KPiAgCWNhc2UgSVJRRl9U
UklHR0VSX0hJR0g6DQo+IC0tIA0KPiAyLjI1LjENCj4=

