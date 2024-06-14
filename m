Return-Path: <linux-wireless+bounces-8991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC44F90817E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 04:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FCE1F22B78
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847818306C;
	Fri, 14 Jun 2024 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mwl+9ISz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BCA18307A;
	Fri, 14 Jun 2024 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331495; cv=fail; b=HBi3NT5H5WwT9RzQoFoSkt4JwPRiI/UsiK0qpTo5CevFe5zmentrTTbbMFKNAZoH94FLGxXnkjiS/SyvJQ6Yq2kR76AUkG+fYo40yd2fyT9diSx6i0oqPhd/rpQzBktwLUW+83VK5dnY91Z3JJLzAtF4hZwQP3qXtinPRMsyeug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331495; c=relaxed/simple;
	bh=I32LaYJHzAZkLpTkk0fOjG0Pir13j4gCayZoCt8w9Pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psEmwfSMFJ5jS5iDjeVKo1dgZPffaEdTT0IVCs1Ph9YUz7TByKsXaTBGY6/TxboP7ZxnhR2psdmbyxR+iNF68mwZGSgpDSt6rwDdwBFO2BKp2yrr+RWyBxzyOMoUcLC2bkS5H0PwjCzLOFUYWYQI/tBMdfr5LKzTPlsTrtn8CjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mwl+9ISz; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM+Fd9Wf53alelirEszfIqs/1X4bQethpLs23JbRqqI7OxtJt8lFfT8KJD6Lk1SpHSpYOlYaUsBfc4loM3cg4yWYp3xWHIwdblo9cGJXwlrLqWQniFI8NORG6m0vVAzPkkhRXFI/TPnRD6X7nTfZaLQ1CV9hLutfBzx0KKQSySoCAf8Zdg3xphnBT7l+d9TGBRHtgDDtrA4tVyjfRlH/ziaXj5D6j1B9BEpHky5xMDFkIBa323vrbPh4ems37/MU3Onaav97qetYDUW0LZM0X2sVlH8+z1tO5DGv1s/t/Wna+a4QmIFfRDuNZtlLzKZqAs2QMsYO+71rMdyDcYfZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I32LaYJHzAZkLpTkk0fOjG0Pir13j4gCayZoCt8w9Pw=;
 b=hNYTeijhb9bNRzQ+BjxAP7b/ZYsMBgArNK7Ov4fxnoATwYywkrBsJsMHKL8GsznUuHU6Hpg4HvMMdeS3AbnE7KxuGydoD/B/XgJ0chYaprc9sIrreltmh5nsnY7yYjMu+y4oRxJwGXJ5Vc+w2gU0cwOuNANdok4K24RRJx4AYnLuzEeIm3JygC5dGY6QoSJEG4rYEi8xih08yMKb20XLkPJSsfQzhze08njKKF+G5uqaS9l5KaleQx0Sqdds1bOzKCdJNlWVEd1TIzkgpllQsDb6i9b0WwHHmMJ51SMA3sjaEybE01RyuQ59VWFFTJ24psPW7Y3cLOc/v99XB2ey1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I32LaYJHzAZkLpTkk0fOjG0Pir13j4gCayZoCt8w9Pw=;
 b=Mwl+9ISzruSsl6+B3hQZJp9PZR8cehU2hBB7HpVbuCVuyGKfdOnZgqVDahVQHc44wH3xUTjzkx+Z9IGvKLBteZiMUBHJRyM0XZRzT5Xpus8WADEd8gU7dQF9sXI8wOkCKRkdZJ66GiqR1zJNj7RZTcDFi8Q50pUY2JfK83JRgWU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM7PR04MB6791.eurprd04.prod.outlook.com (2603:10a6:20b:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 14 Jun
 2024 02:18:10 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:18:10 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index:
 AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEwgAAQrACAAB/CYIAfhvOw
Date: Fri, 14 Jun 2024 02:18:10 +0000
Message-ID:
 <PA4PR04MB9638E1C1AD03619FD8E9A1F4D1C22@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM7PR04MB6791:EE_
x-ms-office365-filtering-correlation-id: 868fa346-d971-413f-335d-08dc8c183c7a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?REVXcHZWQmJob1Z1Q0h2Rk1JeXhKOHZGM3gyOHRQNm5iMjgyc0wwc3ZNV2tT?=
 =?utf-8?B?WndOdjk5Z1JhT0JqOWIvTHVkZ0hxS0EyS2VQUzFEbWdpbzNMWlZtSzI4OHRD?=
 =?utf-8?B?YUNlYWdJN3VkME1sR0lyb3YyZTlHVUpzWHI3eS9MQnoraU1kOVJtV24wWDk2?=
 =?utf-8?B?cTBUUC9MQVlDQlVsN2UvTHF3Y1JNa2pheGtoV2tqMDF0aUR1NEVYSlZWSjZQ?=
 =?utf-8?B?bWRtNGRKczJHVTdIYjQ5NWZKK2Q5T2Y0UjVscUEwaDhHZWordFBFZmRqUUNp?=
 =?utf-8?B?eW52aTJhOVpOVmFwRmVhYTJSam54VTMvUG5handhRVF3aVgrbVM5bGdVWGc4?=
 =?utf-8?B?OVkweG52djZHRVIydWNFQmFlZjRBVVBvSW9jYVJEUTIrSHNjYnRVQ01tN3Qz?=
 =?utf-8?B?WXFqdFoyUVVoYU9FTERtM2JaQ3Nxei84VEhjQTlTNEJtKzBDUUo2Y3Zkam5K?=
 =?utf-8?B?ZFBwbjhKK1gwS2psODU3NllWQ2UwMHJmQlhLQ3lrRWZmRHJ6Nlh2cDlkWi8z?=
 =?utf-8?B?T2EvWk1qOVFaL2hMejFUY2ZNeGh2cmY4OUwrV1FYTUVVdUt0Tjl5R2kzK2hC?=
 =?utf-8?B?RGZnYlQ3bTlBanR1WWhiL0Fpa3ZKZjM1b2RxYlRjY2h2TUl5ZjVnekJQMW91?=
 =?utf-8?B?NEZWcmxzTUFhUktlblJOSXpBOVNNcEJsS1BwYnJTaVVLYTZZMWFiMUxsTnZj?=
 =?utf-8?B?ZGZHbEFVRnZJYi80bGRnQUMzMHc0Rk1KSzJwQmJpenpBUWZNQnp4WW9FUFBy?=
 =?utf-8?B?T3hjcUVJU1BiMzJSaUtqdUlUSldKcFJTV1ErYVRHTURoUG1jZDg2Rm9LWHl1?=
 =?utf-8?B?ZnJxK3BVMlMvcG4veHo0czNSYmVxWGlDOXNTSlVnK01nUDl6V3N1RzM0ZFk3?=
 =?utf-8?B?T1F0VlJ4ZjNycDdBVEZubkhQd3BBbzd0LzF6Q3Y2SFRZUWFNSEI2aHA3bTlq?=
 =?utf-8?B?Qkx3OTRkS0I4bHZtZndCL1FEbjFtRDBuK0theEsyb2F0Z0lLK3NLby8yRXJ3?=
 =?utf-8?B?UUVrWVQ1dVJwRlRPd0w5b254TmN6ZmcrSFFGa1VCRVlSTG9lOVhpaE1ibVBm?=
 =?utf-8?B?bERtK3loSkRrNjExRGYwbXVyUGRRU09MSDZ2VWpDdHNkcWpYZGJRWWpEZ1RU?=
 =?utf-8?B?WHRjVVkzdEs0eHkyajhzMHJjTW9qUDZ0L3RGZXZFREVVTXp5QVZtUFM3VGRZ?=
 =?utf-8?B?a0JucGtaRVRWSzRXR1lScFhhZHRTbVZjdG1WSmh5WU41K3FBcFV2UVB5S3R1?=
 =?utf-8?B?cmNPZktsUG5vVmljU2N6TmVzN3BqeGtHTjBxZkVOYkY4Q2daZjRPZnl6STc2?=
 =?utf-8?B?UGJyQWp3NkJ5dkIzaGErRHkxcWVrNzU1YS9LZnNxU21xczZQd3IxcG52OFFV?=
 =?utf-8?B?SlhTYyt0N3pWY2lxWUdKQmRSZWNuN3JvUlhuanVuT3lIZytSUitlUWpwRzAz?=
 =?utf-8?B?bFhVdFZoTlNtSWxwRDM3L0RkSUVPN1dVUlh3aXZLR1l0MXZtMHlpekZJR0pr?=
 =?utf-8?B?SWhyN2lUalp3OUhrbGc2aWVUUUpnY0NXYmF1dGNYYU9jSUd4eVlyQ1djclFv?=
 =?utf-8?B?YTNBeGNadDZaZm1oenMwRXBsWUk1cnBHYklCSXJPZndLRmY4ODV4NlhTSlhF?=
 =?utf-8?B?SVMvNWxVazhpZThnUkc1dnhzQmhZRU5YSFBrUVNrSVNnU25mSFp0UjEwSkpU?=
 =?utf-8?B?THVEQ2VwWUhUaUNlbk9xTG1wdm56NnBnS3pvdzNBcGNyaDJIdjFzZWZVZk4y?=
 =?utf-8?B?V3UxQ3c0ZVppUDhqcUx5Uzc5cVRJZUxuZ3ZYMmgrbnM0OVVBSnpQSS9udmFu?=
 =?utf-8?Q?wKKV3aPJji+XX7dnZqeOPRH1Iy5PsBdmzG3io=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXpNenYwQ1VvNytESDh3UVlNeTNzZGI1bmxLeis4a0thZ09Ca3dTSUpUMm81?=
 =?utf-8?B?YTRIN05EQ0I0Q2ZrRlNiNFlFSmRpNVN2di9weGp1SkY5NjRIQnlGbnNlYmpX?=
 =?utf-8?B?ZjNPYjhvZzdrenZoa2QxWldPaVVCNGR4clN2WTA2QWVnZFRZdTJzcmx2eWFl?=
 =?utf-8?B?SS94bmRUMEI5bldIMFBLOUdqdHFZYlRJeUtqd1JmLzV5VmtnWVVoNXFwUktR?=
 =?utf-8?B?b1ZReEFIeGtGbnhHM2RFZThHNEgvN0NYNkdYOG1BRHY4SU0zVGZzYlFyQWN1?=
 =?utf-8?B?T1ZmQjk4dXplVkFpSS9ydXVPWFd2QnhvUFdwbEo1Ujg0S0hUYVk5WDhUVFRB?=
 =?utf-8?B?Um12S0d1dGl2b1k3RWNJemh4KzVxSU9CMjBEWkd4a0VTcjBiN0pWMFlXUlpE?=
 =?utf-8?B?Z0duUTNpWXp5S0JURmtFWGV6ZVZpRnI4MlpMNGttc0RMR3gvQnUrL29FNkt4?=
 =?utf-8?B?U0dyckpTY2Y5cjV3VVQ2clhYbWZiMW5TUW9QalhGY3BnbUV0L3EvcWJvL0JJ?=
 =?utf-8?B?bHVzVUF4QUIvZUlyUHJsM25YMGtSeHYwOWJWZVo1ejlWL0owU09vc1N1SG01?=
 =?utf-8?B?MjhHUzZMZmE4bGQzODFCZmJkUTJzOEJVZUhQNGdCVmg2UmkxNFhmQlc3K0JH?=
 =?utf-8?B?b1FrVitGT21LT1J5OXFyQytGMWVHTFZBV29xTGs0QUx2cUltQldTY0JteGN0?=
 =?utf-8?B?SWpnU0NrWU5NVzV3SXZIejYyRE9qNkRMVklucTJVSk1vbVVpNlhyQTFFdFIx?=
 =?utf-8?B?SGJlK3Q0d1FBcjdWNjYwMXV2RTZmZDNRWE5kU2tvdythMXh2M1M5WjR2dE1G?=
 =?utf-8?B?NG5Mek1lWGNRNFF2WEhSS3JaQ2tjNTEwa2pMNDYxc3ROdlhZT05SK0htQnRZ?=
 =?utf-8?B?L2l1N2czTUZreDR3U0tnQTlTcGhST0N2WGcrN0JKSGJFa2wwejhUSVdjaG1u?=
 =?utf-8?B?b3pDa1ZSVUV5OXVJSTlzWVNJSGxFdzlRaDA0WTBCQnRYRXFjZU84ZTlrSVZT?=
 =?utf-8?B?YysxaVFBNm02UmpEV2tCQ2Zaako1UStCMzg4aFQxdEgwNjF0dTNPQlJucU5Z?=
 =?utf-8?B?SjZzVnJvdXROaldYSjBIMk8xWVF3WDlCS0p0RXI3ZjZDUHVISmFqYlZWNGZ5?=
 =?utf-8?B?dW9MVGV0RU1oZVMydFkxUFNUaE5IUmVOMkc0ZkFOc0FVc2JYaXVOU09IVVFn?=
 =?utf-8?B?NGhmRkFyNHFvelovNjl0UjVZeXRBUFRUMjZJUnhrODRzNFVycHlWVHlRQ21J?=
 =?utf-8?B?dkY4R2pYd1ZiZ2RGRzVrTEVwT1k3NkdJY0JKNXVvSExCRmxVWS90cXJzOFUw?=
 =?utf-8?B?b0lOWTU3bnV1UEpmMGxTOFI2eFBQRmpVVWw4dWJsRi9FTlpURU9kT3ZZeDRB?=
 =?utf-8?B?c2NCY0s4ZXhJUm8wWGJIOE9CYWVJQUMxa3p6K3FQNVRTbXRQbnMrdWpZVldX?=
 =?utf-8?B?cGJzN3cxdldIS0w2dVFCZFVDdXgzbjNpZEtjSk9ITmV3UFU2eitMcGFNbHpM?=
 =?utf-8?B?aFdiKzVUd1RHNzFtckhlTUJnZXBUZVU3UDg2eUh6R1RDbnJiQ0d1ZUk4RW9a?=
 =?utf-8?B?TUpUQ3ZuTVBDY09xazhNZzJDM3RWWm4veERUUHlTQ1l0MWErZDFWZGxZN0dm?=
 =?utf-8?B?MGRKcTAxeWdTc3k1QkRzZzBjbVhibEw1SzdRRHF2eGx6Z3g5NHNiYlRzYnVq?=
 =?utf-8?B?eStrWUlKOWRRYmFoc1g3RDk1c29KUjZFWDVIV3I0aTRDYldLT0NWd1l0cjBq?=
 =?utf-8?B?WTNOMU5BWTNGY0hyZ3ZCTzR1RjhIZ0xvUVNQTUNHNWcvSllUK0tQYmhvS3hq?=
 =?utf-8?B?dHJQelBFYjJsR1V1a29MYVZVSys3YWVnQnFKZ2pXREYxWjQ3M1FBZm5rYUov?=
 =?utf-8?B?NFBrTmZMNjVRWUM0RXRlVFZiSGp1Z2dGQVR1ayt2OGJaSjk1NDdTR08vMlFy?=
 =?utf-8?B?Z2Z5aXptbitqbmhUeDlVNm5ONWxCNUpNb3lxakQ5bEtyZTIrVUhYNk55UG9P?=
 =?utf-8?B?Qmh6RjBySWU1Q3F4UTN1MkZ3UiszRzZBblNhYW5BdGVlekpyYytWbXI5WDhk?=
 =?utf-8?B?L3V1RTBuNGFzNUxDdFFNd1kyRGI3VWNJdHU3Y2ozSDJSNGgrcHVybUwwYjFa?=
 =?utf-8?Q?JJ5296eGVgdjOmHuRvI7tca88?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 868fa346-d971-413f-335d-08dc8c183c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:18:10.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GtaOlb9b+BEfY6EbTNt45qMHu6gMl2G7981nNT2POsq6DaBXB/qoGJvrZr8XboL+UP5S7kBakSVm5nrKxMMOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6791

SGkgQnJpYW4sDQoNCj4gRnJvbTogRGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+DQo+IFNl
bnQ6IFNhdHVyZGF5LCBNYXkgMjUsIDIwMjQgODo1MSBBTQ0KPiBUbzogQnJpYW4gTm9ycmlzIDxi
cmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGt2YWxvQGtlcm5lbC5vcmc7
IGZyYW5jZXNjb0Bkb2xjaW5pLml0OyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2llbi5oc2llaEBu
eHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXgu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSCB2MTAgMS8yXSB3aWZpOiBtd2lm
aWV4OiBhZGQgaG9zdCBtbG1lIGZvciBjbGllbnQNCj4gbW9kZQ0KPiANCj4gSGkgQnJpYW4sDQo+
IA0KPiA+IEZyb206IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnPg0KPiA+
IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjUsIDIwMjQgNjo1NSBBTQ0KPiA+IFRvOiBEYXZpZCBMaW4g
PHl1LWhhby5saW5AbnhwLmNvbT4NCj4gPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IGt2YWxvQGtlcm5lbC5vcmc7
IGZyYW5jZXNjb0Bkb2xjaW5pLml0OyBQZXRlIEhzaWVoDQo+ID4gPHRzdW5nLWhzaWVuLmhzaWVo
QG54cC5jb20+OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA+IDxmcmFuY2VzY28uZG9sY2luaUB0b3Jh
ZGV4LmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MTAgMS8yXSB3aWZp
OiBtd2lmaWV4OiBhZGQgaG9zdCBtbG1lDQo+ID4gZm9yIGNsaWVudCBtb2RlDQo+ID4NCj4gPiBD
YXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4g
Y2xpY2tpbmcNCj4gPiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0
LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcNCj4gPiB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBi
dXR0b24NCj4gPg0KPiA+DQo+ID4gT24gRnJpLCBNYXkgMjQsIDIwMjQgYXQgMzowMeKAr1BNIERh
dmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPiB3cm90ZToNCj4gPiA+IEkgdGhpbmsgaXQgbmVl
ZHMgdGltZSB0byBzdXBwb3J0IHByb2JlIGNsaWVudC4gQ2FuIHdlIHB1dCB5b3VyDQo+ID4gPiBz
dWdnZXN0ZWQgY29tbWVudHMgdG8gdGhlIGNvZGUgdXNlZCB0byBob29rIHByb2JlX2NsaWVudCgp
IGFuZCBhZGQNCj4gPiA+DQo+ID4gPiAiVE9ETzogc3VwcG9ydCBwcm9iZSBjbGllbnQiIHRvIG13
aWZpZXhfY2ZnODAyMTFfcHJvYmVfY2xpZW50KCkuDQo+ID4NCj4gPiBBcmUgeW91IHN1Z2dlc3Rp
bmcgdGhhdCB5b3UgcGxhbiB0byBhY3R1YWxseSBpbXBsZW1lbnQgcHJvcGVyDQo+ID4gcHJvYmVf
Y2xpZW50IHN1cHBvcnQ/IERpZCB5b3UgYWxyZWFkeSBkbyB3aGF0IEkgc3VnZ2VzdGVkLCBhbmQN
Cj4gPiB1bmRlcnN0YW5kIHdoeSBob3N0YXBkIG5lZWRzIHByb2JlX2NsaWVudCBzdXBwb3J0PyBU
aGlzIHNlZW1zIHRvIGJlIGENCj4gPiBjb21tb24gcGF0dGVybiAtLSB0aGF0IHJldmlld2VycyBh
cmUgYXNraW5nIGZvciB5b3UgdG8gZG8geW91cg0KPiA+IHJlc2VhcmNoLCBhbmQgaXQgdGFrZXMg
c2V2ZXJhbCByZXF1ZXN0cyBiZWZvcmUgeW91IGFjdHVhbGx5IGRvIGl0Lg0KPiA+DQo+ID4gTm93
IHRoYXQgSSd2ZSB0cmllZCB0byBkbyB0aGF0IHJlc2VhcmNoIGZvciB5b3UgLi4uIGl0IGxvb2tz
IGxpa2UNCj4gPiBob3N0YXBkIHVzZXMgcHJvYmVfY2xpZW50IHRvIGF1Z21lbnQgVFggTUdNVCBh
Y2tzLCBhcyBhIHByb3h5IGZvcg0KPiA+IHN0YXRpb24gcHJlc2VuY2UgLyBpbmFjdGl2aXR5LiBJ
ZiBhIHN0YXRpb24gaXMgaW5hY3RpdmUgYW5kDQo+ID4gbm9uLXJlc3BvbnNpdmUsIHdlIGRpc2Nv
bm5lY3QgaXQgZXZlbnR1YWxseS4gU28gdGhhdCBsb29rcyB0byBtZSBsaWtlDQo+ID4gcHJvYmVf
Y2xpZW50IHN1cHBvcnQgc2hvdWxkIGFjdHVhbGx5IGJlIG9wdGlvbmFsLCBpZiB5b3VyIGRyaXZl
cg0KPiA+IHJlcG9ydHMgVFggc3RhdHVzPyBBbmQgaW4gdGhhdCBjYXNlLCBJJ2Qgc3RpbGwgcmVj
b21tZW5kIHlvdSB0cnkgdG8gZml4IGhvc3RhcGQuDQo+ID4NCj4gPiBCdXQgaWYgeW91J3JlIHJl
YWxseSBwbGFubmluZyB0byBpbXBsZW1lbnQgcHJvcGVyIHByb2JlX2NsaWVudA0KPiA+IHN1cHBv
cnQsIHRoZW4gSSBzdXBwb3NlIHRoZSBUT0RPIGFwcHJvYWNoIGlzIGFsc28gT0suDQo+ID4NCj4g
PiBJJ2QgYWxzbyByZXF1ZXN0IHRoYXQgeW91IHBsZWFzZSBhY3R1YWxseSBkbyB5b3VyIHJlc2Vh
cmNoIHdoZW4NCj4gPiByZXZpZXdlcnMgYXNrIHF1ZXN0aW9ucy4gSSdtIGZyYW5rbHkgbm90IHN1
cmUgd2h5IEknbSBzcGVuZGluZyBteSB0aW1lDQo+ID4gb24gdGhlIGFib3ZlIHJlc2VhcmNoLCB3
aGVuIHRoZSBvbnVzIHNob3VsZCBiZSBvbiB0aGUgc3VibWl0dGVyIHRvDQo+ID4gZXhwbGFpbiB3
aHkgdGhleSdyZSBkb2luZyB3aGF0IHRoZXkncmUgZG9pbmcuDQo+ID4NCj4gPiBCcmlhbg0KPiAN
Cj4gWWVzLiBJIGtub3cgd2hlbiBhZ2luZyB0aW1lIG9mIHN0YXRpb24gaXMgb3V0LCBob3N0YXBk
IHdpbGwgdXNlIHByb2JlX2NsaWVudCB0bw0KPiBjaGVjayBpZiBzdGF0aW9uIGlzIHN0aWxsIHRo
ZXJlIGJlZm9yZSByZWFsbHkgZGlzY29ubmVjdCBpdC4NCj4gDQo+IFdpdGhvdXQgdGhpcyBmZWF0
dXJlLCBpdCB3b24ndCByZWFsbHkgYWZmZWN0IG1heW9yIGZ1bmN0aW9uIG9mIGhvc3RhcGQuDQo+
IA0KPiBUaGF0IGlzIHRoZSByZWFzb24gdGhhdCBJIHN1Z2dlc3QgdGhhdCB3ZSBwdXQgY29tbWVu
dHMgYW5kIFRPRE8gdG8gdGhlIGNvZGUuDQo+IA0KPiBEYXZpZA0KDQo+IElmIHlvdSBhZ3JlZSB0
aGF0IHRoaXMgZXh0cmEgY2hlY2sgY2FuIGJlIG9wdGlvbmFsLCBtYXliZSBJIGNhbiBqdXN0IHB1
dCB5b3VyIHN1Z2dlc3RlZCBjb21tZW50cyB0byB0aGUgY29kZS4NCg0KPiBEYXZpZA0KDQpQbGVh
c2UgbGV0IG1lIGtub3cgd2hhdCBlbHNlIHNob3VsZCBJIGRvIHRvIGxldCB0aGlzIHBhdGNoIGJl
IEFDS2VkIGJ5IHlvdS4NCg0KVGhhbmtzLA0KRGF2aWQNCg==

