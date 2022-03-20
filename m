Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87B4E1E3F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiCTXbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiCTXbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:31:48 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660080.outbound.protection.outlook.com [40.107.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF53D132E86
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW4GYvpVHR4dWTzBVRARyB4GmKmldGhb3kCFLOVIzykHfrkexQtBQiLI/Z87cKzRCnY2DTZ0kBZbInDvhJhNbwP/QKnKDEsV/2EailtbwOdiXzHe4BnywgYaT6b9V4HGLJkCx7T0iewCtzJPWWzsJBoCCkCl9IGFM9ZhLo4ENkRHDcLgl2Vfk5KZl6hQdwVxSiXjTuQ60YnhAErJFtVEqeib02Y8k/I0FIrT6eBNk5fBPTVHOHceaWLhlxR3AIxZm/ejuM9pZrxHdv9vnFB8fq/iVEjTcmdsBDOad6qo2aS/sJKcw4MZQofhOzF0Yk3p8uZBFpPYaUcMhprRnnGVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTujvhkIWQ6yH0hFslCrCkOlmW9EFvTqjwJXxvixihY=;
 b=NJjsd05dpPb6m2cQvYxg/kepnlXQ5qFI8WHohGD9f+sBbJLaIuUtdShDHjBy2GVScCdZPXyZC4SkOryTsTfYIlHTiz7N6WHbLlYqna8smduwh+q/DFIJFaY2jtq+uFjmp8k8eqJPf9FLyEGgy0jYwg0i3Pi/3iO4LR7PXpLgj4Lssr669BmJQdICF73QfT2W3OqvZRZR6cCp61Ppg/QZjMtmYTChQGjzuLFu8+fj/y4hwm+2wYXOLgktg+AwLV1oIqxNFmVzGuAZCgLLcPC1HeVZShLjKliPPTUMgRgqzk7MQVQkx+4CRadxqoCZVGmkPc8bybtKtuptx9pyHU51ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:22 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:21 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 0/6] ath9k: suggested improvements and bugfixes
