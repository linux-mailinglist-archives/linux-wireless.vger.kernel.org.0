Return-Path: <linux-wireless+bounces-17103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2CA02172
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D1F1883FB2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6331D514E;
	Mon,  6 Jan 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MEwEpiZ6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010009.outbound.protection.outlook.com [52.103.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97E1D63CF
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154407; cv=fail; b=lgiDiKoGikN/pvgVQ+G7xjslc7gEDmxyEFtBA9jQcU1+gYAEbtMjS65SH7rZ2QUMmWysgScu/JZXcefGDh6VR/5up8kKZ4K141RiVxnaccRgvlO+KQ9wdosZtGw9o4bxaELnm45tJub3N5Dwv4s/dnO1EpT1yR8dFCtpi16lVVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154407; c=relaxed/simple;
	bh=xWUOBF7QuLSziv7dAKVXSbLnKKc8rXfXd7WrylHYU/Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fuAuYyAMcOAQoO03LZuPADKGhOnh3FgiLy7WfbxMEC3OfbUkj6jykFxoWWoDapJrDz7caGZcX8+rvYPgAqAe4L0JIgonEFW7faRz0ea82ms22hO8EBXtb47DstO3Dp8gArE2R1SqYUKnWLOptBaEzPFuRz+LmQmKb+wFNzarDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MEwEpiZ6; arc=fail smtp.client-ip=52.103.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNHxfIbq4FapoQGMy1mge50Gq+vkX0/rdpqR0h7JdHVwGxSX3XM1Pd3WolqIzJO3Z1fSMzHcTVq/8V7pl4CFlkwPBQh5IDtvY8vRVEZ4U9nC1Jj+AHMvxdB40MhgzwoifXgF3aLGvG52ccI0C6aKsSDI/zlxpqL0ks9YZ17aOdeb+lfoQ/ax/fS/FIzskqL+ap1qHFf7Wv7ONGUcWGnxaVZltKKhu1jRXKi78RTz5QnTt0WEn5AmrqmZR1z2DG1TOMjfXnih0NP/HoKIXOhFD1HdFufGu7LWgqIatIbwOk+axL92cULMkwHPbhjwF2JqbS0j1IF/Naxn3wLFuJv2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWUOBF7QuLSziv7dAKVXSbLnKKc8rXfXd7WrylHYU/Y=;
 b=gLGUZQ0Y80sTELnlBhjNk0K1+MXzbhgIE2CgGBrNPP3eAAOouEEdHGLZHejEawUl3v+3FPfiI3oGbQHViAIOt4iOoH3OAts02ad19fOwYC5vnNS7sZtRtju72iOeRtDC009d+3XPepuAz1AYCd41kDt+poV4XFmoB0ll6+pxoZbR9N1BcWiynGAZjDyive7xUIDCkJwfKmLGaLFdVNBnynHanYJR2K6KosB+yJuNpxkYM0GBKXQnevk8i0JJ2JoT24I2WRHIkuIrKO1pmkySTW4M/zq1MTb4kZIRTKDl0x+i2OhDiKOl8+Xm/kTxr5WOE6G1xKhf31SyPFCgNIOWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWUOBF7QuLSziv7dAKVXSbLnKKc8rXfXd7WrylHYU/Y=;
 b=MEwEpiZ6Nn6X3mhRiK1uEKNMW0l0IBws5Q+bki/2VG4x7bq7zvDwa2pv4+xf2nGGFaOSVo3TwLS+XzFER9dq1DyfJ0esIGQr+74Ub+bljJVibUpt9DXteJgjfykYZpSEqV6yV3rk4dU4wI1ZhWni42vhdrMGPCOvsN/0rDNzdhygp5/QA3m0Uc25ueHTWbqQ3qeTq6Tnum3WzBgR3ECwp+G2I1P93RtD73aQOSGgNkfKEC6VirXaQATcvabYevAtpHiFlOcLvrIdeDy+FcnEFibEB0wrddfUcS4V4kSeZJISzgVlZG7fE9kX+N7bymbHHyZI2z6HdtQI1P+0Y5vA+Q==
Received: from OS3P286MB1520.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:179::14)
 by TYWP286MB2939.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 09:06:43 +0000
