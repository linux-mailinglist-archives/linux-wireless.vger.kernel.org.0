Return-Path: <linux-wireless+bounces-34227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPnmBGUZzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1397370481
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79B233031DDA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31887390230;
	Tue, 31 Mar 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="j55B7xU4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012050.outbound.protection.outlook.com [52.103.35.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D8317158
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983515; cv=fail; b=ZHB29VRlezfOlVAmpgyHbDS4ArWVEajk8zXcnY+Y3WAPb5yNXD0N58RnVbhygeTrE2bnzUJ6Ntc/kylcpTGEQJUayi+TFK4z3teVqKs7hXgSqM0lny4M9XO6j9yqwANiHG1aAjvDccdb/XWSqUhOgfsWD+u0sZJ5qodVEynhp0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983515; c=relaxed/simple;
	bh=NqnAaaS4aj3jTkkJ4Q5DtI8zAVAArPhX5B6jAPgRNmE=;
	h=Date:Message-ID:From:To:CC:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/dXkLnrwwAy8nsUbkyrUtVDUTjBukWpErOkOo9NvF9G9f0ZBVTuMqtcGf+DLCj79GXIBmWMsn9kj7CXq0Xor2nNPHyb5opUmS6kCQzCDjA9frDb1fDFP0ud8wgX2b06YgTZI8P6bHCOk5Pk0LvGxBQiqolZqufTpIA2HaslI8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=j55B7xU4; arc=fail smtp.client-ip=52.103.35.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvvAoLmIqqssnCicV+VX4u7xN61PqtzR9i4bL++x29yMUFKpXZnyaCcMSCr1INRh85QgFYPQJVzZUlJZ/2OSMvjiu0FrgIKkLGJKrbvdN9MIF9xlYeHcpbqKltqOWdxmvJQpjzlScjxk+L6fwn9fFac22NUzFHAECHTY76GsHj2DFtKt5wq9Eqqp/zc+M9h6AHZpjsK8Z1sKcb7GD4CHBlA7Lk17cz4IkiMovSMwm6UtghOizZEtTz3lT4hLC1NTDog7n1Wu0yE80nvVOPYQrRbkuUDPYq822tOaYrbAhkaUXZvifEMm85iNyUwWHRvf6HRgvPlwnnaJyYHdN0YZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA5L22S0hgiZHC4sokPCiKj+WzNtrWtXAtIOotC1/4w=;
 b=mG/KhdWodDMX9ClwBbgsX+o0NZwfvJcyAl9p+BYVAzE/3vWUWCCCaYfn3B95oeGIpMYl6vInADBXqnGCIva5IQBox7DJruF+foa6For4AhoBYw5h7/OMKoSgHLlNoiDzCNsXpih/0EY3wkRwy7UX/xd4nLY85VglUNAE1iEjcdTfKyW7PEgiQCki6hyEwQlhZDwgaaApCFCq6Diz4++DEe0Ll+nr2/oO4C7cRO9zcmzRfCgKG8X3LfPql0gaOBgFpPzsiGNwMAuR96rGIupr12PhA6upiBs29kcF4EV5cMRvkipEw9JV2s/D2sda4uYVoK4lLS/VsTI4u5X21EGbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA5L22S0hgiZHC4sokPCiKj+WzNtrWtXAtIOotC1/4w=;
 b=j55B7xU4rWNhI7mavRR2CvcKsPBSK7Sx2xKKYXy0ec1BXbBGK7sQIgBLvF+7AuogZdXZf+iiT1L4faC4KjlASRciI9l6fqbGIE4NQ1Ftr/929StmYRMtkujAYUa+E+KLYTerRjB40sD0whZUXKApmGkikyap1IYvELv7stsU4TqWOa+RC+K+VKsYMc7oiOInf3VUr8rUhvDPGI+fTA/m/Jv9E5avW6lEb/8YeJ13MnDmuXPKv2ZrhPtg/2k5BDSh18E1lZvsmnrBnn/G200PaQZKGxS9Y/+3NOtbauEHSIJw43OLUiB2yRfjgqq+mmVX28lfZvzRlsiwfbSF8HsyIg==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0978.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 18:58:30 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:58:30 +0000
Date: Tue, 31 Mar 2026 20:58:29 +0200
Message-ID:
 <GVYP280MB15188B2C812AFD34DFCB16FC9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@gmail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 08/10] carl9170: phy: enable antenna diversity for 2-chain devices
