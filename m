Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54B3AB88F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhFQQI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:56 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233146AbhFQQIA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFfwm90VI6ShS+Tl7P3Z1Ef3aKHc+CahN2cf2gvIPc52JvEw7VWcvR6MCjSGSrv9H4HkmWelOl39OZOuAxGuOiKXEaJQ5plmpxhrqkCHUfxObq23lSxcJC82jgO8x0wwQm67Ay94ySxe6SAXB2QegJ9DPfvhrWHGe5e4oX/KFii9Y6YFMcYwJSJidY94MBjjYkfOKeDsfDlLDFfufC5mzEyzdkSpFQQ32JQNHDiI37rNNsI68o6kppsBYA4qZi/hhWMQZEfXAlgsIUl3f1iCSPXg8TMj7iRiAlyS3O6tdgPFV8zJU5YLMhi4qVoJNXYRwgjZca/0OAQp4IQNfJKghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qveGjT7G2/sJRFpFvHdeCmgZk0TrpUmPo2O40AupbzA=;
 b=iYONFVF48Wtxkm/eFJ1UZiNfCU8s3hzpUCVJBt94SyJkMDeeiStcKqbbf1+xt9S/UcVt0OtL/F68wHWTDBD4z9uguGlpZKXya+Pl8wTyfSf0wMoC3ORHQP9d10QPyKvUyy8SaBd8Uw5xX6Iqommqv7AKS2o1yFTpJyEcdV5rzcFGoyl8Q1y8FqiKxR/qd1J1fueT6ahlnJFh45ZDADAYuqkOVLbzRAcqTWWCqxh38Z26fIj+5FCVqBZUayOmFh97Om0+Vfmkpk9rYGjjMhf7dCJ6ISDQsW/ZmejkllaaqAPtcHxGUK/8vJoGoQ28sNpy+EBnY9tW0Te/wC8ElZ7d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qveGjT7G2/sJRFpFvHdeCmgZk0TrpUmPo2O40AupbzA=;
 b=kajYVXFATDHnto7oWQEtJRTBUZzxGS+jVQWKGYAx807wrmHnFaVO9JHw5tTnZdliQ6saACWV9MLho5+3BwLYA6x5j34cF26QEaHKFM7TH8M35xBUllVsxTG4qUyVzRNdauY6IPGwZ/UjBZrTCVtGcLl8DUCBqnFk/ft2hWJkVC8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:29 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:29 +0000
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
Subject: [RFC v1 088/256] cl8k: add fw/fw_file.c
Date:   Thu, 17 Jun 2021 15:59:35 +0000
Message-Id: <20210617160223.160998-89-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6980a8ae-38a5-4271-d631-08d931a98b73
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB08710E84BB7B01420442D920F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKA00czKc9bZu3XCz3GkC7VqsliJsmCZI7dhWXgJHBjHE/ItZ+0RP0lvz3BXWT+jKQRaNqjRDpLWvaZsrwNVNKpoUdYK4UgmxprseJk+1ARqXBk557H2eZhxTm5Tfgn9NoPilJNfCGoed4WisBD30bDUWMXJdDBqbBNxKk0wwRqqlv0ustmKwb+boJg8xNwH3lTOjeC8Z3Y6vFn77i13NtLGat8ug2HRHX6YlqKgtSvCIjgCmS6c2FJ0xpOHXcVKl6vhm3a26mcAjBKri90teZ8qWLnOOBeEUCPMLxg1NnAl64r/5h4HaxOZ9+Ifrk1d1C5ZBIFGoK1SIV5fjFhiJr1voIXiQv74DNVotTL60N5I1+GWBTqH6+KteCdn3xlTUqE8rhWcNvMShR3VRo+oEeur9RTQ9uUD2GQT02EuZQXwXV0cNdmNfS4TlKrL3XsGDwvZF4mmEu5G+OVps3rmj+88rA6HTTGbrArVCGwqOT3XVoicBN+Wvx/RXjAcWCkMokHeVYO/drbA2Hwwkt89wBkILbx5lcO7CrnEDXmMwyXQYtOSNvjCVV/h5yCErjXqtGKu6ilHLJ2Ze0Spu4s9AErU10i/oyU2WB911aNAPAhlVZwmYkEG/3vSLQbqr8Z1R5k7xJOJfbCdJjMsDOAdrBiZR12oHdpIBisTZN7Ox4MxMztgq7x2dcgg0S8EEuXkCvmSC5TP2CQIyc2wGLVatQ2PNsKLLkF2kP10kzVUdSpEI//6GrseFDYwTJdraW5n15ET7PUsSnrhOvGRhD4fSxmuxqCMnXdEjeV9RmsNbc7g+ehXSloeAA2Q8YInKdwWdaHBuIEMANsyL1F3k9UbBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(30864003)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(966005)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VeMrlzLvH7VAKN0EN5ru5lJ9BaHPjiblk7g0Os6CEVICXa2o4f8kFdj5/QH?=
 =?us-ascii?Q?ImbxqLpoeqQhoz+XVoo9tzjNccos2gOBlzChxGiKSORTICaa/Q5jWdkXF/tO?=
 =?us-ascii?Q?4G6gRGQOhFb8KZPewrGf8KeI/Cu0v0o2vT3i6fxnEXEntDkCGQL1kGHtH67V?=
 =?us-ascii?Q?hA2eOIERy8sM6VpJU2NFpbilyo4X/z2HkC84FnpRWUoikR1S60let1o1DBjJ?=
 =?us-ascii?Q?I4qCRiyQL2TuG2Trw6DND9ntk8HCyHhYOQ1kbetz1H19Vvtt2kyGKgY+NDG1?=
 =?us-ascii?Q?wnHMUzLyYURq7Opd/3uieGczVsAXcdPFkOKNszc8wDMKdjyaaaj7RlTCg2pX?=
 =?us-ascii?Q?selJkkeIqkUv/ISepI+r62adU1hL5zE0e0xAQARzUdQQYUBscv780t6ae438?=
 =?us-ascii?Q?itTZyKtCWEahYqNB55HezDwhOGZ55Bq4r+bjHbPN2onp5atQ/hrqhWxKCe69?=
 =?us-ascii?Q?R4y7hkExpRHHKs3tkXbf82MEHvdSFUq88fna87Hn0dlwSXgJpFlNb5cAA4NG?=
 =?us-ascii?Q?qVAT/s9vQzqBH/VDoErqBFl/dTcrx3qk8kmBQnkCr+cuI6dZyQ1XkjGpTYmL?=
 =?us-ascii?Q?Pt0UB8oFW7k7e5ZMOkrHhkKV6jo8y12S12y3DP/0/3DijE9YtVipJOlVYFoo?=
 =?us-ascii?Q?8eCCO6JjMP9HLqBVpU8Q3gN6AOWmbXaHSaQ9+ELnZLLS78KilJNRLRqDRQXi?=
 =?us-ascii?Q?KOW1YTs6ruxbZp046oyfaNJV5+MW6vLaVvL8pvBcLRZHoH3cDsEGt98yyQpd?=
 =?us-ascii?Q?kZ5lPYp380BryNktyUd/8uG20JBPXiX+rUQ0S4coyj7TGH2oQ5Dt/ozpEIzw?=
 =?us-ascii?Q?RSSUNPcq4kpzAsL+rANInBZX2WdXy8d9ovonMo35XWNOYFUkI9j4ip1vmg2e?=
 =?us-ascii?Q?2wktWBmR7DUHwM7wDN6gqswNjCCYVb4c0yYFQI2pGyJSFP6cwVKWQkOy8/4O?=
 =?us-ascii?Q?RmRMEGBsUV5siDxBfhjj7ZV2AItUL4gVPqRJQZtDF607ffVL6gr+6xfDra6D?=
 =?us-ascii?Q?Z0e05tNBPgRxmqH0QIzaNoPtnqtiG6eXOeZKQc13ZoEYHZyTMvLzSbCuqZs2?=
 =?us-ascii?Q?T/hJNaHaU2t9WCxQhH3hOHai+BlZrrx8chLntnmjQoVJAApdf8sbWQ9xd4A2?=
 =?us-ascii?Q?LbTFLYakWttD46J00TV7pWiLWg41kHdudBLw5nY/yWo6BnTfH7BJFzZzQyth?=
 =?us-ascii?Q?oHaFa3q1nTuPEAkteCUS/VyFEi96Mf5PmiRd5N94ycjZj2dBawnaKKBD0T8f?=
 =?us-ascii?Q?BJluYR5neLL7FDZh3zaHK+AtdLabaJL/yvDCg/orTBVrZPv33kmIByCo4Kna?=
 =?us-ascii?Q?lobpluG4uEl0kj9LQRoG1IrV?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6980a8ae-38a5-4271-d631-08d931a98b73
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:11.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s24h9Utygsi5AcOgiDuGM9N46erIweIkhCwk7vs4niwp5vudFsbSRCRjpg+Mc2+fnnZYm+UUBfUmeMLBzuVa0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/fw_file.c | 485 ++++++++++++++++++
 1 file changed, 485 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_file.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw/fw_file.c b/drivers/net/wi=
