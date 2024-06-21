Return-Path: <linux-wireless+bounces-9384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CEB911D8F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2819BB23F56
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B1171E40;
	Fri, 21 Jun 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahPXlbq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2069.outbound.protection.outlook.com [40.107.8.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7717166E;
	Fri, 21 Jun 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956427; cv=fail; b=OvSf2UER7B1c7EGqvbsnYMJztGB1w+UfHFHXz6gAB3xFwwtMfG6/zo0lSzy1Bny6bALiAKs0eAPVQwi54qq4Z+km1GCxw474JINMsXPeZeuunfCuw0KBU/YUjEZKATrwJ//d8ESfM1kOVvy7xp+/rvULs0nwAmQwWI9PbtfMip0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956427; c=relaxed/simple;
	bh=fwahuzSqlOgzx7xggO7pGwA/UCEBjcfeVKOkB+5T7E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fq5dstTHTGS37vBYGbnn0YBprX9GxCFvbrpfaCeP2+QbNnQBrK+fCTlmOs6KMmn2t5xIfITtsQYSluqKmlFl+r9ckluE6NcQy+MkoK4PScMhzsCURXHp8JF5/e/3gyMibGINZwXs5KqtZo0Wro3GwOvTvjiFrWQsCPLBee9DXPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahPXlbq0; arc=fail smtp.client-ip=40.107.8.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+f9GsISshIV8M0Dyrm15Y5mozTW7h7pZ6cvp5ilrovPb/AtvyfK3xnrW/9ybo+1Srm9kIN/DMJP6UBLPe8Hw+ri6x26rQTpM82/cPglrv90AUbFPDkYFfzXqvuYtqyTgZ3vLnRwGl3tlUgFnaS4uBFQz0kXZXpGSPbh+/XtQapiJ5zJHx9YYx/VJg1Y4znlX2Knb3qMYQgUYokHen87ZhoOHp5uCeUSx8ySnI7Hfp4+s0ldFoYcsVVc0lrOOW93O52+mP98EhIGlNsRnvo+HPej3SIdNkPBmp8sqin5r85Nn3ZBz5cjmxC/wWEnPNTZ1JgvpHtFpZMMEmiux+iNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNbDWSfKHx1T8QiK+SUlWoPo54vRTjDOgM8l/zmkn4U=;
 b=b5DkJITuS6ro5YxjZG+b6qt3wvtb8zuKRTEe/UYdyjr/bT7apnuH2oYrknaVX6StNp2LI2fCNZRXgHEKKe45oj9HXONBUUYGHwM7gzEkEhCtF0U119JJX8wd/t8LwLpFhPp+13UgsdCwcdfWRhNrLM/76mlVQ6XQLECVfWJ1rzWzdPFteUI4uOMl29fLI1ljOj3gkj6cDLe/OkCx4q+D89htYm6wljEo9cXjudarEl3/Ck8rrm8VHQUZpcDVvWOjzIgUgK9cUQhh+/ofb285OnVh66d2fdHUyjw3hgd4++63rdc8PbNp+xvy/sV0i4ldElhbydEpLbZPN/EOSSuX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNbDWSfKHx1T8QiK+SUlWoPo54vRTjDOgM8l/zmkn4U=;
 b=ahPXlbq02MyDnVLcJeCJpxWUxBzvp8U3v2YlWh6RJOckxY2knJ7Bz8xIdw3q41NxFKA83sYthQQs7HH71xSwUOn/R3Z2sUjrYHCC8rLNht+kssKWI416pV7ClPo55/nIlLhvCYpqGBHcxlz4JV0gOJHLfBkiNcqeoxxIez7BhkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:53:42 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:41 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 20/43] wifi: nxpwifi: add init.c
