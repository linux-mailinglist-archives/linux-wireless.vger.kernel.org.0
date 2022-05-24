Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283CD532923
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiEXLh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiEXLhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F28CCD1
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbUxYeCWSnTt0pyzlDHYqCI8kKK/YB0u0TInmn51P8vtGsQ0MCi08lEYswmO2me9rsrX8mUuTSBl4CfCdfrWjM4jacot+In1k5ItHodFTSvcUV/mf/zfQOs4mkz3KZlL8oIvZ+UM00FbPtDQ/Lmx+EqIaYIOpf+uARhWxccyr3w1hmKYct9kgVtwikD6n+0I33D2TO0QAd+uokqCPaFDLOrVshQP8JwfgPkucwSBkezYYsvnfSI1Wvpy8MrMwVGQcsxZUp64dFKOeKy7SO54/7KWw1p9rcmqudJ6dCLP6dLMgDBdYMIBop2Bu/B83kPY+ZDv0GDAt4r5qIHRyrgzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjlMsvoYqrF8iI2C6Th+1QHgUI5fwYhcRgfn2VJai9Y=;
 b=kSqxwgQLvVd4mQ8c9zNPc63mJxN8AGJ1FFIOuiejv8q9thZOptGs5zhfCPC6DwrAUI36sT3hy6cWtk3YHXDcYliOuumd4IZUpdp2bDWHxMhTkXRcx085N8KaCIFjkNvsjz0ert4sQme6ZfFcBQcLk00ZYrI+cSoLbheGLV9jmiVtlI9NiELBY7GJMLmuSicOFfSWNUvjBjik/TaUXvqb+3UTlHg3s3tG26ccizL5XM/VBm0LJRycJDiruD7xpmkSyQ1UG3nRKEdiKtlzbYcXmzcTaozA3Zly1g7mkLSmko/bhTnRTyCEPb1zNbfUSHKbKBtqMEzAT9IlvuK+Xqj2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjlMsvoYqrF8iI2C6Th+1QHgUI5fwYhcRgfn2VJai9Y=;
 b=ou9GPR9vqsLoaNN/HuLcDFmm9bjMhnFQ2WyYUGeiEUBmq4dpwCL1dJiqMs/JqhDlqMNgHTY8YHZY556bD+13vKvikliymJV7DUw28/rd8vOV3UVrAnXUAoEgIlNyb7ld9uNcH9p6spl9p+XlzXqWdbBtPjPmesemfZzp0ileVDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0501.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:17 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:17 +0000
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
Subject: [RFC v2 00/96] wireless: cl8k driver for Celeno IEEE 802.11ax devices
Date:   Tue, 24 May 2022 14:33:26 +0300
Message-Id: <20220524113502.1094459-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a0fa428-2ef3-4eb6-cbae-08da3d79c197
X-MS-TrafficTypeDiagnostic: AM6P192MB0501:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB05011725005D37DCB60BC7BFF6D79@AM6P192MB0501.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aH5cgiN7VkMQqOmlNZRMArS/miF0eNKMwzYGRyg15Oc10vCWdpIqxmyXzEgtWwKCHZbMUgnXcZcqyaxA+Xt3DZ8H9H6Gy6ProQvCITcSj3fn+QIC3bONGkLQvvkO5hIw4B9E9q5LRTEUXDbfi0ZOde4PCVTrrntJz87zFu5QPedpxUXlmf9pZ7hwtWyACeFEURTmhxytrTkmGIYD0s+jFLl6f9/B+pEBQ/RHyWEHi7LVxw+Mj98dAGhKbz9rpakzOhxVTlaZrAZ5zyLHymZ9hBGWnfx0etAXO4/iyKF19/nrmTznhSNAq/6vtJNiVDn/yj+91x48cC2Kt4ufYyba6Uat3S2HKK49B6NTmP8+nM5WhVMZguV9q6imOZFV2mvVexMC3qKZsfADQ6MhlmuVYJXouq7zWm23zmRvwvYIl7xhFvRc6S8MRF51LsNpGS9KNvWqBViByXoRsFAETq+LX155KTfWkExmTk9e68mPSYFxFq+NVXdYRqLmq7fbZAKbbtHFM3+OnmXN8gPeaAE+zobLGkWZugwkiNVCnxKTBIxxNFzvyc2eXFKHmvgE6rmclY8KoY9lS//xUP4nTbWUcdtQnk+Mhz5MBMduf3uyYTw8xzqOfhma1zQaIVdRCOB87UDj40HppnKBi7EO5y4EWUFquvoTnseHY1MHmewIt42EXUoE9mnpX87K5pMjOV1t9sZ5L/UUaAi1fEjwDJGT7/OdfZdFhLVXPlvfPl52v/UkoQM+AtoAmIhnvAlItfxxxCLogG64LUg53ftF8UW5duRskDZZbiPmkAQK9whuP2bkXVL+w+SQsAQZp0J7yK2G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(39850400004)(366004)(346002)(396003)(6512007)(186003)(38100700002)(2616005)(1076003)(9686003)(86362001)(6666004)(6506007)(107886003)(38350700002)(52116002)(6916009)(66946007)(83380400001)(54906003)(6486002)(966005)(30864003)(4326008)(316002)(8676002)(5660300002)(41300700001)(66476007)(36756003)(66556008)(8936002)(508600001)(2906002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L6cXfGYdD62cZ+QDovm2XcJcKXr0X0IuMcOnCq8pZkAaUTd7nMIuEZBlR8Dw?=
 =?us-ascii?Q?QRmnWtYGkr/M6gno+o1DA+kFGLrONKvVK+MvZhc3exBKyPv58asL1OpuVFvi?=
 =?us-ascii?Q?cHvvPTWF+Ca4EaalTrmTjvJPKYJfz5Z1CZ0hyps+gBJ7h8NHc1lncpl/k1WR?=
 =?us-ascii?Q?pft97NyQAybFlLIUPTc8wCdv8Eugko+zoaak+grcBcvZDdYQmHQy8hQVWEo0?=
 =?us-ascii?Q?VyXea9b8+39THz/RvL9lIjusxqwzEAnCKxrQdRV9Z2hkJUTE1zvYpve6iUVt?=
 =?us-ascii?Q?9S3RMhyAaONzZmWUdGh6qiHnZxdhGxR24J3tShaJVOzCLtmRy+AzngBoTNLR?=
 =?us-ascii?Q?RdFkUvkhBRNI1ILTW4aM/EyyJj9EzV5l/NLDmBtzAqpmy5oFnHGg6FDGeQRY?=
 =?us-ascii?Q?Lbo7BlG4Y/pdSECYEOmTqA1Ka15XOq944EDwBQNfqvavcGCJpzgH+CIM/LI+?=
 =?us-ascii?Q?5ZCneOUX6vv1auSzF0554gLn7VA8reh26cChLPXsSgMFsHj15B8zXICfb/aO?=
 =?us-ascii?Q?TY7xGrR+QkROBytof1s5ZgKTiIze9biFF8gcO/41wK/g7ZNc4qrzumSAE1S6?=
 =?us-ascii?Q?7vltRswK9dn0/KV9pggbY0fPUCqSBKM9OT5OkvSz+S1gBfWK4svblEZ8Olhm?=
 =?us-ascii?Q?ewraQ3k4KwoqPoIhMZQfQWXCYXez4YIM64fpBXuogLRt/PLA9FZBDX9mzfXz?=
 =?us-ascii?Q?dh1ud1xhVKYDgoPLdbB77UhXTAtmo9ZCarUQC68wFRLaBGBdEm9kEYrtE2Nd?=
 =?us-ascii?Q?4DkDgpqPqaqZGB+QVbLdBaOc27WZwk8WBg3ZVTl62tE3LQd22MFI8ETO7g6T?=
 =?us-ascii?Q?kgKAvapAyyVRpCnNcKx2jHI7NDupAiM/5adgfyTsev9DJzPM2LZDN2I9mKbn?=
 =?us-ascii?Q?BaYzw7z7jCTRY88LKvt3xWE3V2/n/NNNAbDC5ryFnNM74M60sy5VCsKY3ubN?=
 =?us-ascii?Q?e3Qld9xOrCXP3xE8xioIQwVLnDDpzEF85gOkmeqy6cT9IyYu4CG8TxT11gju?=
 =?us-ascii?Q?tjU6L6plR0NE9Wy0B0q0LTZeFVgikTVvaDK/DfD8YywVBk6bFz46VQNgSODZ?=
 =?us-ascii?Q?oR3QvIKUE1YOjn++62G4mEUx4ibeHZewvoG9/egJZB4B7VFVZ7zWlDDlaOBU?=
 =?us-ascii?Q?otdQsXiXgsGxJqT63Lf0MY9GF892YJcqRQP+L4IwrLfk0a5khbP9PT7Id95S?=
 =?us-ascii?Q?iwEwzYs8Im65SH2fCc+DrggWFvMA6g+9gqcHqnjn7Fae6WDaOR6RUGEmYL7X?=
 =?us-ascii?Q?I0WtlFUlJyUMpEECvteCygu5idh9SMIiqoBcFpnfeaXe833tRTAVsXU9Efpm?=
 =?us-ascii?Q?ibRWLjUFRcy5B0+Vxc7d/rFplZAXYhiLTniPt6yHK59N5mPiZWBnBuvHV0AI?=
 =?us-ascii?Q?W+N3OQb/1hfUGEfBB5rOTq4271NSiJl/Hwecb9d6XVutkHUv4Y+dtlhMrnc/?=
 =?us-ascii?Q?hT1rkDuHcaJFtZMiCEXJ7MunB86GiphicmFAAexP64I17886uqjTGvxCtnDW?=
 =?us-ascii?Q?XGRw8snp0gmM2Db1BDXLBSLZZj7Gnxe6vV8p+uJpx2Y4FZglyFr95G23GNxq?=
 =?us-ascii?Q?bnRPcwJdy39YVf23Zt4K4XvKXXZ8vYAjioWB+7NAHuRYK9H662KBtO8+cPO1?=
 =?us-ascii?Q?1kLAL3wUdoRqoXbziilbmeP9kv/+EOLK8DVdJfOGn9l/py8iYDst6k0dAcPt?=
 =?us-ascii?Q?qtXMJ1+v7zY1nS5OJdfluaiLhEPzxIOFZMoBWwXMSXNnzjI83gx6rxAKPPia?=
 =?us-ascii?Q?Tu/mN8KaKlVuoWG8dh9nslXtYMVYI+Y=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0fa428-2ef3-4eb6-cbae-08da3d79c197
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:17.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dAlGwjtUA+NTiLuH4oetDz0YNHh8wHKq4JtJILl5SZTpgXhy21yJGkSYPKe52crjMIroNBjVqWGKAhY4nl/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0501
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

