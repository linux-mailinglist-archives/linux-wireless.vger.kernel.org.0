Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3E19227C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCYIVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:00 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgCYIVA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdiYDJ0JkbIb8AY8+4xNpmY0o0j37garVfGWqcz0GgGafPYlObpOz4d1ZRNFTT6fWS9Rt/a3G+9iAV/gL+uUZ2ewX8Rrn0A/2Z0JebfAhrcCySRzJmdLOHqd1QR7izMUCwaLIF2ZgxnvYcj0ElaYtLykrhkGRFdkBx3Qb2lVXirhud8lkweJ7D1sO2Riuvy49oemVuyrR0nXWu1ngKasydUqoQ/YA0bZbyfrOs0ETCnPq0uqDlHw0VyVvN4vSD49el0MHIkeC9/Yw6nZBAXFALY1UupmCIGQLgcg6dKEUsvVCvXo15LbPPDOfd+618ntj5C2dMdejsI7jV0ARDCwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jP2KvIC+fI1lyO2ru82pxFLw6jlYhOchU51tClN/DI=;
 b=GjxtFLGipgHfD567Xeyx6qvuMzpswCzBs6wtRWQohRBEcTGfTeW597qpWhdyvEeEaZtxh2NS/cE+I27K3x33gZhqA2olcSP2J6oM5+YVk8V6cm4XJJ6LXzZWIHYBn690IPlGXmDGT9UGtrTI3ZuRRblmq/x9AE/Fca6Pr5lzWzq3FwbQLt1Y/FtThFOK7fD7rOpNy1J6tCJZq7SZksGN58CqZTfSoy1uZOjtfTrSoZcapBXH8yalqxyYS5EqvuLZzb4JBYVcg5mMQuP0RUuf8XUqa1QyUfIBDOSGPdvZrw8/ntCXYF6rdutFviX2sgOxp77gy1JnDDFHS9bxuCksZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jP2KvIC+fI1lyO2ru82pxFLw6jlYhOchU51tClN/DI=;
 b=jRZWWCrdBfYq6w9WAzYirjjRFPnAU+aHOUYMwHAwEJU2q+uiRhcWTqlhoX583POyTM6Q+8QNasuo+e240aVjid+2M1c+IgT6d3pRriVMlSI2+yg8wQItuwnT6rHkJzCiQmpNBgQgMqitqyR0F/3YMXyl+dLxtalUNERinhNcSY4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:51 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:51 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V3 0/6] brcmfmac: USB change series
Date:   Wed, 25 Mar 2020 03:20:23 -0500
Message-Id: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:50 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49690210-79e9-46a5-2f4b-08d7d0956df9
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5189FF7FE61C17D9F268CB12BBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvtHRj/MxQQfOBoS+Q3zTSCl37coLoN+X6EDYrfRgUbTxPnz++JrN+EmYiF072IE1c4LUlij9b8Hpqpy3jp5CyPt3FQDhqoR/WjXreN22/F4t0WwSngo+K2wFmkbQwO7R+QQlcchg3QEQGtPPS6dPqQ/1pFGebdG10qT7x9ewWu5TwpbjTsV8bYfeNWLKIg7ZQEaVwAZqKITk77QOci9pNbuDS1w7k4VV+i3BMT6JbB6USmQ2Y25wYMzRFd9TwfXSg+4rnJYi/mnBslx3gT5ZAh0NQhkTaQJstJC2d4mqjXqm0sfSjLMQFYSN3pUlC7LSArXHZ6qfk+MUmb/QA1mAX7TWc+s751JFQk3thiV/rdwBIQnOo4l4Lkk9qZF3Y3h4noeGiZVUdJGCo+bzrKBzZ4qAsbDI6ZoF/GGa+DscwRbR5m+ZLfJJYO4kTic6I4/
X-MS-Exchange-AntiSpam-MessageData: comUsdrA4Gbzocq1NWUH0lxzg+8Rm8zz8zZacA9budY6tw9A4KRIHv03F9psGkzyQ+JQqhWEVIgG5N9lNMDozHizltdpJtptRdC8J6OHk7ivyRdsZAclOWV25KSXBbgFJ7SL3FxLVoALXGMvg/cawg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49690210-79e9-46a5-2f4b-08d7d0956df9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:51.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Md5CIcg9st2VO+SO+VmLqbEFEKAlXKSQkZ94LVyuOi1bx/dm9Wl3w/zSVMO7juJJ8A17S4iHz23pbPIeWnoJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

USB runtime PM and console print support added, alone with several of bug
fixes for usb devices.

Changes in V3:
 - Fix build failure in patch 05.

Changes in V2:
 - Clarify "SVT" meaning in patch 03 commit message.
 - Add explanation for wowl usage in patch 05 commit message.


Madhan Mohan R (1):
  brcmfmac: increase max hanger slots from 1K to 3K in fws layer

Raveendran Somu (4):
  brcmfmac: Fix driver crash on USB control transfer timeout
  brcmfmac: Fix double freeing in the fmac usb data path
  brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
  brcmfmac: To support printing USB console messages

Wright Feng (1):
  brcmfmac: add USB autosuspend feature support

 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |   1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   8 ++
 .../wireless/broadcom/brcm80211/brcmfmac/debug.c   |  82 ++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/debug.h   |  24 ++++
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         |   5 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 141 +++++++++++++--------
 7 files changed, 207 insertions(+), 56 deletions(-)

-- 
2.1.0

