Return-Path: <linux-wireless+bounces-30692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D8D110D2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 09:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F335301D6A6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158963451D5;
	Mon, 12 Jan 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P8oaDWtH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67234402D;
	Mon, 12 Jan 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204999; cv=fail; b=VmbUVFWDeR0756A57aQFcUiD7NL22e1EdPa5uFxlCszv8igBi34PUIx0bau2BpiXuyliLgIsY8+b6fLC7zny9ROPxcy4+iw64C4kWKRbZE2/WxVHoDZ1ezGZ0GqWnWr8/54Srg7JxZUVXUkdLZcmBD2aWzy448i0wMWfJWAeCXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204999; c=relaxed/simple;
	bh=J3R0JnGnE2NUWirLE1eBfdJfsnh77Z/QZPx91luh54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MesdjTLV9VZsVEPz1w4KX3rZ1qJgRvbfHzjp5NFMyFuiJ3eIKxRrxq944KQcPzDMf/aEycTNrJGhkMc69UZpFNxI4N9FCOfFgphUkV28OddXfosgNQ3By1ZA301JfyqhQcxzRuWeuwZf+BHd21dakBijKDqSEVLNA6Idq5fZiEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P8oaDWtH; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9Iq6Uw2/os2mlOrAOmpR5f1JB4JWTHz2Qq7dszdNC4AKOx5SZBC+GdigWDiQimFVry426Xxf4ffdkpLPvWqzogbvZxxVv013xJiITBoJmgV+ZF+vmWdj8J3+pb4BVDyFFM6xYFlfUpPYaWiioOT8alJFF6ms9e71KV9fVUiDgShp1M6brLzBkK8f240VHOk81uWK4OzzgRezqwfYK4+2WilvfoW33ZZvBrxs0mjrpWRKRgwLIbtZDo8TbwjK4D1Xg3HT5m8e0rINkzVlWtRzPSEYlz0kBnj5sStNvuIew1vZzvecq8c9w5qb3h8rL+VO77GwCswbwWO6p8xzVtFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIqc4ppIqNflOc9XzDaiILcgbroLTH4hVHvaAAQ3pAw=;
 b=bwAQbalWfowzBcB17vjjJ973S5eBzQNJ/rEMhEjaElcKjpAKVpkawHsIR/m1GOerAG1874oxf0U7l5mzHXFB8MZkrwl9c9MSHvC5MP8cj8e+WFoUPK0+nN+uu/u5t4DemzzqGdkaizHNM4bN8g/HnonVm16PILBLbXeiT4+KwcJXUVAVKlbE/NZ9JCbGvbAuYj0Gpg8xs+NQ21ZDiPcnA/ZN0j86bX4SqFtBCClkxRKRqySbVyteJO0g9KE7CY3JHWaz0I9XXgjImgznY7D3aQEobznvblreqjuLTOTJI7E61KPEb42zXfq/ERvvEnKNdSaR+JRHJQD/YcaGQtRLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIqc4ppIqNflOc9XzDaiILcgbroLTH4hVHvaAAQ3pAw=;
 b=P8oaDWtHFLaBrzssLBoaCc6TGqxC9SuzcRFId2NqRs0VI1y8NXOM1yjLas0nnZ03K4H+ja74IJWMaAmIPA1CgLMp91WehoyKbk3fGBLJy5z6JNNRCZgMwXoOSEWHq5E01JuMnq/uxHBsLbDW1UFXjiTrWWvi+lRPD5eleMJTZfYvXYYof+3yEWEHmHllqfvuckz/E7P7XJxT6H8wbr80rIuyBXgxhg3YyxqKEUtDEeNUK46DbCVXA4R1uvLvzFwS1wLrFFhgfrchVTDR8v7FfeBfEQHBnrBC8cQanCifmNionkQ4ODG2xhj49sNJZ91yMzzcGF7VowEvyAlRx7ocVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Mon, 12 Jan
 2026 08:03:12 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 08:03:12 +0000
Date: Mon, 12 Jan 2026 16:02:45 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Chunfan Chen <jeffc@marvell.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Cathy Luo <cluo@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Fix a loop in
 mwifiex_update_ampdu_rxwinsize()
