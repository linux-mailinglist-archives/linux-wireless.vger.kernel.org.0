Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492917430F2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjF2XQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:16:55 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230525AbjF2XQx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjhx0SL1UO/c/v/EatHCzj5JfodqfZqxTxOcy0UoYzXmUTeZrdGT0gqV9IG1O8QtsYGxb2ZLZ+Sns2yNMSkUIrs2ucz/WZfSFkuUZXTxfEG9fiI+gT5LQAqvwjUO5vlKYILyi/ww32D0VBKYLYv1pw/lX4tWpOLbi/svcFGqeEaX39SRaegn+jWyEMZyBf5CDSRF3MxenAjnQX/uH4GAA3C58Eq4X1IwNyIXBebzjh7GQaN96qwm2eRcB+SGL4NL154wAOfh41cakGQqrajyUmywvAvT18L2HA06/KW4pv0SE6og+jy+3YU92205IzD/ejMejJNMJlu5AUoNWuDUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVJ5HPkIJxlbgiPV1xBOB7MYj0FTE4Dl3j9Tc7600fw=;
 b=nUXGEKba9YtukiZsc3flrjGgcwGCKSMcQcCVYPENfTITmURBx2oj1tQ4l/sIePkE/NMRiOpKqup/p/pRbgtajFb9ZAMTLDheEUoK93Bv41pOTps9Ad+Jq6JcQUNVVmVagvdyMWgK7PpnCVYvh3kcFY5WkYIACCf6wjKo8yJ1dWQr6aNX5t11JDhViX4C4UoXH8F045x41tBRd0H7aRwZD0h8/hmDut/nSIhdY1LcYfiKbRTegKyXpLHgmWcHS9UffYcgSV7nRn7EwMeRrM3xi+QEW9O8ezWCGsQIKN49F6kJ/Jfyh5knDAF//rwT6fKD3lWRoaT7XmTRBp5kL/XA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:48 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:48 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 02/11] wifi: ath9k: delete some unused/duplicate macros
Date:   Thu, 29 Jun 2023 16:16:16 -0700
Message-Id: <20230629231625.951744-3-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 7befb421-8dda-4167-f6a8-08db78f6e9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5rNlugQh8ocBnNkBvo1JLRSr/oS9vlo/29Pk4HVD9a5Dasyw498k+Je0q66UEZLRlmLRAlVL9ebngx8ctU5kwicuOJ0kK9AOCdqMfuqZrzF4ogoGKrQIG2DWPlwzHa6FfaxVkl7URb2mt5qmey0LruADr3xRrQYNu8oWIKknqMyn4nIacs96GXb8LHmY28jqVe/ZeG8Bm+YwvjPIv91H8kLl/yQyT8cLagnFUI/Bm3oXuX5XFZhUTuh4g3XID7oQhSBwgoZDWlvPYOmRWurM5hDV4T5bVt4Rt77tA30rnPetzdWiLBJseOZ6nxqUneSu8pnxgteq8NU1IZPTAcApyuikIbvNeG3qCJ0RIMKlsBUx2LMnxt7WQDnd+VPz2bDWieg6AlX2HuwhbsgHGYMkxDvy9ieo6WOL9ERbObEWq9cgSsXeTAMB7ZuuV2uig/rwJrQwH/Y5Y7GBscfXAKfSDK2PI57kggomW0UGRyeRWcxlMFSmN5dbFnv3H7ixtE0pK5PS8ejzfLNAhyCrK63Rcl99HWifJKtxYOaRqbwhdJ+DWnx0PgNsKAy7UHjIp23
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zPI3N3ccVN+HgirukK40Vst+0HQ9hi/rugK+2MbJ5P0q1e2mDVkSiOcC33t?=
 =?us-ascii?Q?zoIwG5/bwDU8uErzdTZwiCJYpZbQ9iXWuSvYtkG37qFnwsBrjIgT9LuszZiM?=
 =?us-ascii?Q?BIO9uOWcOyALe9SLAvK3LkJn5pE8qGL80vMu+ahpIOjyNiUucWx+l4DP7fCC?=
 =?us-ascii?Q?/SDmLo5TGiuFQKv/2mkhuEdIC0bayM8tejKbJprURah7iefRinz7CpBYKh16?=
 =?us-ascii?Q?V91JuV42DKnMDaJVReWt3tQfuxHJk7JzQZzjmD6jzBBwY+wk48CYl2MkZ+M9?=
 =?us-ascii?Q?7ppjsl0sX/HdJ+sx/b7e3qSYI9FIvcFh3QIwSmxbHF1bbHHEIXSJuSkMnp0+?=
 =?us-ascii?Q?XQ9qSXx/2IfyyWw2nP35l+4EZitxVDikQUqBwccWtf+ykdSyRA+dU2ccwWWL?=
 =?us-ascii?Q?rkvX9rEq6JdQTod7b33VZ86JY//HuNlmWbI/yOWJQEBNovO9ghIaky3jGydH?=
 =?us-ascii?Q?3gRi4Ij8/nlwOv9Ezx5Ui3uaIF1HB8Ci23jxjXOr/nkR9sRrV9CY0O11t5XC?=
 =?us-ascii?Q?MKumh2JCmu6H/2tBc1ERE6x6g/4780/WTAxj6bOoFbmUspyW68jHhTfZ/3VX?=
 =?us-ascii?Q?aXRyxZiNOS0CNLs5ScyNbB/wLsMs987YSozTOcpCM1ol1itvLPMFhvyPRuDK?=
 =?us-ascii?Q?ss/LBK1CqtGemxFdm8hMyhdiRB2xMP36un8a8wPMSxsn1WFGLVNc1lKPSF+/?=
 =?us-ascii?Q?yts14QtiS81SR0MpiR45NfNQ9nPoZBYlbbtoU0QndgU12GkCESRRMVysr8Av?=
 =?us-ascii?Q?XeQNZEK/AWeNibmxytP8BrCDAW8ufqqoGMHtKMUNS4Lo3lpqUJPScIAtkLPO?=
 =?us-ascii?Q?Q8//XuEp1bGgdXHSCwCgJ6X71L7ZzaTxfrG9wi9EayyDLX3B9uWuecoHsWgn?=
 =?us-ascii?Q?MyMUhioA48OFKn+PSqUYAuN/pRqAcqSMLngcVKPwE1E0FFb0IceLsza0g1sG?=
 =?us-ascii?Q?A3NoOg3w4CW4qcjnpie6y/TOPw8C6lHxTtl5TpCSJ9BWks8rv6xlJfo30MLr?=
 =?us-ascii?Q?iuiEZCaw8+clpryYinmpvMB05T24VV+xrSz+7vMb04sOBMlx0EHjuDzRmXLu?=
 =?us-ascii?Q?Hp4SX6a5lErK+776KXcvQyefjUlbHgJ7YIjh7Pqb9S6UeGu7VNBcfIjVD/E7?=
 =?us-ascii?Q?Z9Pkq75JagXfUAYbQDmXEuPqgJ+aNiUe5dDcZE/FEdYShj4KZJfCPQmRTJXm?=
 =?us-ascii?Q?WZMNt4HXwnBVzM47IRRLfiLG8al56p4SpcSyAx4np2zUGvgt7o9/8ogBReS2?=
 =?us-ascii?Q?quGSa1hLfwgsYFXDtEjcZHLOD3EUrhwtfENfKM5ao2+dEWtcoiHtYLfIBms2?=
 =?us-ascii?Q?OTDZeZYoB9A3UpEMppCRJ9z1UCOZWqAW7kp2sOe6Qlw44bnSgzz0AXae8Vnk?=
 =?us-ascii?Q?jYY4tmf7m2idTa03JpcmPx89VeLUtYMMM1GclmQlWs3ib0TEY9L9jxCSSPFv?=
 =?us-ascii?Q?zWSoHeooIDQfHu07r0pBM1KgEHGvb+KR1H+1SgfqOEBVG02TbD8wrI41C/ky?=
 =?us-ascii?Q?Y5KpYwbBcCMZEDWxYAydGnRobCHl4dqb6FhK1VL5N+xo5/XKjP15kq3yfuZy?=
 =?us-ascii?Q?uIqnbizyxJ1Jm9HWL6J04ivQw/4iiXwkXyJaiisg?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 7befb421-8dda-4167-f6a8-08db78f6e9f9
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:48.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3pnJ5H47SDCDnVgI4CbA8eHlSYAZTh+nHKD7Uqc6Nz/Q7CU4Vk7YODvP+udqB5mdOAq8CXjPxj9OsR1i7mjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rate macros are for AR9002 and not correct for AR9003.

