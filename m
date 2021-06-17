Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95F73AB864
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhFQQHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:39 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44002
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231877AbhFQQHO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A49NijcjGZhIpQ044Zuk1L3Dvtog79usnZGxUUm5IkaBjc0QOrLrUCeaZiq4MJf4g/2wUOdTPYJyrSEkBLzdw2pdUG/47wyp9PEuog95i2sGgUMFNvGTMKoFXjyCdi/+1f7gOES4qOYySOAkVSTuA1w4fmJDs3SCGkL67gmsRQ6/0n3MwUYR+GAGFfjpLjQQLjOFutYzGS8Usa3B00U5nII7cvnoYUManFdK6ax3VtKpK4Fpi7tQpasitzGif7NEeFFPzyJaWB+K1Ow94ciHIRCdpIwTyuSKyjRPwOpNR1f10uveavz1bk7AIMBzwo0xQyMwUrnBjpAfM2cyMNXIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0/MfBa4fi/a0mfwach0iLt6iWcZUZYTXh+mnovlmbA=;
 b=CX5HLB/S4sb+Xvjq8Q2kPSF7j6nDorQKxUSVoFMELMYl8VrxUJUtnlANmPKTN7CRphUySinKXJS5ePs194cPm0hSa+pWlOJHi5Ow1m45eU44GPzPbexCE5DAB862jtEFBLlXB40FmtYxObdhTSzKVzzw3Ymg5RWFCR5q8UAC3vWpXDMNXJP370g5hrbRYlhezX9bJydHHcUxu4t+W5gVEcurSHk1aqQateimO42icysFdxhNJEJi3pGlOteORWl5namsZSGFmWJEfpPqJoObdtWBG7o+Np7/IVr//75nrMj3YkBhM3OGQqFc8XH3kG2FUQEHULcBpwl3WO8lQgvKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0/MfBa4fi/a0mfwach0iLt6iWcZUZYTXh+mnovlmbA=;
 b=iKIRyaKN8AGY+2EqK05KC7JB6LbU5aRtyFVUXaELl1VCdOgI9vK37ZvxIz0bu8zpQVea/Uf7zmTRI4k4couEmIeV1GUMXTODIxMYOOcUO8I+BOQ1/ngHi/9XfL/jROf8cUj3gdyWqQAJ8LbTbf0qujZRymZf1WsS32XLCXQMBfg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:00 +0000
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
Subject: [RFC v1 092/256] cl8k: add fw/msg_cfm.c
Date:   Thu, 17 Jun 2021 15:59:39 +0000
Message-Id: <20210617160223.160998-93-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff93d86e-9b38-4fc0-b505-08d931a98e19
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887FD4FEE3D51639E3A4B24F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JStIhaW3iWTxKMmw2Vx/PDfb/4689W2v9fEpujWHQrP1/2pIaMCpnWo9cAd3t2FxmBoWE175lCuUJGIVOiVcuGechYEWCdMGYXZnK2bFzeH6aEFRIGIqlJ5xtvfNpb1APwjsIVTFMHwaKUbQjCdGXBqGcdeWW5u5OzCtKqS9EGI6H2OfZyENV0Q+MbSaZtglpFbxAQRHL6uRWxvqbgkFS/um6wq8a6pYH8Ge37r5mzRPVfuzRtTl/WLifqU1mex54YpDeFj5QfEwMYcnmMC2ksks1a33hRxUjPI2sgrEzkKQLR2rG24QzyVgdPB7CpnQ5MzMRk4LQyejsojyTRE+Bycl3qI9uN176VjtDgZCUBjey9V+gT4OeHv5Dgv61qhyQy7B6BowFNvUuvO+GdfKb8K9L687bXhEl7UWx8e3k5u12fkUCHzhxgyE5QLFc/GFtM8Q05ett5fU8nZ/Q1iNjmhSzyT/qWvDGMKqo9WietvPmduoUJxukmOvS23k2LIwwz2Z7VsOY3Vxi3OOTFzhJmoCkDIURH3pxF2g84tRq/Gthh7Q1Ly2AEhGPCPDrofFv9oqWEQeT5DAqNCxfFaj5Ysmc225ig3Dvgego4s+9WTMLE5SvnmcjjgN7bT/I59dEBXC8ztpxlrJf1SwRZNbRs3SFwnm8NCTEesYAHsy8HZEPx4cw8i3hA7JkTsnoz0LgvGguNgyKXD4hJpRsc7xoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(30864003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wObvT5nW2Sr8hpg9gc1A8NjzfkCBKJbPpnCN3DI+cvVvlYTR/jIzLtYbBFQM?=
 =?us-ascii?Q?k3uMM+DoqHyJ33ZU5zoz4VDrokGXunZgPWuNBmPmzfXJm20puPutWxRi4td8?=
 =?us-ascii?Q?JVAgRangAhDmXjHmC5VESdCrooqShYP7bivpGTvAzBYEdikxLOqECeONMlwe?=
 =?us-ascii?Q?Y6nwvEwjJ/LEDKZrEmC4JZZaW9R9ZrNLT1yOklrCCJ6665kn9IRcg14/3AvX?=
 =?us-ascii?Q?AmBztyCNKP1ivahURozP3OszeLvDGyLdrlGyHoOWKV85ApozyysUnN2OQmMx?=
 =?us-ascii?Q?CM/obiiE3b0HImKiNTCGPcCmrpopXCzwoXUVV0fZ9obUv8LSlGUksyFfQKJd?=
 =?us-ascii?Q?ux4BK9moJOYUShJb1LFdNDDEhh2uB/6dcyTDWmFLiip6M5cmJ7d2MGgkVN7S?=
 =?us-ascii?Q?62+2qu9QCdwBJQ1wIVDSyzLTl6BauW6YAhn2Rh9U/fe+qJzEPXTginV5uhc3?=
 =?us-ascii?Q?msGBReb9/4wKlcEGSGd0YJHmh2D0EPlydrGaxdVg8TsQ2l589awktNNMcqeI?=
 =?us-ascii?Q?rs0iTQ3QfQCFhz5maad4z0azwkSrDe5X+DePeLVhXs1Sa8nQMX/yY15haeXC?=
 =?us-ascii?Q?/13EjgCmF/7IrnaYryIoLMsz5God6gC8rze4pZzfGR2+n/pf2A/9VlMfsopN?=
 =?us-ascii?Q?Gznw3iVQW78LWoI3dGWomDyq7VhneZ+vt+Kt2m6tZ1kmMd5nMsTwFc6/em75?=
 =?us-ascii?Q?BxPpff2JjsaTtMkGfTQiyQqRqXawE7XMiMrpIizpDsjlN3OmZMukLpn3r86p?=
 =?us-ascii?Q?YHhMeyumcTtlw3pEG5Yq1wK99ztUU8FmYKvp1tT5VPv2SEeVlQwG19RvqCfI?=
 =?us-ascii?Q?TTuIRCHtBqwClXqOv8+ALCEeOmpG00mtBMoytnIvlPgnl81pIgKKrvo3TadT?=
 =?us-ascii?Q?OBIPf3dFNnAqdoJUDwWUaJnwVl8/DOtpY93Gl2KT8UOGREsoZ2Wa7QXTEycK?=
 =?us-ascii?Q?STWrgP5GFxjvQhGw7Tug+XCt/eWZe/dpzm/LSMhBYHt5SHnpPJDCaxR/NbvO?=
 =?us-ascii?Q?e/C1YrBaPGm6RjKl2gIzG+TqDJjHGdnhtLdv1/6UCNCYUpfsoxSADf63AE0p?=
 =?us-ascii?Q?3/xxl8zhr0ux9sfP2P7qt6fWtIfzJ/CI1ftdRmWdRJ4xGFC5yJ0pp+TiFJR1?=
 =?us-ascii?Q?UMVL2MmPWeXAp3Ecb5/tYSLKoAbHfS3j8nAkptIUkT6lKDaYDydHhK4asQDq?=
 =?us-ascii?Q?d3vKEkVXUzdKcmPND6j4fVkY8iZUEShz1ZxeIl/mYOaFCBn6ZbJDyMC4IMZ6?=
 =?us-ascii?Q?5R6RxmGDH1N7HIFW09W94D/BJC0R6r+RbwS/0M0r2BfblRxrRv/9NtCsLX9y?=
 =?us-ascii?Q?9ha2tHTe1jJriAAx0LTQGSEA?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff93d86e-9b38-4fc0-b505-08d931a98e19
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:15.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Grvn952/+6RSkge5zKzLOodbnOTim6nSw/7yjgfmdGpNLWZULHh0Htx9utAzd9/vySIFL2ZFOqah/yqNJ8MEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.c | 316 ++++++++++++++++++
 1 file changed, 316 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_cfm.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw/msg_cfm.c b/drivers/net/wi=
reless/celeno/cl8k/fw/msg_cfm.c
new file mode 100644
index 000000000000..a63751d0804e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/msg_cfm.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "fw/msg_cfm.h"
+#include "fw/msg_rx.h"
+#include "recovery.h"
+#include "reg/reg_ipc.h"
+#include "chip.h"
+#include "hw_assert.h"
+#include "config.h"
+#include "coredump.h"
+
+static void cl_check_exception(struct cl_hw *cl_hw)
+{
+       /* Check if Tensilica exception occurred */
+       int i;
+       struct cl_ipc_exception_struct *data =3D
+               (struct cl_ipc_exception_struct *)cl_hw->ipc_env->shared;
+
+       if (data->pattern !=3D IPC_EXCEPTION_PATTERN)
+               return;
+
+       cl_dbg_err(cl_hw, "######################### firmware tensilica exc=
eption:\n");
+       cl_dbg_err(cl_hw, "................................. type: ");
+
+       switch (data->type) {
+       case 0:
+               cl_dbg_err(cl_hw, "EXCEPTION_ILLEGALINSTRUCTION\n");
+               break;
+       case 2:
+               cl_dbg_err(cl_hw, "EXCEPTION_INSTRUCTIONFETCHERROR\n");
+               break;
+       case 3:
+               cl_dbg_err(cl_hw, "EXCEPTION_LOADSTOREERROR\n");
+               break;
+       case 6:
+               cl_dbg_err(cl_hw, "EXCEPTION_INTEGERDIVIDEBYZERO\n");
+               break;
+       case 7:
+               cl_dbg_err(cl_hw, "EXCEPTION_SPECULATION\n");
+               break;
+       case 8:
+               cl_dbg_err(cl_hw, "EXCEPTION_PRIVILEGED\n");
+               break;
+       case 9:
+               cl_dbg_err(cl_hw, "EXCEPTION_UNALIGNED\n");
+               break;
+       case 16:
+               cl_dbg_err(cl_hw, "EXCEPTION_INSTTLBMISS\n");
+               break;
+       case 17:
+               cl_dbg_err(cl_hw, "EXCEPTION_INSTTLBMULTIHIT\n");
+               break;
+       case 18:
+               cl_dbg_err(cl_hw, "EXCEPTION_INSTFETCHPRIVILEGE\n");
+               break;
+       case 20:
+               cl_dbg_err(cl_hw, "EXCEPTION_INSTFETCHPROHIBITED\n");
+               break;
+       case 24:
+               cl_dbg_err(cl_hw, "EXCEPTION_LOADSTORETLBMISS\n");
+               break;
+       case 25:
+               cl_dbg_err(cl_hw, "EXCEPTION_LOADSTORETLBMULTIHIT\n");
+               break;
+       case 26:
+               cl_dbg_err(cl_hw, "EXCEPTION_LOADSTOREPRIVILEGE\n");
+               break;
+       case 28:
+               cl_dbg_err(cl_hw, "EXCEPTION_LOADPROHIBITED\n");
+               break;
+       default:
+               cl_dbg_err(cl_hw, "unknown\n");
+               break;
+       }
+
+       cl_dbg_err(cl_hw, "................................. EPC: %08X\n", =
data->epc);
+       cl_dbg_err(cl_hw, "................................. EXCSAVE: %08X\=
n", data->excsave);
+       cl_dbg_err(cl_hw, "..........................BACKTRACE-PC..........=
...............\n");
+
+       for (i =3D 0; i < IPC_BACKTRACT_DEPTH; i++)
+               cl_dbg_err(cl_hw, "PC#%d: 0x%08X\n", i, data->backtrace.pc[=
i]);
+}
+
+static u16 cl_msg_cfm_clear_bit(u16 cfm)
+{
+       if (cfm < MM_REQ_CFM_MAX)
+               return ((cfm - 1) >> 1);
+
+       return ((cfm - 1 - FIRST_MSG(TASK_DBG) + MM_REQ_CFM_MAX) >> 1);
+}
+
+u16 cl_msg_cfm_set_bit(u16 req)
+{
+       if (req < MM_REQ_CFM_MAX)
+               return (req >> 1);
+
+       return ((req - FIRST_MSG(TASK_DBG) + MM_REQ_CFM_MAX) >> 1);
+}
+
+int cl_msg_cfm_wait(struct cl_hw *cl_hw, u16 bit, u16 req_id)
+{
+       /*
+        * Start a timeout to stop on the main waiting queue,
+        * and then check the result.
+        */
+       struct cl_chip *chip =3D cl_hw->chip;
+       int timeout =3D 0, error =3D 0;
+       int max_timeout =3D 0;
+
+       if (!cl_hw->msg_calib_timeout)
+               max_timeout =3D CL_MSG_CFM_TIMEOUT_JIFFIES;
+       else
+               max_timeout =3D CL_MSG_CFM_TIMEOUT_CALIB_JIFFIES;
+
+       /* Wait for confirmation message */
+       timeout =3D wait_event_timeout(cl_hw->wait_queue,
+                                    !CFM_TEST_BIT(bit, &cl_hw->cfm_flags),
+                                    max_timeout);
+
+       if (timeout =3D=3D 0) {
+               /*
+                * Timeout occurred!
+                * Make sure that confirmation wasn't received after the ti=
meout.
+                */
+               if (CFM_TEST_BIT(bit, &cl_hw->cfm_flags)) {
+                       cl_dbg_verbose(cl_hw, "[WARN] Timeout occurred - %s=
\n",
+                                      MSG_ID_STR(req_id));
+                       error =3D -ETIMEDOUT;
+               }
+       }
+
+       if (error) {
+               struct cl_irq_stats *irq_stats =3D &chip->irq_stats;
+               unsigned long now =3D jiffies, flags;
+               u32 status, raw_status;
+
+               /*
+                * The interrupt was not handled in time, lets try to handl=
e it safely.
+                * The spin lock protects us from the following race scenar=
ios:
+                * 1) atomic read of the IPC status register,
+                * 2) execution on the msg handler twice from different con=
text.
+                * 3) disable context switch from the same core.
+                */
+               spin_lock_irqsave(&chip->isr_lock, flags);
+
+               status =3D ipc_xmac_2_host_status_get(chip);
+               raw_status =3D ipc_xmac_2_host_raw_status_get(chip);
+
+               cl_dbg_verbose(cl_hw,
+                              "[INFO] status=3D0x%x, raw_status=3D0x%x, la=
st_isr_statuses=3D0x%x, "
+                              "last_rx=3D%ums, last_tx=3D%ums, last_isr=3D=
%ums\n",
+                              status,
+                              raw_status,
+                              irq_stats->last_isr_statuses,
+                              jiffies_to_msecs(now - irq_stats->last_rx),
+                              jiffies_to_msecs(now - irq_stats->last_tx),
+                              jiffies_to_msecs(now - irq_stats->last_isr))=
;
+
+               if (status & cl_hw->ipc_e2a_irq.msg) {
+                       /*
+                        * WORKAROUND #1: In some cases the kernel is losin=
g sync with the
+                        * interrupt handler and the reason is still unknow=
n.
+                        * It seems that disabling master interrupt for a c=
ouple of cycles and
+                        * then re-enabling it restores the sync with the c=
l interrupt handler.
+                        */
+                       ipc_host_global_int_en_set(chip, 0);
+
+                       /* Acknowledge the MSG interrupt */
+                       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a=
_irq.msg);
+
+                       /*
+                        * Unlock before calling cl_msg_rx_tasklet() becaus=
e
+                        * spin_unlock_irqrestore() disables interrupts, bu=
t in
+                        * cl_msg_rx_tasklet() there might be several place=
s that
+                        * use spin_unlock_bh() which enables soft-irqs.
+                        */
+                       spin_unlock_irqrestore(&chip->isr_lock, flags);
+
+                       /*
+                        * Call the tasklet handler (it also gives the CPU =
that
+                        * is mapped to the cl_interrupt few cycle to recov=
er)
+                        */
+                       cl_msg_rx_tasklet((unsigned long)cl_hw);
+
+                       /* Re-enable master interrupts */
+                       ipc_host_global_int_en_set(chip, 1);
+               } else {
+                       /*
+                        * WORKAROUND #2: Try to call the handler unconditi=
oanly.
+                        * Maybe we cleared the "cl_hw->ipc_e2a_irq.msg" wi=
thout handling it.
+                        */
+
+                       /*
+                        * Unlock before calling cl_msg_rx_tasklet() becaus=
e
+                        * spin_unlock_irqrestore() disables interrupts, bu=
t in
+                        * cl_msg_rx_tasklet() there might be several place=
s
+                        * that use spin_unlock_bh() which enables soft-irq=
s.
+                        */
+                       spin_unlock_irqrestore(&chip->isr_lock, flags);
+
+                       /* Call the tasklet handler */
+                       cl_msg_rx_tasklet((unsigned long)cl_hw);
+               }
+
+               /* Did the workarounds work? */
+               if (CFM_TEST_BIT(bit, &cl_hw->cfm_flags)) {
+                       cl_dbg_verbose(cl_hw, "[ERR] Failed to recover from=
 timeout\n");
+               } else {
+                       cl_dbg_verbose(cl_hw, "[INFO] Managed to recover fr=
om timeout\n");
+                       error =3D 0;
+                       goto exit;
+               }
+
+               /* Failed handling the message */
+               CFM_CLEAR_BIT(bit, &cl_hw->cfm_flags);
+
+               cl_check_exception(cl_hw);
+
+               cl_hw_assert_check(cl_hw);
+
+               if (!strcmp(chip->conf->ce_ela_mode, "XTDEBUG") ||
+                   !strcmp(chip->conf->ce_ela_mode, "XTDEBUG_STD")) {
+                       /*
+                        * TODO: Special debug hack: collect debug info & s=
kip restart
+                        * "wait4cfm" string is expected by debug functiona=
lity
+                        */
+                       goto exit;
+               }
+
+               if (!test_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags) &&
+                   !test_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags) &&
+                   test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) &&
+                   !cl_hw->is_stop_context) {
+                       /* Unlock msg mutex before restarting */
+                       mutex_unlock(&cl_hw->msg_tx_mutex);
+
+                       if (cl_coredump_is_scheduled(cl_hw))
+                               set_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags)=
;
+                       else
+                               cl_recovery_start(cl_hw, RECOVERY_WAIT4CFM)=
;
+
+                       return error;
+               }
+       }
+
+exit:
+       /* Unlock msg mutex */
+       mutex_unlock(&cl_hw->msg_tx_mutex);
+
+       return error;
+}
+
+static void cl_msg_cfm_assign_params(struct cl_hw *cl_hw, struct cl_ipc_e2=
a_msg *msg)
+{
+       u32 *param;
+       u16 msg_id =3D le16_to_cpu(msg->id);
+       u16 msg_len =3D le16_to_cpu(msg->param_len);
+
+       /* A message sent in background is not allowed to assign confirmati=
on parameters */
+       if (cl_hw->msg_background) {
+               cl_dbg_verbose(cl_hw,
+                              "Background message can't assign confirmatio=
n parameters (%s)\n",
+                              MSG_ID_STR(msg_id));
+               return;
+       }
+
+       if (msg->param_len) {
+               param =3D kzalloc(msg_len, GFP_ATOMIC);
+               if (param) {
+                       memcpy(param, msg->param, msg_len);
+                       if (cl_hw->msg_cfm_params[msg_id])
+                               cl_dbg_err(cl_hw, "msg_cfm_params is not NU=
LL for %s\n",
+                                          MSG_ID_STR(msg_id));
+                       cl_hw->msg_cfm_params[msg_id] =3D param;
+               } else {
+                       cl_dbg_err(cl_hw, "param allocation failed\n");
+               }
+       } else {
+               u16 dummy_dest_id =3D le16_to_cpu(msg->dummy_dest_id);
+               u16 dummy_src_id =3D le16_to_cpu(msg->dummy_src_id);
+
+               cl_dbg_err(cl_hw, "msg->param_len is 0 [%u,%u,%u]\n",
+                          msg_id, dummy_dest_id, dummy_src_id);
+       }
+}
+
+void cl_msg_cfm_assign_and_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_ms=
g *msg)
+{
+       u16 bit =3D cl_msg_cfm_clear_bit(msg->id);
+
+       if (CFM_TEST_BIT(bit, &cl_hw->cfm_flags)) {
+               cl_msg_cfm_assign_params(cl_hw, msg);
+               CFM_CLEAR_BIT(bit, &cl_hw->cfm_flags);
+       } else {
+               cl_dbg_verbose(cl_hw, "Msg ID not set in cfm_flags (%s)\n",=
 MSG_ID_STR(msg->id));
+       }
+}
+
+void cl_msg_cfm_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+       u16 bit =3D cl_msg_cfm_clear_bit(msg->id);
+
+       if (!CFM_TEST_AND_CLEAR_BIT(bit, &cl_hw->cfm_flags))
+               cl_dbg_verbose(cl_hw, "Msg ID not set in cfm_flags (%s)\n",=
 MSG_ID_STR(msg->id));
+}
+
+void cl_msg_cfm_simulate_timeout(struct cl_hw *cl_hw)
+{
+       u16 bit =3D cl_msg_cfm_set_bit(DBG_SET_MOD_FILTER_REQ);
+
+       mutex_lock(&cl_hw->msg_tx_mutex);
+       CFM_SET_BIT(bit, &cl_hw->cfm_flags);
+       cl_msg_cfm_wait(cl_hw, bit, DBG_STR_SHIFT(DBG_SET_MOD_FILTER_REQ));
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

