Return-Path: <linux-wireless+bounces-32522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA2yHWeXqWlKAgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:47:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7C213C88
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36B8C30DA164
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327D3A8FEA;
	Thu,  5 Mar 2026 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C1sULyz/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6513A7F4E;
	Thu,  5 Mar 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721716; cv=fail; b=eHSb0oUUfOB+NQjwzZzWoF+n+2PqyavhYESZZbNO0+hCXBhY+E5ap1IgJRIGtH1fGocFW/mlZOG/Xos69Ikkf+LLijvBxnmtywN0ksVyqqH+VLWYpkxER804J/414H8IaOWELE2O3nExvEdtcBcNo+2hNOWN+SOVNJpIJCsafCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721716; c=relaxed/simple;
	bh=Hy9joNDmb/WhWnaIFH/8POzf3R21m9cZny/TwTkLD/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=la6J5S1uevUbt/E4bGce9eDGboFe4RHuYPo9basQlofxJEPi/b02QhbGy8cP6wzu8JFPbLsdIyRATYpa0uSvp2JPvq2yaiHfGqmYBPnOLuljG4/zoIH4CvK1CNLAygHBqEIjMUPkf93FBHg5VzVoQLZfpyAmweeO3j6Wei/lXSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C1sULyz/; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSct+9GPhgBT2Y8IWqujWk3gLIIPPeg6zaHEPnKy1j+/iTUonHShhNN+oo3NIEelqhnXbUHC/UZQfQqgHkOuhvLLvaOq2Kq+sv6u95AVbZjM9WNK0JTEl3OlcC1C+zhYw82VqoL5UiTTULwCsoN9bSrAewjR+4n51lLySowFFGgah39BgUrv8Ug3higIza7XsdFUYPlR1YXLiEPgn8bL4XmKVE6CZwVyNcbUwEYCxLIxC5JQa+z+XpzYUlQo/8wbOv9dNqazZGatlTQb1+lN5XK82Hs0OhoykLgwA4f1fZtJHiEAzFWROaKUBuEko/2jYLPR9F0gr8PI4/haJms0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPF25ra8UzK9EV+KfJy4Kpyg0a4ayxqBFM5qiy/tTbk=;
 b=sS2QCSWJzOn5FeVT1toylemnrRp31u8FT88A8jcaqRETOeAczjULV4IC2dShVbyMEUh7e0eVCbX1XJ0+Dtl/iqJQcCEs/AlsrjveStZg2F/IpmTeyxj6Vkw76pkMOZ7NzMdQRGbrUqCJ3k+OL1y+FKYJAPWY6OPc2/V32ZsnXiEsDCC8kdaLw3LWds/bgU4G0/nfSdIOJS7qqLk/Fi1uTTAwXOFumrepAElY0Ks/7C5Gire95A0BZyVrVAOCMdOzNyL6JShwFVKG67sUxWBauf5xNcYVf8FGfWAgcYZQRHeo4j9kzYMqEpkF/ifMG0pbrCD3CQwx2t7gbbS982dMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPF25ra8UzK9EV+KfJy4Kpyg0a4ayxqBFM5qiy/tTbk=;
 b=C1sULyz/3gFH8ROYPda8GdfoUK07A6qhkNnKu12knX8Ed3FGOAxomSy5Dnq9vuvG8vIB2Xy6e5hQOVZYIK1hIkFUUPxnTJExKcFbM2ibVvLrITu5RztmsPvnF36UEHal87tTgm13FVpmzb+47IyXQnRoNG9amu63MM5X0BG3TZYYg2P8DcQj4yzCWjBM2bDORxfzoSmbKAV8WIYRSKVyUVBG9KJz0u9L3SvOP/e+5Z5wy00XgfdbZHBAeprmGr4HYd4GQGeHZFnF8EfnHTLKoyYih5EIw39YeqW9TXb+RojSFGCEDu5VxVX6lC0HigU8FQw2on3lGJlFiFWoAPtyng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:41:50 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:41:50 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 01/21] wifi: nxpwifi: add 802.11n support for STA and AP modes
Date: Thu,  5 Mar 2026 22:39:19 +0800
Message-Id: <20260305143939.3724868-2-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cebef6-d680-4315-a625-08de7ac555eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	x0vQ7VBhBbGZu6nnsP56VzCu8uj6JskzRU8u7TBm9Itq2zK0n9uIxxLiFN4hm+e+qtB/JpZXVuJOvam8A2fhfjc7OEzhpdLV4M5sK0fFe60oqKz0ktgEzRiF57KdWUQgZAB3q6Y1yrkyeGqHP7UWpTEcUKL7rvlLVC8hpGvWTGQGDSUU++3qhIINxj7aQ/U1ob5rCG1o1xHuHQBAoob0kWBWlVAbgYDL+AXTMRFm7j/5EIDx3YyXv33H9NnLIpy4Y5PmQVFFAxZ6PufP+R5lcnfc3WDayFKCmFw3dVnRWVWwGOqr7PylxM8xLA6tzfEze9KvHQDKKtxPe5ctJxuyFpG9T3hk2mz8mfQ7dSwfSlJdMvzMoy/KHNqLJiYrk7ZYK2f1W1/opG8GYwY+qJjKvw/d3G2nCnyKrfLED6zMiwJ0S9XoqgPoOsIz/nMQG5aLuFMOLhCSd2B/1GmmevmjJiSaeBHixtP6NQCFlyQ8Q1ir/k8UyJCaDVNL2GTjvZHn+qyLWi2vjR1ZqiBx3c1qa6vhgqBU7M5QOwY0FgklTTopMHPLoZ3q331xdyqI5cydEIm2R53uy72/inkuNEu+wyqdjx7Ozinem4nerCPoVgdLibvr+kqKGGbGUo5H+lR7JBiaKXP6eLUYAljC3ZSqfvG+OnTXGZlTBTNq1ZtHXeJonjaiUZXHO2xuEJRl0LWcHL4jB+OlVmeZ05yYau6yaaFV1eKctmovqQ/J9Gcou9LbIUWOGP25merRM0l/MAEpcGNFxzMrIcEu3fEpj4VcpHir2NXDNMnuvtoJXftTtWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0SlrLimMrk0G83Z7z52FQc5uSggxAJfkgi1ke3AWARuKzQ2NrzdsEIdXUN7?=
 =?us-ascii?Q?pPeImo82Hg+OMQTLycZBQFH4q0QB87wG4oCrDMhfE3Lgokro040QYRs8+t6o?=
 =?us-ascii?Q?XeGWQzlSU0iDfhpT5e7easBIODBc1nNhgQsioiKgAECkYSsteZiYZsSei70/?=
 =?us-ascii?Q?lLcm239uG23v1YTySMm4A1BDyLCgI674dCibtN5VpyS8L0ixCkCly1Uoz9+E?=
 =?us-ascii?Q?Ov3lqNnScAW04ExJ8tl5OZCUVWh7ob2CXRlQ5HvLruIplPWATM0ycq7RpEEK?=
 =?us-ascii?Q?btCqrZXYyX76+RbhM0WNbg4eoKZMnUTSB+qvAM9XCBYWXkH/63lOHHR/f/Hk?=
 =?us-ascii?Q?AHWSHX3LouogjXBvwXfcmWyViy/iUvhlpUF5syoDnltU5rhztitJP7e0IA7X?=
 =?us-ascii?Q?44abFJp8M5KENFVoGBpn1HZZ0NQBsIcBAM/9BD31S63bkljMAal/VoaOYZSa?=
 =?us-ascii?Q?E5mGS48sxI4R6Ffn9XulioQKyjkhU8OvrPzY1AW2E6j0Sa5r09YhWqlNPHLw?=
 =?us-ascii?Q?tjBP3YVvHA38r1spHI1LHIFcUkQAd7vTApeE29Qny/YIoT610pYwaZ9qYhCW?=
 =?us-ascii?Q?z8Vp5xY6XhG+CprKuHgU3ZUxD0dOVD2OFX4UYexAwKlF/Oi7dhCi3FH0o/oH?=
 =?us-ascii?Q?QbncHA33DmV1VV7UVK2gQQq4Fel2WcIEFo8mPj5rRIDsNX646MoXMrimNgZD?=
 =?us-ascii?Q?J7+FWL+EXWb4OcqfKVFi1sEhIqBwqwYp6JjYPuzzJfGd8yFt4VYYbL/Sa9FC?=
 =?us-ascii?Q?TkTDTmnoz0vymc11N0IywXdJu5B9DcDTFUCflplcioLHdtdls9zrMMCkcEwD?=
 =?us-ascii?Q?ISbp12DWMThZRtmATKF4gN546bKiaSsc3MhH/wDxSsRiYFbYtIB5gqGPsirb?=
 =?us-ascii?Q?kDzU79nqhJT10ArD3/kip4tLSUOqIz90okUa2vLznHhnV4w1RYdi1M/+XOys?=
 =?us-ascii?Q?bkg+bpugSdHU4TEOR8M0yPE3hE9/ENlXTOCm66aZujO3jiIoCPnhPkdoXkuZ?=
 =?us-ascii?Q?qPfgNVdejQqrcS0pvuwgrxaAv8YV9MCVO0rgWOiXWHXiTpfGb/HK0o9Hb1RQ?=
 =?us-ascii?Q?DdKD0V8p5uGAB/CjEtz7F/lXWwNd73hpap/GYhH0/h03vRwZU+EKv4ptGdvW?=
 =?us-ascii?Q?ukkMlNKu4B5MCO9h698kjdI0EbGM/XyvgEToOyERDjgwNHWBWVYyGPXgQWjt?=
 =?us-ascii?Q?Bup9jAeo8hh10ZZOgmIAUTNU2d5wvHZx1qezeWRY+/f0sHg9uvu/S/PhgcxR?=
 =?us-ascii?Q?mcQ/U2IF3/FzLRpWqMwef7qUoHbbxPDyWSY+4qs6BNTqY46MkVD+F2rvitFV?=
 =?us-ascii?Q?w/cnjSmuXBO7Hd97kVR9Zy3tNKzKEUnO0Balb78XXwnIc/9wMOyAIvEryFPx?=
 =?us-ascii?Q?eTYiN9wE3FSsMxyKrgM8cemZ2XyvLGfXt/6TC7Pn3rBqQs7va55ZqdHd49p/?=
 =?us-ascii?Q?OCygYOjxOTPIQp7d/xJy0uAT9v3VCm+y8VW5ueoWaADS1xlNRQUSlOtx5z41?=
 =?us-ascii?Q?yLBTvNMt0nzKVh++TcoU1TU3n/bZKOjMT5frmWV2x/+/d4tOuQ9hhLwpxViL?=
 =?us-ascii?Q?UCJdt4408egN4xPtYSsiT6CTzQ4D0+xKJV4NEjkfLuHPCUgkRZM60n/L5uSi?=
 =?us-ascii?Q?MzS5+Kk5QRZSClLKUCvdfmGDYZB3NCpI55n7S9MUaVp43m8QutLs4kWtv91V?=
 =?us-ascii?Q?+PaTAWSXyvoWH02lC3yM1wT5thDk0tar5eK7wYxr/lVTnWjiZCOd9PtW3Hrf?=
 =?us-ascii?Q?GroFR4XEsQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cebef6-d680-4315-a625-08de7ac555eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:41:50.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/uIpGAZt+yXDW+Ch/wog9uRU/VEKSSFTbMBr4HNhum2h/8b1/BmjWAaqOOf4FpMfY88Fy/UM7AuZw7x9COp9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: F1C7C213C88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32522-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add 802.11n functionality to nxpwifi, enabling HT capability negotiation
