Return-Path: <linux-wireless+bounces-8367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1598D6D74
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 04:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF521C2178C
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5DDDB8;
	Sat,  1 Jun 2024 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="D0AcKjIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2075.outbound.protection.outlook.com [40.92.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06300D304
	for <linux-wireless@vger.kernel.org>; Sat,  1 Jun 2024 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717207643; cv=fail; b=d3ja9nCHtw31Egsm8ubEaJjgxgEYdXIVzVGYFiw8FQuWl6Xty9+bPwiCLGW0IJRxNz+QJ7rQhdQOtgLaLTOFaSxn2JUptaPvZ2FUxfvCrYHeH4PKEA5lKNZFUgW2v4zmUVJGYVv31HUnsxMzdHshGU3+WuPafCwL5iUU6robalo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717207643; c=relaxed/simple;
	bh=aptn8rJS5xUM7zDqFoJDY2QnpQopyCUciZyYPRXK0KQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dgWqnkyYNDwFGNlY+VrovYiyPS4hjpIYNqwR9XbhBf0LAZeYQD2x0Utx2IwFMuZ/YedPSrYlIxF6JWebkQI9/cY3i0Gf68NeRipdNSZhTD1GR8oaP9o/YILQzgUM+43NQtf/FCdHZr4ju3TRjvq2pEYifpRHPOED7yx3prw+uJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=D0AcKjIt; arc=fail smtp.client-ip=40.92.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVdyOrwi+7hxa4zr+cjB7hRJNs3ZWodi2uD5xtu2p3A0e6K8sIluewapWZhAs/hJZSjIQ1M26X3fpGh4V30pxgYGE1dj81i+NpOzxQQrl8qNQdujL6IIeI2IakspFXCs89Ba9jvRsxDXCWKUeL6bD26YFdvwe4mpAH4mIdBWh1ihHpeigNLud8aHkXv4TLHoc52Qbth+fApemXKzZrDmtOEzbDqLzYnkrXfxmly33wx5rXIrJ/IN/596xl7Rx4BftnOuyqa+EYWMw3faL1gmAtCyerjhWpCONO+85TVWEGnUhe7WI7sQgf3oFwJkZhY8vhhAL2ITJACLbeHjs+14cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4FZkdOXaLgv7q2Xc6BH56M2NWl8lvQg/AFqveW0CvI=;
 b=S42SvFOQic6HQOr3GS8eOCjpQ03JR1c078zLdCD9+6yzdUGvaMFGh3vB4w5H2UptZDFTMr80CceRk2W1AdxYBgi8qckPk0sUNsCwpL+0763qoIR4Du1q4H0eDp5Iv2qSiDX0AXrSCtyw73R0xLH5OAjB5jcXAHUIQKfLNfnAK1yKMpWiU2zEMqJ/JKnmGqGthn0P6Wiz4rBUVwirH7/5SgXqwWdf+eUPrPnWjF5RX2DTr+/xRQKb+25wSyOmyRDtSBwj13GUULnac55Yms48egB++Ag+3rMNZddI8Z9lZE4NMtTgD7bupLZNMP+HvOUJ5GMmd3ryEYqu4AMzaP0B9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4FZkdOXaLgv7q2Xc6BH56M2NWl8lvQg/AFqveW0CvI=;
 b=D0AcKjItzVYbCuABKNZhYYrrTg6eKqw3hjSoiDsJwwfwlOJdhcYpkf6eXUCDKYsRov+CoURcsH+JAGFWk4bJ5oog8lKLr946p3zxXWjma4HtAenuRZYchGJmHmVUrZQVM4z/rwTW1iNv8gsrNkq6UnMFbAgE7Y2ytOTG9LYWPr+Cd8SZeLGTBqSmiEhDwZbuLJ6jSYA9ZBGWsYp07F3ujTDRVWId1YSevTIm0XufMFX+5p94S7u8jtZvg9U7IuwQ8DQRr5EJXXwkjFQyAR57J+Bpgdd5ECWatAPgvv7NOJ/jZ3vcsSWsgzeTreJGP4vi9qFEVRVjtjcIsgQ6YGgJBQ==
