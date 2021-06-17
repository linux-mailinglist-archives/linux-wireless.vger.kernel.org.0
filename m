Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431C43AB848
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFQQGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:16 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233631AbhFQQGB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKHG4ucfXGgJHSLWT08BXYsnVPWUa28z5oF5s9qGkZ2NdVwbiuW4M5TjSCqw7Z7x3/141OQe0CbdJ6zP04RJpRym6LSNR+Yv7m0xPbBdoNe78HL/Vm7YbtWFyVxTQbVdieJ99kZIh2DRDHsht/Wm9EG5i2xpnRJI5IyFjVYWU2yNWmK8imaeglsZk8/YE1Yhc4+LHJr0/0TAz0NA4vTLX6o9q+9uwR0jN/EXsjCXVCs/0aWAo9UtVqSLnsFoYIQa6U60zB0ecm9EGbLgGUuomHpRtEC44YpvA/a0GeTaFJyYubn03gyK6Ci+uwpsyo3fpuOv5kk+UTt7CgYIqplbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGY1q7SqNGIRIMtBbDDOWZrOK5fbeM6NppfGsqvLe90=;
 b=Twqu6tQfmWe4W1/JIL46xLG25Mr5Tt35eR2tPWUmi0pFrhBkWC1lxQ70UlDKCibUR4MtT5UiGVLzlCuaRP96TbXbXuAE/8o5f5FjxHOpgsQP2yE1E5DLgMloyBHiYId1ICu0RhjB+Gif01A2561Njib8Eszk6lCWUpAIo2QXzzBhhcO9zVtjfeiH2Tm1h1tl4dgkq00eCQnP9CR2Ulo4qEu5RvIAStS0+VJl06aeGzC1na4VnN0lN5ajtjunOzsOweQ0FDVkrYzHr/7STz6xs8EWmFQo32WTkbhNZ34u2sGdRV0zT8+zXuq2h+3qagyHMxa/jmexIMY5hxVjUFgHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGY1q7SqNGIRIMtBbDDOWZrOK5fbeM6NppfGsqvLe90=;
 b=LXsgGVyiYRUa7SLQHcU2Eku/6lQsMM+980MoZiimb8HWMsGf+SnJETo4fLxRA4FjlOJ5vAPuhiV46ZsYT4rgYltp5VSO/pk8DIFzjvssonZj/nsuAWbjoenU71YwkqTS81zkcEiMdTjMhIbRi3O32TO7MGVDGDAk8aIIiCIggng=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:42 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:42 +0000
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
Subject: [RFC v1 044/256] cl8k: add chip_config.c
Date:   Thu, 17 Jun 2021 15:58:51 +0000
Message-Id: <20210617160223.160998-45-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6956fb4-65f1-49c4-e706-08d931a96e81
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234338FC6AEB37A4188769AF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X85dDIDNdyj9hyi6U2DcBupYIxvtBU8TeA2B7nsss4aYBaB7i/W5GhBcfm+YkwZ+oFyoaYJm/uY5d/HMlfAhWNwqbtvN8ff9hTuld++rN7eckXlpHWsDe3goLJ2hJvINDmaG95gzLeKdQO0lzH8nHxD7O/o/n7h9F6KOXQTrplEIdhJHOtqaUpHFpR+CRrt+6oxeYDw/H+BmX0CvxbB7vUGKqS9KmeG9MNm3xo670RIwKnU29Dy6FLgOVNXqQ5JoGoQiwZlKa8iXJK9cUvcTk6LVLiAvLwW8jbevfkRrPwkVWc3R5xGfIHlkDOs06XjBIV0pMIs36VVpQFS1Lzxrcvf75Xig/Z9Zk+z/8pfeDEJd85v8Sns6YX1lldYabVIpUr/iqdZ1YbHz9wR51jCTcPkem3Uiah8NDyMWPe+uMd2IPWuX7nGWJrmVty8OOoOsuUHPryTnHpCK9RyXL9ZmrPGpA0AQ+NjAzcN4a1XzI8X2BPnVsgUgEFU5lrjcZ32J1m9OxxMYVpYf7FRoBAGBiriEWnZ8WPQckv9xLhFuU5IMAdFP4pytrvFpP5Opnoidnl+5ZiGsYUHUXci6RtpWunVVtO+XFcTfs+IPvhyuXJlD2R+rzwStmuK/tOQZ1DWsp/599JNXTAcomNHeUniBtOi52e00na+ThiHe597w/IWPSQjp6QJE3MOftPcoIVNmWKvtgrHgsoC5ePMEnUVFQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0C6txkqDb+lvVm059LKGR6T7Yw540JPrAQ/OuOAGMcFwlFPubYW/iaVtFkR?=
 =?us-ascii?Q?a9p1JO8OoKiJhJh5Pb/GkfJVuige6724P+LNZStlxLNf93IgFoypqch1E3SY?=
 =?us-ascii?Q?mgPdObQeuubrdcuzh1LinGtq4GY59CXEXwuoaTD+EU+1fihTBvXtNktRnFtI?=
 =?us-ascii?Q?uVAj6HUoSwZ1z8sacW4ZE0wIy7tsA/iGRFz3Wd9ezflW12AFpOGxe+P8WzAU?=
 =?us-ascii?Q?jJTFGYXSHiYQ6iU6O2VfQ+ys5pf9G8OvxeV4SH5klUUOB5yrb2VqYyZkFeNv?=
 =?us-ascii?Q?RwW6iQvrnZ7uu+1Kvm4t8b+jcHie7ZSCZNlNz/ztxwHv4aKMjVj3tOI8WVug?=
 =?us-ascii?Q?j+SjoOdtylZH0gOpP+WeJrzYAsPFj8HvsIEvxt2UQi3UknvvG4/gk/DPL+YE?=
 =?us-ascii?Q?5EkbU8Hv0EXsUsOBX1pSJh6DYTOUDV0SWeVEstP5I6i2UbGKuVDrBjyKI0w2?=
 =?us-ascii?Q?ZCJ77wVv3MaZadGSjGJSD4AmylpAsuj6iwHzXbt0T/DvttIuek8drHJJaQOL?=
 =?us-ascii?Q?kUJmtoOjGZiNM8P2+ivK91DULC5jjYCgemrSlvMzXgrbKNZMEhdsYyIbshgI?=
 =?us-ascii?Q?2iNUJunFrY09jFhAesb0GzodJHAnxAu09s5VI61S8vbR9ZDr20ZTai8EIvz6?=
 =?us-ascii?Q?um2P9ALNZY6d73OwVdfsmfbYadsmLs3Tn5WZlqq6IwMm1afH9/J5CqXC2qxg?=
 =?us-ascii?Q?oTyRL834YJfKOg3aUxZ/WnpwcvOVvmQbZBUGPO1hpMn2/azLy3MYUsO7jTPL?=
 =?us-ascii?Q?74EfC/cvRkCqt/Dr9wMxCkmjfzP6oe0e0PgLwbbLabv/LXzcdoImsAyrp/aY?=
 =?us-ascii?Q?O8wTQiK+JasJARD8AwAHZH7VqUIf8BtFBnExSGlBIArFdzBPNzvvCd+juQB8?=
 =?us-ascii?Q?18czhOMmx04UdnNE0Pg3iC5rddfGe/XxLHXal0+GSGC13Jklma/1zii3Wc5o?=
 =?us-ascii?Q?gVSKAIlAXCL2Z6Ww1nwWxB03KvHkeuEa6DCMZVsJU/cEvNvS8NcpxmM9dMoE?=
 =?us-ascii?Q?t/JySrk5UkqNZnJaryy2x8lVgBNTSxjVNFVpU93+DzbW8lEWHjhjNro7Sw0a?=
 =?us-ascii?Q?qfmFwwpte0OpzbZkGk9n8s6IoxeJPl2yC933kfNk5W6+FVdfUQQdYgCwvMXh?=
 =?us-ascii?Q?NpcgMVw35kmKBDbltj68Fzfj8PHmdjXtwTljcAX1l0WrIV67z7X6AE7stbS7?=
 =?us-ascii?Q?gRypQUreVJ2/dpis7G0/0kweZMhyMnB3ScPYBVcbD1XIpckCE7ZT5zOCFejR?=
 =?us-ascii?Q?KJmlgX7Oini8YYqSdU4oZtTpPIywii5BwwGUbo6dQkLCtd0h4acPWIBVYanS?=
 =?us-ascii?Q?Ngvy+E89tSa6uCPo98cPSlFy?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6956fb4-65f1-49c4-e706-08d931a96e81
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:22.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtdTNG6aWiEvNPMbjvyd3A66ONE1AGSqv4sa+2b6cK5PJUhzQ4NKaB/IibV2HrWS82QMKBRleHVtNyv8fpvkPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/chip_config.c    | 290 ++++++++++++++++++
 1 file changed, 290 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip_config.c

