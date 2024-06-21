Return-Path: <linux-wireless+bounces-9407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D3911DC6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366CB1C23A2C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D9C17CA1A;
	Fri, 21 Jun 2024 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BQx62HD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E517C9FA;
	Fri, 21 Jun 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956499; cv=fail; b=KzFvMI2VAKmGVfe2FJ4dHFIDWhV2f8N+KHulNbWJsGegEM+5W29EgP3jxrVXem/qWUdPByUsLHPGfYRze5IfaR817l4QhOAQIws2lBcZIzBMwIXWDfl07N4LUAed83DN36FXhhDC5Git45mFFaVEuHprVIOsZ1kO2d8xDtXTyAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956499; c=relaxed/simple;
	bh=87vnGicA1bMCdwQ2qCbwfvXbwJghdo6PWPqoN0A3jx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6sGQxszZ9ywxKz2FQNGgpLa0rfDVZ0J6+5qFSkiZ0HglM7cJxiMevXr26Z/8h+Rixns+p9Y+fGwCFHzKK6kEDSsnmLxL/JAJQMzO69ozMC8j5ZEMbiGtP0HpqvGSovvZfti0HjMp19bPXYYOX0/ZKwbLrgpnapGQKKc9NrU1MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BQx62HD6; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6M6FloMIX0kBjjhpQTYXymCSC7KkLtqOhIq3hk/IEY7RNfC19eHN5OFXKESBPu00ez0eBbpRZLfzcyTPv2zIJf5sQsMcY9j/a74DuzVo0PT/8Zt7S79UDdmdBqg8MSJxBnfti1kmgx3ElATN+DNB6LA36nlNPXXxJjcOnp+YrGttUrUE1L78Sio/ajG6F6P1UTgCPDIPGrjTfONz4a1hTyXUDgWV5kFEBr5HTDj2MAitBI89IyqP2gGX7sMDEz0KfGhS9pXzXiRvz9GrBasxyH6lJVcGEgymRIQZ2E7jp+88yBMif//w6B8fnDvdNmZcZob2GUVwsndA5Hzemv3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGyOOhSIruRZcNnNHvocxfzf8w9E1T0P16IvnfcoeEQ=;
 b=MuTnsSZ91pKUqicqfFIMyne/OfrrggYi29F6R7SyK51GUcevdvy+Mn8uC3c80D0Segc+A89A8R5z987zViwxNXEjmZfw5nyM/CRekby7QCmpD8TiF/lnvv+xclH3Psc0IiNVlJ7VFwS8Luyw1mEmUPLk6jQAFMORi8H/SbuY6QKnN7bAeTQySCgDv4KuHdh92JKvcC1G3J6qU5OKunkZcBff+iT7Yx48fAD9AphlqGe5figsTDAjLt7Zlcj9dh4zZhHY5CHmuhu+6aexnbrAgtYbyEz3R8Xk/pYpv2wY/1bRiXSdOjW8ztqCZbykEzh18KVocgtBZ0qu+5/duP94lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGyOOhSIruRZcNnNHvocxfzf8w9E1T0P16IvnfcoeEQ=;
 b=BQx62HD6uF7CofVWNIEkwxwo10xUdmsBDDsva+mAvW323nuaYk7YDN1XJUnTUjnC3vi3FZvLg65lwPe0b7TfISeBS5dgq3v4ROVWPjJBqgLy0P1S0sUgIahpZmeBZ810CHta0+1Rja54I26mxkuIoVPVAu8aA4vNU+jFWoxI7mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:54 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:54 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 43/43] wifi: nxpwifi: add nxpwifi related information to MAINTAINERS
