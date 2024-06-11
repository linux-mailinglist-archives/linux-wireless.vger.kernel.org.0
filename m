Return-Path: <linux-wireless+bounces-8793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B42903CD4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1901C22FBD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9003417CA10;
	Tue, 11 Jun 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="LgPxghef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BA17C9F6
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111644; cv=none; b=IElJZdqyN6Vf2y3HwLRRu2p4c5tyhj1PKhlKvH0VB/OpDSV0IAdY4leQqwNDpcR1Dr5g/wkwS17INdrP7ykl9ZiKMDTUot33bj3gTFAN3R8SrDKR+4ckCqGFIrssFAdpclQLgl6gSa6RxIKnlFpvlqpc4/HwREPFjC+IQfPOUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111644; c=relaxed/simple;
	bh=kxr1a998CjCOi4NcPYYegUL9VRDdF2VGRngdd7VQjI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oomZ3UuOeURCdrgHpcduM3j1QSYhvzQEn38Jz8ymDiSH9dNgiYo3NxhUKR+SQgdU6E+rr0S6zXfHmqks0pTCpq+AFVQBLzNDUidsSLcA9aDgl6Y7zhLeZ9jHQVnzRccRWO6+vCAu19kuy9h/gaZp/Npf5Vkx+dZov5WQHfWKFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=LgPxghef; arc=none smtp.client-ip=194.104.111.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1718111641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxr1a998CjCOi4NcPYYegUL9VRDdF2VGRngdd7VQjI0=;
	b=LgPxghefxSMJ1/OMTn53LzdrAC+2sbUB5H8r7cjKCO4TiV9vXKI+YjxUXB1USH/pfgsnzg
	FN3VFrwgnOGsJuq0/r+IeWtbDTOAdaX2pAU9ba5yudgQJCch2KQyr8RjQKlh3aeiP/D9yE
	xWmMBAzuKhHRixdzJ9lMqkfRdL3bLiU=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-c5Hig38EM-OJxVqU3y_m3w-1; Tue, 11 Jun 2024 15:12:33 +0200
X-MC-Unique: c5Hig38EM-OJxVqU3y_m3w-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR1P278MB1191.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 13:12:26 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80e5:de46:5ac0:59b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80e5:de46:5ac0:59b%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:12:26 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "yu-hao.lin@nxp.com" <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Thread-Topic: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Thread-Index: AQHavAEBGsvdkq+K0ESlhSz5omdtMg==
Date: Tue, 11 Jun 2024 13:12:26 +0000
Message-ID: <bd519d27dbe5c239d621072f96f67e371e552a74.camel@toradex.com>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
	 <171767674666.2401308.2539321240473169281.kvalo@kernel.org>
	 <Zmaq-4whltVgrzCz@pengutronix.de>
