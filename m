Return-Path: <linux-wireless+bounces-9345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA3911987
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 06:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6BDB24387
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3D112C48A;
	Fri, 21 Jun 2024 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvyvXTKP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E7EBE;
	Fri, 21 Jun 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944590; cv=fail; b=IrWL522Agq8a+RdygLXikpT3zJeQNythTi9nA+6nXN2FfEmoSXNa6otxitrCyKoHfdS4jYZk4Y5EfplF1Y96KI0JDu7c8tKZaOtQwOPSZPetfPsZAWrlaULONlF1qyyTltrms8iHmbmAQ6ll3l6OIQaZsRxSPvmuO/N6i6RbuDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944590; c=relaxed/simple;
	bh=4at1mwis7bKSi98D7GCiMIxdfCHOCxtZTmNHvGr32Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+19pAks45gTxU5QT5mQli7SHUKpov6NNXRqCvgF9+d0AA7OCuFmliaW2X3WMkXamazuIuQuWbfSLI0Bgs7XgdJFORMWxGZLxtdVKu6LAOqdDKIPHWWYjx+QgdwpPACmV8L+y5lHrDDsLnY7w7Tr3ptuSuu5IfM6m3a5W5GnumU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvyvXTKP; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdQNsR9mRhUvFgmceFy3ZOmksSLet8WRRJLTPhTUR9k6AClQ0NMdpoxrRfh/MkLSHfRihbEQHKm6Q8HiselrNX/o8ev3lEVf7gUGgpOsvQnm4rfTW6awCn755rN7Pqzr/iNbW7MwKioJbVsfiCzOQYquh9mexEskY2FVnmR4tbDtU2qHZzpTtaNYST0DKMJSZLG1gx9/rcwgrgAfAo/w30CiBnOBGYzTJoSDtq0Z9oARzuJ8AYz77S7uXG2KdrfwBzTVSVlZwRUZCCrpidddujnPwssDxbNxBrS5URxXxvcF2MHjN5tucJTL4m6kMYaxUPRjkFjqG6YXmfE910S1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4at1mwis7bKSi98D7GCiMIxdfCHOCxtZTmNHvGr32Pk=;
 b=XBOPM8RDgR26bLnWAAf95w5NQt4CBge1lTtxEwjoUbErTOh6lI+22hRz3cXwbf62AQPZnAzENq7WdHrLInTzMaM/VkujxJ5rbOuIw1OLAatdxGYU9Vw+Z8g3vFGsB5jdNjSl6BGVlTkoquorLEo4VN2MFcuYTHP5eBsBeskQxe3hc0Y9oM1qLS9I5jyLn5KRAIBrUkC+wBcylA1riVpb+kXXgP5VV4w2khInskr3mzDn+cV8Oaae9xlNXFEeLfJIQqmYp95I9427HKed8QodGsgVRUIERftaGnANHVqMl1eE6lXMEjec8nbUZVecb5Z9jHvXk1pXVjSi/w2yRHQhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4at1mwis7bKSi98D7GCiMIxdfCHOCxtZTmNHvGr32Pk=;
 b=JvyvXTKPRQdUzpsvMMEVG/fDIl96LTGPR2OQ/EvVG0ZWIIzlXsQkBSyWRq2XIz31zR9DQNYVuo5yxizn3NMxsAwLdISvKa2Fz5zVAGQDs7+HSu1fTQ2R+ETIwXlkmz9H2kUnDaT6MHW34yZrKKqTTU+X2NvzfoGZ/UKhV0d6NpU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB9663.eurprd04.prod.outlook.com (2603:10a6:102:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 04:36:24 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 04:36:23 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
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
 AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEwgAAQrACAAB/CYIAp+uAAgACzNCA=
Date: Fri, 21 Jun 2024 04:36:23 +0000
Message-ID:
 <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZnRsfiau_JSWBXTZ@google.com>
In-Reply-To: <ZnRsfiau_JSWBXTZ@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB9663:EE_
x-ms-office365-filtering-correlation-id: a412747d-65b2-4499-ebd1-08dc91abb4da
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?cy9DU0hkYWVhK21QdERCU2RPdW9mN3hESG5jdmVoMHMxQjM1bzAyODhMaGlX?=
 =?utf-8?B?MWw0NFVDVkRsLzRFV3pnM0FuUHlzck1CUGZacFMxNzJxMy9mMkpCb3M5SFc4?=
 =?utf-8?B?NEZlcjNSb21WbnR0ZXc5TDN5eVp4NEVPY3NOdkd3S1o2WFNtMVluaG4rZGVo?=
 =?utf-8?B?MUFxVllKY1VKb21zSkhLVWF4T1pacHgwdlRqVVkveVI0b0FVZDZOT1RqUm9u?=
 =?utf-8?B?T3krYmVjdHQ0dFVFaVFxV0E0Ukw2enp2dWQySjRCU3I1YWU0dldYQ0NFUmRF?=
 =?utf-8?B?VDR6UmlxMDl6UnlBaE9MOXNzQTVQODBMcUQvYXBZWUNjWVJQYkVSY2tvVDE3?=
 =?utf-8?B?OEtrVUNRRkdkZnpDWUVOY0Nna1pKZ21GSHkzZmljT1Nubkp4V05YTDRCMUR6?=
 =?utf-8?B?TmFGSmcrOUVpSElQSEU2S1lRY1EraHVkUE1HRFVOT3pMTXVlZTN5WmpxcmU3?=
 =?utf-8?B?OVlhWG55eTZtelo2V0pCYUwxZmZIckNEUmJiWW5JcHBQQW5POFhtUTQ2ZWRy?=
 =?utf-8?B?MUMxMGljQnZycGJualhFaUZzK21LdWw2dHd6YzFxRjBLcE5CdUtnQnk5Ym5H?=
 =?utf-8?B?SXVYRkkrR2FMYXJ3cUhIc0RiVHRCdC9CMHpLcGZhdDN3ak5tTlN2M1BuT0NX?=
 =?utf-8?B?eEtrZGtDaG9TR0Y2ZEZRbHl0dFh3eFEybnVsY0NlNUxqemtnSlQ4a0o1QXNT?=
 =?utf-8?B?STRnb0c0ZklvV0pxa2FpZHRMMytNcmV1akhvalE4bjJVeUkrTW1nWUQ4YjFN?=
 =?utf-8?B?bU1iZk1QWU5RWDgyZ0RJYndPb29rKyt2U0E2WW8yQWRxaWVaUHlJSmc2QXBP?=
 =?utf-8?B?RmdZNkhjdksxVEZndEgxQmlTRXVhUzlGSkF1alBWUkVFN1llT3c0UFIyUU44?=
 =?utf-8?B?dEszNURoKzFWYVJRRnVMdmJ2U1NEVHpCQU56L3BYUFhKODRCSE5aSzh6Q1cz?=
 =?utf-8?B?aEYwZHIvdytvTHFxMm1CNlJ0cHExd3MraWFSTHdvM1Q3KzRWczZndGhVQVJE?=
 =?utf-8?B?QTdkWjJ6bkdBcTJUTjJxZThveHl0bG4xUjVUWUtQMUM0L3NxV1hsQ0xUUExr?=
 =?utf-8?B?eEdqajlCM2lvWCtGMld4OUt0MXMzREd2UHBrZVYxWm1FK0VEaU1pdTBHVnlS?=
 =?utf-8?B?bWxnN2J5OTJjSlh1YWJRY2hKL25ia2lEdC8yeDMyNlFCOC9pQ0JTUUVaeDhD?=
 =?utf-8?B?bTlacTFUeWN4Zi9ic1RsNEhqTlI0cERiYTlrQnNiejRpaE5iSXBOYXdxTStk?=
 =?utf-8?B?UFdYd1lQZmxwUTB4VStLQ0dEcHF6ZGlrVmFKVktxTzluM3I2UHNIREMwaWRa?=
 =?utf-8?B?YTF0bi9YbVJjb01BcElpeHh5enB3cmhyVWs2WjVvNGFPWHI2VGxqSVJPZUh2?=
 =?utf-8?B?UWRGTHRWTllOcmhwUHJrby9ZbjNXbVdxelJuTXNvSDdCT0JTSTZxbGEvak53?=
 =?utf-8?B?WDFEcGs2SFc0ZEZzVlJXRFRld0dXaWN0UXdHNk44MEZtdjZmb2xpRlBsaFVX?=
 =?utf-8?B?MEJ6QXZlZWhPTkhwNzJZVThiTDZCTDdSSmQwZTlOUnBtMTVCbkxYOXRvcUgy?=
 =?utf-8?B?THEyd0FOTWtTbXFzeG5KR0U0YkpZaDBiVlR0cFllMUJrZGVmVlcyWXhYQXFU?=
 =?utf-8?B?UHlQbXNrYUNpWEQ0bFoxSTQzdklRSi9FRzA1ckJyRkZxQWdTMDgrVWxmT3Fk?=
 =?utf-8?B?UjR4emYvaWxhN3Y3NEZlV0xiYWw3Q0VDMkJJZUtMUFZXRTVGQ2h5VU9yQmFl?=
 =?utf-8?B?Zmh4RnM1bEVpdDhpQTNJalJSN29iK2FIY1hyUjBPaDhBdnJzWWtVelgvWS9U?=
 =?utf-8?Q?pokeo8eJAMM/udvInA04sbuFYuLkOOTSY/cHw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXNzdFlMSVFiZlE3WjJLbzU5cnIraE1zTnlzS0txSCtFRXlqUGRzRWFmUERR?=
 =?utf-8?B?c3BmaE15ak5HN1YyekkwbUpTaTJpekdUTERFN05OWE4yS0pXOVhhOGlET2pk?=
 =?utf-8?B?SHFyck56cnUwRWFlNm5LVXlkK0YyUWRud1pLdUZEMjlKV2VsSWVQNGVoeFgx?=
 =?utf-8?B?RWhoZkNJdXFKNUYyRCtQWjFzODQ1T2c1TnA4SUJhbG9rRWFxTSs3Zml2OFJT?=
 =?utf-8?B?dVBPaXI1YkQvZ3U1OWpwdmx2QXRabXZvQkdFcjJCNSt6a1RXdnRYc3N1SzNo?=
 =?utf-8?B?aHhpMHpHa0tzb0tsRVlJdTg5a3NuRlJpNm1FMjhjTlF3L1ByZVI2emw2MFRU?=
 =?utf-8?B?MDM4M2E0L0pKenRBMEU4TmpGdTVYR0hQakg5QW1MQjlPMHdPWmg2eFVNVCtl?=
 =?utf-8?B?TDJFVXhQa01pd0Y2M1NOOElTcElvU2VVR2NuVzFiRXBuUFJhdHBvMTZsKzRr?=
 =?utf-8?B?eTU5RE5ibzJiVFBBVU9XUkJ0Z2lGb3h4bFk4QnVYRFlQUVJSZWxxQlBiN0VZ?=
 =?utf-8?B?d2U4QlNQemI1TmFQUFF2OFhTd0RCSlFuZjVDejVoR05IaG1waUFpQUYwU0FZ?=
 =?utf-8?B?ZGltTGJ1NnI0M2hsL05GYzFNamp0TG0xTUl0SnVTbWNVMVl6aHczUVNWVEdo?=
 =?utf-8?B?K1J5ZFdBU3hHeitoY1dIaVJoV3JGMEdVOFMycjBIcnZRNjlkTTZ6WFZxL04z?=
 =?utf-8?B?cy8ra09Pb3h3MnErVklPZytZQXN2NlIwbTRIWm5Kc2g1Z05jblFUUm9tSGZw?=
 =?utf-8?B?Tzg5YUhyNzdYaEdKZ3Y2emY5MWF4SWI5VzArZHA4cWJ4VzZZeWsxRGJvZWJ0?=
 =?utf-8?B?SXlOMU5iZllzWTBnR1RsUUpyYS9hWTN3bHBKa2lQenpOYXBER1k4TEN6Wi9z?=
 =?utf-8?B?S2gyMmN3a0paeFpLZFpCS0wvb3FxVTg0WFdEVXdJTjhRSldIK2I2cWNHUXlI?=
 =?utf-8?B?UklyOWZJYzV4K2ttUUlhQldSZ2dPc2RTSkpoV21abVAxQkFuMzc5WXVPQnZQ?=
 =?utf-8?B?MkxtK1hPTW1Mc29DTStCY3lXNlFIZnJybzVpWDlrQ1BTVXUzblEycDQzR01F?=
 =?utf-8?B?SzloL1VXNWRYZjZNU3N4bVNOb25FclFUVVBnVDA4S2x1L2U4RFA0NGdlL2hS?=
 =?utf-8?B?Q2JEOFY3ZTRLSFJYbVNmQUNPa0J0NEFuazgyeWgzSlErSXRYSHlIcDFNaW15?=
 =?utf-8?B?M1haM0JLQ0s0MWx1djROaW0vWGYxQWJucFRpbFFFd1ZJODArYWtzTGwwN3Bq?=
 =?utf-8?B?TlplSVIzc1hWdkhvV2FVdm82akdPMEwyQkcwcWs3Vyt1R25QKzJJcEszTDBz?=
 =?utf-8?B?RXdITjQ5dTlsNHdOUk9KSG9EM29nWHFTR1NKTzNEcWNBMWptcEJtWE5KR1dF?=
 =?utf-8?B?ZXkyemV5amltYXlHcG96ajdVOWRpVm5yZVJnYloyNmYrU09nM3hBVUpsT0cy?=
 =?utf-8?B?bm5jT09td0Z2UmJ6YlNrT0NVdWp4ak84WU9LbkpPUlNKZlFhbHpaTGlvemYw?=
 =?utf-8?B?RUpicHNDNUJpdTlvRGFoSlM4NFRYSXRBTktSck9CNlZNeHhSb3hCU0RiMW5n?=
 =?utf-8?B?ZHRXREhGVlFkOTNoMTBmeG03Zys1NVd6a0Z3blpVUjBOZU9pU05zVDdVMzYw?=
 =?utf-8?B?WkE0R29vdU9kUVl1RkJTQ3pSNitkcGNaZk9QeU9WNm45akp5TlBNdFdhbDU4?=
 =?utf-8?B?QnZFWFZ2WHVub3B0N0g1a3NLZlBFTUgzb3dFRGswRDd4ZUIvUlJScEFZbXNv?=
 =?utf-8?B?UEZZNjM5cVRhYm80VkVkYWNoWXhhcEc3cGxuamhCNEpjYk1teTdpSTg3UFAw?=
 =?utf-8?B?M0pwOUE4SUNwZHF4dC9mQ0kyclpZaSsza005YUZjenNCckFaYWZkYU9ZU3c2?=
 =?utf-8?B?TFNlalVNeTRCbGQ2aHdiOEFmSnhiOEJUTi85eDQrNEllRDZEVWl6OUEvdTBn?=
 =?utf-8?B?cDNRN3VMQ0JMclNRVFhYWmZqNlk3REZwNzhxL1dJYkdDUkRTclFTMXY2dlVv?=
 =?utf-8?B?WDlKOVYvTmxNaTBEYmM1RWJHb2hnOTJIVU1YM3Z2WDcvdjBRTlVIS2ExWjV1?=
 =?utf-8?B?eHNCK3kydXBHb0VyRnh5c25kRWVmU3VwQ0FwRWZCdTFWZzQwdytzanZ0R3hl?=
 =?utf-8?Q?Ei/191NJDyiiGXBaF841se2em?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a412747d-65b2-4499-ebd1-08dc91abb4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 04:36:23.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6PVl6OxuVIsl9QnxCtsXVdtdxZaHL+CX+AN+iZhVRe3Yj8R85YLWB5/rkEU2BKt9wJp4ibOf9HaWFZQWh7D5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9663

SGkgQnJpYW4sDQoNCj4gRnJvbTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5v
cmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyMSwgMjAyNCAxOjUzIEFNDQo+IFRvOiBEYXZpZCBM
aW4gPHl1LWhhby5saW5AbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3ZhbG9Aa2VybmVsLm9yZzsg
ZnJhbmNlc2NvQGRvbGNpbmkuaXQ7IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54
cC5jb20+OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxMCAxLzJdIHdpZmk6IG13aWZp
ZXg6IGFkZCBob3N0IG1sbWUgZm9yIGNsaWVudA0KPiBtb2RlDQo+IA0KPiBDYXV0aW9uOiBUaGlz
IGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlu
a3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBt
ZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+
IEhpIERhdmlkLA0KPiANCj4gT24gU2F0LCBNYXkgMjUsIDIwMjQgYXQgMTI6NTA6NTlBTSArMDAw
MCwgRGF2aWQgTGluIHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFu
bm9ycmlzQGNocm9taXVtLm9yZz4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjUsIDIwMjQg
Njo1NSBBTQ0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTWF5IDI0LCAyMDI0IGF0IDM6MDHigK9QTSBE
YXZpZCBMaW4gPHl1LWhhby5saW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4gPiA+IEkgdGhpbmsgaXQg
bmVlZHMgdGltZSB0byBzdXBwb3J0IHByb2JlIGNsaWVudC4gQ2FuIHdlIHB1dCB5b3VyDQo+ID4g
PiA+IHN1Z2dlc3RlZCBjb21tZW50cyB0byB0aGUgY29kZSB1c2VkIHRvIGhvb2sgcHJvYmVfY2xp
ZW50KCkgYW5kIGFkZA0KPiA+ID4gPg0KPiA+ID4gPiAiVE9ETzogc3VwcG9ydCBwcm9iZSBjbGll
bnQiIHRvIG13aWZpZXhfY2ZnODAyMTFfcHJvYmVfY2xpZW50KCkuDQo+ID4gPg0KPiA+ID4gQXJl
IHlvdSBzdWdnZXN0aW5nIHRoYXQgeW91IHBsYW4gdG8gYWN0dWFsbHkgaW1wbGVtZW50IHByb3Bl
cg0KPiA+ID4gcHJvYmVfY2xpZW50IHN1cHBvcnQ/IERpZCB5b3UgYWxyZWFkeSBkbyB3aGF0IEkg
c3VnZ2VzdGVkLCBhbmQNCj4gPiA+IHVuZGVyc3RhbmQgd2h5IGhvc3RhcGQgbmVlZHMgcHJvYmVf
Y2xpZW50IHN1cHBvcnQ/IFRoaXMgc2VlbXMgdG8gYmUNCj4gPiA+IGEgY29tbW9uIHBhdHRlcm4g
LS0gdGhhdCByZXZpZXdlcnMgYXJlIGFza2luZyBmb3IgeW91IHRvIGRvIHlvdXINCj4gPiA+IHJl
c2VhcmNoLCBhbmQgaXQgdGFrZXMgc2V2ZXJhbCByZXF1ZXN0cyBiZWZvcmUgeW91IGFjdHVhbGx5
IGRvIGl0Lg0KPiA+ID4NCj4gPiA+IE5vdyB0aGF0IEkndmUgdHJpZWQgdG8gZG8gdGhhdCByZXNl
YXJjaCBmb3IgeW91IC4uLiBpdCBsb29rcyBsaWtlDQo+ID4gPiBob3N0YXBkIHVzZXMgcHJvYmVf
Y2xpZW50IHRvIGF1Z21lbnQgVFggTUdNVCBhY2tzLCBhcyBhIHByb3h5IGZvcg0KPiA+ID4gc3Rh
dGlvbiBwcmVzZW5jZSAvIGluYWN0aXZpdHkuIElmIGEgc3RhdGlvbiBpcyBpbmFjdGl2ZSBhbmQN
Cj4gPiA+IG5vbi1yZXNwb25zaXZlLCB3ZSBkaXNjb25uZWN0IGl0IGV2ZW50dWFsbHkuIFNvIHRo
YXQgbG9va3MgdG8gbWUNCj4gPiA+IGxpa2UgcHJvYmVfY2xpZW50IHN1cHBvcnQgc2hvdWxkIGFj
dHVhbGx5IGJlIG9wdGlvbmFsLCBpZiB5b3VyDQo+ID4gPiBkcml2ZXIgcmVwb3J0cyBUWCBzdGF0
dXM/IEFuZCBpbiB0aGF0IGNhc2UsIEknZCBzdGlsbCByZWNvbW1lbmQgeW91IHRyeSB0byBmaXgN
Cj4gaG9zdGFwZC4NCj4gPiA+DQo+ID4gPiBCdXQgaWYgeW91J3JlIHJlYWxseSBwbGFubmluZyB0
byBpbXBsZW1lbnQgcHJvcGVyIHByb2JlX2NsaWVudA0KPiA+ID4gc3VwcG9ydCwgdGhlbiBJIHN1
cHBvc2UgdGhlIFRPRE8gYXBwcm9hY2ggaXMgYWxzbyBPSy4NCj4gPiA+DQo+ID4gPiBJJ2QgYWxz
byByZXF1ZXN0IHRoYXQgeW91IHBsZWFzZSBhY3R1YWxseSBkbyB5b3VyIHJlc2VhcmNoIHdoZW4N
Cj4gPiA+IHJldmlld2VycyBhc2sgcXVlc3Rpb25zLiBJJ20gZnJhbmtseSBub3Qgc3VyZSB3aHkg
SSdtIHNwZW5kaW5nIG15DQo+ID4gPiB0aW1lIG9uIHRoZSBhYm92ZSByZXNlYXJjaCwgd2hlbiB0
aGUgb251cyBzaG91bGQgYmUgb24gdGhlIHN1Ym1pdHRlcg0KPiA+ID4gdG8gZXhwbGFpbiB3aHkg
dGhleSdyZSBkb2luZyB3aGF0IHRoZXkncmUgZG9pbmcuDQo+ID4NCj4gPiBZZXMuIEkga25vdyB3
aGVuIGFnaW5nIHRpbWUgb2Ygc3RhdGlvbiBpcyBvdXQsIGhvc3RhcGQgd2lsbCB1c2UgcHJvYmVf
Y2xpZW50DQo+IHRvIGNoZWNrIGlmIHN0YXRpb24gaXMgc3RpbGwgdGhlcmUgYmVmb3JlIHJlYWxs
eSBkaXNjb25uZWN0IGl0Lg0KPiA+DQo+ID4gV2l0aG91dCB0aGlzIGZlYXR1cmUsIGl0IHdvbid0
IHJlYWxseSBhZmZlY3QgbWF5b3IgZnVuY3Rpb24gb2YgaG9zdGFwZC4NCj4gDQo+IEknbSBnbGFk
ICp5b3UqIGtub3cgYWxsIGFib3V0IHRoZSBhYm92ZSBiZWhhdmlvciwgYnV0ICpJKiBkaWRuJ3Qg
a25vdyBhYm91dCBpdA0KPiB1bnRpbCBJIHdlbnQgYW5kIHJlc2VhcmNoZWQgd2hhdCB0aGlzIEFQ
SSBkb2VzLCBhbmQgaG93IGhvc3RhcGQgaXMgdXNpbmcgaXQuIEJ1dA0KPiB0aGF0IGlzbid0IG15
IGpvYiAtLSBpdCdzIHlvdXIgam9iLCBhcyB0aGUgY29kZSBzdWJtaXR0ZXIsIHRvIGV4cGxhaW4g
eW91cg0KPiByZWFzb25pbmcgYW5kIHJlZHVjZSB0aGUgYW1vdW50IG9mIHdvcmsgdGhhdCByZWFk
ZXJzL3Jldmlld2Vycy9tYWludGFpbmVycw0KPiBoYXZlIHRvIGRvIHRvIHVuZGVyc3RhbmQgeW91
ciBjb2RlIGFuZCBhZ3JlZSB0aGF0IGl0IGlzIHRoZSByaWdodCB0aGluZyB0byBkby4NCj4gDQo+
IEl0J3Mgbm90IGNsZWFyIHRvIG1lIHRoYXQgeW91J3ZlIHJlYWxseSBsZWFybmVkIHRoZSBhYm92
ZSBsZXNzb24sIGFuZCBpdCdzIHJlYWxseQ0KPiBhZmZlY3RpbmcgdGhlIHJhdGUgYXQgd2hpY2gg
SSByZXZpZXcgeW91ciBjb2RlLiBUaGlzIGlzIGJ5IGZhciBub3QgdGhlIGZpcnN0IHRpbWUNCj4g
dGhhdCB5b3UndmUgcGxhY2VkIHRoZSBidXJkZW4gb24gdGhlIHJlYWRlci4gQW5kIGlmIHlvdSdy
ZSBnb2luZyB0byBtYWtlIHRoZQ0KPiBqb2IgZGlmZmljdWx0LCB0aGVuIEknbGwgcHJpb3JpdGl6
ZSBlbmpveWluZyBteSBmcmVlIHRpbWUsIG9yIHN0dWZmIHRoYXQgYWN0dWFsbHkgcGF5cw0KPiBt
ZSBhdCAkREFZX0pPQiwgb3IgLi4uDQoNCkkgd2lsbCBrZWVwIHRoaXMgaW4gbWluZC4NCg0KPiAN
Cj4gPiBUaGF0IGlzIHRoZSByZWFzb24gdGhhdCBJIHN1Z2dlc3QgdGhhdCB3ZSBwdXQgY29tbWVu
dHMgYW5kIFRPRE8gdG8gdGhlDQo+IGNvZGUuDQo+IA0KPiBPSywgSSBzdXBwb3NlIHRoYXQgd29y
a3MgZm9yIG1lLg0KPiANCj4gQnJpYW4NCg0KSSBzdWdnZXN0IHRoYXQgd2UganVzdCBwdXQgeW91
ciBjb21tZW50cyBhbmQgcHJlcGFyZSBwYXRjaCB2MTEuDQoNClRoYW5rcywNCkRhdmlkDQo=

