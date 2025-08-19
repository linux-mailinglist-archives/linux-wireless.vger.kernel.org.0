Return-Path: <linux-wireless+bounces-26460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A83B2C2D0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C72614E4180
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE73375B5;
	Tue, 19 Aug 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jO2bB2MX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013028.outbound.protection.outlook.com [40.107.44.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB41FC0ED;
	Tue, 19 Aug 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605567; cv=fail; b=O0KyFLvpG2c13+jfgiloWf0Y8qOh6m7EP4MAbnzNTpJvJy6Ht56pfCRa/t8VR5/BNONy4AiddxKHJOFH8zg27ExhAo8MA3x7yFOzsFseUbb2qqxCIycVKOOildIKeDmqpj0ncotD+GEYCDLCxZFz5WkAkYbqMI0LB3q3thwuLgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605567; c=relaxed/simple;
	bh=JjKcBTKshu1Ji5Ll7/saMPTAduNmb3L8bF6z2yilPGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRtfwrY8UL/rm7Uze+Dfw9Mw1Sq3DxR6YfN5G1RFMfdYbmz6n/+ajAg1OH1Nvgx+aRaP5ZkA7qSLxR2qQ93lxc2jJ3kNmZwJxIgC0Gr/Tncne5YMYZEalFgIgIhYkvT3sz0XnBa6VlKwOB57ZykYMqJ4riGCJm8+GOVm/zCQB3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jO2bB2MX; arc=fail smtp.client-ip=40.107.44.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUzwFeP89lCA0P5qvCROWNVtCXEc8L+kuUGGfoN6zdx7Sn8zkVm1pQo4wZBpnFzPkFYK0JXWYR1+5QZQbq5mSKoLrlAEjIchiR+LVvrOwWufM5cWck6Put7uafs/f89X1sMesRXhNf2PGZbuSgh8yHcb2q46OicmIQdq28x/QV0jWXbRVTsNUpla7JMVEh8XqSeU8TKRszVUdeaIeB8OhyUHXAYYPTcdjw1H7teCmL9thvIjftj6fCt45xpAqOwhR2ozSZcF9DxcBU8ojD3xw9XehR/AlI113T8oQJp486e6FuFSsTyXTomYvu8vptp1OkVMUQFIH63fhkJhUqyb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4TcJXS//9f4rA5C0Dg5K/ZP/rhc9J6e9wHQCR3VXrc=;
 b=C4rqaBnoSvwYzsRLJsFE3TxjiQuW6RPHhgjklql2Gr1QUrt1Fg7JfHeAjTtM83Yh+PCuT1WOmGOWbwEUS4zBm2aeSCsLHsq6yMRCvbc+9wTLlSU2aW4FNXqzN/fzsldqAV3Ai7QuyStVKI675WVl+E8Ym3xMD1YrbiA9IvOyDmn0N9+Q7jWU9A1FtgVXfx1JPq4uDY7/fEN/Cja9ZRpDkaUO9PFwSD/mxyrsd+ozGgeOe/2rKNYYqyXCZrwfhgKDHE7dzkDwFBcANV8Pe7Qb+u77mLxLMkR8HDqQlN93kzfwRYq5yljvwexxm1MEmcBVdEvdwDJlaWEWmVdsJCxrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4TcJXS//9f4rA5C0Dg5K/ZP/rhc9J6e9wHQCR3VXrc=;
 b=jO2bB2MXpIWatXYBlsqqRGs8b4ErGK0Dd6Vg6u/yPvSm8bMcaj4XE4ST7H+QbeThvuhvFDSJ8PJfu8kd6gUv5wX9bpXuNpI2QfEPvMKaIXI/Q43YatTIiLISZFspvRh0CYB6z4ur9UJJm0nHrMAQbrubhjYEAbr/zroFmc8CpkqelGodtiBaoIECYbp5gJ8FwpVfgJXiakG3iBfHpIloUNeYQi30ohFkBQdRzP5zLJnjopIuan7xQUnzecWAp3qA7mq+i/WTnDRxuCvN96cHo8A+u9n9io+ydO8oK6tz2OFDjm+fmUqwwH6A83y3NTQ+Ab3txjmd46FjCD76pnp1SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6828.apcprd06.prod.outlook.com (2603:1096:405:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:12:41 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:12:41 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Rotem Kerem <rotem.kerem@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK (iwlwifi)),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 2/2] wifi: iwlwifi: pcie: Remove redundant header files
