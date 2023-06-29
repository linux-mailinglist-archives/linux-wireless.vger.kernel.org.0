Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB27430F4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjF2XQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:16:58 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230415AbjF2XQz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axtbgetgxg3oKmcycMzcHtEy+9DOc1PtsPwTxW8Ht4gOboK2pfpgP54Vqbea9ipCpuem/Zek6yc6sacNmM6KBfz3fRQHfs6iaIkn6BsWdLnNrWJIiz4iPWueTuVj23asAVm1k0QPziyptdXMxIyq4DU8tmeCy9LgIoZUp6fhIrC4m1hstq0/U8/Ovc7zRPiHtVyOp1OgjskqGlp03G5PokbEVLQlUQDLXmVIXvqsbq+LNSA5jfBsoiBw/Bozq+xREK5AjAZ2VxPKEAaa4uLXAQRAc/mOMiEQGHrW8h/d3N2qu3JLasRrD+y+S4yFP98Ru1LOw44H/VKXYyN1t88rUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7t0wVKpinfH1HE270QRvZI2/pW1MLN43Lin1tYM8gM=;
 b=OjYVYk8I4fMiHTMMw6hczgK+gucffwLC07URF+LOrwnYj8tCTzjqd6NLbfN3w64CpijZwccAmUqAJtdgKKnJIpVt259UlFwggi1/WbEeRGjlW+TdlRntBnoqefBph9bsNF6GvhGN0juP23HPfP/o+FxePoEBOzsY6ikIfpPO56iJfN+J2leY32JsMbk09cCw15lRHK3dZ6v9r41eBvBwOeL4DRhyrXQhRlzeff3OQe+r0P8ymB4N3DXRGWg+IcvJZ5dLgr4ZZA0YY686IRKL722668UXmAM+cL1PKNpshkcyy0CkCOM9Nn4+SttRIk7Y/+ZqqWs72Nzh7Wvlijy02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:50 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:50 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 05/11] wifi: ath9k: add QCN550x device IDs