In-Reply-To: <46d3a248-bc59-4c60-85ba-88d80afa8dc3@gmail.com>
References: <AM7PPF5613FA0B6344DB5885359FAFC80D69444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM> <46d3a248-bc59-4c60-85ba-88d80afa8dc3@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <0ff3485ffcd5ddc342ff1567a5484c5a@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 07404833-ff60-473d-2d54-08de8f577ffa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|461199028|8060799015|15080799012|51005399006|5072599009|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	yUuv5s9D8mA22pwy/N2eJNNX2odIFUd1/v2rkUQc0AGH7DWgE479VoxW6FsOGRIRqTRvFnLCYJUR5q0qpiN73VkTPVdnA1DaSN6bo8fYp4qO+IOi43TLO1w0pn+OMqLpzG14zb4F4Wj63qQ8kHgCglRWwOLsXNX0MP5IyhrrkPpNGP0RY/NFhmVZArgbYr72E7QRTJdPBfCIjsIflcAOcjdE7ft/vqIMpTvPvheLcinv3WuMHSOZoRC/yVNgrWsPgdd9zFeFZjYSgkw+I1FRjlrtLk7a3vHbB+zTU2ZMUCM+jIrL7a7GH4OjdYiO8moAtkFmSGaSGc+PD5pDx+urix6+/YB1KF1uLw0kbLx9oPwy7KAZ+L8uIWdp23AmkZ5mXcPgyYGL1B0t+GBFeri9P+FkMDmI5v9JwEip2N70knllxcRZHwYlzi/BRJXPyHAzfnBcW/kVBC8vhW3q0IM5UNOfWNWtoBmu7PbWF95fWnfDePW7z7jY1qffhFK7DelfcSd0eesoYipDLtVgC43SKVRD197AXIJTqgEM7TJtEq7ognlXKbW4uh3b9VOfeM/G+cj3LPbIvE4n9S7xVKuWE9OyDTJM3Pg78SvHCPxQdZjT0QbmE2n7scFA6Gy4dCPSQPwhFVj1Awp2sSqDftpBlwwpvyh4DVs07pWZGhOfij7EAMhH2susyWBslk80jY/qOEK2YN04wxNUB8i2SqKSdTBGtPJcFd8/Xk6jkOx2P0B58PgnTwFEWuP9Pwxymxap2k7ojnLCqr6Bxx1Ijk1mUCT+N6rjb1ytuL48+eogPwg5ee3Td9K6CNFWMH2AL5DXP/ZCSuc3jlm0U+48Eg6BSC6ipfoO0WcxfbRit4kXFbUTJSvvxYtZQFU/J16dpQ32K42HDC3Vj4dKZtx09buBk8qxiXj6mFQyT+sSpi9RbWSJ5nV5MrKoxmkuKdPoZq1s
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dC4u8adXn8+a+2lqZc78D6UQ2hbMKcBemlVcNKIgZuccrKxoHNwZkpTXl18B?=
 =?us-ascii?Q?8TAUVicd5DK6WoUA0rzdKSQAbI5OulhIPEmHLFiGtEZYTSReQPLXNRZaUIv2?=
 =?us-ascii?Q?bBNuGl6XOnokahaXgnmgWkNYjtfzncnaUJrtYn3BGQ7C9t9wDuTN28QbbJZ5?=
 =?us-ascii?Q?cG+3a0JhHsVlExuaMRYmgWydO2Ls8BB2DdZVMkfFkKRfQUnYy4sM3lvflWGJ?=
 =?us-ascii?Q?2jFi3OCB9viRaFBEENZ7ayhDwPDrUQCQjXO+4eAAc2xwac822crb84I2LXzH?=
 =?us-ascii?Q?WTDmyb53J6q+gZCSG2oSZoGPoGwSDYMFrdLsVDEyI7DV/CqFBRZh9wGOEbCB?=
 =?us-ascii?Q?4hXj9HLxKPGDzWT2rzDj3zULu0DChb52WVqSZ+TY3BI78Sj7z/UAE2Nm0YkG?=
 =?us-ascii?Q?bMGGvoYm6ICq0T+61x5lC2sK1XlvqfOA7TxttUlmouyHmLMtzZHY+psuf4P5?=
 =?us-ascii?Q?UEi5PoXJPqzLT9El4tLxvTi8cVDLlI9v2GleZ7hf2VprljeypQ4VIzr2bU9L?=
 =?us-ascii?Q?Ht5Ad8vWN6rtYOCDqKoJwQtuT2bY8NYcjRONALC9e9WLD6qAck2yW1kjZcpV?=
 =?us-ascii?Q?BdyPle5aEjSnJhkwdzfL/do55gu1ioth55dNkjiqZoHY1O6BXNeXVhcF7lz1?=
 =?us-ascii?Q?BXNrpWUarGVYdfAtDdc19+rjGWz07K0E2NVBGmGyNW4HeEI94N2nZzwcOW8K?=
 =?us-ascii?Q?SrWkj6G1wTjUXb8bABqNMWE3aKa6MFhiXTtvOA8KZIvVdAz7STQxH5nh6q+u?=
 =?us-ascii?Q?5PGoaOyRpmj8tOviyAhO8eDH1ztuaLMegM8vQrsY8b1jpCnlbEIL/x/fU62w?=
 =?us-ascii?Q?9m+02M9m4/hxmmNKtzVP/UKipQJW3brmdKDj++pAfwIM9+0t4Q9bJhRpWv7A?=
 =?us-ascii?Q?660jfeBXzl1euURCpC2326KizW0ZFf+eOdy2pAwBRhJg7s/pvOvQxAWFqGd9?=
 =?us-ascii?Q?E7QwOPqUfsvH6TVVBevftBV2s/IRY0LyutELwu6v2C5pxMCiRuRqNQvdlH3U?=
 =?us-ascii?Q?qWDp9ljzCkoOb8PdsrgezGxTKCz9FTMdcxMstDjOb+/xl7FJNeOdqBL+GKTD?=
 =?us-ascii?Q?uO+vHeXvwy5z11e38HwRYhyk1YBQ0zitX3rn6sRLdfy/ehCfbyj4+i8mzek/?=
 =?us-ascii?Q?GelXxO28IVFviR9sq7h6bICJ/tSPYkZtqBW0VCXRsBU9A6QRNFm311n/9+Kk?=
 =?us-ascii?Q?vtiLshgcDsRHjmlv3zjuNemXhIXEjQyJoEiFtyjmHoXTdTPHdehGvOVE08l0?=
 =?us-ascii?Q?9XdfBodpJ/uGF2EFi96kxsO8QIRlUl+nx4DAowCP5Z1cqCS1BiQODRd1sxrS?=
 =?us-ascii?Q?6he+LuO08179567IZj3I31aQaZC9DXRjX7q3B8IQEIlrRVaJgCDqpzCQ3Sx4?=
 =?us-ascii?Q?PXaU+wP/Icvy5uSKP01D2rX9kCSX?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 07404833-ff60-473d-2d54-08de8f577ffa
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:58:30.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0978
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
	TAGGED_FROM(0.00)[bounces-34227-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: C1397370481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 8:53 PM, Christian Lamparter wrote:
> Oh, no. It does program them! It's part of the ar5416_phy_init array
> in phy.c.
>
> So. From what I remember, this was the reason why I copied the
> definitions over from the ath9k driver to carl9170. Because this
> register must be important if they are part of the init values. But I
> don't know if these definitions are the same for AR9170 and AR9285.
> That's why the AR9285 is there.
>
> As for ar5416_phy_init values. They came from the original OTUS driver.

You are right that ar5416_phy_init[] programs MULTICHAIN_GAIN_CTL as
part of the register init sequence in carl9170_init_phy().

The patch does not duplicate that. Here is the call order in
carl9170_set_channel():

  carl9170_init_phy()                  ← runs ar5416_phy_init[] loop
    └─ writes initial MULTICHAIN_GAIN_CTL value from OTUS defaults
  carl9170_init_phy_from_eeprom()      ← our patch adds code here
    └─ calls carl9170_def_val(AR9170_PHY_REG_MULTICHAIN_GAIN_CTL)
       to read back the same OTUS default, then ORs in the diversity
       control bits and writes the combined value

So the diversity configuration is layered on top of the existing init
value, not replacing it. The relevant bits we set (ANT_DIV_CTL,
ALT_LNACONF, MAIN_LNACONF, ALT_GAINTB, MAIN_GAINTB,
BB_ENABLE_ANT_FAST_DIV) are not set in the ar5416_phy_init[] defaults
— the OTUS values leave them at zero.

You raise a fair point about whether the AR9285 LNA definitions map
correctly to the AR9170 RF frontend. I used the AR9285 values because
the OTUS driver is the only reference we have for AR9170-specific
register programming, and the antenna diversity block appears to share
the same register layout. The improvement is measurable on our
Fritz!WLAN N hardware (stronger signal in multipath environments with
the patch applied), but I cannot guarantee this holds for all AR9170
variants.

If you prefer, I can add a Kconfig option or a module_parameter to make
this opt-in, similar to your suggestion for the SGI patch.

-- 
Regards,
Masi Osmani

