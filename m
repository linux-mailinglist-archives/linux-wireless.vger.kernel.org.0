Return-Path: <linux-wireless+bounces-11866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99495D478
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E0D1F243DB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3A18BC02;
	Fri, 23 Aug 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UPCiOSSP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54007189506;
	Fri, 23 Aug 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434661; cv=fail; b=CgD/XZbUwkvphH0CF1Z//fSpZxrSE5gDRK+pmBDviezVEZDaz0FptobB5ULUwx83dnM6Bzu+3nwiogwpb4iS0ADXbqN6l5lmRNW6tvWgA6rkC+e/2p6sHF1CtXHytks9zrS6ZU+/bG0HHdVaYC9ZN6qSGR/QUHUVfehyt5xjowQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434661; c=relaxed/simple;
	bh=LNPgoXBMJY+fRKN9NhewwNBmCOt0H+68rfnCxNqoi80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JYh+eJunj/e5rsuOiSIOtaOouXercOZH0Pdl+vcohHSK0MCnUfbPs5FVYrTUTx0ifa7Ln0FabOGvfKGDrB6DL/NJjxwxD+GnCxjD5tai3/AdxYgop+236klsi6F9Uk2TgCt1QCncIpMQKBu5CLspqS3ZBjn/mP3lS9JrngGss2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UPCiOSSP; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkch7He9wsvzHkVkNbdESMx5avIB3Xw8eMF33jy6ihKZfEwuBWVQmqq3N63FBPpAZ7TgCVoEWMaEEGy4UVPbbpO5/juOhgLrC4oBNlLDdVkKyh6RVo0Hn/mdRZ/SFaR+hgfEo6WlnmdbpcJ8ZtlUy7SZhLxcZpHxaIFmZ5xtlNXQCSTXoygFShkBTb1Hbu9HMH2cCYNefogqZmIkSFiLHVkxDbbocjvJZXBX8dKGAAZFQC8o1XU8PvwY94W6VCNrC4+oeJba0xxY6LBRZ4gFjn9GH1qydvQicLG+sjir1pmPU21JchZIc5zyTxdm+nwAaqngAzaCj6mlC2ABdS+xJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNPgoXBMJY+fRKN9NhewwNBmCOt0H+68rfnCxNqoi80=;
 b=kteSV7z3oNWan73/Fvno9E8yXruT+gPvJMwHaZh4fWuzYpGLi6OsgIgJtx63z8G4V9uv59QakV/H/YZjt+W5N1MoWw0PcK5UBP9uJIQrcLLIie12bV94Lu4WEthOQjMmChh752SWt+kkWCPMvEPVxNZ9IRmA0FJxFK0tR8e/0G0yD674JIo3oL2bdeiynpnKZUK1VFiWIdnB/Z93PHSsRXWvrnbpzvJPMnPo816BGuPeUOF5QDyRaKo9+lbAd/oYQWpuMIb2Id/s3jMAFR9CfXMYn4shV9rJNwTRr5u4bY3edEr6iPfX3a9W8ZexDDc4ueXjcebXHspUhFUQCsa2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNPgoXBMJY+fRKN9NhewwNBmCOt0H+68rfnCxNqoi80=;
 b=UPCiOSSPD/FILXszgZMGNJBT4Pig0ed5GtwP7FZvI+1Xvj83ADvwBsnAGCrlapAn4jM2xPJsa/Y4/XDP1MFi5M9RyiXU1ABbZhd8zXCMK6JgFOqHZ+WLz0l4ZVTGzpfDJiM6yJ9eVzzC4KobTIDoUTzBJjVkXRHnY0Yve166nngSz0tUGcf/RCjWGJ5+rWGmSQVlLQ0F9iZNHp0AxpX45dIXW44N/ae8ZFJhGC0uRsRYhV+ZdoDbv0O6iE94+WYFoGuldG8ZBSBCkPvlCI06vYTK5JAGcm0GYxHfyVPuHOeTPLIHU0obMvEePaz8pyzqD6+3hIJumpb2BF5AUDy8ZQ==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 17:37:35 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%4]) with mapi id 15.20.7897.020; Fri, 23 Aug 2024
 17:37:35 +0000
From: <Ajay.Kathat@microchip.com>
To: <marex@denx.de>, <alexis.lothore@bootlin.com>,
	<linux-wireless@vger.kernel.org>
CC: <davem@davemloft.net>, <adham.abozaeid@microchip.com>,
	<claudiu.beznea@tuxon.dev>, <conor+dt@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kvalo@kernel.org>, <krzk+dt@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
