Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE61E73DC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgE2Dtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:49:51 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:15968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388037AbgE2Dtt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La2/0neByM03dMFTWtxmhYQyhC2M9KMdnyzYzt6+xieP2ZbOlHJGVOZXhLkwKhqjZ9Cedn+sRga/ygvJ6d8RHk2XVaI1LdvXP4lxBobb1ynCDLkyZI4KqR/7d3eIA98oTnrLU4iTZD43r60V7SbXr1m4bmzfHMXVebwJhXHl9RZ89VsG/soCzAHymxsSj2du+SBYYeJbqnRg6SAjCMgQjbE7gT9b3Xdcq1aIXyvHIuZW4JnywnwUA1u/qaTcqGBRLstwUxjAGygTC7sGPawXo6Ew7iYRV8GkTExOxQ9Uu4QMDO5GaE9vZLMYY964PC+rS+KwfBgl40s1l/2CfwW1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC3JZ7YSFhPrmL5DuM1c8D0/GvwHO1aZ3LKDY6DDHu8=;
 b=KqP1+9Z0lDjfTnCATm1bqD2yiSK0yxCuxPGYIY235ew84dDYKPxpbpEk/B0Kvja7qTw+gDYAh/DUcb5ovTfIKyE30vxL0YOiyB2eJ5hjmfMuz1jsfapoREFY+NjrDbu6fUq4s5+qsL1KIfoGjyoNenclYN4wrAoC7L2/7ybb5hKf9c43eeaQ/o7kyg+3ROrTHUxtfBw9AU1/c6/K5mv8LyHA5sDNu706uCniQnGGJ4zwOZpyx/3A5kVvORHeDXqxeWN4EimGA14igof9JsbyfS3r0ALq8pIMQyiKR6sydi2057ESqxIjQu2v+uau6R9Xee5Iml31VTdrVDj2F3zmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC3JZ7YSFhPrmL5DuM1c8D0/GvwHO1aZ3LKDY6DDHu8=;
 b=fwq82kH+ewuzfMMkMyOe63GcAVGIgWPBQ4yXSNQNzI1RX8xcEQ9zhxY++gqW54JqXuk9i9Y+9p2VDnA1Ds6rwVkNLUzZmv0N4hgLl5k152s8xTa7Ss6nqNrucIMt1BDxAOYaTB2rT5D7hEdMDOI/eO9Z3KFgNXKOrbJa9P7LuDI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4839.namprd06.prod.outlook.com (2603:10b6:a03:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Fri, 29 May
 2020 03:49:46 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:49:46 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 0/5] brcmfmac: SDIO parameter change series
Date:   Thu, 28 May 2020 22:49:33 -0500
Message-Id: <20200529034938.124533-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 03:49:45 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 043fd9b8-63c8-4e76-d287-08d803835409
X-MS-TrafficTypeDiagnostic: BYAPR06MB4839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB48396363C305CED27BD0919DBB8F0@BYAPR06MB4839.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVKdIR5t065bc2tNSE4PsfnEO9HJuDTp0U38pLKWIMuj3kLGIUZeeRCY7BMTXOBVBYpPlHCuFUbzs+mxcGoPjHuNeF03Is1xFS6F4X26ysV2vrfiX/0vtgx9FuVZ6f8mvYAoq20lfXRZTBf4mE/6vuFF6/Cuvt0EbEI5nwW/qpzNp/OTpVJG//03G+WaEa3fzoK2vVpJFEM2zPtIkuQ6O/7an+lYWK9gRQoUJgN/Cz7hAoZIlfu22UC32QismAaFumslRE3C9AukFPtaD15s/SPHhJt1wEUQpNDyDLGrfyWxcUSx/Cv0x99wfX23xwdxj7eTy8Qg2KqHyY0eccpKRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(66476007)(2906002)(66946007)(52116002)(16526019)(7696005)(26005)(186003)(36756003)(83380400001)(5660300002)(478600001)(6916009)(2616005)(956004)(66556008)(8676002)(6486002)(4744005)(4326008)(107886003)(86362001)(54906003)(316002)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ce9Ja9OrpCMzNo9OcwgeyKcU/W5lmdZ7YCeVdc3q3gGkVyIGLlAToLyX3frLGv0LwfRrWB6XaODctsbW3UgAe8tjjKpmNGXQVU6AyVb5NQcemeRjJ5oG5UGJyubpfezTGHCboD+cTacNchfjRU5qJ2lZ5c1jMuiWhcUNRJQqikgJmHQWWmgUoqPTOArYHBgo5BIdiHmp6OKO8Q6bl0Okw0rdWnDsQFcsfO60kiqHDRXNnse4ZwNRcn9/dgMPkB3LjfI1Rm9RmGufomRwXBMoqjDO1/xYhumWSaocuNR3zsKKq/mhkGDvPK5mCvcaeJOfLT+0UJp/xN7k0CvnRNtrAQ7rE9UELjQL1Brv2NpcCOwTaIEXstIMrQQZJEgNyKgHfD9DBuxCUEwPi8RxBRLkGUCjhE/oBuTOEydyK3dj0Xh6YByDvWVc6HJpJgcoTAnIn/snglWDS4fHuDC86vFJG4ifQZBgXVsjBXqM930O+9bBXPmKmccORWPA7mfbJ6eG
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043fd9b8-63c8-4e76-d287-08d803835409
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:49:46.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nSB6fRT5Zo+Dx+OzBjGQWHwBWPf4fEovjOUPgMfFelGPOtcjHVDufGZLDbuufHY53t7Cru8ksXDPvweuRhOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4839
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set F2 blocksize and watermark for several chips to fix bus error during 
stress tests.

Changes since V1:
 - Remove unnecessary mail footnotes
 - Rebase to wt-2020-05-25


Double Lo (2):
  brcmfmac: fix 4339 CRC error under SDIO 3.0 SDR104 mode
  brcmfmac: 43012 Update MES Watermark

Frank Kao (1):
  brcmfmac: set F2 blocksize and watermark for 4354/4356 SDIO

Wright Feng (2):
  brcmfmac: set F2 blocksize for 4373
  brcmfmac: fix 43455 CRC error under SDIO 3.0 SDR104 mode

 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 22 ++++++-
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 58 ++++++++++++++++---
 2 files changed, 70 insertions(+), 10 deletions(-)

-- 
2.25.0

