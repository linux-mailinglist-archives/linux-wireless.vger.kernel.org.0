Return-Path: <linux-wireless+bounces-28389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CADC1D51C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 21:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5C94E04AE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A430DEBF;
	Wed, 29 Oct 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fit.fraunhofer.de header.i=@fit.fraunhofer.de header.b="LUhB72tD";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="GN0S6xTd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-edgeMUC221.fraunhofer.de (mail-edgemuc221.fraunhofer.de [192.102.154.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EA312823
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771449; cv=fail; b=kLhOLP1Cr7ZAK83n2SbwlAwnbXN7Hcw6S23shL6d5WYAKciGoCs+D7O1NI+rJl2uqlSSNbmmCvHtJHtjdoEr6w4MGIYE9ZteEdWQgbxE3mmPh1DuToLTrHZx9Pu8PmgQ3mFd4ZZKaQQLWGof0QNItYwhTivmK2GSaKFqa59+Cto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771449; c=relaxed/simple;
	bh=0hYTqfYFZepXeht00BuqD4Kc/2SUu2J/obeRvhtKKgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9Eqy+/4vHoMHwRHzlId81+icBEHQzVtiq/UfojovTCFWhMn/x8YiuCEuHWp4yvfh+8yU05vaPcf3XjKcSnRFVu9DpBwPb0PfZrNf54rvY4R6iYgsk79+bdg5xBoQQcBbYBCfxCy95DxCmt9abQbDmBFqyyBhTDvIDukX13UL8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fit.fraunhofer.de; spf=pass smtp.mailfrom=fit.fraunhofer.de; dkim=pass (2048-bit key) header.d=fit.fraunhofer.de header.i=@fit.fraunhofer.de header.b=LUhB72tD; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=GN0S6xTd; arc=fail smtp.client-ip=192.102.154.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fit.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fit.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fit.fraunhofer.de; i=@fit.fraunhofer.de; q=dns/txt;
  s=emailbd1; t=1761771444; x=1793307444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0hYTqfYFZepXeht00BuqD4Kc/2SUu2J/obeRvhtKKgQ=;
  b=LUhB72tDJyhXo+G8FjLNNwOqP5o9+tn2pT7JhyPioE7T63Gr++fqUAbk
   q1wcTWqB946E+GEkRp3Kq5cXPFvQKupi/GDocvTXSUcQS6UPA+xMSajVx
   sSRMUeycegy2sbj4qf1/7f43vld63bTr5f7VVeaqwgNC+qOBpgvJlyqH7
   ICT9foO+DK7ptZ21dhktricillQj+QCgXaPD6/xBrOHMi0u4jbnKxiVs+
   u9Or4Rp0P2JSMQMF/NmyowitTm/Dtnckmjjv589HchuW5XmFy6VoZPDga
   +l0ZfHLEd+Dszk3QeEBHFLsaHwsBjFGPqTRLfV9qlHqDQy8Ci6YVKI0lS
   w==;
X-CSE-ConnectionGUID: 3tUM61uKQpGczpFzEgtXAw==
X-CSE-MsgGUID: JVELbUlLRTaeUuUilcOtUg==
Authentication-Results: mail-edgeMUC221.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2ESBQCWRZ5o/xwBYJlagQmEE0ABgiSEVZF0i2SRC4JQA?=
 =?us-ascii?q?1cPAQEBAQEBAQEBBwEBUQQBAQMEhQACFowPJzgTAQEBAQMBAQEBAQIFAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEGAQIBAQEECAECgR2GCUYNgluBLIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QI1VgEFIxEMAQE3AQ8CAQgYAgImAgICHhEVEAIEAQ0FGYUNBBIDMrFzgTKBA?=
 =?us-ascii?q?YIMAQEG2ykNC4JHCQkBgREugxBthDYeAYFtcoMNhHeCDEOBSoJ1PoIfgiSDW?=
 =?us-ascii?q?4JpgzyMMYQ0iVYJSXgcA1ksAVUTFwsHBSU5QhAzAyAKNBUcAhQNDwESDwQWB?=
 =?us-ascii?q?S0dcwwoEmuEG4QoK0+CInWBAQ8BZkEZP4NTHgZrDwaBFRkeLQICAgUCLBc+g?=
 =?us-ascii?q?V0XBQEeBiASAgICAgKBA0ADC209NwYOG0OULINngR2BRJNZJhKDY60SgVNmC?=
 =?us-ascii?q?wMEA4I1gWebW4ZJl2CTC5kGIpFvlwUCBAIEBQIQCIF/gX9xgzZSGQ+OX4NCs?=
 =?us-ascii?q?yB4AjoCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 eeNgiZ+JztCkJQKwH7D0r8E21AOzSppclGQ
