Return-Path: <linux-wireless+bounces-27478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38EB839D4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 10:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FEA1C04E0D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D2301000;
	Thu, 18 Sep 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="0EyTvETU";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="TtDy4vih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D682FF168;
	Thu, 18 Sep 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185681; cv=fail; b=DXj1BROPnsXiksCRZTJxERHCG17kJ3Pf/vq1a4GKZtOfYFImq3GZKoRG/AXlhoK548rZitUzYhf1zBMsjgTtL4eCm9yUQ55Dew1Sew+N/XG2R9KOzIRetv8SssXvfXLnXUXbOIbvKvxNZMqdv7w1BIiIpv1YDWb2CJtzpeTdvsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185681; c=relaxed/simple;
	bh=wx2GYA8H6xocqeLrbRHvTZTwB1SLGvIOhABkCkS06qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVuJVvnOoQPD39bX0NjxYKgcxJqOzhSOC5zxtqzD/AlfpSln0EISa05QeqvMd5kjALQzwPmzGhouTiZlHyRPVx1z+qY0yciHwduawZDA9FxrM45tNmE1tWAXhTuABb4s2z3X2p5imSPHOYAg0PH4QBgrlkBzWe4Ejkpr+Euu1K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=0EyTvETU; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=TtDy4vih; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I4xSju1586581;
	Thu, 18 Sep 2025 10:54:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	QlhV9yzHhoWapYEzfYd5kUr4X0uE+Zc7x9ppIEFqsHg=; b=0EyTvETUfXPMDPtl
	HHLolKwtZKg9guJiVo+or2qaac7lUuEj1FHTFLC3HM903dhmF0IJOTYWFMYWPMlQ
	y+czgsRFhGqjWRa+nR7RJ1C03hBOQzP2UBmHImQZbIFqTcdF1FpAFOdEz6SDVRXk
	edwJE8UGma7YyafkEMadZwbLS5BxOHcI7E+4jb92RgXPEK+LuR9w/TjlOo2wCoHG
	ULMXJKiqBjqIi1UChmJllY3+5yNtBK8pynTNlrjcbBB14D9J7jH14bTS5mgIWPie
	wLCuJGoRkrceejFjSyDIX0920HJJLEzQ2q+NFTDfU8RfoDyd/5VmosiMIcbbVGPF
	mp/k8Q==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2134.outbound.protection.outlook.com [40.107.104.134])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd2t93-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 10:54:18 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtJ/+abt13CeDTdgu9VM1DgyKC4K/MUKbOU66kMRmCPeb6fcJRqVGwY5vTzyXu+E5P/IwBNpuH4RZH1Oj27p3q/EmVibBucYauMVxnA1vL2XcL6FXxdSVM0CX/5xRfEnAIK52g06BZQ44pckrdtF94nkFVt6qygQX9Ra3FLqyYCv/yHiGZ98ZnF4NOrpwUm1Gmb3I+lu8JeF5RjOfB2XeOzIC7JiYugB6JLZJtKohP/3kYkL7io0u/Gz0Zn8s1GgvS/5Ikt30CLOkMfU/mitc1UkqqxUki2m/FP8F8DmEWewWNej91MR6XyRAzd2GBQ9qPYb4bI4hheYVRkaHBOFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlhV9yzHhoWapYEzfYd5kUr4X0uE+Zc7x9ppIEFqsHg=;
 b=RUuk8fxYez+U52FxMtZKN+jik7//9TgTv7SgvaQenGmwbwc1o4Fiwwyl8KGHfSCa/Rc7W421zCC9BywAQA2k4A4oJqth5AgZcp/7et991oH2465v+eBq/jFYlXQxVDbdF3JLLVsGLsm89D6us03NV7trl5UnXDD3JpuQ94tYJdZBvrXB1G2d1FG00MtGG4bp0qhugCbtbtFp0MiZVcQRDltP5CWwO2E9Bt3ZsyVJqQ3vzMw7Blyp6DhdDVIRX3rHJgLyU4hHgYCbiJeCwfH0V9ludOXEvi7udffIrvP3zKtq+qnvCzgbUVjFHHb5GW3ZKfC+MydsWbhuOfDIwNezLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlhV9yzHhoWapYEzfYd5kUr4X0uE+Zc7x9ppIEFqsHg=;
 b=TtDy4vihkETSf06JC4p+j7qtgwaphvDHMKosSR9B/5ImfWB66OK3kUtGYp3EX7ChQUwLZABTJ7JPCd3JnYRrpUBq2pMczRkaJymyR24XB/LclAZFhc5v96wUPCgiLX7dZCT+tRVGJ3twzg61IVvIJtbLq0v2swfX8f396dLeksY=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI2P192MB3195.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:54:16 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:54:16 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/4] soc: qcom: preserve CPU endianness for QMI_DATA_LEN
