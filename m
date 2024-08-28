Return-Path: <linux-wireless+bounces-12121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD68962185
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0421F21B19
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DA15C131;
	Wed, 28 Aug 2024 07:41:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB415B145;
	Wed, 28 Aug 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830882; cv=fail; b=YhSrBQi93TrxeM7UtpvlcZ9lfNic/yx7qacXtvrm6M/BVHFEpPVToywAY0fpwvkJeil1etpciZ18GcnDccLhD2lQFIP+ADi//83Um2np7lk6uzPuigKF1Hdl83zNSagPZ98symw7+prkbhxgjNGYqjjBd2MduWxfB+c02iNzT4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830882; c=relaxed/simple;
	bh=m4jywguzwzc9q75AMLYOPix+C0ZE5a5MGA4IZ7EIp5c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rv9RTGLFAL3fHvkJJTfTxq9wMFQXrmTFlVwLdbieaQjSVCfNK+hSlxdfLG8l6QLhOz2vx9IW8RJ6O4mgMd7ffAMP/ivPvuUykl7JAa5jocabLkZDcI+hzAoUzVIQDh4LmzLayOSEO57aW0QEhiINfSiI0nsjbytszgIKoaKICP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXHVlu50yjkv+4NMXu43HN6YB+43YVBKwbGVAj9kQ6KQeIyOpGoaWlpQn9Ld8z1IyqmYgDhUWobBjTLhIF7Lc2zITMTy7DIuQZ2vJcnMxvgCm+XNpvd2kIP7bq/9fLTggnCJwYP3icFPaebaWosXPZNen7nhbjRHMoYoJ/VdWApkqMs2mi1qruNmyDC8grTBtiYczD4+3dFvjhglVg1pWOd6PZjVpVVeiga2xV2EimB5q6eNHU+wJrKSZXyhjyq0mI1Bqs6qlIhHSeN5Ek4edcwKXJ6b6kpvSceWrhDWtaxNRoOrbHPx1pwpBDPYwAkdstEjVNq95sJpDFG+ld8NQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/E0WGgE6Ehzy8g7GiG6jEMXz/oYkQ2gd4cyn/tSzSs=;
 b=juS0ueujy30m0xKljiJYN90dJxFK+CQNNdFwFl6SFUxSvRT8/VtZ/kLpeUdH4EsE5nPFx7xiJPZNgQaQIdgkyPT9Y+KygtTGWm1xJDiQK1U+yCKg2vQo7VrrGsLRKzL/9OSR17QGHtYkj1C/6l4mrDq82cqAo/juCBmvBh8Hp6JMAuY1wSWcwb5pQjKDBtbKuXRAA9kKZ+JUx640ZgDfahdPvdi+3VATvCZtIdW+XmM6bUXL+qFlAIFymYmUeVIs0pCRHo62ePOGKcghxDXPaBtoyICEpShWHRwQ7UrarNwFp3nzwjTDMiASiKeFbT0dE+bBBQcXdgq+sud2cbFvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:41:15 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:41:15 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:40:49 +0800
