Return-Path: <linux-wireless+bounces-23397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B4AC3764
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 02:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7531892C2A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 00:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC701D5141;
	Mon, 26 May 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="De8fivNO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2095.outbound.protection.outlook.com [40.92.89.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6381BC4E;
	Mon, 26 May 2025 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748217603; cv=fail; b=RrCQ02+B2j+Xc3VIgzR6bJ6BUvBgF2wKAadkKWsM2kMssrROvpWtMm3oIDCzbbcttlMTUN4vspeRAygzPhi2MlN6M9gNYe/CJ2yVED38Bj9e4+npaelUhAgmbRIZ7X6ZswcbnP1U3TqjJRm3GOAeZdSe76aOuIn2CseA5ebLlYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748217603; c=relaxed/simple;
	bh=5VwQj1E7iYOsd2Fp+U90k88VN/v197MR/3WiJfI6M2E=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Q/4zKH2K0TEUi51rXYq9rrj/BZYvFepveo12kZSj8dEZcz1W0FgCv0P4IybwDhakoC6px1J5pX+reVCIyYwYBzvfaIg1MvItZbxJqaSQebrmXPN95LQuYJfVe1+7Js6DJSDNVC+RMfwkcFjnmHbqJdDh7vuevY1AkDg6GrofQV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=De8fivNO; arc=fail smtp.client-ip=40.92.89.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdR72pigQo21Tyen8u3p5MoM3doqGaaacJZA0Iudkn3glvD+EKV/ZU1AF3WfqEOlSI9+Jy/BrUdEYrbae5yRXj+93v/9Sc6cKeg0f2kJTsak/tuCqQP1Jf8OlOBj6hsh166phliIlfdyaS8eP2ldQUEKS1l+LPdLOEUq9atjN207pOIUXBU9Sm2z3uSfiaJeniuzkaeyJTHF808zT1RsVVvPhmFlbuYogOI9L18RkQ2RpbWhZffqYXF2CjOsIzUbvx4BvtS9XoK1iPdzSv5nRDerruwp56TUj6lsrfNrJ6WdE1O2IFXoef+muOD3SNlJLUiTIU7O8NIWgthQ7ITHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyQmT1YoAij8K3+QUjarCksoPYs2sDVGRmtld8oniIg=;
 b=a2ovYTj1GCO9zrov+U2q3JMu5obtb/v98jF05eTDKtEQuiRFEHIPrau4yd3HdpPlkxGTNRdnOoh4Y1i17qRDjXBZP+BNrveU5MrPorU6WbtrIDmhFFLfaHo/jssCUiQPu9eKxST/IOqcZjmxLGMA8StIz+t4Z7ruiNGIUQwM+QJ7A9zXImu7XHY1iYfjyLPZ9SR391BbrWzT04kzJsAruG4832nTqiY1Rdq3d7wL8m7TerKzKyqnJsnwSQEvZ3Pssu9iNQ30haB3mMMKen5aY5STxjyAGr6S/X3ZRI7kc1a/wOKGgNnR8ok8iSZP58uXKzNDXfy48nxKky7tfvMMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyQmT1YoAij8K3+QUjarCksoPYs2sDVGRmtld8oniIg=;
 b=De8fivNOdGdZwrha4EaCV0pVubrNCuGq1jk2GwLUwGc+EmYuoPp+L1JZP6X9DcDdkADOsD3rDR0R5ACMSpGO6FQ31GueHA9eiKEG7VkGk4FQjjMSgC6zvstc3OL0Z5GxjnNC78DGk6UO6ceKnJe8vGWB0vL5loZQVFPlCv/jWMIUeAsLmQ3tzSc67TTjzD8OCLIr44Cx21DEcHY/4+xQHXA1Wl1uKxnyFKmsP3cvICHkqxTMrTf3WynveESqS7fgud4ivKYpqbQiGUbszkJ0xuOY9tXIq2GzhU5oEk1kn8WsdY7pi8vPP69lZSzIySeD6BRyBlm6tYnWvXFpxN+Gdw==
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com (2603:10a6:5:3::15) by
 DB9PR02MB9731.eurprd02.prod.outlook.com (2603:10a6:10:45a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.23; Sun, 25 May 2025 23:59:59 +0000
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963]) by DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963%4]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 23:59:58 +0000
Date: Mon, 26 May 2025 00:59:55 +0100
From: Cameron Williams <cang1@live.co.uk>
To: repk@triplefau.lt, johannes.berg@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git bisect] kernel panic on insertion/removal of Redpine WiFi module
Message-ID:
 <DB7PR02MB3802DA6C4DF13BA6D6A4887CC49AA@DB7PR02MB3802.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To DB7PR02MB3802.eurprd02.prod.outlook.com
 (2603:10a6:5:3::15)
