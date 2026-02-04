Return-Path: <linux-wireless+bounces-31551-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHsAIlCLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31551-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:09:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24877EB6E2
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6C53062227
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256C742314A;
	Wed,  4 Feb 2026 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zxsu+lAP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4C421EFC;
	Wed,  4 Feb 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228319; cv=fail; b=CGajtyxA/joyuStXdNPjjT5PjBaFAf3/y94dmDgN56gVsM0QlPEqsl8RT6tiYvdDn+6GYEAUC7EjM+YdEJiDdUyEoPtSbAE1jslzf3HRqZHzqG3SPYRZc9mGPkPaqghQGksNGve0KiIMh0Z3oNGMAo9cvvaxmfoYuWGL3nRIRiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228319; c=relaxed/simple;
	bh=ZWshfbi43yjdwEqaeDxMmbRRb3vhW4iPB0kG7MvOvDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxB7M/4kqBo2EK9I/t3EMfloOUSEARKABmCb/2pPLThjQCehOETZjLAoYEJxh+TUvN/+bG6GT5z2abPnfkCoqcODQ8gBPOFQ3kVXAQPbbeYJ7G+lMcB9JGCbD9oX5h0W1mnAJcDxAFDI/srGj0zim4k3jd8UtQVoNXw99ESPycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zxsu+lAP; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrDW7AoOsMzar4we56BgMTXskcngC8d4ebe5VpisSC6SmwKyMpaJ7y2S+l5tCTJ8P6iB3jEe3GL/7/q7bq60VF7EGXeHHS2o2dyuBbBp0O5HVtDYTzXpYFnbYI3wSQirMLOr0oWhVCR0cWMchNJDTcysV98w11SM48mE+0Wp19sOazp8mfMT9za79jJuwFlthSWhiL8fx8xjKHVqi/4YoQTu6iMi4aWNG5SkIUoTG9Oiz6XtR3/kmed+0DuE38y7RNDvdkXu0Xqo3fTkyLBrbQfYfdPhjxzWpCx10wpQ9/PXMXvLV6pGmWLSo2xhBdpDuz0Zxc0DcBp60ACX+Mu6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ntHaU9qT3CKzeeyxQ03aJ6OMynI6/Hf+dGcjLG/3N4=;
 b=DcCaSbTK1rajaolCnqc5yB+P3wzBGc/29wmrS/ry87QO3yxk1EgfC8AXji8QVqTI+wHhfa9Nnp+ZovKqSk3UC/NDvh6J6LmSKBWYjHTT/3edANnQs9IrdkV87DcCSD/3RPvfEMhCr263KNVu22pqM13KQvyFPoYdxxvT7ZCjzIdBtARtCm05A738LopNumeci8kMterzfuL4zHjYcK6kyJcTsAwoOyghSrQeB2DaUBmMghImTUZrfkYeY//tRJ7fmQqazfKJxAs23tCkcQco5JtC3t+UKZlb8vWHjt1mQaE70GzBHPfqwbKwfNjgGc+9cI2QsdrTTj76OblY4Bv4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ntHaU9qT3CKzeeyxQ03aJ6OMynI6/Hf+dGcjLG/3N4=;
 b=Zxsu+lAPpwL8hwKYTmA5kLcOpBZbKWDaNmENERsRlD1JSSBTX3kjzJ8sqMQgfs9TNLbcw4LHyyamyXPg+YiUhAphBPaxGaJEmLyax8FXzRCmC4xZ7aTTPXc1fHiiHcH9sppu8PlPuXiOOGJSUasNPosDY8uS8qoM2BXiEWxCV5q3KUQUX0BJfMxBIg1hIlX3gSikR8xjs5NQRer+ipCfBc4yS2iWCuXtg+3+lGrlzVNC0nI3DQ6Vl+3aqPZGfVfFX6YOzCh+x7HwV9fYC/sNSdjN8yRFaQUP/wLlB0vt8iV8svEYs5in8ah205mXY/e83WzCWnXyG0jlGZjbgICo3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB12314.eurprd04.prod.outlook.com (2603:10a6:150:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 4 Feb
 2026 18:05:15 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:15 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 02/21] wifi: nxpwifi: add initial support for 802.11ac
