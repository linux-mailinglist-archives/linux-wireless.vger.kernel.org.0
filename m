Return-Path: <linux-wireless+bounces-11793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF895B1CA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951B5B23D16
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937F17084F;
	Thu, 22 Aug 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RX4LDl+5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D716F0CA;
	Thu, 22 Aug 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319395; cv=fail; b=i5zLOC1DIonkq5/5T9CBTXrsud+ABVlnqD8tgpNzs1oBqAV75MiTE8TsHH4ESsd0WGFpgm0+TprJYbWCLZA2XdYFBI6ypFbk39d5beusTmki7Zf1LqEbFN55ZElR+xmjXWVS41qHP+aemj+doL7UIF52YDbkZxY2RVL5cSRXZpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319395; c=relaxed/simple;
	bh=SnRHHHbPrUwPQR0XK1DnU09B3opxIQvage2KonO9nbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D8MMYj9lcGIwMbkGWGKR2g0KdecH8Day6Anf/xDZEVja9rndZYnPEFCV/OU+DhRzMqlu6XCtq69oJFjTTNzsnnr34x4iyYAk44M3vH1k43L9Ei6BLYhhYcvVJ1SV6DgAwTMK44MZ+rvJNjYjhlWSkLfRYc7tEcFhbMQ2oSznu0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RX4LDl+5; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuFlqxb06etGZtNk9Xx6M3+hIQidypxNPGgeFjUqukLq6isVUcLT9oEbUAoIOY6mreajgYzm6BpDF1YlZ6uzV5CDwlhFVT0avISwE06Iiej/95Lpu7sJJl7kBM0Ua65mIKJuvjnQwWXmIgXm+Fgxhev6srPV96twq6x2NtFcT6k8Rm0gstRNO9d4I2hOt1IFM52VrLSUVKisQSk5javALIBq7rpHQruw+AnsjSZWXD+IGyHw9f+o9CNhHui3MyjR5ufvTWKSou98xJN5CCjN4QztD63fXgWoT1fxNkxOwZYJmuHvvs5ia9StcARYe7y2H7EPULO7WcNDVN58gBX8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnRHHHbPrUwPQR0XK1DnU09B3opxIQvage2KonO9nbg=;
 b=btaZw3gp4JitOM5kFyjjAzgcb+PVK7wwOOh6v0n4uDIWjDlqqSeqYjQcJ5YUtXQpksy0AxqhG1hNLT8hp2ZOhTV5BmXjueHiMo8nesNUhjoC6I0G+f8ocVTs8Dh8GmeMJ8UyzRKt3SzKsdNRFNxynuXvLl2LyEWMhpvL3GQFizNz6DagXIGsJe6cSLW+6FD0TViBKAE1F0pb5mV5Wcj2YaQupus733gPOs8kXRl/uhTtXpZXk8iSXErhqHWVvaOT5jjUAZTpZf2GahnGmypBqU2zvCgUYc2lMQT8/seqVvJCh7yiKWO9WefzYUOCePE9Z9I+CeRnclMCBZw5hyJ9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnRHHHbPrUwPQR0XK1DnU09B3opxIQvage2KonO9nbg=;
 b=RX4LDl+5A00jtH05s/4ZP4L4oNGQh8QsN7GPY6iwt3fD6jikF0f0Z07vPYRncN/KhSikIgSyhYN8Hku07p5KLeItHm6qRLS+X0hKkkOsLceHMQkEMxguJThuXlTuwZSsehjdicrcI7c0Vlm65J6rivzxj4wSOISwYx4rGltr82UAqRAUQXGCcyrak6jl1SN8Lg8EuvDxxH6bA58HwG0YIncXdcDc0znR1WSvJjb/ZP9bgL/SsHyxR8UDWkgkR4Bf68yw+IQpoWOqpwralUU2ahQIAe7zsxrs4D/6qI/B7iT0CttPxAe6Qgld7EBeOLglKlvfkDQQqyYj81D6VOMVvA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8130.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:36:30 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:36:30 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	<briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, Kalle
 Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Topic: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Index: AQHa8vjaVhal52qkKUSAi5YxIXRvnLIzBf+w
