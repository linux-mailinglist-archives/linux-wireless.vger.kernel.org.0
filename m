Return-Path: <linux-wireless+bounces-29537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A301CA7709
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 12:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795342914C0
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141430B524;
	Fri,  5 Dec 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JKl7IgcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262E3176E1;
	Fri,  5 Dec 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924120; cv=fail; b=Wub4URhG1ivBpxMnGSA98jWZXpK8lF0iufHkMBg0riOOv5sswMMdHoHeB8ndW8dgvP1ZsmCUABnDJRrJEhtvuRhAnKvVegVp9sh0ERmEyhnh8rkF/QAMu0lrs9unrNkgGsG6rjW6J6x8Em1/DV89It6RD/qhbxVj7K6MWONuzHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924120; c=relaxed/simple;
	bh=oBaWS3k0rA68Vt+xYRllz4nPlll03zvSwgiaCKV2lNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdJspZXfJCFneoOG8z+CjB40E7mS4FyBJDHo2Lq4vAqC3+ZCg7VXLSrahiq0V7YgVgwA+IQ8WfQkjy+B2Pu6yabDJxQQUexnvzpYcdNgnYt5GJwbuuJHOqZvDQlsmQwmj8FcU5fFyCVqMgCo2KpKyy7xbdiuy4IqWQlW+0jiYRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JKl7IgcW; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnofSC+jUehs2Fq3IBheQqwVNQDFjRWdthU1grmuUb2QPdB4Fc4SiRvA9EEp3B5x6mbEa/pWwIZkqsWY2INeiivrVoeddtmxoWMsuHLc6J/cGLRqbXeXvj+W8qlNoCgyw4UxjEE8AafW8kci/Zr7WDN4t1+7fnWb6iwh7Bltb0wqpXApA5A4+/QPb3Cerimn2JWyPJDPRgRWim16vJ6nCIlQYHvTTpXgqB4SsykeMottI7toxgo0FfkWttqLf7in9dCqhcbc4Agk5zVzrUOaaXahnR1quRl6WOhdXMjVmIeRgAN6Pf8JKPTf5BaeeslZfVImk2bWprmybm76cv0g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoggvLfWzixNKbVC20LAT0Uo+eC+5C+y98Sk36Koy4o=;
 b=A7lQqsCd5QLKxZtBxZZ+vgVz/T8leRGWaQlLl3hDyDnz5nbRo0cT8rDY5hU9eZf71/CLcJnjIiG7+vF/c0rpcydsMwgcmMh4mGuzGgBa79fejO8E3mneOuYrdjNsFL7yMRxwB73VJivnEZyg1zvPCqpOY6oeUGPvtTFPmE3hfTWJW+/a7X0I45anzwtvgOmp/OYcc1IN3mRal8IrADZdMFDte89B1wv689+4yzAd0doeGOY/w8Rvn0toWo6N1IpnFF/bof0h2z0IlpPub0S/wAjsnpAnONEhqnDXmiM1xobspRSsJx8+WvBByq7pfGyJNNWUZqTX6VRMs7ZyIo7Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoggvLfWzixNKbVC20LAT0Uo+eC+5C+y98Sk36Koy4o=;
 b=JKl7IgcWxnoYmEXmSHRZeQQt8x5T6NbqbrTVnixteflwVxugcLdJuH1UsXjhpONiFVwG4zKs3b8JIjT/tjhl+e4TQpCEpDJUNYnEj7wmJR/h1FtlWMiuyuLG70OIGTH+LN5D6GmmCiFQ+NOlbXYBbiNvCME/TwqkcWzXRIJ5RRGxVgEkDibTQxt+oQb7NM+YNduyznx4yCfqPOiU08TZp80HonB3qcPKKZk1Fj6vFel1GF+JVzG6iKnUYkIKpPm5Wh8NWhIZSOSBCpFY2egXsiKwB7px3cIfB2GDi3Bk+bX/mdwGxYsLNXwltOCe0ZnhYVmqCbAKN0Pv8UoJtLbR1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PA3PR04MB11225.eurprd04.prod.outlook.com (2603:10a6:102:4b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 08:41:49 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 08:41:49 +0000
Date: Fri, 5 Dec 2025 16:40:44 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v8 12/22] wifi: nxpwifi: introduce command and event
 handling infrastructure
Message-ID: <aTKajGqAIGVQwNnw@nxpwireless-Inspiron-14-Plus-7440>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
 <20251205065545.3325032-13-jeff.chen_1@nxp.com>
 <aTKFkOPTgrbZEPRn@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTKFkOPTgrbZEPRn@pengutronix.de>
