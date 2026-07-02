Return-Path: <linux-wireless+bounces-38494-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0SFULYEoRmpRKwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38494-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:59:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B36F5069
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 10:59:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=zvituG5E;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=XvmvJFuY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38494-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38494-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA6231388DB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B2472766;
	Thu,  2 Jul 2026 08:45:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16C46AF38;
	Thu,  2 Jul 2026 08:45:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981941; cv=fail; b=RZvSr71earh90/AnL9DL/3cp+HUUjiV8pIxC1KbSM+2XsfyQ5KK2ZE+HXpbLCdkiN+ehR04jurvYZncvs+rxamJrz6kdFpD/Pw5OzH21CpziPdZwtVZ//ggYZGap+mpd8AEJmtM6zN9YMZ8pC+/UM/vMwGDQahc7i/hZRtVMd8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981941; c=relaxed/simple;
	bh=bJQsPQ2jxh5L5ok3NfhljvxJnIsDh0/XwXViPYUyztk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9ZE5h8k3jWmhRIt+yWDHAvmqlYCZiMx2OsReY2UqoXxmYlUT/05sTwIrubs4zlg8ikq+BiGNE1AQkW82KD/aoDH0FD2eqQzu8j4LJx4/vL6v7j3A1SjIQUdFjOFCEe97WIS2c5vv0M5+CDpcc/OM0ISA+JU21NNAWF3yB1Tlq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=zvituG5E; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=XvmvJFuY; arc=fail smtp.client-ip=205.220.184.10
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6625Tv4I277258;
	Thu, 2 Jul 2026 10:44:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=LySQw26V89fm/9i3cqWVAUuS
	q34U0VTkQyNPohDTnQ0=; b=zvituG5EMtCDA8YSH273c2BAxLRRlQGk49eTdXGh
	+h/qRKS8O2wwoHV+SSMMkA8B4nUJlKm5QzUoXuqj3XE9qqfgfTskxYbMuJCQ5tye
	IVjW6YRUcVZZnI6gHkMLepik+sT0AJDs8Z8las3NlaVDx9fWJvXjse3NlhUf3JbX
	ecalxlnRuUYSSI5wco+teHA4c1owoLtOWmdMgkJACCBOXNCYQim3xmd8iDvzBT/L
	bgn5ySECuPkUKbR1xXCgw86IAMXBWIe+WouXg0OS9WUO07v/gHdPPbvAzPI5anzV
	2253Fal+SXvQtK3PYygq48ggygS3f4VJOTdJMQ8NC1QoZA==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11023134.outbound.protection.outlook.com [40.107.162.134])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22v9en8d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 10:44:50 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMTKebNNScqEJhH0KJWjsBcbAOkTTIR4RkA3E9aaeguJSIt6NGJY8UHPSusXSE+p52Lp6NNhiokXSYuiz7KCOHkT+1KJMfgiyapo7G5cZO+2NndWlw7J/wITMHBV7dxMa6hO1r6B0L/NPmkpN3RdsedOi2wIy3Dww/QfN1cQrpnm2ommptj/9dFmjAJqtgrMM77UIPMSW15t60WkCl0L2/OfptXqB9gCGTGFqb8F/u4cVQfZEcZep2Gbih9i8igKjM91WukOa1GuCkV1EuV7ibJIpXJP2vV26yFPpJsuXLqcDodFYRzChhQ+uj0DBobk57MyMIyIRhZlyM9SYe57Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LySQw26V89fm/9i3cqWVAUuSq34U0VTkQyNPohDTnQ0=;
 b=WgArAGZrefw7FkJC/tK4FEqiOPfw36NXpvws6veBYRsg19++NZ02RfTzT0MGRW+bwq8VgdAkD+KN5dCEzSFDzzY8Cc84iszEE0fwdWVMQ1gt/VBBY5kG1Fm12QHFXEYEOy3TQc4CiTGJ6CNXPOWF3d56vwWP09r6fKM6Kexg+xiE0S3VS42e9EcGzlydNkjYE2l/iOP5AnkWmV1Yuwxz7RtBllOWt4cyXIXmO7tlO7Q5ZdKA5DWSpvkBzwwTEFcTXNx04CiMw6N/j1Uy9y6ui2DvzoXsItENCpL24LNE10P66m37EuP1bFptxeFbz7wnanEjMw2o3liCzhizOucU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LySQw26V89fm/9i3cqWVAUuSq34U0VTkQyNPohDTnQ0=;
 b=XvmvJFuYxrt+zpzKb+pP0AvMo9y6FHiVZvSGz2gFcPfMfqpHbEUll4Gf8Rr1wDZiDY74kV1Eem5N6KFXWi7G1rpQmtSQVBt6sakbjmNuVG/SSMtb7KuO7GEPrBE1YJIC8gxXA52eCLAYIIo0wHex2WWo9vZmEZdnhzkLBCx8xyg=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:44:49 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:44:49 +0000
