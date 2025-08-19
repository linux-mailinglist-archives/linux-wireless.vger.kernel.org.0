Return-Path: <linux-wireless+bounces-26458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E5B2C2CD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 032204E23BE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C383334707;
	Tue, 19 Aug 2025 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hGu/EWT2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013019.outbound.protection.outlook.com [52.101.127.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0520C000;
	Tue, 19 Aug 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605550; cv=fail; b=pGphEN821FaLObPFXv7rdVAFWgsi3kK2Gwxm/qfboo5DikGvJ0p/Iql3pkdNwhNYerK8ToymvpijPxbBD9YtbOKXK/+JXK2uiFEo+ZZxLK4hILdBtkV1x+Hg3gjUVCWt2mJwE5NCKZf0mFVODgAbHYWXOPw0PthzCr927tAr6OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605550; c=relaxed/simple;
	bh=CCwDXkjf0h643h7x4M2zGSUZWWXmRykx1io9ph9vpRA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mPrpftM/nRmAR8/xwduLOvJOZ4jjLEve1EVrW4GRnvG/Ov7J2HSVdRN12ccBmpgfXZi3CB8ATsci/SeDBDEkltYoPGR6KPHVyVUVPlmAIXJykE9cvB/nP9fEZFpitYN36K7uv4vCECqQTCp4SX8pWr7zrfJM9WwFPsFyvuTEMOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hGu/EWT2; arc=fail smtp.client-ip=52.101.127.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFuVvAvWiOApblIrZY2I7uRTprzGN27eG2MMmO2m4uQznopywppafMStiLqTI2LGuDlHQykwN7ydOuWmaUHEZUshDYcCHpL/ijDfXkrIXlf6QYVtN++Nw0iJvXiGGZTt409QKRLgMQRxaM2NNi6/WmHJ82KkBcSKAV3Ax7yRAQgRDxHfomEE49zpFitqcnXmcL0La9wg4EfjFA2Iqoa8uM5tB/Dg5c5E34AwJQXFrGoAMB8fIlofqjkSuo8GcFjjDhoDbHuVbnBy2Ug87fuVDfVCPfJO0phQCX8Z6vd8L4BW8sJy+RrMAMKcQvFGmIrHgUid5TmOmyrZDlg5ly313g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpJPGMxV/f9LxVyWnaSUPX8PIJ/q0uF4DHAU/hMYeew=;
 b=pCMyU2mfBC8176N+3MRR84FfIN9cd5cOpn89LFFvMjniuNmxM3bQ+67jFdvV4XD8qXJG4OQd7NhBcNn4JHc/G1F7Ee1LOdp/cW75NTPDMyzpCEnfmqwVK/5k/3/85dlIKVUTqcf74rz+rMub6lbJ9Y3Eee/FcWNa26leYq0OrSBUBdB82bW6kNpjD+PRZJJyJneZZcjEFVr75l+AmMBuno90yNb9d1d9XN3CV6kaSR76DmsO3hlPlaEPLxiD/YSi8N1HzuwWivHVsUWEWbpl93QxORRtB1MkWplW2vukZQNPuV7ri9iuHXrnQpvVioIBMHzOJOLBaIGojVtI0yBfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpJPGMxV/f9LxVyWnaSUPX8PIJ/q0uF4DHAU/hMYeew=;
 b=hGu/EWT2/bwlFMmBykmng6tnNawWl8hX+M8IV3TYHbF65nvO+2ahwa+3okKSWscvWuEGWmXasq1TBkpwklC11N2SX5Uz3dnvh0Dc5fus+WpeSsi5EDqBWED3LoGXzPwmikYis66Gftjmfy0RDFhiIjSa+SeY9VL5CmsgFr6OjxKgZBJcWvGhFoi28p4I7XYs0iTub5jjCLMRK5H1fSruAxs1SmAJLN9lzEVLKmYU3+JLVSPHtOrVynD9vf5Mcal4Tiiq1o/NOG7fLk3bzEDEH0wYT6SoWnFS5UBT+R1jV+sJ0k2PRtEt0ZVatsG0JyE+va0BhC5hctSmZESDF+wYbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6828.apcprd06.prod.outlook.com (2603:1096:405:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:12:25 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:12:25 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>,
	Rotem Kerem <rotem.kerem@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK (iwlwifi)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 0/2] wifi: iwlwifi: Remove redundant header files to clean code
Date: Tue, 19 Aug 2025 20:11:50 +0800
Message-Id: <20250819121201.608770-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ba9440-2b76-4216-fc8f-08dddf19a89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z44SfdNvQ4R38jlxSJPxAk860wVJHqF7aqNLAR4T84ZwJG9epqPVdTykb9ln?=
 =?us-ascii?Q?SmcO1PZaDLzQtwTkG+Zc+Sji47MswlprdxDYeuaqxnwgs7w4ZKCGHx/iYYwf?=
 =?us-ascii?Q?5xTbAEAIKesdK4sVTQiwH0BKwW2U6od8IuDzyfM8HZrNP2/wRioEq3TQrif0?=
 =?us-ascii?Q?pODF/NBjHLL7P4su5dcol/NKs5WJ6kBcJ+SlWXnlnnbJpjfhgNGp3rcxY6NP?=
 =?us-ascii?Q?D6zx7Nw2GB1WD14y7jZXrHQiQtxx3h9iL3jacVPt2cWNyiVjKdbF2QC+PyO0?=
 =?us-ascii?Q?wtKeRNORDlCh7egFs2l7DvdIawKifjsTStKuHHUVk0wWQB+7kxhNnJRC1Vq5?=
 =?us-ascii?Q?ZxjEyd42tVHUb2eMxipYP8OJWU63ATjg/gmyYLj3Ngxhq11HTtg6No7bJETP?=
 =?us-ascii?Q?yvDSZDyxpM+y9oaYlh5TN4BZdDF+zvmdZcUXhc+QzpRe15l8/eP23LJyaN0c?=
 =?us-ascii?Q?CZHbAOM7thrXz2b+1PFvivDjHItchjif3GQqTso3he2U8ZzFfQX7mBnFYsxl?=
 =?us-ascii?Q?A6Xpg6X6yvMp6qtjmEhDNW7mSLUz+pmsdgnOSpJg7WCC/D0iiV26Oo3mTBho?=
 =?us-ascii?Q?0xTbC9TdL8w+BV41zfJvRzCU6yM2FAhNt5Sjh/dVPwB9Op1lOOyJzzsbsd9d?=
 =?us-ascii?Q?vXLjTjknuXUlnGe2bbIuzvbGDP5n8EBlzgZidYUyxn5THQQlevsDisT9PLYK?=
 =?us-ascii?Q?bVedpaoCN3SF+OilvRci3uu0Se/JoofhLuefobnWvNfx3EgpNfozrgpD2xdr?=
 =?us-ascii?Q?NQ5GhOZtl/oubrnQ3GDyPIPOK2CBnnFxEk+wKBOVrELU5SbYEZrUnWFS8nJx?=
 =?us-ascii?Q?omChqDD7MohaUTQOhrS66IV4WTuyfc2DH7iJQgAZFdQExeWrhuY7gc9M3aBR?=
 =?us-ascii?Q?5R0lXL8epvvBqgzOrkBRlb0NpQkV4WYIpxcQp4spRAVaAS8i7iVoFf8fCMFN?=
 =?us-ascii?Q?b0GocmO3N26ly75ReHv8CUSY+XL1Dx/lrguEyrpb3RNi4YHVNjLODx1srvkq?=
 =?us-ascii?Q?3OtWyYjPNeHP/aPgJdXs4ekFzgmE5ATGx/VD1TDD9jskFIUmyyJISZKA9nge?=
 =?us-ascii?Q?dz370aZw0nZ6gjv1qjBfunC3836hJUm0faXL0mfPog5ZwvJShrsgBvpFjKLe?=
 =?us-ascii?Q?DzLmefbfd6VrkazklKjO9Os4a/SZ87QPeFM1yrGuzAQdE68b6Gj6Uuqp1O6V?=
 =?us-ascii?Q?ulyHAvT7rG4ykiqBpJ5LYfluiLwuDMLNqSN5+PXnljri0jv4ligl6d09oszt?=
 =?us-ascii?Q?l2KYy7x0PHNLCznefLdTfNvitEeTfJQmdHGaKTEp39ugFyDfWSygS+wHebtH?=
 =?us-ascii?Q?AKQ428qnd+pH+/wlLSsJz1QD5TvlJNjZJhY+clVyiIFxwt6MHCw2W6wvlmiJ?=
 =?us-ascii?Q?Wqq3yCBN7xYTp0IYhlcBx/Lqbj+khAfMtPNAjP2aCQhUwXiYgsaD6tyOThUG?=
 =?us-ascii?Q?Zf2zQykai40ud3TFevXKO+TIXFpI7d/yEJmb8OVTRU5WUzFXRJjIHNfHcJkj?=
 =?us-ascii?Q?GE2VW70rV3kDSIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrQX6adpUs87vcxFfHqOAMi3bvT2/fylMcTJ2dXI0HWKCQGw7VT2kOzQi30p?=
 =?us-ascii?Q?voS+hIn/BzU8ppWZqXfhjlLh07mnHqqUqSYU2Pto3KFdwgNUT3LRv/NV33Pq?=
 =?us-ascii?Q?YXd20g47EvQAxMkT4YLJZ4wpJqwx8g1WfxHoOM9UFh46VLxDmGe4YKroMFHd?=
 =?us-ascii?Q?eOYyYT422d9IoB3S43rqCidsG414QTQ4djGmEulU5Hi8CmBa6YPj4E2Jiy5I?=
 =?us-ascii?Q?jqp9yPqNc2Or27k2bzlgXI/L8KS0RLhMulNTuu6rMEakvoQj2tBgBm89qsr7?=
 =?us-ascii?Q?LaGGBF7PdCxTPPh4gH9YDs9QLGd/JOY+jdDoKqj6fhm1GgoYd2If+chWQSn4?=
 =?us-ascii?Q?QQQprQZLWT1hWa6ZnBitZJudt0guKrmcSZMGe11FEs4ZX7rE4RDdvM9mifAN?=
 =?us-ascii?Q?RxfRNq7quZW7k5to/4fe0Qb3FjRxzffGwSF33BU6+E6CQbyiwjyxC3ggu4me?=
 =?us-ascii?Q?vi9XfRYXQXu7HKrIBEX6lqzrVTIqqp9H2bqD8v7jMAniW7G7u9BHLmKuE78I?=
 =?us-ascii?Q?cBaDReMTKnOJidKwxE0uARJP/F/Av4Lj9vleCS7DITuiUeN2fQAyswJB4BO3?=
 =?us-ascii?Q?1NvBykTLBI45aH8gHKg6FFEA1GZhjsxK32oj1Kcw/VeqVpxhjpOPtUT6GFFp?=
 =?us-ascii?Q?fJOFS6A2ETeuTvZ/UrCYmhXtk4jlBvrMNKRYSCuvKI6RrOs9IMGoUkU/1mqV?=
 =?us-ascii?Q?3bLLlajnGxTNiv93RiFlQWquo+enCmEiFRoecHuvYzk+EeYGhWQ+7qmV1Lv7?=
 =?us-ascii?Q?N5aQapR4sK4hD6PQFKXMljsLjXLtW6donJ+eQD1u22Kf1qJzHDrRsmLSM/nT?=
 =?us-ascii?Q?PSVLV1mWfcxvuoQZRKhCidR+oqpeIXi6rGMJk+4Gumyh+vxSpDyzDAbU0AT+?=
 =?us-ascii?Q?NAgm8J6ilt0JYkqA38gg0FCUlstJkUngyCoWDa2rq0rp4SK6oIwrLe24rmg5?=
 =?us-ascii?Q?W0JFvIsbn9iZs6amBdhJ82yiTq8VIDyREmuVVIhz2m3fY50C71VHpCMLCJCG?=
 =?us-ascii?Q?xc3qRcssetRSPsLGqtWGxOj1XTKLptZHOkif5vqEM3AIG1SBiFPHUM12aXy+?=
 =?us-ascii?Q?YjlhOqjnzjvGC+DnAzwqL7MuEu8Tn8gUOyVX+LIy3+kFsVDpkzOEgXOCSiOK?=
 =?us-ascii?Q?iy4JjGpTbEyOAYcf5AYPswb4upsEewqiSOvZYwo7FsWsWGV2+9xa/dTOZz+G?=
 =?us-ascii?Q?2JF7RDkTAeiYcFIy1SO4eFUyZSNLde0aegTsxlOZWBObFCQvQk56iHsib0+Y?=
 =?us-ascii?Q?piqlxytG45aeTRTscM3DlFt/Qb8uTb6qhq+LhYR6FCG9rvpJJv2lCcO4sOdg?=
 =?us-ascii?Q?oKSQaT7sOPTrxq734QpA4Vmar+8lC2vg9UiI8bxi6JBlw64ng6IZMGHWG66m?=
 =?us-ascii?Q?qle4WoNkXrDmPdhpmmOt+Q+18FxM3I5YkGMpRN4gd4yA1KtGpVbdGWd+kKaq?=
 =?us-ascii?Q?m7XByzFkW6rZ3zj7SoymTJPreQlFatAdoOAmk2yMRI2N/Ez+fo5LGUzN8Zr0?=
 =?us-ascii?Q?MYON35AKvIF3jR/Ss+iHnllAbREYR4u3VPG7lNmA6ca9uzqY+GLlj9SaAj20?=
 =?us-ascii?Q?b4XxrntaICt4/wQ3b1AWU4K+H1ur0ggOgpxlLSpj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ba9440-2b76-4216-fc8f-08dddf19a89c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:12:25.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pA6Z8UE6P8Azx23xE9FT1U+WTqUiDj5f6DawQd5vGdo2u/6zlsIb4Hg+hgXUZ0nlojHIPh81sXfS+Abkc4tRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6828

There are two files with duplicate header files inclusions. Remove these
unnecessary header files to clean up the code.

Liao Yuanhong (2):
  wifi: iwlwifi: Remove redundant header files
  wifi: iwlwifi: pcie: Remove redundant header files

 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h     | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 1 -
 2 files changed, 2 deletions(-)

-- 
2.34.1


