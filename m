Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDE15BAFA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgBMIpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:19 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729619AbgBMIpT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuB34LNzbg+ZGix1dz8ej+AHTfbhyKhlsdF5TrBFkOQ5a3LTp3U6304p8v6JhZtu5WcR8mtMLR24cPRDatUGCF24CQrdCuORIqIIBGvxUqnLN/0xhLdUb1N2M21Sx1Lfbr4Wgjs6BlW8FLjKiTiAEhIJHnoV/oN5PUvpWmctTa3q0gI1WpDCJvwGcq33l4L88fh5fisQTHrr7UrEUGhpsCimFhQGeeVn8eOuDO5uNgv72P7M+aAjq4LE+trHbKcbd8Ew6NvWVK8WkOeXq9OvT6hR2tcxzONem+R54/DquwZC2Vt1xzsxbaBs1ZK7qq+cK5mhGPssXcl9YOeINM7NuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhe+/iEp3wP27V/WKNDbaMb5SGw0eXT8zY1Gkxc0lc=;
 b=hvyxLNM4MNi63Msk8yofKFWB0f+1AGVvZIwEsap7ZympM9SIvbpjXGIf8glYiLMcOk1zCLyhH/LcyQMDg9qhBTwoIjqwGn6tEs7MtAXk7hMo6w8k0BdzJcS/vEguW8EVNYjeR/LV3hgftEgOYSQq1lFkwUF9w0LwiGegqnHDfwcSwsL87AvhKieR01rZOPJ57Jw67WUcc8s/MFOEUCJK5ASjArQJ1hhEdLDLljNNEAhDvXl4hGToXpQ0w0jKlaJ3Ga1Ll+6Htux704FtU5tArXK2M1EpKJC/FO4oUZTqnw30edZVOgD5C/m+PESpOOVpLr+VwWnkAk4JIApkPCWAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhe+/iEp3wP27V/WKNDbaMb5SGw0eXT8zY1Gkxc0lc=;
 b=Xusgp/l4d0b7B4PsMh1IT2clLK9syIaguLy/M5dxhi7e44eMmd9YTs6JDpAtUgLbMiDZfEnR15OGoGhBJos8FsP8LT/gBA0rTfw+VT73gyzqO38b2GWHRzvcNOm0D8X+dBlJ86AHCLWlwm1jyfV+lBzq4dL52ctHsEzniQGyiSE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:16 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:16 +0000
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
Subject: [PATCH 1/6] brcmfmac: Fix driver crash on USB control transfer timeout
Date:   Thu, 13 Feb 2020 02:44:31 -0600
Message-Id: <1581583476-60155-2-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:15 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13e9e2eb-2ee1-4c1b-91d9-08d7b0610c1e
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB562341478988740201E683C0BB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxF8T8MYrgqD3nRCLV/uZ34BpdT0NLl9MO1oKy8+0IFFMazjQwf3JhVX2Ep/+PQAxAU3o5aaMhWhoMKaptCz9xFnj5mQbEXXNZ1tqLo5b+KgkPwSlYcP2ABNWH3VQAwP1Y84FMmhCnRIGxodA0hfHWrh+SBeFZ17S/wp29sizUuuVLJN/ZhRgEalTNC0bJqntDdJObeyUAiqOmTHyQKtq+aIRrOBz0UoT9wIq0dJ3TWnBOBsiUe7JGSY84zJsU4vutVTkvCHpjKRY3ZB/cL60k/o8VzReaSfPlx6jrEXpiLmq2hI4XMClY79tilrTzGpiQ9VDL3zMzj1ND/lEO/FyTfQ6zg5rm5Oxgk3xY6SbCfOz72+E+C74kmIfCIToX3TboASLYsW/vgBiPJxJ3d4730YStP2AgoKfwnFvqkLvtnUU8qFXNMnuEHi7NbKWCfy
X-MS-Exchange-AntiSpam-MessageData: zVpB47iS+p5YcYXXD+mqTJNG9QeX+g+4+/mmXvRYoDuKGqSAIKfhlWFOPedVmN1KAY+OU4waQ/iSif7AcfvsyRUPIlp/gh70FtsNDlgBowU7iTLM47VUjmuKeP9kBzakMlEpptWH1o+1jRngGL+Fog==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e9e2eb-2ee1-4c1b-91d9-08d7b0610c1e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:16.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7n/0Nq7ynr/inSdq0ZvS2ZoYk+3YcwwMiWWElTyMiEjN+0saYnamvICNCMM+EF2XSooSzjoYqeM+06V1MQbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

When the control transfer gets timed out, the error status
was returned without killing that urb, this leads to using
the same urb. This issue causes the kernel crash as the same
urb is sumbitted multiple times. The fix is to kill the
urb for timeout transfer before returning error

Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 575ed19e9195..10387a7f5d56 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -328,11 +328,12 @@ static int brcmf_usb_tx_ctlpkt(struct device *dev, u8 *buf, u32 len)
 		return err;
 	}
 	timeout = brcmf_usb_ioctl_resp_wait(devinfo);
-	clear_bit(0, &devinfo->ctl_op);
 	if (!timeout) {
 		brcmf_err("Txctl wait timed out\n");
+		usb_kill_urb(devinfo->ctl_urb);
 		err = -EIO;
 	}
+	clear_bit(0, &devinfo->ctl_op);
 	return err;
 }
 
@@ -358,11 +359,12 @@ static int brcmf_usb_rx_ctlpkt(struct device *dev, u8 *buf, u32 len)
 	}
 	timeout = brcmf_usb_ioctl_resp_wait(devinfo);
 	err = devinfo->ctl_urb_status;
-	clear_bit(0, &devinfo->ctl_op);
 	if (!timeout) {
 		brcmf_err("rxctl wait timed out\n");
+		usb_kill_urb(devinfo->ctl_urb);
 		err = -EIO;
 	}
+	clear_bit(0, &devinfo->ctl_op);
 	if (!err)
 		return devinfo->ctl_urb_actual_length;
 	else
-- 
2.1.0