Date:   Thu, 29 Jun 2023 16:16:19 -0700
Message-Id: <20230629231625.951744-6-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT3PR01MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d7ea6c-696f-4252-93e3-08db78f6eb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CW0q8wF7+kjZyPCE0ltMEIuLGuN2EJO7KB7kYRFf8rerBjd3Rs2y49NxLi+h+BbdODA2eZFbq7oqsy+vU9xfFw6u9ZpoJJoA8+D8P6ZNfmWN2HDMjGzfZDw258b25PmKpIfngtTovkwXZeYhT5FgpCFY8OA1HjV/VFVITIedXwEXC1YqPq3vod4Lm6aARobKIUQaUdm33DbihrrlZ8dQOojXm5bSsbXkLtfAmqbv7yF8gjAmc4WWYwNydrkt+65Se9Z9OWIAXKeRl884w9XXgakQBQ8lkYv/s6etShNvIfUdUevbr9y8g8NlrjU+egeAT0k/IcSLPT1y+XZWduOl1izlxydPmqWObava22Yx4e/HsrKDYlYVnkfHnmRlyuKn4jxnUf2oWOR98mz2tAbZLEXk47kLD//ttXtR7TxD6stdLKXWFfU8oAchm1b/6oHH6lGuw2KsA+H1Ffs1XUjU7fOpHP9wfkXDbS2P2MMIZtp2HutAHpTDdgjaphipM+ygqW/aAnj4KO++5bLM7qyaR2Wab9u/uy91ejhJ/vQx8b5Wbas7MkZzavJfsG4kS4L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aM+3SvKBJM1tWw3BeLNGlEsAEJxMWNfpiKgdaKHuaJB/Y86PW3NQ4cfC1hDE?=
 =?us-ascii?Q?SMwVVEzU2BKj/GCFSkuuVC/o71ebaS71kVLyWF6LfO5FTxwUYDekujWLfs7D?=
 =?us-ascii?Q?lpX066qSDxHhhbDlATrqpm9lT3ZF2Pozji33R7pEFLg1VIN0EWSVJS3jDZhE?=
 =?us-ascii?Q?O2y30PjIQdC6b66NnG5NsfqB2nD9Mi/jMmiH5QEAm122R1BkxCVGc9FiIXhk?=
 =?us-ascii?Q?lJSr0JuCm1wFaXT9fWvqkJ66D/szasnneQAHMcKF3wUT3opuwug3S/TEJZgP?=
 =?us-ascii?Q?baBEZ6MgOVXIwpH28C0v3YyYmxW02HRIcaFuJkVm2Lz7859kK5zU16G0yUN3?=
 =?us-ascii?Q?MmRkrnQy9EIaoMhm0yIgfnm3AGSuOJbYjwEksy6DUKIMn/huHBjZc1Fc1rH8?=
 =?us-ascii?Q?wbGfXqTqKyQWVHvt2BQm4+0wXRhsMbin1xkD4X8TIeNha5JZUACKydS64CuF?=
 =?us-ascii?Q?W7fpMPuxTCcKeKpk3y0E+xoIVLMClo2zcQYoMHg7dB+86vmJwnE/fUYCNEdQ?=
 =?us-ascii?Q?vbHnQxB0BCjEoDP5eJtyzdEBdKXOHJBIcK7v9i7eo84rIHCrnfOa3vsCs3Kd?=
 =?us-ascii?Q?ZG47xtng63663EB89PYdMsSm6zndoejXIiXlK3qrTKrXC1iTRXjHfa577bg2?=
 =?us-ascii?Q?PkDyTp1kDLG1SE8wmqvqXkj7fDtTbYgQIDTxs8abW8GSIdXavdtCXAUftlgN?=
 =?us-ascii?Q?87KlS7wBQO0ejo2Keh3mJS0Z3SO1MCBHGH5hYDQBv4f+8/gTR7CP1OqV9nXO?=
 =?us-ascii?Q?02LAS3KFH9qKeq4W4d2fmvrmyeSU2TzADT5SekEJ71edCjAJ/xlEJAxDiETp?=
 =?us-ascii?Q?Hq2g6uMIiZB/eb/OgALfG2kKvKjXcCZGrzLUBIPqN0H/xmkVKp6tZk4CfF6E?=
 =?us-ascii?Q?d3wac1AhXI7zHkTUop/oJjRv2A9B6KvwDkunOirczxTqXDnucYR3h+IK30xn?=
 =?us-ascii?Q?RlFYU2GgT+SaDZDtSbDdUmF+7kZYNJvIvkUGPNPG/nI/NQcXlC6MD+CrYRBf?=
 =?us-ascii?Q?qynjThC2vfUpOoX3+UO4db9LtVWoOmaB2N952qGyjDGasWr89GoIMwvYfdJg?=
 =?us-ascii?Q?zd0QRfEezrBTy9M0lcmN4kRlcfjhtd4MqgqQt/4yjvVwB/iXqnGa0iKah3Ht?=
 =?us-ascii?Q?PoApqv9BftogdJJD5O2telpoD/u77/gi5jNyV9HaxRf2+FFp+KTQ5CDFCYK7?=
 =?us-ascii?Q?MGGNQCf++RjNPubIdPrCc8PkqhrdxqHuipQqGG1UDT68DXvRShGkH/Msb/Bu?=
 =?us-ascii?Q?J0mYJsj6fR+sbuxndL/ngfqGZGJrTqcWatwyrnr57yUOb/hl1Lj6l7gP4Bho?=
 =?us-ascii?Q?ZgFsXNP/dEAcQUlM2ahEuZeRj+77ybkBl8D0Ikfem556X7w1HMWtTgFcK/7+?=
 =?us-ascii?Q?MHNHR94QLfTn9YC0XP4LSVyBC0hh+46PfSDWh8wsSJWkA8a9+93mZcg0/+hS?=
 =?us-ascii?Q?SfMRZXubK79l/8Jseooec3aW29AU1t4VRdWDacl7S1bRl+fMFNDPNKOUiY5j?=
 =?us-ascii?Q?vBY9/ItpeEUuvhrIT1/fjyhoLEQ+rvrlXLvm/pzzDFN+wH5gLeeyrwT2v2Ot?=
 =?us-ascii?Q?h41ETlqRYA4IBNfq6kwDJCMNgie6iOJYO4Hpd0GH?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d7ea6c-696f-4252-93e3-08db78f6eb40
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:50.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JummrKYVzbsFDFphlYQ4GnQz8HHwI4m6vB9Zzw3IgGiRUFjgT4tpRvd/A3r1cR/tleiC8v8JegjK2GLTkyczZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds the device ID constants and augments the initialization code to
recognize the device.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 4 ++++
 drivers/net/wireless/ath/ath9k/hw.c  | 6 ++++++
 drivers/net/wireless/ath/ath9k/hw.h  | 1 +
 drivers/net/wireless/ath/ath9k/reg.h | 5 ++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 9cd12b20b1..1835b4469e 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -47,6 +47,10 @@ static const struct platform_device_id ath9k_platform_id_table[] = {
 		.name = "qca956x_wmac",
 		.driver_data = AR9300_DEVID_QCA956X,
 	},
