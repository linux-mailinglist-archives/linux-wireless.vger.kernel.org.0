Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291D919227D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCYIVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:01 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgCYIVB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYsbgTdnuA4Q6f50zTEcYqzwKc5aiCZDga0rRP9uGapVRKjWWjjMvvN6IQ3oiJ9E1M59CHTIMfJDoySzTWjoF+mobo/bAPy+akLKhSH00DxhsSeL4V+sHaR0GYrCf+H5DwuL09ygQViJ6vNNuElunPXyAA+tJSr4GKTuPu5Ye0cfGcU3dk2n9iXmwkCyXmfbHcj0LQlh6h+iEcghR9lbUxpwg0KzvBLnv9ROIZ0DzOydnmqfft5qIznaXFS95xwinJLOWtQkavSX6Q2s+dkk7wpefF5dJ0jBl1zkZvLW2o1VrnpufZFS1g4zda+KKzee40bGqfDCZ3nJamqqmfjF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhe+/iEp3wP27V/WKNDbaMb5SGw0eXT8zY1Gkxc0lc=;
 b=ESzhgYwFqc6rlsTmGuxAxkjcKoOBdrnCGUhHGSD19LisSWoyx3tEvKo/nbiPpqy0UhdrGXmJkzFSKF2//5PK89vJVJGfFn81EOqD1oL/Hdk0/bIcOxJBDDf21aMBUPMs0Sfo00G9FsSVBRgfUcnBB9YKD2cBe9eRbsNhaJgkbfJWwh+FvvxnEC2C3iWv42H4PViGEiGajyndZ+I0n5wvvOAoR9ShIaAhYQUBsV0mUcnjCQ1R0kX7RoZKPCaBfap6otu2Gh1UYn0dbfgU4nuulULBVfSiahqtNWpxoDMdv9N/DLSRgJOgXTTg3cryvsoQpNO2JJnRwlliyXTUDuwsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhe+/iEp3wP27V/WKNDbaMb5SGw0eXT8zY1Gkxc0lc=;
 b=RhRF3krT5Zs9VCM4ifTBwgJqWJXbtIV0AUniDLcS8C8mKnpNTCTcb3KlmM0UWv6H5Ml/FVfD6pCcFYMDzyri2HkZxwXWXhY4lzTkC2kclKZ0krEKDsGb9HCfjqPwQM3anYsE/0sR+YjHTD/EnJ8M2QkAG+JnPff2IXRbm3LQU74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:52 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:52 +0000
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
Subject: [PATCH V3 1/6] brcmfmac: Fix driver crash on USB control transfer timeout
Date:   Wed, 25 Mar 2020 03:20:24 -0500
Message-Id: <1585124429-97371-2-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:51 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4534677b-d535-4e57-5e94-08d7d0956ebe
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5189721DB303E0C2AEBDFAD4BBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cz2VuUk6yT/OHWEqrDFbZZwJMm6G63IepUvmUvV9YP5ksJcLc3oQAFyop4PkC1ielnz3OlAzMb1CiuTxd1LWwQ4Sb/HcmdwUOlTxvZDbFsWRH0UvdSd4swfrNr+Z/nfFKSFWXExyCw6rMJF+B85n1qwwQpLzhWSHlHp2FMb+S3Zyz7BIw1z7bNxCxg7A4KGpS3kecCi/fGl72ZKEyXicR+4EYP5iuD1qXtrsDm8pCJNmYcNvnSkIITGMSWgqnCPsTHkH1qMf7VmofKgXlRwa7mFF1WR6/N7e7IadsiTPokvU93UmNI1Pcy35XG5uQB/KW7d17/rJXDlJyM0QAtNfuFnt28Nlrf500efBFNoGqm3PrB8zvXrsdqi816aHaxfUFLXPh7QD+VzYLPO04usKX6aue5BORGq/qL/dKby6GWcdIQQpJsb9vgoVkyDhVs78
X-MS-Exchange-AntiSpam-MessageData: yyjnH+MaKcbBBeD7bJ/zMGuRcjuHNp6yyGwRSTk9rTemovmQSzeMzMTnKfj1DCRLiGHp3Dh17frKaXlhjeWSvSW8J9p/oKOVS7KT0AxmEW0DikxTS+Yh3Qrm8L2cDWST7Vlq8DMDSp9WM638+neyHA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4534677b-d535-4e57-5e94-08d7d0956ebe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:52.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqOVXjGBT4C7dDuPKu9RpfgCS4hK5+9jTWG3ZFUUG4honkqwOMfsw2PK9ud1tXrEVL59ZAzPTebyHdHVoda6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
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

