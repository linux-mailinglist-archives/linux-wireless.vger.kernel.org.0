Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D007532965
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiEXLkD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiEXLj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4492D18
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzKh56PrVvIFjkn7Wu4NmBKGdPI3XhHA/d4QGMrqJmlPds13JgStkWrHU6vSV+wXgqKVRtFzkYBbeNUS0EBnH0OH+DW2wK6sGDjtE5//oUIC3iZstPVl+kb5xPQuWi4O1ugN6vNtP8uL/xb+YgtJo/p9JK/Tpdp2fxt348pFCKnzLQRHkKf7otvHRFJwH4/VgjVzRcwr0nuoJYWq0oxyK5+23acB5OceiaGbRpw7354dBqDFZyiQghBCaabr+ydah/rnrsh7RZl4wpcFZuYIemd+MBgSuL6hm/RKGKmvmnwr396tHBmfSh6MJic3bUMLISAueH+YqTxKaru6bZFrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVBs+OrzaqPeKNdbELV8FHA0fl9VpL9yoculXcSaNbs=;
 b=XxdG6Um4MZauZ0Oyy/XFPmu4SjwArQnjTPDt51+TPKm8oQuxkl1vOl7b5sqUZgPVzO9FCTwLiLvi7u9KjrAgr0k/+vIH3EZnilXcmxS4KVqRhEXPeBep+bn77g7jWZkZFB5nbEXbcV0g4y6J2C8ug1IgDXoTHzH6kg/yWYUdpWWKdKV3RaH/r2trKKUFu1BXX2wd+0ojReoWvlfOFu4FzAJCpZn6Li12VHwJlRDR442/l74QmyCHvclM7E/W0WFUig4GUgWd/vk+XRfhVKpbrbMhj0HDZqHBr7RSMjzg7YrL5W3bLV2lWOqYg7cJ7HeMXWycXqt9xyygLxHjySN00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVBs+OrzaqPeKNdbELV8FHA0fl9VpL9yoculXcSaNbs=;
 b=CqBN29rocrCihAmVqfu95Ysx2TR/Gt7imY6ibL/246zL5YhirdmDYEmY+EkJWohJptCBoxRQEwa0walisHRg6Q6o+U0gUag6cwnu8FWKsrtUHgtxs2kQ/uZOqoVDx1r6NGEazE+AjQ0D6GJmECMLlUQW/5rBYC3FIPs8fQV6N98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:25 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 66/96] cl8k: add rfic.c