X-Microsoft-Original-Message-ID: <aDOu-5fq5P_U8_WU@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB3802:EE_|DB9PR02MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 912b3407-c227-438f-8c16-08dd9be84092
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|7072599006|461199028|41001999006|15080799009|7092599006|8060799009|19110799006|440099028|3412199025|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9BvnxijqTmTNOXKbM/hutMWPptwiDqQRjurpu3FYoc8wqbDNdGci+XE/xnjO?=
 =?us-ascii?Q?rCko97CB68hlitaX3yvULy4ePj7pgtjc+52kO6s3S3FT42dFooSz6qGIZHLX?=
 =?us-ascii?Q?WYkF2o0Y+QWsxePPgcnRN+jETsb8u/2wtoVSs8mC3QrNNjptB0PSiZ7jhUMj?=
 =?us-ascii?Q?A/7VFR//J9isxBSWE6j+JH8fqQGO4cIpDmNGznDRBYPrdVVAbszxqe7J25in?=
 =?us-ascii?Q?H8WvaARHbtywLM8iFjMMAKye8OZGU3KK4RecNPCPGX7K9LBX9nPcfHVi7K4P?=
 =?us-ascii?Q?8DSENrf4jZ3CmkCgHK/wWfuiYyM4oSKPcyYumy/ZcvtX+zcA6gXRD6E62lhq?=
 =?us-ascii?Q?imp3k2uoS17btub++VE0VOJywG+Xfv+IxYjrW7pplrjx7NrxJifHf2uvHfZ3?=
 =?us-ascii?Q?NJ3bfSA6+ZHAfFn6HqiFZ0oEVys20Z+ZMekIW+SQ4IgzoJq0JYPO4KbnagFQ?=
 =?us-ascii?Q?J3aG3nOzhJF8+89KZ5+j46dBg/fjuyA87Xa3jkgtXlbt8aWd0rIEFqlrdrtP?=
 =?us-ascii?Q?so5O+Q/KJZ7WHswuAUp8ZwFwOyE+dN39OSbAt4tx/QD4ZTTLtlVoE9lPxnXJ?=
 =?us-ascii?Q?1c/MVJq30x+KHIm5uOCrqUxh+jEu7aw4bhKqf/U2WuQJTI4NMgkfpN94/VMi?=
 =?us-ascii?Q?vEGJZb9+KO8VTAJbP6Ja9W2VpK8Gvazq88ut7G5qmrHRbwdT/jL13LFKA+fd?=
 =?us-ascii?Q?4Gp6HDkUk6LSugOfALE2mRKqU8WKxQ0tj6t5TlO9P8dpSFINQNyON55rGThS?=
 =?us-ascii?Q?sgHMwWTnS+SCdHpK2RUx8NYZMRzYbwMK9d/ROVS+hjxwUA35hb1tgkqURXL3?=
 =?us-ascii?Q?aU482qzDvPjHDz/+ORev0bPOs+rTxNi+vGhUnpqdkOnCfprndVhVRvoAjEgS?=
 =?us-ascii?Q?TVP3tEmwDDH9MvNDoKCuRY6ijBXiIke+mQGZGGS39C/U7vYPk5zCbP9ec5rt?=
 =?us-ascii?Q?8oHXW4pqZTuF4Wab1yFjBXwfYUgFjCVsCBswHcCF5qPTCl3shJukNxd7ujtn?=
 =?us-ascii?Q?QMvKkBH7fhDP2fLt51szWsaEHvjSxoUXJ5JGWNDv+VKKZyYsYRYTrnBoPDDL?=
 =?us-ascii?Q?c849WhhpMUb8sLqHHP+Qe4cRo0yCYe+m5TC6ffgJ2t6Re816919BTWTkRCze?=
 =?us-ascii?Q?hIo7/JxiN6W4U+cW/YSoOvewwodKQxoHzWdfep5Nlq3u/PfLZMaLd8O4Bl/O?=
 =?us-ascii?Q?8LeRqWunKUovEos2/3FIW8BjTtX92P9tD0iXVtSyyZM97z8YHNCgQBc8CJ4?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bxcdNTSfcjOYf2wq0Xh1YEATpNd1jKZcvDhupY1defXW6B4JeRcv9q6wIj4b?=
 =?us-ascii?Q?wVtvyoMA0uSvoMJn6eHZevlN2FgivyN5POfX7JdKPMptj3pjIVL0EPbwVXK/?=
 =?us-ascii?Q?acf5S8VUAyF9HLJOGByZbnAXdAvgrRtJCi6qht1tB/4S5uZ+u2jwXqra8BsL?=
 =?us-ascii?Q?UvcR60mdMS8G1xgyzuVIUxQRnnnVrA/WWT1zVNF6OjRX/Fj0qXASjYnbiaLM?=
 =?us-ascii?Q?KZiMrFgBy7tDt5oMYIxgjQqLg4jZeND8l+20G8bcRhE83s+MEJP3q5ZppEn/?=
 =?us-ascii?Q?TnBQqSw8wF1yCNLuhaNVQ7ChwlB2A9+xcA6qjp5d1I3a7fOo4fN3Bc6Y7tG2?=
 =?us-ascii?Q?V+hAMey3W00rR144BeEWdg7NwpP6//l7jnBgGug9Orvl60185+pJPT+0FYTU?=
 =?us-ascii?Q?TIUSk4aJ3iA5s1j9GZQgz5bNgKEbZoQTyCv+S9T2Ic4hjhdWXEABe+l7P0no?=
 =?us-ascii?Q?cqUYj5EkO6VVVYYY5tzajNvHV1QdI9LQErePDM6omItjDxU8y4t9UWNCt0mv?=
 =?us-ascii?Q?MqRwicxhVaPjRcHH1ect0JivGkmOU8Xtbl3/Vyy1AXAhTZOIRBEZC9ehdEs4?=
 =?us-ascii?Q?cXeQHfNw3Kj0Q/BTyRxfo/eeZ4wvQ/vzFtsLeKAVeadgtAKZHhGD9a6CV5fQ?=
 =?us-ascii?Q?PgYNXxEhTeZOIaOgprAa1mRQ/jKOotzcoAWMdcJYUyiznwB3YT3zOLu5cywk?=
 =?us-ascii?Q?eVEOEFHAW9W0m6YwnxZi+z8Ulordqk6mrRqA+6MpKzXGybX+s0XwtjSFGlav?=
 =?us-ascii?Q?PaV3x3a4rQFaMivpM/7VXb6kDgiB5BcVDFhE2JaeYcyroP80YRHeNkgh412s?=
 =?us-ascii?Q?D0ldYYO4en/gxUzBM1Fq2otvs13JjcXX6Tpw7xcuEzarMFQlJVPKOulJUksT?=
 =?us-ascii?Q?VSj+x7rUG/ooCmcAQ04JAsnII/L44TLYzLALRQMqdDg8+T3yXvfCbRE8ZVQW?=
 =?us-ascii?Q?MigKTJjXMqCbYeI2qA/KsD9C1kSnWJ+vuB2qPpkDccPdG4a2pLlHucBFMIFw?=
 =?us-ascii?Q?rO6om1qRwmBUUtcQkw8p7N1L+DAYivZWHvotOtslJCwYBhQk14O62375t8O8?=
 =?us-ascii?Q?MHtWTtmyk6x/RYm/9+aHK11Rxa+8rbmmYiLfuqA4jdKeYoskXa3sEnXfNkv/?=
 =?us-ascii?Q?+7vm7MyQIhiJCZD+RK9eLKyUIg1C29X2mu8zdJEmcYh3p76F5SJRgvsq4K/B?=
 =?us-ascii?Q?41gTuq8Fr1VPTwbjXcmVT37+5Xgm84YgcpvqNqp7uuQIZxcFr/K1m5Ay9ms?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 912b3407-c227-438f-8c16-08dd9be84092
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3802.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 23:59:58.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9731

