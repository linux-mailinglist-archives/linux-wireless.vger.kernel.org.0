Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B072174E8B4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGKIKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGKIKf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 04:10:35 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2067.outbound.protection.outlook.com [40.107.117.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228071A8
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 01:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSWesRMRbAnhpJWm8s9ezpDdKTo/BPEdajyqoL5inUtHL/UZOh8Iiy0TNhcJkp7UpcpjQsId97UiGlAPv+Uszjf38LunR4E7sufzLAhFRf+7rzI3f6r2jdNHRuc+jINooMsqoCun8Bm8xbxcF29WGUw2SspOjBznqJXbbe2Wuhx6p9Jp9azL7QcbzNDFtrGPhX4FYX6MFCIijPPqiQrb1ya6Iiuo7Anzpg8FMoAMz2vgKF0+Cq7BZvwd/QU4d5TQjsrrrZ1HrEc5314A6yxz7r+5GTV7oYUrtfkV8CCrrPzhqdIppGjLJ6SSpmPmS2VWnUTisLc/dfDDphR3NiEe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7yytgArhhcQAhzvZYbDgi3LqaSH3GT1FPkR4PsI4PQ=;
 b=B9XMFHpfyJJbOum374whOQ9PzS0bqCPAT9fICuGhkGFE300nAapZt5GRRcNbLpIFaY9yPG5HmLdF0j8i8eK7qJWvdk0A2XOXn8ip1Qq1AlfKw73AQQ0100t106y4tRYhY9T+fRSj1MyTASonIf+8QNZ7MjuDh03+cjnoyUtuwG2eI6i9BatrtDU0QB+k+PTlaJLnb6loTmb6UWZW58o3vI9geyEumLMjS6B4wqz6OBiAO4+pVj6WroFDiurAp9Pdn6uRTyohvcHkCTPXRgR3vhko5X87q8bSqwbRIM+6leVrvT6YRgfV9H/lg9oaRSpOFw3A/Isd0w2J5yNdgrzYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7yytgArhhcQAhzvZYbDgi3LqaSH3GT1FPkR4PsI4PQ=;
 b=s4V8lY4Tukz/pQszyLdLxdJ4ba4TpkTeyvyt6nfL378+Co7NN4NmtbMzDdpnt4BwVqkw27gt3N8ghN4fXXVq1ErWLvMz1vzxze+M2iNTcpZJHSs2NCc5kCObnur8AIq9QDuuOxzm8HfuKX5yCRD8wXETNGIWFl0wA5EX+zWLmu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10) by SG2PR01MB4364.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 11 Jul
 2023 08:10:29 +0000
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::a0c:9c3f:6dba:79aa]) by SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::a0c:9c3f:6dba:79aa%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:10:29 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     kuba@kernel.org
Cc:     jk.shin@newratek.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: fix error handling when channel_switch on S1G band
Date:   Tue, 11 Jul 2023 17:09:18 +0900
Message-Id: <20230711080918.20114-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230705141206.22a74fa3@kernel.org>
References: <20230705141206.22a74fa3@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To SG2PR01MB3286.apcprd01.prod.exchangelabs.com (2603:1096:4:80::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB3286:EE_|SG2PR01MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: bf591e38-8e40-488f-bdc7-08db81e64a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlyYap4NHboF6IJIM5xD1w4iEQ7IQtmL1GZE5b26My53pYN6czj/esiBSrexItTwrWwWcb+HXS4xroOX/MV4NyBsroPe5eZFSiJmnkxXASIf76xg2pdWteQIh3wRTU8v4GmdNfP1s8fl/id7AM7XYJ281GlA29TdJksMFZTsEsejOVLowGN5qpJaRL0/I/7F1TDONfx8G28GSOa4+UnHPJdNj9dG0uh3qxX6T7JkT+kvHpmkT5vIrE27BW7E66z62j6/xGmdjYfk0WyGj+rwZ+YtMRd4GmYrXkUeQ6mbnzYPlHSCTCIXVacW6YeV/lx3QmLGMx/giVSQ5VnxzExg0S/m4/pHJJd5uALlSYTdwibgwnb1UlVN33zCV35eR8gW4RAdp+JedC//cnZthFMVUD0Y8J/3Z9CjM8ho5QVOzaoME1FrIiae9+X2Ib1oHUL1xNgYzSlftNMxbR+tJFB11NZpvOpbb/Ns9kM5cYk1IRWNy0LrMxw56LM9w+k6pqPhEi2Zmq8OSNZThno7nSwSP2by9njHggkI8cSm1sEBM0NxmWvwXZj2kWjwTzI6jg0vZKSxNFnSM7GzqrWym2190Nkzxa3mdz3TLcWd1utXIrA4Cas9ySqE9wCf2SGGHvFL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR01MB3286.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39840400004)(396003)(376002)(451199021)(6666004)(6486002)(478600001)(38100700002)(86362001)(36756003)(41300700001)(6506007)(66946007)(4744005)(5660300002)(8676002)(66556008)(316002)(26005)(52116002)(2906002)(6512007)(1076003)(6916009)(8936002)(4326008)(83380400001)(2616005)(38350700002)(66476007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dpDBdtBfXOjfTC+bCUBfCIYCpd5oBI3i9Hj4F6NGAa9XNSC3qZ4pjXUzj5b9?=
 =?us-ascii?Q?rBKVmddDEjJ1pCy6dHFI0oCAytPT1KNMXUHYZSLgnbeRGoR4E2D8bNRXde+1?=
 =?us-ascii?Q?vd/TveKkegpyrqqtlCwJXXt9NU6K+SD6MuEs63bIcgBe1iwybsMR11sC8mGM?=
 =?us-ascii?Q?XwS7yCvsnLVKiII0rN2U+k6gc/QI4WtWuxHjStv729RlIJ5k+c1g1pwdlBUj?=
 =?us-ascii?Q?YahEDZ+l0uxkRUaSx0Rdz1up+3KfSDAzspLUPK8C+ZeRG4hQwoKNgnxqiaFr?=
 =?us-ascii?Q?8rXRRZK4KPl9E8brOwlmKWT5eozkvFmFgIzibBjBjZ/qkyjBsVvwT0UDLmUk?=
 =?us-ascii?Q?55MyybaHlAMDQOmo3mr1E1v0MsUInYwjieqybEC6FY3BGCL0pqe+cZ9bt2+F?=
 =?us-ascii?Q?vBrQJVWU6VfRMrymi5mcuFbrORaZcxhfp5X7vFw6GL6Mjra0vzOM6YbttpkV?=
 =?us-ascii?Q?ws0wLtBpXO7Y7/AoClsxCxJg7TVZHHoOZOiQbek6QkWo5gXlUA3mQz3x0wi5?=
 =?us-ascii?Q?L0FhvafpN5IHOmtZy1U9Q2I37CTTSzxV56y1MMgjBjYaVvbUEyc7PyKZ2dLw?=
 =?us-ascii?Q?Yxp6CwdHuAQ4/UbDcRgDpkWdHYqzMRNXQfvLUHANOvNJLLGx6YNQ+IwvRZfV?=
 =?us-ascii?Q?KCetq8eXxIGLplBgRDPFPl/B+0qDCUZvRFH7wGbfSmToMH9IfJDyIXthJrHZ?=
 =?us-ascii?Q?nH2pGDd6f1Vkeq9qwge0yhAjd/CMKJWAfBPRV64UVsp3KtqzIW4W3sYwWnj+?=
 =?us-ascii?Q?NtSLmJcFWsIa97miyGtWsbVVQOpzKx0uidE6WpqXYOLD9LBX3j+LKuQAt+4C?=
 =?us-ascii?Q?g1i/53mvN5HZqqQ8l1h2FLFKE7ZSMq3CyARVG5DT/nU50HOY3y0JT8d1bXPP?=
 =?us-ascii?Q?zDOWHaMs9Jnn0L2jropxesn9RdQ8HSZGwuyqW22ES4pRWCFaV9O8yQO4HBaV?=
 =?us-ascii?Q?VnQT7OERgL6MH4atCrR8rgC0IXrlrFN7huRzz0nTV/6jAA2IM2qgso2Bx4UX?=
 =?us-ascii?Q?osh1bO/e4oBh9yBS4pY564YW4gfnPv6HSashlxH+nPFPo2tFl7obAOIoiFyP?=
 =?us-ascii?Q?O5r/ArIf1ColItDMmzeggyD9ve8qT6j99i0nbJZQ2jUWnMmJGDndx3rxq33t?=
 =?us-ascii?Q?LvGgw5SCFOhjVKL6gtAJMkQqu+9T3Xg9H3isLRhAAQl8R/J4y69g2LnGmBgM?=
 =?us-ascii?Q?CShx8uj9XwVqrWhoDrp4nvkcP1aorIeEHGhRy6Pz3dqNP0CR/+rVHthq7vEU?=
 =?us-ascii?Q?n+7zP+pbtf1CCRFmvD81broiaBtTukKbZxJMalxqB3btABPrFfJnKaxneM68?=
 =?us-ascii?Q?+unakrzreXAFUUv/0rXPm1M6vW5cvqu9psEEY35YXzWaodXf4NOdYcPvhQhT?=
 =?us-ascii?Q?EWc6bPwFrPmhyjy3fzO1OS+/5cmJ/5ZfGAGfmWC1wOqXClnR6x1zKAKKVXw6?=
 =?us-ascii?Q?j/N2EWuLSU5Ws9/IEDdCQv8sldUwk2FUFzan8+v9TgagvfzWrY2i7BHaQQ+t?=
 =?us-ascii?Q?FEN0TPs9K43cc53sEXCrHMMoSffRppGnDNy42KUn6TKJ45JEVhW1pofYPD9E?=
 =?us-ascii?Q?mYBIfx9RzExk6pkJuxrsTt6X9WPeT7xXt8PGk7R2?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf591e38-8e40-488f-bdc7-08db81e64a16
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB3286.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 08:10:29.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrKWu8LCW67TRhtUzCeivndFYz4zegyhHcChY+KPGDnDhRV7TYtfiK0oHYrHveJa1VrdFJFtKWBYFGNHNe397A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4364
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When channel_switch is performed to a channel with a freq_offset,
such as 909.5 MHz, channel_switch fails with the "-EOPNOTSUPP" error.
Since freq_offset is used in the S1G band, it should not be treated
as an error only with the freq_offset condition.

Fixes: b6011960f392 ("mac80211: handle channel frequency offset")
Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f2d08dbccfb7..f251945cf6fd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3909,8 +3909,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
-	if (params->chandef.chan->freq_offset) {
-		/* this may work, but is untested */
+	if (params->chandef.chan->freq_offset &&
+	    params->chandef.chan->band != NL80211_BAND_S1GHZ) {
+		/* Currently, offset is supported only on the S1G band. */
 		err = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.25.1

