Return-Path: <linux-wireless+bounces-38758-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dmPIH7vyTGrKsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38758-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:36:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D73D71B697
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:36:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=z42VeGru;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38758-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38758-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D34E304791F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14941F7C2;
	Tue,  7 Jul 2026 12:27:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022114.outbound.protection.outlook.com [52.101.96.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993D41A784;
	Tue,  7 Jul 2026 12:27:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427230; cv=fail; b=Juy9kEyBCPbQ6kbIUDGJCmLoxCTruoHm2SWmlvqc62W7eUzIZ2knOvxU62De+OVjHcy8aSqKI790iZmRfaXBtS8Fv1Vv+rbsIC8aJyAMyqrF+A+iU/NDjjfSvKkRdJ8AZtgxj3mn8iLdW5C29qL9qfoUBswtITgoE43NJmrsa20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427230; c=relaxed/simple;
	bh=H5JFKotXcRvBL+j9x2gVWjs5di3esqntHjg/n1H0gL0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZLLEbvLl4HpdKJ9IsjMR2UFlKnc9eh4ldoqGTgDVHFiIZZgyrx4uoxEbBRhVhkbpwlSMGbuV70Ft1E5777SypirBgD4FkedtZ1Wjxs03QRq6Fmup59Kwq4O/FP74YRDQNgm36mV2NlCMgBGLIVqcfXOTM07btHKk7j/KRiwmj0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=z42VeGru; arc=fail smtp.client-ip=52.101.96.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TohsxdBIOgpDr8RViM7yp75sRD3r0oExuAuvfUsWrgXaOpLhpruVCPIb6+KDTR5RCQhLDykrEgyNYHCcu6KciypkHPZyRNwUnTUjZRiyMzTR3gN3taWnHyneEquabdFYgDHat2fAV/VdpPxRoWILc7UxmBR3AhoWtT/maHkx7AHIZSqjtqIIdYl8QVAy1qZ4h4FiliGrYoJH/OOy1f1LeRPPOvnKBCn45cck9XEVSiWExMkkBAq7SuD0qU9lJUeOUj0K2aeRgoxaJdCac007wrQfDRjsE+WZvSsyd3Wv3WsXLTRNhNzLydw4g/drdXwCSgZEBx42Br8usHEEhk048Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKJZ67QQ885SkqS0B0nB7uW1qr5umZrpZ5Tc2Hd5MW8=;
 b=JI5ux/4Lp5FKG0f2uYOOe5mXpoRjWgAt3ImXTdM4/TogmjRamimX4GP3tE6Y6YCpOWptu5kc8XGWrKPu2Xv7ipQRI/ZFnYEpz8egGnqItx6D/fL1+d7e3GITP8AjEHt5G8Y1UZPsZb8NOz+IN946/pyAGhUX9riBMH5yQAbgpvnG9zNMes8FnoCcnHZ59Hkvntj0Cu5LHYXqv6gEooRAEyk5bDgPxra4xcGMk5/mlryxUtHSUNKNgx5gPGqCCefSCazmhW7FgdT709NhlWR8xFusrTZs8egS9jm00fcg3oNFzI3+b2uyB94oM4GYJNMrr2X1KMrmfQa2lmqZ/dJWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKJZ67QQ885SkqS0B0nB7uW1qr5umZrpZ5Tc2Hd5MW8=;
 b=z42VeGruNK4lmS1r+HGwadOmX3eK86J2QcZB+5fndA7r51s8JEmXfMA93wZw0UEEFP0SNSkatsbfYI1ah+06QuzKc8sSPNb6wF0SXyqBFKCWGOG09NmQUbjuJj2P+MxZWITAZjqtuN3c65wZ5HPUJf0eRjevG0zlZMFgUfS31hg=
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
Date: Tue, 07 Jul 2026 13:26:42 +0100
Subject: [PATCH v2 3/7] usb: serial: spcp8x5: don't store usb_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-usb_dyn_id_uaf-v2-3-632dcf3adfba@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=1552;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=H5JFKotXcRvBL+j9x2gVWjs5di3esqntHjg/n1H0gL0=;
 b=P77tZzMnJYZxzDerSi4XVJcO0FMK+FnQt7iSZRf88ngqZR5Pu+Addl4UxgGA9ZA0cREr+5UFV
 6W9EZxeAzNsB6mzcy6Uw50sf4JFew+UYZXlx6g0kKxMdqUL18YRSBzi
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
X-MS-Office365-Filtering-Correlation-Id: b3803309-9abc-4c79-b58b-08dedc230986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|366016|1800799024|921020|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	iBgRhaO94C7HyKtHQ+28p9hIgLtM11+cgntsD+nQrCDUjBLC7j642xf8q7MObKBWGWRxxjgfR2y4YL21uOa9vkzUUkjABfwJZiD0xfijVJKMm9du+LnjoDPc9QrROaxDddN+YI7dNK8gGrH2Y/QRwihOrQ4JVE12F3GWMpMsHU0Qj3GaPUSYXOCrIOsCSr5XmmqOslNWTBPh0YmyVAzEcFxVRvV3oNULSM2I4qvl1e4/loXpmpslxs1E6iheatMWocZD7FdbvIp8QRKjftZnoJlu2f0gJsNbNfl1z3i7yHpBYnPikkWZYQp/T2T932DWAdmP1AAyVugeVfdLRzR/OFWi1S/Bp/mSuueL35ORBcpEhousbAS9moQrdQDgRuUXQ2n7lyW+fD/TC1q3sFJQze7zdW8PAlkGQhAsYURbugSnxdrzDy3D6Ydxt032pCP+eaQHH7vD62bSvYTmFFhIdTByNl/foO0VbSvhTrEs97xho6lJBMcK2XyZxBqyWxJlaaGEFG3CEsLvpeYfoddu01dmEKcHm7q4OdYnwoFRYa2AdxLaQB/SCwX01JZB4kBFLfl79JT5OjjVvUXMFwhyLHzzh3CLECGUe3VmoQ7PuhWflP09DlLqwMSPsBtmYUIBPzZbvVnHljGlmuVafhYNaVjGdXbJo7qY0SKp4TbPcZCV/21/m0B+4IAbrVMuOHuUImP5H80xHI2NtTkCSz4BBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0V1K2JqR2liMEFXTVU5T3ZoRHM2dUlkUDZwSG0wcklsSHhQd1RRQ3prTm1t?=
 =?utf-8?B?QWhTTzUvaG5VZjZFQlo1OVRUemxoWS9mMGRSbktpRUZza3hrMDE4N1hxVHFj?=
 =?utf-8?B?RTl1Z3BIbm9YTERaZTRyN1VhOUFLYk82MGovVmlRdUd0TEQxd0I0YmtBclMx?=
 =?utf-8?B?Tk82aWRndERBdXI0MFg4L3lMU0NOeWdOTkRyNVdqK2pIbXBiZjN5Z3lMYUtE?=
 =?utf-8?B?TFF2d25ueEF0c0wxVmJKN2IzQXRaY1VpR0kyWmtKU3ZUOVZXVDB1bHF5R0Qr?=
 =?utf-8?B?L2NlOTBJNWFWR3FJeFNHQ1IwQlM3dHVxZ1AzQzU5L0FLdjJTNVVVTk1BZ0tv?=
 =?utf-8?B?cFJ5SUdqd01FNjRPdHBwUzJzUGRRUzRLYXU2ZVAwdkpIaEhIYTNWbm9XWiti?=
 =?utf-8?B?dTlsQ3JjMnE2SlVHb0xEdUd0eVF2QzBlUEFPZ3BaWEEzc2NITUtTOFora1NU?=
 =?utf-8?B?WGRuYjZKTG8wSFJWdTU5Nk9uVTVTd3ZSMmFYLzZIVE1ja05vUGJvSEVzRlYw?=
 =?utf-8?B?M2tSNUUzWGdLRzhKYjVaWStEbFdKRVRzVUpRdXE3Y3BHVGtENkhOSVlOb0NK?=
 =?utf-8?B?VEhadmlhbVFFKy83bVNWdVNXWk5MekV0VkdPV3dGMzdCSEFyaGY3aTZLbXhI?=
 =?utf-8?B?WGdtZzN2UlR2MDZQb3VDOE42TVBGTkxITjlxeHpHbDF3c0piOEFhbUdPWXhi?=
 =?utf-8?B?Y2pFMzRPSTNyZXJVRmk2cFVVaTlrUS96YzU4Q3YvU0dJZEtzTG5wSUtCUUhW?=
 =?utf-8?B?NjJNQVA0eERwSlU3RWpsK3JMaEYxZFM1bG02VENhVHJMMHI4K2s0ejN1WWRS?=
 =?utf-8?B?d1p0dmdTR1phV3AzQ0kyTk9idXdtMHY5dzJPTnVjWXdDMmxUZUJJcFRVTWUv?=
 =?utf-8?B?bGlBTTJPM3ZMcUVkUksvZWljbVhwNmlKUUhDcEVWdU1pTzlMVU5LRnV0Rkk4?=
 =?utf-8?B?ZDZMeTNtRXJINFRFcmU1c3FHQXZJTDBHd240RmFmYTdMS0MwRWJESk5zRGhy?=
 =?utf-8?B?MG40MVR5aWtOMER2SEtLdXpVcUh1czNIVUpNZDB1OW4zd2pRaUo1bE5SRXdz?=
 =?utf-8?B?QzFMS29QUW9jWlZjUGFxZnBCdDcxWjlvVGozSW4zMHRkMG1OK3ZBV0lwd3dj?=
 =?utf-8?B?clNlbC9lOXVlcUoxazNzdVZ6cVB1T1hvbXJ2RVFBWmJ1VU8ySUJmOXhha0J5?=
 =?utf-8?B?YjU2dUhXZ2JtTXptR3RtSTVtd25UUTdEbHFvSmhKcmNvNms4ZVA2TDdmT0N3?=
 =?utf-8?B?TmJveGVrbjZQNHdLbS9SV2JlVFBGQVh2SDFwbnB6QjgvNnNxZmt2R0hQR21q?=
 =?utf-8?B?cG83T05aMEh5cTRnbnFmUUV1RG1GelJnbGtRL3YzcWdMTk02ZmhicDhWN0JE?=
 =?utf-8?B?Zm5EV0FCaDRmMy9vbUFWSDNlL0U5R0JpcG1KYXFhZUFPcSttenJST09HVlhZ?=
 =?utf-8?B?NlRndjZNMURYZDdSVmJ2Wm1vYUtOYWl2dWpXRDFTbWljMXJzSkZweWhWVklz?=
 =?utf-8?B?WEw5SkNNUWhIdXRhK0NEb0F1QVNHbVlqSVJvR3BqRnNVVzFLZVZuMkQrb2k2?=
 =?utf-8?B?cmNWNFcrelVSbDk2R1pSVDkvTmcxVG16WVZDVWpYRkxqYktSTmtjWUc4eFZL?=
 =?utf-8?B?VGpScHhaWE1keHVxbWwwREZCVVlRR0NTMlRqMmtXS1JpSzlidS9KUUVJOVJJ?=
 =?utf-8?B?NnZEUGpld3kwSGxMYzg5VndtaXhDTTc0c0VGNHhEZE9QemNrTDJjOVI0ZUVQ?=
 =?utf-8?B?eHNoUUg4WGxTdzNjVlNscEh3cW1rNkN4RHR2aUFnNTRDNFZPVml5SDBTc0gw?=
 =?utf-8?B?OERRbjU1dVhoYzF0aXh3SXJXTS81YnFzY1VSMTJSOVcxL040aFJibWw5Y3lQ?=
 =?utf-8?B?dTVkejFZQ2FVcEwwbmYrOTArYW5KY2NIaGF4MmRjTGVSNVhnY25JeTJuMktZ?=
 =?utf-8?B?R1Q5S1FNMUFrcDhyMUhVRWtQcHQvb2ZnMkxHSTZLeGZRQ1Q4ekxOV2V6bTc3?=
 =?utf-8?B?UWR1MllnQWhYVkZteVZxR0gwUWsydWRHNm9OZ2dmbkZDaDgvRU95SkVlU2ky?=
 =?utf-8?B?cEM4eHNieVBJdFQxZGJrYVdNakZCSGVrZDlIQWdkMStoT0xwdGJuYlg5TmpW?=
 =?utf-8?B?bUJVaytDZnIrMDhxWmt5VTFGaXB3OFJIZjV1R2lROEpNWmtoVnk2TzV3R0RB?=
 =?utf-8?B?ZUlDOWVPa3BpYnZ2REtaK0RRSE1KbXp0a1pwZ2NsSGRUalhHTmxqcUVmd2dU?=
 =?utf-8?B?NFc1RWZDUml1OTRzczZlOEtuT2xsczB5RFBwUDlHZ2V2ZFQrRllwMkIvbmlu?=
 =?utf-8?B?VFBiQzZReGtmVDEzUEY4R01icSt5L2NkOFo1WFBaU0wxbys4QkNvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b3803309-9abc-4c79-b58b-08dedc230986
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:57.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR2/SlvL6TxTNo2cvYalnOFnH+ugagL+PaWBtCnVb0+VZ8ritgx+MRPBKbL1t615t9mIXpRl1I4q0BWUVNV2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38758-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailbox.org:email,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D73D71B697

USB probe functions should not keep usb_device_id for longer than probe due
to presence of dynamic ID removal. USB serial does not support ID removal,
however in this case only driver_data is ever needed, there is no reason
keeping the usb_device_id in the first place, so convert it as well.

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
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


