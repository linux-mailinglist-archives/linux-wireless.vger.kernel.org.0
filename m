Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56B53AB917
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhFQQMZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:25 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:60643
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233669AbhFQQLT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5gdipIyebsMgqDnLWA6jnZ+KiyGzhx7WQ59TmN+cnsMB4gjZqcg8a81wlpBu6njnuYv4aW8ZgxCSZ/aEJ/WMhE4SYLFc1I0pqDFtDSmnunK+qPQumawPxvV9N+/9GDoAE1su8RtzGJcLw9IYWNzTX1FD8w35tAXrvqnl/sG5ANlmPIoxfefqlpRViu2SkOOSqtoqvPbqNX9/DsBcUAcN1lvs75SuY1eXENBbsOqnYm0AhhBntTOqoubTobw3cQJ/5qx3PsRk19Vcfby77PGzs3jbnBiNxDeBxKSsFkK6UeTsBOZ0JO7kVT3GpKjVEZlN43ayMO75GAqMKywT6m7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oybJtMbBClRaeVwsgsu6nLPf1qmdVFUl1Ry3Dhoknek=;
 b=VkKJl3HmeLNHefOgJ5WmPowF/lNUfRZOe00pyirQ8/6ahx0m6+8LgVwdRpV+EbJm50JPZApZgsGHk2UmvN5UejaUHsLZ+CWw0U4omj57W8wLcx/3JLMMUp0UGEs6WHxWSuK03z0mEDrxm/drxhrVjzTb2B0KiSCGYT0F5wFBlchYV5g/XnncVpDYCq6uPjnNRJj+rPBTy+/uA8aRvCS40goCVQ6+ugdHTP7LiHeYus8/TD3mbB4Uo0RoqD6+cyHDHes0gIrbvJ6VUT699hkU29pa0guJWANDJlZLHcIPV4F5CGtF05EzVBijw2ihswgDkoMXsIWPNGslVD6xZUPZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oybJtMbBClRaeVwsgsu6nLPf1qmdVFUl1Ry3Dhoknek=;
 b=lAah54uQxsMwoEuh82GQghxE7kH2sBNAVAOeHatwi7scWSgeC9lvPFOh5DLn4DaEDVKbApuywZqz//rU9vlqDW1ChLwWaP+wSTjVN8bGV8X2XHLmB5Sw3sh7W57yD1nCn+UZ5b5zgohJONNcjQIQRoQZpZzAQa2vnsTKZX9j3Tw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:55 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:55 +0000
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
Subject: [RFC v1 226/256] cl8k: add utils/string.h
Date:   Thu, 17 Jun 2021 16:01:53 +0000
Message-Id: <20210617160223.160998-227-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5006ad-fa68-4294-700d-08d931a9e866
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0452BC196EDBB44F9A287AF8F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkdvwiq5utXmKT9WY0rxapdfg+vHBB+FXqnNzjRT6rIoTB6BkawdJpSI8BrMQToqbTe6H087H1Kv77fcU6ZAzFwPU3AjDeiiNa/FDFRlxPJdx0XF7ETr5VXK4JGSLoOaXxjkNl0FQMcjKf5670Ncx8uSJ0vGIfUyo7GRaB0st84+zo7f5HlqZYBWhIewXxaqu5ddvztqCcno7BVq2O2WUlFtqV1bhBuo8E8oIWCTvS3XJEmKhG1WVEUaXHsB3A+rX7hC8f2R5/n4p5rWyWTehpecfQkvnqEcknS/dZqq9qL70zjXnFmQV2YwfVeCtaYI3mQc4fGhN2TbETfuiqxM538AqmKM9fNeC4O/q+FZkiWPLFGPJuwY9hChl6f4nXWdXKl+Q7HK80A4+FvDfTxNTRRZasVVoQBWCnH1dQXKoDYqqTe/uC+h4MD+L2G6G7MGINTiRzE7zxWNRluPCrF5Ki4mzLLqw0pIxQm7Vlgouw4Pf7f5MVauhm+xqOLKn6yF6A4iaPOw1/TTSxqaxONFMYu2rfjCGK2q2jWaAj/d3oyYWC3XTH0t3hbzU/+9Lxmrwu5nz2AWNtBhCXWG/X2cATeLCKi2tDs3YSb/FhIESObTqVoEgprXHtVlzxMC+qP3CBdPA/6ZBFHmfwtvJ/hhtHGTXao/PhCroKlZrEpQFRxtvNFZzyf43QXJ+1dHKl/fTiMGW4f+ZbattUnIsJi0dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+V32WUTtX8Jzv7K/3vPWdiKrciWlx9IibE77CphhLBqTslwnEIyGZNOfVmn?=
 =?us-ascii?Q?DK8wnL2rBdD0lMtZFkQLkWp6i5f2Ph2YXYIwYlIJ6lCoqCoxyFN0uCcLiBOo?=
 =?us-ascii?Q?t4tBsXnH/7WhN8+061CxYd5isrnP2aJzDxddzEMlWKmLwWE7gAvdsqmXxnkK?=
 =?us-ascii?Q?yuFem2mEdL27aXNaiqZxzA4I2aDYlPnYv8uzSxdMu2u11htm1RmbkD1iX+F5?=
 =?us-ascii?Q?kMnwHYhm8MWUs04rdC9b6sY41MA3qyv+bI9/Y/2URV2ckvGSAtcKKHwsp3UJ?=
 =?us-ascii?Q?VXP99S5yNXyQRw+fLTR3a3HSKCS/RwsHI4iMu871WvNGdV3Cjyv/utr+8/Ba?=
 =?us-ascii?Q?CgznXs5i8CYmWnj/Ur+hUFj1VPLMDJMpMRbgMuqhVxWYF2PAUwPq5cZE3qwQ?=
 =?us-ascii?Q?M/ZGE4WQ+NCK6f3iGu+QukkYbcTT1rQEH0hxcmSfl0fj6N2fzdLyt2CKac6J?=
 =?us-ascii?Q?2sJEMiv0W7O3hqYKkdnJIfMYCpIDynxZyniVhpWrlz0rFnnWKGKJTJ5ZJ2wa?=
 =?us-ascii?Q?xzxGZeElmFfb1mL2M7UZL3XzSJ4eJBPXNuhHujl8ZrDiPQUsXv7WMdB6Qcbo?=
 =?us-ascii?Q?Y1JzKTSTvlkknR+CducHJHoQD8P9nhciARdEhPK/vWhGhUVCkSRVpI07B7vU?=
 =?us-ascii?Q?Xdne7gIcBCU/Lk/aK0MElqcL2E7po0nA5oTcFFgleqTH2zFJXlc0lZtJxrPK?=
 =?us-ascii?Q?IZn7YdL92l/6OObyfdyZ+RpHdgOh4p2MoBE9CuJ73VlEaJ+kk6iPn8nPQKAN?=
 =?us-ascii?Q?mLslzR6rNW6e4Y0eV76JnGKJPO7sSjtKCOiqmvroa8ZHx+HTRfpyf4SkevRo?=
 =?us-ascii?Q?YVWBsZ6QBnBmQYfY1uXPt8r9Jxvi9uLbDogfIi1BcGQEgvO0qXZ78AFbidZU?=
 =?us-ascii?Q?dFA01jB1p0Su/s/w7Ri9INOVpBC9Bqirbh5Q6t0MAbIOsdg4sZwtJ3AKbgPl?=
 =?us-ascii?Q?lvsZpT8SbN8EsAD+eeLfwoYhzGXZXY2zhWCRwF+s1uEyu9WFq8OoCp5m2A/L?=
 =?us-ascii?Q?XbnKdzF6n3YsZyWiUOYv0vTPnnngO6qKUXRFOHEXmJT3Avpgc9vJ31pexuth?=
 =?us-ascii?Q?WDl+QjQoQy8kcHtXRgZPtonOHIAVN+FOAWZb2oqrWJGPKB3lo68Spv2k3Mzs?=
 =?us-ascii?Q?NE2BvIFpTx3YEHWTVXObdQYK1uMEkl3m9aELZloMIlWXF8lp4yphfrSyOZfm?=
 =?us-ascii?Q?otvcim02Eg9eDFOINyg8WJz/8zyxBRhjfV3gQuN+AgrZkQxQLXBimxMY6T38?=
 =?us-ascii?Q?N7Bc3/yQ+q6apn04JtCuzf8cD3F7b36XhDscllY/qEOif1jehNr0PEMzbbOC?=
 =?us-ascii?Q?jOlHn6xZaOdgn07WmLEiNukp?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5006ad-fa68-4294-700d-08d931a9e866
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:46.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4fVSEx4lRVIJQH47xwgtKUqmZlxPSltRvAAP+8EbpwhNg47VvU5DUKGRYTD0rXPuvzTLoSd+qjVhCJMRssy5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/utils/string.h   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/string.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils/string.h b/drivers/net/=
wireless/celeno/cl8k/utils/string.h
new file mode 100644
index 000000000000..aea19516ff99
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/string.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_STRING_H
+#define CL_STRING_H
+
+#include <linux/types.h>
+
+#define STR_LEN_16B  16
+#define STR_LEN_32B  32
+#define STR_LEN_64B  64
+#define STR_LEN_128B 128
+#define STR_LEN_256B 256
+
+int cl_strtobool_vector(char *src, bool *dest, u8 elem_cnt, char *delim);
+int cl_strtou8_vector(char *src, u8 *dest, u8 elem_cnt, char *delim);
+int cl_strtou8_hex_vector(char *src, u8 *dest, u8 elem_cnt, char *delim);
+int cl_strtou16_vector(char *src, u16 *dest, u8 elem_cnt, char *delim);
+int cl_strtou32_vector(char *src, u32 *dest, u8 elem_cnt, char *delim);
+int cl_strtos8_vector(char *src, s8 *dest, u8 elem_cnt, char *delim);
+
+s8 *cl_strtok(s8 *s, const s8 *ct);
+s8 *cl_strtok_r(s8 *s, const s8 *ct, s8 **saveptr);
+
+#endif /* CL_STRING_H */
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