Date: Fri, 21 Jun 2024 15:51:45 +0800
Message-Id: <20240621075208.513497-21-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: f67eee80-6a3b-45c8-c220-08dc91c744a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otuZina4hDQZ4QeOJ6SQfA5BLrXR5uf3IUw7aPq/VE1nB5LmmHy9BI/D06Ml?=
 =?us-ascii?Q?2Bq3MheOEAWrwy4JpiQFc4iWGggbZns6n3CaKdlSn3+AcrDTiJnPvK7UysVJ?=
 =?us-ascii?Q?5v37W6+joN4aWUc/fiMo//bXdD7s52HA1cc+qrsLILQ+NuRIjheR79fH0AVB?=
 =?us-ascii?Q?2YQOQ8IcrpQtqRIf0ZA35BU76TxPuRR6pHu/nHxCZ8l07ugqzNZDchIA1PRs?=
 =?us-ascii?Q?RBP9DrIfU9HT7SsUJgy+qQocw8x+jAk+3x08Jli37Cc8rLgDhk33zLGOqYdJ?=
 =?us-ascii?Q?/VIz4FGPGbkgu682ENKGYxHgYzVitoiijTumb3vxk0fPNA97yW2DY6uqWev1?=
 =?us-ascii?Q?A+9WhnR9D6xw7tOKglfjTC2s7ekuWaUlcXm/nZbZf/Oyjx5tE75mxCGJSxr7?=
 =?us-ascii?Q?udGAMw/Bs1CYJgJlhXoEll369xDY9OuiWFkq66vLDdc8rSuqKm35cDYDc3lM?=
 =?us-ascii?Q?/TvXGFiXCrV8uJER7ARh5QXzxbN58AZ2ErrWEyQExtM3lnTdCwGZzbBkpsje?=
 =?us-ascii?Q?w9DDXwWATOTqP5MEAFhiMP0Wi7KdaJmhEefdn+rFl3+C+EGeRg4u0ROAwrAC?=
 =?us-ascii?Q?feSWUvhs4FkvtZR223TTHy88J8uT30fQ1CCfoP+M/rlNxypncEK5w75gGLku?=
 =?us-ascii?Q?ubEMzEPSeUPtOgzUhnzJL8C4/P2EYOfvUwF7vDaYxQ8Gt9Qn4+9kTByWnVg1?=
 =?us-ascii?Q?zmgg3BiJH/7WW4Jni9GHW3lDvEDx/72gZP4WRap0Oopjnc2X4yinkfro+Ym0?=
 =?us-ascii?Q?/3q85bopYxfM2+Na3NIPF9U0ob0NQC5vXnbqMfodRX8nMP/OYKLE8OrJxKqi?=
 =?us-ascii?Q?fhJw7/ES0dYmQcvffabqoXZI98S34fOXbu2D50efifUbXSi6o7Y6LxnASYzT?=
 =?us-ascii?Q?7r2RVnEl41KYxks5147CsGAryDmftgz4QF4AxE0acKU+02rbuiJGzt5Bk+Ig?=
 =?us-ascii?Q?8lxSJglviTk8tXg7GTCoRJfH/N6YFa5UpijI9LePUslTbrCF1IW1Y5G9txdj?=
 =?us-ascii?Q?rBNltaFZXJmxjpQM7Jo+Nq9uv5bKkYStPnE2blwo5JAMm+8/dwmsAo8xTzh6?=
 =?us-ascii?Q?F/2B0GkPytw9W4+pmCNoaB52xgnPE4zLo5ZGHuiOOKWoqkCNB9J1JH+GX2SJ?=
 =?us-ascii?Q?/ntSpkpDFfGsHloA6qQ3aBAZrQeshciy4YHDfP018+lZ7gkSttYzSAlzkJwK?=
 =?us-ascii?Q?bYkcXHo18sUeeZjfPGX43smJzkswh1oDfOqqP8QGlzUBVQEvfjHlN3evQHBm?=
 =?us-ascii?Q?sDs2FZpmVue6gwd2b2PJ+nplUF4alMHatwwcHigwzZj3NdsPsjRtAGdCkzvA?=
 =?us-ascii?Q?5LE6SxC/aHNq2uc64Dg4+Oiv4xWsvQPd4DZ7KEmndRsnhl8JvzGEYhhcczYu?=
 =?us-ascii?Q?2zSx6n8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USV+KLPFX66IBimVi9AJjKHsdMaYb9lH5BTZp1t9dadr0QZMD4KPvtXN9t+I?=
 =?us-ascii?Q?7xs5TUFz5tHjwxmVxp5eBNUis7CVonE3NBLy7bMWkuVQAovlRJx4wy3CahQ2?=
 =?us-ascii?Q?mu5fjns/0hE6g6j9CoTrDJmTwJkGwAhiCMK6yTGLMV+a86SYOzODT9NDoS9R?=
 =?us-ascii?Q?vsZ5G7u9sH3eJqYtrbmwWcnGELA2z8ioOAH4Ewk9ghW5LOHAc8YYfIWCenyZ?=
 =?us-ascii?Q?ph08ZY/NlQhohgHcQnNCRIuYCOEQS/fW3Pn0rSVr+x/znyjN/CfM5VA8Dy/Q?=
 =?us-ascii?Q?c/1dn4mx3IAgPIIle4yPCmDQqo8AFN3FaZ5bb0EXzYjLilOLLuWcsJ9NCdbR?=
 =?us-ascii?Q?krgeQte+21+HaYpyWNwntMJtTuySIGcekkEkMGPuJ7uEoTOLS9nT/2ld9C9g?=
 =?us-ascii?Q?xOB3JjocYJRJLLRAELX+63hPoZZW2aQiFwgRFuzAC5wwKitrpEvdMMB6GaXk?=
 =?us-ascii?Q?/yKJpoCZOXKw0UOZgWBdnyS3g6i7KvnDuw4AlUL6Bmn7iil68dSYUVoOxTKR?=
 =?us-ascii?Q?nfNvhR4cL3vWAT2i8G7y57Gt0ppeUB0g7cdd8nSErAgQCFXp1otTEY8wanGa?=
 =?us-ascii?Q?O1zSqU2goE/YLGyp0SYaT33SM9ne9OZxyJ7lkeapk6bUaWL+2NNjDSgOOWHR?=
 =?us-ascii?Q?AWTDrTXb4A2eVQKkonKTuGE2S9mTsXZSE4V/3Nla3WmfiYcts2yFKsWNosZU?=
 =?us-ascii?Q?xs+3YGEXtPrG4XA8LR1r3y2I8vxZ9asKgpnMhWnUHzvQ3dBI8aAVxi9YP2cM?=
 =?us-ascii?Q?GTyzJ7oPs81fQzwxyljVMDef3PVwcQ2GSxsp/lCv+6hm8Mms6Z6+q87HbalO?=
 =?us-ascii?Q?7PZbtlVC1GUpLpWJJGrnAYZriBd2WhCBoIwV4JRTzIsugNkkcVaajrBhAQg5?=
 =?us-ascii?Q?TSqGlqKD6d18PictiFfr3fb8sKCdgDTPDtXj9GnUL3tz2JX/ngLciNLvndsP?=
 =?us-ascii?Q?qfKMTk+sAN8uFF+UKqM+NdTGys4MhIsDysZn0PRHTwpOl5QUF1dUK8genn8O?=
 =?us-ascii?Q?grIofdSnatxolk9TLvrm+kaEKKwqhSLKEKZ9Q8dNS3f08CCdnOitHYiTzZwn?=
 =?us-ascii?Q?w6NZ6ezHZGAg1rStVp3SfrJICyQzCqNdIEmr/7HVYztwcaNjzhwFhrjmhTh3?=
 =?us-ascii?Q?E5RWRkOR6K+5LbhlWPn912ib45qGZJadroQcUTMZ5xuBhfvczVU16k56h8QG?=
 =?us-ascii?Q?0neG+SJZD+b1EwEXCBXQVOuI0eP2sUjpUieMZdQqN/kzfexjDKvtssLrxIur?=
 =?us-ascii?Q?QZUy078IFQahh/GYr8CvDXYSwkiBDZCJKB8Y3yjYyqCTHEmNByDzAOr/VXxe?=
 =?us-ascii?Q?t3p1e19hgNK6C+dfGnMJjq0V96pF/xaj46+37puOXGb7J1ZiKdx8eyP21ZXm?=
 =?us-ascii?Q?kMfioZObdrxrX+kwavhbTOGXDRSXTLvFn0iLJkTLZPnVQlU9W9Wgp0eiZIhL?=
 =?us-ascii?Q?2bCMf0Iss8FERZESKixyD88yFtMar48SSTdWPWEjJryBVLEMiOJcfbLDuJA8?=
 =?us-ascii?Q?woiG5eomq/neUwSeX0EqqpodtOpPiQRYk4QALBBxxlBqCXoDBjSc4R2VdfkV?=
 =?us-ascii?Q?nQ6JND4Gb7XttYlOaJ6r7zgnp7PkvhLfOQvwxQVU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67eee80-6a3b-45c8-c220-08dc91c744a2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:41.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUqbrh8J02Lsr7uq6z708p10XV9flkCv9sCZOrsDn1eIIsIfWJLxcr88FjGs9vaBpQE5oE357UPsfhqxiSz/qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/init.c | 696 ++++++++++++++++++++++++
 1 file changed, 696 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/init.c b/drivers/net/wireless/nxp/nxpwifi/init.c
