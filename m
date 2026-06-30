Return-Path: <linux-wireless+bounces-38364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IcxbN7SrQ2rOegoAu9opvQ
	(envelope-from <linux-wireless+bounces-38364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:42:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DB6E3BEA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:42:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=iNcT8CO8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38364-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38364-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4D5930CDAA8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A27409137;
	Tue, 30 Jun 2026 11:38:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF8408633;
	Tue, 30 Jun 2026 11:38:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819512; cv=fail; b=DvRI75F65ZmL747XtHy6P72M4TGoIFRZ3AyvZ2bd1P2/U/gkjf7US6E07syT+tv9+gn9Wv16No9xGXVAKhFrcA0vXu62ClL2+fCArVZ67voPnW3uSaDxU/PeuD+iCQsj9fem5ONY+rBSIJzD3BPi8SyNlybkkoaqq7uIzveGsOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819512; c=relaxed/simple;
	bh=UyFJf1KtjdWk5jwLlj+t5JzXepcYAPhFv2HF+i/fSLw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IK5C4xmq2Z1nFS8HXiLfp0cwxkrniEYOL3l2wm5d3UbXhZNo6jT8Wg3DapXP2aYT57pyZQ76F/l7Wv63CN5agaHX6jn5rlcnPxh0gvZA9IE5Wjy06uhj+yO+p4fBIW3PMfwY2SVCTz63pBqgnPV07tyBCfJ3zd2+r2oKnK/H44U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iNcT8CO8; arc=fail smtp.client-ip=52.101.96.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr5kgG1TfMMutLlo83a5uQPRFysEj4eens3c5Q0H8e8lx5sv5ojXMYCeyw6hZo6txZmSiqcNbWOjEjU0KRwpXd+WAMGLe9dHzJx4/CJYlDzVNIkPXt+xVgfkKqutqeVfaYTRxklLQRFLIW2IEy2SjBvQQu2XpMQ0MbNfLCKQqVzTeCXRh12lu63N0FWUbTeTPRITwAnEM1z6xvPM+KA2KEXdjX5ybKNw3c1i1SUI9W+q6PyMZszJOTZv5BEOKUDPJLMKdB7e52TmwMLCpobZp8cLaA6Gx8HmYlf/Gl9bW7tmlgrQtNbIO/Q8/XjQ/SDPMbGLO4IDuKr7OMJnm1DPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXrkDLwc+wp29Z4aKxnU7m8XyspzB7GUVS9uIGPbOf8=;
 b=mZSrmBXUlM32ErIQXlvn4egKrWUxiC4d2t8PblP7H4QTVinBzeO1EO0Kv/6PnPIB+lO/R1F4pjGfY2vBlrfQblutrlZudHEvZ/KjTXkb0Y+AxEkvXBAK69GfvVYeuUv5fCQvcknUyzni+88b1WHN0FpqmIQmKsGnlKAB7sL2yW5m5MsPR45RgFI3i7gxm0XEhiuWaiVYHJctzzmL4KWkuToCoixN+dQ9c8oj4OxYWI2aFRuDjMQagZlIeGQLUChLnDUSqG6C1MpHWsh4yJ9qZONvdQ5pcV7gpTt5vjz30x+TuFM7mpgpPaKbM8/tn+62GOC6Geh5gTUw/n5m4R9v/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXrkDLwc+wp29Z4aKxnU7m8XyspzB7GUVS9uIGPbOf8=;
 b=iNcT8CO8Qs51eZ5tadPEFFkVxXkVzrYJLaawmu0EiFsMSvlh6rjQs5m2hl7XcSB9mnwy2niqh4a0ysmY/XyqhMlrksJK3t8fPQDhURsWQ93m9ec2dsXWKQll9SOzpXsGUXkkfYkGnVSKIp7JlRsf016tbQfbkTaYctdM0kGzZtc=
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
Date: Tue, 30 Jun 2026 12:38:20 +0100
Subject: [PATCH 3/4] usb: serial: spcp8x5: don't keep usb_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-usb_dyn_id_uaf-v1-3-160a02be5ac2@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782819504; l=1450;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=UyFJf1KtjdWk5jwLlj+t5JzXepcYAPhFv2HF+i/fSLw=;
 b=ZPJl04bpe06z2sz4EkTpVPcBq466/Ji5ub0OzG+J+kOmpYK2Wully241fj4+K9lmAl5QiGkJG
 HO+31JSuce5B1VTsAnZgjG5h1oSDWIyZPK8ELBQ82kL7EgUU/kiqaPj
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
X-MS-Office365-Filtering-Correlation-Id: 765239b7-2a30-4704-aca1-08ded69c18b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SYVdKY67SMVCC4Knzo6ohbSySFwW4bVa+Kj6MjB1piXSE/d6gm10X2pFnQzpEH419YQ1PgZkeylKpa9mu/FRKGAeoXY/NF0GdMdkMxTcXYL940dh5uWmaznuik4D3hmc/C2hixu9P0UBb9KYD8dUSyms0J/Oq4KxYp3J3+uKcGu/S46rZVO8fNt61Rq5Jzwigxix/lxxNXrJ0I/wQtCImgG+ijlIW48T2Ci+rxEdx+95GKIpuvPURDwtaBHC0M8fmYLJCEBXtySfxMeDqfK7cy8TCz9oXAm1d3e13yQukH35DWI2wUGZowzWDf3M3iwsH4Jq2Ilb5TXjbXhaYJ0HUAroR5uEQ87fSqkVTBkyBGcCJVu3qG2rs93gyMqHwXW/gJ1zb0Bi4OogtGWrUY145mCmxkZRPQL4t/K3LipY7Fmmui8sAIpOeNUa1kFSTIH53GwW+Fl0D6ZeoHaJvfpHq07FwCREdZxoyITa3iAfKnj9zlj4iILS7AJ5tKMJpZP9e1MQ3pyKuMVDeXyJUPHSDpNC2i0PBlPFekA6bLG/A6s1mCkuKFxOzAsKc97o66B0BtveasdWhs6/D6yujfLI1XD+Hu3/NoxnN5BeuHOuwxvDLAKVRlsOqG/rgkE462oYzx2DR7c2DVZWRMIbkql0RJBmIad3W1z9uQb2O6LDixk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhnTjdsZjJVTGVySHVwcThBeE1iR2dsb1BNVkg4SzNOcDkyM294N280SUo0?=
 =?utf-8?B?Y2JMdEJoWTNSbXArMjY0c1JIR3dNRlh4L0d1RU9JS0VSbUs1TWtJMFRkeitU?=
 =?utf-8?B?dXZVY2hpc2w4TXF3cSt2Q0dpcHJNZVo4WXBqUFM4UHB0U1ljbWYwU1JOUnI0?=
 =?utf-8?B?RW1Hc3d2bGhqZFR6bkRHeFArM2YwZ01MRDAyWk5qaWUxVlNjYkRWazFCMnZ4?=
 =?utf-8?B?OHRrWnB5WUQ2UzQ5elhCQjRkWFhjcDlSUGVGRFZWYnNBYlMrbFZmVXlDRTVJ?=
 =?utf-8?B?NGN4NFNTeDkxMkZDUHFkWHlnclc4MWt6Mmo5NDh1NUcyR3Bhblg5UkJCZitU?=
 =?utf-8?B?M3ZOMzBzYVpadlB2eFVrWjRsaVg2KzZoOWJqenF5aGMwZHkyMlRDNURSeEFs?=
 =?utf-8?B?STVSSzloeXc0VHhJRVU5anh3OGFiWEFwTFhaSDhUK3RCMjN5YXY1QndwUzkw?=
 =?utf-8?B?amNUU2dSYmJLYmV5SjZLTTA0R0NSQTVmaHVxSk9mSGhGN3EvSTQ5Qm5UUDFT?=
 =?utf-8?B?UUp5N05NSmRVQ3dWSzBMU1VCTHFTUHJMUHg3bm02WnJqZmNubSsyVDRPYXBy?=
 =?utf-8?B?c3dxVkgwd1YrelVoSFI5ODB0bncvL3NiSERWMkd5Rk4vQVFEQnp3QzFzNE5B?=
 =?utf-8?B?U0dkTC83RUlPQ2tTc1N5aWh0aU5EZEljWFN5RU5UaEEyVVAwZFpmb2s5aUov?=
 =?utf-8?B?K2xoZVQ4c0lqTzE3Y2htSHVNVENKdXBIMkdHSUQ2T1U1ZVh5dDI2L0gyQnFC?=
 =?utf-8?B?N2k0bWszQjVPSHJWSnhFOGJaZVJ6YXRTbkpnaXV3RG9tdGtyTGErQjNONzN3?=
 =?utf-8?B?Vnl1TWhOVC9mSnY1NjNDWVJTZ3VKK0NJRmMzd2REZDVSQVBCQ3ZVbWJPN0Y2?=
 =?utf-8?B?MWgxL1VjTXBIUlZZQ3NWbnBSODcxdjBYbzVhczVkSGZKcmdCaE5RU0lldHRS?=
 =?utf-8?B?Q0dQdXVPelJrMWR2R1NuM0VnZW10RGRyRVNYYnFRdXpSNHU2RXFRMEFnZHQz?=
 =?utf-8?B?VFRYN2M4U2pLWTNWaTNBdi9lb0hnSTNCdEQxOTNzN0ZQMVk1T2hSUW5hTGUz?=
 =?utf-8?B?bTErMFUxREpzOVJ6aldIWlBjK0Vnc2hWZlUwakpBcHoxUE1HOVN4UVF3cTBC?=
 =?utf-8?B?bDRLcGRuOTV3Z1V5MlhCamo3RnE2NElrcURyam1HTndqcHNmaC9YbnpCeTdu?=
 =?utf-8?B?Z2ZyZ3RmazRYcEVJRUp3MUhybkhiTkhrWDJHZXFQOWc5czFKeDI0MnN5WVJE?=
 =?utf-8?B?Z2t0aXVGTEFlcWJ0QktkbE1QMEdtU0lPTzZkTVAvWkpwN3REejRFZ0xPTk1x?=
 =?utf-8?B?MnBzMHhiaDB0di9lamRQL2EySWI5RDRLNjZsNE53TE8vMFJRYmlkQ3pKSkcx?=
 =?utf-8?B?QllZcGhhSHdoL3RzMFpkNjYrbTFGSVNPM0xIQjBEVmNGdGc3QlpCME8xbVhI?=
 =?utf-8?B?MmJtNXQvT0NQM2NhTHZ1YkVTUXhESWJ6a3kzc1lpV2xzR2ZSRjArLzJPbzlG?=
 =?utf-8?B?T3BtMFBWT2p6TUZqWXZia0tiMG9wVHJsMUZyY1NiUFZWeklReCtuK2h6Y0Y2?=
 =?utf-8?B?NUx3NWNkUlNVWUJrVmI3SCtKQml0cFdreGpvcnJvVXo2TU5jNnNYYlE5WTJK?=
 =?utf-8?B?VDlNalk4OTJSRitNTTRwZVRqNUhONkJUelZYeWord2pxTDZEdlZIQ1lVNGdU?=
 =?utf-8?B?MVRIcjRGenFCM0FMa0JsbGF3NmhOWk51RldjdFA2SXlQWHFBaVdoSWZnTWJO?=
 =?utf-8?B?NUIvY1RWcEJ6VWtJSU9tZEtHdWN0VVdVSDJjZVNQZ1lZVDRDUTdyY0lHeXlX?=
 =?utf-8?B?SUd1U1d0ckI5WW1SMFI1cDY0Sk04T2NIUnI1VDJzaSsvK0tzcThUUUtTUXhY?=
 =?utf-8?B?c1RIY1lIeGk0RXpIdWN4NHhyRFB0OVdGQmtROW55QUo5ekpoa0FqbktyU2ho?=
 =?utf-8?B?MHh4bVV1WEJBOERnNlg3ditzWEhzRWJRVlVSdk5Cbm5ONVNoOHBqQ1c3NnJB?=
 =?utf-8?B?MmlnSExMWXFEbUIwUFhuTXoyNk9mbGZTUG85WGhhM3hSdmh0dnJpRDdqY2xo?=
 =?utf-8?B?K3pUcXVEWGVFbWJpa3hyYUt5eEwyL1JLdk96Uk1DeDVGQ1dobUtzN3FKc1cw?=
 =?utf-8?B?U1g1N1EyMkl5RU5zUlpuSzc4VnVoTFRXd21idzJ0TkQxY3RkY0tnM2c5QlJ2?=
 =?utf-8?B?SklBYmJxM3VCZENicm83RVM1VkdGY3dxZ2VDNElndWw2M29PUE5rZ3NidTFk?=
 =?utf-8?B?QTRlQ2phNDFBMklTVmxUSEFxOS9sS09VejNYR1NGT2ZmL3lQVENFemRCRDJl?=
 =?utf-8?B?c21QVlkzNEdkS3NwNnA5ZjREc1owcy9LeWM5aEE0TXhtRWYwTkZKQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 765239b7-2a30-4704-aca1-08ded69c18b1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:38:25.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FxJmscFbUygyUG2ObZHz360jdJH4Php9AdnVwvE47Ii3LCrN2HX2T/U1hQTkDVjTCWxClEe12kt0U4qJQwE+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7243
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38364-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C8DB6E3BEA

USB probe functions should not keep usb_device_id for longer than probe due
to presence of dynamic ID removal. USB serial does not support ID removal,
however in this case only driver_data is ever needed, there is no reason
keeping the usb_device_id in the first place, so convert it as well.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/usb/serial/spcp8x5.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index c11d64bf08fb..0e7715a02df4 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -133,14 +133,14 @@ struct spcp8x5_private {
 static int spcp8x5_probe(struct usb_serial *serial,
 						const struct usb_device_id *id)
 {
-	usb_set_serial_data(serial, (void *)id);
+	usb_set_serial_data(serial, (void *)id->driver_info);
 
 	return 0;
 }
 
 static int spcp8x5_port_probe(struct usb_serial_port *port)
 {
-	const struct usb_device_id *id = usb_get_serial_data(port->serial);
+	unsigned int quirks = (unsigned int)(unsigned long)usb_get_serial_data(port->serial);
 	struct spcp8x5_private *priv;
 
 	priv = kzalloc_obj(*priv);
@@ -148,7 +148,7 @@ static int spcp8x5_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->lock);
-	priv->quirks = id->driver_info;
+	priv->quirks = quirks;
 
 	usb_set_serial_port_data(port, priv);
 

-- 
2.54.0


