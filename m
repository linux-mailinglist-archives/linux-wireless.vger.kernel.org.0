Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D681C715A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEFNFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 09:05:39 -0400
Received: from mail-eopbgr680137.outbound.protection.outlook.com ([40.107.68.137]:26605
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbgEFNFi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 09:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQjmaiyBAG3Qug7M5QOI0R5mazBT5IIPKtkbsMwH9d6JTkDqA7HHiqbBv9u96HhlEj/RQz5XIX50n4dWQMfLU2yQrgzIdUQTfVtJbTHj25qpFI/kqyRfA1iThMeP979UzQvHpq+NwkYladsJhLV8aW3O+JGXN9FpfMUXeB/CE/Mt0MwEtrjEIfVdquztWTrFsDFRVpdCvUezyuG0ygHiWwpuu7og+sFq5zE+crjYuhrkpZ5SlP5X8PNZnGAM7Sp+eBPoeb53YvjACtY5vQfQV3hdr95L/PcT7aCRzB6E2UO07X371FGa8cex9E3n6a2NXmO3kpYx5VGZUK8CBSNBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z96Cth50p8Tpo9nxHeAjGqak31Jir1NAUfh6KqKjAA8=;
 b=l880Ct7TDjZWdJPerziFjR804Hu3JmmqIVxyylcN+khVYyoS3NGgnE6/nW4/KFR2wT5puVZdIhe78tIlOmzzUkUAu5qM44QJ4oe/UCr6BqRuiaVdvAxsmSYKG+FgBRgPrYiL40UYcUXrUh/6rzp/Ufvo4zwvIzwrpEPLu7KAwsNTL9t9c/amAn2DrdugxWqS74y2Sn74sLKTXJjyqKlyq1HWb++eNixSWaJ9RFTefaJGYJZ2Qm49oRaGa1FC/SPdAHJujeh/iCPcGUtELi3xls/FwUw6afSVzTdXPKIv/HqRVGhilhAKOKqXxzyE6ZU+u9zndW/xOSYGitZa9k2CTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z96Cth50p8Tpo9nxHeAjGqak31Jir1NAUfh6KqKjAA8=;
 b=n09gj0DwZlRxhC8yVPVe70kT7du3+RogY0UadfMl51V/sUU2PtEd5VYMngepXR3UjzKrLSfXRYBMMrlE/bc0wAltU62irtqHwfqURBk1aeUfq3kj6rozoLWZjpUPoTWFcsQqiEscuS+utlRnSkDDO8U5JtlU5dWLAftOoNSwx+s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB3994.namprd06.prod.outlook.com (2603:10b6:5:87::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Wed, 6 May 2020 13:05:36 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 13:05:36 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Ryohei Kondo <ryohei.kondo@cypress.com>
Subject: [PATCH 2/3] brcmfmac: use actframe_abort to cancel ongoing action frame
Date:   Wed,  6 May 2020 08:03:20 -0500
Message-Id: <1588770201-54361-3-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
References: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.18 via Frontend Transport; Wed, 6 May 2020 13:05:35 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f515b618-5b9b-4e4e-cd9b-08d7f1be2afe
X-MS-TrafficTypeDiagnostic: DM6PR06MB3994:|DM6PR06MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB39948DED9499E8E52C710311FBA40@DM6PR06MB3994.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIch+dCzvQVtx1RTidsA1u1pRuVtEEjr0RMsO+26fSGFv6qHzlqmyvF5SOwAi27TFmi4vYlPMlas4bbTRpmFfSaBx7IAtCByvBRzxKDFe2bIHJR2GjjYoC34m5V/mbpa9aAzOERw9fgeBUPmnTyvsfpqDqhn7+wZLuBbZWOnxjPeudes3zWjhPko1RssbrRJH3TiyF7ILsncOq2/VNw32YFyK13QFfZ8l7pMAZSBhCmw7kZ/f2MPgFY4HOY5HLFiiuSQ2LtAO9epnPFKj4gtG4kx6r7AsfcdzkoVDpf3VPhzNr9RxWJM+jriI4q+R3J2oU9k8IHGtlB53elA1Y2X5LKSHQZyenPrz9aJ0iG8KnuZNIcczW2/ea0ra3wEvMn4U7+JRcJPEZjykVvjZ3b+O09E9N1ePWxcKtB6pvvsx1V1b6F/0j+/3pUw9OrWixL/OAevJCKDfXQSkAf/026UXapaMAxFgoUcfeIWtzLl4UtOrbdQuU2PQ0SqYqHK31Yg9b3b8LU7PrZi+05pNF2rlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(33430700001)(86362001)(6666004)(107886003)(2906002)(33440700001)(52116002)(7696005)(4326008)(66476007)(5660300002)(54906003)(2616005)(66556008)(26005)(186003)(44832011)(66946007)(956004)(36756003)(6486002)(316002)(478600001)(8936002)(8676002)(16526019)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oslj67uewmQW9njFCURfCjxSMsb0tG973KGfSNyRRTWSUYUJmdie4I0pcmPebtKgHCFWzXKkba3KnhtNcKrwuSWC3G+sZ+iGMrxga+rvw4SDNFuIy1fn/5d2P6DgBVXsIXMT/EPLxlMmBehLcRMZlEHjq5RPLVs4G3tXukr+fevRLbCVktoDONvqfaYYprfFhp6EvvJv5z/YaOchcW8f+jLV+f3gi2nS9u7OBWwp9B942l0YVSTNC5PjVs9ulQHDOejADmVOM/jzMpMhhnpy8soDxGteKOkkLPQJQlFvSXpFa/NYbwKRjlADkEKL964g46uS9W6EZdEOs7cZTGkb5HQDgTYv63DNP7KnrT5JyCgaFMhFH8BHwCDJVL9tn8IePATjUKQHGDyL94WAB93k014qu0id1DUd8MP7g7uOLVH/rjjwI8SncZ9aNQtAyqZafJac0dvCB7KuMZ9LjFlwOiPx69XdW2ERQo/hUAUTnkfdYFsv9PCKmLfo0oVnYE4ntsbOGvQFiHHS4/AuiXHHyltmrcSWvEUadJMSLcDALY7eJF4bJR795qW9BA/xXYgCbNw4b9CyMynwKSxsMjnqEJdEaUaEzCjUisxUCXfX8k8s9bDZ/2SZ8k7zS3tK64ze73lZAz9isWMwElT/XsF1NdpEhi0mx7pM20dUK6c2rbPZm+G5q0PYHtEpabpXFJtH7vn1rbllvP7Ib6FRrEbjbkvv20/Ugk3dvcQSBLfAyLH3K8GR8Z3SctZ0XXfD79kjWngIvmnuh8fu7EO+D11TLSD24FeBykoPkAiORhTtgG0=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f515b618-5b9b-4e4e-cd9b-08d7f1be2afe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 13:05:36.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgBlJljo7uEEGkoTYtcWcjrfW/JMrAxxC8v6Z/5tf6CkvcC7FKltZPTlCuytjzh7KcE7gof+npFguYpv5wNpiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3994
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryohei Kondo <ryohei.kondo@cypress.com>

The driver sends an action frame down and waits for dwell time to be
completed or aborted before sending out the next action frame.
Driver issues "scan abort" to cancel the current time slot, but this
doesn't have any effect because, we are not using scan engine for
sending action frame.
Fix is to use "actframe_abort" to cancels the current action frame.

Signed-off-by: Ryohei Kondo <ryohei.kondo@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 34 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 1f5deea..7e43eea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1245,6 +1245,30 @@ bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
 }
 
 /**
+ * brcmf_p2p_abort_action_frame() - abort action frame.
+ *
+ * @cfg: common configuration struct.
+ *
+ */
+static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
+{
+	struct brcmf_p2p_info *p2p = &cfg->p2p;
+	struct brcmf_cfg80211_vif *vif;
+	s32 err;
+	s32 int_val = 1;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
+					sizeof(s32));
+	if (err)
+		brcmf_err(" aborting action frame has failed (%d)\n", err);
+
+	return err;
+}
+
+/**
  * brcmf_p2p_stop_wait_next_action_frame() - finish scan if af tx complete.
  *
  * @cfg: common configuration struct.
@@ -1255,6 +1279,7 @@ brcmf_p2p_stop_wait_next_action_frame(struct brcmf_cfg80211_info *cfg)
 {
 	struct brcmf_p2p_info *p2p = &cfg->p2p;
 	struct brcmf_if *ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
+	s32 err;
 
 	if (test_bit(BRCMF_P2P_STATUS_SENDING_ACT_FRAME, &p2p->status) &&
 	    (test_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status) ||
@@ -1263,8 +1288,13 @@ brcmf_p2p_stop_wait_next_action_frame(struct brcmf_cfg80211_info *cfg)
 		/* if channel is not zero, "actfame" uses off channel scan.
 		 * So abort scan for off channel completion.
 		 */
-		if (p2p->af_sent_channel)
-			brcmf_notify_escan_complete(cfg, ifp, true, true);
+		if (p2p->af_sent_channel) {
+			/* abort actframe using actframe_abort or abort scan */
+			err = brcmf_p2p_abort_action_frame(cfg);
+			if (err)
+				brcmf_notify_escan_complete(cfg, ifp, true,
+							    true);
+		}
 	} else if (test_bit(BRCMF_P2P_STATUS_WAITING_NEXT_AF_LISTEN,
 			    &p2p->status)) {
 		brcmf_dbg(TRACE, "*** Wake UP ** abort listen for next af frame\n");
-- 
2.1.0

