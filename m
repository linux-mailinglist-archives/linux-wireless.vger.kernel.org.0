Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7033AB81A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhFQQEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:04:48 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232720AbhFQQEq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoJz8WqEDn2c9DdFxgJg4+h8A4qbVB7LOkdiGKh6faABgPoSnZAMgDuXw46iPDIwfWrJYzqX2U1HvOW1cz2Fjl/9FL5BBSPhbvRzEy78yuyd9mazgnd8ZKaMOuV1L7GE73SnaM2GDPpn7vnoOXlmNeAT6nURk9zfZDhZrmw0w8PWK4SDheYYf2IzXApj5LoDrk1IsMhNQVJMr86alQiSWpIAEVvBT+iw3CSFYUgUF5+JzNs4LwdZikwMyaYEvxo7SQEneMWJ2cY+mOZLPu8gzbunI/9cTm8PspFGIPVz+p1vEO/X2b/KgvZ6fjBoi/Illr8vIcNKNTCMKdickMPfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Eq5eCUJiY4FKE+kCl/wofbx2ZPACHENaDoH9EUcKI=;
 b=iTUEMuytT8XxgBm5D4Jm6nolMf0oeUM4AWGtYpLj1lnR3y2j8mqrHijApPcKMzXC5NaBYDPH9Y0ioD4IfnV7O99kAAZ8HJxi5iRUeFBRRIKMxRritE24aasN9W8mGnur00i1lUBE1k6TM+guGa9pOxaE6EykzqGQN1btj4pzGroxLP/EOo0NvrCSYLHZN1epmIcPEs5L5Ud8fqFuuHs/XbIP1jAYswlhRr3OWebeONToP8wOfDS6y9tS+PkCqmS3TNYLG/bBYJhHhF0AmnhNEd246G6rJotPxJJpUEDQXy7wFeplhxNXrE9DCCAkcbhBDtKycwkd0RlFTcz4/Gg2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Eq5eCUJiY4FKE+kCl/wofbx2ZPACHENaDoH9EUcKI=;
 b=RDyzupIx9rirh3EJeWyGJ0cpPr48A+xCR0p93ChRTXuq+/qGTnDGb6SZVYeM1vh42X41S8QPt+fHJbgWXNanw9ouN5aeJi1DSwH9HuqIifTwJqV0yjEOP7PB1ygR2eKqCb2aSoe29zEmU2vxPYfhQc7stD2G3FZMnKobBTG5f48=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:35 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:35 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 002/256] celeno: add Makefile