X-Talos-CUID: =?us-ascii?q?9a23=3AJ2elLGmlGCwgK7TEoBW8bVTmCdzXOSbB8VKOelK?=
 =?us-ascii?q?bMH5GQ6+NZ029979UutU7zg=3D=3D?=
X-Talos-MUID: 9a23:0K9dZgvC1aNYkXFvf82npg9PEM1V54CUNEkArIg7us2PEjBNNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,290,1747692000"; 
   d="scan'208";a="13752233"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeMUC221.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Oct 2025 21:56:10 +0100
X-CSE-ConnectionGUID: Tk9wldwPTRK0pXMuPLH2hQ==
X-CSE-MsgGUID: zIROehm1Rz+qjvuIt6dfeQ==
IronPort-SDR: 69027f69_8rAfVezUEMfHrlUniB3KnSusR/MFtOOUd9OaWdkBdO6jZwf
 h7hW4mPI9PbkxxkniCP1yFtasxFz7pJnnHGqYMw==
X-IPAS-Result: =?us-ascii?q?A0CDHAAVfgJp/3+zYZlaHAEBATwBAQQEAQECAQEHAQEVJ?=
 =?us-ascii?q?YEtgVYCFFJAAYEhgQmEVINMA4UsiHuLZJELglADVw8BAwEBAQEBBwEBFD0EA?=
 =?us-ascii?q?QGFBwIWjD0nOBMBAgEBAgEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQEGB?=
 =?us-ascii?q?YEOE4ZPDYZbAQEBAxIREQwBATcBDwIBCBgCAiYCAgIeERUQAgQBDQUZCYUFB?=
 =?us-ascii?q?BIDNgICAqUsAYFAAoslgTKBAYIMAQEGBATbIg0LgkcJCQGBEiwCAQGDDmyEN?=
 =?us-ascii?q?x4BgW5ygwyEeIIMQ4FKgnU+gh+CJINbgmmDNIF6hC2SQAlJeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFJTlCEDMDIAo0LQIUDQ8BEg8EFgUtHXAMKBIQHxgRYD0XQINJGwZoDwaBE?=
 =?us-ascii?q?hlJAgICBQIrFzqBaAUBHAYfEgIDAQICOlcNgXcCAgSCHn6Bdh8PiQ8DC209N?=
 =?us-ascii?q?wYOG0OUOIM5gR2BRJNZJhKDY60SgVNmCwMEA4I1gWebW4ZJl2CTC5kGIpFvl?=
 =?us-ascii?q?wUCBAIEBQIQAQEGgX8lgVlxgzZPAxkPjl+DQstLRTMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:sEL4hBVL3nKMdqmz1optNNYX2mHV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsKpshrGr+RM9huXJf37TaxsAR6/9
 os3axSv0hw6KmQbt2bdh/ZujL54gx2Y8k8aocbeNa6zbMEgbp/RVOkBVUxRVONtWgpsWL23f
 pADVtAZZuFdpdHnjVoprTePLgX2OdPU7BVjhETv/vwYyME/Sh7L7T58Nu4UqV3t8/T5DotMd
 tjk4ZHwlWryb9Jtg3DEzbjBdlMDjNu1dpR0bNPU+UNzJx/J0nGr9K67PmqHzbgsrDSi9dNPW
 PuohXAXtC1B+xaB990lqdiZlIZOkFzfyXtX5NpqAP6EelQrRPGdOc4D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBwTu5BKCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23: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
 jzWcW8+Em/oaFyoq/knDAjLBW9z3tAzB+o=