Date: Thu, 2 Jul 2026 10:44:46 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix channel list copy on big endian
Message-ID: <akYk_pKRd7kR13IL@FUE-ALEWI-WINX>
References: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
 <8b29a6f4-0742-46f3-bc86-defa6e0faeae@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b29a6f4-0742-46f3-bc86-defa6e0faeae@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF0005F6D0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::64d) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DU0P192MB1571:EE_
X-MS-Office365-Filtering-Correlation-Id: 276b7569-0183-4e8a-fa9a-08ded8162d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NJz4VMm17ccoWNeYUxwfixCHaGQrQMt7s616ymDFn/ArKDKOtNKbIRGKrhsRVMGPVINVA/cgpndezxrfXv/qvf/jOSzZGpbl1W3wB9GGObRoL0ovQvC+dOy6+2UCIzb/2VDHoDN2EqqXDMKzzZjJ/jHXVKSfxvoba8bZXqaxpkT6WyJkL8D9CGvQzMRl4ABEpNO8Ga/mxvmDoc/nfL4qaDAXuoAzsNvr6o/5HUguNZOfPIE0G5acVxz9LIH3cqxAq/KSr0XkWu55sdwmref05d2VDzQlrF3xq5RS+fL4Vf2ZaI8NqKW16swQkJORPnAAyIM30nYVJp+XdydFVQevKwdoanVfWmPvh18ca76If3Z2El2mswx9ZdI9EszSUn7DDk3z+XhaQscoA/sztGyA7VzAnCzlKzThxdJXQktjUiTQlIG1x4CBDorClP8yfc2AV4h0kOdsf6uoCv1IgJ+XxPPBiFliZ9LsmF8ebMRxpO8/0oZbZkCAtKVbNjTgt7wM1gIah/pRnBS/UgLRHMUceI6V0aQsoU1TTvx62OHyaUC3H7uY1aagWT9SsxuhIvaCI+0sQ74mF+ofbId49zIonkO4AzdDRP0+aij1gGWccrYNaH9aqkpSU7VYpxZsqNIx7k1ryDy8OE3zeg+XRlptG4mNjsqPruefuH5gTpdqQ5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B5bGm5VV7eco1k+LxbaifNxzmQ20Lf19ARPYaiFdFFbAma0NuedrYUjwCpwe?=
 =?us-ascii?Q?oLX2qNnv4X1cmcAZRDez6JkZXEuNh8gLgJheUwYPDr237jNuSu4QBfVTJMA/?=
 =?us-ascii?Q?U6nU9IieV38Apy7B5vMhyf4nkponFowTQHWCal9Cx8KwpaCDp761TcEoj8dw?=
 =?us-ascii?Q?60UND9ViU5ZwztzwzWFblu3ADKagWaWJSjq9ossMc7KGiY3stffdW8zWcxaR?=
 =?us-ascii?Q?e2E8kpsMBJYynCbobJwBdqHQtqoq76NDCzN4dIvvIcoT14s1+f/7PSfulbJT?=
 =?us-ascii?Q?MGaYh90H9cF+2YNVObcHMSIK/fDEVUuDiomKYQ8fOuzvw1/2Ykc2hCkanCl2?=
 =?us-ascii?Q?Za8zfIJ0aWvQEXJDxxXiClormuaMXoIdQOgr9VSxogkfhlUwzRu1eZB55FvC?=
 =?us-ascii?Q?e/LxfliUqLP6/DDtECgswPFTeXQzupNEiCUG6iNirrw664ZiAqEohWRUNKK4?=
 =?us-ascii?Q?1Dl/zJkpy0Qjta/RvwLhaMxACE+JQNTyJXF/Bj4TCg48Ynfp64JuTaSg0CzJ?=
 =?us-ascii?Q?S+HaO/fHsEuXc3gY0Eyz7OqH4tfZEQipzkKKB/v94ZwqSPcr7oF3jonZz6Tr?=
 =?us-ascii?Q?kepG1sdawYuMGJf6owgsd5tkpnobA3J1MwNoq3XQeiJRcycNGdY0rzS2erqm?=
 =?us-ascii?Q?rS8QTjCuJb0WfKZlwjUvOnDAVOkVrfbafm5fkE2lWb5Ux8D+YS/2MR4CtStz?=
 =?us-ascii?Q?AHBzESEZoBrcokiDDsDJmnBMUS3ORuaJV3s86DDQw69bl7A+4TW85CuXix7G?=
 =?us-ascii?Q?67vxwI2D9+LVlsTgaMTTBTae9beDlZPyKWq2R3MAQ9suBLBhDYTyCxErvSsT?=
 =?us-ascii?Q?cmMXlACv2cpmmLqIJV3TqRHsMFwVAw3auZlsx7P7YbK5YF5GDIxr5O0+LMiZ?=
 =?us-ascii?Q?MnEspLQ16o4vCQUFIKIFU8SxoAW94jlmVozReY/46cOT5gkExAXjul3jhakN?=
 =?us-ascii?Q?GqF/oLaINQk3RQsOYhy2xEubRjTf+kcGNlulWM9Jx+QZap37XMrW7J9XPVU1?=
 =?us-ascii?Q?RK6oNjqmRAE4LrJJFJSE4aWYc0EOlrrv7/lehOb6K7rxXq0R8ev1fYub0lyH?=
 =?us-ascii?Q?PR0IaDYJYMB9ArqfB6ti14TIRkb+qI+JnjOdFoNrgW+ev0Glc9eeWPc0zPNf?=
 =?us-ascii?Q?VoJGo9XnLpUbMyEaXFspk2RTc0bG4llclG5ZH0XjHviC38lym94pl5Ora/5G?=
 =?us-ascii?Q?jlRlRxiuQVDCClBfxP2tea98qG/bcuvirANNuE7n2i+YPUlsH4RshFrbABB+?=
 =?us-ascii?Q?LhhwxpBgJgut1htZROv79c+yGN42b/u0PEhN3T4AVw2rQtygCQaCj9V4FOH6?=
 =?us-ascii?Q?FMfmEs4VZ2dFIfbo9wBaW38Lz/0aDyGoNGZwFDQnmfyHVoHJYW2yCo/xgzFS?=
 =?us-ascii?Q?f2BT9nd9fttJlmfkUOnbhIKU6oa9zQVd8PHTD8YjlC6n0vVtbnFh2lkpBBMJ?=
 =?us-ascii?Q?c3o5wn+lN5klesoE4EUg/gQWqfDygLKaphPwEZykpYpH64sgY/LKzv+b47nU?=
 =?us-ascii?Q?hV1HYTIhlJgkDUcQQAFg60ammJitkHOYRC0DkMs0gvVgjAmDHZAqIp/VF8Ug?=
 =?us-ascii?Q?FSY0RRO9qWwHbvBDhU1mjv06jTOonFvvOVr1quUCyQDSHLjsShXAU6EXy7+J?=
 =?us-ascii?Q?0P0GoVn1PpC9kyJt66JHigqo68TcIQTIX5xsCSAu2MAweHBCG2vEV0AJZ1ip?=
 =?us-ascii?Q?tj+oZf20mVEeB8kEKKZUc2ENj+8d6fRHmjj8PVFDRpwFhBbBuI6a8S/qpcC2?=
 =?us-ascii?Q?FgEpxSvZTw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Dr3Rh+CWcHXpJTZIpkS1qQeRYePUpG4OikRX7gW9uk0m/A4veNreZ2Zy7hfWICBRbQqYI8b7/0ssSccgtZBTZ4jg9rNT2BpET0tg/WQu5VxDgirruQGLgmA5EyCegs90WhFGcuDWmTbZJlmWz1xinvdYcxu7DIMv/yHQgktDQMjjNAi3qJWTIySaS47GuHmq26Mh6h1bIvktAdkVLOqU5uetMK9fzQhigiWwayOvKaEern2lFih1HEyG2qJv8HYic8H52rA7rGOK+Kb2jCEfEAFb/gpKEpnaH6+EZuWLszpTGQiK+mcFS5Zw/LLowr1X0KfMlDygWGcFWuWm7Kuf/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BR5QMKwpvDGxG7B7zL3gnbUNngXi7uI+ZY3brPEquh7oLkxcE0abO9MckYfBPj3JoxUiOzEbSC9YeUnsR1/hs9BO0bbCS+3anCBvR/iqJnakwUaGIDH7eTu8HX9LeTNpTOxuz0lTMxROlXBwTvblUrzfRW0yeUJNoP3JIsnEkyMi1FQpF34chAjZO90Ru4ts7T1x6DDCH9cWuu4gbRD9dQxOc0kNt8N9rQxWVXMECN/W9vGmG1xMbUuOphGK42prSJp2VRzxoR3hqtRZ79yjsS5hzbp+gMQOGF8VtePGSqHJJFhXq+l8+Ql0HzqDQ1kPSeMu2pHvwA8nZbUg4KYRZJGNRFN8AGuGGBAP/xYGyifxQDrJm38BBjXd0uPlz8m9KaRzYTSxpBeGJDPitZdz6Dl4g+9i985WS91rkf6yu2+cfcx0Oue+8kOLpAWMGAaw5892J951L6XVTDqgrcqNN0MQfGqBRVfqTC6uwX4RxV4YVkT9aNB+i1XPTB4yd+q4/jJF0BIGof1dVz+kQODnNwVswVvuKz5BSo85xDb5OlLkXnN966QV89Fnk/VgYTRKM7MtrFDDX1BMT7Z43DnDoNoYOB3BvNlqFL7pTmOzTTrw5xm3Q9SZtIFwkUTdNitk
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b7569-0183-4e8a-fa9a-08ded8162d5e
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:44:49.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QWi6t8kEavx8vb636DpGG3P+Sb8gn7XWLIsbDT+Wt5pNwQBv+ZAECesCdv2X64cv9e87yFbXZzgnLQK0MwF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DU0P192MB1571.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MSBTYWx0ZWRfX9PeAai2adwgP
 yEQIJuKcjDp4NbZapJdwl/b0zPIYABdzoShMBM1yEu+bgM9CpeLjeOPshq24/x5vaKgBnMoiBGG
 H7p3ESYL2bYlbHIXr+E5k3CNOI4v4YPVjUYj7Ce9q9n9VsYgh0g+rWzrlsRlz5pEVSRo0Xx2rS9
 PMlel9QUdsdHANOzoLtuzynhg6xSWQYNOiVBRoNRyXn3tZMdvH+ILIYlhf9/Lu9L7+TSvn8D/l2
 yGocwGJtnBzpqihFES1fd2FkxLSGfj8+BnJZXok9cGnIMvR0qR1bdROlZO1KzkVFoNoaKqChBTg
 sOs6JhHRXwUhcK4+Wj6EulhTa/NgVazcJ48RsmKv6+qf5xY3c693maheg+kr7EfDE0/ih+NFFWQ
 6qohBz4A9pEHYnijRU+yNK6kG6fjPWMrKUppbcBZndiuWH0RSc/GYzQes0/NRHNHFiiC7SVCOoD
 kEoctXoQgBjpNC2hOzg==
