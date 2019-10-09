Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAABD0ECF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfJIMch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 08:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfJIMch (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 08:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03851806A53;
        Wed,  9 Oct 2019 12:32:37 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-32.ams2.redhat.com [10.36.117.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A289710027BF;
        Wed,  9 Oct 2019 12:32:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Denis Efremov <efremov@linux.com>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 5/5] staging: rtl8723bs: Remove File operation APIs
Date:   Wed,  9 Oct 2019 14:32:23 +0200
Message-Id: <20191009123223.163241-5-hdegoede@redhat.com>
In-Reply-To: <20191009123223.163241-1-hdegoede@redhat.com>
References: <20191009123223.163241-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 09 Oct 2019 12:32:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rtl8723bs had 2 private file operation helpers:

rtw_is_file_readable()
rtw_retrive_from_file()

These were only used by the removed phy_Config*WithParaFile() functions,
so they can be removed now.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../staging/rtl8723bs/include/osdep_service.h |   4 -
 .../staging/rtl8723bs/os_dep/osdep_service.c  | 136 ------------------
 2 files changed, 140 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index 81a9c19ecc6a..a40cf7b60a69 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -171,10 +171,6 @@ extern void rtw_softap_lock_suspend(void);
 extern void rtw_softap_unlock_suspend(void);
 #endif
 
-/* File operation APIs, just for linux now */
-extern int rtw_is_file_readable(char *path);
-extern int rtw_retrive_from_file(char *path, u8 *buf, u32 sz);
-
 extern void rtw_free_netdev(struct net_device * netdev);
 
 
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 25a80041ce87..f5614e56371e 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -65,142 +65,6 @@ void _rtw_init_queue(struct __queue *pqueue)
 	spin_lock_init(&(pqueue->lock));
 }
 
-/*
-* Open a file with the specific @param path, @param flag, @param mode
-* @param fpp the pointer of struct file pointer to get struct file pointer while file opening is success
-* @param path the path of the file to open
-* @param flag file operation flags, please refer to linux document
-* @param mode please refer to linux document
-* @return Linux specific error code
-*/
-static int openFile(struct file **fpp, char *path, int flag, int mode)
-{
-	struct file *fp;
-
-	fp = filp_open(path, flag, mode);
-	if (IS_ERR(fp)) {
-		*fpp = NULL;
-		return PTR_ERR(fp);
-	}
-	else {
-		*fpp = fp;
-		return 0;
-	}
-}
-
-/*
-* Close the file with the specific @param fp
-* @param fp the pointer of struct file to close
-* @return always 0
-*/
-static int closeFile(struct file *fp)
-{
-	filp_close(fp, NULL);
-	return 0;
-}
-
-static int readFile(struct file *fp, char *buf, int len)
-{
-	int rlen = 0, sum = 0;
-
-	if (!fp->f_op || !fp->f_op->read)
-		return -EPERM;
-
-	while (sum < len) {
-		rlen = kernel_read(fp, buf + sum, len - sum, &fp->f_pos);
-		if (rlen > 0)
-			sum += rlen;
-		else if (0 != rlen)
-			return rlen;
-		else
-			break;
-	}
-
-	return sum;
-
-}
-
-/*
-* Test if the specifi @param path is a file and readable
-* @param path the path of the file to test
-* @return Linux specific error code
-*/
-static int isFileReadable(char *path)
-{
-	struct file *fp;
-	int ret = 0;
-	char buf;
-
-	fp = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(fp))
-		return PTR_ERR(fp);
-
-	if (readFile(fp, &buf, 1) != 1)
-		ret = -EINVAL;
-
-	filp_close(fp, NULL);
-	return ret;
-}
-
-/*
-* Open the file with @param path and retrive the file content into memory starting from @param buf for @param sz at most
-* @param path the path of the file to open and read
-* @param buf the starting address of the buffer to store file content
-* @param sz how many bytes to read at most
-* @return the byte we've read, or Linux specific error code
-*/
-static int retriveFromFile(char *path, u8 *buf, u32 sz)
-{
-	int ret = -1;
-	struct file *fp;
-
-	if (path && buf) {
-		ret = openFile(&fp, path, O_RDONLY, 0);
-
-		if (ret == 0) {
-			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
-
-			ret = readFile(fp, buf, sz);
-			closeFile(fp);
-
-			DBG_871X("%s readFile, ret:%d\n", __func__, ret);
-
-		} else {
-			DBG_871X("%s openFile path:%s Fail, ret:%d\n", __func__, path, ret);
-		}
-	} else {
-		DBG_871X("%s NULL pointer\n", __func__);
-		ret =  -EINVAL;
-	}
-	return ret;
-}
-
-/*
-* Test if the specifi @param path is a file and readable
-* @param path the path of the file to test
-* @return true or false
-*/
-int rtw_is_file_readable(char *path)
-{
-	if (isFileReadable(path) == 0)
-		return true;
-	else
-		return false;
-}
-
-/*
-* Open the file with @param path and retrive the file content into memory starting from @param buf for @param sz at most
-* @param path the path of the file to open and read
-* @param buf the starting address of the buffer to store file content
-* @param sz how many bytes to read at most
-* @return the byte we've read
-*/
-int rtw_retrive_from_file(char *path, u8 *buf, u32 sz)
-{
-	int ret = retriveFromFile(path, buf, sz);
-	return ret >= 0 ? ret : 0;
-}
-
 struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_priv)
 {
 	struct net_device *pnetdev;
-- 
2.23.0

