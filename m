Return-Path: <linux-wireless+bounces-17573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C1A12D99
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 22:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE07C7A040F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A11D6DB9;
	Wed, 15 Jan 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vPPSwcWy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AA14B959
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975990; cv=fail; b=bXglTfyUjoN9QCHJ65asUpZnHWQlG4knHgv6Xl2310wkCCGlbbGcm9bxsr9yrwFymMZI6lDrzNly8Kh2pKFm4yfp/UVlJdrNiVdv1tKT1THtFBrM6JkeFSf44Nt/DzYWc97z3W4BOf4IjNscLhy6BszphBdgpTriIZYJT6MLylk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975990; c=relaxed/simple;
	bh=nXy/5hQ/Ujq3SwRRXZkXKNexDr/0iqi3SRXjhkYWoqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nuZOABGbYnZrl4jNSmvYZIpQ5wORKPFt+DCZfB45lr2a5l/+2JPNHVzz5uXcNw/mUfxfJKKvgqAU8VPiF9gkkjhNv42nB8wRmeEsRA4JV/XXrHPrdEVQ6vqoeRvbDnexjvbOd/VFhUAaAXgH3G1J/SF849SjVsKTgvokreVlBWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vPPSwcWy; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok+RAhbLpKQQysnUl8Agg/Y7cDP0j0kL239fcf9vVIjp1PpNdTmUx8W0kX/i6zfcN6Vx+itimjYVXe4zz2icqlGht+qFrXo8SOnkrbtifQljYux4zichAwjpuRK95pic0uSspXWwQ4fFSjb4VjENLZoEjFU2YPcQ0UZyutmO5BjUuVi6BkqjqSLPhAy8hs0Z2tX9i+VfK0RGxuPv78uU/bJLiSO/roDK2xX+KYY2eZEbGfA6CoyXqUIfXwPrYgXWtQ09KruLFkQsXYRSqmlOClS22LJQ+ifwWbf4lxoWh4ImbiVvZ8XFM9y6u+/FjDVn9Ik1BfVZZ75oSCOynN6jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXy/5hQ/Ujq3SwRRXZkXKNexDr/0iqi3SRXjhkYWoqg=;
 b=kwbljSrD+Qs9Vyc4lxg/ggBourRlmrrEjtkCkq1dPjbrSXzSuAuqJB6/vaKH53rVmZId4yaSAEdu9m85blg3TJ4mG14olqnD5up1D/RRPW6ro3AiKK9BWwNxSSwFjtu2zad1cK14osij7GLASOGy+KcMOiSBODTFobPJAxwCwqjqLsGetU0ESO4fVWQtCeb/C6QrYwnYGF9XNThaXVFFA90ivNze5DFsDXHX1Hlh9et2tLiOVp3H9Ah23wysf0aeIn3ive/dihxdUXjk9U93LtO+nZfYoO8lMDIAaxH0zUXPfxz+Xcy4iibH/Jhrf9IuIBzq0lF2ffla8HftLB4COg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXy/5hQ/Ujq3SwRRXZkXKNexDr/0iqi3SRXjhkYWoqg=;
 b=vPPSwcWyn7ERoUCt2hUhwJSVvTdqcsnlhCQsTgkUVMpAPbHBFlqlpB2z8nXJJ8qricncFAPEOzDewVQPe8tI47tY9PLkH2L1D+LnJjxiqG37JvXmmc3kJCqg9s94V1GXRVoipObMAMFKclvDQ22W2Y16w8zZ5EsAj9+mPrEpS3sxVs0P0Zt6IKQ1Y1fEp3qy6zaYLY4ln8LcnxSBb8TW6B6OLSc5FuWoDx+uJS6ch4wpzBv4xvsxASPKuEwoM08FpNkAf1b3Dd27T8ClryURCjjcbMyUaMM/h21zKYnIwuPhQaphYatfWPJOTdS78JtkIL4WL+kFrvpTqQFiTcG5Hg==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 15 Jan
 2025 21:19:45 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 21:19:45 +0000
