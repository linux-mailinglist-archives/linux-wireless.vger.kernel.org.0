Return-Path: <linux-wireless+bounces-29352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1DBC8830A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 06:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEDA3B3CA5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 05:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFFD30DEB0;
	Wed, 26 Nov 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WDXRjkOQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011035.outbound.protection.outlook.com [52.103.13.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435E7D098;
	Wed, 26 Nov 2025 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136550; cv=fail; b=r+ByUEUeaMR/Rc5gAQDcIHMGwKENcDq4X0vdq0EfdNwcqgjOi51RBR/1Zj2m7im5ko68rQHu6b0wbLZXFZY2yKnZlXE5CzwQOGxpO39asbbfpo2x2VrBHfxkAojT7o2Z4qsGWeKI1IRWez86XcTIb+gM6FgmDlCIZVJzLa3d4sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136550; c=relaxed/simple;
	bh=NfMM8mu3A72gB4TUMVZJuiHMiYUF7JquuwmrkD20y0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FviYbmlXWUPalstyEc6fLd7YugoyMO+DEd1Qq05lRYjr2V1Ne6NGS/muEy3IjUssb3aK7ZUHGG0iiy+XBQtiqMu5yrhE/t/xLfoX9aX4+Wrw1MjAw5N2k2ZmyycUNxyOtx79PHBbUjvpYcxOx9S9aswxJq8P1+5InKIuNIUA5co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WDXRjkOQ; arc=fail smtp.client-ip=52.103.13.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLpM4TzeFoz42qnjJxKyjy3hUXFax40Mw91hw2/Z+jDKejiyZ4l68VNmuE1sG4kwY2pDjvDUB6glXrXYdIEVpO9aEjKQgYrrvL/CkZkfc9cUx0xBhOPMd9yZgU3cytOti7jk01DolEPmAZNjwDHz5XoXUl0b6zUwItbAJIDEDCTCH5atQOdFW0T6JNcMjuGyeXI5p4oLNqpuEBOpRdjMfH5EVh4KZtgLT5jByx30IjkDUtLdW9qSXQowWPvfx8dDJvOPpZVbD3IgBuDeBs0xJP7j6CQUJYxuAD3tku6E2M+KBo99UCBasLCuCPcRrPmM56XjV/q/UP7DwAVTI5c1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfMM8mu3A72gB4TUMVZJuiHMiYUF7JquuwmrkD20y0I=;
 b=G562BAu8Q56LSrnlo4Q75dbWQaEfFfDhhu6PuLZRpHqw4ciyF3sXGUVX2WMneCbNQsI0mSDBekVDg5ZUDoBpOwTiH0l+WtnayKMr4VJuKtXUYi7n7mOUvUiJP6hWOJd/lI3KkKAlps0oN4SQ97kFnYkgiXb9XRRU+8SZEc3s6V7EvgegZrHI3QrjPJKXwWQAC6jeZKtUAyisyMs2sHuCuXTrSIDudgwUajbuub87pI7UCMHaGtOZJ12dipKiu51ZZAo4/0tC/FPy6vmaIvRw1qB7cJ2Zhdrw56AilP4AqQJk3Zw6tEtfxWaMDUst7ukRfU9abnj06wGvVtshoHDYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfMM8mu3A72gB4TUMVZJuiHMiYUF7JquuwmrkD20y0I=;
 b=WDXRjkOQa7AKukKJdcIZtFSU/+gw7HDDoMhRtmAcQAIIeTVUAgVekqf0RNoxA8O86d//3naA1Phd3arSYmN93LBPwQCiWPUcdH715NZhlgelUZVKSBnWwc776w6SIIeVZn1AGpF+h/7ewFIKxKm/2dAGxq91lKxvsT5ck6cnN3HrjMvpwSdT4uGg+F3fuz8NLxyBLmhF/08ZmIhUZGN3NDtHRGrE7LNZbHHlbBVA+wLHXZbfN34E23habAr3iVa82gYFyEbq/kedXdUuh17IRDQXPM3jrTl8mHhNMQ9pdpvLTamO3nJAqPbSw/6zyKc8TST2n5V60vaLbq8PQuP+AA==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 05:55:46 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Wed, 26 Nov 2025
 05:55:46 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH rtw-next v4] realtek/rtlwifi: remove unused two if blocks and
 put unicast set inner if and else block
