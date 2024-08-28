Return-Path: <linux-wireless+bounces-12119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B2796217D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690E61F216EC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C94159571;
	Wed, 28 Aug 2024 07:41:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B715530C;
	Wed, 28 Aug 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830879; cv=fail; b=VmSUg7Pto3oF7S/okqFLITzWj2CH52H4kz/ajIxYppBS3xOBmxB3fDEdVIG6KdwIWLUALiUuxS2Cdj3PkT4q+VPHFciaGMkjLsIXZwm8HxRQSTioeEs+0IB0bqjNysejfWvQ95ugy1c1hjs11vj/dhAy7EFho39IXqhjmUUrbRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830879; c=relaxed/simple;
	bh=pvBFedbixSkiqWuMD5ggRHBeHefsL/vzl60gVabib1c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FFsClXNOcYmVwF3gUjCSNQP2aOUdWp6UHIO/IJlYye7jDPJvIuZnCBxWrmJsOW+62cSI2D3xdl61FnW55maQtzgp265CePlobaV5XfZIhJrK0APvHOkeB6dI1sFf3qpzoiilOVHnfiV9pV7lFPyfbFtwsOZJ/1IQZPkV9WjzlV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmzkBad7fD0G88L62NnVgyEQTag00YcSCuLYiej0+VxA3rxiQ0n6z+jFrbSqadEluUZpUgErOwnF8l9BCHUn3SoiKCuAae6Bbr4KyFEuu0wWg7NstRrYnEqGF3bVAzMxQaPrdaF/rHpnA/2KnULy/s4oB0W1SfeXbyDmbT1epNitLZ00+7nFRvGx7jEXEV736/TbIOl5rLk0YxfnzZc1Hrr/hO+YeSE45OdDykqtGFU0dx7EdqmKgLEmWGi1STb8rOE2vJuZORXRQufC8/bciMNfBJtdM/7Qf3o3ko/YmER7vrwdAE8LPtvy2IM0KDNDFCjhM0I3I3ZALDqLEtNARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbxQ8CN2hEqCPJsO4yOc2S/gFbfZhs3WhsZPY+vH/Dw=;
 b=YLn5TI2z0H6mKpPrLqJd/1DIU47X6gBffj33kXR4cm7kTEV/4ngQz842Oo1fz2bec/BEH2QZ/6jnvo2E7h9RzUhlPpsSW7EUGilVoTu3SPyEboeXwkRDnVTzcSiwCdt4m34NgFIAZZ4UrbnflfEtH9semiI9C+LhJ836rBpjeamzzZpVaGfvITSkJ5SUOvxk+NXN0CbqBgWSc35wGU1QWnBo40TjnyJ1m2H/DV8cMrEleqnwBdvaShVtPTaPzo3+eilPvFPbRlHerUvpJOk2gCeLMoTmR5q1T92H9zA2uCIZbq37sDV0iKuq2z+Jv/lw+wEMaUdmEbFdNzWffltaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:41:13 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:41:12 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:40:48 +0800
