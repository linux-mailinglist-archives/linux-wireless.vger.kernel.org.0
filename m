Return-Path: <linux-wireless+bounces-12719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5397276C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD3FB22A4E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14914D719;
	Tue, 10 Sep 2024 03:05:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021139.outbound.protection.outlook.com [52.101.129.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836F4A0C;
	Tue, 10 Sep 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937541; cv=fail; b=D/dc027RG2NCtUapcLHDwdv/JisTHBcyllxCtSEy2mmEjsvkLoUNFq5I+MTCtHAEnrXjhBUUIjuz/JvZWj7CyF89k7CejMvZAh7HHBkqWbg8Tj0LA5b8KwpzSTi8ksQlyaBvQ7lqM4gGDgd9BP04q3RqE0Y7TcoumhgDas6EqTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937541; c=relaxed/simple;
	bh=zFJ/1N3BUjApkZv0VG4/INFVylk1b87X1EwDkztc46M=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=XGv1/KNi9RnZdyzw417zwZHl3vdANM+D1Z7mQzTkYbctOkxazQEBCWZnb+JhSo5woGvKJB53sWO4AKKOBuAtYYl/84BiMkHdc++/a9S0/9SXiyd2mrrNeQ1Ar5x86phZw/9LA3uYGm8kLHWXblXjt4lmyYS6zC4SpHytB6ElBIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.129.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMQ4Bt1y/AiK1UfAHXNGQ+bWFpfCDpMx9SzcqIDqae0smbPtPMdcYvR/tMpY8cJsDfYB+HkofCOdhP+0RZmZVm5D4ZPy4L+57R8PxLR/IujNrn5ik0rcjPaJ8U0Wcagy4D4B7tJxZ1uevL1VwcZ36ooKJ5Hi4bidItodfSCTM8EHCk2X/g6NLbVn1ClflBjyEiosSnv12H97O14ed7DGtprsCjK6v9ycBh8iVpusFXkp2xHrccGri0jAfbxXjs7GZGXB5tSyDvmwE/Yk5OFDHZJpsaguS58/jqE6Dcg3wRDnFMO+1jWsbs5ru3yMTdvysfmxlGiHJagtcwWbnvilqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFJfVabuP7ppubT4MEJD895a4SqSK1B3JUBRXcgQ0e8=;
 b=xZghkhWcvFwtMVRv4hxil55k3w+5P8a/3+gYQiH1C9LKbnbD0EftmIg8aWEybEZQWwzxXy+IdSjoBNqKmr/cDI7UcewiBvYEnG62OTdhJTSpcoRHMZJFIGqTcupnhnIoBk1RTSKu/px3bXFsGoquYf85QGwI6j3+O4hj314I8WQsMCLHsqBkQmG+Nj20sgQCvlSyGBVvwdNrttWbrVemfpdHc+MGsDzAStGTVvUMZSgTU0gm7xarh6+x67vOT0HEfON5+plYUrjNLCfs2D7CRC66JFSeolr8xxl/TuEHsnj9GIASFWxpz+Kp7tnQWBLzYcVXNc/nweM7t1wXMXtrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SI2PR03MB6783.apcprd03.prod.outlook.com (2603:1096:4:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:05:33 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:05:33 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v14 0/4] Add AP6276P wireless support
Date: Tue, 10 Sep 2024 11:04:10 +0800
Message-Id: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACq332YC/4XOwQ6CMAwG4FchOzuzDQLMk+9hPGylkyYwyGZAQ
 3h3N25e9Pj/ab92YxEDYWSXYmMBF4o0+RRkdSoY9MY/kFOXCqaEqkSrWr5SwAFj5KMhP5BHbgG
 s0V2t0VmW9uaAjl4Herun3FN8TuF93FikyvUvLo1wwbWoKwONASe764r5rzNMI8vgIsv/SJkRr
 VsrNThs8AvZ9/0DH40PHvsAAAA=
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 nick@khadas.com, Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725937530; l=4394;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=zFJ/1N3BUjApkZv0VG4/INFVylk1b87X1EwDkztc46M=;
 b=PFnR67GddZe+TxAOgqQ/uSOtDmQVrX0oUFuPdcjGd7HgYgQ/grq/IZhFUHKXoJn7wThWZtD4y
 wW2/7Z6/Y6HCEcofk/HPhRRfLEE+mnTEHIjE7bgYRHmB8fmA/i5WmPM
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SI2PR03MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ea157d-8e02-434f-167a-08dcd1456f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0dJYkxHOE1HVkdycHB3ZElLaGs2YjVlQnViNHFTTU5aZkR0Q3dNSmdPczQv?=
 =?utf-8?B?aEZyVm1vTWtRSDZqVFJJazZxVFpSYzdDSkkwcTVJS3hkd3dBMStMaHJPN1dY?=
 =?utf-8?B?VEZjZkwvVnpzb21HZWQvMXJBSnUzWXQ5WGI3VGltT2VGTzVHVWI0aUI0VzBm?=
 =?utf-8?B?Yis4TUNBbVdZTEpyWFZmN09pSHNaa1RhS0Z1SHVYUFMvS2tHRlloWC9XdFVp?=
 =?utf-8?B?VDY0NTBEMmFzQng0bU85VTN5cmpXaHhQaTM3QStRR0ZHVmY0ME1RbG9meE8y?=
 =?utf-8?B?bFdCNG5yOGYwSDlpenQvdGtYTVQvMk93K0RoQTNiN1kxSU40UDJqcVZ1VFdC?=
 =?utf-8?B?ekZQdHE0b3llYU5ORktITzR0a0tZcnRVT2drR2NJZlY1Q1pxSFoxWm5zQ3Vh?=
 =?utf-8?B?dXkvNE91Y3dZdjhFalhnMDZ4b0g0K1pQVnI1L0o3R3AxOEVHVEVIWHZJYnNq?=
 =?utf-8?B?SURCbnR4Q0w0U2F0TmVQZUV0QjQ1QUlIdlJxdktzeFlnZDAyNFVWLytYOWNN?=
 =?utf-8?B?dnJ0UGVPM2VSVko4a3pJeHh0ZUFjRzEyUk4zV1Y2aVBkUFVmUzlHZEZzSHFj?=
 =?utf-8?B?dnQzY21wZnJ6c2l1bnEyZUhpaVVkbEhEL1dJbGF1S0U1Tk15cVorR2krVVNw?=
 =?utf-8?B?KzBDbjJBc2tTSUJBbEZFd1FuZ1R3aGpKYzN1N053Uy9TeCthZjdkRVovRkUz?=
 =?utf-8?B?OGZkY2p0cWhFWktWUmxDRlNlOUp2OU9JTmF6b2xYeHZBNTIvZlNPeWNuNWc4?=
 =?utf-8?B?M2FMUnhMakZlWTZJcytZTlZzSnY5U1NNc0VRLzFRWXp4MnFNbU5aQVJJSTdJ?=
 =?utf-8?B?eGU4c1l5aGxUcnM4RDFPcnE2MDh2YlIwQXdHVDRWM2FaRlNodWpNNi9oallh?=
 =?utf-8?B?WUM2U3htNXc4MGhQUXFkOVdmS2hqUU5WQVRqMWdMeG5OWUVaUEVGKzFST3By?=
 =?utf-8?B?MjVhVC83MzlqOFBjVUlybWNCMU91RlBmTFcxdXd5eGJwdGRvd3NhWHc3TDRX?=
 =?utf-8?B?djJwdm1XblEvQ3EyYjlQRUxkVjdFQzB2Rm9yY1NzV0Z1NCtzUTRFTWRGWERn?=
 =?utf-8?B?T2RZaENwVjNlQ0F0NS9QSlBUMnJWTnlodWxFU0xMdU40M0hieDFOcmhwVXhK?=
 =?utf-8?B?YW1RaDU4Uzh1eTc0TU5CSEFDdjMwYzZWaFVVb1Uva3FlNWVXVDhMZzNLQ2dR?=
 =?utf-8?B?SEJwYS9Cek1hTEZGNDE3djZKS2tJNWhlUWJiQlVNQk95c0VMSlV5bDNJY2oy?=
 =?utf-8?B?WGJNVWJKQjZmOVFTZXBpckZxcHJoMThza0dXcVZwYkY4a3ZXenBuazQybnlm?=
 =?utf-8?B?SE5BWTNheEJXRk9QR3pRbVIweUtpRzJUcE1lTENRSm1nTGJiRHRIek9ja0dv?=
 =?utf-8?B?SzBVTGEyZXhtOVRJRG9EdnJrZlpBT3FGMm5OeGRhQkgxMENrM21HWm01bFg1?=
 =?utf-8?B?aTNCSHpoSHJReGRWMi9TdXBqeUpiNXpvczBNVEVTK21EYk1URGJxNmxwcllS?=
 =?utf-8?B?aEVtdnl5anNucExNeGJjckphTU1oWmxsMUJVelMvZVZWK1E2clg0UGdCUzhp?=
 =?utf-8?B?U05PRVdrL3FUZmlXMWl5dlJlRVpvWlhEdU9Hayttd2ZGZzF5a1NBUTFUQVhx?=
 =?utf-8?B?eUx0L212Wk9vSk5CKzRnUW1FKzZpQTN6dUFEdS9wcTVld0JUNVJiRngzd3Yv?=
 =?utf-8?B?dFI1OXdxYnlROW5ZUVpQdE5wSUJlcitnMzVlSlJXdU1paGwvNW12QXM5TnhH?=
 =?utf-8?B?SUlDdTdZRk1CVDcrKzZCTUsxUjhrNnV4ejNCejFqTUEvbVF4NHpHNm42SnV4?=
 =?utf-8?B?c3FBd0hTUjRDYjBnOU9LVHNQUjZBdllQZ0VSTFNrRGQvWkVtRE5ROWQwamdu?=
 =?utf-8?B?ZjdaNjVrclFLZktVSlFTRlpxWUFKVlBpUlRpcWhmak4xQUpvamFkaVA4STVm?=
 =?utf-8?Q?isNLVe1G18Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjhQcjZRdDdhQ2c3ckdWaDB2V2FWZWp1UVpuSWdCSzZnTE9zZGFwT3VKZmJx?=
 =?utf-8?B?cEhtUnRFd1pnd0J2cndHTkZzVnNHLys5dGVmSmFZVXlMbmhPZFgzN0RVbEVT?=
 =?utf-8?B?VzQ1WlhnSkRtOEo4UHRBd1dBa3c5VnFKaXk0ckFOWCtvV05MYVoyREJZNGl4?=
 =?utf-8?B?TFA3dUZEa0tQaFJOdlJPMFdvNkUrVWY3aE9yMUY0UEVUNXFQbElTQ1p0MmJ6?=
 =?utf-8?B?d3N0dnN3TytOcHg4ZG5UdHRncEFsd01TNWdvUlM3cVNPT2I5MDErM3FSL09k?=
 =?utf-8?B?YnNTZlp4Vko4ZHZHdUQ5ditnSGhQSkpibkZhWjcvRThwQWlQNHpLcnFIakxS?=
 =?utf-8?B?SjEzL09SdEVMSUZ5YTlGTU9aakc1Wm0ybjdUMHdnT1lRNUJ1RWptbXI2ZXdl?=
 =?utf-8?B?Y0tuRHUzeEE2ZGxVaHd1SlhMS0FyYUZEUCtxbmVacWI5YUhURXpEVUtOckds?=
 =?utf-8?B?L3FydmVRaDdBMmtFWk8vd1ZlbmIyRzY1eEJGN0tjSFRVK0Rualh6a1BHNHFN?=
 =?utf-8?B?VUxDTGNjZlVnV1d0RFNHOXZuZ1F2NXpxWXFkd2poR052OFdXVThRYWNyZ3dC?=
 =?utf-8?B?MzdjSHpJSEVtZmNDb2kwTi8wbXJUcjU0SFYvVUJpSXZiVmZmQ0IwSjZvbVdy?=
 =?utf-8?B?V1pzWENKam5FbHZTWU9iNU0vSTZSUSsxTk4vNjJyWHF6dk5hYzMrdVZqdXVW?=
 =?utf-8?B?UEhsVlp4b0VvaFJLVzM5aUJvcVJlN2lsZGp2V0ZIck81Ti9uTXl0QWdXZlIx?=
 =?utf-8?B?TEEzalQyQUNEVHJGa1h3RXRZWFk5K28wZXA0RVQ5V2Q2QkpxbjVJZmV5bUpn?=
 =?utf-8?B?K1VpeVNsZEpYVG5HZjVkTTJjRkhQelFSRnJBTVhHSnl4SWs2aGZhNlhPb3Qw?=
 =?utf-8?B?cURlcVgydFBxb2tQRkhyNmdVbXZiNWhCTEZ2R1pVOGJ6K1UwT0JzZTR2M1NC?=
 =?utf-8?B?cVBZQWtvb2NJbHRCVldkQUZPSkF3Zjk2ZWc5RldmM2NKREVqQnhIem0wcUp6?=
 =?utf-8?B?alJJTDlqNzFQQjZQRFovZ0lYbkpKWUN2bWF4SGdZeTI3SG5HZU0wM25LU1RL?=
 =?utf-8?B?VWVaRkM3Y0N2ZjdrMHlYZmtxeDZSL0dNNUtDZ3Z4TGo2SGllaHFLRnNtWEJL?=
 =?utf-8?B?dlhWVjdEOVFJR3lEQ0JpZk0vd1k1VHZUeHNhRjVnMmZ4U0ZCKzh6MEVaQXN4?=
 =?utf-8?B?M1RISFY4UkZwdXFtRStCVHA0QzM4dnM3dFdBRUdORVI5TmNrZ28wcFpNRjVY?=
 =?utf-8?B?MitTUW85bDh2alN4M1o2MjhJVkZVem8rcUFNb1Q3T1pPMUZMMWs4dlFQNjRK?=
 =?utf-8?B?UERPZHovUkllNm9JblpHV2NuNGcxWTlOU2dkSGx5S0RUTDNjQVhGeEFlay9L?=
 =?utf-8?B?WWx1a3Q5MDhESjdsckduNzM1dFM3WnRQbU9xRHcrNDd6UW9LS3h3bzZVMVN1?=
 =?utf-8?B?ZEU2QzFLY1ZmZWJTZXk4NDdKV0ZMRWtCMkpvdGxqUHd6ODlRRlVKQkNjL2pZ?=
 =?utf-8?B?Wk9TbUVVODdVTldaTDhXZzhQVC9lVkYrQWVCZjZYdXNrM1RPUkVDUzJjblhs?=
 =?utf-8?B?U0F0SGRTMnJGdzZZb2FQWXlkR3ZUNjFsTjhVME4vZ3RIWVVUdXhuamt1RThv?=
 =?utf-8?B?NXdIK0x0M2ZTUHBhUWNKRS9YTERFVTUveGViMDJZRlVIQlRWRmwvOFY1Um1V?=
 =?utf-8?B?OWVOL3QwczZrN0U3MmgvZHBISDZsKzcyRUlLRVRMb0VENlFQOGw5YVVzaFlv?=
 =?utf-8?B?VXlrQlhrdXEwVGp5cWN0d2dnbm1jWDJIOGE4ai9Bc2krRnVtYlFmV3h3QVA3?=
 =?utf-8?B?YURyREdtSnA4YVM0SFh0eWh3dU9zUFdYY1Rpei8rMm9DK25BYzhxbzJsNDNS?=
 =?utf-8?B?T01PY0tvU1g1S3ZVZXE1TkUrQmJMUFQ3ODNmUnVLMER2SnNaNkFRQUxyWVNX?=
 =?utf-8?B?NmlPV1VhdHdrbDdNTFUwUmF0Wk1JWDkrN1NtSWxVczlWQkl3RnZoN1JjVTN3?=
 =?utf-8?B?eHVhd1dqOW1XcENEWWRiVEZMREtYbzVlVkNxbmdQdmJJREk0K1RaRFU3MFA2?=
 =?utf-8?B?TE9iZ2I2dTV3TFp1SzBhRHJkY0phMDJ5aFdzRlJteWJqOHRBb1ZMS1B5dm5a?=
 =?utf-8?Q?79ZZr0j5E6izNcfTM8RM71/jt?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ea157d-8e02-434f-167a-08dcd1456f76
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:05:33.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcJY7c+b7KLSvkJ7lCPNT0G7qAcC0MUm8XUCA3r7hWC9A0w0S+6RHfR8YsBza5cNAlWVwiPypF8lRG5qpFOxgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6783

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
Changes in v14:
 - Fix up syntax error in sdio.c
 - Drop commit "dt-bindings: net: wireless: brcm4329-fmac: change
   properties enum structure"

 - Link to v13: https://lore.kernel.org/r/20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com

Changes in v13:
 - CC devicetree list that forget last version

 - Link to v12: https://lore.kernel.org/all/20240828034915.969383-1-jacobe.zang@wesion.com/

Changes in v12:
 - Add "brcm,bcm4329-fmac" as fallback compatible for PCI ID based devices.

 - Link to v11: https://lore.kernel.org/all/20240816020635.1273911-1-jacobe.zang@wesion.com/

Changes in v11:
 - Retain interrupt check in of.c
 - Split DTS and submit separately 

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

---
Jacobe Zang (4):
      dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
      dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
      wifi: brcmfmac: Add optional lpo clock enable support
      wifi: brcmfmac: add flag for random seed during firmware download

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |  9 ++++
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 25 +++++++---
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++--
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 55 ++++++++++++++++++----
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 +++++----
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 ++
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
 9 files changed, 102 insertions(+), 30 deletions(-)
---
base-commit: 97b766f989bcd06e5a7651b1080001d7327012f5
change-id: 20240828-wireless-mainline-bccba9d69efb

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>