reless/celeno/cl8k/fw/fw_file.c
new file mode 100644
index 000000000000..73b239ab5814
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/fw_file.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "fw/fw_file.h"
+#include "dbgfile.h"
+#include "reg/reg_access.h"
+#include "chip.h"
+#include <linux/firmware.h>
+
+/* Location where FW codes must be written */
+#define RAM_SMAC_FW_ADDR 0x00300000
+#define RAM_UMAC_FW_ADDR 0x00280000
+#define RAM_LMAC_FW_ADDR 0x00200000
+
+#define FW_START_MAGIC           "CEFWHDRSTART"
+#define FW_END_MAGIC             "CEFWHDREND"
+#define FW_OFFLOAD_MEM_BASE_ADDR 0x70000000 /* Defined in fw link script *=
/
+#define FW_SECTION_SIZE_MASK     0x7FFFF    /* Mask for max. size of a sec=
tion */
+#define FW_REMOTE_ROM_BASE_ADDR  0x80000000 /* Defined in fw link script *=
/
+#define FW_REMOTE_ROM_MAX        150000
+
+/* Location (offset) where FW codes must be taken from */
+#define IRAM_START_OFFSET        0x40000
+
+/*
+ * Poor man parser of a plain zip file
+ * We use it just as a container for now. Could use cpio instead.
+ * (no compression, no 64-bit data ... no nothing)
+ * Reference: ZIP File Format Specification v.6.3.4 (2014)
+ *     http://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
+ * For BIG ENDIAN host: zip format is always little endian.
+ * TODO need alignment on non-intel hosts! zip format has no alignment,pad=
ding
+ * TODO check CRC?
+ */
+
+struct pkzip_local_hdr  {
+       u32 signature;
+       u16 ver2extract;
+       u16 flags;
+       u16 cmpr_meth;
+       u16 filetime;
+       u16 filedate;
+       u32 crc32;
+       u32 cmpr_size;
+       u32 orig_size;
+       u16 fname_len;
+       u16 hdr_extra_len;
+       /* Filename goes here - not 0 terminated! */
+       /* Hdr_extra_data goes here */
+       /* File data goes here; no padding, no alignment */
+} __packed;
+
+#define PKZIP_LOCAL_HDR_MAGIC   le32_to_cpu(0x04034b50)
+#define PKZIP_CENTRAL_DIR_MAGIC le32_to_cpu(0x02014b50)
+
+/*
+ * Enumerate zip data in buffer, find named item
+ * Return: 0 on success (the item found)
+ *        -ENOENT the item not found, normal end of data found
+ *        -EINVAL the data is not zip (maybe old format firmware)
+ *         else invalid data format or other error
+ */
+static int cl_enum_zipfile(const void *data, size_t size,
+                          const char *name, char **pdata, size_t *psize)
+{
+       const struct pkzip_local_hdr *phdr =3D data;
+       int remain_size =3D (int)size;
+
+       BUILD_BUG_ON(sizeof(struct pkzip_local_hdr) !=3D 30);
+
+       while (remain_size > sizeof(struct pkzip_local_hdr)) {
+               char *pfname;
+               char *edata;
+
+               if (phdr->signature !=3D PKZIP_LOCAL_HDR_MAGIC) {
+                       if (phdr->signature =3D=3D PKZIP_CENTRAL_DIR_MAGIC)
+                               return -ENOENT; /* Normal end of zip */
+                       if ((void *)phdr =3D=3D data)
+                               /* Bad signature in the first entry - not a=
 zip at all */
+                               return -EINVAL;
+                       pr_err("ZIP - unexpected block: %8.8X\n", phdr->sig=
nature);
+                       return -1;
+               }
+
+               if (phdr->fname_len =3D=3D 0 || le16_to_cpu(phdr->fname_len=
) > 128) {
+                       /* FIX max len */
+                       pr_err("ZIP entry name len bad: %u\n", le16_to_cpu(=
phdr->fname_len));
+                       return -1;
+               }
+
+               if (phdr->hdr_extra_len =3D=3D 0) {
+                       pr_err("ZIP xtra hdr size=3D0! FIXME!\n"); /* Copy =
name to tmp buffer */
+                       return -1;
+               }
+
+               pfname =3D (char *)phdr + sizeof(struct pkzip_local_hdr);
+               /* Because fname in zip is not null term! */
+               pfname[le16_to_cpu(phdr->fname_len)] =3D 0;
+               edata =3D pfname + le16_to_cpu(phdr->fname_len) + le16_to_c=
pu(phdr->hdr_extra_len);
+               remain_size -=3D (sizeof(*phdr) + le16_to_cpu(phdr->fname_l=
en) +
+                               le16_to_cpu(phdr->hdr_extra_len));
+
+               if (phdr->cmpr_size =3D=3D 0 || le32_to_cpu(phdr->cmpr_size=
) > remain_size) {
+                       pr_err("ZIP entry data len bad: %u name=3D%s, left=
=3D%u\n",
+                              le32_to_cpu(phdr->cmpr_size), pfname, remain=
_size);
+                       return -1;
+               }
+
+               if (strncmp(name, pfname, le16_to_cpu(phdr->fname_len)) =3D=
=3D 0) {
+                       if (phdr->cmpr_meth !=3D 0 || phdr->cmpr_size !=3D =
phdr->orig_size) {
+                               pr_err("ZIP entry compressed! name=3D%s\n",=
 pfname);
+                               return -1;
+                       }
+
+                       *pdata =3D edata;
+                       *psize =3D (size_t)le32_to_cpu(phdr->cmpr_size);
+                       return 0;
+               }
+
+               remain_size -=3D le32_to_cpu(phdr->cmpr_size);
+               phdr =3D (const struct pkzip_local_hdr *)(edata + le32_to_c=
pu(phdr->cmpr_size));
+       }
+
+       return -1;
+}
+
+static int cl_fw_unpack(const void *data, size_t size,
+                       const char *name, char **pdata, size_t *psize)
+{
+       /*
+        * Get named item in firmware container
+        * Args: pdata : pointer to pointer to item data, psize : pointer t=
o item size
+        */
+       *pdata =3D NULL;
+       *psize =3D 0;
+       return cl_enum_zipfile(data, size, name, pdata, psize);
+}
+
+static int cl_fw_load_other(struct cl_hw *cl_hw, const char *name)
+{
+       /* Handle other stuff in firmware container */
+       char *edata;
+       size_t esize;
+       struct cl_cached_fw *cached_fw =3D &cl_hw->cached_fw;
+       int rc =3D cl_fw_unpack(cached_fw->data, cached_fw->size,
+                             name, &edata, &esize);
+
+       if (rc)
+               return rc;
+
+       cl_dbgfile_parse(cl_hw, edata, esize);
+
+       return 0;
+}
+
+/*
+ * Copy the FW code and data into the proper memory inside the firmware as=
ic.
+ * vaddr - run address
+ * paddr - load address
+ * fsize - memory section size to copy
+ * msize - memory section physical size
+ * mem_base - base address of xtensa internal memory
+ * fw_buf - buffer holding the FW binary code and data
+ */
+static void cl_fw_copy_section(struct cl_chip *chip, char *fw_buf, u32 mem=
_base,
+                              u32 vaddr, u32 paddr, u32 fsize, u32 msize)
+{
+       u32 *src_addr;
+       u32 dst_addr;
+       u32 i;
+
+       src_addr =3D (u32 *)(fw_buf + (paddr & 0x0007FFFF));
+       /* 512KB - cover all internal iram and dram and some more */
+
+       /* Check if run address is external or internal from xtensa point o=
f view */
+       if ((vaddr & 0xFF000000) =3D=3D XTENSA_PIF_BASE_ADDR)
+               dst_addr =3D vaddr & 0x007FFFFF; /* Must be in 8M PCIe wind=
ow */
+       else
+               dst_addr =3D (mem_base | (vaddr & 0x0007FFFF));
+
+       for (i =3D 0; i < fsize; i +=3D sizeof(*src_addr))
+               CL_BAR_REG_WRITE(chip, dst_addr + i, *src_addr++);
+}
+
+static int cl_fw_phdrs_upload(struct cl_chip *chip, struct cl_hw *cl_hw,
+                             u32 fw_addr, const void *edata, size_t esize)
+{
+       /*
+        * Load firmware image with "phdrs" header
+        * and optional non-resident (offloaded) section
+        */
+       u32 size =3D esize, section, section_cnt =3D 0;
+       char const *pbuf =3D edata;
+       u32 *src;
+
+       /* Verify FW image phdrs start magic */
+       if (strncmp(pbuf, FW_START_MAGIC, strlen(FW_START_MAGIC))) {
+               cl_dbg_err(cl_hw, "phdrs start magic not found, aborting...=
\n");
+               return -1;
+       }
+
+       cl_dbg_info(cl_hw, "phdrs start magic found !!!!!\n");
+       pbuf +=3D (strlen(FW_START_MAGIC) + 1);
+       size -=3D (strlen(FW_START_MAGIC) + 1);
+
+       /* Verify FW image phdrs end magic */
+       while (size > 0) {
+               if (strncmp(pbuf, FW_END_MAGIC, strlen(FW_END_MAGIC)) =3D=
=3D 0) {
+                       cl_dbg_info(cl_hw, "phdrs end magic found !!!!!\n")=
;
+                       break;
+               }
+
+               pbuf +=3D 16;
+               size -=3D 16;
+               section_cnt++;
+       }
+
+       /* FW image phdrs end magic not found */
+       if (size =3D=3D 0 || section_cnt > 100) {
+               cl_dbg_err(cl_hw, "phdrs end magic not found, aborting...\n=
");
+               return -1;
+       }
+
+       /* Remember where the fw code start in firmware buffer */
+       src =3D (u32 *)(pbuf + (strlen(FW_END_MAGIC) + 1));
+       /* Re-assign firmware buffer ptrs to start */
+       pbuf =3D edata + (strlen(FW_START_MAGIC) + 1);
+       size =3D esize - (strlen(FW_START_MAGIC) + 1);
+
+       bool is_offload_present =3D false;
+       u32 off2_start =3D 0, off2_end =3D 0;
+       u32 off3_start =3D 0, off3_end =3D 0;
+
+       for (section =3D 0; section < section_cnt; section++) {
+               u32 *param =3D (u32 *)pbuf;
+
+               if (le32_to_cpu(param[0]) =3D=3D FW_REMOTE_ROM_BASE_ADDR) {
+                       if (param[2] > FW_REMOTE_ROM_MAX) {
+                               cl_dbg_info(cl_hw, "%cmac%u: FW remote rom =
too big =3D %uK\n",
+                                           cl_hw->fw_prefix, chip->idx, pa=
ram[2]);
+                       } else {
+                               dma_addr_t phys_dma_addr;
+                               char *pfake =3D (char *)src + (param[1] & F=
W_SECTION_SIZE_MASK);
+                               struct cl_dma_accessed *fw_rom =3D &cl_hw->=
fw_remote_rom;
+
+                               fw_rom->size =3D param[2];
+                               fw_rom->drv_v_addr =3D dma_alloc_coherent(c=
l_hw->chip->dev,
+                                                                       fw_=
rom->size,
+                                                                       &ph=
ys_dma_addr, GFP_KERNEL);
+                               if (!fw_rom->drv_v_addr) {
+                                       cl_dbg_info(cl_hw, "%cmac%u: FW rem=
ote rom dma_alloc_coherent failed =3D %uK\n",
+                                                   cl_hw->fw_prefix, chip-=
>idx, fw_rom->size);
+                                       fw_rom->size =3D 0;
+                               } else {
+                                       fw_rom->fw_v_addr =3D FW_REMOTE_ROM=
_BASE_ADDR;
+                                       fw_rom->dma_addr =3D cpu_to_le32(ph=
ys_dma_addr);
+                                       memcpy(fw_rom->drv_v_addr, pfake, f=
w_rom->size);
+                                       cl_dbg_info(cl_hw, "%cmac%u: FW rem=
ote rom memory use =3D %uK\n",
+                                                   cl_hw->fw_prefix, chip-=
>idx, fw_rom->size);
+                               }
+                       }
+                       pbuf +=3D 16;
+                       continue;
+               }
+
+               if (le32_to_cpu(param[0]) =3D=3D FW_OFFLOAD_MEM_BASE_ADDR) =
{
+                       is_offload_present =3D true;
+                       u32 *pdata =3D (u32 *)((char *)src + (param[1] & 0x=
7FFFF));
+
+                       off2_start =3D pdata[0];
+                       off2_end =3D pdata[1];
+                       off3_start =3D pdata[2];
+                       off3_end =3D pdata[3];
+                       cl_dbg_info(cl_hw, "Resident RO DATA block: start=
=3D0x%x, end=3D0x%x\n\n",
+                                   off2_start, off2_end);
+                       pbuf +=3D 16;
+                       continue;
+               }
+
+               cl_fw_copy_section(chip, (char *)src, fw_addr,
+                                  le32_to_cpu(param[0]),
+                                  le32_to_cpu(param[1]),
+                                  le32_to_cpu(param[2]),
+                                  le32_to_cpu(param[3]));
+               pbuf +=3D 16;
+       }
+
+       if (is_offload_present) {
+               /* 2nd pass to find the resident RO data block */
+               pbuf -=3D (16 * section_cnt);
+               char *resident_file_data =3D NULL;
+               char *resident_umac_file_data =3D NULL;
+               u32 *param;
+
+               for (section =3D 0; section < section_cnt; section++) {
+                       param =3D (u32 *)pbuf;
+                       if (param[0] <=3D off2_start &&
+                           (param[0] + param[3]) > off2_end) {
+                               resident_file_data =3D
+                                       (char *)src + (param[1] & FW_SECTIO=
N_SIZE_MASK) +
+                                       (off2_start - param[0]);
+                               cl_dbg_info(cl_hw, "resident_file_data=3D0x=
%p.\n",
+                                           resident_file_data);
+                       }
+
+                       if (param[0] <=3D off3_start &&
+                           (param[0] + param[3]) >=3D off3_end) {
+                               resident_umac_file_data =3D
+                                       (char *)src + (param[1] & FW_SECTIO=
N_SIZE_MASK) +
+                                       (off3_start - param[0]);
+                               cl_dbg_info(cl_hw, "resident_umac_file_data=
=3D0x%p.\n",
+                                           resident_umac_file_data);
+                       }
+
+                       if (param[0] =3D=3D FW_OFFLOAD_MEM_BASE_ADDR) {
+                               char *pfake =3D (char *)src + (param[1] & F=
W_SECTION_SIZE_MASK);
+
+                               cl_dbgfile_store_offload_data(chip,
+                                                             cl_hw,
+                                                             pfake, param[=
2],
+                                                             FW_OFFLOAD_ME=
M_BASE_ADDR,
+                                                             resident_file=
_data,
+                                                             off2_end - of=
f2_start,
+                                                             off2_start,
+                                                             resident_umac=
_file_data,
+                                                             off3_end - of=
f3_start,
+                                                             off3_start);
+
+                               break; /* This should be last section */
+                       }
+                       pbuf +=3D 16;
+               }
+
+               if (!resident_file_data)
+                       cl_dbg_warn(cl_hw, "FW resident data block [%#X-%#X=
] not found!\n",
+                                   off2_start, off2_end);
+       }
+
+       return 0;
+}
+
+static int cl_fw_upload(struct cl_chip *chip, struct cl_hw *cl_hw,
+                       u32 fw_addr, const char *data, size_t size)
+{
+       /* Is it old .bin format (used for firmware tests) */
+       if (data[IRAM_START_OFFSET] =3D=3D 0x06) {
+               const u32 *src =3D (const u32 *)data;
+               int i;
+
+               for (i =3D 0; i < size; i +=3D sizeof(*src))
+                       CL_BAR_REG_WRITE(chip, fw_addr + i, *src++);
+
+               return 0;
+       }
+
+       return cl_fw_phdrs_upload(chip, cl_hw, fw_addr, data, size);
+}
+
+static int cl_fw_load_operational(struct cl_hw *cl_hw, const char *fw_name=
,
+                                 const char *main_str, const char *dbg_str=
,
+                                 u32 ram_addr)
+{
+       int rc;
+       const struct firmware *fw;
+       char *fw_ptr;
+       size_t fw_size;
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_cached_fw *cached_fw =3D &cl_hw->cached_fw;
+
+       clear_bit(CL_DEV_FW_SYNC, &cl_hw->drv_flags);
+
+       if (!cached_fw->data) {
+               char path_name[CL_PATH_MAX] =3D {0};
+
+               snprintf(path_name, sizeof(path_name), "cl8k/%s", fw_name);
+               rc =3D request_firmware(&fw, path_name, chip->dev);
+
+               if (rc) {
+                       cl_dbg_err(cl_hw, "# Failed to get %s, with error: =
%x\n",
+                                  path_name, rc);
+                       return rc;
+               }
+               cached_fw->data =3D vzalloc(fw->size);
+               if (!cached_fw->data) {
+                       release_firmware(fw);
+                       return -ENOMEM;
+               }
+               memcpy(cached_fw->data, fw->data, fw->size);
+               cached_fw->size =3D fw->size;
+               release_firmware(fw);
+       }
+
+       rc =3D cl_fw_unpack(cached_fw->data, cached_fw->size,
+                         main_str, &fw_ptr, &fw_size);
+
+       if (rc =3D=3D 0) {
+               rc =3D cl_fw_upload(chip, cl_hw, ram_addr,
+                                 fw_ptr, fw_size);
+               /* Load other stuff packed in firmware container */
+               if (rc =3D=3D 0)
+                       rc =3D cl_fw_load_other(cl_hw, dbg_str);
+       } else if (rc !=3D -ENOENT) {
+               /* Assume it is a single file, not a container (used for te=
sts) */
+               rc =3D cl_fw_upload(chip, cl_hw, ram_addr,
+                                 cached_fw->data,
+                                 cached_fw->size);
+       }
+
+       return rc;
+}
+
+static int cl_fw_load_lmac(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (cl_fw_load_operational(cl_hw, chip->conf->ce_lmac,
+                                  "lmacfw.main", "lmacfw.dbg",
+                                  RAM_LMAC_FW_ADDR))
+               return -1;
+
+       cl_hw->fw_active =3D true;
+
+       return 0;
+}
+
+static int cl_fw_load_smac(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (cl_fw_load_operational(cl_hw, chip->conf->ce_smac,
+                                  "smacfw.main", "smacfw.dbg",
+                                  RAM_SMAC_FW_ADDR))
+               return -1;
+
+       cl_hw->fw_active =3D true;
+
+       return 0;
+}
+
+int cl_fw_file_load(struct cl_hw *cl_hw)
+{
+       /* For TCV0 load lmac, and for TCV1 load smac */
+       if (cl_hw_is_tcv0(cl_hw) &&
+           strcmp(cl_hw->chip->conf->ce_lmac, "no_load")) {
+               if (cl_fw_load_lmac(cl_hw))
+                       return -1;
+       } else if (cl_hw_is_tcv1(cl_hw) &&
+                  strcmp(cl_hw->chip->conf->ce_smac, "no_load")) {
+               if (cl_fw_load_smac(cl_hw))
+                       return -1;
+       }
+
+       return 0;
+}
+
+void cl_fw_file_cleanup(struct cl_hw *cl_hw)
+{
+       /* Clean up all firmware allocations in cl_hw */
+       cl_dbgfile_release_mem(&cl_hw->dbg_data, &cl_hw->str_offload_env);
+}
+
+void cl_fw_file_release(struct cl_hw *cl_hw)
+{
+       struct cl_cached_fw *cached_fw =3D &cl_hw->cached_fw;
+
+       if (cached_fw->data) {
+               struct cl_dma_accessed *fw_rom =3D &cl_hw->fw_remote_rom;
+
+               vfree(cached_fw->data);
+               cached_fw->data =3D NULL;
+               cached_fw->size =3D 0;
+
+               if (fw_rom->drv_v_addr) {
+                       dma_addr_t phys_dma_addr =3D le32_to_cpu(fw_rom->dm=
a_addr);
+
+                       dma_free_coherent(cl_hw->chip->dev, fw_rom->size, f=
w_rom->drv_v_addr,
+                                         phys_dma_addr);
+                       fw_rom->drv_v_addr =3D NULL;
+                       fw_rom->size =3D 0;
+                       fw_rom->fw_v_addr =3D 0;
+                       fw_rom->dma_addr =3D 0;
+               }
+       }
+}
+
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

