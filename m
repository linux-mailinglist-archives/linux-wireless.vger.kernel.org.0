Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022D3260A7D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 08:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgIHGCK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 02:02:10 -0400
Received: from mail-dm6nam10on2122.outbound.protection.outlook.com ([40.107.93.122]:56704
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbgIHGCG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 02:02:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm6MYrVDm11bedzBh1v2CfgTpUGOX9TbwnB6wSOE/p4evTJwq3xxDEX/MLibH8hDglZVhpE3sdu/uyeOEhRBLJ01EQGsr9HD2yMIvbsEk/VTVPY/RPXYra6/kvnGrzTWyOW9V3cXEfrxUxAiSgsy/pkBOqMiCJ+IqmYskPTr0cd76As1b8qUThycMsFh9isuHmTeVFIQfGzzai3nuxeXLqgodzd5woy/RyxEticco0Qt9c9lcqjW+PaglvZYmk/T9/7qWOAXMUc3sfUpzSQZNRb/MNzidhOrSwWYc/V6SpIEIZmAfzEBC8vGiVoNiMu28HaRMv0T853XoxWWz8t0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODZAIrzMf55NR/kueTkOMbYZAd2BgDU/4X3/4sBlgkI=;
 b=RYQsMc/nird0LYI796+OBTvcuYU5bTzSy90uS/3ej+WX7biWWTDy45wBT3WFL1paaMQJ6AahAT8sNDcMeRBU80mRtEdFyBLCOK0eLzQoUE6gmnOLjztQ5mgVJpc8Uz9KuKsmAt5AEqhgTI16ldcFIRb4GFocbupJCuqHZAaAE3WYZpdTCRnTBXQPWF+reE+SNMRjSdAL/1YBMoxAoxtzE39+EgNRgFStLpfG0chIvUudKa7Dzh2XIscFiIWtreFa/1fmJCRO3KG6T+FPZiMss5CpI3ft+y2RXjxj4tQKlzEwbcqWgobKkMRjnJ65WCNFfqQgoz7TiuNWvZWw47xR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODZAIrzMf55NR/kueTkOMbYZAd2BgDU/4X3/4sBlgkI=;
 b=VW7q/noPiaxt1DlxBgTkI2gup1YekO3OVww12JmZBVW64XU4iddxBGVaMgVVIZrJaPtzDX1lxk+gfT3WOsIGdp72zs/QPq12fOn//anMhGWx8kxdcpfTYTLniSFbWcwwpUw1/k1w6UiWLk9vXgjfQy2mtunYq16v0F0D7WNLYAE=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3507.namprd06.prod.outlook.com (2603:10b6:404:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 06:02:04 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 06:02:04 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] cfg80211: add more comments for ap_isolate in bss_parameters
Date:   Tue,  8 Sep 2020 01:01:57 -0500
Message-Id: <20200908060157.98846-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 06:02:03 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90008d5c-acc0-4ad4-39a7-08d853bcb57a
X-MS-TrafficTypeDiagnostic: BN6PR06MB3507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB35076614D41DDD66AA85DBD3FB290@BN6PR06MB3507.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnBnORgPUmKyBZMX8LHnub+jSZ5jS+hF0+L2arOy1l/G+lF6jFRucQXOT6SMuq6nPiP6tzmQJvIMdszrmLKfXZ031ZfR7hfuStDN/sRMOHUU91rRrAqwJr3d6p7qoSdcNonttIcOwCC0YbTgGqR/UxfIINFcOJ3ah+5DjdvaKboq/Q1X9KYo1Ci9vLZEnziYX7KzQ5e0ykfxyesSdoA2LtCDbjfKMVL2zAqSdC4oUj+dFnhlVvO5zKd2MD6pK8RLpbg03+omXJuAyUND4HfGMVsXQ8d+kWvt/dXkND7H43Zek59PM3Gz94x1cla4K0OT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(5660300002)(186003)(16526019)(26005)(66476007)(44832011)(4744005)(316002)(66556008)(6486002)(2616005)(54906003)(86362001)(6666004)(66946007)(1076003)(7696005)(52116002)(956004)(478600001)(8676002)(2906002)(8936002)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xOb+rcTv0CvptCZRej+9BeGcpdgX4pvsCH8XflGUL6ybY6VOAcBXiaHDCrvSNW4v9M3GJI+ty9lpB7PP7xVqffnZPP0cLvDzq0Ncw/fDVz2MA2PRn16WQOTUWs4O+EWWYJT0MP8gaUSTe6ldYSmC+A9SOCVfTtF1mjVjxm/YDC1jqjZPRrPUOqM67E812HGYwLgxm4DjJDtlzyk0+KHL35fJ5AZVW+KQBKs4OD7uMPjdMpJLSV6FtS1y8QrRENe5aZ32CHwelvKsbXSwGCa9AMFySa+zTrHPKzADiRb5RTXfI7SQdwrNOMMFfXtsgVCZYPwjoOc+D/ploAdrg+ZPHEjo/BPDyZH4jTOeiNCGT/3eWUMRhFBO4H5bPbEbNPkmICp6OjWIyCT4+oVijkKNMxlIcYWBeFqO/36Ks7DLPkUJ12DzPPtlod8JgTPJHi1TmJZhqb1EUvcsR7nc435UMRidgFI9hCfhGoGrVE616iBpsWmP5g4B3LAoXAONf8JmA8S0/aFnNE5r3ZiZJMmh6BJDgq7/4gIWVuR9FKbA6OoWOwj2nCnbOyXBq7BfDKwBr1QOK0pwAekUodW7m7GvGmdz7RJ24zTpIBHdGruJvgcxxPi36PoM9hYp298M5SPz2z8K4WyjPjbvZgjGuGUoTg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90008d5c-acc0-4ad4-39a7-08d853bcb57a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 06:02:03.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E850iyCvrViDKeypH0sDa0ieR6OWHXWuOp8ffgAVTalKCJ59vZUAWT31qKXZiP7Aw8FobOR63btIkYlWjOYMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3507
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The value of struct bss_parameters::ap_isolate will be -1, 0 or 1.
The value -1 means not to change. To prevent developers from thinking
ap_isolate is only 0 or 1, I add more comments on it.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 include/net/cfg80211.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..f60281c866dc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1764,6 +1764,7 @@ struct mpath_info {
  *	(or NULL for no change)
  * @basic_rates_len: number of basic rates
  * @ap_isolate: do not forward packets between connected stations
+ *	(0 = no, 1 = yes, -1 = do not change)
  * @ht_opmode: HT Operation mode
  *	(u16 = opmode, -1 = do not change)
  * @p2p_ctwindow: P2P CT Window (-1 = no change)
-- 
2.25.0

