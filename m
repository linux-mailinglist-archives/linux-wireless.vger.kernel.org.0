Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E03AB82F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhFQQF0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:26 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233576AbhFQQFM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtfF0Cjo7HjcI3w8Yq0vHCRvzDOcpH91sERO47lrhOaSGqCy3KTWn8cUsFW9D7uGamhOGSaoHvRc7Tm5oaSNcN2qg9jFW1KKikiuAz3EtHyiP2l7pZHfBrTEB+uG5d2Ome4BA7fpiP4FLZUDdpR5CFsYy7py0Ga8EUwj9XTNYz8QaOuS3UiCTSXti4QvE0HTDS8Od60RihtKQ0HrUYffHi3J5LFqp6+adevW9rFLvOyPT64Dyspw+yCV1FflILun9cHxN+z/+f4xbg7yZzJtTfyZayF9joMXvicqaetF1dfGfy13r37f574f4f11pOSVPsTdqyFFAnehEgpukSQCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E82klbUSJwTGNyiOrdh5ara0wBdo7lVD0yaXP/7gzIc=;
 b=ODFRNLHO5LBEWX3/0s7MNdwpKfkAUYqyzjrhxQs4LB78+TzUe/4HPtC28yZf1+4ycduIHC0EUjUONWB1eZ2FS4Ba0uMIh35gPrbcYizqRMc64oadzQVsjSSKxJLmYyAaKzhkwIxzE0CU4bCXPJqSShSlyGgy/mYUQlKKHlUgLuECav3WQqrgSrZ3Zv9tfUg4iloOWEamAPBuxxvgjlMl9L7OvQT6TtM+vAfAzkNeB8SyqazHHb3pflL9Xea+u0hFcHpEBRy6mPK3pvvfR6Y/lUHd9FgV99lolAb+tMYIlCZXx+Y2FncFdwl7Om/7OkJEz4QhUmrrJ9JaulQnJdVdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E82klbUSJwTGNyiOrdh5ara0wBdo7lVD0yaXP/7gzIc=;
 b=DUqxgbdIM73v1yVgP8ok4t/uLE6VGP9Gt0UaPN40i9uaLA6URImrPzNv8miQZS3XLODvORO0oQOQvOCmkv3xVIJRZ9T1n1NmQ4EfNn44QHrR7NkQ6xgL88zn08afFlDTosqSylvZNGmATpWUWbwU4U2dpEUFpvtUpMA/UAezRuw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:59 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:59 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 023/256] cl8k: add bus/pci/pci.c
