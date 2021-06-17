Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068043AB81C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFQQFA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:00 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233526AbhFQQE5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+tJLJQSwHl+ZAo6g4F/Qs7aPuJVY1isrricNSOV2cNfRnBVn3aU7YSo58op1qIsO0ZhBpAiUvpiYqray58fQDxtcnyJ3AJCk76Yn2mwR8GrjoorEU+fOuV3Z5ZIaPbw7z+jnH/MiiKYeCcFsIHxT08U834KWTvjhS81wfbR8Q1eNjSUJE/6lZhlgS/9hZA05xqtZACJMbcIanMbRidxcnx6zz/fcQZYJzuGSY94+RcoeAvzLhQV1Rw5BMF62FNfRk6DZvgypY7ogWelg0yeHEddixkBdcfml36T8WyWxuNsF8F4vRHI2lyyAAQi4HxZk8/hdy1vigLExf55mnbL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hIZdRf/3rCy7xoAlqzvmbczcGpn8Zne56pOEFzKv7g=;
 b=ZYEtJfY1NP1i1vTXKg0YQvOX6ZE/AkhvihfyAkOmJ/UVO3RSsqE8Lw/dEO9aOL2e+K8lQK99SDKePRiM4HPmbaf/5+LiUtMxGoWSQ7X7gyAamgoDGoMDnoXaxtj+RQgWJiUHCWRrCQjjVDnpVPa1kAvSuO9F/95xlLNWXVsxrBoq8S/p8C733GqdBQQ6BAbK+dWvlVBWaARyE7M30mXKNiOJTQBU12yo6aHav09T+wsKKoMzj4tBqugA19cw6nCVfyMZaho9HDZT2GmWJH61HYjk+GjXgvzG7zWKXhD6//Z7FlO0Zicliv28mGjyG1pkJJs5CtMd82gaidfDdYm84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hIZdRf/3rCy7xoAlqzvmbczcGpn8Zne56pOEFzKv7g=;
 b=uaRNhacU5bj+CRMYRwuDjmsX4B6Fs5PsOMxFqDbp4Nngx7/vKO877sHw00qVBa6r8VhkP5UGFU2RzRmtwwkCv3DzlfLkbs1kR19TpS4V2iWCnEnr5bTLOiTTWm1azaVAqAfcGHdwdUUK3k2oXbaGWhLn2vENcRpUnsunn/NQsKA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:37 +0000
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
Subject: [RFC v1 004/256] cl8k: add Makefile
Date:   Thu, 17 Jun 2021 15:58:11 +0000
Message-Id: <20210617160223.160998-5-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 025c13d9-dac7-4ff5-6b78-08d931a953c5
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1412F0E8719512F7A36A0A8BF60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGc84CuL7hOQ10FquxtVIyALxnsYdiTiLKqDLyD5GrqrkGnbqJefRLt9Qhxwim/rE1ASQ7WHO9hHzpNZfDOuJTVWfVCNmhyxTyx7sI3zW8pMVoLZYpW3ft79G5M336+CPKx69qh2cb72i/T7KFS0cqH9016xq+rhCYeFUQLg0K1PYdjyhCvsupS5vYhB2jtaUv0suKDJeaXfyhu5qqBc8CH/+rh2H+P6C7Nte1PXOet3cE2vJueXPZ2ezWWtc6maIPaVokI38WOLvGOAVHxrRNCC+G6171SDJcWXSrOOIQW57oqo1Ga6pcq60XsXC8OUQlcailstTQ+YV89yNd6J4A5CJWzJGriF5PznQd9lhVF2WXH7ZvguFZjyWeKYN4F/729D5YEbMlF1rOAQ5bMAVfyG2OrWO0pelnk2ySueTQm0g8tz2H1TT+fuLxrfDxVF5EK8ybSIcmiMB8ANKaoSAe0hjX+bibj7/zqnEuIvT5S0jfnnPe/DLo7OnGoYI6F97EypWqMRk1FK/nTMj0THobAJcxB5kIUGehWneqadbt0NKGq9ng/h3ziHYXsQNMwdw+GbQ3lGIz7i3fTnUS6nj54HOPPhbYwsD5l6OyNTpK/hTsuWit9M8Py6M6ck3n33Q01hqELtRHgxVXFumcEKFh5HDUC30+pE1mXupGV3E/T+9Dea/8A6oPOF8yfxFn3MPh2mMNgZBPFOnFDFk/0iOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8LRHOczWophlgfjnqk7r3JOrTRxECGOAaBg4dFF3hzQROY3Metuee38hEOP?=
 =?us-ascii?Q?vIihOHG1jZxJlKbddPy7MvDhaM3amePA+kNV3qZAJYIW4pjnBeftf/Q7Afzs?=
 =?us-ascii?Q?bUf1Ga6ZWk4VintqhXuVYmVJw2EzmuFg2i4jVG7GjECK4ajNawSTk9AaAEHG?=
 =?us-ascii?Q?eqWt70x/HabZcNcK2fLmEhxDrv+pDFkWr9v/sGo3tqq3Iy5esipQDXb3/odo?=
 =?us-ascii?Q?dN30KF9DSkIlKDV9LeBxJfDy8vjyzfE0ePq/9XM3qJlF8wuoAydUYQ5cUkKw?=
 =?us-ascii?Q?xnWHZhv75ibYLo64INkBl7mXpqiuEIGfWSv7GfuqGyGaCA43tCyu8TislS9H?=
 =?us-ascii?Q?VoZIV/3hNRpeOx4D2BNxCodehUPz1YCAvZCvs+tXew0hzER8uzZdWTKVVXu3?=
 =?us-ascii?Q?VWwHP6DYbSid0tGc8pCaw+MqRIIJj7ek6fAlnLpdk+M1lxSu+oFF12skvyqF?=
 =?us-ascii?Q?PdKOPESls81PYGf71pelSStndj4HkM+fiQrOvKgaXsSvsRBrGD1aJawVX7c3?=
 =?us-ascii?Q?VmAaHc/W4K9JWmqijcWxkYMKofXQipDkIh3YFMfziSH7tPFwq9/pXH2ZcALX?=
 =?us-ascii?Q?uf7yYpKS6x9s4w4hgZf8IVLL9tJQPgUa0t/iC9ciF3iM6uT/OQaSuq3gFvCc?=
 =?us-ascii?Q?jOP+zX9iroH9pYRTL8l+ALIZ0kbC1dniIkkJ1jCnhx7UCw3AgBdErSL7mHf5?=
 =?us-ascii?Q?yoFnTpqY+RP62yPJI1xlkEmZsff0aww1bktDgCWTBHzv1aoPNBQuAma1z1X8?=
 =?us-ascii?Q?fPd9S0hyP5uCPyZl7xkheIliljNfKIQsYNJQ/qFKI6wYFptKvtynSxD3LDh8?=
 =?us-ascii?Q?8ZNcrHEo8C7VFW3QKC0rZ2hU70pmqHI8/w9RTvJSFjnw/XMm1FCQe72rO6Fi?=
 =?us-ascii?Q?cMgaOB6IHrE8KPM4veF7NDLMfbWxYVieWUfdueEkFg0R9dMOJ7tsam/StgTB?=
 =?us-ascii?Q?A+A0YcNIYjWZJjm/kHwjJrOWSAketEXPiYigw1iahI0OIvnVfLi8gGbHzefC?=
 =?us-ascii?Q?bZynCIvCUJIeWJSeo4MIOsgpwuGY+S8WuG5714UpEsDN2iL5KN4Qu7lExzGM?=
 =?us-ascii?Q?wBl4yy0laoVgpU0QkE2F+tmrfLLUYhaechhObO+S9Y364HRuFpo3xtNZqlSX?=
 =?us-ascii?Q?81Slt0Zet3OdQg88KKz/kZqXbuDkKlRXXezivsb8xat5B5VgbV/gW1bjeuU5?=
 =?us-ascii?Q?3ovjfb+TLahScKI5Q2gbFNBOO9Y9XBHmBChEzQw0rEx3ALu0oYxxv8xrmuoJ?=
 =?us-ascii?Q?iWlJ5zbx8mu6eu/DtN0i5wEK8IQGm1LzHru37gTnO0zuSksg6YfUzB5E52l+?=
 =?us-ascii?Q?LGnAYUqvs6fWB/4sX4TdipCw?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025c13d9-dac7-4ff5-6b78-08d931a953c5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:37.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13Rp0+SjpRg6MR+nsSpm/RBny+JVa0WqLk4pHnwPC4rLW/6Bcthywi8f9L2FxXBaXk0Qcg0YH8nF96JUqMDvew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/Makefile | 149 ++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/Makefile

