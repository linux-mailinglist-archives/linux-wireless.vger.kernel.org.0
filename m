Return-Path: <linux-wireless+bounces-34230-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCzJKYwbzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34230-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6553705F9
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 321F330411C3
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925135DA60;
	Tue, 31 Mar 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="cU/uM21I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011034.outbound.protection.outlook.com [52.103.34.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E89223DE9
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983983; cv=fail; b=RLaIYgfMYow5u0xDhuOdwOx2j0uLRZIganRetBLUphZOVxvR1oKyhTP+PvjwiAGF01Z2EzvcydLgsWGwGeF4DQtYzpCormUJ6KpQtqEgxvNux+BH8WTkiQu3Kcvwd4hGzziv1IJvCSqUOa6LkDOkmvUwvRtyWXD+k1xLYoieXMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983983; c=relaxed/simple;
	bh=5nRkHkxbaTYyMZl5BxWD6dnytVEqfRCr8MA4FYV3Xjc=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2XkWpiJK0f3I38rD+LRYL3lh82h08xqjSFgcUk/ts8kA6bUbTTaDK5GeRZlD0by7h7Q4rOwzFJ0a1uFe9G9n9U0/xT50JOfvjsS04O1hIkbz54gnJjBd98I3B+D0Mw6BjyO4C9zRYXbkVaUCpJ3I4skYRdcIzo67cCxNax2JI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=cU/uM21I; arc=fail smtp.client-ip=52.103.34.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAa7kWqzbGRYQY7k/gV+OmR+NGSr20PzTmemCHST16eMZNenu5gbWWefD05BSl+TlvffJYxGBTY/TFlMS3FZT/pp4phprYcPRSYz3/03xeDqDkZ6sVL/JKgEjAy74psNdZZZPpXjeOTzmtcZBPqZOfRO6rdl6EA33tmAxch6M3rqiX9w8Iyx1VeS+mNtyuCuJcCoe9k9JOPVHnzh7TAXT2rLAxv+/K/2vPEbLQH/Vn3nuHnLV0vJkn0+V3LXRuaN3Dqq0aGWqQSA0ER3YLTwVxWHSviB+APW19mSWHhugiLsikbta2NfY3EmFkhT9QPZKfZv+fg39VYrtPo1OCbqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBS1FJ7RM1qAsrORYNGA+9PtLrxQLyso7F7B+x1DZbc=;
 b=YA5xladWZLs0uX+k8kR9Aa0GwRC+GU1JMkrI5skx9HD6J+nxgcdLqjuj6ycHeERfNhYTaNfR4iRI0e3CcAOcl0LJSpALdeBc36HKt/PfBUVTiSoUKwnx3jb3wtYpi/wahgcyEIjKNLhj60saZb00MUkOlguRe+iBY0r1iFP/cDtPNVavEgoqIE0E9bS6eJhCF67Y2HE933sx4HVmk0ZsiSqvWX3r1iq1xgAJBSo17IkwlJa1UbSDVo6SplYbdJSXg7b6FWeI6MDR61DhakR4jXz+7NmzIIUCNM6im0lYHn+eEk2HwW4I4lQQ67X5Pc4Q2+L0YKYkodj+KowD/loMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBS1FJ7RM1qAsrORYNGA+9PtLrxQLyso7F7B+x1DZbc=;
 b=cU/uM21IJim4BtjiI9ZM2TV3GtUL/tc1JNz3nQFyUPAMNigbtXOUKxVSOdTP3zmfVJsvNjDcaPR2aJsP5t0/lPgl9HbHYQlHt8VHNFGXOzlihiTqjN5Fm2cqvGxPu8TN9ye6Ew31XqoqcKam7Ri6x9QTE2ToYtcQ3XlxxNl7Jg9MjzW/Dt7FJhnrcSjrUjaELoFXPKLkOO1+avoqdtrW2uwdWXq5MUk35vp6/qjWFfWN75BR6euLSzFxBbHE0JmY3TmiP2oq4ME/zbgHI5XUobY0UbFfY8xr8mSnDOsXxLGJ1m4bHdUr6sOREM5gxEL86hiCRwx7l/3S4ha+BAKWpQ==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV5P280MB2028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:06:19 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:06:19 +0000
Date: Tue, 31 Mar 2026 21:06:17 +0200
Message-ID:
 <GVYP280MB15186FC27B872EE8DF0B46B09453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 01/10] carl9170: mac80211: enable Short Guard Interval for 20 MHz
