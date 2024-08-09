Return-Path: <linux-wireless+bounces-11181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37594CD8B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3AA283B40
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9C192B9A;
	Fri,  9 Aug 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKJINOM1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9D192B74;
	Fri,  9 Aug 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196768; cv=fail; b=QJJkNC71ieI0YOELEpfnqEcg6A1aytjosEwYBfLhx+s+uSQZrkcLEWcPDvA3fy/OwCCf5TQehMpZ1OhVv5BIbCSNqwNs4AilQAqiw1hgjtg1XRT6hCuwUounrbJnagPp7B67b1UFRdHxgbw2xjKntO5CPxGzVk014O38tRwuLek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196768; c=relaxed/simple;
	bh=7P/LnuSYSLdNtiA2kaRD2ylmDoBGn0TwKl7rF6BuZGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nf7LwmI4cOxrwaq809KFnXq7sBj0AnnQAqgOa8G8kG0f5gNykrTwukrxewo7NakajkLvJX1+bUH09Xm6KPG3kwGrRxJeCapPQVNTcB8IEE0m/pFcpO9mbhXl27IC+ZhwE9BZ7CL5/S0u6QmjWaVNSbbjRWMcncZiVF2HwD5Bpdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NKJINOM1; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj5QNB9Z6n9nCZ2hTQb+NVeiymN/X7tTAJa5VCD82ypyMBSSNzlvnEoA1oVRfw94tlhtKnsJp60V/c3spsMYWHpGgvnBWwgsrcMZnll3iwAywbtUt5tBbXE6EPuNJH0bffWFqbfIgyJ6kIXSkqeqanAiWfEKpAt3ilp72ANEeP+jmvtfpFtfUSrTbKoNTzQOrU5dzLnvhpri4RDqUMstkYm+sXhYOq3WfvCUFhMoicl1lHUELW7M0Bd1X44CYYXaUAaZzUJ/zIKoggUybd4pqSCW85Om+ENZ0dqgkeVZ0Fj4qd33k+g1zOTHMvIqAwddx8649PQHrwuRXYolh5lsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8/p8snz+4NkzgjaCyakojmj4QeDZLgn/yHswc5j4zE=;
 b=nIYFPr3cCjlHxOF2iLdrnH1f01USJkXZLfv1YnmWbO9E3Okly7qvo7hkY+bm5gKYKr21SLPaGK9EYZAvLGq4wweb6I9knpPBSwBemM7gcKqm0BrjF1ma7LvjawcevWgqUNrcnbk4Ub1OAVboMTe5lOmER7zxBxy3pDwn87DOfdO887WCZwp9QhjLL6zI2NT9S6eOnKDuBbcRAH8GQlZv6ZG58rhBFtktx0Gqpe2aojxoMtLSBzg2jYcGXv8QulTx9y/GaStIooNVcbb+RlELGYePB+X2iv0QBDqAm58xjrF2CuE00ZY/bwbcaKuk52WxtwrUy/c3UdcJw8zlrX0v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8/p8snz+4NkzgjaCyakojmj4QeDZLgn/yHswc5j4zE=;
 b=NKJINOM1H9a3jzTkGTlsX8hKodUvFe1qte6kcbgcMZToAUfijWXP17RBqnbwHePevyWiRPKFyr8fvPyX6d1u/XYwKHt5v6o+f0WQqtQC3Ibv/w9gSNQLst+v4wraJG0Q2SWoQxOCr/4niexAs5HBVSO07pW1jjxrL3PpvrzMFqOVoGrR4aLaxiYj48gyloh7ZHo+4kbirTKdW/HQcemAFHOo3TIxs4niXoogHuG0KGe2SdkABQaqagrUbkfIcq2Zni2Trd7z7n/s4dLCrhEH1UdpbUgloC+YhNj+ehhSwXhRAqTlh2nhI4kOCFfsI69MaXh31pFIuvubP0XMrUNI/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:03 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 04/43] wifi: nxpwifi: add 11n_aggr.c
