Return-Path: <linux-wireless+bounces-38450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3jWnMccVRWrj6goAu9opvQ
	(envelope-from <linux-wireless+bounces-38450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 15:27:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D06EE18D
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 15:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=fOaD5SGv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38450-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38450-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64A443061E9B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713A948A2B6;
	Wed,  1 Jul 2026 13:16:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010020.outbound.protection.outlook.com [52.103.2.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE776481643;
	Wed,  1 Jul 2026 13:15:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911762; cv=fail; b=ohQjBX5N3uMxRbqQgrJHW6LT4FRDmKvKEPRyhRnpyF8S9A0jqT1OodbdI3lmnk6/fxgWUj0XSAAno+RtLzCx0YGIQJ9B9BX07BppVS+w6qKv48XlUqvPzDUpUiAyYONltjWKOw83cCAMyAO7t++FxE9N3wn3uEbutTmpMvyMIig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911762; c=relaxed/simple;
	bh=9xXPADXa63XTx4EqXxvqlbAdtRGbhtFyYhEy0sVg++I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDIxkEvtsNUr03AmeBFCFIvlGQtRoHZj6mZNNSuWa9iMeV+8mfnDB14/rx3TsBe7JidixeWLOSXPdwUmWbrtKfmhlwWhblWA197bAfd17yoRnC4oQBKfAhDTSiz8r0KBZVwpPCPwoNeHXM31Au+xDR3+SaGrz3K3ExNGVKPeyew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fOaD5SGv; arc=fail smtp.client-ip=52.103.2.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZxlhEahlEt545XExQ91MXh2bG7p7wLOMlD75N6KmPkAjYEvygDF02NlSdFbru56MWPGpP81MTO+AMp/GQfICInKySPRhFToPlSDWphUjFgsSz+gC1JrlQGsnxdVB9qL6BcmTf9hIRHLX7+hc7tny1hrxITxnrul9kZvB7ipQOcHSXOIRtmo+51P8LDjxBdVbm405/ds9BNQUHRHfmjB83ntI6SH70w4JcKZXbAvbH5tsFgFM4WaEiowT18n1vryecHSy+EVXE757rBOhPR5OUsBnFcWN+QlaWeWoHfEenT2yGQuK1RRwZtn0y3mlJA6f4rHcj7CqTur5kA4iiohlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xm0FI05XJFZDL+RZtaxrDFvSt9ANySRA+OH3mdIz34=;
 b=IwCqK0U6XKKYF1IBsMd95FYwopZrMp+pBLMsUclpyfjfh0SIZYmBuurRACu8gFoEXjnTV7XC6+140irIuvrJYPmne0Usl3by0525ghk5Qd1/aJOLov4w/Xot1CTSo3XtCpvoCKeZCviEqf00p0DdBM+t53N4RDvR2VWfV+Aq9wUDy9AyFwfRR0irgz/E7rrF6ggA2MmWh8FpolIG3UT2rCaQpA0yvwI6CDIzXYmJ2GHJ54CtvlZyueaGzLxFipkMpLVnK/xsewTht8zu1uyF2RirpBByAQDStcnrH/8+mTzMBN1VkorG8g1JtHbS06hCLcFJH2jm+EUo1UEz7isWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xm0FI05XJFZDL+RZtaxrDFvSt9ANySRA+OH3mdIz34=;
 b=fOaD5SGvGJZLhXCc1iPuTzx/kS0IsbEvFkuhXhqWC7qqVdcnAG7h4VyPNmtolCZ+W2JJVYRv6OpG0+7gL163k5kty+eKG/EjRskihMn0/4q0Yv1teOjGAELZ/pE1lPA5HXRoRAaEaComwsLBEdrVx8uR2BDvy6uZRIMDRyTJ6zwUlUGttnXU0T0/16mkSrjmqMZbolXTYjN1mcIatnAEH4MlRW4t8GBpIAL6AipxvelRehSJG2nljAlf3paCaw4ka98ATE+vTFsZyzGOjKkeaajQJreplALvEdkgwWvJwUabuhqsho1+M0q5rqvWpMjmNt4VzigbPreNBkGulr5XDQ==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by SN7PR19MB6969.namprd19.prod.outlook.com (2603:10b6:806:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 1 Jul
 2026 13:15:53 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:15:53 +0000
Message-ID:
 <SN7PR19MB6736B784D6A16CBA531DBD5C9DF62@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Wed, 1 Jul 2026 17:15:36 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
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
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
 <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0002.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::7) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <375f0807-17a1-4561-bade-1f6d2deb472c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|SN7PR19MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7846a314-40a3-4a84-2140-08ded772dfbf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|23021999003|37011999003|12121999013|15080799012|51005399006|41001999006|19110799012|8060799015|24021099003|6090799003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHlLRThGSkx5bGllZ3dRNVZ3QkJWUzBXV1NDVXNybzhsLzRRazhBTTV3Qkxh?=
 =?utf-8?B?T2RBemlVYkNUV0NZZFEzVDI2UjVqSFh5MHVCeWpJQW9mKzlnb21OUEErT3VF?=
 =?utf-8?B?NnRqVVkxNkZMditweWZ5bjI0TjMydllXVzN2K0lQcjJEWHJZL24yTVFjTVV3?=
 =?utf-8?B?WDNhQ1N5emJBZTBqekxzd1A4RXYvdUxzMDh4aDRiYlFhMlZIbUxhK2RGekVN?=
 =?utf-8?B?ekJDS3UxeXZZeUZ3Ujg2d3RCRnJOeFFWeGZmSUxZdDRyakZKakMvVTROMEVR?=
 =?utf-8?B?ZTA0a1ZKbzFRM2NYYkcvUnBtR1V3WEFTQ2FnWlVXNXY2YVErYXptZVpGMVd3?=
 =?utf-8?B?RFQrQS9KTEdiR1FNakd0SFJ1V3BxSDdaeFI2T0VhL0NDaE9yQjVSdFZuSDZL?=
 =?utf-8?B?TEo0dUVjMTZRTUxSMlJ1UE5rOWx0dEpQMzl6eUczdjVidm4vSWNycnpRa29q?=
 =?utf-8?B?V0UybTlXZklvSnBTSmNUVjdRTStUOHJQOWZ3Mkh0ZzljV0hlRFd2NlFUbDJl?=
 =?utf-8?B?UDdiNHZJTXYzN1lHUTBpajVwOEJtbzQ0TFNaTk91QmNKZkE4OEorbEJXWnF2?=
 =?utf-8?B?cXREUDhCa1Njd21iNVJ1Z2I0MHdMZUViclZGVmlKVnpWSjMyUTh5K3lkTFB4?=
 =?utf-8?B?QVlqS3IyS2VnYy9xRUZmdmwxMUwvRWwvNUdzU2RxRnYvS0s4RU1YaUk0RHNV?=
 =?utf-8?B?djcycktlYWhMVjlMR1ltSlpkVWorbC8wYmtOOTFNZnQwUm1LNnJIZGFnNlUz?=
 =?utf-8?B?S1dQbXl4WlM0OEJSYzd3WVFyeFljTGF3NDAzeitIdFZQSlYyYWNsbzA2azZH?=
 =?utf-8?B?dkUxLzNzQXZUWFIwZTRlT3c0dDRQTVo4dktuWmFESy9CbndZR1pDV1Jhc2lP?=
 =?utf-8?B?VlRkeXVaN2FNUnRwVk85M0J3dC8rd2wzcWM3bWo1RzdEUmxWRk1oVFMwVDZ1?=
 =?utf-8?B?SW50VG5NOEVwZFNidm9tc1Jmei84N2tXREtPWmE0WmpaeFhlYUVJaUR5MHZn?=
 =?utf-8?B?cjNwK21NS2wwS3dwVkJ1NVhkc1NNTDkrbUcyeDUzODFINGVqeE8zeW5FUWhO?=
 =?utf-8?B?ajBwM0xJQXk3V2J0L0VtM1BEWGJyQy95eGNQUk9neHU4ZDZ3WXRzcWt3Y2Jx?=
 =?utf-8?B?bVRLMmIySEQzdEFac29uZ09yVmJjV3g0Q3hmL2FqcVVwYkMrNXY2Y0gvUWVw?=
 =?utf-8?B?S0V1cTNuUnlqYm82R0RhN25ybEdjaE03cHNNZm9sQ3MvYWl0Zlhpd1htamNh?=
 =?utf-8?B?M3orb1g4MjJhSWZma012KzVxTm56aEVwSXhKTDVEMUNkblJrVUlSc1gvREdB?=
 =?utf-8?B?YkJ5YWEyNkhLeXpaRnI3NFFwc0h6OFFsQnJ1QlVjVEpOdlFTRWZWTGZUZ3oy?=
 =?utf-8?B?Rm90YmNlVEowY0hmbm94bmJHOG9ObkdQV0ZyekFCazU2R3Fhd1RMRWhvLzRp?=
 =?utf-8?Q?mXxS02UF?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YURpQmJibTdRWmZiRVFjZVdNWDdubFdnN1ZwZUc2WG5tZkpQaE1tRmE5Ylh0?=
 =?utf-8?B?N3pyVUN4MldlUW42dXN3c2gzK2wyM09iRWdnY2g5Slg3V2RqT1NPT1VxUFJh?=
 =?utf-8?B?ZE1sMnNmNGlZSkFZOFpYNk9QTTRZbzJQYjAzRFZIcjJPUUNaQ3ErbGxuN3d0?=
 =?utf-8?B?VFArSWoycFZHOHF4RCtUQkxDZEtSa2VFZklqSFNPYkxJSTRLc3B1ZkI2S2tP?=
 =?utf-8?B?WHVzVm5ZN2hJTTllaXZ1YlAvOHZ6cloxMWwyeTBuZ1N2TVdrQXJSSmpSQm9y?=
 =?utf-8?B?ZGliaVFOK3pUaXR4bE1XM3N2d2pVYmI0bllpdHM1RGFWcW5kZGo2K2RzVFlM?=
 =?utf-8?B?SXpYUGs4TXBLZWVWL2RLWkRUMjYvL3FhRWt0TTV3VzRGNWZaMnFZcnB4QjVn?=
 =?utf-8?B?cjIwRDlBOVlPcUo2WlZ2NGQrTkVFZVBlbFozaTY5dVNIQVc4OXYwajg5SHJQ?=
 =?utf-8?B?My9tMWZsdmxjakdNcHFoT0ZZMWVicU1nMnMxVjZQVjFYaHhkU2JlSWh5eTVX?=
 =?utf-8?B?VkM0UUI4U1oxaXZmOWlkQ1U2SGI1MG01RWxsNkRsNDZ5OUVoaVJRNnViTWp4?=
 =?utf-8?B?Y1JzNEFtRWlyeDZzSnRxMXp4bGJCK0tncjZLQzF6dHowbHJhNzBkY2g0bDJs?=
 =?utf-8?B?eVFMVjJzYlJtNXhuM3Z2Z2Z3b0ZjdXFMK2NyVlNvdmt5WTZVN2JTRytSWVpX?=
 =?utf-8?B?b1NYc01leGxOSWxRM1BVbTYwSCtFYkNUR0pNZHVFMVBmR3RtSnp0eDNTZ0lM?=
 =?utf-8?B?MnFFd1ovcHRLVk1jeDdtREFVNDZocVhheDQzdXFrazA5ekZDeVBJYnhvdDY0?=
 =?utf-8?B?Rm5aN1VXR010L2pJRGJmUDdqcnp4Qmt5Q0V6ZXdZVFYvOHYyTlEzdHl6M0NJ?=
 =?utf-8?B?TGozdnhhT0JWSm9Kb3h2UWJRcVVkaHkzSk1IR2U4VFFCQXloTnhETU00bmZv?=
 =?utf-8?B?V201VVROOEJUTlRhMFpPYUJ4QVNjaUhwR081RlBzTVZ2cDlUdXdXWi9kUkxL?=
 =?utf-8?B?TTRQSHJNQkhrL3l1MnNRVjh1TzBob1QzakptdnFoTStqYloxUnp3dXRtcXlZ?=
 =?utf-8?B?ak1vUE0yRnUzcHd5cmlxNXZZRmhOb2kvN3JjSWJGb3pScXl6eXRTRFZmb3Jk?=
 =?utf-8?B?MkZJQlh5QUM0UkZ4OGJHZEdnSC9QYzRkeVVFZExONEFBQTZTNGFMcDF3ems0?=
 =?utf-8?B?NnlnamRKelNBRHNFRXpRSlpOdG9obDB4V3drdk5Vdm5PU3RtUk92ZnZZejVV?=
 =?utf-8?B?OEZ1OXl0T2NnQTd3ZEM0c1lDMENTaFp3ZFZzL0tGOFprZFlQRG1RaUxaR1V6?=
 =?utf-8?B?ZVphbzFIdFhBT01nUUFrTXYrRzBTMDBRYzhPZFk5UDdNQkpXTUpBUTU0dDBv?=
 =?utf-8?B?b1dWOU45ZVRRVFZGMkpJNU5mcDkvSnRxNlh3ZFVybVhPeGM5ZU8rNHdWRDJn?=
 =?utf-8?B?ZVlUUUVXREpVNTVCL0tSU05CZ2hWMllsUnJUa1Y1dU9PdkYyeDhSakFlOS9U?=
 =?utf-8?B?MHQzcHdNVVNCRHlBa1h3R1dTK1g5RUk2WFMrV2xseGFNKzBKanFNdzJCVkxR?=
 =?utf-8?B?U2k4SHgweFh5dlg3L05CMWV6bHJLL0tHY1dLMHU4Z2w5Z2ZWck1tRUtMTlpU?=
 =?utf-8?B?RWNmUDFwWFUyTm4rRzhnUm9IRS9xOGZQU2hJdkE5UG5zK2dkb1ViV1RsSE5Y?=
 =?utf-8?B?TDI2dVR0S0Y4ZFF1bmJpUWh4ZjdwbFpRS0NuQnBOK2YvMmZLR2VVNTlobVdh?=
 =?utf-8?B?Yis3bVEySUVEMURqNnQwaHNIdWNFTHlWNUVlRXd0UnNnVTFPUnh3TEt5VThJ?=
 =?utf-8?B?NVp4YWNuU2IraVVxY0RRUnhoaGFjZjc3YWo2WEFhdkExcXVUbkh4MTFoQXdw?=
 =?utf-8?B?TzlpUGp4Z2M5ZHdhKzBsWWE5eUxnWGNYUjFXMzRQWDBwRlE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7846a314-40a3-4a84-2140-08ded772dfbf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:15:53.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6969
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38450-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D7D06EE18D

On 7/1/26 14:40, Konrad Dybcio wrote:
> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
>> modes which are required to be configured through a Secure Channel
>> Manager (SCM) call to TrustZone. However, not all Trusted Execution
>> Environment (QSEE) images support this call, so first check if the call
>> is available.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> I'm amazed changing this setting is a secure operation
> 
> [...]
> 
>> +/**
>> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
>> + *					     for the Bluetooth subsystem (BTSS)
>> + * @pas_id:	peripheral authentication service id
>> + * @val:	0x0 for normal operation, 0x4 for ECO mode
> 
> If there's just two values, maybe we should make this take a `bool eco_mode`?

that was the direction I was going in initially but then thought that
there may be more (undocumented) power modes I'm unaware off so changed
it to u32. I'll change it back to bool.

> 
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + * Returns -EOPNOTSUPP if the firmware configuration call is unavailable.
>> + */
>> +int qcom_scm_pas_set_bluetooth_power_mode(u32 pas_id, u32 val)
>> +{
>> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
>> +					  QCOM_SCM_PIL_PAS_BT_PWR_MODE))
>> +		return -EOPNOTSUPP;
>> +
>> +	return __qcom_scm_pas_set_bluetooth_power_mode(pas_id, val);
> 
> Let's just inline the whole definition here - it's single-use anyway

will update, thanks.

> 
> Konrad

Cheers,
George