Date: Thu,  5 Feb 2026 02:03:39 +0800
Message-Id: <20260204180358.632281-3-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB12314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f998b36-45cc-4275-5c19-08de6417f2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTO+pphZciSBE0xal6KF1x0yd3L2kbg+A+I1hp1Bd2ACMLYnczRauUE2efij?=
 =?us-ascii?Q?LiiUGiO2fAIPHP9e5bLlfGp0z8aig9Mi5PquPzFIY46GED81ueQtGNwZstkA?=
 =?us-ascii?Q?4pJLRge9nY6O2XrjNSk33ttw3plL+axJxE8nUVOW/qnT7brDvDPYVNJ2QhIp?=
 =?us-ascii?Q?ezGw6Sq9d/BKtN2IMgKjkVg47ufXiVgQ1GCmL2hwypYf9J8diud5YIo/xPkT?=
 =?us-ascii?Q?fgFTMYmAaxiLvP/3wz+vuEtv8ELovV3KKbQvT6MBe/63EHDg6AqAYpKiwtdp?=
 =?us-ascii?Q?g//fBsKyBaVsrA2kuk4H3OF00i9HJJNN+GYUMYnPdQzBMp0RQks3IHej5C9N?=
 =?us-ascii?Q?Lr3mh5B90/wpbzW9JQiqTMZmzDA+QsPlWZg49CBukGTI44EeqaAtEGH8kyjx?=
 =?us-ascii?Q?sYdhk+S4MffoY+3sDzlkM9M3wWd7S/IH8DQa7eoV0gLIT/tnnAAwZ3K4g+54?=
 =?us-ascii?Q?JgVqBN6D86vlIOwWt0mbAPKCJcEJKMk+jT8zKbAO3YMUp04DzVs9AFOcs15v?=
 =?us-ascii?Q?C4mr0JmtULf4T6Nd1fUgyu5JjcRz8daJ1T9jwBXczHYSlQzFkQGmj9/X+mUm?=
 =?us-ascii?Q?J8qJ50RGJMaoBPODOojGDG7ZT8/hlcb9+uu1Xym//ZYsevgw+X47d7r0DxJC?=
 =?us-ascii?Q?msqW9Ej0CIhgtmFp27RjFFd8jSa7uT0/9d5VYPavbtoVIXErolRaFNBHhPrq?=
 =?us-ascii?Q?0hVwB0GZ4S1NU5YAwYdaOLXlcc0+QSDCiQXYV46VGtPfpvMNpvxaZ0dfm/7X?=
 =?us-ascii?Q?CjuEg2XRLmPY3Cm/BQ0a2tFzRSlk9UjcXPOh/HsyfAgz1+Ka89KyYFkj8ubP?=
 =?us-ascii?Q?uV5H1XE/ILxPKY71+ovUqpDC25UssrrL9c+/0QfGCzYDYoHEB0EK0VsEGs0f?=
 =?us-ascii?Q?+XprGB5HmBGgK3F8JVGADjGGolEvcLi1HS8aGEzAeYnf/pnPBXVifpX5/XpK?=
 =?us-ascii?Q?ixk4vgUpXBq3ZLD9ywPcy0N6RndXnFqvNL5WHxkNv0qvdFxZ2lyrtUzCu1Hc?=
 =?us-ascii?Q?dkEdj3cta7klflCou0MExuRZOjCZL53LvwPjeVOVOFuDS6w1IDitb3A0XGDM?=
 =?us-ascii?Q?kaX8EkWmedV8zoT9n0GMiP/Q6bhIC7o4fo5NCWFhuOvsZAPuEsZJ8uxd26ZW?=
 =?us-ascii?Q?zAcTnpb9ulVt3AebS7QF8ZmNhDVYq+Wsa5y0nzcP5wbOij/lJKtJTeZlBekU?=
 =?us-ascii?Q?YH+6ASpRVpE+CDjOleH78MpLei8hxVPlJrKg9KRxOYTnj8oZbUIOLHK9eXMJ?=
 =?us-ascii?Q?E2ggjKezSV9HRhyB6D/6toaB8WmLZVdKRRvK5eV6Yf3MF04tN60XdIp37vz7?=
 =?us-ascii?Q?FPC3nlkARL4xkPwRQTCD1wBl3Ddgn/ZNsvQ7iNURlR9+9r74+4h5xA2CbwwA?=
 =?us-ascii?Q?4JX4g/dsYTgXoOdo4eo/SWlwl7n/TEKIovwAQff3xa4xXYtPFNwEH5i4WtzN?=
 =?us-ascii?Q?7Q67Au+icBWA90bFSSlZatg4cVGX0AsH6DTxhgDWP25Yw1Pq2QPzI28fhK16?=
 =?us-ascii?Q?5Xn851+Y5Z1xXyGCkDVvkfjfE1FJshPK+72/JFxKydS/3tB2ZCLgayHOhE+w?=
 =?us-ascii?Q?Fs+oj43L78l2WbYAHPR9pia1QFhq2U4IgJH0/mdIAhgSC7ZZfwANPCjHoboc?=
 =?us-ascii?Q?rpUxlENmK0O+6anTCy/rtXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OlnZowyp8Hpa75R/p5zoLcGOESLNsT6ci06isLz9EOFNHB2rHOJftLoSt4A0?=
 =?us-ascii?Q?YwuYNpdtv3J9qhnqPIm5l6ikNvfEkTyArsnIlSH8v/dBjAHZfAEAzbNAT3Yx?=
 =?us-ascii?Q?IMtsEaUuEBMZUiwDwMqBOqY7rNGxJv2HbrRxKDTBCstIBTZvnFkdJ7R/Poho?=
 =?us-ascii?Q?8rIQ2N6x7NVw1fJKjcMCjPkk3q/cadbFOvyeapI9QPKoEPNrqGPEeENOyUin?=
 =?us-ascii?Q?3MEP5eFWzVEpcf6/+7fvpT7vBIvRdlBrmSmFbgtTTKMA9KiCOyBGsNEpE39/?=
 =?us-ascii?Q?/CCVQa5AzRBjh5ghnFnbcZXJk03BXOjIym5Yy4gWBtgr6Fs4tyjG2FtcVBRc?=
 =?us-ascii?Q?46WgbpdT80x4wBA94qAoJH+usBsWFV0fBzQatqobyPXGvolEO122y+0a5cgj?=
 =?us-ascii?Q?CoRu995+Ymo6fKXgLpmvIrja4KkxtBj7yTnjFDhMDlindvGRHaeh9HSGvhSc?=
 =?us-ascii?Q?TcoThxqZ9qsEGmhWN1XJhQZqSN2KuX/k/55ypPQ/6JafCVvmPP6JMUW2bkkR?=
 =?us-ascii?Q?HREwHguZgyiSxz7f7TA74+KGMqwq1rNOjA+A/HLiuaA32t0RgVJgUOuoTVKK?=
 =?us-ascii?Q?TE5WXnc28w6xMDmN9oMxGODDNJ37q3lzk56dfHx5BTVywuSkfdnpSPmH/Sza?=
 =?us-ascii?Q?wzQYW57WYLlau6RLcOjFQ4veI7821zJeJgJgs9mAY+w0Dt6kMIPBaBVUL0kU?=
 =?us-ascii?Q?kOakJW2GvTnAomE+tuWq1se83vllfA9Sm1GpRSdrbtzx+yELqsQM9cnLY/oC?=
 =?us-ascii?Q?jn4KCzoi0MQP8VgZY74QrG2YFAIpovpxmwgggSaAgP9ErTRDG4L2pF7CNrij?=
 =?us-ascii?Q?nvwCvYlMFv8NBWEDv5Wra14jyBYwMx6NZe3WV1wv9lU7pA/LAFKLlnqq4S/G?=
 =?us-ascii?Q?MeNM4pnnEXKJd+GmRhViVqLq1iymXwspHlmVYj6gBNylsPLe54uGA/t2oReq?=
 =?us-ascii?Q?w3ZyqGd295nIJMk6WQXa+uE1YLGs1f/HCwKkgMk/stYjYmdwwREvBYXB5mjl?=
 =?us-ascii?Q?64o+5JdJY0zaUtqn9wab7iUrd5v2Pl5MXil1UcqctX1q8MWREV8YwXE5ZAio?=
 =?us-ascii?Q?SLvj5Kcpy7Obvo+rkgVkSLzhEYq41HB5Jnq6FekmNLEJAiId//dhAt3t+g1U?=
 =?us-ascii?Q?dAWd65EdU3NlMML8NgOLfCCO9FS+9w0xrJmxcXssm+oVQIPySmZObSLZXeBx?=
 =?us-ascii?Q?KqhlMq3iDEACtNomaeiHc9Kr1O4Dr4M7Rw/1E3oJt0vFLSybcNSgdrJPDiQB?=
 =?us-ascii?Q?HpuDJ+svZOM1ZE0uDhGykbybbZ1Np/DlT6hdBhmFGPK7Cbp7pfzUpMLUETnP?=
 =?us-ascii?Q?lcMfojiMB/EttnaO0eot0q+v6lGaf1k/fzLbN3lcnD6gYjtjCI6dkiGMijTq?=
 =?us-ascii?Q?LqYXXs4jgbCi1MIsw2TnR/+xpwfEnJIhlml56zu7twIew/Dy7dp5zsJS+VYo?=
 =?us-ascii?Q?/yfGaqLGYCRAZB1aGZkhhgwMgjce/GqYCfLdS8fizD8yObQYS8Gye4K1QSJv?=
 =?us-ascii?Q?5AHIvwRK627vDyn2y1qcsMqp1vIjSZfxthbU25tQ4ES5R14HAJKDJL9454A9?=
 =?us-ascii?Q?gdm3A4GzmGi5v45kdEY59/dWLdWiHwgjvlJEryGxjOsFs1EnjfWNpU5yji/n?=
 =?us-ascii?Q?8u/UV/7y4dUrhWXFVZ+e6EPBS7oGU2x/2wJBp/6gDz5Ekz3gKndKpiTm1CNW?=
 =?us-ascii?Q?jCjOAFUgGPDG5u38x/Ycc83ZGeemvLrFUCzC82i4ci18YEJF21XJlLCfGZp2?=
 =?us-ascii?Q?7gglbsa4Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f998b36-45cc-4275-5c19-08de6417f2f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:15.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmcXj+AdcALcEOErJfTLXR2JbJmQf+SI5iR2QVqLkoqtcbizZrSITQVEbnDJFYe1Y4AZiWbVmDeD0zWtmyeWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31551-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 24877EB6E2