Date: Thu, 18 Sep 2025 10:53:58 +0200
Message-ID: <20250918085406.2049559-4-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E3D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::46) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI2P192MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dae75a-3e98-4958-e80d-08ddf690f2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFX1auemwTFO2WWdKsHqlT2voPjNJ+7L363C4Y1tyIFgWGzvetK14BT6Lsqd?=
 =?us-ascii?Q?oR6cu/Jt0GdXkeRxwHqUXo4ngby/SSrja/x3TVoMw+mX79jqAcD6TQe/xCnJ?=
 =?us-ascii?Q?uN1wEUcjg91PkXOqrujQs/pDc2wl45O2tRbO7t3u/Vo4ljQ7c4c83sjYBE3L?=
 =?us-ascii?Q?6nOgjjPzJ5jw5tIAAajtZAG6SSOH8/8n+/wBw88dRlyLdu3wYlsC7ZTHfri3?=
 =?us-ascii?Q?oSooRQg4Yrwr84rhX0tsZ8O+YuP7glaUsxekFxvZpOH7z6svqGV4xl8mxTmX?=
 =?us-ascii?Q?zyW3yAyaC4NElEqM+/MJPLXF7ixEbPSzRdn1tUe8sFUKxHlZZ9j82UBXSAiU?=
 =?us-ascii?Q?lirhYXLd76sRH6amdRQrQW4s75nBzfNmw7inSP1GbVrztYoa/jmdRRfrxG7C?=
 =?us-ascii?Q?KUBwcrxiRlt53sNefVljY++eVNQHa7vNjPAN3NUCIRyAaSOyqOKbAkxYK/aO?=
 =?us-ascii?Q?accyCp44nR6YNs48nLUmnC3FlxNjV0NG64JHz4P5RNTF6UlY0pRJsYlqawBu?=
 =?us-ascii?Q?9puRTbsW3I08NfK/U6ArO4SbQYmj8K6qQKX4BCWKE3UP3oKdF7qAeNkxK0YO?=
 =?us-ascii?Q?54UiLdHUTCCgSIT3YS0jmNxzhz7oS9YVqEDkpxkFyc5mbyNZfheulRFfl7JT?=
 =?us-ascii?Q?ddPn0Wh3DHFIXAM5KEMyzvUBsnZkHRiNPHQ9ORqGnPKMqMoe+8ryAm2v+Zgr?=
 =?us-ascii?Q?Sjii9GOrb18xLBj1IbqwG/7FmOsji5IL9N2edl43opDu2bp2nLnU5U03/Taa?=
 =?us-ascii?Q?c36n0kPYpMsmacRSAY0c0aoT64dCA/MhypRK+v7B18eRQN1PZt99r8rtDjJk?=
 =?us-ascii?Q?nx/jxUI0k4/HbNU1XtEA/Scct/lc4NlroUZ6SFNu7yZ61x3yh5oVC4Z8p4rI?=
 =?us-ascii?Q?TllTI4Z/sUpOVRFynZSSwwOTnZ3uu5VXqP0TIrKGELstZmhs6QvedebNc5Nu?=
 =?us-ascii?Q?uKFif+lpGyyVYfg6QEYBXnJoWR1fgCDVwolfB3mZ/GulWQPy+ik2/xzpSia3?=
 =?us-ascii?Q?LfraSpJCbs316qwsV3ojRHnuqI685DucDu56I+gMtFeLwIIbqUs0EFzjD3uI?=
 =?us-ascii?Q?ABmR+cToo6gYO30Qt9PMZBfY4+19Xj7l+SKOFvHtZpHYA4/MLH7qFZUplkOJ?=
 =?us-ascii?Q?NInZgUAbMeUSHuDyAm3HHCYgkiCrisrJHXhlfxAHdMJ3WN25OPBdirFPPywB?=
 =?us-ascii?Q?pifEOsOy6y3ku7ZViFMI/nnhZFlJNwjHoF5jN8DOGGgKWH7XWY2tnnY26Pyx?=
 =?us-ascii?Q?MLKgdgDppXsWVfZR0+PtjE64g5aY87tWW0SJ0Vr8dUqmqmpIbXsonIB7E6cw?=
 =?us-ascii?Q?V8kbzkbGzZ0kNjKDXJLm3MGl3YxBi/S5B/ItfXGAcwr+QFlZVFPaSGPP6m63?=
 =?us-ascii?Q?11h1IcwSFr9mmV3Q7zP5jJP5WlVwfPEhOYZxWA6bu5xp86AUpjGw5xz6kKVw?=
 =?us-ascii?Q?NkEvXYcbTAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0zJ3gaAS2+88sQwCbgFgs+LAp8EN2DSVKbiqCSFXAWBCKeqk6vTMfPD4dov?=
 =?us-ascii?Q?azFgYU2Xs98CYcp3Qxlldxse2M2napkm4ycsxoPAQdyXrnG/5/RkpipGhj1e?=
 =?us-ascii?Q?hh4sPXXzT5IKWX/iglSf3R565kNgqyi0U6/+Roy7sIaiLLFmXg1OmisEDJOn?=
 =?us-ascii?Q?t8pv5sufOt4SWQWI/c+CGnOJ5hf8MFpIz0Deuvvnd9m4SNt0kwBzdz9meXqE?=
 =?us-ascii?Q?82ZzxgFgTqhKyfWue89wglSAAH+eOmiPeIe27cwglcd1H7e2ELjHwK90ey6y?=
 =?us-ascii?Q?m84b9KdGT67+DhmaGq9vDZZE7qshW4HLjUX83B6u2B0gB/eRkoK/UJoUwury?=
 =?us-ascii?Q?QVg9MJ5pf/KhDy7jVJM7PIJaTZf8NFZtdOcqvq2S/VG7aiK/3aKrIF7rDkHo?=
 =?us-ascii?Q?D5ikafUcbq4ZNirj0huZmrPQmkvk4HQNdEBTh7LrTmCBBrRTx2vq7etO3Gtx?=
 =?us-ascii?Q?e1QbOFbzW6VRuG9bzmX0+ENAtONMxNkACc8Kxi74qz0nwH+Qkazpw+AXjTOA?=
 =?us-ascii?Q?WT+LtXjKgfzVqXDDFaIaXYF0ARBuINzhS8Qu4dKZzHdE9dMaHMouw6qm4c+D?=
 =?us-ascii?Q?Jj/MoxIm3ZE3oGjRZDdMjLCFx7RUAtPKu6oCgntla309vsO8Gp79O/zQdJxq?=
 =?us-ascii?Q?NITUt6b/t4Mcx1tzmL45lpNXM36zEJdRetD+vrXHjOIvnD8RkNOjwds+haAM?=
 =?us-ascii?Q?yt+ss3Zt8oTMD1KGhpE8W/zbalRQO3nASh6lz/e0S47s6qco/dBtghNmtoNr?=
 =?us-ascii?Q?pDkAoFGr2REPpmKV5gzIHWuR7ev4HhOt/2A6zrDOAG85kSK8cF1eqNJ6g79c?=
 =?us-ascii?Q?3zZ5RbrPjcNf7E9H+6oby48lHPdl9Dtj5nMBUw2hfk1fAKMOkKUyON4afz8E?=
 =?us-ascii?Q?M6ORZyIgs9IXI7Tm5p4+bZAQXF1g9KpMwh2kuQFGJqeDvGnD/DUUghDUSspK?=
 =?us-ascii?Q?KyUrOUSlTJRD+FNl1+t+4z8KxbPaSNYejMkAM6k2FoYS0EI6RrgmQlscydjb?=
 =?us-ascii?Q?n7tTSJ2nAONnclP8BqTO6pW/11S5q6dpwlu8WevQc5l5Gd6NeFswgEfTz0qM?=
 =?us-ascii?Q?d4KAs4HS/gpCvj+wviaDSn0hc3+77VGYkct4yGRND2mp5ydz4J/ARuWXBAnh?=
 =?us-ascii?Q?vIbuADxA1eagiX7VAKdYkynW/FhnbyuFPXWxXvknZFT2hxXAueabyFc7VN8r?=
 =?us-ascii?Q?5U+HQkzgAl3YtqcvilhRevTLQrJj0RcBBOdpKN0HdclottQp8IHDX/MLBrp0?=
 =?us-ascii?Q?Em6gG4G8+ZXkCYanbau0brhCXXdkpnAYrHNQDpESKWl89aEFS2V+cqvJsxwp?=
 =?us-ascii?Q?WuZKqJCDJNv/NHWyCHKNrtQr8Wt78C+aSNfYf8nCCf3DFQKYE0WpKX5wZyLB?=
 =?us-ascii?Q?xoqb1cDkNTuX/xnLKGi6Ut0kQ5DtZxyXGnBVz7b0deFeOyTB1Z8GpQNNEoBT?=
 =?us-ascii?Q?qkZv/ejQHIIOrVBVkCEvm9bE/t20tVItg0bgHmPhfmPPjIYlg0kgJrln7n4H?=
 =?us-ascii?Q?JoXKvZs8M0bB/KQHphy7fgihEkUuuP4qMTNRTWEHHE8DRJWESZOh+3o4hd2r?=
 =?us-ascii?Q?CccV3Qp//2NDZ9Z3GnHrFapA0XtJzrVJYHGRdlKP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q6+dhn5Xl0gIph1mhUbWTNKPt94ajvU+B4quCmvEHMls14jH8eO+cVsWaLrUyEeVnEtNnp17oZVOAT+p+4LD7FryW3wBQkowevGtfYFNo/fJ4hjI41TjmlQCB9jw9eIHRnK9ltiVOE7aJ0h+cV7fni0a/bEUS9zffDorvjRPrMf8pDDS3ajHxflmXbJqk2r49Oc2CrAQTMXwKLLRPhnD6zhk8aGhdba5/LwVP4sFusDmKLFmIJL/PzKZFQPSB0XNMrwQWwvWQiJbKPdzzVahqjEo3aJyJJ+1IbcZSGXDKS7GPlw33O+ignTQ57Oxmq5dvvQ+8wjrOOuWPJuBc87UaMKx3ZfoJZFWKWYW1tkkMZNnEPrsi1ITNlvbsxr2zR5j+nXLsst5Ipxio8MCUqE1xcDpTVpg0inkYBj9we5crtb31SFB6fBp1cNGROb44NdguKOCL1tcXNPLNlbIZ+kC4JrVQj/EGyXcsLSVHSCm1TGNBLRFF0LyrCVh65hXC/IKMdtJ8dx+FlYqGDCibnGGaEJCM1ohmAAFqoKsgaqiBBq+aXxh2QTr9j3XBjNsiMj2NPxGaefUv/9UuH2CjTCgQu/xpzZQSZjFicJwEzI366jChmm0WVXnp5zdQNiNMMJI
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dae75a-3e98-4958-e80d-08ddf690f2e5
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:54:16.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSSlfj8Y4Gqphfl10cR4i9KP10WiIkLHRqa7I4/nAHyrFIoiSwxpJ2TfzTt+WiK587qhxkYscampq71Cggordw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P192MB3195
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: VI2P192MB3195.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68cbc8ba cx=c_pps
 a=SoZJgLlObDoeHP1yZO72Vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: -vFkpwl6qnHRx7g0YCQh6EhfMNAre2C5