Subject: [PATCH v12 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v12-1-9064ac7acf1d@wesion.com>
References: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724830868; l=1081;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=pvBFedbixSkiqWuMD5ggRHBeHefsL/vzl60gVabib1c=;
 b=oumwvwKsr4rsnjUzj/ymaZJUCcAdLSZzTt0dZ0c+HZNpMwWtLiUzaw5W/dJYhoPcYHpaPcM0+
 woIw6ggrgZiAFHwDx5OnuL9zS4D2Ammt39TrAbA4ypRgLz4vFvqhvM+
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: a17b7d7b-1f05-48b3-31a5-08dcc734ca73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjlTWS9mZ1pSVVZjdHNHTE9HWXJjcU42Q2ZUT1Z5cjB5aVNSUHIzdWhMUlpz?=
 =?utf-8?B?cjlETDB4dUxYS3l6RXpramcvNDBUS2NadHVDWVlQNGR0c244WEYvRGlKS25K?=
 =?utf-8?B?NDFOSHpJOTlKTnluVEhXdG11WUdDMnlpVjAyUVNFaFM3SWJjU2pXZG9IUEhX?=
 =?utf-8?B?b3lEaFFNTXlUQit4MlRvU0Z2RzBuYnJibGRVUVBud09YeGp1L3pVelZTa0Nz?=
 =?utf-8?B?Ulg2cjF1SHAwd1FoWE9FTEVQL2hDcnVEMHdYU3FWWTdJQnpXTWpnb2tBa0NB?=
 =?utf-8?B?Mm1kSnZ1djRGN3JKQ25OWC9GYzI1NnRkSXhqTGE4cm83R1N4UnNqeGpmMVpW?=
 =?utf-8?B?NHY5V3BpL2NWOWJWU1VyV3lUWG5JTG0rR0NRZ1AyT1VEWG5OMFNEOFVoM3F5?=
 =?utf-8?B?b1VGQ0hmck1PS0EvRkhPSVZ5b2tnU2lEbGw5aWRvVUpXMkFaSjNjNGh2bTlj?=
 =?utf-8?B?dllER0ZMTGdGWFdTMzdyMTc4MUE2VlhDUDkwN3QwUXRGYW9DY2dXeGNJSTYr?=
 =?utf-8?B?V0tONllZbnZMdHhoYWo0QTFPV2QvdlUxejZpY2IvVjNnN0ZrNWRIK1BweDhW?=
 =?utf-8?B?R05ndjBxYXpTMVM2TnlOTjk2QkdXV0lGaFFsT3NSRHNhNkVoVTRUYjJoN0Zi?=
 =?utf-8?B?c3VDeGJsSXN6SkN6YWRGK29ac3JqaXlhQlpKaDE0aVZrNUxkQVp0U0JZVmk0?=
 =?utf-8?B?TGVCS0c4QkJGTTdiYmNSZXhnWkZGMzZnT2Q5QVhxdkg5cXpaZm4zMzh0WkVL?=
 =?utf-8?B?T1NsS245WW0xaUhwY3JnZ0pnMVRab0hDRkJJVnd6empMRnBMYnNWQVB2WFpN?=
 =?utf-8?B?bXRDMVFzNWtpVlNPN1FkOGx2SnJDc2FrMy85SS9DRnBYanNCWFVQQ2dhTnNY?=
 =?utf-8?B?cUhPRzFESlpRdFFyN01pT2F4bFcreEdRZ2ZLMVFWOWlVUmpuZzM4d3NGbDQ5?=
 =?utf-8?B?eER2YUhrUFNaTG9oQ0xidkRrZmNGdEVPUFVnOFFucmFMek5TdHc5ekxra0Uw?=
 =?utf-8?B?M1M5Sk1WUlNWTHJUbGFuME50Y1pGalM0SGRSVGhtTW9RQUtYVUpCK2RxSjMr?=
 =?utf-8?B?OW9VWHBUN3MvSEpJYTBibFp1Y2lVTkRxWlh2T3lXdEVvRmhydjBldGVnOHJF?=
 =?utf-8?B?M25nVGlvUmI5bW9KeXJXZTJ4Z3AyaWd3bDZMUnhrZ2dNQU1QZWphd3RwV0pN?=
 =?utf-8?B?M2FVNCt4d3lmZlFsRVVqbEg0a2o4MmFocUZHMVFyNkxjYmpBOEt5KzRuZDdV?=
 =?utf-8?B?ZDVsenlUaWNYRjh6Z3hDQVBnM2F5dXVrRHY4ME50WHlqU2UwbzEyVk5MWFFD?=
 =?utf-8?B?a3V0RUQ2UUJVNjcvZlZpREFPYVpOMXdKa0Z1UkRucDBwT2d4Wm5NQTcxOFQv?=
 =?utf-8?B?NDJ0d05Ud1ZBODV4cnVxL2hEZDBFa0svc0F3d3J5VWFDU01zZEZ1aXJWTFJU?=
 =?utf-8?B?YlplcWN6RmM5UjlmdkhJUW9BOVc4Q2QyQnE0UlQraTBIaG1qWUNXV0FtZTlh?=
 =?utf-8?B?RTBsUE81UlRia0hPYzFvNXJURE92UlNFc3paUUpuRXlubG5aWkF0Y3FETWM0?=
 =?utf-8?B?OFJJdGY4N0crWmJoMDYrQXpGclNmWUhiQ1d6ZFZibTlTSlJYUklVUTFnN0Ja?=
 =?utf-8?B?dTdVUENDUmZiWmU1OHJGc2F5S3ZqZEVYNkhpdGU1d2owR2htTVVVL1BobzJH?=
 =?utf-8?B?andrVDdUd3pIMFMxSEZSWDRyajI4aDNvZU1mNktJR0ppWHMydUozNloxdzNh?=
 =?utf-8?B?Zm8xY3I3bnh1R2N1dWJWbVY3aVhLTEwzYldPejYxRmtkNGdWU3EwUXFUdWR5?=
 =?utf-8?B?M2dYQmxuWmI1N2ZTK3crcHFQclloZjlQajI4bGZiaHZETkEybkdnZHA5dTdZ?=
 =?utf-8?B?YWI1aFk2MkFFR05SeGFsYTdkTnV1RGNKZk16NFVUYldVMUVwYzVDYkI4Zy9V?=
 =?utf-8?Q?SnYhE+WGqC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzBxWkQ0anRoKy8vWUxCby9KcHd0cjRYQmtmUDRURFNkQnczMElhQmNMQnkw?=
 =?utf-8?B?eXFmN0xBQmVQQW5UNUI2ZnBudzFWRmN0R056S252cFVBT1JJNTVhTGRicmVN?=
 =?utf-8?B?N0NCTHppSmhmWi9KcnBUYTg3YWdPSWZaYVhCamxDNGpPanNEdkFRaWg2OFFm?=
 =?utf-8?B?RUhBYUJCM1o4aHY2OFVaR3FSOFRtSm1FazlSeHl6UmhYMkVaaEZKRzRJaWMx?=
 =?utf-8?B?UVlBODg1dkdUQXF5L3lvUE1ldnYvQVZXeVFEb3J2Y04yVVFyS2hhaDA3eWly?=
 =?utf-8?B?cjRIUjBET2tYZEFGNGl5elBUWFRhZUZRbFNUTmZyUGx3c3E0eXZiZTJDQnRj?=
 =?utf-8?B?UlVVQWtjZXFNWDQxTlVTUmsxRE1GWkFhUUpKR0U0YW5vb2pjUFBYbFlRVzZE?=
 =?utf-8?B?aGtvSTlab2lleGd1VlBvRmx5WG5jeExtYXJ6ZFNoMjJOVENTUnBxU2Y4QVNZ?=
 =?utf-8?B?cW1uYXppekFxSXFVNGVydU9hK29qbkVIZENrNGZCaldDZWYwZ0FSeG40U2tO?=
 =?utf-8?B?dGlOK2N4cklYN2RzckhDM1ZEQzRRakR6TDk3MW05WlphSXFoOGZHRzV1bG5S?=
 =?utf-8?B?bGdkWXJOWER5VThGNmU0SnZxVDI0YXpVN2xnUzBNMlhCdG5Uc2ltcENtUHlQ?=
 =?utf-8?B?TFN4SFdsbTgrMW1XSjdkY2dFeHo5cjlTUmozNHRkeUNXR3BOdUxXSkZ4SmV5?=
 =?utf-8?B?R2NTVGVlNzljTWM0M3kzSWZzaUlVMlVDZ21TeTh3ekduc2FabEI3SUVJdTZz?=
 =?utf-8?B?WEk4YXVHZ2d3bFJyYmxXOFM5QjRkQ0FnbmNseFlwb1FWSERQb1lLZ1ZSeitL?=
 =?utf-8?B?TXJDNlh3SWgrUmlaV0tmS0R1NXJlWUdTN3pyck1LeGZJeTVGVU1wRExJdTVs?=
 =?utf-8?B?QmdXa1E5OGFVcUZKOVcvWlo1MkdwRE1jVGU3Q3dxQ2ptYW9acHBKbkdTNXlt?=
 =?utf-8?B?SWlmeWZDVmFUQlVlOE9BaXp6aEtTSFVMUm5qUWdVWnlaVlA0ZWJEL3B3VlJm?=
 =?utf-8?B?ZmdhY2dOd0hZWFJSZDVzNHhWNml0RUZBY013dEJOWmJKekZxakNnN3BadGxV?=
 =?utf-8?B?UWFiMHF6UVN4b3ZtMWh6MEdPSEh2WjVIUVEzQXNIQWt2bHlQT0h2WFlWS3Ez?=
 =?utf-8?B?bkVEa1VOSXRLUDZMZkZWaWxJY0ZwbSs1a0k0QU10V0dpQ2ZOeU9aOWREcE1U?=
 =?utf-8?B?dkdwbmw1WSsycUI0Q0ozNUVZaEhnN0VUVUYwdFZiM3RJRkRHTmxMdkYyaDhY?=
 =?utf-8?B?YWQ2bGhxRjhRelVqZDZLU0ZUa1oxVTNVTTZaYnlRNlNLeGlqbEIwYUVzYmt3?=
 =?utf-8?B?dDAxS1J6eFhKSHVFekU3NWdIc2FvTG5aaHR6ZVlrMi9ndGtmem5sZ29kTG1G?=
 =?utf-8?B?ZHBuWmN4R2lIQmFmOHNiTlRqemc4QnUveEdkc1N2bENCbFhDMjd2UVNWN3Nv?=
 =?utf-8?B?WFd5Z3o0Rmh0Mm9XcE41WU5Gb0QyZmNYMzdmandJcWxXRFNIeERpNE5UTW9H?=
 =?utf-8?B?N2Y3WUtLOFNES3dmNndRZkQ4ZzJiQlVIT2paSGpoelIzUERGRC90QlVBYlg1?=
 =?utf-8?B?YVYvNjk3WU9jUk5RbUJZMmRJejdoNytxVDBmNXl2QWlTbVpYS09JNUVxT3kx?=
 =?utf-8?B?SnUza1BVTENCOHFGdHdBdFNsUXRKWXNCb0U4YmxEYWI3NUo4YXM3VGw3djcx?=
 =?utf-8?B?V3k1RUVYMmIvaTJYdkhsWWRSMVJvMGRmbVpoZ29yaWs4K1IxTXdjL2VDQ3Jy?=
 =?utf-8?B?aWU0SUNNVm54aXlKcGlDYkpidlVCSVl1ZmVFeTFQNGFIWDB2Rm9KdU9zUWNO?=
 =?utf-8?B?M0E1TUJiMXFoTXQwS1lhWE5WSnBDOHFmVUdtVy9CSGVLUDhJYWFTNGxuTkFG?=
 =?utf-8?B?Wjh0UTRIRW1tVEVUMzR4OWs2Z3lDenArQ05lZXNVc2pIc2FZNzdmOGZuRjFo?=
 =?utf-8?B?cDEranByR01pR2IxZmt4dUNaUk0vQWlVQTBCeTd3T3ZiS282UldsT1pIaVZY?=
 =?utf-8?B?b0l2NmJDUVd6bC8wVFltdGpIRkV4OGxqbUkzVjV4VG9vVmV0SGNpdW51K3hB?=
 =?utf-8?B?U0dHaWFQcWJnc2ppSWEvQ0lOUzREbVpCQkVDSDNyNVNLWE5ZZnY5UlN1cXVq?=
 =?utf-8?B?VWNOTDF2YmYxL3lXckordmg5dnBXcnJsbnQzK0lPd3IxMjUwYTJ5ZGRqQmRm?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17b7d7b-1f05-48b3-31a5-08dcc734ca73
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:41:12.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epirFcV3s6jJuebo3oFrLTQaB5jNKEIugu8NeFe9YS3d+kiyim0MCmpSzsUu/s1HDD7IOxVbMp6pZIz7+LdDKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases

-- 
2.34.1


