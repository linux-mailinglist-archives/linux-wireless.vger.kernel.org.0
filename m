Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C353293C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiEXLhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiEXLhl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BA94AE15
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvxIVmO4hz0SY+m7usjHUFCrqqP4foJbh9LnHQKr1XLpOzBoH/VOc+7/MyIef2fI3EHxupnpVdpCv8gTMnOs00iJse8nKkDSvYZU14U09EA0IA12ryf6mP5eN9F09FvlgzDP6BSvPDYhDrHKe1Qo+uBuY1jPHkezf81Ledgf+2kXa0woxuPHKcparxT+3K5mPFgQOmZT2zhWIrByycdUj+USWbUm77im76EUAcw1G7N6OfqhctZg3kImqH4N//5pUjKG9EQWbM8jQ7Jssa9QkT+STDlMJmxKjhYEoGj3Wp6naXODaG8cGqSt5nvVdyvVxoQFw7a9Ieyn4i8TSm1f9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g2OLxRte3SsbqJ2/0gdLBV+VxiAwUXr3Ed7N4TdzIk=;
 b=b9RylYU6bLwxZEw53PVQGh8FqvCndsh6veF+mjvJRt5Nn1A+QJo1MRre/sAEqwwgbosZ9+XzYACNyuyWDDXbxNlk0ZnpaefepgwwNhZEmHW6XBIFg4Ixz5hycVxa6O+ZDDM0sX5aRCYM1Hrmu/fPb+mLWA2UJaYcFPdMmz1b8YBRbxVbWvYIpgBBxPAJbrW+TkYSibe/lp8QFUGspCOJFzRtZDcQh6hIKDbH0XdYPvixeYKPCeNr0cUs8AybWYXgAYHWs7i2nbWFN9oKiPip43AJC+MHSpNJEksX1Q/RKUf6O36RcLhYJJkgVWAEQBlt71ZINuc325DDOXkQU360MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g2OLxRte3SsbqJ2/0gdLBV+VxiAwUXr3Ed7N4TdzIk=;
 b=XXw1ij5w8ijkmDjIRgS74lHVsFYOltWwJGjkVZLfctoAFEwDT/7pKG+QvGYUXPwuEBLKSUYagu9E4oohKybZ0XzhozbPzrbtlxKpl87MMh1T7V6JXDy2cGTO5xJaMp3xfPCDyPz5IkzBQKrcwAbSvDvPeecXeQAM6/sMrvlUJY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:37:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:37 +0000
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
Subject: [RFC v2 03/96] cl8k: add Kconfig
Date:   Tue, 24 May 2022 14:33:29 +0300
Message-Id: <20220524113502.1094459-4-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db6b24d-bfcf-4d73-3910-08da3d79cd35
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384419E2A15AE1A7F8DBB66F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8aWoLkOM+6HQFAkxj6heqYqtzX6sn6cT1N/yIpwQWDszD79657MYocWZCDwhvrCGXlH2KL25F1fpI9hHca6I7oqO3IM+juuWgPOcYyZnKAI6og/zoBwbG5sia3BkhASMUsvHgMyGFMASbxWTsvZ4yP3IySqMRoWSZRNOiyIKAMpfCoS5dOS9eRZtXfc2BF0yEasy+kG7HSEM1Z5aGhD4A5oCAqePGhli1BgIUWVqE9usrbd7ptozS8yrM46oPomQil0L17LrdIWtg42l85I/8ZRDfSL5Kb7Q1IBJItPYWrqzFBNi4WgW9VRshf5hiET6ejf33G+fM/2VOoAx0qBcSH9G/zIC0W9devaStKuTikaL4fVtE6CBgig/LkC3KsgGaqBkaypNuAIyHRI0KKyAvcEG94vQcwwPmg5KeGbkgg6XGO9X4vTQimD0PcvTDzccM3P0TAJqmEKD2q3eoZMjsWmlse8qHAs6D+XswEKcLXlMpFLTdrIYRGibE/GOF0JGmcqtojI2W5/rfejx321xoUkRYPTg++M6+rM7E2ptGDDwo8VIX7BoSP2H28/JRR6M5RJL8/1zoyF0EqIp4npd+SsIUWnioDZ/Yvss7Jcplf74U/PwXZbCPQBVGYRljDHiXsn22m+vaHm/VzUPWKllMQcClrWa8TTOkx+eD3sdihxmp6TnrBw33RKOBUjdP2POI6cNCFLcVaYLAoksfZ4lUnF16yIrI3Bs4ad/g5Xk6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G18CZpSBA84HrPsP+GLt+/aYJXzo5lcfWfqEqVr+Wij89aHD1wSTmbaeskhx?=
 =?us-ascii?Q?kcneXKtPXJD5XGSvPoBH9ZOz/TScJHPbRWOt+YqqQ3KYt3GneZiMF6nc7vMp?=
 =?us-ascii?Q?JlO32veYPCkRMM5WKeRZ3JV8NZFdfJqF5g7LRKhHZcdVWpDYyKPJ13lOaiX6?=
 =?us-ascii?Q?LFj7XbYHDLZ4sDb1X9ySuZuZyp+Qpzgopqld+xDLfksX17q2SvS9C2sALOqq?=
 =?us-ascii?Q?fmjfuvsoXNI6kvXNkdKmQWRyOWwuGSPPd2L0u0am0q8YE/Ly5IDqmAV83D15?=
 =?us-ascii?Q?Cbk8MzZkZL3ae/weNcCTqEk4lbj+cwzsC6Vfgtlj6axpZmJH5ofSiYGzjdsA?=
 =?us-ascii?Q?0XAr6snFX5zXZchdhSX/RDOkP00Usdi8bOrZmJtAr/XXltO92TSirlM3Sllh?=
 =?us-ascii?Q?2ROQo/J1HxjaOph1ev4lIGvVjsnjj4rh4eOfSvzOhS7Bep8DPsNjkqWyxN/F?=
 =?us-ascii?Q?ueXChXsnQiGOU+ItmJwWhyQtYdRMo5poVlqI7f7zj8QkF90xDd8XsuK9shz5?=
 =?us-ascii?Q?aYWUz1abmOvNOuHlXqL1cEhHp+jQNU87tTDZ4hPmlvHWMcPH4pyZIQa/xN16?=
 =?us-ascii?Q?iSH3bb5Nns0xOBPWmfyJLgz1/TcfOb7xjlft9dgQyhEJWBcSU5bX3gwiw/lm?=
 =?us-ascii?Q?vmB0nPhm4KPh3dqu9VgtuYsvLnqOOyaA2z1RfvVmkZ5VG+EelcAPEoTBhnYZ?=
 =?us-ascii?Q?EXVAHofno/kV4Jomur/Vm2Yj/tFoTCbFnbxW+r3E5QTMIJHrjWWUCLp4UK/A?=
 =?us-ascii?Q?UEUQHMnNIZfCRfYpaffAkXtWfmYeP5M2GNWzG8p/t5o2BHjU1kp5igjFcvsV?=
 =?us-ascii?Q?yK8cu0sshrgQbffBeC2QtwDv4DRwWis991MYby9iF8DdP26zV/eQALlQumYH?=
 =?us-ascii?Q?Bi5V+4g8vZmHlPYf4adgDp7pYfNePvXORegI8Qx7Cj6SmoH1no/7tsJ+hiZ+?=
 =?us-ascii?Q?q4u1MWKMRLbJmFH++FvZLEdmu5ut5B7ubNW6LRpD/0LnwCU+yJKQd62j0wsB?=
 =?us-ascii?Q?uW6IRzfNTXBlVK6ERuy0+BvzSiG/f88WL6E57r1LrJG/gt48rLRuzS2E6J/k?=
 =?us-ascii?Q?DWDWkuAXrFMUxx/F7xIogOFSPql2kvKcGlSAaHBZhj2PDkqv5AWh82YMOpFO?=
 =?us-ascii?Q?GD5qQ1jnIYp3PabGSamsp+We2lnj6TJ9n+54moZx1JTPQWQfkscZxTxpFLnT?=
 =?us-ascii?Q?iyyCRU0EPR12MPNEy7GFm6P//49U4zXJEdlXRo26XuWgCNlVMN1j90SPrjX4?=
 =?us-ascii?Q?mbMiD1M1g3Q14gBlcyT+kWc8sdEE1DZDUMOu9EJWUBdimJzkVvSA7IEwhqjD?=
 =?us-ascii?Q?xZJB8p1b1rFWCv5Px6LLS3Lu85/abx6nb5J6bRHTYxVH0egb+mkR8NgOXHob?=
 =?us-ascii?Q?4zadv+reYRD7RqeF/EEON5LKp8+dJ5il98JWhxHzftgArb8cvJcW8pH65jP+?=
 =?us-ascii?Q?6SKoPV4mnu/9D1dORkhxa5RFvf+C2QwpVp72ViwknVF62wxoWKiKy/u96LXv?=
 =?us-ascii?Q?xZcM6aBBurJwSgA76G5RzxjRMbgDm5C+FpdXDhsao9HjVKdrhsUVmlAWMsNZ?=
 =?us-ascii?Q?cUwlZb/7Qsx4CfvZBudR55nuXsJGbDDUqj+TPqmDj1KKi0u2tD3fG6Akc4ar?=
 =?us-ascii?Q?wY4f7i5o/pGL8L7/T62TT6wU6tkQF2L5NCraRTTnfaNlVbkZI2diySmCCK/M?=
 =?us-ascii?Q?UVH9vpj+ecT/E1Qvb0vPvU6r/R3rILTo2/ueBYLie92bDh07l1polFYm0Mxh?=
 =?us-ascii?Q?sBvrK0+vhdn6M/r6+yI+rIu9mgEo4OQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db6b24d-bfcf-4d73-3910-08da3d79cd35
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:37.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/P5om1BZNS/67Qreei+0LLi+cvMmNH+AJ47ZRQIMof+5nl5lMtzZroDDensZCmtJg9Whu+01bNOby4H2N8Zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/Kconfig | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/Kconfig

