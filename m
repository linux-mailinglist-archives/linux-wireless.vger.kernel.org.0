Return-Path: <linux-wireless+bounces-12454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DA96B0E8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 08:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691B81F25C7E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 06:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788A824AC;
	Wed,  4 Sep 2024 06:04:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2117.outbound.protection.outlook.com [40.107.122.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703BF9D6
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429892; cv=fail; b=u7WfnnUlf7bZI7SFEU7hTxUEFzglI7nFTeOWgI8NNoR/FAPWvHyTzBf7/c+XV6QeA+G7HsiuKrbKZ2HjXtCucnboZpKenYGV6QmmxBIrU/7nD7U4zRF721GaC8nbX942PhWW2Z7QNfn9gvOWpxqtDi8mYoyH9YVD5SmEt4NmTc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429892; c=relaxed/simple;
	bh=eDM93+Gg42MGfLE/GiaFyk4XZbb2ASCP7IWkImlqq60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=isXBjfCJrsO7Yh5TRgc0O5ysPY/hXb58anJT7VbwkA1m+pqyn4bqfDcVbwnayj38aC47KD8S2gr6Fk+etY4itNezmPXhPykGEHc1s1VceD6Hk4yju6CVfnsL3wRZnSgVtI0Eih95W9fcT+t4b3JinnExeDNIwiGty3lvDomXBbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3adesign.co.uk; spf=pass smtp.mailfrom=3adesign.co.uk; arc=fail smtp.client-ip=40.107.122.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3adesign.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3adesign.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueYgPefD/IxbcBUkXqunIBxRrm4EICawjK/XxmY9Rqkh2tflDuRYIZs6vYudDfJ2md3MzINmgtgMJ+5yQfVeLHwWge587Df4QlA6DskhF/w5PnYnYZLBIL+VVYeVVOkaWSxwVwpQ9ZMgls8wTII4QXm3cINr0neRv+1FGj9DwnX9iUf4BilflNNNiamE6JW0qT7ldQhqaIue7x8l+GzJfg4UJxxjLtsjYCQeojpOt4bs8sfsASYhViyw8zpPdVexCYRThxk1+dZ/7DV8KWoq+8yCSL7nG9PML1gZLXwrCaDjvVcrpkPwBKcKRo6Q/kQnlca6EnJoJNTn7cYG3Wk0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDM93+Gg42MGfLE/GiaFyk4XZbb2ASCP7IWkImlqq60=;
 b=jBwPzRk8Ym1CIqwEWMQxyPz8wIAfjV2GSY5+aePRH4WeaeA/OL43SF58WbhplfJsBIc0HO5LZOIG70fuW1qqBSvhsYhd8ypP650bYg3UThA42s97jauaOVwme0aR7eVKK1vFsNVA7YGIczydZp4Jwt2bUfyyi+uePVnC4van5YvmnIEJJnCxQ5stKN4VJkwzyLc/r8bXtYDfjpj/vvo5+LGQf5MlCQZYduTM9KQTQSVaBwcK/jWOqZkNgiHATo5pQ3ICgxMEKBFcH7dG/gIW7T/A3+AZQNBjKOpIbfn2YcGMRJU1KKgwVQTixn0ds9npmAr/pZF3sHzqVnifuASZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3adesign.co.uk; dmarc=pass action=none
 header.from=3adesign.co.uk; dkim=pass header.d=3adesign.co.uk; arc=none
Received: from LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:182::14)
 by LO9P123MB7617.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 06:04:47 +0000
