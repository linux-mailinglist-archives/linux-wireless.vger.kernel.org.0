Return-Path: <linux-wireless+bounces-37488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id udh0MPZsJmpRWQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:19:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B92C5653778
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:19:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=DyKeY+FE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37488-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37488-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85B963003828
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561335200D;
	Mon,  8 Jun 2026 07:19:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECE2E718F;
	Mon,  8 Jun 2026 07:19:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903146; cv=fail; b=W95DruReUglet5vICPo65x/cmrz4Ue3z91TTWcydiKAfoLek37W7KikULPADyvJ8U+vn/uBgWdSZrAhZoAZgEbnTvyXlEsSQ6JjEiCGU1W3Y4f9NBOM8xzemsOgJegpjMwxYzMmfmlYMGmP+deuLdNXY1Z1tfcVTA9LDT7IHLPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903146; c=relaxed/simple;
	bh=5tZQaCWKdN2JcpOWs+siWNNJdNGSc8+GIG0hCfnWE0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WT8fhB6A0mI5BPO0UnFazGqS8TLUJik6rypA8vyzsEx2b4I0hrRwwO4SVE7x93+G8Gso/niykfEwVHHinifCSS3+U/qFb7iMeqiRa/ehURm4aLb9Hk8JCw58hsh7nqxlAqFjAYPtOUB88iHvZ8t+lmy0tJSmu1F8harDmBLxwIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DyKeY+FE; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHUoBcOeM8MzwOo0xZ+lNpgK7RXhXNGvkEx6eGmFNWuba3Ub75rW8B2/HcmpxE+uDgd8IvaEO/P111fKZy9fJmquf4lMvVlTaVe6M+Ga5mljPDqb1jfYesUbwbNslM8ZbtGSV3CXniQAZOk+jesU3qJPUZKK8AIICjUdpBE1xF6AB5KN/nxkMmXghVJ9+/cw7hKzroNVHQ0E3h1ayU6xeThy/8Z3v6rKUC3ncPq5JDfE0bpGo8zjvy44nRhspy6Vn0INyVQmc12AkgWXymiJ79aMlVm8WD323yWAvm9jM/Ke9OwcorEK1wu7XFk7aIWzkc/lSDFXCl/yZTm/42GKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCm6LmCrNsnlSpfv+Me9BbXRYUqOrZ4U0ixXlRXT6Xo=;
 b=hDF5j0Te4awLX6Oyiyzv3OzlY+iLQopGeXtksa4LFf3BT989YiHSCt8AwAtsbgSzkClDxinBBmCqGUwhqZOE9eFbDawE+HayCfGGhC6DOL6eBBbxpOW7/nY1oVnEYIa9f0/XGjEohBYryREuNUe/+GEVbR4lu+fXVrmcTO1Iem1KqIJA8M32F7+StrNCRmKXd9ZOPxnnCiyoksjfAqVc+wQ4fUQkswC4g/fBPg11nJPkhkB/iJD/Pm3MJd6TFoyagz6Qm+Y1yWFsuI4A/dw34DIHRKZyaC9AZYccSsLlFYf/WpqsMFTBTuBrsyNKBjdpqe2p8eHwMem5MXhfIiEN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCm6LmCrNsnlSpfv+Me9BbXRYUqOrZ4U0ixXlRXT6Xo=;
 b=DyKeY+FEHRsp0wbBF/SSTdekrUQZlzKI4yxoQBE94AiB0XG56rttXQzJwn1Mk70k0fI34zC6rvLnx54ppOGaQyUFdZr3a/Zyq6cCOHkd7dbKF+X0xHbbUccamlNbtvV1tPLpDpQgjLa81ptRjlLbTvPm0h/6Z0mu9sawAdTUsiYhqdJMNMHDOuZQ3II45JYs/My+cjEEbx5FeHvp9t12csgADXYs136BWYCBhNsexIySrB0PydH/CP7iYgwLZvORley4WU0w72PbZvpnV6ibUR3CFmy1wpilrp0u40QhdJl1cRvFq6afCOyrBVoyxRVxGrCLFE5zNpDb0QHRv30vhQ==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 07:19:01 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Mon, 8 Jun 2026
 07:19:01 +0000