+	{
+		.name = "qcn550x_wmac",
+		.driver_data = AR9300_DEVID_QCN550X,
+	},
 	{},
 };
 
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 5982e0db45..e63314544a 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -282,6 +282,9 @@ static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 	case AR9300_DEVID_QCA956X:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9561;
 		return true;
+	case AR9300_DEVID_QCN550X:
+		ah->hw_version.macVersion = AR_SREV_VERSION_5502;
+		return true;
 	}
 
 	srev = REG_READ(ah, AR_SREV(ah));
@@ -592,6 +595,7 @@ static int __ath9k_hw_init(struct ath_hw *ah)
 	case AR_SREV_VERSION_9565:
 	case AR_SREV_VERSION_9531:
 	case AR_SREV_VERSION_9561:
+	case AR_SREV_VERSION_5502:
 		break;
 	default:
 		ath_err(common,
@@ -688,6 +692,7 @@ int ath9k_hw_init(struct ath_hw *ah)
 	case AR9300_DEVID_AR9565:
 	case AR9300_DEVID_AR953X:
 	case AR9300_DEVID_QCA956X:
+	case AR9300_DEVID_QCN550X:
 		break;
 	default:
 		if (common->bus_ops->ath_bus_type == ATH_USB)
@@ -3315,6 +3320,7 @@ static struct {
 	{ AR_SREV_VERSION_9565,         "9565" },
 	{ AR_SREV_VERSION_9531,         "9531" },
 	{ AR_SREV_VERSION_9561,         "9561" },
+	{ AR_SREV_VERSION_5502,         "5502" },
 };
 
 /* For devices with external radios */
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 450ab19b1d..2349d0e93c 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -56,6 +56,7 @@
 #define AR9300_DEVID_AR9565     0x0036
 #define AR9300_DEVID_AR953X     0x003d
 #define AR9300_DEVID_QCA956X    0x003f
+#define AR9300_DEVID_QCN550X    0x0040
 
 #define AR5416_AR9100_DEVID	0x000b
 
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 2e65105d30..75a9651983 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -825,6 +825,7 @@
 #define AR_SREV_REVISION_9531_11        1
 #define AR_SREV_REVISION_9531_20        2
 #define AR_SREV_VERSION_9561            0x600
+#define AR_SREV_VERSION_5502            0x700
 
 #define AR_SREV_5416(_ah) \
 	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_5416_PCI) || \
@@ -992,10 +993,12 @@
 
 #define AR_SREV_9561(_ah) \
 	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_9561))
+#define AR_SREV_5502(_ah) \
+	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_5502))
 
 #define AR_SREV_SOC(_ah) \
 	(AR_SREV_9340(_ah) || AR_SREV_9531(_ah) || AR_SREV_9550(_ah) || \
-	 AR_SREV_9561(_ah))
+	 AR_SREV_9561(_ah) || AR_SREV_5502(_ah))
 
 /* NOTE: When adding chips newer than Peacock, add chip check here */
 #define AR_SREV_9580_10_OR_LATER(_ah) \
-- 
2.34.1