In-Reply-To: <c5176f7e-6806-4c2f-a01e-8b30d0a965d3@gmail.com>
References: <AM7PPF5613FA0B662B9909BAEB554565F499444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <c5176f7e-6806-4c2f-a01e-8b30d0a965d3@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <1ebf98c2df1f9190d9da3fbe6b76cace@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV5P280MB2028:EE_
X-MS-Office365-Filtering-Correlation-Id: 556c648d-a1cc-420c-bb08-08de8f589719
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|12121999013|5072599009|23021999003|461199028|8060799015|19110799012|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9zKNuRZKmD1IBrDHOy16VL5JTA75m82zsOlfFgHvZoGcwf57GM5FMtYGmU4?=
 =?us-ascii?Q?4SbLOHjE8oqSdYupYRtLnRDSqmb+HcGCPu4QlZVYZVNIf+LswCx15XqpKMjh?=
 =?us-ascii?Q?SONM+AbuaD72AXXqXKCkQeAiucd+B0mNp8lw9oj+aetoTXaXaGgyBznJLEcr?=
 =?us-ascii?Q?htT3morQGcirOQ6MvNKuUjIs7mFAAWfvnSip22PW7G5p+We9c6bKqKJ98b+h?=
 =?us-ascii?Q?rS2rQKOM+04WuyZaUCD4fJ3TqRXfEESZ3OWW1i0mCL1Jtkgw5cxeJ69H3ZJ0?=
 =?us-ascii?Q?k2UN4khAk0t+ecW2Nv4tdvcJd6REwzxjDnbnejAVTK1xnOoiivU/uqkGfASt?=
 =?us-ascii?Q?ftDGsqXmGPlRWKM5wasu5SDQ/lVlb26d5Wb2q+a0nhtpV9di8A/FlYbkiKIz?=
 =?us-ascii?Q?4o77RSOQBbf2K/0Iv0xOkj2Z4IYsODKJDu/9JsSN8t47U4CA6C9hThLsZcVj?=
 =?us-ascii?Q?bxCIurHLsBNoKZbN3TGvb357MtAc0PiCmFq8jxezfoYOP+fAjzQTEBvLzIYM?=
 =?us-ascii?Q?YszespKstXDWAb+G37rR1aWjJTCrdXFxbg4QzvNxMkLzFnMuBdFtWndAS4ex?=
 =?us-ascii?Q?z36wO8MaSOBp9D6pnkHa61yTQSrVOlIZzQ0ATe4Kn4/0gEaH6EWN9eqDwNBW?=
 =?us-ascii?Q?fecro26/z0SMIe4jJfmJ3feBKvez1zzzH4DUHk7GlWVXhFpHOPl4tIk/HRdS?=
 =?us-ascii?Q?BY9/EX6kHLx+d50OMThi7mvmbSbXnCpfbkjnIM756VbUag1uM8t7RoWai07G?=
 =?us-ascii?Q?5FbieFVQVmBcQbICTIzd7Atq8c8TK5i+RbilkFLHUHBDyKTIXWiUm7+z759L?=
 =?us-ascii?Q?jtP62t/QFfijaXPbfTqSxYWIbg6q151UagCg4NVm/0rrkIPYjS1CUhq9hoZ7?=
 =?us-ascii?Q?0HMxq5aqNyfxfgSnRR+nPV4pwx9YpYZ1ZUdCx5rnN+RyNGyzZyA3sT73l8sZ?=
 =?us-ascii?Q?CMOtPDs0kbjYb7kkC3n4PF3lkX2wm321t7vrBjw6SGY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMpwFOsAuDHui1TgtDaxq2VV/H68FWn7R0drHX1mtrVNT0KmCXISQvyvT2jt?=
 =?us-ascii?Q?MPXnAxhT2SwFsB0WTxSmf2zikIQHZxLX+Rdg2wizmvJP/OWyJY5AuHr06sB4?=
 =?us-ascii?Q?JvN0xjBKZ8WrI0V1iwuCGpAgzVTgK40naS7KeLAcKQYk9myqxUCU6phYNFsY?=
 =?us-ascii?Q?USFEfWeV2/q5mGN6ByCKJMXO2kN4/f6O425HmGcLfF6qbzFavHzWS3gzzegA?=
 =?us-ascii?Q?j2QZgiEf4FkJbEJlCOdJUMS8g1f6LhiwkbNFDbppIeLDvUtpQp0Eih4Abf+u?=
 =?us-ascii?Q?/EoQmHh7NI8M45hoM0gIoKDhLFGwN9kWduXuecbPvmuO0eEh4U0yG8/ux5Xw?=
 =?us-ascii?Q?nQd0A+3P8ZUlYRFZdcsFp5SzyGCLGQh4CrNwmJPsxZHsO7w5mgPwJMQKAXV0?=
 =?us-ascii?Q?ag6SRIthugMj23tlQhSkar/VDlJ0ZGt1WS65I4iQKH4u6Ncmo1JdfXiW5+QS?=
 =?us-ascii?Q?gi+d5R7C6iJa95Js7TBOCGhgiiRHW3ux97d/CAzOnoUVx9Px3JvjY2bPeef8?=
 =?us-ascii?Q?UOfkY493YFQWYtH68aiO9I51aDzMYOzmRRaG/yV3xMwwvSQ7vht/YcNi9OlH?=
 =?us-ascii?Q?Wlu9mMyCDk3DITSXI1wvWS0YnYZHSB7TQPA007tC7ENCjnkpNiWoPAz8prkq?=
 =?us-ascii?Q?siYfOjnNhgURMLhun/p9M28o/lCuYyPdDPwUU2k8MXOoggIf+mEuIfDQLWQq?=
 =?us-ascii?Q?QF3nuMO0jZ7E8Rs5foBKr8Ns+CRWLH9rJHS8kO+rB447IOpfrHzMI8NvAqWV?=
 =?us-ascii?Q?9lU3Cy0W25ydKIDMmHht+ctsA5JqaayX62vzsJEc3ZBSjeARqRRW8KXeC1CO?=
 =?us-ascii?Q?wVx5tFI4tt1jUPDkvSPE4y8CerdeweUn9jL0TMYNx2OEtjWeExVOP9goLx2n?=
 =?us-ascii?Q?6s2rsRXgOvqzgC0i/6PmXVBmpy2ivlOK51gihLG3yG1JAmaapWvkfkn5rwMc?=
 =?us-ascii?Q?DWV40h1MKBtsxn4ZzwXMbXgxeSYS4hxp9KnrAKQXsrgOtLeU3R1ypisoLBcj?=
 =?us-ascii?Q?vlFdHUDsT6K0pwdLR5TgAnWtl52tfBwW0OcMo9oDtaG6Xhh1HeWT5ieNOeVs?=
 =?us-ascii?Q?YOrGqQ3nCbwKQ5kzelgzvMRGCb+qk8bLHrcVzXXhFJH8+l2DuWSIec0eqw3Z?=
 =?us-ascii?Q?mmFeXl5peVoWyykpXeyE599xPi8CcXeW9+nSZcR4ZhJYsMBM3W8Bk7I/75UI?=
 =?us-ascii?Q?v5G5ZWrWeee8HBRUgXXtCpg0G2wNH00WG1SB38CrK9cSfc4PCFlFy9EUFZtb?=
 =?us-ascii?Q?6sgvec/aqiiJ1X6S5ML8pIWBoVKgsrpkkDIMxE7quGA60JXdnXkcGaNAO6ov?=
 =?us-ascii?Q?TCrMhkljejd72zFZomGlPx2DmG2Yk4GmuNH5w4sImUKjFQcU61NYpbScXIhk?=
 =?us-ascii?Q?6r85CdAROXUZv1VAqK1PF2He7yT5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 556c648d-a1cc-420c-bb08-08de8f589719
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:06:19.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2028
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34230-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 4E6553705F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 7:41 PM, Christian Lamparter wrote:
> Are you really, really sure about that?
> [...]
> So based on that: No. I can't ACK that. The feature might work or not,
> but that commit message is wrong.
>
> That said, if you say have been successfully been using this and rewrite
> the commit message to not include wrong information and add a
> module_parameter like experimental that enables it, this would be OK!

You are correct — the ath9k SGI_20 gate is a MAC silicon revision check
(AR_SREV_9287_11_OR_LATER / AR_SREV_9271) that does not apply to the
AR9170, which uses a completely different ZyDAS MAC.  Referencing it in
the commit message was wrong.

Confirmed working on our hardware (Fritz!WLAN N, AR9170):

  iw phy phy0 info:
    Capabilities: 0x196e
      RX HT20 SGI
      RX HT40 SGI

RX HT20 SGI has been enabled in production on this device for several
weeks with zero stability issues.  The capability is negotiated
successfully with 802.11n APs and SGI frames are decoded without errors.

I will send a v2 with:
1. Commit message rewritten — no ath9k reference; evidence based on
   OTUS driver and observed hardware behaviour
2. module_param bool carl9170_enable_sgi_20 (default N) so users must
   explicitly opt in until broader hardware validation is done

-- 
Regards,
Masi Osmani