Thread-Topic: [PATCH rtw-next v4] realtek/rtlwifi: remove unused two if blocks
 and put unicast set inner if and else block
Thread-Index: AQHcXplOcL6ODpiG8k6BBnhFu6v3gQ==
Date: Wed, 26 Nov 2025 05:55:45 +0000
Message-ID:
 <SA2PR10MB4460E7C842251428DB9D253EA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
References:
 <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <731806e542f245b3b3ae6d2429c499e5@realtek.com>
 <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com>
In-Reply-To: <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|IA1PR10MB6267:EE_
x-ms-office365-filtering-correlation-id: 3364f4cc-26e7-4a2b-8573-08de2cb07141
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K37bg/D3hdjhOLC+pm/gFFD20Wi8JjjTEzcpXHNRazTLG+Owu93rEkOGMdmI9wH2wCrnc9ClEMAVd/iDqyP+t6PaRb69Us3Qeol2x2HpwFhrrJHqpGZfr7Xtqp53kNWAkaLeG3IDsC18W6NaVSMUZwdgWuC1mrmJSIjXd+/P8XjSUh5MgLFuF6wHGIpS6iuYkZKi9jYSV6qz/5RzJOXcqyjGZW5HDFoGJiwUoCIbrt9d+Ug8k3aa+OrNMjsErQwgJRPlKwKV0Yhjqw+ZiO+CwgT3vuhFaBRqhHzB3TqzMy/iRGT0CJ+0ays8+SpKZ1fCztsWgk6sWLDNFrv/m2RygkGcIH3B2Q1dkyn+mEzfV7K5BsvdJrwCzZth+KpMcPKPOvsSD16rqeQ1abquqGP+CRocj4g4TW8TvezuskSlqWrXb83JHeCjYuM6YAz1uiV3ezkJeZK8LuZoKq9O4miDGv1zuS05yCfNF6D5MQKgRAt24rDMPdA/1D6iK5U4IwSnXbsnsmZKGfE5MjvKofbWNLw22xPnA1TQ8Jvj1K1ecPlnnQGOZMqMDJeW3XoeDwMXQSGrlH4XHefsTVXrNd63i12zjQ13jU3L3JUjRGQEi+vqXZEQ9N5e52Ibz38py2cn0D535fG266lPIrsVl401buljjm+wYr6A1HD7TZvNLwcoIUTCjaye7ha4RVdq8/EmLqJ910HqDAe/KpT88g7Dxk8EzdWQA62W7OaOYX7AE7zp5ZFhPkLoJ9c=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|31061999003|461199028|15030799006|15080799012|51005399006|8060799015|7042599007|102099032|40105399003|440099028|3412199025|26104999006;
x-microsoft-antispam-message-info:
 =?gb2312?B?MjdzQko0VnAyYWVnc3RRRWIyWkdDZUtlUGU2aEo1UFpFaDJadWlFUktwcWJC?=
 =?gb2312?B?ekpMemhONy80MnQxV2N1S3pzSWI5bmduakVDaThyYmtuODRNUENkU3lPU0Fh?=
 =?gb2312?B?aUtLMW1ONWx0MTJQVjk0WUdMUnMxUDRrdmUvZGxSWm9sK2tLSXdORkpTQWFY?=
 =?gb2312?B?K0xwa1djZTYvVUxkNVN0NmZVZTNJRW51TFoxK3pidGtOUzI4cnIrZTlhYmp1?=
 =?gb2312?B?Zm9yYTQrT2NaMjRwSFI3U09kWDZlS3FLYytFNVI1eFRTN1R1WTRydHB1cjhx?=
 =?gb2312?B?YmhYajNJbDlRZFZtZktvNWtwZGxHRnNQUjhCYTM1V0h4UTlUaDVFUjVuRmha?=
 =?gb2312?B?aWE2QTEvZXh2TlErVlZJaXI1UmdmWCtwRW0xUDZ5YmQ2eGlRV1B0Y2Z4U1d3?=
 =?gb2312?B?MTRpaHZHNG8rYytmbCtrSU1pcGtMK29lcFp4ZHNsdU5OK3BoV0lqbnlrNVpM?=
 =?gb2312?B?MHliNE1hdVNOc2dlTi9ZUEtVclpBcUNpVkowc2RKWDd3NTdVM1pYUEtIYzhL?=
 =?gb2312?B?dWtZK0hZekU1b25henc2R01MVDdCa0lZc25aTmFhUmJzQW94WWFVZUpqeFFz?=
 =?gb2312?B?c3g1YUErME0rWXFJZVc3MGFxc1J4UTFIcU55WkI5cGN5bHFhQitQdVpEYVBS?=
 =?gb2312?B?SXR2N1VqdGNDcWpxV1VLVjJJSUNLbFFYbXJmVnpXMngzcjM0Nk5BcXR0azd4?=
 =?gb2312?B?ZWRnRHhlRWRyNDhuUnpTaTNCTDh1N0VEM1FiWkRHakhxbjd0SW56Nyt1WXhi?=
 =?gb2312?B?REdSRHREa2tScVZnc2xFdzNSamQ4a1VwcTZpckV5V3JYejdaell6Y1cxTHVF?=
 =?gb2312?B?UXNscDQvRmpOM2VNeWJpYk4wSThOb3NUd0JyTWxzalppWlkrcXY3VysyaGtp?=
 =?gb2312?B?UmRoZkErTFFDUm5acEIzR1A2TEFvQUhybWhFUTBqb0xtME9NUUYyMzdzNlI5?=
 =?gb2312?B?TjMyM2hQeERXMzZ6S0MwSFc1Nlc0ak92QVBxNHFkSzJkeFRoSFlTdkxNNzdT?=
 =?gb2312?B?dEpXRDB5bVdUbnJvNjdTYkZROTNFUTJyendrdmwxRjV5cmZPSUU2bEs2KzZB?=
 =?gb2312?B?Tm1UaGlSZ1RzbkhubWExMnVTSmZ4b1BoeHlHRmcwRy9zV3NCWkY0Zmp5Q3RJ?=
 =?gb2312?B?dDVScEhSNlJBeHVtZXNSb0xaNDZ5Tm9kUmhTcFhJTFlFZXRvT2FPbWJVdk9I?=
 =?gb2312?B?R3VOUElSeFNBeGhhYU1MaStmaENhclFRVytwdUN4Sk42N3dmMTRMa3lLRzhk?=
 =?gb2312?B?UjBobmZvWDZFajRvRHRoYXExUzUrQS9kcURReHJiWmNzTUJEZ3RLRHJiZEwx?=
 =?gb2312?B?RmFnZnp5VFZHWjdwMVpoaHNEV3dZVUZqWk9HbUVqU2YveHRwNEMxaGFlckFa?=
 =?gb2312?B?MDkwVmNNaEtvd3MvbCtPMW1jSVM0Ujc4dmxSa1R0UkRCOVdUdk9xb3FpWCt3?=
 =?gb2312?B?VXowcER6RGU4TlJnMlVFSEp2bFA0K0VSWFlmRTB5SjRONEZDc2Y5WHBzWU15?=
 =?gb2312?B?M0ZMNkgzTWJsb2p2UEtESEw0eW1UOHdVU2NrSVJZQWJVN1QveGM0NUxnOVN2?=
 =?gb2312?B?TG5sWDZ5V3JEZmRFWU9yVXM1aGJuakRDYXNOR0VFZFUvTDUxMGwxK1JRZlhV?=
 =?gb2312?B?UG1RZU55b2JTTytKUmlZVGFmSXI5cXlVYjAveStCUjZaaUxkeXE1MkQvcGZ0?=
 =?gb2312?B?UE5wVHhYSlFpdmhoL3FkdjBQYjl4VlcwcmlUSFlkdm5oL0k5N2djVURnPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TzVQWVlGR1hwejNxdk9GM2ZCSUM0NEZINHhiK29OVWx3RGdDOU1VeEtPa2tR?=
 =?gb2312?B?Uytsb2hzMnRyNVNXVlhaNGhDQ0k2OU5aTEM5c09iSVJzOFRVSDJKTVdkdDNq?=
 =?gb2312?B?NTF2UVBWdzBjSHVIbTd3SkVCY2xzUEZVU3BjQW5GTTFkTG9vU2thOUZyZVh1?=
 =?gb2312?B?YUM1aXdLSWFlVWhrRldlcDZKT1cxazZtOWxPYVFaTUFoUnplazlOcFpRdXM0?=
 =?gb2312?B?U2Y5dXBVQ1BXVTArVXNVUVM1bXNrRDMyNFdjeWJGdjNMWkFoVWhsYkd0NWlp?=
 =?gb2312?B?amxiK2RhSFQyRG1RM2YraFZxaEN4NVRlUXlRQmxpT3pIUXJlTkQ5WmNjdFBo?=
 =?gb2312?B?SWhibVc2TkFadGc5WTEvZEF3S2VGQ1pJdlBRRUpndW1QNUJ3anh3ZUpoWnJJ?=
 =?gb2312?B?eWkzQWhydW8zZzFLUWtTYUwvckx6VWcvZ3FwWkozYXQvdi91V1NKWVEyOGg3?=
 =?gb2312?B?Z09jekJMS2xTVUpndHJ0UHBHMGlTOWs4ZjNLa3FSU0xqNWdxdGx3Q3UwNTFP?=
 =?gb2312?B?d1pQTXE0eUIvajJnMkVnTUQzbEE5Qi9oSXpJMHpGYnUzbW84WmtmL0tQeEdC?=
 =?gb2312?B?bVVENzF1NHhyVzJHN0tLVnRGWGRmd3Q4QXFkUzNkUzVNTFBqMnVZdzQrblRS?=
 =?gb2312?B?TGVGeHMzRlJpcy84TTZLQy8vcmFpaUxvT0FaTHhudVB3QmJ5a0NKK1Y5WU1N?=
 =?gb2312?B?TkVUNFhjWHBFVGlqWmJ1WWpoeUMyamFETEVkY1hHbHpTRHlpTHpqVVRER3I2?=
 =?gb2312?B?dlNYeHNyTXp0eWY4bEt4ODBjOXdVMWxpZ0RqOURRUC8yM09nTk9jME14Mlhj?=
 =?gb2312?B?US9iY2VpaTBFanZaNURjS2RkYUwyNGR3NjA5Z1JMRC95bmgrVFhvWTN6cWVz?=
 =?gb2312?B?Q3EyVUxTdjcvamswS1dNWFdOOUIrN29IbTEzT3NZOU8xVzI2MTFreDRic2x6?=
 =?gb2312?B?RDl5Q2VDWURNbElxcTdnLysxVjdwMnRjdFFGNXpDNjl6bklJU2QrcDVyVi93?=
 =?gb2312?B?ZnV5SEU3R3JCVjFiQjVNZ3I3dHRNU0pOTlVLS2JuU2NiYlZzVmVHRHZ0MkVl?=
 =?gb2312?B?ZmliMzdpekRlVkxzU2o1QWdQS201Ni9PYzZFMUFoR2xUVVNjNkR6RXNoUHVC?=
 =?gb2312?B?bUM4N2R0MjBGZWZhNTZLSEVtczdNNW1SRDlTUVpNVWlnQjQvMlpiK0piSjB6?=
 =?gb2312?B?eXhyY0x0aWkzUWRRcmNScXdMaTAzUjE5bjc2MDhQdCtyWXA1T0JwbGVMZENz?=
 =?gb2312?B?R0NiaW52NVpzeXZ2RHVVTStjZi9xZ3NWaDlVbmRoQ2RuYmJ4REJvL0h4ZkUz?=
 =?gb2312?B?UXZ1SUxrN1BteUthVUlDd2FZc1hyVDBNaFNqOUZtMXVvRDFOVk1Xd3JxTXVj?=
 =?gb2312?B?M1M1YjllMzBENEcrNDU0WlhHMFhwUzlpVkVSM2hnVjRzejBkbCtFeWRsWGZH?=
 =?gb2312?B?UlZ2ZjZiODFiVDBIMzl4L0M2S1MwZEtienpIY3ZiMi8rOE4wblMxbGVYVFhx?=
 =?gb2312?B?ajJPRnFTc2R6MCs3eHVFZXk2UGNTNHZBYXBRYm41bWcwWXJpaGJTV3E0VlBn?=
 =?gb2312?B?NE5tVDJCVGtoZGRaR0o4aWVLZmVSMGpLdDkxdFJpcitEVTlORjA5SWkrNDJq?=
 =?gb2312?Q?QzzPBVaZaOVRcYZPelF7v74Ys8rAcEknTXOkoHzvy5oA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4460.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3364f4cc-26e7-4a2b-8573-08de2cb07141
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 05:55:45.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267