diff --git a/drivers/net/wireless/celeno/cl8k/chip_config.c b/drivers/net/w=
ireless/celeno/cl8k/chip_config.c
new file mode 100644
index 000000000000..c6d60ff685d5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chip_config.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip_config.h"
+#include "chip.h"
+#include "utils/file.h"
+#include "config.h"
+
+#define MAX_FIRST_MASK_BIT ((ETH_ALEN * 8) - 1)
+
+static struct cl_chip_conf chip_conf =3D {
+       .ce_tcv_enabled =3D {
+               [TCV0] =3D false,
+               [TCV1] =3D false
+       },
+       .ce_lmac =3D "lmacfw.bin",
+       .ce_smac =3D "smacfw.bin",
+       .ce_umac =3D "no_load",
+       .ce_irq_smp_affinity =3D -1,
+       .ce_eeprom_mode =3D E2P_MODE_BIN,
+       .ce_production_mode =3D false,
+       .ci_pci_msi_enable =3D true,
+       .ci_dma_lli_max_chan =3D {
+               [TCV0] =3D 6,
+               [TCV1] =3D 3
+       },
+       .ce_country_code =3D "EU",
+       .ce_ela_mode =3D "default",
+       .ci_phy_dev =3D PHY_DEV_OLYMPUS,
+       .ce_debug_level =3D DBG_LVL_ERROR,
+       .ce_host_pci_gen_ver =3D 3,
+       .ce_temp_comp_en =3D false,
+       .ce_temp_protect_en =3D TEMP_PROTECT_OFF,
+       .ce_temp_protect_delta =3D 0,
+       .ce_temp_protect_th_max =3D 110,
+       .ce_temp_protect_th_min =3D 100,
+       .ce_temp_protect_tx_period_ms =3D 50,
+       .ce_temp_protect_radio_off_th =3D 115,
+       .ce_phys_mac_addr =3D {0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+       .ce_lam_enable =3D true,
+       .ce_first_mask_bit =3D 0,
+       .ci_no_capture_noise_sleep =3D true,
+       .ci_dcoc_mv_thr =3D {
+               [CHNL_BW_20] =3D 150,
+               [CHNL_BW_40] =3D 100,
+               [CHNL_BW_80] =3D 100,
+               [CHNL_BW_160] =3D 100
+       },
+       .ci_lolc_db_thr =3D -40,
+       .ci_iq_db_thr =3D -46,
+       .ci_rx_resched_tasklet =3D false,
+       .ci_rx_skb_max =3D 10000,
+       .ce_calib_scan_en =3D false,
+};
+
+static int update_config(struct cl_chip *chip, char *name, char *value)
+{
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       READ_BOOL_ARR(ce_tcv_enabled, TCV_MAX);
+       READ_STR(ce_lmac);
+       READ_STR(ce_smac);
+       READ_STR(ce_umac);
+       READ_S32(ce_irq_smp_affinity);
+       READ_U8(ce_eeprom_mode);
+       READ_BOOL(ce_production_mode);
+       READ_BOOL(ci_pci_msi_enable);
+       READ_U8_ARR(ci_dma_lli_max_chan, TCV_MAX);
+       READ_STR(ce_country_code);
+       READ_STR(ce_ela_mode);
+       READ_U8(ci_phy_dev);
+       READ_S8(ce_debug_level);
+       READ_U8(ce_host_pci_gen_ver);
+       READ_BOOL(ce_temp_comp_en);
+       READ_U8(ce_temp_protect_en);
+       READ_S8(ce_temp_protect_delta);
+       READ_S16(ce_temp_protect_th_max);
+       READ_S16(ce_temp_protect_th_min);
+       READ_U16(ce_temp_protect_tx_period_ms);
+       READ_S16(ce_temp_protect_radio_off_th);
+       READ_MAC(ce_phys_mac_addr);
+       READ_BOOL(ce_lam_enable);
+       READ_U8(ce_first_mask_bit);
+       READ_BOOL(ci_no_capture_noise_sleep);
+       READ_U8_ARR(ci_dcoc_mv_thr, CHNL_BW_MAX);
+       READ_S8(ci_lolc_db_thr);
+       READ_S8(ci_iq_db_thr);
+       READ_BOOL(ci_rx_resched_tasklet);
+       READ_U32(ci_rx_skb_max);
+       READ_BOOL(ce_calib_scan_en);
+
+       if (!cl_config_is_non_driver_param(name)) {
+               CL_DBG_ERROR_CHIP(chip, "No matching conf for nvram paramet=
er %s\n", name);
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static int post_configuration(struct cl_chip *chip)
+{
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       if (!conf->ce_tcv_enabled[TCV0] && conf->ce_tcv_enabled[TCV1]) {
+               CL_DBG_ERROR_CHIP(chip,
+                                 "TCV1 can't be enabled without enabling T=
CV0\n");
+               return -EINVAL;
+       }
+
+       if (conf->ce_eeprom_mode >=3D E2P_MODE_MAX) {
+               CL_DBG_ERROR_CHIP(chip,
+                                 "Invalid ce_eeprom_mode [%u]. Must be 0 (=
file) or 1 (eeprom)\n",
+                                 conf->ce_eeprom_mode);
+               return -EINVAL;
+       }
+
+       if (conf->ce_first_mask_bit > MAX_FIRST_MASK_BIT) {
+               CL_DBG_ERROR_CHIP(chip, "Invalid ce_first_mask_bit (%u). Mu=
st be <=3D %u\n",
+                                 conf->ce_first_mask_bit, MAX_FIRST_MASK_B=
IT);
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static int set_all_params_from_buf(struct cl_chip *chip, char *buf, loff_t=
 size)
+{
+       char *line =3D buf;
+       char name[MAX_PARAM_NAME_LENGTH];
+       char value[STR_LEN_256B];
+       char *begin;
+       char *end;
+       int ret =3D 0;
+       int name_length =3D 0;
+       int value_length =3D 0;
+
+       while (line && strlen(line) && (line !=3D (buf + size))) {
+               if ((*line =3D=3D '#') || (*line =3D=3D '\n')) {
+                       /* Skip comment or blank line */
+                       line =3D strstr(line, "\n") + 1;
+               } else if (*line) {
+                       begin =3D line;
+                       end =3D strstr(begin, "=3D");
+
+                       if (!end) {
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+
+                       end++;
+                       name_length =3D end - begin;
+                       value_length =3D strstr(end, "\n") - end + 1;
+
+                       if (name_length >=3D MAX_PARAM_NAME_LENGTH) {
+                               cl_dbg_chip_err(chip, "Name too long (%u)\n=
", name_length);
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+                       if (value_length >=3D STR_LEN_256B) {
+                               cl_dbg_chip_err(chip, "Value too long (%u)\=
n", value_length);
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+
+                       snprintf(name, name_length, "%s", begin);
+                       snprintf(value, value_length, "%s", end);
+
+                       ret =3D update_config(chip, name, value);
+                       if (ret)
+                               goto exit;
+
+                       line =3D strstr(line, "\n") + 1;
+               }
+       }
+
+exit:
+
+       return ret;
+}
+
+int cl_chip_config_read(struct cl_chip *chip)
+{
+       char *buf =3D NULL;
+       loff_t size =3D 0;
+       int ret =3D 0;
+       char filename[CL_FILENAME_MAX] =3D {0};
+
+       /* Allocate cl_chip_conf */
+       chip->conf =3D kzalloc(sizeof(*chip->conf), GFP_KERNEL);
+       if (!chip->conf)
+               return -ENOMEM;
+
+       /* Copy default parameters */
+       memcpy(chip->conf, &chip_conf, sizeof(*chip->conf));
+
+       snprintf(filename, sizeof(filename), "cl_chip%u.dat", chip->idx);
+       pr_debug("%s: %s\n", __func__, filename);
+       size =3D cl_file_open_and_read(chip, filename, &buf);
+
+       if (!buf) {
+               pr_err("read %s failed !!!\n", filename);
+               return -ENODATA;
+       }
+
+       ret =3D set_all_params_from_buf(chip, buf, size);
+       if (ret) {
+               kfree(buf);
+               return ret;
+       }
+
+       kfree(buf);
+
+       if (!cl_chip_is_enabled(chip)) {
+               cl_dbg_chip_verbose(chip, "Disabled\n");
+               return -EOPNOTSUPP;
+       }
+
+       ret =3D post_configuration(chip);
+
+       return ret;
+}
+
+int cl_chip_config_set(struct cl_chip *chip, char *buf, loff_t size)
+{
+       loff_t new_size =3D size + 1;
+       char *new_buf =3D kzalloc(new_size, GFP_KERNEL);
+       int ret;
+
+       if (!new_buf)
+               return -ENOMEM;
+
+       /* Add '\n' at the end of the string, before the NULL */
+       memcpy(new_buf, buf, size);
+       new_buf[size - 1] =3D '\n';
+
+       ret =3D set_all_params_from_buf(chip, new_buf, new_size);
+       if (ret =3D=3D 0)
+               ret =3D post_configuration(chip);
+
+       kfree(new_buf);
+
+       return ret;
+}
+
+void cl_chip_config_dealloc(struct cl_chip *chip)
+{
+       kfree(chip->conf);
+}
+
+void cl_chip_config_print(struct cl_chip *chip)
+{
+       struct cl_chip_conf *conf =3D chip->conf;
+
+       pr_debug("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
+       pr_debug("  Chip%u configuration\n", chip->idx);
+       pr_debug("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
+
+       print_unsigned_arr(ce_tcv_enabled, TCV_MAX);
+       print_str(ce_lmac);
+       print_str(ce_smac);
+       print_str(ce_umac);
+       print_signed(ce_irq_smp_affinity);
+       print_unsigned(ce_eeprom_mode);
+       print_bool(ce_production_mode);
+       print_bool(ci_pci_msi_enable);
+       print_unsigned_arr(ci_dma_lli_max_chan, TCV_MAX);
+       print_str(ce_country_code);
+       print_str(ce_ela_mode);
+       print_unsigned(ci_phy_dev);
+       print_signed(ce_debug_level);
+       print_unsigned(ce_host_pci_gen_ver);
+       print_bool(ce_temp_comp_en);
+       print_unsigned(ce_temp_protect_en);
+       print_signed(ce_temp_protect_delta);
+       print_signed(ce_temp_protect_th_max);
+       print_signed(ce_temp_protect_th_min);
+       print_unsigned(ce_temp_protect_tx_period_ms);
+       print_signed(ce_temp_protect_radio_off_th);
+       print_mac(ce_phys_mac_addr);
+       print_bool(ce_lam_enable);
+       print_unsigned(ce_first_mask_bit);
+       print_bool(ci_no_capture_noise_sleep);
+       print_unsigned_arr(ci_dcoc_mv_thr, CHNL_BW_MAX);
+       print_signed(ci_lolc_db_thr);
+       print_signed(ci_iq_db_thr);
+       print_bool(ci_rx_resched_tasklet);
+       print_unsigned(ci_rx_skb_max);
+       print_bool(ce_calib_scan_en);
+}
+
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