Date:   Tue, 24 May 2022 14:34:32 +0300
Message-Id: <20220524113502.1094459-67-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7960a886-33ec-4ad1-b719-08da3d79f41f
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB09156A8EF013363A31E47992F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JynXxgYDd9Ixqd+PmQMGA0X5aYxVYoW4wYjMKhTwzSGsBYL7adGQ+Q4hn95Ky34eAIKPmdnZDciPPJqUpQX6BX2RqjpQzSFLyCtTUYk8/aCq5zyfp9tA30A73EKU7XdJqw4N8xBnwHQ4y0PlrBNFFRhTjQ/dCE4Ek+ErN6dfKWn0QyViokTWthFZswlWeAHikXK3g2HtM8WQYSP3n2SDbE2uduqAN9eqlllRDzWnyhVS8FjocFLRyDtQlBmnkM6ZdTlBD7yWucY34SoiKD6P38OovU+AodPl6CBj1aNSPhnqLdzVp+oShlXTJYgfokgsH2SyTTUW5cLJAoE24ZQPKRrDPSoiz9Cb2YVxLSgMDG8a+zgtlvJDtjpFM1PfY1Wo78yOL4XzxuRq5H0PV5DB+BfOTEYZVrFNMcwaQ5zuTQQosoSFNpzlkSp8zv6fQJuJZOgh6aDukJekoWBk9I18fMeCVoEzvhfRHs4K3SVBlEn5zjzwocsJ2jTqidIhVYN+nnK7VMgwsayuo4TGsFoNz+//1Y5Vwt4bTnk3xc3BJblGuZG5rjN5iao+3vxc67DVwMf10jaZCNnjgVz0DxMuM+G9qMjo6K8BOv3Rb6Etkc1uKSA2pYTr9iw1AYh2UerxmOAkWFYILk2oCYDqPLHJEpe3ktDDjkuLPQ8N87uH2dyk3d+GYqgUtSn8NEWD5a5s4WBXYVP13xse45f8TQO6meD+6R4HjR7fJ/9g6s8WoS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZAdAt/809rnHySXeZ0Ytyc87ibbCpVYPo4rfaOGED1hUfhRh+Pv6tWYg9YX?=
 =?us-ascii?Q?naar4wQAAQLuYT4Har1OnV8EeIkZgRPVs1xlO5kKTMtDqVgmpS5hBePSzD0h?=
 =?us-ascii?Q?sugehLKEPPPyQury/sWcbjN5MRyc8VZ+ahKpPP4ABAxzvcCC09n1nutjgMYk?=
 =?us-ascii?Q?laCXlo6BiOLBNLsJnPH+nl6WewYMbD9Jg8JWxaxgV/RepoOqv2w+lrJrLLl/?=
 =?us-ascii?Q?oX2Uq8KHiYB5cqS5mgudj31lP0JbfBn53B/lAOVHy9DG2w65a53PZOdgO6DQ?=
 =?us-ascii?Q?SBf2H49oOzQX1SV0zYgwhP85T1WYNsAZV6YSe3sgh1fR55i7HXGVhqcUbW8E?=
 =?us-ascii?Q?AEW7u6cebo8skhg3QN4ovZiVhmw04dg0ekxBG6KmE64pGo/ngqaPMd8xnCwO?=
 =?us-ascii?Q?qFtDUTxAmZNJn2Ago4GDmMllDUxwQti/ZhrLNkx4zk+ilOEKFgSrBcy0A6qI?=
 =?us-ascii?Q?AIDSXNIOqDP77nhZyOWPHtZqac4JxKw3bIILq1XFQJWuRPwgojS4jwbOvRF3?=
 =?us-ascii?Q?Msm3cMeggSXALMfS/e0VoZ6kT7clsUntMA/xp01dUdqcJfjruFPbO0e37zZo?=
 =?us-ascii?Q?BX5AC4Tv7xjxB6bBAAYZ4629oK0Jol3PxFfmM+myYzhSb6fk+ODCG4Q3AiHV?=
 =?us-ascii?Q?nK7vLe3dhacI9woK6628Z3TEVlAFYeik063ParH0YI6YtpXtKYDwVGZFsa90?=
 =?us-ascii?Q?hR2pgLSwPOJl/1I2p6CEhz9lGlvby4o6IfaXEPwzCC50n7n9uWLggECRT3jI?=
 =?us-ascii?Q?nvf7W5MPg6NjyjO612YNgh3hQ3VyEMH4lfSKI3VvVeQIsYMOGV6iZojjUv9t?=
 =?us-ascii?Q?xH4G8zL5IPkWlnq8uUMnb0oySJc6E9iHkgOua1VougQGnCMKhizqRHIvlGxd?=
 =?us-ascii?Q?NdDlGHA/WjkCZOXWx25zf7AJ6Iik49SLJ2fmoBB1QIO0sUJnscGYpzuCA4bD?=
 =?us-ascii?Q?SYBfz9KM69TcRYG0iioLipeODIUpoHMpZcKh2rAj/10Nl1Ag6bdYbjrvlwWu?=
 =?us-ascii?Q?aclePKTYd8jC6ByEJN6RGdQvRbeHHstr9N899VqxArynXPdKYegmov8uqowL?=
 =?us-ascii?Q?yerOKS2El8ojbKlL9Yj6nFg62A6OO5/b0wEZZzCfH4cA4od69RcnFn7+P1gM?=
 =?us-ascii?Q?7ZbJgmKmfuY4dNoXQbKClwY0pFs8akCOeaXoQnj0YX4xg4JsBfqdlROyaBlF?=
 =?us-ascii?Q?6PKJs7oZJ8JyNfMYS5V51MEGW+BXpdGgi9SfWpyfKQkCjvCreXW28RASoO43?=
 =?us-ascii?Q?bjQ03rqN9eYRjYF/z30YiQYBqx7cxpSNCfLfyGstMF21zJZEa12O1PYZf11X?=
 =?us-ascii?Q?7KmUhCYnUvw8E2h+7bTv+YVAAYdUNDPD3bN+qTqwUnr91b+hX+/MpM8bBiIW?=
 =?us-ascii?Q?iS+/hZMy/UcMkemhbDmpX585wCYPi4VCFesCi3ffpYkVNfmqWPqfPkFnd6xN?=
 =?us-ascii?Q?h3qcQhLr1hWW9vxcguJhKBImaSvMXngz4effkDpnwDGXLYwOl5uIaCEgVUWc?=
 =?us-ascii?Q?hB3XbnsYjNBzpZy5MfZw8l6Eh9k551HNfueCDzdZMet0CTYR025yR9hQ0Af7?=
 =?us-ascii?Q?M0mbcWo1rYD63rvj3ZKOyONN05imhEe/fPNvVOg+HrpbEYPOQVWDQGHKVnj1?=
 =?us-ascii?Q?WU2Cdv2EeEp+1myhAD4RGjXiYf63WSgNHjLWyWVzcY8KW41wOToPwYZNC2su?=
 =?us-ascii?Q?Vu5RBvC+3StFBUMB/sz5iBkV4puJ7nClTYG2WkClafqJksXHACb7lmSMUKLw?=
 =?us-ascii?Q?iEV7zCz5yR1JM0evizarY0ffnON48O0=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7960a886-33ec-4ad1-b719-08da3d79f41f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:42.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pPY5UK35vJksPSmXHwLIR7I5nl/aAnpF9dBWcg+g3fKkURNUPxSkawnXbKNzYijpDwI7WI2xpVK55mAD8leQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rfic.c | 232 ++++++++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rfic.c

