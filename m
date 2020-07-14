Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C021EC9E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGNJUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:20:33 -0400
Received: from mail-eopbgr120081.outbound.protection.outlook.com ([40.107.12.81]:18715
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbgGNJUb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/0rY9RYA6+dnzcW8Hw65VfIN0HZxGYXHJn4i2MNCtr+67XeT1l1o4GEmDkFMN4CViyTQpo2zdU1G9PUnEf+ywriYmjSmUi7WFoXev+MY2KU/ih7bDxT8edLWIwTn+8SRn3NF4Cw+tzXwV5za1rsvv6c8Hn7sk6mztxVFVagUG0mGGUZw/ZubNnyCSFoL8VI3hOIueGYzedy3+QMxvD66E8wfVYc3DTG1QEQ+4lfpnBacpl4YsKJE55aDB8wB4p4qFIEN52rCC5RrG9BnqiN0sUdOlvn2z/cVnN652zIGhGy3PZkBTuRUFTCXf6bQblXHqaC+B366GO1P/CfG6vv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHxS21B+V/161v0K9NCMIPDwwgg4c7NkueTAVnggy1U=;
 b=b54rRf4LZLglGdUecrPq58Xxi1uDkfeiRwHZ/53suf9OA+g9TX2XABYkt89YG0G7MdxEBi5vhHneL+RWbIqeKOl/CPYz6saZn4ksHbQt/gNYhHGTcxXYj3EuaGZ0CZQZIO0IB90KIfoUFbK2fjy83Fb/gmENd9U/X57+eA0/GYP13KMdFyxTsorRoi3Ic1kQwRZnrAPpvG46V5IvXdJwfrusPy6Jkc8ttC5qj1G1wS7CObkF2VQHa6bVY40/7ynVxfIdcNLWTCcyp5PKuUbC2+pHtnDhChgOIBfm3/4dB/X033S7PKQs0ErfJP+H9SHxmSATODz9vBqBNoq3dN3H8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHxS21B+V/161v0K9NCMIPDwwgg4c7NkueTAVnggy1U=;
 b=XBs3GO+PKe9E8VQ6golN6lZSdeZ1DUcgx6VAbRR0ViwH+862d2PHpMJkQahobjbEd1IImBElFx73KBkHPapSGinIcMZrIcFdzaMRDTo7CRb6sB3o138PhWa0XvrH9q7oxV0eJIWFWYytGKW/g7ZOXkApjtsJC+mEvxzCQ3m01AwIQilCb7RxbXKge5WHO9z8UWxuPgfCahFDOe4EyV8NwEVrIdVbK0xOCVGmiRmYIqfUkIgRVPwo4UrGVa0jFmzyyZxcpmKtYe9nH/aD80UtZlrXT0/o1pmUd/vv6aaAvsW0svmAKFlkHboK48yvuwv+N+rQv35Ts0QDCvq+bwt2cw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mail.polimi.it;
Received: from PR1PR06MB4954.eurprd06.prod.outlook.com (2603:10a6:102:6::26)
 by PR1PR06MB5964.eurprd06.prod.outlook.com (2603:10a6:102:c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 09:20:27 +0000
Received: from PR1PR06MB4954.eurprd06.prod.outlook.com
 ([fe80::add2:c9dd:7fa1:4d0a]) by PR1PR06MB4954.eurprd06.prod.outlook.com
 ([fe80::add2:c9dd:7fa1:4d0a%7]) with mapi id 15.20.3174.024; Tue, 14 Jul 2020
 09:20:27 +0000
From:   Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
To:     linux-wireless@vger.kernel.org
Cc:     Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH v2] iwlwifi: Make some Killer Wireless-AC 1550 cards work again
Date:   Tue, 14 Jul 2020 11:19:11 +0200
Message-Id: <20200714091911.4442-1-alessio.bonfiglio@mail.polimi.it>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <87imeqcwbt.fsf@tynnyri.adurom.net>
References: <87imeqcwbt.fsf@tynnyri.adurom.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::17)
 To PR1PR06MB4954.eurprd06.prod.outlook.com (2603:10a6:102:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alexei-pc.homenet.telecomitalia.it (79.8.185.97) by MR2P264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Tue, 14 Jul 2020 09:20:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [79.8.185.97]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bca381a8-f4d9-473b-0a2e-08d827d72592
X-MS-TrafficTypeDiagnostic: PR1PR06MB5964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR06MB596441535BDAA2B2842BA12AD1610@PR1PR06MB5964.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSiJlhkz5zjKo28NgnjCdIE7A8mZP52IGlTKsH34Y4tYwagzXqcIhcgZQGTLQylfU5txfKWuYVUCQzak1Zh12Gxkagf1K/D1TkxJvqSuzfTltdgM/QMXrq7tSFPDI+A831E5QDJwPi0v+r7isV2XMLoMU17hZRrbSZ9gHS6d48FoVHrGmnSSPCb39D9aiQj228h9CCHMb7ZkabWA3znEm0Typ2SEFvCvH9vxrTj8tOyEi37cKSaO9mDM3irJ99wPGiUCl25tJ8nb9UXX1rZc4diRQJ2xUM9ReM99VN+m/lj3GKpW6NhSwJ4X2errM3ERrF/oApBfTaM2BGIudO64OtcZ0gAuLOjcu0CYtqZyLVX11lb2RNO5mQUusdh9bclI4KNOgODqscsApe2xTq+Es6Ze63OrF2b2K1XOY/jP8YL6uj8cmRY1Kdp6vBqxUGdHA7BG35kDfMM/zMzg0SmI0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4954.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(44832011)(54906003)(16526019)(6916009)(8676002)(86362001)(966005)(8936002)(478600001)(956004)(6486002)(186003)(26005)(786003)(83380400001)(316002)(2616005)(4326008)(66556008)(66476007)(66946007)(6506007)(52116002)(5660300002)(6512007)(6666004)(2906002)(1076003)(16060500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gxb984kdcsb1RMRbks3zY9ZJaCEiJ57M9qN2AypEozlhdEXw5kQRexognFBYWi1yObWz0Lg/WwGuxOqWoVM/Jw9XDxb9B+jpVSa2NtOcMS/ZRqIlN8tt7vX0cOJipxa2VXYSP+9dMz733r7yIcu5HrzG4TWbL2VrrJ5bRsAXiu9bF6PVFu6dUF5ZrF+QMvENCJdLRLoQBm/C16y7xbDQI/mmvrx0tWiRI/FzcXque0r124smDjH5wrxGZ2K/B21z94Ql5EDiuCJHE2YCIDtUTFkfoGNe72Q9OkaF6O9EF5zAZZiedx/aivOtObligUw0PUiFgpkvPU/dzOBtP6SS+75iPKiFA00zBBF3qtU5mKMf84N561Or59PNj0/p14XeUab8Psys/r2oBKZztY6H3vxXF1251ZF5p7OUbtzVOaKS63aljbpIMNE0EUuGJffqH/Zgah4VoAynOwkymbrJoVefeQF+2sxanWzar1hP/bA=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: bca381a8-f4d9-473b-0a2e-08d827d72592
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4954.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:20:27.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODOnpaChWRHyUjrZ0U36xd5Q1eeu/TTuDGcwgx261q8h0pvz9nofeduF5PwhDau9eq4AowsX2jXk2VPPh7DStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB5964
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the regression introduced by commit c8685937d07f ("iwlwifi: move
pu devices to new table") by adding the ids and the configurations of
two missing Killer 1550 cards in order to configure and let them work
correctly again (following the new table convention).
Resolve bug 208141 ("Wireless ac 9560 not working kernel 5.7.2",
https://bugzilla.kernel.org/show_bug.cgi?id=208141).

Fixes: c8685937d07f ("iwlwifi: move pu devices to new table")
Signed-off-by: Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 65d65c6baf4c..e02bafb8921f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -582,6 +582,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x30DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 	IWL_DEV_INFO(0x31DC, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0x31DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
+	IWL_DEV_INFO(0xA370, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
+	IWL_DEV_INFO(0xA370, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 
-- 
2.27.0

