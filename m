Return-Path: <linux-wireless+bounces-37811-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czP+BfTGL2oRGQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37811-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:33:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E468514D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=CZzUbEFA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37811-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37811-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8099C3017F81
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FB339705;
	Mon, 15 Jun 2026 09:33:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232682F7F0F;
	Mon, 15 Jun 2026 09:33:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516015; cv=fail; b=ldVw5Eqz0tJs8vYn5DJmeM45olAgzTv6XWdaN4waAISR4RyZltZrDlPj0g4fg+n/BtMXQslc8a8pyVk+YIQVnjdn+lAK7IYeEW8UAOf+37rvUxKlEZ0Wys04nDWMTUBURVtzMaXTeLA+YwOb7nyM98fYZ2B+4XDX/W2dhUQmv8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516015; c=relaxed/simple;
	bh=f2ri0jhIQgS+rtRP24hP6lx8Bx1/dZs3yAEdkhyW5WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PhMGs6ebG9ZcMzz2z8JdnpmSfyQO45YpoZav4GrD0S2BIA8Q2WkBI+154W9yCENHiRLGrLYvqriFeCSU8hJpMi7+BNmpX2oY7o7S9VcyDcDebrwDVRqimuGVEY+5GaRYkAchCgSsG6bMigkJt38NlSnPw8/21CoWAFYZDTsSHqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CZzUbEFA; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1KfLBkyImQDzzQRVhEgfpoHmvLISaiqUmQ7pMMvCEuiJuAgiXEHGk5lDfNbqEdTtOcA6CoBpFqcfxavfzZ0P5y5N76x/C/efUi6dpbSAPQ+r7YjLErPMzo6Lr4B0UVqsIT6bdUR+CkoaqIE6zBygPElp9uFkAnkYpnGYVv3jcpztXkdu57B/5biNe8tqqK1B6Sk1UIzSbav58+/tZMuOFYECmAXZ2Sf9kZsCVJt2dbK3mEdbFq2xTHf7CG2nVlJMHmYpK6b7A/sleUCPY0EviZRgThbJP5iaiK6XOPCl/qH57A9WcYQkkiUrav6c2gmIuae4vCA0q1LRu2HTk2mDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDYXYf/z16PXp1dK8DmXw1iqVbHdAUD8BgWwfZZ7vOQ=;
 b=jd9XhH8dKQFrtJ2gjTjvc1Dfm0kMlRsnaKYqDUxbFvGcfHBHgPl150c1mMtbLVZKMA6+zPRrQ2+2FCTHxt4FCIQhdMzgZ3gpDgzo+XbMzWsRcQIe9QCnBaqoLE1iu/bnoBWG7IuLvh7bupWIUv982B8mtd3o6z5WbVYgN48/vK/wjjAe3RquIhmPIH6cst21AnaLlJ88KcSldmy1MGVcT0DJuIRcrOy8yQJJRy7U4P3zIcXB4Yo5xnbPi08R48WHuY0J1j+BpaAEK6SadV6asA5vzglKjYQjDb0CDcRQAZZEKsMLEIm8sZjvcPtBZLucbu0fPn82yZHlyi0EARk7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDYXYf/z16PXp1dK8DmXw1iqVbHdAUD8BgWwfZZ7vOQ=;
 b=CZzUbEFArgSCsH8v9nHk1pecm0RtWEF+XCewIiQ+etTBxmF9M/NNMn4d3XKEa1axp3rEglKbd5Ghrn+4/LK5GkS5Xf1OOZ4b1RjCRFaTgApQENl/VIU2qPHZ0rXmMb7C1BB5zMxMHY4Ffq+jBvtctyacvrPmupIO+KER1Z3JGTSJaWmCc/9mZ60WzsDpyE3gTgHqV3hmhp3LrZ22/c9d7TRB2XCgcr+0fVXHL2A0c5LRDMLCB0ECAFb4tdOoQj2scf87BePU4EFq26EYQUpJzcYC2W/BJzqu4E2DskldVxvScE7GK18vNiOj0ygCk/ZtOHiO+N9BXa7chhRA04tWdw==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:33:30 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:33:30 +0000
Date: Mon, 15 Jun 2026 17:33:48 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rafael Beims <rafael@beims.me>, Brian Norris <briannorris@chromium.org>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next v1] wifi: mwifiex: fix permanently busy
 scans after multiple roam iterations
