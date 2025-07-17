Return-Path: <linux-wireless+bounces-25562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F97B082F0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 04:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A3D18921D0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 02:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35831B4244;
	Thu, 17 Jul 2025 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K55MBLkW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5081799F;
	Thu, 17 Jul 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719220; cv=fail; b=N4KL5e8dlcHyfCRjuBjMorRdclTt16xmyIOp70WGQg0GP7mLngZx9oXT9d70G8MFR/tHr6RpwcEK0SgvIrVHRxxD2c83M2WwZYkyt/Szw1k2QaR1KBaBBikdfAFsjM1mwukrDqjc95Dcc+7yELWyt0/JRBjxiK1hvjW7zwOU3Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719220; c=relaxed/simple;
	bh=S4WZ5qzd1u7Wg4GzYWigNl0N+966t/EEL+rLAvojTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqvKWimC4hdFus3Y8kupmh1ka/P1QnA1aQutw8y5nQv9uj6sNdZQTV+Qsh+AEghZIWi5GLYPYmDcJaSbygbLh3l7ejWh6qx+ct2uSc1zUOdkYfIPBh8UsDAdAhgTSEygMLWF+tS7tUk/BNZk/JVnF2UKzayTD+I1o40/gicD/2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K55MBLkW; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvGqt9g3tToLDlqA+MZQe3t8yfnsvx5lOi779DhLdhtDjoqyHG5WuC1KQ53lLb26Jj7ylwCIpjgY3cxNVQ7Djra/c2J2m/OZwbTgtxRjcye4z7Dzi3AAZw0+unWV0GPja+IkLb6rywdyxdg1GnEedB/LUVLq42i9xqJju3FXpIklfs+70nnecUSXj2iUIa0TslLawUtDrpbJM70N7GCKvkibEDYJbQ0SNAh50jMv8UXLkhVHBGcv6//J8BUQc80ZhVw8zEg1MjHW678oSGdFLfhbyLEtsU8un/GLScsodcmbF4ZqTViWLoTgUreMA/N7D9x+rYqYdNth0HWlDeFoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtcEzV2M7VYpM8x/SlUIXNXod5cz1Y43GEqV+zHR4xY=;
 b=Y7glwEUA8sMNaxuwGbzTzu/EAaEFBTSmYeFQyhW9FzYr8E+QRpHzbLkDKqtLln1z7rXyQiSoxo/qa+MswJkbUCE0apH+rffWBNVEOI0qs6Dr9YtnEdR5s1yU4ZvpSGfxr5pGLcwlm2JHrIMne3VhcaNKjx3lJes1O0jMsJXcIFxij7dMsjrflD5QPisWMa1El9kHZ3N6jLQrchNBOpHWUV6TQfhlsUd/DjYlTuN3TZDdereokgLCnFBHVeyPFE6PDFRuGvi0kyr+/AMXsBVgo14fzycGhp2+3AlIi+rYCv7TzW3Qs0MraZqWR9yUIG+UFF16GLmZGzk1z2pRaRgBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtcEzV2M7VYpM8x/SlUIXNXod5cz1Y43GEqV+zHR4xY=;
 b=K55MBLkWZBlBthCwVpf8pGV10I2zW+V2IIi2bvqWRJksFGKpGW7SHdX7KjBgnw0cjmmFBBkxVcFfqn0jgvWfY+hSEfhqpN3ptvrJqyZ9DbpNaKhS4tAzZoO8+2ybwXsYE7K16YASpIoE5PPwHoiFNQUgFc9+fHp+NgeJi7nwXLaIsUQuzMB7OTT3MZ9PaJxrQwjLOWWFpDAnijTDjbDR0Jym1yPzbb9EbhyaXxhrKTzg1aYi/iDspyhWMj2cDk8sL1/xuK+BpXacNviJhPN0kWuN3EqhI5QHU1rJKemIyhugfNDoU+QpVjfgh7m8bdgQDDMEEtSYojkv4Lj3EIVUpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com (2603:10a6:10:8a::17)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 02:26:54 +0000
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391]) by DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 02:26:54 +0000
Date: Thu, 17 Jul 2025 10:22:54 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] wifi: mwifiex: Use max_t() to improve code
Message-ID: <aHhefskeJR4+rEZx@nxpwireless-Inspiron-14-Plus-7440>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
 <20250715121721.266713-6-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715121721.266713-6-rongqianfeng@vivo.com>
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To DB7PR04MB5497.eurprd04.prod.outlook.com
 (2603:10a6:10:8a::17)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5497:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f121243-e19a-4f4e-2e19-08ddc4d96515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9OGdYhgMRx/8sW1rCka+Fi2ynVcoNicB1UQmVFTa/YHFbTmiXdiKwDjPpEK?=
 =?us-ascii?Q?ludyCzCjZjooa7GlfupvnwE68dH+uz9uLtzr6RtXUYuMsEYjUEJpvvjpmu4d?=
 =?us-ascii?Q?6Ge8IgiuSto2wv18mEXs+3AONlLxVUtgqD7thAoe70zcL3soB8s8/asQRF3/?=
 =?us-ascii?Q?O+/CZO2j1Nju0At/dXkhW8Ul6w4cbtjcEJ118d8Gl7iWsgOaqnGBxjetPXr8?=
 =?us-ascii?Q?6xb5H6lgVvS/PVDIwvx/MTPmNteuTF73RsLRBkodEbD9DKybJwKTd+YhJx0j?=
 =?us-ascii?Q?NYPplOxVBKM+sKXkav0QhQbKYtkR2acjMvc6t7TrJmVsSdFyKWa7gOgSPTs9?=
 =?us-ascii?Q?6aQtQwNhmg2kBscK8lAg3Wi5SS24Zwbzw6PECPxiBAe4s8nOo+9CrGP4Sx+F?=
 =?us-ascii?Q?WaXRmkO8KDKwNy1+N4acYdV4+GhD/kp9zZSbVAFxMSNvbjkcpbxGlJllhIeP?=
 =?us-ascii?Q?sp18fpf5mI99hqBRYsdKnJDh/lf7IMK+rt1PZzoFq/TyiqXgnCAKtQgU8rgK?=
 =?us-ascii?Q?Zal+SJxL5fBAenyLlSSbKBAGa7Z9FtgyFS9QE+RVyXlBL/4x9ocOvCHfSgwc?=
 =?us-ascii?Q?ptI9a3haKEiRVGe3rf2S98SClEDbqE5Nt9hKazdZamXnNVVFvRu1yHizLo03?=
 =?us-ascii?Q?Xoibcji2sSmAnFrFJJSYrE21MZWuHg3L6lLu1YSORCGnWNd6O5ciGdqRmN3Y?=
 =?us-ascii?Q?H1AnjUia2ksH7lOtDOMok8lARBV80DwWx7b64Qo4P3zGRBD/LgBr7yP34CYy?=
 =?us-ascii?Q?DiSEb3ZBWqiDb/BrksywqKOjpDrQtnq2ojAsdQSm3GbW4SAgDGsrBc5rPru+?=
 =?us-ascii?Q?ziqcjNX9VKvAAHl07/YqOU82Wc6GFHjXxZdz/f60r23F3o4dN4Cl2e/CgMr/?=
 =?us-ascii?Q?QqdBPIPluX9zVtCD6BjtC2T9HS0nHMJhInnrxd6R0XT6oxOQeB/U7mzGdOt1?=
 =?us-ascii?Q?IZsq4i2Dpt13QsKRjCSUlOsRxOVnxbKoHls19w7dXI+FEbOSGOyxbN15iyld?=
 =?us-ascii?Q?wMs7Vn9KufgAb8Dk6b08TTnimS6rG4EzCZ/is/opnC4pACsocrAOlFSp0UW1?=
 =?us-ascii?Q?A09G/kAl3nk36zz6GyuG4mC20SI4fn94APZgNGiPdIgFfln/gg7TDC7Gii0K?=
 =?us-ascii?Q?UeRPE4i3eDJz9GXpOGU0GM3OAv0cnBf0fEORzszIXdSKIRkyW9nS/raHpxGv?=
 =?us-ascii?Q?umGdosfFt+6I2xQwrw1wg5RhlFrknLkbIOwse2gjK5EbRspiUW81W9RXYopN?=
 =?us-ascii?Q?7WBxA37qAtSBEkT73o5VTDSaoGB2Oghu2WgcUVRm4SP1e3a6Ta2h7i4uRno2?=
 =?us-ascii?Q?JUGbG5w2+cl9zcvFXbY3zW3nEq/93hQ0eFmzz745eGmG5MKNEmC5gW2+uOLW?=
 =?us-ascii?Q?Rci1X8kYa3WvlIDBha0MSJ4qvHXqjJhdRg57zjCiLUBz4i0eaiHUqcWbbtIt?=
 =?us-ascii?Q?CfiQwn/1av4Y7sCmdLSYGYnhSZGR5QgT6NCpdGGX0kAURqGjEdaG2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A07z2g8wA7MWgy05/k8EIvm78O4bWmuzCpsNsN4Kyjh5QIwfUa9/hH75W0qY?=
 =?us-ascii?Q?sg+A9xgfNqMblzNa7EUaaQ8gBpPjmuSpcqTtOyQ2f4l6deOt8Tr0wyQgyd1q?=
 =?us-ascii?Q?Cdt+GTaCrRZqDXWBmtao1S73Hi6ii4UPa03dzRN7vHGYfBeYVadaE14r/SOl?=
 =?us-ascii?Q?BHt/aKGPxcO9lZ7gOmUppPmocZifjcaCT0mxv+WFSGRxNoxKmav7Zuepclkj?=
 =?us-ascii?Q?Vrt+caPv+DPtcEWRiNwpF9V4knGd803YH0QihK+FaLKElvhcqVKc7UPY1tS3?=
 =?us-ascii?Q?EEcD+ly9NzezXFiCYvYxpZXb5reh4AG3Oitv1ulSb7EzQ6Z4gITgMAMw4yJq?=
 =?us-ascii?Q?QvOoDMUb/ktPK1aIBJOkJFiN8Rw63W9vDTQPvL8Ip3AVLpws02HRQSQnXAGS?=
 =?us-ascii?Q?XUX5O2zT17P0YTbsUioL677h0PnXgB5a2hob1yCZv1CmYFav4xpTsnCExrL8?=
 =?us-ascii?Q?FktWNUg561eG33SVbPSgh5DlIyEmtpday52S3bVzkvJnUVd+Z/FVQZgIzjdW?=
 =?us-ascii?Q?jWOji3kkyGoXb4GHnAa7gkXk2v7BD1emGWiVwx7xmUnG5GTIAxITCPc0rOhg?=
 =?us-ascii?Q?D8IiBu09M/U4cUDmXDe0K+S8Q5oL/9mziTg9wdbpcP9g0SxRqWiqB5fyC1Xm?=
 =?us-ascii?Q?WIGdVsxLfC9TyGbH48lj0gg8YEW61TWWQFGWpgnB0jxEaBcGww5GBz/1fry+?=
 =?us-ascii?Q?tiOX8hsjVjkDwMKC85DDNfxy/NWH2CorDmNw7e6L1s38LfdiDqEHz1odLzuD?=
 =?us-ascii?Q?Ru1rC/8q55b/I5Z64h/rgimYan2vjptZWYpXE87TDBbDow9WI/9O8Xqq1c3t?=
 =?us-ascii?Q?6pRoAMhszK08+VslB9WtzV/0tuwNNOhIw14oqCDilf2jfrXEQ1u/ZX3w5CpK?=
 =?us-ascii?Q?0JnjnUqjrOGN/JMJHjBNat3tMOat2juwT3Alvr4ODGMzHtTpA+xUHjDd9ubc?=
 =?us-ascii?Q?1JkJzFSKsM9DkeutzjJmesSjKWFjGrciqDl3pxVtRz3o9D4SGM2c/HazAfUr?=
 =?us-ascii?Q?BCXTihyhRu8ag7D1YeBh8uR/HQ4vStNbjy2pdfrVvDCCKeF+d/i63f66Zrjy?=
 =?us-ascii?Q?VoeYvoxQWO9sFyBxDW1eYfGLiCZT67TgupclmXfxn8OBnec969+futtsdvaB?=
 =?us-ascii?Q?zYT+RtxdyjaTN9TLeKi38qnuxuZoq1+n/47AD3Kh5G5AZ+X5b2bhc3GqfrWN?=
 =?us-ascii?Q?QwUrvom4GxzP43Nnjuir41Dc3eIB220N0Rl/jxPyeR+u3ARUmmT9t+F0CvD+?=
 =?us-ascii?Q?mD2FPH6eWsvtYPXq1G+swkQ4QdqHNdMs/IMECCwQvZke6DeiK/bKaErmwte3?=
 =?us-ascii?Q?q1SmS+MvxIoM/QHu201rk97M/VazA0wRczVj6kXs4RgY6EuE46uH21qL0alZ?=
 =?us-ascii?Q?PcA9VjP5PWjHV+N6A0AfO/wC1lEN63HUTqA3FP8wGu3dgizSDPHu8rIUD6HE?=
 =?us-ascii?Q?RSScPecozwNVA2i5E+0X6lWBkHQZwgygkdJQodKlQqaX+bYpsVWG5GDFDMLc?=
 =?us-ascii?Q?DXwG1MQ65k+Kwl+yQHO9V9eb74RH93iN5NHDUfk54RZL6+TTL3WGk/p/kcOC?=
 =?us-ascii?Q?unbu7s96Nqs8YiYHDlzpwoTw7+m1pobAlw6TSo7t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f121243-e19a-4f4e-2e19-08ddc4d96515
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 02:26:54.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0l6MVjrqHaWIN42cuL0oKwGynNhu6K+E5dx9dbBCpupp7hVsLy/GGFJ5tIgiDVJ4rEt9Fkaqdzu9g1sjXtqaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

On Tue, Jul 15, 2025 at 08:16:51 PM +0800, Qianfeng Rong wrote:
> Use max_t() to reduce the code and improve its readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Jeff Chen <jeff.chen_1@nxp.con>

Thanks for the update.