Date: Mon, 8 Jun 2026 15:19:16 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it, wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de, ulf.hansson@linaro.org
Subject: Re: [PATCH v12 00/22] wifi: nxpwifi: create nxpwifi to support
Message-ID: <aiZs9CCl3tBv9ZrJ@nxpwireless-Inspiron-14-Plus-7440>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
 <dea3dc8bee50dd5eaa1327fb8ea83658f73d323d.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea3dc8bee50dd5eaa1327fb8ea83658f73d323d.camel@sipsolutions.net>
X-ClientProxiedBy: MA5P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::7) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: e7361678-3f38-4ae9-d1d5-08dec52e3684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|22082099003|18002099003|38350700014|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	UzpSpbu7FiVOYrhDlSdrbH961lRH4zUO6JAVWqc0F3vbz9wyU7auNs5OUo9TJXmCTR71Mmzu75hcQVlMZoabvPzSVFh6c+ALuEderUeUBgYZaVPKhxKv/yjTdD+aldrYvkXveksugqivos+vmVlH9yPe11Iyd+rZCwoXl5ACjFNfF+8CCFuMMSyZ9n5LkPYcPACM43rwOZclC1Xup9GIunryAawOKu+fJuWbFVOpBwgTK8rDLinYUkrvXLxT8gBR8d1cIqwCn+6zIXnBkUWJJ0Bo2YfA0rlOVOeupWBweMdhvKuJgnXsfDWGKktuAoSWhNuI830JjJJShI6qC/dFmrDycbbqphCOBoOQO2V1toJ4D4soX/jvBUxbBhS9PERQNqA8rQxdQ3rGFyKCZdiElpHNa2feS6oYyp8neQIyPY6tL7zUScpuxfpWag3nSuQq0A1Qv61XO7JxC5x8NXz6Je/v7NJ7WKFYvnMqgH0ycGlq63nowU1g7fuQKV4GEPYVbfgS/B3eu9mO+NDvnbVv0Z61P7bREsujIxgby/HI07F8CQdI5vugwUZDxmrgCo6DmJYszWW8E8mtnBgidLFryvss0hhju3rrX7655gnbQNxZMpS7SufQTin8NbA/FBoizDG3v+Jt1OYUTkho9l3c2fVRgmsdl/J1drhFxzqPVSO2mzFp+4y0+PzbGCx4rN9ZrNRRaMdGPhn7c26ijZdd50xGcx6zL8VWhTlIG2BvF6uKPCS0iiKYkl6EqEI+9DCz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+piCWM0QFnzqsT/VGiASPHQoJLrvAmeD8AQLWO0dYHYu5JTiyrWuIz1mbdl?=
 =?us-ascii?Q?87xsbEePHiRKZC9MhCPTJuwSnerM8AaqN7O/wXNyJ3v+bMSW0g2s7oHcSLkl?=
 =?us-ascii?Q?SSSIp1+eNkkb0nRaZ4pckou1xMfLlMKmbbRNR0wLqPiA9yhyveSBW6HfKSNc?=
 =?us-ascii?Q?/rKfG9vcl2z++CNPtngvbus2jXzsdbsCLHbvNTYrbe/XAJOSxTRqyPDm9Ply?=
 =?us-ascii?Q?HAcXhOasS2KdJyvlKV8TipEbpjYNQnKd5ww1FC0kUKs1pc6MNThkiME77Zs/?=
 =?us-ascii?Q?sUV/GtdIn3F0G7bYPl9vnTnVIzmMvU6xQRVPwQvLDi8qppKOSMAGeKn80pl/?=
 =?us-ascii?Q?vTmkQGwyBDTibtLDQhlJMOAwxQ1im1FF1fCSVRpKeABnKhMeg7OpgTTAmaox?=
 =?us-ascii?Q?Y/B496FVDQReq3tfNIp1VYcI32YcB6j5uAAEqsgwl+SY7f/ph75FQHXOySXj?=
 =?us-ascii?Q?9L3TW0VQkkZ25nDOeaqFo/CjqNsS1xmAEjBUV2qoMC/uKx5ikSkHZQOmb6gJ?=
 =?us-ascii?Q?PWbWp4vxqj8Hq1FmHtkIjgBRcyZR4OUSRGiCmHdnPyb48PcwP1GxkTYiQqTQ?=
 =?us-ascii?Q?9DL7SjdM5yOsujcXy2MjZeKpz6rxCPihOogM79Uwz7iB4mk9V+wYir583vaW?=
 =?us-ascii?Q?XK1JI/iEkErel7mH7Max10cvse3f9RGxk8Kaydp+xcm9q5KEKAF4qEbzR49U?=
 =?us-ascii?Q?RtW0WlQnqzUEInvFSrTIvFpsksKOQiXlYCP0/IWmhvklbxvSjQ2+r75i9V7z?=
 =?us-ascii?Q?6DUONk8qjqIfOaph5UuzZoqxC+q6n3XsY+siGMLVHwMKU1zhc40BAYpRteu2?=
 =?us-ascii?Q?wWS7V1gtjB8/bNVqagq4BfS7TlpDYwJhMdzznhVWAN6v44H9eOsZnIGtZ9yw?=
 =?us-ascii?Q?zAeWJmQExEaIWYsZTEajCzDriAJ20t6r5PqN58930uh113vglO1H1l6MyJre?=
 =?us-ascii?Q?wQTubO6WVFD2PrxO52H7Tmcgf0gCAbsfE/QEqmdzxYbZIGoFDg/zAOfa8eAu?=
 =?us-ascii?Q?aCS+p4/bMljP4lo3KDtBh8+VORRL36yp1xh2A0aV9SwIy6aRLCXohYmvXVSu?=
 =?us-ascii?Q?Ph0utZwQZfQDVVzN4ZxQOyjdfUg4f2HcXQmIBZIxLHfkvnf9j1odzfdq1f+K?=
 =?us-ascii?Q?sCa75QnsOjO0IHDQju5JnUdNgk7L0rLToqrEa9pzxEBdIioBjEWGePdgFfPn?=
 =?us-ascii?Q?0l5k/0nnwuQBL2dO+qHnWXFkvphQmP3Nnyyf6dk251XhrVs3fOcoZI6rnBDm?=
 =?us-ascii?Q?8rVsFr1ScAItnerelyzX/RobBXlBZtI5kWSkT74WB3luJx39BpbxT22qQl0F?=
 =?us-ascii?Q?XceDn4Tl07r8q9hzCLOs6Px5y6vzBS7IU+a0Ym4XnT02Dp8uTX4pk/qmQzqo?=
 =?us-ascii?Q?BKCQDwpJA1KSlY+yTkzwPV7f5Nekug7c/JadZjTvrBF6t/QPlKmNKkgZrgsB?=
 =?us-ascii?Q?59tOa/1nw9m9lDVKS825zbn97IW2u3QHsiUFTtkiOH9jmckLyUGWEU9bG3Mb?=
 =?us-ascii?Q?IAc/tqdt6PpA4aXQPlFR6GtFUV+BR9m/CkMRAFFCGAm+YfSQhnvGxbdpJFWK?=
 =?us-ascii?Q?26nqQaVVYa24qTG+HvWLAIjgv8u2N+bRe2yYkjnLiQRXRuTQLSR7tQex9p56?=
 =?us-ascii?Q?LJKWeXHo9j0WpKdou9iuPhuRwjMSt4snBR+LsHx9RdJfAfHFS+i/nkSUdWML?=
 =?us-ascii?Q?HS70LI/Myz1cMzaoNlckwfgmGNX1VGToXgPjulooMM38B6fVOLH9hY5RV5vs?=
 =?us-ascii?Q?qwo9o5xYnA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7361678-3f38-4ae9-d1d5-08dec52e3684
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:19:01.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFeGM22bFEbzHmpvjVcG7R2IuVrrm///2+J5stXqgkfve8XIdJ0DHxkTdYknnkk4XkkUKEcDMOEchWmKn+Fsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37488-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:from_mime,nxp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B92C5653778

On Mon, Jun 08, 2026 at 08:39:24 AM +0200, Johannes Berg wrote:
> On Sat, 2026-06-06 at 00:13 +0800, Jeff Chen wrote:
> > 
> > Firmware binaries can be obtained from:
> > https://github.com/nxp-imx/imx-firmware/tree/lf-6.12.34_2.1.0/nxp/FwImage_IW612_SD/
> 
> Are you going to send this for inclusion in linux-firmware with an
> appropriate (redistributable) license? I'm not entirely convinced that
> the license (that appears to be attached to) the repository is really
> one that could be used there?
> 
> johannes
>

Yes, we are preparing a submission of the firmware to the linux-firmware
repository with an appropriate redistributable license.

Thanks for pointing this out.

Jeff

