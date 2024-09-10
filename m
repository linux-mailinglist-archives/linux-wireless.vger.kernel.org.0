Return-Path: <linux-wireless+bounces-12723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8897277D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24BDB23CC1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05CE187FE2;
	Tue, 10 Sep 2024 03:05:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D9181D00;
	Tue, 10 Sep 2024 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937551; cv=fail; b=UeprwZIwD5zRRvGq53TPdMA6UJpqEIIG5s0mVMM+zHx/FI+dbwsxv9vWbheBpv0ql3KCtW9i5wWDo0RV2pvd/Zg6p8Nx02joV2QwdCGzpfyBQ2aqOMIQSjaS1nhqVvAAf0JxfJZ+1JeDijd8Tryc4ZWDcoYLf+Ju9LHK0uGBTrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937551; c=relaxed/simple;
	bh=eaPDKg4EgZjhgoZGjOIrFz/PouRc4pgRKLayAeEjx7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ptQvLcRC0mRVOiQySx3kpyMNr6L+tctWqzD2ePV0sqmOP6B5a4bBHYoYlXDZ7+YK9uNIn5fxPj1j4zqPTWDWd8H0k20Xr5BWfcLEd01quDZCKEuUO4e75KShIYB1WBqt0q03EgmqV9NjLM3eoolhpXNJ002O3UGAXTWArLZMQBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrlW/u3Uv8qjPHJCMoHtt10DqgFznE4Wozb2Ktx2ARbfJVQQwt9cXAqPKjpjg7v0y1VM7/eGNf4cz+L7byVlryPF1RIQBiKOUGNQ1mM1Q32BpPujpiW4N9zg3IEEa4RAdoRQiPDks6AKxO5SymxhmuO/oSfN0TmWnMQzxY2KGKWvfp2BPHZ0oLFAUFL+Fc9WOKk7dyUl5Hl1S9DZwcJaFBjyDLajk11m4b4dHsqxUOTIwkAmI37gE4eYRFmnsAkINyE1dYBl/EX3052dzDZhjrQobuFv+Q7ZlnetxwkTQnNTYTBZHPM0WcmRQmGImblxabyN5zlJDf16h4awq6IY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIa/19ZSdmiXE/+0Ze0XxBHm6vHkH0nd5ZiJsa5DkWA=;
 b=xU30arzq64KyrnjYoeVM7zf4mmV7HvOIUf3sA5A9r3mMWXOk6nJiFtKhreMCaCa/0KZRz4o7PVdaRIoDGcrLtt6ko3hfp/1Vvuql/kMNJnMJiEBxw8pWapNjcWystOGJAIR6HHRRZHnUs8Kwy+6dOdKM21jyHOc74YHZ0TUBcZxLNNX37GbFI76NBOWZT5TnlfYpjCeTmKfCczXePK0txvZqz/NKS+bp8rd+lMnMOMZh1zH6sMDdvNDnwoY+BI5uLjG6K7/K75n+mGzZ4upWSuTe7vAUKqUC425PZnE4mvXQVFBMX7gBIEtqsoIsyMZN/93VncXOM64cF7s2WaF0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8442.apcprd03.prod.outlook.com (2603:1096:101:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:05:45 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:05:45 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Tue, 10 Sep 2024 11:04:14 +0800
Subject: [PATCH v14 4/4] wifi: brcmfmac: add flag for random seed during
 firmware download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
In-Reply-To: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
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
 Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725937530; l=6614;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=eaPDKg4EgZjhgoZGjOIrFz/PouRc4pgRKLayAeEjx7s=;
 b=ybBsYhJi28XgyZE8MkJ1Fh9bwJnv2zBJOvOgRj/u52fjUFj3p3qw3pBn55DxddHuo3MuI1++a
 Q4OlTuP+D8GBHoT6tXwf22OumhKX3Zc+eSwB5Vsf/9tKi5ToE8asxLu
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c6b97e-811f-402e-49e3-08dcd1457694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDFHOXBUdFhpUTFBRXIwUStTMzRwRkw0V2I1MDRLSCtLT3JtRUtmdDlOSmo5?=
 =?utf-8?B?b0htTEZiUUlmdFlEQ0tUQmFTWm00U2l3U3RyYjROd3EwYUxGdG53WnIwRDEx?=
 =?utf-8?B?OWNxbnhXSjdpNTFoUVM3QVZhSUJybkQyR25hWlB5UmZaK2hDTk42YThhYUN5?=
 =?utf-8?B?ekRDOGpYUXhzMXZpQUoyM3R5VU54ZHByY2xML3hSbFlpSkdndmpPM1NUUjVK?=
 =?utf-8?B?Rnp6MkJ4WEJoc2ZpNGx1NWRsZVRvbnhIQjNGcXdmL2JLOFpUdXdOb2o0V3lM?=
 =?utf-8?B?ZVUyM3dIWkVXSG9MUlpBZkMvYngrYXU2M2F5N21ld0VuVTBvTXJBakVlNXpa?=
 =?utf-8?B?d05uSlRPKzFENTNLZUErQmN5YW9HRlpnUllKS3UwVEdhM29pMGdnQ29sSXgw?=
 =?utf-8?B?eGJTZFh5dFVZVFNDdm5zTFRtZEF6K2RJR0xSRjl5Wm04MU9kUGY0WFZZRUQv?=
 =?utf-8?B?YTkxOWgvL3lYbG9iRlZaRXNKT0d2N0xsSUdGOC9hdURxd0JVdWkxa2FGU1ZO?=
 =?utf-8?B?dktlWmhlZzh0Y3BCUUVyZyt6OGF6aDdLSXBubTFheW5EZWQyMW5Sd0ppLzN3?=
 =?utf-8?B?NHg2bzJlYUFmaVFMUXdQKzVzUHhmMUU2aGNXbDl4d0ZGQU5QM2t1amZYNnlK?=
 =?utf-8?B?Yi8vN1JVdmZPK09WVjlCMm42MXkzNEoxaXRSUTBHeDBvWCtkSUZ6OWQxZ1pu?=
 =?utf-8?B?TlZmRjk4WlNjVFRmbnF6cFNVU3c0bndoRlJ2a1VRMzFWcWYwQ09lYnU1blNl?=
 =?utf-8?B?WkxhblhtbDBhUndudVFtTjJTaHZwRmJVamNBV200TEJNY1BSNWtkMjdqbDl6?=
 =?utf-8?B?VStqSUJ0bU84dWdkZWJ1VXlzWk4ralkwYW10RjJXUUVWVEF1SFRtcVhDcEJh?=
 =?utf-8?B?KzNsN1E1RUNOZnJ4YlpCLzRCS2Zkbm1iZDRXSUlyYnNYL0ROR3RodHViWDU2?=
 =?utf-8?B?cXhZc0N5TEJqa2NDOGVXNHdOZElyb0ZOYXJJcVR1SFl3WS93U1FOejFCaDFy?=
 =?utf-8?B?VytTMDNlQk1jR0NQNG5ZK1JCaythSmxqVjhBanFOanUzS3VMYWVaWXVTSmRj?=
 =?utf-8?B?TkgxclNrYnJlQzNLSDZnczQrVG56aldHNis0UmxWUkQ5Und2Ym9yVUNabmpE?=
 =?utf-8?B?SitnN29EOURxN2dvSm4zZlFXa2tQUE02TzZVblNFQ2d6L1VQZEVUbXFWZnp1?=
 =?utf-8?B?N3RDb2lDb2J5dWVwV0hQWkVrWXkyNUdtcjBNWjI2amZkblBWYW9jSisza29y?=
 =?utf-8?B?Mkc5Qk8zdlh1bUpGWUNTKzViN3pja0RJS21sUVd4V2NwT0pYdEI2YnNJUlZT?=
 =?utf-8?B?Rit5WG9VTGQzNkU1RDN5eUFVWFUvL2Zlbnloa3JnS2JVSksyQUVYWUx2ZXA1?=
 =?utf-8?B?MjF6Mml1N0hPUFBBakE4R1BXdXVNdTZQZGNaK3hyb2RHSzVzaFI2MFRHekF5?=
 =?utf-8?B?bUl6YXRsRzhBaXQvSExHWW1HZDMvOERmejlKNXdYZlp0Vm9QR3pPSDFhRENG?=
 =?utf-8?B?MG90OHFLc0lqMEJ2WGNhZ2w5elFWckc1YVE3NXZaMnQxZzcwUFBiS3c5YVZw?=
 =?utf-8?B?MW11d00wcC9RcnN1dlNVZUNmZ0thNFEzcGtVQ2pMMnRJWjhGaHYxbVQ3aVFR?=
 =?utf-8?B?S1BFWiszeVJpa1U5eWpoVVd2RVM2ZWphbi84RXA3M09PV3ZFcDdBRkVKNEta?=
 =?utf-8?B?ZDRtdldSUlA3MjNKc29ySm1oc0YwWWZLN0NoSkk3YWhabHJ6RVBmbGpuZHJq?=
 =?utf-8?B?VnpLdVVYRXg4TFh5VkZyVmhOcUIxSG5IVHFaWXRZM25EWXlxZ3o3Sy9XWjVr?=
 =?utf-8?B?d0FuakVCL001N3kxaW1VN1V0aE1JdUZYZHM2T0NyblB2RjJOaFNLT0djZUFr?=
 =?utf-8?B?QVdNTnlDS3M4WTlzMTZYYTdrVHVoN0dRMy80QitWWm1oc1JESS9wQTRZSzBC?=
 =?utf-8?Q?B+G1sA3XPj4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTdlQ0EveVlXMUZKUlRQUXN3WFBlS3hSTS9yYnA2akVUL2Z6S3hmbXJCQjR2?=
 =?utf-8?B?WDRGVHdPNVpNRHEweG5TNnFPeGRNR3NKMVNBaFdRdXJwSmR5NHl6ODNucEln?=
 =?utf-8?B?dnVLTnBKMzl1L0Y1NWpLQVdydVowV1RodkEyWHFSUXZtU0p6bVFURjkzcGNx?=
 =?utf-8?B?SW12WmxNdERKNHFKTVVaQ3dwQUc5bkRwc1RiUlMzQWNnMlRyUXBkOUNFbnAw?=
 =?utf-8?B?SjZYeXRqRFE1c2NyWGFpUFljK3UwZFdaN3N5UnVDVW1XTUtlTmU2NFRKUzNC?=
 =?utf-8?B?d2FpTWNTVXJ2c0hZbDZya3VkVG1kalNvZnQ0a2JXbnhiL3RkcWR2QktMRENq?=
 =?utf-8?B?a0pKVTI1RlBrOGJUcEN5bTdPM3FxWmNxVklvRUJjMk4yaDZ5R2tENkNnd0c0?=
 =?utf-8?B?ckIwdDlxbE5IOXJSWjBtckJqa0dHZE9mMC9mZVJIMlAvQm9NU3RIRzVkTTZ4?=
 =?utf-8?B?NDk5SFJLWHNRZ0g3ZjdaNHRKUzl2V3NoTi9GMGF1RjkzQk42R2RPaFZOTHVD?=
 =?utf-8?B?TXgwNmRYUmR0aXdjUzFPUzBoUEo4UmxFY3p3eEdYV3p3ajJQM1ZaVDRaMXo1?=
 =?utf-8?B?OGw2OVRhQ1lGMHRtT1VPV2hDK3pqQkkrVDZrSW84cklkRDlkVWkraEVtN1Zr?=
 =?utf-8?B?RmwwNHBrc29NcG05ODYvL2ltQjhFb3Q4U2NZYWo2QXFra3ZKZlhWYk9pN2tz?=
 =?utf-8?B?c1dwdERVV0daa0FNUWszMTY3TFFRdWxDRGhpeUVtNU56VmtxeFNFdEZadVho?=
 =?utf-8?B?dTNIeDVjYVZ2aEJhNlh1ZWlSRWhFd2NvMHVKS0ZsczcvMWxoWC9zUTJEa0xj?=
 =?utf-8?B?YUJrdWFQM25vZHAxQmdGSHdsajhUNEMvMjdjMmVTL2VJRUJXdlRvWmlMSTY4?=
 =?utf-8?B?NDh3eFpiOUJRSFR1SWoxeFZ4N2hpNlRhY1Urbld2NDFPb1R2V0FkQWVwcUdr?=
 =?utf-8?B?R0VYWDlXYm1MZEplNWtUV2ZUTjBOcE82NzNaQ0tZMy90Y1J1T1NzRXNMTkpN?=
 =?utf-8?B?bFRrTUxHYiswUFdDOStwUUhrdHg3YmNlZXBDQStCaUUzQXpKK2xXcUNVWGps?=
 =?utf-8?B?NVRFeWRoN1g1emZhOGR2TWxuK21NWS84KzZTcW01ejl1Nnk0NUxiR3c0ZnpR?=
 =?utf-8?B?aUV4ZnZETUZsaGY3WWRRZi9nM0c1bmlNRU5yYnVmUVJlcUZ2dEN2UTNxcDJL?=
 =?utf-8?B?VllTZE1UZjRWeitOanNZZ3kwTmtPYWJSSUNNT0tYUnorbnc1dnlYNGtXOVVM?=
 =?utf-8?B?eDI3TW1GSU1aTXVCVUh5RCtKVWpRS3k1Ulk2WXB2d3RPRnNCM1lNM1REdjZB?=
 =?utf-8?B?Nnk1RDd4QU9PTjZjeVpONmc3ZGg2WGpLWnJBZzJQL2lsbklmQ2VQZjRjeEVU?=
 =?utf-8?B?bnZMWXhoM0NJZUV0ZXM0UnEvZGhJbkNleUR5bUR2bFNWSDVYY2w0SmNWcHFq?=
 =?utf-8?B?UlB6bXl3dTRxRmo2dDhJbnJHb2xWWnVkTFVZYjVvczlzRVg2bDhyU0w4Qm5j?=
 =?utf-8?B?NmE2ek4wZVZwUWtuNlhzVFNMRHQ5c3lUOGNFVyt4M2s4M0Rsb0lDZVgrbVhX?=
 =?utf-8?B?NHA0Q2RwZEI2UlF1cVg4ZzdjUDRKUWxEYVdEUk5ySXlISFl6SlEzY1JYdEE3?=
 =?utf-8?B?bFNxRzhPK0JjN3Fxd2ZIbUR0VFQ3cldyMGdLYzFZUHd4b3Q4RW5ZMGR0SVZO?=
 =?utf-8?B?WHNiQm1NQW5RSTFuVUZ4M0pMRXZoVmxVMHB1QmdWL0w0dTVnZ2NDWjRxa01w?=
 =?utf-8?B?NTRraXYrWkZYSkxERDdMbXdGdjl5cDlZcHNTa09Yb2QxUW80SWExdmFvSWdC?=
 =?utf-8?B?RFExV0x4d0RSa3htbFN0SVBZc2RCYWdYTDFSUjhZOW0ydnZPSTlZVXRVODRz?=
 =?utf-8?B?ZHlUVS9NU1NmdUMwS2JNSmFXNnpHOHNlM1BJSC9WaXYvZ3FPaU1wQWZwRHV0?=
 =?utf-8?B?Qi9xR2hkMDQ4Znc5TzFrQXBIMExBcWcwYmVtZC9HR0dSLzBEVVRSQ2o1Z3pv?=
 =?utf-8?B?VExxWFRNVVhLR3BSY1Y0T3RxV0duVm5oSStOL2J0ODAyMitMamRXL0JYalhl?=
 =?utf-8?B?aVA0T0lCNGNBMnRSRWFhTmJhTUc5bEE4bk9ycHVnZU4wK2JWYXI5U2V4YVc5?=
 =?utf-8?Q?jyJcc6GcHd4KdkmH2UKnPU+pP?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c6b97e-811f-402e-49e3-08dcd1457694
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:05:45.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJKu7YQMST++oeBNxrq1ODwW8RZaqVPAZo2Z0AJo596Fh13DcmOHKgpQD3JlpcKfhdPxIf7osZLD8IpoPaNipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8442

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++++----
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 190e8990618c5..c0fdaa4dceda4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
@@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -353,6 +355,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1715,14 +1718,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2394,6 +2397,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2475,9 +2509,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2663,14 +2698,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2698,9 +2733,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..c1e22c589d85e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
@@ -94,6 +95,7 @@
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define BRCM_PCIE_43596_DEVICE_ID	0x4415
+#define BRCM_PCIE_43752_DEVICE_ID	0x449d
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433

-- 
2.34.1


