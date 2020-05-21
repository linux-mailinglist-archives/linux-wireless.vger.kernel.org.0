Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043F51DC5DF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 05:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgEUDsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 23:48:51 -0400
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:9153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbgEUDsv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 23:48:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfOcJumaKiaT9PUPmpvrNNPpoZPkV5e9e6m22VVdS7Lj8CtMwYv/IUuG9RQE/BYpZ15gD7/rma17QgmgoO5VC6BE9aGLIapdh6pAstnE7Bn1K0dQvoWMjvSh1fpKAxA2KXyXfZLEaYZJ5RmOzPzWyrw8O+iBz0/xo6Uj87I68WvUddDL8JkUvPTgRrIFHeyJSfoPRh/YLAh0wtcpGNnQOGGGfl/O2EL6s4/lPvlMeo24E1hKpgYorpy0Oa/Z5n7pd9PUe7/C6G5hkDyMDetMlSdqpf8yTzOP/n3aVWc4LIxPREzS4XfVUk6AzHrot96TAyaEgih59LzXbFMu8H8U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMW+gww0oE+9Dg81pOnyAz0k3YdMlh0i88NRmeDXQJU=;
 b=WrV+jOcYanLrboy2x6fkq7vvK9wvjtlaqjjzq0azzVe5V3p+GH/f2sNeOxlqORMmo0GgUcLNmpdZ5otSQ1DcdWQ0+2KLzHcImMxTS+HPLEGidDyx1sWdGp296f5UcaDnnRg/JhbgCjWX2Ziehq/fXHWd8dDINXhG61EukY9UPlLv6OJcOZQhNS6zAqxqocuPxY+bMl9uAKIG9fovUbsobT1Z7D3njYV/vpBDlIuId8giFSErAbEWGEh80sbnm9fFHnJHvjVTCwaedBoqjPn0xVyjnoCJ/ApIH0tNWJal7FWr67HT/1MsAK3kmXNgrf1rznD3wXupUcaeX0wL7bWXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMW+gww0oE+9Dg81pOnyAz0k3YdMlh0i88NRmeDXQJU=;
 b=CI8qZtc69KRGkiHuCn8eZvTW2y/JheQJA3MGUlXLnv8uAzKKIDolYmdsDY16+njrD+3wCKmnQPE7iiPjP2V5iK2hisXthz+HEiXptguHQRxuAnnk2Nf6jO00xDF05hocxi3nOOBhhG7EKqilcsrQuGBLHixjUULg8QWLhSeo0Cc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4024.namprd06.prod.outlook.com (2603:10b6:a02:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 03:48:47 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:48:47 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 0/5] brcmfmac: SDIO parameter change series
Date:   Wed, 20 May 2020 22:48:33 -0500
Message-Id: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 03:48:46 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0d0247f-97da-41d9-8418-08d7fd39dda1
X-MS-TrafficTypeDiagnostic: BYAPR06MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB40241735C9886688D68A55B5BBB70@BYAPR06MB4024.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpsbM5TNJLA4u+eXlTvQOk29Ajmc8Hjf2ndqARKgjpNpVdMJTh0SSpQIlsCMwpxkDHySCLZ4JLyY6wB3lkGRxcUXSfd65qYFeqHBohu3y+m5fhHLXKgyYIv9zAtE09ytd3QLmV/3aY437mCxUMTu9/tb5wz4PnW2G9VBCH+pWOySQKzoc/I3D8OWEwdedlT++jXJsYbgU8wUOR1W93r2iMwGPb+cUjVpHdlQ/zYnAdGJLlCQ6wsF6Gd56OEzNpGc6tYfXwjKGhi3Wb2OuLxRV0IdBsjo9L256waqnC61BoYgq7lF5/qZEadEndLV0U50oHrHHSJ9dmlZOZ//T1Q7Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(26005)(4744005)(6666004)(107886003)(7696005)(1076003)(52116002)(86362001)(16526019)(956004)(5660300002)(66476007)(66556008)(66946007)(54906003)(2616005)(6486002)(316002)(36756003)(6916009)(8936002)(4326008)(478600001)(8676002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: eB2psFAtAOP6OBLfs7hF4qkQToUDkKsCuVJu7f4tc9JJJWQS20Hk0SIUg/BLBkTfZa0/TAr+2JTDHb8Y7QYXfwM3uSWY5YMuFv0i/8ODv2o+Jp5DgA28DRjNI1S7E7S3y5neksN2+yyDqafXxddjyyQKid+nmOty+A7fycgQO0iOCgxCJwKNj9W0BiGdzsHdNNYKQssV2zBHS9nqt0q2s/LlgUPihDoYyI5xFKOg2lF1tyHil1BoSDH04JgNrgo7AYCK+5w6+3JXT205r+FHQ71xp/07/oSEr/wvu706mtab91JfwChEFtmEH7d8wuO5QBT+nACdpQK9GN+ZW5I9tNx66fO1MFmt58t3I6DYNaWtJviZszmrUwmr4KAk1z0xcKnWwBNtZuEflaZ65L1rWpjawGgY5M0GufvpAZt5CDiQXqigqABmKEMNhVn8aI6KxiIFhyWx1nB+jDi9ZNzAIFsHoL2ji0wzcr7uucpE0NNaNIQQrJ9NTdi2xlyMuco4
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d0247f-97da-41d9-8418-08d7fd39dda1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:48:47.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bdzW/5LxUm+Ylf9cP1BH8DlZuIJErikgZcYa96Ob74GT8WfJIflPXVuv5Dx+CiLE9OxAJo/RVcc4uVHo0RFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4024
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set F2 blocksize and watermark for several chips to fix bus error during
stress tests.


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


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