The AGC 3 macros are unused and have incorrect values, at least for
QCN5502, where AR_AGC3_BASE should be 0x2de00.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.h | 9 ---------
 drivers/net/wireless/ath/ath9k/reg_aic.h    | 4 ----
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index 57e2b4c891..ad72a30b67 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -851,8 +851,6 @@
 #define AR_PHY_TXGAIN_FORCED_TXBB1DBGAIN  0x0000000e
 #define AR_PHY_TXGAIN_FORCED_TXBB1DBGAIN_S 1
 
-#define AR_PHY_POWER_TX_RATE1   0x9934
-#define AR_PHY_POWER_TX_RATE2   0x9938
 #define AR_PHY_POWER_TX_RATE_MAX    0x993c
 #define AR_PHY_POWER_TX_RATE_MAX_TPC_ENABLE 0x00000040
 #define PHY_AGC_CLR             0x10000000
@@ -1041,13 +1039,6 @@
 
 #define AR_PHY_TX_IQCAL_STATUS_B2_FAILED    0x00000001
 
-/*
- * AGC 3 Register Map
- */
-#define AR_AGC3_BASE	0xce00
-
-#define AR_PHY_RSSI_3            (AR_AGC3_BASE + 0x180)
-
 /* GLB Registers */
 #define AR_GLB_BASE	0x20000
 #define AR_GLB_GPIO_CONTROL	(AR_GLB_BASE)
diff --git a/drivers/net/wireless/ath/ath9k/reg_aic.h b/drivers/net/wireless/ath/ath9k/reg_aic.h
index 955147ab48..f50994910e 100644
--- a/drivers/net/wireless/ath/ath9k/reg_aic.h
+++ b/drivers/net/wireless/ath/ath9k/reg_aic.h
@@ -17,10 +17,6 @@
 #ifndef REG_AIC_H
 #define REG_AIC_H
 
-#define AR_SM_BASE                              0xa200
-#define AR_SM1_BASE                             0xb200
-#define AR_AGC_BASE                             0x9e00
-
 #define AR_PHY_AIC_CTRL_0_B0                    (AR_SM_BASE + 0x4b0)
 #define AR_PHY_AIC_CTRL_1_B0                    (AR_SM_BASE + 0x4b4)
 #define AR_PHY_AIC_CTRL_2_B0                    (AR_SM_BASE + 0x4b8)
-- 
2.34.1

