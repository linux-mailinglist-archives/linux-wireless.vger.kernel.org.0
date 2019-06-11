Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1287C3D683
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407457AbfFKTKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 15:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407141AbfFKTKb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 15:10:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E3D2183E;
        Tue, 11 Jun 2019 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560280229;
        bh=IRI2jafQQVnG7eS8oJSDlBqbK7g+mxZls+7IGPq1zVM=;
        h=Date:From:To:Cc:Subject:From;
        b=cGYNrZ/7x0YqYE0ikIWkg4OL8Hp2wO7OkDNgP2gbVFdlXqFouYvNtZKTdcNNdvPu4
         /lVEpVuW4NYgt2fwWot+ajNLm7+rGKDbtl5jPymIvAwtMftpOVUmay9twp+2QOx3NI
         BpjGq1R+2tVmoNsXzc229u4hdLeFMTYxP0lke0Jg=
Date:   Tue, 11 Jun 2019 21:10:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maya Erez <merez@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH] wireless: wil6210: no need to check return value of
 debugfs_create functions
Message-ID: <20190611191024.GA17227@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 80 ++++++----------------
 1 file changed, 22 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index df2adff6c33a..ea5da93196fd 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -394,25 +394,18 @@ static int wil_debugfs_iomem_x32_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_iomem_x32, wil_debugfs_iomem_x32_get,
 			 wil_debugfs_iomem_x32_set, "0x%08llx\n");
 
-static struct dentry *wil_debugfs_create_iomem_x32(const char *name,
-						   umode_t mode,
-						   struct dentry *parent,
-						   void *value,
-						   struct wil6210_priv *wil)
+static void wil_debugfs_create_iomem_x32(const char *name, umode_t mode,
+					 struct dentry *parent, void *value,
+					 struct wil6210_priv *wil)
 {
-	struct dentry *file;
 	struct wil_debugfs_iomem_data *data = &wil->dbg_data.data_arr[
 					      wil->dbg_data.iomem_data_count];
 
 	data->wil = wil;
 	data->offset = value;
 
-	file = debugfs_create_file_unsafe(name, mode, parent, data,
-					  &fops_iomem_x32);
-	if (!IS_ERR_OR_NULL(file))
-		wil->dbg_data.iomem_data_count++;
-
-	return file;
+	debugfs_create_file_unsafe(name, mode, parent, data, &fops_iomem_x32);
+	wil->dbg_data.iomem_data_count++;
 }
 
 static int wil_debugfs_ulong_set(void *data, u64 val)
@@ -430,14 +423,6 @@ static int wil_debugfs_ulong_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(wil_fops_ulong, wil_debugfs_ulong_get,
 			 wil_debugfs_ulong_set, "0x%llx\n");
 
-static struct dentry *wil_debugfs_create_ulong(const char *name, umode_t mode,
-					       struct dentry *parent,
-					       ulong *value)
-{
-	return debugfs_create_file_unsafe(name, mode, parent, value,
-					  &wil_fops_ulong);
-}
-
 /**
  * wil6210_debugfs_init_offset - create set of debugfs files
  * @wil - driver's context, used for printing
@@ -454,37 +439,30 @@ static void wil6210_debugfs_init_offset(struct wil6210_priv *wil,
 	int i;
 
 	for (i = 0; tbl[i].name; i++) {
-		struct dentry *f;
-
 		switch (tbl[i].type) {
 		case doff_u32:
-			f = debugfs_create_u32(tbl[i].name, tbl[i].mode, dbg,
-					       base + tbl[i].off);
+			debugfs_create_u32(tbl[i].name, tbl[i].mode, dbg,
+					   base + tbl[i].off);
 			break;
 		case doff_x32:
-			f = debugfs_create_x32(tbl[i].name, tbl[i].mode, dbg,
-					       base + tbl[i].off);
+			debugfs_create_x32(tbl[i].name, tbl[i].mode, dbg,
+					   base + tbl[i].off);
 			break;
 		case doff_ulong:
-			f = wil_debugfs_create_ulong(tbl[i].name, tbl[i].mode,
-						     dbg, base + tbl[i].off);
+			debugfs_create_file_unsafe(tbl[i].name, tbl[i].mode,
+						   dbg, base + tbl[i].off,
+						   &wil_fops_ulong);
 			break;
 		case doff_io32:
-			f = wil_debugfs_create_iomem_x32(tbl[i].name,
-							 tbl[i].mode, dbg,
-							 base + tbl[i].off,
-							 wil);
+			wil_debugfs_create_iomem_x32(tbl[i].name, tbl[i].mode,
+						     dbg, base + tbl[i].off,
+						     wil);
 			break;
 		case doff_u8:
-			f = debugfs_create_u8(tbl[i].name, tbl[i].mode, dbg,
-					      base + tbl[i].off);
+			debugfs_create_u8(tbl[i].name, tbl[i].mode, dbg,
+					  base + tbl[i].off);
 			break;
-		default:
-			f = ERR_PTR(-EINVAL);
 		}
-		if (IS_ERR_OR_NULL(f))
-			wil_err(wil, "Create file \"%s\": err %ld\n",
-				tbl[i].name, PTR_ERR(f));
 	}
 }
 
@@ -499,19 +477,14 @@ static const struct dbg_off isr_off[] = {
 	{},
 };
 
-static int wil6210_debugfs_create_ISR(struct wil6210_priv *wil,
-				      const char *name,
-				      struct dentry *parent, u32 off)
+static void wil6210_debugfs_create_ISR(struct wil6210_priv *wil,
+				       const char *name, struct dentry *parent,
+				       u32 off)
 {
 	struct dentry *d = debugfs_create_dir(name, parent);
 
-	if (IS_ERR_OR_NULL(d))
-		return -ENODEV;
-
 	wil6210_debugfs_init_offset(wil, d, (void * __force)wil->csr + off,
 				    isr_off);
-
-	return 0;
 }
 
 static const struct dbg_off pseudo_isr_off[] = {
@@ -521,18 +494,13 @@ static const struct dbg_off pseudo_isr_off[] = {
 	{},
 };
 
-static int wil6210_debugfs_create_pseudo_ISR(struct wil6210_priv *wil,
-					     struct dentry *parent)
+static void wil6210_debugfs_create_pseudo_ISR(struct wil6210_priv *wil,
+					      struct dentry *parent)
 {
 	struct dentry *d = debugfs_create_dir("PSEUDO_ISR", parent);
 
-	if (IS_ERR_OR_NULL(d))
-		return -ENODEV;
-
 	wil6210_debugfs_init_offset(wil, d, (void * __force)wil->csr,
 				    pseudo_isr_off);
-
-	return 0;
 }
 
 static const struct dbg_off lgc_itr_cnt_off[] = {
@@ -580,13 +548,9 @@ static int wil6210_debugfs_create_ITR_CNT(struct wil6210_priv *wil,
 	struct dentry *d, *dtx, *drx;
 
 	d = debugfs_create_dir("ITR_CNT", parent);
-	if (IS_ERR_OR_NULL(d))
-		return -ENODEV;
 
 	dtx = debugfs_create_dir("TX", d);
 	drx = debugfs_create_dir("RX", d);
-	if (IS_ERR_OR_NULL(dtx) || IS_ERR_OR_NULL(drx))
-		return -ENODEV;
 
 	wil6210_debugfs_init_offset(wil, d, (void * __force)wil->csr,
 				    lgc_itr_cnt_off);
-- 
2.22.0