X-Proofpoint-ORIG-GUID: cIRUF-idI2iJAsCBet7ekT-nKVChKmbK
X-Proofpoint-GUID: cIRUF-idI2iJAsCBet7ekT-nKVChKmbK
X-Authority-Analysis: v=2.4 cv=ZNznX37b c=1 sm=1 tr=0 ts=6a462502 cx=c_pps
 a=3eXa2DONhk7IWO7mF/8PyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=8ys4xmT3Mru1TjC2zVq1:22
 a=N9GNhs4bAAAA:8 a=65p1ccFE3Hf02clXqFMA:9 a=CjuIK1q_8ugA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MSBTYWx0ZWRfX4dUFD8wYNXTO
 CZnl5SBuWpdPBRkupHQwSK1feOGUV4q97sf56BNjqY7RStMqT6fCBg6VhaWS+8WNYBZ6VRAag/3
 PwnkwVEE+LjHr9Q2auzehCK5lQ8gvtg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38494-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,beijerelectronicsab.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 086B36F5069

On Thu, Jul 02, 2026 at 04:27:44PM +0800, Baochen Qiang wrote:
> 
> 
> On 6/29/2026 3:46 PM, Alexander Wilhelm wrote:
> > The ath12k_wmi_scan_req_arg structure defines the channel list in
> > CPU-native order, while wmi_start_scan_cmd expects the values in
> > little-endian format. The simple memcpy causes the hardware scan to fail on
> > big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
> > values to support both architectures correctly.
> > 
> > Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> > index 65a05a9520ff..9e1d3c662852 100644
> > --- a/drivers/net/wireless/ath/ath12k/wmi.c
> > +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> > @@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
> >  	struct wmi_tlv *tlv;
> >  	void *ptr;
> >  	int i, ret, len;
> > -	u32 *tmp_ptr, extraie_len_with_pad = 0;
> > +	__le32 *tmp_ptr;
> > +	u32 extraie_len_with_pad = 0;
> >  	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
> >  	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
> >  
> > @@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
> >  	tlv = ptr;
> >  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
> >  	ptr += TLV_HDR_SIZE;
> > -	tmp_ptr = (u32 *)ptr;
> > +	tmp_ptr = (__le32 *)ptr;
> >  
> > -	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
> > +	for (i = 0; i < arg->num_chan; i++)
> > +		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
> >  
> >  	ptr += len;
> >  
> > 
> 
> seems hint_s_ssid and hint_bssid at the last also need the endian conversion?

Okay, I will investigate this further.


Best regards
Alexander Wilhelm

