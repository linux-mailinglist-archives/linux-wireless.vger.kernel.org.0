Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED8184544
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCMKvL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:11 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:56545
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgCMKvK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah1jOqkaoKlvH3h8/D8dg1AXmywPSW5hyNo4TB+WbzmveooLgy9EvI86Ia4riZkBDxPzv/qih5hsmg7uXh8rsVRcE5xASNzW4ErACw/Ib9vvDlac7JzHkuSMUERI9Fkt4HWZrQY97tma2SDeDqIHGqQo6pl7eHmMz3Er82jjGJDICesgd8tUiFxGHfcrkjEjdgzteMZi4aaUNrlZHCiLYbVpL6P29sIptDAyY+f+eL+juXYjW73P+gmokL+/4T7UZv3jEg0DM5AnLhemyz98QVYz1WOIXzM9iYFJIQg3/6Y+U0FTN0SEYDDo/o131PsWTrDOF/MObbDoo2ENigHjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp/XWRTwvr80437RcBtCuvYDovgnHn+kzgYBZ3/mbyk=;
 b=dQ6Ut8Ra/KSFJUE7GjWK9rz0zqaiol/UBmX5pS66cscaudSX4aU3lwy/MVdejJDBvFa48Wbl7LPSzyxqa7ULgI4tMIQEQze3c5t3LSAwYzqSvHNvyBtPN3saR6/ormTV4O8xB7NVIb/Pm2gIGJxBkNYw4avThqTJJXZCsPnZpWevkuhIUdnfg7aIX1dAK0iwtxvdgSDcJqgk4aRlKPVZaLGgj1j+o7WCorDjZG1AQhVGg3cSuDL4BX6hQiLx8fR9ALDhI8plhM2xxB3m3lISGaX0uAhZewBDHR1KBmvPsmKbqj8/4B5day5whBfRpIXotwxvANanw4htQfiBnhyr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp/XWRTwvr80437RcBtCuvYDovgnHn+kzgYBZ3/mbyk=;
 b=D7rMb3zEc04v5oL6alBVrnqR6aD/cQUyuh+sJfnEt9QzOv8JJjE9F0paBwjwi6tqL7DwkfdgiIuF9KQMsWbS89eroYx6cHUuxJSOm0EETNNSosxRci6nMlN681aJaCACLebV8b6RyubeXV0kDk4JSA9eLokyYcdgweDohEnmhF4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:08 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:08 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 3/6] brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
Date:   Fri, 13 Mar 2020 05:50:17 -0500
Message-Id: <1584096620-101123-4-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:06 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3c678c7-debf-4dc9-9ba6-08d7c73c6f5b
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB530335115F7366B4154C2A7BBBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(6666004)(316002)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mG2F4QG571QrG5oIcZ1YjLPAfed3OjYVuVTO+8ngUgtWWyJwChMVZjqr9RahzLxL3tM+VFyChNARB9II6hDxJpABVpsHPKOuY0A0+fgHTfPD9+PRM8sGnfN+2cS7Lb7dOnSsSvd5oodD2P5AWc63GdEpaIlDk5UDojZ6SUcjhzETiUf7Z9iam4xOq9k+BDPESPOsj9fTZzpkRxOmHyy7CnLdwQeTwBrbq3OFrTbc/sElAsjECyRWaiyagqp2NBbhh1KOqf1RKYxsuYM/hJ+aCqiwLMNH2JrzKaMUO7FXvVc0Yo5AFRik9q2CaBnWoTcWjvndcJT0ifwp1MMAKjHZWAgVexnvDM5awxZjDC1F3bi0blHDHl0RpqFOa9rJ89ubgYmfSFLJf5SaAhn5jJHcvouh5R/ATeqUjUG7W3xwb1/E/fElo6WF5O3yyKWqziTl
X-MS-Exchange-AntiSpam-MessageData: BmGUrwlM3zIiKZeX5aT6nR5nWU83F36PeghlRa4C9o0v1HXlKV7MejuXl8gcfIlfZFWy5o0oaXZtjKqX2FOQJUT0vNjRbWdjX6BrzFKyKnydfybRL/yE1RNJQ/RydZK0MEoDWrL+tYBL91++Zrzm5A==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c678c7-debf-4dc9-9ba6-08d7c73c6f5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:08.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXuyK7ZbVfMIb1kmTZRgpZ1BOCMxyO3uC3OS1TI3fD+Gzid0plahuZdebB1cVAQGUo6u+/G0a+7xp3YX2KVYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

The function brcmf_inform_single_bss returns the value as success,
even when the length exceeds the maximum value.
The fix is to send appropriate code on this error.
This issue is observed when Cypress test group reported random fmac
crashes when running their tests and the path was identified from the
crash logs. With this fix the random failure issue in Cypress test group
was resolved.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a2328d3eee03..2ba165330038 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2953,7 +2953,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 
 	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
 		bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	if (!bi->ctl_ch) {
-- 
2.1.0

