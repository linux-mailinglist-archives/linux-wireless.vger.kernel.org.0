Return-Path: <linux-wireless+bounces-27921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C322BCA0CD
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3AA13561E1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443C2F6198;
	Thu,  9 Oct 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NPbQ0DQw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A725A2A5;
	Thu,  9 Oct 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025747; cv=fail; b=c7dtIe0uDzCbkeg2Y8D3k6ZBoxy0bwkD0YURrM5t47vXp0PHr8DEk7BnIElorHN8nRRpPSxq8VHNScQ6gT5+NLwqfXaiN5d5Nd+YIXPPVV15S4niY89iaVuFOkkNJS0mE4jzeFeTUA0pqB8ZF+y6zfi/o79+brGLIkj6hlCqVbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025747; c=relaxed/simple;
	bh=g0/bVs4v68PfRuTiiWdEDcwh32Mw/tdwZhDI3v76rck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JfcRrCDKbFwX2yWiLRCSUHr4I4+PRAB8LefMFb80BaDnuU1hxgT7PvzAeKeQDaw3mHLorakjFHKyjq8kn7HIbcQqlybpyo+8bz+NYch9Y1cBHYJH1s26ZigVN+6Jb/oIqcv0aMy5A5UFeM7I9cngVc4Ri8nrMLUwtdn6lYXFew4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NPbQ0DQw; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEOBK9DESEEk9zMQ4d13ZBtyrguRWV1oTRKjS4lsM6fDzo3ekyxjARuIKpLTGQ0OigXhylxzb/OF6k5UUIEYgkVbSK7hinhGDjlCQSwOzjlJTr+vebpwrG7sK1TLlvvXoNFeBVxPh4wVn6zfxxxPFUEpSqQFZ/TGFyAnmIR1OuDYXLIDqSrdvvQc5Gr5CHEU8SvHp7l6e1VRTBkseFW4lmxTWa4abyMnvS24DimNEyK+c7UpUQc1UYC0sVbr2r3Sje2xme8o0JQy6sTsQy+rkV2edmrtp8tUDsgKxDUqWVZCVl9zzOmNBG2rSL06HRk1wqwxYJcJwc0z0tO17Q7Xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REx7NVwO+Udkdj21oBHnJbwutbTQdZkhOmbOWB7kneE=;
 b=Q12786njlrknlVJeNmW6CZJz89qRoYFLqReLvFrN+9+P4OX2s39zWr+gCSH8OeHsWG2EVMCXUPzThz1FNxKaV0j2rC1l58CTgP3O0XrCRscQD9B2w0iZD+RBDfw+OHcAxDo+YQ/W8BatALyNHHjp2lqc+7BT1v8M7T92pBXqQ/+vb+Xn1e036FN7Dp3Mc4WFvxpDX7qpA5wxZK9gckQaQKjXqvAFjsFaFPDLDKxGDsgUIHBqnv4SYQktqVXGnvHyUIWKjUP4RNNiskSVxsHlqcBCDcT/n0kjcgyVBREVcZF47bnzlXCibpLQaeD6P5arZDeezO4PxS7JzUPSbN2GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REx7NVwO+Udkdj21oBHnJbwutbTQdZkhOmbOWB7kneE=;
 b=NPbQ0DQwIv486tHUQARSQxSd7FlWc1+dN9KndGK0CPr/SRPdevvmcPuL66aa0DimWnM57GHR2Rt98HX5vdsOgc7JvZAccrgVulvgbi1oCCp3pqS6XHsnmZEhOS73zK++xNMkOwrM9yGuYEbCnGqoAVqkMz14hTCPPgyDfeIKr4IE27QKpwW3F6zZCMcIkJ6Wx6HNZILYwIwYUHrPT9oC9Mw0Peqw0G/yu4y3vqqw48nN7IHFvtzb6wwYse2QL7vYlmv00kJwfR5d7E5pCi1i6bTD1XjkdMs/HeUXi07n6C0e41vwRQEdgzHbLKzlkpDnqArfscdg7o0DRE+Y4pm7Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by GV1PR04MB10893.eurprd04.prod.outlook.com (2603:10a6:150:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 16:02:20 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 16:02:20 +0000
Date: Fri, 10 Oct 2025 00:01:51 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de, brian.hsu@nxp.com
Subject: Re: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <aOfcb3bwacg8RidH@nxpwireless-Inspiron-14-Plus-7440>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
 <164050d7-e0db-4a67-bf47-6d88e80d78ab@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <164050d7-e0db-4a67-bf47-6d88e80d78ab@collabora.com>
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|GV1PR04MB10893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcf0f06-cd1c-4a36-804a-08de074d3a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THR2Qm1IS1RDV01VWmFpR1o4Q1Jaa2pIZzBvYWxxVmtVVHBIc1JXNzRseWla?=
 =?utf-8?B?UVRCSFZKQWxpWUM5RElvbVhWR1EzZTVLNGpnOGNjUnk5NWMrNHJ2V01uZ2tt?=
 =?utf-8?B?U2R2c0MvMlp5aTZWVHdLZU1OdnpKZmtWeVkwZ290L0F1YmlCYk5kK2RGSS96?=
 =?utf-8?B?TmN3NHpPMDU5VlppRjNDTkJPNENmNk0xOGVkV1RWRmZ1alNXN3AweW5hU2V1?=
 =?utf-8?B?OTlCWmZEM0VGczRYbjRia3U3dm5ON2tMa2xwYWtrNnhHTDV5bnNoTEtiTGtt?=
 =?utf-8?B?UFBJa2Y1eVZsWXVESWZEcjNIZmpiVFRpdFRSdFhvNytRcE5GSnNNTCtiRmp0?=
 =?utf-8?B?TFhCTGU5OXNGK2xDd3EvajdudWs3R2R4clFWYW9tUmI0VjFzaWN5aDRxN0Zr?=
 =?utf-8?B?UU04Mlc1cVZxc2FIcjFkVWVjdWJ6UHhFNCtXMWg1Y1NoL21BbmZEa0ZKeHQ3?=
 =?utf-8?B?T0tUeFpqTUNDQ1FMSUJvRTIzOTIvVVdCMnNCZi9hRzZyeUVlVHhOL3cvQ1pF?=
 =?utf-8?B?c0R3ODg4K1RNWjZwUnhWeHJyT3gzQWVRSTRocjl4ZktoWWhMUFNaaUtRWHg3?=
 =?utf-8?B?U2NUZS8zZW40akhCUGJJV2ZRR3IxazRONVBTcUdYRnp4VEh5cUFGY2lwM0li?=
 =?utf-8?B?UWtDTWdIK0hVMFJjalZlWURia21ZL2JEZlZFN21FKzBhdmkzVXF3WjllVUpH?=
 =?utf-8?B?QWZDZ3dsem1adFkweWYrT1hwNVJiMEdGMXN2MVRleHQ4cXlZdTUrSjhOZmNG?=
 =?utf-8?B?bUpLai9rR2lNbmgwNDF0SWhQb0ZwNG1vMVRvZXR1VVd3MlM1VzRYRnF5UmtM?=
 =?utf-8?B?NjFMcUl6Z2VDUEdteEd0NHFWRDdyYjZVKzk5aDR4b1p6bVJ5OUpXU1pqanp1?=
 =?utf-8?B?NFNtWjBNbTIycnU2ZUdPYVViM0wyMDFpMjRsNkFRNkpKVmxBRVFZQk8yNldi?=
 =?utf-8?B?ZHRFSmhwV0ZPN1Y2NTBLNWVpSUloWm9RaGQ3bFlQQlFFNWVxOHBBc1drMEx6?=
 =?utf-8?B?dDRMRDNoSDJRTkpEUGFteDVmZUtac245bk03djZBRnowTjY4NXZUYUtVbjJo?=
 =?utf-8?B?ZjROSVVBYjFtYmVXOS8vNU1DSkl0MTQ0NmIzbnV0ZmNUZ2EzcTRqT1ViazhF?=
 =?utf-8?B?Y21JNkR5dlFycHFjaXFON28renVlNzhVaERpSWorOWVzVEUwQWxobm9ZUmx4?=
 =?utf-8?B?amo3SnJiQUJ2N0VJNkhQK09GT1poY29hS2ZaTzRBall4Q1RxUUl3STRqSHV4?=
 =?utf-8?B?cnFjMFhMeVZXZnBkTHZnd0cvUWtiZHM3TTcyMTRqWXhzNGxLYTBSY3ZyWXVY?=
 =?utf-8?B?MDFqdTREd2FyaDRYZHAwemVxZ1JIdGgrL0dFclVZcmRPcC9UTGVVOVlzd3lo?=
 =?utf-8?B?ZGh2amtmUmtGblRENmVuQzBQMFRvL0o3Wmd5N2FWQnliQlZ1eVA4SHRYNGth?=
 =?utf-8?B?UXVTUVJReFpqR1cxMXkwS0YyM0h0RlllRVdnQkZtcU5VZW93OGhWWWhNQmto?=
 =?utf-8?B?NnNqUEN6bTRjaC9ibjhkMVR6OWlGZ3VvL0JoajVFd1JiZTJQRDU2MVVEdHRF?=
 =?utf-8?B?dUppT1Z6cUhKYTQxSmg5YjJWdWMzV2ZHQjFWK3dQNnZQbG5PaWdNL2MxVTBy?=
 =?utf-8?B?VGVTQWN3eVRlSW5hN1ZHSXRNNU1EWngvNHZpVGlxNE9LOFd3K1lKU3RwOVNk?=
 =?utf-8?B?YnBqYXY5V2JuTmFPbGFTWkxkRFJHaFBsK3k5NFpmOFQ0NnFWckkyWHIzaWNM?=
 =?utf-8?B?cXY2alM1TUt6c2F0MWRjWWlCRTJuMGF6QUtSdDVmSjExbU9oMXJqOVd3RFA2?=
 =?utf-8?B?R0ZBOVB0TXVHRXV4MEJ0OEtXWTFRSHhmN0ZDRE9VYjE2K1l1eGNCaXV0R09u?=
 =?utf-8?B?dFo4NEo4ZUQvVGlFMFZDRU1WMVNkbDF3Z01BT0cxRndabmFMN1lBNm1wcDhs?=
 =?utf-8?B?bWtqUzcvNnFvTHRicWFIdFErZll0djJuVTJYK3FVNTNuM0NWV0JaUXh0blkr?=
 =?utf-8?B?Sm9KcnNzVW1aRkM3bm5tdXFGRkNQZE9iWUQ4d2FvZFA4OWxFS2xxbUh2SklU?=
 =?utf-8?Q?VJagDk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWx4ZGJqNXVkRG5DRWdsTjl0aUpmeGJwQmZTOUZIRktXTnpaUXIyNndPbnJG?=
 =?utf-8?B?eE8zcHJMNGVUcTFneHVORVNndzdya2pjeTYvR0ZkQlB5d3FWWldlYi94Zi9t?=
 =?utf-8?B?anN4ZmFVbmVLR0hBVS9YVVZZRUNEc2Z1elJFNFVCaysvdTRSSXBwbmhoTTUw?=
 =?utf-8?B?QkMzcVg4UVJBL3dTOUh6blpYckI2VFlEOU5IUDdmcVlSWXpwcXRaZTNHVm9J?=
 =?utf-8?B?K3BNR3BsZjhzNVVvR2krQTEreUVmalY2aWVFWUhEZmpPSXpzYVhRcHB1Umox?=
 =?utf-8?B?MzZ2bDJDSUdzb3VzeFlhbHJXa1dtVFpxVWdjYk9ac2VBbVpnUXh1b1g1UkRV?=
 =?utf-8?B?Z1h1dEdtN0xMVk15SkxXRTNrQUs1OER6bkVHNXhCTElKZjFZN3Zxd1hqL2c4?=
 =?utf-8?B?OXNTRnQyRDJoZEZzckZoVHRQc1hyWXh1Wm5QNnlVcFIwd1pLZVhkdmh5Znk5?=
 =?utf-8?B?MUNOZEhicWlqT3Mwa0NGVWJKRHpvMmxrVzdmUGRCQ0pBb0FsbTJsSVBPOFhS?=
 =?utf-8?B?ODIxLzhZVzVKRTRGV2NXRmZxeEdTZWd5cDVsYmg0WXBaNTJuQTVleTQvYmVE?=
 =?utf-8?B?VGsrUVlvMkxNZDQ0VElING9RVHZtQUlDcHZTeTdsbXVnTCtJekhHeVllbDhm?=
 =?utf-8?B?ZTExMkpsR3QzUDg3ZWJESEtxSmtwbkI2UElWdHRjdnBYYjBocEhnMXptYjVI?=
 =?utf-8?B?MHVLdFdBSWVXaG9iRmo5RzU1bVVtajdYaHc3b3o1SU9CaXhpN2tDd1dKRzdW?=
 =?utf-8?B?UEwrd0xzUkhQdHAyd0R2WWlOTUhxMUhOTGtDWGNac3ZyRkxHU2JYT05OZ3Zv?=
 =?utf-8?B?cG1nQ0Z1Q01jODg3NnVlVEpBRWZzYmgwWDBQNHp1U2VSNDBrVWFEMS81d1Fs?=
 =?utf-8?B?YVB4aEhKcWk3NVpUT3lON0xvamZYMmJjUjQxaysyaWNBaHhIS1BNVmNVN0lt?=
 =?utf-8?B?TGhOYVlTbi93UytkNWpCT2ZTOVNlU21Eb2F6UlRabHBVaFQ3d0RlN0lRcGVD?=
 =?utf-8?B?UGEvNTQybmtpSXBLd3RtQXdUeTBnM0VPdE93RGY2RkppM0x6NE0yb1V5a0tq?=
 =?utf-8?B?akd2MERxamFIckxtU1JHMzRRcGR3dU9CN3FHR01wNXFuYXZFbmpSQjI2WDNM?=
 =?utf-8?B?cXJKaitWWkYyQ1lvOFFqYm9XUkJkd3M0NWZydHpWMkFmY3pjME43MjBtcXk1?=
 =?utf-8?B?VmJsTlpYSkI3SXAyYUNHcm5TYmxRcTFHR3hYR09HN1BWaE45QitiNUFDcG4v?=
 =?utf-8?B?bkRodGNZWXEvekhnSVU3NXhiUVdCdVBHTzl6SkxLZU12cUp3clZDWjAvWC9F?=
 =?utf-8?B?S2RyUGJDOTRNekExSFRCY0NBbngwWGNQaXk1OGMwV0ZVR0xmNEEwT2dVT2pu?=
 =?utf-8?B?OTNla09jR1ZYenZlcEE0K1I5WVZpbWVrekYwWHJBL2llWWVOekhDajdOeDdB?=
 =?utf-8?B?bUVvTUs5My9GcUtiTGtHdXB2U3UyVHpoRFFpd1hlTVcza1dOMmFkZzlHWjBK?=
 =?utf-8?B?K3Y0Q3hlWTlSaHhaK3RWZFIveDhlUWc2R3NDTTdYT0puejRudDdKZ3h2NmJG?=
 =?utf-8?B?OEpjNjZMQXo1RENJSkZJY2hTNTFXWEpoZllmbENmWGZndFdCa0FpOWFZMEdw?=
 =?utf-8?B?Y2JWQnBuNUtBOGJHc2lqWlNKaldIRVF2eFNLd3Y0MFNvRUhjOWRYL2Q1c3RD?=
 =?utf-8?B?azhMdnJCMjgwOXpRTTk3VWlZWVAwOGZSQlg5UER1OU1vcDNEdTUvYW4yQlJK?=
 =?utf-8?B?Vnpjc1JqZVhJQ29QUWVsaEhuQnZMZVNoVTdVN205V2lIM3ZGdDNVNkZPanpw?=
 =?utf-8?B?Y0tPLzRTT3UyMVpxSDNtbU8xamNxM210bFRINGkzQTlKWlJUSEkzcFVTd1p2?=
 =?utf-8?B?ZmM0bWNtNDJzaFJpRVFreTIxUUc0SHZBNkxEbWx5RVAyTXgzSHVrNFdRdkdX?=
 =?utf-8?B?VG1mc0FuTzF5aytFalpzSU4rYm1zUW1OY3oyY0owVXI1dFNpTmNTMk9QL3pF?=
 =?utf-8?B?RVNCWm1NLy91Mk1jNFJ1UytyT3dYUmF4bWlDS28vSHFiTHpTOUpQc2ZpNXFz?=
 =?utf-8?B?a2FRK3ZueS9qajdjaWdNcHYwN3dIVnc5V2E0UHloRjQ1M2hIc05RUjlQY09P?=
 =?utf-8?Q?h3yxx69LqurFqfQ+spEuyfABO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf0f06-cd1c-4a36-804a-08de074d3a00
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:02:20.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga41VO7Mum1HjiS3aMKRTKwHeF5e8zSFI/T3hXS8SkSkig0EkyRuFUH7Vi9V9wAsV0Qnra13u1LwfwFRYlPa/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10893

On Tue, Oct 07, 2025 at 05:49:59 PM +0100, Martyn Welch wrote:
> This seems to be working well for me, at least for Wifi. I'd like to get
> Bluetooth up as well. The bluetooth driver (btnxpuart) doesn't seem happy
> loading the bluetooh firmware:
> 
> [   35.930755] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
> [   37.953107] Bluetooth: hci0: FW Download Complete: 396444 bytes
> [   37.953167] Bluetooth: hci0: Frame reassembly failed (-84)
> [   39.277635] Bluetooth: hci0: Frame reassembly failed (-84)
> [   39.292011] Bluetooth: hci0: Frame reassembly failed (-84)
> [   39.310094] Bluetooth: hci0: Frame reassembly failed (-84)
> [   39.330273] Bluetooth: hci0: Frame reassembly failed (-84)
> [   39.351381] Bluetooth: hci0: Frame reassembly failed (-84)
> [   39.373112] Bluetooth: hci0: Frame reassembly failed (-84)
> [   41.353087] Bluetooth: hci0: Opcode 0x1002 failed: -110
> [   41.358411] Bluetooth: hci0: command 0x1002 tx timeout
> 
> I think the "combo" firmware needs to be loaded by the WiFi driver right? I
> assume this isn't supported yet?
> 
> Martyn
> 
Hi Martyn,

Thanks for testing the nxpwifi driver. On our side, we haven’t seen issues
with Bluetooth on the NXP i.MX93 EVK platform, regardless of whether the nxpwifi
driver loads the Wi-Fi-only firmware or the combo firmware.

From your logs, it looks like you're loading the Wi-Fi-only firmware
(nxp/uartspi_n61x_v1.bin.se). If it were the combo firmware, the btnxpuart
driver would skip loading the BT firmware entirely, since it would already
be downloaded by the Wi-Fi driver.

To help us reproduce and investigate further, could you please share:
- Your test platform (SoC, board, etc.)
- Your test steps
- The exact firmware version you're using
Also, have you tried running Bluetooth in a BT-only scenario (without loading
the Wi-Fi driver)? Does that work correctly?

Thanks,  
Jeff