Received: from BN8PR16MB3009.namprd16.prod.outlook.com (2603:10b6:408:5c::25)
 by MW4PR16MB4767.namprd16.prod.outlook.com (2603:10b6:303:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Sat, 1 Jun
 2024 02:07:19 +0000
Received: from BN8PR16MB3009.namprd16.prod.outlook.com
 ([fe80::9952:18aa:c42a:7dcb]) by BN8PR16MB3009.namprd16.prod.outlook.com
 ([fe80::9952:18aa:c42a:7dcb%3]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 02:07:19 +0000
From: zhefeng xu <zhefeng_xu@hotmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Other updates on STA+AP mode with rtw_8822cu
Thread-Topic: Other updates on STA+AP mode with rtw_8822cu
Thread-Index: AQHas8R8o3GKojT9dkm/0nRi/CxCLw==
Date: Sat, 1 Jun 2024 02:07:19 +0000
Message-ID:
 <BN8PR16MB3009FB694F91A191827BBE29E0FD2@BN8PR16MB3009.namprd16.prod.outlook.com>
Accept-Language: en-CA, zh-CN, en-US, zh-TW
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [jjx0iq9tZvGj9O52ceVtnrbYSfp59j24]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR16MB3009:EE_|MW4PR16MB4767:EE_
x-ms-office365-filtering-correlation-id: 86c5912b-dd87-4468-4fb2-08dc81df912a
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 OZlsZhneZoF94P4miKZZSFeyx4lnUoimPQ9kAX9cgxU+VcydE8QJaJtTplnCdkeVK173T8BjnKVOOz1pFRUlH3oQn2L4EfZ3luiOXCtwg7Ft4Yrqv2/kHHg6sNYqRh+aLx4bo83zvM1upVaMsLhpnpgXrmzxk7ki19vdg9qFjZ5Eh2j6kKnZykXdWVXbd5k5AFhgOHEV2jj446FlL7dKLwKAwp7sIWVttFUebgH8bpGwNpu4Em/gVciAjAIG6smfNfkiJYWBcKj7gwPbKqvaV2mkxRbuf0ZisbBmWydZQyB6/x8TRGfN9t/+NNq9PAxpVeYM6WRnUSF5YUj/U4AL4XP83UVTuFTiW+tImVhhyyDhfZqoBsUPJtKEeYJditHJq0YU0HgSp6xBjcCVcEkt9YFm3ynU8XEUQPoCnx45H3QFQGwtjfV/ohKm/sMGjtMDHQY0oEXmvjNoZxyN9kCszDAqwQT1o96REPD6e/ZG19Fen0DAQvt37udb2sktTjbiz0S/yuOnTMGdjVS6M38d8rnW1vybaJUKxr9bJfrm6hDhxZF4FT8X3KPL4QxNcZGV
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1vfsWG/bZBs6kgqJU4Z9bV1RVyUw81Y1Vmh3IF+iEU9eJYaR5a55Ks+d23?=
 =?iso-8859-1?Q?GBP+koj5ZECbaO9W7gkFOzNRX4MaVeHOMqfgxB2Poll3rouDDtjlOrROoF?=
 =?iso-8859-1?Q?zUAwAqMg1qCDhvFNM4dJYV/5Jqlxjrpss5tKadh7yX3E97DU35NNc4j2NB?=
 =?iso-8859-1?Q?Nj87ticAQkH83kMQfDbyS7uqffQYzO2Uz44nGYsurB51k8DIvBKkpEDYSq?=
 =?iso-8859-1?Q?GimJB6j6tkRZHJN19anjtgwa44P4cbG3ndpNTfeOwOEcEKIfar2v25WyK6?=
 =?iso-8859-1?Q?Q5JXCVSqOX5Uc+jbVRO22U+sqYVUX+2+syeyoeDdQuPCoMPKPXt3e1fB7W?=
 =?iso-8859-1?Q?bDVTCa2Kw2SiFKQpSdz9Xb28wfX1oAP3XspK8iI86aI0ju8t6PFcCkwixJ?=
 =?iso-8859-1?Q?9L48FhnG2OuIILQzBo9Knbh2WNHcnEmgo0QNG1xxYbpOik+1bvaCvW+skp?=
 =?iso-8859-1?Q?zsHG2QPRRfyBv5yzz6UHCZzYKT6y98zpkc7n/HCx28CxzzM3kJ6FbNAFSo?=
 =?iso-8859-1?Q?+2BKHEuYpaCSlZLu0PJhMKwc0GVwZzYBgnZERx1O8ly6KINHAJsPX1jYxt?=
 =?iso-8859-1?Q?rfOy/NqfT6s+ccezzDq6DSW5mLTDX89uLB79+2OsRVLKSSMqTcLTXQi/FG?=
 =?iso-8859-1?Q?saWMr9IYhwiaTueA1nkjiRm+UFmaW6TK+thl37Ru/S9IGBF+RUF6pA45Q9?=
 =?iso-8859-1?Q?DTYt2o3gQo5vyMmIjlxlR+0E8qAV9p/BAUUNFOhmwKLxSssVvQOPV0AajH?=
 =?iso-8859-1?Q?P6uFZcIRz9DRE0BshQn8/0Wd+9bCrUeTLkgtb7PACtcowr7hfUpst08cb2?=
 =?iso-8859-1?Q?ADicWD/0RLEriIPfQicM8ZuuCjWla2N6Votz9Xrht99T8IQY1cmO2sgCMj?=
 =?iso-8859-1?Q?Q/BDsQN7AgL1GAYz/au27zVCZ3o56LHCuSuoutmaF3tu7wxMc372ee96n8?=
 =?iso-8859-1?Q?ayDWbWBqll43LWJPrsM7DyCvt0Bx88oRDoBJGAkWAxsozHUgkDVGwFJN/K?=
 =?iso-8859-1?Q?Nc/939Q2GR/KcLXx14wEsAFHqciTXA3PYi9S2xuBVXhxkZVRr4XYEwRPjT?=
 =?iso-8859-1?Q?kp1q74vuk4i2D5yTZb3CPWGHxyAlBv9mFrFurlRiPDnvXzVsgeLCHKFFsR?=
 =?iso-8859-1?Q?+L+HGrHxuM6KD0qdS7yxjmQE2U+lhoKOdJ5pMaxdfdA+hFgrgvMWHz+W4Q?=
 =?iso-8859-1?Q?2FARkTlThJIlAiR9oR+N5sJ0Jl0WHlvJtdWBOn/P5JeYO0mSJAeExjmxyS?=
 =?iso-8859-1?Q?XmDo0WilipdkPbkJ6H2LDbNb9A3tb9BEQstdYJlA0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-5ce7b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR16MB3009.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c5912b-dd87-4468-4fb2-08dc81df912a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2024 02:07:19.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR16MB4767

Hi,=0A=
=0A=
Recently I found I could connect the AP from android cellphone or iphone, b=
ut never succeeded connecting from windows 10, ubuntu or ipad. Not sure if =
it's the driver issue or hostapd incompatibility.=0A=
=0A=
phy#0=0A=
        Interface x0wlan0=0A=
                ifindex 43=0A=
                wdev 0x2=0A=
                addr 00:0e:8e:b3:fd:f5=0A=
                ssid ap_test_j=0A=
                type AP=0A=
                channel 40 (5200 MHz), width: 20 MHz, center1: 5200 MHz=0A=
                txpower 23.00 dBm=0A=
                multicast TXQ:=0A=
                        qsz-byt qsz-pkt flows   drops   marks   overlmt has=
hcol tx-bytes        tx-packets=0A=
                        0       0       11      0       0       0       3  =
     21340           183=0A=
        Interface wlan0=0A=
                ifindex 42=0A=
                wdev 0x1=0A=
                addr 00:0e:8e:b3:fd:eb=0A=
                ssid CIK-Mesh-2154-5G=0A=
                type managed=0A=
                channel 40 (5200 MHz), width: 80 MHz, center1: 5210 MHz=0A=
                txpower 23.00 dBm=0A=
                multicast TXQ:=0A=
                        qsz-byt qsz-pkt flows   drops   marks   overlmt has=
hcol tx-bytes        tx-packets=0A=
                        0       0       0       0       0       0       0  =
     0               0=0A=
=0A=
STA+AP can be set up using linux-router script. AP can access internet thro=
ugh managed wlan0 connection. I can watch youtube from the cellphone. After=
 a while, it's possible driver printing error information but the old conne=
ction to AP is still alive and able to access internet. And the connection =
can last for very long time.=0A=
=0A=
The log could be like:=0A=
=0A=
[  +0.005236] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
[  +3.040394] rtw_8822cu 3-1:1.2: error beacon valid=0A=
[  +0.005233] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
[  +0.184770] rtw_8822cu 3-1:1.2: error beacon valid=0A=
[  +0.005342] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
[  +1.831908] rtw_8822cu 3-1:1.2: error beacon valid=0A=
[  +0.005334] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
[  +0.270540] rtw_8822cu 3-1:1.2: error beacon valid=0A=
[  +0.005334] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
[  +1.748539] rtw_8822cu 3-1:1.2: error beacon valid=0A=
[  +0.005094] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
[  +0.283437] rtw_8822cu 3-1:1.2: error beacon valid=0A=
[  +0.005743] rtw_8822cu 3-1:1.2: failed to download drv rsvd page=0A=
=0A=
ssid advertisement could disappear (sometimes ssid still can be seen from o=
ther devices for a while until more severe exception messages printed out).=
=0A=
=0A=
I can look into hostapd's code to see if there's something special there (t=
he tool might work better with intel's adapters), and I saw there were peop=
le making up patches for hostapd to make it work better with realtek adapte=
rs (not for rtw_8822cu). =0A=
=0A=
Any help is much appreciated.=0A=
=0A=
Thanks=0A=
=0A=
Zhefeng=0A=