In-Reply-To: <Zmaq-4whltVgrzCz@pengutronix.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR1P278MB1191:EE_
x-ms-office365-filtering-correlation-id: 9d59e4e5-bfb5-4d26-fd40-08dc8a1823b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009
x-microsoft-antispam-message-info: =?utf-8?B?Unc4c3czYklPaTdQTkJVMjg2cmNmZ3FVYmtXTXNLR2VZV1JhZUtsaGlrRU05?=
 =?utf-8?B?dmRUZEJURkFZNE9oa3cvdjdBNDZwbU5YWXJjUFU4VFo5c2ZZTENDVkF6ZS9o?=
 =?utf-8?B?bCtJbHcyRWVJR3BZSHlreWVnSUxRSlN6ZC9PdHBaek9ZdTZteDlPRmJSbytP?=
 =?utf-8?B?VUNLeGQ2Tmxld1M2aXZSRkFkK0JaVDJrbzI2Tm42eDJNN3FkVUpadTdiV3ht?=
 =?utf-8?B?YnBIdkdBekF3bDlQOFFzbERRNktvcnlnTnJaQmJaRmpXOWlPbTFFUFAyYkRD?=
 =?utf-8?B?cWFuZjA3eGYveDFnNW5PTjFEZ2dyNVM3QlpaNDRJK3NzZUk3SWdiVmlVOWxF?=
 =?utf-8?B?WmpVNDd4WkN6dGVSRjRtaWR6Q3JVZkF2TUNlMEp5cFlWSFM0YVBrZW5XU29y?=
 =?utf-8?B?cEtBOFEvakoya3YvY3hHRGgxMUlab0xZOTVTNDZMOUNEOUt4a203OUVyWHpH?=
 =?utf-8?B?aHJWVUVFSG1iR2NWdG9lY2w2REVIYTNzSlp6Slo1RVNhV0tVSVhnaEs1ak9o?=
 =?utf-8?B?K3ZpenRlQU1FL2FveFA2NHZzNFdnU0UvMkJKN0FNVnlsSTNjNUxXZ05MY2dI?=
 =?utf-8?B?L2RhK2x1M1BRTko2dXA4TXhWTkVLVWVYTk1sYTc0bEVOUGlhU2tNOW5SeGs3?=
 =?utf-8?B?WitMWFJ5RVZOYVVsM3llTXNraktFUGFFcStjWE5UNjVZM2xRckZHVG4yeFEz?=
 =?utf-8?B?LzRHVGpROGxtb3JYNDdhUnBHZWlSWk9mczhCaE9JemFqQ3dXMzFkaTFXaWJx?=
 =?utf-8?B?YjB3ZUxjbm1vb2ptdFczbWhYdk9sNmJuZCtEUW5HdnBESkpjckVnN3dYZFBq?=
 =?utf-8?B?MW1zMTMvUFIyUXowdEkxUFZ5aXVGdUJoTnpCTE9FeDhlZGR0REZLdTAxR0Ix?=
 =?utf-8?B?QjRJMkJDRmNNMndnbERvM1hvLy9zMzkrVWlkbzJ0Yk4wcWlUK2gyWEo5R3Fm?=
 =?utf-8?B?MmE2MUdCbGF6TVRVK05Sd1ZuWVhVVVVFalNaNjRDa2tlRi9Kd2VsOG9iT2V3?=
 =?utf-8?B?UnF5YWxMaDlYdTlReCtnWEtpVHFTSmdSUFNQSjZqU2t3aWlzbUk3RUExNkJG?=
 =?utf-8?B?SFl5VWo5d1RIdkVXNzdjb2k5M2NsdGxCVHFIWENVZEh5bFhJaTJiSThUOFV5?=
 =?utf-8?B?L05vQ3pEMU5tYytpU3Bma2FOdmJZUmJSb2w1ckZ6R2puRHZsU1E4TjI1L2lt?=
 =?utf-8?B?Skx3MHBUMS9aWlZ0dnlxRHJOdGIxMnY5eFpYS05BNElBeHFxMzhJeThmRzVR?=
 =?utf-8?B?MWZtdXMxOE1NNjZ4SDhabTA2MEFkbFRremxma1J4aFd6c1EzTFFkVHk2UTc4?=
 =?utf-8?B?dmxrRHJQV05pV0dUT1ZTcVVFM3ZLaEN5eGdrbGZaMEhPSTIvUmZqN2F2Q1Za?=
 =?utf-8?B?aTFVKytjU0hzZkg4cEEybm1vUkVzRlp5NW1nMkd6WXRtU1BSamRucVppcmpN?=
 =?utf-8?B?QXQzcjg4R2Q2MG5jV0wvZTMzNS9iUlVkZzRubXZ2dFR3UGRrZUxQS2NVTmRz?=
 =?utf-8?B?TmtKOEtSSzRMd0JlYnhxUDY4N0R5ZnhwOGN6U0d5YTJBODNvVTJOL3JtZGkw?=
 =?utf-8?B?MjZZTmh1S2pNK0ErYnZ5MDh0YnBWV0pxenE1Rk1HUW9vYUhKU2dXS2loa0Rq?=
 =?utf-8?B?SDZRN3RlVkZKRXJCeHBMUGl3emMvUmhsK0NCNmIxVzFhanNxQUREa0tKcWYw?=
 =?utf-8?B?NUNOU1BsVmFvZDQ0dWtJeWo5QUlUSWRJTytwWTkwUTVROThWK1VTdnlRODZ3?=
 =?utf-8?B?S2JFWUNSOWx1WkhWVnIyL1Y4ZHB3eU9QM2FHNGdPZE50MjB3blpaYURXTkNT?=
 =?utf-8?Q?ISD9iK+u2gkrzdwVUWPoAIaXUG90c+j7k3gh0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2tGY2xHbURxb2FTNUNOZExkR1ZEQXBxVFhzSWU3YjVyakVrYmE5aG9WWTND?=
 =?utf-8?B?Q3BDQkNjS1NCcWZ3cTdhVzRMQWZKOC83SkprcjUzU1Q5WktTSjZhUFFHZzMy?=
 =?utf-8?B?YnRqbVFzV1N5M2RZcy9UWjZrME5yNHFoTFF0NEdmQWhTdlVmTnp2cU1xRVUz?=
 =?utf-8?B?TkY3YmhOWUUxZUJaRkVoYndsSTlCTFYzUnlKUXpqRnE4NWRybUZwb09xamxQ?=
 =?utf-8?B?elQvdzcySE5FZEw1eTdhbmptZnBwUmVzR0I5UXdoVEQzQlM2RFFJcm05NFFO?=
 =?utf-8?B?UlN0b01nTTRUSGtPUzlGUDMwYWxXRE4za2xUNjg2NE5XRXYvVzE4MzhvSDdW?=
 =?utf-8?B?RGZSKy9PU01DV3FzNE5rcWRyY3o0K3lXbHViRmlMU21FSHowUUJ4WElNcEN5?=
 =?utf-8?B?QW9DZHJ6YytkMy81UEdDaTV3a1c3d0hpU2M5WlpWOWM3RGFud3RaTCsrS1Jl?=
 =?utf-8?B?K0d3SlZEVjRxaG9jSUR2eEI5S3EzNkVScDhhTmY3S3ZEWFA1d01LcTFJMm1I?=
 =?utf-8?B?Zk03eVMyT3JxcXA1aVhINlFyMUhzTWduQjFwdUlCREpzQjBjV2pPTW1JcHZU?=
 =?utf-8?B?c0pPSkJRRTNmSU5hZzUrTlVjMEM1azQvSzI3aVhVOThodTFHLytZbVVoTll2?=
 =?utf-8?B?VFl6ZW1JOHRYTXN5YVFaTkZSblkzQTNyMVZJV256c0ZjNVEzY1F0VExZTUFJ?=
 =?utf-8?B?TXJDTElETXQvekx2MG5KcG82dkpVQUF6aUxJTnluRk8yNGJ1YnJ1SnFQamZT?=
 =?utf-8?B?TEF2QWFhZk9Say8wYk5sWmJqQktaYUpqSWZCK1RFaDJQRnhscEFvSGQ0MER3?=
 =?utf-8?B?MlJrSFpQdFRuRW5vbVJ1QTFyelUwdjdEQUI0OENpZzAvcmxHWUVMM1daT0lP?=
 =?utf-8?B?QVVNb0wvMGlJZXhFV1N3MzBJTFV6SU52U2xSSFoyWDlQT0RlanJFOFpDTUVu?=
 =?utf-8?B?TmVkMk5oTVI3bE16NHFDVjlXVVFDdWplOEVqdlhtUklwN2F1TTh1c3pmaDBm?=
 =?utf-8?B?a1VLZ0tCQ3RsRk1FNXcwZzJRbUlSSG9MNjIreE9VYjJZQTBCRkx0a2pUUFJ4?=
 =?utf-8?B?c2xxWE5kUmFhajdmWFRKYUhoMXoxM2V0NXpuZmxkSTFKU0tLdUl0NzVOMEdV?=
 =?utf-8?B?b3BjRWFBYVB5V2p6OU8vOThOSWlKNFBIOE02T3gvNDk2Y0dDeThmTXJ1eGpC?=
 =?utf-8?B?VGVTRnZFaUxEVlFsb3M5THJyekFBNGNEL3ZiNzQ3WDI4NHpNc1JMS0tpUkkx?=
 =?utf-8?B?VXZlcWhTRU5xL3dkU1ZXMlNEa2NaQmhzaFR5NnQ0VW0wcHd0b0ltWjFNWEtp?=
 =?utf-8?B?NG96Rmp1RlpIUmFkN3hjUGVMQ25TYWMwcERCL2RWb3JUZlBRTVVBNHB1aTZu?=
 =?utf-8?B?RmxGdHN5U2Y4T3QvNzFRN1RuVWZZanhuRXYzcUtJTW85bnFoY0ttMUp1Mmhh?=
 =?utf-8?B?YzhYK2dDdkV6cUJPcExTcVdtaGVnOTVCU1BxMTF3Z0x1UHlpaEErelYyK24v?=
 =?utf-8?B?WmJBWjR2aDZBNFBMaGt1c1NlUnMzbjlOSFMzZEZpdUlOZTVMQUhuWURCT0ZY?=
 =?utf-8?B?MDdjS2tUVjRXV2lBbGV2cG5kK0hoVVRiM0Vvd2ZFVmVwbTQ2Z0hISG9ra2Vn?=
 =?utf-8?B?OVZjVys3M1B1MXdVRXNuc3JBTkMyMGY2ZjJnZjVwbnpjU2JvTWVWQXNVTHRC?=
 =?utf-8?B?QktCS3Eyclp6SjdlMkRVMkNEeG9oamxzNTN5NFZLRldFcUVQSTVJbkFUcExj?=
 =?utf-8?B?VXAxV1hFRFlTVGk2cnRhU0hNdUlFdTU2NG51TTFrY29qOG92UzFGSXBoMjRv?=
 =?utf-8?B?ak94dWN6WUx4ZmhEN3oxSlFmT2srOUcwc1JSTTNTdEpiWmV4K3U1Sk8vTk44?=
 =?utf-8?B?SFloMXpGRldETVI5VW1DRW5TK3dlZlJnZDhhK0wwV3lLWElkekpYWU16eHdU?=
 =?utf-8?B?QnZZZU9WUEFYMWtlclUzeVpWbFpxbGxJWThhd2hZRUQwTWhHUzh3K3dxeXRw?=
 =?utf-8?B?eGFQZWxrbTFlUmtMdUVxdVJ5c2k4SVlBY2dmU3ZkakRkVVJYeTZibkh3bXFN?=
 =?utf-8?B?TVhiQitDZC8xTlNoSUNNWHQ4MjNNczczMzBzOE5QQUs5MXpMYjBzbjY1TkRm?=
 =?utf-8?B?cGZmRWdtOFRIREUwc1dWMUxBT2EwL1RPZllvcnp1dVFUMERLcW0zck9sU21E?=
 =?utf-8?B?M3c9PQ==?=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d59e4e5-bfb5-4d26-fd40-08dc8a1823b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:12:26.2593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYPjeqTTGqhVy2g4HGhGddIhP6IN4681PTN/BqXy9II8/kUQ9dplYq1yq23Zm4O/7pPGKDPDpn3TtOg/woO0l+Dp34izM4yMjLkOAH4snLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1191
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <1162B6AA4ED5C14EB3A6227E2AE2CF43@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