X-Rspamd-Action: no action

Introduce 802.11ac feature support for both client and AP modes,
with coordination between host driver and NXP firmware.

- In client mode, the firmware assists the association process via
  HOST_CMD_802_11_ASSOCIATE. The driver converts 802.11ac IEs from
  cfg80211 parameters into TLVs and appends them to the host command.

- In AP mode, the driver converts 802.11ac IEs into parameters for
  HOST_CMD_11AC_CFG, which are then passed to the firmware for
  configuration.

This patch adds logic to handle VHT capabilities, operations, and
operating mode notifications, enabling proper negotiation and setup
of 802.11ac features through firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 280 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 313 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..117d06c35401
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi 802.11ac helpers
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Map VHT MCS/NSS to highest data rate (Mbps), long GI. */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* Convert 2-bit MCS map to highest long-GI VHT data rate. */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u16 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* Find max supported NSS. */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* If not supported, fall back to 0-9. */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
+		/* Support 160 MHz. */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS6. */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS3. */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void
+nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			 struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT capability info. */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* RX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* TX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities element. */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+			cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation element. */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+				cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* Negotiate channel width; keep peer's center freq. */
+			supp_chwd_set = u32_get_bits(usr_vht_cap_info,
+						     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification element. */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* Initialize BlockAck parameters for 11ac. */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..edc01b35d5b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ac (VHT) definitions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AC_H_
+#define _NXPWIFI_11AC_H_
+
+#define VHT_CFG_2GHZ BIT(0)
+#define VHT_CFG_5GHZ BIT(1)
+
+enum vht_cfg_misc_config {
+	VHT_CAP_TX_OPERATION = 1,
+	VHT_CAP_ASSOCIATION,
+	VHT_CAP_UAP_ONLY
+};
+
+#define DEFAULT_VHT_MCS_SET 0xfffe
+#define DISABLE_VHT_MCS_SET 0xffff
+
+#define VHT_BW_80_160_80P80 BIT(2)
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg);
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u16 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


