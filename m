Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D576136D91D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhD1OAm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 10:00:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240085AbhD1OAl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 10:00:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0AAF1063;
        Wed, 28 Apr 2021 06:59:55 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2D703F694;
        Wed, 28 Apr 2021 06:59:49 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH 3/4] s390/hmcdrv: Remove the redundant directory path in debug message
Date:   Wed, 28 Apr 2021 21:59:28 +0800
Message-Id: <20210428135929.27011-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210428135929.27011-1-justin.he@arm.com>
References: <20210428135929.27011-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It would be better to use full file path with '%pD' instead of hard coding.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/s390/char/hmcdrv_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 20e9cd542e03..cdde75508c8a 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -137,7 +137,7 @@ static int hmcdrv_dev_open(struct inode *inode, struct file *fp)
 	if (rc)
 		module_put(THIS_MODULE);
 
-	pr_debug("open file '/dev/%pD' with return code %d\n", fp, rc);
+	pr_debug("open file '%pD' with return code %d\n", fp, rc);
 	return rc;
 }
 
@@ -146,7 +146,7 @@ static int hmcdrv_dev_open(struct inode *inode, struct file *fp)
  */
 static int hmcdrv_dev_release(struct inode *inode, struct file *fp)
 {
-	pr_debug("closing file '/dev/%pD'\n", fp);
+	pr_debug("closing file '%pD'\n", fp);
 	kfree(fp->private_data);
 	fp->private_data = NULL;
 	hmcdrv_ftp_shutdown();
@@ -231,7 +231,7 @@ static ssize_t hmcdrv_dev_read(struct file *fp, char __user *ubuf,
 	retlen = hmcdrv_dev_transfer((char *) fp->private_data,
 				     *pos, ubuf, len);
 
-	pr_debug("read from file '/dev/%pD' at %lld returns %zd/%zu\n",
+	pr_debug("read from file '%pD' at %lld returns %zd/%zu\n",
 		 fp, (long long) *pos, retlen, len);
 
 	if (retlen > 0)
@@ -248,7 +248,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 {
 	ssize_t retlen;
 
-	pr_debug("writing file '/dev/%pD' at pos. %lld with length %zd\n",
+	pr_debug("writing file '%pD' at pos. %lld with length %zd\n",
 		 fp, (long long) *pos, len);
 
 	if (!fp->private_data) { /* first expect a cmd write */
@@ -272,7 +272,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 	if (retlen > 0)
 		*pos += retlen;
 
-	pr_debug("write to file '/dev/%pD' returned %zd\n", fp, retlen);
+	pr_debug("write to file '%pD' returned %zd\n", fp, retlen);
 
 	return retlen;
 }
-- 
2.17.1

