Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCE3AB85E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFQQHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:24 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:9431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231250AbhFQQG5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEyQTw5jMGxYyfM5vZxUqYknva8DtY0denN1vd7PfxDI8NWCE7S0Bv8yS3y6E3DDIcQ7YOIrw05BLjZ84Y8qXUNZxteN2FRjI5w2nhJJOwrnTONXXU5zN/yE6PqJdIUMyk0qVmmu0cXP2dVUQbDGeDjaJ3QSsQnVLL+SLWd/axHZJi+/3jV1PLaEs99qkGJdoDm5VAaPVlP4ZPV16m6WR2dr3nXmXVHH9GAd1XipoeDYSjLcAA/z+ll2eT+9KUC+TyFG5YlsTRF6zaSdQBYnTOE2ArLBS0aDGJmJZeDY0sxlTc2VevDLtd965dN9Ro6Iwm4RE+NqKikiF6SOsU/Ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkC1xuyuLRAgicDO+WAcDllcKSpVNF5iPSIlVAMzX+s=;
 b=XSQu+uX0Y2oEoFtNuKbYV1Pb6psw4FuQ1tsg4zAUDc4TkKq68ffrtlzjSTQi4G/PsWYxezZLzCwLTX+I+ddkshtcP5xUMK/keU+Ao9HbRy6x2RaN5NeJKeAUgcw9EeULOJ8HA24IIdFyZ5XHaQiYxGjun3f8O474aroRiLGIb+cBEuBbBBf1Ulw30sKD6RXUT/2GJlrPxZdmv/bEnbKqgX8K5yK2p0P+qRMZxvHjhhFXXZCs6gcw/pX4c54FMimy0dafKLZl8oIidOyBp0r6CkWd1yQZ7Oh2GzptjNO5QbOKpiERPrKPrb+jGLDwbrcUIGQ+NoZ9yZXUFHl96twfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkC1xuyuLRAgicDO+WAcDllcKSpVNF5iPSIlVAMzX+s=;
 b=Rxj2W0vKNSNQA+kcIPo48UTB/sIPbd74g9Lu0DbiToBWy3FkGSAi3FtzMCEgty6tV2NBlyX05/ljVcFdJVT9VbfRexvscQQodQ8PCzKyer2RauGvluGi7sx3YlYX8y1shR9yM9fu42QnM5Q4rfd40DHqWcVgLLrsljdCbaw/UhU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:20 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:20 +0000
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
Subject: [RFC v1 064/256] cl8k: add drv_ops.h
Date:   Thu, 17 Jun 2021 15:59:11 +0000
Message-Id: <20210617160223.160998-65-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e31b6cd-eeb1-4c27-221b-08d931a97b92
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268E25ACB59C854337FDCF4F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu/iJ5xwQ6igNQzGfnNgiaMhlIwyEEcPvuaYBMjBDFMIeoAPh/8lfZhKk6gIUMp2iMge7XNGvKLF+9V1Yp+w3lOFe2QhfayCVuk89uil+PkQIYnLGy9HlKDX4T2JGdVEEuTEoVBuOIKfexE8Jcjt6Z5sUDchJORL6AFsZhQpe/UWQ2Pt4FBItXv7nKvo8MBRScmt0F2O65slmAWLr26rp4avqP+o8hIE/XdZEPIuf6ZJZwYEjXdbx+ubnCGDraASqtPZV1TTWZkv8DrZ+xhLsClTRa75LGj1Pq9Fa6OESOQdEoth2GRkR50o7k4IenwOwtlnfOYydahE3nWI/WKbwd3IVZQsaldND+UvJiUQBQU6WlZwOLbpUU40Q6gNaE3O+BY0DzhoF3SCu6HSl/sJVpfL3koUvQPKQ3B1gc0oYWD0SIcm+wI4t2fbqgHClFk7gzCSdUb8saUYvsI3cIgz/UVoTJrEKbIND5DdqnIyjC0nksxXbg0iNBlPHnTGAFjEudLmpIh+cUlD/WryEPhFjbiMtxrt82/zVx9GVzEIIDeo50NvM3EoMTMjrjLmautoDtZRub79prZ9Vy/8Dw5pT+aBALyjc1CswH5sSdB8v4ElbRI3jL5zB2rnmzk2MzEfSsKtmXRWC7tXjhBLoW+3LPGhevyc5e9ETaEaOc+NCY0zSRf0UxgVSE/5TmpARWm2JefopipNgbI1iBPZ+tUuow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bx7ST5HodbKLeLLnWweVerxGAGMhQHGTpIfTJ9rjJuKLBk0/ryfwxTiXmQTZ?=
 =?us-ascii?Q?ApcaXF2O/mSagW/oXfCsqPVQ6ddAlOASjxAwoBrQb8/06c2kxg+g20u6qFA4?=
 =?us-ascii?Q?L7BPLgH7JqUIlvGrsqQG2AHqsEfQE6ksSb0xcWJqSE+6oFLLAN6ictX6fhrR?=
 =?us-ascii?Q?nx8zpl9VmJNoqy+1he5nfM9LndcqGo7EA2HBKOYbilYAuHukpy1c+R0mug9e?=
 =?us-ascii?Q?QYTA9hIfFPzzr7CH+OpI2QwaAodM09PGM/Cl/+k2tHMDVtVHdDa3Rv4rgkkV?=
 =?us-ascii?Q?tcYlxHzp0zQL8KGRGIonmG57kS/uN3/UyFeY15lgO3AjuTD0WzHW7zMVTVwZ?=
 =?us-ascii?Q?He2Pc3d/Gb8pFbZkSi/QTrNgzrwQAB7spmqH+S+cT2pUosZBLlML1lhic7zn?=
 =?us-ascii?Q?TIHv+SmSBQX0mWo26rD4idoNgMiPvmrlCg17KktZIF6Vd00TGl39GUCScSdf?=
 =?us-ascii?Q?0vZl8Ef+Iqh2+EvRu4uxM6vvNcKZoScG/TwI0Pb5Oip1xsQgv3cEwO+9pmJJ?=
 =?us-ascii?Q?7OHS5v5ZjA5ApWn4DezjL3Vd7l+wd9OYRDUeDc1jk46OQe5zlJJGMbC3GFCz?=
 =?us-ascii?Q?ros+eEysscqmmyQwIRgSri2hZGjtHBKoLSw8pAEtWsMvJYF/BX3B1bN4MYfV?=
 =?us-ascii?Q?psDQSDheetWrEB+D1r7qLk1dbSD3wrTJZ1HBkWYD/w2IQJDI32mbWvHk+VzA?=
 =?us-ascii?Q?6cgbWwnt6K1/Phmxp5jydoibI3ongfn+Bc7gQ/BcB+Mna80U72q76cTSXVbK?=
 =?us-ascii?Q?+GFSj/IjOcCmIzRnulmngc8JhS1VgChObbxceLEl0qxI40UeQRyFjeK14kGh?=
 =?us-ascii?Q?bRFCspacvAmITmVt046/Pc6f/9dSS4Z00oX5sWaMunO2GTJQFK2ZPDjNiy7C?=
 =?us-ascii?Q?z57S4M6uUXKg3KLgDptPDttIRitGFjKSIfBNRTmn3E7C9yPywyN9ZfL2GNxD?=
 =?us-ascii?Q?JnfRrc8SekRcOzN68l9wAIcKkXK5SbT8rrWxl+IRWbL6fOnb+pRGzkCMASsj?=
 =?us-ascii?Q?BYAgXniZdaqW1B11+hTzDUR9vj4zjWIqmHTer05RU94p/2fpx0n0rTWgv0sB?=
 =?us-ascii?Q?hcIOBs0vo1gkAD5F2RYB+nb/XfpGcCGDzlQXhMc/mqs+Dz1OFM+ggLUnajdk?=
 =?us-ascii?Q?nN49nODttKs01a8nKgOz2MIaJArwQeBurYsw2D9k9sFTbNDWStzQOHnUDLa/?=
 =?us-ascii?Q?DqG0X2Rq2pLm+Y6M1HAZyvF9AtAeJa0zsLD80eDzKvhG2JxElPNUbkI1zIkC?=
 =?us-ascii?Q?hxstYf6d6BCphPfj0+7NDsMC8Hm+QKCeWEgiJ/N9IS24BtW/iioA27zQAlee?=
 =?us-ascii?Q?ZtlTTUHe3m8XfEVZ5vVunovF?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e31b6cd-eeb1-4c27-221b-08d931a97b92
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:44.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQM9hrnzsx4KE5r4CO4UWbX6EXen5pB3rBBvO8IgXKg4flnQqTkBsyWjiZNUMJdsk+/+L1NGwNZK2d+R8Rerrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/drv_ops.h | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/drv_ops.h

diff --git a/drivers/net/wireless/celeno/cl8k/drv_ops.h b/drivers/net/wirel=
ess/celeno/cl8k/drv_ops.h
new file mode 100644
index 000000000000..3e8f56d9d6f6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/drv_ops.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DRV_OPS_H
+#define CL_DRV_OPS_H
+
+#include "hw.h"
+#include "tx/sw_txhdr.h"
+
+static inline int cl_drv_ops_msg_fw_send(struct cl_hw *cl_hw,
+                                        const void *msg_params,
+                                        bool background)
+{
+       if (cl_hw->drv_ops->msg_fw_send)
+               return cl_hw->drv_ops->msg_fw_send(cl_hw, msg_params,
+                                                  background);
+       return 0;
+}
+
+static inline void cl_drv_ops_pkt_fw_send(struct cl_hw *cl_hw,
+                                         struct cl_sw_txhdr *sw_txhdr,
+                                         struct cl_tx_queue *tx_queue)
+{
+       if (cl_hw->drv_ops->pkt_fw_send)
+               cl_hw->drv_ops->pkt_fw_send(cl_hw, sw_txhdr, tx_queue);
+}
+
+#endif /* CL_DRV_OPS_H */
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

