Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FDD293310
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 04:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbgJTC3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 22:29:48 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com ([40.107.75.103]:52961
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730463AbgJTC3r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 22:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOF7aaXL8Pyn2JH8Q2p0IorLZJy4i89/ndD3QT6ondLyXG7SU+LwnH627+nktHqJUrG/+tuFJWc2JqJ2BQ9KRPGfG7Bui1OYnLgCu8FKVAe/jYGaR7Bqru0J9LUxyK75gwXA/moN0QUTZHxvCtPdZOaeqBOPT7RHs8vDP25ckdsSSMXirt6eDokbvm64x70V+sjAvDUGixg5RNwoMUjXQCMoxDqIETE2Y61Ty6GnNjvNE44qtqbNMqaXSI2rHKnNm8feX9TsSdPwdDdRxXp7ItoyEWlkjKKjCtvOUU28TsER2AnWrSIcoA7rNeQDJixLOrqt2ziNhTyk/ltN0zHt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JQtzu38erIUa+kOVuKvNiTPdNh1FQWy7o3zNpoVojQ=;
 b=T/FgT4WcqHULLCEEnSy39iFEYfsg2+WUFQkE3qEkJG6Z9UGODIp+fueCE5RdwKTzRQrLx1qaI7sDjghBLb2NpSRhLDO6aiwANzKhbvmOgekIaenFlbCNIEEVSetrW7kNlWWFMlAGtiUIcZ3GeNpQ1LpEtjGlsiN3oXXKTNVyrVLMM2cLSa+olgMBug71oxJ2fztyBqchwi898eDaPHCNOZA+yvNzlZ7+BrJlR6DSnrHoM6jVP7B2F0DSpPzly2+nSuO4toLckkCq497P1mrsBqApkyc0qqZH/pDLvDIBBVXMuFaH1vCmWrs0MZFoWhW034WGD5dnO2aKedch7bxifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JQtzu38erIUa+kOVuKvNiTPdNh1FQWy7o3zNpoVojQ=;
 b=W4fPTHT4xPqQL8C9ujFW6mxiR3Sv9h4U7+b3CZLVUMxryJMuBnEmQH+qTKDkNLdpvcknzlSG0aCzMzgcPPLT2ocpoiKgBw4r6okx0l9cmz+eCDOhayA1IvzvOr6kNvCgQ2DexxfL1NsjEcUQNxTUwnvNPh6rSV/+CNsuQwV3my0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3251.namprd06.prod.outlook.com (2603:10b6:405:3e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 20 Oct
 2020 02:29:36 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 02:29:36 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Subject: [PATCH v2 0/4] brcmfmac: Add few features in AP mode
Date:   Mon, 19 Oct 2020 21:28:08 -0500
Message-Id: <20201020022812.37064-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 02:29:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40759270-41b9-4c8a-7255-08d8749ffc6f
X-MS-TrafficTypeDiagnostic: BN6PR06MB3251:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB3251E213A012AD038F5BDCDAFB1F0@BN6PR06MB3251.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6s68dPdQqNOBU/IanJOrzRW64EFIa8MAZaF3e0wdUx5i8KMkgPcdRv17c9chuYblyl4/ktLD+cLfpYkxHJallhvtHvixsLpzw959c9qEXzQiuiXRl+2IJfpZfIwGo+ceVyE8GMovw/nTXdpuxk0P6izelh5fmuFgNyQLHp1PGsfK9mqYKVZ4xihTzRJJSt0XPxf9cEWqwkudw9gcXIulKM0mGOZsAnC+34DY2ZqdjoADc285tgVJ6A52067Frk9/FaqApaERkUxHCsYRiVtI9AP7LG6DxY3zy27AEwF/7GdsXphnuMAdjNy8BgCGAHaU1aUxacbcI1xvUBNmUZd6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(66556008)(66476007)(7696005)(52116002)(6486002)(8676002)(186003)(16526019)(1076003)(316002)(44832011)(4744005)(6666004)(478600001)(26005)(5660300002)(2906002)(86362001)(6636002)(54906003)(83380400001)(36756003)(8936002)(956004)(110136005)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Rr/qitVqA0m2i1g6eVcnLC5a8hSZKtVExKKsZWGkPu8CCVq1Wj+47GAV7uMQoM8H5gIAjsRnWypN72q48W2knnK78OYXL9hDPk2fCIZpObuwJQNI7xAmK7JzTaFSKoIsK1Gtzufda56U+7H7/Cv8T/vuEP0MGiIBtjnW3s1xusw7VGD0tqDDjJhNNCtnT+cmHD3pYH8JNsn7TVh3mZ10IQxJoKGo+FRiY5+0iBrLwuwWNyRI0KKPF3JY568faWzkR3go9DE2u4z70Iw05OUBc31uGozchu6EwFgmlBUEdrbLHBT5GG/bljDwnY5QDYXWNXjqfDNWHgyUWVn6CCZB8I6tBSIg/mtscvAuVK036zQuGZ2G2pwswiKbO2tK66YRzHr/kaXbswiavQwWg4tbDoYRnl+/dyR/eVoGqNBYI19MNgf8EJkc+Dnlj6ngPxLNRzOU6Qj42trsr7j6a0QknyWdFbwLGs7OQ3S6VxBb9oRa/YyGbFmJa70jw26jiQjr+YEF7N5P3cYgF6siukqdz5tz7o4Zbnvz2XV5jxikNGbIdkXdoWoNfBlBOnhMHCzlag3VqEZxtyh7dVnZeY61PqHuJV16alcCctaKFz7XyRamjoNEaXUFaxg05oW1TSKFLeVhTfuxFcLd8Ylia5Namw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40759270-41b9-4c8a-7255-08d8749ffc6f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 02:29:36.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL/2ZdqiF2felNCiWcqNyVSppFjmS4wBCIf2ebrxBV8+T/BFjmFVqAj9znVkk/z3Rx1ypIU3BM4SPlVqmmET6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3251
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series add support for AP isolation and forwarding mechanism
in AP mode.

changes in v2:
 - Remove u32 cast from patch 1/4
 - Fix sparse warning in patch 3/4
 - Remove the macro from patch 3/4
 - Change conditional statements in patch 4/4

Jia-Shyr Chuang (1):
  brcmfmac: support the forwarding packet

Ting-Ying Li (2):
  brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists
  brcmfmac: add a variable for packet forwarding condition

Wright Feng (1):
  brcmfmac: add change_bss to support AP isolation

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  65 +++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |   1 +
 .../broadcom/brcm80211/brcmfmac/core.c        | 117 +++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/core.h        |  18 ++-
 .../broadcom/brcm80211/brcmfmac/feature.c     |   1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |   3 +-
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  31 ++++-
 7 files changed, 228 insertions(+), 8 deletions(-)

-- 
2.25.0

