Return-Path: <linux-wireless+bounces-38363-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QIFVLMqsQ2pCewoAu9opvQ
	(envelope-from <linux-wireless+bounces-38363-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:47:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC96E3CBF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ML8Ldh8G;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38363-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38363-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB68F3014210
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBCB408622;
	Tue, 30 Jun 2026 11:38:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CD403EA1;
	Tue, 30 Jun 2026 11:38:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819511; cv=fail; b=aR1vcc2Uv5VRBns/lTMbfvydrvGmYmDxXZKzyA9w8bxuptZguW4LwM3bE3CSKTUncT2gjyVByt3tKlCjMYtS22eBN+gRUCXVzTQa+2Nm50pxqVhBYWe/OcFQO7gddJLtsj0Sb2zEhShYqQqaFFXX3xtbxA70dgHxE3UG0Ued9NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819511; c=relaxed/simple;
	bh=D4bY8Lr7lyIao1yb/wxDSv9FcbfIwOOUq+cOyNTkddU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=usvx5Day+9Hrs7DwNuNzeLMo8UiaVMVdnfgni2dZKIA0TNOELWiVltW2RVEgG3JtQTPrHtfZtehvTA081IyGPTADeRQkJO0Dwyqy5gpGm2Y7ay6J4HPWUFWRcgxzAGNTK2YKZcj8lborlPl/FDdeXpEIVamtQ+5CYB/9Mg7ahlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ML8Ldh8G; arc=fail smtp.client-ip=52.101.96.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUULPq7+ZV11iz2vQL/3A8pJdZS0Qy5WyL3R13cd3rvN6apPWBMhUK+agOQ+FQgFYJZ4zjbGIF1TprF4w+T20e2cHxuKe5hANyGoiY+XubVuF7mKObdA/KcWzG2eIoHq77iEQZZa5k8wgTH3QNzPaUJQq1q8uJDDRl3wM0hEZRzwL5fPlsrzakHhME9kBNliU8Iy6cGpXIGIsCqqs3v5E64uGnTkAchnKfaHkTisio4zUEjfzneBfDp60DQJUHQhugWZzpo/jCNoTbyusrUUfSmmkbeVOQFhLBI9zXGe6BMx7KOvWmriA9Oy4lpE9LuvkoRebZ39C8CywgbRFsapfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pBXddp0gX9wnDxNOIWcbj9tzIZDCbAIDQ4/hQV2TA8=;
 b=Fi717HDDWWrjuV5x2ofHNLI0jIeRKGkYTVp7cYl7dgwiv7+mFKSOUzegV1gq2o+F9LDzQ7tmSKtezWM2ZJKEpzwK+6CYmk1kv5GvC5HNTXPF+tl3LLSsPPpWVQjnLTZmY+Oqd3faqec2k605oWb41oH1EeyEhlZjU84/p2L+mQXRu1AvYvro4sppsbvz3AwUokg/EgQjYPzcPlVqLxHC3rXGTuAojJUQqgkCLRBU4fxGAMLe1305w6TIjidLhEEA+cFjjge6jPBv/lZfA0pfXUDi5oqXrD1ffd/uT1fyl23jSb79EBvsV2NgOQw0touzAe3mj0W+yLbcBlW0YRtGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pBXddp0gX9wnDxNOIWcbj9tzIZDCbAIDQ4/hQV2TA8=;
 b=ML8Ldh8GGrUYKHKuK5/L9H7wE7C9Wb4JPH1aciMWTwGgZn1/135JlRiPVTC/hNCb4e2QfCvE/NNgl/noKUcBQyFOSmOEldTKsa78vL2ls4Wlw/St9iQApMK9uOKr9lvyBk+u+zOAbb+NlsoYx4zWxoNweuK1qrA1kHHPRLcygBY=
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
Date: Tue, 30 Jun 2026 12:38:21 +0100
Subject: [PATCH 4/4] usb: fix UAF when probe runs concurrent to dyn ID
 removal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-usb_dyn_id_uaf-v1-4-160a02be5ac2@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782819504; l=4069;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=D4bY8Lr7lyIao1yb/wxDSv9FcbfIwOOUq+cOyNTkddU=;
 b=UMCIi2PEqb6kP1hFBbuNqZbmDSxgoeDklgMwfrPvmqxqzcgwtAobsFPSztXfawAeDocuDSxLM
 7TaQ46YqlpnA9lwyUgazrV8lSJZF0nwDSkKQSQ9OS3HtwXQO+uT3yTv
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
X-MS-Office365-Filtering-Correlation-Id: e18bdcc9-8dcf-4654-010a-08ded69c18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wBcPIz9DIdVbHoOmWXAy4iwAP75MybsocZwHWs+LtP8vLOM7yC8Ui7mClPBge1Fgr84DiZiQ3zfjCdxaCyjQ+ODsSbEFfDjsP9qd+dObI5MWxyh9XfKf0F2J7l7LnXLwOaJQ792H4SkqtEq3eU/VXO79rRzximwsFKVAJIaLkOjF+9NZGlJHOxWRA6olc/sQa8D5cDq4kSilzrLZatgLTNKcesMMhD7cR3+GijgE5aivK5wKBx7jMSUYW7hbdpD/7Y7bSLp3/CjCbzjgFDha2kD6oWuGTR/wMxmYRaHh2lUEGMP2MyGorCErqSX+GOzltzRfGIbBECGQK+pyLjfDGJ729GUiuM6l4dIhovMI7bGdEItGX4VxKAwfY5+KT2eETvSzkvbRRijK7jpvyqNHOLEz3Mvsuf7d/FFG2Q75oSJpLwtBC0h2BB7yPsz2snyMEyOHam+CIIeR5AIXHcB7eGTnuPX/EbJgd74IYG02eLYxXH2q59rqcWqrKMgbBvHyKs16gq1jk+0zprO3cav30Wy9DuiXCLpmt/gXGR4PPlur/J9VMx42OKovSTZuRClmOVdv63R5PIlaeo/G0dW5/BB80H2ozMPZtIHj/BFlqNHwTIiBOvLViLowws5Kds0qBqMaS/1n0LYRFw2Ad850wgs5dMGOvB7YOOP9uMCTnSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tSNjVtdmVaQ0lZd0JMVGxXSE5KUnk5cmJMdlY4SVo1VDh4YitmWUkzZmp5?=
 =?utf-8?B?cldZM1BCelNaaUgySzF3UEY3Vk1hNHlLSEd3QnRwb1pmYm1WdlJSYUt3OEMx?=
 =?utf-8?B?UXZDUFR4QjdZbFNmS25YcEdXYTNCOEI4Y25ZSU9sYU5MZ0s4T2pEclJIcXRz?=
 =?utf-8?B?cVFiYXpodm1GcktHYWZabHo4VHRSOTNIOEZ1MVY1bE5nY2pjR1cxbkZ4SWZM?=
 =?utf-8?B?a2RScmtRT1BVY2l3bVl5ekFqZ1ZGSm1tTkV5VjlNekxpZ1dPSDBjYVJYdEVo?=
 =?utf-8?B?cC96Ykdxd0lob0lCNTFNU0JNMHF3TTdOZU4yZ2tCbHFYS2d3UXdjTzM2UU5F?=
 =?utf-8?B?M0tiYU9janBnN1Frak4zbDJHelp1dEcrSmRacGt2dmN0QzZjS1VjZm9JR0tp?=
 =?utf-8?B?NlBRMXVBbXhRL01UOGJJZStBa3NuMGcwNmZILzRrb0Z1SC80aUs2QUExbDdx?=
 =?utf-8?B?U3cvaWYranpYVWl1eHdvT2p4VHhQMzRPOGtJV1d0NW41TGpzSEcyU1JpeXpT?=
 =?utf-8?B?bEordVVHZkYvNXVYY2F5TEltNGJIdHNMUkI1YkgxWEFocHVidndGSUtjK05O?=
 =?utf-8?B?NFhiekl2MWRnc3EyWW0xbHZ3NVdFM3NLbmtKZ2pCakYzbU5VT3FrSzZnK09j?=
 =?utf-8?B?TnlRNHRYSlczT1J0aC9zU3JQU0Q3Q2tXTUdQeFYxZGlWVnQreHlFd3h3c3h0?=
 =?utf-8?B?a1BndWQ2bGRqaXhWOEZnUW9tVE5vS1VrWExES3JRT0R0RFVGaUdZNCtycFFO?=
 =?utf-8?B?ZXNBd25VN0pIRkNFYXFTUmNrbmlEQXhkYzJ1L2p1eXFtTzc1RTkrdDJIWWw3?=
 =?utf-8?B?Q3N2Qm5uTG0wVzdzR0FHb1lFdDNlVzFvMVdicFp3dk0yWTVsRm1CMU50RXBB?=
 =?utf-8?B?TndhSVVRdlBZTjZ3blFIWUprbm1tZUx6ZjZ1NWMwOENRdkpPUWo3WGFJenJB?=
 =?utf-8?B?N1dKekdwdkpJQ1VsdWVyekdHT09tRCthSW1VSENqT0djWTFYODlXSTZ3b3Ft?=
 =?utf-8?B?dE5xcno2d3A1bzlEYXpzankzVzhEclpLU3k5ajVuUENDclJ2b3lWVnBQRGx6?=
 =?utf-8?B?NHZNOE8xS3BXcFF0ZW5XcmJOMVUwajJHTTRKWUpsV1ZiRGZEZzN1ZEtPeXdz?=
 =?utf-8?B?NmNkUnN6Zk5RY21aVlN4bWJDMFh4eWJIUGVMdXJWWWlBK3hsSjZHOVBnclo0?=
 =?utf-8?B?MFcydjJpalZoSHNEL3RjcUFEMWREMm4zNDczY2VBaWhhRlh6RmZzY0Z2TjdH?=
 =?utf-8?B?dWp4TFdRS0lZU2M4MGNTSXRmU2x3WVAzc2FiSlRpRnNTZTBNMXB3amZxZzVu?=
 =?utf-8?B?NWdsWDVCVGFETnVQVy95ZWNSUENQUVd5T0RpWmpnZVYzMytoWHhGK1cyMUU5?=
 =?utf-8?B?Y1VqcG9BRHFpa2xLSkYzRFJXN2p4bHVjTVEvSUJXQU83MUppNWN0clh4YS8z?=
 =?utf-8?B?d0oxeEg4QXgwdnpkOVh1aDFzSklJOGtMQ0kvTjBJQkxydW9mV2FmWWRZUUlE?=
 =?utf-8?B?S2FidW9FZitMZHRoR3QzTDlON3VRQzlON2FQNUQwUVhleUxxT0ZXOW1hcDQ3?=
 =?utf-8?B?bFBLMm53RmNsL2JhQXJEUS9FVmNSVEFLWDJ4MlE5MVlZUUdMRitrdmxYZkJa?=
 =?utf-8?B?bUQwa003eGs5MFVHLzY1UStDNE9qV1g2QlZGM0l6UjJ4LzRLTklxWmZyRUYv?=
 =?utf-8?B?WGpwRDlROFlxZ0R4a2dUWCtEczMySVVaN0NrTmpXaEh2WFNKNStERTVYeWRk?=
 =?utf-8?B?THUybUx4czhPWm4rTHhKNHlYLzRXWUNpUUZYWjI0K05zaFRpbDdMRkxFT3p3?=
 =?utf-8?B?eng1NVNMYTJiNmdveDhXaEpueTBuR2VLd2VWN0JTMlB4bGlpa1hJaFdvWW1W?=
 =?utf-8?B?Z0pJdXJITE5CQkdZMi95M2FqYXN4c0RwSVY0bVVkRFRjb2o4eHkxcThjTVJs?=
 =?utf-8?B?QTZJdzArdWtCUGVUS1dxUXVuTnRZQzhLVkFZcWkzWVVIV054N2tSZG9RQ1dW?=
 =?utf-8?B?UEx6b0ZtUkI3b0Y5WlA2MWdYakh6SDUvT1dBUzN5YzBkOWJiQ0sveVZJcUh2?=
 =?utf-8?B?RWZpbDBHYmJQcFhUcldEVjd4MXVJdTdBSVU4emVwN2NQUm55OVFQclI3RzdS?=
 =?utf-8?B?NXNxNWtCSXcybUJrWkFpTDlTb0NNb3ZIbEhlMGpBdkl1TVlIVVRTOXVrbSt5?=
 =?utf-8?B?ZGRWZEpzZERSa3RFM0ZOZkQzZCtiWVFvbytRdmZjT0NkWDNQUW0rN3VGSFVj?=
 =?utf-8?B?Qm1maWZQaFVCY0U0ay96RVhwbXNjRnhXck9XcDNnQUg0U01UMXcyWjFkU2pm?=
 =?utf-8?B?Ty9IVEhZaVRDVmNiVmNCbjM3ekRLdjkrTWFYYmc2NDZLTjNjbWVvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e18bdcc9-8dcf-4654-010a-08ded69c18da
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:38:25.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bh7Mx+x3g+9pgN6VO0js7yO+9G2H7prVNYGkHM54MAWJ986UpTJHZb9kiG+K6Lo43DgLf1YTmYI8qTgwoKAAmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7243
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38363-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBBC96E3CBF

Dynamic IDs are only guaranteed to be valid when usb_dynids_lock is held,
as remove_id_store can free the node. Thus, make a copy in
usb_probe_interface. Clarify the documentation that the id parameter is
only valid during the probe.

USB serial has the same pattern, but it does not need fixing as the IDs
cannot be removed via sysfs.

Fixes: 0c7a2b72746a ("USB: add remove_id sysfs attr for usb drivers")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/usb/core/driver.c | 33 +++++++++++++++++----------------
 include/linux/usb.h       |  3 ++-
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f63004417058..c26410cabdfe 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -227,18 +227,19 @@ static void usb_free_dynids(struct usb_driver *usb_drv)
 	}
 }
 
