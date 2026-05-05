Return-Path: <linux-wireless+bounces-35922-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAi7EV0b+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35922-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:31:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF74D1543
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A40301CF9D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2748C3F2;
	Tue,  5 May 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b5RlbsGQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1A47DD4F;
	Tue,  5 May 2026 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998515; cv=fail; b=Y+ymt1jp2QbcCafno+qjbd1Y3j4DUeLhXrzSotit0NR1LNBwcvpoeSK5b3KK8fV0gZlnk+MWE2bKEngViGjeB8b4zwqc81eI+2PxDvf8GvZl2e2+DLzt6c7TPloDaiPhcOMl16Qr865LIvAh08WxRsqdsyxRLGOJsPmOnAiQMXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998515; c=relaxed/simple;
	bh=KjrFmJsTnOAVETaYy8gxMucU0aBpF4X0Dwqys3HafMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dH7Z3YejDNj6/poqLuXLbJl9Fou8/GE6k8km6b73JDjoz2XYPLF1mXTKjEwRa7trC1tywCKfoV0pFraubsZYHMrJFzxjv1SMVmW4xzacvkIrBs5U4YXCwrHW8Jj5E9y8fzSzQ8L0qkuWjRQXlpbmd7s9nVyYxngTnlRS+YfypAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b5RlbsGQ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdPvwAbcGE8VbocMG75D/IS8tv2u/dwImVMtaLZne2VjucTJ2myTyKOu31A6l542J3kGaqFl5K1o8puZUc6c4OI90BF9HUzNHsKvL30Wwgub3YBmETJpCbYyFnQfz6v3CefLBVAvFn3Ox+9AMg86W0CqzyUWDhbqlXepsdR5Vo4pLoPsjdthtk2A1unDp4PkrWHjEpT5A3hVUmBJpUF7N/QxkftTBPVMavNXLqROvtAJtVjmfhRSIFladpIQpEDGM5kAw6DEeawIXnmpOxfDMqm66QjR1mFKU/y3R5ha/ZMUKZtXYltCUYL4QcstTgQe41KfaNugMzlanH1bh3ezcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67E+e4MpC+SYypwpZNegS+i6jx9wtRbb15wiJjSSmGc=;
 b=GKHDuP9UkCIVZnJwYUQ+/cCyjrVyZcP5SMVQeupUA+5ZyCnqhMpKC8CwxeFg/Dt9nRpniOu+DNLZ01yQjgzUwqfwJgS5GLEFwUI7D3xhpn4OljJqZQSrpJFMEO85Nb7gc+NhV2CjOYrV76ESd8X+UD1EIMqiSb/05qQ60NxwKrpNWEDwWJTEOU1FAYHl85Vz8V5WgWV+Zhi4EAuQT+v1cbPkfXNYEgVgw9/K3CtQ3xa7+X6pahXf4K8FFXUJZBCSBTOIExaksd4WemTar6s2CQAUQYNX8QKRl9XiIx3AnOjQXg/VwFTImzZ2ItYEoioMF4Trgb54ck3RuqoYgOl0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67E+e4MpC+SYypwpZNegS+i6jx9wtRbb15wiJjSSmGc=;
 b=b5RlbsGQ6p3N/CSi4ILewkVwl3pGpupMsHpGZhAcg7XTbZ+AFqn/hLiUNEQ7OTjvUg65rMWbGlYrx92qZiVnKlLRXMUDzGBEkQZAajhBwR6EPDDAcwstKtQQw6l61mzjgW1pqVq1nXHFBx7c4oy+QovtgGMCK7IM2eM5LxA9e8CaXeVQFXOETwvZ5esS1XzupKX/AM7s64jn1sCf6Ag6QYXs6znEPRMf3EUHvzg0LWgvIGy4COeyqDhfAxo5CMxQL3GHw2nDfZj2HE1Ka6IsPjWnorKsSZKYqA+CXD0lbH6ZkEqIcvvA8028jKLBMfIJvdhAqUFG5qm7INuirqXvwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:28:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:28:28 +0000
Date: Tue, 5 May 2026 12:28:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Adri=E1n_Garc=EDa?= Casado <adriangarciacasado42@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>, linux-mmc@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Adri=E1n_Garc=EDa?= Casado <adriangarciacicuelo@gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
 and add Kingston CID