diff --git a/drivers/net/wireless/celeno/cl8k/Makefile b/drivers/net/wirele=
ss/celeno/cl8k/Makefile
new file mode 100644
index 000000000000..188da2ea2dfd
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/Makefile
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: MIT
+obj-$(CONFIG_CL8K) +=3D cl8k.o
+
+# Stop these C90 warnings. We use C99.
+ccflags-y +=3D -Wno-declaration-after-statement -g -Werror
+
+IFACE_PREFIX=3Dwlan
+
+ccflags-y +=3D -D__CHECK_ENDIAN__ -DDEBUG -DCL_IFACE_PREFIX=3D\"$(IFACE_PR=
EFIX)\"
+cl-objs +=3D \
+       wrs/wrs.o \
+       wrs/wrs_api.o \
+       wrs/wrs_cli.o \
+       wrs/wrs_tables.o \
+       wrs/wrs_rssi.o \
+       wrs/wrs_sta.o \
+       wrs/wrs_ap.o \
+       wrs/wrs_stats.o \
+       phy/phy_common_lut.o\
+       phy/phy_olympus_lut.o\
+       phy/phy_athos_lut.o\
+       reg/reg_cli.o \
+       key.o \
+       sta.o \
+       hw.o \
+       chip.o \
+       fw/msg_tx.o \
+       fw/fw_msg.o \
+       utils/utils.o \
+       channel.o \
+       utils/string.o \
+       rx/rx.o \
+       rx/rx_amsdu.o \
+       tx/tx.o \
+       tx/tx_amsdu.o \
+       vendor_cmd.o \
+       main.o \
+       mac_addr.o \
+       ops.o \
+       ampdu.o \
+       dfs/dfs.o \
+       tx/tx_inject.o \
+       enhanced_tim.o \
+       e2p.o \
+       chan_info.o \
+       edca.o \
+       calib.o \
+       utils/timer.o \
+       tx/agg_cfm.o \
+       tx/single_cfm.o \
+       tx/bcmc_cfm.o \
+       tx/tx_queue.o \
+       stats.o \
+       cca.o \
+       noise.o \
+       tx/baw.o \
+       power.o \
+       power_cli.o \
+       power_table.o \
+       motion_sense.o \
+       dfs/radar.o \
+       bf.o \
+       sounding.o \
+       dbgfile.o \
+       temperature.o \
+       recovery.o \
+       phy/phy.o \
+       prot_mode.o \
+       rate_ctrl.o \
+       radio.o \
+       config.o \
+       tcv_config.o \
+       chip_config.o \
+       rsrc_mgmt.o \
+       traffic.o \
+       rssi.o \
+       fw/fw_file.o \
+       utils/file.o \
+       rx/rx_filter.o \
+       vns.o \
+       env_det.o \
+       maintenance.o \
+       ela.o \
+       fw/fw_dbg.o \
+       ext/dyn_mcast_rate.o \
+       ext/dyn_bcast_rate.o \
+       vif.o \
+       mib.o \
+       band.o \
+       tx/agg_tx_report.o \
+       hw_assert.o \
+       dsp.o \
+       rf_boot.o \
+       ate.o \
+       afe.o \
+       tx/sw_txhdr.o \
+       fem.o \
+       chandef.o \
+       version.o \
+       cap.o \
+       agc_params.o \
+       utils/ip.o \
+       ext/vlan_dscp.o \
+       netlink.o \
+       twt_frame.o \
+       twt.o \
+       twt_cli.o \
+       cecli.o \
+       mac80211.o \
+       omi.o \
+       data_rates.o \
+       rx/rx_reorder.o
+
+ccflags-y +=3D -I$(src) -I$(srctree)/net/wireless -I$(srctree)/net/mac8021=
1/
+
+ifdef CONFIG_DEBUG_FS
+       CONFIG_CL_DEBUGFS=3Dy
+endif
+
+ifdef CONFIG_CL_DEBUGFS
+       ccflags-y +=3D -DCONFIG_CL_DEBUGFS
+       cl-objs +=3D coredump.o
+       cl-objs +=3D debugfs.o
+endif
+
+ifeq ($(CONFIG_CL8K_TRACE),y)
+# Without this flag, the trace.h will be searched for in include/trace/eve=
nts,
+# which is not what we desire.
+       CFLAGS_trace.o :=3D -I$(src) -Wno-unused-variable -Wno-uninitialize=
d
+       cl-objs +=3D trace.o
+       ccflags-y +=3D -DTRACE_SUPPORT
+endif
+
+ifeq ($(CONFIG_CL8K_PCI),y)
+ccflags-y +=3D -DCONFIG_CL_PCIE
+cl-objs +=3D \
+       bus/pci/pci.o \
+       bus/pci/rx_pci.o \
+       bus/pci/tx_pci.o \
+       bus/pci/msg_pci.o \
+       fw/msg_cfm.o \
+       fw/msg_rx.o \
+       bus/pci/ipc.o \
+       bus/pci/irq.o
+endif
+
+ifneq ($(CONFIG_CL8K),)
+cl8k-y +=3D $(cl-objs)
+endif
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

