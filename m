Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32A321274E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 17:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgGBPGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 11:06:30 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:9806
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729556AbgGBPG3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 11:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCzJyYRrzkVgEXXoLEyKdgKD3e6cuBwjf4fT5OfrbQP8acNJ0753gJd1uyxmk1OSrE3wFz5xIPs4gmmpzfgStaT7nxKP15njQzXG5gnVaoceEY7XKIacMcQ3Bof7X5dn0bx7lvq2xlXcCa09JiesjCf6UX6J9J1edtbMtTfqwgipHIM/ufBJXY4VfnrPG3F9lzsmYO/WRuIx2yXJBAggVQ6IZDYHOZaO1GZf8he+ZbtfjpM3axFukvP81zuDUdgIrbGoLeaswKhYVpYx9O83RChVV29fA9t6WiglkacAujaO8eYhhLAqMT6f2xRwYT70i43i9RuNEi3pplhEXD96rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW18D/6yzu+yPW6FeQXCLoG0lMiGajCaLRxEi+fouLE=;
 b=jhWR0Iw46z7XmNrmeJjPMCJq31SuGS0W5JCl+V41gd8K50YfFEIlzWUMoMVDw9g6y6uHudqAxYEbMe/k31WGkMxkX1BCHSsr+KtXwdoCHcNyPKR38VIeXzB3vc1tXc9R9aSEVj6VaNqQ0f6YNpafWizCfqKjASzsg2SbPyDHzBzJ5oXbUsErJO1qzaTItxLld3vRYnRyWr1c6/ft1rWzuV9ha0AcNd+ZrLsiacJRQh2HvkIleBOeZYu/sGRG4KQjpXjimO48aNRF24jQF9hQQa5I3RCAt2zRrlmXQSbvkhKndLAS2kzV/BfFYrEtjiYoG6Ve22zRSHvOkSzEWs/QJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW18D/6yzu+yPW6FeQXCLoG0lMiGajCaLRxEi+fouLE=;
 b=OzE8e2QJIKNIxGh1pYrbeQTEbeeFlW8rSzFK5F/1IPCRtQpkg3YcdZliAjoyyqvoIH6sw/20pFznw5XFkI+uzoLYmX+sWqrGPrZD3hdOi4ij+0bLgDDQWng99QTZU95diHghUb6sOptBaKZBJCjiSGuWYylJLJRn5+DeVXDp5+HXPuWdcasBcl0ksf+isY7jVAy/0lUYHjfyj6W3hbuz/gH2QJVL18QbRdXO8q3cWDlNg0SgMu+TtCFR+/LAoD0DRCsLQ+PkFPAGrhTPhosZhmz/WTZBnSxw3/w9Q815eUZZe/1tZTMDoeJRVPkLbLKpURnIPssVbzMSj5BWF6fFHw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mail.polimi.it;
Received: from PR1PR06MB4954.eurprd06.prod.outlook.com (2603:10a6:102:6::26)
 by PR3PR06MB6716.eurprd06.prod.outlook.com (2603:10a6:102:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 15:06:26 +0000
Received: from PR1PR06MB4954.eurprd06.prod.outlook.com
 ([fe80::add2:c9dd:7fa1:4d0a]) by PR1PR06MB4954.eurprd06.prod.outlook.com
 ([fe80::add2:c9dd:7fa1:4d0a%7]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 15:06:26 +0000
From:   Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
To:     linux-wireless@vger.kernel.org
Cc:     Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: [PATCH] iwlwifi: Make some Killer Wireless-AC 1550 cards working again
Date:   Thu,  2 Jul 2020 17:05:52 +0200
Message-Id: <20200702150552.9734-1-alessio.bonfiglio@mail.polimi.it>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To PR1PR06MB4954.eurprd06.prod.outlook.com
 (2603:10a6:102:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alexei-pc.homenet.telecomitalia.it (79.8.185.97) by ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 15:06:25 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [79.8.185.97]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff91a8cd-8d05-4d8d-5a68-08d81e997d81
X-MS-TrafficTypeDiagnostic: PR3PR06MB6716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR06MB6716679E45A5D4F21AD8B821D16D0@PR3PR06MB6716.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79p/SiQD9JxasFYQV5D8C0hvLv1cpYoOA7p46GsXRdiPDyu3peVVuCyv+abD3YteChsWlA5nfNEgcUmj/whjrK4EbxIS987oiAneC66oVTPxA/pPOIm6kXxUPsA3eAo763ZM/V5ESWu4Q4bvkytHtOvCv/EauHSz5PyWyE+7XTro+sBgPQU+akBT39e0wy9178PMgEU5N+uKENdlRU19aKz0ToK/Jwi1NpOWx92ldxw4tlm92oQVT3xnNy0iZA4w+wc7i0FaQRifuRr9P4UnjUpu8yNhV500p3E/zK83KMj5Ot42vxC6ec+qKUoxxWH62TMi5URFuzLKqvcK90IKXjZebFE2QPljuljnGRejRdmMf+iOd2OkZw2OaDldtvR2wWn3JUqMp/WtSqAxY46z/tPPF1XNrBxZxq3tMRsJX8iK0G2SaF167LTn6C6WnMIUaJfQIdypLppGV81ut9A0Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4954.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(83380400001)(6512007)(26005)(16526019)(4326008)(2906002)(6916009)(52116002)(1076003)(66556008)(66476007)(66946007)(44832011)(5660300002)(956004)(6486002)(2616005)(6666004)(8936002)(86362001)(8676002)(186003)(6506007)(478600001)(54906003)(786003)(966005)(316002)(16060500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yDsDpOaaMU5+d9L8DE1W20qFF4uWq2YaUuixFeRhFqn25+53qZOkL4VmgJXGYLQmdgTPjW30NPZ0mjeI5Ae8TtkF/05lFLIpeDkhzPcPU11uC+8occQUmbqCEEmkIk+BgDB5bB0o8rkkUXWXxLefGs/nhg7nlWLmQlKl/pCvr+lfqblgncM46JfYyN8TgDtqE9w95e81IY1Up/pqmz7NclTABTxaY94dW6mg3MozqijrpRMMuJl3ATSZvDOD6mDnUGfuMdxdqj5b/c2ouEhCpJxEqIcVmEXHTjpAMkK0L+U7XaCZgDlZ36Bu13VD/f54VZCwhdCGYpQSDPvDGGw3ReFqyh/eUplZplwBheOjLj3jKOJtZSw4AnZZn7SWlXB2vdCQdOFKJEZIXFaRR6jNvkQySlmMN60LfBElYHWnoL3QeMGAI+NU/U1J/dd+LwKfTe199jqtn+X48H+5feNyHjxXFWChGW6Xj9HRleMKExc=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91a8cd-8d05-4d8d-5a68-08d81e997d81
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4954.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 15:06:25.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBtenzfWiYGSK45TT9WkuNRb6tTMGXj+dnZmuihlCFjwvCmOmx4gTLlnK4e2uPGSr9qbqFAfqDM+59dQiTNVqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the regression introduced by commit c8685937d07f ("iwlwifi: move pu devices to new table") by add the ids and the configurations of two missing Killer 1550 cards in order to make these cards being configured and working correctly again (following the new table convention).
Resolve bug 208141 ("Wireless ac 9560 not working kernel 5.7.2", https://bugzilla.kernel.org/show_bug.cgi?id=208141).

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

