Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8126830A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 05:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgINDQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Sep 2020 23:16:54 -0400
Received: from mail-co1nam11on2096.outbound.protection.outlook.com ([40.107.220.96]:49120
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgINDQx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Sep 2020 23:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze7yNaVJWAMpCPqb8Ao3TMyBLMXtalUjBYYka2zC9lEcG6calkvtJXIsa3HOo7fG4Y3AcE0mBs+UIvb8UDTp7WMvuefAV2qkXgXeWAsr+87mBWKvJrDrPuYz57Oort2o77D8iZ/kVrD+eYhg4um9lu4P3UgR287HSZAquNbbjfhye8/xfRdKkxmI5ykblPfOJwvrcWe+oEpjkzqN1g/cElIopJgTOdTX414C39E8JS7wZFEN+BSe1AlHkcak5nFcS32arrt6wdKqeTSM/AKUEmvGyONNqjyafrbpwB02ysqe5saDTrImkNA/F7W2fpl61BB3wsfGn79pufDPqSk/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hVch0XCiE2krAp+LgNiSjkiKvWWkErE48HgegzjOi8=;
 b=aR1LXVV5Ati7tH/kb91OETZcDFkAjnd2LdOVPK289HqYz6o47R3SZtuxipJoZDodnxrgdI0wwGXYK2sEndtSTARhjJOrKk5I/PmiWBSa3cTJZZnAazLGpfmTnspQz7YhyS9C9JNtisVGXh9huRCTFU29+G/+NLy01JUvm8Y6T05HvVMxjcKvZ5IO31jwwnGdMCHog4SL2W4mGvCftt6IvtWhKevYiQuA6LUcphhUHJF0zQdR6fYtTGoZJRpP13HUmFf3BIfEIIAXtqPT1fEV1gq9IMWOmnYiUSctCPaTonNy1jaNHKmU6Qe38RxBM9WERMck22kGu5SqMwuzPFHdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hVch0XCiE2krAp+LgNiSjkiKvWWkErE48HgegzjOi8=;
 b=j0BKiUDGC0tKV2mN1TOP5y8c4RbUzLGCXUCeP1sXGisQC38MKdVMPFmq3B+jw7OGALWkwcAaRrpepdxrYANfPJEiCQheFo4xC60eX2qZ+X19o4BXWoxb0gWSxmodzx4sUF9SCdQSx04cu97ycitAPtPdMiT5vMA6rTvBz7lihK8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5377.namprd06.prod.outlook.com (2603:10b6:408:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 03:16:51 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 03:16:51 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Kurt Lee <kurt.lee@cypress.com>
Subject: [PATCH v2 2/3] brcmfmac: set net carrier on via test tool for AP mode
Date:   Sun, 13 Sep 2020 22:16:33 -0500
Message-Id: <20200914031634.190721-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200914031634.190721-1-wright.feng@cypress.com>
References: <20200914031634.190721-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 03:16:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1b25bf6-b7b2-43fe-1768-08d8585c9f67
X-MS-TrafficTypeDiagnostic: BN8PR06MB5377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB5377A1EA9C9E65B2D3AA875CFB230@BN8PR06MB5377.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqWlTh1FNAi5HZFgDp+qZUIjrMgxnkjUETLvFHS2smC8DLbwnqmq1AArinUOljDiPAZr54BvZ9T/5b9fyfGKrgeZ98BlW1+Vge/HADhcgBeJjF4WbOv1xOwUjmf1uquX+qwzGUeq1ECfNvySvOWOOOgXYLG8Uspfs9T/SQW3nWMouawS3sEXViMFKO1YaHHwLpbmVMyXbAIe63ly7Q3McddQzBGY8HceCgWnBCS16cD0E/0XMgYknstGsnLbErCdN6/LkECNiRIuat3d/Vny7zg6iQhe8XpSNr2gMe9dHhOciE5FEGlcBBxWepHzqvUzq9IoqKCZB2Np3JwwC2BJLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(36756003)(26005)(7696005)(52116002)(6916009)(6486002)(66556008)(66476007)(1076003)(86362001)(16526019)(66946007)(186003)(4326008)(8936002)(8676002)(44832011)(2906002)(478600001)(316002)(54906003)(2616005)(956004)(5660300002)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: n+SkSvgKwcDwYujOzA4YfH0l85UwnnGn117vXan8AW55Rlyr/agHvzpJaKqZ91cbjtnZck4bB6pAwTnEPbvCrm801y2gfPGo+EBpoHcbbAK88DXXtm3hx9mrc0p5COQrsA93IRIX5dBwIOGxxG/XYglKEhWlO7z0IGeD1+5j91Qt/ePY0rrurPLIc2dCe8iJApFf7Rqx/uXocjGfVQvhDsO32BfFoT1scA9e0DJ0xzeBboCLfD3uANVr3Caryuaz6Tbq9pWVbasau+Vi6cWwRiJV9S3SQ2sezQb+FgDVzDD34QEOQ6CBa+Bu9+vfmQ1S0POhz8UePjzJfKHMzhQX6zJ2zrKGzUtwXE6bsJVTmSWlFFIbqF+KqVIHj9nJFp/AfX0EnT7fS238vXsTqp/NPPlZDR3K2QbHBI90hvqqzctw9zNAmycqsOPZKoEeHn+YWD6bsO7nJwgzgnylWl9RLnnfbYkOidpgud+EKyJGe7ECdXnS0an04Tc8OIqdLQeshqWn4n+rL/47YjcL4N8WoxAB2BzODUpk/w09cJnuC+HFGYNjTIYYECQwtYOV2McW7LBrrVkKN457rHGdYZOHz8QhhpOCzHj72S3IV3PVOTCg2egqWo+O3rPVl/hNYlEC5gDcpjqEd58AJ+9917n4mw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b25bf6-b7b2-43fe-1768-08d8585c9f67
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 03:16:51.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S59B54Z8oda0971rIMxR9yf6T/lXRxhMgD9ZLGuNReD/m1Fba+IbdlKEPNSOCZy4sGBsClA3UNITlfW1MKmxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5377
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kurt Lee <kurt.lee@cypress.com>

In manufacturing line, test tool may be used to enable SoftAP. Such
SoftAP can't pass traffic because netif carrier is off by default. To
allow such use case, let brcmfmac parse ioctl cmd, and then set iftype
to ap mode and report netif_carrier_on to upper layer.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/vendor.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
index d07e7c7355d9..5edf5ac1167a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
@@ -64,6 +64,15 @@ static int brcmf_cfg80211_vndr_cmds_dcmd_handler(struct wiphy *wiphy,
 		*(char *)(dcmd_buf + len)  = '\0';
 	}
 
+	if (cmdhdr->cmd == BRCMF_C_SET_AP) {
+		if (*(int *)(dcmd_buf) == 1) {
+			ifp->vif->wdev.iftype = NL80211_IFTYPE_AP;
+			brcmf_net_setcarrier(ifp, true);
+		} else {
+			ifp->vif->wdev.iftype = NL80211_IFTYPE_STATION;
+		}
+	}
+
 	if (cmdhdr->set)
 		ret = brcmf_fil_cmd_data_set(ifp, cmdhdr->cmd, dcmd_buf,
 					     ret_len);
-- 
2.25.0

