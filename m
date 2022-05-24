Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B2A532987
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiEXLlt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbiEXLln (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D2925EA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdgeZQYqTlJyU9XAa7lqEIxlGnpMGkfK42yvmrhpnMKgDnhCT3zuDIiMyOaPxhzYW3SinFo6f5tLw2cnyOVsdrqG6h7ERKlKYXyzntBeOvT/EsGj23bwmMo1UTF0oYxQy6awnc4qholMcBPi82mi3yzfz6wYF+srZ/BQ8Kr9QD0sB0LHv2R0oDPviK9z9agSEczzh9bgU2ZR69hAruBQwyXnb2vmcaRNNdMccNmrRH+mmQYdJGKUirbnXHNV9PTHyIMFl3o/WjaNNhXRUSoGjeEW9pMUpy6OpeQFUmTe54NXroYMcTnQly0NLCAmRIyUZSw/87tEX36b2y9KbOZJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2EsdmC0BYJQttpVsZdcSg4Qt8pRmjoMXU92ba804Ns=;
 b=i+7rADt+SZ1uCmOJmg/zWs0OZJvuuh2ZobHgxRJG46yJJP+UaqJPTRb33zdrPhrMUE5B9VfELwds+3JOsh/qu27E1S/67uKOZLTz6CIUj3RBnvRcxKhDuM423rzOoQHDTFqKh5uIGhvKsnOMimKY/ykwG12rKSjIUt6GXHeaTPplgHT7rMLIKLJT6R2D61jJ3GU+o9TCKVlJ+J90whlFmslvZxZOGNnr3xdIqGeTZVbTzeY4VDhfM4s7PShnlyWXHMDXcybL+QqYhxHU0aKlei8O7XUrSzQC7EKfdbt8UHp/v+eVBct7/RE1zJXoCbqL0i1tN8IJomKEHAiBSomRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2EsdmC0BYJQttpVsZdcSg4Qt8pRmjoMXU92ba804Ns=;
 b=Y76M+mke+tA/x61erOz9hWT74l+yQO+b2xx4Vviyf7jK/S0YfRXaE+S+x+Gd2zMiN84Md2bRDoP2z6JuU/3+rxrpluI0kIqdV2NIpxG3EzbkZjTkhLGkcATOUQPBh+y9fbi7M2l5Eeqla7S4VbuXWoqhdMcEvJzT11q/CEERHAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:34 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:34 +0000
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
Subject: [RFC v2 88/96] cl8k: add version.c
Date:   Tue, 24 May 2022 14:34:54 +0300
Message-Id: <20220524113502.1094459-89-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d89b5423-586a-44bc-c7c8-08da3d79fec7
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB066900D941A634DAF3A900F6F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWBaPyg9MAq1lNALY+mNhe529b6ymlGhkw6dY9nXHQW2GqkMcbLg5FGqmo87ytlhKYjsb0lvAP5M+qEPTj/PcuHKaTloKrxM+BpPpq41sm3c8HHYhQ8m72KcQvJ31dhCGEhYfC2JHQzfrZcvufWwEWSGUdN/CcrnvpovnE+h/R8Swbh6Xj0BkoaW5oxIMBlBRpVjkIaFqY8BJxi4oU18Eyta9tSCVZPC9D0S7f4YX6DQueEn8+YkEKRe8quOeh0uvtRmdV4MJL0DmM6kQKC2M0qw6wY/OGSN94zPR90XbAJay4g6RJf0Hbg2lGXlGCsXWwXDaMbYN/WDjxWcyYMTsKmsMAsRKeiTu4BwdA7gog/Z8ic2xV/7jHUmMy4LOQOC37dK2sb0mmy3ix12eKGSgk5aptW2OB5Mx6WneVR+DXjeL8PQFzybqz/CTeVdYxFTAndbJhuucP7nW4q0fd4Jl4cTjg12BpJyg+DlE/GMoMIdvb2Q9qGkOlZLCWhreF/Kwj1cGJrBcQM3M1ySwtheEUEt76PQd68I5gzyQj1eunE8fqPygK+2O5kwjFQOJIIimmV1mxOsmX3IeUoKzrt9Ed+oE2lIy8R+f+NeRyW7Llc5yGY2fBjudSYwqdU3z2I+Q+5E0YDSdjky7ONdaBZteSm35dEM2AuUXqpCfrogNdoRvHoKG3SEDMlYvVetGjTCQTTkNJXfsBOZSbj1hF/aGN9dvKQJ5b5JYjmbzFusESo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDgmkkAfqQHklnF0uiHQm8MBPVhMYH7NmZd+CuGe/0womPIdRidNgb76JPR3?=
 =?us-ascii?Q?gh7ieMnTo/XefafnKGzhOJAWjOWsUGTA5xDh9+ba2puKDPKgpA0OqkZJ+YpY?=
 =?us-ascii?Q?c7djCBmtnM7jQtQf601PsNPSKG2CXTUHRXh5X0qSTewOtLKtqndyxn9dkGKk?=
 =?us-ascii?Q?A/xkAclisuRUfaVddhnrFu7q4lhJ1qTY1jaBc/Ke8xn+LjI77pHSw/8h3No5?=
 =?us-ascii?Q?Fusvq68ljLhkk0lqhUh5Ipf8o2693Mp0lj4lwmzq4/zC+qb2/vuu+oi4hEus?=
 =?us-ascii?Q?trdUYozdVrnMMGQJNOBqM0uBP39JmTQ600N1OZ25Hpvg9I6CM88qG3GedJ+W?=
 =?us-ascii?Q?REdKdImd+eyoPMJORK3rpZw4lUMZYl0xf2uASn7rIYEfeldh1e7Gahbb9/+H?=
 =?us-ascii?Q?94JH2VaaRy5P8xGY/RYP5MAEQz8vhV10/UAP68tIL3ATBSh9WZybUJ55HVek?=
 =?us-ascii?Q?kTgHGqIKm1LKUtvkjZDBptdupMSRNliAeaGFRldVrAJmZjrJHvsAfuQ8yt++?=
 =?us-ascii?Q?UzFToeOFZY13MCjcVS1foGg2KQSI/hhz5pIfJa6wHYBan6Tl7ogVyOO2W4VH?=
 =?us-ascii?Q?UipFW90Ic9KOafq13c6RJR4sQR6usdwH/VZTZk5V+bLX6a1b+3jl/Lx7yTqO?=
 =?us-ascii?Q?QPyhIG19cUKvZrN0fBWFTbwLwoxYfKFDnBNBvzNS3lFNTnWpKjlNk4CLOOGj?=
 =?us-ascii?Q?rruGASvlBDugZHFgSweGL1npnGCbfMT9rTOJITOGn/MvrUEX7rpiq3mmww1Z?=
 =?us-ascii?Q?VUhBGyzRDvmRNjTwcg9t9oYwcLR2IhLu5JbHt0C8rUZyLby9VeGIE2HTRev1?=
 =?us-ascii?Q?YlBmQsqE7oOxrOlRXPn7nDHM+8hL829A9zHKFkRN0sgsdg5gHVl3qYC5qrsb?=
 =?us-ascii?Q?lN6qt5rVsX9N7rrVamJm5awlLL7OYDsLCJDh/0YLXdj2uZYVLGUHG+WKJPbL?=
 =?us-ascii?Q?PLma6wPn5vNzAV0BRh28MRWctJTEUmpZ+bFf8DswwjogdM1I52YJHPu2TLu5?=
 =?us-ascii?Q?4el8X0jqy2zpLgywgqiAAmte7lfOKuuXsfFLMl95pCcPR8k4/+4PtL+fG9b8?=
 =?us-ascii?Q?YArr8zjgVPpx9B7G0FKJugeBA6JfFWfUIqcJsmMMlBORIRg/tXX66rzeC6o+?=
 =?us-ascii?Q?IvN6WJ3cuqO9OCWmYckuJmT6QbQx2n9z68zRRbJWtgsBQ5iiNe08261dLpIy?=
 =?us-ascii?Q?67A807JSRIxaZfBfNFp2GTQbRCnBXCXNbPa6AT3GI04cMwjE35KfPT16Ffb0?=
 =?us-ascii?Q?srAIivtBJ2V/divITsDUtMm2NvzIerf4kLYNXLxpAMZUwKETDpconESlwW8b?=
 =?us-ascii?Q?Ye4WTIyDvZft47eSt8rlTM1tgfUZibbpv0cYeRVC56iL58q7W6jioso205Ow?=
 =?us-ascii?Q?YkPPhPItq+/MnA/qnGPJvIotG8zZHK24cn3OLxx1y3vI1kZRUTtlJHuBXuoy?=
 =?us-ascii?Q?ivVET5ZzuEwOOfG6nu/Yfof7H4CZJ6ztox+aLVKuaZPMMI32jAWemlwddXby?=
 =?us-ascii?Q?GM8tde8topGyftAgG6DenvxxSCW7TLtZ7U/+Txrc0Ghh3OPsfmVlUUo6hqlr?=
 =?us-ascii?Q?YE1AWJt3j+AM7aG7hntdJ2ps3A0j1apGilvkUvquoKKrLgRh71wHZohaHSYr?=
 =?us-ascii?Q?2fqTbMSMba3ZmjQCSHDcY2qPui8rNOrOv7aANDM3+Fnf7V9DEQb+rkm3S5Jw?=
 =?us-ascii?Q?i8d6qgKTEhwb1dAlw7ZVHzxsDjcG2gCrr0FwB24jvXn0CbzGR2a0klmJvaSy?=
 =?us-ascii?Q?EdN1CFp8mJHH75q6658xVdHYbnGPfvU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89b5423-586a-44bc-c7c8-08da3d79fec7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:00.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzlG7DlNJ/rKeXMJnvASf3t2fekJIBTOtMWPR238rV2SmEXwINX/32SX/WC+gQjEX7CHcE7X2hIKXkNRW9uuew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
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
 drivers/net/wireless/celeno/cl8k/version.c | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.c

diff --git a/drivers/net/wireless/celeno/cl8k/version.c b/drivers/net/wireless/celeno/cl8k/version.c
new file mode 100644
index 000000000000..1965190a833a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/version.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "debug.h"
+#include "chip.h"
+#include "rfic.h"
+#include "debug.h"
+#include "version.h"
+
+static int cl_version_request(struct cl_hw *cl_hw)
+{
+	struct mm_version_cfm *cfm = NULL;
+	struct cl_version_db *vd = &cl_hw->version_db;
+	int ret = 0;
+
+	ret = cl_msg_tx_version(cl_hw);
+	if (ret)
+		return ret;
+
+	cfm = (struct mm_version_cfm *)cl_hw->msg_cfm_params[MM_VERSION_CFM];
+	if (!cfm)
+		return -ENOMSG;
+
+	vd->last_update = jiffies;
+	vd->dsp = le32_to_cpu(cfm->versions.dsp);
+	vd->rfic_sw = le32_to_cpu(cfm->versions.rfic_sw);
+	vd->rfic_hw = le32_to_cpu(cfm->versions.rfic_hw);
+	vd->agcram = le32_to_cpu(cfm->versions.agcram);
+
+	cl_hw->rf_crystal_mhz = cfm->rf_crystal_mhz;
+
+	strncpy(vd->fw, cfm->versions.fw, sizeof(vd->fw));
+	vd->fw[sizeof(vd->fw) - 1] = '\0';
+
+	strncpy(vd->drv, CONFIG_CL8K_VERSION, sizeof(vd->drv));
+	vd->drv[sizeof(vd->drv) - 1] = '\0';
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_VERSION_CFM);
+
+	return ret;
+}
+
+int cl_version_read(struct cl_hw *cl_hw, char *buf, ssize_t buf_size, ssize_t *total_len)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_version_db *vd = &cl_hw->version_db;
+	struct cl_agc_profile *agc_profile1 = &cl_hw->phy_data_info.data->agc_params.profile1;
+	struct cl_agc_profile *agc_profile2 = &cl_hw->phy_data_info.data->agc_params.profile2;
+	ssize_t len = 0;
+	int ret = 0;
+	u32 version_agcram = 0;
+	u32 major = 0;
+	u32 minor = 0;
+	u32 internal = 0;
+
+	/* Request data if existing is not actual */
+	if (!vd->last_update) {
+		ret = cl_version_request(cl_hw);
+		if (ret)
+			return ret;
+	}
+
+	/* PHY components specifics */
+	len += scnprintf(buf + len, buf_size - len, "DRV VERSION: %s\n", vd->drv);
+	len += scnprintf(buf + len, buf_size - len, "FW VERSION: %s\n", vd->fw);
+	len += scnprintf(buf + len, buf_size - len, "DSP VERSION: 0x%-.8X\n", vd->dsp);
+	len += scnprintf(buf + len, buf_size - len, "RFIC SW VERSION: %u\n", vd->rfic_sw);
+	len += scnprintf(buf + len, buf_size - len, "RFIC HW VERSION: 0x%X\n", vd->rfic_hw);
+
+	version_agcram = vd->agcram;
+	major = (version_agcram >> 16) & 0xffff;
+	minor = (version_agcram >> 8) & 0xff;
+	internal = version_agcram & 0xff;
+
+	len += scnprintf(buf + len, buf_size - len,
+			 "AGC RAM VERSION: B.%x.%x.%x\n", major, minor, internal);
+
+	if (agc_profile1)
+		cl_agc_params_dump_profile_id(buf, buf_size, &len, agc_profile1->id,
+					      "AGC PARAMS PROFILE:");
+	if (agc_profile2)
+		cl_agc_params_dump_profile_id(buf, buf_size, &len, agc_profile2->id,
+					      "AGC PARAMS PROFILE (Elastic):");
+
+	len += scnprintf(buf + len, buf_size - len,
+			 "TX POWER VERSION: %u\n", cl_hw->tx_power_version);
+
+	switch (chip->conf->ci_phy_dev) {
+	case PHY_DEV_OLYMPUS:
+		len += scnprintf(buf + len, buf_size - len, "RFIC TYPE: OLYMPUS\n");
+		break;
+	case PHY_DEV_ATHOS:
+		len += scnprintf(buf + len, buf_size - len, "RFIC TYPE: %s\n",
+				 (cl_hw->chip->rfic_version == ATHOS_A_VER) ? "ATHOS" : "ATHOS B");
+		break;
+	case PHY_DEV_DUMMY:
+		len += scnprintf(buf + len, buf_size - len, "RFIC TYPE: DUMMY\n");
+		break;
+	case PHY_DEV_FRU:
+		len += scnprintf(buf + len, buf_size - len, "RFIC TYPE: FRU\n");
+		break;
+	case PHY_DEV_LOOPBACK:
+		len += scnprintf(buf + len, buf_size - len, "RFIC TYPE: LOOPBACK\n");
+		break;
+	}
+
+	len += scnprintf(buf + len, buf_size - len,
+			 "RF CRYSTAL: %uMHz\n", cl_hw->rf_crystal_mhz);
+	len += scnprintf(buf + len, buf_size - len,
+			 "CHIP ID: 0X%x\n", cl_chip_get_device_id(cl_hw->chip));
+	*total_len = len;
+
+	return 0;
+}
+
+int cl_version_update(struct cl_hw *cl_hw)
+{
+	char *buf = NULL;
+	ssize_t buf_size = PAGE_SIZE;
+	ssize_t len = 0;
+	int ret = 0;
+
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Force logic to update versions */
+	cl_hw->version_db.last_update = 0;
+
+	ret = cl_version_read(cl_hw, buf, buf_size, &len);
+
+	if (ret == 0) {
+		pr_debug("%s\n", buf);
+		/* Share version info */
+		cl_version_sync_wiphy(cl_hw, cl_hw->hw->wiphy);
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
+void cl_version_sync_wiphy(struct cl_hw *cl_hw, struct wiphy *wiphy)
+{
+	strncpy(wiphy->fw_version, cl_hw->version_db.fw, sizeof(wiphy->fw_version));
+}
+
-- 
2.36.1