From: <Ajay.Kathat@microchip.com>
To: <marex@denx.de>, <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
	<alexis.lothore@bootlin.com>, <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Thread-Topic: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Thread-Index: AQHbZ3GKYuBJrtYZzkyipv/0jszdjrMYMScAgAAmWgA=
Date: Wed, 15 Jan 2025 21:19:45 +0000
Message-ID: <798971cb-0c4c-4e5c-9e90-2488edca49a7@microchip.com>
References: <20250115171751.7308-1-ajay.kathat@microchip.com>
 <b558af8a-a72b-4568-8ed7-5be22105a5c6@denx.de>
In-Reply-To: <b558af8a-a72b-4568-8ed7-5be22105a5c6@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SA2PR11MB4873:EE_
x-ms-office365-filtering-correlation-id: 0d96b6d1-37f9-44e1-91f4-08dd35aa55c4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cndxOGs0ejVqbDNsK1pTcmVOTWh0d0p2bnpQbE5SVzRaOW8zWUJ1eCtQY2VR?=
 =?utf-8?B?WGxXRE5jZE1UUlNiMWFZZUs2ZE9jYWR5VXpvY0poVDJJZFVXaFk1VzlVcFRG?=
 =?utf-8?B?QVhxemNOMHdCOVhZd2dpcXZBc1J3Q3JEbjNRQmdBaTVYRlc0R2ZocCt3UGNy?=
 =?utf-8?B?S1ZJblBTZUxObmd2bTJubkpiVC9VYXFicGFBazlWYWZjZTZLNzAyNmMrN3dN?=
 =?utf-8?B?dENIT29oRUlYVUI2aUx0WGlMTmR6MmRDVGoxVFRoelAyZThjWVNDM1huMVpP?=
 =?utf-8?B?WTUrWm0wdEZmYzBUM0JzQSt1V2xxSDc5K1BGTWQxSzdVZjh1dk5uUE1WdHJs?=
 =?utf-8?B?RlBwUzBlK3J3eXVlZG4xVTJyL29SWkpQazRmTGhxWVUyTzQ2YVdNdUdPbnRm?=
 =?utf-8?B?VjltTVVaVmt4aENUSS9wQXd1NFR0M0pFWmpVSjRHQzlPdHU0TmQxblBwSkV3?=
 =?utf-8?B?QnRBSi9pSExWYkFEa3JnanlHbllyV0ZzOGw2UDJ3YW8ra2VpM0ZCWGRpYXR4?=
 =?utf-8?B?K1E4WG5kWVpRNTQ2UkdvUS9md280dnBuTTBSRmxxNm5PTXVGbGM0SEdTV1Fr?=
 =?utf-8?B?aGc3bldxOStQWXFKMVB0ZTdvcFlUcStTWG8zeTkvOTg0Vy94cVZIbjUxbjdt?=
 =?utf-8?B?aHl1Q2JBS0dUWWJKSUcwMitMOVc2a1prZzJha2F0UldvSExnYzg1QTRDc2sy?=
 =?utf-8?B?NGhSK25JVWtHbXRoTjFmcFc2RUVwQi9GcHFwVjZSRlVaVmxNODFWbytCWDhE?=
 =?utf-8?B?MndGL1dkWUc5MzlqMnpRQXcxaVU0TkdySWY0OXlJNEhJeGozN3B2Qml2S0FF?=
 =?utf-8?B?alV4ZXVwb0lNemV5eWQ2Vjg3ZWRvNml0Z0IrNFphK2g4Szd1YTAySnNMN3dB?=
 =?utf-8?B?cXZJL1Z3VU5lZkFCd0hYVnN1UmVUNWZ0NDdQZXUrVDI5MEVlTVp0cGpmQk5S?=
 =?utf-8?B?L2NtSC9sZTNpTHpBK25DbExNRHYzU28vS0V2V3VsNWZYcGd1SkU5OWZiYVFn?=
 =?utf-8?B?N1NLeG9qRXhvQ05XWGo4SGtkZzVkMkNWajMwUHVWZWpGZktxdVFYbWFWdVhO?=
 =?utf-8?B?eC9sZDQwQTN0R0ovRzBnV3d5K3dSU2tkTjU3aElnYmlwelpxTjJzalh5ZTlX?=
 =?utf-8?B?dlgzZ3lkTWVtaUVwOU9NOTRlMHlHaWFQZEtKWmZ6NS9oUDRlRnRSZE9VUVVl?=
 =?utf-8?B?YUtXaUpnc1J0YzVmTmRNNzFZMjNLMlZxYTZRNEFDS2xMWWlWTEREdHN5cEJj?=
 =?utf-8?B?dmpLdnozVUZ4cy9zMUdkelBwbjFTbk1Fd0dlMm1uZVhzNjJRRm1xQTJLems2?=
 =?utf-8?B?c2ZaTWQ4VUxqekF1WWhHS0E5OHJJRFpWdmRWZFRueHpwRGxwNjM5RkdkYzdO?=
 =?utf-8?B?aEQrWjBNWFd2OFNYMVFGYmxYYjl3UkRFcUYzUVNFSU14N05Ka1VOZ3hLanNr?=
 =?utf-8?B?QWxVb215dG9UZ3pjNWRGeXlyUnJVWHBGOW1pcTV1ZmpiMlVlbDRVSFRqVDNp?=
 =?utf-8?B?Ui9HNVBtMnFWTnlTd3htazNiMEU3QkFXUklOS1VpSEJDUWVBTlp0L3l3NW4w?=
 =?utf-8?B?SG9GRlpRYnlTa0krajIyZ01CcDdZUDlLajQ2Qm1mT1JvaEN5dElHZzZIK2pJ?=
 =?utf-8?B?WC9VWkxSYXo5WkF2SzNpNHlLWUtGWkZuT1lNdlZCa3ZVVXh4K1ZvTDM2UVhW?=
 =?utf-8?B?VGp2TSs1ZU1YanplRDRiaUVIdm9sdXNXWWt6MDc1dS9LcW01TEFFNURmbTRN?=
 =?utf-8?B?ZUNZeERVM1cwekNpLzdaa0hiZ2J5RG9WV3VmTG85RmpaQUdaSkNCYkI4ckxM?=
 =?utf-8?B?REJIL3dvR2dPOTlic2Q1eTZhdXFkc0xPWm5hR2tpZllJdjJwWGpnZGtYbWdv?=
 =?utf-8?B?Qk1wdXBodjdqdEw0blZTbkhzNDZRRnBQVlNXQUVIa0pvbHc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3UyYUY2M2t2S3BKNUdGWElPZkhHUFB5L0ZrRFdVWFZMV2pnMjQyODN5TXR1?=
 =?utf-8?B?TE9RSHBlK2VOaHV2bTZDem5wNFNTNnFtZGhvYjM1UUhXc0p5UnVyamVuWG5s?=
 =?utf-8?B?L25JWVBSZlZmVGlBZSt4YzJQVlB4QU1EMTVkTi9EclIrK1Z2cWFMRXQrNGxt?=
 =?utf-8?B?c2ZoT3dCN3JZL2trcmRBSmpmTDdibnJ4NlNrT2J5OExrOFN3ODJNVU1TRDF0?=
 =?utf-8?B?N1BPVWRPb1ZPb0lVaHZiQVppclR0dllTakg2WlRxNjE2ZmtXbDU3bmQ3Tlk0?=
 =?utf-8?B?Z2ExaWoyN2xNYWVQVHBNV1lYUnNWazRHaFNpSVpnTlQ1NFhUVGFWODVYcTNE?=
 =?utf-8?B?M3hoWHB3QzFJOEVhWlRmYnVkSkFMam5oSjZ6Qm1aTHlSOU5EdTR0d1RmYWx1?=
 =?utf-8?B?VDRPNHl6ZWMwNkVGam45VTVTTk5iWjM0T0d4S1BFcy92Q0NNVjdqUkcza0RY?=
 =?utf-8?B?ankzblJhSzlFTmd0L3ZMVTZ0YmlZZWcvQkppVUcwY1MwNVJvVVJiN1VkRGg3?=
 =?utf-8?B?bzhnb2tFa01obkxvajlZYzE0MGZ3M0lGSTBSOHo2U2xXYXBDL0VldkwvZzJj?=
 =?utf-8?B?aFMzek9KTUdoSDN2TVFkT0Y4WlVaUGdJME9QMmY1WnlQaVlqN2M1TTM2eW5q?=
 =?utf-8?B?MGd6bUQyKzRnUERra0lHTzRkZ25tYUpNN3VCZ0tVZ3k2OXVrcmNua1F3eWNN?=
 =?utf-8?B?R0JMMjQ0QVBtOTUyRnpnVjBCWkhDOXZEMkZZcmlQeU43WUZMWlcwczE0ZlIv?=
 =?utf-8?B?N0xPcEhWQ0lkelpVQlB3c0Z3WnBQekNIek54UTFra0dkc2M2RGtZb1MwZmU0?=
 =?utf-8?B?THpWaWJ6Qk4rMkhaRWlYT0lSRDM3aUpwSHJEeFFBakZLUlNXa3NEVjdBb21C?=
 =?utf-8?B?S1NyM3l5aXNMSzczR25tcWRTMlNVbnJCbEFmYVRIZ2FPQ3cvU2lheVVGMFFG?=
 =?utf-8?B?QUZDYjBVUFFCSHhyMnRmQzVrQ1VRKzhJa1ZyOUxIbDU3RDBQck9jaE1EUDRG?=
 =?utf-8?B?dFFJbEhFYkVsZUpYeXVNeU1zZUVCbXBOSWsxSkhVV2YwZkNZeGxHemkzQmI5?=
 =?utf-8?B?T2xSTzRiTitBb3I0OWxYak9CMTl5OVJUMWFkV05rQ21wMDB6QjJxUmw2NUdN?=
 =?utf-8?B?Q3EwcmpYUUI3eWhrQnJpV2NOQmNNUGp1bEd2YTBtdUtWeENmK3ZzYklTK3la?=
 =?utf-8?B?MUh1ZzlPRnNwNzVoWGZ1c052UTZVcnNESXdNRVdkbjM1S0xKanh5VStUVnRo?=
 =?utf-8?B?TjZNdkdDRk9mU2VSRjVtbG9KWUdGWDhKYWJURVhlNzQvZ2V3Q1pJNmVLUDhi?=
 =?utf-8?B?UmRHeWZ5N1ZiNERiRUpuajJ0clNxbFRNOGZzWTZOa3BjdFZ5MDBKcEFFTHlS?=
 =?utf-8?B?cExERGxOK0pXTDgxdytWWVhxWHREazNUV2FsblUwR0U0Rkt1ZWZCVk0ybEts?=
 =?utf-8?B?WXo1dVV3bU5FSDVsb0YrM3lkRC9sNS9naURucW9iOUlLZjdDTjZGRG9QQktv?=
 =?utf-8?B?WGVONzVDajUxOG9mSGx2bTRWQjg4aXNzWm5LY1p2OU9Qd1h5UjhMWkx2bWNp?=
 =?utf-8?B?ai93YnNzRlhBd2N0eUdOVmlkTGZGbkFEWjVCczhsWExvVjdBZVF0MUFUcGNY?=
 =?utf-8?B?LytlYVZWVWtSaXhVUTQvYlhxaXdaUURqZ1l1c2ZRNGZRNm5ySi80Ui9NS2Jo?=
 =?utf-8?B?alg3WXZOK0M3VzhsNEZCUVRKTjY2alBQaUNJWnpiZVVWSjRrT1pnV2pWSDla?=
 =?utf-8?B?VFpaWXNBRm4weFVkWDRNWkhwM3JEWjFBMTBSc3Q2bUc4VDJaSk9vMVluRkJj?=
 =?utf-8?B?eFdEYStwVHJrUUJlWnJDc1BtUkc0a3cwZmhtSUd5NVNZMFhiZkRrUHB5UjFZ?=
 =?utf-8?B?SC9NU1B0ZEdiMWpvQXhOTnBRV0NCUnNwbWF0eWM4VG00OWtQRUdiOVRvWC8v?=
 =?utf-8?B?dllRb1ltQXhTUHh4aW12MnlQQUtqaU9VdE1MQmVZMWY3enRydE5Td1NGQVU3?=
 =?utf-8?B?VkRoQjVIUGVuV0VSMlpaYW9JZW1rVHdQaVZYaXVSWW11TTNNWEtodDRtdWJq?=
 =?utf-8?B?cVJBc3FTd3F3RGZmdjc1YkJwbVpOcjkxd2xzeTFGWXJzcGN2aXVncjBjOG4r?=
 =?utf-8?Q?C26RBk82gRW3IXy5591Z3epYO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB727CE1430D5747B77283AEABBC734C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d96b6d1-37f9-44e1-91f4-08dd35aa55c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 21:19:45.5797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygR6K5WfSDn1XfSHlaLy2wqvhQ3B4uZeZdx2YRe73vEwUkG10soFrtiMZ7ktPpAPNXgBSLPVoAtbibUIQhbipzuzhtkvnGF7TfnYdmep/qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873

