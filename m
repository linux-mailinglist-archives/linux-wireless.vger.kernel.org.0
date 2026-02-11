Return-Path: <linux-wireless+bounces-31738-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bz8FfODjGmfqAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31738-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:28:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14A9124BDA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77DB6306C11D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51B25A334;
	Wed, 11 Feb 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmQHmreG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE0255F3F;
	Wed, 11 Feb 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770816446; cv=fail; b=s6ynlaQaSsebGSDEUoX/OSXBsztm1pSwbku1lnxTerF/gndIn6A6xqALTz/NQFJWxLdV1CDIkClF0h64oy6kBlXYIhWMUgQ0YbnwpuapagAxHkhj5hf3Me+DgbLc3MpJVKKgoLgXQaluGXWpB8SrxiLsQHfdaLfl2EOK8Sxcjic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770816446; c=relaxed/simple;
	bh=g0yeWjaEoOCSykX0Du0R6vkbmfQpsQf9CqU/Q5/pnuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OhFiwx8xiaFlUqERjtvBbS4lt0Y67mA0vCmekU7UlyQoxzongvYMlADQLRsNK3rh5foWTpoZUdMSBqGp+zTEo3fZWX+6OmpxcSTyEk4RrGPx7VT7xio2ZpUeLY39fJEZojOZ34HaJk3cfXW28RE/HwWAUUKd60EzysxhVC6vejg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HmQHmreG; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5o2cogt2EtvvvxxX3rfjwu8lFmglNlIw0lvjNo1419dSc+wxsvgOvYAVIELJ+Z1grEIkV3mrnW5Se9PvCxh1HwytabkLzukti7MSko59+pCBwAo3wojMEPRLenmrEvRot7jIMRLYnjKZ2a+yQIj6sjraIo4LJJOMBqk0F0AkW2Db/TND65nHTOkqpY+PabAlo8gbEl+/9gzhCsLJRuMuBzKrmKA3V4DDgKuOjv3dAmDnW5HVpXYH7z3XyGOpZkqdGKd7Q9W4nLAq4X2uYWBL+jq2OWycINoQPMizZHBehHdhs5hu4Gy/8VXt8KWYt8Z51DKhAJM07qcXu4G6vyToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vUnho7gOt06+oGdKKk5gBG/U8bpyc025EOSaAfqXyA=;
 b=c1qvgyTh1z0626/qKTvDkPgTu/P6QD4GW/vR5I2sjzJ5CfuUhC/UR2/4E7Xuc1bZ60lmnqmlIfpfvhrY0kt4bAYyEaf2e+PEphtLpn/CVFAdBkeufgc0f4vOgY+fDEFCDXA1Gspmp86ZDZd6byDUob99Ra65N9Bu6/zoJlJs2Txqsib3WhN5PQg3aGCs5GV4YuvrbxNUssVlMJElestzSNmmC8nslkuv3TMKRBc6M9A8Ji4f9toJ7y1BHUef3+TsY0Bb9XecMNJJxgoQNhvW/7st95PF0lKeKpcn5rPSA9dvQegGiaXFx8rTwZ27fRFIds3Jf/AZUyEGTg1T23FEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vUnho7gOt06+oGdKKk5gBG/U8bpyc025EOSaAfqXyA=;
 b=HmQHmreGYNpr/e2TqQqyFEusoNg8pNCzaF02wiKrigST14xtlcRxmpxjurtK547cecHEgkiLXs49p2fZCGlnWdllhTaOGnKT62+k1CNafgGdbh9X4Q7hkpdkJKKRHZ27Ri6nLzsoDWqnVuAxRLtLIQ9UOBgFrX2Uve+Ng0o4SMSIAmKlCTkkZXwhU/j4cSwobhVXDvLjhAB5Rm7Pn+6ItkCk29/uRqj0KAvT4tYOZDPnDaGlSn1FwX69iE5U4ZMnQh2avmqOvMhQrv6LqZbYQDUtPO/P0Vl8zvE2bGvSwHGRz/OfcB60r/Jzrg5EkjteN/IlddhnX8xsZqR29AwaZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by DU4PR04MB12373.eurprd04.prod.outlook.com (2603:10a6:10:62d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 13:27:22 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 13:27:22 +0000
Date: Wed, 11 Feb 2026 21:26:12 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, s.hauer@pengutronix.de
Subject: Re: [PATCH v9 12/21] wifi: nxpwifi: introduce command and event
 handling infrastructure
Message-ID: <aYyDdAmlvI2TqNA0@nxpwireless-Inspiron-14-Plus-7440>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
 <20260204180358.632281-13-jeff.chen_1@nxp.com>
 <372f8174-f719-477a-b7a6-6b833f906c9e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <372f8174-f719-477a-b7a6-6b833f906c9e@kernel.org>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|DU4PR04MB12373:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b7545f-3e8e-40ee-83a0-08de697149d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2xaZW5PSWFkN2NPN1pIcVduV2JUN0t2OEk0U0dHdXE0VXo3T2R4Q050TFdm?=
 =?utf-8?B?eWhZTkxEYWFaTWdGRy9IR2tjaCtoSDljRE1vdUxOc01YUFVVYUVPK2hzMXRQ?=
 =?utf-8?B?MTNGZUgrUVpBbWpmcDgrbHF3ODU0Q0JBRndMOGdKNi85ZkJKWVBzTEowWE91?=
 =?utf-8?B?S3Zaem1WdllhcDdyMXRKczNjZUZ6bXlvdWJKMC8vNnJDS2RoZVM4T3hiMzdT?=
 =?utf-8?B?WUxYZEl4UEdSTmlReW9CR2ljZVFzNW9CV29YUWZ4SElTK2NLbnFNMzdveTIv?=
 =?utf-8?B?clg3V212c3BiK3BBL3VRTHlBVFBCSlpkdkkzOFFDUEhUQmlCbnk3RWlELzMr?=
 =?utf-8?B?TTlSVEl6RXlqcEsrT200c3FsUkpLem43bHlUZHQ1d1JBaVdBUitQUDNXamtN?=
 =?utf-8?B?Qjc4eGw2VUpwMzJ2dE1mcUtIMlhZU3BJT1VUNGIzR1dvOC94T1BQbDVlMyts?=
 =?utf-8?B?eXhXRmFIZm9STStua2tPdlZKcFE5S2FKRE1RZmpZanV1S0diTVMzRlZGdUNJ?=
 =?utf-8?B?SW5wK3p4b1JVNWJJWDRWbUpiTjdWNHdHdms5Ti9HSC9OcjcweHB6U0FjK3JY?=
 =?utf-8?B?UXRkazhNV1FNTVNyUUFySVVoVldjZmRkZ3FSRjNjSFMrSmxGc3ZRUWdMaUxJ?=
 =?utf-8?B?RThZZDJwRy9RNDRtNHBYN2lSb1VwYklycGpFaE5ZSitkYjJEVXFQSnZZOWtw?=
 =?utf-8?B?VERBaEFJVHZMUTlhMnZoeW14UXFzZjFrTEM2Y2x0Y25sRWV4WkxlSUhzTHRt?=
 =?utf-8?B?NG4rR3d6Y1JrRHcwdStOZHJ6T3NHMW9INUxuOEpha3prYVk0ZE9Mb3oxRENH?=
 =?utf-8?B?UGZmUXhXTFRFNGh0Y3hCazVrREpheXBvTVAxUENlQ3F6SzZnd3d3NmlIUHgr?=
 =?utf-8?B?VEhtRHlaUmluYTlDNHp3WjU5S1ZJeFV2QjVrZlQ5NlNKYUpRQVZLWk9sc25a?=
 =?utf-8?B?UzBPSUNINWRQalI5OXArVjczbjg3a1lhNXlrYmN2bGNUZWtScTE2ZTV3Q1ZO?=
 =?utf-8?B?NmE2dExWTitXOW91QmZkUHF5dWx6RjJ6MUJHOGNEQm9oS0haampVUXQxRkJ0?=
 =?utf-8?B?eHp1Q3dBZlM3blFRU3FpWlBRc1ErR2ZDNWM1MXQydU1qVHNNN3A5NDhoTFlC?=
 =?utf-8?B?Ui9pczU3OVBweHljWnBoWE4yYlFXZUxSTFV1Sk9ncjlJWmdyODhVQ3VEOGVQ?=
 =?utf-8?B?eTFOdTdhODZpcHJ4K0hvckNIaFZKbzdzT1hjN1FnWlVHcUJCVk1VTEs0aVdj?=
 =?utf-8?B?M0V2eDdOL2xBK3d1TGtPanFWZU5lOUJyMVlWbGlMTmQ3Q3h3WitGNHR3ckpI?=
 =?utf-8?B?aUxkaHhRLzJnMnpVZW5wNlBKOURuOWg4N21KM21OY1Y3SitBSlNSbllBa2RS?=
 =?utf-8?B?RlNqcmlpNnlqSVo5OHplRnJyZmtsWkwvYSs1N0MrQUdyQUExY1o0b0R3a0N4?=
 =?utf-8?B?UXptQVpMTzV4b1U0K3NFblZWQkJub0lUY3B6bzdzcTJESmZiMDFGTmFUSGxX?=
 =?utf-8?B?VVN2QjY5SXJBcVBFcm16b2dIRlMvTEx0SFBzdytYQ2xwd3R3RUJtV3ExZlFK?=
 =?utf-8?B?NFJpbWVadTFLcHcyZDlCN3YwTEFESFlYKzlVcVlKZGtVNStuRVYxL3ZacStF?=
 =?utf-8?B?TDl5RXdZNXlXcWVnL0pvVVQxQWJvNExYbVorZUlsSG5RcUowSzFLbUh4eGY0?=
 =?utf-8?B?SFJsM3RubmFUdWJjK05PMVNqYkkwVnJvdnIxbHZXTEx0NEJOcEh2Rldhb09H?=
 =?utf-8?B?U2Zab2M5eDlOaUpzaGV6S0RqZDlMN1lFbmQ2ank4bWt6d1Bpek9ENWoybXAz?=
 =?utf-8?B?Z0VhQ1Vza3o3ZnlHaEpKL3VmdGhLTDZRM0VSYXpJSVNSKzUrcUR0VDZsOS9a?=
 =?utf-8?B?L0tuZzJvM3hvM05NM3UyNUIvRVU5aGloNkhUQVFTN0Y0NEZJaGtFYUVJOHZC?=
 =?utf-8?B?RitRdWtRM1BNQUVZM0lZVk94T1I4MVBjMmxDK1laN1JPT0d3aCt3WHNyWXZ0?=
 =?utf-8?B?eU9KVk4vUSs2Y2FhaUlrRTBFQU5YelpDUVN6bEhzbitudFJjRFN6Ukszd1pN?=
 =?utf-8?B?WWhlNkl5V2pTSDYyRTdBc2Z5eitIcnRlM1ZPRlFpOUJPTVplRnhXY2w2M3I4?=
 =?utf-8?B?S2dYU0YzSzJwZ1BETUl1QVBKRjFwQkV1dUo2ckdRMDNLWlhtbThlTk5lQWZI?=
 =?utf-8?Q?GCNM46QS6tJWoGkGnD+TSN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmsweDFxaHlNZEhSUjEwRDBSdVYvRm1JalhRazlwZGkwV1VFOTd4MlRXUk5B?=
 =?utf-8?B?WmhNeHZTR1pYM2pxUk5RUWZGZWNid2FwVndzRUJiWEh0dU5aMklId3prQzBH?=
 =?utf-8?B?b3dWTEJ0aGNRRkZzeXREdndrQ2w3MWliRkU2ZlBZdFZPUUEwR2FIaFlnQmlB?=
 =?utf-8?B?SzdEcUFBdjZnUkpnVmV5eFFUM21SSUJZenI0YUdBb0MvUEUvVXhwTk1NWU9k?=
 =?utf-8?B?MXRoOGxwSzJ5YzZKY0VYODFUOWhmL09tbTZqSmNoTVpyZE5iR3BVUHAyMktL?=
 =?utf-8?B?eU5XTVhkM2xtcUpNYlJjWDI2YlV6cGVtRUkreE9yalNqN0hNTk15dU1pV3Yx?=
 =?utf-8?B?ak5kRjhHRmRwVzljSG1Jb0lLeldSdzRoMm5xbVFkZnlEaWdha0F6ZEh1ekVE?=
 =?utf-8?B?bklvYzNrajNQa2wxY2loS3IrNUhETEYxWnRvZ1dtc2ZIMVhBNFNNTDBnckZB?=
 =?utf-8?B?SUJtTmFCNXZlQjN3K29icG5YSXhUZHZHRkhadnkwK1NQTWVxcTRCSE1PKy9w?=
 =?utf-8?B?dmhyV1IvWUkrUS84dmJJc2M4SUJteW1xdE0wUnVSMy9hVWcvZVZoNERrZnZG?=
 =?utf-8?B?M0lxRDJnczkvT2lpTDM4MzdDZmFYOUpXakMwa05CditmN0VPKzlDNjJBZzZM?=
 =?utf-8?B?eGhjdGwyeXRTK29FdTBxcmFWV3RGWGZtSnUvMDlwZGV6bk1GenYzUlRZNHo3?=
 =?utf-8?B?eXRHRWVpZENKbEdjRGVYMHkwOTdmYWF1bEFsSCtwb3B1Ky82L2FFQXprMWpI?=
 =?utf-8?B?SHJzbnN6TnZKKzRGTmlYT3RYaVlLM3NaeFpyOVdJYmRBaU40b05nbUQwajJB?=
 =?utf-8?B?QzVLRXo5VXQyWUM2NE81SmUvRDdORThBTDNDNExla0lUNXE3c3VLbURJQ0dy?=
 =?utf-8?B?NVlqNmdDWTJGc1lYL3kyREF1cnFBNzdQMldvNXB0R2hRMGo2b1RBSjAwUDdO?=
 =?utf-8?B?NVZDeVFzeEtmRWFNYjRVVURFb1NTTVkreGlOczdLQnlrQjFWYTZuYUlmVTJH?=
 =?utf-8?B?VGw2Z2hBYVEzdzljWHJEQ2ZNK3p5WjJjTmVYUFpDZTU5RXhISi9pL2ZPZUlm?=
 =?utf-8?B?eTlRNVhOYXNXSTYyTXRwVXNUeEd2TVFubFpqSWxHR1RQNUhQa1AxRnZZL1Vy?=
 =?utf-8?B?NmE5Z2JValVONUtmQmRDdXlJdzJCZk1pVXlEdkFCNlU2Q2ZnRUZYUU1ZUm9w?=
 =?utf-8?B?U0Qrd3BaR0FzVm1PeFliNVUzZDN4UmFBUTU1R0lwdnRmV28vNFZKaWlsL0p2?=
 =?utf-8?B?SHVFUFVpVTczZGV2UWt0eXE5S1VvazhPa0ljbExydzNuVnpNNzk2T1BmRzl0?=
 =?utf-8?B?NlhLUEZUaGFMbzJhT0poaENSbk5qWVhQcmZ5RGI4Ykh5SmtkVGU5akc0c2dF?=
 =?utf-8?B?TGFEaUs2eXJKdzMxR3RNdUdzYU1udGpZc3ZvK1FCMHRrL2NpSmQzTzlFMWRT?=
 =?utf-8?B?QjIyQUp1eVZ4dDgvRzhGZXpOZmU4REx5UXZLNGRVQ2h4QmllYlUrcW9RVldD?=
 =?utf-8?B?allLQkl3MWtXWHNsMFFoMmpIZ3JmaWtLdGVpRzhWN3Jmb25lVm9uVU5KQ3lX?=
 =?utf-8?B?RS8zZ2xBK2hTNnlHMlFtQ1ZjVHRLQnFGS3ZIRUg1RE5ZR0U2RWV4Z3dNOXBJ?=
 =?utf-8?B?WGRCSHJtLzZVMEhBY1ZoVloyQmEyeVFHelFIay9QYzFkcllVVllEL1F4UDI5?=
 =?utf-8?B?dzZQdTJGVnpqbjh3Rk4xeXV4V2FXa0x6dFdtUE9XTFF5RWRPd0ZRZ3VneDdZ?=
 =?utf-8?B?N3Y0aUZyWlNxSlNyZ0czeWFnWG9CaHRHZStrdCt4ZnQvbEJ1ZUsrSi9YNThq?=
 =?utf-8?B?VTdVeDRNZllnbGs5WXBDaFl1NFhBb0hCZ25XbE5sMSt0UzVrN2pIMzBkZFh0?=
 =?utf-8?B?bFU5TkNnWkgzU2N5M2RWV29GeGh1RWlHay9pZ3ZYeGVSYzJhek9yZjcrYzdv?=
 =?utf-8?B?VFgrYnZ5M29FR1VPS056ak1YL250ZXhhOW5TTVdMWkRkOFAwV01STm1VZTM5?=
 =?utf-8?B?dE1FUGNTOGhjL0JlVjdudzBZc01DNVJDWkdIb0p4TmJqclRZbTJiL1VvVTg4?=
 =?utf-8?B?M1IzRDhVZ3pjaUpqOFRVTDNOcVZzTENOcEw4NmFialozSDZtRHBkbFYwbEdI?=
 =?utf-8?B?VmsxN3lXOUt0VUhTWGJUbGNZWm43MVgzWWFmaWl5dVZBa2RhMnJza1FNTjhQ?=
 =?utf-8?B?UVp3WkhwZGNvV1llaXZuZnl4ZjRoMEFHYStvRklsak81Slp1YUxxR1ZwcWx5?=
 =?utf-8?B?S0NqSUFUdllLcmhwT3NsRHdUY0puTkZabTcxRC9henJwVExjeWRMSG5Tb0Y4?=
 =?utf-8?B?YTNGcjA3Q2FyZ0RJWU1UclplRFVGRlJURFBoeXJ3cVRoUUYxOXUwQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b7545f-3e8e-40ee-83a0-08de697149d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:27:22.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyn9oF7mVXDpbsAtyVNo9lmfGLEvDinNsh+cJ772wfItKkNK1dAIAenNDQnn5MiLNe6zfyDiCUEtd5i4ErIKmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31738-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: C14A9124BDA
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:39:03 AM +0100, Krzysztof Kozlowski wrote:
> On 04/02/2026 19:03, Jeff Chen wrote:
> > +
> > +		/*
> > +		 * Download calibration data to firmware.
> > +		 * The cal-data can be read from device tree and/or
> > +		 * a configuration file and downloaded to firmware.
> > +		 */
> > +		if (adapter->dt_node) {
> > +			if (of_property_read_u32(adapter->dt_node,
> > +						 "nxp,wakeup-pin",
> 
> Don't sneak in ABI. This is not acceptable.
> 
> NAK
> 
> 
> Best regards,
> Krzysztof
> 

Acknowledged. This was not intentional — the DT property access was left
over from earlier bring-up work and should not appear in the upstream
submission without a proper binding. Thanks for pointing this out; I will
correct it in the next revision.

regards,
jeff

