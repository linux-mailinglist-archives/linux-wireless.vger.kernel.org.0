Return-Path: <linux-wireless+bounces-29536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECECA6C20
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4203930EAE85
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6028B2FF66A;
	Fri,  5 Dec 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j4zSjpvS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E427FD76;
	Fri,  5 Dec 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923671; cv=fail; b=UvN5JmdRGeFaI+FjVxq6RjOmEQZVS/h/g11JamFFThEANn49z9ml2YZ2wxYHWEMrb9FvUomI4NdWlWhc+NXhNAcw7HHQVLCTttj0ihjLDiFlpYSJmSCs85aPJrUBSUtO+5hfIGORRd5q2OjJzEqLXf12r8dDqCYuSPruEcjs3uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923671; c=relaxed/simple;
	bh=8jvw2x9RDeGUb8SZbxzQ+sSCrwUa8HisXE+3iFRF/bU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NN7+/7Kn2LVoirgEpZJOtjWCjyAiFxLDFrygRZmzd8XZFdW57n1ANyMF9is4lbh0xDyd/AFJc5yMuq8fXdSQDZjvfW05oQilrVMn2ya0OQ2MldnWHPkpE+GrcvZ3RcrhFs8sR+3ueaUCCRsITJgE3OgVdVM/ocjzHnBgRmPzoBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j4zSjpvS; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfSEiXyDHSdscifoDofw65LSr7LYIAtBWGNj3ZINVTzyIh0haU2si6LKJbVk/Rw+X1ZB33TlvAKWhFCthknfC8hb21LnSoFdzJoBTwPKhdDNB1akglFO0wKwCmVaKTYCU+9wD/0GwyI9o+uRAnGW8AAhzUYHlhhTkFXY5APYce3GRLS5PlDXKLbGUI5Fr/06z7i8ozDC6lviGo5npvekOGgXdDtZV7Hmb8rRHBLZmZUl015DWxrdsXNc3zBPxQFNQVzg65fLjP59KLOqAcBfU9EINx6o6M7mas3QYdhPBxjMaZEoDcJJAgOJ1A0pwqJesRDQ5YLpf5ShThGv//royg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL8D8zPqz+Qok4PIVF6Lzd/g0eZVB1XTLKOHvjquDjM=;
 b=Qt9elJaD/+cymBcZw+vzWKlKjtZqpNrqIFAYKlS/6N2mrruvjizCx06kOoV9LYSbLIUXpnIj5qj5Y2qQX5u9D9mVwEqqGLxfJQrJCX1x0V4aQtLkGdnm10aYbevVls0IHIWpK8BLrEbZMpwiGVr6CmMwy1XFc0wmIPP/MZddrZUuwhxE0DbYg4ksECc/fpPFxU7/+45+mkeFbpeoFCQNK7cjo4U9X8/XbO6bDnzv9Cj0f7qL7PBkTOpJRiDlqNJqD7tMDhfCzVT/Jr3GRrXTxK3RAnBGm4WPwFB70SYP/2R3JV1AcWzwWDLHSueQ+FiCWkuw54cHuK9BW1qQyhcmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL8D8zPqz+Qok4PIVF6Lzd/g0eZVB1XTLKOHvjquDjM=;
 b=j4zSjpvSxU1dZ4/dvSlxqaXcuEuNLvmH69jlSiAy60gtA4my95GM/fmjgH2/TbykCYLmuN5Y8Y7NRxLLx1eCd21Qtu7lgDUIgBjgXrufvjLr/nbi0G7Uq7hncR0mWwsNTzvT7R+/yN8DnH+BVSkEU7LVd9XTksS4pObpmx2V45l473Gv6tQOjHF54e2mdr2aqW+DFVUWM6gsqb4pY5YMjwsNOSn9z0cvjdJIvzGNdbp5GaEd1gF0K8zcqWWpl9ejOCLS1zDa/bB5Vju0edp/9A0wzUHrxrbOxEAD2xBM3lKi9Vy2YQmGG3ip8hXDI18sxGfWBg2K1cCRiBQLlw9P6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 08:34:18 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 08:34:18 +0000
