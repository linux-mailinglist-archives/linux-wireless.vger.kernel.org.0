Return-Path: <linux-wireless+bounces-38366-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TPGhGPWrQ2rkegoAu9opvQ
	(envelope-from <linux-wireless+bounces-38366-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:43:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0366E3C13
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:43:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=xBV1WMmP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38366-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38366-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E96D30F5BC5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46C40B6C3;
	Tue, 30 Jun 2026 11:38:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376E40B367;
	Tue, 30 Jun 2026 11:38:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819516; cv=fail; b=KREWaiZLuHjsBAFdnD6UrMIRxHIRtqoOyTt3YK4ihYYxBNzPE9mhpK3Lxc+MSXBEmzkB0qkh8XnrH7jndpMynurx03yY6z9u+ytIWn2eGPjt2SBzRp+f+elo6+K3Lxg5jIzpLT+0oftvWCaLSn3M1LmD4XOCBin5ZT8M75SukTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819516; c=relaxed/simple;
	bh=apmvq98Ght24DKbpLqd4F7zcVRkFKpEbKHKV9UjP43U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ko64gpoHqmiToMagAnz6eR3dbd0wDWJvAOjpqOSzUW0O7ktH3ZpfA1cdOFg/bo+vueWp4Lbdgr6EHrAwkPT8e4MHoaU9Ww5RpWyEgMh8ieF28w2Cr9hfhEiPDJ3h72d6NbzMm/ePANlxWPK3RBmNZOA58Eji3idYmlvmPuZGHYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xBV1WMmP; arc=fail smtp.client-ip=52.101.96.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUuNMoj5gPaQmHTZOMZccZpGFKPKL9rTD4HXIWZBzbAbYbfuP7BCBzbxcAWzA6EsG7z9iinbGeCYlyjOvfYY3cF59K5yp78ZYDaIe9Z5eD0JqbHBtThOPI976YuoRYSK2rvrNQjvSGKxpT5ssXpvOYVPmOg+gVLOjOc7Qb4V1UiAwmRVozRdQJOYQ1v5HmG3XuzGkjlgSNNwSvRFgIhmBJIIKVvP9UeRAVCakyDkGKW8QFoGpGzbcjyfmJBR7TybGFThfBQAfrKGxB52eNEwPXvYd3QvpAYECskZtajKnblMztPZsliEfxjwcORUep3/HTPMvP3MBfunCzg+SEWIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JaAvuzXKJyspNli0e9CMgP9Wa3WfRXb6zMfkOm3YUo=;
 b=UayViIHgDA7L/9VMnufC6r7X8TkltL1kbC1G1NcJv7QecPMcjcESnEWCZa98dJ9GVJ/EuuX4o80cj7OUBT6LM96lkD6qMuUaCv/ES043qqutUrtJ0DnOR6JIgk+DT/wY5/6jNPRG1jVPGWxy5ndfuNTXqdXY5hjS4+ale2GGoQ4BX+VoNuMDVcEO1B8PoVDToaLc/GIsdk6hKV09rbiPMoXXNHb109dgcZqTYZiMkKPCWA0D2dK19EZ6lROWbidjfdp9l+8HmzSPfEIpkiQeG8aFUqZ3v6X8gzkNl2hXhTw5mEt6H7cd9EhRoPUJewN2L4noKfRY8Va2XA8Bg9xAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JaAvuzXKJyspNli0e9CMgP9Wa3WfRXb6zMfkOm3YUo=;
 b=xBV1WMmPaDvpRptQnOsKiqeGlAXnRKIodY7NsQHbclWsx7WoSYQ1MjJSEixZwLBaW2igJaTDDWzWObxTVStjfeCDDuWt7k2FsjcCktJL9VTPf7Z6VGQIBDADRLFtKKQDpDq0c9AcO9T5BWKFa4dgOKAo3cFoViL7qIP5C8ck10A=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7243.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:38:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:38:24 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 30 Jun 2026 12:38:18 +0100
Subject: [PATCH 1/4] wifi: ath9k_htc: don't keep usb_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-usb_dyn_id_uaf-v1-1-160a02be5ac2@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782819504; l=2832;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=apmvq98Ght24DKbpLqd4F7zcVRkFKpEbKHKV9UjP43U=;
 b=+Hp5yubytN9GmorcKdpuN1YbwqDIgAuHUGHdthTkqh62BsiwBBIEz3Hiyf6k3MYkPC5Jqtl6A
 G444WJQvoT3BSbK/eCTFtxtsiGbsuTpZ8BAaQCWESztZTlhNBmBpefI
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
X-MS-Office365-Filtering-Correlation-Id: 47fa7b19-7e2d-4fd1-62b6-08ded69c185f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WhVWEyqO9fwYv8xgDQ5jy34SnkymLRp/2Vmevg4x+GrjUJRIzgIT6jlZUF1IKA6pRkOcCzL1PJyuaBNHpMBhYw4E5MNO7esfODqi0wuH702YhBpsfAAn9yKXdKgEt4YQokK3f3WyxK+FhbyWYFm3tygUtAzrMXJJCrdDrePb4ocY3Or2IZ1lOUWa9QBo6vWON4MIOIBI1KLOtDVtnRZXfS7Jwbl2HH0s8tD2qcpfep7FS7/3FcvGCN8CzeRsf41sRys6KxMT5zMKp9sQkwVUVsoEiAvHEIbQDTLoUKYGb9I1PMtMAz2E85hv6fcD8BXDgjfKJRZi5s3yNjFgJfw2pfETlJ6szra76XhAGvH3E0Qm6taoUIp8w+s0UJMUTNCtO0bxD1oiiiY3RyfTwIO8XQlsKg8GXrYVEENdsHFEMz/qzbzNJpgOx8l+hULS/bsKink596A5RmdZxMbyhAAhyolUuubhP9E4NoWey2JgdR65NhYUIt3fwOV2wKQU4R4Lgn/ZoIEPu4wTgDZ3rIV8PxJZSBmTERi8fAKM3G29S6sif7qNL5oCz40zY6sSzoLo7FK/CGQ+XHD6P7IxSB7Pdd5Y8XCJB2wIm5mREWBVYlbzKkKElCDNFx6ws8vo/N3FSo4JXGGuXNepgoo9pxk2q3tvmYujuMqYl3YKPzOgrWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5VR0sydFIvYzhJWkpjWk14OFEwS3g0eG54NGNMTWZYcmNtYzRPbXU1SEVR?=
 =?utf-8?B?Mmc3ZmNDem9BWmd1NnFBMDY2UGhYam1ZNEdaOXgza3ZpbVMrYlZWNUQzNW81?=
 =?utf-8?B?ZjJoenJkVmNLdzJhdExPaStYZXEwaE5pa3RMZXVENHF5VFFyQzJZc3V6RjAr?=
 =?utf-8?B?elpsaXZSeGphZEFoRzFVLy9WVXc3OVRwOVNnTlVydkl3bHo1OGxRbTA4UWZk?=
 =?utf-8?B?NEVGUzhiVEtZVlVjR3VmL3RSbHJvOGtKaVNoMUQ2VDRVZmp1S1VqcEhkWVpS?=
 =?utf-8?B?YmZWZEhVTk5BWUY3SmxNY3JVSVdXckt0TytXQjN0UlVRQ1RGTGE0RThvYjRp?=
 =?utf-8?B?MmQ4bnA0dXV3a2tDRWFFaU85akNLdHEvb3luSGZ2K1BmejZ4eVFXT3N1bGFk?=
 =?utf-8?B?Z0RKYUhIazJvWVVoMU1VQ2VncE4wUnpPZ2w4MHBmK1BTTUwxdE9PekFHNC9m?=
 =?utf-8?B?VXpvVCtCOW9SbE9xUjBOc0RpYUlBNXpkMmJLc3QzU3ZvanZnRU1ZVW5sU1p1?=
 =?utf-8?B?bHY0MmZGR1Qwd21oMlZjNDkrR0JTRWhnNUpOeUgrT044Si93Ly9SdjRKUDl0?=
 =?utf-8?B?WXFrM3ZQVjdENDUxUVJQSVNra0ltTE9XVklpVnpGc28xUEExUEtCV3piME0x?=
 =?utf-8?B?ZCtBN1FHTjI1MUFiMVdlUllOV2o2Si9UdlNHSFgzcEx4SXNRazV0UzYrN2dn?=
 =?utf-8?B?SGc2aVV6TTRBSWxaem52b2NxMS9rOTA3anVVWHc4eC84OEFWSk9CQmNTWXRr?=
 =?utf-8?B?bWFMeGptQXN2Y1I0NTZiRnR1eGh6Rm0xQkhVNTFJanJDb1BFb0xFem1IbUdm?=
 =?utf-8?B?Wnl3TmJlWjVWbS9rQUhCdDd2QzRZc0hDVlF0OTlYaUVVZFV5QWI0bUNsQUp6?=
 =?utf-8?B?bndnWWdGRGFuTG1pVXlVcEl5ZlYwY3A1YWlOK3hEb1dRYTNraElKcjdldXdH?=
 =?utf-8?B?YWZXVVE3TmFRTDQ3MGp0djhjY3NGQ3NEYmpZeXpCUUY2RkR6UDF4dUk5YWJ2?=
 =?utf-8?B?Y3BOb1RabHhpdGt4ZXVValBaY3BFSHJqckJ6cXoyQlpmcFpWMFBHZXZNeVhV?=
 =?utf-8?B?VlJkSGZGU05TUExITFB5Q1dGQTFRVmhxMWpWeWhOVTdodFpqczlCOTRhUk1r?=
 =?utf-8?B?V0Npd2wyc29JK1NrZjJobS9QNzMrNnBBUHBqZXdUZFY1dU9SeUpxZ1hmWDVH?=
 =?utf-8?B?Vys2eUs3WkpGVVFRaU5lMk05eFgwUmxxQXVmSVhkaXVOUWlKa2V2WGtZZ1My?=
 =?utf-8?B?M0RrUzZidk1HSjdnNGFVZ2pLRGFqNGhVemxRSktDRXR6TkUwQ2JIdGl5LzVB?=
 =?utf-8?B?a01uRXNJak14LzQ4OTgwdHNWc0ZyRGFHNFJ4UmNkK0h2MGFmbjR1RCtRT0FI?=
 =?utf-8?B?cFEyLzJoVUs2dW9EMXoreURiSXBQUnlyUW9qcFFPNjNrRFRQWm9SaE5KSmJq?=
 =?utf-8?B?cjl0UXBLRk4xellmOVhma005OTZqeXFrc3pEaktxN3oxWitYNkNXY2F6ZGhw?=
 =?utf-8?B?a2pjajd1NjJMaUxya21hZ21aMmpWTWlDeWxUNFVrL3pCOHlDTkdpK3M2azE5?=
 =?utf-8?B?VmYrY25yTkxWd3hjV0JFQzQzNTZ1aFpwZnlEcGlsYVZjZmFJNVdjWFhIa2xS?=
 =?utf-8?B?cVAySVFpVmJmcVhVWmNsWWI1ZUhzOXh1bUFoM0FtSXFKMzBuNTE0ZElSWmtq?=
 =?utf-8?B?VG9lVHlQaDBXclk4RXYydmR2ekt5MnFMVXJPWUxyTjhQZnc5dXN3ZDZQOTdE?=
 =?utf-8?B?cDAyenhYbzl5S2MydnlESHZzd2xicXVaM1lxaTIxaEp1dVJncHR4K3lvZGw1?=
 =?utf-8?B?NkR3dWN0V2xTVnFQMzhwWWFpZ1g0WC9ZR1pmNG95NGQ1Y1YrT2xsOHVsT25x?=
 =?utf-8?B?cndQdDlqNnVnaldFdmFoVk0xU3BBaEZ0bXJLMHpTM1ovak9iZjRlWTJFRUd6?=
 =?utf-8?B?Qjg4ZjJud3lkaTB4T3ptSERvcGhxajdkbnpHL1ROL2V5WkdNaXlLaEVwU0Fh?=
 =?utf-8?B?MmphWFQwM0NBeno0UWtTdHNhcCtlVUhJVGZkRkk3NkZSQm1ZREJ1QzcyNDF1?=
 =?utf-8?B?VFJ3bnpvSm83ZzdZaksxcHZzMXpXZ0M5OW1SVVIyYlRYY3AyanBKSGk3alRr?=
 =?utf-8?B?ZGpkZFdhRDFFdzdVWk1vYytMakU3UlVlRGxvblJaNVlhT1J5ZGhDUDVLYmt5?=
 =?utf-8?B?enNlQ0R1TWgxdHVYa0NEcldoVmdBclhPYTZwR0hXYTlJTjZ0UjNRK2t3Ykgy?=
 =?utf-8?B?RVdzTUdIMWswaUdPaHFRdWRYQmVqclhLbnJyZjROVUpMc3o1V2lJcWhzcXlD?=
 =?utf-8?B?SWJ2YjlYNm9NMXZxSFlic0ZubVVyWlliQ1ZHdmZpN0grSTZhQWdTQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fa7b19-7e2d-4fd1-62b6-08ded69c185f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:38:24.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGPB5Bozh9xm74Qjsdr3YbJpUWmCYSXgcjQykQocUJumHUbMXSFQR30pDTv+q0TOVJWV01xWPOgZVqvn+2nd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7243
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38366-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA0366E3C13

usb_device_id is not guaranteed to live longer than probe due to presence
of dynamic ID. All information apart from driver_data can be easily
retrieved from usb_device, so just store driver_data.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 12 ++++++------
 drivers/net/wireless/ath/ath9k/hif_usb.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 515267f48d80..d65c09c2b7fc 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1087,7 +1087,7 @@ static int ath9k_hif_usb_download_fw(struct hif_device_usb *hif_dev)
 	}
 	kfree(buf);
 