diff --git a/drivers/net/wireless/celeno/cl8k/rfic.c b/drivers/net/wireless/celeno/cl8k/rfic.c
new file mode 100644
index 000000000000..5a3a595694b5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rfic.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/namei.h>
+
+#include "reg/reg_defs.h"
+#include "phy.h"
+#include "utils.h"
+#include "rfic.h"
+
+#define PHY_DEV_NON_PHYSICAL 0x0
+#define MAX_LOOPS 15
+#define READ_REQ  1
+#define WRITE_REQ 0
+
+int cl_spi_read(struct cl_hw *cl_hw, u8 page, u8 addr, u8 *val)
+{
+	struct mm_spi_read_cfm *cfm;
+	int ret = cl_msg_tx_spi_read(cl_hw, page, addr);
+
+	if (ret)
+		goto out;
+
+	cfm = (struct mm_spi_read_cfm *)(cl_hw->msg_cfm_params[MM_SPI_READ_CFM]);
+	if (!cfm) {
+		ret = -ENOMSG;
+		goto out;
+	}
+
+	if (cfm->status == 0) {
+		*val = cfm->val;
+	} else {
+		cl_dbg_err(cl_hw, "SPI read failed\n");
+		*val = 0;
+	}
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_SPI_READ_CFM);
+	return 0;
+
+out:
+	*val = 0;
+	return ret;
+}
+
+static int _cl_spi_driver_read(struct cl_hw *cl_hw, u8 more, u8 addr, u8 *val)
+{
+	u8 prescaler = 4;
+	int loops = MAX_LOOPS;
+
+	riu_rc_sw_ctrl_pack(cl_hw, 1, more, 0, 0, 1, 1, 1, 1, prescaler, READ_REQ, addr, 0xFF);
+	while (riu_rc_sw_ctrl_start_done_getf(cl_hw) && --loops)
+		;
+
+	if (!loops) {
+		cl_dbg_verbose(cl_hw, "Read error - addr [0x%02x]\n", addr);
+		return -EBADE;
+	}
+
+	*val = riu_rc_sw_ctrl_data_getf(cl_hw);
+
+	hwreg_pr(cl_hw, "more=%d, addr=0x%x, *val=0x%x\n", more, addr, *val);
+
+	return 0;
+}
+
+static int _cl_spi_driver_write(struct cl_hw *cl_hw, u8 more, u8 addr, u8 val)
+{
+	u8 prescaler =  4;
+	int loops = MAX_LOOPS;
+
+	hwreg_pr(cl_hw, "more=%d, addr=0x%x, val=0x%x\n", more, addr, val);
+
+	riu_rc_sw_ctrl_pack(cl_hw, 1, more, 0, 0, 1, 1, 1, 1, prescaler, WRITE_REQ, addr, val);
+
+	while (riu_rc_sw_ctrl_start_done_getf(cl_hw) && --loops)
+		;
+
+	if (!loops) {
+		cl_dbg_verbose(cl_hw, "Write error - addr [0x%02x] val [0x%02x]\n", addr, val);
+		return -EBADE;
+	}
+
+	return 0;
+}
+
+int cl_spi_driver_read_byte(struct cl_hw *cl_hw, u8 page, u8 addr, u8 *val)
+{
+	/* cl_spi_driver_read_byte should only be used when mac fw not loaded,
+	 * else use cl_spi_read
+	 */
+	int ret = 0;
+
+	spin_lock_bh(&cl_hw->chip->isr_lock);
+
+	ret = _cl_spi_driver_write(cl_hw, 1, 0x03, page);
+	if (ret)
+		goto read_exit;
+
+	ret = _cl_spi_driver_read(cl_hw, 0, addr, val);
+	if (ret)
+		goto read_exit;
+
+read_exit:
+	spin_unlock_bh(&cl_hw->chip->isr_lock);
+
+	return ret;
+}
+
+static u8 cl_rfic_str_to_cmd(struct cl_hw *cl_hw, char *str)
+{
+	if (!strcmp(str, "DONE"))
+		return OVERWRITE_DONE;
+	else if (!strcmp(str, "SPI_R"))
+		return SPI_RD_CMD;
+	else if (!strcmp(str, "SPI_W"))
+		return SPI_WR_CMD;
+	else if (!strcmp(str, "GCU_W"))
+		return GCU_WR_CMD;
+	else if (!strcmp(str, "RIU_W"))
+		return RIU_WR_CMD;
+	else if (!strcmp(str, "GEN_W"))
+		return GEN_WR_CMD;
+	else if (!strcmp(str, "DELAY"))
+		return UDELAY_CMD;
+
+	cl_dbg_err(cl_hw, "unknown command %s\n", str);
+	return OVERWRITE_DONE;
+}
+
+static void cl_parse_rf_command(struct cl_hw *cl_hw, char *str,
+				struct cl_rf_reg_overwrite_info *info)
+{
+	int i = 0;
+	char *ptr = NULL;
+	u32 res = 0;
+
+	while ((ptr = strsep(&str, " ")) && (*ptr != '\n')) {
+		if (i == 0) {
+			info->cmd = cl_rfic_str_to_cmd(cl_hw, ptr);
+		} else {
+			if (kstrtou32(ptr, 16, &res) != 0) {
+				pr_err("%s: invalid data - %s\n", __func__, ptr);
+				return;
+			}
+
+			info->data[i - 1] = cpu_to_le32(res);
+			res = 0;
+		}
+		i++;
+	}
+}
+
+#define RF_CMD_MAX_LEN 64
+
+static void cl_parse_rf_commands_from_buf(struct cl_hw *cl_hw, char *buf, loff_t size,
+					  struct cl_rf_reg_overwrite_info *info)
+{
+	int i = 0;
+	char *line = buf;
+	char str[RF_CMD_MAX_LEN];
+	char *end;
+	int line_length = 0;
+
+	while (line && (line != (buf + size))) {
+		if ((*line == '#') || (*line == '\n')) {
+			/* Skip comment or blank line */
+			line = strstr(line, "\n") + 1;
+		} else if (*line) {
+			end = strstr(line, "\n") + 1;
+			line_length = end - line;
+
+			if (line_length >= RF_CMD_MAX_LEN) {
+				cl_dbg_err(cl_hw, "Command too long (%u)\n", line_length);
+				return;
+			}
+
+			snprintf(str, line_length, "%s", line);
+			cl_parse_rf_command(cl_hw, str, &info[i++]);
+			line += line_length;
+		}
+	}
+}
+
+int cl_rfic_read_overwrite_file(struct cl_hw *cl_hw, struct cl_rf_reg_overwrite_info *info,
+				bool init)
+{
+	char *buf = NULL;
+	size_t size = 0;
+	char filename[CL_FILENAME_MAX] = {0};
+	char path_name[CL_PATH_MAX] = {0};
+	struct path path;
+
+	if (init)
+		snprintf(filename, sizeof(filename), "rf_init_overwrite.txt");
+	else
+		snprintf(filename, sizeof(filename), "rf_tcv%d_overwrite.txt", cl_hw->tcv_idx);
+
+	snprintf(path_name, sizeof(path_name), "/lib/firmware/cl8k/%s", filename);
+	if (kern_path(path_name, LOOKUP_FOLLOW, &path) < 0)
+		return 0;
+
+	size = cl_file_open_and_read(cl_hw->chip, filename, &buf);
+
+	if (!buf)
+		return 0;
+
+	cl_dbg_trace(cl_hw, "parsing %s !!!\n", filename);
+	cl_parse_rf_commands_from_buf(cl_hw, buf, size, info);
+	kfree(buf);
+	return 0;
+}
+
+static u8 cl_rfic_version(struct cl_hw *cl_hw)
+{
+	u8 value = 0xff;
+	int ret = cl_spi_driver_read_byte(cl_hw, 0, 0, &value);
+
+	if (ret < 0)
+		cl_dbg_err(cl_hw, "%s: spi read failed", __func__);
+
+	return value;
+}
+
+void cl_chip_set_rfic_version(struct cl_hw *cl_hw)
+{	/* Read version only on a physical phy */
+	if (cl_hw->chip->conf->ci_phy_dev == PHY_DEV_ATHOS ||
+	    cl_hw->chip->conf->ci_phy_dev == PHY_DEV_OLYMPUS)	{
+		cl_hw->chip->rfic_version = cl_rfic_version(cl_hw);
+	} else {
+		cl_hw->chip->rfic_version = PHY_DEV_NON_PHYSICAL;
+	}
+}
-- 
2.36.1

