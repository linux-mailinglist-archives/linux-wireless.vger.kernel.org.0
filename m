Return-Path: <linux-wireless+bounces-38169-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yGrJLathPmq9EwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38169-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:25:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 408096CC679
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:25:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=goPDdob7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38169-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38169-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD9430EA3FC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F3C3F1AC9;
	Fri, 26 Jun 2026 11:20:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011072.outbound.protection.outlook.com [52.103.23.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D313BAD91;
	Fri, 26 Jun 2026 11:20:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472847; cv=fail; b=G+vXro+F06JZnOXCRENNDuNRiezYSHQXyTL0zUWS/epaMEyOZ7+B2FwffzilqN1JTiME0RPAu+J62xVHPN/0GxTCKZX6QCu1GUrF6Yrsfi943Fb+5wlvAzEKKbFiwVsKFiy2uS8OLdghXB9KRSJoXQLbMfSMlY1yiPRNaZABl4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472847; c=relaxed/simple;
	bh=3XDNvTA6jaTkdXeGqgRB7nn+fWE0p7zbCmZkOnI4bOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ry7jb199iGs+qgRoVDStTvd/DLE0un2suj3RI9AW4zO0eA9Ux/495ZAGIWQxPEkiZsnzrbsxHx5OxuceYFoTj1/5XH3TJbHC+whq9O72R/kDTOON7zDJy1iEpSMe9RNc/mu2XP5gHq4+oRYGKsVfhyQpWwz8C4O69bnjLcx8SDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=goPDdob7; arc=fail smtp.client-ip=52.103.23.72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL7AI0pHQxgyawTewdqnk90t2Adpyl+7olUOVDJT0kNgEcwYkpbSIc2nBon+ztvbNXLoL/ZWSOXLN+344wUdGIMOtVHkiU3rv/ddMUs3kwfzYXCtwHSJY60py3XVjMkhO1hDT+vPMJ/wWD8nqqPZd/9V6nFUcOcqxP/TOTegbpjnEa0jv0vCa8Ek8bfNk7HOTOG0r/zShyq4W+nMVeBFOoFdHIc3KU34Lk6N+dPFXzDSc7aqOiJRSt3h93BtffFM1Oe9YXu/pgl0+xYWC4kf49cX51FBkhA+pOWhjRFEX5eG0DbKtw9Dfq/PwaaGTw4iQ/QevLY0dmoo8X+287mTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VsPRqy8e3ITxHc3bxGhN5Bt0qPn5IuL0VL5DkcvHvM=;
 b=PzfGtpLtLJT1rTH7gSmfPBjtDYqxC/8XNlj897+Aox6ir+nt4bw9bLIO7GRUdSKnrjBzwpETgE2CzLRdwxsr5fpR11Q6TeP1KpFaD22vYbP659JKCSnfqGgBU3CXQVHPYPKATyGgmITweccBEPT5uFU/DQZl2+iU27ZT8QEoBmkpo7V0YM1w0Cet1Y1yyduE99XXfr57MJ657MbmAYZWKE5pVGpVOf3bfBkpNW+X1EvUEN3KT6cXV7S1sHd2rpGt2iVH81vnzNIEu/Iu89JVpSaWPEWLpPCFL5owaUb5tt2VmOm9kavbjrtVyGXYkBlxuqDC+B03V8z/lTOaJ2B48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VsPRqy8e3ITxHc3bxGhN5Bt0qPn5IuL0VL5DkcvHvM=;
 b=goPDdob71RPebVxReeqiHYXVsNrGY/pSIgOJmGHPvu+kVUtpb/QPYAr0ENXJLcrtdRXdNn49ouM6AuqvmkZiOB2GqINcTWW7wV0PEVWH89pM+uQdjy2zqQxlOvSnrFXZk9tTYzyUaO3erDgGRPM6Yv8t+mRxNdmKAOe9ILb5wvaxG1ZK3VPx+25QerQO0YnbU/zAx3q5+rmoBdwH28dWalz38iYZ8L+KS7XDjpbnDJEvmAY/8SweDEJBqATeRqhRWywz2kUBrFNBStHlkCTqvReIIuQic9bbdlpf1oH9kScDArtuJobiQY6ALXCKydCQXUSmMXR6KZZb3SC9PHnxLg==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by PH3PPF7D22BCFD4.namprd19.prod.outlook.com (2603:10b6:518:1::c35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:20:42 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 11:20:42 +0000
Message-ID:
 <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Fri, 26 Jun 2026 15:20:29 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
 <20260626-discerning-light-swan-6b599c@quoll>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20260626-discerning-light-swan-6b599c@quoll>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MR2P264CA0185.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::24)
 To SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <c3754c5d-7347-4e39-84f3-de87c914d907@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|PH3PPF7D22BCFD4:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9091a4-030d-48f4-64f0-08ded374f531
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYAYx1xXrBLUWTP0Nof2HmseH0pRapauukvwEgwlZOaQysSN2NyZdM9L9hdQhfgZJHVFamoLFiHno86gFVM3/grQanBdVKTe6h9M+pK7VKNtnqFHFlBxIaBRPWE3EcZ0qbTMR42QSbtFbZQmIRHy4qo/1br2PPG1Hsk1XaCry9dyWmV/GZ4NSuQlHVNoLZAdo0mkIsCX3rIuZPav50rxEw1oCUAxfDvOe2l5mp8PqIUlrkXKu/kEWfMDoOk0imgftkwl/+X6PIHjvoX0S+Ve1uwPN5ZPORiLRuMsL2g7nS3EB9QQb4nxppKRAADxeRHSd/EOl8+j9sozi4Y2OkIh7hqnxyNrdppPJj8ziI0xkqmk4ku5tR7PR1WodiGk9WgXX7qyBaElSSC2bfxtL4hosNL7TDrCCNAvQMk+ekodTo6qpoKca/LMPuZCa/2x7aU3HXZ30/rgsF8b//eo5hjTmGeEVIsYcEVcIK5KUOwAG/v/YhucktGTwh5raKf1xTgsOlKVsRogmCQa1SqQ1Q0T4F8Igz4FmRA8cG8ZmqxpVGVF4doh7e7cxm7jSSjCSgOtTxE1GkyvjE5aA1A6eCDNF53JLKGewAPoVFXKJ1h2JCicDGUvHprY9ZUzaG6YEH7M5Vi1dS9YokDDshoAETeCszIjS3xRS9Ke54SgYDWtLcmEyO5ydkzA63rN37GLbCM40hrg7g7PAPTPZJGxliUhygBXq4rkEF8MESthvh+PACpk3yOozFftFmqqrTjlE2RGuMQ0qAwEYYAKmRsujAbGGhpHmr73gYVj8MfOFmXSOJeyxV43H718fAUy4gV0dD28yxwt+8g8M8zZaQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|51005399006|6090799003|37011999003|5072599009|24021099003|41001999006|25010399006|8060799015|19110799012|10035399007|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEFMV0NsTkVXT1NaTFhYcGg2bXA2bm1wdkdPZElHZW9kcU5LKzFvcXpldGVt?=
 =?utf-8?B?LysyczdWMlBkRmdCMDNGNjBMZHM5WEhIUlV2eG1kZHcwY3RjbzZYcDd0K3FC?=
 =?utf-8?B?MUs4SDc1U0dGajUxODBFL2JxZFF0a1BFTVUzditzcjQ4a0sxNXlWaVEwNXlX?=
 =?utf-8?B?ZHNhK0lWRGRjdVgzKzlQU1BUNDg3Wlg1aUZqZXB6Z1NUZzZ1Z2piaE05bnlW?=
 =?utf-8?B?QUVaU0xxd3hIanZrb2RnN25wUlM4WUxyQThnRkZURVdJcWowNkhQVDJLc1Jh?=
 =?utf-8?B?OVVCQ2VHK3huOWlKT2lIRm9KTG0xYm5EVXhjUXRYMW9XUXNjaXVmVkQ0TGFp?=
 =?utf-8?B?Q0hYOWN4STBiVmc2WWV1TzIyUysvaFg0eXZ6eEVoeXJLK3ZlMFgzVzBZcmV2?=
 =?utf-8?B?R3QvOHY5dGQraXF0TVlpb2FPN3Z6OERnSHBPaTVkY3dENlVjRlZSd040YmRn?=
 =?utf-8?B?eE85RWpra1RFdTQ3MjM5QS8vRlpCN0xvbHpHclloRUV2amsrdzR2TU01ZkdT?=
 =?utf-8?B?aExaZ3A2NTlKNVoyd3NaalZjT21yNitPQ2RVemd4S0RIZjZvVkd6STFDYjdw?=
 =?utf-8?B?cXkwRk16emhyc1pvY2h0aE44WEl3WG9NUTJrd1ZGNmhEVzVPRFAyR2FUNnRq?=
 =?utf-8?B?cGtEdkZrNWhrK2h0M3dxb0NnbGNMNGdSVXd5SDZCdWd5c1BwY3Z4aGs2aXNZ?=
 =?utf-8?B?Wm1LY2dhcjBPU0E3cUp2MHpHaUN4STlLclRkeWJpMGlVbHVBOEVjckJhdEds?=
 =?utf-8?B?czlaQUw0cU5FMXlIYWpCS3B3VW5maXd6T0t1VFNmSzVvUFpNQTQrWXZuV0h2?=
 =?utf-8?B?QWlBNzhSYWltZzRkWWtJZnhkdGNjUnU2SHozU1ZGS1pnNndoZmdwR2hsWncr?=
 =?utf-8?B?MFRsdWRRZk5WT3JFSW9rdnc4dEJmVkpJaDJBUWltamVaUkhMQnZwQVlKMzd4?=
 =?utf-8?B?Q0w3YVFSd2tVSXdYR1NCMHhsd2NTbnArVFNrMldRdzhNbzBUdHBpeDJaM0R4?=
 =?utf-8?B?SjBNeHRyb0JOeTRjNVBselREeGtYTHIzR0M2TG1lMU02dlc0ZklXSXBMYjMz?=
 =?utf-8?B?Z2hUZHByZDJUSWFPTWpmalRSeXlvYjF2dGhFOWJYQ1FSRHE2ZTdKOGMxSnQy?=
 =?utf-8?B?R0pzZGxVK3dGS3Z4SGhVYU9sTEtlRHU2VWJUdTlXa2o4NFY5NkNUVHY2UVBh?=
 =?utf-8?B?dVFERFYyQ3RmV3ZwYkdYQ2NpK085bGNyZlQyWDNTR09vOVV1WUNWc0J4NlF1?=
 =?utf-8?B?ZFpOaG1OM2IxRzQxM0ZsZmFiQmZodzdNL2wwOEFpTXNxTGlEbGM2QWNpelNB?=
 =?utf-8?Q?mOoKHlS+Uf7o82qnQ5c3d/xVtRSL3kxYnf?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkg1MldJT3Y1eGVPTy9yWHpKeGI4MGZUTDZsVk1FbkN4cnN0TzhjT2p6TjNN?=
 =?utf-8?B?SlR0OFpJNFp0OVQ0aVk5RHBNQkQxRUUwTUIxVHZwMUQxbUxkVTlPWWd5ZHBJ?=
 =?utf-8?B?OFhUY3hUVDl5QWZiYkhJM1l5Y0QxSmFDN0RsTjBmdWJtazd1QVRIeDNrY05U?=
 =?utf-8?B?aElaR3Z6Tmg3Smp3RVBGaTlTWXdsT3Y1OVZoV2tVWGIvSXdJMU5VQ2ViSGYw?=
 =?utf-8?B?TDMyQjBqMFZkS2h0L3ZiV05JWVhBT1dkdHdSMWlJVE9jMnJkejZDT091SVBt?=
 =?utf-8?B?K1loQ0pZSWh3QXZDSkQwd0gzd2dYM0tFbzBmMFNMU3J3ak55ZjE3S1psODlx?=
 =?utf-8?B?MkoxcEN0SFNaYjBxcG81bERhWTdrUUlERHl5aEtYSXlHdUh5L3Q3SEJQd0pz?=
 =?utf-8?B?L1pLemUxM1RqTzJIUzU5RGtHWERaQzRvSkVvVFpXOW5YSzU0MEFiTFRnSWMw?=
 =?utf-8?B?K3VMSUEyd0pSMXhzQlFZakpnYS9aU29rWnFRcDg1em9hcmNtNktKYTRyWWV5?=
 =?utf-8?B?ODNRR2RIa080c3dGVDQwSnhyQzNDaHZOQVlmVTRrUVE3UWwzbkFGVlZEVktk?=
 =?utf-8?B?SzdoWVdMYXkxUUZDQVIyemdOVERMcU5jeEVsSkNWVjBXRG5YWEZNT3hMT3ZS?=
 =?utf-8?B?OFZyamN4a3FQSis5U2ViVE1uK041N3k4K2xzRlJxT084cnFnOVhtTUgwSVhK?=
 =?utf-8?B?Y1VLVTZNWEpLRmZyWjAzU1dXMUhGU1V0RUZOdUdtS0g0OFY4YTQ2QTJNaUdT?=
 =?utf-8?B?b2FiLzNScWs2UktkbGRxUnF4ZENUVWREREdLa3RnTzNrOVMzUzUrc3V6TjR4?=
 =?utf-8?B?T3B0T2pjZ1ZTRDJXL1hVSTJoeE5JaCs4TmRBVTNpWFVmWHhEWm5hTndvbFNT?=
 =?utf-8?B?RDRxTEtzeDRaY0U4K0hndmhibnZPZ0hLU1R6cjlSamY4TW1BaGIwOElKa2tp?=
 =?utf-8?B?M2VCVlBNUkV1UVdHR0tweHhGTk5RL3hDSUttdzFDTi9NbWpmUGwyczhzTzVE?=
 =?utf-8?B?aWJpTms1RjcrWksvUGFpTnhHTkgzLzl2QXdJVHlTUTdtb2ZEbTdXTTNsekoz?=
 =?utf-8?B?VWZUb3FoS21xTlYreGRQeVJlY2lxVzdQYWJOK1FndEdIeStTeFFCNCtKWEJm?=
 =?utf-8?B?SWhFL2dISmthdEN1NSt5anZKNUdYb2paT1NDQ25iUllqZFFtZFRGVXY5S0x2?=
 =?utf-8?B?Q1lzUFlHaHBDYk5HdW13YlFlTUhaT2dnd0dldU9NTXZOU3FwdnFxMmJ4Zk5p?=
 =?utf-8?B?NytmbzBYbGdMazRXQlhTM0ROdi85eVNOS3pod2dPYjBoUmRTS2JjZzY0RjNk?=
 =?utf-8?B?a2p4UThRZ2djN0Y4WStpOGR2cm1WTWxpVHlOdi9tUzE5QTM5NUx5WkpvMlZR?=
 =?utf-8?B?eHhCWE5OL0NJazlqTjdzYStBd2ZJUzZCajZOYWdyYjYveUR1SVhLV0VYT1Fu?=
 =?utf-8?B?TGRHbUFPUGhrYlpuT3ByNVI5VVJCMFVwV09mTEVta2NyRTU1dFZYUHJPaXRX?=
 =?utf-8?B?K3dVa1FVeVp0cnJDd0JVSkI0OWxxbVNGOXNPdXFkdHd2bEs0WjIzR2crSzF2?=
 =?utf-8?B?K2M0Qkd2OHpneVd2MGhyYmM1S2VOU1BYUzdkM1Qzd1cxOVJGUGhzR2hrVFRY?=
 =?utf-8?B?ZG8rb2VqK2ZrQmRkNjBYa05tckpxL3BWdEJpZ2NoTEljY1kycFFFY0EvR2Fa?=
 =?utf-8?B?QStoUnViQW9Ca0JkMzBJS0VkSUlTcDJqVE8yNnVaa0Q0azZpOVlzc3psZndl?=
 =?utf-8?B?Uk52QzBPUWVtaS9Ia3Q1MGRpSkYrTEplSzMzUmRwOEQydXpLTDVJZTVua2Jx?=
 =?utf-8?B?aTZKUjlJblhDcjN3R3hsdldtRmtJM0RSMVVycVA5TFRUOFE5ZFdoTndKaWtS?=
 =?utf-8?B?c0FyWFloeHJ0R0JiRGVTM2dTV1BMTDZlUDh3TkVYSTJuYWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9091a4-030d-48f4-64f0-08ded374f531
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:20:42.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7D22BCFD4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38169-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,SN7PR19MB6736.namprd19.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 408096CC679

On 6/26/26 14:53, Krzysztof Kozlowski wrote:
> On Thu, Jun 25, 2026 at 06:10:08PM +0400, George Moussalem wrote:
>> Document the Qualcomm IPQ5018 Bluetooth controller.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  .../bindings/net/bluetooth/qcom,ipq5018-bt.yaml    | 63 ++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
>> new file mode 100644
>> index 000000000000..afd33f851858
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/bluetooth/qcom,ipq5018-bt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm IPQ5018 Bluetooth
>> +
>> +maintainers:
>> +  - George Moussalem <george.moussalem@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5018-bt
>> +
>> +  interrupts:
>> +    items:
>> +      - description:
>> +          Interrupt line from the M0 Bluetooth Subsystem to the host processor
> 
> What is M0?

it's a low power Cortex M0 core, for Bluetooth processing in this case.

> 
> Anyway, this part feels completely redundant. Can "interrupts" property
> be anything else than an interrupt line from the device to the host
> processor?
> 
> 
>> +          to notify it of events such as re
> 
> This feels useful, but cut/incomplete.

yeah, c/p error. The interrupt is to notify the host of bluetooth events
running on the m0 core, such as TX/CMD completion and/or availability of
new data frames in the ring buffers.

> 
>> +
>> +  qcom,ipc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to a syscon node representing the APCS registers
>> +          - description: u32 representing offset to the register within the syscon
>> +          - description: u32 representing the ipc bit within the register
>> +    description: |
>> +      These entries specify the outgoing IPC bit used for signaling the remote
>> +      M0 BTSS core of a host event or for sending an ACK if the remote processor
>> +      expects it.
>> +
>> +  qcom,rproc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the remote processor node representing the M0 BTSS core.
>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +  - qcom,ipc
>> +  - qcom,rproc
>> +
>> +allOf:
>> +  - $ref: bluetooth-controller.yaml#
>> +  - $ref: qcom,bluetooth-common.yaml
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    bluetooth: bluetooth {
> 
> Drop unused label

will drop

> 
>> +      compatible = "qcom,ipq5018-bt";
>> +
>> +      qcom,ipc = <&apcs_glb 8 23>;
>> +      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
> 
> No firmware to load?

firmware is loaded by the remoteproc in patch 1

> 
> It feels like remoteproc node split is fake. The property qcom,rproc is
> even more supporting that case. Shouldn't this be simply one device -
> bluetooth? What sort of two devices do you have exactly? How can I
> identify them in the hardware?

I wasn't sure how to represent the HW. Should I make this bluetooth node
a childnode of the rproc? Essentially, this is the transport layer
(using shared memory space and IPC/interrupt).

Most QCA BT controllers are also childnodes of a serdev/uart node as
they use serdev for transport.

From what I understand, it's simply BT firmware running on this
dedicated M0 core in the SoC itself connected to an RF.

> 
>> +
>> +      qcom,rproc = <&m0_btss>;
> 
> Best regards,
> Krzysztof
> 


