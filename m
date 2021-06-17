Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECCC3AB834
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhFQQFe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:34 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232692AbhFQQFU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY3pyyJNgmhCBfSmE++7Ng+Yo3wnPaClg0A3y9rZ01hEtvwrg01V2VMZ45YcJFdAJV0PM0lT2EvtVcTFQqs3xR9kfw2YY8nLECC7sScjW1xrkTijtSmAh38SaZfXs7Eq9T5tH6IKhu0TL7frCajuVaIgC5kRoqgzB/ffz9O6Kx54TjYa+cNZNlsQmgeOopLeg4inmj920aLuzODjbRAHEE/2lA9GCgV9SPzubEg/jXE2Bu1GcRmowEWGJ7ozXVRv+s90b2EPhu1fkRaPRbatjtMZ1iGs6IDUgUEnt2Y1xQOaku7Snuq1rnyCuaNEpELyC9xCPgzZjlS1TvnSxpdbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKut833gpU65nB5QYog5Wtb8r0tqiv96aYZNB9/Wgac=;
 b=Hm7C1kO+n+pAbKvxH4sp87AJvvegNjcqaPsfb3t7Q8O0XeUlzlIdFSvzeuRI+gxMdXfWr1yTYitnOacMM2mQLhPSsEfCOi1/gddE6YJxjlpd29xXqgqSducHUN9tqtph9mihuuAK4V1Ysz7GK0ssCAeu3siltOl7S6VTVGPS6+jSveERhxW+jSZZTS0R1FacZKrwlug+odagl+lmxqbT49cTRrc0uU9pvZ2f2dnBDeMR9gj5A5cl8m/f6/b5UHGVXA81YMb2AdzyxH0C2bLDtk/wgHXKToeT63DW4lHGbK3bjeUSBoac/lt3W3MCQ3CfDgT74iWZZNYSKjn6MAguRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKut833gpU65nB5QYog5Wtb8r0tqiv96aYZNB9/Wgac=;
 b=3i+2rsd64BTkxiiohqXTzM+kyBi+2t6ukOGUzyg0RFAqFJiAgVbCeoN8SByN7mdSC6V5Y8CqRPyBxHUs3KFZImLdExwZZCxUmioj+ABdWI2caAQiGkOGs4RosFObhx/BL0f/3/a3Msbnz+o1CzqRb4CUNRb9B98XPwOv0yA3ujc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:03 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:03 +0000
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
Subject: [RFC v1 027/256] cl8k: add bus/pci/tx_pci.h
Date:   Thu, 17 Jun 2021 15:58:34 +0000
Message-Id: <20210617160223.160998-28-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1014f969-83c9-4b57-ee0a-08d931a96348
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499E54FE3A216B51F5E8218F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONvFo6Pf/7rYagfRZ07V6qmuMkaddvCfVxlNKIdEkiBE7ct6ULPvq2khvif0RQ+lUsIzaO6Ynr2R79MYjV3frPmMmB5cSaX2HQ1Gl/qVTkeISJmCP40CpLIIVQmWLcNp7d7bQWlenEz7wCNVW7mzkBk6px3UyPwTSIkpf7OSf4PokWCMD0bQTaIBBN4Uaxs0+Z00jntdjpBwchzGpk5vGzAaCcd42OkSDrxygdIb1RxTLhRvP3oQJHc0oq4z67d6lzYxn+6NShsJ6rNUTZrVwTW1QXpKmckEgZmiIimvq+rnZrSSnlr8piwgr5dMMuAKGOvpbaJm6CgMEalnRo/I8A2CaWPehGQ1M8dqjQDERxq9NQEKNptRBkWD5K93r9g7ZchbMl38tGgRhKyxN0hCVKlCeMrKh+EGhSUMRdbuZ6Bu92otMlfbN6KrunmlaDJaTCs28XkxqZfocpC9zA7kGkNPBE/QlcZ1ey7Q5s0/Jg46WUFL7yatD6ruM1IRKqGyBr8UxcRh6WiOE+2qokO6uXUTSKIANevXrY+CBR68h0JFUeoUduE8pTQYtAilCQWnKF0II7ujQ+bMElhseL6VhkI9mDWW5SGqSxUl6Yb2Xsl49Zj1BSynpMTNay8Y+sjBZPrZzqQwkFuFwuPeVcH0IoqE2u5g71gvz305JyEf6P2f+wz4WeDyggORKASRBvwSMVVdvFGd7Jja5t96h5qFzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBTgNYjI4kE6KpJeaf+DlN5VJUcfRFDTpZLV2W8AVTZiFG539OwZWKJEnxs/?=
 =?us-ascii?Q?634lHsRBmn5ysNAun0FCmGUZRaLJaPUSzSlSZ5u7K8BPuX6UflJndqHmxM8f?=
 =?us-ascii?Q?qQDPWK40PTnwe6/Rfszwy5piqgVf6Y7oAjWdztZXiQJxRHZXiChLosaS8C6n?=
 =?us-ascii?Q?kB+/jn6ckYeVzXudl5cIE1HsJbXj7eXGbVGmEA3gKB9/NbBGoD27YrtUIUPZ?=
 =?us-ascii?Q?k0v76hcW9N6B6SiZiGbTmLPz7OeeBgJ5uEBCVdjH7R0rpQlwQfVJbRFhPqAK?=
 =?us-ascii?Q?YqvW7SdSlHpNkMpTiyE4YVtnbj+rcvEZHkRJ98ylcG44kR1VBCg0r6ps03ar?=
 =?us-ascii?Q?txEEclZ2fEjy3bQqR1ppULbqis80TXaUC3NwoytUSeg//CdybwprDpIUB/cH?=
 =?us-ascii?Q?T7vgw7GjJHPQvnoq/cNKSCAFl7WS8IbhHZOeWwSHnGcKF/vHrgad4wV3+3E3?=
 =?us-ascii?Q?S65DZic1Pf6KAHefmCDCNJC6ZAi0x5AL4anfu1zNRkS0kXpJhqWckW1dvTBA?=
 =?us-ascii?Q?XUJYzsKKsrhGQCQLHIo4HdR3RELKQ98mC52nmoRVl/hLSgsjCxMH09obZlkg?=
 =?us-ascii?Q?NY4LAE1klQFuetfPWztjWhmwNzGSq+K5EvKBqrjLK/g1mkEXOnUcTbaCEP3B?=
 =?us-ascii?Q?jpwoT+sCttmoacTLuSex2nGDoEPm/VRf2tK+8XyA5b6C6cFPHeYh44WAqb9h?=
 =?us-ascii?Q?OV9txfgEDJro8cOeaH5GVc4cdXaKs7byJf0H8Typ0PbiTACtHwNSC7VTgFqF?=
 =?us-ascii?Q?6+uo+VBjMvOETF6zWQVSUQZYUBDDlb1EioKbd34e+k3WQAJ6pL41CknmmiCV?=
 =?us-ascii?Q?UEZLTzddc1pIl6ydSnJDXWymz7zKqDtL7tFaL+jbo5FG3kbaoIpSP3CmtfK9?=
 =?us-ascii?Q?2w5DADX1q/nhELqE72ZxmTNznplwP8jaKO0cCSyf/2pPFPmBrfeu47KMVKs6?=
 =?us-ascii?Q?r0V5dQk2TWyLnPqWZsQQwvWJ8zftXyZPernbbb/vhnRXrWiSv+oswg8a1BDw?=
 =?us-ascii?Q?TDHdC0SSbMlBqn64pRqKQe+L8sBuP43Anh1ANQDLTWJgojSqgg3MW1qirV5Q?=
 =?us-ascii?Q?Z9NUnqniGIQLijQoRrcHgEB2/+pn4juE8YLmYvHwoNuZBBWvLXjX/aIW1NCD?=
 =?us-ascii?Q?X+hIDTTlibVF88x2ZgUlQzSeygeymqgXD+HSkUR6o1Pn6Aid3FwqX9Dm5rt7?=
 =?us-ascii?Q?oTWfYij+KrFNLQ+Ef1qj7KRvaZlYINDcb5psgQCHKf86nd6yiOxZkFxU8ajK?=
 =?us-ascii?Q?aBmZsr6dDTbpN314EgGU/x8dz5bBlVQyfxZsxa7fOQlQ3QykvMOzLQAKrY6Q?=
 =?us-ascii?Q?5P5jE2wqH4H98uDyV2Z9oLwZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1014f969-83c9-4b57-ee0a-08d931a96348
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:03.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Inq5OEkm5ijHid4wqCDQNRUhOBW+VpSiw+MKGq96r0QGZYXKQ+FZlO5Vyci9W9bka0AoaiWXr0MkFfTDLxEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.h

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.h b/drivers/ne=
t/wireless/celeno/cl8k/bus/pci/tx_pci.h
new file mode 100644
index 000000000000..8e07ee1965f1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TX_PCI_H
+#define CL_TX_PCI_H
+
+#include "hw.h"
+
+void cl_tx_pci_single_cfm_tasklet(unsigned long data);
+void cl_tx_pci_agg_cfm_tasklet(unsigned long data);
+void cl_tx_pci_pkt_fw_send(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txh=
dr,
+                          struct cl_tx_queue *tx_queue);
+
+#endif /* CL_TX_PCI_H */
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