Message-ID: <ai/G/C7VxxzDVWXW@nxpwireless-Inspiron-14-Plus-7440>
References: <20260612122547.1586872-2-rafael@beims.me>
 <20260612130607.GA7651@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612130607.GA7651@francesco-nb>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|DU2PR04MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6769a3-db24-4877-875f-08decac1292d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|23010399003|376014|18002099003|22082099003|38350700014|56012099006|4143699003|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
 8kGuLamBirVw+qk4PBeGMyFQX4CFLmt6VAoRvkGz6Mdw/gEU8pJ1DpVAHz8Qm76YcU4VN7f92rO4QgKfoA2kXFzJVwGmAKsaAJ7Os86D+D4C35U5SWnskes1ktsa9tL9rsoybgc/XFQa7dWSLN3llqHePMIfmUkOLcMEWdaltssShLdC2Vg+sM2WQqc129pCROE0wjBXCqi1CIWyw65eYOwCHWAWgec1J9Cmg3ZZDX9u/y8l85GinN+joDv8EUhCXNRiq1W0gv5EY7QbvLmrQ/ZTH9s99qFrrlkT9WvKSAkwyl0Ee0EHNCI33LiTr9Vmlk3UblyA2cLBnR2ZaP1OzESSEHeOKRF2/MRaQFW5Wl9kOHovdMFwyv4YnEla7SGHUQaIxOn6Vpa7OBR9aGGnJaDRzM/nX6XNn3vPUM6GLlEiQDgATjUNiZ+Cp2k/KOwCHrAB+Fvp0VDWWXdo8OrM0wKzlfiMMxpYm8hAHbIppqMVBAXbD5VlxGfo+Or6PpjSNdGgY9Ei1z45QvVa+DrzwsA4AvHwqfr4gdaugvHU+lHHlKtO5qZS1OmBC5jU0IgIsZNenEIgXx5y//0vgrzv1tEw+OfaGEHDMSn8svFlGqdLj6JbnPLMDG4JiUee0sbq6BZckeXyJ9ikd2IyO9lOBBVi+ibZ60df7MS+gPC63djuwgoSbgGvhyqpSlFrUOTkBxZwTuABWloZX4fk32QB708vaTdmEPZ2S/ng4aYiJXpxQnLfuET3M55jao6E+MC4
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(23010399003)(376014)(18002099003)(22082099003)(38350700014)(56012099006)(4143699003)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NSZpWgTcpe1KVC4MYZlnHF7ZC91NeTWQrF+3zXTvZRHeDo6raZdAoODnhhLD?=
 =?us-ascii?Q?X7X3Xk+eXe6lxBwq30ctO5b06hcz3wStiS2GMvAX9e69LgasTaCBVyq+i6Io?=
 =?us-ascii?Q?kqzq33wLk/9yHR+g95zU2Cj5KKeWpMjHHczE0yl+64t1jlWpqyQ4VJ8TFzrJ?=
 =?us-ascii?Q?bTgRQJmf863epqo1SwttxdZr3JyupdKf4FkFqBL3g2HcpFBLkWzZbK8kU6e/?=
 =?us-ascii?Q?xC2O1eURzQDQ6b7hvZOq5oTDI+U6hQZChNXtjeTFUsiJ69idFveJe0yXx5Fd?=
 =?us-ascii?Q?K8ZRYg+EV25c8SRCPd/RQtBEGjtqAMYiKYdY0wwOqc2YCLDj88lYms4wUTj4?=
 =?us-ascii?Q?qZqw4kbJVeLhHHmKqCwveG+mlO9ixEbXxSI1LDJw+CBYpl/XjkUnNVeq3KHf?=
 =?us-ascii?Q?ffEIBfEi5iEuV6BcCX6kfR3F6kMvq/Y9V+NoYwV2/cL1S/0VwWRTG9tso/YS?=
 =?us-ascii?Q?8rffMml5BCf4uOHVToBgBily9ouXl0pAa6KR5dCe1hFi2eoPkQx43rxNBW8C?=
 =?us-ascii?Q?DKOG+r5OZHdCxinv184xadosevuSQvnzG7OCjXPxzBhfR78psZnL7j8ftP0H?=
 =?us-ascii?Q?sYaiaOwRk7EgptLhA2dZcZfFuOwaLgpLP6SVAB4zLuKfQ/vnrlJZNIeEIe9v?=
 =?us-ascii?Q?brvkpx9D2WgWViCzgcUNaGiyO0Mtp/ehwMmxzeQmQ+Pn78+qrLRAn7CIA3uN?=
 =?us-ascii?Q?EKqj15w7aO9+ul4wtTVx9Ykmwt5WqG8dqvVTVS3NnXvyxMWLWUbv5AUDsS5m?=
 =?us-ascii?Q?oMY9N8YO3Yfw227v8D/0mo2gUQL6jWRjYJeyjNGW0iWH8cAfoYZlLzWO+67t?=
 =?us-ascii?Q?oXTYAGcujWpPCcgFo0lVu0E0zlk26NLFHxoWmnPgXyeS4f2AxLyBHaypReRh?=
 =?us-ascii?Q?iGch/vbMPsY0j0r7+9aUyHHvil5Ehf05n/yxxlfVEli29u8r/4turmyt+n76?=
 =?us-ascii?Q?V+OHDUKuuZhlpwV6TYOI9LORb6vEZnQjBqkErWd/+KhSBo8F45ebf4wM7WCS?=
 =?us-ascii?Q?dF2CKq5cCNNMjuv8LgPnrTrJ1joDgbvchpqYiqkDTW7trb/64QnWQ3AYTwcU?=
 =?us-ascii?Q?3acpreistADbbXgQa8jIJuLS2zijJ09y79TYg422S6sW283DhkKdNKxP7SAJ?=
 =?us-ascii?Q?wGNsGGms3qBpI89BVjrEFUAaMJ2WHZziA0VdNIQuVXFDvUd5SFxQ3/tObLoz?=
 =?us-ascii?Q?Sfz/EFQZU8z13loTZ5H/2CI7TDmC71zM+yb8clPNhK0L4F0N2h8qYbtQfL/I?=
 =?us-ascii?Q?/9vEtbgsUUgb6GXcHhzDDC4MREZYPejB//A8yuJgak6E8F4bzTVijco6d5PB?=
 =?us-ascii?Q?V8oUrMsJUXGzz+wHw41J0L+IXPuXtpGkU6dWHsO/l7d4CxjXfpv5ooZvTolX?=
 =?us-ascii?Q?zldy66hLBbdRCLKLmB8XdXmWDiuMYrmRnhgkglUYLSqI++RiixQQO2y2dSTu?=
 =?us-ascii?Q?DUfWCKFmy2ajbThZVxVnNV7uNtkV17t1fp/8zM88rCp9n5kFVnUszvOt1s/1?=
 =?us-ascii?Q?CdBFK6Cmy0U6ujUvJtJIi72KsO15OSZZO1/4d3+3MvBQ6MHoY/TBVYc8ur6F?=
 =?us-ascii?Q?/C7kwlF0ve6M5h8UXoF/FUcJZpQPhm4a1tX02XJG+DeYAptRacGcSrZ8o1x5?=
 =?us-ascii?Q?IA3yvw03sM2bXD+zAEeZKqu0j8bFk8zGHLtUcc0yekDlIqfEOGHld82djFQa?=
 =?us-ascii?Q?Le77kwjf4rBrgPEUVC8TJ+Lm4D294Uj4QTb/haeL6fcGdV7Eb5/skGxTczVN?=
 =?us-ascii?Q?sKyTNlXrSA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6769a3-db24-4877-875f-08decac1292d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:33:30.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEwSyZ5cJaWVf5fY7BnJYPR4fY8AgH3trS4IEVGOr21Xwg+gvbwaOB5L8gasbY/oY/BxSYGpdZAHHpni9lj97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37811-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:francesco@dolcini.it,m:rafael@beims.me,m:briannorris@chromium.org,m:rafael.beims@toradex.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,toradex.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 774E468514D

