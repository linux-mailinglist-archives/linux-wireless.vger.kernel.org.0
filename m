Return-Path: <linux-wireless+bounces-38362-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DiyvAxKxQ2r2fAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38362-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:05:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C616E3F88
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=vIZo3ilX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38362-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38362-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C6B830C9C04
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3F3408001;
	Tue, 30 Jun 2026 11:38:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645F40312F;
	Tue, 30 Jun 2026 11:38:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819509; cv=fail; b=BZqGWtIwO6H4CsiaPlFLNtYQNT48fIDRNQoE/mfSNibqSPtOIKloiIeScio3YVIT58ei82X75PoNXmT70bDjwvhiI17hf1OEE2DHD6CSzlkFRQMi8ONTn+8oyacOp2ZFH6tsCiKftwl7nYPigTXXYFQe6mgiO9xKfWnqjszhwQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819509; c=relaxed/simple;
	bh=6VL0VVmOeZzowV7X7dFZbBuLT0Se4X1PtPvD1Okb8To=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DmatrLw1TzltAA495bNALd7aHuvLXEutpkv/1CqTsXf0LXMEStm4QCWxcCUA+TEtqFXICtNFTjR/Xqj0SkKFLMLKaimAGihNUoRGiIQ8Fn0BRfRd9x9dA21kwKC7iLXql4uSCxJz6SjDFwqns6wqms1SBpgvbOa57senfTYDeTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vIZo3ilX; arc=fail smtp.client-ip=52.101.96.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJV9DdNpiMApb7a0gmpPx3wSALWxs5d+9MZsHEiZU2EglK9NekKMZKSddDheDH2pbGerBkYB3ofhYNSPCZeQ3yAua5ejnvdhi56dCBgsQIyG6WGsrSODW2cbVopznYB5voSJddhJ2zp4LsUwR7NyckvFmSh4Oy7TPcrfNB0GF1XEQN8Dm+6Ck3JBk7LJG/fFumqIdFJbd3mroFTo1ybQgLBccCOVl6zPA7qLWmpAjddR/U94OGmac9atV2Q6jNmv4cOuIDWAoLpHBBpAEwdgHAcRiYiXopcyuPPQUgCqGbzUfSgBgAKY1gqbd1GLWMwEYvZwum/OaVpO3k6KE1g+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubp7hAVO9gonQ67CwQjxwl1DeQV5IyqXzUbsB3P4ByM=;
 b=ioVek9KBbvv/E+VEGZZ6OoIMeIs/Z2AChv1gA4TzEhsexUDp0cVcr57zVhsiQ6r2FVjYlrEDQYu9v+u/XCUsyqnZvhX8s394rj6GHtrgE/iMwAAhOtZ47Yv2LsVOK5k0MQ5QXFGFmbbZtbG/ZTpjA6Bp058ocCwizu9oekcxDkQnpgOTxvT5aM6W7K+QGXhW45+Mv2fdmN11S/Fd4RyuZIZWUZRjFHzGpp031F2ePv71rp2/gigwvOUsHXtgd9RymXAHuYZ9hePaGfr0GQtus4vETqXATHSkKk/nYwyhjMGC7qTnrWbUUgw10hkqPA7DWfVsvRDz5jCX5v48Ns0T0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubp7hAVO9gonQ67CwQjxwl1DeQV5IyqXzUbsB3P4ByM=;
 b=vIZo3ilX7zYcwXYdn81hvI+fkC5EbebncjJx1soyTf8f43IqEJNyOaKOmnQ/roKXtAhgYfK3rI+cUubpX5+tM8xUgMNN6VPzDF7Ibw5CPIElNlIk10DxCTYmt0OW3yk7PsKLuIFjMg4eYWlwGLP9vfBG627HK6k9DVkXIKAh0zw=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7243.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:38:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:38:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 30 Jun 2026 12:38:19 +0100
