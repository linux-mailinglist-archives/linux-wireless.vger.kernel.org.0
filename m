Return-Path: <linux-wireless+bounces-33798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P2LHvpMw2nkpwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:48:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8DA31ED62
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82A68302824C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 02:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B9F283CBF;
	Wed, 25 Mar 2026 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ZwVcqgS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023107.outbound.protection.outlook.com [40.107.44.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF579CD;
	Wed, 25 Mar 2026 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406900; cv=fail; b=Nv6C1lBHCSfJTWU7MquNhhPw/plgvAizKO5SLzV2LadVlZ3GMtMYklfvC9vM/ZmZfhqiYMfEn8A+Pa9ujAmn2DUmzS9xR+WPIrAMPS/wxysap587JThDLd0o7TTzuWCUVXoTubYhI9fqgETork6HWRMwyGnszMVWZnkwfFgwTxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406900; c=relaxed/simple;
	bh=TLM8O9tPM9IrPdSrxqyo0SeoDYbQSzVUURaa+5Uey0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbBcVlkEk5VRPYWHWRt1SC9HC7/GkxoHVCsrV6m1q5gfGNyUGhONY6bvqu7VUVX/hBjUc61a6WJcDyXEVQvVA7neg0HpRffCqhbP+/wAE7S46s++kcw+dzIPwuZ5ad7v9tD22uUm1U96kiSUIzDZSIKUFrqSyGbFPhQzI2s9TzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ZwVcqgS6; arc=fail smtp.client-ip=40.107.44.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/hCMHl2CfqOQNBCUlbbZShah/dwRycdqP/ny3mEmimy/QRmj7CPv0oydoPchSwDRC1M93FSdi15LzjwJhHay04nw564U35g11nNDlE0SaEsqFH20b0cTfneMFDvBTgbs1v0Qhx2pW2B9rGVVNJd/ej6LDCUqmRjtm02D5CpVgE7dmiwie62XFLNUQVEmmUCcbP9mP/fURy4mX9HFcDTvNpkKH+AHr5GwXdRC8V/ynw42BIkQuroeMxdqVAqRpyqnBEg9ntdtN89DWghtJ/7BlZYfz/Zx4n7FjEUybUyP7W9+UkReo6YeFY1wiVAaLGbKdHe0B3sdo0OmLfYFFSRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq0T1S+FFsvnKXCCuV+pWKYzVePyuEfmjErJokPG8zg=;
 b=JauN2LMiL/V918lUqpdeUjK7+zdUx+QlZ9N+gLAdJ/Zs9yt+1JXhItrhPmBIN9kIfs2yhe9h3lBEf5iVA+2SzMth039zrCNvpDLFdgdGveatd837TQRc3C3pXFCXFFscazL4xvEzRlcfWbvaq37X6y9BphvdjYCSrvdnVMR2B9uJZuRTzAr8rV20kmoLydcjB99qsGZOvB9900BinghPUz0CpsAnZp14+obusGM8ShjSmFHSR6FqLXtNq3wkVnxb4Xaq6zDvirR3GjB+o7R2d59jsp50sJ7wOwyXtbraajZwMJTKCONODGpJfT8PBXnQEMDXChRmQSynLcr5BwGSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq0T1S+FFsvnKXCCuV+pWKYzVePyuEfmjErJokPG8zg=;
 b=ZwVcqgS63KM1rhOpf9kBGQBcN/LUCe3fga8b4H4wgVv9TxJzOyzXhHHtIyayP8DJB+7FZ7YbjMlt/vDYL8OE9WNmLQPsRSfGJ78jdirtUijvr2NHclvnGZ67ogbiWt4OWAp1PhzfdaI26WJbMXgv5CQ3d91x4i58ZtTlBYLOls5+IjBKoKkkLltz+j1DVVUQTzYFvIoRuVIkjDzZBwBh1+VgQB44q/32Kfj4pVxCV/wzwfs6P57yCUkxYrcesMrUThtLzXLqNsynvLPYoqbov1pHbT8GkHPKOj677THVl/dUexXI1G1k9g3qjcoRmIXnYQrekDTO0RorskWgyu8h5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI3PR03MB10032.apcprd03.prod.outlook.com (2603:1096:4:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 02:48:16 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 02:48:16 +0000
Message-ID: <316efeff-477d-4d8d-9c60-ac7c4e5b9b33@amlogic.com>
Date: Wed, 25 Mar 2026 10:48:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and
 SDIO pinctrl nodes
Content-Language: en-US
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr>
 <20260323-add-emmc-t7-vim4-v3-1-5159d90a984c@aliel.fr>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260323-add-emmc-t7-vim4-v3-1-5159d90a984c@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI3PR03MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: e19a0ca5-4462-4d2c-b356-08de8a18f6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Yk41VjJkCHmZKOTydfCgWYZ2HgIMGYPV7y0GelV/HJ37kcDFaW8w2gc/9KpNL2v0/K9Vy/MIeDVN68CHU8ilHjpSXEdx56h0t28Y73NFwQqU8/7tZHz+MEoa5Q/doggP3FozIsjnCXo5ucxFkrRdWp5aFRFuGH3ZF0V40jtDPBs3vFYrNahyHzU8IKXOHuLo48eyavtw2MjIBJzeYyOl4MkP+mzJDKpCkggx9i99tbOesw0Ylvev9uwyF7tzZ1TGE+A3OLnYZm07rKfRsFEwSP7YHv4VsZhLZbKVsIPQyIalvYyKZQqD5fmZX6WgiYHZP8aUuk50HRZONFsJ4wAAQPjrjGHM+4F6wnhgqnEzzGKTakOh9hgZh9ZAezgDiyxlU2rgXHb0CD0VBea8QwaUTmMMLZgGkCiiX69vmE8cwVCJ+N0ccyk7gsUyBNIpeFB5lbuDwZPPn5WUGE2Kb/jmlU/MQW6TyR26HeKQaw2jA0qY0OlPHyG8rU1zqLWJoz9FJDt0dNlLAo6boQz25xAz/PSebQ7qRLPwjU8hRCXd5HCziAdZkesANb7ITwL3H3/7wXuxbM0ZcrHp3YWmKwse745oAm1K6PSE74jnJyXr/5vVxRunjxIhVvX8I8oJE5AJ9VCEAi7ZwxBrIl+9F/qfkhmGPOwSyzmYMZMiNaaf72vVQEE355MC3vGNUQ1cbW1YQzXWyKOvboJtbDFmXH/6WHYXB7NUL2bCOwjlIWmewjqpVhoEMDO+UhwrYYVVMpiosnFS2CHo3JSU1AAg6AgJIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEl2ako5bi9CMEFUZ21nVVJPSDA5NGh0MHNjaVhnRG5LaUlCazZUUnZBbE9F?=
 =?utf-8?B?USs2Qms2RGFiZEdSdlRBSldpSDV3aHExOUVIc3BacTlXeklESW03MEhyVkFt?=
 =?utf-8?B?azk2QUhyVU4rY2NDcmMrY0M0aGFNeWZpejdDQmJOSmFIcUk4OGE5OTNreVpx?=
 =?utf-8?B?WTZIMCtrMWdGNmJ4Y3Y2WjJ4SkRRczZVU2xmTXRoRDlKVUZYbzhmL2krbi9h?=
 =?utf-8?B?VWF1Z0RzcjlCSmMvYXlscGkySWJjM0M4ZmU1UzZRc3V0TUUrUUVOOFEyN2xD?=
 =?utf-8?B?UVhVSEszcUFLMFNvaUtXdWNwa2hnL0lYZ1IyQjJOWUZrYlZzdXVmdkcwSmx5?=
 =?utf-8?B?T0tEUDFDTCtTTHQ2YUhVRDM4WUJocERhZ3JOVm9CRDZRUXpYaVdvMlFhajZQ?=
 =?utf-8?B?d05ZQk1HdFhuSCsyS3IrU2NiaFN5OGQ5OW1sV0dEcU5ub2hwbUVaUmZGUTJH?=
 =?utf-8?B?dmYxUE9VMUorUmFOYTRWUVgremhMNkxieUIrMnV2SXgwZW16MkxnSE91bGcy?=
 =?utf-8?B?VzRHQncyeElvRHJSQmZjNUlBSVQxa1Z1dDBlNEwyNllDd2pRUGwyejRER2ps?=
 =?utf-8?B?ZlkyWWd3R29nK1NicW9kdDNVdldXZWRkakFocG9YWG1HTC9Sd240YUphWURV?=
 =?utf-8?B?SzhFbFNjQlpQa0ROdnE0TFJ0eTg0cUw2Nmp4ZSt5R0FsS2FUTzRBZFNkWnBF?=
 =?utf-8?B?emdlRWRncHcrUS9lMHlGWmpzL3BTektob2U5SytXK3NocmVjQmQzZUg3Z3VJ?=
 =?utf-8?B?bmhHSFI0WnZiQkNKN3RsYlluY01Ob0VWN3I5SUg0ZmlYWU52UmpxS0diM2xX?=
 =?utf-8?B?clhCWHpDVlNTc2FiZjNMdTJOU2Q1QTJtbmFXa2ZwcE9saUFHa2doNDRJTExO?=
 =?utf-8?B?eC85S1RUOUpUcld2S1oxZDVVVXFGWnl2Q0ZIUktoeXNJd0t5U1VVajZacWpI?=
 =?utf-8?B?RGVHZkNjR3REQnZ5aDRSQ2xTTWdYMnR2dWNoYnJqRXhld24rWDdUWlk3UTIw?=
 =?utf-8?B?V3BSUEpDSEx2VGZiYW8vWmlWYk82bThaZlgwZFN2c3lGK0VNZVdSRDRmNEpZ?=
 =?utf-8?B?cGsrc2pXZWxGblhVNHhpaXBvekRlaWJiQ3hqVTF1cFR5OWlBTm41Z1FKOVFw?=
 =?utf-8?B?U0k5T1kvdmwzcEpDcWl2YXVvZ0hCZjlvZXI0cmFpTDRMVDZ4TWRXMEJVcDlQ?=
 =?utf-8?B?WVNTNUR0YWE5YkJER3Y2MkhEeEdOV1ZCaTlJNmVvUHV4YkVWN1I1QnBiSWh0?=
 =?utf-8?B?alkyNmhSdkFqdkwxYnpEc2YwTjdQS2c1RXg2T1NpZFNSU2FJVUhidjhHMWsr?=
 =?utf-8?B?NjU3MStFcW93ZW1kbmxoYm1hTWZGd2oxbXVOYzgvTUhJcUJCbjArTnVReUx3?=
 =?utf-8?B?M291RFZCbHRMR3hsazEvZWt5RXdpcmNDZkhDWTFhS2xiTG4xMk5udTlWVnZ2?=
 =?utf-8?B?b253SlBaSkt5UEY1TGR0VHVIRHRqUCt3V0toNHViZEl5K0RDSHNvUytQUS9V?=
 =?utf-8?B?MXVTenZNSDVudk5udXp0UDZJekg4YllqRG5Wb1YwWkhrRzRtRjdURW9aeWtm?=
 =?utf-8?B?bHFZN3NIKzBGdjBJTVYzREJqSnJITHBzekdlek9aV2RDWmJhK2MvTmprM2dw?=
 =?utf-8?B?ajZWWGE4Z2owWm5lZzhTalpFSGVoQ0FRSHV6bVcvZ0pRTjk4Wk5vd0dva285?=
 =?utf-8?B?YzB6QVdVRGZCa0JHdTdxaDFaWFhVVld5dkxuaUFubCtPdHdrRjcxVzczMjNw?=
 =?utf-8?B?TmljZHJlNUZ3SUh1MmNxUFdIRkkwUFlLUCs3SDMyLy8yamtHbHlXZElIWXdU?=
 =?utf-8?B?SDNXZGNNRzE0NU5ZT21XV29lU0hWRHJSNXdMM3BrWmdrTkhVUWZaa3hValNK?=
 =?utf-8?B?c1F2aFVvMDRsU3lyelZ1UFNZV1N6a2t5c3o4TC9oWEk2Z2dndTdYbFpJNGYx?=
 =?utf-8?B?dzdCSk5TdUUzSENvaFRRZ2liSStoWTIwaDhBdkpCK3ZTalB5MVJWSU92TXRv?=
 =?utf-8?B?Y1MrbzRpY0h0aitNaHFqRG9KZUxxV0I3TDJCdVhYYjkrZTN1K3B6bTgwc05m?=
 =?utf-8?B?TVZ0dTYzNmdLUUhFdU9CSkpIS2dCNzBReDdvUXcvTXc5bElzUngrTkVmVVl2?=
 =?utf-8?B?VGlXaTNGb3dWaU9EYVdCTjB6bjJTbFZrcG9SMHBXTDJ3cHVUOHg2SnYwUlZM?=
 =?utf-8?B?T3o4Nml0UUloNzI5dzNGY2puOHVZV1RROFgwYUp5ZHQxcm10Z25TVjF5VUtu?=
 =?utf-8?B?U2ZCK0NzVW1yWTMrcksyclRxZUpSZXVac1JiT3hrcEcxdlJXM1FDNmhISCt1?=
 =?utf-8?B?ZzRNZ2lPUjZVaFh1ZUtqZGFEak41azgxSjNWaUQvZVZCN01hUi9oUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19a0ca5-4462-4d2c-b356-08de8a18f6e7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:48:16.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcK6vDhMdaSUaPWn3Rw8+Zp/tAZX/QBqbtvg/z6gcv9VPtaTdBIFom9ObV2zuoAu3OZ7F0zhDTe1dzMfXDaGfd6+7JO0o0Lmf1hxXH47QM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR03MB10032
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33798-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[aliel.fr,linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aliel.fr:email,amlogic.com:dkim,amlogic.com:mid,0.0.15.240:email,0.0.15.160:email]
X-Rspamd-Queue-Id: 7A8DA31ED62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ronald,

On 2026/3/23 17:55, Ronald Claveau wrote:
> These pinctrl nodes are required by the eMMC, SD card and SDIO drivers
> to configure pin muxing at runtime.
> 
> - eMMC: control, 4-bit/8-bit data, data strobe and clock gate pins
> - SD card: data, clock, command and clock gate pins
> - SDIO: data, clock, command and clock gate pins
> 
> Signed-off-by: Ronald Claveau<linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 98 +++++++++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 6510068bcff92..ac8de8e9b8010 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -250,6 +250,104 @@ gpio: bank@4000 {
>                                          #gpio-cells = <2>;
>                                          gpio-ranges = <&periphs_pinctrl 0 0 157>;
>                                  };
> +
> +                               emmc_ctrl_pins: emmc-ctrl {
> +                                       mux-0 {
> +                                               groups = "emmc_cmd";
> +                                               function = "emmc";
> +                                               bias-pull-up;
> +                                       };
> +
> +                                       mux-1 {
> +                                               groups = "emmc_clk";
> +                                               function = "emmc";
> +                                               bias-disable;
> +                                       };
> +                               };
> +
> +                               emmc_data_4b_pins: emmc-data-4b {
> +                                       mux-0 {
> +                                               groups = "emmc_nand_d0",
> +                                                        "emmc_nand_d1",
> +                                                        "emmc_nand_d2",
> +                                                        "emmc_nand_d3";
> +                                               function = "emmc";
> +                                               bias-pull-up;
> +                                       };
> +                               };
> +
> +                               emmc_data_8b_pins: emmc-data-8b {
> +                                       mux-0 {
> +                                               groups = "emmc_nand_d0",
> +                                                        "emmc_nand_d1",
> +                                                        "emmc_nand_d2",
> +                                                        "emmc_nand_d3",
> +                                                        "emmc_nand_d4",
> +                                                        "emmc_nand_d5",
> +                                                        "emmc_nand_d6",
> +                                                        "emmc_nand_d7";
> +                                               function = "emmc";
> +                                               bias-pull-up;
> +                                       };
> +                               };
> +
> +                               emmc_ds_pins: emmc-ds {
> +                                       mux {
> +                                               groups = "emmc_nand_ds";
> +                                               function = "emmc";
> +                                               bias-pull-down;
> +                                       };
> +                               };
> +
> +                               emmc_clk_gate_pins: emmc_clk_gate {

Node names should use hyphens ('-') instead of underscores ('_'), 
consistent with the following nodes.

> +                                       mux {
> +                                               groups = "GPIOB_8";
> +                                               function = "gpio_periphs";
> +                                               bias-pull-down;
> +                                       };
> +                               };
> +
> +                               sdcard_pins: sdcard {
> +                                       mux {
> +                                               groups = "sdcard_d0",
> +                                                        "sdcard_d1",
> +                                                        "sdcard_d2",
> +                                                        "sdcard_d3",
> +                                                        "sdcard_clk",
> +                                                        "sdcard_cmd";
> +                                               function = "sdcard";
> +                                               bias-pull-up;
> +                                       };
> +                               };
> +
> +                               sdcard_clk_gate_pins: sdcard_clk_gate {
> +                                       mux {
> +                                               groups = "GPIOC_4";
> +                                               function = "gpio_periphs";
> +                                               bias-pull-down;
> +                                       };
> +                               };
> +
> +                               sdio_pins: sdio {
> +                                       mux-0 {
> +                                               groups = "sdio_d0",
> +                                                        "sdio_d1",
> +                                                        "sdio_d2",
> +                                                        "sdio_d3",
> +                                                        "sdio_clk",
> +                                                        "sdio_cmd";
> +                                               function = "sdio";
> +                                               bias-pull-up;
> +                                       };
> +                               };
> +
> +                               sdio_clk_gate_pins: sdio_clk_gate {
> +                                       mux {
> +                                               groups = "GPIOX_4";
> +                                               function = "gpio_periphs";
> +                                               bias-pull-up;
> +                                       };
> +                               };
>                          };
> 
>                          gpio_intc: interrupt-controller@4080 {