Date:   Thu, 17 Jun 2021 15:58:30 +0000
Message-Id: <20210617160223.160998-24-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776cb767-edc8-4bbe-b6d6-08d931a96087
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499116DEA5085FE27ABBB1AF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+3N3cbMDe1Vux7eYSyvGC20YlLr0YohT1pDa4eOXQYWlt8wOGTSkh1TZo2oMYiikhUb9YfXonQAd1T2M0FhWlFan2rFMaCIFJx89ZHLqqvjmYhIH6my/zDpoKll3mX5gcuEkj8n71tDhxYETVxOGAByx3tv/4O6lwDf8kdMF0lSHy/g8fOW8MBe7nGqDjM1BWhevQjb3Vh5vUozQaX0hSsaYE09Md6Fs/6i6YghIzhQ6SezCxtNcU73ObuvfpfgZ73qLvjvHItPqXo3acvgVFBIqv6gPfhth2ICFFGz2TwN1pWL5imnkOOys0WmcMSkfDuwDlQTkLmKrXXzYHnoRc57wGd3yntrjxbnb2Dfgwp0OcMzpY2IGfHHHUIk6K3kLNuQn6GFwuFtWTzWtbwTRw4KYm+qBNPLBzl/s926cHGxROqJ6CDDM/yg/XknM3p2EXpGJuN0LLG2Mytp/cl3Pl/MlQHCljRZYIxgFZCiYeo8olC64asILKwvb+v/TeLZ3MEaaQDJVsRkJuV25fz+M67ngb7ceq3Ff3WwmxD1qrqL1HzOB3aTivSyPn4Xpm+tAVkiv4Awqxgz+Z/fFNCE0aXD5p/8O5E05/nBv4u4swJqMTpplZK2I6tgVYzXGeJuHyTHIT6FdV/IOxmtclbkn81XYK+0CW7CwJdBGFjV5idz5hBZMDFsEn64qVNQP3eCtyfCXzo0eCoJ8LNRkEQnhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WeH96jDA8s6y1IVojrmJoYQ+Pt1EG+ucFCTqloXKWQHqJWjLtlEG73/dSrz?=
 =?us-ascii?Q?OKd4LEp4IPGmx56ogXAzoC+qlAbsSyC6Sn5R+2n9ugnx6FhgZB70OeUoWuoG?=
 =?us-ascii?Q?flaA4bk9QnEg19YcrhWitXoHpjqZLvWS8hwqfzNr/cCZOk3GAs5qDA7v+nz2?=
 =?us-ascii?Q?EZ5rZfoWKQNWbGR5uzwTVf2I3tMUWy12J6AFvv5fbg/nhnhA7gjsWj2mmJYE?=
 =?us-ascii?Q?EMh7oGVU5VX7NmigXsO3pDgvwFt41/ARG40b0Xc8J7iBsfv2P6dNwqcqiRjz?=
 =?us-ascii?Q?yP4n74K1d0HikTCkwo80+EQJYxNcTDrhYxi/fZvA8IurnRbSLR5FkNdxQcEu?=
 =?us-ascii?Q?Hq8JHD9YnKW0soPBW7IUK75Qtae4x0ZuFHWzUfF186ndKKyxNDn5e01D/d8K?=
 =?us-ascii?Q?LhWDyMMpcfHyEZaocdj0S6fpEHfK6WNQnlEKUMBFjzBHWVGd8XVRkTqP7bfW?=
 =?us-ascii?Q?Wqgywm+7eqYPnIyt724aqMkW/Q74HGDeOn585Yu8Q/ndrj9hZepPIQ+Va6hh?=
 =?us-ascii?Q?6ecmOCh0EKxwpsUXSXzlBaTXVjbUTLGVHnA3eFjkImgn7IN8zpI2mS5NZ4RD?=
 =?us-ascii?Q?wGlmRrlB1a613Rz/5UrCA3yaSLZRJKPkrtXB2PvE/1buU/vz/JqgX+TlszcC?=
 =?us-ascii?Q?//i+y3cAKbyMfVgO04UpHHPQBbaE5ORx59RWCQGV8/3KTcf5Am2xDnHnxJA0?=
 =?us-ascii?Q?jfLPSd6Fco/FLw6Grk8Uoe1YlpDxbXJGus5gRnCin/oJaMc8+oAkxYQyxMnK?=
 =?us-ascii?Q?rEIreG8wppFtbsCW/aAEn9hExEeUTEndvp/m3Kx603Z1ghZgE+onQQnjQhKR?=
 =?us-ascii?Q?/RAyqeWfQRAoxMFF2F99OaXHYbG8vNSSBW7gwcUVkW5NK6iYol/Noak5yHbv?=
 =?us-ascii?Q?3kW1RIzGiuxdEMf/TMCiqFmRz8sX8SBgLD137sXAZiW/+TZH9+b0PL1D5Hft?=
 =?us-ascii?Q?x4k/bcL2AqsHJJR07oVasOa/rHqFvh6KiAEq36syTYv12E5OVJuWyG2etMLp?=
 =?us-ascii?Q?l7XGcp6IsqVXq8IH8WnYqB96nLk1ceoeg4TU9vTfYEq6mc/sDsl3XBqPFOZc?=
 =?us-ascii?Q?QFR7UmGhufTlPcxBSnmBTpweAFfI43X3FUCPQLjLZ9YaEHL3QBbvG84p+nwM?=
 =?us-ascii?Q?MbNu5iIw7VWJsRWQTLaungQyJCb1WokbLDyf/V9JOjvQ+c/YzQ0DkIoIEn5V?=
 =?us-ascii?Q?nvwbTTIaQXWZ8Mb8B0mTeXjQ0yYclBe3vBnXUkLMRQtZbqQ4HcPtaW8zi9T3?=
 =?us-ascii?Q?GQOQS2f9rIoFn9IlM+dFWQ69zG8xs1RAN9uv2yBqBWEuRvQsf2xmD0eP9Z53?=
 =?us-ascii?Q?eQtRmdr3dbxivodIxsh8INq1?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776cb767-edc8-4bbe-b6d6-08d931a96087
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:59.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ds6vvgFjOUL+/21ZwWLAHWFdYZ79uKZTSoJWrMyrt8FFDgZhb3mHOJXA/2sieVSn8ajhIheIffu/XkeP8ZwvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/bus/pci/pci.c    | 210 ++++++++++++++++++
 1 file changed, 210 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/pci.c

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/pci.c b/drivers/net/w=
ireless/celeno/cl8k/bus/pci/pci.c
new file mode 100644
index 000000000000..a9c2eebaeb1f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/pci.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "hw.h"
+#include "bus/pci/msg_pci.h"
+#include "bus/pci/tx_pci.h"
+#include "bus/pci/rx_pci.h"
+#include "reg/reg_macsys_gcu.h"
+#include "main.h"
+#include "ela.h"
+#include "debug.h"
+
+struct cl_pci_db {
+       u8 device_cntr;
+       struct pci_dev *dev[CHIP_MAX];
+};
+
+static struct cl_pci_db pci_db;
+
+void cl_pci_get_celeno_device(void)
+{
+       /*
+        * Search the PCI for all Celeno devices.
+        * If there are two devices sort them in ascending order.
+        */
+       struct pci_dev *dev =3D NULL;
+
+       while ((dev =3D pci_get_device(CL_VENDOR_ID, PCI_ANY_ID, dev))) {
+               pci_db.dev[pci_db.device_cntr] =3D dev;
+               pci_db.device_cntr++;
+
+               if (pci_db.device_cntr =3D=3D CHIP_MAX) {
+                       if (pci_db.dev[CHIP0]->device > pci_db.dev[CHIP1]->=
device)
+                               swap(pci_db.dev[CHIP0], pci_db.dev[CHIP1]);
+
+                       break;
+               }
+       }
+}
+
+static u8 cl_pci_chip_idx(struct pci_dev *pci_dev)
+{
+       if (pci_db.device_cntr =3D=3D 0)
+               cl_pci_get_celeno_device();
+
+       if (pci_db.device_cntr =3D=3D 1)
+               return CHIP0;
+
+       return (pci_db.dev[CHIP0] =3D=3D pci_dev) ? CHIP0 : CHIP1;
+}
+
+static const struct cl_driver_ops drv_ops =3D {
+       .msg_fw_send =3D cl_msg_pci_msg_fw_send,
+       .pkt_fw_send =3D cl_tx_pci_pkt_fw_send,
+};
+
+static int cl_pci_probe(struct pci_dev *pci_dev,
+                       const struct pci_device_id *pci_id)
+{
+       u16 pci_cmd;
+       int ret;
+       u8 chip_idx =3D cl_pci_chip_idx(pci_dev);
+       u8 step_id;
+       struct cl_chip *chip =3D cl_chip_alloc(chip_idx);
+
+       if (!chip) {
+               pr_err("Chip [%u] alloc failed\n", chip_idx);
+               ret =3D -ENOMEM;
+               goto out;
+       }
+
+       ret =3D cl_chip_config_read(chip);
+       if (ret) {
+               cl_chip_dealloc(chip);
+               return 0;
+       }
+
+       chip->pci_dev =3D pci_dev;
+       chip->dev =3D &pci_dev->dev;
+       chip->bus_type =3D CL_BUS_TYPE_PCI;
+
+       pci_set_drvdata(pci_dev, chip);
+
+       /* Hotplug fixups */
+       pci_read_config_word(pci_dev, PCI_COMMAND, &pci_cmd);
+       pci_cmd |=3D PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+       pci_write_config_word(pci_dev, PCI_COMMAND, pci_cmd);
+       pci_write_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES =
>> 2);
+
+       ret =3D pci_enable_device(pci_dev);
+       if (ret) {
+               cl_dbg_chip_err(chip, "pci_enable_device failed\n");
+               goto out;
+       }
+
+       if (!dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32))) {
+               cl_dbg_chip_verbose(chip, "Using 32bit DMA\n");
+       } else {
+               cl_dbg_chip_verbose(chip, "No suitable DMA available\n");
+               goto out_disable_device;
+       }
+
+       pci_set_master(pci_dev);
+
+       ret =3D pci_request_regions(pci_dev, chip->pci_drv.name);
+       if (ret) {
+               cl_dbg_chip_verbose(chip, "pci_request_regions failed\n");
+               goto out_disable_device;
+       }
+
+       chip->pci_bar0_virt_addr =3D pci_ioremap_bar(pci_dev, 0);
+       if (!chip->pci_bar0_virt_addr) {
+               cl_dbg_chip_verbose(chip, "pci_ioremap_bar 0 failed\n");
+               ret =3D -ENOMEM;
+               goto out_release_regions;
+       }
+
+#ifdef CONFIG_PCI_MSI
+       if (chip->conf->ci_pci_msi_enable) {
+               ret =3D pci_enable_msi(pci_dev);
+               if (ret)
+                       cl_dbg_chip_err(chip, "pci_enable_msi failed (%d)\n=
", ret);
+       }
+#endif
+
+       step_id =3D macsys_gcu_chip_version_step_id_getf(chip);
+       if (step_id !=3D 0xB) {
+               cl_dbg_chip_err(chip, "Invalid Step ID: 0x%X\n", step_id);
+               ret =3D -EOPNOTSUPP;
+               goto out_release_regions;
+       }
+
+       ret =3D cl_chip_init(chip);
+       if (ret)
+               goto out_chip_deinit;
+
+       ret =3D cl_main_init(chip, &drv_ops);
+       if (ret)
+               goto out_chip_deinit;
+
+       if (cl_ela_init(chip))
+               cl_dbg_chip_err(chip, "Non-critical: cl_ela_init failed\n")=
;
+
+       return 0;
+
+out_chip_deinit:
+       cl_chip_deinit(chip);
+#ifdef CONFIG_PCI_MSI
+       if (chip->conf->ci_pci_msi_enable)
+               pci_disable_msi(pci_dev);
+#endif
+       iounmap(chip->pci_bar0_virt_addr);
+out_release_regions:
+       pci_release_regions(pci_dev);
+out_disable_device:
+       pci_disable_device(pci_dev);
+out:
+
+       return ret;
+}
+
+static void cl_pci_remove(struct pci_dev *pci_dev)
+{
+       struct cl_chip *chip =3D pci_get_drvdata(pci_dev);
+
+       if (!chip) {
+               pr_err("%s: failed to find chip\n", __func__);
+               return;
+       }
+
+       cl_ela_deinit(chip);
+
+       cl_main_deinit(chip);
+
+       cl_chip_deinit(chip);
+
+#ifdef CONFIG_PCI_MSI
+       if (chip->conf->ci_pci_msi_enable) {
+               pci_disable_msi(pci_dev);
+               pr_debug("pci_disable_msi\n");
+       }
+#endif
+
+       iounmap(chip->pci_bar0_virt_addr);
+       cl_chip_dealloc(chip);
+       pci_release_regions(pci_dev);
+       pci_disable_device(pci_dev);
+}
+
+static const struct pci_device_id cl_pci_id_table[] =3D {
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8000) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8001) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8040) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8060) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8080) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8046) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8066) },
+       { PCI_DEVICE(CL_VENDOR_ID, 0x8086) },
+       { },
+};
+
+static struct pci_driver cl_pci_driver =3D {
+       .name =3D "cl_pci",
+       .id_table =3D cl_pci_id_table,
+       .probe =3D cl_pci_probe,
+       .remove =3D cl_pci_remove,
+};
+
+module_pci_driver(cl_pci_driver);
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

