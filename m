Return-Path: <linux-wireless+bounces-35284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cgAVBCml62mrPwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 19:15:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA6461BB1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B368B3020EB8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F53E1CEB;
	Fri, 24 Apr 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDQaIHry"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDB3E3C6B;
	Fri, 24 Apr 2026 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050640; cv=fail; b=SyOwnOwBzh0pxOQdP3CrjklSOma3+k1hAIfe6T/GsjYsziZi39shJB2hpZMlV5+C5WXF6azxv08gQLju4IdCh+tFX0LUnrBVcNTaER9+IIHZ0etNnTklXTmjC02tQ3bK7fbvcXVBVoQWqcCfdBI4EIx8mIQXEDz8OWkTg1TVW5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050640; c=relaxed/simple;
	bh=FeY9rp9KvvLyA2rwZSagBAgtriTz5KK05A40yzGERhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JpLwVr9o2Gyd1GOrMuOx7uH3+4qFPGrXM7GXpVW5/hJWLeVZWTzP+VUaRPHSpqaAQEaB6CGmmR4C/dPS7V0pSb8TGGBjRHUcmTQCj/4NacG5eSvQ03zSi/axpadJFGIODXvbdbUjN+kVUsk6oxJaPgIQvsTTNaU3Jctn7i6PARE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDQaIHry; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq0BDmg7SBVBms/46bqVKlTnJwGrFUIH8nCjODSV96COAzW8FioMJm0BRGDPbu0FhKGjoZ9AnAlNhklXw/xyVLK0Hmj+GBECBauTBTfJvC+6ugWJaTcoPEO343UNpBWS2mSqY2/NrWJ31kKcI+8u2M14MOfxapDk5BAUN0kmnT/11SyLkhwBGfWPCxshcURaNxlBesdZJjJJjwucg9biRTFg+fpclci0v4MAm1BB34kyvdtUa/CaTgp6xPBvHmkHWPh2GE972fbYz8rlGP0CF3QO+PbEHOdViH4gVqLpPoxVcs58sTFxX+9b7d2MrHNdfbVMaKqyXA+T4tGqhVHSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWAABuooCiucJa5zGXEH2MBSsxDi0td7jvJLT0FcsHY=;
 b=lIVzWDxKwNeypHMTFDXz6H2Q4HGfSv8P8zCD6sX5fmx+sPWFBrZLthnWjSPQsXWfvddBbuoZoqt4cRIES/pcWRZEAuaIwPOxobTDOgDCs9AbgojLWy82iGsshHOULTLlOHY3RCF5dfA7we67Zra4iSSdhpqYivVsnWIMZpJg0+8srB28BHYWm2cNWRiBLzipuuE1qfLXT/dhshQZA7LVNKjUwh6BKMdkUwFiisi7/cdO/oPTgcYJC8/DOnmkTalVYLgz7XiecUnQmMjHLpsrNNZKqgYF6meSFwynQQkLDocaYZ4scb4XCkkyd7i+RDUA4TPlOWG+RrcWK1Vs7d6vZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWAABuooCiucJa5zGXEH2MBSsxDi0td7jvJLT0FcsHY=;
 b=tDQaIHry3LEKxekwbT9ZwMiV7/5DN580lg222W+dMitdtgVvJW61uiE5qHFKmCbj/jttjVXzgAdRjXt8PZ2C5bNg5WymM6w6H4wLWrGJuI9wzNswWg8VBQEJHJYhZLP1C5tc6cWq744ghETr9AqgMT6f7gzKbWSwdtMZ4guxi34JMhRt+tldJy9Nb3Ua2pSoHHGiutIFzsSburWecDzQrsgc2y4M7ce2fou2ldFTTF3G5Yl2uCNDo13qspsfp6UOxuCMoxo+FGNJpQHj92NrAJZuje1l2WL7XTREVf4wBNk2gtJYR0Mu6Y7qS/gELwBYolKBxsuPfVeh3Pyr0QminA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Fri, 24 Apr
 2026 17:10:27 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 17:10:27 +0000