IronPort-HdrOrdr: A9a23:Erv7BqmzOelfSj2ioW9Y1HZaBtHpDfOEimdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcIi7SdS9qXO1z+8R3WGIVY3SEDUOy1HYUL2KirGSjAEIeheOu9K1sJ
 0PT0EQMqyIMbEXt7eY3OD8Kadb/DDlytHnuQ699QYUcegCUcgJhG0ZajpzUHcGPzWubaBJTK
 Z0jfA3wwZIDE5nCPhTcUN1ONQryee79q7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFuxaR3NTjj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVaXaGYtjxdmpDu1L9qqq
 iOn/4TBbU315rjRBDwnfIr4Xim7N8a0Q6h9bZfuwqknSW2fkNiNyMLv/MnTvKQ0TtfgDg76t
 MR44vRjesmMfuL9h6NluTgRlVkkFG5rmEllvNWh3tDUZEGYLsUtoAH+lhJea1wVB4SxbpXZt
 WGNvusrcp+YBefdTTUr2NvyNujUjA6GQqHWFELvoiQ3yJNlH50wkMEzIhH901wvq4VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRDsFb0BOXjKt5nriY9Fr92CadgN1t8/iZ
 7BWFRXuSo7fF/vE9SH2NlR/hXEUAyGLEPQIwFlluxEU5HHNc/W2He4OSMTeuOb0ociPvE=
X-Talos-CUID: =?us-ascii?q?9a23=3ADuB0PGnwwJxijCQuUJ2OZYM2uxnXOUHenWjUL1C?=
 =?us-ascii?q?ANVxKEKWlbEKo3IM+k/M7zg=3D=3D?=
X-Talos-MUID: 9a23:ZLqh1QYbkq6EleBTpR7WozxiMZ5S8ee3Cl4QsIlYt8eJDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="44677081"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:56:09 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Oct 2025 21:56:08 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.7) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20 via Frontend Transport; Wed, 29 Oct 2025 21:56:08 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKfxWQ2gG/J2CM7AePtuKrXtcG1qgMM7asZaU3EtJ280zQ/0uORRoKCOZVz0xioa15ZHRDR9LMJCbhRwKG2eIRTOFuRPORcr0PoRkitqPWxXPH7Z55jIhJv/83pUF6Dumhx+ONXROAbutct/np3uf6ToYdUCdBdYoJDzgdPzTnqk4xuyY4regk+yjW4lTSD62keEyTLIJYVGJI+T3Ub3pvLAXSna9l57DLmehZn+dxk9mrPMQeYt4iUSFudqA1yxLFgrWkwlgLliAGNhe7QYG+hpgdap8w0LoUsPlD8JeYpravbDpLPH6u/1/M6NiEiyFOaDSc/DruIrJlXOnrLOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hYTqfYFZepXeht00BuqD4Kc/2SUu2J/obeRvhtKKgQ=;
 b=x4/SxJQLxDCv0GRn5WTd6f9TBTysGP3Bbgw/jnOnLKfC822FpDz5c+vC6DZXFtVPIYbLWCTvE728nM3MV69VvPkjIrVf8dpPUumbySqAoLNmERZXdBJqJgjc0kt9BS41Zk8vnv2UFgyng2CzZGVAgpsSqJipPknT7vAu0+p3w946AQFnVOXDdsovBccrwJPNF7DbQYAfuhrL+IJ4azyNcElSG3f0yOZLGxrlBJ5PV87ThHCWdhbN0/ctnK25Zw8yHb9+DhDgdCX1WYqb90Ix9ufgvMHR27jAf/xSxjID5/QR8xgCjVcpH/yo1US7FtLOlaROGPRPNxrj6fWctBNFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fit.fraunhofer.de; dmarc=pass action=none
 header.from=fit.fraunhofer.de; dkim=pass header.d=fit.fraunhofer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hYTqfYFZepXeht00BuqD4Kc/2SUu2J/obeRvhtKKgQ=;
 b=GN0S6xTdARsxNxbMTeNE2Vcysd1Rp3omb0rBiOhDYCd2UXSNBCjSqK9JsMv3weYZ4ATrqAQ7IdRD6OP9EPP07YhIS2/QMXal+JEBQCNluqmXb4Xtd4LS5J6i1zs4Iw4QrQGeqofvXwDX1FFYraK98zl32dsT6FL47MKTZr8MGQA=
Received: from FR2PPF8A4D19C63.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::60)
 by BE1P281MB2548.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 20:56:01 +0000
Received: from FR2PPF8A4D19C63.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1a56:eccf:3346:5602]) by FR2PPF8A4D19C63.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1a56:eccf:3346:5602%8]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 20:56:00 +0000
From: "Kretschmer, Mathias" <mathias.kretschmer@fit.fraunhofer.de>
To: "baochen.qiang@oss.qualcomm.com" <baochen.qiang@oss.qualcomm.com>,
	"jjohnson@kernel.org" <jjohnson@kernel.org>, "klaus.kudielka@gmail.com"
	<klaus.kudielka@gmail.com>