From: jeff.chen_1@nxp.com
Date: Fri, 5 Dec 2025 16:33:13 +0800
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v7 18/22] wifi: nxpwifi: add core driver implementation
Message-ID: <aTKYySrs9vZP9vmM@nxpwireless-Inspiron-14-Plus-7440>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
 <20251117110046.2810811-19-jeff.chen_1@nxp.com>
 <f2pjxhk2amhubmu4vvhjqcy74u2ine55oswka2ybykgnuajh4x@eyyegw3wfrsx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2pjxhk2amhubmu4vvhjqcy74u2ine55oswka2ybykgnuajh4x@eyyegw3wfrsx>
eFrom: Jeff Chen <jeff.chen_1@nxp.com>
X-ClientProxiedBy: AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::12) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bcffc9-1e30-40c7-4377-08de33d914d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GpeimFMrfMr2EaUFEcZnbN0ygPLEFvAULLpM0mEhLASS+t8HYmJlPWJ04eX2?=
 =?us-ascii?Q?zUfYe8hGUdRcGlu8uAzXHdJS5C5a3/5ztMhTSYwSfexUEaSe48h/iIrHTYiE?=
 =?us-ascii?Q?hLmNphGzv8COFysJTZg8ENsKmqTqbcVuBo1mzx9XlLeuTpzfP8o5HDzV92PL?=
 =?us-ascii?Q?3XI6PnqLZCm4t9u0BGNyvkfCuvtFtEga2wanoJqxNJGyTF1yv84hNMoJXz1C?=
 =?us-ascii?Q?2VHGNfuDLiNplQ/4WpkjIHgMEQJTl6/9i3+RgLsxaA8hhdC71sGxyMfLe7tE?=
 =?us-ascii?Q?dwHkmcMNJUlM70Ptp+s2wSElDoor0hvgin0bqatXpLxIqiqZvB8BYM5r7+2g?=
 =?us-ascii?Q?+82+p5ei3Ecy0Q81kYWM7XBvtljyVT3zN/dei7AVJXhprPMvvTlsDAV6oxHu?=
 =?us-ascii?Q?tgdT37h6nDHdLE9CR0ui1A8c/D0ugsYt7pZTysw/ekf9k5aEhvySKOoLo55I?=
 =?us-ascii?Q?WP+xZieEJSOG5Gr0lCXZxW4FrNkAZoNP9aC1R7FAehsRHvVgOF4y9Kr+ifb5?=
 =?us-ascii?Q?pVq9r21uAX/KJNfyp0y+9PtiFizgS48F8Ex0Ml+GuK34EgniALSZ7xmEM7JK?=
 =?us-ascii?Q?58qW4mvjYog0Tu9h0rODXivgHoE3h4T6A5Ie+JQNH3BMv2LU9n2wn6+SjH+O?=
 =?us-ascii?Q?jR/ei9KaIZl9yMg5JyOz8uWNHTmRYToR7jzAWsVSW4vgGvLur7dU1Zu2mwc4?=
 =?us-ascii?Q?/PV8kQrQEeIcKtIqKMTVO6PxETZrf1YRl5h3KSw6YMzGaTojeUGOJYTL2D+/?=
 =?us-ascii?Q?la+QKxqU+7wPGJmwadHEBqLmOLTVJIZ/B+3xeH7lLBDqLftXZnHIdwRRXcri?=
 =?us-ascii?Q?lvNE/tBuWJPmgroIq0Cu28iuNsW4qUIIkiWKeF1Dpj54JdPa7uoExDHg54IS?=
 =?us-ascii?Q?SeHT+fCyuzloUf//j6K6sfnwmTpTP98ykYVWt8NcZnLfgyG6EvSOktyMrZDW?=
 =?us-ascii?Q?un0R/bOonIEvD4XNlluIji2WN3BS5MvAmw7pw3x7V8i+xZ71wCxgFXyPlQ+V?=
 =?us-ascii?Q?EDK8JRAHjHLbIwVncuqn5SBroMebaL2GRgJdn6xPJIPemxuHSg59Dy7FUzOg?=
 =?us-ascii?Q?/IsmWHdQYqyxrHDfqF29z/rH1nNhS9wJlScNA/FM4ZWxxjOfmCb/vfbw1kSX?=
 =?us-ascii?Q?uDe2fyfqPnZNrsgmI/czScdpDazdxJU+D7dpkRZ40yONY5HrgrZEEA9Lmj0G?=
 =?us-ascii?Q?7G4s3NxAqdG6/HDfCGr+/VLe9wKU8UjBaa4CKYrs00NPk5BC7HMPWRw67SCQ?=
 =?us-ascii?Q?QdGrGqM5r6ShzsQ6JSlqsWajVDo/lEOkH8ofMdWo1WIher5He/E1VwEYsGsf?=
 =?us-ascii?Q?OTc0BUvBLI4TDkhaeCnQXnwynVqmXo912FEaGvbw/OBwoYR3aJ3hjbWX4+DI?=
 =?us-ascii?Q?8PYWdT86uXA6VmsrhB+zEXZrvk8WCPPBIqxiJlBX/aEpSbMzvpd1mW3SlDov?=
 =?us-ascii?Q?ln5hO+a4rR5jDSZt3oPCviftC1OiRO/zqWax3q1sgE4WO2aN1Jk8zOuK5ebU?=
 =?us-ascii?Q?NRdDoZL5p2Vt9C6yM7RbTt15TFeEi/RoTwVT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWejyLBMe0pVMg37qic6LPUM62ig4nH1OZ477pqkg0wfAmg8nRguTUb9jfCx?=
 =?us-ascii?Q?Gz7a649uuwDaapfFOQOHaXZpTXyfMm+hisE7TKQ9ONgXTLd+SkjIw/qEBkZH?=
 =?us-ascii?Q?qa5rpcBbjUQPmR1h5GbeN/OsdDBhCteMV5ym72NnNXMa6EaL6qT0IQGGSc+Y?=
 =?us-ascii?Q?oakDUB9x3UY1w63vZSz+ejHY3elXEushkUcYaPD+MtQEdm4bu92FORfA1t2Y?=
 =?us-ascii?Q?K1zBumpdcWscRi/t5oDOrunsW86KhC7ZZ3KhdQIGom/MizIwd2I3p8CmERAV?=
 =?us-ascii?Q?i1PoMR/Ln713mrJ1KiGWeDl1F/pEgKT8edIMwY3uQ+Rn3pqfO+wz6JdZe/yP?=
 =?us-ascii?Q?nnzBB0nAXydWGUwhwpsGjuCEO8hg8Ces2ef/T0/qSByooeUOKpMrgx6YsumX?=
 =?us-ascii?Q?g3wp30bto5OVED20E6XJGcB/SgqnOv0Ney7C3tXzW4WCHKAL1DzR4f8oPPm8?=
 =?us-ascii?Q?pR2nyI7u029s9OWcA+76B+Sssb9MCOa+ZLgd5b/I3aPXIRsOLoMCve67DzSA?=
 =?us-ascii?Q?wugpV5M8V37TZiwkozauey/S56RU3Wkg09cL1GbyKau73VaqoISTNNTLDSU4?=
 =?us-ascii?Q?MxVeNGBgMuhT4TH6M3OtYfCidWi8yC9qeMzE0MY5jJAHsAT+23Ft+sKuS2tB?=
 =?us-ascii?Q?jatFRo8v8CixLh3XA7qBD/0Js98Qr9by7FF3t9Tj8vFSap32HkrHY1sxxjAX?=
 =?us-ascii?Q?VMDgDvOFKagfGgwkvQ2qo+qA5lihwO2ryu1GSR9K0Hs1vHgV82n7+56S1AWi?=
 =?us-ascii?Q?He9KiFiMnmLZKKtQEBfVY7pleyCONZgRR5faKD4WaiXjBVSAw5WQi03KsHXR?=
 =?us-ascii?Q?p4/9BlMItgJB3f8+K5y9EhltvSwcy3+fX3U6FaH/caIqgQlCgtges0axGmtk?=
 =?us-ascii?Q?lL4LKaqdP3zXSJmd0W6ROwKUjP8qi8kbIhwbqk8OD+UGJsYtmm76FqeqktjG?=
 =?us-ascii?Q?kxB92dnuelSwlbjf9F8c3yFbm/VhHX5aGOV1uPzM05DpBSneSTt2sv2Y3tcI?=
 =?us-ascii?Q?1rJk2kutaybFMhhUNJI/Pq+9mkCbGxs+1uhI48xLTr+iKUFsQITzbzDIghCo?=
 =?us-ascii?Q?qqGuyA07ZMODKGgMG9cUsdswiD8ymRvC6afKSlNE7s30yFXFFnHCGdWqyAsd?=
 =?us-ascii?Q?NAb4iYo82mzTgmvArd2jixGcdj67kZbl7x1FvTSZOelJ7my0eed0oDstUnzs?=
 =?us-ascii?Q?OZdK8vZqjC7U5S8A6Rt0rh7wxZPseYYZ8qlvWBoVoBTJo/qhwyETJF2TCu+4?=
 =?us-ascii?Q?ACEOnWZX7PcylFPAcmavW4DGWSUHDUcG6KjAFZUTp+n2o759J6/LbBT64+HG?=
 =?us-ascii?Q?xFx1Pz1mlcqoP1JsswZj2CphrYZM31AwL43dUTf/jaQyASM/drgcYGc8osuS?=
 =?us-ascii?Q?lObWG052/754+QJAFmTR7daPbiLl/2o/XluhQRtwIRjBtW+PB8XwiFocyLIY?=
 =?us-ascii?Q?PF+GA4rEOQX9ru54lr6wjt9QcQXJq8mm/fTpQd1ULmJtFSLxjCUwZBmKUSmf?=
 =?us-ascii?Q?P2i2X6D9MRB7tT8Frw31v7rKSCXJFtlUJZTtsWTYB/w2q7rLalqWqLVKJrob?=
 =?us-ascii?Q?tKOwSOvjm2tKfXZmuG8NKfBFMpbRgbeiBqmK8W0x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bcffc9-1e30-40c7-4377-08de33d914d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:34:18.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW5uADiASxnrOMYH5fsDKc8/aWioV16ZWOZQP+QTsWKAaTOHy70O/LWKV6Yp6pwyPp9Ycv9PHgIULjRM5QSCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559

