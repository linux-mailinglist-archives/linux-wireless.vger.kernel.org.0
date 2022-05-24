Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F253292E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiEXLhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiEXLhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF741F81
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9t3fdlT+36Vy5azH/tZm8r2cvOwcH7yG++WWkFGPrvIa+aQgjDzDGcFh7Ns6DhEeIpBeaOehUf5W55JZffiMB51ZTnlMXGbp4Eh/ZsoM3pXt3WdcJ5Dex94H89KpfAmg4fPnrP2tCm1ZmAKZlMklWYz0bmOd1omxq09sfYFwJUr1tw0eOqf9Op0wNq95dJ00ffD3cJGR7ZXfZU/BcDyTgdGyngHXuyiOmZEsHMm2wNRTf6hmz59v0Bw8a3EAbz5UsyBYAmniJu7UvdqkfK7vhx+5nC7xOtVn4bd4Jfo3v4b3mznBN/mCjpRyUgemFzY4L1o8FEFVUms/AmiHt5fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAE/vzEP9FkrDsZbpq8+7wccIy0yBWTgCP5Wew1Yplg=;
 b=kRLFsYDxLoiA38d2Iiy844NLQL9UqIWM7OinDR4o5LFror6+0Jc7RvUg8zkcUNSVP///bWSofNB4wbTy84WYyBUVyNSSVQzI6DRjkwT+p9xvpluIYRiYWOzJD4MQMhPuVA9ErOd87wQxnulXhddrKRulyd8svTD5xvQG8f+DAh9bloxxAX/5xiVfw1YXzfwCXvhUdIRUfRNBK7oQ+HZLfbn0syYbcJ4u9s2vEoxROni+kZRbZ85kprASVYRbN6dfg9m6VputWdbNpR5Ohq54NdSxSZi57Pkq9CjItTol8XtbU3NNyEwLLaBQMH8ZyBIkR6dHzWNZv8BJQFp4lP8DoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAE/vzEP9FkrDsZbpq8+7wccIy0yBWTgCP5Wew1Yplg=;
 b=y0i9agzY45cbtTic0SPrrgm+G4pSkbRs+DLUFRoTKays7lZUHJmtBr13eDORhVwBI8Eng0cyGwxdvNjUESrXq0MPFaL1isjCV2UT7N3t/lWXBS+v0OmSA8g8GUofNhxtBZcMNA70dZPKdCYwABXBFOx0TN+bQamhCQWnBLSrNw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:37:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:36 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 02/96] celeno: add Makefile