Message-ID: <afoapez6kwrPjvU2@lizhi-Precision-Tower-5810>
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
 <20260315172746.270734-4-adriangarciacasado42@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315172746.270734-4-adriangarciacasado42@gmail.com>
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb8cd9a-5309-4201-c010-08deaac356ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|7416014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	nbs78fnH0VNUEU0XlkdbV9kex+WT80t2QXq1tE8TRZIXJVJBl2Arnlv+D+/lFmd0IOt/rxZpgLYDO4DCl0/QPlLZu02IyqVHUH7VwZp0n2yDWe8Vedh12yfpAw5eWnADUTmsng3YoRLYFYA8UA/52YcDeVr4LOFkjuf4m6nxsnApLIPAVoaDUKrL4ngFBV/8ryyE73hwd/zbItpElatKH0nzs0VB02L/1x1DrCkym039j6Brwi15pHyysGoO69yZpB3fj6aWQua1om6/3DaCPy++/WuAysF3o1QyDLuaOCgBqgvfVGv7fl7zlSk1FbyeGnyh0gk0WqUx5AKH7baNtDwP3EKY0xP2UREloVlmRU3P7u8s39Wjb5QC/cmYiDXwswK6f3D4yJ4u07ME5b2AqncndYR+cgWdC8yYREbH5BEoiwgJSqEgyL1yiDgeFHy5Et04x8ZKekwVsHl1ftHGD9U67VOBvBQpyg6VdAj97hvaC1Cq4PLYH+WwbbqzwIlCKp+nJMT8uB0EOaMdCWeBtiJT+SnibATvjaONS0na6Gn4kgKwqeb80z9url7Tytck8TU3lO2ySosJCthgmeP5Ed1Ck5hfh/70lH4/BY4qubLGTZkqdvN47u9vhD7KgaFx7SGpaheEMEHFF+AKcf5wSozuypUSyJJWCs3ofedQTqPnxIzp7D7z6LBeoa0PzCzwBEkx37/e/xkUmGIxxUroxMIRnrUu5mmw5eYB2bT4ifbV7ZVQ/ZCPh+uxhyt8/NTI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?bnm7W7GCJwm3IAlWbwPu8xqKqm3vXaWuXFAJDJfZw2yQqUPILJle4E61YV?=
 =?iso-8859-1?Q?xOsxWA68nNNg4tTivibmjEzwrhKIcTld8lLxD3C+GcHV7DxazKwrNRvK1S?=
 =?iso-8859-1?Q?FAXSUsoijCWskP8Rn6qRley1hYRjNcD5vw9+DEHfYAE30HitZ386Jj5PvG?=
 =?iso-8859-1?Q?R3RinK4FEwX9BJDjMMHq5Yw1RBwByhzSwFNa/YOYT6nONgq133bfAWM5Bt?=
 =?iso-8859-1?Q?tUXKxr1n4nh53705OVuzeqCyvHkNMz01KDF305mEP+KfhctODKaOeGEAz5?=
 =?iso-8859-1?Q?8oKJKk2+wpBzKh8v9eFOHKM+S1AW6oIGPqietCYAKqB+E6WL93aScEWWTK?=
 =?iso-8859-1?Q?SVlZ6+ob4aNP0bwy7HDdwWu4Zh2Rm0SSpxzhN4vsamS2kSrqmtiZCmmUSj?=
 =?iso-8859-1?Q?R7Tev2cLJ0+YD5fidozDxrGKfznPxYWb/hBbfSrkBJEFm/xYAr81wSwU91?=
 =?iso-8859-1?Q?OHEnxpsPtAww/q45HYjXNEmGMiYzE5vIsgqPCyfYsib6Ydt8jGYeYUePSM?=
 =?iso-8859-1?Q?SKbcwzpqIb0bsThkiXbnElL1RHg4LW2iHNt0D/J3zqbp/68QzeS2+YCGNY?=
 =?iso-8859-1?Q?+jEoIee+cq4CLzD+SztZDLeTIvp068aYpZUNahg9BScdi/k71Bmow6P2ul?=
 =?iso-8859-1?Q?IFZAHd6xebZozCFNTclc+DaS3F4mPiN5ojPumvbH8eMD9RGGgUL99/AUll?=
 =?iso-8859-1?Q?8bc+ToTSlM4YY/jXc+Nfk1pqnCz3sezXRAqOAObSWTTa/mpNAa7uMCrFh6?=
 =?iso-8859-1?Q?W1ioT6cJp9mZ/owAZrdog+b82gDGA9t+FghSSSbWTVGxDRuah/+dbYVCGp?=
 =?iso-8859-1?Q?lmqh0BFqi2Uv7R/3S57ijgT7N6dee/5D8aru5TRT+XIeXdz0gS7AUescQ+?=
 =?iso-8859-1?Q?qH7D7bcF5lDCGOQgPb4pFKsz7TET3jNnCIryNy119vzQTKHuoFDbpAeTop?=
 =?iso-8859-1?Q?PrUuwqWanz0AmGrGlckw7gy3dn51Rypw5OEUbXQu+yfJc5iWYLsIPgMtlH?=
 =?iso-8859-1?Q?DIsLPr6Repr5A8CElNZru3+JYsru6gk7hHgdCNftwASzUP3/H5NlXBMuwV?=
 =?iso-8859-1?Q?ebNp6O5INUvFNnJvuKIf6OSpc+DcR2XnH07xJvxzqTwDVE53oyz84aslPC?=
 =?iso-8859-1?Q?qzDePy0Gr3h4ryD5vu1DGX7NDy1GWFCAOMsJAAXgMzBFrKGcobQ7LHwDo/?=
 =?iso-8859-1?Q?KUETnsofXEdH5/cXFaE617/CFKpw9AJEUlTAFSDoU1NuWJ62o8Zv13I9F5?=
 =?iso-8859-1?Q?X3sijvoUAhndH93it6aGAAuZxnEBEl3vhDXrsYvuRejI2rQJ3Vly4A8vp0?=
 =?iso-8859-1?Q?qw1eJsa3MP3uDGg09qc+HLkJ7D8hkeqEX4bbPv4XcHnflDZ7LPOt/nBPK4?=
 =?iso-8859-1?Q?aFwPbzpZZci4vKqrgQaBA/eCPb0PkWPrXk9nSxe7bj9W5qbP1ushCbuBsm?=
 =?iso-8859-1?Q?Osx74zHu377vihc8hJZC917AFWbM8AZKmYf6v1IUuyUgka08kHIpOx0dId?=
 =?iso-8859-1?Q?DCk3dXx51XbPY3+QVQaWJJLLVi45U+nzF/3jFv/Wo5WjDaVZNmvXc2P0am?=
 =?iso-8859-1?Q?wrJsyyEQAXRsg4rVzOeKlAur8FSgA9HAKIn90oy0f6ecydcqkOgjBJzh+X?=
 =?iso-8859-1?Q?HV2z+Sv2Qbm4RxsCdAbUpP/g+uvDAgN+/kvRQ3NVqhGoU2vTWzx0XD53Qr?=
 =?iso-8859-1?Q?NOYWOEWNbxxshsYNRLm1NhuyGtNTmSxcU7FTIP9AmQwwUN10LOCDrfA1S9?=
 =?iso-8859-1?Q?WxQlMB6cJcFGIw/zRu91YbwFnvO43rubvOaZK2zGg2Ji7oxwPgeouNc+is?=
 =?iso-8859-1?Q?1EqNKt7r7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8cd9a-5309-4201-c010-08deaac356ad
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:28:28.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8AjLd2J1SkI1c4m7z814qN8rtDU+Xvzhfk/kWa1xw/8M1a7z4prBpSIJAgr9KAPhz1uV+GvmsBBZYxVabQMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925
X-Rspamd-Queue-Id: E7AF74D1543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35922-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,intel.com,kernel.org,kernel.dk,gmail.com,nxp.com,pengutronix.de,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.840];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Mar 15, 2026 at 06:26:40PM +0100, Adrián García Casado wrote:
> Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
> struct since they share the same flags. This reduces redundancy. Also
> add the CID_MANFID_KINGSTON definition to quirks.h for centralized
> management.
>
> Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>
> ---
>  drivers/mmc/core/quirks.h          |  4 ++++
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c..d736bb4be 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,10 @@
>
>  #include "card.h"
>
> +#ifndef CID_MANFID_KINGSTON
> +#define CID_MANFID_KINGSTON	0x70
> +#endif
> +

Where use it? It is un-related change with sdhci-esdhc-imx.c. Please split
it.

Frank

>  static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>  	/*
>  	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a7a5df673..9cfa26722 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -256,11 +256,7 @@ struct esdhc_soc_data {
>  	u32 quirks;
>  };
>
> -static const struct esdhc_soc_data esdhc_imx25_data = {
> -	.flags = ESDHC_FLAG_ERR004536,
> -};
> -
> -static const struct esdhc_soc_data esdhc_imx35_data = {
> +static const struct esdhc_soc_data esdhc_imx25_35_data = {
>  	.flags = ESDHC_FLAG_ERR004536,
>  };
>
> @@ -391,8 +387,8 @@ struct pltfm_imx_data {
>  };
>
>  static const struct of_device_id imx_esdhc_dt_ids[] = {
> -	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
> -	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
> +	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
> +	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
>  	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
>  	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
>  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
> @@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
>
>  static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
>  {
> -	return data->socdata == &esdhc_imx25_data;
> +	return data->socdata == &esdhc_imx25_35_data;
>  }
>
>  static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
> --
> 2.47.3
>