Thread-Topic: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
Thread-Index: AQHa8/orQOkRWdjHFUaWPUAAlmNCvbIzMJWAgAD06ACAAPjUAA==
Date: Fri, 23 Aug 2024 17:37:35 +0000
Message-ID: <1b39c7ec-d0e2-42fc-9c8d-de911dc787b2@microchip.com>
References: <20240821184356.163816-1-marex@denx.de>
 <20240821184356.163816-2-marex@denx.de>
 <bbaf1b15-2d0e-4699-91cc-17fa7a18559b@bootlin.com>
 <201b31cb-ef17-4e18-9a4e-ff4193d06afb@denx.de>
In-Reply-To: <201b31cb-ef17-4e18-9a4e-ff4193d06afb@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|IA1PR11MB6323:EE_
x-ms-office365-filtering-correlation-id: 5edb044b-7032-4879-a941-08dcc39a464a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmI0RWFpemk2bFA0eXh6VFdMYWMwQyt3OS85UVRVVytRWDB5MWFPVjgwWDlk?=
 =?utf-8?B?RzJuT3IwM3ZSK0JTUGRlbUw4MHp5ZzF2OXFwQ2tQVDlzaEovOVR5RFNjenMy?=
 =?utf-8?B?cGZyb2ZOOFQ3MDdKVjE2TUthTzl6TW9aN0RIRXNFNWZGZG51ZTRnakZCSXd6?=
 =?utf-8?B?TXhLcnVaT1dVM3lUN2tYRjY3eXFZZHBwUThRWkYvd0Jia2ZMcWpBaTNsYWRM?=
 =?utf-8?B?VS9MS2cyQmNRNTVnRUpmbUczZVJoMzdwV0ZMNWJEaFdod3dOcVNCaVhaYUV6?=
 =?utf-8?B?SGU2QnBaZTlSS3FPNjJWWTdiNTB5ejJpN1d4ejNTZzR5TEVyQS9jRjhXNEZ3?=
 =?utf-8?B?Y0RkeWQ4bGdsL0tNeklXQ1VsT0VXSHZ2bUZ1dmRVUkhhOS84MDYrSm1SODFi?=
 =?utf-8?B?UjB5bm1TcW85K3JEdnMwSG5YZHZySmFUT00vV3NLV1ZDZFRaekdPVDlsOWFJ?=
 =?utf-8?B?dVRaMWdlb0hZOVRkaDZ5TjMxd2pCeVJINDRnQjcxeGQ4bWhhRTB0Zm10UHYy?=
 =?utf-8?B?N3cxeStUeXl4bnIwNWVNYjdUS2hVSFlaeG5vUkY4dmY3TTVWd3F3WmtFVzlF?=
 =?utf-8?B?akJMcEhJdWR0TEU1Tkx5aEhENUVMV3RnKy9rcGt2cElvTEZsUCt1NEt2R3cw?=
 =?utf-8?B?K3laQkpFeFRqZWlSWW5JZFJQRk43YkViSm9TNnlPYnk4UUlZVkluOWp0UEM3?=
 =?utf-8?B?NzdKR3RGaDhvcmtQWi9BWWNHZ2RaOFJXMmprRnkxQklHTm9EWG1jMVNNcW8x?=
 =?utf-8?B?ZGVkTzZMSTVTSHZVYzFsbnlnQStyMzVjUUY0MWQ3UWhrUkVhNUoxU01qa0Vi?=
 =?utf-8?B?SDBEWE1aem14SitaMCtCcDFacmRCMlEzSHkrSnhBeDloTjNrd3F6QXNYZXdm?=
 =?utf-8?B?L243OVRGazlrVGY4UDdEZ09IM2xDVExwQjdUdG00aHNGVThrbnpqRzA5ajc4?=
 =?utf-8?B?MkVxRnNXUm1KQW1acXVVaGd4cmtwUk9KWTFmOGQ5Y1VrbmJXY3hIRGYwNnBS?=
 =?utf-8?B?aUdZMis3aEtHelRRSnRUbkdiMUtkV1RzYlE4QUR6ZzRsaFdpZmgyY25Yd1lC?=
 =?utf-8?B?SkRjS1FHd1Exc3VrYlRORG5KWDRTajQrUFQzWlpCdE5sVkVXWkw0TVhaT0or?=
 =?utf-8?B?NHZtbmdKUVlSbm9oSTVJeXM3V0UzcEpURzgwd2FjR1hncVpTYk9DSWtKTlAr?=
 =?utf-8?B?VVB1L0M4UVVuQ0tsT1ROdHhXNittemVESnNBUkdsQ203UW9Fb2c5SGxRajlD?=
 =?utf-8?B?YU02TElOOUlEdkJka2pDWGlIMEZiM1h2cnVUZ3VTY1VFYkZXb1MwQW41bEJu?=
 =?utf-8?B?Yk9tV0wvQmx3U1JmWVZMenpoOEtGT0IxVExJeDNtTWJDR0hQa081dWk5SzVF?=
 =?utf-8?B?OExYZmZNOUFSbFVKUEFjeG5kazEwQ3BGVTBrdHdyWmN4NU5PMFNLWGtxSkxN?=
 =?utf-8?B?NExCaU1JNVIvM1RpL2VEbStmTGpPa0hoL0gzcnFJYUFlZm1WQi9ROXdHZmtD?=
 =?utf-8?B?cWFwckc5OUVxcENVSWdYV29xRzRYOS8xcDlwTGlpNmthSmd0N1VRZkFKdWNn?=
 =?utf-8?B?SDBrWHNDRHVHcXhYamVvWExWTzlzZ2w1aWRBUklneEE3bGR3TVphL0NzVVlp?=
 =?utf-8?B?WGtkNGlsZnZDNTQ1Y2NsSnV5dWxYMzU4Z1RyZDY4bm5JaUpJRkk0VG4vUFF3?=
 =?utf-8?B?R0UxTHJYbEJ0Y2xLZG43QkpQSXpIZU1NdXhTZ2NEM3lILzJrd0xuaWxsRzVu?=
 =?utf-8?B?OGtOczhNcTZ6UGJxMVA1OGsxTnV0UjNKK3RscEdGaDc1RXFCUlRBUnFjTndH?=
 =?utf-8?B?WGJ3ZUIxeXJ3bXV3MEN6bUYvOVBjTU9PeHd6VjZsbkFCNVlLYXJRMVpiUFRk?=
 =?utf-8?B?dlhONm5pdWJxdlc1b05JaitBYm90b0FvclBmWGdzMmV2akE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmZBdHRFdjlRenI0dXhhaG43S3dPVXF3V3dIK0RUWStFakFVdkphYVAzMkVM?=
 =?utf-8?B?KzhzQTQzYlpPalN2TForaUsxNU5JZjlNa2RtZ0tqczBOdWVvWkRwWXVoR1Ru?=
 =?utf-8?B?d3kvR25HUHlXVGdOWGRFemF2WkVEbkRxdzJESUNlck12V25Sd2RuZlZDMnM0?=
 =?utf-8?B?d2RvNmUwUmtSL0p1VG9UTDhaOFdUcGJ2eTBaYzBxRVVYWHplS3FYeXdsbWxn?=
 =?utf-8?B?WkpnOThDQnVuaG9oTVMxS29qeUdXZkYxSDJtTVpHbUExVTdQemYzZ3Q2dlcv?=
 =?utf-8?B?WlhEOFh6VitWV1NKUGh1NEFyZTdheTJ1cEFPM0RGcTc3ZmdiR0xHeHJpSHB0?=
 =?utf-8?B?d1hMT1JnNlBkMElxTTA3MDdna3EwdzNIcitBM1EzR0xOLy9uUzhFRVNwYSs3?=
 =?utf-8?B?dU9qWU5rbEpoemVOQWhDSkNmYUkzSkxFcEtoL2cvcENJa1NYeXJ3QW9McCt0?=
 =?utf-8?B?eUJCcHBNWXJjRTNVQmhTU3MrdzJ0c1JocjBVNjVVVDNHOXNYQ0pxNE0zWmNJ?=
 =?utf-8?B?SEkxQU9QNkFzN3V4bGJUc0dTeVA3dllSb2JnbXo4RUlsaTlNYmxkMjJ3UkQ4?=
 =?utf-8?B?VzFsTTluR0dSZkwrT3NrL1FVT2x0MGNhMXJLeGM5WTFDT09neUNCVnVIZGtx?=
 =?utf-8?B?RDQ1dUVrQnhLcHlPWVM3RFBsYWplTzFiL1d3MUxzQStSdU5RcTAwVmdhMlRU?=
 =?utf-8?B?bGZ6ZERIQ1lrTzhWUG9tTzBYUVJPNFpPTFYwTW0xd1lSNUY0clhwNHREUW12?=
 =?utf-8?B?ME1pOEhOY3hKVmJiSktvS2t2eE9UOGZhVDk3QmRRT1JheDcvNlhwVUZRckdV?=
 =?utf-8?B?dFIzQzlOZy9WWkd3MkpLV2szc3UzTGttUjUwOTZjWkJ1R3MzUm15TXV4b2Fv?=
 =?utf-8?B?eklrcytyOWJtTzBGa204UXhWM0hBOXFOaitUSWoxelRDVm94eGpMZ1JyOTdl?=
 =?utf-8?B?c3A3T29FY24yQkV2TVlOZHArV3k4czZHRE1TTjkrY296OU1oWDh2ZmMwUU94?=
 =?utf-8?B?S3pycWF1b0cvcitrVHFObVZiUEhSVS96NGRqNDZwVU5Nc3hhWVo2cGVjRGRY?=
 =?utf-8?B?bnpVbVV0UVBvU1U3SjBja2ZCaExySGRRRlVOZWdvOUZybXYxN0lOS0cyY0h6?=
 =?utf-8?B?TXdOZ3ZjZEtWcjVrdDhGZ2JneGZTYVNiMjEvd3NaWU01SldwekRkTXFmTG15?=
 =?utf-8?B?ZytRd1ZoWlBsNkFpMUE5cVRleXhCWDJnbzBWRG9lMWxwUGRiZ3BkRzNQdWVE?=
 =?utf-8?B?bVNVQ1dQc1k1dVBHN2RQYU5MRmRiY3drcFE3N2pHTUxHSnZPclNMTENFNFd4?=
 =?utf-8?B?SzIra05FcGZPSjVhNkV1ODBieU92M0x4b0xDWU9VRjE2YjNZWDlia1Jpa1dK?=
 =?utf-8?B?WWtmSWluelFkbDBaQ29qTnpnWjhZR2UwV1kvZmdEVmlYUDJwa3VHSmtpNHhz?=
 =?utf-8?B?QmdsTEI0dTlBdEp1VGJyVVUxZ21KWDRsZ2V1ZVgzWmFRZ1huYTFlZ2JlOE5S?=
 =?utf-8?B?dkIrdFdGWi9nS1BLUHBLOGpMZ0NKWnJTeUZRTXV0S2t6c0VjT1Q3allPazJI?=
 =?utf-8?B?NS9BYmw2b0JVTHkyaUdibG5sYTUwRVY4aW1iZUJ5OFV3QjFrLytCMklGa2xL?=
 =?utf-8?B?OXVEdXlKaDQybitpcUNJcjh5RUEwK0JHaXZ1VU9RdXc3SmRiZXoxS0tGREpS?=
 =?utf-8?B?aXo3TTRDeEhpdDlJUWJRR1VFVUhoTi9RUjA1b2NpM1VqMncvY0RDdEtITFZm?=
 =?utf-8?B?YnE1dS8wREJpSG13ZGlpMUNtekJzT0pPbCtlQmtIeFNVanY5VkRTYnUwOVVT?=
 =?utf-8?B?WWJ2T01QY2ZHWDB0RE1JRm05Sk4rSCt1QnVLY01SclVYdzI5TDE4M0h5K2VF?=
 =?utf-8?B?SE4rVVV5U2ZzYTBhSkxsekRLdU4ySzhUYy9GeFFnRnMrR2RINEJ6VTFTVUdu?=
 =?utf-8?B?bEltMzZYL2FONUJSZWhnVWNyMklycDB6QlZvb0dxSWJVQnhzcXltYUdTdWZa?=
 =?utf-8?B?TG5PTytBZHRNNnJPVDlsaGhNZW5kbmllT2JpaytaU2t4Z1NadG54NmNRQ3V1?=
 =?utf-8?B?THVTY3Z1K1FzTVpRY0ErNWFGNVBoMlowOCtUdlFuMlg0ZXJNWGRqUUxVd3dv?=
 =?utf-8?Q?nzXe/U0ZM6prklQyftn5rYdkV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7566D3C140DFFD45850C259C8D8D240E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edb044b-7032-4879-a941-08dcc39a464a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 17:37:35.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MyF70hrm9l4BF6vBbnc+WT/CIG+FrJL1P2hMuRaPAv1tHYN/vVhNRlbIUdHc53MWMPrQTSRRFEzRw/+xI/ZA8kuJjuvnO3Rxhg5N/0Exf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6323

