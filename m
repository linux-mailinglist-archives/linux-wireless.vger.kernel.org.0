Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8818ADA5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 08:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgCSHx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 03:53:56 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:45696
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgCSHx4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 03:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8BZK/ojPMrYvmfK81DEywDXeKeUxL/gYN1/e12iMRwAiniXfFU9Liek/Umoks9dK+HBSusyTQlXe3C4pZfEtz0ymnW3EHEDVkS5LPIgUl3e77cSaSVHXJPCAqssamydmVuIF9bu2Tqo2jikPTEZ+L+Ljfz9RiHuO6kN/+uFPAwFxrZaaMfrC1XDs8ZE1yCh/KAbdl/LCSMv3kRjxZQUAKEP04LrRFjKNPQHj989qb1QH/gHyC+yb6em6OP3zH2t0MoNL2HlgzQvjbtTKXzlnesHm6KR83Mq0n2KInuoYpBKCzfybTOe5VZhLFcqmjwqaagmHs48tzwS888RGntBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BT5oMl2f1XwPIkelN1R6P9WF3/Pm5LyX5pvaNnd4Pw=;
 b=ELF3R1e9xqwd6hsWBb+Qj2iM96GShmMTnXZayBVxt4xvlplItoN/Px/ujlW0UsOLAVQL/Jzfg1f5bBDtV8ybIPDhUDYQvgsLPBCcLiz5/CYOsQ8A7NdrcWxTXhrUmK51Vtx/7icPt48Es44An9vfN8sH+obWitSEj6kmfVQmPmRGFaDhAmMZqYouATRJRXtmdvFYzD40SB+uJzZCowClhlzQO6LGcL7+FJSqcQqAhZPRK3YrveBo18bYhUEhg5Y/8H1MQTU2UipybuvMIWsZTHEG4jxN3vV0l+otkVSn+TWKWJsk3oi2+xrhEL9mDUFZBbULXGuxRfoONAIWRKe2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BT5oMl2f1XwPIkelN1R6P9WF3/Pm5LyX5pvaNnd4Pw=;
 b=N/BwZeX+8M1XQ38Xngn+vTw1NycU0R912UB6cmr8l5uK1xzkxn9Owt/LNyYIhd1QgAKYPmWISNktkXg6aucmT/0xLVVMjbyqpzV+oZADJuDQ92PF7EYXBXE08rx8b/kE5UY8gOcBc2S1NsRkVmvXEbkDGZJTKQUGuOjazLok8nI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4585.namprd06.prod.outlook.com (2603:10b6:5:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.23; Thu, 19 Mar 2020 07:53:51 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2814.018; Thu, 19 Mar 2020
 07:53:51 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 2/3] brcmfmac: make firmware eap_restrict a module parameter