CC: "andreas.tobler@onway.ch" <andreas.tobler@onway.ch>,
	"yannick.martin@okazoo.eu" <yannick.martin@okazoo.eu>,
	"ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-current] Revert "wifi: ath10k: avoid unnecessary wait
 for service ready message"
Thread-Topic: [PATCH ath-current] Revert "wifi: ath10k: avoid unnecessary wait
 for service ready message"
Thread-Index: AQHcRuPy4jnvSoC/yEqtcS3v+tzj7bTWRqAAgANYdAA=
Date: Wed, 29 Oct 2025 20:56:00 +0000
Message-ID: <7bd5d469d017fd4ec0f2d64c1fa9adb41b435b21.camel@fit.fraunhofer.de>
References: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
	 <97ee879e4f80c3746f6b79ef5ed1d45f452f8ce7.camel@gmail.com>
In-Reply-To: <97ee879e4f80c3746f6b79ef5ed1d45f452f8ce7.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF8A4D19C63:EE_|BE1P281MB2548:EE_
x-ms-office365-filtering-correlation-id: bfcb3ef3-d149-40f4-9f2c-08de172d9128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VjI0dUdEVkpvbHFiMUVzSE9GRXNaV1dQRmkreDd4Mk9jd3RXT3Z6QjNSWHF5?=
 =?utf-8?B?UUJQVm0zTGY0MlMydVVka0RGME9JOG1oZ0UzaHM3OGVvbFF4b1dvd29PZWpU?=
 =?utf-8?B?SFdpOUVMRm05RnVGSEQxRDZEMlBSVXBsMDZublpLckJsZ3FBZ2djSWVseGpM?=
 =?utf-8?B?OGxyd0JCMEFBS0s4NC9zdHRHUktkYkhXRS9rUjlyeUlVZDNZK0kyUTljdW0x?=
 =?utf-8?B?em1DOEpjVDRYRkNFQkRuOUhOZkZ3MjBubTkrY0VsQWE3ajhUMktZa000ZDF2?=
 =?utf-8?B?NG5JUkcwUDBGYkdjYkt5aDRPaXZObWFGTUlNd0RkYTJueXgwaEhEay9zWlds?=
 =?utf-8?B?NEp3b2QrMzAwWWxHSGZ2TjgydTJYbjJ5V0dWWUI3NmZhVTZiNGY3cnI0eC9o?=
 =?utf-8?B?bHMvdHVuQjBjMXVtaGdLZTFWUHVyUHNlSXowdTNXcnRVQ1BDcWlwbkMyaEZP?=
 =?utf-8?B?aXRGNXFGYWF6eTRVVTk3YU1jTVdSOVZmM1VNMzNGY3M4Z05NSUozUXZoZ0Y1?=
 =?utf-8?B?U1dtZi9iS0RKdWVRQXE0N3NPMDBQVDFIRGx5Z1NTNTdXbWhIcFFyWGJRS2tx?=
 =?utf-8?B?bGxVMm5KSkQ4MU1vbnYwcUlEWlFEcW1QYzJJL29RZitVOHVncEdLdGhTUmo0?=
 =?utf-8?B?QWZOVndrT2NFaExsbE5qRVZHL3ZmZHIyVG1mNnJ0Ly9SdWFTUzN0OWh2N0d2?=
 =?utf-8?B?Z3NnVmd5RUdYU3RFNWhSY0VBYmJqV0RnOFBTNG1FUDJQbHNsd0NjbHlzVWx3?=
 =?utf-8?B?SHJtaVpUcmNnOGVWenI4aXVWYkN1VmJMckJFVlJ1NVNPOVQwZzJtUUpVdnMv?=
 =?utf-8?B?MmVCSVZYNi8yU3VCT3Y4eGZzRDU2MG5DcnEwRmlnSC8zTmhqTWpqTkxNUFh4?=
 =?utf-8?B?b0JONzIwU2J3QXZEWmo4NUNvWVc1ZE45ZExIQnBBSmI1aFNPKzBvanpJWVl0?=
 =?utf-8?B?a2hRUXM3QWF3Mk9qU1dIMjJCL3Y1MVVSUzMzYkdpamluQ3dLWmI3endGelJs?=
 =?utf-8?B?M0dPeEVBQWhXVUpZbHFjU3RqZjJzQlM4U05naG5iYUtZQVZ0cVN5ZkpRbkVE?=
 =?utf-8?B?V0VKZ1lCcGR6R2duOFhMcWJ5bnMybFFkM2JMMTYxbE40Y0o2UVJZQ0ZwMTFJ?=
 =?utf-8?B?eUVnM05LdkE2K25tUUVyTllWWHVpWm9LWTBzVkpiQ2JqNDgwaG1CeHlZenUy?=
 =?utf-8?B?enRSQnRFRGdLZmk4aFhPL0lkRkdyd1Z1SnhQTnNBbmNqcithZ29hR3ZDSFFk?=
 =?utf-8?B?bVJPZjFBQTd5RCt1dWM4d0lFYWdZNEt0cEVIOUMyc25KTk93Ym8xb0crVGww?=
 =?utf-8?B?UmlFaDlIV1FnRkVSR1oxeVdmVnRkKytVOVBXUXAxNlMydnM5VnNtNi9MMG02?=
 =?utf-8?B?TWRCN1llcFNuSkdTWHl0QXdGSUp3Z0szdnpxcS9nL3NjUWRpR1I2L2VmMTcz?=
 =?utf-8?B?dndVTkdWU28yMENJQ29xd2hoNHNsSUJ1RHR3KzE1K0MwMmd2YWZWSFFNdG9x?=
 =?utf-8?B?SEdYM0pmNGNIU3kwd3EzZi9JbE4rejBYUkNHZTdSOVhOUFk5TXBPVUJkbU1j?=
 =?utf-8?B?Y0JydTQ0T2xvWnZWdW5BWnJQT1Q3V1RnUy9WRGNNZlNJZzVrVWZOMUg5Zllq?=
 =?utf-8?B?TmQzTmFWUC9rT1JHWm4xdjk2blFWSDdrZ0IwaTN5NEx1M2ZIR014djJmVkRV?=
 =?utf-8?B?d0tNZWQ2Z2E3T2J4OUIycFhRSGo2UWhJNDFkb3BmQUZQU1N0YXhzbzQvanlz?=
 =?utf-8?B?UkRiQWpMV0Riaml2dXhDQTY0VmZsdVBJeDJIdHoweUdOMnFRUkhHYnZ5U0Rj?=
 =?utf-8?B?MUJhcDQvY2svTWlhSm9aMjFSK2tHamFOUW5qSXF0OUljZkJOdXFLUDlNUkNF?=
 =?utf-8?B?S3FhdTMrSU1rL3lvRm9tMlpGaGRRbEhzL2lvSGxZUTVBT3FoZGJrV3FrR21Q?=
 =?utf-8?B?QjQ4QTRNNjlqSU1EdHVESzVuYWZBWmVIOG5pMmtZTDZjUzN2NjZZdmtFdjl3?=
 =?utf-8?B?UUYvUk5oMHQ5NmRQYnhKYXpYNjVodU12RlptRTI1elBuQ0IzM0JzZ054Y0xO?=
 =?utf-8?Q?lMUMdg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF8A4D19C63.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlFkblE3ZTJ6UDZvb2g0ZlB5YStDWDl3c041b3lxY2g1MnZScUdSQXVPV3Ur?=
 =?utf-8?B?bWNmd00xS3ZFREVFNGlaMm1UQWRBdkdPSkd1WGZRKysxeHVjcUtjY2gvc3Rp?=
 =?utf-8?B?ZlhsUFJMZ2lBbzRZSGhHMGx2azZEaUpRV2tJUU1DYXhvMHJITG1OMU9vUTlv?=
 =?utf-8?B?cncyUndYMzNGTkNLdnoyYTZudEhPS3FFTlpuNVNVM1p6MVlXRkdVWFgyZDYz?=
 =?utf-8?B?dXlUcUhrYmpqNWhNT2Z4NnQ5d3J3R2Q0UWtHSzREUTFKZElDTjhST1dRSHNP?=
 =?utf-8?B?NWZ5dXRvNE1jbzRyN25zSEtSdThocUFUcXhqc3k2SkF5MWRBenhEd2FHaEhu?=
 =?utf-8?B?UVRZVCtlNzJ5cUhHcGxuUldXYXNlV1M0QnFkZDB2ZmZBbVBtcEhFWGdteEpS?=
 =?utf-8?B?Y3oxLzlpcjhpWmxmTEdyT1czT1BmTnZjUnllUDlQZ0hMS2FSaGNqd2Rlc2c3?=
 =?utf-8?B?TG1oUk5nSVgxS1Bmaml4eEFFMlF0b3BDcUl0RC81MkswMFF0ZmNMM3ZNdTVk?=
 =?utf-8?B?MmJzbGpOVW9lUzlhNWVKUXVvMHExNStiWjdJRm1zTjZ2NW4zNGFmVFBEQmhC?=
 =?utf-8?B?VEJ2SFgyL05TRTlIK3pvMXVVMkdMeUx3N1V0QkZ5VjM4NTZ6SmNqN0dSRldw?=
 =?utf-8?B?YndBOEE5QXhXNUgzakVzOHNrelpJWWxKNjdoV3c5TnZDOTFiOVJxRXJHbWV3?=
 =?utf-8?B?OU95YmdqdGFoTXM4MG4zWUx5OHMzY0NrWVBGYmhHbUdrZDc1YUZMZ3ZGUWxJ?=
 =?utf-8?B?MFVLczgwSzhnTUNGSW1UTEo3elUzL1RxQVNXM0FrVGU3OHY3eXpmYm04Tzdk?=
 =?utf-8?B?YjVncHpVQzlIOW5BR1ZVSW05RXAwdSt3NDN3NUJQVjIrenJsUS91aTcySzRV?=
 =?utf-8?B?cy95MnYreEdxaElEcWZNWVpIem1aV1RjM3RKRUxBZEF5cG1YNFRCQ2FYWTdv?=
 =?utf-8?B?VENuR1JsU2xuWFcyWjZrWnBqcWRZVUIzRFJBY003VjZMUUkzNmlwUjVNN0ls?=
 =?utf-8?B?bnV5ZEtja3FSd0FUUEZ0UGhTYWJPaVdzWU1pSFNsazh1bjdJSFJUY09oMTg3?=
 =?utf-8?B?Zldjckpxc25kcHI3MGNqNEI0YXRjallJK2I0d2gvSEhqN3AvNWJIamMvWGVD?=
 =?utf-8?B?MnR3U3BpSXplc2dXWjJhS0w3UWZZano4NGtZQ0Y2YVlsV0NTTWt1eG5lQ3Fq?=
 =?utf-8?B?eisxQmx3dmhKcnZkbkZybVpDcGtmckhibnNsVzRRRGVabElPTnhJeUFPMHF3?=
 =?utf-8?B?RWFPTStnSWRqUGNwNEZEdUdQSEJGWlIySTZmd2pLVnJxUGx4bXZHVzhRRHYy?=
 =?utf-8?B?aTV2K0xkVnRDR3ZKTzdhSXB3eGxLeWRtTlpvMks5SitQWnl0TmtpNDNGb1hE?=
 =?utf-8?B?NVZVc0I0TmdpZ2Jsd2Fnc1BrdVgvaDhocTRIeXV2Yy9iZE55dm5RNlNINHcx?=
 =?utf-8?B?OGN2WDZoaytSNG9FUW1Bc21FVkpwOWlmcTVXdFBoYm1UOGt3VW91VC9hdHBJ?=
 =?utf-8?B?d0h2TEJadTBrNzdNaXE0Wk5FL05tVkkyb0VmOHFzTE1HZGtuTE1kaWFnRS91?=
 =?utf-8?B?MTJQd0NJNHd6T3kxUHdCeVM2MmQ0cytxbnpHSlNHWG50T3FsaUk1S0xGVjgx?=
 =?utf-8?B?VkJmd0NjTXo3cDFJakVMQ0VmdUlEUEJ4RkNnSXY5UFdnKzdOZjFlZTVZeGVI?=
 =?utf-8?B?anAvWWhLc1F5VS9EeUNSc1BzU0t3Z3ZDYXNiTHlNOGN6QVhtZFFLQVRtK1dG?=
 =?utf-8?B?NDBqWVgzRXdUU2c5ajUyU0pGVGpJOGl2Y2xqdytPajE1dk9pbkRLb3dWblVt?=
 =?utf-8?B?NjFlVyttbGZ2UzNoV0ttWUY0bXVtOWZEQUllUFZDV3pmZ3ZqbkZzZGlZME9Q?=
 =?utf-8?B?TFN6MEtmWXNMejBPSERUcmlRV01OQkQ3bStDNVc1c3hIdWMyL2NKcDJNMXhu?=
 =?utf-8?B?Sm53V05EUURxSHZwRTdlTXpoY0ZXMldzUDd1eE90d2kzSERxZFNUNlI3cU5l?=
 =?utf-8?B?c0I4YW5ZclZoZVdNeG9paFNHYmRvMFVpamtNNmNtU0I2cXNqWS9aUTNTQmg4?=
 =?utf-8?B?aDdTYUpiNEZrcE1GMWpWRkhUU05HV3l0cmRaOGtHdXdoTWdzSFZTSVl5ZDl6?=
 =?utf-8?B?bjJ2c3JvVjdtL2NiYk1Yelp1NGVEMnc1dWpiSlloNXlNU0V0Zks1ajd5YS96?=
 =?utf-8?Q?4osAz6ov7Ar/QyPXUzXibihbBE5gjauRPdnGji0ENDxP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3839ED4EE24934B96FA67C6FAB79188@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF8A4D19C63.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb3ef3-d149-40f4-9f2c-08de172d9128
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 20:56:00.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvCGchrNxbOPdRrLihb84+CIQeRDp2MFoJQGGRlgYsJQECbnqznCVSQf62qsFekGhFVugGeteU8LHSu68jR0BnWhDYuz3JXk030fCx65iIqBepSmVDDQNvgnURhUcg/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2548
X-OriginatorOrg: fit.fraunhofer.de