Hi all
I am seeing a kernel panic when inserting a Redpine RS9113 module to my sys=
tems. I have
observed this on stable version 6.12.25 up to and including 6.15.0-rc7 (bot=
h x86_64).
Testing on a Raspberry Pi seems to trigger the panic when removing the USB =
rather than
inserting, though that is using Pi's kernel fork.

I have bisected the commit to 378677eb8f44621ecc9ce659f7af61e5baa94d81
("wifi: mac80211: Purge vif txq in ieee80211_do_stop()").

I am not sure what this commit is doing and how it is affecting the Redpine=
 driver.
This module is mostly found in IoT devices, but I have a sample available i=
f you
need me to test any code changes. The dmesg log is below.
Thank you in advance for any help on this.

=3D=3D=3D cut =3D=3D=3D
[   67.214584] [    T167] usb 2-2: new high-speed USB device number 3 using=
 xhci_hcd
[   67.345275] [    T167] usb 2-2: New USB device found, idVendor=3D1618, i=
dProduct=3D9113, bcdDevice=3D 0.02
[   67.345294] [    T167] usb 2-2: New USB device strings: Mfr=3D1, Product=
=3D2, SerialNumber=3D6
[   67.345301] [    T167] usb 2-2: Product: Wireless USB Network Module
[   67.345306] [    T167] usb 2-2: Manufacturer: Redpine Signals, Inc.
[   67.345312] [    T167] usb 2-2: SerialNumber: 000000000001
[   67.430516] [   T1167] rsi_91x: rsi_probe: Initialized os intf ops
[   67.438176] [   T1167] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.438180] [   T1167] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D RSI Version Info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.438181] [   T1167] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.438182] [   T1167] rsi_91x: FW Version	: 1.6.2
[   67.438183] [   T1167] rsi_91x: Operating mode	: 1 [Wi-Fi alone]
[   67.438184] [   T1167] rsi_91x: Firmware file	: rsi/rs9113_wlan_qspi.rps
[   67.438185] [   T1167] rsi_91x: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.525665] [   T1167] rsi_91x: ***** Firmware Loading successful *****
[   67.525722] [   T1167] usbcore: registered new interface driver RSI-USB =
WLAN
[   67.543479] [   T1190] rsi_91x: Max Stations Allowed =3D 32
[   67.550191] [   T1167] RSI-USB WLAN 2-2:1.0 wlp0s20u2: renamed from wlan=
0
[   67.556261] [    T586] rsi_91x: =3D=3D=3D> Interface UP <=3D=3D=3D
[   67.556286] [    T586] rsi_91x: rsi_disable_ps: Cannot accept disable PS=
 in PS_NONE state