Subject: [PATCH v12 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v12-2-9064ac7acf1d@wesion.com>
References: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724830868; l=1192;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=m4jywguzwzc9q75AMLYOPix+C0ZE5a5MGA4IZ7EIp5c=;
 b=JJCMj7TMPwWJc7h6//kSNWxC0PVjqpB2mJF2duXaI0e6zdcuRIa7i6QwWcgq8pdVJXzFXDao9
 cHgp33u1izADxx4cxct5ZPZVImj++6vg9luDIX3vL+dVqTzyns4t7jK
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8085a736-9125-4a88-d85c-08dcc734cba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1F6dlBiTklyMHJOdVVqUE9DNlo1akNwOUVwOGZlN0xTZWROeE9HOVdnVFU3?=
 =?utf-8?B?Ylh6UzJ1UHZ4em9xR3VLaU95alhxby9CTWRqQjhoaVR6YVU0alZiNXA0S04y?=
 =?utf-8?B?VHNqNmJCZEIwT3BpRzJON3E3WHZRUGR3TUxsaUJEQ2Z5T2lKZlhMUU4yNHpG?=
 =?utf-8?B?NFR0ckVZQkV2ak00TDJRT21PNHlOYlJQY0tXNUVIVzdlMTh2aXpJOS9jbzRY?=
 =?utf-8?B?VldIZVhIa2poUm9YY1Jwb3RxSGFPanBtUlIzSVY4VGpEMlRqVWs2WjJ4NEh3?=
 =?utf-8?B?NTc5UkxGZ2lSdUkzcHNqbjFxTmNBbUlTeGZZU1R6ZlRJK0t3dGUyYlZQY1Iw?=
 =?utf-8?B?QUUyYnY1dS9MbzlzSVJQZW1VUWF3M0pBdW44VjBMWXN6RXdTVnNQSnd4R3BZ?=
 =?utf-8?B?ZklLQXJOMkcxaWRTWjNuaDRZWmYwQVBVZW1uMlVscG9rOTIyK2JsM0VZYkNh?=
 =?utf-8?B?dWZrTGQ1MGRldUplV2pSMUZKZG4xTjJreUhOeURDb0xocnY1ZDJxK25OVS9s?=
 =?utf-8?B?RUNQMktGV0RYcjMwTWQ4UkxxYnlSMnFNNExET1d2anFRQXdlVmppVDdobXA5?=
 =?utf-8?B?Szd0d2dybEdiOGRsancxN1FOalpoVmVJZlVxbXViZDZxNXJ4djJqMzdCRU1O?=
 =?utf-8?B?SWJLbnBaMkNoUjhqV3g3Zi9LOHVxYndNcGx3bExzcXVqOGsxUHlnMy9ZMkkz?=
 =?utf-8?B?QmZndVozaXBwNEt1L0JNNklvZUloSnBqalJJTjUxZEVJMU5uZWgxWlJUZ25I?=
 =?utf-8?B?RVlHZVpIV1VoYVRjdjR6M0pZWmNoc1dSY1YzV091M1dlOFlBZFVWQ1pDMWR2?=
 =?utf-8?B?Z3BxZ0piazFjYXVrbThKcGl3aEk2RkVuRXUyYjk2bkEyeDBrQ0kvNkR5V1BF?=
 =?utf-8?B?RVp0dTZwcUthWEpGaDhmbW9EbXNMUDFnZzR1U09VY3p6S1E3STQyRUx5TDJi?=
 =?utf-8?B?bUlucWlMYXdvQmdCeVpQNjNnQ1BpY0RLOEY1R1M3anBoYnpyTkdWS3o3eGFr?=
 =?utf-8?B?cFBvZ1d3dnIvSWhDZmhhVUZic2t1R3g5d3V3VEtIWGlvSklqd0ZtUE5FN3NE?=
 =?utf-8?B?dFJyOStpREdxQ3lTS0dENDV6Y1d5MXRrd3Q0ODY2MnIxKzhZbCtwbGo4L2x5?=
 =?utf-8?B?KzhTVFZMeEdqZE96YzJHeXNWK21mQlEzb3JiemVjc1NtbFZNQjFSVlpZK0Z4?=
 =?utf-8?B?MkZyaWYwVnorbmN6S0NvNWp3NTYxSStxWHQ0WmI2eW9FeUYybWZna2lvWDJh?=
 =?utf-8?B?MkswdEdOaVBQenY5Kzlnc28zUWk5Y3JUV01SVWh4WERiZGlpOU9HTGdyRTNC?=
 =?utf-8?B?RE85ZVBSbEtkdk1pcjU2bHB0akJpd1d2eGN3RW9CajFtRE9LSUorTzFmUFkw?=
 =?utf-8?B?WFg5b015SU53TU80VEJhTmhhRm53Tk8zUWo0bU1EZ2NJZUdRK3JNbG1qRDhM?=
 =?utf-8?B?VHpDUzY0c2F3MTlGak1oTFBvWEYvWWN3aXJSMWd2ZTJKblE4THp6SXpVUHR1?=
 =?utf-8?B?RXA4eVRac2ZZMmJ4ZGxBenpvYnViZ1JzQ0hIVEhuUDgrQSswQm9wNXBZb3ZO?=
 =?utf-8?B?QllmeFNKL0JnYjh0R3dvYzBtNXhhRm10Z21mZ011aU11UUs1bVYvTW5zNmhv?=
 =?utf-8?B?UXVOOG02Ukh3UFBURlFyOHc3dXkxS20yZTlQU0R6SGxWN2gxSlJVVUhnVUNW?=
 =?utf-8?B?SEU3MTdZSlM3L2tmcEpva0d5aFUzRnJXUUxRd1Nac2w3enFydUNuZjFQU2JL?=
 =?utf-8?B?bUlVUW1DT0F6dHg3NitCV2MyU1dvRHkvK0NOSjAwSWwvcjVnVGRydXdiaUtl?=
 =?utf-8?B?anY4TzNNL3lxd1pzaEVnL2RPVElmNGUxcFFjdjMzWHdlcXVldmlORi9Yd2Ux?=
 =?utf-8?B?T29XWG5ZZmllUkFLdVltVFdaa3Z1TmhWVDJsWnkxZE1mOU05UUlUekdraGhu?=
 =?utf-8?Q?hd4TsCIACZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkYvaHFNZkFDUERoN09TSnk1aWk4akFuSjJ2VnhvUjNzdWpJeFIrSGVGd3hp?=
 =?utf-8?B?djhNVlFOcVd0Y2FraUdGNVBNVkdMYWFrd1IyZEhXaEpCOE1oYlNxakg1ZWdo?=
 =?utf-8?B?MlZVc09pYW5nbGIxdjRNVFpib1VCSi8zcE5vWFAvNXc2K2lhQUY4cFFYbkhl?=
 =?utf-8?B?TzRlaXBGRzA2TUFyL2dac0oyK3RzK3lWdmQ0Tks2L1VlQW93bmdJSVJ0TWU4?=
 =?utf-8?B?ZytRR3EyNmJEaHpMSmMyK1NTMFNOb3htRUhqQ2E1L2FhdUU1V3BmMWlGNWFW?=
 =?utf-8?B?aS9OQUd5TzE1ZWROVWZGWUdXY0dRTzVKRlpWVDdYUnA5Uk02ZjdLeitDUXdT?=
 =?utf-8?B?MHI5YjNCVithbHoxeHM5OVhWQTZJR2VyZW9tWGtreWdZbXNWVm02dlViWHds?=
 =?utf-8?B?NENOekVZYnhtNCtDcUZqcFZ5K3dDM2hraFo2cXZORWxxR1dWWEh6RDlXVno5?=
 =?utf-8?B?M2NyTWlVQWZDcG4zQXMxVW96bmNOdXpSVVNmUXQwZ2NyWEhmRnZDOURGNmVm?=
 =?utf-8?B?WXIvSU4yTjJPeTFpTFZqTmZIYW1hdDUvb0F5NC9takg4MHAwS2Npd2xyeG9s?=
 =?utf-8?B?alFxMU53OUhwNi9ZZ3lqUHIrdUI3V2prWjB5blhZSVhuTUsrdTRFdnlKbkdi?=
 =?utf-8?B?TEw5SnU3U3VoS3E0U015R3picnljZ0ozNDZWemN6RnFNbGhtKzNqMjRJNHR1?=
 =?utf-8?B?UW1sVXQ4TnZFclk3Tk0xZURTeXA2WktVN1dXaVlibEZmK3ZIWVd2RVdJamFW?=
 =?utf-8?B?ZCswMThDN2xTWWtncmkwSnlMdTZWR1l3bDJZT29HVzJDNVdEcFdwR0dLS3BR?=
 =?utf-8?B?ZzhlSXk3QTRNRG1XZGVJRDdyd3AzQ0pJNkVCeXhaK0tCMldTTWxybHNpUStS?=
 =?utf-8?B?M1hpMUQra2hCS0hJdDV3b0VZTUlnSUVNNDZHZWl2aTdiWlMwRWFlbU9HUGRR?=
 =?utf-8?B?SmNpZkFFMEZrOEEwdy9NVzlQd2dxb25wbm5zWVN4eFBHbE55V2xaWmtjRHlH?=
 =?utf-8?B?UXcxTlVkbkdEYXpZRVRuMDdISW9jb3NhWkNENXZ6cmJodzZkdXRTRDk3Und5?=
 =?utf-8?B?dnNQanlISnRLenhjYmpLTzhhaUFuclBxSnhRYmlFMmZjTndKVERNcmNBVDEx?=
 =?utf-8?B?ZnRCUEJMS2s3K05RRFBXM3M1Lzd2S1oycDljSkNHTzFrcHBxditGZWZtVVZY?=
 =?utf-8?B?RTVkVCtjVFVQLzBhZnovZmFxZ1h3QlFFaHF0UGdtbktTcE9SRnhGYkswd3RL?=
 =?utf-8?B?NEYvS0dVSlpzVlRDUmpWZllVcktNVjFPVFhBc2FTYzlXcUtYTlRCMHhjSGdG?=
 =?utf-8?B?NGF3YnNSdjRRMDFVKzRQK1cxSHdEVGUvYnI2T1VBRlVNSmlCNHB0V3FHZWEw?=
 =?utf-8?B?Y1BYbHFtMVJIRDhFMjJlR2MrbWJFdWIyc3BaNGVocThRN3JONGlLSmlPZnVp?=
 =?utf-8?B?QXhnT0VtMlJnQ1ZqTDZCNzE0WnRCVTd3VnlMSFBsSmFMSVFnMXdMVVhzVHJL?=
 =?utf-8?B?VzU5YUdKOE9pTzRTRVF2Wm1VdEhGcVU1enRtQ3NoTkE4YithOVZYMTk1N00z?=
 =?utf-8?B?Mk53TXZUYkphNXBieWtENnM3aE9vZFBPdElVdkl1UTRteEc4VEJSUnVGSVNl?=
 =?utf-8?B?Qm5HdGxhYUFCVTM1S0VRYWdNRzc5OGdhTG1rRXNEa3FyN0pXYmo2RjJEbXZD?=
 =?utf-8?B?Q01NMU50UzM0cHkra0MzTGVBOE9PQVN3cnZxZGVQK1NleTRVVFA4VU9ZbHg1?=
 =?utf-8?B?SFRDcXA2TjNzUTZCMFRHV2FPU3ZncTVKeWVQZDhLTTRuYS9qT2hleFRwdnUx?=
 =?utf-8?B?YUZpQ2g0U2dUTFZSVUdYMVNiV0VZWmprYWd2TlRKbDlIL2hiTGhwVDJTdi9J?=
 =?utf-8?B?ZWxOOEFISTFsOFJFOU1jQ0E2c2U1ekROUXdYRHJiRmFMRys0SjE5dmFGanE3?=
 =?utf-8?B?NHBjN1Z3MExLK1J2VFk4cWY4TXpjT0E5UjB3UnNRTmlSY1Zhd0xyZ2ZLLzNs?=
 =?utf-8?B?YlBpZ2xzWVBoWWpJMkdjYTJIN3ZNOHFYR3BFd0xBckhkYUlNbFQ4S0w0YzJm?=
 =?utf-8?B?RXdjU1VnbWZXTWhsOVdDa3JScW4ySUVNblhMaDZVd3hyVWFYNjVuendUMzF3?=
 =?utf-8?B?UFdSM2Q2cXA2a0NQaTU4NGxtcFpFUnhHMkJkM0ZCZDc1WDYvTzU3SzBYTURF?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8085a736-9125-4a88-d85c-08dcc734cba7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:41:14.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFkv7GIof4Yj6MWnSAqQuzWhvXXGdxcd/UFHevlnBqEdTOOLc+pnVlw1CBDqEQ+9+qfiZGYPisfYuQ1k7wHd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg

-- 
2.34.1


