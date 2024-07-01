Return-Path: <linux-wireless+bounces-9742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F091D59F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 03:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77701F210F6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 01:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529E8BEC;
	Mon,  1 Jul 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bzbrPKbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F794C69;
	Mon,  1 Jul 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796101; cv=fail; b=qvltPXHSa4cgpziZ+VZHGKTpehdWwZgOJKVftUSHrxJPinDVmbGfDXSweAFLCzvTXGbjrKJPU54F0y8qgrEv0cf9jWVe+fv9dgjCLEN5dZwBAzwdMBRjb1iimt6zYrDquD/IJYwevptpkdsNEZVlD2DeXQitWvxRMnuliYLTpAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796101; c=relaxed/simple;
	bh=tXGMKpaA0KlcqpHXhR/9dTztQEarxC3qLeNQodxQIug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfzlNXyxWpHEPVmXSf/5gkv6FKR+FaNBKcbqAJ/lb1Ey+GXaQJ7lJ2FofZPWTcYDf2znHoqlcQN3q6I3Sce1A5LPjpBjJRv1ziyc9w5CJOQ2x7ZM8PAZwL0IUqTYEuJmY4CKlzBGqP/Eah9bi2gBwkvFA39TUx+P7fJuiYhqREE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bzbrPKbL; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUU1oKbMSLplKaFCn2LSXaQCHptrgpH/M/QwZAUahl+bzpWJPugD9sM/2bo7JvyjPGMa11MR6nTaskn2qO/20EWctynR0eFn3r1Wz2BVXeJWwu0cxdI6vLSnCWtx+uaAV64M9owo2vmAFvgC71N9ZiilOlGWAF1NjkjVxx7IT84y1hOGyM6lGAIBr01WoD4aQu4DpHgjHFyJ4mg6WUnduT5xnGEyNEJpHZa01x+CPPlp4DncGUtOynelDqdHG6QhMSgf/NHpqWIOzM4jD6957e2v8DnmaYWwEYx8cttlH2ryS+t4ZsKKCbW/7gYLeY/w9FI/gGKxfCYvIxYs76viuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXGMKpaA0KlcqpHXhR/9dTztQEarxC3qLeNQodxQIug=;
 b=BpUPHIAJAbYqXWIlQeF7BldAfC7Z+2cVidT2XBLQWBPnAnIziXkWC0seCMcJDyU8trKAoaWsfBuN0Es7ocdy4B/gHN2BG5d4VGYxE1jXUYj0ByveYhxe6b+L03O8fx4nMdVoQFmpc7tSNypOxQ0on0JEaHFaGbqh6vFnd+y65pQhXISQC7pYR+mMZigp26BV1ls6SZROU6KADLGBiOSc/0xWZeJ51BuKkux9c8xPbMA80T/A+f6vn18mLU63SEU2eoGhUG2Jy7CI2Wn6covwzm7QmRrl9JKcHmeDrltBs+Xv/SdKOmi/3nMqxB930Koydnf8Z/f0Mnsgcm2uOm7pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXGMKpaA0KlcqpHXhR/9dTztQEarxC3qLeNQodxQIug=;
 b=bzbrPKbL0TD7gvxY4jCy+8KBRc7Qtwd3S7ICNcLZ8J7Y4qxOyJXznWcJMWNh4bLQbNerDhZ0xUdfSGcAGB0NWpOEouD2ur/t17w3KbpHpz3eeoxHHNEMR6W/DoOkE+OjJVu96cTdZnufeJkczn06qCCyqQ53flUIVyDN8gkS6hM=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8787.eurprd04.prod.outlook.com (2603:10a6:20b:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 01:08:15 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 01:08:15 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support
 iw61x
Thread-Topic: [EXT] Re: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support
 iw61x
Thread-Index: AQHaw6/4ibKK/7wmRkuzLFu+kd7uFLHSh+oAgA6Wp6A=
Date: Mon, 1 Jul 2024 01:08:15 +0000
Message-ID:
 <PA4PR04MB96382725087E8E2B226D8943D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <5f5c42585e168e252a5fa3f43325aaa360f6d27a.camel@sipsolutions.net>
In-Reply-To: <5f5c42585e168e252a5fa3f43325aaa360f6d27a.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB8787:EE_
x-ms-office365-filtering-correlation-id: 609e37d3-5fb4-45d6-b2b2-08dc996a4979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVVSNHQxUjhTTFVyV1ZpNUZqYzZkWnk0UWVrTHhOVkF2cUQ5VHc4VWdYVFIw?=
 =?utf-8?B?bldSL296NmZ3UWNVYW1TUThpT0poaXFGd0VZQUt6MzhXNW84dUx1M0ZYVGpE?=
 =?utf-8?B?ZzJ1S045Sm9ERnZ5UUJKK0xSeXBYQ2hFckJKZGxTWTZON21vSENWTGVTcC9H?=
 =?utf-8?B?a2ZWb25tT1dBUzA3WFpSU3I1a3B1Z29lMTNNQ2N3eldmY3MzcUJNbGM1MFUy?=
 =?utf-8?B?VnpHN3AwWGlvT1FpUFBGRGhTOWdkaDRrTEtJam5EbldNb2UyREZLQmpQQjJZ?=
 =?utf-8?B?MUFHRlNzc2t4KzdkVFVlS1hmK090UjZ4eGc2cFEvNVlPenpjTlM1YTBvaHkz?=
 =?utf-8?B?cnZMTXVVMFhuSnM3aXJ0dm80Z25HaGZOTXc0ZUtDemVPdmprYjQ2NzVUNVpY?=
 =?utf-8?B?dmlkQ1pMZll1dlh4QVhkK0VjOUNnRGZhRk1aWDNWS1hzT2IvN096aldQQTZQ?=
 =?utf-8?B?ZUZlekg5dG14OUltRnpiZExDdHM1Q2xNemxleVNuc3BVb0tNL2NDM1RtZ0Yy?=
 =?utf-8?B?clN6RmxtNW9URUJHdm1RYXQvRU9tTGVQMDRIcVRJazVsY292NEdaM3JLMlhi?=
 =?utf-8?B?RDhuUkR0aFc3dmtLZWxPditNMVQxS0hKdGx1a0lkdTAzaVh1VURnOHZJYU16?=
 =?utf-8?B?Mzc3TjIzYTVpS2VJSWhaUm03UGlndXN6UmIzeGRGUGpaQitsQUlDT2JTbklF?=
 =?utf-8?B?QlRzbkRhTTZtYktLNk5vMWhWaEVKUXJCaElVMkFNUmxGOXF6TmxrV0tVQjNI?=
 =?utf-8?B?eVJsWWh4elMrZlRRVS9Dd3VFREt6M05XS0xTWnEraHpCcCt4WExDWWNTbTVG?=
 =?utf-8?B?LzJEOEM5dTJZTUNJVEs2RDU0b2lQMnQvendNNU9BR2tBeFIvWmcwNDJiS1o2?=
 =?utf-8?B?dUF3WVVXRTY2MitHOXJKNmJ4WTBNbjd3YkM5V25VZjNtWFBoMm5GU2VBcE14?=
 =?utf-8?B?NHVRTU5EN3d6aWZpSG45NE5razdDcWtyQ2YzeHlBSFhoejhFZ2VpaU9FTDBy?=
 =?utf-8?B?c2VrcEJEVDhFUnFmLzFmcUkzdjJMYWc5QTd2R3FVU0FHZXJZeXJsNGVkeFhN?=
 =?utf-8?B?dHlpT0dQL3YyVXl6U1ZoUmgrVFNvMTBNSmJvUjVRTnVGVk00UGJ6Z2xqNjN3?=
 =?utf-8?B?b3p1d1dEZ1hDS2F3dGtiRC93eE9objJJTS92aUtpemdwTkJEUWx4WmFMQmxk?=
 =?utf-8?B?aUIvQWRDNEhia3A0aWpMczV5dWR3MWY0Q1o4S3dZTnZ6RWdzbldrYnpYSFlL?=
 =?utf-8?B?a3pQSDZLVURnRGRydVd4Q0hVSkZWQzNGM1pWV1Z2Y3kyaW5YSGE4Wm0rL1ZK?=
 =?utf-8?B?SUFmUlZMaEVpZlNsTmU4ZUtkeUxjaXVMbXBOUjlqSWd1OG4xN3kwTUI4T1Ny?=
 =?utf-8?B?WFNhN1lhYmJBNWRHRWdsazJ2M1Z2Wkh5Sndid21HYlJPTk5GUFNFcWhLQ1Jh?=
 =?utf-8?B?M0RPakxrU0dqTlB6dFlxTGc5VjNRQWk4b285WEpVNjNYZ2FoK2ZyeVFFdHJp?=
 =?utf-8?B?UWw4VEtoS0d4RXoxWUJ3Y0Z3V2RmMVU5bGI5OVRnVDBZOU10SVZkZnBNOHhF?=
 =?utf-8?B?clZOcTY4M3diR2lITStnNUg1RzcrR2d5WXJQM1N1a1pieXJzWC92SUVFZkZ5?=
 =?utf-8?B?Q2c2MDJSNkJabzZocE0xNGhJQStYd3ZSZkpsOG9LVkxzS0dnOWRFcDY0UC9a?=
 =?utf-8?B?L0ZBSElEUWJGK2xEaFZEVU9sa2pIamcwaUdKZjVHdEdnM1I1TkxLRmU0QWti?=
 =?utf-8?B?ZkZSTGxyMEp5dnVaT29XYXh1OGM4TUZSLzRPYlZTNk1IWm9rbkxDS0lvNjhE?=
 =?utf-8?B?cEQ4aGNwZ3NxNUhueU84eFdoZXdUOW42WDN6TGp4QjJiY2hmRXhGeEJqMWJB?=
 =?utf-8?B?aVpjbGVSeVh1MzhxWGNiV1UwdVJEOVA5WHZOK0tVcjU2SFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHFRNmJ1dUxyUnByaFdlbHE5cVNiVGR0S1ZyQ01HZXlqcHhtR2lKalE0dWgw?=
 =?utf-8?B?RWRjMGMvUFVIc1JpY2F1Y0REVFA2MmhsWTVDTk5xZFJyajZtUFFzV1FkUTNj?=
 =?utf-8?B?M1ZVd054NElBaDhEQ1lpYjB3OEUyZ1JvZFJlMDQzS0RyOGR2ZnhEeUpRK1I5?=
 =?utf-8?B?RG1TMFVrZ2ZjaHF4VWl1N2tqOFFLdm52cnhpOU5DY0NFQVN2bUxsSkRoRFg0?=
 =?utf-8?B?WEw5MzdoM1BNMGZraDZTRCtEVXcwcU5NZTVrVGo5Q3Q2K0ZDcUF3dWF1b0FI?=
 =?utf-8?B?c1RRSU9mckxnb2phNm9lUkNFSVIrYko2QlNaR083WExlQ08vR0xjYlB2M1pr?=
 =?utf-8?B?aWdnejRuVEtiR2F3aFZTMGhrNHR5T3dIcHVJZ1hOcWhRN2lIcVYra2RZb1JZ?=
 =?utf-8?B?bGdrZUVOQ3BaTHNvVmdzdUx0RXJFMWVCMXI3cHNCcDJ4K3FYWGt6dm5wRlhP?=
 =?utf-8?B?cGJ4b29ITHpabHFaQkNWZVRJcld2K0J2RkpaQ3MyUEVsc2hxQmpvTkx6TWhX?=
 =?utf-8?B?QlU0VE1ZZWZkcTladUR2a01tcFVJWDFnc0t2Zi9IRFF1TTZVYkF4bC9TZ0dH?=
 =?utf-8?B?QUlBN1Y5RVBIa1EwTW5DMFhJaUUzNU1zMjBDQnE4SitCU1loamlnQjRUWTVO?=
 =?utf-8?B?YlQyOGRHMzNLQVRteHdXWUtVNFhvd2NZUUFnS212SlVOM3hXUXNUbmVXOXpK?=
 =?utf-8?B?ejNrdllmSFIzT3VlVHRQb0JXMEdyY2I0SEUycVBpekNHdXlwVzhjTWJLT0FY?=
 =?utf-8?B?R24zZW1PZjljMGl6R3ZJQW16dzB4LytjQTBJcWhJQXFiWlB4azA4NEVZbmw4?=
 =?utf-8?B?TjcrcjlBWlQreEtONVF4dHMySGpVdTFNQTBheVlUNmlDdm0xMFN5emN6dTFX?=
 =?utf-8?B?UU9JMEFSd084WlhXa25BRURMSXI0ckJnMFFWVGlKUTJwc1FGdU5CS2pJWDhl?=
 =?utf-8?B?OFlMUVBsdnBzeFhvOTd6MmJnYWNsZ2FRSklHejdzdVNTMU1oYXM0K0Y1a0FE?=
 =?utf-8?B?VnFHMmFJQ2M1KzJOdnFGVUJaZU1pSHhUbE1pN0NLVFhVUVR5anVGanlFTFVX?=
 =?utf-8?B?VE5kRE56UHVUNVJ2RElFL3RmQVYwakZBRHBVV2hUd1VlWEhoRXhScFlMSFlp?=
 =?utf-8?B?NENiU2sxa1JYZVBrSExIVWl5dlQ3VXBtRG5NVmRvb2JlbmYyT2xHY29jVFJO?=
 =?utf-8?B?QXFBUUErQUljdURKcXJOOUgvc2ZIYmVDYnk1ZUVWekRJSE5wOEJrSUt4Y2lD?=
 =?utf-8?B?Y2k0SGtpUDRPbU5ZZGdDMm1CNzRBeEh0aHVWRENNZlphVDZlSk4yOVVZSldu?=
 =?utf-8?B?MHNqVmg4ZWd3Y0puSlIwK3lIWHljWHlkL1RmN0ovYXl4NmlCVjRhRloxcysx?=
 =?utf-8?B?S1V5QnJPMkljSFpqOHZCQUJxa0FibFNsREt2ams1YzJoNmh2QUNEc0hkcXZ2?=
 =?utf-8?B?R2xPZFNBQ2k0VXI3ekxDVEl3N1hVWWJ1c05Bb1ZoVHpoa3ZHQVl4R084NWFE?=
 =?utf-8?B?YS9lOWtpK2tRMURpUDUxQ3N1ZUJEZWNsSWZqYWFKVE5XWkUxeEFhVG1PMmIw?=
 =?utf-8?B?T0xVZEJqR2hvWGRBc3NqUFk2S01ydGFIelhsYzh6NnU4WTJ6R3AxUFRDSWVw?=
 =?utf-8?B?eS9abWZIU0l6a0djdHNzQ2VPUzdhY2R3bXBVVTdZMHFVTGFrYit0akNiUUpU?=
 =?utf-8?B?eWppNjVqcmpMeEhGaXdLdUc5UlRCVitmUkFmcDlKeU15SWMrUmpaL2FPVm9N?=
 =?utf-8?B?KzBXNUd3dUVOY0U4NitVbnFZK0N3dVVxMTd4d1hDcDVDTXVnbzR6YmNuVGUz?=
 =?utf-8?B?SE1jdXRjazBkSXlJNUhtVEdNKzhNMkhwSjgraVVDbnVqazcvTlZmS3dhU2VU?=
 =?utf-8?B?MEJQK0tKdTZjYmpCYzJnTDdmVTVFczJUaEFEZVA3QjIwMThBT1NYcjJTNGhn?=
 =?utf-8?B?TVF1RW5QZE9rSUNoQjBwcDhsVVl2ekpnMXE1dGhMWVJvUVdoY0tUNEIvK1ZS?=
 =?utf-8?B?SXozN2FzM2FJRkt5QnAvdW5tSVk0U2pTV0p6cy8ydmY1ZjU5czhTSFFsM0lm?=
 =?utf-8?B?OUNrVWxqYnh1T29uVFk5QVc1ODljcTVBTk9Gd3ZnYVROQm1sL3hDb1AydmYx?=
 =?utf-8?Q?r7iWgazEIvocmT8mWSaslUlMr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 609e37d3-5fb4-45d6-b2b2-08dc996a4979
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 01:08:15.8028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avou0xvgw4fPFFtj9oOTp6eoSfCtrjUb9+ISPrA9CAIdVXgfTkqcNa6a1+WrLk24maeuQQLiwqbkQSC1Xw2b2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8787

SGkgSm9oYW5uZXMsDQoNCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRp
b25zLm5ldD4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjIsIDIwMjQgMjoyMCBBTQ0KPiBUbzog
RGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJyaWFubm9ycmlzQGNo
cm9taXVtLm9yZzsNCj4ga3ZhbG9Aa2VybmVsLm9yZzsgZnJhbmNlc2NvQGRvbGNpbmkuaXQ7IFBl
dGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRd
IFJlOiBbUEFUQ0ggMDAvNDNdIHdpZmk6IG54cHdpZmk6IGNyZWF0ZSBueHB3aWZpIHRvIHN1cHBv
cnQgaXc2MXgNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4g
dGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gRnJpLCAyMDI0LTA2LTIxIGF0IDE1OjUx
ICswODAwLCBEYXZpZCBMaW4gd3JvdGU6DQo+ID4NCj4gPiAgIHdpZmk6IG54cHdpZmk6IGFkZCBp
b2N0bC5oDQo+IA0KPiBldmVuIHRoZSBuYW1lIGhlcmUgc291bmRzIHF1ZXN0aW9uYWJsZSA6KQ0K
PiANCj4gPiAgNDggZmlsZXMgY2hhbmdlZCwgMzQ5MjggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0K
PiBUaGlzIGlzIC4uLiBodWdlLiBJIGRvbid0IGtub3cgd2hvIGNvdWxkIHBvc3NpYmx5IHJldmll
dyBpdCBhdCBhbGwuDQo+IA0KPiBBIHF1aWNrIGxvb2sgc3VnZ2VzdHMgdGhhdCBpdCdzIGdvdCBh
IGJ1bmNoIG9mIHRoaW5ncyB3ZSBwcm9iYWJseSByZWFsbHkgZG9uJ3QNCj4gd2FudCB0byBkbyB0
aGF0IHdheSBhbnkgbW9yZSwgbGlrZQ0KPiANCj4gdXNpbmcgc2VtYXBob3JlcyBpbiBhIHdpZmkg
ZHJpdmVyOg0KPiANCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NlbWFwaG9yZS5oPg0KPiANCj4gaGF2
aW5nIGEgYnVuY2ggb2YgKHNvbWV0aW1lcyB3cm9uZyEpIGVsZW1lbnQgZGVmaW5pdGlvbnMgaW4g
YSBkcml2ZXI6DQo+IA0KPiA+ICtzdHJ1Y3QgaWVlZV90eXBlc19haWQgew0KPiAuLi4NCj4gPiAr
ICAgICB1MTYgYWlkOw0KPiANCj4gZW1iZWRkaW5nIGEgKGRlZmF1bHQ/KSB3aXJlbGVzc19kZXYg
d2hlbiBjbGVhcmx5IHRoZSBkcml2ZXIgc3VwcG9ydHMgbW9yZQ0KPiB0aGFuIG9uZSBuZXRkZXYv
d2RldjoNCj4gDQo+ID4gKyAgICAgc3RydWN0IHdpcmVsZXNzX2RldiB3ZGV2Ow0KPiANCj4gSGF2
aW5nIG11bHRpcGxlIG93biB3b3JrcXVldWVzIGlzIHByb2JhYmx5IGFsc28gdW5yZWFzb25hYmxl
Og0KPiANCj4gPiArICAgICBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqZGZzX2NhY193b3JrcXVl
dWU7DQo+ID4gKyAgICAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmRmc19jaGFuX3N3X3dvcmtx
dWV1ZTsNCj4gPiArICAgICBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd29ya3F1ZXVlOw0KPiA+
ICsgICAgIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpyeF93b3JrcXVldWU7DQo+ID4gKyAgICAg
c3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmhvc3RfbWxtZV93b3JrcXVldWU7DQo+IA0KPiBhcyBp
cyBhIG1pc25hbWVkIG11dGV4LCBidXQgcmVhbGx5IHlvdSBjb3VsZCB1c2Ugd2lwaHkgd29yayBh
bmQgbGlrZWx5IG5vdA0KPiBoYXZlIGEgbXV0ZXggYXQgYWxsOg0KPiANCj4gPiArICAgICAvKiBt
dXRleCBmb3Igc2NhbiAqLw0KPiA+ICsgICAgIHN0cnVjdCBtdXRleCBhc3luY19tdXRleDsNCj4g
DQo+IChldmVuIG1hYzgwMjExIG9ubHkgaGFzIG9uZSBtdXRleCBsZWZ0LCBhbmQgdGhhdCdzIGZv
ciBhIHNwZWNpZmljIGNhc2Ugd2hlcmUNCj4gb3RoZXJ3aXNlIHdlIGhhdmUgc29tZSBpc3N1ZXMh
KQ0KPiANCj4gcXVlc3Rpb25hYmxlIGxvY2tpbmcgc2NoZW1lcywgYXMgZXZpZGVuY2VkIHNpbXBs
eSBieSAiaXMgc29tZXRoaW5nIGxvY2tlZCINCj4gdmFyaWFibGVzIGV4aXN0aW5nOg0KPiANCj4g
PiArICAgICBib29sIHJ4X2xvY2tlZDsNCj4gPiArICAgICBib29sIG1haW5fbG9ja2VkOw0KPiAN
Cj4gbG9ja2luZyBjb2RlLCByYXRoZXIgdGhhbiBkYXRhPw0KPiANCj4gPiArICAgICAvKiBzcGlu
IGxvY2sgZm9yIG1haW4gcHJvY2VzcyAqLw0KPiA+ICsgICAgIHNwaW5sb2NrX3QgbWFpbl9wcm9j
X2xvY2s7DQo+IA0KPiBidXQgYWxzbyBzaW1wbGUgdGhpbmdzIGxpa2Ugbm90IHdhbnRpbmcgdG8g
dXNlIEVSUl9QVFIoKT8NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbnhwd2lmaV9yZWdpc3Rlcih2b2lk
ICpjYXJkLCBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3Qgbnhwd2lmaV9pZl9vcHMgKmlmX29wcywgdm9pZA0KPiA+ICsqKnBhZGFwdGVyKQ0K
PiANCj4gKHBhZGFwdGVyIGlzIGFuIG91dCBwYXJhbWV0ZXIpDQo+IA0KPiBXaHkgcmFuZG9tIG51
bWJlcnMgZm9yIGNvb2tpZXMgaW5zdGVhZCBvZiBqdXN0IGFzc2lnbmluZyBmcm9tIGEgc3RhdGlj
DQo+IHZhcmlhYmxlOg0KPiANCj4gPiArICAgICAgICAgICAgICpjb29raWUgPSBnZXRfcmFuZG9t
X3UzMigpIHwgMTsNCj4gDQo+IE9wZW4tY29kaW5nIC1FUEVSTT8NCj4gDQo+ID4gKyAgICAgaWYg
KG54cHdpZmlfZGVpbml0X3ByaXZfcGFyYW1zKHByaXYpKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIC0xOw0KPiANCj4gVXNpbmcgLUVGQVVMVCBmb3IgRlcgZXJyb3JzIHNlZW1zIGxpa2UgYSBy
ZWFsbHkgYmFkIGlkZWE6DQo+IA0KPiA+ICsgICAgIGlmIChueHB3aWZpX2Rydl9nZXRfZGF0YV9y
YXRlKHByaXYsICZyYXRlKSkgew0KPiA+ICsgICAgICAgICAgICAgbnhwd2lmaV9kYmcocHJpdi0+
YWRhcHRlciwgRVJST1IsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAiZ2V0dGluZyBk
YXRhIHJhdGUgZXJyb3JcbiIpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+
IA0KPiANCj4gQnV0IEkgcmVhbGx5IGp1c3Qgc2Nyb2xsZWQgdGhyb3VnaCB0aGlzIGJyaWVmbHks
IHRoaXMgd2Fzbid0IGEgcmVhbCByZXZpZXcuIEkgZG9uJ3QNCj4ga25vdyB3aG8gY291bGQgZG8g
YSByZWFsIHJldmlldywgYnV0IGFzIGlzLCBpdCBsb29rcyBsaWtlIHNvbWVvbmUgX3Nob3VsZF8u
DQo+IA0KPiBKb2hhbm5lcw0KDQpFbmhhbmNlbWVudCBvZiBueHB3aWZpIGJhc2VkIG9uIHlvdXIg
Y29tbWVudHMgaXMgb25nb2luZy4NCg0KVGhhbmtzLA0KRGF2aWQNCg==