Date: Fri, 24 Apr 2026 13:10:25 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hans de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Salah Triki <salah.triki@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Ben Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <aeukAef3c6eq-dLK@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260424130927.349ad3ae@jic23-huawei>
 <aeuRMiws8zCdkGXX@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeuRMiws8zCdkGXX@yury>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccd5fdb-f724-4141-4e6e-08dea224617e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8km69BRC2NhcHkWnvhJ75sKsWeETgo4/eC7xW1GPqU6GDiJHPq2YSdpryXOwl20Wk7tBNRWubs+/iyHBDOH7q3QP2LiDAHD+GLfzoirRjJ41cfxONZ4BecX9BwSxfGelWQ/lYOL57ZPbs2CUhondTa4pX1m7YjN3STUnRpo/5bv2clAyouJDyDLyYvfKeeENKbBkvM2U2eT2ADMe3M8KnAJO1gAFhKj3IXB6Cd/l3OLRL599PpOGmLWmBHOG053YjJUHfDy9pEvIraFOnbgv1Uu7bxySEvmNTCkEh9TdRXmltsSLXXzKLef/j6zfK2OM1sh/C329go+4Q0vSpJ7yVibpN4qQknaW/P+BFPRvLHKBiLOC14Qe32NHAv9smeudNQ8Z7naKbWQ1qcflYFPBymtAtbEMR2sT/to0rIshRpFb/LJdHK11xOCharCPiBs72aI/AMeKeF3alvJFGCxWxSN1L9MosCw98tTieqmru0bkANLCaTcPLwwY8OhaaQs8sfNWBzyx4S94z4Hvs59iu5GxsekdtDq1EzHCV4jLiwBfb5DZbRpW/STlcS12X9+02iLVfjrfVZTN/nC3BGG+JVUoJtlzilWbdqnvQEZPwmNxL/SXZ2lfIA69ttpcc8hCNzrgz1ejFEJXtK3ZtdbmDwqm3eicnhEX7R3WbdASJuJHd8iTsrglla88HYRKSY7ikGyABf8IBQVZNCEtxVaiF6KtxjYn/2HglBi6qLMxF4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QrGbEZiCGkt5+0E62n4kNjnH0QUqxEp0JtjygEWQNxWQBd48Z3efSgDbwgsx?=
 =?us-ascii?Q?Jrpb7YNsB3qNLNx+OHo99CZzJ3o4vjtUPyK8WgRCV5C4IBBIEOrK538XfUIZ?=
 =?us-ascii?Q?bBlqd9X6YpkB0HcRmJ/XrAgcMlphJvC7n9IwC85kkbPFjoF09yE/o0V39K6t?=
 =?us-ascii?Q?Y+N/GsEvmS5RJuuqeGZRo0EjPXumMsofA+kEOQy+Z+D72RS5DAwq2GzRpBRG?=
 =?us-ascii?Q?Mdps6Hbym8Xeo0HQ2L47v0t6DOf5gttowa6bjdp9ZUX9J77nliPoRV1o2UGm?=
 =?us-ascii?Q?Dyc/FQMYjd62Sd66S4ScR1Bcup+TewNJ+RAJL7bD10J5Sju22osxBdUVR/wO?=
 =?us-ascii?Q?3CydLcC+2CGEztwWy0KK18pmPp+G0JBXKN+KyIdPTBc/N1S75YV7zaZUXI7q?=
 =?us-ascii?Q?tcF7orXKuZ5ZfTANSoTJYqqXkO3VDwW6oOJm5Aoq5UEcK4U0DMfRk1ubhJPT?=
 =?us-ascii?Q?FhVLGpsIK3+bPaAcOzzeuw9UVhKu3oGb9Z3EsXWKGBZ1ujvkjeKmxGKPSuDV?=
 =?us-ascii?Q?LP+jfKs20rI25Dt50q9HvVu2y2JaJJ5Cc5OJ20L+oGV5cx8fW2VB17qm7iJk?=
 =?us-ascii?Q?jhNX0MlCMDUBnGTxMCr1RQ6RQeyOg/8glif6LymKTIn+iN2hMYPlhC8NdcVx?=
 =?us-ascii?Q?ivvsrzxcm83SFVVRwsNmUAs66FHy51YsGn3pjab5cJVPoLpYYI3ntqmIwM56?=
 =?us-ascii?Q?3ABGzq1gaOKPT6Dc+jz0Up0uspvd0p2zTeSZ9Cfz09u5yMV1/4AiK0i9z45O?=
 =?us-ascii?Q?lRvjVQm7AxtbU3PLHd4gsvLnUuOlIbrfO5fBfb/wUnENgp1xE+U2vPn2wKwE?=
 =?us-ascii?Q?riOONOWb2SzYzsZsawzSbe5NWnjWstTj6GiSDW2xlrZxhyMhVyIDVqNa5WN0?=
 =?us-ascii?Q?7bwyLvOK1xg86vl5VOpJEzBexrKLpXTrQsqqWI3qZnk9HNI/BrBJWko0crEA?=
 =?us-ascii?Q?KW9pe0RtFNPogpD4qu02MEObVIIX0pwHa7nWUatmqbcRODDKrQMsKRBd0+rS?=
 =?us-ascii?Q?TLTN4SeynsKVGg21cUiSi3THDP2M21xH8AeyIQo/YcCG3PK53K+MohXV0pyO?=
 =?us-ascii?Q?DOA+bx7WF09oBccapbx+ASCwW+aXakTnEoJ60CuCiHzTFAbTJhOuXdhi5Brq?=
 =?us-ascii?Q?v1o75zkWvd4EA02GWV5q6/oSH5XIZpnuv0aFtsJs75dBYkq9SbElS1nmyTA0?=
 =?us-ascii?Q?G4DnTZYpBs/j5ArtzqUj/637quk7NJPzRVEiNPkffFkiDfoUG6INzp5bdIvt?=
 =?us-ascii?Q?vN9ExG4qJ4GMXW4VDYxH3R2jW6aPRNSbcWcWW7hMqkCb/NWWZC5tUvxNP6Y5?=
 =?us-ascii?Q?nt5ip18DG17RdpkqGVQ1vm55RnyaffbUUdFl/WtjWC52gWYLVAS1dYBUFk2N?=
 =?us-ascii?Q?HX34n2jEU+aVpmEVxnwyuaYYQzSD6I9kmUFhfg3DgOicn4//w7/+0rsu4FXP?=
 =?us-ascii?Q?mFMbceuU62RssbIeiNehBF8R0VjaEMJAm533r4V8WQ7E2g4N5v9coN1e8b+Z?=
 =?us-ascii?Q?IIfPVgR1vc2jHPHwNNESbnIcrz1FTrEG2ofHReSri+FtnsFTlG+Ixwuk5S6/?=
 =?us-ascii?Q?IZq+9VpqwK+G2/5cJySmZfY2jEkgceBpZz1dz6irc/yn3+E0cDJT/oODodKA?=
 =?us-ascii?Q?FHzdtc9T+8nwITOj2Ok3HRE8ZRej0itPNdxqxuQy452LNmY/w8R3ukvY9FVr?=
 =?us-ascii?Q?UO0KxrKjRwtEEgB6yrb2HXsccHUQqFVZcuVj/4Aii86y5+ilNRR28MWT0jJ6?=
 =?us-ascii?Q?bR9tfOtsP4x7nUufDJVQGQZMJa4Am5eUzFgzcm5eOUVjh5iA/TZH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccd5fdb-f724-4141-4e6e-08dea224617e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:10:27.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrALK0mNZtB5pYzqRhiWgPYYVvzbXAkBFicnj/J4JFReBCGCJM3SRa956fIKk23i6ceRmILArytC8ABm3XIUWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