X-ClientProxiedBy: AS4P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::15) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PA3PR04MB11225:EE_
X-MS-Office365-Filtering-Correlation-Id: f86e052b-7ae9-4e41-e28c-08de33da2172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUtpSW5meUI5WEd0a2xVQlRnNmVnSmhyRlIyYzRSeGp4QXczV0l1anlkdU5E?=
 =?utf-8?B?OEFGelQzK2Z2bnhYQXl1bGlkTlJFSEZ1SXRoR2UzMUhvTlRzNUhtSEFqN1VJ?=
 =?utf-8?B?K3llOTNUem51S0g3Nk5CYXdkMGZacEljWEdKVGhpeWVLWTFpOEFVT0VUT1lI?=
 =?utf-8?B?dThZSm9lMHEyVWN3aFZQZ21yQzJIZTFaQnNMTXA3SG5heExTMDBvTmduU3hT?=
 =?utf-8?B?RFkyT0x1Uy81RndYZVVvamJId0VmVlQvRFNvd0pxZDU4VVNyU3QvZHdHNURz?=
 =?utf-8?B?cXg1WW51bFZ1NWErWitEc3gyK1lJcEhhQXkvOS9teVY5VHd5TXBVbTFmaHA0?=
 =?utf-8?B?WmE2bHpwSXRpT2RsTGErZDBQSHM1WTAydEpJL3ROTm10MFdoWnEwMWM2Q0J0?=
 =?utf-8?B?TUFBc0Z1UDRvSGVwYzYvN21UVVFycU1aRFFGODBTWEFWaXdHbjhCWHFSOWZO?=
 =?utf-8?B?cHFKQ3VKdHg2MlROb2JhVjZRSXdSVEV6cytidHllUWNpUGk5TlVWcG04MnF2?=
 =?utf-8?B?bHFDWmczMDJzU3laM2VsLzMraFNIRGhxTUZSbmNZRWFkN1dCc2xBZndKSXVp?=
 =?utf-8?B?NDlGMStKWFM4bmNBU1Y5ZTJobXJPSURSSjkzajVpcnVqYXl4K1dLQS8rZmx5?=
 =?utf-8?B?RjRxSGtTT3dqeUMwcks1UWRCakhSQzZwc0o3M3BGdzZLNEhWQ3F6TGdSYnMv?=
 =?utf-8?B?M1prbGxOU041ZFBzMVdxQWVNSHc5ZmNBQVAvSGc5cGFVbzdiaVQ5VDcxcGlu?=
 =?utf-8?B?aGU3VmtLYTg3ZzNkeEE0T1pLeHpuQkxkSURYRFpMWXhhMzBJTDhURjZESTd4?=
 =?utf-8?B?Nm51ZnFCWjQ4YlpZRGZQeEMySHRNMEcvTjN0Z1VDalFRVGoxWlNWZnJPYkYv?=
 =?utf-8?B?TzdYRG5acCt3Y2NlZGpLY0dZS3JFNDMycjc3bysyVmVuT3Jkdnk5M1FUVXpp?=
 =?utf-8?B?YktoaHN2YlJsbTkyVGxwc01INjZ3OUpQZFRVK2Uyd0FqSDZYa21GbDFDc2VG?=
 =?utf-8?B?WXNLZTR3UTJMRThxSmI4dkFWOU5kUHJhYjJ3T1FGK0IyY0NDdHZvRE44eENp?=
 =?utf-8?B?NktqUGZqU2dNdnFWN1pHMnBNUDNxUzFRR1BDSmU4UTRzY1lLVkQweVRzVDdo?=
 =?utf-8?B?Z0RYbmJWMEoxNWZ0UUJqMG14YVBraituS2E2d1V6WGU0ejhhL1lLV2FvTkJG?=
 =?utf-8?B?cTFraVFhWXN1WWZxUmZHWjZlelNscDJrTGdaSVh6WDhqbGkzWllXWHdWemZE?=
 =?utf-8?B?NTB0N25TR0E4OFdSbm8wZURhMitBV2I0NzNiNDFJR3l6RmRpYTFPUS9lZ3Bq?=
 =?utf-8?B?MEtrZU04SmZQTG0zR3dxbkd3dWdYTUlRUG1GSkZHL3NpZ25jRUd5ZDE2M09H?=
 =?utf-8?B?aDdmU2pwSlJ2aENzbDRmMHZMMkl3WXRzc090by94SjE4L0YzVjRlQzR6Lzk3?=
 =?utf-8?B?dXdYdDV6NkRIUkFwYmRGaGFYWE96ZVZZL2gzTEU4K0Y1aWxoUTl5NzVFd1VS?=
 =?utf-8?B?UUNCK1NIazJaNXJ1bUEvcTM3Q1hBRExSZXJIc0ZJOVEzQUVPWC9YbWZna3g5?=
 =?utf-8?B?bFg1MU5XN2s3U0ZCZmZlcWYwQStwYjUrWUtBcVpGcGNwNG5rM1Ntd0wxN0lV?=
 =?utf-8?B?Ni9BRnBNSUJYQVlybldxbjdlaWlCZXJLOWxYV0xXbm5YVnk4Q3FkQ0tTZkM1?=
 =?utf-8?B?ZEdWVWVKbVN5Wm0xcDkwYmpZK2pQV3d3U0haNXhqVmUra2gvbmpSd2lMZXVG?=
 =?utf-8?B?c251VFdkL3pqLy9YbDdaM20zcENuNkF3UXFwVVZSUGwxb2VsUm9PbW14am1I?=
 =?utf-8?B?YXl6b0U3NUhZZjZkK3QrcFNMZGx1Z2daRmNaSjFiQVlCN2UwMkpaaFdNZTFx?=
 =?utf-8?B?NkpLcUt0cHdXYkZ2STZQLzRjeGdxZWg2NERsZHZJSkdBY29WV0J4K3poaXFW?=
 =?utf-8?B?bmZBRFc1cnM3OUFZbFIrQVg5ZHNZaXpQWGh1dE5raThDN0RVKzFVckpNSnRS?=
 =?utf-8?B?b2w3SUVVQzFtbmNnbWtkQ0UrMnRnSGd6RWU3UXBlRXE0eVJaU1ZEYjZpUzRY?=
 =?utf-8?Q?CjS+He?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDNHMTdSU2hTdWdocUZWMkh6WjRMZlE0SmVDeitic0lwRDZKM0xXZ3l5SFBR?=
 =?utf-8?B?dWxieU9jOXlrQWlmQmNDL1oyeW9PWnBFWGpaZkd2WlZKNjRsNkpvZnFEaGVm?=
 =?utf-8?B?dkFuVXY3aHRaOGhUWU1FTlJMdEZHUCsvNmx5SU5YU2tYc1F4bVVudW1Yckk0?=
 =?utf-8?B?SnlNeCs0QkFsVVJYQmN3VXZvbE9aSEUyRWJUQXdvSk8veFRFYU9VQ29RUnU0?=
 =?utf-8?B?cFVCWmNIVzc5M3Z1Ykk3K1h5aXRnQlpYbVBhbXAzc2N6elpZT0JKczBab3hj?=
 =?utf-8?B?WU5FYyswdytXdTdQZVNJVXNEdTM2dHVqSnRrUjZRYlFINi9CbG0xZVIxbTZY?=
 =?utf-8?B?ZUMyYXpsWWpaUWxEYnR1Z0RYRks4Wi9id1hMYXM3bGtPWEQ0K01pS0Vja3V3?=
 =?utf-8?B?bG01Q3psSituRitiaXVYQnFCWDFUWFZQMk92Ui90dzkrZDc5dHNCUGpKK2xq?=
 =?utf-8?B?bCtpWW9VM2RSTUV6ZXdYcXc0a1pNUTJqUWg3OHQ5VHl1d0pPdDZFZ0V1NVRr?=
 =?utf-8?B?ZHZKcVVkb2kyN0k3MWlvSGhzTEtVdFkyK1JCLzJUY0dKOS9rcCtjQ2lWUHdL?=
 =?utf-8?B?NVczR0FYVW9kdjRsR3oyN3dmVjFHenVINEpwQk80MlprUzFFc1BpcnNrcjhG?=
 =?utf-8?B?SkVYa1JxM0p3QkM3N1JUR2tNVzFlQk1EL1dZY3YyTVgrK3kwenlkdVc3Yk45?=
 =?utf-8?B?cS9GUXIrOEwwdUxmcmdWL01NcWFqbC9WaTVOSG9KR2Z1Zm5JNURkb3cwUjkz?=
 =?utf-8?B?eUNmQnhHOEhua1FBVk8zSzVxdHM5L2JHSlBzYm4yUTQrL0VOQnJIa3UrRldm?=
 =?utf-8?B?U1E3TVlxbmxUZmZibm5DZEtPZTdBTDU5VTJ6QVFNWmVpTFZzcy9qOUE0ZVpt?=
 =?utf-8?B?Ni9tWjYwUFR5V0FrUDhsWkYzUFlVR1cvN0QvUUVPYkJNVldJWnh1dktoV0J1?=
 =?utf-8?B?Qkl0NU1NUDVoU3lZWDYraURNZ3BxRGRrUThRZkl3QlRoRHVHT25DS0VmRnYy?=
 =?utf-8?B?bHpiY2ZGNEVtNDJYZG83cWFOTjlaODVqd3JmSXFvem14VmtGMUVsdHYrcSt2?=
 =?utf-8?B?eXhOY1N6aFFvM210WGhXYlZjNjV2Ymt5M1JpQlJEck5oVDV5dWI1ekdGalZD?=
 =?utf-8?B?OFFWODVVM0JsUWw1d0I5SU93SXpHcXprdVowV0hkNUlwVXlQdU1WNHgwUUc5?=
 =?utf-8?B?bGlRQWU5M2ZNekdDQjlvMHM5NjNxU29GQ3lwbkdiMzlJeGp4c0hZM2lTN2ZD?=
 =?utf-8?B?YmtnUi9DbWhUaEVmbnVUb2R6b1BvT09JNHdyUE5ZbW5HZThDUmtMSWwzZHFo?=
 =?utf-8?B?ZXE3emFiK1AvMGVTUDB1RURaSWhlRjJqK3QvVUVjVlUrMHF1Vmh2dTBBZGs0?=
 =?utf-8?B?WDRlZDkvVmlnNFVBZHRJbVVFbHhvU1RDVXh0ZHFxdnJyVEFONUFnS3dVVmZk?=
 =?utf-8?B?WGxkb2NlNkVDSWpIdytQNDNGQjBpR3lIdk5kM3pIK280YkFhMklEaGV1dHJ0?=
 =?utf-8?B?aC8vV0xCT1ZoUllmeVVUc0U2SlRpUUhIRG94c0M3WWNySTM2a3lCVGczMS94?=
 =?utf-8?B?RVdDd2JjTFlyc3R0cCt3MGJwTyt1ZHp4bEFnQWMwWFVEN0ZlK0hOSXNOK0hk?=
 =?utf-8?B?ekZBd2lnRWZLLzBnZURhcVpxVHdtcjZwbHoxdVExQUxjS2ZhUGtjaTdBM2tE?=
 =?utf-8?B?djNSNW5ISE40eVhKZ21DT0NrUWJJNXhhMm10emtEWm5BRzVJU1laVE9CN3Ev?=
 =?utf-8?B?U2tVNjZTTVZScndvWmRKcUxLUU4yYnFidnNFM2ZlOVFwSkVtN1RQNkttam1H?=
 =?utf-8?B?MDVhczZFYU9pck14OFR1bVVjTXl0YUFNVlU2aWhkM0QxQlJDUndQcWtySTIr?=
 =?utf-8?B?cUlIVG9VbVVTNFY5TXpvZ3I1SUl3MjY4elJEVjV0cDlOVlZ3UkoxM2RTYlp4?=
 =?utf-8?B?SnFuQ2oxVFNCN1BuUzRjTUwxejgvUWpEaGh2cGprMENTWFJNdVI4MjFJdmx2?=
 =?utf-8?B?eFFPTXhYakFpOEQ2aGZYWnM5cW1oNmdLWDQxU3g2c3IyU1FhQ0xST2dWM3lT?=
 =?utf-8?B?bWtHUDVIaDlmZFBUcThDcldVZVlxMGJ1bjUwazhLdnNvRjNhdHJzUjZXY3pz?=
 =?utf-8?Q?TtMYjrtq05VsmKcfK5UyXG3AX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86e052b-7ae9-4e41-e28c-08de33da2172
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:41:49.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQV0IAABzvtrBT84Pw8jpaOP8vg2ZwA63mYwqtvAaasUtZHeMxOQ2sdDPtwuSu5DcKioA0afFlIF/avPo+73SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11225

