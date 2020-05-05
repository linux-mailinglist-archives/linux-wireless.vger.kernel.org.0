Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2481C4E81
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 08:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEEGvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 02:51:52 -0400
Received: from mail-mw2nam10on2139.outbound.protection.outlook.com ([40.107.94.139]:29921
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgEEGvv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 02:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvlB42u/HG8YLbfB92e73+nO0AHkgqgbiLcxaTsYJo8ynGH1Q8KkKG6x/H1hFR+cpYuKsEGI65A5jQNERcMEsh8p0iV8DcBvOJH2b01Cy8b39M0mfQkBkz5F0pF96wQjT2h+YfgbnL0vDLUFuTLzzfZK8RacP8GBbZtcZFZPcoFLfpV8V4AoMootS4mvhiy5MBv/nwSzi/EN218Fa5BAf2uvhn3Zz8X4gHaxbPYPMhpe7ss/bIjZd+FzVIIegKdCV15Guy+kgC5bCXmQqVk3C9KfPYN9J06C/9vQ8fbTKb13AqG6TOXiyBx9SA5hyEPfEcQbPgaRHABkxfS72tk9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/15187h7vG1UAZc7aiQtrJ9ryaYLrfpdxj7+Lolej+s=;
 b=KYX/a1u+iGuheRgtl+/OCzrgCWjB7EA6oHG7uTmeQVqlcJGVxXyelzp4aTi6J7xgloQz2Bz7o/s7RHXnyoRmAxlzbZwJnJXpmRFersJTvsw1vfgSdDG10uKy2wQpFHSNQctSta4AU8VM1n/UxLExv1Pn/81H4A3EUsqAebocwc7t0cRipvvUA0KAMxzvNXRnlrPdvXQZuy2/sfPb1/ea8C3MB/MESNpUsjcjfFzLNXQlsCuUg3Q1vuw8pWrF+3kq4FCyGoxs4PbJPdAYXCOkcOA9RO0GN4mjs7tNL6PMurrtgk7m2S9HFmec37dr4gToxoWubfRyKczwJvwqXG/zgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/15187h7vG1UAZc7aiQtrJ9ryaYLrfpdxj7+Lolej+s=;
 b=D8SevjBO6UaJCOhkJzAJK1ceEGqz5mBWFlmJaHdEzV/HLvwHot1VvnLc0pXXKMhRtwwdnAVc5cxa4B1i/q5LnZAOBMgA351BP5J0ccdavADkWIgto6XJ19JPHvTlQl2amcjisePVFSJtDXzmKMx4hhQFt/UkgipBdz7Vj6r82Gg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB3816.namprd06.prod.outlook.com (2603:10b6:a02:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 06:51:46 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 06:51:46 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Pramod Prakash <pramod.prakash@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 2/2] brcmfmac: fix 802.1d priority to ac mapping for pcie dongles
Date:   Tue,  5 May 2020 01:51:27 -0500
Message-Id: <1588661487-21884-3-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588661487-21884-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1588661487-21884-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 5 May 2020 06:51:44 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9637419a-d061-4598-e6a5-08d7f0c0c6fa
X-MS-TrafficTypeDiagnostic: BYAPR06MB3816:|BYAPR06MB3816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB38163BFDE648AD3F49DD5BDABBA70@BYAPR06MB3816.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: at/55+fCCLYL2WP37tlW9k40c0Dimvg0w+c0JYOekBll4jiLxg6wFlMl1tQUP7c/7M8fEOyCLnmQPa9JRlX8KWcLJ/TxfjXizHLvc+8RbkKYfWP7rwRiT/OkACZYrZ7omU7bbxmC2iDy2MQsYqtdZXMzAtvfI7G/nfJi+clt/lzZ+zr5/QIKle5mFnRrC0XY8MYLvYdN9mtyOp0g5iFT0zgvDTQUABl1QtWTRvlSiZ/JpE8s8mVG+mV/lACDJFeuGS0I4+9lR4gr7u6CEvDuJARqXf7xI975VbBVwlHNyoRkMyozfXdggLxA7dVtPMt5BJN7AdnxaVdsmn8FKTESyOtErS056vZH07HmV7TcIFOELf4lZL+207BYM4NCu5Bh9LDbIdjhqCvy04PNIzV7I1LecOGqOIwC85ArUZ+tZOJ3/AG2qzikvWq8I10mcj6XOiV+c0LW9kqP1Ge7fl8oi1+wCYaopmA4m/arBRp+0o5uXJuu3jcQJ2g+OLiLxHCntw357u3zNjgDZYQw7bBLjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(33430700001)(956004)(6916009)(6666004)(66946007)(4326008)(2906002)(86362001)(186003)(36756003)(26005)(4744005)(66556008)(66476007)(8676002)(16526019)(5660300002)(6486002)(107886003)(316002)(478600001)(8936002)(7696005)(2616005)(52116002)(33440700001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cPRTojjQWrnQYxA9vK9Puu+/3VhPEOuy8woafp1ryn+PBPdm1KR8u8VdfLMUKzVpc6pXTencl6qsrQGqTDFdWGE+k5fdP0bQJta9zqVgp9qeZaAuuwpVnAhpdgAWW7a6ZZwHXEcLRvM6WSAG81AOzz9YfcEfvhpJZunoNNDfCW1JcT8AQ2Wr4swGB183jBk19XnjWcUoHMcqOFNlkaouhKZk/IsOnwaHo+qA/8ciO4sw3Kk/vhdjb5Pd0BhZzD2TTwss7iYWhtmu7ATRylDtLfoNeKOrTtT+7ZTNsf6ERgAS+vN+Fg1cbhgBb1BQuPGh2RmtwcQ72rGao+PHJl1/hsGQg1Gi6Um9KDn1mOM1B/jn3TJyJh48w+sI4vCPDnBZ1bKB24E7cz5K5f4+wLszoP7Jc6MZqvLUANtYux9vkRNAWMu5GTU/CEUhrJqa5fCxRx9KGEo6aY4q4S3jKWpD++Xh0ScIC4NpZYtZdvtGOo2KADIqz0fZpFmvbR7OwNP48z8tDncX+mlzKZjVPqKXkDbfNC7qyUjpdPqy19XkoPuw8X00/1KdVcIxhCHXwD7XEI/uYuUkRX4CQo735fESpLjw7oFySbfvRqQRiuVM7dq8c9AeaEvTz0Pz5ryOpF/g46yR4G1JzQXedhx49ehQY+DkprBT+x1N+Wq9hj4veI6ULf2C4zSVR8zV/aMSOQ9FXLb9Wa4UNLz7cj06X+PSp/EEpei+16J6zKAipFWtHJDbEa2aD9oGdi+++BTG3lCE/bFJuw/J5QSUXux3NholIJpHPM9snLEKiUGDJznu+p4=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9637419a-d061-4598-e6a5-08d7f0c0c6fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 06:51:46.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xd20lfA4J5i+HKMsZDdNpVshCVmMD5jC2x1rR0Rpv8GtCEW0z1TsrAZurEv3Gs52CsDFgKLulswAgW3P67R+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3816
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pramod Prakash <pramod.prakash@cypress.com>

802.1d defines 0,3 for BE and 1,2 for BK. In pcie dongles, 0 & 3 are
mapped to 0 and 1,2 are mapped to 1. This change corrects this mapping,
so that BE & BK are given access precedence accordingly by pcie dongles.

Signed-off-by: Pramod Prakash <pramod.prakash@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
index 8e9d067bdfed..096f6b969dd8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
@@ -26,10 +26,10 @@
 #define BRCMF_FLOWRING_HASH_STA(fifo, ifidx) (fifo + ifidx * 16)
 
 static const u8 brcmf_flowring_prio2fifo[] = {
-	1,
-	0,
 	0,
 	1,
+	1,
+	0,
 	2,
 	2,
 	3,
-- 
2.1.0