Date: Fri, 21 Jun 2024 15:52:08 +0800
Message-Id: <20240621075208.513497-44-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb4b048-c878-4949-7d34-08dc91c7701c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9JzF7FKKoxrgVos2LB8jHGKI47qeFrAks8/mn5DIOx/UoD89qrPWeSMYRizp?=
 =?us-ascii?Q?ju49spHOgYd77z+Ruvr0f/aQ7wX6EbQPLUWILEGGtPl8ThXKEVpHE5AtJAgt?=
 =?us-ascii?Q?tXn8RVDKKcHx1gS40Z0kLhxNVkL5MiRjagl4uiiNS2hCSslW05Sjzrs6VCMt?=
 =?us-ascii?Q?zQVJxA+ah7apeuXEamc9OcOjGudXD9RF7WKm/krMeVT6tXNd4MRepNv9AKYZ?=
 =?us-ascii?Q?9RCntjXC18OTX6uXkXPb+sXS0apsrCdXpvNQ5dRBMM0E8cA0JahQnMy9KoXU?=
 =?us-ascii?Q?VWIAcmCfAtEHcGiwqMrRfA4uLW4iHeLNCh0J62+ZHblQfqeroNIHOWkXv/op?=
 =?us-ascii?Q?Ao5qh9Xp3OljWvC/5g6LA/Ng9/wZDMI2RSG8kxA++8AO1tF8OU34idH2g0cS?=
 =?us-ascii?Q?o35lEB60tO3hBw6MhKF4P5NO5c50Vqkia6kJhCq+5JsUM0mxduVHxlivj2eu?=
 =?us-ascii?Q?57Niv/hhREnYw/ryvm7Ykbo/6mU0X+0j2xvNv2XnqjZ3J1B6Li3oXIWMUf0o?=
 =?us-ascii?Q?5sM5wR5rKMkacPmHFxF+SJQfZ/PdXgjpp3mdlK5AA1c7t7KVrhfit08bUox4?=
 =?us-ascii?Q?aS0ovXVs+7IrP/P5YiHGvCkva8gMyP2r/2zLeAbeaTW+ANIKQznVmwu4Rfag?=
 =?us-ascii?Q?0+xwx88HAuZg7SyZhCDyezEUTZcl6i0mXPgstnsCcvMCDGlFb6bqpyqlw+w7?=
 =?us-ascii?Q?33JU8m1JU77jh+cc/p5jkskw8QE73aNy8mJMbWFHbUTwMu6Rr+/IXixglP0t?=
 =?us-ascii?Q?cXiLKkdccEiBcYpHIhQjxCnEGJXNZ2M5tdujTIZcdSdjBzh+EzQRtEBh8uvg?=
 =?us-ascii?Q?m+MoKSYLC5COnKpaGd1YI8iUYEkxz0hNmr1p0DXFNtLGUvF2w0epm90JVzir?=
 =?us-ascii?Q?FTGS809MpFc7RMaJWWAcBO927RhJuYPc2KnEB0DqG+qD45qvLR+zg60MDwvg?=
 =?us-ascii?Q?HXx484tbNR5ZVM81a3oG0jRGxG7IV53uGQ3LMKWCCbPTk4ZeQtUDcmArws1G?=
 =?us-ascii?Q?ybaaQAVXVaiVY+4vQW/OaDUmaNS+sZxGW/jZB6WPvv7INqfbV82EnpcLowIH?=
 =?us-ascii?Q?YTmuwbTLm70sjs/oEn03nbKrCgBuAr4AME2hfQPb+upaw2Uuw3TVkQK47u1i?=
 =?us-ascii?Q?SrzOmnRLeLv/QANQzDB2Yh4wBGk0YZ6og2IQa9E5mSO31WDizH+u9kmRtTTD?=
 =?us-ascii?Q?J5YdvUupZnf+MzMmyL9xIxpr16EC/Ul1y4kszVub+GX6tZNe7KLl49BhTuRu?=
 =?us-ascii?Q?7A/J2az3SQgEc1v9s7qTrPDYIBZ6Oukz4dI7cNSWbbGuZoYeMpUreLHP6w6i?=
 =?us-ascii?Q?QBV+LU2rKUAOrRfThviA0NoXHivWNo6g4OSxVry7NQ1EF0h6R+jMcXAcad2C?=
 =?us-ascii?Q?UT1W8Bk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rm7a+ywh8e6/rU9bYw+srYQe49NofQqTqD07EMuUGZfSTH68Qqh9ypTzbtgn?=
 =?us-ascii?Q?AS2dB0MKWDpbZ5QTP1q2osuPnBZpO7NJ5JxnRaN/CAvmiIExCgMwkQIMItXc?=
 =?us-ascii?Q?jqYTvrpqjBFU1ZRMUzCKBLXtLXww5xaV5yTsA1x3u59r5kaj9h3an2yhD8lL?=
 =?us-ascii?Q?clEnCOk9XIlb42LVImELQCvhY9hvZhS+bEv2YElDE/oNNFPkYkjYlWBJsM2D?=
 =?us-ascii?Q?y7GnwQkdvVqL35qp9+0TdT19y3JNEZIiYG4ZDj7d7WM25vHjz0cv6k1J3Utb?=
 =?us-ascii?Q?I74DmF7f33LueortxySqr0DW1hxYzL6PzJpWJg9ZvfiB0dYq3ARq8uUDvYs9?=
 =?us-ascii?Q?5QdlfM9I/Ufzj/A7YxDP46lRaze8lNexil4T8XMZHsVFeKTHnlQK/acivEnb?=
 =?us-ascii?Q?De208cZjMVjTHkCPu7Oc70mSEooErq6DkocIZ5CFj/RTzaTmx+OZ3BIXBNwb?=
 =?us-ascii?Q?nLIIDl8ROKl/Jr8K/QVn0hVCchSRP+gmp6jBUzD+Ke/fHMGOwGPazMM/3Msi?=
 =?us-ascii?Q?zoQqqtlgWHW23ZIolFz83Fy3JhkTFoDnTxWRx+Cx8VCIP2y/EHrIGAaehLa7?=
 =?us-ascii?Q?qzMcyl0K/GWzc5iP4TVI/8yfiM/awYY4T4xdd+cLiEpqdDJ+dmrSFE9BX0QG?=
 =?us-ascii?Q?XSQO+WRLI9OrGObMikOCTsDVIXbWm2tL62qhxeMMyemLEtjqbO63PArMCsmd?=
 =?us-ascii?Q?0bI/fkoxEMqtLW/H+p0MNmIdvVa8A8Yl2PJIYGbSBSbBxp3Jy1lwLxOCtdlp?=
 =?us-ascii?Q?XSNBW9a9i3+HUSPSeos+5Vk3X89lNmGgxYYSmqQKX7ZGPK397vJUUM3pHVYo?=
 =?us-ascii?Q?bTCBVIM45OBnAEL3u9PCrI/S5RtFN7Imt3KXMjq6JcuB/lh6PS7sTkYORFIo?=
 =?us-ascii?Q?piQBx94PwUWXGSvX34CWa2snHgRf0A/GZ7R+nBP5JZ0JR2vxofe5eJ0RJrFd?=
 =?us-ascii?Q?VZRiHCSC+poJmhMlpjd2IgxZa83q8BOrQXiKEPp32CJL1Z38DZ15zMy25KzS?=
 =?us-ascii?Q?F3/oQEm2CShiWTe1YMo1Q0zqjxx/xStMgDSHSJpmj6fGxf0rWkBxBy2hDHUI?=
 =?us-ascii?Q?9pMgBrvn9OpZNAFopmr+2U+NM0HLXltuTUkbjBWhF6ivUgvpGjrmggFItdsY?=
 =?us-ascii?Q?22q5t17BwFQYb9neHXH2KGIjnG2QjTVjZu53FP6h/FtUi/j0xe13vr8Whi0S?=
 =?us-ascii?Q?kMa+ysyju3+Z99simi+SJ2rxLNPMi8Oe1DrcLqifaWGIP5/osCHS8tHYXV6Q?=
 =?us-ascii?Q?tAsgo909w7WCOiRxF1YQejYOiJY96uKVYwjQ55yD2mC5QF7C9y4li3LkLSpE?=
 =?us-ascii?Q?aVS666KdMDy0tDAD7q0TstLonLCNWAqPbXxi6P9TxYMQxdPOV/zn17yIqVpP?=
 =?us-ascii?Q?MgIm6nsfW6KaGfonQHTw1o5N/e0vKfBFM3+k68P3SHKak/pvb6SHQDDKKdeY?=
 =?us-ascii?Q?ehjCcTo/FCaIZQ4i3vFfC7wNs3D2bbX4VtiIglLuVntA92QJ8dE0Nex+f779?=
 =?us-ascii?Q?PTn21q43N2jkLuWnRQbX8VkG+xzYqkryR66RKSONdyUzo9MvsGjaNwzKagBz?=
 =?us-ascii?Q?BiydTWkI5KgBwdTznNpS5oIJKudB6K0mtfbTYpMo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb4b048-c878-4949-7d34-08dc91c7701c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:54.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rxm8RMKg68tYg0QH4iPkuM1D4Ong7GH2M0plDuXEjAZUmborl3b1E9s08MqlR25MnDiMP3MeGJNqZP3Nx12Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92ad1d545690..847051340c91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16178,6 +16178,13 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	David Lin <yu-hao.lin@nxp.com>
+R:	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


