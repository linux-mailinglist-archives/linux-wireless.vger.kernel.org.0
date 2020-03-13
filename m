Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25F9184541
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCMKvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:06 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:56545
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbgCMKvG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgVC7P1qw+gouAkgr37Ci8oZ3Pd5k/tkFLOxwSs7am7Ih2p2l68/qfiam5/jglaRzGgA+aL234TdeoZsplThwZNMvqZp1VaM82AXwd7EpLMR6AGJ0iYbgj0XqQC+U/Y9p96UJhB/NuNtyGH4K5ObIziopdEIrPc2df4w/+uteL+Dc+wbmoAPPKTMm9SgjWt1JGAazhXSMPUFD6/G2xgdBY3UMxGHR44p4f5W9GIARbHnhgXsF0viUIQEWteYEISyqrz97/cpPdDJGqsEGjrYcu1HGimxMlqNgi5RsedHKASqzQry3Mm8kucSDb1kuvucXGWgHQ5RpwVHZG8qrrbaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMOADgwEHr/o4qrHCXzqhAVsWAo4Sm2+s6G9bztl8tM=;
 b=kqwemOToTbp2u8rEyfezojE4ltoeVl2hUx6s/mRRLGQe46/CRPbKgsy7R1lBegej0es/se2k0h72A8RZKPt+2DDevuaZ6c1wSR3E7a3asczLhPm+EuOqLURom6yOU3PkQP4XP8IpcydHzE9NuOLn8R1FVT7KMdAhzaEq74b8IQVWn+rlEfeP14ZpAjBg799Mzy97NQFMr6ZPHO2zk1QcelntyDgwqLfYGz11TVH9K2dElIDDICMYb/P4Z/sdRkDt3P0Kra+sFi9iicm7DzXo4A32AnKPMTi5RIwj+hZPDkmGGR7UvS9uHwhpZ652IHAK41ldQzG6lnOsCaCFB3RGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMOADgwEHr/o4qrHCXzqhAVsWAo4Sm2+s6G9bztl8tM=;
 b=odONraWPYhTuiJ2lQLQoxkImlAdsaICchK8XwUPJd+575GMWXC8flT27gFfqvAG8/UiRPuYOzjF7hKgSFVzNgYhK/I6UDdhUtE05pp/zHyTQW2brRKqzO7i8X2ZyUocnWuc5Zx+zPeoSEITn3eY2QsbaA4LcQZMkG9ox5H2u3Mo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:02 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:02 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 0/6] brcmfmac: USB change series
Date:   Fri, 13 Mar 2020 05:50:14 -0500
Message-Id: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:00 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13ac9d47-e6a3-4524-edfc-08d7c73c6ba2
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5303653FD38ADB08C18A2CB2BBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(6666004)(316002)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIFUKuvtvui0E5xFdgR+4auxgrX4SKjgF5ZrRLsX5eSB6AiR+KL9+/uNQJbyblUY1r3wBnunGh6jR6YHzSzcyTKVh1j0QbmtEmcudHAefOAvcWm+FO7bfBVnzuNnUVUz/LkOxBmABjcN7P+voOI5Clnkvkjk7U1pcVpb0QwgvpmehQdtJPQxstfdd/5Vc7SfCmamnIBQoseWNLfVlF21rWc2uGoh8B74HA9SjMHwThkprBvmqD8c9Llnu5FhjcUFrQOGng3E3eRer5BJMN/+YA0m+48SMsexxoms8ttW2YSFQOFaDI720VZb5hjb8slNQepl3sZ5EZmPSL2QoIT+eHhUOQzrOOhhDC6mTN9vk1Lz/Pd2NmiOaI5LEcr1gbuCqbxYcj2ltNaMkDKj+7M0Aq6m+3owvj9K0QE7fe2o17YnqD9nRLxVi/anKidzf+rL
X-MS-Exchange-AntiSpam-MessageData: gV+Gzz1lVIUzypJvoU5JthPyMRVhVvMYk0piCbEbJl5aci33dusP+q5ZaM7/09eILtyGGfky6M3en3Yb7cAXn02Gymx6K1HHYdoOvdeC8OYPDxjdlVByqBs2U7vqD2DK9ZoF/89GMO8AmsoVdUAwzw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ac9d47-e6a3-4524-edfc-08d7c73c6ba2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:01.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7mAGmXPQzpkZt4HyWE+Bue/kJIIdx9mGbmYNc/wH6stVf0Bpmf79aOd/4B3u5qd7jRpAeiFuYkFSDxJBNxrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

USB runtime PM and console print support added, alone with several of bug fixes for usb devices.

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
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 140 +++++++++++++--------
 7 files changed, 206 insertions(+), 56 deletions(-)

-- 
2.1.0