X-Proofpoint-ORIG-GUID: -vFkpwl6qnHRx7g0YCQh6EhfMNAre2C5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4MSBTYWx0ZWRfX9O8QhXTNi+Pb
 iMs+UTbBZpXbMUnYZnhCSSj+06k8wPNr4d+N58k6KamV3z1JYzpIXdJIGFQ2VGjh3auwKoKZp8R
 Ovy7pvqZdUzS/XseuhlybySj3WqEMkeoJZZlPZudejh81iX7iVBY/jXJb5cLRv3MQUpBeoK+fIV
 o+7XXt/cyesacyX3VvnHtqJQklNknIbxElBMFaJRSF8emtwzf1QHxToFPfHGX+pWALYx0aJQVqp
 tjoUCUZ63AU3Rq40uSeb1mxfx4mgP9PU27dYSaW9g+wmVUacOlscWp9Y7LxiXXaEnhSDweb+VhH
 qNsMlhukigd6wsgn+leZO3yHj+4fpmPzJeCQZappK0RL+hiDoAay4Cx0/4UWWw=

To ensure correct handling of endianness in the QMI subsystem, the
QMI_DATA_LEN field used in host-side drivers remains in CPU-native byte
order. Remove unnecessary endianness conversions, considering that
QMI_DATA_LEN is always of type `u32` on the host. On the QMI wire
interface, however, its representation is variable and may use either 1 or
2 bytes.

