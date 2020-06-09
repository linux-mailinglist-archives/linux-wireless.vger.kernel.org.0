Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0951F38DF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgFIK7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:48 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgFIK7r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8UfpPll2iQaeEyXRJluGQsYb0E9vvNUOMQE92djcDLk6WByusZXtyeJ9xcRcFrLfDcPW33pPcOpr+ozl9OWmqf3bD1g7DRQyTn5HwV7y53W+6fzYH7H47g7+K6FVWM+SCDkOblUxqj4Oe0khOT9ad/J4dGN7K8EnpkZxlEK9x9xkVaLhIYdsisR7wjVvb6btp3OHhqYvNelKbD/exvvUuxPOhCJDxU37vmrZ32c8qafZdHKA59b0oZj5UX3epppY2k/d1xm21j3INmR+HD4Cw2wcvPczdmUwjgmgVomJeY7DPRi3ksVCZGoECyA/P3w/6g7G75sOFn/EPPw6U8EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnGTJGIUbPjb/3tbGz/NsAiSFlHk0P+ln5+n0bI1Z4o=;
 b=h97ds22DjvqfM4FgHLDFR6NAtY/fCHzrVpidpAJ27LjdSM9ECmxsAH8QCN93wexZBvbY7kdrtQo60hifFJC7u0GJpU5CV5L+vqXIqVqn9t+OgUWSO1H3vPIMGDgKbB4aZ1dGtI3kLRM/HlWQFV7zLg8iYcDxqhl27iT+XomXejcFBYKffNpk2tweQ7qkRMvDSBhz7C/pcM+ERZMH9MNrCjZXBjKabLnzTZcQ2LsMkbBiyQUVPfDjis4T2pobX49G0rcICg3oDTdFLyTW+epzcw9CndrM11hbYmVjsqvmAaoENXX6ZHcdDlVG0KdGFa/Ch0fVcXQbycEZZqHZoosQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnGTJGIUbPjb/3tbGz/NsAiSFlHk0P+ln5+n0bI1Z4o=;
 b=P3u5jTNJ92SClilowQrDqW6+ugo10El2baKstMktMJZUxFAVw/SzxYgqbPaaN3zhGuSvJA6d4wL/QRRWJwUyfoS0/1aPpEys2VAqPRb0fct+uDjFgEbB+KMlVWDmCppTX9bo+qP0XzFow1mBBuDM3iDzxss0wW0jkYNosY3YxQI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:37 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:37 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Joseph Chuang <joseph.chuang@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 6/6] brcmfmac: initialize the requested dwell time
Date:   Tue,  9 Jun 2020 05:59:13 -0500
Message-Id: <20200609105913.163239-7-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:35 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b778b7b-7d3d-478b-050e-08d80c643334
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5064E3D735C87543A8518773BB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzv+4IKNUc/You4LQdepRiz1dakjzjmMzWRRVrT1CeTOEmK56KMW62c1erOoOArb+WQxfL6x8phnerLfaWquRU1mQL+A9DNa+qTvAMg4H1ks1lZdi9lx/mR2WX3h9NCFJgZBR7y1SDlDYzKYpreD+Xq9VecZjalY/lyrMYsEKb3XoiV2fCHWj/C2sAiE1n0oSNg94AcpmE8sJY6+kT3zRszCX7Vp0rDutci/9MbwIRLz6WG2mpwy6G23Ph8WwyiRTLzoT5zTXPYv54w+aDo02j/6xUUQ5WAbhnnXmlvg0cWvYdKRnXE3GDm/rmNUw75RIa7ElegDJCYv0gyDmZLP+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /9qkeiWsMZPTeyRzgFmb/yoY4GCnagartyKu5uHtCGU4pkAENRguKXMGfefdJDE1pJXDOzTu8YmTQuLYtMqw0j5HM87w4I2NK3Z38KvLmqIQFCcc1YwLEHkol8DQG/8gBzOasIJfHgIcAutY7LnMXYu6yyaZwS1frjDcRmPYxAadcTe0HvLxSRaYOXtBsqyxPT02ONy+kea7hw3K/9P/qMwG80FsANFBRimroNj/j8JrB+rLCd2NyvsCQvawSbutj1VzagcQmcskC7v1Xg7Zf87vcRJ10QaDAn19C7MrI2sXzUnFV7aXUXUcdE8Y2bdelBFBh9Qlu/MmAM2CmgmnlDis/P2cD5kCO5yCQFq9XFC+EkmHpjYP3qjGzBpoH23UTtgu5OWbVdMXensgI+WO+6caX5zTkwDMgIeiJPddY4k6bF8qVCH+htxQSnC/vqpd1I4yerR4R1oMad+YDi4KhugSCUGwZdxt0oOO56Pj2ixv2jbwLMeaz8Z4v77r61id
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b778b7b-7d3d-478b-050e-08d80c643334
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:37.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8IP7dg04Whp+RVdBlLBoc7AuUZUN89r/TZL6pT0DIKib3mUHIqm6/Wna5+8p2X9bNk69sMZmjVhn5LAnWJzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Joseph Chuang <joseph.chuang@cypress.com>

Commit 9c29da3f4e7e
("brcmfmac: Fix P2P Group Formation failure via Go-neg method") did not
initialize requested_dwell properly, resulting in an always-false dwell
time overflow check. Fix it by setting the correct requested_dwell
value.

Fixes: 4905432b28b7 ("brcmfmac: Fix P2P Group Formation failure via Go-neg method")
Signed-off-by: Joseph Chuang <joseph.chuang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a757abd7a599..bddd23240609 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5129,7 +5129,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 					      &freq);
 		chan_nr = ieee80211_frequency_to_channel(freq);
 		af_params->channel = cpu_to_le32(chan_nr);
-
+		af_params->dwell_time = cpu_to_le32(params->wait);
 		memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
 		       le16_to_cpu(action_frame->len));
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index d2795dc17c46..debd887e159e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1700,7 +1700,7 @@ static s32 brcmf_p2p_pub_af_tx(struct brcmf_cfg80211_info *cfg,
 	return err;
 }
 
-static bool brcmf_p2p_check_dwell_overflow(s32 requested_dwell,
+static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
 					   unsigned long dwell_jiffies)
 {
 	if ((requested_dwell & CUSTOM_RETRY_MASK) &&
@@ -1738,8 +1738,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	unsigned long dwell_jiffies = 0;
 	bool dwell_overflow = false;
 
-	s32 requested_dwell = af_params->dwell_time;
-
+	u32 requested_dwell = le32_to_cpu(af_params->dwell_time);
 	action_frame = &af_params->action_frame;
 	action_frame_len = le16_to_cpu(action_frame->len);
 
-- 
2.25.0