T24gOC8yMi8yNCAxOTo0NiwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
DQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gOC8yMi8yNCAyOjEwIFBNLCBBbGV4aXMgTG90
aG9yw6kgd3JvdGU6DQo+PiBIZWxsbyBNYXJlaywNCj4gDQo+IEhpLA0KPiANCj4+IEkgd2FzIGNv
aW5jaWRlbnRhbGx5IHdvcmtpbmcgb24gYWRkaW5nIHdpbGMzMDAwIHN1cHBvcnQgdXBzdHJlYW0g
dG9vLg0KPiANCj4gSSBob3BlIHlvdSB3ZXJlbid0IHRvbyBmYXIgYWxvbmcgd2l0aCB0aGF0IGFu
ZCBJIGRpZG4ndCB3YXN0ZSB0b28gbXVjaA0KPiBvZiB5b3VyIHRpbWUvZWZmb3J0IGhlcmUuDQo+
IA0KPj4gTXkgd29yayBpcw0KPj4gYWxzbyBiYXNlZCBvbiBkb3duc3RyZWFtIHRyZWUsIHNvIG15
IGNvbW1lbnRzIHdpbGwgbGlrZWx5IHJlZmxlY3QgdGhlIHJld29ya3MgSQ0KPj4gd2FzIGRvaW5n
IG9yIGludGVuZGVkIHRvIGRvLg0KPj4gRm9yIHRoZSByZWNvcmQsIEkgaGF2ZSBzb21lIHdpbGMx
MDAwIGFuZCB3aWxjMzAwMCBtb2R1bGVzLCBpbiBib3RowqAgc2RpbyBhbmQNCj4+IHNwaQ0KPj4g
c2V0dXBzLg0KPiANCj4gTmljZSwgSSBvbmx5IGhhdmUgdGhpcyBXSUxDMzAwMCBTRElPIGRldmlj
ZSAuDQo+IA0KPj4gT24gOC8yMS8yNCAyMDo0MiwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+Pj4gRnJv
bTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBbLi4uXQ0K
Pj4NCj4+PiDCoMKgwqDCoCBpZiAoIXJlc3VtZSkgew0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IHdpbGNfc2Rpb19yZWFkX3JlZyh3aWxjLCBXSUxDX0NISVBJRCwgJmNoaXBpZCk7
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgew0KPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZmdW5jLT5kZXYsICJGYWlsIGNt
ZCByZWFkIGNoaXAgaWQuLi5cbiIpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoaXBp
ZCA9IHdpbGNfZ2V0X2NoaXBpZCh3aWxjLCB0cnVlKTsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoaXNfd2lsYzMwMDAoY2hpcGlkKSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB3aWxjLT5jaGlwID0gV0lMQ18zMDAwOw0KPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoaXNfd2lsYzEwMDAoY2hpcGlkKSkgew0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aWxjLT5jaGlwID0gV0lMQ18x
MDAwOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJmZ1bmMtPmRldiwgIlVuc3Vw
cG9ydGVkIGNoaXBpZDogJXhcbiIsIGNoaXBpZCk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQo+Pg0KPj4gSSB3b25kZXIgaWYgdGhpcyBhZGRpdGlvbmFsIGVudW0gKGVudW0gd2ls
Y19jaGlwX3R5cGUpwqAgaXMgcmVhbGx5IHVzZWZ1bC4gV2UNCj4+IGFscmVhZHkgc3RvcmUgdGhl
IHJhdyBjaGlwaWQsIHdoaWNoIGp1c3QgbmVlZHMgdG8gYmUgbWFza2VkIHRvIGtub3cgYWJvdXQg
dGhlDQo+PiBkZXZpY2UgdHlwZS4gV2Ugc2hvdWxkIGxpa2VseSBzdG9yZSBvbmUgb3IgdGhlIG90
aGVyIGJ1dCBub3QgYm90aCwgb3RoZXJ3aXNlIHdlDQo+PiBtYXkganVzdCByaXNrIHRvIGNyZWF0
ZSBkZXN5bmMgd2l0aG91dCByZWFsbHkgc2F2aW5nIHVzZWZ1bCBpbmZvLg0KPj4NCj4+IEFsc28s
IHRoaXMgY2hhbmdlIG1ha2VzIHdpbGMxMDAwLXNkaW8gZmFpbGluZyB0byBidWlsZCBhcyBtb2R1
bGUgKG1pc3NpbmcNCj4+IHN5bWJvbA0KPj4gZXhwb3J0IG9uIHdpbGNfZ2V0X2NoaXBpZCkNCj4g
DQo+IEkgdGhpbmsgSSBoYXZlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMsIG9uZSB3aGljaCBm
b2xkcw0KPiB3aWxjX2dldF9jaGlwaWQoKSBlbnRpcmVseSBpbnRvIHdsYW4uYyAsIGFuZCB0aGVu
IGZvbGxvdyB1cCB3aGljaCB1c2VzDQo+IGlzX3dpbGMxMDAwKCkgLyBpc193aWxjMzAwMCgpIGFs
bCBvdmVyIHRoZSBwbGFjZSB0byBkaXNjZXJuIHRoZSB0d28gTUFDcw0KPiBiYXNlZCBvbiBjYWNo
ZWQgY2hpcCBJRCAuIFRoYXQgc2hvdWxkIHdvcmssIEknbGwgdGVzdCBpdCBhbmQgc3VibWl0IGl0
DQo+IGxhdGVyIHRvZGF5IEkgaG9wZS4NCj4gDQo+PiBbLi4uXQ0KPj4NCj4+PiAtwqDCoMKgIC8q
IHNlbGVjdCBWTU0gdGFibGUgMCAqLw0KPj4+IC3CoMKgwqAgaWYgKHZhbCAmIFNFTF9WTU1fVEJM
MCkNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgfD0gQklUKDUpOw0KPj4+IC3CoMKg
wqAgLyogc2VsZWN0IFZNTSB0YWJsZSAxICovDQo+Pj4gLcKgwqDCoCBpZiAodmFsICYgU0VMX1ZN
TV9UQkwxKQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyB8PSBCSVQoNik7DQo+Pj4g
LcKgwqDCoCAvKiBlbmFibGUgVk1NICovDQo+Pj4gLcKgwqDCoCBpZiAodmFsICYgRU5fVk1NKQ0K
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyB8PSBCSVQoNyk7DQo+Pj4gK8KgwqDCoCBp
ZiAod2lsYy0+Y2hpcCA9PSBXSUxDXzEwMDApIHsNCj4+DQo+PiB3aWxjMTAwMCBzaG91bGQgbGlr
ZWx5IHJlbWFpbiB0aGUgZGVmYXVsdC9mYWxsYmFjayA/DQo+IA0KPiBJIGFtIG5vdyB2YWxpZGF0
aW5nIHdoZXRoZXIgdGhlIGhhcmR3YXJlIGlzIGVpdGhlciB3aWxjMTAwMCBvciB3aWxjMzAwMA0K
PiB1cCBmcm9udCBiYXNlZCBvbiB0aGUgY2hpcCBJRCBlYXJseSBpbiBpbml0LCBzbyBubyBvdGhl
ciBvcHRpb24gY2FuDQo+IG9jY3VyIGhlcmUsIHNvIHRoZXJlIGlzIG5vIG5lZWQgZm9yIGZhbGxi
YWNrLCBpdCBpcyBlaXRoZXIgd2lsYzEwMDAgb3INCj4gd2lsYzMwMDAgbm93ICgqKS4gSSB0aGlu
ayBrZWVwaW5nIHRoZW0gb3JkZXJlZCBhbHBoYW51bWVyaWNhbGx5IGlzIHRoZQ0KPiBuaWNlciBv
cHRpb24uDQo+IA0KPj4gWy4uLl0NCj4+DQo+Pj4gQEAgLTEyMzIsMTAgKzEyMzQsNyBAQCBzdGF0
aWMgaW50IHdpbGNfdmFsaWRhdGVfY2hpcGlkKHN0cnVjdCB3aWxjICp3aWxjKQ0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZzcGktPmRldiwgIkZhaWwgY21kIHJlYWQgY2hp
cCBpZC4uLlxuIik7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+
Pj4gwqDCoMKgwqAgfQ0KPj4+IC3CoMKgwqAgaWYgKCFpc193aWxjMTAwMChjaGlwaWQpKSB7DQo+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Vycigmc3BpLT5kZXYsICJVbmtub3duIGNo
aXAgaWQgMHgleFxuIiwgY2hpcGlkKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gLUVOT0RFVjsNCj4+PiAtwqDCoMKgIH0NCj4+PiArDQo+Pg0KPj4gSW5zdGVhZCBvZiBkcm9w
cGluZyBhbnkgZmlsdGVyaW5nIChhbmQgdGhlbiBtYWtpbmcgdGhlIGZ1bmN0aW9uIG5hbWUgYmVj
b21lDQo+PiBpcnJlbGV2YW50KSwgd2h5IG5vdCBlbnN1cmluZyB0aGF0IGl0IGlzIGF0IGxlYXN0
IGVpdGhlciBhIHdpbGMxMDAwIG9yIGENCj4+IHdpbGMzMDAwID8NCj4gDQo+IFJpZ2h0LCBkb25l
Lg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gK3ZvaWQgY2hpcF93YWtldXAoc3RydWN0IHdpbGMgKndp
bGMpDQo+Pj4gK3sNCj4+PiArwqDCoMKgIGlmICh3aWxjLT5jaGlwID09IFdJTENfMTAwMCkNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGlwX3dha2V1cF93aWxjMTAwMCh3aWxjKTsNCj4+
PiArwqDCoMKgIGVsc2UNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGlwX3dha2V1cF93
aWxjMzAwMCh3aWxjKTsNCj4+PiArfQ0KPj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKGNoaXBfd2Fr
ZXVwKTsNCj4+DQo+PiBUaGlzIG5ldyBzdXBwb3J0IG1ha2VzIGEgZmV3IHBsYWNlcyBpbiB3bGFu
LmMsIG5ldGRldi5jIGFuZCBpbiBidXMgZmlsZXMNCj4+IChzZGlvLmMsIHNwaS5jKSBpbnN0YWxs
IChzb21ldGltZXMgYmlnKSBicmFuY2hlcyBvbiB0aGUgZGV2aWNlIHR5cGUgKGNoaXAgaW5pdCwN
Cj4+IHNsZWVwLCB3YWtldXAsIHJlYWQgaW50ZXJydXB0LCBjbGVhciBpbnRlcnJ1cHQsIHR4cSBo
YW5kbGluZywgZXRjKSwgYmVjYXVzZSB0aGUNCj4+IHJlZ2lzdGVycyBhcmUgZGlmZmVyZW50LCB0
aGUgbWFza3MgYXJlIGRpZmZlcmVudCwgdGhlIG51bWJlciBvZiBpbnZvbHZlZA0KPj4gcmVnaXN0
ZXJzIG1heSBub3QgYmUgdGhlIHNhbWUsIHdpbGMzMDAwIG1heSBuZWVkIG1vcmUgb3BlcmF0aW9u
cyB0byBwZXJmb3JtIHRoZQ0KPj4gc2FtZSB0aGluZy4uLiBJIGZlZWwgbGlrZSBpdCB3aWxsIG1h
a2UgaXQgaGFyZGVyIGluIHRoZSBsb25nIHJ1biB0byBtYWludGFpbg0KPj4gdGhlDQo+PiBkcml2
ZXIsIGVzcGVjaWFsbHkgaWYgc29tZSBuZXcgdmFyaWFudHMgYXJlIGFkZGVkIGxhdGVyLg0KPiAN
Cj4gSSBhZ3JlZSB0aGUgY29kZSBpcyB1Z2x5LiBMb29raW5nIGF0IHRoZSByb2FkbWFwLCBpdCBz
ZWVtcyB0aGUgbmV4dA0KPiB0aGluZyBpcyBXSUxDUzAyIHdoaWNoIGhhcyBpdHMgb3duIGRyaXZl
ciwgYW5kIGZvciB0aGUgV0lMQzEwMDAvMzAwMA0KPiBpbmhlcml0ZWQgZnJvbSBhdG1lbCB0aGlz
IHNlZW1zIHRvIGJlIHRoZSBlbmQgb2YgdGhlIHJvYWQNCg0KeWVzLCBXSUxDUzAyIGlzIHRoZSBu
ZXh0LWdlbmVyYXRpb24gcHJvZHVjdCBvZiBXSUxDIGZhbWlseS4gSXQgc3VwcG9ydHMgYm90aA0K
U0RJTyBhbmQgU1BJKG1tYy1vdmVyLXNwaSkgYW5kIHRoZSBkcml2ZXIgaXMgc2FtZSBhcyAgV0lM
QzEwMDAvMzAwMC4gVGhlIHNhbWUNCnNkaW8gZHJpdmVyIHdpbGwgYmUgdXNlZCBmb3IgbW1jLW92
ZXItc3BpIGludGVyZmFjZS4gU2ltaWxhciB0byB3aWxjMzAwMCwgdGhlDQp3aWxjczAyIGhhdmUg
ZGlmZmVyZW50IHJlZ2lzdGVyIHNldHMgYW5kIG1pbm9yIGRpZmZlcmVuY2UgaW4gZmlybXdhcmUg
c3RhcnQNCmFuZCB0eHFfaGFuZGxpbmcgZmxvdy4gVGhlIHNpbmdsZSBkcml2ZXIgd2lsbCBzdXBw
b3J0IGFsbCBXSUxDIHZhcmlhbnRzLg0KDQo+IA0KPj4gVGhvc2UgYnJhbmNoZXMgdGVuZCB0bw0K
Pj4gc2hvdyB0aGF0IHNvbWUgb3BlcmF0aW9ucyBpbiB0aG9zZSBmaWxlcyBhcmUgdG9vIHNwZWNp
ZmljIHRvIHRoZSB0YXJnZXRlZA0KPj4gZGV2aWNlLiBJIHdhcyBleGFtaW5pbmcgdGhlIHBvc3Np
YmlsaXR5IHRvIHN0YXJ0IGNyZWF0aW5nIGRldmljZS10eXBlIHNwZWNpZmljDQo+PiBmaWxlcyAo
d2lsYzEwMDAuYywgd2lsYzMwMDAuYykgYW5kIG1vdmUgdGhvc2Ugb3BlcmF0aW9ucyBhcyAiZGV2
aWNlLXNwZWNpZmljIg0KPj4gb3BzLiBUaGVuIHdsYW4vbmV0ZGV2IHdvdWxkIGNhbGwgdGhvc2Ug
Y2hpcC1zcGVjaWZpYyBvcHMsIHdoaWNoIGluIHR1cm4gbWF5DQo+PiBjYWxsDQo+PiB0aGUgaGlm
X2Z1bmMgb3BzLiBJdCBtYXkgbmVlZCBzb21lIHJld29yayBpbiB0aGUgYnVzIGZpbGVzIHRvIGZp
dCB0aGlzIG5ldw0KPj4gaGllcmFyY2h5LCBidXQgaXQgbWF5IGFsbG93IHRvIGtlZXAgbmV0ZGV2
IGFuZCB3bGFuIHVuYXdhcmUgb2YgdGhlIGRldmljZSB0eXBlLA0KPj4gYW5kIHNpbmNlIHdpbGMz
MDAwIGhhcyBibHVldG9vdGgsIGl0IG1heSBhbHNvIG1ha2UgaXQgZWFzaWVyIHRvIGludHJvZHVj
ZSB0aGUNCj4+IGNvcnJlc3BvbmRpbmcgc3VwcG9ydCBsYXRlci4gV2hhdCBkbyB5b3UgdGhpbmsg
YWJvdXQgaXQgPyBBamF5LCBhbnkgb3BpbmlvbiBvbg0KPj4gdGhpcyA/DQo+IA0KPiBJIGRpZCBz
b21ldGhpbmcgbGlrZSB0aGF0IGZvciBLU1o4ODUxLCB0aGF0IGhhZCBidXMtc3BlY2lmaWMgb3Bz
LiBJDQo+IHZhZ3VlbHkgcmVjYWxsIHRoZXJlIHdhcyBmZWVkYmFjayB0aGF0IHRoZSBmdW5jdGlv
biBwb2ludGVyIGluZGlyZWN0aW9uDQo+IGhhZCBub24tdHJpdmlhbCBvdmVyaGVhZCBkdWUgdG8g
c3BlY3RyZSBtaXRpZ2F0aW9ucywgYW5kIGluIGNhc2Ugb2YgdGhlDQo+IGhhbmRsZV90eHEoKSBo
ZXJlLCB0aGUgY2hpcCBzcGVjaWZpYyBvcHMgd291bGQgYmUgY2FsbGVkIGluIGEgd2hpbGUoKSB7
fQ0KPiBsb29wLg0KPiANCj4gSSBjYW4gaW1hZ2luZSBzb21lIG9mIHRoZSBsb25nIGZ1bmN0aW9u
cyBsaWtlIHdpbGNfc2Rpb19jbGVhcl9pbnRfZXh0IG9yDQo+IHRoZSBoYW5kbGVfdHhxIGNvdWxk
IGJlIHNwbGl0IHVwIGEgYml0LCBidXQgbGlrZWx5IG9ubHkgYnkgZmFjdG9yaW5nIG91dA0KPiBz
b21lIG9mIHRoZSBjb2RlIGludG8gc3RhdGljIGZ1bmN0aW9ucy4gQnV0IGxvb2tpbmcgYXQgdGhp
cyBjbG9zZXIsIGJvdGgNCj4gcGllY2VzIHdoaWNoIGFyZSB3aWxjMTAwMC8zMDAwIHNwZWNpZmlj
IGluIHRob3NlIGZ1bmN0aW9ucyBtYW5pcHVsYXRlDQo+IHdpdGggdmFyaWFibGVzIHdoaWNoIHdv
dWxkIGhhdmUgdG8gYmUgcGFzc2VkIGluIGludG8gdGhhdCBmYWN0b3JlZCBvdXQNCj4gY29kZSBh
cyBmdW5jdGlvbiBhcmd1bWVudHMsIHNvIEkgYW0gbm90IHN1cmUgaWYgdGhpcyB3b3VsZCBpbXBy
b3ZlDQo+IHJlYWRhYmlsaXR5IGJ5IG11Y2ggZWl0aGVyLg0KPiANCg0KSSBhbHNvIHRoaW5rIGFk
ZGluZyB3aWxjMTAwMC93aWxjMzAwMCBzcGVjaWZpYyBtYXkgbm90IGltcHJvdmUgbXVjaCBidXQg
c29tZQ0Kb2YgdGhlIGxhcmdlIGZ1bmN0aW9ucyBjYW4gYmUgcmVmYWN0b3JlZCBpZiBpdCBpbXBy
b3ZlcyB0aGUgcmVhZGFiaWxpdHkuIEZvcg0KbW9zdCBwYXJ0LCB3aWxjMTAwMCBhbmQgd2lsYzMw
MDAgaGFzIHNpbWlsYXIgY29kZSBidXQgaXQgbWFpbmx5IGRpZmZlcnMgaW4NCnR4cV9oYW5kbGUg
aGFuZGxpbmcsIHdoaWNoIG1heSBub3QgYmUgaW1wcm92ZWQgZXZlbiBhZnRlciBzZXBhcmF0aW5n
IHRoZSBjb2RlDQp0byB3aWxjMTAwMCBhbmQgd2lsYzMwMDAgc3BlY2lmaWMgZmlsZXMuDQo=