UmVtb3ZlZCB1bnVzZWQgaWYgYmxvY2tzIGFuZCBwdXQgdGhlIHVuaWNhc3Qgc2V0IHNlbnRlbmNl
IGludG8gdGhlCmlmL2Vsc2UgYmxvY2suCgpTaWduZWQtb2ZmLWJ5OiBMZXMgQm95cyA8bGVzYm95
c3BwNDNAb3V0bG9vay5jb20+Ci0tLQpDSEFOR0U6CjEuIE1vdmUgY2hhbmdlIGJsb2NrIHRvIGNv
cnJlY3QgbG9jYXRpb247CjIuIFJlbW92ZWQgaW5pdGFsaXphdGlvbiBvZiB1bmljYXN0IG9uIHRo
ZSBiZWdpbiBvZiBmdW5jdGlvbi4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bHdpZmkvcGNpLmMgfCAxMSArKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bHdpZmkvcGNpLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdp
ZmkvcGNpLmMKaW5kZXggZDA4MDQ2OTI2Li5lZGEzYjgwZGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9wY2kuYworKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0bHdpZmkvcGNpLmMKQEAgLTY1Miw3ICs2NTIsNyBAQCBzdGF0aWMgdm9p
ZCBfcnRsX3BjaV9yeF9pbnRlcnJ1cHQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpCiAgICAgICAg
dW5zaWduZWQgaW50IGNvdW50ID0gcnRscGNpLT5yeHJpbmdjb3VudDsKICAgICAgICB1OCBvd247
CiAgICAgICAgdTggdG1wX29uZTsKLSAgICAgICBib29sIHVuaWNhc3QgPSBmYWxzZTsKKyAgICAg
ICBib29sIHVuaWNhc3Q7CiAgICAgICAgdTggaHdfcXVldWUgPSAwOwogICAgICAgIHVuc2lnbmVk
IGludCByeF9yZW1haW5lZF9jbnQgPSAwOwogICAgICAgIHN0cnVjdCBydGxfc3RhdHMgc3RhdHMg
PSB7CkBAIC03NTIsMTQgKzc1MiwxMyBAQCBzdGF0aWMgdm9pZCBfcnRsX3BjaV9yeF9pbnRlcnJ1
cHQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpCiAgICAgICAgICAgICAgICAgICAgICAgIG1lbWNw
eShJRUVFODAyMTFfU0tCX1JYQ0Ioc2tiKSwgJnJ4X3N0YXR1cywKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZihyeF9zdGF0dXMpKTsKCi0gICAgICAgICAgICAgICAgICAgICAg
IGlmIChpc19icm9hZGNhc3RfZXRoZXJfYWRkcihoZHItPmFkZHIxKSkgewotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDsvKlRPRE8qLwotICAgICAgICAgICAgICAgICAgICAgICB9IGVs
c2UgaWYgKGlzX211bHRpY2FzdF9ldGhlcl9hZGRyKGhkci0+YWRkcjEpKSB7Ci0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOy8qVE9ETyovCi0gICAgICAgICAgICAgICAgICAgICAgIH0g
ZWxzZSB7CisgICAgICAgICAgICAgICAgICAgICAgIGlmIChpc191bmljYXN0X2V0aGVyX2FkZHIo
aGRyLT5hZGRyMSkpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bmljYXN0ID0g
dHJ1ZTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydGxwcml2LT5zdGF0cy5yeGJ5
dGVzdW5pY2FzdCArPSBza2ItPmxlbjsKKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bmljYXN0ID0gZmFsc2U7CiAgICAgICAg
ICAgICAgICAgICAgICAgIH0KKwogICAgICAgICAgICAgICAgICAgICAgICBydGxfaXNfc3BlY2lh
bF9kYXRhKGh3LCBza2IsIGZhbHNlLCB0cnVlKTsKCiAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChpZWVlODAyMTFfaXNfZGF0YShmYykpIHsKLS0KMi40NC4w