diff --git a/drivers/net/wireless/celeno/cl8k/Kconfig b/drivers/net/wireless/celeno/cl8k/Kconfig
new file mode 100644
index 000000000000..7af6dfafa6af
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+config CL8K
+	tristate "Celeno CL8K WLAN support"
+	depends on m
+	depends on MAC80211
+	help
+	  This option enables support for Celeno CL8K WLAN.
+	  Select M (recommended), if you have a wireless module.
+
+config CL8K_VERSION
+	string "Version"
+	depends on CL8K
+	default "8.1.x"
+	help
+	  Sets module version, which may be important for FW compatibility
+	  analysis and syncing upstream codebase with the internal codebase.
+
+config CL8K_EEPROM_STM24256
+	bool "EEPROM STM24256 support"
+	depends on CL8K
+	default n
+	help
+	  Enables EEPROM STM24256 (specific for some of the platforms).
+
+config CL8K_DYN_BCAST_RATE
+	bool "Enable dynamic broadcast rate selection"
+	depends on CL8K
+	default n
+	help
+	  Enables dynamic broadcast rate selection,
+	  that allows to tune rate of broadcast frames taking into account
+	  capabilities of all associated stations.
+
+config CL8K_DYN_MCAST_RATE
+	bool "Enable dynamic multicast rate selection"
+	depends on CL8K
+	default n
+	help
+	  Enables dynamic multicast rate selection,
+	  that allows to tune rate of multicast frames taking into account
+	  capabilities of all associated stations.
-- 
2.36.1

