Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF332255190
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 01:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgH0XaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 19:30:09 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45062 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0XaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 19:30:07 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5773B13C2B0;
        Thu, 27 Aug 2020 16:30:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5773B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1598571006;
        bh=lX2hkrw1BWRViNiVQI/gAHoTKuKiXummP18AsIAO1QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BdfLH1w7QsQUMA75pJQXrvrFKGumRgxIQipMNNoEJPU6ZayCMMcYKey9sBgbDA847
         O3kTf8i7m/pb0ddgXE5c0+v13dxdf+DI7RUzEBYGgwO+0JcVzTYvL5MwqpIDBlr9tU
         I5kHpU66hro8RvpavvdeX01F9QScrwirKNUsa+l4=
From:   greearb@candelatech.com
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] ath11k:  Add firmware_info file to debugfs
Date:   Thu, 27 Aug 2020 16:30:02 -0700
Message-Id: <20200827233002.21483-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827233002.21483-1-greearb@candelatech.com>
References: <20200827233002.21483-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This shows the fwcfg file name so that users don't have to guess,
as well as some other info about the firmware and radio.

directory: QCA6390/hw2.0
fwcfg:     fwcfg-pci-0000:14:00.0.txt
bus:       0000:14:00.0
version:   0x101c06cc
hw_rev:    6390-hw2
board:     board.bin

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/ath/ath11k/debug.c | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 2ac0df8aee26..38ffcae67ab5 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -398,6 +398,59 @@ static const struct file_operations fops_pdev_stats = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_read_fwinfo(struct file *file,
+				  char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct ath11k_base *ab = file->private_data;
+	char *buf;
+	unsigned int len = 0, buf_len = 1000;
+	ssize_t ret_cnt;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* TODO:  Locking? */
+
+	len = snprintf(buf, buf_len, "directory: %s\nfwcfg:     fwcfg-%s-%s.txt\nbus:       %s",
+		       ab->hw_params.fw.dir,
+		       ath11k_bus_str(ab->hif.bus), dev_name(ab->dev), dev_name(ab->dev));
+
+	/* Just to be safe */
+	buf[buf_len - 1] = 0;
+	len = strlen(buf);
+
+	len += snprintf(buf + len, buf_len - len, "\nversion:   0x%0x\nhw_rev:    ",
+			ab->qmi.target.fw_version);
+	switch (ab->hw_rev) {
+	case ATH11K_HW_QCA6390_HW11:
+		len += snprintf(buf + len, buf_len - len, "6390-hw1\n");
+		break;
+	case ATH11K_HW_QCA6390_HW20:
+		len += snprintf(buf + len, buf_len - len, "6390-hw2\n");
+		break;
+	case ATH11K_HW_IPQ8074:
+		len += snprintf(buf + len, buf_len - len, "8074\n");
+		break;
+	}
+
+	len += snprintf(buf + len, buf_len - len, "board:     %s\n",
+			ab->fw_board_name);
+
+	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+
+	kfree(buf);
+	return ret_cnt;
+}
+
+static const struct file_operations fops_fwinfo_services = {
+	.read = ath11k_read_fwinfo,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static int ath11k_open_vdev_stats(struct inode *inode, struct file *file)
 {
 	struct ath11k *ar = inode->i_private;
@@ -1201,6 +1254,9 @@ int ath11k_debug_register(struct ath11k *ar)
 				    &ar->dfs_block_radar_events);
 	}
 
+	debugfs_create_file("firmware_info", 0400, ar->debug.debugfs_pdev, ab,
+			    &fops_fwinfo_services);
+
 	return 0;
 }
 
-- 
2.26.2

