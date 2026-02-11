Return-Path: <linux-wireless+bounces-31719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBWnLlY6jGlZjgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:14:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D81221C6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09533069759
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1435028E;
	Wed, 11 Feb 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tcoL3zYG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="N6alQJq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376C35028C;
	Wed, 11 Feb 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797609; cv=fail; b=qb8kvzcait3e1O8elax3s6q9SIItxS0kDPry8GGkyHNnrhGQ93Rb02D8O+dKtJjmYMz7v2JcN7Hwe9OsNQAj7KpdN3lKpyYDI8o3iBXoGIoVbiCvJ8Llyf9PRsc7N83fzAxinbhNMB7muduR+Q0TUayvj+CDoHeAk1P+4inrvM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797609; c=relaxed/simple;
	bh=iTYuGpBMG+WXplvoGXVCDS47LjLPqHnmyrvV0aSQNa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqnTzzpVSbRmwcV8KhqwHoBWndej+kpLc3YbyJem3q2gJX1eb94egMcxJb5lwUcrHBWizXs2aJFCKSICwgpBDnQ8OsQUb0r7HhFxf6RdEv5+ncywtVG1mqIGYZx+TKRAyP0qGd5ZJSjwk7a0uoP0V3yFkjjnXVEF2ToCNi8Y1Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tcoL3zYG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=N6alQJq1; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 87b25ad2072111f1b7fc4fdb8733b2bc-20260211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iTYuGpBMG+WXplvoGXVCDS47LjLPqHnmyrvV0aSQNa4=;
	b=tcoL3zYGWxMooEpBnqaGq0DN/P5iUholeKXA1/bpw+OEgQbJMzEJaYJ8uSn7sTKunuvqn1UadoowdaZS47m4SnfJe3QjiW9/HeKny4ezBF0VnggkDguc71xX1Jw8h9JBqhr2ZNtbUm9FsZQN7lWhAKjLrAscnI67yd9vrWmMqR0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:06b536a4-d4b5-4d84-bb5a-e8310c093d3b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:86322d5b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 87b25ad2072111f1b7fc4fdb8733b2bc-20260211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 474769641; Wed, 11 Feb 2026 16:13:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Feb 2026 16:13:20 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Feb 2026 16:13:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyPdKa0NOBof8kKoyXvBkNZndqaBp8Rd4WWixcXUHzbQ93xDtJDJJ71o9Wk1KTHYt1Nvh5YBkbutf6lWQ3ok8rIP9nz2zcMik0FrzYowk3FXKcfp0PRgtQK9ZtOL/5HVqKv6yT1p+R4Pz6qdHGhi3dSCyvX6sfF/1OANSzEbWu/0i5OiYkntUjUtjkM12sUMA4fJKFUJ1K5qsCQRYk47IXhbyDocaUb+wT7ODN7mw6bg5nadN9zi5/g9dWC/Mfth6ltpW5UvyUfkKVAB9wNLcjWgMY0+lbsjz2Ykz9wNP7y8jEDHC+OtbD0xi3jWvHKevdH2S9iuovwZKXSkV3ktPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTYuGpBMG+WXplvoGXVCDS47LjLPqHnmyrvV0aSQNa4=;
 b=jLtW/0LQ163PNIcVc2m4GmX2mK6IArTZgXs2uYKAzLQ3nJd4SuRPAAo53OpSMXd7MGFq6BDI7N45clPTiSDEAeIXYaP9md9f4bgpjkQ5IVxtJk99hDpapwErlVEZdQii45+cV83ezZDrH3Uxo6csMU0EC77BQETBi51bvDX/eyWZ/dSh5oLFLaqnuMhfmbsqPih/WZf27WLBJdOQIa/Y2Nf/hC2LVzczrsbY7w5lr63qf0ZWBGVJKReJU9DOI3YI3yMCgEX+p32QwSMow5TKd7g5Yh78CNgFHRrf1hrKF4Eqp6fHF6lI8ft7YNKCtrTpOcUTaYhT/vVJJuaAb02kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTYuGpBMG+WXplvoGXVCDS47LjLPqHnmyrvV0aSQNa4=;
 b=N6alQJq1GzGeHyWyg95kZ0fKuSUdJ6yzSS+rgnMlGpE2iufiRUJZLtZG/VFP5XPvoH378fr6b565MWWOXY0AwQMQe3vvWKzZb64bt1IUMOGCfVqii7n3g9HII+wHfH/fBgEmBhMpwkjGI7JicxZb69EtqpRmvQt838qLGrEijPs=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEZPR03MB7403.apcprd03.prod.outlook.com (2603:1096:101:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:13:16 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::f429:d36c:b36b:a059%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 08:13:16 +0000
From: Ryder Lee <Ryder.Lee@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Topic: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Thread-Index: AQHcmrhfdLixNmzm402cr6hZjqmOB7V9Cq4AgAAcbIA=
Date: Wed, 11 Feb 2026 08:13:16 +0000
Message-ID: <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
	 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
	 <20260211-miniature-chital-of-plenty-1a71df@quoll>
In-Reply-To: <20260211-miniature-chital-of-plenty-1a71df@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEZPR03MB7403:EE_
x-ms-office365-filtering-correlation-id: 5370d623-556d-4955-2c0d-08de694568c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RXhQVitjYVMyWThPaVNLNEJQRWVsSGZhbjVycTR3ci81TUErbW8rR0Njb1pE?=
 =?utf-8?B?K3c5Q3JjVWl2NnhRQXZ2Y3gvSGphZ2FaaFZDbkIxU2lIeHhvblhQdk9OTitL?=
 =?utf-8?B?VlVTUk15OUtKSy9JRkgrTnhCazJISmdTeHA0cVdJa3lZYnMvdTd3MWRkR2x2?=
 =?utf-8?B?NGxhcUF3T01sY21oK1hybUM2cjc1OG5lR21xSjdGVlM0c3ZwbW5wVmIzRXAv?=
 =?utf-8?B?Y09nbkpLSk51cllvLzJheFMvZ0tpV3dET3k4MHVyODJsQkVtVlU1RHQ1R1Aw?=
 =?utf-8?B?bmhlc0M3TlBxRi96bmtHNnkzcFg2ditPdGEwNzlBbFJEQ3hROXU4NXZyRnE4?=
 =?utf-8?B?ZkFlN0x6NFFZMUN1Nzk1dlloaUpNeStwZ2p6MEIzMTVVNXZKaThiYi9KSGlw?=
 =?utf-8?B?RXdwbGRFcS9tMmhRdmNOZHRFT2FRNFNmVzhybkg3M0h2VUZIZk11ZnpYWWhM?=
 =?utf-8?B?SnBnc2Jlemx2TTR4VHh0RFVTaEFGYXVoMEJmR3Y0YXJaUEpaeFV3ZDJ6akhI?=
 =?utf-8?B?a0xWQ2ZjLzNtblZJN0lWaFFlYUtUQlhxTFpXbE9lcVVYN3JoNncvVDVlQk1W?=
 =?utf-8?B?YzhUcG9yQk8wUERhbGtjQUNzY0QzTDB0bldPUGdVYUk3Um1RL2dobTVEbEVZ?=
 =?utf-8?B?Q2JWQ2J0OWdrclpXWmFNMXE2VDlTVEw5RFVha2xWR1UzWDcxaDBnbTl1bVJ3?=
 =?utf-8?B?cjJrcVFQYk41ZkV6bEx6VU1tMzRqWVdic2crUmx2a1FyUTNaQU9xOTRCM2FO?=
 =?utf-8?B?Z1VaZDNralR1cExWSmUvRGMzajlDb0NPWFFmZEwvQStZSUhQc2lyMG5hTllP?=
 =?utf-8?B?MFB4WUNkcjBOYXhrZVgrdUNiQWJGcnRpV2ZFVkdKSjhzNnVFZHR5NmZ0dW55?=
 =?utf-8?B?Uk9LeDZTQVBvd2dyOG9aRUY1YjA5aTNENWFwSUwxME9CemM1KzdEd3dEejJj?=
 =?utf-8?B?MVdjZ1ZzcEFnbEMwN3JwemdDeitEdEJlYTlpN0ZKNGdaaWRXYnNxQXUxVXdK?=
 =?utf-8?B?L0ladzRtNXB3RUsyeGFodWZodzh1VGh6Y0lqbEFSSGJhWldEMG1tTDNvUWhZ?=
 =?utf-8?B?RHRTRFoxQ1M5ZFpJMjlrWlBYeEoxSXRrWnJjNGNKM1pRZXBHenpsMmJKajZ4?=
 =?utf-8?B?cTgwUHJqakR6dlJJMXNIM1AvNDRhTllwTzJ0ZUl0VnIydzNXSHc4ZUZYNlZw?=
 =?utf-8?B?aHFTNmNTRGtQTWJPV1ZzQno0RE5hVFpsZUVYZ2YrT05sRk05K2NBUjBLMm5L?=
 =?utf-8?B?SjBhY0JpcUNEcU9QVFhDZmNyZGpIcUxQdXd1UkRNY2dCbW5oY0lRRnpwdkF6?=
 =?utf-8?B?U09GZlFpM3hVak5NNERsUjRFSXpoTkcxTjVxd1R5OVZWMmN0dmFmUlo4cEFz?=
 =?utf-8?B?VTdRWFpQUmd6QzdrYTY4ZjQ3Ky9kTU93YXVRdlhWTmJ2bGhoVCtud3gySmpu?=
 =?utf-8?B?UlcrRUF6R2VxZkdjb3AyWHFyck1hMUk3TVNiTisxNGlBRzRPUW5hamV4SjdC?=
 =?utf-8?B?TEVkNVlsZjZJVzk4eU1LN1RmQTNoaUdtYlI0MTE4RzF3bnlOWkFlaFVraXRM?=
 =?utf-8?B?Y24yUWNveGk2bkRrU0tkc0dHMXJjVm0vdDJDVTZycjRDQWpqcjRObVR2S0h1?=
 =?utf-8?B?UjFhbEtPUkVSUTlXWG14b3pydVQ2Y2U5T3Y1Wk80N05oWkJVWXNHd0pqRlI1?=
 =?utf-8?B?Z3RKL1NXWW1kVXBRQzJSK1czamwwa1dKSVJKUmU4RWNQT2FqRTNlMWI4eWEw?=
 =?utf-8?B?WTd6MGh5dkJOeXpSTGtvZkkyVlFWY0o5USthZzFQTkh4OTRydUxYNk5GcTlq?=
 =?utf-8?B?aW42T21ReTlnKzNOaWRSUFdZQkpxbTVkcFZBb0huTGp3OFB1bEZHeWNEWGw0?=
 =?utf-8?B?a2ZHN2x5TTIydGxLOFFKM1JnVU9uQ3Y2WDVrakR6QjJBU3ZKd0NvZjZ2U0NO?=
 =?utf-8?B?THdOMlA4L0RHc1hIL2M3SWErMkk1aFVsWE5HblZBSEEvK05hSXVTRnNpcFls?=
 =?utf-8?B?ZjBPS1Z1b1hpMU9DNTNQTGpNc3lrYVhNZFQ0MmZKRHhSeDJsSzhZYzVscFQy?=
 =?utf-8?B?MG95RnhTOUNjMUlFRkMzWk5MWkgwclRuZ0JZTHVWSUNCYkhpS3ZZeVh1Sis1?=
 =?utf-8?B?diswaFBaUU9lOVFQQWxteU0xak5CeFZGcy9uaTJsWERwU29DS29qbWtMbmVK?=
 =?utf-8?Q?+54A3jatWj5qiPwX4wkioQI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGNoYmdJajhJYUxwdmZzYUxXNU05dFB1ZjdlQ1J4TEoyOFIxZjMvZzVHTjhZ?=
 =?utf-8?B?R2FYdHJKU0krb1M1STJUU3R3UERIWGhJSWRmSVR2bVREalh3WGhvTVV3aXVQ?=
 =?utf-8?B?V1pLenluSmV2R01qek1RdVJsQVN4Q0JqRE5uRDk4THFUeklGTG11K1R4RzI5?=
 =?utf-8?B?TTAveUNoSDFrN2pLeXNBMjB0dWpwcmhSV0V2UEhDSGVpLzMrWStHM2dlRitR?=
 =?utf-8?B?UXUyN0prRURJV3JGZW5WVTNXbTRROW9uWi9rdHNYclFFSWF0NERDWHNYTnBG?=
 =?utf-8?B?RFlJNnpWRndiMUxPcFZMa1M2NEQ1azl1WDBkNGFaYnI1MmxqRmtham53WkFs?=
 =?utf-8?B?cEwvdU1SNnQ1eEVMeGZpR2doK0FtcC93SXV6WGdwUEVZa3JLRDVKdVBYbDNs?=
 =?utf-8?B?U3ZKclE0U2dHaGJZVWxsVFFqYlEzNm5IWXNrYTQ4QndRYlF6MmZBeUlCaDdq?=
 =?utf-8?B?ck44bk5xcW9UZDdtT3FQaVZjT0thNlk4WkpldXpNc0dkeWkrM1FEVTRUaTZU?=
 =?utf-8?B?OXlGTDgzeEpkVVF1Q1ZjZVRQQ2htV2kvdHBMSnVsSFkwVHI2dFdDc2F2RkhD?=
 =?utf-8?B?VWZaeHRzS0tJMkkyWUtTTWJXVFh5Y3VwaStkL245bjBmdWdFWFZ3bVExNlQ4?=
 =?utf-8?B?eTJvdnJOLzdXenpqQXAxTTNnb1ZCclJCRE1mb1RXeHNoZTkxdTVaMXRHZEc0?=
 =?utf-8?B?ZzdHSmVxcGJVbDhZaGZwd05TOXhKeG9jdlRVbktCUGtrcWZ0UStEc1FYOVcy?=
 =?utf-8?B?WFRpbUVZM1VuZGl5azVjV295c0F5UjBQbWFNYmFGMU9MY0owcDZmbUN2dUxO?=
 =?utf-8?B?VXFIUXBHeXVPRTkxdXl4c2pyNXFNS2RkY2tWdGRZNTB6blF6NjFJUFA0d2E2?=
 =?utf-8?B?bGpldHJkQlhxeTIyODNNbkEwNWRJTVZvZDZKcXIxM21pT3ZncFNWWXlkSlRp?=
 =?utf-8?B?b05FbTFpM3Q1bk5yQmRENVlxZHBpWWFZUkZEeGVOaDRHZkRRQXY5cEczUTJi?=
 =?utf-8?B?aEN1amxkTHhLeXNHMGNFV3VDYm5adlVrRXRjWnVXZld0MDZmaS85aGtKVEVD?=
 =?utf-8?B?T0xVcWxsbk5BQ2hQd3NKdUlRZlRNdlRPRG5WQmlNc2VJeGhEbEE2a3U2Wnhi?=
 =?utf-8?B?ZlcrSTF3b1NZTEEydTNodDR0NmdsRDNhNS81blAxV3hPVGlKR1BJSVVPYUVt?=
 =?utf-8?B?ZFhTMTRqT244YjNhUWJLZGJJVzFybTl4Qm5VRlhpVTY2dVl6V2ZKN1V4YVJB?=
 =?utf-8?B?VWhicGxLbWtuc2l0Wkk5LzRubjNpekFmS3VDQzdpbU9iTGttOEdScnlFSjg1?=
 =?utf-8?B?VS96VzJKV0xkdEpMRktDKzVJeGc5RFplZkRFRm9wVDY3QTduQXZDaGtPVDYw?=
 =?utf-8?B?NEFQSnF4WTEraVQ2d3FWRmhWUWthbkVCS05GeU1uaGdOcTRNbDU1VkliN2R6?=
 =?utf-8?B?ck93ODR2ckkrenQyYXY3NnRidjA2M0t5UXViUlNYV2dMakQwMWtxNExBbS9R?=
 =?utf-8?B?V28xbWwxYmlLWThzazM1T05CZ2hiRTVuQzVCQlp5VzAvdTVHb3NLaWVnQ012?=
 =?utf-8?B?NzMvWVYwcVhPbDRKY3BVZE96REVUM0VaRjlhRVhqeEFvM24wNFNXNjY1S0JY?=
 =?utf-8?B?K0I0YkVzK1lOekpDWnJ2bkpHeHEzbFlmRXlOSEh2WkhKcXBTZnRFZllyK3Q5?=
 =?utf-8?B?UGpLdGtwcXB2RmtzVFhUVzhxRVYzenVxN25LM3k4UVFoMitOT1lLNThhOHhX?=
 =?utf-8?B?VDJ2NkNKNHk3a3pxekZ2ZWx4c3hveVNxR0hIdVNxRW50S0pnTit2MWZPUEJr?=
 =?utf-8?B?YVljZi8xeGdiWUNDZk1yR0J0V1NYTVM3QllWOXE4MlVmTWZkR1ozSUQ2Z0Ft?=
 =?utf-8?B?RXJLR09WVzc5TDZEK2prTnA0K3AwWXYwYXpYMzlsSnZjcTRab2FpNFNJRTYw?=
 =?utf-8?B?YWxEL3Fia3hqSHF1TW12VTdmd1NuMnk1MXNOMEU4S3orNW9iSTFiV0w0M3ZZ?=
 =?utf-8?B?WjducmhyQlpCY1pvU3VMVWZPOVI0cE40WG90LzhXQ3lwSFpNVWpXRVhBZmVF?=
 =?utf-8?B?T0tYOE54VnQ3ODlYNXhnc1BoQlc5bExxVHFEMDZrMGJ0TzdCV3c4QjlsSVVV?=
 =?utf-8?B?QjhRcmNJTWFYZnVKQThjVFFSVWJSM0ZwQmJ5eDVJZ3ZYemU4RE53TlNGZ1A3?=
 =?utf-8?B?cHZOcDN2VHdHT2VBWHNKNkJEazQvV0x6QUozaWVpMUtHRW5WR1ozSVVwVlBV?=
 =?utf-8?B?M3RvcE95SmdHM25QT04zdW1rQzgzdlRDSnVoRG9UdFBTR2VLdkRsVFZYamZ1?=
 =?utf-8?B?QzN3aStFSCtCVy9rQWtpU09xOUtkM3lWUWFhZUNOcC93aDUyckdETTZKTzZU?=
 =?utf-8?Q?ualgNVHEHlUSzDIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50E486E2EE81094EB484BECE23463E34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5370d623-556d-4955-2c0d-08de694568c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 08:13:16.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/BA2tKBdCEyKRAlMVhaZdDkJztkhoXaHUgQyTWgKkHECGSWGqLiP9PVK063HHi0OOFSteKqYP6fpDUFRVP2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7403
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31719-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ryder.Lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0F9D81221C6
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDA3OjMxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBUdWUsIEZlYiAxMCwgMjAyNiBhdCAxMDowODo1NkFNIC0wODAwLCBSeWRlciBM
ZWUgd3JvdGU6DQo+ID4gQ2xhcmlmeSB0aGUgZm9ybWF0IG9mIHBhdGggYmFja29mZiBsaW1pdCBw
cm9wZXJ0aWVzIGluIG10NzYNCj4gPiBiaW5kaW5nLg0KPiA+IEFkZCBleHBsaWNpdCBkb2N1bWVu
dGF0aW9uIGZvciBjb25uYWMyIChtdDc5MTUsIG10Nzk4MSwgbXQ3OTg2KSBhbmQNCj4gPiBjb25u
YWMzIChtdDc5OTAsIG10Nzk5MiwgbXQ3OTk2Li4uKSBkZXZpY2VzLCBpbmNsdWRpbmcgdGhlDQo+
ID4gZGlmZmVyZW5jZQ0KPiA+IGluIGJlYW1mb3JtaW5nIGFuZCBub24tYmVhbWZvcm1pbmcgZW50
cmllcy4NCj4gDQo+IEkgZG8gbm90IHNlZSBhbnkgcmVmb3JtYXR0aW5nIGhhcHBlbmluZy4NCj4g
DQpNYXliZSBJIHNob3VsZCB1c2UgInJlcGhyYXNlIiBoZXJlLg0KDQo+ID4gDQo+ID4gQWxzbyBy
ZWZvcm1hdCB0aGUgZGVzY3JpcHRpb24gdG8gbWFrZSBpcyBtb3JlIHByZWNpc2UuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogQWxsZW4gWWUgPGFsbGVuLnllQG1lZGlhdGVrLmNvbT4NCj4gPiBD
by1kZXZlbG9wZWQtYnk6IEFsbGVuIFllIDxhbGxlbi55ZUBtZWRpYXRlay5jb20+DQo+IA0KPiBJ
bmNvcnJlY3QgU29CIGNoYWluLiBSZWFkIHN1Ym1pdHRpbmcgcGF0Y2hlcy4NCj4gDQoNCldpbGwg
Zml4Lg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+IMKgLi4uL2JpbmRpbmdzL25ldC93aXJlbGVzcy9tZWRpYXRlayxt
dDc2LnlhbWzCoCB8IDIwDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYu
eWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVz
cy9tZWRpYXRlayxtdDc2LnlhbWwNCj4gPiBpbmRleCBhZTZiOTdjZGMuLjQxNTZlMWM5NyAxMDA2
NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWssbXQ3Ni55YW1sDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21lZGlhdGVrLG10NzYueWFtbA0KPiA+
IEBAIC0yNTIsNiArMjUyLDE2IEBAIHByb3BlcnRpZXM6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9sbG93ZWQgYnkgMTAgcG93ZXIgbGltaXQgdmFs
dWVzLiBUaGUgb3JkZXINCj4gPiBvZiB0aGUNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFubmVsIHJlc291cmNlIHVuaXQgc2V0dGluZ3MgaXMgUlUy
NiwNCj4gPiBSVTUyLCBSVTEwNiwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBSVTI0Mi9TVTIwLCBSVTQ4NC9TVTQwLCBSVTk5Ni9TVTgwIGFuZA0KPiA+
IFJVMng5OTYvU1UxNjAuDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAtIEZvciBjb25uYWMyDQo+IA0KPiBUaGVyZSBpcyBubyBzdWNoIHRlcm0gYXMgY29u
bmFjMiBpbiB0aGlzIGJpbmRpbmcgYXQgYWxsLg0KPiANCj4gV2hhdCBpcyB0aGUgcG9pbnQgb2Yg
YWRkaW5nIG5ldyB0ZXJtcz8NCg0KSSBkaWRu4oCZdCB0aGluayBpdCB3YXMgbmVlZGVkIGF0IGZp
cnN0LCBidXQgb3RoZXIgcmV2aWV3ZXJzIHN1Z2dlc3RlZA0KYWRkaW5nIGl0Lg0KDQpUaGUgY29t
bWl0IG1lc3NhZ2UgdGFsa3MgYWJvdXQgbXQ3OTE1LCBtdDc5OTAsIG10Nzk5MiwgYW5kIG10Nzk5
NiwNCndoaWNoIGFyZSBhbGwgUENJZSBXaUZpIGRldmljZXMsIHNvIHRoZWlyIG5hbWVzIGFyZW7i
gJl0IGluY2x1ZGVkIGluIHRoZQ0KcGxhdGZvcm0gYmluZGluZy4gT25seSBXaUZpIGludGVncmF0
ZWQgU29DcyBsaWtlIG10Nzk4MSBhbmQgbXQ3OTg2IGFyZQ0KbGlzdGVkLg0KDQpUaGVzZSBkZXNj
cmlwdGlvbnMgYXJlIG1lYW50IHRvIGV4cGxhaW4gaG93IGEgcGxhdGZvcm0gY29uZmlndXJlcyBU
WA0KcG93ZXIgZm9yIHRoZSBjb25uZWN0ZWQgV2lGaSBkZXZpY2VzLCB3aGV0aGVyIGl04oCZcyBh
IFBDSWUgTklDIChsaWtlDQpDb25uYWMzIGRldmljZXMgSSBsaXN0ZWQpIG9yIGFuIGludGVncmF0
ZWQgU29DIGl0c2VsZiAobGlrZQ0KbXQ3OTgxL210Nzk4NikuDQoNCldoYXQgZG8geW91IHN1Z2dl
c3Q/IEnigJltIGFjdHVhbGx5IG9rYXkgd2l0aCBrZWVwaW5nIGV2ZXJ5dGhpbmcgYXMgaXMuDQoN
CllvdSBjYW4gYWxzbyBsb29rIGF0IHRoZSB2MiBkaXNjdXNzaW9uLg0KW3YyXSB3aWZpOiBtdDc2
OiBmaXggYmFja29mZiBmaWVsZHMgYW5kIG1heF9wb3dlciBjYWxjdWxhdGlvbg0KaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzU0NjI3Mjgy
Y2ZiOGU1YTg5ZmU3NTNkYTY2NTUyYzBhMDg0ZjYzODcuMTc2OTU1Nzg2My5naXQucnlkZXIubGVl
QG1lZGlhdGVrLmNvbS8NCg0KPiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAtIEJlYW1mb3JtaW5nIGVudHJpZXMgZm9yIEJXMjB+QlcxNjAgYW5k
DQo+ID4gT0ZETSBkbyBub3QNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW5jbHVkZSAxVDFzcy4NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIFdoZW4gMVQxc3MgaXMgbm90IHVzZWQsIGl0
IHNob3VsZCBiZQ0KPiA+IGZpbGxlZCB3aXRoIDAuDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIEZvciBjb25uYWMzDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBCZWFtZm9ybWluZyBlbnRyaWVzIGZv
ciBCVzIwfkJXMTYwIGFuZA0KPiA+IFJVIGluY2x1ZGUNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMVQxc3MsIGJ1dCBPRkRNIGRvZXMgbm90
IGluY2x1ZGUgMVQxc3MuDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLSAxVDFzcyBpcyB0YWtlbiBpbnRvIGFjY291bnQsIHNvIG5vIG5lZWQNCj4g
PiB0byBmaWxsIHdpdGggMC4NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE5vbi1iZWFtZm9ybWluZyBhbmQgUlUgZW50cmllcyBmb3IgYm90aA0KPiA+IGNv
bm5hYzIgYW5kDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb25uYWMzIGluY2x1ZGUgMVQxc3MuDQo+IA0KPiBXaHkgdGhpcyBjYW5ub3QgYmUgYSBzY2hl
bWE/DQo+IA0KPiANCldlbGwsIGFjdHVhbGx5LCBpdCdzIGFscmVhZHkgYSBzY2hlbWEuIFRoaXMg
aXMganVzdCBhbiBleHBhbmRlZA0KZXhwbGFuYXRpb24gb2YgdGhlIGRpZmZlcmVuY2VzIGluIGhh
bmRsaW5nIGJldHdlZW4gZGlmZmVyZW50DQpkZXZpY2VzL2dlbmVyYXRpb25zLg0KDQpCdXQgYWN0
dWFsbHksIHRoZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZXNlIGdlbmVyYXRpb25zIGNhbiBiZSBm
dWxseQ0KaGFuZGxlZCBpbiB0aGUgZHJpdmVyICh0aGF0J3MgZXhhY3RseSB3aGF0IG15IFsxLzJd
IGlzIGRvaW5nKSwgc28NCndoZXRoZXIgdG8gdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIGlzIHJl
YWxseSBqdXN0IGEgbWF0dGVyIG9mIHBlcnNvbmFsDQpwcmVmZXJlbmNlLg0KDQpJJ20gYWxzbyBu
b3Qgc3VyZSBob3cgdG8gZGVzY3JpYmUgYSBDb25uYWMzIFBDSWUgZGV2aWNlIChub24tU29DIHR5
cGUpDQp0aGF0IGlzbid0IG1lbnRpb25lZCBpbiB0aGUgZG9jdW1lbnRhdGlvbi4NCg0KSWYgd2Ug
bmVlZCB0byBkcm9wIHRoZSBEVFMgY2hhbmdlLCBJ4oCZbSBva2F5IHdpdGggdGhhdCBhbmQgd2ls
bCBsZWF2ZSBpdA0KdXAgdG8gdGhlIHJldmlld2Vycy4gT3IsIHdlIGNhbiBqdXN0IGFwcGx5IFsx
LzJdIG9uIGl0cyBvd24sIHdoaWNoDQp3b27igJl0IGFmZmVjdCB0aGUgZG9jdW1lbnRhdGlvbuKA
mXMgZGVzY3JpcHRpb24gb3IgdXNhZ2UuDQoNClJ5ZGVyDQoNCg==

