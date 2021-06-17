Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66773AB83B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhFQQFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:52 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233606AbhFQQFt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIfnE897GJXiji1z7C6dFY7vgZX9aIdfe+t4w47Zpiq2KAH942lvgzRb0QtHTK91WuJZnqDK0I89OKGzO7cZLcdZPGRVlqbUKjimDW7DjPGlUoIQbw4l0r2QSL9CTSNm28JHAEubKRezrb8r2poezu2LkzQIh5lI7RGIM0SqjepQeJDPVOgK/2li9Wg0wu1Gqo4zKMPQABnxb8AGXtY1ux0lXynTIJ0Dr8nDVB8GDGGQknUAHshREOzCACUEatlh+sOJWuNuG+Pu9CSJmK+dBguGNgPAofEwGKW6s95YBGqr2mY1E4UCC2A0clJQDh3UQ0mcxlguoy/9DIKPCInFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNiyw4dsG6t2BFz/CZL4f6zdXLNqfpeCCo/bI/KyTQk=;
 b=IUJTRzt9UBV5ix9b3TS3aZMVc5YIWUtIAXiHTx7m0vZCqiIChClNQPtzaUO+kUMn9uQyAI4T6z9KxpHo7qeY7pw+sMNQKO3mZMzXFmnaGdiujC0ipDcUfj2mnebRD2J3m88vMQ+GX0M6st45QypFxXEcEMDv9CH2yL65Qy/BuF/fYHS0TP+50zUhjeqwX2WKrY8AnnAkCWW4krlIGqr7EFLDNuRKCWhttryJyA6esD0o+silyiL76ZCSIork0h18JBoLGPOFEWHhPon3eb9nhRAiTVeP1+ZGpUBy971qceDt7dAJQVfOAUcm1/Vc71sUb39iiJKSIsXf46wZGCR2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNiyw4dsG6t2BFz/CZL4f6zdXLNqfpeCCo/bI/KyTQk=;
 b=ntNgmwjmbW8mlNzvBDgA5TZmarZ0h7dZoGx0E1a2OZYamq5XwzbWCpngO+STzRzNunjFdD/DG67Wat7v4jJ7ux6X7xxoQH/rFE1+VGjOLICL91lRis3EwxQCFv7DkTQ+HOtL5U2FZMiy6IjDMB6IaL7eoeR3xp1juxPNVKzfSa0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:38 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:38 +0000
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
Subject: [RFC v1 034/256] cl8k: add cecli.c
Date:   Thu, 17 Jun 2021 15:58:41 +0000
Message-Id: <20210617160223.160998-35-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cace090d-a9da-40e9-fa23-08d931a96851
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB123488A6BF2533FD782E435EF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXDSsTwAOOzK/dZ6surdMkMl+wS5gDneiM3+IXtKXUtntiTTI3rodNQwEo6WjSwl9FaxVo0/wfQ8Em5VZ/SGZbecFEpH7nMiyNhRG3mkDvV41eV4yxsqTsWZrNMmg32Eh2wJ1lHrIsLTjIVOgC/PxdTvoaGTNbjm0ATewPEmpS7nsB19H3CNCjo8U8P27jSH1o2s+Io9OGtizfxTdDwdKnUh5kSZAM4gOAMSo4LrAk2Ue7CnhFJGHsddRbGGbximBajLYZuYu2+cC1LFPhC68H/sv//hga8S3FGDZQjrxxR0aLjj2UdSTu5Y3Eo/g2Vpe477O5Uzgs81s7MebGTU1d0/SSgBOcTi3Sh2Ks5m+39LQEvYp8lam87xjAyos0Ggi6SN511wYrqchxCi15BtUxLUJiU8ms8GnqPhbi5L5nH8F7eiGAcd2OIBNRXVsrP6GNa/w8UMybkHqBIigkuTiovsdXmJb4c+i4tRLWRaerieUYrUbRl9f+0vyFlpBAIOrC1tAN+KAqDseK+4DIkASHwvdULIVhN9U9lk6SG1I1f+zdNILn96NmFvK2YcacH8WuRhHroF5Lq94SHstOpdcKLXGS9oCsNVAz6Lk0Xm8n+9rGlANBxZbFcQFqApH8DEuxlVua/N6UIVjtRcycaKXFw/5JVGcP/dNjh4WC1LiL94vGqmHTqVBx4Q3vGVfIpAMYYvQNZSXsC/o2lABBAOIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(30864003)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7fVteBx+Hiqo3+Chceuy9Fk+LGtbfT29tKiCxfaVq3pFQjWqL4NHrum7Lr40?=
 =?us-ascii?Q?9z+2wVVZvG2WawQ96h7fwzoWgsoLO8FTQvJ0D1NMIa2Zx+WJz1l88J7k23Cu?=
 =?us-ascii?Q?Bd4CeabDzQezRBr61fhbO7O05CSpRxVVUlXeeN/tbIAWjJA2Uwl2bMDSkaVP?=
 =?us-ascii?Q?J5LX1qHAjNT5ZV4ZkcaMLR/Vn72DZcbyr6nuumO7A1EwAErnHUvbhR1yVCVv?=
 =?us-ascii?Q?e29C4k4ySmVHGEkFyoeHPKbceJOCWvHPc83yDV0XMNG1lAYY0tgzu9B61Shd?=
 =?us-ascii?Q?hQuknr1YNBOtTAfFJiNpvgQ7c2FSHmacDG2uW6uv9QDbxDxzHzqYioh1YyR9?=
 =?us-ascii?Q?lquk8UwKx2QIhWxhllZuJdrCYieRlZmBPf0Vz9TpffZGdYvQJ4aTIHZnSi5G?=
 =?us-ascii?Q?5E4CXaxUwq3dTtURWs6KTX4JxIcS9Dg8XkpcuI2xGx92ut7WRiIsZGSt6JB/?=
 =?us-ascii?Q?OPUe7b0sFzk3NFJL8SAqAbG36Gmo1ycYVThUL0o8qo0P07ePpq5p08pzllJB?=
 =?us-ascii?Q?OR5sXBz1GpMGiaBuD7XBNQT3eaUpNCfl6lzAtOmIDrwBiUAXfILoJnBHRuvb?=
 =?us-ascii?Q?D6WBJM7DRwog4WeBRrdNyntdMUI3k5SlsUcqirA0f8fB5OSrvXOWdGC7yiIQ?=
 =?us-ascii?Q?Z2W23sRyUADABbWrTKQnvExzrQ5dMJGg40a+k/P9Jz5qmFPJCBHDXxXSNWWZ?=
 =?us-ascii?Q?YV0mbgfh37SMaR+Vp2nh2SG0RMDgqP6DH68ElV1/plgnAggn1QXVyPZ5KU8B?=
 =?us-ascii?Q?JIBwHFiCKhzyi8Xt7yQz+LSqNB6LZH4S31n5YAaCT7wo13Es1LemDfqOgyOK?=
 =?us-ascii?Q?J0bH4rYQQjH2bwNoLJAIfegZ89BLy6ARYd0xYLkIKB+MIEofXRbOiktm8DfM?=
 =?us-ascii?Q?NCWCdB/765etGz+JdXX6JoAtKZBYWRCgtfmoHIiP+aRLDsrgFqwg7mJeQFBJ?=
 =?us-ascii?Q?ruU6LnoT35PvMgyoQVSyc1blhdUHu3RHtVuek1XDRO3J0mXsGFMkUtRZUDf4?=
 =?us-ascii?Q?M/B8AEAxjFjxQPxAJNAXrUKnZhumeImPcJeKxSFmdpC8PKehAgz1t2GLWXPY?=
 =?us-ascii?Q?+1+T+SJKemRbTTysbm0BKBvHwS4glw9efVkpX50KIm5QM2wQ26T7JB1/ItbT?=
 =?us-ascii?Q?UqHe1HPV3tn8siwpwSPDGvKx6dpIf/RWbXo3D+LsrahnMWHn15zWxjjTPSux?=
 =?us-ascii?Q?hpfjFbzqp7WIR8Jv0P/nPgEG1IF0QIcZzcKioWL18bSZjEDLL5YFcnYoA7kN?=
 =?us-ascii?Q?yBKHxoj/HFXIXVpyjUHOSmzl8OnMPF1NvRdP+13Gk1VwmtstubXEmV2MdpO4?=
 =?us-ascii?Q?mXSGOkSTlJsJp8hGQhmxAPsO?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cace090d-a9da-40e9-fa23-08d931a96851
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:12.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6FoX2MgQNzBTrikB8mEHtUWtuXNwLWZoH8FwQ/RSzeGAiXsJiTQWH8AOSLIMKEkcYOpKIHZzvpc+aqU1Bxgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/cecli.c | 354 +++++++++++++++++++++++
 1 file changed, 354 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/cecli.c