Date:   Sun, 20 Mar 2022 17:30:04 -0600
Message-Id: <20220320233010.123106-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb4280dd-6d74-4f55-d9b0-08da0ac99a15
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB29897CC93CEF113735D193B9B2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3S8NyoRi77XFo23R7kn3dOoO9Ty6xRit/3siS0mpFZHz5ahaDavrgt7oxcPCuju9PPSrENKJljuWk3gsh2vHuMsP7Eg7pKmzTkiWdWh+4Qz0EJSG93MXTpvd3+Bi4yUSdlLPwjdIDvCc7obwR05Ldl5wChHeeX3MPw1K4XzfuJhwNnLO+H922SeeMExruUNQRwkPpAo0qofj/fv7ub1gm0VABGp8dMeWRheNYgdfT+aP3LfH1juNdRASBa0br8HDwSutpKA0kmWwZfnxGMSoj3Lp75z8UXDdbEKzmNAA9Y8Rt/mQv2dMvFKWHDZDGiqISv/dL5QR/RMcpuCCTFTfpWz/LWlSVzHQxA/nYcS+eR3XKB+CjvJq/JfBkD40Up6x2QUJzHMT6i92CHa3qvv4S7bkEHAiUAQH/hPWiJ91ElLxRiflcuuUi8CKbYEmp7rn613EgWwpme+fytx5QywLvgzMoF9csgVJQbpO4k1tL289/p3q0tVKm903SB2GgSE6NuqMxYWZlf+IkEPv3K+OcdelUxeFilBNV45WI4eGQCnEA3/X/y5I0tCWuVrXIG+jTuRtOo8uJPklO4OxvIYZM1vRF5T9OQUEUMV6ZH2aBApGeD9hqKwtjWGaFwx5bVDin2a0ozNDuPioiqYf+pSNWJ6mz2G3OmMqRJKAuohgc3L8lCpIIWVze+0SLp2qMrB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(4744005)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2bVS2dXlPdd0ovl2H/VI3HRz1zk8+MVwQ1XIe3CcChRAVedhxRxZ7fXyylJ?=
 =?us-ascii?Q?Zurr4Idd2asmJQqFnn125sj90pZINRl8nlWZ5dC2hgeNXdOK5OPFDvE+BimS?=
 =?us-ascii?Q?LieS7H2gMBqFTKasASecbjn/eOI5AcgxuyWl6M268SpQX7pg7Z/mS7vjO6an?=
 =?us-ascii?Q?Fm0jPZF1YP8Po3yjTo/CMFqBRF50Zn5WQBN2iODjqx66vZz/y0uAuKtH5T43?=
 =?us-ascii?Q?Fw+087gER2fLfFmKrrWf1qMN1siaq696BGyhGEmtQ2PBzAUEZkTyH637Wr4/?=
 =?us-ascii?Q?gbCLjnnbIsUkmU359HkSn+x554TI1QR3mvP40MQ58iLUKmKGsWh9fItWLnfw?=
 =?us-ascii?Q?8anCN3JeAu6EnNRMj9GO8Ni48h1XYCvoLZZcUT/Fwkd1BKkwioQd68Fu9/hD?=
 =?us-ascii?Q?k0IS0qbWshu8SRCLPGyu3EcdhI2e2wSSV1PgzeZU3S5w6ZHngveFK0E+JCS7?=
 =?us-ascii?Q?pVAtHrPMhTlscUPhFnRSQSdzKsS32Mkopl94NicZbO8WvKGhyka8gYUm6cme?=
 =?us-ascii?Q?CbpA3NMWl1dgQVcgv+niayeeIz5EX6BNIQTonQWAZs5K6HTbT5IqD4xeqf5R?=
 =?us-ascii?Q?FlikweQ26ABopVUf4GfrupVf7DCID1MeHD8c9mQ6IODRcFp36Hw8CweHrGXp?=
 =?us-ascii?Q?VUX5iR136apYgvWHpSYOz9u3S76vLQSnBlQseyyPM0nrG/HhBH8orYa2pfJg?=
 =?us-ascii?Q?tFy74cYHOrcx8WQ4bbJVgdZcAZjgjA/FwEThv0vrZneUxbgn2yTcDjY+m18p?=
 =?us-ascii?Q?v4lV9Wb3BomiK/27ZT/FpRCkq3ej+AK1OGxkXA2Mx/LXn0ntE8mE2O/Hjiz1?=
 =?us-ascii?Q?mLZjEJYXtI9NaWewNLIB2uqydXdMLfBpmsIw+egN/XPqNo0J6zLnF9inFOaG?=
 =?us-ascii?Q?LWc/xYq3o2Bu4FZBWPFK/sCRPI+iNoFv2Oh1efNyppH+EJkYn41ckYOuqROG?=
 =?us-ascii?Q?rUBr3cZd+YXxIAO0433Oa5RyVROhEdwJVKSi2q7lBLBFmWf7wJbxfWZz1j0S?=
 =?us-ascii?Q?lG1Ni6dkG4bvOui6+TPhKWQ3azdxu5a6HIw/5dbJaxx1sTJVdqbqPqHlCa9M?=
 =?us-ascii?Q?5NWNHCtKET12dNAh1Q4x6+6xXGpBzPN0FH4Fpjdzk8qDKpBsA5bF/Z4AWqpg?=
 =?us-ascii?Q?+djCcuP0gR+vfbetB8/M7oYSZXqAhIacEPIYgTwf0qDnCt1zd0jm9J9Az4aE?=
 =?us-ascii?Q?ecjlQBejVD/xRl02LRrKt9y0eOv9y0/ig7bFtuIM1Tl3a8ggJAdDfk36CP2y?=
 =?us-ascii?Q?ypRZT2yKJg2l5vvKcCuhK7IK+6bxiNQ/8FNmS7soPAoZH35oxmLCluP/IfUi?=
 =?us-ascii?Q?hdINmtBmzjr217cYYrsmMLDQRalfzlAQveoRxfVBJFNRSTKryD5jrMJ4odLP?=
 =?us-ascii?Q?emAv8YEp5ChhwxDLaD38jqU79tNL6bI6b+mdinzGsyv/yN4IGTYzcP4/KNcO?=
 =?us-ascii?Q?3JZ2pmKLnaBE41G02hf28gRRYMeH6jpY?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4280dd-6d74-4f55-d9b0-08da0ac99a15
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:21.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEy8jt7rNjBwRkmWCGEDORfFvUNx3lFdu3AsPPANaDRnogX+JQYGULLYYVV56k60/HOlmTLqsHiuNbdpEmuQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset contains suggested improvements and bugfixes to ath9k that
I came across while attempting to implement QCN550x support. The patches
should be independent.

Wenli Looi (6):
  ath9k: make ATH_SREV macros more consistent
  ath9k: split set11nRateFlags and set11nChainSel
  ath9k: use AR9300_MAX_CHAINS when appropriate
  ath9k: fix ar9003_get_eepmisc
  ath9k: refactor ar9003_hw_spur_mitigate_ofdm
  ath9k: add functions to get paprd rate mask

 drivers/net/wireless/ath/ath9k/ar9002_mac.c   |  9 +++--
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |  2 +-
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 39 ++++++++++---------
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    |  2 +
 drivers/net/wireless/ath/ath9k/ar9003_mac.c   |  9 +++--
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c | 10 ++---
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   | 25 ++++--------
 drivers/net/wireless/ath/ath9k/mac.h          |  6 ++-
 drivers/net/wireless/ath/ath9k/reg.h          | 10 ++---
 9 files changed, 56 insertions(+), 56 deletions(-)

-- 
2.25.1

