Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D394B2053D9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgFWNtu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 09:49:50 -0400
Received: from mail-co1nam11on2127.outbound.protection.outlook.com ([40.107.220.127]:64801
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732633AbgFWNtt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 09:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkWehFNiDuG+aCy7QqW8siV6wSJEpiacfGhusjZnYbTT0TR4AVirXhg7jvrouaIaM+76+elDiou6H1VN41PIxH00lHqpkY2tHdwLnnHmW3BH9f/P0ZQ/VWcR7khQxLpW9yugjpHPATIA4KCsX+5uWRyecNuOipGQf+4KK8OyWLwfHH8UlqFFnRksdYgVs0aqk5xfKZtER52oSieanmlMZYZQe/K5OsjLbYE11v30b9/9UzetNV739UyWFGIvF2pO50KYS5lkfJj8RqLpZIfAq5HYOcx1llkROoyP+JR9CdNlt00HlDVesK8OzSCWoxwAwSfV1WicopbWC5mCA2BRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8aiivwIpuOWqvECp0srSXsq7XkXmLD7MNAV9fOpFcE=;
 b=kTD9C7/H3GGB2p6OCVkhd/DVI8KqKcW5J9fG3ZrFOlVk/dUXHSf75ADcqfrHh+xVHCwVc50jbzyEBjYnlyrVBf2+RwPq9sSQkbhczGZXMgMN7hc2HHjjqTz07q2tr0tsvKSp73py6H8pKC5x/5B1nhX66yt8FwdoGfGJWTEhwDWn1+4BaHd21G3RnRJrpQgd9gWCkwwNX/c1slNQup7nfxkJ0ghvJyQf11jKqSwckab31LchP3pSPYpNTCUZGkHF+WO0GdhdLzvT6xhm5Rm/1r3G6wz7SXQCqX/lw1OTN+DYpPZL45I0vBjdB9sDz5KPl4Jln+uUOQOuUWnMogXQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8aiivwIpuOWqvECp0srSXsq7XkXmLD7MNAV9fOpFcE=;
 b=n3qnLx5zKXoK9TmaHRO4ES0xLlMmibCz/DxCKuua4L+LTe/ObFWCX1AbYKwx8QoAfAmHo7FzMQbPFJVAbuYABioamJG+MZkCp5hUHEM7tcYE7GckhDVh2ipu4iQ0TX9aKdsg/6vgtE46DBf9mJAj0aOpt2cUN3/rxxU0xjYo3Cw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5192.namprd06.prod.outlook.com (2603:10b6:a03:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Tue, 23 Jun
 2020 13:49:47 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 13:49:47 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
Subject: [PATCH 0/4] nl80211: add support for WPA/WPA2-PSK 4-way handshake and SAE offload in AP mode
Date:   Tue, 23 Jun 2020 08:49:34 -0500
Message-Id: <20200623134938.39997-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:49:45 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a37cfeb1-efc6-435d-2d16-08d8177c4a86
X-MS-TrafficTypeDiagnostic: BYAPR06MB5192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB51923E7454AF102AD294F49CBB940@BYAPR06MB5192.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6ismIKAqDHh47qaPlHHK5kTkocH1Po5Kv/My2kbOq4PaRRCoiJv8nsyq7eXxZ6mfjSKK6sCBhgqBrPtoWImu/6ZhPSrje99KbMurGH6+6rEzSW0qTWV9EWzqX630Mm4gUoIw8uU0Sq20h2FS6hS4RztrkUDErhO7tbhrxR9pq3eWDIJNW9POO4MWUQXBuMHFIIwe+Vu5Ivn/OH1X74E+XVqq4uUxrbcC2VV4bJCvcH36chQrhnLltmRv4/nauFN/5LNYqO2P8GP18QtA+x/JRcS/pLlU8eqnsWjwIN+i6TuCpUJSViErS7EbnU8BG0b+VSnsHJEby204GAdQxIyGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(8676002)(26005)(186003)(16526019)(66946007)(6486002)(5660300002)(4744005)(66556008)(956004)(66476007)(36756003)(2616005)(107886003)(4326008)(6666004)(2906002)(54906003)(1076003)(7696005)(8936002)(6916009)(498600001)(86362001)(52116002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XdgTBOOKqVjYH2WgxiRPd6LLO/fvNiRPdae4jtteM4RvG3ly9WF6fPWy5ljw3VKKeRyW0EHIC2LUbjEZtqyhBBgbKU/89qCokUHDSkcn2/mu2wRxieaHet6hwHYB4bbCMsplV8yq9u+LFxBNHj67Jq4QJ5eBzoiUnkY+nB0of45NShjtnavJT21k95IpDLQfiMunatHJfmsiJYrOtxsCH9Qq/em5ZIoZwjiIvpgXOvCZy0ac0xmK7m0DIQZljAhpiCpO4MChDK1187hlDAdTaPFK69sbr8isSlH0Tz/C2c2DPWBJb8GA6GGSOiYZWRR9R0UgvFHf3CCfaVg2mv0flmYzoQGTAQ1/vqXPDznkxWaCj3FvfIN4zGoKN0n0rxQRXtXtqFvZaoHkUu5SOWQBxUhkgiKmgCjm1NdeR9hvKsC0fNLorLfJso2D/mRNEsYCJx/Aa3or2Kbqnz4D723tLjZ9hm69wEMmDry3w36PEYH1jatqEc5uArG3D+Vfn43t
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37cfeb1-efc6-435d-2d16-08d8177c4a86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:49:47.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IRpecjvIH7rLUswPDGWkGEI5asAH5vY6aWWP+yM4F8FnnhOihZPnvinlkMMrpnOfbKm52RRMfUv9W/WlpjmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5192
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

This patch series add support for offloading WPA/WPA2-PSK 4-way handshake
and SAE authentication in AP mode.

Chung-Hsien Hsu (4):
  nl80211: support 4-way handshake offloading for WPA/WPA2-PSK in AP
    mode
  brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK in AP
    mode
  nl80211: support SAE authentication offload in AP mode
  brcmfmac: support SAE authentication offload in AP mode

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 49 ++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    | 14 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |  4 +-
 include/uapi/linux/nl80211.h                  | 51 ++++++++++++-------
 net/wireless/nl80211.c                        |  9 ++--
 6 files changed, 104 insertions(+), 24 deletions(-)

-- 
2.25.0