X-Rspamd-Queue-Id: ACCA6461BB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35284-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 11:50:10AM -0400, Yury Norov wrote:
> On Fri, Apr 24, 2026 at 01:09:27PM +0100, Jonathan Cameron wrote:
> > On Fri, 17 Apr 2026 13:36:11 -0400
> > Yury Norov <ynorov@nvidia.com> wrote:
> > 
> > > The bitfields are designed in assumption that fields contain unsigned
> > > integer values, thus extracting the values from the field implies
> > > zero-extending.
> > > 
> > > Some drivers need to sign-extend their fields, and currently do it like:
> > > 
> > > 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > > 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > > 
> > > It's error-prone because it relies on user to provide the correct
> > > index of the most significant bit.
> > > 
> > > This series adds a signed version of FIELD_GET(), which is the more
> > > convenient and compiles (on x86_64) to just a couple instructions:
> > > shl and sar.
> > > 
> > > Patch #1 adds FIELD_GET_SIGNED(), and the rest of the series applies it
> > > tree-wide.
> > > 
> > 
> > Just a quick heads up that I'm beginning to assume that this series
> > will land in some form.  If it does can we do it as an immutable branch
> > as I'm suggesting it gets used in some other patches in that should land
> > in the new cycle.
> 
> I'm going to submit v2 soon, as seemingly the discussion is boiled
> down, and then will likely merge it with my tree. I'll create an
> immutable branch for you before the end of day.

Here it is:

https://github.com/norov/linux/pull/new/fgsv2

It builds well for me, but I'll wait for a while for robots feedback
before making it 'officially' immutable.

Thanks,
Yury

