Return-Path: <linux-wireless+bounces-38754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id USpxAMTwTGpWsQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:27:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C471B55F
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 14:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=NkjTX77T;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38754-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38754-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F0183043540
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A25D414A2A;
	Tue,  7 Jul 2026 12:27:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022114.outbound.protection.outlook.com [52.101.96.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93140D584;
	Tue,  7 Jul 2026 12:27:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427225; cv=fail; b=iaX6U9FEcy9k+3IAwSaiYjIOQkl4Gg9xoRvfGgtxi76zmp0bCuLSwysb3wdGGx0VcA75QeVjA2afPozYZXxMTWvE/9Cgm46pNnp8RG8+vjSKHcgLg65yPlFcXGuqUip3gg0bmFuMAT3Sb9S6QKFpNlkx14IVe9bxDFJIw/vbtIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427225; c=relaxed/simple;
	bh=MY344ZBkvl4oVY8DFULxyHU0G7xkS/g5CVEgFIVkYJ0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gsimp792Gv1Sprce0qiVBtF3XfI7ePuJM7GeIYxIB2Lavvwq7D+22ibQPHdie4s0xCNASsZv73KbolyzfYmRMa8wBVZTp+sYY4djeHuudfA+VnfTL7Z2mP3RCXQ5kNE+Eq9pRjWdcfkxgNexh79LnoZVo1OYywT7hqgYSzWkVLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NkjTX77T; arc=fail smtp.client-ip=52.101.96.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZcdgxlOv5eEaJ3kluh3nLgZahKOIB2Vwc+U+o8htOuS30uxZ4Kuw1BhXXgpT3Nr7yryG2QxVBt/xrAgPQ5+dFiBi7yh90E5z89LlZ/Wk7joQdEiMRtfhJqYQ/V1Qy8KxzZNlZWj9cqX5iLJ3h/avK1NypgKzNTakZlha6AQyzCyaXuyQC5/EWpqybwV4jAaB52qbdwyPNSeCLkOg39VoJ7IGsRfa+AxGZIHC0Pvg89OxYFLr+I/dQBYIrzWc5EB0uJ78MhSFeUY/mJRnogBZPX5JMEtVMbskebP6j/mBUzUs+S61CYI9VAznVtNRlFa2d/FPtUQHKdiUAqZG+08mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+8c2pqm7TxhAkJj0S8VZqH5oyrxGZF1+5gmkFa8J4w=;
 b=E++CPYSrG9Qp3fWGRvRQZ2ccxOXNGAIIeQS3JGrESL3nK4UrgzUEXgccHO/X75tLQGtYah2OIfqOSV4S4gkDYzK1wGaWRpvnmF+2kPpZu/BfTfVFmYh46z6846/I13r7nUYUiQQoWRRRuA4qLdRUCuaJuhdF07m4nWMNkM0LovAMDY1BV70dotd68nwBPLTeTJHIWFEb86MhhzejfCHcqSbHmSeq0C5MrtB2iy/4gDnB2o1tGEfx/WNo9TVPFkZqvZ1MX4IMrhFO0gTHse/MNZXG4vDHAQ3sICKib6H5vIBcYeyxwvvmJY2LuTdUsn2+Myq4OHDpe5QJDJW89AmUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+8c2pqm7TxhAkJj0S8VZqH5oyrxGZF1+5gmkFa8J4w=;
 b=NkjTX77TreZQD77c1YDQaDT45OZ4R0XY7oe6eCiYFPjyEyYL+TmhKCdSieuxQO7hj2RoNrvpm0OEwrUl2kgZ5y5RazoI1n0nd0wxEYFHmvGsPTaC52Pq1PVZQL6I/htigEQSN2ue70N+c1Js2e5yO6b5GnCuFDrhnbSPDCaiGfc=
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
Subject: [PATCH v2 0/7] usb: fix UAF related to dynamic ID
Date: Tue, 07 Jul 2026 13:26:39 +0100
Message-Id: <20260707-usb_dyn_id_uaf-v2-0-632dcf3adfba@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/wTGoC/12Nyw6CMBBFf4XM2pq2PBRX/ochpNBpGRfFtJRIC
 P8uRVcuT3LuuSsE9IQBbtkKHmcKNLod5CmDflDOIiO9M0guK17JmsXQtXpxLek2KsNqXZpClPn
 1ogvYRy+Pht5H8NF8OcTuif2UKskYKEyjX47HWSTvF8/5f3wWjDNRccVlh6Xq5d0qv9g4nh1O0
 Gzb9gGEZvvBwAAAAA==
X-Change-ID: 20260629-usb_dyn_id_uaf-9d5f415387d4
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783427215; l=4097;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=MY344ZBkvl4oVY8DFULxyHU0G7xkS/g5CVEgFIVkYJ0=;
 b=qy+QjZSVDIh20pp+e9QDUvn4fcj3e0eB7hA6bqxOQnLGtVJKrIrz/Y5A46LoABv97cHdQHGGL
 48a70gQ7DFpCfXhZqmqzA8yNoTz1i+F94S8THdknoTu0FH+6jeMILd5
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
X-MS-Office365-Filtering-Correlation-Id: 7fcdd5e8-f869-48cc-0389-08dedc2308bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|366016|1800799024|921020|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4hPB1FzrbvF4VobAcyoa2VUd1QNxYGCZZeS5WKNrvqwOOxz4+HoFAPIgaOLbjgmFxooIJGOAEcgwePn+XSPreplvqahzjTx3Ylwp1FAGrr5OegZXsjnsPduN5ur1vQaMzCfytCOwiXiDAFqbdpAd4BQo7KKHfCvVZTxm00ei1D2B6eU3tDpCBXJZ0x5fA6SLBQ/GALRzC9OH4uPj9YzFRzO+bFE2C1GETWAB9c76TGgbv9PdU5SvVEmImFECj724Rr20G6L85mbTc8l5U3p+J+gxPtnxeoXL2z1XvBMqxS7lkOshlrZmXyfiZuRfvn3OWwl5ATwI6TQCKQHj69u0KDw1b/Af+Uy+cmSu6eoyW2sfLvxVWNyva6D8eIyT/u5nLu7Yk559aAJAxpR7fDPnDa8DWkmXm6WIHTbQzyF2lFPjaKH5RMQgwGSChYJYBcOXpqbnvgEsR8a53u87rA3P3FqXABVX0ZU3KEHLiShHL1oQT0IQYCg0P9RotDFlFfIClzEesq68SiBF+zds407d+n8b8ufr+TB09leb+vlqQS0msxYFNnfkAdgRRqsUH6q7ppNQ5gMIS9DU6ftbCcoWs3ryyW1cVreUhjZGBLk9cK61XZ7O7LPPghwCZAT/+DmTzCvqe37vLQxuSR/eHh4PGiYpxV3oNe6m2rFmOEdjVF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(366016)(1800799024)(921020)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJvWGZySFFPUXcyZmNGTk1rd1BOVXZObU1LU0orRDhHUnJURXdMQzVEWWhM?=
 =?utf-8?B?dXFwTW1lQm1wQTBQY0prbUh3bXFUc3I2R0hIK0hLT056V2poMW1LWFVUY2Qz?=
 =?utf-8?B?QWltUjdzOHRBQVFLeVZLOXBkc1oyS1pBNDRVOXU5RWpvZ0poZ0FGOCt5cHRy?=
 =?utf-8?B?K1pmWTU3Q08wOUFTNmdIc2ZwYzlXTkkyTnRVMzdyN0pXZk5rNEtCM0h2bWow?=
 =?utf-8?B?TjBPVWFxdE91MzZqaXlsUFYzYUl0T1NON3h6bEpmRUo4SysvNGxONlZrY0RJ?=
 =?utf-8?B?dUhzRDFkenRkTDdRb2VxK0NWeVJrRlNnaWtCSTlKem04SGUwSVh4YzIrRnB0?=
 =?utf-8?B?WVlRam5YRmhEYlNqTnRTemtpV2d3Rmlsa0RiSjdrTXY4cGltcnVWZW0vRk5W?=
 =?utf-8?B?R1kyRm94UHRaeWw0QlBhaDAxbEt0UkQxUmRFeHpZY1dOdmZmZWVVRXliYmFr?=
 =?utf-8?B?aEcyaFYvTzhYc0RjRzdWYW0ydmIwajErU09YYy9Scmg2ZjJGOGdCNk90enA2?=
 =?utf-8?B?M0lmOVpZUFZTaEoyS3NRdTZnMVQ4dGxML2Q0WG96cE5ybjVQa2x3aFd2dUNo?=
 =?utf-8?B?M0l2VWNmVlAwK2dJa1hhR0JVYUhIT0NCNVZNa0tDNndaUVNyQ0RMZ1dvOG5F?=
 =?utf-8?B?T0ZYMnlRa214TmtxRDZEckwvTnh4WjhWRW9MaGh3cDU2OEdzZ1RmRUx3MlBk?=
 =?utf-8?B?dEZlZUlqcmpwMzdRMXF6K3BDVXpxZFBWOXM4Zml5ZFgwdjFUa2haZEJzcVAv?=
 =?utf-8?B?Z1RSOHVLa2UvTzJxL05BbDE4SGpuNWw2M3plR1UySHF2NFZFS01xUHFxTFNE?=
 =?utf-8?B?N3ZJSzc4QlZLQ0swV1RlSFhaRE9DK2dJa1FaUkdpeVF1eFFvZ0c2OC9acGRp?=
 =?utf-8?B?VFdHNVUraTFJajhBTlJCRU9pQ2Z1b1JxbFZYMFZIVzB3bkRYQkJmZTFGT0dr?=
 =?utf-8?B?Y2taTzdsUDlyMkdwdmFYTzNtZWVvdkE1blRaNWx2NitndWM2WUtERDJSaTlZ?=
 =?utf-8?B?WmF2ZUxyZFZFMzRpQXdPQTE3M1RXOG50aGYxODZJNlovcjhTRGJSUm5jVXRF?=
 =?utf-8?B?QmFSQnczc3drVlJ5YXNUTFpQZXZvR29QSUphRHZCNnErZ1V4STBnN3Axamc0?=
 =?utf-8?B?NW8rT3kzdzI3elp4bXJqVVgzTXRNNGc4VG9QcFZsajZVQUgyS0xTdUxkbWth?=
 =?utf-8?B?Sjh1bGFzTmpJMmh5Zk1tVGExNUZjTEZZREJYakJjUndONlVUa09Pa0IzTEVq?=
 =?utf-8?B?S1UxV1IvWlVQOFIxTmo2T0h1eEJwNDZLQXkrK0lqS1hlUE04eVNtQ2dhbFlQ?=
 =?utf-8?B?RGxGb0V2clZmWFk4ZllvanVoV09Ca0Z5dFJPa2ZtTXFDZC9aSXU3bkNZRGxL?=
 =?utf-8?B?ci9CQ1J6aW1MM1NhT09UcWxXSDlyOXFzaTVJaVVLM1IwL20vSDNCOFFwb1Fx?=
 =?utf-8?B?TGI5ck1VQ3dsMHAzQXI2TjVrZUhiKzVEWGdvWHJDK2hxd3hoZFRuaHhIZ1ZM?=
 =?utf-8?B?UEF0dEV2M3plTHMzMjM4S0ZXcy81c3l5RXRhTWxoSWFaZ2dCQmtlRnlCSDNH?=
 =?utf-8?B?U01YSStoOTMxem1odHVOOVZtdFlVK2xJd1Rjd0ZYRFUvbXhyNyswUklOQWQw?=
 =?utf-8?B?bkVMRmNsY2ZFbUxhM1I2Yy83YlduZ2NydXBvTTkrWlBQaDUwN0xnSjEzaFlr?=
 =?utf-8?B?YlF6WmtNZkE2RzFsYjA1WE14WkFkRk1QNlhYdWwwMkdDNW12ZC9kZ2p5Mnhy?=
 =?utf-8?B?RVF6SngrZ3BheWZMbW1qaXNDOE50NWVXNFdBRlF4TDZKdTFkeXdHSzFSejhl?=
 =?utf-8?B?K0s5T2R5QmwyUHRHWUxTY1grYTVXK3J6cUhIYitjWCswVTJqK1JpVEx1QzJS?=
 =?utf-8?B?dmVkVWY2NzZEc1ZDV09JT0JQdWhINXA4OVZNbHdYcm5VVElMcWNINFpDczZo?=
 =?utf-8?B?UDdGcmJvOWYrc1dNMUN0NE43OU83Y05GUTBVVWFUNVhQRTlQalRmd2xtY1dy?=
 =?utf-8?B?WldrckRoZEJBV0RWclNZaW1uSVB5T1NIMzdxdVFqZVhpdkFUUzhGLzBDeW1Z?=
 =?utf-8?B?Ykxma3NQcSs5Y0hPSkVMZURWaGVZN3lGcjJvb1U0K0IyQmtNZXg4cmhzNWUw?=
 =?utf-8?B?amJlazJqU01JSWtRVGcyQ1E0NTVRejU0a1NhbEh4N1J0TU5kekpvWTZCTDdl?=
 =?utf-8?B?N0lLMVNJZ2VSOGNaVG1leUxiczJkMitYMjczTnVqd0pkTENmdVpBTGVhcm9M?=
 =?utf-8?B?WloxU2dnaWt5Ym83UWFNYlI4YlY0UVFlZlIrSURSeU1UL3pNQ1U1Sk9hMEgz?=
 =?utf-8?B?SmxuZjJ1WXhNajBRaEhNK3BRRUJmNlpwWWl6ek05cnN6T05Va3pXUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcdd5e8-f869-48cc-0389-08dedc2308bb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:26:56.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUW5F4ysJ7RP8gIksF8urwEjDpFwC6jbd9gdi1H6VEwU4nEJcv+VcOEylYw1W/Lj2xWzf3WeBDu107MbtK0AUw==
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
	TAGGED_FROM(0.00)[bounces-38754-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 805C471B55F

This is the USB version of the dynamic ID UAF fix similar to that of PCI
[1]. usb_match_dynamic_id returns a pointer to field of usb_dynid, which
can be freed when dynamic ID is removed via sysfs. It can be triggered with
the following sequence:

    echo <vid> <pid> > /sys/bus/usb/drivers/<name>/new_id
    <probe start>
    echo <vid> <pid> > /sys/bus/usb/drivers/<name>/remove_id
    <probe use ID>

Fix it by making a stack copy of the ID. This does mean that the lifetime
of ID is scoped to probe (which is already the case but never spelled out
explicitly). Drivers use these device IDs creatively, so this series also
fix these drivers.

The following coccinelle script is used to find all cases that are deemed
suspicious. Only useful case for IDs should be access its fields, or
forwarding (without type cast) to functions that do so.

@usage@
identifier fn, id;
position p;
@@
  fn(..., struct usb_device_id *id, ...)
  {
    ...
    id@p
    ...
  }

// Due to cocci isomorphism this needs to be explicit
@bad@
identifier fn, id;
type T;
position usage.p;
@@
  fn(..., struct usb_device_id *id, ...)
  {
    ...
    (T*)id@p
    ...
  }

// Good use cases
@good@
identifier fn, id, fld;
expression E;
position usage.p;
@@
  fn(..., struct usb_device_id *id, ...)
  {
    ...
(
    id@p->fld
|
    E(..., id@p, ...)
|
// Redundant checks, but ignore
    !id@p
|
// Redundant checks, but ignore
    id ? ... : ...
)
    ...
  }

@script:python depends on usage && (bad || !good)@
p << usage.p;
@@
coccilib.report.print_report(p[0], "suspicious use of device ID")

There're 3 drivers that store usb_device_id, and they're converted to just
use driver_info instead. The other fields of usb_device_id can be easily
retrieved from usb_device via descriptor.id{Vendor,Product}.

There're also a few users that rely on pointer arithmetics. Pegaus and
xusbatm are converted to use driver_info. All unusal USB mass storage
drivers rely on pointer arithemtic to index into a side table, because USB
storage subsystem is using the driver_data for flags. Luckily all these
drivers set no_dynamic_id. Ideally these could be fixed too but their
maintainers probably have a better idea of how.

Link: https://lore.kernel.org/driver-core/20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net [1]

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v2:
- Add le16_to_cpu in ath9k patch.
- Fix AS102 which relies on address comparison. (Sashiko)
- Fix pegasus, xusbatm which relies on pointer arithmetic.
- usb_device_id from static ID table is now not copied. This ensures that
  USB mass storage subsystem can still perform pointer arithmetic. This
  also addresses Danilo's review feedback.
- Link to v1: https://patch.msgid.link/20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net

---
Gary Guo (7):
      wifi: ath9k_htc: don't store usb_device_id
      usb: usbtmc: don't store usb_device_id
      usb: serial: spcp8x5: don't store usb_device_id
      media: as102: do not rely on id table address comparison
      net: usb: pegasus: don't rely on id table pointer arithmetic
      usb: xusbatm: don't rely on id table pointer arithmetic
      usb: fix UAF when probe runs concurrent to dyn ID removal

 drivers/media/usb/as102/as102_usb_drv.c  | 73 +++++++++++++-------------------
 drivers/net/usb/pegasus.c                | 54 ++++++++++-------------
 drivers/net/usb/pegasus.h                |  3 --
 drivers/net/wireless/ath/ath9k/hif_usb.c | 12 +++---
 drivers/net/wireless/ath/ath9k/hif_usb.h |  2 +-
 drivers/usb/atm/xusbatm.c                |  6 ++-
 drivers/usb/class/usbtmc.c               |  2 -
 drivers/usb/core/driver.c                | 12 ++++--
 drivers/usb/serial/spcp8x5.c             |  6 +--
 include/linux/usb.h                      |  3 +-
 10 files changed, 76 insertions(+), 97 deletions(-)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260629-usb_dyn_id_uaf-9d5f415387d4

Best regards,
--  
Gary Guo <gary@garyguo.net>