Date: Thu, 22 Aug 2024 09:36:29 +0000
Message-ID:
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8130:EE_
x-ms-office365-filtering-correlation-id: f4376ecc-7c04-4335-2fcf-08dcc28de6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enY4NlRicE5BTEhuZWFLZUwrSXUwQmVHb0c5RFY5cGZuZzdtVzhYS1lsTmZk?=
 =?utf-8?B?Y0krY3dyRVBTbmx4Tm5qS0JkZHhHcDFTQkJxbHJXRDBDdVpkWVRvY25MTjUz?=
 =?utf-8?B?dW1BVDZFUms0aFBYck5BZU1kSkwwZ2lwM3Y2NFhyWmEwajUxcnlub1BzWUd3?=
 =?utf-8?B?elIraHVrWjE5dFcwSFdRSHhuSjNod2pSWkVsSkEzdFUvODgwZUZDODNQNzU4?=
 =?utf-8?B?d2pYUHVjOXNYUHBHTm1zOUFsc1JKNlpvQkFjQmR5ZldhcFF3V2d0czdrUExy?=
 =?utf-8?B?Ykc3di82dUU3QU1xV3J4RHBqVDA2dG9TdWU5QURjRlJvU3BXWktDL2hBd0Nr?=
 =?utf-8?B?ZkpuY0lnUnA1VVVCcURwdTBCUjZuMFV0Z1FrUDFUenc3bGQ3aFU5YmNmSUlF?=
 =?utf-8?B?R0NMMVZVSUZFL2FvVmo4TFRnZ2xpclF2Y3cyVmNYTFF5NnRURUVXOHJuNFc4?=
 =?utf-8?B?eHkxTUZYZXFZVXBWY3RLb216amVsQmpoSzdjYkpHd3dvZEF4cE1URys4SnBT?=
 =?utf-8?B?cHBaQUhmV2FOeDlsKzJrL3ZWUmRXWnZvOVpuS1hpblBsSnk3TmhyTXBSOFRx?=
 =?utf-8?B?WWFMKzhyNW5jLzlzcDNHL2NRTElqTFpZOTV0YXZNbFN0QzZNckplcERBT1p0?=
 =?utf-8?B?L0htRElwbTBJbk1obVBOWW9NQkJRazdGSUx0OURaYlVzVk1NR09jTjJFZ0p0?=
 =?utf-8?B?dE1DR2ViQlJwZzJ5dUVQd3hQOEJHZWJjeUhkTTduUTlybzB0K2x6TkVGSkRS?=
 =?utf-8?B?K1F0TXplSUg2ZkVVYXFYWElTVHNKWjRLbHphckt2c29abkZTS2hEOHpuZEpM?=
 =?utf-8?B?YnF3V0ZLT0lDNUx6NGlyTllQc0IzR0R2UXVTL0Q5dTNEK2pMVXBBY3pma1V5?=
 =?utf-8?B?UVdkQ1RSbUJ0a3U0Zlh5eVJ6MEk1WURkTkhNKzRmOCt6aFFtZ0F2OEFNSmhR?=
 =?utf-8?B?NGRUVmpOL0h6UmJtblpRc1dVYi9CQXNRcmlqaFhFMFlaeHlLaHNBTzdweWNU?=
 =?utf-8?B?VTdaRXBNcnpDMjVuRU9ia1FMZXNuMFluTnFnMW9iVkh2bXpXTkVRTVJBdk41?=
 =?utf-8?B?WGVCR1lQSlc4bW1wL1Y4K3hQbzArTmJTWk9IQm1Tb3creUl5NnRVcyt5dWo4?=
 =?utf-8?B?Z1JmWUdSQ1dGcmhxWEFheDVMRmplWmR1eHFRVytkRzY5eGI2Q1ZtMkZzdG9P?=
 =?utf-8?B?aFA1Q3NzTTFQRktLTU9yOERwN01yMFEzcS9IZlVURm43T0xpS0VPaUgzVFl4?=
 =?utf-8?B?U0tsbkNtdmlsQmpWSTNFQ1Fxd05HdFFhblFGTEdzY2ZheVQ5TVJGUmZ6ejB0?=
 =?utf-8?B?eDZwb0xBeXVCVkxhbVdXUkdHWkR3bnJMaDZZVVhRV05jcGlDSk1HREl3L2Jh?=
 =?utf-8?B?NWhsTDY3ZDFKcDRNVCtibVBjcHZlRmsrVUJVeHAwZW5NZGZUTlJUUXlyN3hB?=
 =?utf-8?B?ZkFBSVdkWVh6cG1xSVhwcHZjZXJWOE5DM200QTF4Z3VlVG5WMi9ncW5zODBI?=
 =?utf-8?B?aklGL252dkZneDA1NHhIZVJFa0VXMUtFRE5iZHVyYmRMYU9DSXNoQWZYQlhq?=
 =?utf-8?B?MDVvUElMZEtCSnJVOTkzQnhNcDQwV1kzbjkrUFVPWUtSSXk5NXQ2VUpuT1ZT?=
 =?utf-8?B?RnlicE5nREVVbUNtMzhmRmhOc3ZpLzluYmFDVnAxNFZYbXg2RkE5RUw1Lzky?=
 =?utf-8?B?VFlPQUwvdU1KYUNmNTVwSUQ4NWxtTEwveWhNemM5bkNHMWlyZlF5UXJLaG5T?=
 =?utf-8?B?VjlKbHM2WHVvRVl5bGJiMFZ4Q1BqM2NKVGdOZVpWdExucGtkcnZySkI0K2xP?=
 =?utf-8?Q?X6Ml/iRuIjnnL0G2h5vUAaClkCdyzJpe3uRiA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVNvcThrYTNodkIvOXdSWUhSRzJzMFF2ckVKMjc1cGJ0UWdsMHFXWmttUnlT?=
 =?utf-8?B?dzdqWFlLVFNyZlVZUERSekFJVmtFOGFWK2lzelBJWktxQVBwWitqeVNsUXpw?=
 =?utf-8?B?ODJsMFJKay9WVk1lc0d2UnZaNGRyek56ZlErb0l4U2xZVDk1QWhtY2NlbmY0?=
 =?utf-8?B?KzIxM01IMk5uOC9mTXRCbEJXQ3RwVU02UU1YY3RjVVM4ZGxMRU4rcVpzWmwv?=
 =?utf-8?B?TGQyRWllZXdUam80M05zMFdCVHBvVU1mRE8zUVFMelFCaGpXc1FrYi8xdHYv?=
 =?utf-8?B?SGp6RWtXTmdwQVpNS2ROR044NlJ1dm9kNVNEa0tIOVdiWFo2cU9RSm9CK3dT?=
 =?utf-8?B?YW5HRWRZY3cvSTZESysyR0dlaWJpay9DeTlVaGcwZzlGNE9URk1FNksvWkg0?=
 =?utf-8?B?NkFjUFBaeEdXQnp5VkNmd2hhM0pOL0lzenVoREVKMUxFclpzaDlKWjRsd0lP?=
 =?utf-8?B?QTZVa0grMm1TZXdoSEtCYko1MEJobHBQL1FpQ1dLSTZ0NDg3Tis0d2lmUkVN?=
 =?utf-8?B?L2lBYVI3S2RsTEJNdFlRZDBUdWFyZHJSSlozZXk5Rmlid3VVRGFML2VBY2FU?=
 =?utf-8?B?QjZJZ05yZWtuUHREYmJQdDk3c2R0MVNPOHFJSHpDa0hBZlNvdkxyZC9zc3Qr?=
 =?utf-8?B?YlpOQ3czN2ZrNjB3bEpra1c4UHo1bTlGSk5XQThibFEyS1hleHNiSm1hdUxh?=
 =?utf-8?B?WU1NZWNhNzdrTWdKclBCa0N6aWwyOWJpdldFMk9lSTg5dDE2RklPM0JkWDVM?=
 =?utf-8?B?MFordFU1SDRpNmxoMmZDUlR5eDV0Sk5VWC9ORmRQdjYxMytTb3RGT3ZYL2VZ?=
 =?utf-8?B?VkduT1dkYzhIakZWS2c0dXdWTVIrWVBUSDBrMjdRbU5GV3JtdHI1bjRLb3E0?=
 =?utf-8?B?T25kVXJ4RWFsRVR5bWRPdkkrSFRkdkdMUFpHTnJnbVNWblVOVkVBUkRFYXUw?=
 =?utf-8?B?V0QreXFUU29XTmNHWWQzajZuTm55RkNTUGRwdUpXS3dqbGJxd2lNakZ0R3Nh?=
 =?utf-8?B?RWpyd3p1OUhPeE1FQ0xMYy9EOXRNSVVCL1hnbUduOUNtMXU1ajE0SE1pYWU0?=
 =?utf-8?B?dE9VZ096NWwwRDdkY2NzWU1pR2xtOFJNU1l0S0FQa0YycXpnNnpMV3BPRGZ4?=
 =?utf-8?B?S1Y4bTJ4dm9rODY0dkZlUnI3R3V2dEE1eURXWG9zOEdhV3I4dzE5bTU5eERU?=
 =?utf-8?B?WllyaU93ZlBkV0oyUi9od28yRHpzS2g2QzFqRGxTQUYzTVFCOXZ0c2pNNzhM?=
 =?utf-8?B?TFFDZ2FHR2ZoVmhsTUNlWDY5SDJCbjZrYmM3L1BTRjRQZ2gydHNsZU03Rml2?=
 =?utf-8?B?RUZMLy9LeGs2NlNrdWZ5Z2dGdHJnVFVYZlBxTnJuUUJ0TFF0ek5RUjY5SnNs?=
 =?utf-8?B?dXlTNFdITVo3Q2FqWlZJLzNIUXk2MHlJZEJTY1NRcFFHSHpMWXVLeWp3Y2tw?=
 =?utf-8?B?WE1qVkNSV0hqdHN5T2M5dEozZzBNZGUrbGZxak5ZYkJkNkZKc1JQbGJkVC9K?=
 =?utf-8?B?b1l1VjFTQndkbEZIVGVtZ1ZoWEFZalpYZ2pyY0JOOHdpV1hWc3QrWXRIazcx?=
 =?utf-8?B?ZTlYaEx1clBLL2NPQTRPOElCcy90a2U0WXM0Kys2SXZLblVtZ1Z6M01qSHpt?=
 =?utf-8?B?VFlkN29WekNudWk4bEs5R0x1T2R2UG1RTXRDZW9HUzh5VXA0ejBtNkUvUCty?=
 =?utf-8?B?Qi9Ub0h1L2ExWjVNbVdVUkcrVUhEY1FyOFhNaTlpVlJ5ZklpTDNCbG50WFpa?=
 =?utf-8?B?S0k1SU55bUMxRk5zVzNYSjJNQW9KSW9va3pzdU1MNHJCS0xCWFlsaFE3bFBB?=
 =?utf-8?B?R2lzdG50Qmoyd3NOSmI4UHJvVnhIZWlSTUtSdGdxRE14YnFzYk9IRWpQT0Qy?=
 =?utf-8?B?QVo1NFhWclBpU291a252NU0zYnlaYmkrUGdxYVJKemhmNzVCZUEyRU8wQWd1?=
 =?utf-8?B?WmFzcTY1YmlMdy9rWlNYMlJUY3M3R2o3M040b3p5VlZCeDFEVnJ2Wm9hQkx4?=
 =?utf-8?B?RHgzcEdzL0NYYXNCRTdGcWVSVi84SnloK0YvSnpzcHd5NjUycDZXUkdweTAv?=
 =?utf-8?B?Q0FBOGdlMHVFbnk1bDRyTjB2TTQ1aU9LTFlzQXlhT0VzeTRSdFo0NmdBRGpr?=
 =?utf-8?Q?TPe2DiX3EXPyAiTX6nEnDMgWR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4376ecc-7c04-4335-2fcf-08dcc28de6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 09:36:30.0076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52CjMJDOBrJETgc3S+ydfbpR45cki3RHOPJ+UrD62mACNYkgXomCYTTujWWM+ShgTHXkkD5o8x1kxCSZbk4F0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8130