Received: from LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM
 ([fe80::493e:62d6:55a0:48c6]) by LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM
 ([fe80::493e:62d6:55a0:48c6%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 06:04:47 +0000
From: david Atkins <david@3adesign.co.uk>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wcn7850 issues
Thread-Topic: wcn7850 issues
Thread-Index:
 AQHa7kGb/waLDsK5rUe0AflzG3bOpLInNsxggABezQCAAjnlIIAEFF+AgACLnWCAEPZAAIAAFKQAgAMsa8CAATNCgIAARKCwgAAFVgCAAZPVMIAAFtdvgAAkNoCAAANhTYAAuXkggACEvICAAA+AkA==
Date: Wed, 4 Sep 2024 06:04:47 +0000
Message-ID:
 <LO0P123MB4057091D9028417A192B0E60D69C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
References:
 <LO0P123MB4057D6C2F6FEFF335B30EE7CD6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <LO0P123MB4057122D4C7D07C7114F5ABED6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <be53813c-3edc-4734-b59d-83f43f14ea91@quicinc.com>
 <LO0P123MB4057C3085F445434F5E87B3AD6872@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <26bb8ec7-7170-4a09-ada3-c7c753c16e87@quicinc.com>
 <LO0P123MB40573F46A6D63145363C6B13D6812@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <cfe8e314-a28b-4ea3-85b2-9f5b4ac2db09@quicinc.com>
 <LO0P123MB405769E063E48B0F7AE18C5FD68C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <LO0P123MB4057E823BDB7B9ECCCD75840D6972@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <a6c609fc-150b-4779-b3f6-dddbd6ce93dc@quicinc.com>
 <LO0P123MB40578A6CEC43AEFE301F9ED8D6912@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <86bc1623-8845-43fa-9aad-a8a6066b1448@quicinc.com>
 <LO0P123MB4057266AFF389FA69FDC84B8D6922@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <fb455a66-b29b-4eb0-984c-254f9a1c5626@quicinc.com>
 <LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <871q21kwk8.fsf@kernel.org>
 <CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
 <87seuhjbfn.fsf@kernel.org>
 <LO0P123MB4057552A6B51BCC3C75A0013D6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <CAFED-jnkQRV-_cfSuuOG5YxhA0O6Pxw7GyNyZ3AYoC+-Txn5yw@mail.gmail.com>
In-Reply-To:
 <CAFED-jnkQRV-_cfSuuOG5YxhA0O6Pxw7GyNyZ3AYoC+-Txn5yw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=3adesign.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P123MB4057:EE_|LO9P123MB7617:EE_
x-ms-office365-filtering-correlation-id: 1eace4bb-37dd-4cc8-8181-08dccca77b3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2QzWjFIR2g4ZFByN3lPVmRjMXRuN0Z5dDd5RElKVGh5WFpDN1hDRWQ1TitG?=
 =?utf-8?B?TiswekNTNG9Vb0w0ZVhubHdTU2xCQUZ3MlVvVjh2YWM3MVJyTXB0dFFOR21y?=
 =?utf-8?B?Zkt0Y3J5aTdFN3pGVElKb29zRUNyUEtBRUs5aVV5WkZyL2k2T0h1K3NVQU1n?=
 =?utf-8?B?REJBQzA5Z29OU2dza2Rnd1hQQ2pEelhpcVgvQ2txWmFaTzFoN0V6TS85dWJv?=
 =?utf-8?B?MUY5TTd3cVdnamhxU1V5MHhCaG0xVkg0bjVkUmVuVWd0ZDdyQ3M0YkxaQnhv?=
 =?utf-8?B?SnJCWlJSOVBaREhHUi9pU2JXOUFNQU5Fd3Jsd3h5QXlJd1BqUS9OcERRb21y?=
 =?utf-8?B?SHlZdzlrcDZWQi9tL09ZVzk3RFVGRzNwajd3dnRITVFYYTlTaXFCV3ZlWFhK?=
 =?utf-8?B?RVl3Ui9VWFNZMkxPTU5JTk4wbzZYOWtETnpadnh5d2N2NzF4YzF3d1ZaMVEz?=
 =?utf-8?B?QSttZENvOXM2Y05zLzc2akhnTDljcGtkUHUzM3lKQjA1dzlBUG9zSTcyMUtN?=
 =?utf-8?B?Zkh1ZEtUeUVqQWNPNWZIRkw2dytTTTFhNXNOOFNrd21vMVNXVVVRR1ltYjl1?=
 =?utf-8?B?cVpWRHBJZWtRc0NWQzZLOXJMQXo0Mmo2cllMYnB1NE1GWFhMVnFETHJ5d0Zs?=
 =?utf-8?B?Si9zVlZDeXFUZ2x2SXZGcHJxdWJCWWxWVGh4ZEVKRXJtR0hnT1V4c3d1b3dm?=
 =?utf-8?B?VW1qcUNWZXVhRmw3Rk9rTmhSandLN2YxNzJnSTZqYmM3TWZhK3dFMWZ1NFla?=
 =?utf-8?B?N20yZjJZOUJTVzgxWUYxRERUQ21MVXpsczFyMzJ2ZHAzR1pYOGhrYlhuQkVY?=
 =?utf-8?B?R1hyZHBQN0xEcUtKZUE1S3pFRGE3ZU02U0F6Q3JYRmkzUThYQzZkaUNYMERr?=
 =?utf-8?B?WU1ZTGJ0TjdzRUNnL1B5WnpvNjczY2VHb2ptdWNCZytPK2lvaTRCUzg2dk5r?=
 =?utf-8?B?TmJqYmRzbm40TWpENytUYnFlNnlvYmpOY0dIcm4ycU8yMDQ0L3ZWTHZTS0lB?=
 =?utf-8?B?b0pKL25BaWNQd0lRbE0rblM5aXlrbm5aZThSWnUrUlhiWVZBMUFqNmhSb3FS?=
 =?utf-8?B?bFc5WEpkbldQVWJNTGVXcXJ0RFIxV3Z4cEI4Tis4T3VncUdxYkdnRkM0bWJI?=
 =?utf-8?B?WjdEMEpDWitTRlNVOG50VnZyZ0QrQ3p5RysvMXZzYTZiN0JrdHJ1ODAzWXd1?=
 =?utf-8?B?ZUs2bXQzeUlqZW90QjR3NE0rU0E3YVVKN3ljTFdiaTJMdk5OaHBqZlVYb2Fu?=
 =?utf-8?B?em9rS3FGWFRoQTVsOWNNbnFMdGU3ZjFUOWZwMmY4czJjcEZEcUdwZGZFenhq?=
 =?utf-8?B?aWdDVVA2YmVwSWlUUFN2aHlwTWtaemFlYkZpdlhWNFo2Y2FQV0NKeUtKczhP?=
 =?utf-8?B?Q3I2L2V4UHVrakJPOTk3UHh0NlRVV2QzMXpYQTlGbWhsZzZmZnNZMDRxRkls?=
 =?utf-8?B?Z0JjeUlVaWM5RnVNU3ZiODBUUDUvRU53OXZMZ1IrVXRYTDVDNGo3cU1mK0E0?=
 =?utf-8?B?cWl1UTNseVo2NHFONDZjRE9sVTk4QXNjTTR6eWxKSnhrZFVwaER6dG05VFpu?=
 =?utf-8?B?T0FSakM5aDNSTG9HRGZnbURXdWdvNWE2T24xc1REUEwxUmFjK1VTSWxiajhU?=
 =?utf-8?B?akY4bDNkN0VPRXY4UlplbkNnck9NaVYzMStNUUJsVEkxMm05cXMwdy9uakhC?=
 =?utf-8?B?K3VYaDVzSlRMUEtZcDltOC8yd0R5dnJUTERaL1JuSVd0RUxEd2x5RXpzTW1a?=
 =?utf-8?B?US9BTkZvNXJ6QWpjUGg0VjAxS0tXTjZuUHdSL2l3b1Z6TWIvYzlDcGM5MXlm?=
 =?utf-8?B?QmtjSk9VVFp1ZGF5UjBHdE52NkpOVDlBT1diUm5jNFBGdTQ1M2dJc1FYUG1h?=
 =?utf-8?B?V1FYNk5FamFQcksydDFxZU9POUVvMkRwVWNiVXVXVTFGL1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnVsZHozeHdGZWdoR2pqR1VJd016M0RRRW0vaTNCWVpIYWY4TVQ5RTFweHZG?=
 =?utf-8?B?L3lCT256Z3IwWHo0Y1htVmZsc0g5ZWtEZ0FLdUZwVDNnRjQ5U1Ivem4zcVdP?=
 =?utf-8?B?RGU5V213b1RhQ1pMWUk0enBtWU5aMUlnRU1manNldWZHNVl1UUpUY09sZlg1?=
 =?utf-8?B?NmNkMDlKbjN0YWtmK1l0d001YUdWNktxdTEyYkdTMVQvUnBLMXVmSE9UYVRG?=
 =?utf-8?B?MERjR3MxTkIzZDhWZlJoVjU0TUhlMmZTeTI1ZWp1dU94OWNreHNFalhiS09v?=
 =?utf-8?B?Y1hXRGo4VGxqa01BTXorbk94V25ZVjVTSUovR2dJN0VqdU9KQVdlb1NFM3E5?=
 =?utf-8?B?amNkK0pDVllqdVlIUEpsVXRDU05oVm5qbmVaWE1XVFpUelVyZUw5NkxWR3hS?=
 =?utf-8?B?ZlNESGVTaEdobk1DSTVBa2pRazdKK2NqMll4MW5LTXhHNmc2UlEvUkdKNU44?=
 =?utf-8?B?dXNGQXVtWnhLcWJsRUg2M25HNTdCclZvbzk4bjNNdmk3TXBEQ0VPNjlJRCti?=
 =?utf-8?B?UlJPRUVNNk1wdi9oSlUxTWRjcTJLaWFEVCtBdEdod213Q0hpQW10Nnc1cWlU?=
 =?utf-8?B?STFSaEZ3T1BOZ1U3a2dXM2FYQ1NrYituRkhZdWg2ZjEyVXBBUlJ2MUFqeURJ?=
 =?utf-8?B?ZU5INmlvZ003Z3Nyb2JKd2tERDBaVS9GWmsvOTdzdkJxdkNPbVlyZi8vbnZn?=
 =?utf-8?B?ZU96b09Dd3R3cVh3T0JZTVJmenVuT1BPNHFRVUF0a2RLT0NhdmN5Nm91UzQz?=
 =?utf-8?B?VXJISlV0SEFnVWkyRmpXeEcrRVRqY0dQdnhORVVWNjZ6SFhOZWx3L255bENF?=
 =?utf-8?B?Zk9WQTllZ3djWWN3RGczM1RVZkZlUkFmRnlORCtES253ZlFCUnBkQ1VsMUJ0?=
 =?utf-8?B?RWxFcVJpSFlxc0VaRlU3KzZMSm9YY0hhVC9JYVJpSEJNcFlKUituRnV5OGVi?=
 =?utf-8?B?NHVCNFNwUnRZdFhwK3I0N0tRQnRCRlprUVM2V0F1U3pnQjZRRnpKYTZiR09q?=
 =?utf-8?B?Mis0YmVTU0ExU1U2OFZQZEY2YUFuUUdaZmx3ZGY3ZlhteWgybCt3RTZEc0d5?=
 =?utf-8?B?ZlErN09LaitLeTVuazZ6K1dwbGllV1FaaTVtSThDNnhCLzBGSUNObTVoZC9p?=
 =?utf-8?B?SldWSlVOWndTT2NBT2Zkc2RQejNuMUxtZzhnVEhXYzFsa0VVTzJoR0treFBs?=
 =?utf-8?B?RzNYTzdDdStsZENnYlltbjNtSW5WZ1phRk5ta0ZkdUZWNjZFbjVySTNVOXZB?=
 =?utf-8?B?SkR3RDJsVUdjSTR5ZTRpNEl0am9HOWVWTVVrVnpZcHRCV05oQXFEYms4Mm9H?=
 =?utf-8?B?OXZUTlU1TmFSMzF0TU0xRXV2RmpKUzZOQ3dsaUs2WXQ5Y1hoMkFXNGtTZWta?=
 =?utf-8?B?aUNyNitySG5MNFpmMm1Ea1RzeTB2dGl1WXVpenFLTFp4aUZGUlNjejhRTk5w?=
 =?utf-8?B?YkNiNUcrUzl6WXBPOFkwYUM1dTA1WHFsTDltYTNPM01ZdUp2RmZJYnl1SGpX?=
 =?utf-8?B?cmxGanR2b0cvbWk0eTZqZzJDRFEzNC9KWDd0WVkxbXZHQlFxQ0Z4OXp5b0NG?=
 =?utf-8?B?ZXBmTWpQaEtnZUkxV1c1WW9BTjBvU1Y5b1hPOW10c1ZFUEY4czRwaVgxWWY4?=
 =?utf-8?B?eEJTWUZmN1ZFVFIxWUJPb0lDZUhSb1pOdDRmbkFDZUJNVU0zZ2lKZzhLNTAr?=
 =?utf-8?B?bHQxcWwwd1BRWXIxQ0VRczNiUGl0ekFZSEhIUVIyM1Z2VVlMb1AxQU10eEZN?=
 =?utf-8?B?ZUpDQW02TlkrSG9kd0dwU2ZGUmJBb2NxSi8rV3F1S3JVYkhDMCtOdGl0NXYr?=
 =?utf-8?B?M0ZROG5tVEZickFsR0xxOTdid1RoeWZTaDZUMVVDZ3pnVlhCME5tZFk2VWUy?=
 =?utf-8?B?MXliNmFlc0JYQXg3WmNZU1N1N0R1c05yOHBmOGdISGJzL001RVdKYk5QSkdy?=
 =?utf-8?B?RHlYV1JZVTBJQkMxU0Zhc3M1SytIK3BtdUFFaG9OS0JMdVhsTSt1YXdNRDJS?=
 =?utf-8?B?K3F4OUxPVERRTzVyQkduNk5DQlRYQ1pHTE5LOW1xYVE2MlJXOTArbS9ncGJG?=
 =?utf-8?B?UWRLbi9COU5ueG5DYWZxUVZTQ0hSZlhmKzBQMU00ZHJ4bVhKNnM4eXhvTDho?=
 =?utf-8?Q?PTofDw+ZXJpUZmS3oglLB7Pav?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 3adesign.co.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eace4bb-37dd-4cc8-8181-08dccca77b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 06:04:47.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b153f19-49d1-4c9d-8de6-70aea15d7add
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gl/zVNO/gPm4DLjckAwEQB7tAlKDAfA9W93htKNZ+19E7SO5AVNbUSh8IA29jnncTe/T2vHbCEsgVMPseP405A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7617

PiA+ID4gPj4gPiAuLi4NCj4gPiA+ID4+ID4+ID4+PiAgICAgICAgIEV4dCBUYWc6IEVIVCBPcGVy
YXRpb24gKDgwMi4xMWJlIEQzLjApDQo+ID4gPiA+PiA+PiA+Pj4gICAgICAgICAgICAgRXh0IFRh
ZyBsZW5ndGg6IDggKFRhZyBsZW46IDkpDQo+ID4gPiA+PiA+PiA+Pj4gICAgICAgICAgICAgRXh0
IFRhZyBOdW1iZXI6IEVIVCBPcGVyYXRpb24gKDgwMi4xMWJlIEQzLjApICgxMDYpDQo+ID4gPiA+
PiA+PiA+Pj4gICAgICAgICAgICAgRUhUIE9wZXJhdGlvbiBQYXJhbWV0ZXJzOiAweDAxLCBFSFQg
T3BlcmF0aW9uDQo+ID4gPiA+PiA+PiA+Pj4gSW5mb3JtYXRpb24NCj4gPiA+ID4+ID4+IFByZXNl
bnQNCj4gPiA+ID4+ID4+ID4+PiAgICAgICAgICAgICAgICAgLi4uLiAuLi4xID0gRUhUIE9wZXJh
dGlvbiBJbmZvcm1hdGlvbiBQcmVzZW50OiBUcnVlDQo+ID4gPiA+PiA+PiA+Pj4gICAgICAgICAg
ICAgICAgIC4uLi4gLi4wLiA9IERpc2FibGVkIFN1YmNoYW5uZWwgQml0bWFwIFByZXNlbnQ6IEZh
bHNlDQo+ID4gPiA+PiA+PiA+Pj4gICAgICAgICAgICAgICAgIC4uLi4gLjAuLiA9IEVIVCBEZWZh
dWx0IFBFIER1cmF0aW9uOiBGYWxzZQ0KPiA+ID4gPj4gPj4gPj4+ICAgICAgICAgICAgICAgICAu
Li4uIDAuLi4gPSBHcm91cCBBZGRyZXNzZWQgQlUgSW5kaWNhdGlvbiBMaW1pdDogRmFsc2UNCj4g
PiA+ID4+ID4+ID4+PiAgICAgICAgICAgICAgICAgLi4wMCAuLi4uID0gR3JvdXAgQWRkcmVzc2Vk
IEJVIEluZGljYXRpb24gRXhwb25lbnQ6IDANCj4gPiA+ID4+ID4+ID4+PiAgICAgICAgICAgICAg
ICAgMDAuLiAuLi4uID0gUmVzZXJ2ZWQ6IDB4MA0KPiA+ID4gPj4gPj4gPj4+ICAgICAgICAgICAg
IEJhc2ljIEVIVC1NQ1MgQW5kIE5zcyBTZXQ6IDB4NDQ0NDQ0NDQNCj4gPiA+ID4+ID4+ID4+PiAg
ICAgICAgICAgICBDb250cm9sOiAweDAyLCBDaGFubmVsIFdpZHRoOiA4MCBNSHogRUhUIEJTUw0K
PiBiYW5kd2lkdGgNCj4gPiA+ID4+ID4+ID4+PiAgICAgICAgICAgICAgICAgLi4uLiAuMDEwID0g
Q2hhbm5lbCBXaWR0aDogODAgTUh6IEVIVCBCU1MgYmFuZHdpZHRoDQo+ICgyKQ0KPiA+ID4gPj4g
Pj4gPj4+ICAgICAgICAgICAgICAgICAwMDAwIDAuLi4gPSBSZXNlcnZlZDogMHgwMA0KPiA+ID4g
Pj4gPj4gPj4+DQo+ID4gPiA+PiA+PiA+Pj4gQXJlIHlvdSBzYXlpbmcgdGhlIGF0aDEyayBkcml2
ZXIgZG9lcyBub3Qgc3VwcG9ydCB0aGVzZQ0KPiA+ID4gPj4gPj4gPj4+IGZlYXR1cmVzPyBJZiBu
b3QgY2FuDQo+ID4gPiA+PiA+PiA+PiB5b3UgY2xhcmlmeSB0aGUgaXNzdWUgc28gSSBjYW4gcmFp
c2Ugd2l0aCB0aGUgQVAgdGVhbS4NCj4gPiA+ID4+ID4+ID4+Pg0KPiA+ID4gPj4gPj4gPj4gYXRo
MTJrL1dDTjc4NTAgc3VwcG9ydHMgRUhULCBidXQgd2l0aCBOU1Mgb25seSAyLiBIZXJlIHRoZQ0K
PiA+ID4gPj4gPj4gPj4gQVAgcmVxdWlyZXMgTlNTIHRvIGJlIG5vIGxlc3MgdGhhbiA0LCB0aGF0
IGlzIHdoeSBFSFQNCj4gPiA+ID4+ID4+ID4+IGNvbm5lY3Rpb24gd2FzDQo+ID4gPiBkaXNhYmxl
ZC4NCj4gPiA+ID4+ID4+ID4NCj4gPiA+ID4+ID4+ID4gV2hpY2ggZmllbGQgaXMgcmVxdWlyaW5n
IE5TUyBvZiA0LCBJJ20gb25seSBzZWVpbmcgYSBtYXhpbXVtDQo+ID4gPiA+PiA+PiA+IG9mIDQs
IHRoZQ0KPiA+ID4gPj4gPj4gUXVhbGNvbW0gd2luZG93cyBkcml2ZXIgd2lsbCBjb25uZWN0IHRv
IHRoZSBzYW1lIEFQLCB3ZSBoYWQNCj4gPiA+ID4+ID4+IGFzc3VtZWQgdGhhdCB0aGF0IGF0aDEy
ayB3b3VsZCBkbyB0aGUgc2FtZS4NCj4gPiA+ID4+ID4+IEJhc2ljIEVIVC1NQ1MgQW5kIE5zcyBT
ZXQ6IDB4NDQ0NDQ0NDQNCj4gPiA+ID4+ID4NCj4gPiA+ID4+ID4gTXkgdW5kZXJzdGFuZGluZyBv
ZiB0aGUgc3BlYyBpcyB0aGF0IHRoZXJlIGFyZSBtYXhpbXVtIG51bWJlcnMNCj4gPiA+ID4+ID4g
b2Ygc3RyZWFtcyB0aG91Z2gsIGFyZSB5b3Ugc2F5aW5nIHRoZSBBUCBoYXMgdG8gYWR2ZXJ0aXNl
DQo+ID4gPiA+PiA+IDB4MjIyMjIyMjIgd2hpY2ggd291bGQgdGhlbiBwcmV2ZW50IGEgNHg0IGNs
aWVudCAoc2F5IGFuDQo+ID4gPiA+PiA+IGV4dGVuZGVyKSBmcm9tIGNvbm5lY3Rpbmcgd2l0aCA0
IHN0cmVhbXM/IEkgbm90ZSB0aGF0IHRoZQ0KPiA+ID4gPj4gPiBRdWFsY29tbSB3aW5kb3dzIGRy
aXZlciBmb3IgSGFtaWx0b24gd29ya3Mgd2l0aCB0aGUgQVAgYW5kIGFuDQo+ID4gPiA+PiA+IElu
dGVsIEJFMjAwIGFsc28gd29ya3MgYm90aCBvZiB3aGljaCB3aWxsIGJlIGluIGF0IG1vc3QgMngy
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gRGlkIHlvdSB0ZXN0IEludGVsIEJFMjAwIHdpdGggdGhlIFdp
bmRvd3MgZHJpdmVyPyBKb2hhbm5lcw0KPiA+ID4gPj4gbWVudGlvbmVkIHRoYXQgaWVlZTgwMjEx
X3ZlcmlmeV9zdGFfZWh0X21jc19zdXBwb3J0KCkgaW4gbWFjODAyMTENCj4gPiA+ID4+IGNoZWNr
cyB0aGlzIHNvIEkgd291bGQgYXNzdW1lIHRoYXQgaXdsd2lmaSBhbHNvIGJlaGF2ZXMgbGlrZSBh
dGgxMmsuDQo+ID4gPiA+DQo+ID4gPiA+IFllcywgdGhpcyBpcyBBUCBpc3N1ZSAtIGhvc3RhcGQg
Zml4IHJlcXVpcmVkIC0gYWR2ZXJ0aXNlIDB4MTExMTEgLi4uDQo+ID4gPiA+IEluIG90aGVyIGNh
c2Ugc3RhdGlvbiAgPCA0bnNzIHdpbGwgZHJvcCB0byBIRSBvbmx5Lg0KPiA+ID4NCj4gPiA+IFRo
YW5rcy4gQW5kIEpvaGFubmVzIHBvaW50ZWQgb3V0IHRoYXQgeW91IGhhZCBldmVuIGRpc2N1c3Nl
ZCBhYm91dA0KPiA+ID4gdGhpcw0KPiA+ID4gYmVmb3JlOg0KPiA+ID4NCj4gPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL0NBRkVELWprOHBKaGVKRVZpRVNuRTU0Zi0N
Cj4gPiA+IEsrSmdSTWlXb2lDU2EwR0J0PVJLYUNuN3N3QG1haWwuZ21haWwuY29tLw0KPiA+ID4N
Cj4gPg0KPiA+IFNvIHRoaXMNCj4gPg0KPiA+IEJhc2ljIEVIVC1NQ1MgQW5kIE5zcyBTZXQ6IDB4
NDQ0NDQ0NDQNCj4gPg0KPiA+IFNob3VsZCBiZSAweDExMTExMTExID8gYW5kIGl0IGRlZmluZXMg
dGhlIG1pbmltdW0gbnVtYmVyIG9mIHN0cmVhbXMNCj4gbmVlZGVkIHRvIGNvbm5lY3Q/DQo+ID4N
Cj4gPiBUaGlzIHRoZSBkZWZpbmVzIHRoZSBtYXggc3RyZWFtcyA/DQo+ID4NCj4gPiAgICAgICAg
ICAgICBTdXBwb3J0ZWQgRUhULU1DUyBhbmQgTlNTIFNldA0KPiA+ICAgICAgICAgICAgICAgICBF
SFQtTUNTIE1hcCAoQlcgPD0gODBNSHopOiAweDQ0NDQ0NA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uIDAxMDAgPSBSeCBNYXggTnNzIFRoYXQgU3VwcG9y
dHMgRUhULU1DUyAwLTk6DQo+IDQNCj4gPiAgICAgICAgICAgICAgICAgICAgIC4uLi4gLi4uLiAu
Li4uIC4uLi4gMDEwMCAuLi4uID0gVHggTWF4IE5zcyBUaGF0IFN1cHBvcnRzIEVIVC1NQ1MgMC05
OiA0DQo+ID4gICAgICAgICAgICAgICAgICAgICAuLi4uIC4uLi4gLi4uLiAwMTAwIC4uLi4gLi4u
LiA9IFJ4IE1heCBOc3MgVGhhdCBTdXBwb3J0cyBFSFQtTUNTIDEwLQ0KPiAxMTogNA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgLi4uLiAuLi4uIDAxMDAgLi4uLiAuLi4uIC4uLi4gPSBUeCBNYXgg
TnNzIFRoYXQgU3VwcG9ydHMgRUhULU1DUyAxMC0NCj4gMTE6IDQNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIC4uLi4gMDEwMCAuLi4uIC4uLi4gLi4uLiAuLi4uID0gUnggTWF4IE5zcyBUaGF0IFN1
cHBvcnRzIEVIVC1NQ1MgMTItDQo+IDEzOiA0DQo+ID4gICAgICAgICAgICAgICAgICAgICAwMTAw
IC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4uLiA9IFR4IE1heCBOc3MgVGhhdA0KPiA+IFN1cHBvcnRz
IEVIVC1NQ1MgMTItMTM6IDQNCj4gPg0KPiBZb3UgbWl4IGRpZmZlcmVudCB0aGluZ3M6DQo+IA0K
PiBTdXBwb3J0ZWQgRUhULU1DUyBhbmQgTlNTIHNldCAgdnMgQmFzaWMgRUhULU1DUyBBbmQgTnNz
IFNldA0KDQpTbyB0aGUgYmFzaWMgc2V0IGlzIHRoZSBtaW5pbXVtPw0KDQpEYXZpZA0KDQo=

