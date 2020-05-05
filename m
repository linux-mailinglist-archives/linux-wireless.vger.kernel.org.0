Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5607F1C4E80
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 08:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEGvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 02:51:51 -0400
Received: from mail-mw2nam10on2139.outbound.protection.outlook.com ([40.107.94.139]:29921
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgEEGvu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 02:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxDLnT2rWhhKKTbu2votL3Q46QWTz/g+chphJU3jIx0QUJKJ1hkUztVO1GwWQLf+9e++dl4Yz4Mc5kvjkekMLKwQ1UH44mZwFygRxNIywnTSMV4PTd81QoWozP4kv8iZPzw88d5o8bl69M6Eu6lazwU+ziexBZaBKalHVbVoJSdLHt6Vff+UzjIpEmuIyOK2WyoMSJdQS1+hFTpJrw0V1xF81kZKzHVNUEPGuz1m6tTrKZE9iUq6gcu7i2RDhAMXUHE7YaFniEMA7ereEy8FtczH5mQeemlhJFAvrhmenbs1PXI1QHyKbBWNuzzeUsYAOAUBT1Urcw4wzaSsIx5zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQrcJ5P44OZs9P3JdmSu5m6BchdRfSXyEvmfBA77bGk=;
 b=LMfHrGPtn1eMZRwjbFRqlhlfdTLDw+tIj42fYxcjQzLwyzRtHtsguj4EnPokpz3WGeQIEN8i142pNvx6nWuplEVEpc+kc0oCBa2ZMXjctoFuJB4WA8QTPNNPQWII+ousmUCXlz4ss7vrTq3t2hHh8aPQpgSXrtR8cOvLxHlSkq8+rqsA4V6hAxN+bCUXj5n0SDlG4GtaWINN4nKNcxGY9TyoIV2WW60Zj/HdHw4o9IOUqa+zFSIIlTDC1TV/Syw3A0DyUtWnnN+HZ2DisZbZLviIfphmC6+McrHU3tVYRxbVdc6UkJtfEYHTttzzG7C9exuvc4cdwjK1RJWOIouYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQrcJ5P44OZs9P3JdmSu5m6BchdRfSXyEvmfBA77bGk=;
 b=UqvLBdVB9GlEnUq0hsyJhqZWiPxg2P7zMOgfZbvl1N1k9ARhyhaqpIIlwBdFMNl8FvnOPzDjmhJoMZyiNH1xE4kiPAWP5ZFQ1oat6J9fj13f+sZR1kzO3So9LDSFbCtEkINEQiH8UO74tfb6GXux2tM5zv07f2+4H/IcXmm3S5s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB3816.namprd06.prod.outlook.com (2603:10b6:a02:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 06:51:44 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 06:51:44 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Saravanan Shanmugham <saravanan.shanmugham@cypress.com>,
        Justin Li <justin.li@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 1/2] brcmfmac: map 802.1d priority to precedence level based on AP WMM params
Date:   Tue,  5 May 2020 01:51:26 -0500
Message-Id: <1588661487-21884-2-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588661487-21884-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1588661487-21884-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 5 May 2020 06:51:42 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ec998fe-de57-439b-bdec-08d7f0c0c5db
X-MS-TrafficTypeDiagnostic: BYAPR06MB3816:|BYAPR06MB3816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB38160FBC6CA0F8A445474ACBBBA70@BYAPR06MB3816.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1gzVOV+Xof2EKjHcVFyJvAFnWce6ixQfyTl6jnnSJX47zK8dxl807zBQ14sgvvSWhZOPUAfvtOB2cmRf79eivP/0ru0Gje0504E8TMaQGVbJ8gakKHc1C2DZKoTdpY4E394kFtPJohaPfnwUp3HXGUybb2AAzTLR3Dhpw5mMNXVmyaxUgMrMBCq2kvuDVaDCW9JwobGOQSKEccHtWJN0E6ZO5kzDRP+IEGM+8FIZ1zqZzn+iRlL+/gjK1Fcwu/dSbNlREh6KgMoLNSrUvpV5WHPqlEI+C2+DY9ZtQO5vzPbdTOuip3NZzqCfa/nnPr8aGOhcrqGb6teXqWDh2ZlYCSVRDPEEiNUrHfK2pXPerDbKF4ySauvpTY0gomcTko6QJr5d+7wle3NEG1Cybg4MmYp+DW5psXpymSM8HXJ1boOraqFxle18GDPOSf8BSpqYrZ86TfTv83ZrJGlkVgD09/nILb90vB1ZlJyQDiHPSob0l99nssL2Z84iwW+56ppj8JROnBu4CSwZl/Gi9eCzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(33430700001)(956004)(6916009)(6666004)(66946007)(4326008)(30864003)(2906002)(86362001)(186003)(36756003)(26005)(66556008)(66476007)(8676002)(16526019)(5660300002)(6486002)(107886003)(316002)(478600001)(8936002)(7696005)(2616005)(52116002)(33440700001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6oCPywpa1jg3KsfKm/+9zNjnkwwtSltO8Mm/9XtkxJ5bHB2oq4RD3AhAG0a7gvJ7N4fElIKtPEOctgi99sv0AmyIwcAUnd5LajOPSI7d/OVGeReVpP5y/YXF19eoWlLt4dk4uqBzbg+u9BG57fzs20DldeGCTRIWUPsHkHN15XmYm70J/B3kDh7hf03R7EXlJvAOJWXiHh4uSRlOJSzZeXMtCUCbdtscNRPZ+6IYbtJP4HDK0JIEy+YFNvSmF0F/+Cr+/1QBbikkRt/q4q/zWmfORRKzRtQKFfrHQPd4F0P4DYCin1pJ++soHTMmC4OrFs9DLrKdfm8ig0Qx8BkZ30OvyVZMG2biRvEPQbT4aGYKtBqjmKu/K+jFkv9ggxhVxzcDRDKsoG3cHhS/7Ml9qrGBBpWwcOw8jJkj9d5SEDiPb1Gj58OYQpODWE5OelkbNvDaKfFNNNDjL7VxS6DkQtJJGlkqw4RmW/ptJGLV+MY7eiiDqDIE/OSHGd5Fd9aQa2SPQrkqah9tUcJ8HzNp0593nK25/TaDunn5kehxiVPbN73mhCHsdf+Fx0VZMkpX4y3eStIgSFeIPhzvIMBlNK+dzLBNvp8DkQLJH4zNaiZV+/uI3hWzsvEOupxxf4P0m3GXG19q8n9R6VmWYe/nO+aPoDCDo6Cuh8i+fJfmKNoDgD0lgmYvh0iLv7cPf9pYzGcz0zi31AxejETuWbG1lY2R0321LMrbWs2IjL7mOyHQJfHZAjnGoeAaKDgvX7yoGbKcswBaSfZhdSmu9CfEKCCoeE+jmpSaQeDkcCGJF78=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec998fe-de57-439b-bdec-08d7f0c0c5db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 06:51:44.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anvqyyh5yuc+k16xAwwi8QOyFTkq6SSlQOwrA22HbHtgd4HHivdYvewE3kKA4OSQueNsO9Rw6pGMKqLW1tPn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3816
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Saravanan Shanmugham <saravanan.shanmugham@cypress.com>

In WLAN, priority among various access categories of traffic is
always set by the AP using WMM parameters and this may not always
follow the standard 802.1d priority.

In this change, priority is adjusted based on the AP WMM params
received as part of the Assoc Response and the same is later used
to map the priority of all incoming traffic.

In a specific scenario where EDCA parameters are configured to be same
for all ACs, use the default FW priority definition to avoid queuing
packets of all ACs to the same priority queue.

This change fixes the following 802.11 certification tests:
* 11n - 5.2.31 ACM Bit Conformance test
* 11n - 5.2.32 AC Parameter Modification test
* 11ac - 5.2.33 TXOP Limit test

Signed-off-by: Saravanan Shanmugham <saravanan.shanmugham@cypress.com>
Signed-off-by: Justin Li <justin.li@cypress.com>
Signed-off-by: Madhan Mohan R <madhanmohan.r@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 152 +++++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |  24 ++++
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |   4 +
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         |  26 +---
 .../broadcom/brcm80211/brcmfmac/fwsignal.h         |  23 ++++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |  17 +--
 6 files changed, 213 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fa846471dac2..d5d4a36faf19 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -23,6 +23,7 @@
 #include "p2p.h"
 #include "btcoex.h"
 #include "pno.h"
+#include "fwsignal.h"
 #include "cfg80211.h"
 #include "feature.h"
 #include "fwil.h"
@@ -5566,12 +5567,151 @@ static void brcmf_clear_assoc_ies(struct brcmf_cfg80211_info *cfg)
 	conn_info->resp_ie_len = 0;
 }
 
+u8 brcmf_map_prio_to_prec(void *config, u8 prio)
+{
+	struct brcmf_cfg80211_info *cfg = (struct brcmf_cfg80211_info *)config;
+
+	if (!cfg)
+		return (prio == PRIO_8021D_NONE || prio == PRIO_8021D_BE) ?
+		       (prio ^ 2) : prio;
+
+	/* For those AC(s) with ACM flag set to 1, convert its 4-level priority
+	 * to an 8-level precedence which is the same as BE's
+	 */
+	if (prio > PRIO_8021D_EE &&
+	    cfg->ac_priority[prio] == cfg->ac_priority[PRIO_8021D_BE])
+		return cfg->ac_priority[prio] * 2;
+
+	/* Conversion of 4-level priority to 8-level precedence */
+	if (prio == PRIO_8021D_BE || prio == PRIO_8021D_BK ||
+	    prio == PRIO_8021D_CL || prio == PRIO_8021D_VO)
+		return cfg->ac_priority[prio] * 2;
+	else
+		return cfg->ac_priority[prio] * 2 + 1;
+}
+
+u8 brcmf_map_prio_to_aci(void *config, u8 prio)
+{
+	/* Prio here refers to the 802.1d priority in range of 0 to 7.
+	 * ACI here refers to the WLAN AC Index in range of 0 to 3.
+	 * This function will return ACI corresponding to input prio.
+	 */
+	struct brcmf_cfg80211_info *cfg = (struct brcmf_cfg80211_info *)config;
+
+	if (cfg)
+		return cfg->ac_priority[prio];
+
+	return prio;
+}
+
+static void brcmf_init_wmm_prio(u8 *priority)
+{
+	/* Initialize AC priority array to default
+	 * 802.1d priority as per following table:
+	 * 802.1d prio 0,3 maps to BE
+	 * 802.1d prio 1,2 maps to BK
+	 * 802.1d prio 4,5 maps to VI
+	 * 802.1d prio 6,7 maps to VO
+	 */
+	priority[0] = BRCMF_FWS_FIFO_AC_BE;
+	priority[3] = BRCMF_FWS_FIFO_AC_BE;
+	priority[1] = BRCMF_FWS_FIFO_AC_BK;
+	priority[2] = BRCMF_FWS_FIFO_AC_BK;
+	priority[4] = BRCMF_FWS_FIFO_AC_VI;
+	priority[5] = BRCMF_FWS_FIFO_AC_VI;
+	priority[6] = BRCMF_FWS_FIFO_AC_VO;
+	priority[7] = BRCMF_FWS_FIFO_AC_VO;
+}
+
+static void brcmf_wifi_prioritize_acparams(const
+	struct brcmf_cfg80211_edcf_acparam *acp, u8 *priority)
+{
+	u8 aci;
+	u8 aifsn;
+	u8 ecwmin;
+	u8 ecwmax;
+	u8 acm;
+	u8 ranking_basis[EDCF_AC_COUNT];
+	u8 aci_prio[EDCF_AC_COUNT]; /* AC_BE, AC_BK, AC_VI, AC_VO */
+	u8 index;
+
+	for (aci = 0; aci < EDCF_AC_COUNT; aci++, acp++) {
+		aifsn  = acp->ACI & EDCF_AIFSN_MASK;
+		acm = (acp->ACI & EDCF_ACM_MASK) ? 1 : 0;
+		ecwmin = acp->ECW & EDCF_ECWMIN_MASK;
+		ecwmax = (acp->ECW & EDCF_ECWMAX_MASK) >> EDCF_ECWMAX_SHIFT;
+		brcmf_dbg(CONN, "ACI %d aifsn %d acm %d ecwmin %d ecwmax %d\n",
+			  aci, aifsn, acm, ecwmin, ecwmax);
+		/* Default AC_VO will be the lowest ranking value */
+		ranking_basis[aci] = aifsn + ecwmin + ecwmax;
+		/* Initialise priority starting at 0 (AC_BE) */
+		aci_prio[aci] = 0;
+
+		/* If ACM is set, STA can't use this AC as per 802.11.
+		 * Change the ranking to BE
+		 */
+		if (aci != AC_BE && aci != AC_BK && acm == 1)
+			ranking_basis[aci] = ranking_basis[AC_BE];
+	}
+
+	/* Ranking method which works for AC priority
+	 * swapping when values for cwmin, cwmax and aifsn are varied
+	 * Compare each aci_prio against each other aci_prio
+	 */
+	for (aci = 0; aci < EDCF_AC_COUNT; aci++) {
+		for (index = 0; index < EDCF_AC_COUNT; index++) {
+			if (index != aci) {
+				/* Smaller ranking value has higher priority,
+				 * so increment priority for each ACI which has
+				 * a higher ranking value
+				 */
+				if (ranking_basis[aci] < ranking_basis[index])
+					aci_prio[aci]++;
+			}
+		}
+	}
+
+	/* By now, aci_prio[] will be in range of 0 to 3.
+	 * Use ACI prio to get the new priority value for
+	 * each 802.1d traffic type, in this range.
+	 */
+	if (!(aci_prio[AC_BE] == aci_prio[AC_BK] &&
+	      aci_prio[AC_BK] == aci_prio[AC_VI] &&
+	      aci_prio[AC_VI] == aci_prio[AC_VO])) {
+		/* 802.1d 0,3 maps to BE */
+		priority[0] = aci_prio[AC_BE];
+		priority[3] = aci_prio[AC_BE];
+
+		/* 802.1d 1,2 maps to BK */
+		priority[1] = aci_prio[AC_BK];
+		priority[2] = aci_prio[AC_BK];
+
+		/* 802.1d 4,5 maps to VO */
+		priority[4] = aci_prio[AC_VI];
+		priority[5] = aci_prio[AC_VI];
+
+		/* 802.1d 6,7 maps to VO */
+		priority[6] = aci_prio[AC_VO];
+		priority[7] = aci_prio[AC_VO];
+	} else {
+		/* Initialize to default priority */
+		brcmf_init_wmm_prio(priority);
+	}
+
+	brcmf_dbg(CONN, "Adj prio BE 0->%d, BK 1->%d, BK 2->%d, BE 3->%d\n",
+		  priority[0], priority[1], priority[2], priority[3]);
+
+	brcmf_dbg(CONN, "Adj prio VI 4->%d, VI 5->%d, VO 6->%d, VO 7->%d\n",
+		  priority[4], priority[5], priority[6], priority[7]);
+}
+
 static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 			       struct brcmf_if *ifp)
 {
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_cfg80211_assoc_ielen_le *assoc_info;
 	struct brcmf_cfg80211_connect_info *conn_info = cfg_to_conn(cfg);
+	struct brcmf_cfg80211_edcf_acparam edcf_acparam_info[EDCF_AC_COUNT];
 	u32 req_len;
 	u32 resp_len;
 	s32 err = 0;
@@ -5620,6 +5760,17 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 			    GFP_KERNEL);
 		if (!conn_info->resp_ie)
 			conn_info->resp_ie_len = 0;
