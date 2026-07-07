Return-Path: <linux-wireless+bounces-38751-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ylcfJlPxTGqCsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38751-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:30:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03771B5D7
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:30:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=FcCZOFAL;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38751-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38751-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932D13013698
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B794014B8;
	Tue,  7 Jul 2026 12:27:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022114.outbound.protection.outlook.com [52.101.96.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC43FE362;
	Tue,  7 Jul 2026 12:26:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427222; cv=fail; b=tvmU3bdaAITDaCrh2HZbUDT0hSBcTfzbC0no/iOLa7GbGrh59+iyrnb5GQSaZAA6BBU7z36M+TfMpreNrEZnmX0NfI7waDIeM4v84n5X9+d+pVsDWTZavCooibl4HuLhO9sRj+E0ednbJalh7ryArM+7sbsnAYmn977taIwK/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427222; c=relaxed/simple;
	bh=MHbZObFH/YiDHiGKbRxzAATYxmqcK5zgrhAUZaM05wk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Xx5qOnL/t1tzQQlie+fnA1XnCBo5jM9Mw3qMteJGwbfIEaYyLqGpqTfjWm6dHg2Kf3qI84fpOG5qBQjpzEAjKkc0U2YJPSazuEjA5anpRzWKtPF1nwmVjJndHfnMnthobItwbZPihow93MSJzANU10NaV58NkwriUd0udtGyWKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FcCZOFAL; arc=fail smtp.client-ip=52.101.96.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0wdsznwVTNW+UUoyhCJjgINQ13bsPyOcDS5yIh1JDCvmYUSbpuTudblZlQGTJSlcUZYs4I1j9F/NKIERiFzMpO8k6hU/die7G6L3y2rRezpmjks73jYCNKFrIWsAwo/lgFDLpfpF7hqNUhS2fV/9Eam0wM96aXcAxNBRj08fUB8ZiJF8HmCnBstFG/B8hn9okjafKsdjhDH6lnCR9q0GTs1O8ThZ02PdZ/auwZmzaqH1X7TD94QCWnVl3gfk6TlOkrAdVHJ0405efhEqj/cdZpJ+mztXsHQH3t3FaohJC/mXIuUhZh1NUCM1p3eGke6gkI/6DiSLTJOtNbas6WVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqUN+Ge5pa8YkE8//+RBDKMEy9BtL9Ej05adkUt6a9o=;
 b=K95gBAnUcJ63L/kZA1c91bdaPh8oD4A40RRRZhzFPgp07wUGmtsoPBiNiRCFac2kgI82mQ7BKeupUO/SW7/BFt5oJxDa/mQ6gzlbG9LIgLzzz5WRn4gz3jLHwsADY3jDeomgtkTRRZJAVxCCvXXam3YONqs8NJMxFSlXs4e783e6+NUR+hF5gQC2aUj622HKEO7ndHNtz3RumvwsslDHI0JkkFF92zGQ72D085RL9lLUmbm+tLA6uzTr5qZMmCHzKO1pxxzfxD7Jeug8MD9JGq5eKstW1UH9I/jT+6oEVCSHjyYTP7fi2h8APvcEidHVQC+xhSjpG3cXcxIu4whAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqUN+Ge5pa8YkE8//+RBDKMEy9BtL9Ej05adkUt6a9o=;
 b=FcCZOFALIoQOVKgwlR2QgXETJyFLMo4vqIVUdzvlP/BxbTqVnE0+QnK+CdCHFYOzA9I1h65wA/4Pljsb0Wuxe82AVi3PUxy3Y+rX3G/SB/RmUt346YS6UGHsys5Do8EkJyWxUGhpqQ81rwXVt2euRrLPgiiC1CSBc+FLbThAphM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2615.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 12:26:56 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 12:26:56 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 07 Jul 2026 13:26:40 +0100
Subject: [PATCH v2 1/7] wifi: ath9k_htc: don't store usb_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-1-632dcf3adfba@garyguo.net>
References: <20260707-usb_dyn_id_uaf-v2-0-632dcf3adfba@garyguo.net>
In-Reply-To: <20260707-usb_dyn_id_uaf-v2-0-632dcf3adfba@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Johan Hovold <johan@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chas Williams <3chas3@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-wireless@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=2845;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=MHbZObFH/YiDHiGKbRxzAATYxmqcK5zgrhAUZaM05wk=;
 b=F+Xy09P6O+kMXaie+SWGy76yz7RsnCRpPLvMuUMxPJK1xq7qZ0iAhCk6TlXp5vF1B0QPNLK+2
 a39iaBet8+QDeycXS+OpgUDlCLHz55yAIsAjNg5w1y8scG1cZBUSdXo
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8eee36-8e4b-4531-2aa9-08dedc230901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|366016|1800799024|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MjwzkSUtHUELPQWQQ9lInTnWXl55PVh4TUTfHZDJ7BkTFVcEvpJ86KVgF9Ess/Suscr7mrDU1/o4tjlBQUPjJ9D4Hsepbv8PCJH68DC743uhXyW7hiBM1UNgo0sY3ipQsCSpg2bVN1cY51iM0TEU+CyOSNGVe/YtoRwAwby1x43DpnDVQVDyf2HLVMcAryKENE3TNwUSmRbiQGd1waFTc77NxN/b1PL2dW9hgqQjB7IbrflIK8mu4bBahIulGrvMFcJR+g8sEBMmGzgH+MCwXbXpxRqFFSUnF/XHGfmzWtf4+7OvViQ2kUUvp80cID557zUv0MfBwoxdobo0tkR2ie8IxyfzYFs/+kvxlP5M8ib2Gn+YbF5tuBJ0UmSUIr9T3MsL+bB9MYoMLr1Xjan+9zQmyM+aK+v537pxmRhXAmOKH4R4u02RiFa6jpB8Bp+mv2d1VZeI0Xi7LNSfDgBwk+1MZ4mMeDRrdZ95dkY1NOCnjqYbqdhQ0na7qyH5tYjxAoqhtNem6X9TeSzgCe0ffVd5O6lwCyU+Vz2CYU6ZHfvD5cTVAFgV8xlqpjGLLe/TSF/gRLGi3gdN/BrnX/N1fpBQIW+oKqAKQPaHWWtPCV6HwBQMGrKi/uDAVYV0mcy7GeAP3388B452cGtrgYr2erZ+FReancmZDbAFisrMKVns0ZxrFcGRZE2SlxKy4APxt8TieoWoFpu7bbdpph2+/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHluSnRaM1NxT0tuTEtkYlJLM2U4Y0o2eGxSS292SUZZZXkxdTdxekNtT09O?=
 =?utf-8?B?MUgwUDliQjA2cUZCQjR4Q05qQzgybFpmNzBEVnhjbE5QUTJ5clY5OW5jckh6?=
 =?utf-8?B?MTF2YmFvaTlJaUw3aXNXOUprV0Q1RWpUVW5wTmp4aFJ3YldIUDBCRm1PaUFw?=
 =?utf-8?B?eVJNMnN6dUpOS3RoTWVvZHczZjlUeFRQdXJ2eFRuSHcxbnhDZlc5L3RxRzFq?=
 =?utf-8?B?Z0xyWGdJTzB0UXQrOXlraGdGelN4WGorTjRzNEN4a1M3L09DK2s0R2hBQlYr?=
 =?utf-8?B?ZzBybFBFRkhLUUZkRVhRTXhiaUlWVHpKWWgrSC8wRWJvZU1YTUZZaXJuejAw?=
 =?utf-8?B?RDROQytaVXpZLzdmdXpLaC8zdjJHVGQzOHV5SUtsS05GdUU3YUF6WjMxMlF2?=
 =?utf-8?B?Nks5TGRlcGREZklla24yS1NHYldETU92MFFQaHo0YTlJN3BvcCsweVBIRzd1?=
 =?utf-8?B?K1ZoemxXazlTMU1iWWhkUm5ZbUpROGFERzQ4aEV5aU5ranNsTUNURTVGZVR0?=
 =?utf-8?B?aDBlU3Z1VnNMTHl2K3JFa0NhZkEwRjducHNhZGVqNDU5MjljZlpuM2xxMVFu?=
 =?utf-8?B?dk16OFIvMG1tZ0NQN0IwT1hSVWRuK0xZNStuWjY4NHY4Y1luVTFmL2luT2lx?=
 =?utf-8?B?QWVUMXF4NGk2K1YvcytPQkI5SHpTaGRHVExJZGJEd1BuNlplS2ZvQ0QxbERr?=
 =?utf-8?B?MmVxeFN4UzRsMFVYREdvNDlQTHliVjJwVXVndnlIMERTdWNnZEltNU1icWVl?=
 =?utf-8?B?dkpyU08zNGxMQTVlVzZlOXUvVlJkVmt0Qmt4MTNqd3B6M2hSTDVaYVFBWjdi?=
 =?utf-8?B?bXF1TDk2SnZuSWpUVnlPRUpybVd6Vm1hcDhaeVdXaDNHUVpZVEFad2MxWGta?=
 =?utf-8?B?UVNVRmtucm1tN2laZHBnMFVkd3NHWHA5dVJLTmc3ay94ZDJxTUswNkp1TWNh?=
 =?utf-8?B?MUQ2SWY2ei9XZHFZSGJITk1PRWhyT3RFdGRFRWI1cmxJVXd4a042WkxPa3ha?=
 =?utf-8?B?UHBkZjNUUm5YZVRQY3l2T0k1NnpadHMybGovTVh4VjdkcmxWQjZORE1pVU9L?=
 =?utf-8?B?UVJaYnQyWStZYXk1QUFTWkxjMFZKY1JLckdudnNxbTBhWEZHM0lQSWJJMkRI?=
 =?utf-8?B?eXNzQjRmVjZyTVhtTTBlNmRnaE56QXhLNXBHUHZZSGozcm5SaUtqanhsb2dy?=
 =?utf-8?B?anRyQkJIeGlROXRvNHFtZktGYzNQWUZGSnAxUEJMN3dNQUFJY1crWi9jb1VS?=
 =?utf-8?B?NkFxQWVmS0p4Wnk4STNDSDhLb1NlZEFZemFjS2x0aEt6SnhkMEFEczUwMSsr?=
 =?utf-8?B?bFpuWGVKUUFGVmZqZVd4bjI3VmRhSi9QMkFtYmFBVnhNYUFiVW9qMVRPTHBB?=
 =?utf-8?B?clM2RzI4VGFPd2FKZGJBY29zdVFzR0hET05aSFhRZlJqa3Fxd3lnTEpvVWxE?=
 =?utf-8?B?ZCs0ZU5xWk5kVlpBcEhTeUtTWVJueGdUTVNneXVjYUlEZDd0YW8vL080ckJK?=
 =?utf-8?B?U1VZaXFVaUIwMUN2cGkvRGhYamp1NnllL2tXb2ljUUREVUFmNS9CNFFKdnB3?=
 =?utf-8?B?c3VsdVFWS0x1SDFVajh2cy82bTVtQlJnemVMRStFSkRmREpvblpXUmVZM3Nm?=
 =?utf-8?B?bjBIZ3A0WWxHSlJqaVZEaHg1aWJuK2N5a3JlNnpsdWkrdW93WG9sU2ExemRE?=
 =?utf-8?B?MTV3ZEVJRUVjYThrbURyTDZvMFM4RnorTGgraXA4QWVQczdEV1M5Q3cwdDFL?=
 =?utf-8?B?b3FmOU9pb2RvR3MwNlFWVmN4R2lFZU0rZlFYVU9WOHZOU0tMejdWMzgxMkg3?=
 =?utf-8?B?bGhEUVdNU3h6cXJZSVJoTTFCQlhzQVFYdVRHUEVEeThZKzI4VEtROERMVTdn?=
 =?utf-8?B?NnRQdlVPaWVhYVVrMTFUcVJhL291cGJnMzhsMFRNNVlPM1ArUitrdDFpd3dt?=
 =?utf-8?B?NitYbWRmKzIxT3BMYnZleWxiM1FLSEFZTm5zMGEzMkJRWGswUkdyRUhQT3kv?=
 =?utf-8?B?aUtXa08zUmtCekVkZG1yMmErcFJNUHd0b1pBZytkZVk3Q3lTenBOQUR4cHJJ?=
 =?utf-8?B?WWtOZy8xcnpsZ3NDOGZnK1VnOG91UkREaGtscThGRzdJT0taWFh5aTVmVVRN?=
 =?utf-8?B?Q3VoeldtU1hIWkk2bTNobFJ2T3ViS013Mm1kK0pYaytVYnViRjUvUmFORTQ1?=
 =?utf-8?B?Umo1cmRZOCtzNUZtQUxCa1hvSzZqZlRsNEtsTXVJMU0wR0dmOVdXRThOTmp3?=
 =?utf-8?B?UURVbjZKVDFEYVIzOWRGd2ovUEF4bHhSdnZNdzFjY1A1eEEyanBTQmlSS3RL?=
 =?utf-8?B?Ly91bHJOdVhVem5WRjZIdTB2SE9JM1BvR3JzcUZIdDQxdnMxcThiUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8eee36-8e4b-4531-2aa9-08dedc230901
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:56.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gPWQKiAdJiOq3CCp36GlS+38yI1lxA77muj8KADLGI5xHP0mYGaxVLHqxVv4gMYfBm3wdDiBHYwnkbVhIJsVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38751-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,toke.dk,nucleusys.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,rowland.harvard.edu];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:mchehab@kernel.org,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:3chas3@gmail.com,m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:linux-kernel@vger.kernel.org,m:gary@garyguo.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB03771B5D7

usb_device_id is not guaranteed to live longer than probe due to presence
of dynamic ID. All information apart from driver_data can be easily
retrieved from usb_device, so just store driver_data.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 12 ++++++------
 drivers/net/wireless/ath/ath9k/hif_usb.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 47f904e7e652..d3491ff08e6e 100644
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
@@ -1255,9 +1255,9 @@ static void ath9k_hif_usb_firmware_cb(const struct firmware *fw, void *context)
 
 	ret = ath9k_htc_hw_init(hif_dev->htc_handle,
 				&hif_dev->interface->dev,
-				hif_dev->usb_device_id->idProduct,
+				le16_to_cpu(hif_dev->udev->descriptor.idProduct),
 				hif_dev->udev->product,
-				hif_dev->usb_device_id->driver_info);
+				hif_dev->id_info);
 	if (ret) {
 		ret = -EINVAL;
 		goto err_htc_hw_init;
@@ -1369,7 +1369,7 @@ static int ath9k_hif_usb_probe(struct usb_interface *interface,
 
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


