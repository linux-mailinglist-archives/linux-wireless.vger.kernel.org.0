Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A801EDDE7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFDHTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:19:02 -0400
Received: from mail-mw2nam12on2131.outbound.protection.outlook.com ([40.107.244.131]:62176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbgFDHTB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qugv5kg7iqNoE6PB4neAaidv4BzcpDDqnYPYJ3GST6e7ZYJ52ps8/1CluSQrx7Jj9/g/gfiQ8GhWYP8TkYjDwCWlQHSqL2tFVGhZ/ScbNWyDFA1zbd4nApdj5uFMzSxblvZ4yHiXXqAd7Fvn/BUSrPZmmRowaR6QtLkHggZXjUDewKFpvOkYC8mfy4Sn3bjMWA26wZC3Ioz8vP801itadieXi49YqzqfbNhjONdqAHPp4UDFKnfGKnXH1c50sS7wIggozxdWFf6ok14ffz1M2g37s/jkuJnLYWBQ+CHg0q1fy2DmipTID6Bba8QNnfCw0EeZaLVPGnkW2wFiNpS30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXW1dYlIpU3N+IiooStW+231FDUJf74Mcqp8d+lNAiw=;
 b=GnmnJd+MMgU7YEiZT/e7sp0MnsG2yLLpuww264lxiRi+VKcRBKfsLQ267Sriq+UGUmJpqr/VSsjQrQJtmlqyyFZSzD9hE7worgvz3PtgFR454CLDEAedC8GHxXctKtOS1mL7xglHHU1cHHQJG2Z8lLFA5DB3Oi6lbXDI86rp9jEff3H7tYe3UucxfkMhfJ4U8pmvFPeWs42vft0h/62bgCUXfYW9SdSkvDV3Dq/DYW/yNPuf5dlt4qUwAxISvrusZcc97hlAU5TOlXtOgwCfklVdUnBZDVVI6aQJNP2OfHwNhRqZB3sG8U4x0vHKp+GVnaz+nTln8Cg86w0/KvA1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXW1dYlIpU3N+IiooStW+231FDUJf74Mcqp8d+lNAiw=;
 b=IBBTh5l0HRiAPDiiJbQavXud1c7c8/BTtwSOOcs+xTpJwEOhxnYlWDSyhohSuhmQoRdg1s0HIFOJRDQgXGd2xUpM1Dy6FDCsAY/uOZaRkvPpYw1zFohZadIlo/voq8QM2UGjFCXAm4rgmWn2T/Hpg2gmSbGT8w39C/oGFO4GIkk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5146.namprd06.prod.outlook.com (2603:10b6:5:112::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 07:18:59 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:18:59 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>
Subject: [PATCH v2 5/5] brcmfmac: To fix Bss Info flag definition Bug
Date:   Thu,  4 Jun 2020 02:18:35 -0500
Message-Id: <20200604071835.3842-6-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200604071835.3842-1-wright.feng@cypress.com>
References: <20200604071835.3842-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 07:18:58 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 739377bd-5981-4c9d-3e6f-08d808578cb2
X-MS-TrafficTypeDiagnostic: DM6PR06MB5146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB51462E3F8AE9ABB7C91A34CCFB890@DM6PR06MB5146.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u82YQwIIh9y3VKosaGpbH082mbP2UzXoMio8TLZsiNfO40u8MlDoiWamDQH4im5h8VZCjjGog8kBHl6FENE2ZK6w5Lax7MMG62SSO3f7p3Z5qj4KXV87gxYH/BXvPNDs+2syKi7GOh3n6u0oerVqBGlc3ti7Nt4iORlVEZZoURg5ta0rBtLCeBBva0KQ2faIiOuWXMWBSLM81j5KQWrA/tQ5l4TVZPMR9cGBrcmXPqDTtrOWp94HKbNEp4bToHgB0EJ/1wfbghQwPQXc/F3ozihaN9cohhkWDTVXQ+xPEZ11N8kax1DHqqjkJrMh4QPG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(316002)(54906003)(6666004)(26005)(16526019)(186003)(2616005)(52116002)(36756003)(956004)(7696005)(44832011)(1076003)(8936002)(8676002)(83380400001)(107886003)(6916009)(5660300002)(2906002)(4326008)(86362001)(6486002)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3XDnTAKQSmEyXITCIFvI+3Vpg6FB2kJ2rxKCQq5QZqS1UZ0SA4bZjpklrCC2lWpbUlN5EkkiyPTdw+OOX5AqLnZ4C03+AuLT7yKBRfTkob7ovFBm2GgbiECO1CjLXs0aEskzMuV7n49DF6yFXu4dPLwnVBem9nRmGlkhasEFw3P9KAWCsPeRlZlSn08M0tMkmuskuxNgz9SfYKTpwAC8B7tZJNYqHnHuIh9yK8O9H61lPSU/nMFzBGBFNgL4kU8b4GpP8CzeufVcgSDtLzNBHz6cRD8lYJ9SmMaU/gIy+F5DKEuyJ9lXvVKqUmtGb36rCjMUnDafLgFKUWAWq4CIExVVj7I62A0wJZpKnctmbGHIlAQQx5RU53DHYRNpELNYiE1+qCdezypN6VFVP+1wWtyU98L7E52DOXq9Iuz9VKXcsg+55xJx056VyvKQIBhpeivZgc4zIuFMyY2Ykaj0KvcRmCFiotmLvVtpq9ocNGo9XGWLvo7nG+UfjDjtT8GB
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739377bd-5981-4c9d-3e6f-08d808578cb2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:18:59.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmpKzmga9OWE7tbL08x1RNMLzD4bbSnqHwKAC0WqPbL/xowaL6dWGgV4jM3mgL+aeEi8r9fz/glSU0Iqp8m8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5146
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>

Bss info flag definition need to be fixed from 0x2 to 0x4
This flag is for rssi info received on channel.
All Firmware branches defined as 0x4 and this is bug in brcmfmac.

Signed-off-by: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index de0ef1b545c4..2e31cc10c195 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -19,7 +19,7 @@
 #define BRCMF_ARP_OL_PEER_AUTO_REPLY	0x00000008
 
 #define	BRCMF_BSS_INFO_VERSION	109 /* curr ver of brcmf_bss_info_le struct */
-#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0002
+#define BRCMF_BSS_RSSI_ON_CHANNEL	0x0004
 
 #define BRCMF_STA_BRCM			0x00000001	/* Running a Broadcom driver */
 #define BRCMF_STA_WME			0x00000002	/* WMM association */
-- 
2.25.0