[   67.594527] [    T586] BUG: unable to handle page fault for address: 000=
000008240a338
[   67.594534] [    T586] #PF: supervisor read access in kernel mode
[   67.594536] [    T586] #PF: error_code(0x0000) - not-present page
[   67.594538] [    T586] PGD 0 P4D 0=20
[   67.594540] [    T586] Oops: Oops: 0000 [#1] SMP NOPTI
[   67.594544] [    T586] CPU: 3 UID: 0 PID: 586 Comm: NetworkManager Kdump=
: loaded Not tainted 6.15.0-rc7 #2 PREEMPT(voluntary)  c20f07b4249bbdea71e4=
6edd15ba51691a5df4d6
[   67.594547] [    T586] Hardware name: Dell Inc. Latitude E7250/0TPHC4, B=
IOS A19 01/23/2018
[   67.594549] [    T586] RIP: 0010:fq_flow_reset.constprop.0+0x12/0x140 [m=
ac80211]
[   67.594648] [    T586] Code: 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 8=
9 f5 53 <48> 8b 5e 18 4c 8b 3e 48 85 db 74 6c 4c 8d 6e 18 49 39 dd 74 63 49
[   67.594651] [    T586] RSP: 0018:ffffcf7d40dcb418 EFLAGS: 00010202
[   67.594654] [    T586] RAX: ffff8e3e8240a328 RBX: ffff8e3e8240a328 RCX: =
ffff8e3e82455210
[   67.594656] [    T586] RDX: 000000008240a328 RSI: 000000008240a320 RDI: =
ffff8e3e824549c0
[   67.594658] [    T586] RBP: 000000008240a320 R08: 0000000000000190 R09: =
ffffffff967cf0b0
[   67.594660] [    T586] R10: ffff8e3e82455210 R11: 0000000000000246 R12: =
ffff8e3e8240a338
[   67.594662] [    T586] R13: ffff8e3e82454900 R14: ffff8e3e824549e0 R15: =
0000000000000000
[   67.594664] [    T586] FS:  00007f09d9df2280(0000) GS:ffff8e3fffde2000(0=
000) knlGS:0000000000000000
[   67.594667] [    T586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.594669] [    T586] CR2: 000000008240a338 CR3: 0000000103690002 CR4: =
00000000003706f0
[   67.594671] [    T586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[   67.594673] [    T586] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[   67.594675] [    T586] Call Trace:
[   67.594678] [    T586]  <TASK>
[   67.594681] [    T586]  ieee80211_txq_purge+0x42/0x130 [mac80211 b66c681=
ff5546b41a64cd4e5f21f037bc2e7ea5d]
[   67.594760] [    T586]  ieee80211_do_stop+0x5a9/0x970 [mac80211 b66c681f=
f5546b41a64cd4e5f21f037bc2e7ea5d]
[   67.594812] [    T586]  ? synchronize_rcu_expedited+0x1e4/0x220
[   67.594817] [    T586]  ieee80211_stop+0x5b/0x1a0 [mac80211 b66c681ff554=
6b41a64cd4e5f21f037bc2e7ea5d]
[   67.594864] [    T586]  __dev_close_many+0xd8/0x1c0
[   67.594869] [    T586]  __dev_change_flags+0xe7/0x230
[   67.594873] [    T586]  netif_change_flags+0x26/0x70
[   67.594877] [    T586]  do_setlink.isra.0+0x373/0x1280
[   67.594883] [    T586]  ? __nla_validate_parse+0x5e/0xca0
[   67.594887] [    T586]  ? __alloc_frozen_pages_noprof+0x18d/0x340
[   67.594891] [    T586]  ? __lruvec_stat_mod_folio+0xa4/0xd0
[   67.594895] [    T586]  ? __kmalloc_cache_noprof+0x137/0x3e0
[   67.594898] [    T586]  ? security_capable+0x7d/0x1a0
[   67.594902] [    T586]  rtnl_newlink+0x864/0xbd0
[   67.594906] [    T586]  ? __skb_datagram_iter+0x7b/0x2e0
[   67.594911] [    T586]  ? __wake_up+0x44/0x60
[   67.594915] [    T586]  ? netlink_recvmsg+0x384/0x480
[   67.594919] [    T586]  ? __pfx_rtnl_newlink+0x10/0x10
[   67.594923] [    T586]  rtnetlink_rcv_msg+0x34f/0x3f0
[   67.594927] [    T586]  ? _copy_to_user+0x36/0x50
[   67.594930] [    T586]  ? move_addr_to_user+0x4b/0xf0
[   67.594934] [    T586]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   67.594938] [    T586]  netlink_rcv_skb+0x4f/0x100
[   67.594943] [    T586]  netlink_unicast+0x27a/0x3d0
[   67.594948] [    T586]  netlink_sendmsg+0x228/0x480
[   67.594952] [    T586]  ____sys_sendmsg+0x35b/0x390
[   67.594957] [    T586]  ___sys_sendmsg+0x99/0xe0
[   67.594963] [    T586]  __sys_sendmsg+0x86/0xe0
[   67.594968] [    T586]  do_syscall_64+0x82/0x820
[   67.594973] [    T586]  ? __sys_recvmsg+0x8e/0xe0
[   67.594986] [    T586]  ? syscall_exit_to_user_mode+0x37/0x1c0
[   67.594990] [    T586]  ? do_syscall_64+0x8e/0x820
[   67.594993] [    T586]  ? syscall_exit_to_user_mode+0x37/0x1c0
[   67.594996] [    T586]  ? do_syscall_64+0x8e/0x820
[   67.594999] [    T586]  ? do_syscall_64+0x8e/0x820
[   67.595002] [    T586]  ? do_syscall_64+0x8e/0x820
[   67.595004] [    T586]  ? do_syscall_64+0x8e/0x820
[   67.595007] [    T586]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   67.595011] [    T586] RIP: 0033:0x7f09dacabe22
[   67.595027] [    T586] Code: 08 0f 85 21 41 ff ff 49 89 fb 48 89 f0 48 8=
9 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 0=
8 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[   67.595030] [    T586] RSP: 002b:00007ffd1fc27dd8 EFLAGS: 00000246 ORIG_=
RAX: 000000000000002e
[   67.595034] [    T586] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: =
00007f09dacabe22
[   67.595036] [    T586] RDX: 0000000000000000 RSI: 00007ffd1fc27e70 RDI: =
000000000000000d
[   67.595039] [    T586] RBP: 00007ffd1fc27e10 R08: 0000000000000000 R09: =
0000000000000000
[   67.595041] [    T586] R10: 0000000000000000 R11: 0000000000000246 R12: =
00005611e474f8e0
[   67.595043] [    T586] R13: 0000000000000055 R14: 00007ffd1fc2800c R15: =
0000000000000000
[   67.595047] [    T586]  </TASK>
[   67.595049] [    T586] Modules linked in: rsi_usb rsi_91x btrsi ccm iwlm=
vm btusb x86_pkg_temp_thermal joydev btrtl intel_powerclamp mousedev btinte=
l coretemp btbcm kvm_intel spi_nor btmtk dell_pc mac80211 cdc_mbim kvm mtd =
platform_profile bluetooth cdc_wdm cdc_ncm cdc_ether qcserial usbnet mii us=
b_wwan ext4 irqbypass libarc4 polyval_clmulni polyval_generic ghash_clmulni=
_intel iwlwifi sha512_ssse3 sha1_ssse3 aesni_intel at24 crypto_simd crc16 d=
ell_laptop mbcache processor_thermal_device_pci_legacy cryptd spi_intel_pla=
tform jbd2 intel_soc_dts_iosf iTCO_wdt processor_thermal_device rapl dell_w=
mi processor_thermal_wt_hint mei_wdt mei_hdcp spi_intel intel_pmc_bxt mei_p=
xp intel_rapl_msr iTCO_vendor_support ppdev intel_cstate dell_smbios cfg802=
11 dcdbas dell_smm_hwmon e1000e psmouse processor_thermal_rfim intel_uncore=
 i2c_i801 dell_wmi_descriptor processor_thermal_rapl ptp mei_me i2c_smbus i=
ntel_rapl_common wmi_bmof sparse_keymap pcspkr processor_thermal_wt_req lpc=
_ich mei processor_thermal_power_floor pps_core processor_thermal_mbox
[   67.595135] [    T586]  parport_pc int3403_thermal parport dell_rbtn int=
3400_thermal rfkill acpi_thermal_rel int3402_thermal acpi_pad int340x_therm=
al_zone i2c_dev sg dm_mod crypto_user loop nfnetlink bpf_preload ip_tables =
x_tables crc32c_generic i915 btrfs drm_client_lib i2c_algo_bit drm_buddy tt=
m intel_gtt drm_display_helper blake2b_generic serio_raw xor drm_kms_helper=
 atkbd raid6_pq libps2 vivaldi_fmap sha256_ssse3 cec video i8042 serio wmi
[   67.595161] [    T586] CR2: 000000008240a338

