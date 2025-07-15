Return-Path: <linux-wireless+bounces-25472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A126B059D7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D3474120B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BE2E3B0F;
	Tue, 15 Jul 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CeM/FWQj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012032.outbound.protection.outlook.com [52.101.126.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701422E0400;
	Tue, 15 Jul 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581895; cv=fail; b=LtC37HHNgsdPrLFXf9fsMxLWoyh0SQbMmJDKEwTy2U2yFoyF8TAuKIMQWf62OlmyweFUGV3a/0cTKMEMs1OucpqIjq98ypzC58rVKMb485a6axmhDBz3oXx7A+O21LvfPbqwykpeMmNeJif6a682vvDzE7LnAOFNLXgYkwCOCX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581895; c=relaxed/simple;
	bh=glge1X30xkVS7ETLwpvfGQfZVTkGAKrLLFrdy/7Oa9o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ID1JHUV+yf1+e7QrUYqH0NJ0TSsnfwFPpPcprP+eDzq+Nwi3MkBgwQ9dFsNUvwsxhR+iRMXxhXIJmrC9YUjjOZpHnn13h56oWdvciH3WRmLY/gGTlCzGTZtDWSprdNwAFsEjoPDXScTOd5VNvWRgmiUeKmR/fe08SlKa2qE8neQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CeM/FWQj; arc=fail smtp.client-ip=52.101.126.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/EnjIm7W+d1AP7XZyDRlWEpuVIJKhDrRai1dgA5gKLlI222bLddYYqzc86SP1leNaCpak3S2FVROJXi1Af+N246T813CEXhq7OavRhJvlq0mi3JPUqpR9H0+1LqK+oIYvbdGRk3jntJgG7c2JP94RWb7af4WAEDJvhyS6MiOaniW1gTF+A3URtHGrMv6WHj8lMYtZlskHVk69A8/uEQ8yNgw7qwlPCiB29SeCY4OFsPPk3u4O2Dl5+yJDhUGtJThqqR/LVyaI5CWT8p1MSJMEeVT1OrAabdxiOQ8J17t5Ai0Rn44RoLeoN7n9FTmdblBSBuIKInOp3rVesDRgQz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MNUklGgo2xDPt6BuiO/jdzyBn83AtRRsWcYYXum0Hc=;
 b=NabEwMt6L7g/1kZIHX7LYZuRawI2ZtHwAj9Hd1jJei5148icDQVhU7pPWi00NTtDY81mF64Yok9W6CPtqQYlqfaZNmLnlEfJbwGW7l5XyK2sZrkEBujTKEjdXiPiIdFXE1lCOget0+zdCkHzFKf+pMHAEnoUVU4d9zTFw3ILdoONfQktSoICi809Sh09HlU5CJlu3JeDpuqOrSTnyTz/YFmxDR+iiKFLtfqgS9fDHfHYmDl1E4AjZq9U2BJNzzdZ/DGLyjZm56f/FWBq1u92FandaCg4kADeVj9mWggUao2GvdXM8JT/4RT28WTo4QO8SrzPQfhIH+7JbH2ArRIJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MNUklGgo2xDPt6BuiO/jdzyBn83AtRRsWcYYXum0Hc=;
 b=CeM/FWQjJT2xaL8ETzJg0hamsbDmsRgLTgJqb33eJi6y4WJ53G3g4aRSXtd4Ltg9xAp8Qrv0J/iYIe8JWzujgQYXzBoza23hxPZtMBA5fHRPOXdhnKeb0W4jImpQYCRAGLxI9QGhuhEPQF2tlUednn1jB2tFgHUn2PfiR0A+k4JXkCK18YqLOrkpBhQRmzyv5CvEl0hvthj9/8BtcqTYaGtVr3H+6VfJnL7sCH4RrFl3nhDO0TriVaL03fCewyV0qyjXJrSJDHG4jJS/ufUCYgd6oXGnZ5ysZr0OSzuz3T/LuGf36Ce1jcTG/E5LUn2NOqPSsdDpp8EpPTxYohWQuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:18:11 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:18:11 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Marek Vasut <marex@denx.de>,
	Kalle Valo <kvalo@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-wireless@vger.kernel.org (open list:MICROCHIP WILC1000 WIFI DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/7] wifi: wilc1000: Use min() to improve code
Date: Tue, 15 Jul 2025 20:16:52 +0800
Message-Id: <20250715121721.266713-7-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: ef943540-fbdf-4d59-79d1-08ddc399aa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUx5Q21DT1IwUkFvSzViMzkxS2JvSFFiQ3NYbFl2VVJXclVQWTEvc2NWTzcz?=
 =?utf-8?B?RWFQRXZ0cUNtaUMvdkZwQmVyNnY1QmJ4NkdkMWIvY1UvWTFlb0lTYXpLV1Y4?=
 =?utf-8?B?NnpYNDBrZHYwT0I1Q2JIVTZWaTJKNWJvSjRHTktLeDl3RGt1cldsbmFDRmps?=
 =?utf-8?B?amxSaWU2MXhyVEViQVlSN0t6M0VRaUVzbkpqRG94VjRkUzNpZ0xLYUROV3U3?=
 =?utf-8?B?UHVDeEpOejhIbC8yMDY4akZpOS8wNzV6bUlJRU0wVGwyLzhoZzhPL0ljT2Yw?=
 =?utf-8?B?RGF5NmdPdXpPL0tKRVRTSHBLR2xleUVOOVdrZzh0Wk8rNEtid1dnbGdwSW90?=
 =?utf-8?B?eStrWFdGVFk2TnNrV2c2cElHUmJpWDF6dkdpUHd1U2JEMWtITkJ3R0JYakkz?=
 =?utf-8?B?SURROExXUG1PNksvOFJSMzJzaVJleGFyNHFSckRkUVdtOWRibW0vWlRRdWNw?=
 =?utf-8?B?VUs1VmwwR3VOTjJLZW4xZzFzclE3YlJka0VaT0pjVWZ6bFBrSGlLS0ltM1kx?=
 =?utf-8?B?YUs4MHBRd040Sit4RUljbTdSaDUxU2p6UGREdE12eEVBSFlCN1hKNWJ6UE01?=
 =?utf-8?B?dy92U1RWVFNLSHNNdGZ5MU1lUjE1c0NYbC9rZ1ZLYWllSW9jaytBZzNDSUho?=
 =?utf-8?B?UkJNbnYwTFVydnNUdVRHTGE1eTRrUXdCVE9TL0tKRHg2YmFBbXZLR1VLZ2hG?=
 =?utf-8?B?eW1RYkJDQ1VCckFLQWkrRnZ2TWJsSFFBYi82Qk1rd0ZqWEU0M2dLY0FJWjh1?=
 =?utf-8?B?VVFBcHhRYldLbThMRm9xZzJtSy96ZUIwY1BNelUzZCtPblhmL1FjWC9uNEdv?=
 =?utf-8?B?YjNaYlB1Um9DVHhLTVFnR0J3UGNKa3N0cUhmL3ZOUEU4Nm1PdWtSUVRpRGpG?=
 =?utf-8?B?aFRhVFY5ZG1mc0EzNEdnay9BUTF4alI4T0gzQkdpRVI0Y1Q3VjRZSDVmbHhp?=
 =?utf-8?B?d0Y5Q1NMbGtManNaa1lZSzg0amx6K3NYYUwrdCtyaCtwWUFuaWo2NHozL0lX?=
 =?utf-8?B?UG1VdThoR3dnTXUzODlxUjN5bVhQalhNcWVjR24wYXpOei9kZVZDS292dkc4?=
 =?utf-8?B?Q3hQeU9QMXYyZTVwNHk2VkhlanJmQTFOcmNLMURqa0hJbXBzeXZQVHQrQ0dR?=
 =?utf-8?B?T1pUTGhNSGlVSDdDY3l4YlU5OEJ3K1B0NitJaVorVkdMNlgxYlFUR2s1dU03?=
 =?utf-8?B?SG1wUTJYOTBUMGNJdWNJMXlqV3g5RXRNUEdqaFdXL3BTRm1VODhJV3JiaFpv?=
 =?utf-8?B?SUluampBZEJaeW90bEtUeWlIL1BiaXNmNDdxME1JMFZxSEhXcm9heXZlZyt4?=
 =?utf-8?B?MW8wY2k2ZlpaMzE1U1ZpeE04ZnU5NGlEb1lIYnUxZld3OTcyTVJTZFdpT2tJ?=
 =?utf-8?B?d2h4MHJTUDZ0S0Q2S0VLYzBxZmdHNjVMZm5nNWpmTWNLK2VlemRwMWhkd1Ri?=
 =?utf-8?B?cHJVeXJEM0ZlME0yeUJpdVdnWitNeUlnVVRmbTdENVVyemllaEFWbTB3QnVN?=
 =?utf-8?B?WjNqeTJLR0FQcXNmNU5ITG9xMGlIbkQ2V1lOa1pFajBJem9STmhoK0ZTRVdS?=
 =?utf-8?B?Z3ZtdVdpYXdKUDRCY2dUaW5WeS82QXNzck8vQ3R3UnZheWp6MHBSVnZ5d3dM?=
 =?utf-8?B?Z09iaGtKaHFtVzlaR3ZlKzA0NFlYSFhrK0xraGlBZmsvcEhndTNTL1d0RUdT?=
 =?utf-8?B?UVE3T0Vab1RjWWpxVk1pR3RETjJ0b1ZsY015YW84UWNXL3ByenJhZHVIR3RS?=
 =?utf-8?B?UW8rdXdJYmJRWkM0eWtiVytsY09YNFdMbmFTMkNkVkRhUnY2Qk1POVdlU0tV?=
 =?utf-8?B?SWh1c1JQOG9wWGh6NDZ3NWN3RjluRlFSeGQwMU4zVDRqM3MrZHVLdHBJSVVj?=
 =?utf-8?B?UU5CbEN0VDFLeDEyL1NRYTlxOHFqWUk1M3VxS2xqYS85TXlZcFU3TkdMZGxq?=
 =?utf-8?B?RG11MWRVeHRZZ0Nia1dmdDJnazJpVFRKUWFTSkxHYmRYK3NuK25vaFgyLzBE?=
 =?utf-8?B?WUVnQVozSkhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clRCdlFSZ3ZBYTliT1JkSVh5ZnYxYTdSci8vd1Q5Vk4wMmRxRURSZnE4QU9l?=
 =?utf-8?B?UWFtSGRRTDZEOGI5MnVJa1ZPemR2MERkMm9XS0xBa0pjdXpERUFScDN1Vzg5?=
 =?utf-8?B?d2JRYm9NZi9HT1EyUXA0SzgxYzBpQ213eGtXMHMwVlZQbzJZKzFSUWtneHJ1?=
 =?utf-8?B?VWZvN3FQM2E5Vi8xWmZ5VytNN3lJbzE2ck1kUTJkelViK0w2VFhhb1huY2c5?=
 =?utf-8?B?R0NvTUMyQ1NZU09UVDJ5ck5YRFRPRWVYRHVvVGZkUFpqOFVZMzJ3d3prK2lF?=
 =?utf-8?B?cXB6VWp2VkwyazU0WWMrN0EyRUY5RFpiOEhVeHBQT0tkc1ZGYjdLMlhGSWpw?=
 =?utf-8?B?eEozWnd1Q2VUYnhxeWtIcy92aGxXbWIzZGdVMG5LUzRTMlp5d3Z5SENkN0h0?=
 =?utf-8?B?bi8yWXFIVUZKY29LS3M5K084Vi9FL0ZMNHg1NDdObVVOVW5GZEJhUkEvRy85?=
 =?utf-8?B?MXNpeG5heHJyaHMzb2d4U3krYjFhc3lpTjViNGtSUFJnaWJoU3NleXRBdGM5?=
 =?utf-8?B?RmN1a2w2NHNZYzZRcDZVZS9GeHRXZURPT0dGOFl4VHp4ckliS1dHeUhHdkV5?=
 =?utf-8?B?N29ORndObmJGZk80c25yV0xQUnZEa2k4dkNudlhXYm1OU2h3WUhGazRRMmRx?=
 =?utf-8?B?YmltL1Z6T2xKaDNuWjNCbTZMdnVEdlFHOVpKNEpDN21vOS9iSG5HK2FUdUxo?=
 =?utf-8?B?N1JvVVJvWGErbU5VL1dMVUhZck1FOFBzeitIL1MwT0oxTU9leUhUV1l5VG1q?=
 =?utf-8?B?MkIrTWFldnYrWXBSZHE2clZGM3lvVitkOStYS3NCVzFCbkJTcWZxZUVzdmc2?=
 =?utf-8?B?UGEwZWZnRnBWQTNDWFJ1UGlscG1iMHJ1U3NCT2l6bEx3S1RJbXNMbEJTeEVF?=
 =?utf-8?B?VFpvWGxLYlMyUzRKUVk4OUpPZENpSytLUGcrb1N0MUVTUnpQYlJmYTlablZS?=
 =?utf-8?B?UjQvTkNHdkhvSXJFVHlyd0N0a0RUL2kzUzBDSnBFNUtab05DbzlzNXVNVnRN?=
 =?utf-8?B?aG01Qk5RaTR0NE4wRHM1YngzTStlN21EeCttdmdVNmNVc3VOYTQ4VXlxM0xz?=
 =?utf-8?B?bjdPckRIU3hXTWwxaTlGT05sdUlVRDJDTGN1RURmNThnanB3UVludVBSU1dp?=
 =?utf-8?B?MXdEdWlTTC9KM1RxRXRZKzVLKzAzNU1MN1BzZUYrcExqRnVpcGE4QVJCT3dC?=
 =?utf-8?B?bVBRNVdscmZtdWxiQjQ1Rlk0RndHWXB1alhwZkxYamkzRmFma0hySVc2Z2pM?=
 =?utf-8?B?WTN0VWVJM0NvTDlrNDZjSFZ5SERGL2U1NGQ4N2cwMmZOV3JUQ29sOWxOVHhT?=
 =?utf-8?B?bkVqNGNSeU03UXplWU9tdkdFQklWaEU2UjNQUlk5cjI5QU50ZU1HRGFWMkwx?=
 =?utf-8?B?KzN1VGR4SXg3VUdMODczZVEvREtvc0JzdlVEazNKT2c1RmpqVGtrSGJFZEt0?=
 =?utf-8?B?ZVlNWjVoTjVuNmNpc3lVd21VVHVsRFF5R0Q1UDl4a2cvdlp0R05KY1BUZkRr?=
 =?utf-8?B?a2FpVzZlSW83YlBteGR6akVHQnI1bjNYNng0UXIxdyttV0JleHhsL1duR2Iy?=
 =?utf-8?B?OGc2aG9qaTNzdFRkMW1aTkl1ZzRiRllJcUJvK1ZLc1ppUmZDYUx0d1RqY1By?=
 =?utf-8?B?bkFYbFVVS0tadlFaTjVKUFNuZVd1cEllYzJZN0Y2ZkdOd1pYKzczaWxVOGpP?=
 =?utf-8?B?cFNWeHgvaTdNYlUyVm03VFJqSVR2bVJieGxsWk5Sem1XL3MybVNLeXp4MHZs?=
 =?utf-8?B?d3ZXWFV3Zk4xWG9UY3IvVi8yZXFlSUlFK0l4b3lDWFk1V2VmYndFaVpSTlFl?=
 =?utf-8?B?K1pJaFNRZElsQnVRZHRSa2xTbHpWMFo4MURtNWJJZEc0ZjZ0dFdHMHZCbEp1?=
 =?utf-8?B?Ly9rRjlYWjgwaTBrN2dZSWZBVHFBMjBITm5OVkVSYXhONXJaY3lpdSt1eU1O?=
 =?utf-8?B?MVQ2c0lZYTJSMTdmNDdZeklvSTl5SERpUDd1RUdyN2RRcWFGOElsWlMxTnpL?=
 =?utf-8?B?cGVaVDVmZmxPOHFndmJiczlrNGc0dEtaVWFOMGk0MHd6UEo4MFFTUmZzSDhw?=
 =?utf-8?B?eEhRMDBVQTFEblpRZGFLR1c4a0hqT05abEpLQXUvWDlOK09GV0hjMytEYmdw?=
 =?utf-8?Q?IoEws5tzJUq07yEiEXApY9vO4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef943540-fbdf-4d59-79d1-08ddc399aa4e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:18:11.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctxI9/7QYPw0hW1aBP6S1ihQZ+l7Zvzn0T/fd2TiX1gADYwErvAUJT9VCUPVy6ffuS4LyFr1wGLehMOyY0C/3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use min() to reduce the code and improve its readability.

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 9d80adc45d6b..fedc7d59216a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1287,10 +1287,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 		offset += 8;
 		while (((int)size) && (offset < buffer_size)) {
-			if (size <= blksz)
-				size2 = size;
-			else
-				size2 = blksz;
+			size2 = min(size, blksz);
 
 			memcpy(dma_buffer, &buffer[offset], size2);
 			ret = wilc->hif_func->hif_block_tx(wilc, addr,
-- 
2.34.1