and configuration for both STA and AP roles.

Convert HT elements from cfg80211 into firmware TLVs and append them to
HOST_CMD_802_11_ASSOCIATE when operating as a station. Generate the
corresponding HT elements for HOST_CMD_UAP_SYS_CONFIG when operating as
an AP.

Implement AMSDU aggregation and blockack reorder buffer handling in the
driver due to firmware resource limitations.

Add the required logic and files to enable 802.11n functionality across
both roles.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11n.c        | 837 ++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        | 158 ++++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   | 251 ++++++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |  21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  | 826 +++++++++++++++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |  71 ++
 6 files changed, 2164 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n.c b/drivers/net/wireless/nxp/nxpwifi/11n.c
new file mode 100644
index 000000000000..e46c5053d509
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n.c
@@ -0,0 +1,837 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi 802.11n helpers
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11ax.h"
+
+/*
+ * Fills HT capability information field, AMPDU Parameters field, HT extended
+ * capability field, and supported MCS set fields.
+ *
+ * HT capability information field, AMPDU Parameters field, supported MCS set
+ * fields are retrieved from cfg80211 stack
+ *
+ * RD responder bit to set to clear in the extended capability header.
+ */
+int nxpwifi_fill_cap_info(struct nxpwifi_private *priv, u8 radio_type,
+			  struct ieee80211_ht_cap *ht_cap)
+{
+	u16 ht_cap_info;
+	u16 bcn_ht_cap = le16_to_cpu(ht_cap->cap_info);
+	u16 ht_ext_cap = le16_to_cpu(ht_cap->extended_ht_cap_info);
+	struct ieee80211_supported_band *sband =
+		priv->wdev.wiphy->bands[radio_type];
+
+	if (WARN_ON_ONCE(!sband)) {
+		nxpwifi_dbg(priv->adapter, ERROR, "Invalid radio type!\n");
+		return -EINVAL;
+	}
+
+	ht_cap->ampdu_params_info =
+		(AMPDU_FACTOR_64K & IEEE80211_HT_AMPDU_PARM_FACTOR) |
+		((priv->adapter->hw_mpdu_density <<
+		 IEEE80211_HT_AMPDU_PARM_DENSITY_SHIFT) &
+		 IEEE80211_HT_AMPDU_PARM_DENSITY);
+
+	memcpy((u8 *)&ht_cap->mcs, &sband->ht_cap.mcs,
+	       sizeof(sband->ht_cap.mcs));
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
+	    (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+	     priv->adapter->sec_chan_offset != IEEE80211_HT_PARAM_CHA_SEC_NONE))
+		/* Set MCS32 for infra mode or ad-hoc mode with 40MHz support */
+		SETHT_MCS32(ht_cap->mcs.rx_mask);
+
+	/* Clear RD responder bit */
+	ht_ext_cap &= ~IEEE80211_HT_EXT_CAP_RD_RESPONDER;
+
+	ht_cap_info = sband->ht_cap.cap;
+	if (bcn_ht_cap) {
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			ht_cap_info &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_SGI_40))
+			ht_cap_info &= ~IEEE80211_HT_CAP_SGI_40;
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_40MHZ_INTOLERANT))
+			ht_cap_info &= ~IEEE80211_HT_CAP_40MHZ_INTOLERANT;
+	}
+	ht_cap->cap_info = cpu_to_le16(ht_cap_info);
+	ht_cap->extended_ht_cap_info = cpu_to_le16(ht_ext_cap);
+
+	if (ISSUPP_BEAMFORMING(priv->adapter->hw_dot_11n_dev_cap))
+		ht_cap->tx_BF_cap_info = cpu_to_le32(NXPWIFI_DEF_11N_TX_BF_CAP);
+
+	return 0;
+}
+
+/* Return BA stream entry that matches the requested status. */
+static struct nxpwifi_tx_ba_stream_tbl *
+nxpwifi_get_ba_status(struct nxpwifi_private *priv, int tid,
+		      enum nxpwifi_ba_status ba_status)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl, *found = NULL;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr[tid], list) {
+		if (tx_ba_tsr_tbl->ba_status == ba_status) {
+			found = tx_ba_tsr_tbl;
+			break;
+		}
+	}
+	return found;
+}
+
+/* Handle DELBA command response (recreate or continue ADDBA as needed). */
+int nxpwifi_ret_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp)
+{
+	int tid;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+	struct host_cmd_ds_11n_delba *del_ba = &resp->params.del_ba;
+	u16 del_ba_param_set = le16_to_cpu(del_ba->del_ba_param_set);
+
+	tid = del_ba_param_set >> DELBA_TID_POS;
+	if (del_ba->del_result == BA_RESULT_SUCCESS) {
+		nxpwifi_del_ba_tbl(priv, tid, del_ba->peer_mac_addr,
+				   TYPE_DELBA_SENT,
+				   INITIATOR_BIT(del_ba_param_set));
+
+		tx_ba_tbl = nxpwifi_get_ba_status(priv, tid, BA_SETUP_INPROGRESS);
+		if (tx_ba_tbl)
+			nxpwifi_send_addba(priv, tx_ba_tbl->tid,
+					   tx_ba_tbl->ra);
+	} else {
+		/*
+		 * In case of failure, recreate the deleted stream in case
+		 * we initiated the DELBA
+		 */
+		if (!INITIATOR_BIT(del_ba_param_set))
+			return 0;
+
+		nxpwifi_create_ba_tbl(priv, del_ba->peer_mac_addr, tid,
+				      BA_SETUP_INPROGRESS);
+
+		tx_ba_tbl = nxpwifi_get_ba_status(priv, tid, BA_SETUP_INPROGRESS);
+
+		if (tx_ba_tbl)
+			nxpwifi_del_ba_tbl(priv, tx_ba_tbl->tid, tx_ba_tbl->ra,
+					   TYPE_DELBA_SENT, true);
+	}
+
+	return 0;
+}
+
+/* Handle ADDBA response; delete BA stream on failure. */
+int nxpwifi_ret_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp)
+{
+	int tid, tid_down;
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &resp->params.add_ba_rsp;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	u16 block_ack_param_set = le16_to_cpu(add_ba_rsp->block_ack_param_set);
+
+	add_ba_rsp->ssn = cpu_to_le16((le16_to_cpu(add_ba_rsp->ssn))
+			& SSN_MASK);
+
+	tid = u16_get_bits(block_ack_param_set, IEEE80211_ADDBA_PARAM_TID_MASK);
+
+	tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+	ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down,
+					      add_ba_rsp->peer_mac_addr);
+	if (le16_to_cpu(add_ba_rsp->status_code) != BA_RESULT_SUCCESS) {
+		if (ra_list) {
+			ra_list->ba_status = BA_SETUP_NONE;
+			ra_list->amsdu_in_ampdu = false;
+		}
+		nxpwifi_del_ba_tbl(priv, tid, add_ba_rsp->peer_mac_addr,
+				   TYPE_DELBA_SENT, true);
+		if (add_ba_rsp->add_rsp_result != BA_RESULT_TIMEOUT)
+			priv->aggr_prio_tbl[tid].ampdu_ap =
+				BA_STREAM_NOT_ALLOWED;
+		return 0;
+	}
+
+	guard(rcu)();
+	tx_ba_tbl = nxpwifi_get_ba_tbl(priv, tid, add_ba_rsp->peer_mac_addr);
+	if (tx_ba_tbl) {
+		nxpwifi_dbg(priv->adapter, EVENT, "info: BA stream complete\n");
+		tx_ba_tbl->ba_status = BA_SETUP_COMPLETE;
+		if ((block_ack_param_set & IEEE80211_ADDBA_PARAM_AMSDU_MASK) &&
+		    priv->add_ba_param.tx_amsdu &&
+		    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+			tx_ba_tbl->amsdu = true;
+		else
+			tx_ba_tbl->amsdu = false;
+		if (ra_list) {
+			ra_list->amsdu_in_ampdu = tx_ba_tbl->amsdu;
+			ra_list->ba_status = BA_SETUP_COMPLETE;
+		}
+	} else {
+		nxpwifi_dbg(priv->adapter, ERROR, "BA stream not created\n");
+	}
+
+	return 0;
+}
+
+/*
+ * Reconfigure Tx buffer command.
+ * Set command ID/action/size; set Tx buffer size on SET; ensure little-endian.
+ */
+int nxpwifi_cmd_recfg_tx_buf(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd, int cmd_action,
+			     u16 *buf_size)
+{
+	struct host_cmd_ds_txbuf_cfg *tx_buf = &cmd->params.tx_buf;
+	u16 action = (u16)cmd_action;
+
+	cmd->command = cpu_to_le16(HOST_CMD_RECONFIGURE_TX_BUFF);
+	cmd->size =
+		cpu_to_le16(sizeof(struct host_cmd_ds_txbuf_cfg) + S_DS_GEN);
+	tx_buf->action = cpu_to_le16(action);
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: set tx_buf=%d\n", *buf_size);
+		tx_buf->buff_size = cpu_to_le16(*buf_size);
+		break;
+	case HOST_ACT_GEN_GET:
+	default:
+		tx_buf->buff_size = 0;
+		break;
+	}
+	return 0;
+}
+
+/*
+ * AMSDU aggregation control command.
+ * Set ID/action/size; set AMSDU params on SET; ensure little-endian.
+ */
+int nxpwifi_cmd_amsdu_aggr_ctrl(struct host_cmd_ds_command *cmd,
+				int cmd_action,
+				struct nxpwifi_ds_11n_amsdu_aggr_ctrl *aa_ctrl)
+{
+	struct host_cmd_ds_amsdu_aggr_ctrl *amsdu_ctrl =
+		&cmd->params.amsdu_aggr_ctrl;
+	u16 action = (u16)cmd_action;
+
+	cmd->command = cpu_to_le16(HOST_CMD_AMSDU_AGGR_CTRL);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_amsdu_aggr_ctrl)
+				+ S_DS_GEN);
+	amsdu_ctrl->action = cpu_to_le16(action);
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		amsdu_ctrl->enable = cpu_to_le16(aa_ctrl->enable);
+		amsdu_ctrl->curr_buf_size = 0;
+		break;
+	case HOST_ACT_GEN_GET:
+	default:
+		amsdu_ctrl->curr_buf_size = 0;
+		break;
+	}
+	return 0;
+}
+
+/*
+ * 11n configuration command.
+ * Set action, HT Tx capability/info, and misc config when 11ac HW is present.
+ */
+int nxpwifi_cmd_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_ds_11n_tx_cfg *txcfg)
+{
+	struct host_cmd_ds_11n_cfg *htcfg = &cmd->params.htcfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_11n_cfg) + S_DS_GEN);
+	htcfg->action = cpu_to_le16(cmd_action);
+	htcfg->ht_tx_cap = cpu_to_le16(txcfg->tx_htcap);
+	htcfg->ht_tx_info = cpu_to_le16(txcfg->tx_htinfo);
+
+	if (priv->adapter->is_hw_11ac_capable)
+		htcfg->misc_config = cpu_to_le16(txcfg->misc_config);
+
+	return 0;
+}
+
+/*
+ * Append 11n TLVs to the caller-owned buffer.
+ * Caller allocates space; no size checks here.
+ * May add: HT Cap, HT Operation + channel list, 20/40 BSS Coexistence,
+ * and Extended Capabilities (HS2/TWT bits when applicable).
+ */
+int
+nxpwifi_cmd_append_11n_tlv(struct nxpwifi_private *priv,
+			   struct nxpwifi_bssdescriptor *bss_desc,
+			   u8 **buffer)
+{
+	struct nxpwifi_ie_types_htcap *ht_cap;
+	struct nxpwifi_ie_types_chan_list_param_set *chan_list;
+	struct nxpwifi_chan_scan_param_set *chan_param;
+	struct nxpwifi_ie_types_2040bssco *bss_co_2040;
+	struct nxpwifi_ie_types_extcap *ext_cap;
+	int ret_len = 0;
+	struct ieee80211_supported_band *sband;
+	struct element *hdr;
+	u8 radio_type;
+
+	if (!buffer || !*buffer)
+		return ret_len;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	if (bss_desc->bcn_ht_cap) {
+		ht_cap = (struct nxpwifi_ie_types_htcap *)*buffer;
+		memset(ht_cap, 0, sizeof(struct nxpwifi_ie_types_htcap));
+		ht_cap->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		ht_cap->header.len =
+			cpu_to_le16(sizeof(struct ieee80211_ht_cap));
+		memcpy((u8 *)ht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_ht_cap,
+		       le16_to_cpu(ht_cap->header.len));
+
+		nxpwifi_fill_cap_info(priv, radio_type, &ht_cap->ht_cap);
+		/* Update HT40 capability from current channel. */
+		if (bss_desc->bcn_ht_oper) {
+			u8 ht_param = bss_desc->bcn_ht_oper->ht_param;
+			u8 radio =
+				nxpwifi_band_to_radio_type(bss_desc->bss_band);
+			int freq =
+				ieee80211_channel_to_frequency(bss_desc->channel,
+							       radio);
+			struct ieee80211_channel *chan =
+				ieee80211_get_channel(priv->adapter->wiphy, freq);
+
+			switch (ht_param & IEEE80211_HT_PARAM_CHA_SEC_OFFSET) {
+			case IEEE80211_HT_PARAM_CHA_SEC_ABOVE:
+				if (chan->flags & IEEE80211_CHAN_NO_HT40PLUS) {
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16
+					(~IEEE80211_HT_CAP_SUP_WIDTH_20_40);
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16(~IEEE80211_HT_CAP_SGI_40);
+				}
+				break;
+			case IEEE80211_HT_PARAM_CHA_SEC_BELOW:
+				if (chan->flags & IEEE80211_CHAN_NO_HT40MINUS) {
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16
+					(~IEEE80211_HT_CAP_SUP_WIDTH_20_40);
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16(~IEEE80211_HT_CAP_SGI_40);
+				}
+				break;
+			}
+		}
+
+		*buffer += sizeof(struct nxpwifi_ie_types_htcap);
+		ret_len += sizeof(struct nxpwifi_ie_types_htcap);
+	}
+
+	if (bss_desc->bcn_ht_oper) {
+		chan_list =
+			(struct nxpwifi_ie_types_chan_list_param_set *)*buffer;
+		chan_param = chan_list->chan_scan_param;
+		memset(chan_list, 0, struct_size(chan_list, chan_scan_param, 1));
+		chan_list->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+		chan_list->header.len = cpu_to_le16(sizeof(*chan_param));
+		chan_param->chan_number = bss_desc->bcn_ht_oper->primary_chan;
+		chan_param->band_cfg =
+			nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+
+		if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info) &&
+		    bss_desc->bcn_vht_oper &&
+		    bss_desc->bcn_vht_oper->chan_width ==
+		    IEEE80211_VHT_CHANWIDTH_80MHZ) {
+			SET_SECONDARYCHAN(chan_param->band_cfg,
+					  (bss_desc->bcn_ht_oper->ht_param &
+					   IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
+			chan_param->band_cfg |=
+				((CHAN_BW_80MHZ <<
+				  BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
+				 BAND_CFG_CHAN_WIDTH_MASK);
+		} else if (sband->ht_cap.cap &
+			   IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+			   bss_desc->bcn_ht_oper->ht_param &
+			   IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
+			SET_SECONDARYCHAN(chan_param->band_cfg,
+					  (bss_desc->bcn_ht_oper->ht_param &
+					   IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
+			chan_param->band_cfg |=
+				((CHAN_BW_40MHZ <<
+				  BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
+				 BAND_CFG_CHAN_WIDTH_MASK);
+		}
+
+		*buffer += struct_size(chan_list, chan_scan_param, 1);
+		ret_len += struct_size(chan_list, chan_scan_param, 1);
+	}
+
+	if (bss_desc->bcn_bss_co_2040) {
+		bss_co_2040 = (struct nxpwifi_ie_types_2040bssco *)*buffer;
+		memset(bss_co_2040, 0,
+		       sizeof(struct nxpwifi_ie_types_2040bssco));
+		bss_co_2040->header.type = cpu_to_le16(WLAN_EID_BSS_COEX_2040);
+		bss_co_2040->header.len =
+		       cpu_to_le16(sizeof(bss_co_2040->bss_co_2040));
+
+		memcpy((u8 *)bss_co_2040 +
+		       sizeof(struct nxpwifi_ie_types_header),
+		       bss_desc->bcn_bss_co_2040 +
+		       sizeof(struct element),
+		       le16_to_cpu(bss_co_2040->header.len));
+
+		*buffer += sizeof(struct nxpwifi_ie_types_2040bssco);
+		ret_len += sizeof(struct nxpwifi_ie_types_2040bssco);
+	}
+
+	if (bss_desc->bcn_ext_cap) {
+		u8 *ext_capab;
+
+		hdr = (void *)bss_desc->bcn_ext_cap;
+
+		ext_capab = (u8 *)cfg80211_find_ie(WLAN_EID_EXT_CAPABILITY, priv->gen_ie_buf,
+				  priv->gen_ie_buf_len);
+		if (ext_capab) {
+			ext_capab += 2;
+		} else {
+			ext_cap = (struct nxpwifi_ie_types_extcap *)*buffer;
+			memset(ext_cap, 0, sizeof(struct nxpwifi_ie_types_extcap) + hdr->datalen);
+			ext_cap->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+			ext_cap->header.len = cpu_to_le16(hdr->datalen);
+			ext_capab = ext_cap->ext_capab;
+			*buffer += sizeof(struct nxpwifi_ie_types_extcap) + hdr->datalen;
+			ret_len += sizeof(struct nxpwifi_ie_types_extcap) + hdr->datalen;
+		}
+
+		if (hdr->datalen > 3 &&
+		    ext_capab[3] & WLAN_EXT_CAPA4_INTERWORKING_ENABLED)
+			priv->hs2_enabled = true;
+		else
+			priv->hs2_enabled = false;
+
+		if (nxpwifi_is_11ax_twt_supported(priv, bss_desc))
+			ext_capab[9] |=
+			WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT;
+	}
+	return ret_len;
+}
+
+/* Check if pointer is a valid Tx BA stream entry. */
+static bool
+nxpwifi_is_tx_ba_stream_ptr_valid(struct nxpwifi_private *priv,
+				  struct nxpwifi_tx_ba_stream_tbl *tx_tbl_ptr)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+	bool ret = false;
+	int tid;
+
+	tid = tx_tbl_ptr->tid;
+	guard(rcu)();
+	list_for_each_entry_rcu(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr[tid], list) {
+		if (tx_ba_tsr_tbl == tx_tbl_ptr) {
+			ret = true;
+			break;
+		}
+	}
+	return ret;
+}
+
+/* Delete a Tx BA stream entry (after validating pointer). */
+void
+nxpwifi_11n_delete_tx_ba_stream_tbl_entry(struct nxpwifi_private *priv,
+					  struct nxpwifi_tx_ba_stream_tbl *tbl)
+{
+	if (!tbl && nxpwifi_is_tx_ba_stream_ptr_valid(priv, tbl))
+		return;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: tx_ba_tsr_tbl %p\n", tbl);
+
+	list_del_rcu(&tbl->list);
+	kfree_rcu(tbl, rcu);
+}
+
+/* Delete all entries in Tx BA stream table. */
+void nxpwifi_11n_delete_all_tx_ba_stream_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_tx_ba_stream_tbl *del_tbl_ptr, *tmp_node;
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock[i]);
+		list_for_each_entry_safe(del_tbl_ptr, tmp_node,
+					 &priv->tx_ba_stream_tbl_ptr[i], list)
+			nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, del_tbl_ptr);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock[i]);
+
+		INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr[i]);
+
+		priv->aggr_prio_tbl[i].ampdu_ap =
+			priv->aggr_prio_tbl[i].ampdu_user;
+	}
+}
+
+/* Return BA stream entry for given RA/TID. */
+struct nxpwifi_tx_ba_stream_tbl *
+nxpwifi_get_ba_tbl(struct nxpwifi_private *priv, int tid, u8 *ra)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl = NULL;
+
+	list_for_each_entry_rcu(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr[tid], list) {
+		if (ether_addr_equal_unaligned(tx_ba_tsr_tbl->ra, ra) &&
+		    tx_ba_tsr_tbl->tid == tid)
+			return tx_ba_tsr_tbl;
+	}
+	return NULL;
+}
+
+/* Create Tx BA stream entry for given RA/TID. */
+void nxpwifi_create_ba_tbl(struct nxpwifi_private *priv, u8 *ra, int tid,
+			   enum nxpwifi_ba_status ba_status)
+{
+	struct nxpwifi_tx_ba_stream_tbl *new_node;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	int tid_down;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+
+	guard(rcu)();
+	tx_ba_tbl = nxpwifi_get_ba_tbl(priv, tid, ra);
+
+	if (!tx_ba_tbl) {
+		new_node = kzalloc_obj(*new_node, GFP_ATOMIC);
+		if (!new_node)
+			return;
+
+		tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down, ra);
+		if (ra_list) {
+			ra_list->ba_status = ba_status;
+			ra_list->amsdu_in_ampdu = false;
+		}
+		INIT_LIST_HEAD(&new_node->list);
+
+		new_node->tid = tid;
+		new_node->ba_status = ba_status;
+		memcpy(new_node->ra, ra, ETH_ALEN);
+
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock[tid]);
+		list_add_tail_rcu(&new_node->list, &priv->tx_ba_stream_tbl_ptr[tid]);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock[tid]);
+	}
+}
+
+/* Send ADDBA request to the given TID/RA. */
+int nxpwifi_send_addba(struct nxpwifi_private *priv, int tid, u8 *peer_mac)
+{
+	struct host_cmd_ds_11n_addba_req add_ba_req;
+	u32 tx_win_size = priv->add_ba_param.tx_win_size;
+	static u8 dialog_tok;
+	u16 block_ack_param_set;
+
+	nxpwifi_dbg(priv->adapter, CMD, "cmd: %s: tid %d\n", __func__, tid);
+
+	memset(&add_ba_req, 0, sizeof(add_ba_req));
+
+	block_ack_param_set = (u16)((tid << BLOCKACKPARAM_TID_POS) |
+				    tx_win_size << BLOCKACKPARAM_WINSIZE_POS |
+				    IMMEDIATE_BLOCK_ACK);
+
+	/* enable AMSDU inside AMPDU */
+	if (priv->add_ba_param.tx_amsdu &&
+	    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+		block_ack_param_set |= IEEE80211_ADDBA_PARAM_AMSDU_MASK;
+
+	add_ba_req.block_ack_param_set = cpu_to_le16(block_ack_param_set);
+	add_ba_req.block_ack_tmo = cpu_to_le16((u16)priv->add_ba_param.timeout);
+
+	++dialog_tok;
+
+	if (dialog_tok == 0)
+		dialog_tok = 1;
+
+	add_ba_req.dialog_token = dialog_tok;
+	memcpy(&add_ba_req.peer_mac_addr, peer_mac, ETH_ALEN);
+
+	/* We don't wait for the response of this command */
+	return nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_REQ,
+			       0, 0, &add_ba_req, false);
+}
+
+/* Send DELBA request to the given TID/RA. */
+int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		       int initiator)
+{
+	struct host_cmd_ds_11n_delba delba;
+	u16 del_ba_param_set;
+
+	memset(&delba, 0, sizeof(delba));
+
+	del_ba_param_set = tid << DELBA_TID_POS;
+
+	if (initiator)
+		del_ba_param_set |= IEEE80211_DELBA_PARAM_INITIATOR_MASK;
+	else
+		del_ba_param_set &= ~IEEE80211_DELBA_PARAM_INITIATOR_MASK;
+
+	delba.del_ba_param_set = cpu_to_le16(del_ba_param_set);
+	memcpy(&delba.peer_mac_addr, peer_mac, ETH_ALEN);
+
+	/* We don't wait for the response of this command */
+	return nxpwifi_send_cmd(priv, HOST_CMD_11N_DELBA,
+			       HOST_ACT_GEN_SET, 0, &delba, false);
+}
+
+/* Send DELBA to specific TID. */
+void nxpwifi_11n_delba(struct nxpwifi_private *priv, int tid)
+{
+	struct nxpwifi_rx_reorder_tbl *rx_reor_tbl_ptr;
+	u8 ta[ETH_ALEN];
+	bool found = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(rx_reor_tbl_ptr, &priv->rx_reorder_tbl_ptr[tid], list) {
+		if (rx_reor_tbl_ptr->tid == tid) {
+			memcpy(ta, rx_reor_tbl_ptr->ta, ETH_ALEN);
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	if (found) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "Send delba to tid=%d, %pM\n", tid, ta);
+		nxpwifi_send_delba(priv, tid, ta, 0);
+	}
+}
+
+/* Handle DELBA event; remove BA stream. */
+void nxpwifi_11n_delete_ba_stream(struct nxpwifi_private *priv, u8 *del_ba)
+{
+	struct host_cmd_ds_11n_delba *cmd_del_ba =
+		(struct host_cmd_ds_11n_delba *)del_ba;
+	u16 del_ba_param_set = le16_to_cpu(cmd_del_ba->del_ba_param_set);
+	int tid;
+
+	tid = del_ba_param_set >> DELBA_TID_POS;
+
+	nxpwifi_del_ba_tbl(priv, tid, cmd_del_ba->peer_mac_addr,
+			   TYPE_DELBA_RECEIVE, INITIATOR_BIT(del_ba_param_set));
+}
+
+/* Retrieve Rx reordering table. */
+int nxpwifi_get_rx_reorder_tbl(struct nxpwifi_private *priv,
+			       struct nxpwifi_ds_rx_reorder_tbl *buf)
+{
+	int i, j;
+	struct nxpwifi_ds_rx_reorder_tbl *rx_reo_tbl = buf;
+	struct nxpwifi_rx_reorder_tbl *rx_reorder_tbl_ptr;
+	int count = 0;
+
+	guard(rcu)();
+	for (j = 0; j < MAX_NUM_TID; j++) {
+		list_for_each_entry_rcu(rx_reorder_tbl_ptr,
+					&priv->rx_reorder_tbl_ptr[j],
+					list) {
+			rx_reo_tbl->tid = (u16)rx_reorder_tbl_ptr->tid;
+			memcpy(rx_reo_tbl->ta, rx_reorder_tbl_ptr->ta, ETH_ALEN);
+			rx_reo_tbl->start_win = rx_reorder_tbl_ptr->start_win;
+			rx_reo_tbl->win_size = rx_reorder_tbl_ptr->win_size;
+			for (i = 0; i < rx_reorder_tbl_ptr->win_size; ++i) {
+				if (rx_reorder_tbl_ptr->rx_reorder_ptr[i])
+					rx_reo_tbl->buffer[i] = true;
+				else
+					rx_reo_tbl->buffer[i] = false;
+			}
+			rx_reo_tbl++;
+			count++;
+
+			if (count >= NXPWIFI_MAX_RX_BASTREAM_SUPPORTED)
+				return count;
+		}
+	}
+
+	return count;
+}
+
+/* Retrieve Tx BA stream table. */
+int nxpwifi_get_tx_ba_stream_tbl(struct nxpwifi_private *priv,
+				 struct nxpwifi_ds_tx_ba_stream_tbl *buf)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+	struct nxpwifi_ds_tx_ba_stream_tbl *rx_reo_tbl = buf;
+	int count = 0;
+	int i;
+
+	guard(rcu)();
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		list_for_each_entry_rcu(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr[i], list) {
+			rx_reo_tbl->tid = (u16)tx_ba_tsr_tbl->tid;
+			nxpwifi_dbg(priv->adapter, DATA, "data: %s tid=%d\n",
+				    __func__, rx_reo_tbl->tid);
+			memcpy(rx_reo_tbl->ra, tx_ba_tsr_tbl->ra, ETH_ALEN);
+			rx_reo_tbl->amsdu = tx_ba_tsr_tbl->amsdu;
+			rx_reo_tbl++;
+			count++;
+			if (count >= NXPWIFI_MAX_TX_BASTREAM_SUPPORTED)
+				return count;
+		}
+	}
+
+	return count;
+}
+
+/* Delete Tx BA stream entry by RA. */
+void nxpwifi_del_tx_ba_stream_tbl_by_ra(struct nxpwifi_private *priv, u8 *ra)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tbl;
+	int i;
+
+	if (!ra)
+		return;
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock[i]);
+		list_for_each_entry_rcu(tbl, &priv->tx_ba_stream_tbl_ptr[i], list)
+			if (!memcmp(tbl->ra, ra, ETH_ALEN))
+				nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, tbl);
+
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock[i]);
+	}
+}
+
+/* Initialize BlockAck parameters. */
+void nxpwifi_set_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_STA_AMPDU_DEF_RXWINSIZE;
+	}
+
+	priv->add_ba_param.tx_amsdu = true;
+	priv->add_ba_param.rx_amsdu = true;
+}
+
+u8 nxpwifi_get_sec_chan_offset(int chan)
+{
+	u8 sec_offset;
+
+	switch (chan) {
+	case 36:
+	case 44:
+	case 52:
+	case 60:
+	case 100:
+	case 108:
+	case 116:
+	case 124:
+	case 132:
+	case 140:
+	case 149:
+	case 157:
+	case 173:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
+		break;
+	case 40:
+	case 48:
+	case 56:
+	case 64:
+	case 104:
+	case 112:
+	case 120:
+	case 128:
+	case 136:
+	case 144:
+	case 153:
+	case 161:
+	case 169:
+	case 177:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+		break;
+	case 165:
+	default:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_NONE;
+		break;
+	}
+
+	return sec_offset;
+}
+
+/* Send DELBA to entries in the Tx BA stream table. */
+static void
+nxpwifi_send_delba_txbastream_tbl(struct nxpwifi_private *priv, u8 tid)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_stream_tbl_ptr;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(tx_ba_stream_tbl_ptr,
+				&priv->tx_ba_stream_tbl_ptr[tid], list) {
+		if (tx_ba_stream_tbl_ptr->ba_status == BA_SETUP_COMPLETE) {
+			if (tid == tx_ba_stream_tbl_ptr->tid) {
+				nxpwifi_dbg(adapter, INFO,
+					    "Tx:Send delba to tid=%d, %pM\n", tid,
+					    tx_ba_stream_tbl_ptr->ra);
+				nxpwifi_send_delba(priv,
+						   tx_ba_stream_tbl_ptr->tid,
+						   tx_ba_stream_tbl_ptr->ra, 1);
+				break;
+			}
+		}
+	}
+}
+
+/*
+ * Update tx_win_size for all interfaces and send DELBA when it changes.
+ */
+void nxpwifi_update_ampdu_txwinsize(struct nxpwifi_adapter *adapter)
+{
+	u8 i, j;
+	u32 tx_win_size;
+	struct nxpwifi_private *priv;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		tx_win_size = priv->add_ba_param.tx_win_size;
+
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+			priv->add_ba_param.tx_win_size =
+				NXPWIFI_STA_AMPDU_DEF_TXWINSIZE;
+
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+			priv->add_ba_param.tx_win_size =
+				NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE;
+
+		if (adapter->coex_win_size) {
+			if (adapter->coex_tx_win_size)
+				priv->add_ba_param.tx_win_size =
+					adapter->coex_tx_win_size;
+		}
+
+		if (tx_win_size != priv->add_ba_param.tx_win_size) {
+			if (!priv->media_connected)
+				continue;
+			for (j = 0; j < MAX_NUM_TID; j++)
+				nxpwifi_send_delba_txbastream_tbl(priv, j);
+		}
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n.h b/drivers/net/wireless/nxp/nxpwifi/11n.h
new file mode 100644
index 000000000000..039c45993f07
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11n support
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_H_
+#define _NXPWIFI_11N_H_
+
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+#include "wmm.h"
+
+int nxpwifi_ret_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp);
+int nxpwifi_ret_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp);
+int nxpwifi_cmd_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_ds_11n_tx_cfg *txcfg);
+int nxpwifi_cmd_append_11n_tlv(struct nxpwifi_private *priv,
+			       struct nxpwifi_bssdescriptor *bss_desc,
+			       u8 **buffer);
+int nxpwifi_fill_cap_info(struct nxpwifi_private *priv, u8 radio_type,
+			  struct ieee80211_ht_cap *ht_cap);
+int nxpwifi_set_get_11n_htcap_cfg(struct nxpwifi_private *priv,
+				  u16 action, int *htcap_cfg);
+void nxpwifi_11n_delete_tx_ba_stream_tbl_entry(struct nxpwifi_private *priv,
+					       struct nxpwifi_tx_ba_stream_tbl
+					       *tx_tbl);
+void nxpwifi_11n_delete_all_tx_ba_stream_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_tx_ba_stream_tbl *nxpwifi_get_ba_tbl(struct nxpwifi_private
+						    *priv, int tid, u8 *ra);
+void nxpwifi_create_ba_tbl(struct nxpwifi_private *priv, u8 *ra, int tid,
+			   enum nxpwifi_ba_status ba_status);
+int nxpwifi_send_addba(struct nxpwifi_private *priv, int tid, u8 *peer_mac);
+int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		       int initiator);
+void nxpwifi_11n_delete_ba_stream(struct nxpwifi_private *priv, u8 *del_ba);
+int nxpwifi_get_rx_reorder_tbl(struct nxpwifi_private *priv,
+			       struct nxpwifi_ds_rx_reorder_tbl *buf);
+int nxpwifi_get_tx_ba_stream_tbl(struct nxpwifi_private *priv,
+				 struct nxpwifi_ds_tx_ba_stream_tbl *buf);
+int nxpwifi_cmd_recfg_tx_buf(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd,
+			     int cmd_action, u16 *buf_size);
+int nxpwifi_cmd_amsdu_aggr_ctrl(struct host_cmd_ds_command *cmd,
+				int cmd_action,
+				struct nxpwifi_ds_11n_amsdu_aggr_ctrl *aa_ctrl);
+void nxpwifi_del_tx_ba_stream_tbl_by_ra(struct nxpwifi_private *priv, u8 *ra);
+u8 nxpwifi_get_sec_chan_offset(int chan);
+
+static inline bool
+nxpwifi_is_station_ampdu_allowed(struct nxpwifi_private *priv,
+				 struct nxpwifi_ra_list_tbl *ptr, int tid)
+{
+	struct nxpwifi_sta_node *node;
+
+	guard(rcu)();
+	node = nxpwifi_get_sta_entry(priv, ptr->ra);
+	if (unlikely(!node))
+		return false;
+
+	if (node->ampdu_sta[tid] == BA_STREAM_NOT_ALLOWED)
+		return false;
+
+	return true;
+}
+
+/* Check if AMPDU is allowed for the given TID. */
+static inline bool
+nxpwifi_is_ampdu_allowed(struct nxpwifi_private *priv,
+			 struct nxpwifi_ra_list_tbl *ptr, int tid)
+{
+	if (is_broadcast_ether_addr(ptr->ra))
+		return false;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP)
+		return nxpwifi_is_station_ampdu_allowed(priv, ptr, tid);
+
+	return priv->aggr_prio_tbl[tid].ampdu_ap != BA_STREAM_NOT_ALLOWED;
+}
+
+/* Check if AMSDU is allowed for the given TID. */
+static inline bool
+nxpwifi_is_amsdu_allowed(struct nxpwifi_private *priv, int tid)
+{
+	bool amsdu_enabled = priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED;
+	bool rate_ok = priv->is_data_rate_auto || !(priv->bitmap_rates[2] & 0x03);
+
+	return amsdu_enabled && rate_ok;
+}
+
+/* Check if there is available space for a new BA stream. */
+static inline bool
+nxpwifi_space_avail_for_new_ba_stream(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	u8 i, j;
+	size_t ba_stream_num = 0;
+	size_t ba_stream_max = NXPWIFI_MAX_TX_BASTREAM_SUPPORTED;
+
+	if (adapter->fw_api_ver == NXPWIFI_FW_V15) {
+		ba_stream_max = GETSUPP_TXBASTREAMS(adapter->hw_dot_11n_dev_cap);
+		if (!ba_stream_max)
+			ba_stream_max = NXPWIFI_MAX_TX_BASTREAM_SUPPORTED;
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; j++)
+			ba_stream_num += list_count_nodes(&priv->tx_ba_stream_tbl_ptr[j]);
+	}
+
+	return ba_stream_num < ba_stream_max;
+}
+
+/* Find the Tx BA stream to delete and return its TID and RA. */
+static inline bool
+nxpwifi_find_stream_to_delete(struct nxpwifi_private *priv, int ptr_tid,
+			      int *ptid, u8 *ra)
+{
+	int search_tid = priv->aggr_prio_tbl[ptr_tid].ampdu_user;
+	bool found = false;
+	struct nxpwifi_tx_ba_stream_tbl *tx_tbl;
+	int candidate_tid;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock[ptr_tid]);
+
+	list_for_each_entry(tx_tbl, &priv->tx_ba_stream_tbl_ptr[ptr_tid], list) {
+		candidate_tid = priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user;
+
+		if (search_tid > candidate_tid) {
+			search_tid = candidate_tid;
+			*ptid = tx_tbl->tid;
+			memcpy(ra, tx_tbl->ra, ETH_ALEN);
+			found = true;
+		}
+	}
+
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock[ptr_tid]);
+
+	return found;
+}
+
+/* Check whether the associated station is 11n enabled. */
+static inline int nxpwifi_is_sta_11n_enabled(struct nxpwifi_private *priv,
+					     struct nxpwifi_sta_node *node)
+{
+	if (!node || (priv->bss_role == NXPWIFI_BSS_ROLE_UAP &&
+		      !priv->ap_11n_enabled))
+		return 0;
+
+	return node->is_11n_enabled;
+}
+
+#endif /* !_NXPWIFI_11N_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
new file mode 100644
index 000000000000..be7080f2a6ce
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11n_aggr.h"
+
+/*
+ * Build an AMSDU subframe for aggregation, with fields
+ * (DA | SA | Length | SNAP header | MSDU), and compute padding
+ * to align the subframe to a 4-byte boundary.
+ */
+static int nxpwifi_11n_form_amsdu_pkt(struct sk_buff *skb_aggr,
+				      struct sk_buff *skb_src, int *pad)
+
+{
+	int dt_offset;
+	struct rfc_1042_hdr snap = {
+		0xaa,		/* LLC DSAP */
+		0xaa,		/* LLC SSAP */
+		0x03,		/* LLC CTRL */
+		{0x00, 0x00, 0x00},	/* SNAP OUI */
+		0x0000		/* SNAP type */
+		/* This field will be overwritten later with ethertype */
+	};
+	struct tx_packet_hdr *tx_header;
+
+	tx_header = skb_put(skb_aggr, sizeof(*tx_header));
+
+	/* Copy DA and SA */
+	dt_offset = 2 * ETH_ALEN;
+	memcpy(&tx_header->eth803_hdr, skb_src->data, dt_offset);
+
+	/* Copy SNAP header */
+	snap.snap_type = ((struct ethhdr *)skb_src->data)->h_proto;
+
+	dt_offset += sizeof(__be16);
+
+	memcpy(&tx_header->rfc1042_hdr, &snap, sizeof(struct rfc_1042_hdr));
+
+	skb_pull(skb_src, dt_offset);
+
+	/* Update Length field */
+	tx_header->eth803_hdr.h_proto = htons(skb_src->len + LLC_SNAP_LEN);
+
+	/* Add payload */
+	skb_put_data(skb_aggr, skb_src->data, skb_src->len);
+
+	/* Add padding for new MSDU to start from 4 byte boundary */
+	*pad = (4 - ((unsigned long)skb_aggr->tail & 0x3)) % 4;
+
+	return skb_aggr->len + *pad;
+}
+
+/*
+ * Adds TxPD to AMSDU header. Each AMSDU packet will contain one TxPD at the
+ * beginning, followed by multiple AMSDU subframes
+ */
+static void
+nxpwifi_11n_form_amsdu_txpd(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct txpd *local_tx_pd;
+
+	skb_push(skb, sizeof(*local_tx_pd));
+
+	local_tx_pd = (struct txpd *)skb->data;
+	memset(local_tx_pd, 0, sizeof(struct txpd));
+
+	/* Original priority has been overwritten */
+	local_tx_pd->priority = (u8)skb->priority;
+	local_tx_pd->pkt_delay_2ms =
+		nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+	/* Always zero as the data is followed by struct txpd */
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(sizeof(struct txpd));
+	local_tx_pd->tx_pkt_type = cpu_to_le16(PKT_TYPE_AMSDU);
+	local_tx_pd->tx_pkt_length = cpu_to_le16(skb->len -
+						 sizeof(*local_tx_pd));
+
+	if (local_tx_pd->tx_control == 0)
+		/* TxCtrl set by user or default */
+		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA &&
+	    priv->adapter->pps_uapsd_mode) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			priv->adapter->tx_lock_flag = true;
+			local_tx_pd->flags =
+				NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET;
+		}
+	}
+}
+
+/*
+ * Build an aggregated MSDU packet by encapsulating buffers from the RA
+ * list as AMSDU subframes and concatenating them. A TxPD is prepended
+ * before transmission to form the final AMSDU packet.
+ */
+int
+nxpwifi_11n_aggregate_pkt(struct nxpwifi_private *priv,
+			  struct nxpwifi_ra_list_tbl *pra_list,
+			  int ptrindex)
+			  __releases(&priv->wmm.ra_list_spinlock)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct sk_buff *skb_aggr, *skb_src;
+	struct nxpwifi_txinfo *tx_info_aggr, *tx_info_src;
+	int pad = 0, aggr_num = 0, ret;
+	struct nxpwifi_tx_param tx_param;
+	struct txpd *ptx_pd = NULL;
+	int headroom = adapter->intf_hdr_len;
+
+	skb_src = skb_peek(&pra_list->skb_head);
+	if (!skb_src) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		return 0;
+	}
+
+	tx_info_src = NXPWIFI_SKB_TXCB(skb_src);
+	skb_aggr = nxpwifi_alloc_dma_align_buf(adapter->tx_buf_size,
+					       GFP_ATOMIC);
+	if (!skb_aggr) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		return -ENOMEM;
+	}
+
+	/*
+	 * skb_aggr->data already 64 byte align, just reserve bus interface
+	 * header and txpd.
+	 */
+	skb_reserve(skb_aggr, headroom + sizeof(struct txpd));
+	tx_info_aggr =  NXPWIFI_SKB_TXCB(skb_aggr);
+
+	memset(tx_info_aggr, 0, sizeof(*tx_info_aggr));
+	tx_info_aggr->bss_type = tx_info_src->bss_type;
+	tx_info_aggr->bss_num = tx_info_src->bss_num;
+
+	tx_info_aggr->flags |= NXPWIFI_BUF_FLAG_AGGR_PKT;
+	skb_aggr->priority = skb_src->priority;
+	skb_aggr->tstamp = skb_src->tstamp;
+
+	do {
+		/* Check if AMSDU can accommodate this MSDU */
+		if ((skb_aggr->len + skb_src->len + LLC_SNAP_LEN) >
+		    adapter->tx_buf_size)
+			break;
+
+		skb_src = skb_dequeue(&pra_list->skb_head);
+		pra_list->total_pkt_count--;
+		atomic_dec(&priv->wmm.tx_pkts_queued);
+		aggr_num++;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		nxpwifi_11n_form_amsdu_pkt(skb_aggr, skb_src, &pad);
+
+		nxpwifi_write_data_complete(adapter, skb_src, 0, 0);
+
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+		if (!nxpwifi_is_ralist_valid(priv, pra_list, ptrindex)) {
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			return -ENOENT;
+		}
+
+		if (skb_tailroom(skb_aggr) < pad) {
+			pad = 0;
+			break;
+		}
+		skb_put(skb_aggr, pad);
+
+		skb_src = skb_peek(&pra_list->skb_head);
+
+	} while (skb_src);
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+
+	/* Last AMSDU packet does not need padding */
+	skb_trim(skb_aggr, skb_aggr->len - pad);
+
+	/* Form AMSDU */
+	nxpwifi_11n_form_amsdu_txpd(priv, skb_aggr);
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		ptx_pd = (struct txpd *)skb_aggr->data;
+
+	skb_push(skb_aggr, headroom);
+	tx_info_aggr->aggr_num = aggr_num * 2;
+	if (adapter->data_sent || adapter->tx_lock_flag) {
+		atomic_add(aggr_num * 2, &adapter->tx_queued);
+		skb_queue_tail(&adapter->tx_data_q, skb_aggr);
+		return 0;
+	}
+
+	if (skb_src)
+		tx_param.next_pkt_len = skb_src->len + sizeof(struct txpd);
+	else
+		tx_param.next_pkt_len = 0;
+
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb_aggr, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+		if (!nxpwifi_is_ralist_valid(priv, pra_list, ptrindex)) {
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			nxpwifi_write_data_complete(adapter, skb_aggr, 1, -1);
+			return -EINVAL;
+		}
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (ptx_pd)
+				ptx_pd->flags = 0;
+		}
+
+		skb_queue_tail(&pra_list->skb_head, skb_aggr);
+
+		pra_list->total_pkt_count++;
+
+		atomic_inc(&priv->wmm.tx_pkts_queued);
+
+		tx_info_aggr->flags |= NXPWIFI_BUF_FLAG_REQUEUED_PKT;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb_aggr, 1, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR, "%s: host_to_card failed: %#x\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb_aggr, 1, ret);
+		break;
+	}
+	if (ret != -EBUSY)
+		nxpwifi_rotate_priolists(priv, pra_list, ptrindex);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
new file mode 100644
index 000000000000..be9f0f8f4e48
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_AGGR_H_
+#define _NXPWIFI_11N_AGGR_H_
+
+#define PKT_TYPE_AMSDU	0xE6
+#define MIN_NUM_AMSDU 2
+
+int nxpwifi_11n_deaggregate_pkt(struct nxpwifi_private *priv,
+				struct sk_buff *skb);
+int nxpwifi_11n_aggregate_pkt(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ptr,
+			      int ptr_index)
+			      __releases(&priv->wmm.ra_list_spinlock);
+
+#endif /* !_NXPWIFI_11N_AGGR_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
new file mode 100644
index 000000000000..c5819f89b08c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: 802.11n RX Re-ordering
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11n_rxreorder.h"
+/* Dispatch A-MSDU to stack. */
+static int nxpwifi_11n_dispatch_amsdu_pkt(struct nxpwifi_private *priv,
+					  struct sk_buff *skb)
+{
+	struct rxpd *local_rx_pd = (struct rxpd *)(skb->data);
+	int ret;
+
+	if (le16_to_cpu(local_rx_pd->rx_pkt_type) == PKT_TYPE_AMSDU) {
+		struct sk_buff_head list;
+		struct sk_buff *rx_skb;
+
+		__skb_queue_head_init(&list);
+
+		skb_pull(skb, le16_to_cpu(local_rx_pd->rx_pkt_offset));
+		skb_trim(skb, le16_to_cpu(local_rx_pd->rx_pkt_length));
+
+		ieee80211_amsdu_to_8023s(skb, &list, priv->curr_addr,
+					 priv->wdev.iftype, 0, NULL, NULL, false);
+
+		while (!skb_queue_empty(&list)) {
+			rx_skb = __skb_dequeue(&list);
+
+			if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+				ret = nxpwifi_uap_recv_packet(priv, rx_skb);
+			else
+				ret = nxpwifi_recv_packet(priv, rx_skb);
+			if (ret)
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "Rx of A-MSDU failed");
+		}
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/* Process RX packet and forward to stack. */
+static int nxpwifi_11n_dispatch_pkt(struct nxpwifi_private *priv,
+				    struct sk_buff *payload)
+{
+	int ret;
+
+	if (!payload) {
+		nxpwifi_dbg(priv->adapter, INFO, "info: fw drop data\n");
+		return 0;
+	}
+
+	ret = nxpwifi_11n_dispatch_amsdu_pkt(priv, payload);
+	if (!ret)
+		return 0;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		return nxpwifi_handle_uap_rx_forward(priv, payload);
+
+	return nxpwifi_process_rx_packet(priv, payload);
+}
+
+/* Dispatch packets up to start_win. */
+static void
+nxpwifi_11n_dispatch_pkt_until_start_win(struct nxpwifi_private *priv,
+					 struct nxpwifi_rx_reorder_tbl *tbl,
+					 int start_win)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+	int pkt_to_send, i, tid;
+
+	tid = tbl->tid;
+	__skb_queue_head_init(&list);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock[tid]);
+
+	pkt_to_send = (start_win > tbl->start_win) ?
+		      min((start_win - tbl->start_win), tbl->win_size) :
+		      tbl->win_size;
+
+	for (i = 0; i < pkt_to_send; ++i) {
+		if (tbl->rx_reorder_ptr[i]) {
+			skb = tbl->rx_reorder_ptr[i];
+			__skb_queue_tail(&list, skb);
+			tbl->rx_reorder_ptr[i] = NULL;
+		}
+	}
+
+	/* Simulate circular buffer via rotation. */
+	for (i = 0; i < tbl->win_size - pkt_to_send; ++i) {
+		tbl->rx_reorder_ptr[i] = tbl->rx_reorder_ptr[pkt_to_send + i];
+		tbl->rx_reorder_ptr[pkt_to_send + i] = NULL;
+	}
+
+	tbl->start_win = start_win;
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
+
+	while ((skb = __skb_dequeue(&list)))
+		nxpwifi_11n_dispatch_pkt(priv, skb);
+}
+
+/* Dispatch packets until a hole is found. */
+static void
+nxpwifi_11n_scan_and_dispatch(struct nxpwifi_private *priv,
+			      struct nxpwifi_rx_reorder_tbl *tbl)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+	int i, j, xchg, tid;
+
+	tid = tbl->tid;
+	__skb_queue_head_init(&list);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock[tid]);
+
+	for (i = 0; i < tbl->win_size; ++i) {
+		if (!tbl->rx_reorder_ptr[i])
+			break;
+		skb = tbl->rx_reorder_ptr[i];
+		__skb_queue_tail(&list, skb);
+		tbl->rx_reorder_ptr[i] = NULL;
+	}
+
+	/* Simulate circular buffer via rotation. */
+	if (i > 0) {
+		xchg = tbl->win_size - i;
+		for (j = 0; j < xchg; ++j) {
+			tbl->rx_reorder_ptr[j] = tbl->rx_reorder_ptr[i + j];
+			tbl->rx_reorder_ptr[i + j] = NULL;
+		}
+	}
+	tbl->start_win = (tbl->start_win + i) & (MAX_TID_VALUE - 1);
+
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
+
+	while ((skb = __skb_dequeue(&list)))
+		nxpwifi_11n_dispatch_pkt(priv, skb);
+}
+
+/* Delete RX reorder entry and flush pending packets. */
+static void
+nxpwifi_del_rx_reorder_entry(struct nxpwifi_private *priv,
+			     struct nxpwifi_rx_reorder_tbl *tbl)
+{
+	int start_win, tid;
+
+	if (!tbl)
+		return;
+
+	tid = tbl->tid;
+
+	atomic_set(&priv->adapter->rx_ba_teardown_pending, 1);
+	flush_workqueue(priv->adapter->rx_workqueue);
+
+	start_win = (tbl->start_win + tbl->win_size) & (MAX_TID_VALUE - 1);
+	nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, start_win);
+
+	timer_delete_sync(&tbl->timer_context.timer);
+	tbl->timer_context.timer_is_set = false;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock[tid]);
+	list_del_rcu(&tbl->list);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
+
+	kfree(tbl->rx_reorder_ptr);
+	kfree_rcu(tbl, rcu);
+
+	atomic_set(&priv->adapter->rx_ba_teardown_pending, 0);
+}
+
+/* Lookup RX reorder entry by TID/TA. */
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl, *found = NULL;
+
+	guard(rcu)();
+
+	list_for_each_entry_rcu(tbl, &priv->rx_reorder_tbl_ptr[tid], list) {
+		if (!memcmp(tbl->ta, ta, ETH_ALEN) && tbl->tid == tid) {
+			found = tbl;
+			break;
+		}
+	}
+
+	return found;
+}
+
+/* Delete RX reorder entries by TA. */
+void nxpwifi_11n_del_rx_reorder_tbl_by_ta(struct nxpwifi_private *priv, u8 *ta)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl, *tmp;
+	LIST_HEAD(to_delete);
+	int i;
+
+	if (!ta)
+		return;
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		guard(rcu)();
+		list_for_each_entry_rcu(tbl, &priv->rx_reorder_tbl_ptr[i], list) {
+			if (!memcmp(tbl->ta, ta, ETH_ALEN)) {
+				INIT_LIST_HEAD(&tbl->tmp_list);
+				list_add_tail(&tbl->tmp_list, &to_delete);
+			}
+		}
+
+		list_for_each_entry_safe(tbl, tmp, &to_delete, tmp_list)
+			nxpwifi_del_rx_reorder_entry(priv, tbl);
+
+		INIT_LIST_HEAD(&to_delete);
+	}
+}
+
+/* Find last buffered sequence index. */
+static int
+nxpwifi_11n_find_last_seq_num(struct reorder_tmr_cnxt *ctx)
+{
+	struct nxpwifi_rx_reorder_tbl *rx_reorder_tbl_ptr = ctx->ptr;
+	int i;
+
+	guard(rcu)();
+	for (i = rx_reorder_tbl_ptr->win_size - 1; i >= 0; --i) {
+		if (rx_reorder_tbl_ptr->rx_reorder_ptr[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+/* Flush and dispatch buffered packets on timer. */
+static void
+nxpwifi_flush_data(struct timer_list *t)
+{
+	struct reorder_tmr_cnxt *ctx =
+		timer_container_of(ctx, t, timer);
+	int start_win, seq_num;
+
+	ctx->timer_is_set = false;
+	seq_num = nxpwifi_11n_find_last_seq_num(ctx);
+
+	if (seq_num < 0)
+		return;
+
+	nxpwifi_dbg(ctx->priv->adapter, INFO, "info: flush data %d\n", seq_num);
+	start_win = (ctx->ptr->start_win + seq_num + 1) & (MAX_TID_VALUE - 1);
+	nxpwifi_11n_dispatch_pkt_until_start_win(ctx->priv, ctx->ptr,
+						 start_win);
+}
+
+/* Create RX reorder entry (TID/TA, SSN, winsize, timer). */
+static void
+nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
+				  int tid, int win_size, int seq_num)
+{
+	int i;
+	struct nxpwifi_rx_reorder_tbl *tbl, *new_node;
+	u16 last_seq = 0;
+	struct nxpwifi_sta_node *node;
+
+	/* Existing TID/TA: flush and move window to SSN. */
+	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
+	if (tbl) {
+		nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, seq_num);
+		return;
+	}
+	/* if !tbl then create one */
+	new_node = kzalloc_obj(*new_node, GFP_KERNEL);
+	if (!new_node)
+		return;
+
+	INIT_LIST_HEAD(&new_node->list);
+	new_node->tid = tid;
+	memcpy(new_node->ta, ta, ETH_ALEN);
+	new_node->start_win = seq_num;
+	new_node->init_win = seq_num;
+	new_node->flags = 0;
+
+	if (nxpwifi_queuing_ra_based(priv)) {
+		if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+			guard(rcu)();
+			node = nxpwifi_get_sta_entry(priv, ta);
+			if (node)
+				last_seq = node->rx_seq[tid];
+		}
+	} else {
+		guard(rcu)();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			last_seq = node->rx_seq[tid];
+		else
+			last_seq = priv->rx_seq[tid];
+	}
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: last_seq=%d start_win=%d\n",
+		    last_seq, new_node->start_win);
+
+	if (last_seq != NXPWIFI_DEF_11N_RX_SEQ_NUM &&
+	    last_seq >= new_node->start_win) {
+		new_node->start_win = last_seq + 1;
+		new_node->flags |= RXREOR_INIT_WINDOW_SHIFT;
+	}
+
+	new_node->win_size = win_size;
+
+	new_node->rx_reorder_ptr = kcalloc(win_size, sizeof(void *),
+					   GFP_KERNEL);
+	if (!new_node->rx_reorder_ptr) {
+		kfree(new_node);
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: failed to alloc reorder_ptr\n", __func__);
+		return;
+	}
+
+	new_node->timer_context.ptr = new_node;
+	new_node->timer_context.priv = priv;
+	new_node->timer_context.timer_is_set = false;
+
+	timer_setup(&new_node->timer_context.timer, nxpwifi_flush_data, 0);
+
+	for (i = 0; i < win_size; ++i)
+		new_node->rx_reorder_ptr[i] = NULL;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock[tid]);
+	list_add_tail_rcu(&new_node->list, &priv->rx_reorder_tbl_ptr[tid]);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock[tid]);
+}
+
+static void
+nxpwifi_11n_rxreorder_timer_restart(struct nxpwifi_rx_reorder_tbl *tbl)
+{
+	u32 min_flush_time;
+
+	if (tbl->win_size >= NXPWIFI_BA_WIN_SIZE_32)
+		min_flush_time = MIN_FLUSH_TIMER_15_MS;
+	else
+		min_flush_time = MIN_FLUSH_TIMER_MS;
+
+	mod_timer(&tbl->timer_context.timer,
+		  jiffies + msecs_to_jiffies(min_flush_time * tbl->win_size));
+
+	tbl->timer_context.timer_is_set = true;
+}
+
+/* Prepare ADDBA request. */
+int nxpwifi_cmd_11n_addba_req(struct host_cmd_ds_command *cmd, void *data_buf)
+{
+	struct host_cmd_ds_11n_addba_req *add_ba_req = &cmd->params.add_ba_req;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_ADDBA_REQ);
+	cmd->size = cpu_to_le16(sizeof(*add_ba_req) + S_DS_GEN);
+	memcpy(add_ba_req, data_buf, sizeof(*add_ba_req));
+
+	return 0;
+}
+
+/* Prepare ADDBA response and create RX reorder table. */
+int nxpwifi_cmd_11n_addba_rsp_gen(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  struct host_cmd_ds_11n_addba_req
+				  *cmd_addba_req)
+{
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &cmd->params.add_ba_rsp;
+	u32 rx_win_size = priv->add_ba_param.rx_win_size;
+	u8 tid;
+	int win_size;
+	u16 block_ack_param_set;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_ADDBA_RSP);
+	cmd->size = cpu_to_le16(sizeof(*add_ba_rsp) + S_DS_GEN);
+
+	memcpy(add_ba_rsp->peer_mac_addr, cmd_addba_req->peer_mac_addr,
+	       ETH_ALEN);
+	add_ba_rsp->dialog_token = cmd_addba_req->dialog_token;
+	add_ba_rsp->block_ack_tmo = cmd_addba_req->block_ack_tmo;
+	add_ba_rsp->ssn = cmd_addba_req->ssn;
+
+	block_ack_param_set = le16_to_cpu(cmd_addba_req->block_ack_param_set);
+	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
+		>> BLOCKACKPARAM_TID_POS;
+	add_ba_rsp->status_code = cpu_to_le16(ADDBA_RSP_STATUS_ACCEPT);
+	block_ack_param_set &= ~IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
+
+	/* If we don't support AMSDU inside AMPDU, reset the bit */
+	if (!priv->add_ba_param.rx_amsdu ||
+	    priv->aggr_prio_tbl[tid].amsdu == BA_STREAM_NOT_ALLOWED)
+		block_ack_param_set &= ~IEEE80211_ADDBA_PARAM_AMSDU_MASK;
+	block_ack_param_set |= rx_win_size << BLOCKACKPARAM_WINSIZE_POS;
+	add_ba_rsp->block_ack_param_set = cpu_to_le16(block_ack_param_set);
+	win_size = (le16_to_cpu(add_ba_rsp->block_ack_param_set)
+		    & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK)
+		   >> BLOCKACKPARAM_WINSIZE_POS;
+	cmd_addba_req->block_ack_param_set = cpu_to_le16(block_ack_param_set);
+
+	nxpwifi_11n_create_rx_reorder_tbl(priv, cmd_addba_req->peer_mac_addr,
+					  tid, win_size,
+					  le16_to_cpu(cmd_addba_req->ssn));
+	return 0;
+}
+
+/* Prepare DELBA command. */
+int nxpwifi_cmd_11n_delba(struct host_cmd_ds_command *cmd, void *data_buf)
+{
+	struct host_cmd_ds_11n_delba *del_ba = &cmd->params.del_ba;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_DELBA);
+	cmd->size = cpu_to_le16(sizeof(*del_ba) + S_DS_GEN);
+	memcpy(del_ba, data_buf, sizeof(*del_ba));
+
+	return 0;
+}
+
+/* Decide and perform RX reordering for a packet. */
+int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *priv,
+			       u16 seq_num, u16 tid,
+			       u8 *ta, u8 pkt_type, void *payload)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	int prev_start_win, start_win, end_win, win_size;
+	u16 pkt_index;
+	bool init_window_shift = false;
+	int ret = 0;
+
+	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
+	if (!tbl) {
+		if (pkt_type != PKT_TYPE_BAR)
+			nxpwifi_11n_dispatch_pkt(priv, payload);
+		return ret;
+	}
+
+	if (pkt_type == PKT_TYPE_AMSDU && !tbl->amsdu) {
+		nxpwifi_11n_dispatch_pkt(priv, payload);
+		return ret;
+	}
+
+	start_win = tbl->start_win;
+	prev_start_win = start_win;
+	win_size = tbl->win_size;
+	end_win = ((start_win + win_size) - 1) & (MAX_TID_VALUE - 1);
+	if (tbl->flags & RXREOR_INIT_WINDOW_SHIFT) {
+		init_window_shift = true;
+		tbl->flags &= ~RXREOR_INIT_WINDOW_SHIFT;
+	}
+
+	if (tbl->flags & RXREOR_FORCE_NO_DROP) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "RXREOR_FORCE_NO_DROP when HS is activated\n");
+		tbl->flags &= ~RXREOR_FORCE_NO_DROP;
+	} else if (init_window_shift && seq_num < start_win &&
+		   seq_num >= tbl->init_win) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "Sender TID sequence number reset %d->%d for SSN %d\n",
+			    start_win, seq_num, tbl->init_win);
+		start_win = seq_num;
+		tbl->start_win = start_win;
+		end_win = ((start_win + win_size) - 1) & (MAX_TID_VALUE - 1);
+	} else {
+		/* Drop packet if seq_num < start_win. */
+		if ((start_win + TWOPOW11) > (MAX_TID_VALUE - 1)) {
+			if (seq_num >= ((start_win + TWOPOW11) &
+					(MAX_TID_VALUE - 1)) &&
+			    seq_num < start_win) {
+				ret = -EINVAL;
+				goto done;
+			}
+		} else if ((seq_num < start_win) ||
+			   (seq_num >= (start_win + TWOPOW11))) {
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+	/* Adjust seq_num for BAR (WinStart = seq_num). */
+	if (pkt_type == PKT_TYPE_BAR)
+		seq_num = ((seq_num + win_size) - 1) & (MAX_TID_VALUE - 1);
+
+	if ((end_win < start_win &&
+	     seq_num < start_win && seq_num > end_win) ||
+	    (end_win > start_win && (seq_num > end_win ||
+				     seq_num < start_win))) {
+		end_win = seq_num;
+		if (((end_win - win_size) + 1) >= 0)
+			start_win = (end_win - win_size) + 1;
+		else
+			start_win = (MAX_TID_VALUE - (win_size - end_win)) + 1;
+		nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, start_win);
+	}
+
+	if (pkt_type != PKT_TYPE_BAR) {
+		if (seq_num >= start_win)
+			pkt_index = seq_num - start_win;
+		else
+			pkt_index = (seq_num + MAX_TID_VALUE) - start_win;
+
+		if (tbl->rx_reorder_ptr[pkt_index]) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		tbl->rx_reorder_ptr[pkt_index] = payload;
+	}
+
+	/* Dispatch sequentially until a hole; update start_win. */
+	nxpwifi_11n_scan_and_dispatch(priv, tbl);
+
+done:
+	if (!tbl->timer_context.timer_is_set ||
+	    prev_start_win != tbl->start_win)
+		nxpwifi_11n_rxreorder_timer_restart(tbl);
+	return ret;
+}
+
+/* Delete BA entry for TID/TA. */
+void
+nxpwifi_del_ba_tbl(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		   u8 type, int initiator)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	struct nxpwifi_tx_ba_stream_tbl *ptx_tbl;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	u8 cleanup_rx_reorder_tbl;
+	int tid_down;
+
+	if (type == TYPE_DELBA_RECEIVE)
+		cleanup_rx_reorder_tbl = (initiator) ? true : false;
+	else
+		cleanup_rx_reorder_tbl = (initiator) ? false : true;
+
+	nxpwifi_dbg(priv->adapter, EVENT, "event: DELBA: %pM tid=%d initiator=%d\n",
+		    peer_mac, tid, initiator);
+
+	if (cleanup_rx_reorder_tbl) {
+		tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, peer_mac);
+		if (!tbl) {
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "event: TID, TA not found in table\n");
+			return;
+		}
+		nxpwifi_del_rx_reorder_entry(priv, tbl);
+	} else {
+		guard(rcu)();
+		ptx_tbl = nxpwifi_get_ba_tbl(priv, tid, peer_mac);
+
+		if (!ptx_tbl) {
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "event: TID, RA not found in table\n");
+			return;
+		}
+
+		tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down, peer_mac);
+		if (ra_list) {
+			ra_list->amsdu_in_ampdu = false;
+			ra_list->ba_status = BA_SETUP_NONE;
+		}
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock[tid]);
+		nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, ptx_tbl);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock[tid]);
+	}
+}
+
+/* Handle ADDBA response. */
+int nxpwifi_ret_11n_addba_resp(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *resp)
+{
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &resp->params.add_ba_rsp;
+	int tid, win_size;
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	u16 block_ack_param_set;
+
+	block_ack_param_set = le16_to_cpu(add_ba_rsp->block_ack_param_set);
+
+	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
+		>> BLOCKACKPARAM_TID_POS;
+	/* Check if we had rejected the ADDBA, if yes then do not create the stream */
+	if (le16_to_cpu(add_ba_rsp->status_code) != BA_RESULT_SUCCESS) {
+		nxpwifi_dbg(priv->adapter, ERROR, "ADDBA RSP: failed %pM tid=%d)\n",
+			    add_ba_rsp->peer_mac_addr, tid);
+
+		tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid,
+						     add_ba_rsp->peer_mac_addr);
+		if (tbl)
+			nxpwifi_del_rx_reorder_entry(priv, tbl);
+
+		return 0;
+	}
+
+	win_size = (block_ack_param_set & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK)
+		    >> BLOCKACKPARAM_WINSIZE_POS;
+
+	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid,
+					     add_ba_rsp->peer_mac_addr);
+	if (tbl) {
+		if ((block_ack_param_set & IEEE80211_ADDBA_PARAM_AMSDU_MASK) &&
+		    priv->add_ba_param.rx_amsdu &&
+		    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+			tbl->amsdu = true;
+		else
+			tbl->amsdu = false;
+	}
+
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: ADDBA RSP: %pM tid=%d ssn=%d win_size=%d\n",
+		    add_ba_rsp->peer_mac_addr, tid, add_ba_rsp->ssn, win_size);
+
+	return 0;
+}
+
+/* Handle BA stream timeout: send DELBA. */
+void nxpwifi_11n_ba_stream_timeout(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_11n_batimeout *event)
+{
+	struct host_cmd_ds_11n_delba delba;
+
+	memset(&delba, 0, sizeof(struct host_cmd_ds_11n_delba));
+	memcpy(delba.peer_mac_addr, event->peer_mac_addr, ETH_ALEN);
+
+	delba.del_ba_param_set |=
+		cpu_to_le16((u16)event->tid << DELBA_TID_POS);
+	delba.del_ba_param_set |=
+		cpu_to_le16((u16)event->origninator << DELBA_INITIATOR_POS);
+	delba.reason_code = cpu_to_le16(WLAN_REASON_QSTA_TIMEOUT);
+	nxpwifi_send_cmd(priv, HOST_CMD_11N_DELBA, 0, 0, &delba, false);
+}
+
+/* Cleanup all RX reorder entries. */
+void nxpwifi_11n_cleanup_reorder_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_rx_reorder_tbl *del_tbl_ptr, *tmp_node;
+	LIST_HEAD(to_delete_list);
+	int i;
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		spin_lock_bh(&priv->rx_reorder_tbl_lock[i]);
+		list_splice_init(&priv->rx_reorder_tbl_ptr[i], &to_delete_list);
+		spin_unlock_bh(&priv->rx_reorder_tbl_lock[i]);
+
+		list_for_each_entry_safe(del_tbl_ptr, tmp_node, &to_delete_list, list)
+			nxpwifi_del_rx_reorder_entry(priv, del_tbl_ptr);
+
+		INIT_LIST_HEAD(&to_delete_list);
+	}
+
+	nxpwifi_reset_11n_rx_seq_num(priv);
+}
+
+/* Update flags for all RX reorder tables. */
+void nxpwifi_update_rxreor_flags(struct nxpwifi_adapter *adapter, u8 flags)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	int i, j;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		for (j = 0; j < MAX_NUM_TID; j++) {
+			spin_lock_bh(&priv->rx_reorder_tbl_lock[j]);
+			list_for_each_entry_rcu(tbl, &priv->rx_reorder_tbl_ptr[j], list)
+				tbl->flags = flags;
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock[j]);
+		}
+	}
+}
+
+/* Update RX window size based on coex flag. */
+static void nxpwifi_update_ampdu_rxwinsize(struct nxpwifi_adapter *adapter,
+					   bool coex_flag)
+{
+	u8 i, j;
+	u32 rx_win_size;
+	struct nxpwifi_private *priv;
+
+	nxpwifi_dbg(adapter, INFO, "Update rxwinsize %d\n", coex_flag);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		rx_win_size = priv->add_ba_param.rx_win_size;
+		if (coex_flag) {
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_STA_COEX_AMPDU_DEF_RXWINSIZE;
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_UAP_COEX_AMPDU_DEF_RXWINSIZE;
+		} else {
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_STA_AMPDU_DEF_RXWINSIZE;
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE;
+		}
+
+		if (adapter->coex_win_size && adapter->coex_rx_win_size)
+			priv->add_ba_param.rx_win_size =
+				adapter->coex_rx_win_size;
+
+		if (rx_win_size != priv->add_ba_param.rx_win_size) {
+			if (!priv->media_connected)
+				continue;
+			for (j = 0; j < MAX_NUM_TID; j++)
+				nxpwifi_11n_delba(priv, j);
+		}
+	}
+}
+
+/* Check coex for RX BA. */
+void nxpwifi_coex_ampdu_rxwinsize(struct nxpwifi_adapter *adapter)
+{
+	u8 i;
+	struct nxpwifi_private *priv;
+	u8 count = 0;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+			if (priv->media_connected)
+				count++;
+		}
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+			if (priv->bss_started)
+				count++;
+		}
+		if (count >= NXPWIFI_BSS_COEX_COUNT)
+			break;
+	}
+	if (count >= NXPWIFI_BSS_COEX_COUNT)
+		nxpwifi_update_ampdu_rxwinsize(adapter, true);
+	else
+		nxpwifi_update_ampdu_rxwinsize(adapter, false);
+}
+
+/* Handle RXBA sync event. */
+void nxpwifi_11n_rxba_sync_event(struct nxpwifi_private *priv,
+				 u8 *event_buf, u16 len)
+{
+	struct nxpwifi_ie_types_rxba_sync *tlv_rxba = (void *)event_buf;
+	u16 tlv_type, tlv_len;
+	struct nxpwifi_rx_reorder_tbl *rx_reor_tbl_ptr;
+	u8 i, j;
+	u16 seq_num, tlv_seq_num, tlv_bitmap_len;
+	int tlv_buf_left = len;
+	int ret;
+	u8 *tmp;
+
+	nxpwifi_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
+			 event_buf, len);
+	while (tlv_buf_left > sizeof(*tlv_rxba)) {
+		tlv_type = le16_to_cpu(tlv_rxba->header.type);
+		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
+		if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
+			nxpwifi_dbg(priv->adapter, WARN,
+				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
+				    size_add(sizeof(tlv_rxba->header), tlv_len),
+				    tlv_buf_left);
+			return;
+		}
+
+		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Wrong TLV id=0x%x\n", tlv_type);
+			return;
+		}
+
+		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
+		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
+		if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf_left) {
+			nxpwifi_dbg(priv->adapter, WARN,
+				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
+				    size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
+				    tlv_buf_left);
+			return;
+		}
+
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
+			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
+			    tlv_bitmap_len);
+
+		rx_reor_tbl_ptr =
+			nxpwifi_11n_get_rx_reorder_tbl(priv, tlv_rxba->tid,
+						       tlv_rxba->mac);
+		if (!rx_reor_tbl_ptr) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Can not find rx_reorder_tbl!");
+			return;
+		}
+
+		for (i = 0; i < tlv_bitmap_len; i++) {
+			for (j = 0 ; j < 8; j++) {
+				if (tlv_rxba->bitmap[i] & (1 << j)) {
+					seq_num = (MAX_TID_VALUE - 1) &
+						(tlv_seq_num + i * 8 + j);
+
+					nxpwifi_dbg(priv->adapter, ERROR,
+						    "drop packet,seq=%d\n",
+						    seq_num);
+
+					ret = nxpwifi_11n_rx_reorder_pkt
+					(priv, seq_num, tlv_rxba->tid,
+					 tlv_rxba->mac, 0, NULL);
+
+					if (ret)
+						nxpwifi_dbg(priv->adapter,
+							    ERROR,
+							    "Fail to drop packet");
+				}
+			}
+		}
+
+		tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+		tmp = (u8 *)tlv_rxba + sizeof(tlv_rxba->header) + tlv_len;
+		tlv_rxba = (struct nxpwifi_ie_types_rxba_sync *)tmp;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
new file mode 100644
index 000000000000..db95d9db5d1f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_RXREORDER_H_
+#define _NXPWIFI_11N_RXREORDER_H_
+
+#define MIN_FLUSH_TIMER_MS		50
+#define MIN_FLUSH_TIMER_15_MS		15
+#define NXPWIFI_BA_WIN_SIZE_32		32
+
+#define PKT_TYPE_BAR 0xE7
+#define MAX_TID_VALUE			(2 << 11)
+#define TWOPOW11			(2 << 10)
+
+#define BLOCKACKPARAM_TID_POS		2
+#define BLOCKACKPARAM_WINSIZE_POS	6
+#define DELBA_TID_POS			12
+#define DELBA_INITIATOR_POS		11
+#define TYPE_DELBA_SENT			1
+#define TYPE_DELBA_RECEIVE		2
+#define IMMEDIATE_BLOCK_ACK		0x2
+
+#define ADDBA_RSP_STATUS_ACCEPT 0
+
+#define NXPWIFI_DEF_11N_RX_SEQ_NUM	0xffff
+#define BA_SETUP_MAX_PACKET_THRESHOLD	16
+#define BA_SETUP_PACKET_OFFSET		16
+
+enum nxpwifi_rxreor_flags {
+	RXREOR_FORCE_NO_DROP		= 1 << 0,
+	RXREOR_INIT_WINDOW_SHIFT	= 1 << 1,
+};
+
+static inline void nxpwifi_reset_11n_rx_seq_num(struct nxpwifi_private *priv)
+{
+	memset(priv->rx_seq, 0xff, sizeof(priv->rx_seq));
+}
+
+int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *priv,
+			       u16 seq_num,
+			       u16 tid, u8 *ta,
+			       u8 pkttype, void *payload);
+void nxpwifi_del_ba_tbl(struct nxpwifi_private *priv, int tid,
+			u8 *peer_mac, u8 type, int initiator);
+void nxpwifi_11n_ba_stream_timeout(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_11n_batimeout *event);
+int nxpwifi_ret_11n_addba_resp(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command
+			       *resp);
+int nxpwifi_cmd_11n_delba(struct host_cmd_ds_command *cmd,
+			  void *data_buf);
+int nxpwifi_cmd_11n_addba_rsp_gen(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  struct host_cmd_ds_11n_addba_req
+				  *cmd_addba_req);
+int nxpwifi_cmd_11n_addba_req(struct host_cmd_ds_command *cmd,
+			      void *data_buf);
+void nxpwifi_11n_cleanup_reorder_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rxreorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+void nxpwifi_11n_del_rx_reorder_tbl_by_ta(struct nxpwifi_private *priv, u8 *ta);
+void nxpwifi_update_rxreor_flags(struct nxpwifi_adapter *adapter, u8 flags);
+void nxpwifi_11n_rxba_sync_event(struct nxpwifi_private *priv,
+				 u8 *event_buf, u16 len);
+#endif /* _NXPWIFI_11N_RXREORDER_H_ */
-- 
2.34.1