-static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
-							const struct usb_driver *drv)
+static bool usb_match_dynamic_id(struct usb_interface *intf, const struct usb_driver *drv,
+				 struct usb_device_id *id)
 {
 	struct usb_dynid *dynid;
 
 	guard(mutex)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (usb_match_one_id(intf, &dynid->id)) {
-			return &dynid->id;
+			*id = dynid->id;
+			return true;
 		}
 	}
-	return NULL;
+	return false;
 }
 
 
@@ -320,7 +321,8 @@ static int usb_probe_interface(struct device *dev)
 	struct usb_driver *driver = to_usb_driver(dev->driver);
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_device *udev = interface_to_usbdev(intf);
-	const struct usb_device_id *id;
+	struct usb_device_id id;
+	const struct usb_device_id *matched_id;
 	int error = -ENODEV;
 	int lpm_disable_error = -ENODEV;
 
@@ -340,11 +342,12 @@ static int usb_probe_interface(struct device *dev)
 		return error;
 	}
 
-	id = usb_match_dynamic_id(intf, driver);
-	if (!id)
-		id = usb_match_id(intf, driver->id_table);
-	if (!id)
-		return error;
+	if (!usb_match_dynamic_id(intf, driver, &id)) {
+		matched_id = usb_match_id(intf, driver->id_table);
+		if (!matched_id)
+			return error;
+		id = *matched_id;
+	}
 
 	dev_dbg(dev, "%s - got id\n", __func__);
 