Message-ID: <aWSqpRZmBUmfZMIZ@nxpwireless-Inspiron-14-Plus-7440>
References: <aWAM2MGUWRP0zWUd@stanley.mountain>
 <9085a572f5fee0a14059c023c3240aa4d96afc08.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9085a572f5fee0a14059c023c3240aa4d96afc08.camel@sipsolutions.net>
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 1102ec05-6695-421e-c96e-08de51b10803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmpxSjdsak9ZbE5QenhmeGs2c1c4YnYrL2hjYlpJZXNJdkdZZFF5Rlp1NWNN?=
 =?utf-8?B?bjFFa09tdjF1dS9NYlYwUjRnYkpoeHhUaTZ5NldBaThZem5yejFvUXVBd09z?=
 =?utf-8?B?RDNLMGJUcFpCNFV3OVpLU3AwWFQyWEU0VGt5SnpoZ1FYaGpDcUVFYjhCRjVH?=
 =?utf-8?B?MkRJeWpoejB6WmtRRDBxZ3lJaG9LSFN1SWFpU3hHeERsOW9PdWhPc3JaQzg4?=
 =?utf-8?B?dGgzMjlqOVhmT1RBWTMwZ0xOd1N3VHZ0RWNnMyswajY5QTZyNGc2OEtpMHM4?=
 =?utf-8?B?NWNqSFBSTE90RmtRaUhKZlFOUnorM0VPN0hLVDN3VzQxZWluSUcvdVNzUUpq?=
 =?utf-8?B?cm9VMVFGZUZFd2paTzhtU0Ntamd4YjJXZndkMWJrMGRxOVVaRlNiazNQaEpw?=
 =?utf-8?B?dmI1dWtLUTRmS0d4RnJFSno3VEZ2UEgyRlFmUVlkaWVmSkgwcFh4Q01GVXhu?=
 =?utf-8?B?K2NaR1Y4aDRhT29NMHFSTkMwSEM2OE1tLzlTYXhyQlA4NC9uTHkrMUNJOG0w?=
 =?utf-8?B?K2JFeEx3KzdoVmlpYTFtUWl4V0JkaHVVR25GVEdna05XdVYwME8ySG1YaEJI?=
 =?utf-8?B?MkFLSk0vZkxFV1VGc0NwSWZvYWVVTFFOWEN0TW1NWlVSQk13c1lEUjluNCtO?=
 =?utf-8?B?eFRVbzRzWm4yVzIwWjVmWlpBMGNNRFhBZlpDTFYyUXNRT3M4VnhMckxJTVdp?=
 =?utf-8?B?YjZqT3pKNXVpd2dFWW1iRXVhdFIzMjd1THRabGVJRVhOdWhZNUZxNi9NUXpD?=
 =?utf-8?B?bzZIVW1RbG1YMVAzSGEvRUJ6amJIQzJlVDQxSmtPVTZCTTMxeFBxOFhPejdq?=
 =?utf-8?B?a2I2QXduYW1SMlVmR2ZiRmsvamhGTDlxRGd1WWxjeElSSytuK2loYkR0VkFy?=
 =?utf-8?B?ZGF6UU1tQkpTVFl3VDBNTFYrbHNJMnVYcHJWaldWa1hocEZuWHdFcEJyMmla?=
 =?utf-8?B?RVJvYTc5eStIa0pJU1ZKVmYrbWZxVXJyQmFteXhybkI5OWh3U0tzYWdOMEZG?=
 =?utf-8?B?NWxWSDF3UWJOM0xabjVWcElyY2h5L1dqb2pzMXNYS25HZUN2OXJMUFZyWGZH?=
 =?utf-8?B?ZFU2VStXMS9janBMeHJibzBsdWlCcGhQU25QVy94eUtCbmN0MkdzdzJuU1Mx?=
 =?utf-8?B?RkpuejVKc0FwVXlkYit3UlFURW13QnJOazI2VmowRWZUSGxYQUtjdWFMQWtv?=
 =?utf-8?B?US9JM245R1RmWmhhVytIODcrRHNNUXhlcm5ITWJINlB6dUlqb1RhOEx0VS9I?=
 =?utf-8?B?N0QzZG84ckFJdzQxMk5wL2lYbnNkbjc2K1Z5aUFDQVREMi82cUNJVVZ2MGRH?=
 =?utf-8?B?cDNodC95b2pYOEJId1lBSUVsUjBIR3IzL2dQSFlaRDBkS1hLTXkvODNPS1pX?=
 =?utf-8?B?UmFzWnBIK1hDdlZ1MU5DekZyM24vMWpSUUN0Q3JrdUpVZkROT0x3Z3hHU1Fp?=
 =?utf-8?B?MEZ0UzF3SEU0U3RrdjNPdXBEN3Q3NzEzYTA4ckhJbTk5YkowNGE5ZExqYUEv?=
 =?utf-8?B?ZjBsbnYxZ3BTUyttZE93dWg2M2Vub1FqckRkVzFqYnN4aHMyVkw5TXhSM1JU?=
 =?utf-8?B?dVgxSnhaM3lEY3dVYWlJNXczMWdLV2ptNE13WHk4anB0bVQ4OGxoUWpQNUpr?=
 =?utf-8?B?UWlZelVtWStvNmJ2WmJSMDVkUUR3NzdYZWliVlExOUtQeWQvSnkrQ0o3RlJ0?=
 =?utf-8?B?T1FyT2hGd2Vob2dKV3dVeWhXM2pPb21iSFhPWi9GNHAzL2VrRk1HRzZzaVAv?=
 =?utf-8?B?SnJkTnNmZnJoQ3BhMHFoY2djUU9SNVgyVlNwNmxYdlJ4OGpnQk5wM1hqL3hY?=
 =?utf-8?B?TW5JYWo4QnJJeFpHZzFDTUZZYXFDTGlZV1V3ZGk5TXRKWmpNTUpteURwbzhC?=
 =?utf-8?B?Si84QXpwYkJWdW0zSDd1U0RYcDlqUXd4eXF6VkUzYWRCelBEM2d3OVBmeFVp?=
 =?utf-8?B?RCtVUGhPdlVqQStTeXZ3K0N3WXREYjNTdjhOVmVRdlZiaW5hNS94dExnUzUw?=
 =?utf-8?B?QjZOREgwWDhuVms3Uk9wQktUdlcrOWJJcDlJUCtzenhvMVZISWJ1aGtyUXlp?=
 =?utf-8?Q?UECj+q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG5OZmJiTnFrWHZGUDV1V3dJWnpEd0k2ZlRnOGJiMXN6TGR3cDAwdmFjb09U?=
 =?utf-8?B?TFExSC9zbjdHN1BlV3pyMGw5WlgrU0NpTzBydmx4cU5zb0V5QXZDTjhkK0NP?=
 =?utf-8?B?VFJEQmRNVEV0d2hndXhkR29DWno4cE1DZ3UvV2ZiQWoxWWozU25hRlBGYlM3?=
 =?utf-8?B?alhicnZGTGRqZjNQbUVyUEp4S3VHcmtvdk5QT2JGRC92SEJqQktDeUs1Z0I3?=
 =?utf-8?B?T08wWjlQb2JLZ0l1YTFlaEZhSE11M20rVTZ6T2tQekxVY2N6MXU1VVl5bDFM?=
 =?utf-8?B?Ny9rZy95MFlCTjJOdG16bWREV3prNDFkYW1jZERrMjg0V0x4SUtZdFQ2NGE1?=
 =?utf-8?B?aVJaQ0tKWHNJWXFQUVM5dHNJR1hTOHluQVpDdDczUFRMU0xyTmd2emhEclFU?=
 =?utf-8?B?Sjdzb3VWTzkwb0V4RnQrS3hrbXlabjFhREVPcWI3dnh0My9nUmxzUDBOQjBr?=
 =?utf-8?B?L205WS9nU0d3Vzg5Und5QnR1NEY2MWJ5NlBXSW1LblNML1I4Q3ZLRWhHZjNs?=
 =?utf-8?B?aVQzLzJ0YzZWenBUai9wUnlObEFPR2tBNjY5dU5TZXBFeE15SHZ5amd3QW5H?=
 =?utf-8?B?aksxNldtODByWGt2YktVdUVuNW1hYlR3MHlaMHlGZk9OWTF4aXFaWEtFZEJ5?=
 =?utf-8?B?MnRyNHdOV3ptcTBKM282OFk1cVd3QjBLNmwwV2pqbmE5K2syYm5xdWYrcDA1?=
 =?utf-8?B?cCtHbFFRUkJyT3k2bnNhaGRMQTFQKzlKTFZuSXZZQWVqSWxGbjNVcXNhL3Rt?=
 =?utf-8?B?VG96MVR4OUVHVk91STQwVUVZeXFLMHUzdG16N0ZXTmJaTHk4VEdYeWMzK1ht?=
 =?utf-8?B?Wm9qVXM4NGMzL28vRFZMb3kvMEhqcGZnZWFVdEpJMGVrZkVkUDNXRWpkbC9B?=
 =?utf-8?B?Q0hVUWE2RWl6M2g4T3NVQkNhK0xmZi81ZVZYT1YweDU5eHVnRVNyNmtlVHJt?=
 =?utf-8?B?S2dOWlByeUZvZlJtSGc3ZmNCU0c3b2FETXd2aWVLc1pzejk2c3M4Y2luNXZz?=
 =?utf-8?B?cjdKT3U4dWRpc210VTY1RDRoQUdXRGFabGEwbUJRZEQ2QzFhbkpyWlI3VTdr?=
 =?utf-8?B?Y2JLVE9WcFlFUGFlb3oyeXZaclo2dFFxbVBiSnU4RjdOZ2QzN2pMNHV6dDRD?=
 =?utf-8?B?WmdCSVpmejJzcDl1MUxrbHZKRGFBRFBNc21UZ0RMMkdKd1hJYnZiSTMwRzJ1?=
 =?utf-8?B?YnNRRjhsV0hRL3N4dXowZUpzaFZaa1lqMkdadnFEdEI5T3A2M25Tdk9GNVVM?=
 =?utf-8?B?MVV0L0pwVUlLMGU5alFKL0pIT1grbE9JRzVoRUZmcVBDaDhHbXFRSWxZSU5O?=
 =?utf-8?B?cENXdkhHT1BNTnRJcWNKZGZjd3hQbXdBU053eWYrbUxLbiswd0YrazE5VkpW?=
 =?utf-8?B?c0J2MjNldEVZenVuMGhhZ21SNEU3Z1RsdWVQclBlSU4wVFdtU2tBcGJNSlV4?=
 =?utf-8?B?dDRTZXBxNTFOK3ZveDg4b2wydG5qUlIvMWhyL29kdGZTcmtXS2FHV01ZTms1?=
 =?utf-8?B?M3ZsbXpadVpOV2NKSnFnKzV0UVh5RHlyK25Dbnd1TUc4c3J6WWljME1CWWxF?=
 =?utf-8?B?N0hUUFNLYzVHTHRhZDVoQ3JxZFVKczlRZnhQVW9SM2JJWUVpQzRGNU1FdlZ0?=
 =?utf-8?B?eDZHZ1dMT3FKRWJsVmszeVlmNUNRR2FFaWQ1bkx2TEd5MzE0dVRxUXlXMDFu?=
 =?utf-8?B?MTFQbGxhT1FKNlI2L0RSTWdOUC9LK1NPemtoMUhjWFJ0WXJFb3ArM1N6Q3hV?=
 =?utf-8?B?NjhXTzFOcVd0NHRjOFhBYjU1VTdMWTd6ejA4MzA4SU5ycm0rSnFuY1AwY1hU?=
 =?utf-8?B?clNRSEVoS0VJR0g2amhkSVRLSGRYd2FCOWpVYjRQZ1UydjVCM0QwTjVTaDJD?=
 =?utf-8?B?ZmtsYit6dW9pMW4xUFdZaWluaGxldWN2YnpqbnpYMmg5SHFpdHc0QXFuQU5u?=
 =?utf-8?B?RWlBN1V2OCtYWGhyTGgrejAyYnZSa29Gc1AwdWFnR1U3MmcyYzYyeno0dlQw?=
 =?utf-8?B?YlBtdUVjN2NZbzBuWWdIRHVneUpyZzUySzJsTFJWKzROc2pyK2Zqenh5Ym85?=
 =?utf-8?B?SnhkUGx3QksvRW9ZbnNNa1YvRmlXemdnNzdWSndEOEcwU0ZxMi9lSlVSQWZ5?=
 =?utf-8?B?bWlwSUtjNU9xNWxYZFptcEN6QVRCRXBUMVoyQWJuV3EyVnlQaUc3QTc2Y1pB?=
 =?utf-8?B?WVVPdDJrOGVMYmZGVTF5M0NobVg1VTVqQllHOWdESFFwV2tBWXI0bThtOXIz?=
 =?utf-8?B?QzhLbWU1VUpVL013T2MyQ21DN2JJTEVsN1I5K3dVY08wU1Q2bzl4eEZmeXIv?=
 =?utf-8?B?eVZxL2dDSXM2UWdPclE2R2ZheDBmOXREbUd0UE90SzVGUTVCYXF2UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1102ec05-6695-421e-c96e-08de51b10803
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 08:03:12.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlIkbmQNn3H0BjMVTCgE7DQh/4Ml0OgOGhcDeViEqxHdYR5ICBDdiEKN/2OfotrYt65eK4gAVraJTAkzKqhN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

On Thu, Jan 08, 2026 at 09:58:46 PM +0100, Johannes Berg wrote:
> On Thu, 2026-01-08 at 23:00 +0300, Dan Carpenter wrote:
> > The "i" iterator variable is used to count two different things but
> 
> nice catch
> 
> > unfortunately we can't store two different numbers in the same variable.
> 
> :-)
> 
> > This was found via static analysis so I'm not positive on the impact
> > of this bug.
> 
> I think it basically means anything other than the first interface
> (using adapter->priv[i] with i>0) will not be updated correctly for A-
> MPDU buffer usage (?) if you use more than two interfaces. Given that
> most people probably only use a single interface, I suppose the impact
> would be rather low.
> 
> johannes
> 

Johannes is right — with AP and STA both active, whichever interface first meets
media_connected (AP or STA) will trigger the inner loop to overwrite the outer
interface index, so only that first interface gets the per‑TID delba while the
other is skipped.
For reference: mwifiex_update_ampdu_txwinsize() already uses separate iterators
, so aligning the RX-side loop to the same pattern makes sense.

Dan’s change to use a distinct inner iterator (j) here is correct.
Please apply.

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>