Date:   Thu, 17 Jun 2021 15:58:09 +0000
Message-Id: <20210617160223.160998-3-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c92e3a9c-6489-4871-270d-08d931a9525c
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB141227ECDBF23201C10CCE14F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2XMa4O/a4K+8I2T6hgkJWjSf4+YpBLjjFBPC5TxS9mfjsDY+DhOMX8h33PZHLXoSeqJum0zgZXZDNb8EfaYAydqbSKg5968plqHHYT3opSNLRoDA+4XPiiRcfldU7t01l5KrgtP2D3aCbi5f+behsuanpbzTcS/0Rnnmdbn9Jca2W+plWMRgclFzRH+HVKEQBUUcUDrB9TDBgqhgQksRkduiQPqDwJYgJqkELjQUTQHDahI4k3DBgD/2gO1Dk35gK1CRagsETQQnQjv642mgJKM+89g8r86STwv9uVZr3J9yYXi8+gcAV1n0zjMLbraw0Lt0AgjTXLcRPb3wg+FcJ6P1P310Gez9HLRJpg1Sn1GRnwpIZ0o/yEmvSUdUXdj6sbRX5GmS9vUHF7b5GavLVWrrpxPtBSu8NDqc6U1NY1RJPETYR9sKyPrGvLhjyv42gfWxmixzCd8IVdCWK5/85YcUBJEtsPCrdOE56eaeOzF1HaRn9HTIT1kcADr2aXDFg6bobKBqxB799qFTXm6BVXYwyndTcOkcNJZHBBug4FfVDqmphqg/Bb5crrhVBHGXA0dBbdyPAjjRbfL9JkOwtuWAiyUS6gt3tMU8VROqbcXccoDQODZoMDm8FZ91dfl+Dj4C+IIWgY0uTsYmyJvym4kMdfdAke1KxKkEHyxO4IkazHIr4bq2bGfxGZREYJS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4gwdOqRRLcS7Zn84i0VquvjWcW48XmePI1XcPVQGVWFiVF28Wx0l+lsGhjZ?=
 =?us-ascii?Q?WxSLCvxIXkvr+PLGKTsVGxxDHtGCoOMVH9FDIFEGilju6YVEFjqOfEbydE6R?=
 =?us-ascii?Q?upPDU2Y3L7aB58C+DMBGiGwKLMsZZ+w6jGy/r8THQ/a6stpRTbaWpdCTdKXA?=
 =?us-ascii?Q?zmi79ptvhZ4S60cUi4AzrJFadWOmsZE3iA0cxw0l5Eqd2S0tx+JmRF3G+UOA?=
 =?us-ascii?Q?EqwrF9AI0qjSQgmOM2kHw5FPU1Au/ALsAe4NR4tCwT98REmfFz93PkByn6V4?=
 =?us-ascii?Q?6hPhwRpG3WfETBwoy6rGQrvWCKmFNKN1l35mh9kU62SRbIDcKZbQoaZEHX6+?=
 =?us-ascii?Q?ToJ/M8QpC8Edxqh2ZB/Asvkch/Kd1tgAIEOVjd0GF71eyPg+wJtJuWHyD7HV?=
 =?us-ascii?Q?wC4gJ52m9VNI01EIMYEN5OCCCZI09SZ6mgrWTsUyFA/whkGBGr2oPShawIyh?=
 =?us-ascii?Q?lR9ukjpGMJwM1NlD9FQ0IQkINJgXTo4rfnALGYNIS0r0cAT03dL5zWHi2e2m?=
 =?us-ascii?Q?7gso8hY3FGSjpuQ/WfvatJ/GcMfrx9QU2EIGC9VdIoBafn4aEq+ticZzPHU8?=
 =?us-ascii?Q?rtA3Bg3e1UlDZ1FFMo7lwRE6Q+liqNl6T1hRsvCUcteWJAiAzLzCPdiYAXLC?=
 =?us-ascii?Q?FazSF2LGEsETVKNZkt4kO/0iMDjoI3lTMkx8bzu6KxHLwUaKcCsRvLyYNoL7?=
 =?us-ascii?Q?nR38rBn/uh596A2eNA+j0IlYo0yAQhUa/22VQTlb9D5cszsx/LLcg2f2J7UN?=
 =?us-ascii?Q?Fv78SNbRntPdGGg8ZjY88T43AEfSC4/gRpRt+3PzEQcDP9WJGyovUSZo4qf+?=
 =?us-ascii?Q?TP32JTOMSkE84Z8Ct8TKxKER3HFapneS+BI9leymcxVRijiZOyKZa/IuPjVF?=
 =?us-ascii?Q?W5RClKK6IOgJadGhTz8gg0+dzvCk6+ywlfi0rsFrAIlKj390xh5JtWv4mpYF?=
 =?us-ascii?Q?wGwCrxCoT8oll5hK6aFNqDvP4jpguEu2pNvoW/j57qzFBLUs49OWRYdIwUp4?=
 =?us-ascii?Q?XInm8pNPNAiLmF4AhFoCRaUB/o3N52qSlZYz9T3cfxYtrIhu8nGUiqOB3Fjj?=
 =?us-ascii?Q?0zw9NnxBdXmOMtS4jYz+nrbDqhKTxdAW7Al5gOpJD6MUO6lLIsA/skP+1vor?=
 =?us-ascii?Q?ltn3E8Savn2aMC+ePdAaezZpONeV1c34e7gqeCfqz19AD1MgVFTuatSU+v2K?=
 =?us-ascii?Q?Dxjq6EvF/8k3HSVLVo2+8ZvrjUElZFuqhu5yvdkeEqBm/e9I3vOPQZDBM6+m?=
 =?us-ascii?Q?YNqDImnKCjVjKE3yOibJTIf0Vcl0l1N+KJeroK/j9Mvx48SQgWaLegb0HeQb?=
 =?us-ascii?Q?lk0WyFSI6RCEfe6DWeB9McyZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92e3a9c-6489-4871-270d-08d931a9525c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:35.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFhjJ4h/ZrvfOKugurFrJ2qWu21wRiA44RC4gYiZqI98hvnN6Z4ahro0sAebFh/S76RFqNwhQBHrMKyJvQcWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/Makefile | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/Makefile

diff --git a/drivers/net/wireless/celeno/Makefile b/drivers/net/wireless/ce=
leno/Makefile
new file mode 100644
index 000000000000..b1724b81d10c
--- /dev/null
+++ b/drivers/net/wireless/celeno/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: MIT
+obj-$(CONFIG_CL8K) +=3D cl8k/
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