diff --git a/drivers/net/wireless/celeno/cl8k/cecli.c b/drivers/net/wireles=
s/celeno/cl8k/cecli.c
new file mode 100644
index 000000000000..abe5d4a06f48
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/cecli.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "hw.h"
+#include "vif.h"
+#include "cecli.h"
+#include "vendor_cmd.h"
+#include "wrs/wrs_api.h"
+#include "chip.h"
+#include "fw/msg_tx.h"
+#include "channel.h"
+#include "calib.h"
+#include "tx/tx_queue.h"
+#include "tx/tx.h"
+#include "stats.h"
+#include "power_cli.h"
+#include "bf.h"
+#include "edca.h"
+#include "traffic.h"
+#include "reg/reg_cli.h"
+#include "radio.h"
+#include "temperature.h"
+#include "rx/rx_filter.h"
+#include "dfs/dfs.h"
+#include "utils/math.h"
+#include "cecli.h"
+#include "utils/utils.h"
+#include "fw/fw_dbg.h"
+#include "ext/vlan_dscp.h"
+#include "vns.h"
+#include "motion_sense.h"
+#include "version.h"
+#include "enhanced_tim.h"
+#include "rssi.h"
+#include "cca.h"
+#include "noise.h"
+#include "twt_cli.h"
+#include "omi.h"
+#include "config.h"
+
+int cl_cecli_agc_params(struct wiphy *wiphy, struct wireless_dev *wdev,
+                       const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_agc_params_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_bf(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_bf_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_calib(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_calib_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_cca(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_cca_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_chip(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       if (data) {
+               char *str =3D (char *)data;
+
+               return cl_chip_config_set(cl_hw->chip, str, strlen(str) + 1=
);
+       }
+
+       return -1;
+}
+
+int cl_cecli_config(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_config_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_debug(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->conf->ce_debug_level =3D *(s8 *)data;
+       cl_hw->chip->conf->ce_debug_level =3D *(s8 *)data;
+
+       return 0;
+}
+
+int cl_cecli_dfs(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u16 ret_buf_len =3D PAGE_SIZE;
+       char *ret_buf =3D kzalloc(ret_buf_len, GFP_KERNEL);
+
+       if (ret_buf) {
+               struct cli_params *cli_params =3D (struct cli_params *)data=
;
+
+               if (cl_dfs_cli(cl_hw, cli_params, ret_buf, &ret_buf_len))
+                       cl_vendor_reply(cl_hw, ret_buf, (int)ret_buf_len);
+
+               kfree(ret_buf);
+       } else {
+               return -ENOMEM;
+       }
+
+       return 0;
+}
+
+int cl_cecli_edca(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_edca_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_fw(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_fw_dbg_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_motion(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_motion_sense_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_noise(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_noise_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_omi(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_omi_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_power_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_qos(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cl_vif *cl_vif =3D NETDEV_TO_CL_VIF(wdev->netdev);
+
+       return data ? cl_vlan_dscp_cli(cl_hw, cl_vif, (char *)data) : -1;
+}
+
+int cl_cecli_radio(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       bool radio_on =3D *(bool *)data;
+
+       return cl_radio_cli(cl_hw, radio_on);
+}
+
+int cl_cecli_reg(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_reg_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_sounding(struct wiphy *wiphy, struct wireless_dev *wdev,
+                     const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_sounding_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_stats(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cl_vif *cl_vif =3D NETDEV_TO_CL_VIF(wdev->netdev);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       return cl_stats_cli(cl_hw, cl_vif, cli_params);
+}
+
+int cl_cecli_tcv(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       if (data) {
+               char *str =3D (char *)data;
+
+               return cl_tcv_config_set(cl_hw, str, strlen(str) + 1);
+       }
+
+       return -1;
+}
+
+int cl_cecli_temp(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+
+       cl_temperature_cli(cl_hw, cli_params);
+       return 0;
+}
+
+int cl_cecli_traffic(struct wiphy *wiphy, struct wireless_dev *wdev,
+                    const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_traffic_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_twt(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_twt_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_txq(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_txq_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_version(struct wiphy *wiphy, struct wireless_dev *wdev,
+                    const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_version_cli(cl_hw);
+       return 0;
+}
+
+int cl_cecli_vns(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_vns_cli(cl_hw, cli_params);
+}
+
+int cl_cecli_wrs(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cli_params *cli_params =3D (struct cli_params *)data;
+       struct cl_vif *cl_vif =3D NETDEV_TO_CL_VIF(wdev->netdev);
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       return cl_wrs_api_cli(cl_hw, cl_vif, cli_params);
+}
+
+int cl_cecli_help(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       char *ret_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!ret_buf)
+               return -ENOMEM;
+
+       snprintf(ret_buf, PAGE_SIZE,
+                "usage:\n"
+                "agc_params -    AGC params\n"
+                "bf -            Beem Forming\n"
+                "cca -           CCA related\n"
+                "chip -          Set nvram per chip\n"
+                "config -        Debug configuration\n"
+                "debug -         Set Debug level\n"
+                "dfs -           Dynamic Frequency Selection\n"
+                "edca -          Enhanced Distributed Channel Access\n"
+                "fw -            Firmware related\n"
+                "motion -        Motion feature\n"
+                "noise -         Noise related\n"
+                "omi -           OM infrastructure\n"
+                "power -         Power related\n"
+                "qos -           Quality Of Service\n"
+                "radio -         Set radio on/off\n"
+                "reg -           Register related\n"
+                "sounding -      Sounding related\n"
+                "stats -         Statistics related\n"
+                "tcv -           Set nvram per tcv\n"
+                "temp -          Temperature related\n"
+                "traffic -       Traffic related\n"
+                "twt -           Target Wake Time\n"
+                "txq -           TX queue\n"
+                "version -       Read Version\n"
+                "vns -           Very Near Station\n"
+                "wrs -           Weighted Rate Selection\n");
+
+       err =3D cl_vendor_reply(cl_hw, ret_buf, strlen(ret_buf));
+       kfree(ret_buf);
+
+       return err;
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