Subject: [PATCH 2/4] usb: usbtmc: don't keep usb_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-usb_dyn_id_uaf-v1-2-160a02be5ac2@garyguo.net>
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
In-Reply-To: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782819504; l=989;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=6VL0VVmOeZzowV7X7dFZbBuLT0Se4X1PtPvD1Okb8To=;
 b=kp4vJvDUtlcNPd7Q8loC1t6pISV5ppqrfhixf7Q3c3TQRpgx4qTk21cojgzbtkqjsnJoDdka7
 SKmRaa1hiNuDIV8QcgBzkE98weM5hmkXvYuIk8I1m16EVZ421uLiakb
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 718dfe3e-f858-4833-cec5-08ded69c1887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	19U0PJJFVe1hhir+qtTV79fWS68cumuwuEnOPuuc4oHDdui/Yn3ZOTT4VgoWw2sOysmQwffmypRh0dhD/Lq4A6FESHU95xZzGT9x54VUg86nMPj5M4ELTkronKjyuBYH2TEDiyF6160GSHB68JQ3M97z9Qrq5X4a6R8SkGlkloXCkM68HMOKRFFVO2ZSTez0NckyyAIkaUwB6lrfi4jRWVoIBu4xAwoy6a0AYpm549jVuCKECuKQaz6S/dDOyJ90obdEuq6eU2nQcYu2ZxAiG5IKi/X7nLQAWIXuCIvR2JqRfS2dxSjkWvfc5+a/s9S0LkYE8aGgx3HdfqrmXFTIfC086hcFIkDDAqCa7opi+NL3dchoCpMf3ZP4pZKi2eVibgfxElisw7NuDswiWwtba/OfeMXAxtfbBSGlyRf756bQzoJUKAJzsnxSns/KH0NCrLo3+xdpBmqgzm+Dbl8zvx3Zu9794YCY3jQP4qy1/e9H50kpubWfm+3M7vL5rAYRFxeIGFaRX8Uy9LOFngvbTtU/nW4a6Dh3GYNf+4Jr25OvRaX5C9rpqtRvOnH1PBc6wDRqpcQRPbO+8i0IHKow4PDBqMPAAsUGSRRuU8vwGmmV+XBstLuKX0bzdj4wwVwlZZB8sem4QVAxHTyveyG/RO4GKaufZFXluTJHSWJneKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHdKekRhUVRaZ2k3dDl0OXNOZFNXMUZ5em5MRDYzb0sxZ2NxVGtlbGRYc0ZP?=
 =?utf-8?B?ejdnSzNzckNVK290MXlmamdrbDRwMUZIc0NuRlBYNGlUdW55MHZGbnNZWlNw?=
 =?utf-8?B?SVFRRTh4Z0RYd01pL3hLeVA3SGpNRjJRclN6UjNJRGgwWkwyUkpjcjQwQnRC?=
 =?utf-8?B?RC9HSGZMUytJaDFvRDhCZ2c4L2NjS0Q4T0JkTExSOEtEaXpPR0hDdXRBc0Vo?=
 =?utf-8?B?QnV3N054QnVYSHBVM1VZN0hhNllqUTl6OVVaOEU2MHFVcDFwa1dVMFUrRkE4?=
 =?utf-8?B?NHdaaS9rK2JuUzVQUDA1V3pMazI5Z3hnZ2l6UlM0RUJSdXIwVkZhWllSYTNW?=
 =?utf-8?B?Vk04S2xmWFRtcUdWUVFyQjlVak1sNmFPZUdPMlAzYSt6MDF4cThkTjFqUytn?=
 =?utf-8?B?NVlnaW5Nb1NhY2hINFFQOTB6QmxmdFZMZmxtZ0xBWjZCMk9SSHpXa1R0dElE?=
 =?utf-8?B?NnE4Q0J1dE5PR3FlZ0U4Z2NTaW9GanpKVVpDeE0yQmFpamhnSERhL1ZzVVg1?=
 =?utf-8?B?Zkl2eUkyNytsVWJjMlJiY1MyRGluc0xCd2tPSEhKd0piZy8xNGZ4ZlVGUmlD?=
 =?utf-8?B?U0VTMjFYbFJCWlpLL2xPRGxGYUxtejBoMHgvRWRrMUJLQnFqMWN0SUlKK0JE?=
 =?utf-8?B?N0NKakVGaXdmdlRhVEtnTjNiL01iQk9FMUFqbGhLRjByTGRCVVVmR0NRTGdD?=
 =?utf-8?B?S2VpdWhxNERaOVNMbWpZUzkyN294WkZvakJHSmVYaDNrdEhncW9oMFVzZ1Na?=
 =?utf-8?B?aTJRMEd5MkpNVHJLZktCTVZCMDdyNk41RVlSRTFhMXQ2TEthK21Dc0crOVBj?=
 =?utf-8?B?bmZISTBJdnhpN1h3UUlRcGJhUUpEazhjdkVoWGlGSDVmcnUvbnVxYklmb0JY?=
 =?utf-8?B?d044bUJVaUxySVN2WE56RkdpSjlqNVMyRE1zbzZvTVhsSnpzeDM1d241WmI0?=
 =?utf-8?B?T1lEY3JwYnl0R2hzS1B0WXdYd2dGamowUVVkeVdRL1J3NE5HQTNkd1d6U05y?=
 =?utf-8?B?V0d6UStsc3VkZ0ljNXF3RHRJd0FCMGQ1RlovREJydXhDZjcvUk9BRDR6TzdP?=
 =?utf-8?B?cE4wMnNNdUZDa2xYa3o3VncyNkx4cVVFT3R2a28wdmg4akdrQ3AzMjdZV2FL?=
 =?utf-8?B?elJoZHZRUy80a1FuRkEyaTQzLzFmb3ZFaTYySWM3a0tiajN0KzNoalJZcjFE?=
 =?utf-8?B?a25iS0xhdkRNUmhEa1F4TFNURElPeklaWU9RdWN0dGxaQmRTZDM3bCs5YmJD?=
 =?utf-8?B?VDhISElTZ09LYm5uYWlZdDdjbjBxYVEvOGZVOHFqK2lOMVUyamsycitkR25P?=
 =?utf-8?B?SWlWc1BtTWdxVXNDNmtKSVRITTBPOUQ0UHR6TlJFMTlPRWE4dFlZSEFEcTJB?=
 =?utf-8?B?L3hZU0JGaVBJM0VtcUZYTmYxLzVFd05mOUN2NFE5cjVURHlxN0pjK00zdC9q?=
 =?utf-8?B?YVhKR2V6cVMzSWJscWRKNWgxRzUyeWhFTVRPWERqaitNKzBWVjFzMDc2NnE5?=
 =?utf-8?B?RkQycWlYemZURW4wZmtrVXJzYUcvbjBXbUpvM0pSM3FibkFSN3Z5T095OVgr?=
 =?utf-8?B?aGFjZ3NRVWxhNUlaUDBtdTByNWU3dEdOMTFSSDluQUoyNmJUd1gwaFd4aW1h?=
 =?utf-8?B?dk05R05JZEJNN21MZjh5aXRiZ1BQbFhVNmRORUhkUzd2eXJhbXY2cUlqaGNl?=
 =?utf-8?B?RWdHNm53dnRyRHd0NndEcnNZbHdONzZzdXN5V1IwNFMzakNuVWRVOXg4WnNm?=
 =?utf-8?B?bXNPU0NBZ3ZkRGZjMlFJMUlEMzhvQkdRNEhpZ0lnNHF1dXNrM1c3czJ5djZI?=
 =?utf-8?B?bkp0ZUxoVnZyRTJlbjBsam5IbGpKc1l6bENFZEk3YytEajVGSmVNVlBxOFFz?=
 =?utf-8?B?TmFXUHpVYjcxd01tUlBMN2o5WVc4MmdJd3hESDErOVREaHBBQSs1M3JoZk5C?=
 =?utf-8?B?WmtsUHlqNlZxeEsrZS9oQ1Bodi9mL3V4QitUb3JGdmozOHJkNzR3a2dUd25F?=
 =?utf-8?B?Q01HUVllUkxERllFanBQdG51eWZ0Rzg3bDhtSEhhRlE0c0twVVdscndFUGJI?=
 =?utf-8?B?UXpySjltejd5TDlSSTU0Sm4vaUJ3WDlXQlZ1MktLUWUxRkhvSDNYRG5qVVBQ?=
 =?utf-8?B?a3A4QnRTQVhZZ3JpSUwvTE1WbGtPeWtydmVkUVgrMUpHY1RYMjV0aDNhWFpt?=
 =?utf-8?B?Unh2UmNUeUtNMUF1MXVYSmtpUkxPSTJ5NGI2aVBWQ0VDdzZhdUd0ZytPVFU0?=
 =?utf-8?B?U2srN1Y4dU9LWGsydElUZ1JOR3FONmI2T3M3QkZEenFFYVdka1phcU80VXZt?=
 =?utf-8?B?cDlML0VaRFp6S3lKbm9rWnVENlZHMStpNnpGLzh0SGdOVlRPd1NGQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 718dfe3e-f858-4833-cec5-08ded69c1887
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:38:24.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDizIoDjWNd29U2BltNGBBTkmebaaQ89Kvy3XJofQm5aHrVTS8dp5/rrEPCw2Q+j6u/7xRH/1e/S1waclwtaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7243
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38362-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:gary@garyguo.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82C616E3F88

usb_device_id is not guaranteed to live longer than probe due to presence
of dynamic ID. This stored ID is unused so remove it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/usb/class/usbtmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index af9ae55dae14..51cd9320a736 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -71,7 +71,6 @@ struct usbtmc_dev_capabilities {
  * allocated for each USBTMC device in the driver's probe function.
  */
 struct usbtmc_device_data {
-	const struct usb_device_id *id;
 	struct usb_device *usb_dev;
 	struct usb_interface *intf;
 	struct list_head file_list;
@@ -2394,7 +2393,6 @@ static int usbtmc_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	data->intf = intf;
-	data->id = id;
 	data->usb_dev = usb_get_dev(interface_to_usbdev(intf));
 	usb_set_intfdata(intf, data);
 	kref_init(&data->kref);

-- 
2.54.0