T24gMS8xNS8yNSAxMjowMiwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4g
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMS8xNS8yNSA2OjE4IFBNLCBBamF5LkthdGhh
dEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gVGhpcyBjb21taXQgYWRkcyBXTEFOIGZpcm13YXJl
IGZvciB3aWxjMzAwMCB3aGljaCBpcyBzdXBwb3J0ZWQgaW4NCj4+IG1haW5saW5lDQo+PiBMaW51
eCB3aXRoIGNvbW1pdCBbMV0uDQo+Pg0KPj4gRlcgdmVyc2lvbjogMTYuMS4yDQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9saW51eDR3aWxjL2Zpcm13YXJlLmdpdA0KPiANCj4gY29udGFpbmVycyBmaXJt
d2FyZSB2MTYuMyAsIHdoeSBhZGQgdGhpcyBvbGQgZmlybXdhcmUgdjE2LjEgaGVyZSA/DQoNCndp
bGMxMDAwIGFuZCB3aWxjMzAwMCBmb2xsb3cgdGhlIHNhbWUgdmVyc2lvbiBudW1iZXJpbmcuIFNp
bmNlLCB3aWxjMzAwMA0KZmlybXdhcmUgaXMgZ2V0dGluZyBhZGRlZCBmb3IgdGhlIGZpcnN0IHRp
bWUsIEkgdGhvdWdodCB0byBpbmNsdWRlIHRoZQ0KY29ycmVzcG9uZGluZyB3aWxjMzAwMCBmaXJt
d2FyZSB2ZXJzaW9uLHdoaWNoIGlzIHYxNi4xLjIsIGluIHRoaXMgY29tbWl0Lg0KR29pbmcgZm9y
d2FyZCwgYm90aCB0aGVzZSBmaXJtd2FyZSB3aWxsIGJlIHVwZ3JhZGVkIHdpdGggYSBzaW5nbGUg
cGF0Y2guDQpPbmNlIHRoaXMgcGF0Y2ggaXMgYXBwbGllZCwgSSB3aWxsIHN1Ym1pdCBhIHBhdGNo
IHRvIHVwZ3JhZGUgYm90aA0Kd2lsYzEwMDAgYW5kIHdpbGMzMDAwIGZpcm13YXJlIHRvIHYxNi4z
Lg0KDQpSZWdhcmRzLA0KQWpheQ0K

