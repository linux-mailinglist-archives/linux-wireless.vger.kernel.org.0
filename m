Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10463AB841
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhFQQGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:05 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:58626
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233624AbhFQQFx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jADbGAUzN7au2juGNTPHptuGWKA349+f9R+c5Hf0ys4iPBSawHlU3MD6jeLIaMlZ87ZdTNc9m291fLR1vtrlyEDuVRXJ2tSDIGa682JSV617gu1D8vjHCgcO727XSmRa+iOtWX88/widFdKOV8VZJMr6gxmYB3BydiFzywNo7Evst8zKzx/LEald1Zw3pXAv3xhU/5LFRt5VMIr2j0SoP7kDshI84C8ncRfL8QTaTp9vOLAF6lM5XbGQR95E0PYtHkz1C3xmCpdQkvc6USt7N2moDlqVGpKYvgy6mIFvVR5ENkYrQFYfql6Hgp5Uc4EplVvcSVb1Nx63HFFZD0QClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FHc0eagsG1Y+mXySLUSg9FbeHOmsxMg4Vuf1zU28RI=;
 b=BCy5TG6G07Oor0NDsAymp3oLfnVzw5hjLv8qb6tggy6tnH6v1w74crTOy+sxTpf2to+GJK/mV1bWLHsncASCnCV88kjc2yKcd1VE8ir9wkrRkMn/DIarVfFYkKSU6142e1bmwFkWUk/2KIMdG3sKPSNpsfYTSl+fdWXH8Agn2t0yQ1glBxFrRrqrXo8m2qWRawmEVlnwInH/YO3ZylCfQZPZaLsUbKKsRPrxJBiLF709/5VqB7ic5yzmqjWZUk2uMGr6gRPdKljOsUPzKhK4kq4lCCl8PRdqJLWbCIVCFPqan6Cgzyggii9rCXTzNJMoZytsRChDE8PNjIvfXvOylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FHc0eagsG1Y+mXySLUSg9FbeHOmsxMg4Vuf1zU28RI=;
 b=QdbaRlB8hBmgohWFFzgbFYBz93xjcmQ6SW3G57KmCLARWeysICkJeJEtMEgW1bw+lyxpaASmM1Klp6GOhqwiGmGkSzvcA1Bs3K4bHWlKDoWL6xhVO5xGTpreRzefk7pMey5lNVDtuBtumXrMarZiD6wsJadZQAgKpVTqTR+czcc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:43 +0000
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
Subject: [RFC v1 046/256] cl8k: add config.c
Date:   Thu, 17 Jun 2021 15:58:53 +0000
Message-Id: <20210617160223.160998-47-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5e1c25-17a5-4566-be6a-08d931a96fb1
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04995298701F364DC78EC10AF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQUTh5bvfsVbRn0k+QAj7SnbKa9uyjpxCtCjMOjmTgthLcLaH9A6mrD9BsnKUtnYY27VqdzwuTn8+p1MeJByvGVjye4V/GlVAfy0VwNw8PleWfj+FeXnUSEntoa1PfV8tPucmayFJ1lbWV5j8D6ZnsmrXQ1mMKUH9TJOoTYsbx3W5MGWC7Xh/tdft2oBmLjcKywUji9fVr6MB6rqVxUnsXbrO0vHCU4MLyzpmbFNd5LRe806hQgSYh++ahXpOSDQzb7dxwZAsJD+pNDGnWtykNLTFM1vn7+Je7HD00kPwFhq/xQj7YUG2eBN/zf4QQy9nEwCWL2fqbEyz8fBSjWOVEvi2SRYvUdml1LCg79FvIE/if0CTIKoKOTwdTt6DAM07I969OfTAjX99B0UMCfaff0uz8cZKnv7f9FZFRwgByMAqANjEJCRpNj+JwcqKtX1j1XtfEPN+TTLq4Kzvu/O4ShNQeTJYF5pJnGohmCUzpgCKDssG9ZTHP+4VSn/Q8vMVB6sjecEwYrAPOTm3nU/cazK5zgFlXOIHYL2emrw9E2MeImiMbbZZFnOqxSOB/8Lnb5s4w0nFM+BOswQrDq8gO6Bo2lrAA24P0KNNtJtssf03jtOQXZ8+sg8eHpT1xWZUOxHsX9MVRFfvkP95eskVjd+KFDQK5od5RGcksact+pgDD8Wvx5n1uxrAFYxJwfF/g7PdYJAQEs75uj9FIzrMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWBO3zWrxesvVLr0PmItIM5NBAKk4NMY/H21sDMLcNZR43Kmw/lRPcovq3Co?=
 =?us-ascii?Q?HGxyzIj78AiPq7OEDqgeeH+SGBhMmMlf9m8J4K2ggSMwOC9rUTTqmC4Q6u/s?=
 =?us-ascii?Q?DVwGEnAg2OjQ8ci8aCTlr6fFMTIDL3QHECLPGavm8ucdWeTI4Xmu3KuRjib9?=
 =?us-ascii?Q?5a50xUKQojeTqmo1rtACCUKGk4HErIVCnOnXas/4SuQc40TP189jLYaem6U3?=
 =?us-ascii?Q?Jl9ZNFpaqU4/kWY5oCh5qvlKkLqfqH+3CdZqQy4AGSJpjn4mttm+DsfYbYqs?=
 =?us-ascii?Q?WXA3YTyUpmb9CtjBrApcXX+536hBpHQgiz1TosZOBRbQQ0aoBhP2zEmAgKID?=
 =?us-ascii?Q?cviVpuOofZdrx88rbKjBXZUtMs+gFpnHaCiSH8a4h2X+mBsGtwcAhqEU0DpL?=
 =?us-ascii?Q?6hFB3M/TJSCHB3gHhuy9zOk0Iphg+QdW7aBrAtygj4y4gjL49D2sfpM0mSMv?=
 =?us-ascii?Q?Y/OBV3N8xjDCHIZxeVbrKWUq0V45oMbIPcra2tEmKqpi9e88ALtuzAoNjPZs?=
 =?us-ascii?Q?6KhJPmEWvowYxu0PXhAf5ie5lD33GpG4nnhx3pOgOQNnQzb2jZiyBw+xlAf4?=
 =?us-ascii?Q?hVSJVhG93DwjqyoHcA7D3izVySbBpm7RTwBT8C/0oVSp4GZbErBLieiz+E3z?=
 =?us-ascii?Q?ev7t6xDMfCTIFRZct+Y5bk2XIrFSXVAnkHaqDdi99fGH+2oaGO+zebbxh/CJ?=
 =?us-ascii?Q?bRHZfHc2OPV/Xt+zxy8YV3AGBjty93zPHaUpqMs6cRxUpNHrhGOBNuwIy9N7?=
 =?us-ascii?Q?F1E9OmJur3wm1RSaEHSof1ttIE4zgDRGHjmU8pvYFFmfFmOQ5ajxJo/2640e?=
 =?us-ascii?Q?ZTN7H7W4ghMMEgZT2C9VkV9PFekbGTcFOCeKv311o8R2/OJAMpMfWu/oH8bf?=
 =?us-ascii?Q?zVM4MlQlOiYqGxHlfhbXFVt5hyMLDl7TFIWI423SbsTPCOlYH45aRhzXWsDi?=
 =?us-ascii?Q?0Zd8+bTsDFWpQTA5IP9gOsuAIV9++Ncjdqta5Za68ebJyT4Xfh6XZbiGiip7?=
 =?us-ascii?Q?NP6THoQxyOW11ay/C1Svfb7wyWWVbMeHO2Fxk2XSntwnqQ1no4q+MdEK2k2R?=
 =?us-ascii?Q?1HUUqUXszi+1SBk2s6dCIiy4VzTRV7FeygjXW1FZfwMJNmIA03xtPyATh1uJ?=
 =?us-ascii?Q?x++WueaEXBzIntq/zW+DMC+MN0Wr7FyXYTAXc8zl2IuXqtykjLecNNQHxKxt?=
 =?us-ascii?Q?62CD/UIf8QjynNOYat9PytBMEoIi7w9wvIMhyPCHyK7aTrGFDiOaapcUeeHW?=
 =?us-ascii?Q?JY05yw09ejXFx3csJzT43fXF1WFYBY610aWLSuGbATIu3rX48ciI6o4IO4qP?=
 =?us-ascii?Q?1mJkavBOQG6wPXeYSdy5gRd1?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e1c25-17a5-4566-be6a-08d931a96fb1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:24.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZiJepC8xTX8ZY2GjkfoZDkjuABihsfDd1ywnujANXgKbK45sVwQS/hpjyd5chPwr+24NK5zTsKOYqWTE5xkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/config.c | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.c

