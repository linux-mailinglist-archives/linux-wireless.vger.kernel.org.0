Return-Path: <linux-wireless+bounces-29535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FBCA76E5
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 12:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5F78369F8DB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA467335574;
	Fri,  5 Dec 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RAvX+A1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0773093A5;
	Fri,  5 Dec 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923084; cv=fail; b=K1hlMNjdvhJYr98Tt6zyn0WDWOOo8o/xegPxdfRAF/gTModSf8f5TVIC+ge08UbjIlb/xQS0ZLNHS9F9GIbUKe7WyB0OwS0NTGGEU4Qrcm4rku1UeNcpAditlnPj5varOCXnKbc0iKLw1zkTKzn1STSqWi624BGQ590CVSR+vgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923084; c=relaxed/simple;
	bh=8Pezrz4NLL+ejYMpv8rE/KTvcQ0jgCPrTueQRPKPymc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QD9GlX8RbTFaS65A2nd/gOgzjgN5r7h2eR+08HTugSZ9rjogYJFtja38m3JMj6owiItSKJfh3zhyUMFSDPGiMZG3zDzwRq24aR3lezbJUlyEgm6zO3yoAh8haKeI9/lU5XuOtSL2ihLh/sM5yk2ubLpZD3SXzsddroMOs2MCiPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RAvX+A1s; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB6ru3IWR3Z1EeymzbQvrrcSw916IqcvUjulFBUf9jzNwY5Ka09lCAwV0WGAwqwH/ZUmOvPuMpa55qJZuzFonWJmlnWzjFzJ8TDY88QqJtWo6TXckLie0kqYJ2fHtU0xuH+I2OGpuigIlze+Wq5jHmPD65fTlKDDY8/R1vIgLnmWnyKr1+edqg5LTP229gP8pxC/VJgN3AcMLtDHbiA8otma1n9folmYBkLOdLBXzUeH4sKtRWPt1G9u/ObVUYt4aTZtgFfRCZGsDDkszTfYRTF9/4FjZrMavxYLEXglDrQ3bD8eNos9BqqNODqy7e8xkQt3XK4qg95napaWIcZUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPZZh53K+eIyuYosNo9u2a20Y8VID0uJjqMaS9Kmj8s=;
 b=mEMFAJ2FDUqKFB0V0dyxCBnQ8k7UPOP1GjHzbgKPjV9rk1b6NdmuvHDCIsrsmMunYKs0gxaIBAcaR5r8/4of6vddkLpQJ7Vc+b1gvuIjT3ODfMjPVJpKTM7hdr3nD3eDtCjZYIDeupTm/N4+hL0qu87wEJZh71OcJeHePSPRyD8ATeAcs2DteZE81DQg5CTGh6kC6WJmgTkM2hbIxvoiyo4Yf7nd5AMnbNzSTESRPARE0CPMWmQH9rRSyKmC6a/QMg8qTMzOU9lMayBYEyNBPz07/Hd8a1noxQFhg3Y7F1Lhmz5Beim1l0Wk2+BhSIX9LStXBa71jKMFtK8jMjxgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPZZh53K+eIyuYosNo9u2a20Y8VID0uJjqMaS9Kmj8s=;
 b=RAvX+A1sz3FZx/N++rW10k7OaSIJGPTnlx00IDwnlbOWewJOKcVFRSW0mVAfhlfpuMkicduoxpwIABq+ZFr4x0k2FpGA4OTPeAFOebxygKWzK9IgvNLE8GgfNxiehFYJkm7bMsCwjjFbjrNUCxudWHcRLEMPNJSMApZVMvrF5BmXebhvArQSViErl26mcALgUJCDWOeqono4rfkqNdZRU8YL/czMpxxdqbJDbAHCrhazD7IeKHTFzvse8CvBHM+OquvaxD2leSIvC9iojTcFHN9ZSVeOKCWFaLqlKISAizfl+oC9Gc+62DfD1AQ6yAxnZB/V0UTRHhZBLy+OTaWJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by DB9PR04MB8297.eurprd04.prod.outlook.com (2603:10a6:10:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 08:24:24 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 08:24:24 +0000
Date: Fri, 5 Dec 2025 16:23:19 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <aTKWd88nT5pOWCzX@nxpwireless-Inspiron-14-Plus-7440>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
 <fe78857f-956c-439e-a1a7-95ea19c8e932@oss.qualcomm.com>
 <2b976b880158605ecf74ca01420c184434371e2f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b976b880158605ecf74ca01420c184434371e2f.camel@sipsolutions.net>
X-ClientProxiedBy: AM8P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::25) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|DB9PR04MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdf7d49-fe6f-4356-6be5-08de33d7b27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHhnT3BZYWthRmhCa2N6L210NWJkNXpTYXd3bDVDWXdDaGpVL1hVKy9nRmpH?=
 =?utf-8?B?UFB4Q1gzSU1EKzFPVGV0YnZSN2dMSTEvR005OVdXcUJaWFJDK3hMQ00zV2lh?=
 =?utf-8?B?TFdobmNCa0J5dGU1clhtVjVmWnBVQng4dnUrNXQ0YytodVVQWU5JSmkvYUti?=
 =?utf-8?B?SGZMb003OHJISUJ5SGw5MGFUNml6Tnh0Z1FMbTgwMGcveTl4cXlXUG85blRx?=
 =?utf-8?B?UHVZVFRPV0xDUnBtQVdrR2VUWENOTjd2RVA3dnhIblhRcW5Nd1ZXK2ZLYzhJ?=
 =?utf-8?B?YUY4a3A5WE5IZUlKaVU5OU5WWG1mcmhXb0lGUzQ4SytHU2VybzZRblhSM290?=
 =?utf-8?B?NUNuM25DNVNwQzd6anFwWkI3bVhTeSt4bEF6TDBuU1gwWnI4NkQ0cXp4eVRv?=
 =?utf-8?B?ZUZ6TU5LR3A0T1dvbEpSeTJqSk0zc1JMbE1qZVp6OEdUKy85ZnV1OHlxNGxo?=
 =?utf-8?B?MzBIODBFT0RrR0hpYXF0QlNVV3VwcTRQVXlVSEJtb3pJVW0wZ1VLUUtqOVM2?=
 =?utf-8?B?TDRKOTRRQzAzVHd6MzY2Y09XdGprY0ZuK0JvOFMrOTZLd2NiNktacmsyRFZy?=
 =?utf-8?B?eVZ3L3B5YUFveUdNL1dvZS9icTlWbHd4L0lCZXVMaldsUzExY2hjSEZtdGR0?=
 =?utf-8?B?UCtSRmQ3WkxQZ2pyeHJOWWtLUlE5VGZ6MFpjSkIwaFo4U2dSYlFUcFUwdW9r?=
 =?utf-8?B?VDNmTDNCZmpuTzZUdXJsVXZQak1TZ3pLMkZXUlRHVDZBVGU3SmU1ZCtJaVA3?=
 =?utf-8?B?ZHBhMEQzU2RUQnFobzcyU0ZKWFFvc3hNYllUWHZxZ0d3MmNHSHp6cE9EU3l4?=
 =?utf-8?B?aWwwSjZJelNiUFZObEdoSFZJN0w0eDBVWTJmdjM0NnhNa293cTNSRlY5a09v?=
 =?utf-8?B?RUQ5amFMRGJqYzJEZ1dvci9vOHMxSkpPdFA3d1JzSTVqL2J3NmprOFgyN0JO?=
 =?utf-8?B?UVVNNUFxRTdyejh4cXpMcmJSL2o1eTZzZlVyeE9vKzJBelJiU1NEdzcwVkR0?=
 =?utf-8?B?V3RwcXRPNEJiQnRpS1owV2dGZHpVSXZvSmIxUGxwSVhGcDViMU85WWdpVmxm?=
 =?utf-8?B?bVB1MTdhY0JteUVXRDFQY3RnVmlwTTRiZThpUTg2LzFtcUFQWUZWelMzZEVs?=
 =?utf-8?B?dC9BNkZUL1RXWHkxeFZQMk5lOWhrUlRCRkZySVlnVnIwN0RxZTV3Tm9pUUVE?=
 =?utf-8?B?NVR2UDJXNXBXVFI5Yk1Fb2l5cmxvUldGcDhmQklweTdScHhFWlNxY21SREZt?=
 =?utf-8?B?blk3OVpDNEJ5TWRaeXZzdHo4czBmNGtURFBoZFJNeXdKbkYvclF6V0cxcHo2?=
 =?utf-8?B?Y2gyaC9tZWxhbGdXZzB2VGtKaUVibkZxa1B3S0hzek1yeVp4SkxEZWJDRzlB?=
 =?utf-8?B?QWNNM0tNbVRGWFQ4TkNuZStZcWN5OWdkak4vYUx4dmhQN0pab1Y3bXVOL09T?=
 =?utf-8?B?ZFQ2TTJQbjlrQ1dYZHFnS2JJWk8ycVNaUGRhdGszL1R5a1o3L0g5dG5odVEy?=
 =?utf-8?B?V0VmTkRQVFBwVjIxTFM2ajMvTWRMVFlIMDN0TXR3UUc2MVVDTngzaXM5Ui93?=
 =?utf-8?B?U0drMThVMHdCcFArV0FuenV5b0J3RDVhT2ZQQStuekx2SU0wWmdCd1NmNGox?=
 =?utf-8?B?b2U2V0VxamZZS1JGdGJ2TlBLNytJUGtUNmZKUWpjMkJjYWt2MDcwWENPQmh5?=
 =?utf-8?B?VjMwUHJBbExaUlpQMzQxdzMxbjVMamtqNXA2VGdhcXBaaGxscVRUcG83c29u?=
 =?utf-8?B?NW40MllBK2Q4c0c4TzRDSlZ5ZlNNcC8wWVJCU09wZElVeXk4SEptMEVwR1F5?=
 =?utf-8?B?aitSZUU2dWJ0SWF3MU5GSzEzd0t2c2NPSXk2c1hCVkIrMEY4YnRZMGdyeFdH?=
 =?utf-8?B?Q3lKOUxIVjQvaGRHRG04aXhIRTFNS1NMajFKRjBzNFRUV3c2L0tCdHVoZHZQ?=
 =?utf-8?B?VnVxU1JHOHN5M2VoUm9aQU4vdld4L3FtazJKZG1BbDU2R1dxWXI5T3Q1UzFS?=
 =?utf-8?B?TjNFd3ZUN1BBQTEwbHVBamlqY20zSWIxMWJ5M245WlBXejJ5YnFtdSt5LzEx?=
 =?utf-8?Q?QgrsqK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enFTcjl3SlBjbCs0bGtQTWNwcFJWUkJTWjBxZFZ2UUNOdkpsTkViUXlvUzJP?=
 =?utf-8?B?cGhTaEpvTmVYVjhJQ0JtQTV0aUdMdUcvT1duTzg1b3ZkVktCdjdObFY5TjJF?=
 =?utf-8?B?SjRRaFkrYVMybWIxOW1yRUFpazVMQXBUbGs3MktQV0Q5QVZFTlVjTnFnZXRT?=
 =?utf-8?B?RXRyenk3cU0zTkMvbk9nQktvaVRmUzhZNXYreXFpNXhvakY3NnFnV0NQcFNi?=
 =?utf-8?B?RW1GRFNTMzc4L0oyMnNBbVhSSVJUKzRYSDlKMnhWbE9GL0cyVzI4L2V2enVP?=
 =?utf-8?B?b015WWJteU5PZGJCcURML3AwYUNocVUrdkRzQWlTLzJrbjA4U0RuZFRxNGVL?=
 =?utf-8?B?OE56czhvVVdKUUtENnNPTmQ4Q1VKQUp3MURMVFZ4MjQ0cmlvQ1BKZWhIb2s1?=
 =?utf-8?B?U0hPU05Hd0laMGhZRncxQnYwdmQ2dnNnRm13YXRxVHFtVUE3b3p4LzdRdTFt?=
 =?utf-8?B?VkE1S1NJaVJ1cjVWUXBLTFlGTElaSDNVUHUrVmtCL1A2Zys4UG1NUmNicUNG?=
 =?utf-8?B?VEcxOTJ3aWk3eDhteFZqY3RZZ09EcTJLclQ4b2srdnltMlk0bXJpRTJVa1cw?=
 =?utf-8?B?MFVPRWY0Z29xTHQ5UnRhbVh6QlRxRlE2QjhSQjQrbHhqdGdvTTJKbzh4Q2Yy?=
 =?utf-8?B?MnhuZXNacndOcTdTWENSWEwvRUxaMmFlVGxMdWdQamNOK3JCRmlpbk1DWmd2?=
 =?utf-8?B?TXphWVVQZWMyaVNQc0RCU3E5SnIxWTBjbE8vTWJ1REFvU0M4VVUrbEZWbm55?=
 =?utf-8?B?Z1NZczhST3BFOWFwQ2ZLUFMrb2hsWVJIck84RjFjSDJnUkJjejE0bWRFbFdr?=
 =?utf-8?B?ZVdsM0JQTGRUNUM3NVcwVUhqR01MM0RBZkt4eCtVdE1Ma2VZcFFoaXFXN0E0?=
 =?utf-8?B?MllQNVlocEx3a0NsVytjTmpxNXFRM2hsbk50RFY1SDNBTXZvbFFTa3dvV3d0?=
 =?utf-8?B?VFdMdHQzcDVpYmJpciszMjYrU2QyV2FLczVDNXY4eWoyK3VFYW9lSlJkRlg4?=
 =?utf-8?B?MVA4S2lMRm8rKytwbDBSZ1JBNVdzMVh1OUtoNXpJck5lRWI3N3JxSENLV3pC?=
 =?utf-8?B?bk84MFllNS9UMFFnbDFlek1nZm1RN1BtUGZ4SktKTWxhNllLSVBKZFV4TFZy?=
 =?utf-8?B?T0Zub3pnZ2F0R2NObzdRbWFjSDVocUdzMmZ3NDE2bEMvdGZ6Y0VRQlY1bmhk?=
 =?utf-8?B?ZzhhbkdYRzVWMzhGTTJselhEVlJLSENNUS9hSld0aVBSYVdJNG5YQWxrOU5m?=
 =?utf-8?B?ZWorSVVLOXRLS2VHemNSNGpqYkxjSjltcys4UFVueWNpazQ5MjgxalFrUlVt?=
 =?utf-8?B?RHBQQXovQW4vQktJM1RXUEpsRDlFcXcvbkZRTHhLVjlNazJZcFdZM1VBQ2hu?=
 =?utf-8?B?RHNQTFAxREVTeVkwWkZqckt5cWVmZlJEZEw4MFBmdkhNRWN3M1k2dUw3eTlj?=
 =?utf-8?B?NVBqS2VUY2dpM2RDQ2xZT2FFb2hBOERPaDdaYnlHUHNpRXZZT1JrWHFGTUZW?=
 =?utf-8?B?c2ZqbU00SnQwRlovMTdya3BaU0lxUU5Oc1krbWVxaElxZ29pN3RCT3dNd2hn?=
 =?utf-8?B?dzA1a1hhTm83ZWdMYlVSb3NVUWdHOU5mR0NrbjJib001U3VGNVA4Sm4zTWtp?=
 =?utf-8?B?dEdzQkhBSTNjSUpudWhNQVRQWElhdGRZNDBBM0QyMitEYk5kdlJOS3plZmZw?=
 =?utf-8?B?Qi9OSjlacy95ZFRHK21DaThFdk1DN1hIU05LclBXUFNFNDZBa1VVYmIxbzZ4?=
 =?utf-8?B?SUlOVUtmaGE3NW04WHhCb29vSW0wSk5mTjlwQk1jY1ErZ0c1Wk94Yk9UdHc0?=
 =?utf-8?B?TVV1eEpOeHVtNVdCVDd2MkhUMHlOMi9rU05HSkd5dWZWRnZWb1RZM1JyY3lU?=
 =?utf-8?B?ekNrVG5PK0cwM1c4NjhNcS9FOFlxNldxaHRNbTdaaWdSamlKRjJPcDRjNUFj?=
 =?utf-8?B?d3NqL2FHZzhHczlHbHhDSTdjWllnOVZnYWpKYjFBUkh6OVBPOUdLaThsT2lE?=
 =?utf-8?B?Mkd6bU9BWXM3NE4vcUF1c2dBT3lmNVFrdW50K21OeUJla3lPc3diZ0YrUCs4?=
 =?utf-8?B?SDZpc2xMem9vVjVaVm84d1dJak9VanVuTGlHc01LckZta0VQUkpOY1hqVi9D?=
 =?utf-8?Q?zzzm87QVwEH0QKPqeEzffLquj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdf7d49-fe6f-4356-6be5-08de33d7b27f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:24:24.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arRKineD5VF3C4RWIdeuEFGN7BBE7lyhmsyaQpNRA8TkGcbAh+bCnb2juioB/ktc20nFXMiUhS35bimRHEEycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8297

On Thu, Nov 20, 2025 at 10:01:12 AM +0100, Johannes Berg wrote:
> > UNDOCUMENTED_DT_STRING: DT compatible string "nxp,iw61x" appears un-documented
> > -- check ./Documentation/devicetree/bindings/
> > 
> > Is there an associated DT patch out there?
> 
> Oh, ouch, this is something you should resolve I think, so that it's
> documented (and correctly so) before getting used. I'm not really
> familiar with the process though.
> 
> johannes

Hi Johannes,
In nxpwifi v8, I added the Device Tree binding for "nxp,iw61x". However, I got some
negative feedback from Krzysztof on that patch, so I’ll fix those issues in the next revision.
Thanks