+
+		err = brcmf_fil_iovar_data_get(ifp, "wme_ac_sta",
+					       edcf_acparam_info,
+					       sizeof(edcf_acparam_info));
+		if (err) {
+			brcmf_err("could not get wme_ac_sta (%d)\n", err);
+			return err;
+		}
+
+		brcmf_wifi_prioritize_acparams(edcf_acparam_info,
+					       cfg->ac_priority);
 	} else {
 		conn_info->resp_ie_len = 0;
 		conn_info->resp_ie = NULL;
@@ -6036,6 +6187,7 @@ static s32 wl_init_priv(struct brcmf_cfg80211_info *cfg)
 	mutex_init(&cfg->usr_sync);
 	brcmf_init_escan(cfg);
 	brcmf_init_conf(cfg->conf);
+	brcmf_init_wmm_prio(cfg->ac_priority);
 	init_completion(&cfg->vif_disabled);
 	return err;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 6ce48f6275a4..0b2fddc53189 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -23,6 +23,23 @@
 #define WL_ROAM_TRIGGER_LEVEL		-75
 #define WL_ROAM_DELTA			20
 
+/* WME Access Category Indices (ACIs) */
+#define AC_BE			0	/* Best Effort */
+#define AC_BK			1	/* Background */
+#define AC_VI			2	/* Video */
+#define AC_VO			3	/* Voice */
+#define EDCF_AC_COUNT		4
+#define MAX_8021D_PRIO		8
+
+#define EDCF_ACI_MASK			0x60
+#define EDCF_ACI_SHIFT			5
+#define EDCF_ACM_MASK                  0x10
+#define EDCF_ECWMIN_MASK		0x0f
+#define EDCF_ECWMAX_SHIFT		4
+#define EDCF_AIFSN_MASK			0x0f
+#define EDCF_AIFSN_MAX			15
+#define EDCF_ECWMAX_MASK		0xf0
+
 /* Keep BRCMF_ESCAN_BUF_SIZE below 64K (65536). Allocing over 64K can be
  * problematic on some systems and should be avoided.
  */
@@ -205,6 +222,12 @@ struct brcmf_cfg80211_assoc_ielen_le {
 	__le32 resp_len;
 };
 
+struct brcmf_cfg80211_edcf_acparam {
+	u8 ACI;
+	u8 ECW;
+	u16 TXOP;        /* stored in network order (ls octet first) */
+};
+
 /* dongle escan state */
 enum wl_escan_state {
 	WL_ESCAN_STATE_IDLE,
@@ -323,6 +346,7 @@ struct brcmf_cfg80211_info {
 	struct brcmf_assoclist_le assoclist;
 	struct brcmf_cfg80211_wowl wowl;
 	struct brcmf_pno_info *pno;
+	u8 ac_priority[MAX_8021D_PRIO];
 };
 
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 144cf4570bc3..8b5f49997c8b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -72,4 +72,8 @@ static inline void
 brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev) {}
 #endif
 
+u8 brcmf_map_prio_to_prec(void *cfg, u8 prio);
+
+u8 brcmf_map_prio_to_aci(void *cfg, u8 prio);
+
 #endif /* BRCMFMAC_COMMON_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 8cc52935fd41..e7a4ee6cb0ec 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -311,28 +311,6 @@ struct brcmf_skbuff_cb {
 /* How long to defer borrowing in jiffies */
 #define BRCMF_FWS_BORROW_DEFER_PERIOD		(HZ / 10)
 
-/**
- * enum brcmf_fws_fifo - fifo indices used by dongle firmware.
- *
- * @BRCMF_FWS_FIFO_FIRST: first fifo, ie. background.
- * @BRCMF_FWS_FIFO_AC_BK: fifo for background traffic.
- * @BRCMF_FWS_FIFO_AC_BE: fifo for best-effort traffic.
- * @BRCMF_FWS_FIFO_AC_VI: fifo for video traffic.
- * @BRCMF_FWS_FIFO_AC_VO: fifo for voice traffic.
- * @BRCMF_FWS_FIFO_BCMC: fifo for broadcast/multicast (AP only).
- * @BRCMF_FWS_FIFO_ATIM: fifo for ATIM (AP only).
- * @BRCMF_FWS_FIFO_COUNT: number of fifos.
- */
-enum brcmf_fws_fifo {
-	BRCMF_FWS_FIFO_FIRST,
-	BRCMF_FWS_FIFO_AC_BK = BRCMF_FWS_FIFO_FIRST,
-	BRCMF_FWS_FIFO_AC_BE,
-	BRCMF_FWS_FIFO_AC_VI,
-	BRCMF_FWS_FIFO_AC_VO,
-	BRCMF_FWS_FIFO_BCMC,
-	BRCMF_FWS_FIFO_ATIM,
-	BRCMF_FWS_FIFO_COUNT
-};
 
 /**
  * enum brcmf_fws_txstatus - txstatus flag values.
@@ -2130,8 +2108,10 @@ int brcmf_fws_process_skb(struct brcmf_if *ifp, struct sk_buff *skb)
 	skcb->if_flags = 0;
 	skcb->state = BRCMF_FWS_SKBSTATE_NEW;
 	brcmf_skb_if_flags_set_field(skb, INDEX, ifp->ifidx);
+
+	/* mapping from 802.1d priority to firmware fifo index */
 	if (!multicast)
-		fifo = brcmf_fws_prio2fifo[skb->priority];
+		fifo = brcmf_map_prio_to_aci(drvr->config, skb->priority);
 
 	brcmf_fws_lock(fws);
 	if (fifo != BRCMF_FWS_FIFO_AC_BE && fifo < BRCMF_FWS_FIFO_BCMC)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
index b486d578ec96..b16a9d1c0508 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
@@ -6,6 +6,29 @@
 #ifndef FWSIGNAL_H_
 #define FWSIGNAL_H_
 
+/**
+ * enum brcmf_fws_fifo - fifo indices used by dongle firmware.
+ *
+ * @BRCMF_FWS_FIFO_FIRST: first fifo, ie. background.
+ * @BRCMF_FWS_FIFO_AC_BK: fifo for background traffic.
+ * @BRCMF_FWS_FIFO_AC_BE: fifo for best-effort traffic.
+ * @BRCMF_FWS_FIFO_AC_VI: fifo for video traffic.
+ * @BRCMF_FWS_FIFO_AC_VO: fifo for voice traffic.
+ * @BRCMF_FWS_FIFO_BCMC: fifo for broadcast/multicast (AP only).
+ * @BRCMF_FWS_FIFO_ATIM: fifo for ATIM (AP only).
+ * @BRCMF_FWS_FIFO_COUNT: number of fifos.
+ */
+enum brcmf_fws_fifo {
+	BRCMF_FWS_FIFO_FIRST,
+	BRCMF_FWS_FIFO_AC_BK = BRCMF_FWS_FIFO_FIRST,
+	BRCMF_FWS_FIFO_AC_BE,
+	BRCMF_FWS_FIFO_AC_VI,
+	BRCMF_FWS_FIFO_AC_VO,
+	BRCMF_FWS_FIFO_BCMC,
+	BRCMF_FWS_FIFO_ATIM,
+	BRCMF_FWS_FIFO_COUNT
+};
+
 struct brcmf_fws_info *brcmf_fws_attach(struct brcmf_pub *drvr);
 void brcmf_fws_detach(struct brcmf_fws_info *fws);
 void brcmf_fws_debugfs_create(struct brcmf_pub *drvr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 3a08252f1a53..ce6f15284277 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -315,15 +315,6 @@ struct rte_console {
 #define MAX_KSO_ATTEMPTS (PMU_MAX_TRANSITION_DLY/KSO_WAIT_US)
 #define BRCMF_SDIO_MAX_ACCESS_ERRORS	5
 
-/*
- * Conversion of 802.1D priority to precedence level
- */
-static uint prio2prec(u32 prio)
-{
-	return (prio == PRIO_8021D_NONE || prio == PRIO_8021D_BE) ?
-	       (prio^2) : prio;
-}
-
 #ifdef DEBUG
 /* Device console log buffer state */
 struct brcmf_console {
@@ -2774,7 +2765,13 @@ static int brcmf_sdio_bus_txdata(struct device *dev, struct sk_buff *pkt)
 	skb_push(pkt, bus->tx_hdrlen);
 	/* precondition: IS_ALIGNED((unsigned long)(pkt->data), 2) */
 
-	prec = prio2prec((pkt->priority & PRIOMASK));
+	/* In WLAN, priority is always set by the AP using WMM parameters
+	 * and this need not always follow the standard 802.1d priority.
+	 * Based on AP WMM config, map from 802.1d priority to corresponding
+	 * precedence level.
+	 */
+	prec = brcmf_map_prio_to_prec(bus_if->drvr->config,
+				      (pkt->priority & PRIOMASK));
 
 	/* Check for existing queue, current flow-control,
 			 pending event, or pending clock */
-- 
2.1.0