On Thu, Nov 20, 2025 at 09:17:58 PM +0530, Abdun Nihaal wrote:
> On Mon, Nov 17, 2025 at 07:00:42PM +0800, Jeff Chen wrote:
> > diff --git a/drivers/net/wireless/nxp/nxpwifi/main.c b/drivers/net/wireless/nxp/nxpwifi/main.c
> > +
> > +	adapter->workqueue =
> > +		alloc_workqueue("NXPWIFI_WORK_QUEUE",
> > +				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> > +	if (!adapter->workqueue) {
> > +		ret = -ENOMEM;
> > +		goto err_kmalloc;
> > +	}
> > +
> > +	INIT_WORK(&adapter->main_work, nxpwifi_main_work);
> > +
> > +	if (adapter->rx_work_enabled) {
> > +		adapter->rx_workqueue = alloc_workqueue("NXPWIFI_RX_WORK_QUEUE",
> > +							WQ_HIGHPRI |
> > +							WQ_MEM_RECLAIM |
> > +							WQ_UNBOUND, 0);
> > +		if (!adapter->rx_workqueue) {
> > +			ret = -ENOMEM;
> > +			goto err_kmalloc;
> > +		}
> > +
> > +		INIT_WORK(&adapter->rx_work, nxpwifi_rx_work);
> > +	}
> 
> In nxpwifi_add_card(), if the allocation of rx_workqueue fails, then the
> adapter->workqueue is not freed in the error path. The function which
> frees the workqueues nxpwifi_terminate_workqueue() is on err_registerdev
> 
> Should one or both goto in the workqueue allocations error path jump to
> err_registerdev label instead of err_kmalloc?
> 
> > +err_registerdev:
> > +	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
> > +	nxpwifi_terminate_workqueue(adapter);
> > +	if (adapter->hw_status == NXPWIFI_HW_STATUS_READY) {
> > +		pr_debug("info: %s: shutdown nxpwifi\n", __func__);
> > +		nxpwifi_shutdown_drv(adapter);
> > +		nxpwifi_free_cmd_buffers(adapter);
> > +	}
> > +err_kmalloc:
> > +	if (adapter->irq_wakeup >= 0)
> > +		device_init_wakeup(adapter->dev, false);
> > +	nxpwifi_free_adapter(adapter);
> > +
> > +err_init_sw:
> > +
> > +	return ret;
> > +}
> 
Hi Abdun,

Yes, good catch. This issue has been addressed in nxpwifi v8.
Thanks for pointing this out.
Jeff