PiBGcm9tOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IFR1
ZXNkYXksIEF1Z3VzdCAyMCwgMjAyNCA3OjU2IFBNDQo+IFRvOiBCcmlhbiBOb3JyaXMgPGJyaWFu
bm9ycmlzQGNocm9taXVtLm9yZz47IEZyYW5jZXNjbyBEb2xjaW5pDQo+IDxmcmFuY2VzY29AZG9s
Y2luaS5pdD47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC13aXJl
bGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
Pg0KPiBTdWJqZWN0OiBbRVhUXSBbUEFUQ0ggMTAvMzFdIHdpZmk6IG13aWZpZXg6IGZpeCBpbmRl
bnRpb24gDQo+IA0KPiBBbGlnbiBtdWx0aWxpbmUgaWYoKSB1bmRlciB0aGUgb3BlbmluZyBicmFj
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25p
eC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvd21t
LmMgfCAxMiArKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWFydmVsbC9td2lmaWV4L3dtbS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9t
d2lmaWV4L3dtbS5jDQo+IGluZGV4IGJjYjYxZGFiN2RjODYuLjFiMTIyMmM3MzcyOGYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC93bW0uYw0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvd21tLmMNCj4gQEAgLTE0
MjgsMTMgKzE0MjgsMTMgQEAgbXdpZmlleF9kZXF1ZXVlX3R4X3BhY2tldChzdHJ1Y3QNCj4gbXdp
ZmlleF9hZGFwdGVyICphZGFwdGVyKQ0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgaWYgKCFw
dHItPmlzXzExbl9lbmFibGVkIHx8DQo+IC0gICAgICAgICAgICAgICBwdHItPmJhX3N0YXR1cyB8
fA0KPiAtICAgICAgICAgICAgICAgcHJpdi0+d3BzLnNlc3Npb25fZW5hYmxlKSB7DQo+ICsgICAg
ICAgICAgIHB0ci0+YmFfc3RhdHVzIHx8DQo+ICsgICAgICAgICAgIHByaXYtPndwcy5zZXNzaW9u
X2VuYWJsZSkgew0KPiAgICAgICAgICAgICAgICAgaWYgKHB0ci0+aXNfMTFuX2VuYWJsZWQgJiYN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgcHRyLT5iYV9zdGF0dXMgJiYNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgcHRyLT5hbXNkdV9pbl9hbXBkdSAmJg0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICBtd2lmaWV4X2lzX2Ftc2R1X2FsbG93ZWQocHJpdiwgdGlkKSAmJg0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICBtd2lmaWV4X2lzXzExbl9hZ2dyYWdhdGlvbl9wb3NzaWJsZShwcml2
LCBwdHIsDQo+ICsgICAgICAgICAgICAgICAgICAgcHRyLT5iYV9zdGF0dXMgJiYNCj4gKyAgICAg
ICAgICAgICAgICAgICBwdHItPmFtc2R1X2luX2FtcGR1ICYmDQo+ICsgICAgICAgICAgICAgICAg
ICAgbXdpZmlleF9pc19hbXNkdV9hbGxvd2VkKHByaXYsIHRpZCkgJiYNCj4gKyAgICAgICAgICAg
ICAgICAgICBtd2lmaWV4X2lzXzExbl9hZ2dyYWdhdGlvbl9wb3NzaWJsZShwcml2LCBwdHIsDQo+
IA0KPiBhZGFwdGVyLT50eF9idWZfc2l6ZSkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG13
aWZpZXhfMTFuX2FnZ3JlZ2F0ZV9wa3QocHJpdiwgcHRyLCBwdHJfaW5kZXgpOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAvKiByYV9saXN0X3NwaW5sb2NrIGhhcyBiZWVuIGZyZWVkIGluDQo+
IA0KPiAtLQ0KPiAyLjM5LjINCj4gDQoNCkkgd29uZGVyIHdlIHN0aWxsIG5lZWQgcGF0Y2ggZm9y
IGluZGVudCBpc3N1ZSBoZXJlPyBJZiBzbyBJIGFtIHN1cmUgd2Ugd2lsbCBuZWVkIGEgYnVuY2gg
b2Ygc2ltaWxhciBwYXRjaGVzIHdoaWNoIEkgZG9uJ3QgdGhpbmsgcmVhbGx5IGhlbHAgaW1wcm92
ZSBtd2lmaWV4IHF1YWxpdHkNCg0KQWN0dWFsbHkgaW4gaXRzIHN1Y2Nlc3NvciBOeHB3aWZpIChj
dXJyZW50bHkgdW5kZXIgcmV2aWV3KSwgd2UgaGF2ZSBjbGVhbmVkIHVwIGFsbCBpbmRlbnQsIGFu
ZCBjaGVja3BhdGNoIGVycm9ycy93YXJuaW5ncy9jaGVja3MuDQoNCkkgd291bGQgc3VnZ2VzdCBm
b3IgTXdpZmlleCB3ZSBvbmx5IHRha2UgcmVhbCBidWcgZml4ZXMgKE9kZCBmaXhlcykuDQoNCuKA
oldBUk5JTkc6IEl0J3MgZ2VuZXJhbGx5IG5vdCB1c2VmdWwgdG8gaGF2ZSB0aGUgZmlsZW5hbWUg
aW4gdGhlIGZpbGUNCuKAoldBUk5JTkc6IFBvc3NpYmxlIHVubmVjZXNzYXJ5ICdvdXQgb2YgbWVt
b3J5JyBtZXNzYWdlDQrigKJXQVJOSU5HOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVuY3Rp
b24gbmFtZSBhbmQgb3BlbiBwYXJlbnRoZXNpcyAnKOKAmA0K4oCiV0FSTklORzogQ29uc2VjdXRp
dmUgc3RyaW5ncyBhcmUgZ2VuZXJhbGx5IGJldHRlciBhcyBhIHNpbmdsZSBzdHJpbmcNCuKAoldB
Uk5JTkc6IHVuY2hlY2tlZCBzc2NhbmZyZXR1cm4gdmFsdWUNCuKAoldBUk5JTkc6IFNpbmdsZSBz
dGF0ZW1lbnQgbWFjcm9zIHNob3VsZCBub3QgdXNlIGEgZG8ge30gd2hpbGUgKDApIGxvb3ANCuKA
oldBUk5JTkc6IGRvIHt9IHdoaWxlICgwKSBtYWNyb3Mgc2hvdWxkIG5vdCBiZSBzZW1pY29sb24g
dGVybWluYXRlZA0K4oCiV0FSTklORzogbWFjcm9zIHNob3VsZCBub3QgdXNlIGEgdHJhaWxpbmcg
c2VtaWNvbG9uDQrigKJFUlJPUjogVXNlIEM5OSBmbGV4aWJsZSBhcnJheXMgLSBzZWUgaHR0cHM6
Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjemVyby1sZW5ndGgtYW5k
LW9uZS1lbGVtZW50LWFycmF5cw0K4oCiV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlICogb24g
c3Vic2VxdWVudCBsaW5lcw0K4oCiV0FSTklORzogY29uc3QgYXJyYXkgc2hvdWxkIHByb2JhYmx5
IGJlIHN0YXRpYyBjb25zdA0K4oCiV0FSTklORzogUHJlZmVyIHVzaW5nICciJXMuLi4iLCBfX2Z1
bmNfXycgdG8gdXNpbmcgJ213aWZpZXhfcmVnaXN0ZXInLCB0aGlzIGZ1bmN0aW9uJ3MgbmFtZSwg
aW4gYSBzdHJpbmcNCuKAoldBUk5JTkc6IGJyYWNlcyB7fSBhcmUgbm90IG5lY2Vzc2FyeSBmb3Ig
YW55IGFybSBvZiB0aGlzIHN0YXRlbWVudA0K4oCiV0FSTklORzogUHJlZmVyIHN0cnNjcHlvdmVy
IHN0cmxjcHktIHNlZTogaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzg5DQri
gKJXQVJOSU5HOiBTdGF0ZW1lbnRzIHNob3VsZCBzdGFydCBvbiBhIHRhYnN0b3ANCuKAoldBUk5J
Tkc6IFByZWZlciBzdHJzY3B5b3ZlciBzdHJjcHktIHNlZTogaHR0cHM6Ly9naXRodWIuY29tL0tT
UFAvbGludXgvaXNzdWVzLzg4DQrigKJXQVJOSU5HOiBVbm5lY2Vzc2FyeSBzcGFjZSBiZWZvcmUg
ZnVuY3Rpb24gcG9pbnRlciBhcmd1bWVudHMNCuKAoldBUk5JTkc6IFBvc3NpYmxlIHJlcGVhdGVk
IHdvcmQ6ICdzZW5k4oCZDQrigKJXQVJOSU5HOiBQb3NzaWJsZSByZXBlYXRlZCB3b3JkOiAnZW5h
YmxlZOKAmQ0K4oCiV0FSTklORzogcXVvdGVkIHN0cmluZyBzcGxpdCBhY3Jvc3MgbGluZXMNCuKA
oldBUk5JTkc6IEVOT1NZUyBtZWFucyAnaW52YWxpZCBzeXNjYWxsbnInIGFuZCBub3RoaW5nIGVs
c2UNCuKAoldBUk5JTkc6c2ltcGxlX3N0cnRvbGlzIG9ic29sZXRlLCB1c2Uga3N0cnRvbGluc3Rl
YWQNCuKAokVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgdXNlIHRhYnMgd2hlcmUgcG9zc2libGUN
CuKAoldBUk5JTkc6IE1pc3Npbmcgb3IgbWFsZm9ybWVkIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
IHRhZyBpbiBsaW5lIDENCuKAokNIRUNLOiBBdm9pZCBDYW1lbENhc2U6IDxIb3N0Q21kX0NNRF9B
RERfTkVXX1NUQVRJT04+DQrigKJXQVJOSU5HOiB2b2lkIGZ1bmN0aW9uIHJldHVybiBzdGF0ZW1l
bnRzIGFyZSBub3QgZ2VuZXJhbGx5IHVzZWZ1bA0K4oCiV0FSTklORzogc3VzcGVjdCBjb2RlIGlu
ZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cw0K4oCiV0FSTklORzogYnJhY2VzIHt9IGFy
ZSBub3QgbmVjZXNzYXJ5IGZvciBzaW5nbGUgc3RhdGVtZW50IGJsb2Nrcw0K4oCiV0FSTklORzog
QXZvaWQgbXVsdGlwbGUgbGluZSBkZXJlZmVyZW5jZQ0K4oCiV0FSTklORzogZnVuY3Rpb24gZGVm
aW5pdGlvbiBhcmd1bWVudCDigJh4eHgnIHNob3VsZCBhbHNvIGhhdmUgYW4gaWRlbnRpZmllciBu
YW1lDQrigKJXQVJOSU5HOiBlbHNlIGlzIG5vdCBnZW5lcmFsbHkgdXNlZnVsIGFmdGVyIGEgYnJl
YWsgb3IgcmV0dXJuDQrigKJXQVJOSU5HOiBNaXNzaW5nIGEgYmxhbmsgbGluZSBhZnRlciBkZWNs
YXJhdGlvbnMNCuKAoldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIHRyYWlsaW5nICovIG9u
IGEgc2VwYXJhdGUgbGluZQ0K4oCiRVJST1I6IG5lZWQgY29uc2lzdGVudCBzcGFjaW5nIGFyb3Vu
ZCAnK+KAmQ0K4oCiRVJST1I6IG9wZW4gYnJhY2UgJ3snIGZvbGxvd2luZyBmdW5jdGlvbiBkZWZp
bml0aW9ucyBnbyBvbiB0aGUgbmV4dCBsaW5lDQrigKJXQVJOSU5HOiBDb21wYXJpc29ucyBzaG91
bGQgcGxhY2UgdGhlIGNvbnN0YW50IG9uIHRoZSByaWdodCBzaWRlIG9mIHRoZSB0ZXN0DQoNClRo
YW5rcywNCkRhdmlkDQo=