Date:   Tue, 24 May 2022 14:33:28 +0300
Message-Id: <20220524113502.1094459-3-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a5881f-f3d9-4d13-f8e1-08da3d79ccc4
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384C97DBC8F7BD17847AC02F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOxrrYvVVcoY31ku01DvKudCkKUnp3Hb2VjbHa+TycDkbgn2Wx6wIToDZmZKHF+1r9BORzhFX04j62zI2reQPozv/f8WXlQGkM3ur8xVkvPBDT77qotM7CV0+gFjgX9g0Hi+nSKHJ3g3a25tBora/t4ZF+eT+ye5boeHoPqCU58RkxCrgmk1URLKvh8SAg/H9Nsb4QQfNjkRmsOa2yzGhxVf0e0aPRMT5gjf7Kpda9IsmPQsj1HQF6lNw2tKTHVUqyiBRP78FfXezWyFJyxVVbGOqfdRg9Uo9W6KO0NTNWkHwvm7eB67+xg61p3z5Ke6S6lLw2ajmMs4k7AwZumscKbZu99YYhiNOTiuX8lflF4V1pAUqL0r6700hU/QdYw3yFYBCBeW+gEA/CIjU+ixrz6JayH6JPc+aCyPWSPs7nnA+0jwudfrJuN7vouEo5dsYOfa9dxBBedkWsC98femchCSOFEt6yJ9rIE0aXMjn4SpNO3+m0FcWv77yDYuv9DWCHxp5nLHPVA8PWrBwhv3en3IWoctWQ4DVMwYnS+1puK4FahkmYNcOm66Dcv9g2XSXWy68wtLoOmrnYrbzs4ZycJ0fIiqXLxR6QdaNxUCCkfsBVUo6jFsILCZtvg4OlXJc17HVjM/FIt3p0m8F4vAaYAdDS47jPMhR4YZvRKc5IRZuwv6cUZtXBkaqWJab01XM/U9hs/05ZQIJi5K+ZALXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(4744005)(508600001)(186003)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NlaohjHMI2V8G/fgeYwWc87Qj7YlZqvl7dc5gacM1vhbqeoc0xXJOb+cMA44?=
 =?us-ascii?Q?FTgiZGVcbX2onXtS5hdxlCpdqFUoOOcBMfHrn3DUa2nn8Xdxl187Ld7+U1Ml?=
 =?us-ascii?Q?MLxsF2t9qw0d45hJd02o59EuRd+MCngQtFsRHiYqsnWEirUBLZ7Vrlx6IC0/?=
 =?us-ascii?Q?XdIOMe0TMoqHRE1jRTjpUGkr1LsRf4AVJoD/ZlPO0Xc9TJfNJg5xMLhAu7OY?=
 =?us-ascii?Q?Mag2SnICPT6sGMSjBh7jRxHJfOFtvzZ+TH+ZOU1yrL7hCYoD/It3BK19G8y1?=
 =?us-ascii?Q?31uPHD265ghpW2cpI0QRA/L/NjP0EB1nUzrLUSZu4fq+lOdo2zCAaC0T+byK?=
 =?us-ascii?Q?1tljvivJmpH+zSFgQ309vtZHWZhWHqQa61ElllwI2aAQZzz+8T4f27oQcddH?=
 =?us-ascii?Q?0bjixXaxxGprHsvAcTnkn7VbUlqrm/rdkQu/b19WrBbFK+JR8PEBVuLkiN1Z?=
 =?us-ascii?Q?d9J3P2ZCYGOcf11S0b7JvlyZWOfn3dzGWtnJscmH6oiqux8n0LslfkyenpQk?=
 =?us-ascii?Q?RZKinVRDrR5L4ptfwkL3DWF3AK+4Batrr4ltDorA3XXAriWPRHa4QQA2KivJ?=
 =?us-ascii?Q?PG2QdfCAroNPj3L4YMBUknqd2X5EIhu3TUB2WU+pg+6fTxye0BAjc68uHkLG?=
 =?us-ascii?Q?cHlf9g9jqkwme0uW65rUp5EppaawIP9IQhOtuSAI7MI2aeH6h0TxG/z4hw7o?=
 =?us-ascii?Q?8hczWNFOSM4zTAfeAl0jWRLyhcIvw68DKvarV5Z2CHxWnbFFKuyQ1mEzJAg3?=
 =?us-ascii?Q?SF5qfgVMIpioWSRduaSAqyHaUZRXkUFDEOc0h1tlM4rdXM17ivOmykh5s+Oi?=
 =?us-ascii?Q?su/39NXlmZ8ezmykmXmfLep1+ljfN23M1nvLfUqHj5YXHYN65f+xpWleqWCN?=
 =?us-ascii?Q?qHn/cKO6Ws9jIjUWvt9j1y1tGOdjfJKsCcjWl0kOqkJ8bPkj+bQux7YY18mL?=
 =?us-ascii?Q?TP04824hg9b9CCVbBEm0gUCrsjrYmgOeaxf7XEzQ7whErAykK7s/MWm+LhCU?=
 =?us-ascii?Q?JdE9icGLy9sGuAgALK3plpkErNKbUgdIS4BU8jR4ZhuMx05rmWTWUDuPCzxX?=
 =?us-ascii?Q?2tIEk1ndvtgpGoatXDZk+yHRptAGREule3k+mtjOkhWAX1hXVHIoWa+QEpkz?=
 =?us-ascii?Q?HNCpR7TBXECufj5kV7K/obSWO2NutvsEB66JmjcmIww9lByJLbjlrIxMVqL/?=
 =?us-ascii?Q?CpzngP4Xn3CsmnrS8dMZwKUmpFzheVjvLb2m0SIixBCrwuCCeftV7IoFU67W?=
 =?us-ascii?Q?LGequaqPbB3fAnEjTJjQYqgi3NlVEl6NU1G8MTF4g8afVnjQuiwWyn9bopGW?=
 =?us-ascii?Q?PC25rD3l0v+9G6zkSdX7o7NKZzNQiEs85EJcquDwB/ynPLWEWyJ6ybIsyFBs?=
 =?us-ascii?Q?veTcpBUQlXfmJGWybqguvjNioA2MLO1T5YtlSpX9cY3hEgDlPu6muWj0Ioi2?=
 =?us-ascii?Q?u92Gd/JeeoGQXhtmy69wn2lrlM3u8VIw5m5zop38/xgk1CQZkHwb8D6wFqvR?=
 =?us-ascii?Q?C6QFpw3t5UUcBzX1q8B1DPDoYx41DMhHlHnwXrBVbGrKJTxPtupxKXuL7sLF?=
 =?us-ascii?Q?30AzQv1NAJ+NsNP3yAxvB6LjVRfxA2VD9POJkLfWgqTOgjCbiTI30Iv4e/D1?=
 =?us-ascii?Q?r5eIrKspwQTG/Qj+ldwKIErXygaYhBaGLmbUnMNfIIh7xU+Ibm5Wsh8rBUUq?=
 =?us-ascii?Q?XSKr0sGjmIQzS+Xa0Ga6DvfItDfRdr6ckE5Lt81E4MK+0FcG5VV3airb90uE?=
 =?us-ascii?Q?hW1qjf5rJ9fuKDsw0zifIzYDJGK2dzI=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a5881f-f3d9-4d13-f8e1-08da3d79ccc4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:36.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDhMXqYvMK0gYfRYAEHrNiq/AeSiq3NZs5T/gAWE7jfIW73Sm2VLqNcqj+j05ZjNjkoQoLkuwMGLIIC6BzBL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 create mode 100755 drivers/net/wireless/celeno/Makefile

diff --git a/drivers/net/wireless/celeno/Makefile b/drivers/net/wireless/celeno/Makefile
new file mode 100755
index 000000000000..b7a44afcb867
--- /dev/null
+++ b/drivers/net/wireless/celeno/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+obj-$(CONFIG_CL8K) += cl8k/
-- 
2.36.1

