Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F141F57A3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgFJPVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:33 -0400
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:36321
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730106AbgFJPVb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvHibWaTyDtC/nmqdZKqcCyr+7aCNmaxm17H3TTNJocRkJsD7fz3QbsZufQl1joXUqiKarvxBv1LIG1r4biY0XUgyho9xSS1rlmg5ayvyj13AnFY6WRO8Mx1+Di6nLlF1dl8T0u/kAD7vjsRF2rqFooyDloSZwSzuQXzn+VSK7ajtJIoP+ZScAdvVateIRsCzdzNhyfNdFIQ6x0Le0FZwLUPJ4oNtqtgXt6xcwdareiNeY0+cU2bQGCRsgzLucAgL5CXERC9VboUiHnKcrLXSiN552bsJoXkXPXTwbX3Wn+H7bS0ZIlGmN/5MXHFpp51bKDAVYtxkpXXH4YGDlGa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnGTJGIUbPjb/3tbGz/NsAiSFlHk0P+ln5+n0bI1Z4o=;
 b=LpYtMP6zfiVKpnVu/LvlSpsayVezztocf60xLENPf1zjk2UTLKw6zl8UzCsZ8vIykYBrZkouDdvp/UrPnaajA1I0EK3bZ4fiXTtK96KifIaYJMMqnvHNB+TiJr9tF3f2I9xX8c9qjI/YPuFIF943Rq5BFjnWD643NW3HxfWjXV5ys2bAEajVDlB9KRzK6BkBEQcfiEANTQYdzpD5QCdw8jQLBSfzXN80lXsH+SviJ9t+HlTOQeaTm6axwJDdAW0AWdXnI2UurCVQXvFiftCMC0bbvfmhitSil+3lOdhXV1xHNtKU8D88Livv8/2HdsuD6TUqb8VFDK0hzI+NghPsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnGTJGIUbPjb/3tbGz/NsAiSFlHk0P+ln5+n0bI1Z4o=;
 b=FQIRWB6OK0MwwR0XVZNZkCZP86iniuB/K6byn7ThkGdhEUtn+UjqU6QQAqj/2n3VPi9h6DE/0lQh2BGh52d6PtRD+AWgKcz7MBbW2dZg6OtLqIRKwafuzX4Nzr0emKgm4mb3rKCPFdkr3JHf4yMqEatGjGkAYBLynvyIRdo7BI0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB3912.namprd06.prod.outlook.com (2603:10b6:a02:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 15:21:29 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:29 +0000
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
Subject: [PATCH V2 6/6] brcmfmac: initialize the requested dwell time
Date:   Wed, 10 Jun 2020 10:21:06 -0500
Message-Id: <20200610152106.175257-7-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:27 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4eadc90d-3c77-4e10-f1e9-08d80d51f263
X-MS-TrafficTypeDiagnostic: BYAPR06MB3912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB39122AB9D9DAADDD7F440C5BBB830@BYAPR06MB3912.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3bFChFrmjecpL3PlsajNcJBho030E8W2T6GV0lSJNBnso2A1EjPX3sAUBXQvde1/Zv1GOLqOSvmVyWy7FcqWmUx37qv6MpJNdwQqwPoDJwYfrI33KsKKSr9/Qxp19r+bav907l5N4HhthChS39we+28syUrGU4+yq6vWtELcz0tLUbQlngrb06FObJcHRb3wPCtPEk9P7+8GmmLSvxlAgkE1I4WM1gete1o8SHR1KVgzecoMZaBQkDt44QgUQ8hOJd+2lANTp49k5sNRYmpanMhry6cCbUTaH+VwF3CS7ZpaxxgzOIDv9bCJObKtLQO8W1i5U7ed5bDHvPSFiTqQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(6666004)(4326008)(52116002)(316002)(478600001)(1076003)(7696005)(86362001)(83380400001)(54906003)(6916009)(107886003)(186003)(5660300002)(956004)(2906002)(36756003)(26005)(8676002)(66476007)(6486002)(8936002)(66556008)(2616005)(66946007)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1OncAySsqHrtrkKfqUFr+58ScBXeAKy/gbmwtjx0wWmXsXOqbFF54H9sxi8lNFbyBC/eoEOpZsNG/g5u3yqsuVIViHdaPNAXbIktwpyEkfKyWlBf/gWivTZMinTczB9x2rSEFxn0u8VKHFxmeSIX9vwGjUz2elHE6E3YGwoSuidQEdTFDxeR5Rzd+PpnhhTYbxGZrckzkSy9ku/oYGfUJqqUBAFNtllD7AVe5VDFnzLLce3oPxGPxoBE80uAGSpORhPY4D5K6PJXMgQiF8cZRcp1HHDILVXbqlVcaI3dh8MljlD9ycsVpL0CZjBkdYiVRe34nCnYW4TusFzzTzk7TYbkyzvO9s27Um7Rzm4AxdHg+oKN8iIZCh0wmp9QYsCTw9XZGu6SoIe80O16WwLm1sY4sMJQ3KtUHAxFmZ6JTTPzotYsbttzPRdOR3z1em/WojQmbGBAr0excCwcvDFg0dq9l6J5WFlWVL6oYHJ+h2wBZQ0kB+yiO43+ReJ6IqhT
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eadc90d-3c77-4e10-f1e9-08d80d51f263
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:28.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxCENsRbEi7werv5Uys/+aqYVZvlxeG6Zgi/SmgtLWWDFOkCT/IgL5reL5AIfYi0kNNwys8EA+BK5YW9FS4lTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3912
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