@@ -393,7 +396,7 @@ static int usb_probe_interface(struct device *dev)
 		intf->needs_altsetting0 = 0;
 	}
 
-	error = driver->probe(intf, id);
+	error = driver->probe(intf, &id);
 	if (error)
 		goto err;
 
@@ -891,7 +894,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 	} else if (is_usb_interface(dev)) {
 		struct usb_interface *intf;
 		const struct usb_driver *usb_drv;
-		const struct usb_device_id *id;
+		struct usb_device_id id;
 
 		/* device drivers never match interfaces */
 		if (is_usb_device_driver(drv))
@@ -900,12 +903,10 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 		intf = to_usb_interface(dev);
 		usb_drv = to_usb_driver(drv);
 
-		id = usb_match_id(intf, usb_drv->id_table);
-		if (id)
+		if (usb_match_id(intf, usb_drv->id_table))
 			return 1;
 
-		id = usb_match_dynamic_id(intf, usb_drv);
-		if (id)
+		if (usb_match_dynamic_id(intf, usb_drv, &id))
 			return 1;
 	}
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1da4ad1610bc..49ab8dbb885f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1185,7 +1185,8 @@ extern ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf);
  *	interface.  It may also use usb_set_interface() to specify the
  *	appropriate altsetting.  If unwilling to manage the interface,
  *	return -ENODEV, if genuine IO errors occurred, an appropriate
- *	negative errno value.
+ *	negative errno value.  The usb_device_id parameter is only valid during
+ *	probe.
  * @disconnect: Called when the interface is no longer accessible, usually
  *	because its device has been (or is being) disconnected or the
  *	driver module is being unloaded.

-- 
2.54.0


