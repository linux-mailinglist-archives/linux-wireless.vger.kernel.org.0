Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BF5245E15
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 09:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHQHdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 03:33:50 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:42094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727125AbgHQHdd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 03:33:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8BE8u3o+LEwSCOuYNh6d3BI7jr6soFc3YduYuYejSCy7gqDNfTPlA0is3Fj/TUiCD60vpWwhmSAHr2REmaYBJAkhd8Tmsvlld6bCV4yNI//w48LS9VR1/gltyE5Gdo0Vq2etZbfnQtt3+uHw/vvbB0xpMXvB+0yOtv3KU15lFtVestGrdaUiDRiYyXRFRcQKQhyk4JKsM+U1I4PI9KffOUY+jHaax1yzzFomaleaaTGQZmRb/t+VFy45YzQYScWCRpEnuB5vQfyY3NSnoLrR6/cCmcyHhNDKwCo6rzqy/UblLobi2ddv1BFfs3E7b5qK/ks0xq+EEsD4gFlMi71hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVOpaXmeigkBnNGDPWJ4yj2dbOuzueNsfQp2xx4Wix4=;
 b=aiOpcENlswglWHGAOO4iG4Ty3AlhcnUNoEtR738PGU4mwS+lMjXWYTHjulkZfVmRQyOm5kIZwJXmSsX66+0m8i5u7YBJQN/e9628nVOTTXW9cHMWaCl9vpCh1UlEyjEYpCkHegK5uHDp41XYIbf2r3lVvfbOkpft/bmV3ZIn8Ge3JGCEoarKH7p7oYX/FybBemwdc05muNEMpnRRczzPwPyGYgu3s74ladYYkToxn/kT3I9noH0/eVOkPEQFwh5ui16cmCmmw/6TOWaR+gHb9fEFx9beURtZ/pSKCfmycrq9JrlNuJjKfOxKSzaZ+RuNqAQb2xlwszH7LYEDpyHWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVOpaXmeigkBnNGDPWJ4yj2dbOuzueNsfQp2xx4Wix4=;
 b=ZY8vekpjD3aoMcmtw9J7Lfs3PSoQjYEGf9aWH4FTYk1QVk4NMpvHALU+vFS+fw811/VsnHRdSejTXPervZMGcJ5olrQOo63YiXo3bf0YMDit5mHHi5e4fsdxLyDBz3liLiPV24wctiPiCUKe0e7roEk/GYmoC9cxLrGwPtxAoj8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN6PR06MB3043.namprd06.prod.outlook.com (2603:10b6:404:5a::23)
 by BN6PR06MB3009.namprd06.prod.outlook.com (2603:10b6:404:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 07:33:30 +0000
Received: from BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e]) by BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e%12]) with mapi id 15.20.3283.020; Mon, 17 Aug
 2020 07:33:30 +0000
From:   Chung-Hsien Hsu <stanley.hsu@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
Subject: [PATCH v2 0/4] nl80211: add support for WPA/WPA2-PSK 4-way handshake and SAE offload in AP mode
Date:   Mon, 17 Aug 2020 02:33:12 -0500
Message-Id: <20200817073316.33402-1-stanley.hsu@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To BN6PR06MB3043.namprd06.prod.outlook.com
 (2603:10b6:404:5a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 07:33:29 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92b03d70-966d-4a80-c97b-08d8427fd65a
X-MS-TrafficTypeDiagnostic: BN6PR06MB3009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB30095915AE48A717BC300495F05F0@BN6PR06MB3009.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQqDAn0j+nK6jI9iN04LCPD/YS2cACIuMvJ6hUZzVqTuUGsgcRtye9ALhKvUdCgAOzMMMbPcGmOdUjq3bmmrMC5SZtp1E6uBDUAoeVAA0dJGmBqAAgari7wTDHMAJ1tFDfAj0geMW+KqmCNk1PBPqKlKxA9WBmjuNlxeaQZbUKkP2R67726yQ0Tw+5h+PyJJqSyFMqet1qJeNQWjwluiJ7bPPBBmL1De59wdkb7wAS/1hbwvMbmtCH3YhWvARpkM8qsX1O34Y9G7JfFYOcSpo8i5wqJsbhvMUvLwdfs4GZtxwtvBhcHkfRvzNgS65I6Vre0YSeWq2Ve5rpGP1neoyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB3043.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66946007)(2906002)(66476007)(4326008)(16526019)(83380400001)(54906003)(4744005)(66556008)(186003)(8676002)(1076003)(6916009)(5660300002)(316002)(8936002)(36756003)(6666004)(7696005)(52116002)(107886003)(478600001)(86362001)(2616005)(26005)(6486002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: b3PW9p7Ffi3SIGmCHjGAif5DefeG+mZ3wEXT0R/mWZ6jyivbFSZULnmqjV5J0hGp15AQjGUCgxEQWdqckDcg8MwmgLK9sGjANMmkepOTT91AnOCsyhAQRjrsT4Ify1+5SYKIjQt3k3LkA73BkrUkKKl3iWIAG4nJNyFVCkXoT8yN47c1ZOpQJK5uoTK2gNqUy7+YqBaQPL8Tr1wU9LVGSEisQhXjs6aO1gdiBevxfzITjYBIOqz1agyrhWJEiIlYArRwS+Kjaezp59SCJDBAE+4C8RVud9kiz4u8dDeLVVf/kjUGQQfkObCtO6E++wzIZYHhJoXiuEYsi05JsNeHpI+243JnHVO1yv1wtCAeize8pNHV0oCAl/oUbV0sulyvbuxNzd5xkYARUV6r8xav6vMuIDeb4swSrcG2mVeOKESCuCPDox/ZOiARbkdZkZFCAs4N4yojYZIHCqRwui2WEyCO4qXO2z0bWVXjZP088OYA3871JKYuwUkHMvEMmtesGCS1xiHmqo/lSHqNMBNY5RDAYTefEmlVEhIR2lTk6AEEOv+sW0TceHMIk4NF+9R0/nn9kkg5T/md5zIG7dw+XFW7I7/9O0imgI6jbxkb9CR88syDgAcWx74IDaNYONIVLg9hsa04sATfH30r0pJK/Q==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b03d70-966d-4a80-c97b-08d8427fd65a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB3043.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:33:30.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayDF66Wn/f1AS8FaB6Uj5wdpS1tLL8COlQWniVlTqq4OpeuRHennumLKR6r38+sCD19ca/lbbFJZBNyYiU4cqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3009
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series add support for offloading WPA/WPA2-PSK 4-way
handshake and SAE authentication in AP mode.

Changes in v2:
  - add a new flag for SAE offload in AP mode.

Chung-Hsien Hsu (4):
  nl80211: support 4-way handshake offloading for WPA/WPA2-PSK in AP
    mode
  brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK in AP
    mode
  nl80211: support SAE authentication offload in AP mode
  brcmfmac: support SAE authentication offload in AP mode

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 49 ++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    | 14 +++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |  4 +-
 include/uapi/linux/nl80211.h                  | 55 +++++++++++++------
 net/wireless/nl80211.c                        | 13 +++--
 6 files changed, 112 insertions(+), 24 deletions(-)

-- 
2.25.0

