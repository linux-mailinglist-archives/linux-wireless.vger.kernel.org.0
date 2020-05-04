Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F851C3270
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEDGJF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 02:09:05 -0400
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:14944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgEDGJE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 02:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xye+bWFOpy8NqKz8al6n8nPHq40DLrhY/9y7EA/+Mk+j2tzGQu6RZG1m4HW+bjARpb22J/20gk7nE60QnFiQMozkYLpwQme2nR8J/v238Z+4L7vkxMDNxdKxLmeBLVXveT5xBT9c8zc9eDsgW4JIFi7wMv4s/iEPwFAfp5dal/N++mjCNO7vzf884jOp6FBobX2r/bVywXwLd0GM/qPmvFqquzI/zaVo8s4YhqpaNRTBiPK3Tqw9lqL3I43nGiFTUePvoRWJNu0moIc3M2sONYgCJSwwouJrQI4GyEiRYKyzEzldUBRnOrq9gQrXcbuo1nHeRET5yHVgWkonk1Y58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GiFcN081O8TeisS6Pvf2/6FQwnT59lHkvf9ezDC20w=;
 b=DyjC3Pfvmlf6WMbKgdVzUj6ge/cPpOC6hONCKUXtVwqCFLWCiPN/Mz0AaxCmAAozV4BN7IbmMMol+V8HPKl1+lj0chhL1CheCcRI4EZ/Dmby9nHwSPHcNBW7ciAKglNEGQ3hdyNgXnGAPxTpic9QQNi6XSOts4Pe0xiiyA9PRV1FC+t+sRAL0zmH8/T6OY9/UUex6W8K0cP2GGjiN/wxAtUzNa40I6NRXw+cKRRT/Gqq7JgDVuWZqSbNpti3UxkjiQd3qnzvCW0J4toxlbZDH3ORFZ04IJVTrhs7RkUW8js3acbb567qFIDBYqm0kG4z92gMe+sZObUrXKAuaX9lpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GiFcN081O8TeisS6Pvf2/6FQwnT59lHkvf9ezDC20w=;
 b=AUxDXONPQ1CuWO52xKDXkLrG+SUM08xIY1qBeGOcCjo2Wz0S8XHNOLx87Cbhz77/c6we6zUnI/nquNxElQz/yTBXKMJofHyY1RPo1fzImRl1cxmh3dIx6XTy2VLDKjBrnuoaydfY1/4Ohs9m6cc87q+ZCORhugkACfR+1XtS74Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4283.namprd06.prod.outlook.com (2603:10b6:5:1e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Mon, 4 May 2020 06:09:02 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7%7]) with mapi id 15.20.2958.027; Mon, 4 May 2020
 06:09:02 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Joseph Chuang <joseph.chuang@cypress.com>