Celeno Communications publishes to the opensource new wireless driver
for an own 802.11 chipset family - 80xx. The main chip supports multiple
simultaneous bands functioning (2.4G/5.2G or 5.2G/6G) over PCIe 3.0
dual-lane interface. Basically, the chip is dual-band concurrent up to
8x8 in total, and up to 6x6 per band, including 802.11ax 160MHz support
and functioning of AP/STA/MESH modes. The driver architecture is strong
SoftMAC.

The current patchset is the second one and is considered to be published 
in form of RFC (Request for Comments, version 2). If there are any
suggestions/propositions - we will be glad to fix them and
eventually share the driver with the community in form of an official patch
(including the firmware binaries).

The RFC is divided into separate patches on a per-file basis to simplify
the review process.

Known issues:
- driver may be configured via config files, that is discouraged by
  upstream and may be changed in the future.

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Eliav Farber <eliav.farber@gmail.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@celeno.com>
Signed-off-by: Oleksandr Savchenko <oleksandr.savchenko@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
v2: 
- Reduce files amount from 256 to 98 (including 43 source files).
- Fix Kconfig vs code inconsistencies.
- Remove Celeno-specific wrappers like cl_snprintf, cl_timer, string
  processors.
- Namespace more functions (with cl_<something>).
- Remove DEV_COREDUMP support (temporary. to minimize size of the RFC).
- Remove CLI handling in the driver (forever, reimplement some of the features
  in the debugfs). 