Date:   Thu, 19 Mar 2020 02:53:25 -0500
Message-Id: <1584604406-15452-3-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (12.110.209.245) by MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:53:50 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3944387-dca4-4795-25f9-08d7cbdaaa32
X-MS-TrafficTypeDiagnostic: DM6PR06MB4585:|DM6PR06MB4585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4585CB5465CE97496E0FADDBFBF40@DM6PR06MB4585.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(44832011)(52116002)(36756003)(8676002)(81156014)(81166006)(8936002)(6666004)(956004)(2616005)(316002)(16526019)(186003)(66476007)(478600001)(66946007)(6636002)(26005)(6486002)(7696005)(2906002)(4326008)(66556008)(5660300002)(86362001)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4585;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59x/9b3z/WPyxxfT0lnngDgOLug4aiHC8ScZJfFRndItncmCCIiExHDwjCH7P3Mpqq9GrVD8JZl/XMyf6i1ukeVph7LNcEaW9ntnGiQ5DDe6Ej78mrVuLateG78Jo91tNQXAiIQiEfhxLySb7lMu+BedTSw/KGdyN84GPmKctqsDy38hG+p+6JKcNhc22oIY/RdKXeEl+fEQ21Hb2fueVZ+u16WOmBzpQEtjL2g8424ZJ/Xll5wZax8LzCEfvslfmJJ6WAwh+mwiQPzYTEM+KEnzd3kdr5fUdgyc0GRd19Q7xaefDOtfnXWbPYnWooEZSEHOrZPULMQ9qu9R4Mzt+ssiLE/47fGtVdIJt4+oWBcSnkne5cryJ5ZKbtrfXtIICg7Fwc6XGidBqJFkJXC/ACA8UVBqpxPAfSRODeDYeZMb4HPlLu37/J5JCPDteUNNwPMFTWRk8aNMSKJPTjLal9Chumr2jWpSB7afK3BIV40Jcsiic7otXhW/D+l0kFcT
X-MS-Exchange-AntiSpam-MessageData: duxBb4G0hvTJqI+P1GAVhnC+ofHVwnuTQ4ChqTNQBOuA1ikKw0DdUXrgFTBaHic5g9zndvxzhy0+wDbi2nHGYV89SLL01LxiUE2jX+16cMF+0Mr9uCPt3ZpAL12ptmYEpefBeE3urghUFuzmRZFoqQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3944387-dca4-4795-25f9-08d7cbdaaa32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:53:51.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmTEPMDw+RDTKd5oNFn2TVDWoGaVub3i09L92cKkHbhKHlBMM9Q5+RYXO+vitCrEmmFKCn5cJSqlDBASWT5S1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4585
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When eap_restrict is enabled, firmware will toss non-802.1x frames from
tx/rx data path if station not yet authorized.
Internal firmware eap_restrict is disabled by default. This patch makes
it possible to enable firmware eap_restrict by specifying
eap_restrict=1 as module parameter.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 9 +++++++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c   | 5 +++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h   | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index eb49900..07a231c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6942,6 +6942,7 @@ static s32 brcmf_config_dongle(struct brcmf_cfg80211_info *cfg)
 	struct wireless_dev *wdev;
 	struct brcmf_if *ifp;
 	s32 power_mode;
+	s32 eap_restrict;
 	s32 err = 0;
 
 	if (cfg->dongle_up)
@@ -6966,6 +6967,14 @@ static s32 brcmf_config_dongle(struct brcmf_cfg80211_info *cfg)
 	err = brcmf_dongle_roam(ifp);
 	if (err)
 		goto default_conf_out;
+
+	eap_restrict = ifp->drvr->settings->eap_restrict;
+	if (eap_restrict) {
+		err = brcmf_fil_iovar_int_set(ifp, "eap_restrict",
+					      eap_restrict);
+		if (err)
+			brcmf_info("eap_restrict error (%d)\n", err);
+	}
 	err = brcmf_cfg80211_change_iface(wdev->wiphy, ndev, wdev->iftype,
 					  NULL);
 	if (err)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index dec25e4..cda6bef 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -67,6 +67,10 @@ static int brcmf_iapp_enable;
 module_param_named(iapp, brcmf_iapp_enable, int, 0);
 MODULE_PARM_DESC(iapp, "Enable partial support for the obsoleted Inter-Access Point Protocol");
 
+static int brcmf_eap_restrict;
+module_param_named(eap_restrict, brcmf_eap_restrict, int, 0400);
+MODULE_PARM_DESC(eap_restrict, "Block non-802.1X frames until auth finished");
+
 #ifdef DEBUG
 /* always succeed brcmf_bus_started() */
 static int brcmf_ignore_probe_fail;
@@ -413,6 +417,7 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	settings->fcmode = brcmf_fcmode;
 	settings->roamoff = !!brcmf_roamoff;
 	settings->iapp = !!brcmf_iapp_enable;
+	settings->eap_restrict = !!brcmf_eap_restrict;
 #ifdef DEBUG
 	settings->ignore_probe_fail = !!brcmf_ignore_probe_fail;
 #endif
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 144cf45..059f09c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -37,6 +37,7 @@ extern struct brcmf_mp_global_t brcmf_mp_global;
  * @feature_disable: Feature_disable bitmask.
  * @fcmode: FWS flow control.
  * @roamoff: Firmware roaming off?
+ * @eap_restrict: Not allow data tx/rx until 802.1X auth succeeds
  * @ignore_probe_fail: Ignore probe failure.
  * @country_codes: If available, pointer to struct for translating country codes
  * @bus: Bus specific platform data. Only SDIO at the mmoment.
@@ -47,6 +48,7 @@ struct brcmf_mp_device {
 	int		fcmode;
 	bool		roamoff;
 	bool		iapp;
+	bool		eap_restrict;
 	bool		ignore_probe_fail;
 	struct brcmfmac_pd_cc *country_codes;
 	const char	*board_type;
-- 
2.1.0

