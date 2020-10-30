Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A732A0087
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3I5P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 04:57:15 -0400
Received: from mail-dm6nam11on2127.outbound.protection.outlook.com ([40.107.223.127]:14679
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgJ3I5P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 04:57:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asrXq3lp4D7nlmIPfutd9Gtbs9Bjkr2TGUytsbWO1aonfLUgbV3ClixkIJPNM/Zhu3FkhveBwgx6JlFO85dbOtQTu6Aw1y50b690Kx7kXat1ANm8hDaF6QgMgrvC7+sqmsmeUC0ROXM5gaL7Qea5g4L3xPUKjmmoihOB2Cx8OBPhNzv62GHO+eq7+wM7rSaQXiOXKAze5pWjuHH29aCAUlmXkekcaQAH/I4wQCRKWmVO6grYUvzghHRn5PhbHF84iS/TS8+6PLdSQU+HgMNhdnEgfOao6V92FxKEZyXDrpzcLf2gFtDEBAIftq7mDvKBB7DInxOwiMeRLQpI3j4f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8EhKZ409WANx7vv+9CB/N+oTFCc1flxm1/lTmvSLzA=;
 b=ksJhnYXg3DKw197ONvVtTOMayiAo2Iqp0PIMfunt17KylUfxKLEued220Pj9/zVM65gUyXKDnV/wRE1+TILnIzRIV+TImc8YStEKQxw89X4hV7Dxbv0kKVhEiN9c7zW6nr/ZawhCrNzEAzqhUVBrFRCYDDEBhUwBPW8+HUXhk5fO0ytsEnJ2CmEWQ/my9vV0ri/qHzmplk4JlCm6cCf/iQaqImv6bHNAmrfcdd1rb4qQGXi2eGo6obeJtGOrTmyXFZW6JjMJLcdKXu2PnwEH5apVNtM1DMfshxw/TAyFK2ZR66nr3VxFtxGe/9cB9M8lwYW/VqXTF9d/SUx7Q3Odvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8EhKZ409WANx7vv+9CB/N+oTFCc1flxm1/lTmvSLzA=;
 b=DdQtqSQT9nAJlUKiUlzDVGma/q2+oUTsSTsPZ8BscV8VIsqsI3JFkP/da+eUroiFF36r5gcI8FMNfUBo+VGPgnagZ+XD9mqewAh1ncNSDekwBtjG0I6hEw1Zapbo+REHQdr8EGHE4aw3XEEOfkz7/0MRAIhtcOD/KTBUwCc8eOg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB6168.namprd06.prod.outlook.com (2603:10b6:a03:f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 08:56:43 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::d54a:4515:ff8c:686c]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::d54a:4515:ff8c:686c%6]) with mapi id 15.20.3477.029; Fri, 30 Oct 2020
 08:56:43 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH] MAINTAINERS: update maintainers list for Cypress
Date:   Fri, 30 Oct 2020 03:56:10 -0500
Message-Id: <20201030085610.145679-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:208:e8::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (157.95.12.33) by MN2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:208:e8::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 08:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1839187-8eef-4c3f-4cc1-08d87cb1b8f3
X-MS-TrafficTypeDiagnostic: BYAPR06MB6168:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtFwd,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB616822F37CB30741C419C0D1BB150@BYAPR06MB6168.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8ibwC4r9Y5JxbE5IHxYaatT96za1OXygu3Ek0UBcv9OUb8unP8F9ppyLc8FObg0PCXAvJPBkdFTNbULUcPOzixeCYoy32/XCtQKr09zr59GvOLgSRebgsP1l00KSSAWp0W3PConevG+rE3+NLLGGbvE/opFt+lDbQmHVlPrkWD06gtEd7kqXolQ/z5mHtij8396/QKqut6gE2nTKHIeCyzbyqryVtfDBss/sPnVZg+D4nk4swy5+cT57rEWGXgw3i6qyuyXVUZSeYg9fyQM0xsBvtPxtfoFLb5kLoAaISXY/w1G7ewXpozNJLwWEuQk2DGltfMj6sb8YRO+0y8pfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(107886003)(956004)(86362001)(36756003)(6916009)(83380400001)(186003)(4326008)(16526019)(316002)(52116002)(7696005)(6666004)(6486002)(26005)(2616005)(478600001)(5660300002)(54906003)(15650500001)(2906002)(66946007)(8936002)(66476007)(66556008)(8676002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +Wb0mrQCRsU1oU/jXjrrvX/Zsmdj5W6OXvv5XRCSjoueeVDo776CJh65d2dpuBbUT93SvUtnOl15iWSxSNuV/Kbf9wLMKmekFd4fq1BNcS+cS7+jSqpmudn0MLE8jRgSkBLmqFDdDRgR7Dmqj7wKhTL51QZaLfgFHbfdQ+wP83pbwWAYAEXVTANe/jQ03Nm7zk07LgzrhaQwCV3PvyVFReRUpHHjoz7ckk6xMPWPQPBWWonE6mUDKuCGMpVq91qGpTdKpwZVKRGvC2k/4tiAtdSKGY/+/Kw/Od2lzfQpbWBBvqjE3N3we0p0308eDKuTe6/GajZuPwCWkITQjO0KV1kxM5cuVQz4TFaF6BioEguMfJLUtOVxj8Fp0TDYBM9RBACm0OfDt6DkMm9OejUSenwvi6rCqfA7v8tStRkS7w54EixvTXZ/CCvwdFXWRscZkk7xTjRRMmj6MPLfl0/TO1nPP7nguA62qqCqgCqyYAsRdqE+6G6FAg0S6D3RkH9rU2zVuVh6Ke5uTrp3Pe4D6MXos0BFDS8ufxplhjAk0IxPqgJ2hb91OEqzFBUu0q95X+ClC7/a4ULp5Tvc0nDvoMWMy5Usbll6e5BvA/serg35oOhzEbJjkRL7w5FDpV5KsJPhXlguqjJuo9Be2sf9zg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1839187-8eef-4c3f-4cc1-08d87cb1b8f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4901.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 08:56:43.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJkq1Aou5SDO96cbrTIfqQMImQEj3q958rhJ1K8XsKrOxPcQ+t1xdfz0DaKlTYnEjBP8jGNKxhfja0lT1QmnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6168
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Update maintainers' email with Infineon hosted email
- Add Chung-hsien Hsu as a maintainer

Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..61c573b8e567 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3541,11 +3541,12 @@ BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
 M:	Arend van Spriel <arend.vanspriel@broadcom.com>
 M:	Franky Lin <franky.lin@broadcom.com>
 M:	Hante Meuleman <hante.meuleman@broadcom.com>
-M:	Chi-Hsien Lin <chi-hsien.lin@cypress.com>
-M:	Wright Feng <wright.feng@cypress.com>
+M:	Chi-hsien Lin <chi-hsien.lin@infineon.com>
+M:	Wright Feng <wright.feng@infineon.com>
+M:	Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
 L:	linux-wireless@vger.kernel.org
 L:	brcm80211-dev-list.pdl@broadcom.com
-L:	brcm80211-dev-list@cypress.com
+L:	SHA-cyfmac-dev-list@infineon.com
 S:	Supported
 F:	drivers/net/wireless/broadcom/brcm80211/
 
-- 
2.25.0