Date: Fri,  9 Aug 2024 17:44:54 +0800
Message-Id: <20240809094533.1660-5-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9899f8-fea8-4b6c-f4ed-08dcb858155e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QnxDJsNTaR0E0KfCnx4NREDrx2G7lhQiJdM5WdC/5RpLm0GaUYVtekP9MROW?=
 =?us-ascii?Q?w1NL7TfZxWhwSLCPVWB2oI6nwP1EBXRB6Ae22w/lraXqCLvzlwvd5jzHaj+G?=
 =?us-ascii?Q?Z+5Ayj1VOO3kphEzpM+I2wiuEAf9DhpVFbuoh76vy2nLlzu1uhtqH2Tskcd4?=
 =?us-ascii?Q?o7AD5/SN9MDTGhOsen0sqMm+mSf5xiSWlR14wtmsOqjuOaxyGyGnwiVujhOp?=
 =?us-ascii?Q?nI7iBr3g8MwdKvtSzYL2C4cq9h4q1fDRuqLn9S5KD6KaNIw08bvkK2jkaigH?=
 =?us-ascii?Q?6vrYuznchI4hFyh25vVbgM/itahUXPL/+gX4ROqRwc8NAhQvXPCSL+4qkEcH?=
 =?us-ascii?Q?VEXXvtf4fUP2WfK0K3DgbS2m8Y4waMTAddfdjY/Ro/ojSIXjD9Bx/RImiTH/?=
 =?us-ascii?Q?1wr4uLlEt7F7qUBOGv80BsNZ+61WlgEvvvIuvr7WyCpK8zZFmn9yISsaoCWx?=
 =?us-ascii?Q?JtVux+ZeK52vpnUGsCrWKTChy4QYfXtv6fwRfj307F5fdg6Ff1EOA1B3aG8v?=
 =?us-ascii?Q?LqJi2ZxAZJpFc0mns/2wH7955qEE0hYT4EiAIevf9gdj26sb/CRX4t0tc1xE?=
 =?us-ascii?Q?0DohQCQuGxouZ5jUUN9f0L48UgZv4OPiPo/mpOVktcklMriVhD//f9s7pcwa?=
 =?us-ascii?Q?i9fiVevFKsz/bEq6ACu/QMo18YX6V/qaL5Ur6R56XB7PblcQgNCgYV2S78wr?=
 =?us-ascii?Q?prdtNyhvQkj8q3UjVb9oP+8xEEcIydSYLJQu7kMeZl4pg8TdGkBC80vofVsY?=
 =?us-ascii?Q?+8Is3E/JJc08Yc7kwiKepOvwdXGqcyvcVKcWFOE4FC+qh08K70R9iq6qoVyD?=
 =?us-ascii?Q?rSIi2f5SmV0qKWx7/iRSA6KNidd4RxZr7oDs7I4YpAJLOmWC/Xmjl2+vMej0?=
 =?us-ascii?Q?y9SKW3n7aWkCjDaUbHwGpLDN1aCp/qSUVa8M7LTQgChfDslr7GpLgC8Yz7kC?=
 =?us-ascii?Q?ox/DFY2NWU29fm5W0zw3RO/TQZh+kdd+luYrlyHIt+Edtekwcy2E+CL7cMbE?=
 =?us-ascii?Q?4ST/1Fw+v6YeDGZTbsLwsIhTSVNmjQAc9a96kI/RjNPIM70oJvBn9Oj9dkBb?=
 =?us-ascii?Q?IfNmsAy2zpRPpcSG/AKqWmUuNfpeFjlq3vPt/zY9hlu/Eo2hocSjDAmeXDGU?=
 =?us-ascii?Q?6jmEzVCBV4C+5sMjZDb0mJbO449FSDjkJBHR1A5rxvq+HkLwiEpNHulXNdCa?=
 =?us-ascii?Q?5/A/VKICMMdxz2LHQYXyiUzd77FE4qOTelTAwCT2tG3vyff4BLqlqtLOHkJu?=
 =?us-ascii?Q?ug9gGxPcpjggQkLNuWXCHER1yRlECY0fW7i8pg+NW/bRtW7bRj4+Gyd0n87O?=
 =?us-ascii?Q?R517c1jBp4VVLSDRmfmbI002by9a8oYGd9KoLP/NpF3VzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pme9FG2rqvXDKVH/Z/vN820uMXkFJm73VuzQOSUJlZ6RSxl+gtaSS2Zqxgi3?=
 =?us-ascii?Q?KhMISKGxIfHv7b2SBq1lukPokOgbx6lTFW7zYjHqbYJXnEpsUMR7Q09379Aw?=
 =?us-ascii?Q?QXxWHeUGIpmW0Rml3jIswjo509zY7oBFGMuaMt76Jrt/sJQ1YGgTJuTFmpEz?=
 =?us-ascii?Q?CCY74DZpADkOzohiDG9ciqiMYeq2u73stBXDH0NpeiFu2yBJj2RFpqM667Rm?=
 =?us-ascii?Q?k5lG2OxGJUM+iIOu/tl4EuzqHK0pzmXPbTmoQBo5NXYqygVKDehrg+twJVoj?=
 =?us-ascii?Q?Kfzii0LfN8UZoaDisBmQl4t4G2Ac0ul6dvaQi5YqHpGAfAEb8mncx+YBIw64?=
 =?us-ascii?Q?7gyO6++R/0K8GkXUDTSm10oSHiL/Ek7Mo/CgGS5fco1r/KfTQDP39DtO/csA?=
 =?us-ascii?Q?WWzgRjNAPmgn6Ec+mvo4MhpfY5cyw4ZZWL5ZsknHDVcwjFp5KZstWCPrNt4/?=
 =?us-ascii?Q?BRSnl7CcSA2FQ9cc4FCFdIFvE7/rro0eEr0R09czp4yJiq2ASD8WxUO6hyv+?=
 =?us-ascii?Q?6wETwFKglw06ej0dKSV2pscemk7dzMVntXxVgCFprwdIwZnuIDQjh+7U+Kft?=
 =?us-ascii?Q?9F7GfsTEXFmKYyRjMChOgiW7UpPcvQnRCtj+3GL0GTI7MMCN2qpydMy7DjiA?=
 =?us-ascii?Q?lde2PwDWwPzIT31WdC4j63qsmZvqh/aGCCjDB7pNZsMCjTmXWvO6e3DuxtGo?=
 =?us-ascii?Q?lYz2HmLNwG3e7Dnt10Z9FKMsBtB2J2QHh66yD2aja9kiWZ5bI8gUHSUGBwsB?=
 =?us-ascii?Q?FZlaSu8C37gWm5yo8qRMS7DG8WMxVqQMQE2ZfNrgMN/cBYikLa3z/bPwq4jK?=
 =?us-ascii?Q?Kzn1AzyZEU2rqmb1OW1pF5owxNbA2sUeccrRPQvfR5tkqPSU/RBP+3YeNc/v?=
 =?us-ascii?Q?Gpcr91afbuhsyjU6mKzF64tmMKnOb+2aDhUH3HDLlt385j/khuGmFQzAuCI1?=
 =?us-ascii?Q?pkZIqD4ttMH/vLRnQsman14vZb3h81Fo70SUQvSoss/qbC8p07Z4VVjx1BnP?=
 =?us-ascii?Q?L7mir5nNiIcjiYAz9FTuoPp71gtTDBPzy7fQ7E39Yx73O0DFczo+T9EcLcCd?=
 =?us-ascii?Q?aTgu2w1vX9CXReQI7jsV6+35y4yjoDj2a9besaut/2RrxSE4ElIoaCXw2jYZ?=
 =?us-ascii?Q?BC7mIyR3+le2DCnC1kyKc/8ZONoWhXlSjukoXDnpMsrLi3AVUq8hFalyp/YD?=
 =?us-ascii?Q?OzEZ7KFLnytaGBR7GUu9akcl3If9goSw16bdLPVXv1sEZOKJ6fExB2tgeaE3?=
 =?us-ascii?Q?Iu1EyEBAZXL7zOaERLwaErI3EV+9uh5lc5vYPKPyQtefqCRcIwM+FT9Q2VDa?=
 =?us-ascii?Q?OSmGhY3v1DwUJRsewHG6aGozQFICYI/1mrcfQYrdPXKtI9tUIY0XAZ9eq+vW?=
 =?us-ascii?Q?xvOLUofOt6BDv9QS3OMZvuMnvjD8t5+5U7oJODC8HMAsJENX/M2FS5jAUw5C?=
 =?us-ascii?Q?jRS6LVu/YaHypU2ucNcF7zGNfuwnSTOIrqPcPXJtfvpi+ZKStRhsQ7aiZC5d?=
 =?us-ascii?Q?g/4Cfl5jmZm7F0LUvthl6AyCpPYsCKd9l2UoIGvLq/PKMaURV0gEUSAwKSJP?=
 =?us-ascii?Q?OqDRZPmAbTr3mLbjyKZR2SIjFjHRDbEJmyOluDy5K2NUqOm4FjIGUff04bPH?=
 =?us-ascii?Q?XJ2tHd+ahqM4hykm/VLgscLGcOCTwqGD7BDhAjAKyv+M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9899f8-fea8-4b6c-f4ed-08dcb858155e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:03.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6Y3Wy+bVr1pLwEVdHnfyaymPcaKKxqK/8cs6F51JmbBdGITD9GZy5XfwFlb4w4mjslI1kXo4nksfnea9n2OOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c | 276 ++++++++++++++++++++
 1 file changed, 276 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