Date: Tue, 19 Aug 2025 20:11:52 +0800
Message-Id: <20250819121201.608770-3-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819121201.608770-1-liaoyuanhong@vivo.com>
References: <20250819121201.608770-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fdccb2-3da3-43f0-e807-08dddf19b209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sn0srrY072lcBPHO9vrBOcbmtKI7lvlTImh8wcE03bAGDhru16zoqcQKnxXd?=
 =?us-ascii?Q?OGEj4F85sXwQ0s7WAxk/MFO83T6bDii4mMHW0x7hw7jAVY7uDHegBdQBxl2o?=
 =?us-ascii?Q?rq8H/YC/X/hSjzaYWA4bQ1jN8LaATSXSYlfSokqCvOoafxpfuZW1Y14OOnAn?=
 =?us-ascii?Q?pA5e4QCX1qD9xXzmDvtxbcPayyDHSuRF0VafX0U9lbyUxSWUkg3B4WyScRht?=
 =?us-ascii?Q?1La9WgUqMKcVo/Zklq42wAPONlWdlxmglyfrG3ylBqUHWpoiEPh5fX8bkPRR?=
 =?us-ascii?Q?qdHD/ohL0A25vai2R3hBqobYEzUERQOXKSbAg0G+m/GkdZvN/xoBUWH/e8i8?=
 =?us-ascii?Q?W0MPk4jgoihaP2JZ9tv99on0XQAbhLZNYBh1lOIERYM2Up/EsDJEnkUN5TeS?=
 =?us-ascii?Q?tANWa7l/j5dGXqGDyBD0UKTHABiWvKPFEH+wbe7zVdumpdBS5S3EmIpRVcCe?=
 =?us-ascii?Q?hO3+kOZNUy6brtEcMaCvQdYI85uzDMD9PYcQXURqgVrF0h4hYELHz8BaT1Rb?=
 =?us-ascii?Q?9JR2K1Da6Rzn74b9a/Ag2DG3p1jo1cUVNKGb842TLezU3sJJ8LUpOEB+uDq1?=
 =?us-ascii?Q?qO0lJ7lFl3SpBaZdmQi0c6d30nQk0RZx6Cnpu8kHwzUSocqhrDGlnseWnojG?=
 =?us-ascii?Q?wFKMOydUtapIWRt9XqoDiQUa3VLvywbeql2rswWDlz8lFstfOc2iYMRiFuZt?=
 =?us-ascii?Q?EG2AG4rOFzp/HQBMy5uBe58fuJ3c9IN9+408Boox2/X5M35xp+DaZmvGbkwC?=
 =?us-ascii?Q?QkqppoWyDtP4V63yp5cF616r/XXED1EUaBmke40QFsXpA3x5aRernyotnK6H?=
 =?us-ascii?Q?sszbsbHqIbvmN2zC4eIuOjb5xE4dQMu3iXz5tkyXBu+21mJ19TuwVCQjl4cQ?=
 =?us-ascii?Q?tm40JhF26PlAjF1c0UKWIwveMZ0BcMxtapwOMxfuUjKCtlVHbstTJQ2rlDo5?=
 =?us-ascii?Q?M1iPnbivFjUPRX6ahPhxrF16Tbg54WV3NeFWmoAVH/lJqJiYS8QQkYARTNY7?=
 =?us-ascii?Q?jyfacp06R3KD5dcCfD0I38HtWKRtBCsWOM0v4OISNCx3Jz9uTmEpvcobXO1Z?=
 =?us-ascii?Q?tkwqsW+2/umViwmZ2O8iYVrvTvKCCMEH1I9XaNif3wigPd30PHq1Cu6Kma6o?=
 =?us-ascii?Q?pGhHtr0zVICQbdetiCQsjUjvJ1at2X1zwbNAVDuQ84WOPPOnY84ogFCIYrv+?=
 =?us-ascii?Q?PI5DmT/DE44vlQ97uEnVipINgcgTU29GwQ2temlQcWiMRilQVaIbEJyR302Q?=
 =?us-ascii?Q?xYbOpdJppwCUgIk/fKd5QNs1WEA1YR3VJmWmoIS6KC3bFiVaSUyFstDuTUbj?=
 =?us-ascii?Q?fNjdw7zhfZ/zH01fgW/Bsn0VCv0bCERzwcfk3Rm++yGPaAbv1M5wj4dn0H1D?=
 =?us-ascii?Q?26deRoqpOz/mRRtUOXD7vhk7hQombLmuNPRwI5iw8WnNrEfLCog/QmN6DBar?=
 =?us-ascii?Q?Ey0X6y07efoxgMPL+fFlnIOFrt5WzXqA4Fk0Xms9vTIWEgZYNPiN+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZB0Ow84UkvWY2FHYnUvpxwtFx0b3auDS3dyd8qHmjisKZrZiXmmCK65xFhjj?=
 =?us-ascii?Q?B76QNvdnYrgFY2p1us7ghFN6JQjr/DzNWtW3Fu1tJolOvhJqLE5l8udlTmqk?=
 =?us-ascii?Q?CXXJ5ru21o14SOJxaTTD1yxoag7B6xwUNIKyfXJBBXYCkZaDRJJTjt27Swn0?=
 =?us-ascii?Q?eS7FDefVex3S/i5QnnsBaaURO5shwXCieQYMyWHExwsfwU7jhvnstkXG3+tv?=
 =?us-ascii?Q?QK9t3JSVrkHEJuKu8ZnccHcv4vi+LDrxRxNtgOBxH9UouVAi3kCdW/2llApA?=
 =?us-ascii?Q?Oebr4A0tjPdQZCiYRvavxWCEgrnJp0zcc507ZVNATkIUrXhosejmZCxro0mk?=
 =?us-ascii?Q?bmE4rdUDD9xWGNXe5omFiHqH+6uZZazqpBI0yx0KNmOV8xihHGKYjdUxRgws?=
 =?us-ascii?Q?wnq9CJNMrsGqSOyLJfgQZ9zAJJczfoQiAGPf6WSnIrSfHx1WtDsbXnadZiZl?=
 =?us-ascii?Q?d1gTHbvDc4zz/kCPuNRruTuIvtm+klvR5XtnPSBzoNEPdu6vU1l5kOT5dsew?=
 =?us-ascii?Q?+CK6kMw714+h6q5JykRPPMIS5G+4Y8awwEg5jxrFVtYMCPo8hzAzJ1MA9muq?=
 =?us-ascii?Q?zqeLe7pGBWtyjdxJzbh1dB+P1mTlNN4B0Wo7srD0aIY0iNrOu3AnLsHkYKWU?=
 =?us-ascii?Q?M+WdRPwiO+t+N21Uq9BOVlSitaenOOJ1S96jNN4dQXwoeT82NxX2tAAIqItw?=
 =?us-ascii?Q?0cDL3JLyJM+4BqGBG8mofCxANTPb/oyZhWPAArcLNX6fbXhVnbA1ljOhB/z9?=
 =?us-ascii?Q?E7MU4KBkl2JIXL4cORWQs6UQRPUQJDuroE2vV3AxtcorcY1mX5y7cj+pss4+?=
 =?us-ascii?Q?Vs23fulDhZTBo/cG4rwQj9CIPikDIQbZhdSpXNWLsdVHIsF36HddvzTikM0S?=
 =?us-ascii?Q?XHzXs6Ex3yhrBVxkDVC9QfRIuoHZXkAyajR1s8hjudyRocOwYWjeDo3WL4vQ?=
 =?us-ascii?Q?3NWfc6BxXovNMqm8du0V0zlMnGP3m+3lZyJCoRpJWMzZnWpIj9bBNTQoiQEH?=
 =?us-ascii?Q?cGL133087qeRjgLJQwqYOu5bv9jMyFt8mEpe5CPao0AIdAMiRBQRSgGMvlpS?=
 =?us-ascii?Q?iwX/3ivN4arXt2u1McW8wD/xQRU1cioz84RJbqeJoebe/I9PRdx7gy7+gMxB?=
 =?us-ascii?Q?aYKn1z1Mt2w0CxgXni5UgM5DNQUmozT9LAdDwYO46jtumR3BlzItRhmjjlii?=
 =?us-ascii?Q?sdtJS+E9J1kVvx2snYd+1bQQdHeoyjB+oLRq9gHyQ7nB4Jk4miQcbFL6oeGH?=
 =?us-ascii?Q?s4XHY8H+8b+c1lrhSInmLDt5NwTe4zryAWYrLFb/osPCcgFBAo1hsX9utgr6?=
 =?us-ascii?Q?0C6XVpkmORlgULcR3ApO00FrwP5JNEqCzCjfc+SJKpbPEPgCDsYCbUmCTyyb?=
 =?us-ascii?Q?OwyTpx46fgMfaggD86uwEA9/8XQWHRV6lCXohRg4XkX5KY/20AiN++tvFC0i?=
 =?us-ascii?Q?vZ5L3MT4C6Txw8f+smo1ozuCJQYZUZdAu+4jiHdPg9FJsNpE5WvDqztLLOSZ?=
 =?us-ascii?Q?+Weuk+3T5Zborvz40jWyhMinxlHg+27Cff58Ls/pdFUa7cirajYVxKp+wCvu?=
 =?us-ascii?Q?lFQXXffx10C/TsVBP91ui8jr16dKUyjtrF/5uDqG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fdccb2-3da3-43f0-e807-08dddf19b209
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:12:41.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdG48vQJ+IwrQH+oNOke6prr2EBWgeMX3P/T0GbWs89q2MAHdB0/r2Uk3XIsBLUzRs+QxbdsYpNFQPj5LyQVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6828

The header file "fw/api/tx.h" is already included on line 26. Remove the
redundant include.

Fixes: 0b261b014a99f ("wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 327366bf87de..49237ffe8c88 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -25,7 +25,6 @@
 #include "fw/dbg.h"
 #include "fw/api/tx.h"
 #include "fw/acpi.h"
-#include "fw/api/tx.h"
 #include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
-- 
2.34.1


