Return-Path: <linux-wireless+bounces-23513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B47AC9B8E
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF584A34D9
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71437238D56;
	Sat, 31 May 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="t1CWBQoG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011038.outbound.protection.outlook.com [52.103.14.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2695238D32
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705943; cv=fail; b=oqhVp8UAJNSuDRPIliBuxc8FPMcN4CKEGp16LqyusYe1KEG96bee8JWlm1mn7UOI3KqFy9Mxhy9rssMi7pM77mudzS03I9gKct/8qrNyAFrL4MYEAjYzdXJO6RRiWqzBTLWZK52R7bvfqDFizhBc13zhMrPin+VRfwRkmei5Gtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705943; c=relaxed/simple;
	bh=XAAn1pLVJKPTVt37HzgUCrpwEdXwjR/q7BjSqCvnA9k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mj13/mPlZSFGt9LdpJIEHufl8RDxVKNIvX0e/whvTnNybuSyntdG7NuH4fQxtYxQHzWmCwhO2vBIK3iesflKu8Cx2vdoScKQ4WCqtoPqwCUYrFFe0X5QHUCVCiyVRY4LmK6GF9tx1vb/3zJus4af5a5CJB7RqpEoRTsbFDXiGPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=t1CWBQoG; arc=fail smtp.client-ip=52.103.14.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkmYhPsBvEMQTp3UMQhgKO7DNVoVHUhUCbCdUPpbgGQbwl0VSgv8D5TFl9OwFp72oYmmSq+Xl+IgKBUagT0s5fJFh0KJTEJAdolwQ/uhZyO1y8sewoahxxTr7nG9Fl4lqZ5lDT9Io7d9chC+dihjrQObg9Z3mw00F5kiTB6SCYglz9IdQG2wv1nAcJbNFmOpN/PG8Z0K1tMukE2aTvt8ZDCCGQ0PdBr/YmOW8N3ak+rlGjCNz10va1gJ27WJUUZ941owjZyDFB5DeeILwNsG2PTZ/p9dwNWfCWZywdLeyP8Lo3kpr8mLibPS92l4FQ5eExqf/mLcib79toGQzv6uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAAn1pLVJKPTVt37HzgUCrpwEdXwjR/q7BjSqCvnA9k=;
 b=gLtI2N49Cn/C8268IMQQESOUNqnOAO5Rw5WPvF/c9XYJ4yd+50wkDg+byC/3c16OFZTCrJnyWBQuDKoYRDtD4dGuzCuMAVlO8p9T6xQHbWKqA9Mfrr3tB/NEdnSw2/ZObQ6/A+cpWuNee9u/KFTzfqCu6QPpRO3/Te7B5Pb3/5KzV7IJs3JAm2q0vQv6CdGkkwWxPosiVHhCNY/9w8xiYU9mxSiJ28Yt8UELG3RQ/ko1j7aBPM8Oq1YFuvDEQM359EbWx1hbe36ceQJvqQjx2FUf0vzmyg0eg36cgkpdkxIwn5tbprODTYnOfPCY4mz7ultnLmNsYX0S9Drwtwd8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAAn1pLVJKPTVt37HzgUCrpwEdXwjR/q7BjSqCvnA9k=;
 b=t1CWBQoG4gJmIvOKZCoqzKGTnbohano0GGFzw4nMgVdHERUaTTlcbobK4jfUQgpmjockuQRs3dSzMKNv/l/f9UcRXU7RUyk/d0zV/z9zllptZhhqdkAD6f+z+oV4C7Zg/wxk4d4F7T8/Ja4JcgjTsd43ut609y5Z1prZXpj7j5LhLfHn2zM4ZMfO1wrV7RLMA0S12YaUyz9vf3wxEur/VO2B7CISmx1KukhDaeiB1L2CxB9I6XK0UXJhFEn7+J3b+Cjiq3/m71Xz4MB5T5TWl2kG+KAfu8ULVa0ZhBHbUYycREhm1pFknnMUO3X/5UQhKje3cY9wdEQ0hBB1Rrvydg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BL4PR03MB8108.namprd03.prod.outlook.com (2603:10b6:208:58e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Sat, 31 May
 2025 15:38:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8769.031; Sat, 31 May 2025
 15:38:59 +0000
From: Lisa butan <Lisabutan86@hotmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: (Increase Google Search Visibility)
Thread-Topic: (Increase Google Search Visibility)
Thread-Index: AdvSQUQi+CO7d252QH+WpGKD38oR2g==
Date: Sat, 31 May 2025 15:38:52 +0000
Message-ID:
 <LV8PR03MB8137F4049F5B7B9265D5DA64BA60A@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BL4PR03MB8108:EE_
x-ms-office365-filtering-correlation-id: d2f33198-b0ac-496e-656f-08dda0594351
x-ms-exchange-slblob-mailprops:
 VTa9p188PRPq6TxB1uIe5WbvL5N4xeWgoZ6Pl4UHFPALU1hZOVHNaJDJCgRReFIwZRBo7KFm0P8ZAXcStYtXcUGGmVxO8RifNo1wAxW+9Kfm/+cIRiAgh3T5oEwZ8pmQBXXk43Jn2AROsNFSE3wdDBlejBTmZLrwy70soVtdy9TDpRSOFsxxA7rb4InpNelx1h4gp1CefKX9X7nqUfIe7Bx9ZjpUEN2oe3fFIYglHxsXT1Gr9Cn/TrbqeWs2fwlZl2Xt1vY72wtKC2uRkzgIoZLvO9E85Y7/o5ONnU+eQ1afQuYUE0wPpw69qDBLNHcHzZ3nJL/ReVKg0Vpz8QT1d2bNHw5Rmva47jhqshhzX6ROd5dVNZqgqOIJOhlEdmbTAukCzCmpSweg9m43Ad1eGMF4PaSTubO0xmfnEcXOXK9BP5ZSIGioxN6SxD97UgK92CsyCkeC3jAEehBBa0qQqEWmSR8pvB/bwHPYiu6OCtacLHFqMb1IoaCZfhL9iQUjDjPoljg9EaRWIEJMDWW7dWOd8y0B5Wa2wINWDJbDtDGMUUxtD+j6smTGN1BxKq7gL9kdQJ+ZwC82Rwr8RzTJ0mTlhxM72SXGjcQsFagzIqD3xxTLyNdB1eCQOVRg1O5h
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|6040799012|36102599003|5062599005|8060799009|461199028|15080799009|19110799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WTdWcWcxR0hQc0NmbUs0aDBjZ21nYVZsWnBOK0FjL2RDRVZNZXlDaVUx?=
 =?iso-2022-jp?B?NWczdDV4OHhiYm5tV3NpNjkrT21Cblg2NENXMzNvNDFPUURZR1FYVXJy?=
 =?iso-2022-jp?B?bTBIaFZUem5CTDZqSVRzUXZCbG9iS2xRRjJyOVh2THlMeGhkcFk3NUI0?=
 =?iso-2022-jp?B?UTJIdmYxRmVLQlJoYnVhOXNFSDhNWWZqcHhLR0ZVT2RTdTJzWmlUZ1FS?=
 =?iso-2022-jp?B?TXZvNUdWNmdHRVA5Q0I1b2RjT3hueENFZ205NHhSSnNCOWlOVWRuak93?=
 =?iso-2022-jp?B?QUsxVlV2dDFYcEhDRWtPZkdBQ3dRbWZUUTJGdVoza3I5UUgrczN0cWt5?=
 =?iso-2022-jp?B?TVBjMEh0TkE3cTRWbFhqeWpOY045aWcra2xqUHFraTNaTWx4dWR6ZVZI?=
 =?iso-2022-jp?B?Y096K2tyRWVWOUxXdkJDd2JCaldTY284Ri90M2hOTnF2c2puT3A5TFhu?=
 =?iso-2022-jp?B?UllEUFhaQ2RkemVUNlVoeXUxZFZuNTFHQWNHRThqYU1PWkRxMzhsSFNK?=
 =?iso-2022-jp?B?QitBcXVYSmtyVzNsblNEN2lWU2EybG12WXVBWVgwbXdiTG5vUG5pSzF1?=
 =?iso-2022-jp?B?cjNvbjNhdkNmcTNSSW1UUFhwNktiME90UW5wTUZCWHJHWER2dE9WQTMz?=
 =?iso-2022-jp?B?c29aSm1adVpGcnZHNjFVR25HTnRjS284SnZFOSs5TU02cVdsWThaQkUy?=
 =?iso-2022-jp?B?SitvaFJZSzFhTnJ0QVA0RVZmK0xGSVNkNWZkcktmUjVEb2FHTHUyb25F?=
 =?iso-2022-jp?B?U2hmajZPczV0RldES210RFZDZGdrZTJTNjNtd3Q4NElHNTUvRFg5SkIw?=
 =?iso-2022-jp?B?RDJLcmpvR3lkTnB0aTdwU0J6N1QyeWNZVlA5M0V4NUJQVUdTaGVJbXox?=
 =?iso-2022-jp?B?cHp4KzdYSFJvSGRaWHlpZlIvNjlYTkVGWUxRVDlkYWZQYjkwZXFMcFJW?=
 =?iso-2022-jp?B?d3FjWU4vYnpHSCtXcFp0TUI2WEMrTFZ1UkdUZnlidkladWk3ZXRNbzcw?=
 =?iso-2022-jp?B?cWpkZ2xxR2hpRG1GS2E5SmpDR0RKRFdNVS9IMHE2RU1zWHhyTlN4REg3?=
 =?iso-2022-jp?B?a09LRlRTT04yQXdQeSt0dTgrNjRsUmMyZWMvWVA3Q1RWbjArZlZ5eVF3?=
 =?iso-2022-jp?B?cHQxZW5uNFI5WUF2bGF3bDZUZ1UxeXdjbDg4TlByQTkxY2kwVEIrelZn?=
 =?iso-2022-jp?B?bEdIRzVUVW91RFA4UmwrekFnSG00NnAzd2FIZXN3bWxFVWdJNmNUMms5?=
 =?iso-2022-jp?B?M2Rra3dSTUdMTTBUYkdwZkYxOGxxalJBWUJUaUgyMTNaQ2pXcEJTOEU0?=
 =?iso-2022-jp?B?WmNlald6bi90K05DRk1HNExiODdlOHlpUkRZd2pQbzJOOEVub2ZZQkZp?=
 =?iso-2022-jp?B?L3JsNXluUnBDRy9SSk9tbHR1YUpyU1ZsdTZzcUgvOUVLU2hlWnF6Nk1u?=
 =?iso-2022-jp?B?NElkd2owWlQ2d05wa3RsMjY4Z1RwL2hmc2pDMmVnRzRjV3BBUWNqaXdt?=
 =?iso-2022-jp?B?d3loTEM5aFQ0RUpIMkZmV1FiK3JMcEFoZXhGWEE2TWJXaGlvSzlvYjJT?=
 =?iso-2022-jp?B?aUtVakkyeHVnek9QZFU0QjNoWGZ1Q1Vhdk14YzViUTkwUDBFZzNKUXh2?=
 =?iso-2022-jp?B?VkFzNzJjdjNSNkJtSmpTNFRqRlRiV2xmcEhERDIrSkluOE82UEVvdVRk?=
 =?iso-2022-jp?B?WGM0U291a3RlbHlGOE0zRWMxdz0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?N2FzanU2S3RpeEpKQTJMZDU2S0ZSaWdsMVFBN1pJOWUzOE1TMExtdXZB?=
 =?iso-2022-jp?B?Q2Q5VVdSRExrR3JhUy80YUJzZ0ZrWFdJVHFseWpuUEUxc05rZDE1STB4?=
 =?iso-2022-jp?B?VzRkZHlFbE1MNExlRXFsQ0s5OFI4Q0dYN3ZrUUdORzJmUHFDMEpOMzBI?=
 =?iso-2022-jp?B?cENMbk9ZS2l2UkovWGRUTWxQc1JuZVRtRXIrNHJEQjVKRWZERktNNlgw?=
 =?iso-2022-jp?B?bWhqaVJCVmNiOXB0V0R0cDlEQkUrU2lhN1NtTjZBQXA2MXZYRS9UelBT?=
 =?iso-2022-jp?B?UWhMUElOSlM5RE52WkF2WkVuY0JhNlJQNUx5a2drM2Q1ejlhVDNDZTZ5?=
 =?iso-2022-jp?B?L2lPN2N3bkhRaExneFlBckFHaldEL280dE5tSVFJeHdqN1lGTm90QnB5?=
 =?iso-2022-jp?B?MXZTTE5LQTRVb2VaNnFYaTEybDRBU3ByajE4Y3EyNVIzOTVkeFBJQVMv?=
 =?iso-2022-jp?B?VUg4cnRNSThaMGtGTmpQcmFJVmZOb3U5b1lSUFZNSVREdXlITCtSTk82?=
 =?iso-2022-jp?B?bEFTQzlNQUZxMGxuQ0o4ajZWNXBZenNnVm5jOWFLUVA5b2s2R2hucGRl?=
 =?iso-2022-jp?B?YmFyZmNUYlZkVHEyYURJdStqTy94aitJa3RDd2w1WHdZc3RwSFhOeUdP?=
 =?iso-2022-jp?B?ek1mM2k2NnI1Y1RIUzFib3JlTnRtdythbUwvTFVzWFdJbjFMcTFsaWdE?=
 =?iso-2022-jp?B?ZHFkckJWUHhXVVNaazRpY004aHNzVG1HZ1N2c21SVXczMHR0SWc3RVZB?=
 =?iso-2022-jp?B?Uk1kRWJOaEZGVk1tTysvUTI0T0tSQnlPR1hMMWxOQWNJNjNFbE5Odk82?=
 =?iso-2022-jp?B?OGRJdGMrUmhLTHhrcFlsZW9OZDdIclhJOGZUelBBQ0J2K01MK1FQVWU0?=
 =?iso-2022-jp?B?TGNNMVg2WkZKbHVRc2NSMWtoZDNKQUEvNmtKY2dad2lyK3JMUkFQZHVz?=
 =?iso-2022-jp?B?QUF2cklPaHpGZVZCSXVQZ0JpSnpXWHN5WXNRWlBNZFhXU2lrQXN0eDBR?=
 =?iso-2022-jp?B?QWU3S1JaNGRHT25yOTE2ODB4WDlONkhxQW5DZGVocTF0T1ZyTUlqVEw0?=
 =?iso-2022-jp?B?bDhValZJOFZPN0tlQkVaQU84NlBobkJHMTZ5Rmg4OE84eUZheVZPT1Yz?=
 =?iso-2022-jp?B?YzJpK2dQWU80ZU1rSnBDQS9kS3cweGZVaVlnY1o3T3hhL0dETFpPbUdR?=
 =?iso-2022-jp?B?RU1LSzdpZXpJdENCdWZYdW9aQjJtanVlWU5iRDZKZVMvWWpFZE9XcTlw?=
 =?iso-2022-jp?B?U3o5Zm4yZmpOWkpYUjBMYjlJdEZFWkc3bTJTR2YwRy9LZ2dTZGp3eFRk?=
 =?iso-2022-jp?B?Tk1ieFhkdU5NQ09tZDVIM2NwM3AwdDNiei9HMTFzQnpKZ1RRY3VLQUQr?=
 =?iso-2022-jp?B?SHNOQmQ0Y3hZTG9JMEszVzdHbXZQMDYzVUR3Z2VtZDZwbGFuT1JIZS90?=
 =?iso-2022-jp?B?U3ZKMVl1TGN1MUxYdlRsOWFkTzJ1bVpTM0wwUktLSzVlN01mTVlITmtu?=
 =?iso-2022-jp?B?N21pZ2NvbXYwN1d5Ymh6RmU2K2NadWNKUGtpc0ZvdERaTTVHS1NqNkN6?=
 =?iso-2022-jp?B?SXF6dm1XK0tMUGNTK21VdkZlSHNsWjNLQWt1RnJDR1hvQm1ZYk1TVkFk?=
 =?iso-2022-jp?B?Z3NPaXhPazRLazFLM3hKemZnUmhPSlg4M2JvMi9QQSs5Tzd2KzlCZ1JY?=
 =?iso-2022-jp?B?bkNPc1BCOEFPK2U0cHpPWFF4ZjU2RDAxNndjSUI4YlBJUWFrV29hOVM1?=
 =?iso-2022-jp?B?WUVjWk1mQ2szSUNBdDRDL01xNlQ2d21ncEJJOXMxdzcvWGRBNExSMWc9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-dba83.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f33198-b0ac-496e-656f-08dda0594351
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2025 15:38:52.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8108

Hello linux-wireless@vger.kernel.org=20
How Are You =1B$B!g=1B(B=20