Received: from OS3P286MB1520.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecac:4aaa:76ba:91f2]) by OS3P286MB1520.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ecac:4aaa:76ba:91f2%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 09:06:43 +0000
From: Jingwei LI <marscatcn@live.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Inquiry Mesh Point Mode Support for mt7921au USB
Thread-Topic: Inquiry Mesh Point Mode Support for mt7921au USB
Thread-Index: AQHbYBpD1FF+TbpcSUG1dfHyQJzpuw==
Date: Mon, 6 Jan 2025 09:06:43 +0000
Message-ID:
 <OS3P286MB1520BBA59C7E5E2C1F015FBED5102@OS3P286MB1520.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB1520:EE_|TYWP286MB2939:EE_
x-ms-office365-filtering-correlation-id: 8d818920-40d9-483c-1f54-08dd2e317086
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|8062599003|15030799003|461199028|7092599003|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?O1y0dqgj/eDy9J9STmjuXn69A0PGmw5ILKN+YROgnrA5sw3KnyOvb7XN0L?=
 =?iso-8859-1?Q?13w1JTqVg/wz9PJyYiXRTJJ4SbzAensd5tLjgLz4vamMSccl46rRW94Q6t?=
 =?iso-8859-1?Q?c/08cuHKGU4M0hr82qPT1JE622npx9bg04VS1OYtWhVklihrqxeQh1rlib?=
 =?iso-8859-1?Q?aIkXcl/1VUNlnvl2E6J8tesN2t2XfM9+/k0LzTKqWXdVZHogpQN/orb3yS?=
 =?iso-8859-1?Q?7U6t4NvTNJodtQCMXXLr07JQWi1ZbUJT972pUhRArvE+53g0y4jkdqzDBl?=
 =?iso-8859-1?Q?5gM7ekuwnXm1U3psaas3iVNaiahOvF5GmG8Z+BS0k07gM0N0p50R79++nF?=
 =?iso-8859-1?Q?vlojZ89+zfDuefEEGl6dEmpib5ZESBKI5MigGoKToXL6P8DM/GzoKLgXjR?=
 =?iso-8859-1?Q?fyU5WrfaSDb8iI3KdPehS8FsTpCqvMHiZu1RvQKVaXkg0p2rfYYuqNXSHy?=
 =?iso-8859-1?Q?vR+Lq5Epwlp30grMGEYJsLu7C2N0mPUezh0JrF2VPnrWIG+Pinx2pCLtui?=
 =?iso-8859-1?Q?3vnkQRMs2mXGeJjXLKEeeHerghdyQat9ed62eZ2jGBtuT24fRNzwSGRMDQ?=
 =?iso-8859-1?Q?8XnpC/4WfcOCqtGtcGaLkQrlJAonL2nrUIoGw+Hu3ppa9dCfr9uN9RAnNe?=
 =?iso-8859-1?Q?ZZ80DrIECoXmLsX2Xa5iW+vLzzNkW5XR/u0lyp4aJqF1cAAH2CWwCcKlKk?=
 =?iso-8859-1?Q?gl57qzyFiitahmFL1YuA4jgIlX4tm5P+/zkUpvBoSxL64jtszImeee3z62?=
 =?iso-8859-1?Q?9vvgkqZu4qWdIGCGcTXe+I2zDuGnLOvu1zCTDHAJdWSR9BERe9t0fX6cu5?=
 =?iso-8859-1?Q?8+C+dNHPAA0cEKJOuHoRDVkGbbmfp3Wammkhz+La2kvtvlHYylmatg0uZi?=
 =?iso-8859-1?Q?L1zMDlHfhuMCDCYj7MgA9cWVG1MqHdsGf2uESQmF52oIRqqTAQWCkcolbV?=
 =?iso-8859-1?Q?jGeHQ17WGfoS0NSuu8HsoOR5uEsthrhElSIz0ztlwxqHm5ipqqBOoZq4az?=
 =?iso-8859-1?Q?cOKuyr1BOjRyCPrcJtWNfjWk7doXo18nPUuawzMvp/DljQS8fSIqTXoIMx?=
 =?iso-8859-1?Q?zV/oGEy3/f5F/S+YViJnn69aNGAejj9zkq08EHQb21fli/7W6oudHqDytg?=
 =?iso-8859-1?Q?rS1iVY9Pi6u49KevjzOhdZ+ITVU4Y=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yUpr99JTO0zjk1C+5UxMBFCgiBpSwDPCnm4+TTHU4bpGx/6wIQj58uh6vj?=
 =?iso-8859-1?Q?KpIzqh79O2zx075O83vURGVZB2pmAaY4Jy9/pIVKFpnq6zrAeJKcmDr7vx?=
 =?iso-8859-1?Q?Hnsg8a6ncF/rrqCZil34GC88Vm65sWwHmemS4JaCiEdvuYlJvvm72LvPBM?=
 =?iso-8859-1?Q?eJdzopeajK3W0H1E6rqZh4VnBSMGlz7s68k/6Njx2u93LobhPUDvXnDGOj?=
 =?iso-8859-1?Q?U3UwKA0TJUPmEzU97EPX6ITWBuOPWqIVPIYOfw7f9fKFj21FWOQQKNLPuR?=
 =?iso-8859-1?Q?d6L3GJc0PPkfUpfZDSP4kR6oEYZOJ1jodZEcNupVR+I+LqFCwrmbYD98me?=
 =?iso-8859-1?Q?xwf2qwgqAKgOf0uEEEqcrNirOgUcNTOsIdZAvZpfoq5A0xXic3pB/t0oMd?=
 =?iso-8859-1?Q?jUWAAIcKeLLDguU5zoY5CO/hBkG9EJuDaYsD56gz9ZzzMIxK4xoGNdeoEt?=
 =?iso-8859-1?Q?VvbH+vLss8zofzXDSyODvkBQlucrFfv/R0Eu5dL/dhfpuNNNRzSVR/squo?=
 =?iso-8859-1?Q?ATmo+qFOy7UeUQ/XZzZFUrJoB/3Nd39JtMmtzWvLRFYMKtUjnY/cD4vNs/?=
 =?iso-8859-1?Q?w79DsqHuAiLvwei5SpNGQoIvXxLVPvSLxlfIhGu6YjYvcuE0TMGB6tWr1b?=
 =?iso-8859-1?Q?CO/Qev5ri4JgpAgDEseEj904uXvwxVrgQR9e7avClztfWVM6shMfXZycRT?=
 =?iso-8859-1?Q?ry6AvQO0LvN8yybqFK1k5xKV8ZjSD7pCdRYHqyZbhEaGKbUcHh7ZgU32PO?=
 =?iso-8859-1?Q?nl6rZuGufMAL/z+VkoMK/uYUQPV03wztmCdl3NfUHk7oolMOCFO2zu6dFJ?=
 =?iso-8859-1?Q?4OFiajWldICPoVUW5RKhTnfPPFZao9DoR8x6R+fSkchGVEV+J3AScuyG5h?=
 =?iso-8859-1?Q?RBMhPSKMCP7HOOHL21aB0BSVcKTSTGEgwQWzto4Jto9otvIvHg+CuOQwFs?=
 =?iso-8859-1?Q?xTx7mIEw7tSJiWTm2R8MQ0/C+a0+TRZf6k+AOm9IDyz5BSBtwmX8u4udVT?=
 =?iso-8859-1?Q?PUXM4WNWgKbew27x99vWYGZHo+YHkiopWJOfSIjV86V5LG8gVW5QX9MYdC?=
 =?iso-8859-1?Q?3MqJ8prbHCkg1k5j/PlrOQ3XRsWeyx7fd+2WkEv3MPlHppizQgtwZv7+hO?=
 =?iso-8859-1?Q?6AxWquS2410nMZ4bgExTYJpC0/VQnXDpOsFX+NomSm+ySH5NcvtgZoWBXn?=
 =?iso-8859-1?Q?NBQrgqTs519QyudJaWFeQsK9UyQDjtv5tDAoo4l9oB47Q2O3/UWf10hqwW?=
 =?iso-8859-1?Q?IxkgKhhgDwy9DfcfepXQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-6efd8.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1520.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d818920-40d9-483c-1f54-08dd2e317086
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 09:06:43.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2939

Dear Developers,=0A=
=0A=
I'm working with MT7921au USB and found it doesn't support mesh point, whil=
e mt76 driver entry is marked "yes" in linux-wireless driver capability tab=
le.=0A=
Could you kindly clarify if it is due to hardware restrictions, a firmware =
limitation, or a driver issue? Besides, if it could potentially be addresse=
d through driver development?=0A=
=0A=
Thank you in advance for your time and any insights.=0A=
=0A=
Best regards,=0A=
Jingwei=0A=