Fixes: 3ced38da5f7d ("soc: qcom: QMI encoding/decoding for big endian")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 90a48fa7ecf4..b92af573e715 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -396,6 +396,7 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 			break;
 
 		case QMI_DATA_LEN:
+			memcpy(&data_len_value, buf_src, sizeof(u32));
 			data_len_sz = temp_ei->elem_size == sizeof(u8) ?
 					sizeof(u8) : sizeof(u16);
 			/* Check to avoid out of range buffer access */
@@ -406,13 +407,11 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 				return -ETOOSMALL;
 			}
 			if (data_len_sz == sizeof(u8)) {
-				val8 = *(u8 *)buf_src;
-				data_len_value = (u32)val8;
+				val8 = data_len_value;
 				rc = qmi_encode_basic_elem(buf_dst, &val8,
 							   1, data_len_sz);
 			} else {
-				val16 = *(u16 *)buf_src;
-				data_len_value = (u32)le16_to_cpu(val16);
+				val16 = data_len_value;
 				rc = qmi_encode_basic_elem(buf_dst, &val16,
 							   1, data_len_sz);
 			}
@@ -695,7 +694,6 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 	int rc;
 	u8 val8;
 	u16 val16;
-	u32 val32;
 
 	while (decoded_bytes < in_buf_len) {
 		if (dec_level >= 2 && temp_ei->data_type == QMI_EOTI)
@@ -743,8 +741,7 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 							   1, data_len_sz);
 				data_len_value = (u32)val16;
 			}
-			val32 = cpu_to_le32(data_len_value);
-			memcpy(buf_dst, &val32, sizeof(u32));
+			memcpy(buf_dst, &data_len_value, sizeof(u32));
 			temp_ei = temp_ei + 1;
 			buf_dst = out_c_struct + temp_ei->offset;
 			tlv_len -= data_len_sz;
-- 
2.43.0


