Return-Path: <linux-wireless+bounces-38756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aVc6AfrwTGpssQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:28:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88E71B595
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:28:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ux1DmfP+;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38756-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38756-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D58D33037142
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838141A76C;
	Tue,  7 Jul 2026 12:27:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022114.outbound.protection.outlook.com [52.101.96.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBC414A31;
	Tue,  7 Jul 2026 12:27:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427228; cv=fail; b=MitQfTgxSLBff0POMmfTzyDlYo7Nn8XwdLrIe166FE4SIaOyhPa/QcpVuJLhwzuXN5IRKx6nfxpNpHo/EIjuPoZWRz3Ry9iObDvpu3mG4Tma2HQvRhdJyyiO5TGT0jINHX5cMFPzBFi+o8cJ3S4dIdhfQaK0Mzn5u84hx2c0bUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427228; c=relaxed/simple;
	bh=6+vYp2bGWhLA04W5W7NsXQfW73uwfudeZDZMQMgWbSs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cqyiax2/8kOAEe5AGWaCdmc0DvG4Eva10pLXHtNND7vB+vYcPig1m1517LKb6XoM1XfPAaU5H4wzsbIa1lfDKoKwZUZRHlwOqZTsCNTp+vSA+LERYxqbRgn3vjs1KZzmVVOhDT7b2O31BsjWml7IRBq2hMUfe1EK65Hi6mYvVpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ux1DmfP+; arc=fail smtp.client-ip=52.101.96.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH5/O6jChFITqsIjPsTnstkSiGk/s9uOntYtj3Qs/n47tzlLiL9Q9+o0r8AtM1nw4pobM/SDvQXjyCyfSIUXRojywZKejlxUVSuMrVd3T0Ms+BWBf1+QKYgxxZm6CCIbgPZp7m2Lp5C64OZIQI51YJ7JLB70jO9SuliBO4HcnOusEtJ3D1IHNsWXia2C1ScXFDBuDEIXXw3HA0+5LE3m5GDrVebTdcxLWdgvVJUV1cK0hNvvu6QZhhLtUwLIjBBCkbL6f5XkyPA8/vyyOcl9ur19uaWFbH8M2a2gOC9gO4Li+R7PkpVQs+fO9/OApRzbV7EfgqRoIHO85dcsFE4p2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BPhTB6rTYTl5dD6cwPc2MbehDrDbzu10dJ3ACK5IXk=;
 b=PhcscTGLpXJAwvFmMF+ukvc+XVElBUlZyb/SS8rzIDaFUN6H7G1DkFV8adOrVK8N2+w+R9eCBA0uOaBWam0NzaX0b24CRHhqlHeAMNJotR4S6l5zmFgUnaby/mQrGD82i0nIlsj5OWkou1bTAPQ2pNF9ioW29nCQ+Ao265iYNAjqb+7RvzpLFOsDal8lEah729QXY00GpNl4tmrV14MR3cdWDU4NsRIPoW8cd3Hi1L2zNpFu1VS0lQjhUN9k2qm+tfjqg1h0GjiQF/KyrOF9qMIFZpRgqmBFb4vo5dELZZv2pJJ9vg1M5riDqEtM22a0NqZZ+MZKFT7vidckjEgdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BPhTB6rTYTl5dD6cwPc2MbehDrDbzu10dJ3ACK5IXk=;
 b=ux1DmfP+DOjMRFYL5GU1i9fxWrvmm+B+f38/qQ7qFgfkAd4gELpz8IVreWTaaURVs1PMbT55iHVqmqtDaVtjSwsqqoPjzqeAKyIsCfXMuG8Tphv4HEQag2aq4GFfAvdOMQHwapV4UN55AOebgzlJ7PS6q0Yk3uPXBIjlVL0TUzs=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2615.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 12:26:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 12:26:57 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 07 Jul 2026 13:26:41 +0100
Subject: [PATCH v2 2/7] usb: usbtmc: don't store usb_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-2-632dcf3adfba@garyguo.net>
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
 Gary Guo <gary@garyguo.net>, Manuel Ebner <manuelebner@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=1091;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=6+vYp2bGWhLA04W5W7NsXQfW73uwfudeZDZMQMgWbSs=;
 b=R6n/eRh1ZOo7ShHuxUbVNfa4nbxwsQ1xqllj/8CGLxdssFIA1HITatjBJPNej3NURYrtUDF/P
 9QU1AAVZFXnAcVovMcO2HPzv6atqqrME8w1KO2YqvyyP2uxsr4wnQvK
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
X-MS-Office365-Filtering-Correlation-Id: 2df17553-ba90-425a-69b3-08dedc230942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|366016|1800799024|921020|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZE1PobLhjoxlZyucCGeZtzQQ4DrQutUKWkyNjcrDuOUTWMnFWN4Weoj3ZbYICf+XzEq+8O4S1ktdgPQ2T0Sx/z24jR5m2cIXpf6YLpwDI/BCdkBOnHqkcQE6oQGks1nAbXzMQafjM8ztsrNxTSwO/jl4bQVbZ/UOCSx2ODVuBMUVbd0wltfemRNgxqerXLE5j/kH8ei8kDQUNHmVymrmxCdiHraPRNudo3BAjDcKLbDdeZ9zj13B5SMXPMqviOJvqCkB27+7zQ/tJyDQ7n143FEl9spOCQ8KAHh+tiO/+b3FAuJtss4iI6bA1NFJ0wqag1l91FQy7BEUzuoLMFjKiby0jHADCF0rz/o+3BMaTlDj2He97wOH6miX+mS6dZPy9WL3rmpn7P2jWz5gCHG/T11CAcIqQi/VVHIOf2iZkYm+Vem2gv6u67fO6xMBucaP5mVmva//w3Y6VZh5qF/iQf1a3mVcF2/5Uic9jf2VbgV5FaqLMrYBkC8QpLl9Arpk4vbvjcuOG9kFUPwZ+Xw2jQwLka4AIoCqerIiJ6aN6TTIz+3FaDIZanMAzY2cfL0kbDs6PEVPZljwofD05G0SKTN1dlg4Ot8MMZe3Jaxzr49W0C2yNg27c/+w6ACrZgkmpgfg/4T8YdzXp61tMDoCDHzDV9rRpJ/44afUcCqLk37xiWtyNFn8x9hlvzDNqo33hyZ9yAdHPfvm714LC9z1uQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJ4TVN5djFLZTJOU2huc1ZoazZ6L3BiWXUvYXdiVnpQNGhVZVZEOUlEcWtV?=
 =?utf-8?B?akt2Zld6RWRTRUFaTEtZOTQ4Sko1aExZUzlWZkpRTThKWG95VS9EVWg2REYw?=
 =?utf-8?B?amNEdE0rQXVPTWFtWWVBLy9PYU1FN0pKYnhKa0VvYXcrVW42cmxTQlJzME1F?=
 =?utf-8?B?S1orcjZLK0hObEN3ZWlTQzIwc1ZyRm0zaVY2aUFESjU3WEpYdDg4K1B1TlhC?=
 =?utf-8?B?THRJYTdCWE92Njk5VjlzUGNhVHI1bTBpVWpLRGNSbWxRV3g4N3Z5dENTbi90?=
 =?utf-8?B?bWJURm90a1krSUVmN3YvRzdVb25hNHk2NWFRd3BuLzdsOXVsaUVRWG0rYm1F?=
 =?utf-8?B?TWdpVkQ4c0ZrVlNHbVVLNTB0eHFCVnBsdGRjaVNaQzhmSHg5V3NmU0E2Yjgx?=
 =?utf-8?B?UHZ1WEdKR3ZqdzFHYklWUU1NQWE5STFoRzdtaUY4MGx3aU5RZ0lQRThscUph?=
 =?utf-8?B?dDBvNWhlT1RyT1VURG11NTJBQmRtT1BaOEtrMGt1QjcwcXU5OTBLd0JuOCsr?=
 =?utf-8?B?aTVjRk5kdzViNFc1WlA0ZW5MZ3NBT0Y4SVYrSDFtTEl1a1N1SEFPdVJqamJs?=
 =?utf-8?B?elJya2cvenpsQkJGelZwbXdseUY1T2lkaFdleFB3ZUx5ZjVoUDhtQmlXaGZ0?=
 =?utf-8?B?QjdxQ1FYSHVaWFF4MnlBaXRCYTRnTThIYUVOQWtycDVDZ3VMa3o1bExUWVo0?=
 =?utf-8?B?a2Q3RlhpNDJ4ejBkSHBSUjVWNUcyZjM4d1ZEM2oxcHZ1UFdEV2FlRlB0eFMz?=
 =?utf-8?B?c1hFTzgrTFJDVU4xTnJGSDgyczVESmdyUmdidGVVYmFJWHpQSi92K05uTENw?=
 =?utf-8?B?ZXdKUnM3U2l4OUpMQ0xtOXJsNzV0dVZlRGpZdjk1Ly9XUXgrN2FEY2M0ZlIz?=
 =?utf-8?B?WC9RbmRibStrL2RSZ3lOczRESnQra3J6Q3BFYUE1ZTlkd3d5MURnWmxnb0sz?=
 =?utf-8?B?WnJFazhyOW9uOGpudC80a1lwUlVkd3IyM1FrM1c3NEtHT2xHZENsVEZUWTN1?=
 =?utf-8?B?NlM3bXJxNkxhOG13Nm02SWhIZXV2V2pyWGZjYzE1VU14WGlJVzQwTEdSQVdq?=
 =?utf-8?B?UTM5dXdsYU5XSEI3dVF2WWJJcW9vNTRhaWg4ZEVIUXozUnI0TG95STIrYkN6?=
 =?utf-8?B?VnF0N0FkT0Zhc2RIb1BKUHlPdmlwZ0RzaVp3MGwxREFmTXNOSlJiNlBqNW9C?=
 =?utf-8?B?SUs0a1BGK0EvcVVJNklnODhnbXZUN2p5YlZLVkY5bjhmYlozWGplRGozQ2tI?=
 =?utf-8?B?ajNERTJxSUJOMnhZWGNsVmJCRnlLQVRHOTdibEltZG9vOE53MG1EWFR0Tk5W?=
 =?utf-8?B?dzhyRXR2SVlDeU5KVG1pZEdXMmRHZE9zSUMyWXNZT3hJWHJFeTZubnNqMFRN?=
 =?utf-8?B?b2tUWFlHWCtVOFo3M1J5eG0rNTFFTlNPMGdTMjRaZzEwRkZxd2FnSVREclFP?=
 =?utf-8?B?UEdVemplNThvUmdHZHhQMGE5T1pTdWprUkdrRjdtempZd29vZWlVRDFEMGwz?=
 =?utf-8?B?bTFwVGVpdkpKcUx4Qk1US3BPbkp1MjVhWlVHRDRiUU12VFpMK0tEN1lDZUVK?=
 =?utf-8?B?RnFGQ0dlVjJWa1RpRE1vZksySXJJYzN4ZHhqRytrOEFEREpBR002RGxIMlhB?=
 =?utf-8?B?VXJFeGF1UVNvcSsxQlIyZVZOVmQvYU1kV2ZLS1A0S1V1QXpaM0RISGxNeXEz?=
 =?utf-8?B?TG9xUUVTa3VZdDZDMVR3ZnFXSmgyWFo2U0dBY3E1Q0JnN1JzM3lIVnpNNkd1?=
 =?utf-8?B?RlVzblZ3WStqOWVkVjdlWVdQbko0QTJoR1gycVU1eHBWLzV1Sm1nTldhSVln?=
 =?utf-8?B?YSt4eHJlUS8xcnFjS0hEblQwTFJuYVB1VmVZWGx2aG53RGt3bExSYWcxZTJ1?=
 =?utf-8?B?cTVyQXphL1UrTmQ1SWlDME5hMGo0RU1SS3hEQTcyL1kwUmFTU3RIQVVZY0hv?=
 =?utf-8?B?T0U3Q0h3Mzd0MGNTZ0FCdFF6SHE3WTc4Um8wMVZOWWFNbXd4djhIN0xSZ0VW?=
 =?utf-8?B?UDRPM2FXVVIxdDdHTlJtWkVMcmh5NFlkK0tSVUs3VWRhZWtHTTlseVlUTmh1?=
 =?utf-8?B?ZUxVZ05RTlBwV3d3Zm0reVhTWkg5Yldvd1VYb1EwYXJQRGR3d29BSjh2V2pY?=
 =?utf-8?B?SVNZa1VITjhoNHlHUXBPUElBZHg4MVdERFFYemgyajFzTHJrM3RucUpnRGtT?=
 =?utf-8?B?ZGQ3N1RpNlFQdDJPbVdJWm9aUGtUeXdNQkE4d3N2WDUxNDhScEZVbi9kTUFu?=
 =?utf-8?B?cStJMjFQT2tTRXRRb25XTERwa2tIeXgyTTUwaTJoVlRCZlhtWHRFTm53Wnls?=
 =?utf-8?B?TzBNQy9GaWEyZS9ENnUxb2ltNlNFQmFNZythMnlvQmFFbTEyZFNlZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df17553-ba90-425a-69b3-08dedc230942
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:57.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq7mf95O1w3BwQrMc3X3dEV8mq38uxdFrZKddczn1tiOLn8AR6weJN6TkHSwfaSx+5sDA9k0HqjvXFcanMV4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38756-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,toke.dk,nucleusys.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,rowland.harvard.edu];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:mchehab@kernel.org,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:3chas3@gmail.com,m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:usb-storage@lists.one-eyed-alien.net,m:linux-kernel@vger.kernel.org,m:gary@garyguo.net,m:manuelebner@mailbox.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D88E71B595

usb_device_id is not guaranteed to live longer than probe due to presence
of dynamic ID. This stored ID is unused so remove it.

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
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


