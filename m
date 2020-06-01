Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18331E9EF6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgFAHUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:20:40 -0400
Received: from mail-bn8nam11on2099.outbound.protection.outlook.com ([40.107.236.99]:30816
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbgFAHUi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdhoZDUI/OhY5CBLUmg2lZByxJhjRhOM9tXn0fqaS/+2Oi4+0Irm5JWRHaKzIqhQ7vjZFXlPV9AlJPI35cusMhhEq9n4t1RoaoYGOH+LzISlJA2F4L/0ilFvIAS+2zR7xnCxHXHMW+88ku6Iza+Vfp0r6Jyn5KbIX+9mLnPv5+f2s8Ht3MeAk2MgQzE5R1LcJCYiKQKelCCfNt1YvqGUaQwIiPHrM+PyFBG7J3uZmvVMKBQhYlu6BzzXX6veKsUrhIRFoJthZsUN03wwNxJLJ0pQWE9D3/7gZvkVlY72m36r50ltMh/JhhLUvItbjnU3hkVA7kZ5LX1nCu5Sp/WGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klxENko/gjgeqz6yLHvRY86xsdHG1usE6eCNXJaUCQA=;
 b=FI192OIP113NO868X/10z+VZZM+DDG9+5OviGe6KZK6S/m8qwEECqdnd6oq1icB6ceWDQS9OAuQJ7Z341WzM5mNOkKg0U7ngCNfgh2qCzg3dPxw93c0oiEcn92Ra1HZPFelhwtfyc+J27U9Q/Ck36mLiQvqMZUmoLnTILi167SfxJffpvDqnV6C6sTxH9SUaai5l4QmMVuN1q72dpxOiytndtjBalwCuAqRi9bCkSsukLeq5O9YdOZl6PYs1hFtuZw/fcw9ZDd97VMwzGO1/FPTkFKwdssTZ/0E2iXMZGqjQ89ofZzJuZYMaNtGIHIaaOXDau6Kg7skRIulOG3QW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klxENko/gjgeqz6yLHvRY86xsdHG1usE6eCNXJaUCQA=;
 b=C1M/+pY8hzLdKme9xzh9jivrJ/Fe6fjROcA6NNGxN1ODFBmqKQj0Jq4kNmljD9qaozjq3nolci6YscP3iJoqpyAIIAfG7CR9wrD6XmPdCD8dCTMTwmPRTOQ+LzSqGULeqN9OvSK0RBp7mIUAPt3Lc8koEgFxEZpRWjKzm2fP0DM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6074.namprd06.prod.outlook.com (2603:10b6:5:10f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Mon, 1 Jun 2020 07:20:36 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3045.018; Mon, 1 Jun 2020
 07:20:36 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 0/5] brcmfmac: Stability change series
Date:   Mon,  1 Jun 2020 02:19:48 -0500
Message-Id: <20200601071953.23252-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 07:20:34 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66cb05d7-89cd-443e-4ca8-08d805fc472a
X-MS-TrafficTypeDiagnostic: DM6PR06MB6074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB6074DFB070891FFF4CD054E9FB8A0@DM6PR06MB6074.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GFch79PsTvrAy0lofqbAhx4IJp0aTty2zeeeMffWsGgbfyYfJRum5n9KTNsEKGnxnnwcdttjaFaJCnm9fYKalVbQ7DPc4FZYUi/MCQZTcrToMbuBpMk7VRsqlj38mfE/4Evc4ly0zwOm3QP71I4Ox/nMar6hTy3iqqtKPsChpt3ShZXsqstPCcS+td3znT7f30Mz/4wd27EGb/pk1KqEQzBJ5E2q2gyQtJJGIvH0OEpM4ga+qjzYmwyBWJjAfHCJ/H3rcEnwCRcsAGJd7BQRvQ2MC3E9rOunj7QaAHZIs0uwiq1cKrVVXtmo9vcciL0mUmuaUGgE1rl2tu39Agy9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(107886003)(6486002)(83380400001)(6666004)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(8676002)(8936002)(36756003)(7696005)(52116002)(5660300002)(6916009)(44832011)(186003)(16526019)(478600001)(86362001)(2616005)(26005)(4744005)(1076003)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xKb/tQgRr3oUmEUCQuYoT3CyX8Qq7CvEdi/xXjM8738WT/M0JKu5dRAaPV4sBMRQZ9P7bdc+c7pnjYxxTLJKUK0zmsis4nfBJnng9ctyUzOwJ/mf7DrAEpcCUosw5PHLTJ3miH8DkRyUHNWj9k6bZ/H0Lx1IGtrVTAGZxYhWLI7I9G0YOllsHbVTfEwUjTrY2NnLnKaw6s7j/pkoT/tr/Hc25EjmbKYUs1gmrFMUy0zMrx5KElM4j+B+cIqtuQ4pBLytWcmBFAkc5nMTFjsnBC75p5rqWp1wr0sw7B6T15MQHk3C1Gx1uHMgLIPW3ECN1smnO19s1R4MI/L3csddh+H4LzEf5JUIHN5RVONE0D2LC/+AACPu0mWx5KExU/nLP3ka9hi2CFDQpb4vD7nQ8KA9FNAVvJJQ6V6x0iOONQGOI+RRLjzJHRkOGFkZgxTSAC4u+4DTwxnWzfvCfF81wKClZpfxwEb8nf1NDG6GpJAxz9xwuN3ZJOcW1Zq8ujHg
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cb05d7-89cd-443e-4ca8-08d805fc472a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:20:36.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnEeJ/gvEKnSEETdse327MarvpX/eber476XPE32UsW7TodgVmnveMP47kTkVkIUe4SG1u+hS+OexbAf9X6yew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6074
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes stability and connection related failures.

Prasanna Kerekoppa (1):
  brcmfmac: To fix Bss Info flag definition Bug

Raveendran Somu (1):
  brcmfmac: To fix kernel crash on out of boundary access

Wright Feng (3):
  brcmfmac: fix invliad permanent MAC address in wiphy
  brcmfmac: keep SDIO watchdog running when console_interval is non-zero
  brcmfmac: reduce maximum station interface from 2 to 1 in RSDB mode

 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c   | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 6 +++++-
 5 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.25.0