Subject: [PATCH 2/3] brcmfmac: Fix P2P Group Formation failure via Go-neg method
Date:   Mon,  4 May 2020 01:07:32 -0500
Message-Id: <1588572453-194663-3-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
References: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 06:09:01 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27ece04a-db1d-4cb3-8784-08d7eff1a453
X-MS-TrafficTypeDiagnostic: DM6PR06MB4283:|DM6PR06MB4283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4283DC11880CF198E978F3DEFBA60@DM6PR06MB4283.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zN6f0lsYFdifn+gUPDM9xO15sm2PpdkM1532PhYnPsqUreijiBB47ZSWwJpKtFs2WEyXhxVtbfODRsrEZoMeGz5JNBIoukFesEKDOKuoqoJjV6np04MDlsl55m4z9AtL6HvRs7Z9iWnMYfT97ccv2L237LXdCXkVwoAbUcyDEJhteWadC1sQc7Iq6cQ9rYWa2R56VpusbyxaxzSrE6LXhofc3nVkH4Euf37s4BPUg+V1lxVX8krkLDrOY58x+DwpIa3oTNdqnpTLIYy9ZgSdUPuf50xeeTmlnwCYhqqs7CXwh/17wQvChMLhyBElI67dh4nOvdePwai1g4FaOWI+/ewSlWEL0/Ls9QsK0xiaK3EuO2TLNNlLjspF+l3RjGCsaSpoQe56XWAsF8zevc0eDY5WfbVGGK4crTJSZKPn7JPU2H5s1kiRioST76USvsXa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(66946007)(66556008)(16526019)(186003)(66476007)(2906002)(26005)(44832011)(7696005)(36756003)(86362001)(52116002)(2616005)(107886003)(956004)(6636002)(8676002)(5660300002)(8936002)(6486002)(316002)(4326008)(54906003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VCyiKLjMCJmnGibjbKkfiBREdkXSWXU+AKb0gtu05jLuoTjS4rT5hI2mVO95pmPdguRfj3jwD54MHhroZVox0Ceqv963WEbVO/ruHrN87aX7ueUgh4Md+9ApjJV2YKbL5W3jtvnSflFiM6Xgltl1LiYEF3mNsg4bAvdiycRjQVaP0zU66jm53i0Rlbsu7t4j4AA3//XKTHspwpK12DIxVhTcthZV1gT6XoV0wZZg5A0+QhZxTU1yJVKYKmE5tClitnJ8cDyLPtB9bPD2CGpJoTKBuMkFPx8oDBciN6F5zfZYoPxgWTWBdKenyQq3eFE2vefkJ0lHLdXUlYuPHE9FQOhLex2Tug222HhNSW4BecPCmiyZhUuAZ6hb8DLxngn+9IEZceWvA2cwvWFIhcvNkIzyZ34VosYm3k+trcl0OReZ9+avBs+Jv0DM0JEa2aFGxv24puopvQYOXOwQwuNExe3oqgHkZVJHuYII6ydbLyqvMku4++vi10TUVmapwWp+xpe4b94jqub/JNoHqF0CyyRwNDG3uo9XYpq2zeDS/j2XOadycj2vBm94qnhc+0aTrHnWexySHw5IIV7WlYsphbkbSAh+t3YIS2H4nyuWmhbg/JgTHntEZ5GmdURm+CzlVf2vNq5FEowch8JlgM9Pdnip/IyYeSx7f/ydOYj5FhRTCc1X8aWsFp/mLMb5Cwq99icxFxju8+laE09TeLYrl1bG9CBw/FplMdkawm26aBqYitey1th5a6VDO82sQmDy4cYzBm6xV/P/u8KudoX2DfSybgUDwbJAtMjn6DHcQrs=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ece04a-db1d-4cb3-8784-08d7eff1a453
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 06:09:02.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yca/X7DUP7xyklr2CRwsebgcskQOBzltgZndrqb6vWChWSdEwNqywDQfB+C3kt7lk+Ggk6qCTLwmigOltiLreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4283
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Joseph Chuang <joseph.chuang@cypress.com>

P2P group formation fails since either peer is not able to send go-neg
confirm or dut is not able to send go-neg response. To fix this, retry
limit should be increased and dwell time check should be added.

Signed-off-by: Joseph Chuang <joseph.chuang@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 521b507..cb8e229 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -60,7 +60,7 @@
 #define P2P_AF_MIN_DWELL_TIME		100
 #define P2P_AF_MED_DWELL_TIME		400
 #define P2P_AF_LONG_DWELL_TIME		1000
-#define P2P_AF_TX_MAX_RETRY		1
+#define P2P_AF_TX_MAX_RETRY		5
 #define P2P_AF_MAX_WAIT_TIME		msecs_to_jiffies(2000)
 #define P2P_INVALID_CHANNEL		-1
 #define P2P_CHANNEL_SYNC_RETRY		5
@@ -93,6 +93,9 @@
 #define P2PSD_ACTION_ID_GAS_CRESP	0x0d	/* GAS Comback Response AF */
 
 #define BRCMF_P2P_DISABLE_TIMEOUT	msecs_to_jiffies(500)
+
+/* Mask for retry counter of custom dwell time */
+#define CUSTOM_RETRY_MASK 0xff000000
 /**
  * struct brcmf_p2p_disc_st_le - set discovery state in firmware.
  *
@@ -1645,6 +1648,17 @@ static s32 brcmf_p2p_pub_af_tx(struct brcmf_cfg80211_info *cfg,
 	return err;
 }
 
+static bool brcmf_p2p_check_dwell_overflow(s32 requested_dwell,
+					   unsigned long dwell_jiffies)
+{
+	if ((requested_dwell & CUSTOM_RETRY_MASK) &&
+	    (jiffies_to_msecs(jiffies - dwell_jiffies) >
+	    (requested_dwell & ~CUSTOM_RETRY_MASK))) {
+		brcmf_err("Action frame TX retry time over dwell time!\n");
+		return true;
+	}
+	return false;
+}
 /**
  * brcmf_p2p_send_action_frame() - send action frame .
  *
@@ -1669,6 +1683,10 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	s32 tx_retry;
 	s32 extra_listen_time;
 	uint delta_ms;
+	unsigned long dwell_jiffies = 0;
+	bool dwell_overflow = false;
+
+	s32 requested_dwell = af_params->dwell_time;
 
 	action_frame = &af_params->action_frame;
 	action_frame_len = le16_to_cpu(action_frame->len);
@@ -1780,12 +1798,18 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 		/* update channel */
 		af_params->channel = cpu_to_le32(afx_hdl->peer_chan);
 	}
+	dwell_jiffies = jiffies;
+	dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
+							dwell_jiffies);
 
 	tx_retry = 0;
 	while (!p2p->block_gon_req_tx &&
-	       (ack == false) && (tx_retry < P2P_AF_TX_MAX_RETRY)) {
+	       (!ack) && (tx_retry < P2P_AF_TX_MAX_RETRY) &&
+		!dwell_overflow) {
 		ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
 		tx_retry++;
+		dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
+								dwell_jiffies);
 	}
 	if (ack == false) {
 		bphy_err(drvr, "Failed to send Action Frame(retry %d)\n",
-- 
2.1.0