new file mode 100644
index 000000000000..792eb346a797
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/init.c
@@ -0,0 +1,696 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: HW/FW Initialization
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+/* This function adds a BSS priority table to the table list.
+ *
+ * The function allocates a new BSS priority table node and adds it to
+ * the end of BSS priority table list, kept in driver memory.
+ */
+static int nxpwifi_add_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bss_prio;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+
+	bss_prio = kzalloc(sizeof(*bss_prio), GFP_KERNEL);
+	if (!bss_prio)
+		return -ENOMEM;
+
+	bss_prio->priv = priv;
+	INIT_LIST_HEAD(&bss_prio->list);
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	list_add_tail(&bss_prio->list, &tbl[priv->bss_priority].bss_prio_head);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+
+	return 0;
+}
+
+static void wakeup_timer_fn(struct timer_list *t)
+{
+	struct nxpwifi_adapter *adapter = from_timer(adapter, t, wakeup_timer);
+
+	nxpwifi_dbg(adapter, ERROR, "Firmware wakeup failed\n");
+	adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+static void fw_dump_work(struct work_struct *work)
+{
+	struct nxpwifi_adapter *adapter =
+		container_of(work, struct nxpwifi_adapter, devdump_work.work);
+
+	nxpwifi_upload_device_dump(adapter);
+}
+
+/* This function initializes the private structure and sets default
+ * values to the members.
+ *
+ * Additionally, it also initializes all the locks and sets up all the
+ * lists.
+ */
+int nxpwifi_init_priv(struct nxpwifi_private *priv)
+{
+	u32 i;
+
+	priv->media_connected = false;
+	eth_broadcast_addr(priv->curr_addr);
+	priv->port_open = false;
+	priv->usb_port = NXPWIFI_USB_EP_DATA;
+	priv->pkt_tx_ctrl = 0;
+	priv->bss_mode = NL80211_IFTYPE_UNSPECIFIED;
+	priv->data_rate = 0;	/* Initially indicate the rate as auto */
+	priv->is_data_rate_auto = true;
+	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
+	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
+	priv->sec_info.wep_enabled = 0;
+	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
+	priv->sec_info.encryption_mode = 0;
+	for (i = 0; i < ARRAY_SIZE(priv->wep_key); i++)
+		memset(&priv->wep_key[i], 0, sizeof(struct nxpwifi_wep_key));
+	priv->wep_key_curr_index = 0;
+	priv->curr_pkt_filter = HOST_ACT_MAC_DYNAMIC_BW_ENABLE |
+				HOST_ACT_MAC_RX_ON | HOST_ACT_MAC_TX_ON |
+				HOST_ACT_MAC_ETHERNETII_ENABLE;
+
+	priv->beacon_period = 100; /* beacon interval */
+	priv->attempted_bss_desc = NULL;
+	memset(&priv->curr_bss_params, 0, sizeof(priv->curr_bss_params));
+	priv->listen_interval = NXPWIFI_DEFAULT_LISTEN_INTERVAL;
+
+	memset(&priv->prev_ssid, 0, sizeof(priv->prev_ssid));
+	memset(&priv->prev_bssid, 0, sizeof(priv->prev_bssid));
+	memset(&priv->assoc_rsp_buf, 0, sizeof(priv->assoc_rsp_buf));
+	priv->assoc_rsp_size = 0;
+	priv->atim_window = 0;
+	priv->tx_power_level = 0;
+	priv->max_tx_power_level = 0;
+	priv->min_tx_power_level = 0;
+	priv->tx_ant = 0;
+	priv->rx_ant = 0;
+	priv->tx_rate = 0;
+	priv->rxpd_htinfo = 0;
+	priv->rxpd_rate = 0;
+	priv->rate_bitmap = 0;
+	priv->data_rssi_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->data_nf_last = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->bcn_nf_last = 0;
+	memset(&priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+	memset(&priv->aes_key, 0, sizeof(priv->aes_key));
+	priv->wpa_ie_len = 0;
+	priv->wpa_is_gtk_set = false;
+
+	memset(&priv->assoc_tlv_buf, 0, sizeof(priv->assoc_tlv_buf));
+	priv->assoc_tlv_buf_len = 0;
+	memset(&priv->wps, 0, sizeof(priv->wps));
+	memset(&priv->gen_ie_buf, 0, sizeof(priv->gen_ie_buf));
+	priv->gen_ie_buf_len = 0;
+	memset(priv->vs_ie, 0, sizeof(priv->vs_ie));
+
+	priv->wmm_required = true;
+	priv->wmm_enabled = false;
+	priv->wmm_qosinfo = 0;
+	priv->curr_bcn_buf = NULL;
+	priv->curr_bcn_size = 0;
+	priv->wps_ie = NULL;
+	priv->wps_ie_len = 0;
+	priv->ap_11n_enabled = 0;
+	memset(&priv->roc_cfg, 0, sizeof(priv->roc_cfg));
+
+	priv->scan_block = false;
+
+	priv->csa_chan = 0;
+	priv->csa_expire_time = 0;
+	priv->del_list_idx = 0;
+	priv->hs2_enabled = false;
+	memcpy(priv->tos_to_tid_inv, tos_to_tid_inv, MAX_NUM_TID);
+
+	nxpwifi_init_11h_params(priv);
+
+	return nxpwifi_add_bss_prio_tbl(priv);
+}
+
+/* This function allocates buffers for members of the adapter
+ * structure.
+ *
+ * The memory allocated includes scan table, command buffers, and
+ * sleep confirm command buffer. In addition, the queues are
+ * also initialized.
+ */
+static int nxpwifi_allocate_adapter(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+
+	/* Allocate command buffer */
+	ret = nxpwifi_alloc_cmd_buffer(adapter);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc cmd buffer\n",
+			    __func__);
+		return -1;
+	}
+
+	adapter->sleep_cfm =
+		dev_alloc_skb(sizeof(struct nxpwifi_opt_sleep_confirm)
+			      + INTF_HEADER_LEN);
+
+	if (!adapter->sleep_cfm) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc sleep cfm\t"
+			    " cmd buffer\n", __func__);
+		return -1;
+	}
+	skb_reserve(adapter->sleep_cfm, INTF_HEADER_LEN);
+
+	return 0;
+}
+
+/* This function initializes the adapter structure and sets default
+ * values to the members of adapter.
+ *
+ * This also initializes the WMM related parameters in the driver private
+ * structures.
+ */
+static void nxpwifi_init_adapter(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_opt_sleep_confirm *sleep_cfm_buf = NULL;
+
+	skb_put(adapter->sleep_cfm, sizeof(struct nxpwifi_opt_sleep_confirm));
+
+	adapter->cmd_sent = false;
+	adapter->data_sent = true;
+
+	adapter->intf_hdr_len = INTF_HEADER_LEN;
+
+	adapter->cmd_resp_received = false;
+	adapter->event_received = false;
+	adapter->data_received = false;
+	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
+
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->need_to_wakeup = false;
+
+	adapter->scan_mode = HOST_BSS_MODE_ANY;
+	adapter->specific_scan_time = NXPWIFI_SPECIFIC_SCAN_CHAN_TIME;
+	adapter->active_scan_time = NXPWIFI_ACTIVE_SCAN_CHAN_TIME;
+	adapter->passive_scan_time = NXPWIFI_PASSIVE_SCAN_CHAN_TIME;
+	adapter->scan_chan_gap_time = NXPWIFI_DEF_SCAN_CHAN_GAP_TIME;
+
+	adapter->scan_probes = 1;
+
+	adapter->multiple_dtim = 1;
+
+	/* default value in firmware will be used */
+	adapter->local_listen_interval = 0;
+
+	adapter->is_deep_sleep = false;
+
+	adapter->delay_null_pkt = false;
+	adapter->delay_to_ps = 1000;
+	adapter->enhanced_ps_mode = PS_MODE_AUTO;
+
+	/* Disable NULL Pkg generation by default */
+	adapter->gen_null_pkt = false;
+	/* Disable pps/uapsd mode by default */
+	adapter->pps_uapsd_mode = false;
+	adapter->pm_wakeup_card_req = false;
+
+	adapter->pm_wakeup_fw_try = false;
+
+	adapter->curr_tx_buf_size = NXPWIFI_TX_DATA_BUF_SIZE_2K;
+
+	clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	adapter->hs_cfg.conditions = cpu_to_le32(HS_CFG_COND_DEF);
+	adapter->hs_cfg.gpio = HS_CFG_GPIO_DEF;
+	adapter->hs_cfg.gap = HS_CFG_GAP_DEF;
+	adapter->hs_activated = false;
+
+	memset(adapter->event_body, 0, sizeof(adapter->event_body));
+	adapter->hw_dot_11n_dev_cap = 0;
+	adapter->hw_dev_mcs_support = 0;
+	adapter->sec_chan_offset = 0;
+
+	nxpwifi_wmm_init(adapter);
+	atomic_set(&adapter->tx_hw_pending, 0);
+
+	sleep_cfm_buf = (struct nxpwifi_opt_sleep_confirm *)
+					adapter->sleep_cfm->data;
+	memset(sleep_cfm_buf, 0, adapter->sleep_cfm->len);
+	sleep_cfm_buf->command = cpu_to_le16(HOST_CMD_802_11_PS_MODE_ENH);
+	sleep_cfm_buf->size = cpu_to_le16(adapter->sleep_cfm->len);
+	sleep_cfm_buf->result = 0;
+	sleep_cfm_buf->action = cpu_to_le16(SLEEP_CONFIRM);
+	sleep_cfm_buf->resp_ctrl = cpu_to_le16(RESP_NEEDED);
+
+	memset(&adapter->sleep_period, 0, sizeof(adapter->sleep_period));
+	adapter->tx_lock_flag = false;
+	adapter->null_pkt_interval = 0;
+	adapter->fw_bands = 0;
+	adapter->config_bands = 0;
+	adapter->fw_release_number = 0;
+	adapter->fw_cap_info = 0;
+	memset(&adapter->upld_buf, 0, sizeof(adapter->upld_buf));
+	adapter->event_cause = 0;
+	adapter->region_code = 0;
+	adapter->bcn_miss_time_out = DEFAULT_BCN_MISS_TIMEOUT;
+	memset(&adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+	adapter->arp_filter_size = 0;
+	adapter->max_mgmt_ie_index = MAX_MGMT_IE_INDEX;
+	adapter->key_api_major_ver = 0;
+	adapter->key_api_minor_ver = 0;
+	eth_broadcast_addr(adapter->perm_addr);
+	adapter->iface_limit.sta_intf = NXPWIFI_MAX_STA_NUM;
+	adapter->iface_limit.uap_intf = NXPWIFI_MAX_UAP_NUM;
+	adapter->active_scan_triggered = false;
+	timer_setup(&adapter->wakeup_timer, wakeup_timer_fn, 0);
+	adapter->devdump_len = 0;
+	INIT_DELAYED_WORK(&adapter->devdump_work, fw_dump_work);
+}
+
+/* This function sets trans_start per tx_queue
+ */
+void nxpwifi_set_trans_start(struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++)
+		txq_trans_cond_update(netdev_get_tx_queue(dev, i));
+
+	netif_trans_update(dev);
+}
+
+/* This function wakes up all queues in net_device
+ */
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_wake_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function stops all queues in net_device
+ */
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_stop_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function invalidates the list heads.
+ */
+static void nxpwifi_invalidate_lists(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	list_del(&adapter->cmd_free_q);
+	list_del(&adapter->cmd_pending_q);
+	list_del(&adapter->scan_pending_q);
+
+	for (i = 0; i < adapter->priv_num; i++)
+		list_del(&adapter->bss_prio_tbl[i].bss_prio_head);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+			for (j = 0; j < MAX_NUM_TID; ++j)
+				list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			list_del(&priv->tx_ba_stream_tbl_ptr);
+			list_del(&priv->rx_reorder_tbl_ptr);
+			list_del(&priv->sta_list);
+		}
+	}
+}
+
+/* This function performs cleanup for adapter structure.
+ *
+ * The cleanup is done recursively, by canceling all pending
+ * commands, freeing the member buffers previously allocated
+ * (command buffers, scan table buffer, sleep confirm command
+ * buffer), stopping the timers and calling the cleanup routines
+ * for every interface.
+ */
+static void
+nxpwifi_adapter_cleanup(struct nxpwifi_adapter *adapter)
+{
+	del_timer(&adapter->wakeup_timer);
+	cancel_delayed_work_sync(&adapter->devdump_work);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+	wake_up_interruptible(&adapter->cmd_wait_q.wait);
+	wake_up_interruptible(&adapter->hs_activate_wait_q);
+}
+
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter)
+{
+	nxpwifi_invalidate_lists(adapter);
+
+	/* Free command buffer */
+	nxpwifi_dbg(adapter, INFO, "info: free cmd buffer\n");
+	nxpwifi_free_cmd_buffer(adapter);
+
+	if (adapter->sleep_cfm)
+		dev_kfree_skb_any(adapter->sleep_cfm);
+}
+
+/*  This function intializes the lock variables and
+ *  the list heads.
+ */
+int nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	spin_lock_init(&adapter->int_lock);
+	spin_lock_init(&adapter->main_proc_lock);
+	spin_lock_init(&adapter->nxpwifi_cmd_lock);
+	spin_lock_init(&adapter->queue_lock);
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+			spin_lock_init(&priv->wmm.ra_list_spinlock);
+			spin_lock_init(&priv->curr_bcn_buf_lock);
+			spin_lock_init(&priv->sta_list_spinlock);
+		}
+	}
+
+	/* Initialize cmd_free_q */
+	INIT_LIST_HEAD(&adapter->cmd_free_q);
+	/* Initialize cmd_pending_q */
+	INIT_LIST_HEAD(&adapter->cmd_pending_q);
+	/* Initialize scan_pending_q */
+	INIT_LIST_HEAD(&adapter->scan_pending_q);
+
+	spin_lock_init(&adapter->cmd_free_q_lock);
+	spin_lock_init(&adapter->cmd_pending_q_lock);
+	spin_lock_init(&adapter->scan_pending_q_lock);
+	spin_lock_init(&adapter->rx_proc_lock);
+
+	skb_queue_head_init(&adapter->rx_data_q);
+	skb_queue_head_init(&adapter->tx_data_q);
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		INIT_LIST_HEAD(&adapter->bss_prio_tbl[i].bss_prio_head);
+		spin_lock_init(&adapter->bss_prio_tbl[i].bss_prio_lock);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (!adapter->priv[i])
+			continue;
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j)
+			INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[j].ra_list);
+		INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr);
+		INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr);
+		INIT_LIST_HEAD(&priv->sta_list);
+		skb_queue_head_init(&priv->bypass_txq);
+
+		spin_lock_init(&priv->tx_ba_stream_tbl_lock);
+		spin_lock_init(&priv->rx_reorder_tbl_lock);
+
+		spin_lock_init(&priv->ack_status_lock);
+		idr_init(&priv->ack_status_frames);
+	}
+
+	return 0;
+}
+
+/* This function initializes the firmware.
+ *
+ * The following operations are performed sequentially -
+ *      - Allocate adapter structure
+ *      - Initialize the adapter structure
+ *      - Initialize the private structure
+ *      - Add BSS priority tables to the adapter structure
+ *      - For each interface, send the init commands to firmware
+ *      - Send the first command in command pending queue, if available
+ */
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	u8 i, first_sta = true;
+	int is_cmd_pend_q_empty;
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	/* Allocate memory for member of adapter structure */
+	ret = nxpwifi_allocate_adapter(adapter);
+	if (ret)
+		return -1;
+
+	/* Initialize adapter structure */
+	nxpwifi_init_adapter(adapter);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+
+			/* Initialize private structure */
+			ret = nxpwifi_init_priv(priv);
+			if (ret)
+				return -1;
+		}
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			ret = nxpwifi_sta_init_cmd(adapter->priv[i],
+						   first_sta, true);
+			if (ret == -1)
+				return -1;
+
+			first_sta = false;
+		}
+	}
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	if (!is_cmd_pend_q_empty) {
+		/* Send the first command in queue and return */
+		if (nxpwifi_main_process(adapter) != -1)
+			ret = -EINPROGRESS;
+	} else {
+		adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+	}
+
+	return ret;
+}
+
+/* This function deletes the BSS priority tables.
+ *
+ * The function traverses through all the allocated BSS priority nodes
+ * in every BSS priority table and frees them.
+ */
+static void nxpwifi_delete_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bssprio_node, *tmp_node;
+	struct list_head *head;
+	spinlock_t *lock; /* bss priority lock */
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		head = &adapter->bss_prio_tbl[i].bss_prio_head;
+		lock = &adapter->bss_prio_tbl[i].bss_prio_lock;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: delete BSS priority table,\t"
+			    "bss_type = %d, bss_num = %d, i = %d,\t"
+			    "head = %p\n",
+			    priv->bss_type, priv->bss_num, i, head);
+
+		{
+			spin_lock_bh(lock);
+			list_for_each_entry_safe(bssprio_node, tmp_node, head,
+						 list) {
+				if (bssprio_node->priv == priv) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Delete\t"
+						    "node %p, next = %p\n",
+						    bssprio_node, tmp_node);
+					list_del(&bssprio_node->list);
+					kfree(bssprio_node);
+				}
+			}
+			spin_unlock_bh(lock);
+		}
+	}
+}
+
+/* This function frees the private structure, including cleans
+ * up the TX and RX queues and frees the BSS priority tables.
+ */
+void nxpwifi_free_priv(struct nxpwifi_private *priv)
+{
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_delete_bss_prio_tbl(priv);
+	nxpwifi_free_curr_bcn(priv);
+}
+
+/* This function is used to shutdown the driver.
+ *
+ * The following operations are performed sequentially -
+ *      - Check if already shut down
+ *      - Make sure the main process has stopped
+ *      - Clean up the Tx and Rx queues
+ *      - Delete BSS priority tables
+ *      - Free the adapter
+ *      - Notify completion
+ */
+void
+nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i;
+	struct sk_buff *skb;
+
+	/* nxpwifi already shutdown */
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_NOT_READY)
+		return;
+
+	/* cancel current command */
+	if (adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, WARN,
+			    "curr_cmd is still in processing\n");
+		del_timer_sync(&adapter->cmd_timer);
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		adapter->curr_cmd = NULL;
+	}
+
+	/* shut down nxpwifi */
+	nxpwifi_dbg(adapter, MSG,
+		    "info: shutdown nxpwifi...\n");
+
+	/* Clean up Tx/Rx queues and delete BSS priority table */
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+
+			nxpwifi_abort_cac(priv);
+			nxpwifi_free_priv(priv);
+		}
+	}
+
+	atomic_set(&adapter->tx_queued, 0);
+	while ((skb = skb_dequeue(&adapter->tx_data_q)))
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+
+	spin_lock_bh(&adapter->rx_proc_lock);
+
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+
+		atomic_dec(&adapter->rx_pending);
+		priv = adapter->priv[rx_info->bss_num];
+		if (priv)
+			priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+	}
+
+	spin_unlock_bh(&adapter->rx_proc_lock);
+
+	nxpwifi_adapter_cleanup(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_NOT_READY;
+}
+
+/* This function downloads the firmware to the card.
+ *
+ * The actual download is preceded by two sanity checks -
+ *      - Check if firmware is already running
+ *      - Check if the interface is the winner to download the firmware
+ *
+ * ...and followed by another -
+ *      - Check if the firmware is downloaded successfully
+ *
+ * After download is successfully completed, the host interrupts are enabled.
+ */
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *pmfw)
+{
+	int ret;
+	u32 poll_num = 1;
+
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		nxpwifi_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
+	}
+
+	/* check if we are the winner for downloading FW */
+	if (adapter->if_ops.check_winner_status) {
+		adapter->winner = 0;
+		ret = adapter->if_ops.check_winner_status(adapter);
+
+		poll_num = MAX_FIRMWARE_POLL_TRIES;
+		if (ret) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN read winner status failed!\n");
+			return ret;
+		}
+
+		if (!adapter->winner) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN is not the winner! Skip FW dnld\n");
+			goto poll_fw;
+		}
+	}
+
+	if (pmfw) {
+		/* Download firmware with helper */
+		ret = adapter->if_ops.prog_fw(adapter, pmfw);
+		if (ret) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "prog_fw failed ret=%#x\n", ret);
+			return ret;
+		}
+	}
+
+poll_fw:
+	/* Check if the firmware is downloaded successfully or not */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (ret)
+		nxpwifi_dbg(adapter, ERROR,
+			    "FW failed to be active in time\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_dnld_fw);
-- 
2.34.1