T24gTW9uLCAyMDI1LTEwLTI3IGF0IDE4OjUwICswMTAwLCBLbGF1cyBLdWRpZWxrYSB3cm90ZToN
Cj4gT24gTW9uLCAyMDI1LTEwLTI3IGF0IDA5OjQ5ICswODAwLCBCYW9jaGVuIFFpYW5nIHdyb3Rl
Og0KPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgNTFhNzNmMWIyZTU2YjAzMjRiNGEzYmI4Y2ViYzQy
MjFiNWJlNGM3YS4NCj4gPiANCj4gPiBBbHRob3VnaCB0aGlzIGNvbW1pdCBiZW5lZml0cyBRQ0E2
MTc0LCBpdCBicmVha3MgUUNBOTg4eCBhbmQNCj4gPiBRQ0E5OTg0IFsxXVsyXS4gU2luY2UgaXQg
aXMgbm90IGxpa2VseSB0byByb290IGNhdXNlL2ZpeCB0aGlzDQo+ID4gaXNzdWUgaW4gYSBzaG9y
dCB0aW1lLCByZXZlcnQgaXQgdG8gZ2V0IHRob3NlIGNoaXBzIGJhY2suDQo+ID4gDQo+ID4gQ29t
cGlsZSB0ZXN0ZWQgb25seS4NCj4gDQo+IFdpdGggdGhpcyBwYXRjaCBvbiB0b3Agb2YgdjYuMTgt
cmMzLCB0aGUgZm9sbG93aW5nIGRldmljZSB3b3JrcyBhZ2FpbjoNCj4gDQo+IDAyOjAwLjAgTmV0
d29yayBjb250cm9sbGVyOiBRdWFsY29tbSBBdGhlcm9zIFFDQTk4NngvOTg4eCA4MDIuMTFhYyBX
aXJlbGVzcw0KPiBOZXR3b3JrIEFkYXB0ZXINCj4gDQo+IFRlc3RlZC1ieTogS2xhdXMgS3VkaWVs
a2EgPGtsYXVzLmt1ZGllbGthQGdtYWlsLmNvbT4NCg0KNi4xMi41NiArIHRoaXMgcGF0Y2ggYnJp
bmcgdGhpcyBkZXZpY2UgYmFjayB0byBsaWZlOg0KDQowMjowMC4wIE5ldHdvcmsgY29udHJvbGxl
cjogUXVhbGNvbW0gQXRoZXJvcyBRQ0E5ODh4IDgwMi4xMWFjIFdpcmVsZXNzIE5ldHdvcmsNCkFk
YXB0ZXINCg0KVGVzdGVkLWJ5OiBNYXRoaWFzIEtyZXRzY2htZXIgPG1hdGhpYXMua3JldHNjaG1l
ckBmaXQuZnJhdW5ob2Zlci5kZT4NCg==