On Fri, Jun 12, 2026 at 03:06:28 PM +0200, Francesco Dolcini wrote:
> On Fri, Jun 12, 2026 at 09:25:46AM -0300, Rafael Beims wrote:
> > From: Rafael Beims <rafael.beims@toradex.com>
> > 
> > In order for the firmware to sleep, the driver has to confirm a
> > previously received sleep request. The normal sequence of evets goes
> > like this:
> > EVENT_SLEEP -> adapter->ps_state = PS_STATE_PRE_SLEEP -> sleep-confirm
> > -> SLEEP -> EVENT_AWAKE -> AWAKE.
> > Before sending the sleep-confirm command, the driver must make sure
> > there are no commands either running or waiting to be completed.
> > 
> > mwifiex_ret_802_11_associate() unconditionally sets
> > ps_state = PS_STATE_AWAKE when it processes the association command
> > response, outside of the normal powersave management flow. If
> > EVENT_SLEEP arrives while the association command is in flight,
> > ps_state is PRE_SLEEP when the association command response is parsed,
> > and the forced AWAKE overwrites it. The deferred sleep-confirm is
> > never sent.
> 
> Brian / Jeff: I am not that familiar with this part of the code, it
> sounds correct to me (and I discussed it with Rafael before he did send
> the patch), maybe you can also have a look.
> 
> Jeff: same issue in the nxpwifi driver.
> 
> Francesco
> 

Hi Francesco,

Thanks for the heads up.

I looked into this for nxpwifi. The nxpwifi driver currently only
supports IW61x. Based on our analysis of the IW61x firmware source code,
the firmware stops the auto deep sleep idle timer upon receiving any host
command and restarts it only after the command response is sent,
preventing EVENT_SLEEP from being issued while the association command is
in flight. This means the race condition described in the patch should
not be triggered with IW61x.

Jeff

