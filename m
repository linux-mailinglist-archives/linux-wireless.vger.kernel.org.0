Return-Path: <linux-wireless+bounces-10805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31F944207
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 05:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D78283A91
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B4C13D613;
	Thu,  1 Aug 2024 03:53:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6211EB492;
	Thu,  1 Aug 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484383; cv=fail; b=YPYrjG6XLzrUkRdNyCWpLv8ZmcURRA6OUWMD4mIaESjOr61Ee+h7gHg2wFXpz/KMBmI6RDF+mNq5qq2NBcqxk4YbqVtf//usLD3uKWvWJaHlWZ7clN0bbkt4Qc8Lbb5xMqD11l77IKNAsEBLU1tvZHlqbMg/OrRrrPDlIvACroc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484383; c=relaxed/simple;
	bh=zEXwebYIL4dXQ8ynyT7NyxAf7dRIwmZzdOHykdTEhDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRYPzT3LvbN9Q4vRzYCq8hpmXfLkPLSl1eT29xbG3hk3VPbvGgJFlwNy1Nj2ldHInwdvA6P8aJuKaNwyWki6TAByedr4hJCyzl0IW6ZmXa22zvomX3ImnVFUYbU+zvG5W/p+c16Xbd2pPeixBDYbhBhPcLHcT75QgkJ+MMWgJAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB2AVGmaNlwtwQa06r1hEUYDmiyGZcROb5KaZlw91Pf/Lrg6F/L9iHpCpuhxvhVDNhAEI8rsFGr3rEcCK3XWxY12OMuqEybpcPP5opGPJyVek0/DtMa4dtd/YAZIvS34IzvIFwkJdW3MHNzdDl0M2BQ8BH8glJ30alqUfyBtakRYivt0fWF65o+hwEse+EW+vVmOCjTvmDGt+pMP0+NXOP8mB3NX+9ycI3O1icZh240McoTfDYbcYcVlU8apuX6vbU4pSbZl5uQvfopX2w7SVQXIhzhUmzL6X3HF41koLNQGoX0jNCbuwGvRXSTK/nOthF2qDTTEMpaHDnw6Dz927A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEXwebYIL4dXQ8ynyT7NyxAf7dRIwmZzdOHykdTEhDc=;
 b=Wu6WExqZLlk58OLkkZHP03vn60eSeDAYfToBCiDTsJIb49ZJgEYrkqeBdzJSIGTy5siddh/0c4DvdF70C7xMI383qJAtq23hQZklIk1HlTRaijcjJFT/OyeD8QByQooLqPRkB0kbv/glVg0K6Hp/zyIYGUrbhxMYXso3q9dQe9bSUAuFgIsVT0tAOo3mN4gR28FB46qxrjtPiOIRYX09hwuowP7ilJrAGEXW2YE5pF8BUmA6ZnbrJLwVBoiWyDiXRYwnsGx2UNz9P2tW196L2qbRx0kFO2iIb1HARguMF0xXvpsuA7yy955TPQ0PTqHqY9JqoBFmr4IFlTs6RqUO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB6764.apcprd03.prod.outlook.com (2603:1096:101:67::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 03:52:55 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 03:52:55 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Alexey Charkov <alchark@gmail.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "dsimic@manjaro.org" <dsimic@manjaro.org>,
	"jagan@edgeble.ai" <jagan@edgeble.ai>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arend@broadcom.com" <arend@broadcom.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
	<megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Subject: Re: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Topic: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Index:
 AQHa4xCLys23WWCKBkqKCO8epOhNALIQn2kAgAAQNwCAAA0NgIAACJeAgAAGrACAAOnsnw==
Date: Thu, 1 Aug 2024 03:52:55 +0000
Message-ID:
 <TYZPR03MB7001889335D58561F86978A780B22@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com>
 <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
 <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com>
 <CABjd4YxiSY0A0iVHGHw9RDey+avxmzUapoLLLyf=80MzVX0yWA@mail.gmail.com>
 <6e34c814-a6dc-4a96-9e46-ca25af67f4f6@broadcom.com>
 <CABjd4YxdCh7EceYOfcFxKtV0H7Von0oZAMWD=69sM6y4-CoAQw@mail.gmail.com>
In-Reply-To:
 <CABjd4YxdCh7EceYOfcFxKtV0H7Von0oZAMWD=69sM6y4-CoAQw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB6764:EE_
x-ms-office365-filtering-correlation-id: aaf90a20-fbb8-4c36-df2f-08dcb1dd6d07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NG1aaXZVVkZVTnlKclRnMjhoMGNCTWpuOVRYbnhwa0ZSeElWRDY0dVMwbWpQ?=
 =?utf-8?B?T3dndER0aDRCRWVGcENod0Ezem1PTUR6WWlMcis1MnM4MFovOUZsN1BwVStC?=
 =?utf-8?B?QzlwcFRpU1pIczYxU29BUEVaeXRuemZZd2RFd2FYdk16cGs2ZVhTRVpKeTNP?=
 =?utf-8?B?ZWUya1BmcHhPNWN3elBPUytBeDJhM1JvQ2dMckI2ZC9NUVVKeFZOUG0xVElq?=
 =?utf-8?B?d2t1UVNtVWJwSXhHcEhrdW9mSUU4Y3owcjVTaVVpdlNGMTFLb1h6QlFqVlpx?=
 =?utf-8?B?MUtDRkFjY0twaGpwSHppWVF1aHczdE8yaTB5SzkzQTBmVitWYlA4MXM0Qlp0?=
 =?utf-8?B?R3U0UysvOVE3THVpQjZOSGFXbUxGTEFkT3FTSGN3QUlaT0g3U1JjRkcrU2Vh?=
 =?utf-8?B?L0dhTEwyaGxuQUhtaExCcVhqOEdBNm54cUxnWXh4SHhxdll3TDhQZFVZV3RR?=
 =?utf-8?B?ckl6UHN5RS9BVlY2eElWWmtYNWRqVSsxWkdLa1MrZW1aRVQ1eEh4YWlobHBu?=
 =?utf-8?B?UnJJZnpuN0hULzVDcHF1TU9icEl3bzBQa0NnVG1sL0ljTWhyUFJieHFCVG9P?=
 =?utf-8?B?T3BYQThjSEJMUmxkUWNLc0MvS0RINlliMlJkRU80QUF4NUlJYlFUNzJiRFZ2?=
 =?utf-8?B?dGM1N0hBRmZjL2JIOFNFUkJiM2JLUlFLMWdXMTBvbkREZ2k5N0I4bHlmTTVQ?=
 =?utf-8?B?WVVDa00yS0RUYkJBbGFkOCtUWXhhKy9OQlhmU0FIdUh0M2JzUUFSbisvejdR?=
 =?utf-8?B?ck5HRkZVVTUvNUx3bm5EcVBPY2J3bjV0VUxIVkYydVJ3dmNweDZJQmFpdHJH?=
 =?utf-8?B?Qzk3dTdlZFhMN25talBvUzNKRlJ6eEVDZTNPT1lQMjIrYTdqekErZjZ0ZlBq?=
 =?utf-8?B?WDFoZTlUbHkvWHdzdjZSREJrdGlsOWhBKzU1dmJIR2x2MHdXSWg1TzhiVHY2?=
 =?utf-8?B?L04wWVhCWFBtRXVocjNXL054aTZFWWNZY1dJYzNOUEM1ZEVzMCtrZXljWFk2?=
 =?utf-8?B?VStlbXNTNHBUKzBCN3Nsa3AyMG1IeEFTUGRNTDRQSDZtYjBaY2xyZzI0MjR3?=
 =?utf-8?B?K2xwOUJwcjZHMG1obTJXMk5nTlZhaWJmLzFsbmkwaVhyeU5yeThqQ0ZPeGxO?=
 =?utf-8?B?Q2RhQjF2UVZYeXNmcmM3aURTRlBXbDdPcWplZlg2OEcwbEVWQjhJZFU0MnJw?=
 =?utf-8?B?UTFkY0tYd1BTeHl0WlJDWXdvOHlRVlB0REVPWGJRdTRPakUyY3pMVkpRbzVP?=
 =?utf-8?B?Z2RtelhmNkZMWGo1clJFMDIrdHBHdXlDR1RRV0ZHY0tXN2MrMnhFTkRrL3RI?=
 =?utf-8?B?a2RCakQvZnZRY1czWVNxR0hJRDgrS0ZVeTBnSjZFOXRwaHljRm1vTnVIMmk4?=
 =?utf-8?B?Z0NuSlk3MWhrRUhrQ2JYNWQvV2cxMUJ1Vy9NRHhKQWxDem1OY3ZSWVdNa2JT?=
 =?utf-8?B?anBvUzF6M2trTFRvYUt5KzZZM3B2SHR1QktxYVNuZnpRZUpYN3dYdHdHMkQ4?=
 =?utf-8?B?cWVteDdKUjdmSVM0eXV2Qm9RU3ZXbDRWNmk0MTQxVmZqcGdsaGZaR3BjNTli?=
 =?utf-8?B?TDdPU293K3F5cUE5WHJ2aXN6OEVoMFhOR0VZVktKTE9sVENYTkxUbXN5RnV6?=
 =?utf-8?B?ZTBqV2gvN2pXcEphR3BtSmUvbnQ3SENvQkt4UWZrYzEySXJwQVFFQmNRalQ3?=
 =?utf-8?B?YzV6N3JabU5JdkdEMnY2d01ka3dNMzhkRWE1blo4SkszS21Ta3R6UURvTk5z?=
 =?utf-8?B?NGlQMlg1cVdSbFV5cTJZM2JQVGNCYlc3em85d2NVUDFZZC84SThydjZOaXJB?=
 =?utf-8?B?WExWZG5kTk1vbENaRUYyRURKN3JOeS9FNjhnSlNvN1lGdGI1d25WMXRXT0hL?=
 =?utf-8?B?d3BJWXhJVFJ5VmZFZEpNSGgvMnlQL0I0UGh6bHAvL3pzeVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUM5bm9TRnBlOXQrZXlQam42VDBmT2ZKaDlXZjB3YmRtR2NFZzRRaVFrdktF?=
 =?utf-8?B?SVcwZTZvT3RwWUhRREhJdTgzWllmeGxiVXlTb1o4b2hQTmhPRWM3c0d2ZHcr?=
 =?utf-8?B?YUdCWU5GajBhUGpDK0V5L3NvVGRUSDh2OWlrS2ZNTy81S05rck1ZNG1LcURI?=
 =?utf-8?B?NFlTeXI3VUcwWkptSTNaZnlRUTZwb004WHNVbnBwRzcvbHNMbXBrdXdVM0ZP?=
 =?utf-8?B?OERyMmJmeEdiT2hvelVuOWNhbk0vQk5iWGpMUjZRbGpRY25aajNReDdVUXkr?=
 =?utf-8?B?N1pDSmVFZVBQUVF6Z0FkU2p0UVNIeEJTcWlkSlN1cEdaeVRTa1FpSDl0VkZp?=
 =?utf-8?B?VDZSU3JSWjVFakZiWVZmc09ta1pmWVFpTEtyeFhzNElqSUNnU1p0dWtTaE8z?=
 =?utf-8?B?VXNRN0VnOEJHSTlsU0g3bEErVGNOb3N4WFRHc1FDOXhxdnBJbUNXbHBCZWFp?=
 =?utf-8?B?UXRGd3dqWmU3TmkzeURqQnNxQjg1NEQ3VzBKZnM0bDdwSXhDQ00rZ3dJUU83?=
 =?utf-8?B?bG9PREdQcENvamc1b010Nml3c0dhTnlVR04yOUtsMStIYVc0enFkWlN1QWph?=
 =?utf-8?B?dUE0K2M2V2J1MjhabzBZT1NPS1E4bEF4a2dKUlJCNWxIcmZlWkNMdzBxcFBJ?=
 =?utf-8?B?UXQ3N2twb0tpZE93Y0o2bmN6eUNBOFZCT1JndHo2ZFNwdnJRNUNSeVl3QVhV?=
 =?utf-8?B?Mk9hTWd2KzR3V3Q2SUgxa0d3dzFiWSt0ckc0aEhtOFl5czArT2NIcEl1SXNl?=
 =?utf-8?B?ejU5dFljSlh5bmJUSjJTMU9jMXdxRE1IVHdMRU5yVDFqcmVwTHVSdGZLYmJr?=
 =?utf-8?B?SXlweVNNRkdSbm9WdURCOUZNQXJuR1pOVXJkZnpsUmxXeHlmNCsvcXNlZkxB?=
 =?utf-8?B?Z3A5WFlLb0dSZGQ3WUJPdzBReW10bGpTODRqQ1FSQi8xNnRPTTZHN3dBaERw?=
 =?utf-8?B?Ti9oNFJGU0tPSWVoN2RhN1NVcEVobktiWWYvR3ZQcG10Vmo4T0t2M01VM2xI?=
 =?utf-8?B?Y09FYXVVZityNWxlS2pSWW5mQnVOL25HTDhJQy9nTFkrYWptQTVjZjR5eXlq?=
 =?utf-8?B?WXhyZ3liVlhUcmQ0a3BKa1hObW9OSFUyRkw1V2V1UFhoTElzMW0rRTI5R3Q5?=
 =?utf-8?B?WkRrenFQamMwVlVUby9ZRStPVXFKeVVWVDcvajcwNWd1Z0x6ZEZodHhtMU1v?=
 =?utf-8?B?SmlacE5rUC9uc1ZjN2VtaDFFQlNsWG5LMEVHVFFmd1lBTVhlVFQ4cHRlQXhX?=
 =?utf-8?B?TVdBWmpuUXVsOVo2RGQyQzRWS0hSUWMzU2NxOTkyUzZZenRwaUFKNHplRk93?=
 =?utf-8?B?SnFKTTFZK3lrQUFkMkc5OTVPTkJCTCttRW5SZ1l2L1NzNVM3SlphRHMyWUQ0?=
 =?utf-8?B?VTZlMU1ndnVFbXpZYXY1RHh4dDM0bFp6Z2VUb0k1bWJsNmcxY09hMmFGbmFn?=
 =?utf-8?B?TUlOdnBNYmVkb2kvbEd2azJPbjFZS20yK1RuSlpHT2JyRFM0TmRhVW5BYXlJ?=
 =?utf-8?B?bXk1Mmx6cXd4dEt0SytzWjloY2FzOTZteDRwUlBzQXBiMmQ2d2gvNXJDSkdo?=
 =?utf-8?B?Y0o4ZXhJRk51V1ZRb0dxaXNUYzY5THpDejVVMHV4cGVHNnljamI1WjFGQ2Vq?=
 =?utf-8?B?cWh1UWc0WkZoNWs0TURhK2lJTjlvd0xmQlhURVFYa1ZkOVhQTmdjenJHWjF0?=
 =?utf-8?B?bmF2OFAvSjZsUGpyVlVpL2lTanZPWjZtUTZOc1lCbFVBNDVLaGM3aUt1clhN?=
 =?utf-8?B?U0pwY2czZlVET2hwWWNEb2UyVXJGQ0Y2NWxoQlFoZElIc1F4RWdYdGtPcGEx?=
 =?utf-8?B?QmNZRGl5R1k3MTdSVWlLNDA4ZlZhaUcxTklVYmlRSWtTajZiZGE1U29XMFc1?=
 =?utf-8?B?Tko2N3FFQXBJU2loMjZFb1IvaTlGZWlIS0NKY1pKTGZNRDl2NG9CM0FlamN0?=
 =?utf-8?B?VHBqWDk4RU1qejhpM0I5bmJpK25yMlpFZ3VteTNpK0JWcUVaNGkxemdWWEFO?=
 =?utf-8?B?U1BJNkZRM1pFZEEzcC9VUTIyeTl3ZXlQYkJMc2pHY0JSaVdpWHR1eVlaMzRB?=
 =?utf-8?B?WGtwQzFDMmxMbmdObWdIc1FNUmhEWGI1eUNDTVB6R0ZoeGczT1hyMmlSWWdq?=
 =?utf-8?Q?Mc1cudpRMJwCZOuuu2JzU67Zt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf90a20-fbb8-4c36-df2f-08dcb1dd6d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:52:55.4857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aT7spNmnOuefZAnD70r4b6VAsksKND+jr82sUpMZEjntoAdT8QhBcNBE39dPSBKgk8hKBs8uAhVg+UOJ3q5tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6764

Pj5PbiA3LzMxLzIwMjQgMjowMSBQTSwgQWxleGV5IENoYXJrb3Ygd3JvdGU6Cj4+PiBPbiBXZWQs
IEp1bCAzMSwgMjAyNCBhdCAyOjE14oCvUE0gQXJlbmQgdmFuIFNwcmllbAo+Pj4gPGFyZW5kLnZh
bnNwcmllbEBicm9hZGNvbS5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gNy8zMS8yMDI0IDEyOjE2
IFBNLCBBbGV4ZXkgQ2hhcmtvdiB3cm90ZToKPj4+Pj4gSGkgSmFjb2JlLAo+Pj4+Pgo+Pj4+Pgo+
Pj4+PiBPbiAzMS8wNy8yMDI0IDk6MTEgYW0sIEphY29iZSBaYW5nIHdyb3RlOgo+Pj4+PsKgwqAg
PiBXaUZpIG1vZHVsZXMgb2Z0ZW4gcmVxdWlyZSAzMmtIeiBjbG9jayB0byBmdW5jdGlvbi4gQWRk
IHN1cHBvcnQgdG8KPj4+Pj7CoMKgID4gZW5hYmxlIHRoZSBjbG9jayB0byBQQ0llIGRyaXZlciBh
bmQgbW92ZSAiYnJjbSxiY200MzI5LWZtYWMiIGNoZWNrCj4+Pj4+wqDCoCA+IHRvIHRoZSB0b3Ag
b2YgYnJjbWZfb2ZfcHJvYmUKPj4+Pj7CoMKgID4KPj4+Pj7CoMKgID4gQ28tZGV2ZWxvcGVkLWJ5
OiBPbmRyZWogSmlybWFuIDxtZWdpQHhmZi5jej4KPj4+Pj7CoMKgID4gU2lnbmVkLW9mZi1ieTog
T25kcmVqIEppcm1hbiA8bWVnaUB4ZmYuY3o+Cj4+Pj4+wqDCoCA+IFNpZ25lZC1vZmYtYnk6IEph
Y29iZSBaYW5nIDxqYWNvYmUuemFuZ0B3ZXNpb24uY29tPgo+Pj4+PsKgwqAgPiAtLS0KPj4+Pj7C
oMKgID7CoCAuLi4vbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9vZi5j
wqDCoMKgIHwgMTIgKysrKysrKysrKystCj4+Pj4+wqDCoCA+wqAgMSBmaWxlIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pj7CoMKgID4KPj4+Pj7CoMKgID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1h
Yy9vZi5jCj4+Pj4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2Jy
Y21mbWFjL29mLmMKPj4+Pj7CoMKgID4gaW5kZXggZTQwNmUxMTQ4MWE2Mi4uN2UwYTJhZDVjN2M4
YSAxMDA2NDQKPj4+Pj7CoMKgID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20v
YnJjbTgwMjExL2JyY21mbWFjL29mLmMKPj4+Pj7CoMKgID4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL29mLmMKPj4+Pj7CoMKgID4gQEAgLTYs
NiArNiw3IEBACj4+Pj4+wqDCoCA+wqAgI2luY2x1ZGUgPGxpbnV4L29mLmg+Cj4+Pj4+wqDCoCA+
wqAgI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPgo+Pj4+PsKgwqAgPsKgICNpbmNsdWRlIDxsaW51
eC9vZl9uZXQuaD4KPj4+Pj7CoMKgID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4KPj4+Pj7CoMKg
ID4KPj4+Pj7CoMKgID7CoCAjaW5jbHVkZSA8ZGVmcy5oPgo+Pj4+PsKgwqAgPsKgICNpbmNsdWRl
ICJkZWJ1Zy5oIgo+Pj4+PsKgwqAgPiBAQCAtNzAsMTIgKzcxLDE2IEBAIHZvaWQgYnJjbWZfb2Zf
cHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtCj4+Pj4+IGJyY21mX2J1c190eXBlIGJ1c190
eXBlLAo+Pj4+PsKgwqAgPsKgIHsKPj4+Pj7CoMKgID7CoMKgwqDCoMKgIHN0cnVjdCBicmNtZm1h
Y19zZGlvX3BkICpzZGlvID0gJnNldHRpbmdzLT5idXMuc2RpbzsKPj4+Pj7CoMKgID7CoMKgwqDC
oMKgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqcm9vdCwgKm5wID0gZGV2LT5vZl9ub2RlOwo+Pj4+PsKg
wqAgPiArwqDCoMKgIHN0cnVjdCBjbGsgKmNsazsKPj4+Pj7CoMKgID7CoMKgwqDCoMKgIGNvbnN0
IGNoYXIgKnByb3A7Cj4+Pj4+wqDCoCA+wqDCoMKgwqDCoCBpbnQgaXJxOwo+Pj4+PsKgwqAgPsKg
wqDCoMKgwqAgaW50IGVycjsKPj4+Pj7CoMKgID7CoMKgwqDCoMKgIHUzMiBpcnFmOwo+Pj4+PsKg
wqAgPsKgwqDCoMKgwqAgdTMyIHZhbDsKPj4+Pj7CoMKgID4KPj4+Pj7CoMKgID4gK8KgwqDCoCBp
ZiAoIW5wIHx8ICFvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImJyY20sYmNtNDMyOS1mbWFj
IikpCj4+Pj4+wqDCoCA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+Pj4+Cj4+Pj4+IERpZCB5
b3UgdGVzdCB0aGlzPyBUaGUgRFRTIHBhdGNoIHlvdSBzZW50IGFzIHBhcnQgb2YgdGhpcyBzZXJp
ZXMgZG9lc24ndAo+Pj4+PiBsaXN0ICJicmNtLGJjbTQzMjktZm1hYyIgaW4gdGhlIGNvbXBhdGli
bGUsIHNvIHRoaXMgd2lsbCBwcm9iYWJseSByZXR1cm4KPj4+Pj4gcmlnaHQgaGVyZSwgc2tpcHBp
bmcgb3ZlciB0aGUgcmVzdCBvZiB5b3VyIHBhdGNoLgo+Pj4+Pgo+Pj4+PiBQbGVhc2UgdGVzdCBi
ZWZvcmUgcmVzZW5kaW5nLCBib3RoIHdpdGggYW5kIHdpdGhvdXQgdGhlIGRyaXZlciBmb3IgdGhl
Cj4+Pj4+IEJsdWV0b290aCBwYXJ0IG9mIHRoZSBjaGlwIChzaW5jZSBpdCBhbHNvIHRvdWNoZXMg
Y2xvY2tzKS4KPj4+Pj4KPj4+Pj4gWW91IGFyZSBhbHNvIGNoYW5naW5nIHRoZSBiZWhhdmlvciBm
b3Igb3RoZXIgc3lzdGVtcyBieSBwdXR0aW5nIHRoaXMKPj4+Pj4gY2hlY2sgZnVydGhlciB1cCB0
aGUgcHJvYmUgcGF0aCwgd2hpY2ggbWlnaHQgYnJlYWsgdGhpbmdzIGZvciBubyByZWFzb24uCj4+
Pj4+IEJldHRlciBwdXQgeW91ciBjbGstcmVsYXRlZCBhZGRpdGlvbiBiZWxvdyB3aGVyZSB0aGlz
IGNoZWNrIHdhcwo+Pj4+PiBvcmlnaW5hbGx5LCByYXRoZXIgdGhhbiByZW9yZGVyIHN0dWZmIHlv
dSBkb24ndCBoYXZlIHRvIHJlb3JkZXIuCj4+Pj4KPj4+PiBUaGF0IHdhcyB1cG9uIG15IHN1Z2dl
c3Rpb24uIFRoYXQgY2hlY2sgd2FzIG9yaWdpbmFsbHkgYXQgdGhlIHRvcCBvZiB0aGUKPj4+PiBm
dW5jdGlvbiwgYnV0IHBlb3BsZSBhZGRlZCBzdHVmZiBiZWZvcmUgdGhhdC4gSSBhZ3JlZSB0aGF0
IG1ha2VzIHRoZQo+Pj4+IGNvbXBhdGlibGUgImJyY20sYnJjbTQzMjktZm1hYyIgcmVxdWlyZWQg
d2hpY2ggaXMgd2hhdCB0aGUgdGV4dHVhbAo+Pj4+IGJpbmRpbmcgc3RhdGVkIGJlZm9yZSB0aGUg
c3dpdGNoIHRvIFlBTUwgd2FzIG1hZGU6Cj4+Pj4KPj4+PiAiIiIKPj4+PiBCcm9hZGNvbSBCQ000
M3h4IEZ1bGxtYWMgd2lyZWxlc3MgU0RJTyBkZXZpY2VzCj4+Pj4KPj4+PiBUaGlzIG5vZGUgcHJv
dmlkZXMgcHJvcGVydGllcyBmb3IgY29udHJvbGxpbmcgdGhlIEJyb2FkY29tIHdpcmVsZXNzCj4+
Pj4gZGV2aWNlLiBUaGUKPj4+PiBub2RlIGlzIGV4cGVjdGVkIHRvIGJlIHNwZWNpZmllZCBhcyBh
IGNoaWxkIG5vZGUgdG8gdGhlIFNESU8gY29udHJvbGxlciB0aGF0Cj4+Pj4gY29ubmVjdHMgdGhl
IGRldmljZSB0byB0aGUgc3lzdGVtLgo+Pj4+Cj4+Pj4gUmVxdWlyZWQgcHJvcGVydGllczoKPj4+
Pgo+Pj4+wqDCoMKgIC0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAiYnJjbSxiY200MzI5LWZtYWMi
Lgo+Pj4+ICIiIgo+Pj4+Cj4+Pj4gTm90IHN1cmUgd2hldGhlciB0aGlzIGlzIHN0aWxsIHRydWUg
Zm9yIFlBTUwgdmVyc2lvbiAocG9vciBZQU1MIHJlYWRpbmcKPj4+PiBza2lsbHMgOy0pICksIGJ1
dCBpdCBzaG91bGQgYXMgdGhlIHN3aXRjaCBmcm9tIHRleHR1YWwgdG8gWUFNTCBzaG91bGQKPj4+
PiBub3QgaGF2ZSBjaGFuZ2VkIHRoZSBiaW5kaW5ncyBzcGVjaWZpY2F0aW9uLgo+Pj4+Cj4+Pj4+
wqDCoCA+ICsKPj4+Pj7CoMKgID7CoMKgwqDCoMKgIC8qIEFwcGxlIEFSTTY0IHBsYXRmb3JtcyBo
YXZlIHRoZWlyIG93biBpZGVhIG9mIGJvYXJkIHR5cGUsCj4+Pj4+IHBhc3NlZCBpbgo+Pj4+PsKg
wqAgPsKgwqDCoMKgwqDCoCAqIHZpYSB0aGUgZGV2aWNlIHRyZWUuIFRoZXkgYWxzbyBoYXZlIGFu
IGFudGVubmEgU0tVIHBhcmFtZXRlcgo+Pj4+PsKgwqAgPsKgwqDCoMKgwqDCoCAqLwo+Pj4+PsKg
wqAgPiBAQCAtMTEzLDggKzExOCwxMyBAQCB2b2lkIGJyY21mX29mX3Byb2JlKHN0cnVjdCBkZXZp
Y2UgKmRldiwgZW51bQo+Pj4+PiBicmNtZl9idXNfdHlwZSBidXNfdHlwZSwKPj4+Pj7CoMKgID7C
oMKgwqDCoMKgwqDCoMKgwqAgb2Zfbm9kZV9wdXQocm9vdCk7Cj4+Pj4+wqDCoCA+wqDCoMKgwqDC
oCB9Cj4+Pj4+wqDCoCA+Cj4+Pj4+wqDCoCA+IC3CoMKgwqAgaWYgKCFucCB8fCAhb2ZfZGV2aWNl
X2lzX2NvbXBhdGlibGUobnAsICJicmNtLGJjbTQzMjktZm1hYyIpKQo+Pj4+PsKgwqAgPiArwqDC
oMKgIGNsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKGRldiwgImxwbyIpOwo+Pj4+
PsKgwqAgPiArwqDCoMKgIGlmICghSVNfRVJSX09SX05VTEwoY2xrKSkgewo+Pj4+PsKgwqAgPiAr
wqDCoMKgwqDCoMKgwqAgYnJjbWZfZGJnKElORk8sICJlbmFibGluZyAzMmtIeiBjbG9ja1xuIik7
Cj4+Pj4+wqDCoCA+ICvCoMKgwqDCoMKgwqDCoCBjbGtfc2V0X3JhdGUoY2xrLCAzMjc2OCk7Cj4+
Pj4+wqDCoCA+ICvCoMKgwqAgfSBlbHNlIHsKPj4+Pj7CoMKgID7CoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOwo+Pj4+Pgo+Pj4+PiBXaHkgcmV0dXJuIGhlcmU/IElmIHRoZSBjbG9jayBpcyBvcHRp
b25hbCwgYSBsb3Qgb2Ygc3lzdGVtcyB3aWxsIG5vdAo+Pj4+PiBoYXZlIGl0IC0gdGhhdCBzaG91
bGRuJ3QgcHJldmVudCB0aGUgZHJpdmVyIGZyb20gcHJvYmluZy4gQW5kIHlvdSBhcmUKPj4+Pj4g
c3RpbGwgbm90IGhhbmRsaW5nIHRoZSAtRVBST0JFX0RFRkVSIGNhc2Ugd2hpY2ggd2FzIG1lbnRp
b25lZCBvbiB5b3VyCj4+Pj4+IHByZXZpb3VzIHN1Ym1pc3Npb24uCj4+Pj4KPj4+PiBSaWdodC4g
VGhlIGVsc2Ugc3RhdGVtZW50IGFib3ZlIGNvdWxkL3Nob3VsZCBiZToKPj4+Pgo+Pj4+IH0gZWxz
ZSBpZiAoY2xrICYmIFBUUl9FUlIoY2xrKSA9PSAtRVBST0JFX0RFRkVSKSB7Cj4+Pj7CoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihjbGspOwo+Pj4+IH0KPj4+Cj4+PiAuLi4gcGx1
cyBjaGFuZ2UgdGhlIGZ1bmN0aW9uIHByb3RvdHlwZSB0byByZXR1cm4gaW50IGFuZCBwcm9wYWdh
dGUKPj4+IHRoYXQgZXJyb3IgY29kZSB0aHJvdWdoIGJyY21mX2dldF9tb2R1bGVfcGFyYW0gdG8g
YnJjbWZfcGNpZV9wcm9iZSdzCj4+PiByZXR1cm4gdmFsdWUuIEkgZ3Vlc3MgY2hlY2tpbmcgY2xr
IGZvciBOVUxMIGlzIGFsc28gcmVkdW5kYW50IGluIHRoaXMKPj4+IGNhc2U/Cj4+Cj4+T25seSB3
YW50ZWQgdG8gZ2l2ZSB0aGUgc3VnZ2VzdGlvbiB0byBnZXQgc3RhcnRlZC4gUHJvcGFnYXRpbmcg
dGhlCj4+cmV0dXJuIHZhbHVlIHNlZW1lZCBvYnZpb3VzIHRvIG1lLCBidXQgeW91IGFyZSBhYnNv
bHV0ZWx5IHJpZ2h0Lgo+PlBUUl9FUlIoTlVMTCkgd2lsbCBwcm9iYWJseSBiZSBzb21ldGhpbmcg
ZWxzZSB0aGFuIC1FUFJPQkVfREVGRVIgYnV0IGl0Cj4+c2VlbXMgb2RkIHRvIG1lLiBNYXliZSBQ
VFJfRVJSX09SX1pFUk8oY2xrKSBpcyBhIGJldHRlciBvcHRpb24gaGVyZS4KPiAKPiBJbmRlZWQu
IFBlcmhhcHMgc29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcyBvZjoKPiAKPiDCoMKgwqDCoMKgwqAg
Y2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsX2VuYWJsZWQoZGV2LCAibHBvIik7Cj4gwqDCoMKg
wqDCoMKgIGlmICghSVNfRVJSX09SX05VTEwoY2xrKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJjbWZfZGJnKElORk8sICJlbmFibGluZyAzMmtIeiBjbG9ja1xuIik7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY2xrX3NldF9yYXRlKGNsaywgMzI3Njgp
Owo+IMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIFBUUl9FUlJfT1JfWkVSTyhjbGspOwo+IMKgwqDCoMKgwqDCoCB9Cj4gCj4gLi4uIHdo
aWNoIHNob3VsZCB0aGVuIGdvIGF0IHRoZSB2ZXJ5IGVuZCBvZiBicmNtZl9vZl9wcm9iZS4gQW5k
IGFsbCBvZgoKQnV0IGJlZm9yZSBlbmQgb2YgYnJjbWZfb2ZfcHJvYmUgaXMgdG8gc2V0IGludGVy
cnVwdCBjb25maWd1cmF0aW9uIHdoaWNoCndpZmkgY2hpcCBjb25uZWN0IHZpYSBzZGlvLiBMaWtl
IHRoaXM6CmBgYAoJaWYgKGJ1c190eXBlICE9IEJSQ01GX0JVU1RZUEVfU0RJTykKCQlyZXR1cm47
CgoJaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAiYnJjbSxkcml2ZS1zdHJlbmd0aCIsICZ2
YWwpID09IDApCgkJc2Rpby0+ZHJpdmVfc3RyZW5ndGggPSB2YWw7CgoJLyogbWFrZSBzdXJlIHRo
ZXJlIGFyZSBpbnRlcnJ1cHRzIGRlZmluZWQgaW4gdGhlIG5vZGUgKi8KCWlmICghb2ZfcHJvcGVy
dHlfcHJlc2VudChucCwgImludGVycnVwdHMiKSkKCQlyZXR1cm47CgoJaXJxID0gaXJxX29mX3Bh
cnNlX2FuZF9tYXAobnAsIDApOwoJaWYgKCFpcnEpIHsKCQlicmNtZl9lcnIoImludGVycnVwdCBj
b3VsZCBub3QgYmUgbWFwcGVkXG4iKTsKCQlyZXR1cm47Cgl9CglpcnFmID0gaXJxZF9nZXRfdHJp
Z2dlcl90eXBlKGlycV9nZXRfaXJxX2RhdGEoaXJxKSk7CgoJc2Rpby0+b29iX2lycV9zdXBwb3J0
ZWQgPSB0cnVlOwoJc2Rpby0+b29iX2lycV9uciA9IGlycTsKCXNkaW8tPm9vYl9pcnFfZmxhZ3Mg
PSBpcnFmOwpgYGAKU28gSSB0aGluayB0aGUgaW50ZXJydXB0IHNob3VsZCBiZSBzZXQgaW4gdGhl
IGlmIHN0YXRlbWVudCB3aGlsZQpidXNfdHlwZT09QlJDTUZfQlVTVFlQRV9TRElPLCBhbmQgYWRk
IGVsc2Ugc3RhdGVtZW50CnRvIGVuYWJsZSBjbG9jayhvciBzaW1wbHkgcHV0IGl0IGF0IHRoZSBl
bmQgYXMgQWxleGV5IHNhaWQpLiBBbmQKY2FuIGFsc28gdXNlIGVsc2UtaWYgc3RhdGVtZW50IHRv
IGRlYWwgd2l0aApidXNfdHlwZSA9PSBCUkNNRl9CVVNUWVBFX1VTQiBvciBQQ0lFIGluIHRoZSBm
dXR1cmUuCgo+IHRoZSBleGlzdGluZyB2b2lkIHJldHVybnMgc2hvdWxkIGdldCBhcHByb3ByaWF0
ZSBlcnJubydzLiBBbmQgdGhlCj4gZnVuY3Rpb25zIHByb3RvdHlwZXMgc2hvdWxkIGJlIHVwZGF0
ZWQgYWxvbmcgdGhlIGNhbGwgY2hhaW4uIEFuZCB0aGVuCj4gaXQgd291bGQgc3RpbGwgb25seSB3
b3JrIGFmdGVyIHB3cnNlcSBpcyBhZGRlZCB0byBlbnN1cmUgdGhhdCBwb3dlcgo+IGFuZCB3YWtl
IHNpZ25hbHMgYXJlIGFwcGxpZWQgY29ycmVjdGx5IGFsb25nIHdpdGggdGhpcyBjbG9jaywgYXMK
PiBTZWJhc3RpYW4gcG9pbnRlZCBvdXQgaW4gdGhlIG90aGVyIHRocmVhZCA6KQo+IAo+IFdoaWNo
IHJlYWxseSBwcm9tcHRzIGEgcXVlc3Rpb246IHNob3VsZCB0aGlzIGNsb2NrIGJlIGFkZGVkIHRv
IHRoZQo+IFBDSWUgZHJpdmVyIGFuZCB0aGUgcmVzcGVjdGl2ZSBEVCBiaW5kaW5nIGluIHRoZSBm
aXJzdCBwbGFjZSwgb3IKPiBzaG91bGQgaXQgaW5zdGVhZCBiZSBjbGFpbWVkIGJ5IHB3cnNlcSwg
bGVhdmluZyBicmNtZm1hYyBhbG9uZT8KCi0tLQpCZXN0IFJlZ2FyZHMKSmFjb2Jl