SGkgU2FzY2hhDQoNCk9uIE1vbiwgMjAyNC0wNi0xMCBhdCAwOToyNyArMDIwMCwgU2FzY2hhIEhh
dWVyIHdyb3RlOg0KPiBPbiBUaHUsIEp1biAwNiwgMjAyNCBhdCAxMjoyNTo0OFBNICswMDAwLCBL
YWxsZSBWYWxvIHdyb3RlOg0KPiA+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5k
ZT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBUaGUgbWF4aW11bSBudW1iZXIgb2YgQUtNIHN1aXRlcyB3
aWxsIGJlIHNldCB0byB0d28gaWYgbm90IHNwZWNpZmllZCBieQ0KPiA+ID4gdGhlIGRyaXZlci4g
U2V0IGl0IHRvIENGRzgwMjExX01BWF9OVU1fQUtNX1NVSVRFUyB0byBsZXQgdXNlcnNwYWNlDQo+
ID4gPiBzcGVjaWZ5IHVwIHRvIHRlbiBBS00gc3VpdGVzIGluIHRoZSBha21fc3VpdGVzIGFycmF5
Lg0KPiA+ID4gDQo+ID4gPiBXaXRob3V0IG9ubHkgdGhlIGZpcnN0IHR3byBBS00gc3VpdGVzIHdp
bGwgYmUgdXNlZCwgZnVydGhlciBvbmVzIGFyZQ0KPiA+ID4gaWdub3JlZC4NCj4gPiA+IA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0K
PiA+IA0KPiA+IEkgYXNzdW1lIHlvdSB0aGF0IHlvdSBoYXZlIGFsc28gdGVzdGVkIHRoaXMgb24g
YSByZWFsIGRldmljZSwgcmlnaHQ/DQo+IA0KPiBTdXJlLiBJdCB3YXMgdGVzdGVkIHdpdGggYSBN
QVlBLVcxNjEtMDBCIG1vZHVsZSBmcm9tIHUtYmxveCB3aXRoIGEgSVc0MTYNCj4gY2hpcHNldC4N
Cj4gDQo+IEJUVyBJIGhhdmVuJ3QgbWVudGlvbmVkIHRoaXMsIGJ1dCBJdCBmaXhlcyB0aGUgc2Ft
ZSBwcm9ibGVtIGFzIG1lbnRpb25lZCBoZXJlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgta2VybmVsLzIwMjQwNTIzMDgxNDI4LjI4NTIyNzYtMS1zLmhhdWVyQHBlbmd1dHJv
bml4LmRlL1QvDQoNCkFzIHdlIGFyZSBhbHNvIHVzaW5nIHRoZSBJVzQxNiBhbGJlaXQgZnJvbSB0
aGUgTUFZQS1XMTYwLTAwQiBtb2R1bGUgb24gb3VyIFZlcmRpbiBBTTYyLCB3ZSB3ZXJlIHdvbmRl
cmluZyBhYm91dA0KdGhlIGV4YWN0IHVzZSBjYXNlIHRoaXMgcGF0Y2ggaGVscHMgc29sdmluZy4g
Q291bGQgeW91IHJldmVhbCBzb21lIG1vcmUgZGV0YWlscyBhcm91bmQgdGhpcz8gVGhhbmtzIQ0K
DQo+IFNhc2NoYQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=


