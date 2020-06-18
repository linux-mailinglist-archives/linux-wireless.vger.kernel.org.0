Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1AB1FF8BA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgFRQIB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 12:08:01 -0400
Received: from mail-eopbgr760112.outbound.protection.outlook.com ([40.107.76.112]:7750
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731865AbgFRQH5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 12:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkkJC7oIgQFWIi2f6/hRRmIw06LYzFUF5o2SLDY549CuUNcgVSlSG91ZVIExTdBHTdkv4kJSiSdSiYJj7WAbzPWp+BOllNECr2gaIHbG/HnJLLLp8g9GkaPnCXs800xPeEYQYRzxATEMYjblXt2M1K1dcbyVouLF6B3yNoIGGNoGLSJuQVA7Rx3syz3Ys7ZBzAvWVwHeUPIdWh7FugbQLM3n13Q1tpuhovDN+dZl/4NwOMM0mi8OSO+DuSBClwFDAFmVfaG2iplxGre3HDKxB6F/RPCU1py4AtbQWC4PM530Jmnj3ql9zwzuGh5NutPf16DwSMy824mUHKLI+jB4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umgzuWmEF8FoNZP/KUMlsV2QT4mc0TRCzl+Nke/DAHc=;
 b=REodyBQ2zwfH/Wwo4CezpAacCSzn0ctrIyKVLCwCcIt6T6vRd+xd4oc7ayD2QkfAA3WnK++x3J61alYwSMY+fV/FK3F+Kctzm0Lw1dXLmFCVMGsPsfers6ChxK2U2iapIBeI0It/EBZslgcR60PvGAT471ubX4tQdzE64ZjmOk0zG75zMTQO8Mh4p4Yrv8s6ybOiH8aq/GZtOLVPqKsfees3PFPoZ6hzAokzK04288satgAL7BUqXg7JoahcsledAZHo8uHUL4idnYZnNj18Lf1Q9KIFZ0+A+hBG2YCwcnYtbHxg/Rmuz0vKT7T4/O+reRt69din71jYbHs0AaMryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umgzuWmEF8FoNZP/KUMlsV2QT4mc0TRCzl+Nke/DAHc=;
 b=kqOcYpjdvl+gIU/cPtUL1mLOaqxWl91lP07cxvXMKPRjvIzWPiAX7GaDm6AciQHFLfMdh/mUx2R7WubR5PeKrqOweZPe5D1STX3T98osPkctJz4rHGt+kLCkESO3Epi1kNrMHacN44t3kA8GsQetzxZRrzNVPXOPSS6S/71Ox6k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4549.namprd06.prod.outlook.com (2603:10b6:a03:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 16:07:52 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 16:07:52 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 0/3] connection related fix series
Date:   Thu, 18 Jun 2020 11:07:36 -0500
Message-Id: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 16:07:51 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e9dc4c3-26ac-49d1-09d1-08d813a1c0f3
X-MS-TrafficTypeDiagnostic: BYAPR06MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4549322C8CE683C6B7EE049CBB9B0@BYAPR06MB4549.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6lAPSd9xEPrvMVQTBljMqJBRKfY1nVIOHgQR1hzsRGeLUCdk3Mn16M1qmxEqxONJpQLCieRbaSRu3NXiJpntI2tkDgpV/c7v8mfjX8VOiXjZu4qtkRI7Gep7K2+f2/wm/qhWS1V5seHUaZHpGf1IREWM6N9AjrwU8ZaKph2qdA1kCraMJSeq+rLdEaa1o4gHuNLQnXyuz60uvtMsjwd15Ulfj1GOCu48DAxW8yI8Et7wgzV7qmmSSjKwn6NJQhKmFmjK9lreGXo8VUF982kVgAM3J0zU/zXD956Ug5FSMZ45OnxS7NVw9O9ickaA5fPIJSrGJ4zvjCv9UmgPjZNKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(107886003)(5660300002)(316002)(86362001)(4744005)(6666004)(16526019)(186003)(4326008)(1076003)(54906003)(26005)(66946007)(2616005)(6916009)(8676002)(6486002)(7696005)(66476007)(478600001)(66556008)(36756003)(83380400001)(956004)(2906002)(8936002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wIMWB2vf/ZM1NR9Bi3VxfMy+btL5e9kuQ4DdBJQfU5eqfxwpNbhNaeZwDkKmcze1WpiPgSt/Bv7MILq4slalnE6UhtLlnGAKgr8C6sQZWIGu23FNhCOwXLmv6QG/kebeDQk+ngx2y22L4MRapAdd5xote0vy96Oh1kPQOcY/K6oxWFQdXIzfs/HyVu4Cofc2ufnIpZDNp9LqcPmieBaKDQ4mVuMmuJaSHcdxz7Cqf1CggLngG8oBc+o/zM22tNztYwbw9ppUW3/RD4mHM/1wQtnW3gJukrjWibNTvwa8Dtdt/vCP2tKi6sJGQRzmIkzmmARLzJWNSQ6MaSubcXRFt746bB3f6b3R0iuKZ6FI6kTfikD59+Cl8DdxcmGSc/o0X1ELvmYCglp6LqWhKbJuSyKOR7SNgsKHRpQ+ig0eMrAeWFTvjuWG9OKI8Re/94H5fUP+ZufP6a9e0uhG8Vz8D6IckIBNGPoFyPyGz/7dsGMictIHiO43fbpuVqdJA1TT
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9dc4c3-26ac-49d1-09d1-08d813a1c0f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 16:07:52.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OhGedCIx8Dg8nlSAL/K9Wp4aQPVBffn1Y71apkWExe45nLNxVSdSE7QntnvXmrViu8TCDI8Bi8M0qeg0kSU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4549
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix several bugs related to connection/disconnection.

Able Liao (1):
  brcmfmac: do not disconnect for disassoc frame from unconnected AP

Soontak Lee (2):
  brcmfmac: Fix for unable to return to visible SSID
  brcmfmac: Fix for wrong disconnection event source information

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 38 ++++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

-- 
2.25.0