diff --git a/drivers/net/wireless/celeno/cl8k/config.c b/drivers/net/wirele=
ss/celeno/cl8k/config.c
new file mode 100644
index 000000000000..8dbe72adfd3d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/config.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip_config.h"
+#include "fw/msg_tx.h"
+
+static char *non_driver_conf_params[] =3D {
+       "ws_",
+       "ha_",
+       "uuid1",
+       "ce_pci_id",
+       "ce_rst_gpio",
+       "ce_iface_eth",
+       "ce_iface_vlan",
+       "ce_iface_ip",
+       "ci_sim_chip_num",
+       "ci_lcu_dump_folder",
+       "ci_server_addr",
+       "ci_server_user",
+       NULL
+};
+
+bool cl_config_is_non_driver_param(char *name)
+{
+       int i =3D 0;
+
+       for (i =3D 0; non_driver_conf_params[i]; i++)
+               if (!strncmp(name, non_driver_conf_params[i], strlen(non_dr=
iver_conf_params[i])))
+                       return true;
+
+       return false;
+}
+
+static int cl_config_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "config usage:\n"
+                "-c : Print chip configuration\n"
+                "-n : Set NDP TX parameters [chain mask][bw][format][num_l=
tf]\n"
+                "-t : Print tcv configuration\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_config_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       bool print_chip =3D false;
+       bool set_ndp_tx_ctrl =3D false;
+       bool print_tcv =3D false;
+       int expected_params =3D -1;
+
+       switch (cli_params->option) {
+       case 'c':
+               print_chip =3D true;
+               expected_params =3D 0;
+               break;
+       case 'n':
+               set_ndp_tx_ctrl =3D true;
+               expected_params =3D 4;
+               break;
+       case 't':
+               print_tcv =3D true;
+               expected_params =3D 0;
+               break;
+       case '?':
+               return cl_config_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if (expected_params !=3D cli_params->num_params) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (print_chip) {
+               cl_chip_config_print(cl_hw->chip);
+               return 0;
+       }
+
+       if (set_ndp_tx_ctrl) {
+               u8 chain_mask =3D (u8)cli_params->params[0];
+               u8 bw =3D (u8)cli_params->params[1];
+               u8 format =3D (u8)cli_params->params[2];
+               u8 num_ltf =3D (u8)cli_params->params[3];
+
+               if (IS_VALID_TX_CHAINS(chain_mask) &&
+                   bw < CHNL_BW_MAX &&
+                   format < FORMATMOD_MAX &&
+                   num_ltf < LTF_MAX) {
+                       cl_hw->conf->ci_ndp_tx_chain_mask =3D chain_mask;
+                       cl_hw->conf->ci_ndp_tx_bw =3D bw;
+                       cl_hw->conf->ci_ndp_tx_format =3D format;
+                       cl_hw->conf->ci_ndp_tx_num_ltf =3D num_ltf;
+                       cl_msg_tx_ndp_tx_control(cl_hw, chain_mask, bw, for=
mat, num_ltf);
+               } else {
+                       pr_err("Invalid parametets [chain_mask %x][bw %u][f=
ormat %u][num_ltf %u]\n",
+                              chain_mask, bw, format, num_ltf);
+               }
+               return 0;
+       }
+
+       if (print_tcv) {
+               cl_tcv_config_print(cl_hw);
+               return 0;
+       }
+
+out_err:
+       return -EIO;
+}
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