-	if (IS_AR7010_DEVICE(hif_dev->usb_device_id->driver_info))
+	if (IS_AR7010_DEVICE(hif_dev->id_info))
 		firm_offset = AR7010_FIRMWARE_TEXT;
 	else
 		firm_offset = AR9271_FIRMWARE_TEXT;
@@ -1182,7 +1182,7 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 	if (MAJOR_VERSION_REQ == 1 && hif_dev->fw_minor_index == 3) {
 		const char *filename;
 
-		if (IS_AR7010_DEVICE(hif_dev->usb_device_id->driver_info))
+		if (IS_AR7010_DEVICE(hif_dev->id_info))
 			filename = FIRMWARE_AR7010_1_1;
 		else
 			filename = FIRMWARE_AR9271;
@@ -1198,7 +1198,7 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 
 		return -ENOENT;
 	} else {
-		if (IS_AR7010_DEVICE(hif_dev->usb_device_id->driver_info))
+		if (IS_AR7010_DEVICE(hif_dev->id_info))
 			chip = "7010";
 		else
 			chip = "9271";
@@ -1260,9 +1260,9 @@ static void ath9k_hif_usb_firmware_cb(const struct firmware *fw, void *context)
 
 	ret = ath9k_htc_hw_init(hif_dev->htc_handle,
 				&hif_dev->interface->dev,
-				hif_dev->usb_device_id->idProduct,
+				hif_dev->udev->descriptor.idProduct,
 				hif_dev->udev->product,
-				hif_dev->usb_device_id->driver_info);
+				hif_dev->id_info);
 	if (ret) {
 		ret = -EINVAL;
 		goto err_htc_hw_init;
@@ -1374,7 +1374,7 @@ static int ath9k_hif_usb_probe(struct usb_interface *interface,
 
 	hif_dev->udev = udev;
 	hif_dev->interface = interface;
-	hif_dev->usb_device_id = id;
+	hif_dev->id_info = id->driver_info;
 #ifdef CONFIG_PM
 	udev->reset_resume = 1;
 #endif
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index dc0b0fa5c325..b3e7b0fb54b8 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -115,7 +115,7 @@ struct cmd_buf {
 struct hif_device_usb {
 	struct usb_device *udev;
 	struct usb_interface *interface;
-	const struct usb_device_id *usb_device_id;
+	int id_info;
 	const void *fw_data;
 	size_t fw_size;
 	struct completion fw_done;

-- 
2.54.0


