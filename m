Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D821C9A21
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEGS5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 14:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEGS5o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 14:57:44 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EAE20575;
        Thu,  7 May 2020 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877863;
        bh=9XCa7JR8FEKWus1Qn+mqDl5wGlHwBasdYcxvlyL3UIE=;
        h=Date:From:To:Cc:Subject:From;
        b=cLWoOWnWSjpR3Du9o2F3Qd82FQmLI/66sVQVdLxm/bSd9nVkav9uvOsbnuU6GHk0z
         AF1Ah4JK+jKnhfwg915hBJM18wQtcYCXuNBVrgNqwyv5ZYI2YbxVHOaDOBdpzkHmsF
         UdYkx8KJjFYUHvoWcoUzis4TTuaXjWsYQNTP6qC4=
Date:   Thu, 7 May 2020 14:02:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] prism54: Replace zero-length array with flexible-array
Message-ID: <20200507190210.GA15375@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intersil/prism54/isl_oid.h    |    8 ++++----
 drivers/net/wireless/intersil/prism54/islpci_mgt.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intersil/prism54/isl_oid.h b/drivers/net/wireless/intersil/prism54/isl_oid.h
index 5441c1f9f2fc..1afc2ccf94ca 100644
--- a/drivers/net/wireless/intersil/prism54/isl_oid.h
+++ b/drivers/net/wireless/intersil/prism54/isl_oid.h
@@ -37,7 +37,7 @@ struct obj_mlmeex {
 	u16 state;
 	u16 code;
 	u16 size;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct obj_buffer {
@@ -68,12 +68,12 @@ struct obj_bss {
 
 struct obj_bsslist {
 	u32 nr;
-	struct obj_bss bsslist[0];
+	struct obj_bss bsslist[];
 } __packed;
 
 struct obj_frequencies {
 	u16 nr;
-	u16 mhz[0];
+	u16 mhz[];
 } __packed;
 
 struct obj_attachment {
@@ -81,7 +81,7 @@ struct obj_attachment {
 	char reserved;
 	short id;
 	short size;
-	char data[0];
+	char data[];
 } __packed;
 
 /*
diff --git a/drivers/net/wireless/intersil/prism54/islpci_mgt.h b/drivers/net/wireless/intersil/prism54/islpci_mgt.h
index d6bbbac46b4a..1f87d0aea60c 100644
--- a/drivers/net/wireless/intersil/prism54/islpci_mgt.h
+++ b/drivers/net/wireless/intersil/prism54/islpci_mgt.h
@@ -99,7 +99,7 @@ struct islpci_mgmtframe {
 	pimfor_header_t *header;      /* payload header, points into buf */
 	void *data;		      /* payload ex header, points into buf */
         struct work_struct ws;	      /* argument for schedule_work() */
-	char buf[0];		      /* fragment buffer */
+	char buf[];		      /* fragment buffer */
 };
 
 int

