Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF4184542
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgCMKvI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:08 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:56545
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgCMKvH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPBYUifSyLYPZDFfjRZ0Adygyud6nJ2MKBJkS+8Na4HRRGWyAMrlvj5YsPqntVf5aMORm8dJMcxZh/tQ3fJ0YTXpFBmwWtDVwKWeoyV+v7IYnaRdFB2n/vCv6WhiaAZUNMJuUQgHlw8uyctcLYQ0OTEQxoSo8Y2pQrhkWnPP8x+k6Q9aZhil7dpv5FD7dOy1EKwS51sb4sL8E41ZI2fDDF3mzfIfKfFWpkFUCCfzXqHxQsYSIOImzYm31+hloVNFdMyWHfbF4kOk9WqDFHvMxKvya1wfS6Tmv7MVGZe6t8p9tFNIzN23htOYL9478LRjUguc1NByL1751opCjsUnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhe+/iEp3wP27V/WKNDbaMb5SGw0eXT8zY1Gkxc0lc=;
 b=Flw1Jc0+/H29pkwbke+mxrjbEdj0j+t2SAp/e3tWhGP0CRFhA6HyRu4f932srr0+nKfHaOW9y4bWqc1VzRgmpFBXi4eXAQbMi2KAJZGPD+6+vaVSBLE0GjbpYX4VQyybHqcLwAz5G0q1CmTLREengj9EPWeYUCJYz5gNei+upJUlUip1mPByAB4AqlBfi7AMmlRHi4cwJ/4Hztvl5p2L2C+GSAvQvWSZPNCQYnLW8CkseiAeNS78bNEW2fQMU9Go3rzSj2lFGCmXeWgO1X9JFJxYtS59oKrOvoBEJL5IxejndNCGZ0xuF957S/P08xWY2RDiJTUfksZZbH6M3BIr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhe+/iEp3wP27V/WKNDbaMb5SGw0eXT8zY1Gkxc0lc=;
 b=NOljt5ZAhehMK+5kSA3Kd73psS1DYVeYL70IIv4t4TGEja32O2CQKTLDak5vPWw8waxKUnRdejmiOPZJ5NPMHpof6wkamQ2sZ4SFwfeTKYr7Htl1TqIHG+VT9iDQqvQqiw0KvRdV8xd2z7imCK+8Dlmq55D074iRKbBCCbJaWYs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:04 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:04 +0000
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
Subject: [PATCH V2 1/6] brcmfmac: Fix driver crash on USB control transfer timeout
Date:   Fri, 13 Mar 2020 05:50:15 -0500
Message-Id: <1584096620-101123-2-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:02 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47e980b6-d371-4b25-50e5-08d7c73c6cee
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB53034E2A4E6F3C2A3A7BE89EBBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(6666004)(316002)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdJfxdNM5ueQ2i/4EVs1zE58T9GYR7lQahFwHbiEUKwqhjWO9XLK0SW8g0mJ21NB64PM/yzCjeaYj4Orz+mm8UIZpilMGsYs1iftnroln6nF3h67Wwfowez1Wfvmzd/EB5x0Jqem97AlczqUO58VFXkbHqsbvROghPiZb+9aQVVDLxvmj9S056qdJwtnZ7+WuMdvyexpAZzYHmhY9zTg/AlEDbbrkRh8g7vhbVoR3TarYcnCHvTYF7uSTbvtFAnwNN2HCTFmiXfYuGX1WtvgXhYBZVzu61UxVyer+gkD0WV9uiGZJYG/dO2fkJViJ8wl512nmCZj3ow/V/dAJ/kEG2Gue8sKuPlGMdvE4SygS4b/O1lqgv//0WDvVf9BmJSnHrlyzFiAJMUE50wv5eJt3YdH634nhGdotYAxuLwBZwlxv2nqlUUGEzyX9SA7WCW0
X-MS-Exchange-AntiSpam-MessageData: z/BM7UqwHCN3yK3Y9PjvV9xglsDD43KwURFBCWx/CCj5IksBC6vHWwRZLCw2PdmnSJIzom3JIWbc/hvIh4tKynfMxc/ASNe0ypzlkrgCHBUM/P1IAeU9JQks52aO/2AvlgXW7hK5F7gxfWCId8VD7w==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e980b6-d371-4b25-50e5-08d7c73c6cee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:04.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWeY2KB8LYR1azp4no2ZdenFWySdYcytfBPFcY7x/KYLmjl/Y15HwB2GP30SaXoQdav6iUjUuNL9efis8oXdxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
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