On Fri, Dec 05, 2025 at 08:11:12 AM +0100, Sascha Hauer wrote:
> Hi Jeff,
> 
> On Fri, Dec 05, 2025 at 02:55:35PM +0800, Jeff Chen wrote:
> > +
> > +	/* Check init command response */
> > +	if (adapter->hw_status == NXPWIFI_HW_STATUS_INITIALIZING) {
> > +		if (ret) {
> > +			nxpwifi_dbg(adapter, ERROR,
> > +				    "%s: cmd %#x failed during\t"
> > +				    "initialization\n", __func__, cmdresp_no);
> > +			nxpwifi_init_fw_complete(adapter);
> > +			return ret;
> > +		} else if (adapter->last_init_cmd == cmdresp_no) {
> > +			adapter->hw_status = NXPWIFI_HW_STATUS_INIT_DONE;
> > +		}
> > +	}
> 
> As said before, please drop this asynchronous initialization stuff.
> 
> A patch doing this for the mxiwiex driver is here:
> 
> https://lore.kernel.org/all/20241202-mwifiex-cleanup-1-v3-12-317a6ce0dd5b@pengutronix.de/
> 
> It will apply nearly as-is to the nxpwifi driver and it's much easier to
> do this before it hits mainline.
> 
> Sascha

Hi Sascha,
Thanks for the feedback and the reference patch. I’ll review it and try to apply these
changes in the next revision.

