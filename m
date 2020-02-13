Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46F15BAFC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgBMIpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:23 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729619AbgBMIpX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvNjz9iIX19XPjVPU+YOXP+/KFuWT4aQXCZI1vxmAFuWv+YkvRXKdZ+8/EqCaK77gkeuBm5wUUIDujq/Bj1t38QskanJ3E+NwoaE6cRLACLW7CViVuj5m6PgwcJeToC1dlX7IeBNW7w76Vyu6wVlcceEoEG5/E4a/l1paHM1HG5sIHN1i2zjrG4pKp7YpTqijoL0YTuefqfI5f7zSYIBKZwuTQruk72UmKrjRAJuPSYYY9pltGK7hcWwQSlVGpaY/RfzwWRIg/TO2acVbcB6mpCEegKVKadpePZGytqd0eYGlWwEcmfi+Z9FqkeMNHaNPUNUEu7fSKAmY0I2xPhvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p48uRjw1CGoBMH+Wc346yKPibmrv7SfJ6ftVAvf9NGs=;
 b=fprkDLVVqmVMtzdcmy/b+eUkdimxWIk1iR5gaNHOmNjQ0k+7wzMdrEI6P+plgVw+7CSisWxKTON/7phXPzdd0llszTaI/1yB8h5F+OtDHW/uihLzfRAqMLqQYvwc4j/ituGrSbwVDHcijsRKAibPBvWh6CGm4bU2DpacHjH0bBmkhGZDfc6o677D2oHv4NOQfsSKS0HKK/fJ4JnOvsUXrqqGpaPIOqG55vH9veiijqYlUfVlKhDee7zutij4gVjOplOlLb24/yfUUwuktMELdD8n2s9sx+1FSVjkp297KZiJ6LoM+ilSysBBp/JRe0aZYm3ADgbCmt2xRVUklhqVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p48uRjw1CGoBMH+Wc346yKPibmrv7SfJ6ftVAvf9NGs=;
 b=ihtKxa2857bQWpUpMnQSVR5sEd+BaG/7K8JXogIAUfrfaDIOOLoACHFen33P3Uf3DE/cCvKP+CAJcTWOwp6PI2EIebZIe4trW7BEjExcn0rl58vR1a/wjrfV3bXI/TAJXEAx4dLfSNr+j2sFYHLhR/rjP0BPVvnwaN5ykYR/R1Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:18 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:18 +0000
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
Subject: [PATCH 3/6] brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
Date:   Thu, 13 Feb 2020 02:44:33 -0600
Message-Id: <1581583476-60155-4-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:17 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cdcd0eb-502e-47b7-3c1d-08d7b0610d87
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB56232E4AE2B29E0DC0A02F4EBB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/Z/zQZ/mVjTIdHbFxgMkeJdgU0hQ17ltP9TQm4Zp/ndcwnHDnA1QRfKVhNqELMReVgBZSyqM6eZwfd1OMDNpMFRObALcIRVjuHgqRf3p9nSxF7ApVheCvKGs6bT9JGUykbVmAYq6OMnhkpaoZLyHQL+uH0OyXbRpgcJ0v+FaYhA9/09WMSLPWqvAu4sYR7EOesWoSXgnsesZn3j32HA/vqhSffAahzz1VrZ37R8OoHQzs11kaZ60dWojVNOfEt7QKLi9g/3Dxf/BtJq+9ScbEyiJOsHxEcbK3OJzAz6cOCy7rKVqSr038wHAvFMHIP+QlufabfCdzCZim7eXawt8ygArev/MeZ6gy1vtu8Aa6jxUqnx3u9Ti/JzUqbdREFLc1HQCZDxlUOKLXsN7863SWzkhJrxhNCvOKS88snAxMP72wfOIdSXSwRaFRGFV2Io
X-MS-Exchange-AntiSpam-MessageData: go7GMDIm+hz5zHkIT9CeH7RIsEid5zb6VfVwa+6v7TvF+LYHV4RxbZf1Mo/jkPHFMiFEUxXPiXUZXE+FHlZj6L/hMvpBFRDZo4fE00FBAothvZrIrsMaX9i6ScspeXtWaLuozXpE0TDUkywsg7aHcQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdcd0eb-502e-47b7-3c1d-08d7b0610d87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:18.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLgv2tYxhqqsAkH9o13SZhDYimQCnuqERyCcAOXH8QwN+4lMHo3i6nAdOdOZPnI3wiP8eEWNLzI74veEX7zM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

The function brcmf_inform_single_bss returns the value as success,
even when the length exceeds the maximum value.
The fix is to send appropriate code on this error.
This issue is observed when SVT reported random fmac crashes
when running their tests and the path was identified from the
crash logs. With this fix the random failure issue in SVT was
resolved.

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