- Remove netlink vendor-specific commands.
- Remove debugfs code.
- Fix sparse warnings.
- Fix more checkpatch errors/warnings/checks.
- Update codebase to the most recent internal codebase (as of 20.05.22).
- Adjust patch to support Kernel 5.18-rc7.
 
v1: 
- https://lore.kernel.org/linux-wireless/20210617160223.160998-1-viktor.barna@celeno.com/

Viktor Barna (96):
  celeno: add Kconfig
  celeno: add Makefile
  cl8k: add Kconfig
  cl8k: add Makefile
  cl8k: add ampdu.c
  cl8k: add ampdu.h
  cl8k: add bf.c
  cl8k: add bf.h
  cl8k: add calib.c
  cl8k: add calib.h
  cl8k: add channel.c
  cl8k: add channel.h
  cl8k: add chip.c
  cl8k: add chip.h
  cl8k: add config.c
  cl8k: add config.h
  cl8k: add debug.c
  cl8k: add debug.h
  cl8k: add def.h
  cl8k: add dfs.c
  cl8k: add dfs.h
  cl8k: add dsp.c
  cl8k: add dsp.h
  cl8k: add e2p.c
  cl8k: add e2p.h
  cl8k: add eeprom.h
  cl8k: add ela.c
  cl8k: add ela.h
  cl8k: add enhanced_tim.c
  cl8k: add enhanced_tim.h
  cl8k: add fw.c
  cl8k: add fw.h
  cl8k: add hw.c
  cl8k: add hw.h
  cl8k: add ipc_shared.h
  cl8k: add key.c
  cl8k: add key.h
  cl8k: add mac80211.c
  cl8k: add mac80211.h
  cl8k: add mac_addr.c
  cl8k: add mac_addr.h
  cl8k: add main.c
  cl8k: add main.h
  cl8k: add maintenance.c
  cl8k: add maintenance.h
  cl8k: add motion_sense.c
  cl8k: add motion_sense.h
  cl8k: add pci.c
  cl8k: add pci.h
  cl8k: add phy.c
  cl8k: add phy.h
  cl8k: add platform.c
  cl8k: add platform.h
  cl8k: add power.c
  cl8k: add power.h
  cl8k: add radio.c
  cl8k: add radio.h
  cl8k: add rates.c
  cl8k: add rates.h
  cl8k: add recovery.c
  cl8k: add recovery.h
  cl8k: add regdom.c
  cl8k: add regdom.h
  cl8k: add reg/reg_access.h
  cl8k: add reg/reg_defs.h
  cl8k: add rfic.c
  cl8k: add rfic.h
  cl8k: add rx.c
  cl8k: add rx.h
  cl8k: add scan.c
  cl8k: add scan.h
  cl8k: add sounding.c
  cl8k: add sounding.h
  cl8k: add sta.c
  cl8k: add sta.h
  cl8k: add stats.c
  cl8k: add stats.h
  cl8k: add tcv.c
  cl8k: add tcv.h
  cl8k: add temperature.c
  cl8k: add temperature.h
  cl8k: add traffic.c
  cl8k: add traffic.h
  cl8k: add tx.c
  cl8k: add tx.h
  cl8k: add utils.c
  cl8k: add utils.h
  cl8k: add version.c
  cl8k: add version.h
  cl8k: add vif.c
  cl8k: add vif.h
  cl8k: add vns.c
  cl8k: add vns.h
  cl8k: add wrs.c
  cl8k: add wrs.h
  wireless: add Celeno vendor

 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/celeno/Kconfig           |   17 +
 drivers/net/wireless/celeno/Makefile          |    2 +
 drivers/net/wireless/celeno/cl8k/Kconfig      |   41 +
 drivers/net/wireless/celeno/cl8k/Makefile     |   66 +
 drivers/net/wireless/celeno/cl8k/ampdu.c      |  331 +
 drivers/net/wireless/celeno/cl8k/ampdu.h      |   39 +
 drivers/net/wireless/celeno/cl8k/bf.c         |  346 +
 drivers/net/wireless/celeno/cl8k/bf.h         |   52 +
 drivers/net/wireless/celeno/cl8k/calib.c      | 2266 ++++
 drivers/net/wireless/celeno/cl8k/calib.h      |  390 +
 drivers/net/wireless/celeno/cl8k/channel.c    | 1656 +++
 drivers/net/wireless/celeno/cl8k/channel.h    |  401 +
 drivers/net/wireless/celeno/cl8k/chip.c       |  580 +
 drivers/net/wireless/celeno/cl8k/chip.h       |  182 +
 drivers/net/wireless/celeno/cl8k/config.c     |   46 +
 drivers/net/wireless/celeno/cl8k/config.h     |  405 +
 drivers/net/wireless/celeno/cl8k/debug.c      |  442 +
 drivers/net/wireless/celeno/cl8k/debug.h      |  160 +
 drivers/net/wireless/celeno/cl8k/def.h        |  235 +
 drivers/net/wireless/celeno/cl8k/dfs.c        |  768 ++
 drivers/net/wireless/celeno/cl8k/dfs.h        |  146 +
 drivers/net/wireless/celeno/cl8k/dsp.c        |  627 ++
 drivers/net/wireless/celeno/cl8k/dsp.h        |   27 +
 drivers/net/wireless/celeno/cl8k/e2p.c        |  771 ++
 drivers/net/wireless/celeno/cl8k/e2p.h        |   25 +
 drivers/net/wireless/celeno/cl8k/eeprom.h     |  283 +
 drivers/net/wireless/celeno/cl8k/ela.c        |  230 +
 drivers/net/wireless/celeno/cl8k/ela.h        |   48 +
 .../net/wireless/celeno/cl8k/enhanced_tim.c   |  173 +
 .../net/wireless/celeno/cl8k/enhanced_tim.h   |   19 +
 drivers/net/wireless/celeno/cl8k/fw.c         | 3167 ++++++
 drivers/net/wireless/celeno/cl8k/fw.h         | 1462 +++
 drivers/net/wireless/celeno/cl8k/hw.c         |  432 +
 drivers/net/wireless/celeno/cl8k/hw.h         |  280 +
 drivers/net/wireless/celeno/cl8k/ipc_shared.h | 1386 +++
 drivers/net/wireless/celeno/cl8k/key.c        |  382 +
 drivers/net/wireless/celeno/cl8k/key.h        |   37 +
 drivers/net/wireless/celeno/cl8k/mac80211.c   | 2392 ++++
 drivers/net/wireless/celeno/cl8k/mac80211.h   |  197 +
 drivers/net/wireless/celeno/cl8k/mac_addr.c   |  418 +
 drivers/net/wireless/celeno/cl8k/mac_addr.h   |   61 +
 drivers/net/wireless/celeno/cl8k/main.c       |  603 ++
 drivers/net/wireless/celeno/cl8k/main.h       |   16 +
 .../net/wireless/celeno/cl8k/maintenance.c    |   81 +
 .../net/wireless/celeno/cl8k/maintenance.h    |   17 +
 .../net/wireless/celeno/cl8k/motion_sense.c   |  244 +
 .../net/wireless/celeno/cl8k/motion_sense.h   |   46 +
 drivers/net/wireless/celeno/cl8k/pci.c        | 2468 +++++
 drivers/net/wireless/celeno/cl8k/pci.h        |  194 +
 drivers/net/wireless/celeno/cl8k/phy.c        | 9648 +++++++++++++++++
 drivers/net/wireless/celeno/cl8k/phy.h        | 3680 +++++++
 drivers/net/wireless/celeno/cl8k/platform.c   |  392 +
 drivers/net/wireless/celeno/cl8k/platform.h   |  196 +
 drivers/net/wireless/celeno/cl8k/power.c      | 1123 ++
 drivers/net/wireless/celeno/cl8k/power.h      |   90 +
 drivers/net/wireless/celeno/cl8k/radio.c      | 1113 ++
 drivers/net/wireless/celeno/cl8k/radio.h      |  130 +
 drivers/net/wireless/celeno/cl8k/rates.c      | 1570 +++
 drivers/net/wireless/celeno/cl8k/rates.h      |  154 +
 drivers/net/wireless/celeno/cl8k/recovery.c   |  280 +
 drivers/net/wireless/celeno/cl8k/recovery.h   |   39 +
 .../net/wireless/celeno/cl8k/reg/reg_access.h |  199 +
 .../net/wireless/celeno/cl8k/reg/reg_defs.h   | 5494 ++++++++++
 drivers/net/wireless/celeno/cl8k/regdom.c     |  301 +
 drivers/net/wireless/celeno/cl8k/regdom.h     |   11 +
 drivers/net/wireless/celeno/cl8k/rfic.c       |  232 +
 drivers/net/wireless/celeno/cl8k/rfic.h       |   29 +
 drivers/net/wireless/celeno/cl8k/rx.c         | 1845 ++++
 drivers/net/wireless/celeno/cl8k/rx.h         |  505 +
 drivers/net/wireless/celeno/cl8k/scan.c       |  392 +
 drivers/net/wireless/celeno/cl8k/scan.h       |   53 +
 drivers/net/wireless/celeno/cl8k/sounding.c   | 1121 ++
 drivers/net/wireless/celeno/cl8k/sounding.h   |  151 +
 drivers/net/wireless/celeno/cl8k/sta.c        |  507 +
 drivers/net/wireless/celeno/cl8k/sta.h        |   99 +
 drivers/net/wireless/celeno/cl8k/stats.c      |  438 +
 drivers/net/wireless/celeno/cl8k/stats.h      |  108 +
 drivers/net/wireless/celeno/cl8k/tcv.c        | 1259 +++
 drivers/net/wireless/celeno/cl8k/tcv.h        |  283 +
 .../net/wireless/celeno/cl8k/temperature.c    |  634 ++
 .../net/wireless/celeno/cl8k/temperature.h    |   71 +
 drivers/net/wireless/celeno/cl8k/traffic.c    |  254 +
 drivers/net/wireless/celeno/cl8k/traffic.h    |   77 +
 drivers/net/wireless/celeno/cl8k/tx.c         | 3397 ++++++
 drivers/net/wireless/celeno/cl8k/tx.h         |  467 +
 drivers/net/wireless/celeno/cl8k/utils.c      |  642 ++
 drivers/net/wireless/celeno/cl8k/utils.h      |  185 +
 drivers/net/wireless/celeno/cl8k/version.c    |  147 +
 drivers/net/wireless/celeno/cl8k/version.h    |   23 +
 drivers/net/wireless/celeno/cl8k/vif.c        |  162 +
 drivers/net/wireless/celeno/cl8k/vif.h        |   81 +
 drivers/net/wireless/celeno/cl8k/vns.c        |  354 +
 drivers/net/wireless/celeno/cl8k/vns.h        |   65 +
 drivers/net/wireless/celeno/cl8k/wrs.c        | 3323 ++++++
 drivers/net/wireless/celeno/cl8k/wrs.h        |  565 +
 97 files changed, 66548 insertions(+)
 create mode 100755 drivers/net/wireless/celeno/Kconfig
 create mode 100755 drivers/net/wireless/celeno/Makefile
 create mode 100644 drivers/net/wireless/celeno/cl8k/Kconfig
 create mode 100644 drivers/net/wireless/celeno/cl8k/Makefile
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ampdu.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/debug.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/debug.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/def.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/eeprom.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/ipc_shared.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/key.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/pci.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/pci.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/platform.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/platform.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rates.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rates.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_access.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_defs.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/regdom.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/regdom.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rfic.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rfic.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/scan.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/scan.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/vns.h
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs.c
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs.h

-- 
2.36.1