new file mode 100644
index 000000000000..85ea840e6e91
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11n_aggr.h"
+
+/* Creates an AMSDU subframe for aggregation into one AMSDU packet.
+ *
+ * The resultant AMSDU subframe format is -
+ *
+ * +---- ~ -----+---- ~ ------+---- ~ -----+----- ~ -----+---- ~ -----+
+ * |     DA     |     SA      |   Length   | SNAP header |   MSDU     |
+ * | data[0..5] | data[6..11] |            |             | data[14..] |
+ * +---- ~ -----+---- ~ ------+---- ~ -----+----- ~ -----+---- ~ -----+
+ * <--6-bytes--> <--6-bytes--> <--2-bytes--><--8-bytes--> <--n-bytes-->
+ *
+ * This function also computes the amount of padding required to make the
+ * buffer length multiple of 4 bytes.
+ *
+ * Data => |DA|SA|SNAP-TYPE|........    .|
+ * MSDU => |DA|SA|Length|SNAP|......   ..|
+ */
+static int
+nxpwifi_11n_form_amsdu_pkt(struct sk_buff *skb_aggr,
+			   struct sk_buff *skb_src, int *pad)
+
+{
+	int dt_offset;
+	struct rfc_1042_hdr snap = {
+		0xaa,		/* LLC DSAP */
+		0xaa,		/* LLC SSAP */
+		0x03,		/* LLC CTRL */
+		{0x00, 0x00, 0x00},	/* SNAP OUI */
+		0x0000		/* SNAP type */
+			/* This field will be overwritten
+			 * later with ethertype
+			 */
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
+/* Adds TxPD to AMSDU header.
+ *
+ * Each AMSDU packet will contain one TxPD at the beginning,
+ * followed by multiple AMSDU subframes.
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
+/* Create aggregated packet.
+ *
+ * This function creates an aggregated MSDU packet, by combining buffers
+ * from the RA list. Each individual buffer is encapsulated as an AMSDU
+ * subframe and all such subframes are concatenated together to form the
+ * AMSDU packet.
+ *
+ * A TxPD is also added to the front of the resultant AMSDU packets for
+ * transmission. The resultant packets format is -
+ *
+ * +---- ~ ----+------ ~ ------+------ ~ ------+-..-+------ ~ ------+
+ * |    TxPD   |AMSDU sub-frame|AMSDU sub-frame| .. |AMSDU sub-frame|
+ * |           |       1       |       2       | .. |       n       |
+ * +---- ~ ----+------ ~ ------+------ ~ ------+ .. +------ ~ ------+
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
+	/* skb_aggr->data already 64 byte align, just reserve bus interface
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
-- 
2.34.1


