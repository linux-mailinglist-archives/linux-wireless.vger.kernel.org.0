Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B931F38DE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgFIK7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:45 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbgFIK7m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5b0/JS+mJM/HnHQP06YAoVus+3EfJFB8/41d40swZBIy7XpEpfmA3oocDt/qF7AuOFr7gbh6+FxICsc91wjjz0OuIY+DiSvShv20GOAPCnLwhiyppCb9ll2/Zv+72vI2Yd29VxLdECpwdvIvNNae7ECUhifvKFY5E2MkBsmdXhYAraQPCDw6dzys7A7D17Eq2ICJcGFAlzElslsl+Ugp88GAUnIAA3lMWl7cV28qQD9rasoYWbq/GOnQudsxrysVhvpv6L1e07IF40x+wGCbhCwiJZHjkJ5hGtwQmPQ+AUCuzxB/WHCtaWuOkxflzhuGHmuxO9tYBDo1b+LVSQxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2PRGbJjvoky2oUijMQwOLo+jmU0gf3d4kuO80Uz1uI=;
 b=HkbDCxCNHifCbGYSNI0oP/LKRgfqIJHOBgZH/FDuEgciYGLT3sgsUVR0WZnb8CM9zKoiJptvjPvoxcRghZB4yWEKwHh0TVY9Vz1jn7hp+Hz4AVZlxWVoRKwhGiH+W4Sq9YbrATYmdxzszjHjsoqfrHVV+d7yzQJqYuoL0/int+5z34Ic69ETywE4Jcn3xH6c+kTPzFwQWI50H4GZDNLOOTfYJT82+DsrK2PIq2TGY/jguX8Byu4ZRX8Fn2coNHdPNxlcK1aG7SrVeeVIdN7PFfcFEu9i4DqwYnoRze0EQq5lPfDgVUEb1S2QRPvmfPZQB7GxLhdDBmvS436vplOlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2PRGbJjvoky2oUijMQwOLo+jmU0gf3d4kuO80Uz1uI=;
 b=Hr7RK8QFPHnOodYr/V7Bn/Ta3T74HOX0qMAU1DaQcYQAiIjYzS54azOfvIrXxIJ23t9CfRgIyk0aRyGjI/uOBOpR9D9UhE8EuEaUh+TamY599h7SdeOhoFyF7GquslY7TeNAjslTVjlBoH0hOgAw/y/zoqkr6C/P0RmIO/SiFD8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:35 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:35 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 5/6] brcmfmac: fix throughput zero stalls on PM 1 mode due to credit map
Date:   Tue,  9 Jun 2020 05:59:12 -0500
Message-Id: <20200609105913.163239-6-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:32 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05d736d2-2818-49d5-7aaf-08d80c6431a2
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5064E9ACF58375E0DBE55B1BBB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytKX4RWqSqL5GExdi63G4e3z+guKXVjsWYT8fya0Ier+LepVoL9zYJmxk5L2qyT6yx+4lkWfPpx99f8NPrWXyYy2zgvhTLxCLITwTKXhew0lbApim70xxeobPGAcsoH5EDSYXp2jomWpxJxRql3K65JE34QB/Dcm1Co4+ICRy/7gB9bhMbH41nfIH5frPkGWImGQCajigB/6SUEcNgSSUXslYJJfz3/kkWwb1PW6v5UIlecKuySprJnqqNWJZzb9xf1DQtu79a2RuIIgsN0KAQTSZPAsIsjM+beUk9TsE0l9ADiFKP8wkIOlhj/5FlxbBQOoqhBZ4GvMdXdUYStpgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gIlOTzOkrg8hXwl6CwLW7pQ6lZEugxut9M2Y2sFo91oqg8kKq7siXIFtcCXKh71Z3OIiPJaqUNxNReR4nhX6tBUgqUorT1WEGFKATN/35oMDs87zFw4veIi6qOlO2mMirRe1KVoRa0DepvBdFTDRlLQSu8X+2tzXuLXlqbGSI8B23QD31uf1ytMS6KkvzanPnf+pAO6u0Ef2UDnJojNE08Lx0cFgAASlOj0wtys1gQhmqC917c72BxlUyfxftrnOXnx2EugDeDh41UFIsovI8RAJr5R3AJoJ47Dtb5iQUorW1w6LqNBi+Zjxf/8gSwIneos+A3LKs//E8+JeazpIWcV9geh9QagqaIdi13CqMfb2x0sQ9jRdqsFDZkPwq4cSEpJVAddb1jgP+LWL0epFrhjUC334bUo2FdPQPCOL6TW/rqJFGeI7OWM3de9ygk9zcL6ddh2IXtbRxUGn+frgC05VWPp5PrUlQstYuUyCyae7qc3JRcoBjMpYm5W8eB/0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d736d2-2818-49d5-7aaf-08d80c6431a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:35.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhNQAStl5tyL0HRZ5cLmczE8svna0N5/rOOZQn/G8oT3MhsVMkfBhq/Y6/qdFVRpzffWWxqIEXH1DSJcf/5BUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

This patch move the credit map setting to right place to avoid
brcmf_fws_return_credits() return without setting the credit map.
It fix the thoughput zero stalls issue in softAP mode when STA
using PM 1 mode.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index ce8c6ceafc58..ab4526223a93 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1193,6 +1193,8 @@ static void brcmf_fws_return_credits(struct brcmf_fws_info *fws,
 	if (!credits)
 		return;
 
+	fws->fifo_credit_map |= 1 << fifo;
+
 	if (fifo > BRCMF_FWS_FIFO_AC_BK &&
 	    fifo <= BRCMF_FWS_FIFO_AC_VO) {
 		for (lender_ac = BRCMF_FWS_FIFO_AC_VO; lender_ac >= 0;
@@ -1216,7 +1218,6 @@ static void brcmf_fws_return_credits(struct brcmf_fws_info *fws,
 
 	if (credits) {
 		fws->fifo_credit[fifo] += credits;
-		fws->fifo_credit_map |= 1 << fifo;
 	}
 
 	if (fws->fifo_credit[fifo] > fws->init_fifo_credit[fifo])
-- 
2.25.0

