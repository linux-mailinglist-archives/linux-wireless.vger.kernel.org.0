Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE173083C4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 03:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhA2CXS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 21:23:18 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42655 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhA2CXL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 21:23:11 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10T2MLQx8015096, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10T2MLQx8015096
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Jan 2021 10:22:21 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 29 Jan
 2021 10:22:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 04/18] rtw89: add debug files
Date:   Fri, 29 Jan 2021 10:21:03 +0800
Message-ID: <20210129022117.28463-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129022117.28463-1-pkshih@realtek.com>
References: <20210129022117.28463-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To recognize issues happened in field, two debug methods, debug message and
debugfs, are added.

The debug messages are written to kernel log, and four levels can be chosen
according to the cases -- debug, info, warn and err.

Debugfs is used to read and write registers and driver status.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 1927 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/debug.h |   75 +
 2 files changed, 2002 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/debug.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/debug.h

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
new file mode 100644
index 000000000000..da831da1905b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -0,0 +1,1927 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "mac.h"
+#include "reg.h"
+
+#ifdef CONFIG_RTW89_DEBUGMSG
+unsigned int rtw89_debug_mask;
+EXPORT_SYMBOL(rtw89_debug_mask);
+module_param_named(debug_mask, rtw89_debug_mask, uint, 0644);
+MODULE_PARM_DESC(debug_mask, "Debugging mask");
+#endif
+
+#ifdef CONFIG_RTW89_DEBUGFS
+struct rtw89_debugfs_priv {
+	struct rtw89_dev *rtwdev;
+	int (*cb_read)(struct seq_file *m, void *v);
+	ssize_t (*cb_write)(struct file *filp, const char __user *buffer,
+			    size_t count, loff_t *loff);
+	union {
+		u32 cb_data;
+		struct {
+			u32 addr;
+			u8 len;
+		} read_reg;
+		struct {
+			u32 addr;
+			u32 mask;
+			u8 path;
+		} read_rf;
+		struct {
+			u8 ss_dbg:1;
+			u8 dle_dbg:1;
+			u8 dmac_dbg:1;
+			u8 cmac_dbg:1;
+			u8 dbg_port:1;
+		} dbgpkg_en;
+		struct {
+			u32 start;
+			u32 len;
+			u8 sel;
+		} mac_mem;
+	};
+};
+
+static int rtw89_debugfs_single_show(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+
+	return debugfs_priv->cb_read(m, v);
+}
+
+static ssize_t rtw89_debugfs_single_write(struct file *filp,
+					  const char __user *buffer,
+					  size_t count, loff_t *loff)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+
+	return debugfs_priv->cb_write(filp, buffer, count, loff);
+}
+
+static ssize_t rtw89_debugfs_seq_file_write(struct file *filp,
+					    const char __user *buffer,
+					    size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = seqpriv->private;
+
+	return debugfs_priv->cb_write(filp, buffer, count, loff);
+}
+
+static int rtw89_debugfs_single_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, rtw89_debugfs_single_show, inode->i_private);
+}
+
+static int rtw89_debugfs_close(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static const struct file_operations file_ops_single_r = {
+	.owner = THIS_MODULE,
+	.open = rtw89_debugfs_single_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static const struct file_operations file_ops_common_rw = {
+	.owner = THIS_MODULE,
+	.open = rtw89_debugfs_single_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.write = rtw89_debugfs_seq_file_write,
+};
+
+static const struct file_operations file_ops_single_w = {
+	.owner = THIS_MODULE,
+	.write = rtw89_debugfs_single_write,
+	.open = simple_open,
+	.release = rtw89_debugfs_close,
+};
+
+static ssize_t
+rtw89_debug_priv_read_reg_select(struct file *filp,
+				 const char __user *user_buf,
+				 size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	u32 addr, len;
+	int num;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	num = sscanf(buf, "%x %x", &addr, &len);
+	if (num != 2) {
+		rtw89_info(rtwdev, "invalid format: <addr> <len>\n");
+		return -EINVAL;
+	}
+
+	debugfs_priv->read_reg.addr = addr;
+	debugfs_priv->read_reg.len = len;
+
+	rtw89_info(rtwdev, "select read %d bytes from 0x%08x\n", len, addr);
+
+	return count;
+}
+
+static int rtw89_debug_priv_read_reg_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	u32 addr, data;
+	u8 len;
+
+	len = debugfs_priv->read_reg.len;
+	addr = debugfs_priv->read_reg.addr;
+
+	switch (len) {
+	case 1:
+		data = rtw89_read8(rtwdev, addr);
+		break;
+	case 2:
+		data = rtw89_read16(rtwdev, addr);
+		break;
+	case 4:
+		data = rtw89_read32(rtwdev, addr);
+		break;
+	default:
+		rtw89_info(rtwdev, "invalid read reg len %d\n", len);
+		return -EINVAL;
+	}
+
+	seq_printf(m, "get %d bytes at 0x%08x=0x%08x\n", len, addr, data);
+
+	return 0;
+}
+
+static ssize_t rtw89_debug_priv_write_reg_set(struct file *filp,
+					      const char __user *user_buf,
+					      size_t count, loff_t *loff)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	u32 addr, val, len;
+	int num;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	num = sscanf(buf, "%x %x %x", &addr, &val, &len);
+	if (num !=  3) {
+		rtw89_info(rtwdev, "invalid format: <addr> <val> <len>\n");
+		return -EINVAL;
+	}
+
+	switch (len) {
+	case 1:
+		rtw89_info(rtwdev, "reg write8 0x%08x: 0x%02x\n", addr, val);
+		rtw89_write8(rtwdev, addr, (u8)val);
+		break;
+	case 2:
+		rtw89_info(rtwdev, "reg write16 0x%08x: 0x%04x\n", addr, val);
+		rtw89_write16(rtwdev, addr, (u16)val);
+		break;
+	case 4:
+		rtw89_info(rtwdev, "reg write32 0x%08x: 0x%08x\n", addr, val);
+		rtw89_write32(rtwdev, addr, (u32)val);
+		break;
+	default:
+		rtw89_info(rtwdev, "invalid read write len %d\n", len);
+		break;
+	}
+
+	return count;
+}
+
+static ssize_t
+rtw89_debug_priv_read_rf_select(struct file *filp,
+				const char __user *user_buf,
+				size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	u32 addr, mask;
+	u8 path;
+	int num;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	num = sscanf(buf, "%hhd %x %x", &path, &addr, &mask);
+	if (num != 3) {
+		rtw89_info(rtwdev, "invalid format: <path> <addr> <mask>\n");
+		return -EINVAL;
+	}
+
+	if (path >= rtwdev->chip->rf_path_num) {
+		rtw89_info(rtwdev, "wrong rf path\n");
+		return -EINVAL;
+	}
+	debugfs_priv->read_rf.addr = addr;
+	debugfs_priv->read_rf.mask = mask;
+	debugfs_priv->read_rf.path = path;
+
+	rtw89_info(rtwdev, "select read rf path %d from 0x%08x\n", path, addr);
+
+	return count;
+}
+
+static int rtw89_debug_priv_read_rf_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	u32 addr, data, mask;
+	u8 path;
+
+	addr = debugfs_priv->read_rf.addr;
+	mask = debugfs_priv->read_rf.mask;
+	path = debugfs_priv->read_rf.path;
+
+	data = rtw89_read_rf(rtwdev, path, addr, mask);
+
+	seq_printf(m, "path %d, rf register 0x%08x=0x%08x\n", path, addr, data);
+
+	return 0;
+}
+
+static ssize_t rtw89_debug_priv_write_rf_set(struct file *filp,
+					     const char __user *user_buf,
+					     size_t count, loff_t *loff)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	u32 addr, val, mask;
+	u8 path;
+	int num;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	num = sscanf(buf, "%hhd %x %x %x", &path, &addr, &mask, &val);
+	if (num != 4) {
+		rtw89_info(rtwdev, "invalid format: <path> <addr> <mask> <val>\n");
+		return -EINVAL;
+	}
+
+	if (path >= rtwdev->chip->rf_path_num) {
+		rtw89_info(rtwdev, "wrong rf path\n");
+		return -EINVAL;
+	}
+
+	rtw89_info(rtwdev, "path %d, rf register write 0x%08x=0x%08x (mask = 0x%08x)\n",
+		   path, addr, val, mask);
+	rtw89_write_rf(rtwdev, path, addr, mask, val);
+
+	return count;
+}
+
+static int rtw89_debug_priv_rf_reg_dump_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 addr, offset, data;
+	u8 path;
+
+	for (path = 0; path < chip->rf_path_num; path++) {
+		seq_printf(m, "RF path %d:\n\n", path);
+		for (addr = 0; addr < 0x100; addr += 4) {
+			seq_printf(m, "0x%08x: ", addr);
+			for (offset = 0; offset < 4; offset++) {
+				data = rtw89_read_rf(rtwdev, path,
+						     addr + offset, RFREG_MASK);
+				seq_printf(m, "0x%05x  ", data);
+			}
+			seq_puts(m, "\n");
+		}
+		seq_puts(m, "\n");
+	}
+
+	return 0;
+}
+
+static ssize_t
+rtw89_debug_priv_mac_reg_dump_select(struct file *filp,
+				     const char __user *user_buf,
+				     size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	int sel;
+	int ret;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	ret = kstrtoint(buf, 0, &sel);
+	if (ret)
+		return ret;
+
+	if (sel < RTW89_DBG_SEL_MAC_00 || sel > RTW89_DBG_SEL_RFC) {
+		rtw89_info(rtwdev, "invalid args: %d\n", sel);
+		return -EINVAL;
+	}
+
+	debugfs_priv->cb_data = sel;
+	rtw89_info(rtwdev, "select mac page dump %d\n", debugfs_priv->cb_data);
+
+	return count;
+}
+
+#define RTW89_MAC_PAGE_SIZE		0x100
+
+static int rtw89_debug_priv_mac_reg_dump_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	enum rtw89_debug_mac_reg_sel reg_sel = debugfs_priv->cb_data;
+	u32 start, end;
+	u32 i, j, k, page;
+	u32 val;
+
+	switch (reg_sel) {
+	case RTW89_DBG_SEL_MAC_00:
+		seq_puts(m, "Debug selected MAC page 0x00\n");
+		start = 0x000;
+		end = 0x03f;
+		break;
+	case RTW89_DBG_SEL_MAC_40:
+		seq_puts(m, "Debug selected MAC page 0x40\n");
+		start = 0x040;
+		end = 0x07f;
+		break;
+	case RTW89_DBG_SEL_MAC_80:
+		seq_puts(m, "Debug selected MAC page 0x80\n");
+		start = 0x080;
+		end = 0x0bf;
+		break;
+	case RTW89_DBG_SEL_MAC_C0:
+		seq_puts(m, "Debug selected MAC page 0xc0\n");
+		start = 0x0c0;
+		end = 0x0df;
+		break;
+	case RTW89_DBG_SEL_MAC_E0:
+		seq_puts(m, "Debug selected MAC page 0xe0\n");
+		start = 0x0e0;
+		end = 0x0ff;
+		break;
+	case RTW89_DBG_SEL_BB:
+		seq_puts(m, "Debug selected BB register\n");
+		start = 0x100;
+		end = 0x17f;
+		break;
+	case RTW89_DBG_SEL_IQK:
+		seq_puts(m, "Debug selected IQK register\n");
+		start = 0x180;
+		end = 0x1bf;
+		break;
+	case RTW89_DBG_SEL_RFC:
+		seq_puts(m, "Debug selected RFC register\n");
+		start = 0x1c0;
+		end = 0x1ff;
+		break;
+	default:
+		seq_puts(m, "Selected invalid register page\n");
+		return -EINVAL;
+	}
+
+	for (i = start; i <= end; i++) {
+		page = i << 8;
+		for (j = page; j < page + RTW89_MAC_PAGE_SIZE; j += 16) {
+			seq_printf(m, "%08xh : ", 0x18600000 + j);
+			for (k = 0; k < 4; k++) {
+				val = rtw89_read32(rtwdev, j + (k << 2));
+				seq_printf(m, "%08x ", val);
+			}
+			seq_puts(m, "\n");
+		}
+	}
+
+	return 0;
+}
+
+static ssize_t
+rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
+				     const char __user *user_buf,
+				     size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	u32 sel, start_addr, len;
+	int num;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	num = sscanf(buf, "%x %x %x", &sel, &start_addr, &len);
+	if (num != 3) {
+		rtw89_info(rtwdev, "invalid format: <sel> <start> <len>\n");
+		return -EINVAL;
+	}
+
+	debugfs_priv->mac_mem.sel = sel;
+	debugfs_priv->mac_mem.start = start_addr;
+	debugfs_priv->mac_mem.len = len;
+
+	rtw89_info(rtwdev, "select mem %d start %d len %d\n",
+		   sel, start_addr, len);
+
+	return count;
+}
+
+static const u32 mac_mem_base_addr_table[RTW89_MAC_MEM_MAX] = {
+	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
+	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
+	[RTW89_MAC_MEM_SHCUT_MACHDR]	= SHCUT_MACHDR_BASE_ADDR,
+	[RTW89_MAC_MEM_STA_SCHED]	= STA_SCHED_BASE_ADDR,
+	[RTW89_MAC_MEM_RXPLD_FLTR_CAM]	= RXPLD_FLTR_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_SECURITY_CAM]	= SECURITY_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_WOW_CAM]		= WOW_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_CMAC_TBL]	= CMAC_TBL_BASE_ADDR,
+	[RTW89_MAC_MEM_ADDR_CAM]	= ADDR_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_BA_CAM]		= BA_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_BCN_IE_CAM0]	= BCN_IE_CAM0_BASE_ADDR,
+	[RTW89_MAC_MEM_BCN_IE_CAM1]	= BCN_IE_CAM1_BASE_ADDR,
+};
+
+static void rtw89_debug_dump_mac_mem(struct seq_file *m,
+				     struct rtw89_dev *rtwdev,
+				     u8 sel, u32 start_addr, u32 len)
+{
+	u32 base_addr, start_page, residue;
+	u32 i, j, p, pages;
+	u32 dump_len, remain;
+	u32 val;
+
+	remain = len;
+	pages = len / MAC_MEM_DUMP_PAGE_SIZE + 1;
+	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
+	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
+	base_addr = mac_mem_base_addr_table[sel];
+	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
+
+	for (p = 0; p < pages; p++) {
+		dump_len = min_t(u32, remain, MAC_MEM_DUMP_PAGE_SIZE);
+		rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, base_addr);
+		for (i = R_AX_INDIR_ACCESS_ENTRY + residue;
+		     i < R_AX_INDIR_ACCESS_ENTRY + dump_len;
+		     i += 4) {
+			seq_printf(m, "%08xh:", i);
+			for (j = 0;
+			     j < 4 && i < R_AX_INDIR_ACCESS_ENTRY + dump_len;
+			     j++, i += 4) {
+				val = rtw89_read32(rtwdev, i);
+				seq_printf(m, "  %08x", val);
+				remain -= 4;
+			}
+			seq_puts(m, "\n");
+		}
+		base_addr += MAC_MEM_DUMP_PAGE_SIZE;
+	}
+}
+
+static int
+rtw89_debug_priv_mac_mem_dump_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+
+	rtw89_debug_dump_mac_mem(m, rtwdev,
+				 debugfs_priv->mac_mem.sel,
+				 debugfs_priv->mac_mem.start,
+				 debugfs_priv->mac_mem.len);
+
+	return 0;
+}
+
+static ssize_t
+rtw89_debug_priv_mac_dbg_port_dump_select(struct file *filp,
+					  const char __user *user_buf,
+					  size_t count, loff_t *loff)
+{
+	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	char buf[32];
+	size_t buf_size;
+	int sel, set;
+	int num;
+	bool enable;
+
+	buf_size = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	num = sscanf(buf, "%d %d", &sel, &set);
+	if (num != 2) {
+		rtw89_info(rtwdev, "invalid format: <sel> <set>\n");
+		return -EINVAL;
+	}
+
+	enable = set == 0 ? false : true;
+	switch (sel) {
+	case 0:
+		debugfs_priv->dbgpkg_en.ss_dbg = enable;
+		break;
+	case 1:
+		debugfs_priv->dbgpkg_en.dle_dbg = enable;
+		break;
+	case 2:
+		debugfs_priv->dbgpkg_en.dmac_dbg = enable;
+		break;
+	case 3:
+		debugfs_priv->dbgpkg_en.cmac_dbg = enable;
+		break;
+	case 4:
+		debugfs_priv->dbgpkg_en.dbg_port = enable;
+		break;
+	default:
+		rtw89_info(rtwdev, "invalid args: sel %d set %d\n", sel, set);
+		return -EINVAL;
+	}
+
+	rtw89_info(rtwdev, "%s debug port dump %d\n",
+		   enable ? "Enable" : "Disable", sel);
+
+	return count;
+}
+
+static int rtw89_debug_mac_dump_ss_dbg(struct rtw89_dev *rtwdev,
+				       struct seq_file *m)
+{
+	return 0;
+}
+
+static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
+					struct seq_file *m)
+{
+#define DLE_DFI_DUMP(__type, __target, __sel)				\
+({									\
+	u32 __ctrl;							\
+	u32 __reg_ctrl = R_AX_##__type##_DBG_FUN_INTF_CTL;		\
+	u32 __reg_data = R_AX_##__type##_DBG_FUN_INTF_DATA;		\
+	u32 __data, __val32;						\
+	int __ret;							\
+									\
+	__ctrl = FIELD_PREP(B_AX_##__type##_DFI_TRGSEL,			\
+			    DLE_DFI_TYPE_##__target) |			\
+		 FIELD_PREP(B_AX_##__type##_DFI_ADDR, __sel) |		\
+		 B_AX_WDE_DFI_ACTIVE;					\
+	rtw89_write32(rtwdev, __reg_ctrl, __ctrl);			\
+	__ret = read_poll_timeout(rtw89_read32, __val32,		\
+			!(__val32 & B_AX_##__type##_DFI_ACTIVE),	\
+			1000, 50000, false,				\
+			rtwdev, __reg_ctrl);				\
+	if (__ret) {							\
+		rtw89_err(rtwdev, "failed to dump DLE %s %s %d\n",	\
+			  #__type, #__target, __sel);			\
+		return __ret;						\
+	}								\
+									\
+	__data = rtw89_read32(rtwdev, __reg_data);			\
+	__data;								\
+})
+
+#define DLE_DFI_FREE_PAGE_DUMP(__m, __type)				\
+({									\
+	u32 __freepg, __pubpg;						\
+	u32 __freepg_head, __freepg_tail, __pubpg_num;			\
+									\
+	__freepg = DLE_DFI_DUMP(__type, FREEPG, 0);			\
+	__pubpg = DLE_DFI_DUMP(__type, FREEPG, 1);			\
+	__freepg_head = FIELD_GET(B_AX_DLE_FREE_HEADPG, __freepg);	\
+	__freepg_tail = FIELD_GET(B_AX_DLE_FREE_TAILPG, __freepg);	\
+	__pubpg_num = FIELD_GET(B_AX_DLE_PUB_PGNUM, __pubpg);		\
+	seq_printf(__m, "[%s] freepg head: %d\n",			\
+		   #__type, __freepg_head);				\
+	seq_printf(__m, "[%s] freepg tail: %d\n",			\
+		   #__type, __freepg_tail);				\
+	seq_printf(__m, "[%s] pubpg num  : %d\n",			\
+		  #__type, __pubpg_num);				\
+})
+
+#define case_QUOTA(__m, __type, __id)					\
+	case __type##_QTAID_##__id:					\
+		val32 = DLE_DFI_DUMP(__type, QUOTA, __type##_QTAID_##__id);	\
+		rsv_pgnum = FIELD_GET(B_AX_DLE_RSV_PGNUM, val32);	\
+		use_pgnum = FIELD_GET(B_AX_DLE_USE_PGNUM, val32);	\
+		seq_printf(__m, "[%s][%s] rsv_pgnum: %d\n",		\
+			   #__type, #__id, rsv_pgnum);			\
+		seq_printf(__m, "[%s][%s] use_pgnum: %d\n",		\
+			   #__type, #__id, use_pgnum);			\
+		break
+	u32 quota_id;
+	u32 val32;
+	u16 rsv_pgnum, use_pgnum;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
+	if (ret) {
+		seq_puts(m, "[DLE]  : DMAC not enabled\n");
+		return ret;
+	}
+
+	DLE_DFI_FREE_PAGE_DUMP(m, WDE);
+	DLE_DFI_FREE_PAGE_DUMP(m, PLE);
+	for (quota_id = 0; quota_id <= WDE_QTAID_CPUIO; quota_id++) {
+		switch (quota_id) {
+		case_QUOTA(m, WDE, HOST_IF);
+		case_QUOTA(m, WDE, WLAN_CPU);
+		case_QUOTA(m, WDE, DATA_CPU);
+		case_QUOTA(m, WDE, PKTIN);
+		case_QUOTA(m, WDE, CPUIO);
+		}
+	}
+	for (quota_id = 0; quota_id <= PLE_QTAID_CPUIO; quota_id++) {
+		switch (quota_id) {
+		case_QUOTA(m, PLE, B0_TXPL);
+		case_QUOTA(m, PLE, B1_TXPL);
+		case_QUOTA(m, PLE, C2H);
+		case_QUOTA(m, PLE, H2C);
+		case_QUOTA(m, PLE, WLAN_CPU);
+		case_QUOTA(m, PLE, MPDU);
+		case_QUOTA(m, PLE, CMAC0_RX);
+		case_QUOTA(m, PLE, CMAC1_RX);
+		case_QUOTA(m, PLE, CMAC1_BBRPT);
+		case_QUOTA(m, PLE, WDRLS);
+		case_QUOTA(m, PLE, CPUIO);
+		}
+	}
+
+	return 0;
+
+#undef case_QUOTA
+#undef DLE_DFI_DUMP
+#undef DLE_DFI_FREE_PAGE_DUMP
+}
+
+static int rtw89_debug_mac_dump_dmac_dbg(struct rtw89_dev *rtwdev,
+					 struct seq_file *m)
+{
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
+	if (ret) {
+		seq_puts(m, "[DMAC] : DMAC not enabled\n");
+		return ret;
+	}
+
+	seq_printf(m, "R_AX_DMAC_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR));
+	seq_printf(m, "[0]R_AX_WDRLS_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
+	seq_printf(m, "[1]R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_SEC_ERR_IMR_ISR));
+	seq_printf(m, "[2.1]R_AX_MPDU_TX_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
+	seq_printf(m, "[2.2]R_AX_MPDU_RX_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
+	seq_printf(m, "[3]R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
+	seq_printf(m, "[4]R_AX_WDE_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
+	seq_printf(m, "[5.1]R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
+	seq_printf(m, "[5.2]R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
+	seq_printf(m, "[6]R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
+	seq_printf(m, "[7]R_AX_PKTIN_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
+	seq_printf(m, "[8.1]R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
+	seq_printf(m, "[8.2]R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
+	seq_printf(m, "[8.3]R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
+	seq_printf(m, "[10]R_AX_CPUIO_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_CPUIO_ERR_ISR));
+	seq_printf(m, "[11.1]R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
+	seq_printf(m, "[11.2]R_AX_BBRPT_CHINFO_ERR_IMR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR_ISR));
+	seq_printf(m, "[11.3]R_AX_BBRPT_DFS_ERR_IMR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR_ISR));
+	seq_printf(m, "[11.4]R_AX_LA_ERRFLAG=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_LA_ERRFLAG));
+
+	return 0;
+}
+
+static int rtw89_debug_mac_dump_cmac_dbg(struct rtw89_dev *rtwdev,
+					 struct seq_file *m)
+{
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_CMAC_SEL);
+	if (ret) {
+		seq_puts(m, "[CMAC] : CMAC 0 not enabled\n");
+		return ret;
+	}
+
+	seq_printf(m, "R_AX_CMAC_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR));
+	seq_printf(m, "[0]R_AX_SCHEDULE_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR));
+	seq_printf(m, "[1]R_AX_PTCL_ISR0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_PTCL_ISR0));
+	seq_printf(m, "[3]R_AX_DLE_CTRL=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DLE_CTRL));
+	seq_printf(m, "[4]R_AX_PHYINFO_ERR_ISR=0x%02x\n",
+		   rtw89_read8(rtwdev, R_AX_PHYINFO_ERR_ISR));
+	seq_printf(m, "[5]R_AX_TXPWR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TXPWR_ISR));
+	seq_printf(m, "[6]R_AX_RMAC_ERR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_RMAC_ERR_ISR));
+	seq_printf(m, "[7]R_AX_TMAC_ERR_IMR_ISR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR));
+
+	ret = rtw89_mac_check_mac_en(rtwdev, 1, RTW89_CMAC_SEL);
+	if (ret) {
+		seq_puts(m, "[CMAC] : CMAC 1 not enabled\n");
+		return ret;
+	}
+
+	seq_printf(m, "R_AX_CMAC_ERR_ISR_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR_C1));
+	seq_printf(m, "[0]R_AX_SCHEDULE_ERR_ISR_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR_C1));
+	seq_printf(m, "[1]R_AX_PTCL_ISR0_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_PTCL_ISR0_C1));
+	seq_printf(m, "[3]R_AX_DLE_CTRL_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DLE_CTRL_C1));
+	seq_printf(m, "[4]R_AX_PHYINFO_ERR_ISR_C1=0x%02x\n",
+		   rtw89_read8(rtwdev, R_AX_PHYINFO_ERR_ISR_C1));
+	seq_printf(m, "[5]R_AX_TXPWR_ISR_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TXPWR_ISR_C1));
+	seq_printf(m, "[6]R_AX_RMAC_ERR_ISR_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_RMAC_ERR_ISR_C1));
+	seq_printf(m, "[7]R_AX_TMAC_ERR_IMR_ISR_C1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR_C1));
+
+	return 0;
+}
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ptcl_c0 = {
+	.sel_addr = R_AX_PTCL_DBG,
+	.sel_byte = 1,
+	.sel_msk = B_AX_PTCL_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x3F,
+	.rd_addr = R_AX_PTCL_DBG_INFO,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PTCL_DBG_INFO_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ptcl_c1 = {
+	.sel_addr = R_AX_PTCL_DBG_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_PTCL_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x3F,
+	.rd_addr = R_AX_PTCL_DBG_INFO_C1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PTCL_DBG_INFO_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_sch_c0 = {
+	.sel_addr = R_AX_SCH_DBG_SEL,
+	.sel_byte = 1,
+	.sel_msk = B_AX_SCH_DBG_SEL_MSK,
+	.srt = 0x00,
+	.end = 0x2F,
+	.rd_addr = R_AX_SCH_DBG,
+	.rd_byte = 4,
+	.rd_msk = B_AX_SCHEDULER_DBG_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_sch_c1 = {
+	.sel_addr = R_AX_SCH_DBG_SEL_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_SCH_DBG_SEL_MSK,
+	.srt = 0x00,
+	.end = 0x2F,
+	.rd_addr = R_AX_SCH_DBG_C1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_SCHEDULER_DBG_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_tmac_c0 = {
+	.sel_addr = R_AX_MACTX_DBG_SEL_CNT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DBGSEL_MACTX,
+	.srt = 0x00,
+	.end = 0x19,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_tmac_c1 = {
+	.sel_addr = R_AX_MACTX_DBG_SEL_CNT_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DBGSEL_MACTX,
+	.srt = 0x00,
+	.end = 0x19,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_rmac_c0 = {
+	.sel_addr = R_AX_RX_DEBUG_SELECT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DEBUG_SEL,
+	.srt = 0x00,
+	.end = 0x58,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_rmac_c1 = {
+	.sel_addr = R_AX_RX_DEBUG_SELECT_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DEBUG_SEL,
+	.srt = 0x00,
+	.end = 0x58,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_rmacst_c0 = {
+	.sel_addr = R_AX_RX_STATE_MONITOR,
+	.sel_byte = 1,
+	.sel_msk = B_AX_STATE_SEL,
+	.srt = 0x00,
+	.end = 0x17,
+	.rd_addr = R_AX_RX_STATE_MONITOR,
+	.rd_byte = 4,
+	.rd_msk = R_AX_RX_STATE_MONITOR_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_rmacst_c1 = {
+	.sel_addr = R_AX_RX_STATE_MONITOR_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_STATE_SEL,
+	.srt = 0x00,
+	.end = 0x17,
+	.rd_addr = R_AX_RX_STATE_MONITOR_C1,
+	.rd_byte = 4,
+	.rd_msk = R_AX_RX_STATE_MONITOR_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_rmac_plcp_c0 = {
+	.sel_addr = R_AX_RMAC_PLCP_MON,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PCLP_MON_SEL,
+	.srt = 0x0,
+	.end = 0xF,
+	.rd_addr = R_AX_RMAC_PLCP_MON,
+	.rd_byte = 4,
+	.rd_msk = R_AX_RMAC_PLCP_MON_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_rmac_plcp_c1 = {
+	.sel_addr = R_AX_RMAC_PLCP_MON_C1,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PCLP_MON_SEL,
+	.srt = 0x0,
+	.end = 0xF,
+	.rd_addr = R_AX_RMAC_PLCP_MON_C1,
+	.rd_byte = 4,
+	.rd_msk = R_AX_RMAC_PLCP_MON_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_trxptcl_c0 = {
+	.sel_addr = R_AX_DBGSEL_TRXPTCL,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DBGSEL_TRXPTCL_MSK,
+	.srt = 0x08,
+	.end = 0x10,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_trxptcl_c1 = {
+	.sel_addr = R_AX_DBGSEL_TRXPTCL_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DBGSEL_TRXPTCL_MSK,
+	.srt = 0x08,
+	.end = 0x10,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_tx_infol_c0 = {
+	.sel_addr = R_AX_WMAC_TX_CTRL_DEBUG,
+	.sel_byte = 1,
+	.sel_msk = B_AX_TX_CTRL_DEBUG_SEL,
+	.srt = 0x00,
+	.end = 0x07,
+	.rd_addr = R_AX_WMAC_TX_INFO0_DEBUG,
+	.rd_byte = 4,
+	.rd_msk = B_AX_TX_CTRL_INFO_P0_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_tx_infoh_c0 = {
+	.sel_addr = R_AX_WMAC_TX_CTRL_DEBUG,
+	.sel_byte = 1,
+	.sel_msk = B_AX_TX_CTRL_DEBUG_SEL,
+	.srt = 0x00,
+	.end = 0x07,
+	.rd_addr = R_AX_WMAC_TX_INFO1_DEBUG,
+	.rd_byte = 4,
+	.rd_msk = B_AX_TX_CTRL_INFO_P1_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_tx_infol_c1 = {
+	.sel_addr = R_AX_WMAC_TX_CTRL_DEBUG_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_TX_CTRL_DEBUG_SEL,
+	.srt = 0x00,
+	.end = 0x07,
+	.rd_addr = R_AX_WMAC_TX_INFO0_DEBUG_C1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_TX_CTRL_INFO_P0_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_tx_infoh_c1 = {
+	.sel_addr = R_AX_WMAC_TX_CTRL_DEBUG_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_TX_CTRL_DEBUG_SEL,
+	.srt = 0x00,
+	.end = 0x07,
+	.rd_addr = R_AX_WMAC_TX_INFO1_DEBUG_C1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_TX_CTRL_INFO_P1_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_txtf_infol_c0 = {
+	.sel_addr = R_AX_WMAC_TX_TF_INFO_0,
+	.sel_byte = 1,
+	.sel_msk = B_AX_WMAC_TX_TF_INFO_SEL,
+	.srt = 0x00,
+	.end = 0x04,
+	.rd_addr = R_AX_WMAC_TX_TF_INFO_1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WMAC_TX_TF_INFO_P0
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_txtf_infoh_c0 = {
+	.sel_addr = R_AX_WMAC_TX_TF_INFO_0,
+	.sel_byte = 1,
+	.sel_msk = B_AX_WMAC_TX_TF_INFO_SEL,
+	.srt = 0x00,
+	.end = 0x04,
+	.rd_addr = R_AX_WMAC_TX_TF_INFO_2,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WMAC_TX_TF_INFO_P1
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_txtf_infol_c1 = {
+	.sel_addr = R_AX_WMAC_TX_TF_INFO_0_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_WMAC_TX_TF_INFO_SEL,
+	.srt = 0x00,
+	.end = 0x04,
+	.rd_addr = R_AX_WMAC_TX_TF_INFO_1_C1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WMAC_TX_TF_INFO_P0
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_txtf_infoh_c1 = {
+	.sel_addr = R_AX_WMAC_TX_TF_INFO_0_C1,
+	.sel_byte = 1,
+	.sel_msk = B_AX_WMAC_TX_TF_INFO_SEL,
+	.srt = 0x00,
+	.end = 0x04,
+	.rd_addr = R_AX_WMAC_TX_TF_INFO_2_C1,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WMAC_TX_TF_INFO_P1
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_bufmgn_freepg = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80000000,
+	.end = 0x80000001,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_bufmgn_quota = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80010000,
+	.end = 0x80010004,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_bufmgn_pagellt = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80020000,
+	.end = 0x80020FFF,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_bufmgn_pktinfo = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80030000,
+	.end = 0x80030FFF,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_quemgn_prepkt = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80040000,
+	.end = 0x80040FFF,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_quemgn_nxtpkt = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80050000,
+	.end = 0x80050FFF,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_quemgn_qlnktbl = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80060000,
+	.end = 0x80060453,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_wde_quemgn_qempty = {
+	.sel_addr = R_AX_WDE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_WDE_DFI_DATA_MSK,
+	.srt = 0x80070000,
+	.end = 0x80070011,
+	.rd_addr = R_AX_WDE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_WDE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_bufmgn_freepg = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80000000,
+	.end = 0x80000001,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_bufmgn_quota = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80010000,
+	.end = 0x8001000A,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_bufmgn_pagellt = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80020000,
+	.end = 0x80020DBF,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_bufmgn_pktinfo = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80030000,
+	.end = 0x80030DBF,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_quemgn_prepkt = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80040000,
+	.end = 0x80040DBF,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_quemgn_nxtpkt = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80050000,
+	.end = 0x80050DBF,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_quemgn_qlnktbl = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80060000,
+	.end = 0x80060041,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_ple_quemgn_qempty = {
+	.sel_addr = R_AX_PLE_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_PLE_DFI_DATA_MSK,
+	.srt = 0x80070000,
+	.end = 0x80070001,
+	.rd_addr = R_AX_PLE_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_PLE_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pktinfo = {
+	.sel_addr = R_AX_DBG_FUN_INTF_CTL,
+	.sel_byte = 4,
+	.sel_msk = B_AX_DFI_DATA_MSK,
+	.srt = 0x80000000,
+	.end = 0x8000017f,
+	.rd_addr = R_AX_DBG_FUN_INTF_DATA,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DFI_DATA_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_txdma = {
+	.sel_addr = R_AX_PCIE_DBG_CTRL,
+	.sel_byte = 2,
+	.sel_msk = B_AX_LOOPBACK_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x03,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_rxdma = {
+	.sel_addr = R_AX_PCIE_DBG_CTRL,
+	.sel_byte = 2,
+	.sel_msk = B_AX_LOOPBACK_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x04,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_cvt = {
+	.sel_addr = R_AX_PCIE_DBG_CTRL,
+	.sel_byte = 2,
+	.sel_msk = B_AX_LOOPBACK_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x01,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_cxpl = {
+	.sel_addr = R_AX_PCIE_DBG_CTRL,
+	.sel_byte = 2,
+	.sel_msk = B_AX_LOOPBACK_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x05,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_io = {
+	.sel_addr = R_AX_PCIE_DBG_CTRL,
+	.sel_byte = 2,
+	.sel_msk = B_AX_LOOPBACK_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x05,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_misc = {
+	.sel_addr = R_AX_PCIE_DBG_CTRL,
+	.sel_byte = 2,
+	.sel_msk = B_AX_LOOPBACK_DBG_SEL,
+	.srt = 0x00,
+	.end = 0x06,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_pcie_misc2 = {
+	.sel_addr = R_AX_DBG_CTRL,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DBG_SEL0,
+	.srt = 0x34,
+	.end = 0x3C,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MSK
+};
+
+static const struct rtw89_mac_dbg_port_info *
+rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
+			     struct rtw89_dev *rtwdev, u32 sel)
+{
+	const struct rtw89_mac_dbg_port_info *info;
+	u32 val32;
+	u16 val16;
+	u8 val8;
+
+	switch (sel) {
+	case RTW89_DBG_PORT_SEL_PTCL_C0:
+		info = &dbg_port_ptcl_c0;
+		val16 = rtw89_read16(rtwdev, R_AX_PTCL_DBG);
+		val16 |= B_AX_PTCL_DBG_EN;
+		rtw89_write16(rtwdev, R_AX_PTCL_DBG, val16);
+		seq_puts(m, "Enable PTCL C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PTCL_C1:
+		info = &dbg_port_ptcl_c1;
+		val16 = rtw89_read16(rtwdev, R_AX_PTCL_DBG_C1);
+		val16 |= B_AX_PTCL_DBG_EN;
+		rtw89_write16(rtwdev, R_AX_PTCL_DBG_C1, val16);
+		seq_puts(m, "Enable PTCL C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_SCH_C0:
+		info = &dbg_port_sch_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_SCH_DBG_SEL);
+		val32 |= B_AX_SCH_DBG_EN;
+		rtw89_write32(rtwdev, R_AX_SCH_DBG_SEL, val32);
+		seq_puts(m, "Enable SCH C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_SCH_C1:
+		info = &dbg_port_sch_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_SCH_DBG_SEL_C1);
+		val32 |= B_AX_SCH_DBG_EN;
+		rtw89_write32(rtwdev, R_AX_SCH_DBG_SEL_C1, val32);
+		seq_puts(m, "Enable SCH C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TMAC_C0:
+		info = &dbg_port_tmac_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL);
+		val32 = u32_replace_bits(val32, TRXPTRL_DBG_SEL_TMAC,
+					 B_AX_DBGSEL_TRXPTCL_MSK);
+		rtw89_write32(rtwdev, R_AX_DBGSEL_TRXPTCL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, TMAC_DBG_SEL_C0, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, TMAC_DBG_SEL_C0, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
+		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0);
+		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
+		seq_puts(m, "Enable TMAC C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TMAC_C1:
+		info = &dbg_port_tmac_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL_C1);
+		val32 = u32_replace_bits(val32, TRXPTRL_DBG_SEL_TMAC,
+					 B_AX_DBGSEL_TRXPTCL_MSK);
+		rtw89_write32(rtwdev, R_AX_DBGSEL_TRXPTCL_C1, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, TMAC_DBG_SEL_C1, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, TMAC_DBG_SEL_C1, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
+		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0);
+		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
+		seq_puts(m, "Enable TMAC C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_RMAC_C0:
+		info = &dbg_port_rmac_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL);
+		val32 = u32_replace_bits(val32, TRXPTRL_DBG_SEL_RMAC,
+					 B_AX_DBGSEL_TRXPTCL_MSK);
+		rtw89_write32(rtwdev, R_AX_DBGSEL_TRXPTCL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, RMAC_DBG_SEL_C0, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, RMAC_DBG_SEL_C0, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
+		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0);
+		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
+
+		val8 = rtw89_read8(rtwdev, R_AX_DBGSEL_TRXPTCL);
+		val8 = u8_replace_bits(val8, RMAC_CMAC_DBG_SEL,
+				       B_AX_DBGSEL_TRXPTCL_MSK);
+		rtw89_write8(rtwdev, R_AX_DBGSEL_TRXPTCL, val8);
+		seq_puts(m, "Enable RMAC C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_RMAC_C1:
+		info = &dbg_port_rmac_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL_C1);
+		val32 = u32_replace_bits(val32, TRXPTRL_DBG_SEL_RMAC,
+					 B_AX_DBGSEL_TRXPTCL_MSK);
+		rtw89_write32(rtwdev, R_AX_DBGSEL_TRXPTCL_C1, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, RMAC_DBG_SEL_C1, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, RMAC_DBG_SEL_C1, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
+		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0);
+		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
+
+		val8 = rtw89_read8(rtwdev, R_AX_DBGSEL_TRXPTCL_C1);
+		val8 = u8_replace_bits(val8, RMAC_CMAC_DBG_SEL,
+				       B_AX_DBGSEL_TRXPTCL_MSK);
+		rtw89_write8(rtwdev, R_AX_DBGSEL_TRXPTCL_C1, val8);
+		seq_puts(m, "Enable RMAC C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_RMACST_C0:
+		info = &dbg_port_rmacst_c0;
+		seq_puts(m, "Enable RMAC state C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_RMACST_C1:
+		info = &dbg_port_rmacst_c1;
+		seq_puts(m, "Enable RMAC state C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_RMAC_PLCP_C0:
+		info = &dbg_port_rmac_plcp_c0;
+		seq_puts(m, "Enable RMAC PLCP C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_RMAC_PLCP_C1:
+		info = &dbg_port_rmac_plcp_c1;
+		seq_puts(m, "Enable RMAC PLCP C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TRXPTCL_C0:
+		info = &dbg_port_trxptcl_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, TRXPTCL_DBG_SEL_C0, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, TRXPTCL_DBG_SEL_C0, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
+		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0);
+		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
+		seq_puts(m, "Enable TRXPTCL C0 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TRXPTCL_C1:
+		info = &dbg_port_trxptcl_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, TRXPTCL_DBG_SEL_C1, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, TRXPTCL_DBG_SEL_C1, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_STATUS1);
+		val32 = u32_replace_bits(val32, MAC_DBG_SEL, B_AX_SEL_0XC0);
+		rtw89_write32(rtwdev, R_AX_SYS_STATUS1, val32);
+		seq_puts(m, "Enable TRXPTCL C1 dbgport.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TX_INFOL_C0:
+		info = &dbg_port_tx_infol_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1, val32);
+		seq_puts(m, "Enable tx infol dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TX_INFOH_C0:
+		info = &dbg_port_tx_infoh_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1, val32);
+		seq_puts(m, "Enable tx infoh dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TX_INFOL_C1:
+		info = &dbg_port_tx_infol_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
+		seq_puts(m, "Enable tx infol dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TX_INFOH_C1:
+		info = &dbg_port_tx_infoh_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
+		seq_puts(m, "Enable tx infoh dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TXTF_INFOL_C0:
+		info = &dbg_port_txtf_infol_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1, val32);
+		seq_puts(m, "Enable tx tf infol dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TXTF_INFOH_C0:
+		info = &dbg_port_txtf_infoh_c0;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1, val32);
+		seq_puts(m, "Enable tx tf infoh dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TXTF_INFOL_C1:
+		info = &dbg_port_txtf_infol_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
+		seq_puts(m, "Enable tx tf infol dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_TXTF_INFOH_C1:
+		info = &dbg_port_txtf_infoh_c1;
+		val32 = rtw89_read32(rtwdev, R_AX_TCR1_C1);
+		val32 |= B_AX_TCR_FORCE_READ_TXDFIFO;
+		rtw89_write32(rtwdev, R_AX_TCR1_C1, val32);
+		seq_puts(m, "Enable tx tf infoh dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_FREEPG:
+		info = &dbg_port_wde_bufmgn_freepg;
+		seq_puts(m, "Enable wde bufmgn freepg dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_QUOTA:
+		info = &dbg_port_wde_bufmgn_quota;
+		seq_puts(m, "Enable wde bufmgn quota dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_PAGELLT:
+		info = &dbg_port_wde_bufmgn_pagellt;
+		seq_puts(m, "Enable wde bufmgn pagellt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_BUFMGN_PKTINFO:
+		info = &dbg_port_wde_bufmgn_pktinfo;
+		seq_puts(m, "Enable wde bufmgn pktinfo dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_PREPKT:
+		info = &dbg_port_wde_quemgn_prepkt;
+		seq_puts(m, "Enable wde quemgn prepkt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_NXTPKT:
+		info = &dbg_port_wde_quemgn_nxtpkt;
+		seq_puts(m, "Enable wde quemgn nxtpkt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_QLNKTBL:
+		info = &dbg_port_wde_quemgn_qlnktbl;
+		seq_puts(m, "Enable wde quemgn qlnktbl dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_WDE_QUEMGN_QEMPTY:
+		info = &dbg_port_wde_quemgn_qempty;
+		seq_puts(m, "Enable wde quemgn qempty dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_FREEPG:
+		info = &dbg_port_ple_bufmgn_freepg;
+		seq_puts(m, "Enable ple bufmgn freepg dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_QUOTA:
+		info = &dbg_port_ple_bufmgn_quota;
+		seq_puts(m, "Enable ple bufmgn quota dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_PAGELLT:
+		info = &dbg_port_ple_bufmgn_pagellt;
+		seq_puts(m, "Enable ple bufmgn pagellt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_BUFMGN_PKTINFO:
+		info = &dbg_port_ple_bufmgn_pktinfo;
+		seq_puts(m, "Enable ple bufmgn pktinfo dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_PREPKT:
+		info = &dbg_port_ple_quemgn_prepkt;
+		seq_puts(m, "Enable ple quemgn prepkt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_NXTPKT:
+		info = &dbg_port_ple_quemgn_nxtpkt;
+		seq_puts(m, "Enable ple quemgn nxtpkt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_QLNKTBL:
+		info = &dbg_port_ple_quemgn_qlnktbl;
+		seq_puts(m, "Enable ple quemgn qlnktbl dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PLE_QUEMGN_QEMPTY:
+		info = &dbg_port_ple_quemgn_qempty;
+		seq_puts(m, "Enable ple quemgn qempty dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PKTINFO:
+		info = &dbg_port_pktinfo;
+		seq_puts(m, "Enable pktinfo dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_TXDMA:
+		info = &dbg_port_pcie_txdma;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, PCIE_TXDMA_DBG_SEL, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, PCIE_TXDMA_DBG_SEL, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+		seq_puts(m, "Enable pcie txdma dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_RXDMA:
+		info = &dbg_port_pcie_rxdma;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, PCIE_RXDMA_DBG_SEL, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, PCIE_RXDMA_DBG_SEL, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+		seq_puts(m, "Enable pcie rxdma dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_CVT:
+		info = &dbg_port_pcie_cvt;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, PCIE_CVT_DBG_SEL, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, PCIE_CVT_DBG_SEL, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+		seq_puts(m, "Enable pcie cvt dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_CXPL:
+		info = &dbg_port_pcie_cxpl;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, PCIE_CXPL_DBG_SEL, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, PCIE_CXPL_DBG_SEL, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+		seq_puts(m, "Enable pcie cxpl dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_IO:
+		info = &dbg_port_pcie_io;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, PCIE_IO_DBG_SEL, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, PCIE_IO_DBG_SEL, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+		seq_puts(m, "Enable pcie io dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_MISC:
+		info = &dbg_port_pcie_misc;
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
+		val32 = u32_replace_bits(val32, PCIE_MISC_DBG_SEL, B_AX_DBG_SEL0);
+		val32 = u32_replace_bits(val32, PCIE_MISC_DBG_SEL, B_AX_DBG_SEL1);
+		rtw89_write32(rtwdev, R_AX_DBG_CTRL, val32);
+		seq_puts(m, "Enable pcie misc dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_PCIE_MISC2:
+		info = &dbg_port_pcie_misc2;
+		val16 = rtw89_read16(rtwdev, R_AX_PCIE_DBG_CTRL);
+		val16 = u16_replace_bits(val16, PCIE_MISC2_DBG_SEL,
+					 B_AX_LOOPBACK_DBG_SEL);
+		rtw89_write16(rtwdev, R_AX_PCIE_DBG_CTRL, val16);
+		seq_puts(m, "Enable pcie misc2 dump.\n");
+		break;
+	default:
+		seq_puts(m, "Dbg port select err\n");
+		return NULL;
+	}
+
+	return info;
+}
+
+static bool is_dbg_port_valid(struct rtw89_dev *rtwdev, u32 sel)
+{
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE &&
+	    sel >= RTW89_DBG_PORT_SEL_PCIE_TXDMA &&
+	    sel <= RTW89_DBG_PORT_SEL_PCIE_MISC2)
+		return false;
+	if (rtwdev->chip->chip_id == RTL8852B &&
+	    sel >= RTW89_DBG_PORT_SEL_PTCL_C1 &&
+	    sel <= RTW89_DBG_PORT_SEL_TXTF_INFOH_C1)
+		return false;
+	if (rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL) &&
+	    sel >= RTW89_DBG_PORT_SEL_WDE_BUFMGN_FREEPG &&
+	    sel <= RTW89_DBG_PORT_SEL_PKTINFO)
+		return false;
+	if (rtw89_mac_check_mac_en(rtwdev, 0, RTW89_CMAC_SEL) &&
+	    sel >= RTW89_DBG_PORT_SEL_PTCL_C0 &&
+	    sel <= RTW89_DBG_PORT_SEL_TXTF_INFOH_C0)
+		return false;
+	if (rtw89_mac_check_mac_en(rtwdev, 1, RTW89_CMAC_SEL) &&
+	    sel >= RTW89_DBG_PORT_SEL_PTCL_C1 &&
+	    sel <= RTW89_DBG_PORT_SEL_TXTF_INFOH_C1)
+		return false;
+
+	return true;
+}
+
+static int rtw89_debug_mac_dbg_port_dump(struct rtw89_dev *rtwdev,
+					 struct seq_file *m, u32 sel)
+{
+	const struct rtw89_mac_dbg_port_info *info;
+	u8 val8;
+	u16 val16;
+	u32 val32;
+	u32 i;
+
+	info = rtw89_debug_mac_dbg_port_sel(m, rtwdev, sel);
+	if (!info) {
+		rtw89_err(rtwdev, "failed to select debug port %d\n", sel);
+		return -EINVAL;
+	}
+
+#define case_DBG_SEL(__sel) \
+	case RTW89_DBG_PORT_SEL_##__sel: \
+		seq_puts(m, "Dump debug port " #__sel ":\n"); \
+		break
+
+	switch (sel) {
+	case_DBG_SEL(PTCL_C0);
+	case_DBG_SEL(PTCL_C1);
+	case_DBG_SEL(SCH_C0);
+	case_DBG_SEL(SCH_C1);
+	case_DBG_SEL(TMAC_C0);
+	case_DBG_SEL(TMAC_C1);
+	case_DBG_SEL(RMAC_C0);
+	case_DBG_SEL(RMAC_C1);
+	case_DBG_SEL(RMACST_C0);
+	case_DBG_SEL(RMACST_C1);
+	case_DBG_SEL(TRXPTCL_C0);
+	case_DBG_SEL(TRXPTCL_C1);
+	case_DBG_SEL(TX_INFOL_C0);
+	case_DBG_SEL(TX_INFOH_C0);
+	case_DBG_SEL(TX_INFOL_C1);
+	case_DBG_SEL(TX_INFOH_C1);
+	case_DBG_SEL(TXTF_INFOL_C0);
+	case_DBG_SEL(TXTF_INFOH_C0);
+	case_DBG_SEL(TXTF_INFOL_C1);
+	case_DBG_SEL(TXTF_INFOH_C1);
+	case_DBG_SEL(WDE_BUFMGN_FREEPG);
+	case_DBG_SEL(WDE_BUFMGN_QUOTA);
+	case_DBG_SEL(WDE_BUFMGN_PAGELLT);
+	case_DBG_SEL(WDE_BUFMGN_PKTINFO);
+	case_DBG_SEL(WDE_QUEMGN_PREPKT);
+	case_DBG_SEL(WDE_QUEMGN_NXTPKT);
+	case_DBG_SEL(WDE_QUEMGN_QLNKTBL);
+	case_DBG_SEL(WDE_QUEMGN_QEMPTY);
+	case_DBG_SEL(PLE_BUFMGN_FREEPG);
+	case_DBG_SEL(PLE_BUFMGN_QUOTA);
+	case_DBG_SEL(PLE_BUFMGN_PAGELLT);
+	case_DBG_SEL(PLE_BUFMGN_PKTINFO);
+	case_DBG_SEL(PLE_QUEMGN_PREPKT);
+	case_DBG_SEL(PLE_QUEMGN_NXTPKT);
+	case_DBG_SEL(PLE_QUEMGN_QLNKTBL);
+	case_DBG_SEL(PLE_QUEMGN_QEMPTY);
+	case_DBG_SEL(PKTINFO);
+	case_DBG_SEL(PCIE_TXDMA);
+	case_DBG_SEL(PCIE_RXDMA);
+	case_DBG_SEL(PCIE_CVT);
+	case_DBG_SEL(PCIE_CXPL);
+	case_DBG_SEL(PCIE_IO);
+	case_DBG_SEL(PCIE_MISC);
+	case_DBG_SEL(PCIE_MISC2);
+	}
+
+#undef case_DBG_SEL
+
+	seq_printf(m, "Sel addr = 0x%X\n", info->sel_addr);
+	seq_printf(m, "Read addr = 0x%X\n", info->rd_addr);
+
+	for (i = info->srt; i <= info->end; i++) {
+		switch (info->sel_byte) {
+		case 1:
+		default:
+			rtw89_write8_mask(rtwdev, info->sel_addr,
+					  info->sel_msk, i);
+			seq_printf(m, "0x%02X: ", i);
+			break;
+		case 2:
+			rtw89_write16_mask(rtwdev, info->sel_addr,
+					   info->sel_msk, i);
+			seq_printf(m, "0x%04X: ", i);
+			break;
+		case 4:
+			rtw89_write32_mask(rtwdev, info->sel_addr,
+					   info->sel_msk, i);
+			seq_printf(m, "0x%04X: ", i);
+			break;
+		}
+
+		udelay(10);
+
+		switch (info->rd_byte) {
+		case 1:
+		default:
+			val8 = rtw89_read8_mask(rtwdev,
+						info->rd_addr, info->rd_msk);
+			seq_printf(m, "0x%02X\n", val8);
+			break;
+		case 2:
+			val16 = rtw89_read16_mask(rtwdev,
+						  info->rd_addr, info->rd_msk);
+			seq_printf(m, "0x%04X\n", val16);
+			break;
+		case 4:
+			val32 = rtw89_read32_mask(rtwdev,
+						  info->rd_addr, info->rd_msk);
+			seq_printf(m, "0x%08X\n", val32);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int rtw89_debug_mac_dump_dbg_port(struct rtw89_dev *rtwdev,
+					 struct seq_file *m)
+{
+	u32 sel;
+	int ret = 0;
+
+	for (sel = RTW89_DBG_PORT_SEL_PTCL_C0;
+	     sel < RTW89_DBG_PORT_SEL_LAST; sel++) {
+		if (!is_dbg_port_valid(rtwdev, sel))
+			continue;
+		ret = rtw89_debug_mac_dbg_port_dump(rtwdev, m, sel);
+		if (ret) {
+			rtw89_err(rtwdev,
+				  "failed to dump debug port %d\n", sel);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int
+rtw89_debug_priv_mac_dbg_port_dump_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+
+	if (debugfs_priv->dbgpkg_en.ss_dbg)
+		rtw89_debug_mac_dump_ss_dbg(rtwdev, m);
+	if (debugfs_priv->dbgpkg_en.dle_dbg)
+		rtw89_debug_mac_dump_dle_dbg(rtwdev, m);
+	if (debugfs_priv->dbgpkg_en.dmac_dbg)
+		rtw89_debug_mac_dump_dmac_dbg(rtwdev, m);
+	if (debugfs_priv->dbgpkg_en.cmac_dbg)
+		rtw89_debug_mac_dump_cmac_dbg(rtwdev, m);
+	if (debugfs_priv->dbgpkg_en.dbg_port)
+		rtw89_debug_mac_dump_dbg_port(rtwdev, m);
+
+	return 0;
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_read_reg = {
+	.cb_read = rtw89_debug_priv_read_reg_get,
+	.cb_write = rtw89_debug_priv_read_reg_select,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_write_reg = {
+	.cb_write = rtw89_debug_priv_write_reg_set,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_read_rf = {
+	.cb_read = rtw89_debug_priv_read_rf_get,
+	.cb_write = rtw89_debug_priv_read_rf_select,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_write_rf = {
+	.cb_write = rtw89_debug_priv_write_rf_set,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_rf_reg_dump = {
+	.cb_read = rtw89_debug_priv_rf_reg_dump_get,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_mac_reg_dump = {
+	.cb_read = rtw89_debug_priv_mac_reg_dump_get,
+	.cb_write = rtw89_debug_priv_mac_reg_dump_select,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_mac_mem_dump = {
+	.cb_read = rtw89_debug_priv_mac_mem_dump_get,
+	.cb_write = rtw89_debug_priv_mac_mem_dump_select,
+};
+
+static struct rtw89_debugfs_priv rtw89_debug_priv_mac_dbg_port_dump = {
+	.cb_read = rtw89_debug_priv_mac_dbg_port_dump_get,
+	.cb_write = rtw89_debug_priv_mac_dbg_port_dump_select,
+};
+
+#define rtw89_debugfs_add(name, mode, fopname, parent)				\
+	do {									\
+		rtw89_debug_priv_ ##name.rtwdev = rtwdev;			\
+		if (!debugfs_create_file(#name, mode,				\
+					 parent, &rtw89_debug_priv_ ##name,	\
+					 &file_ops_ ##fopname))			\
+			pr_debug("Unable to initialize debugfs:%s\n", #name);	\
+	} while (0)
+
+#define rtw89_debugfs_add_w(name)						\
+	rtw89_debugfs_add(name, S_IFREG | 0222, single_w, debugfs_topdir)
+#define rtw89_debugfs_add_rw(name)						\
+	rtw89_debugfs_add(name, S_IFREG | 0666, common_rw, debugfs_topdir)
+#define rtw89_debugfs_add_r(name)						\
+	rtw89_debugfs_add(name, S_IFREG | 0444, single_r, debugfs_topdir)
+
+void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
+{
+	struct dentry *debugfs_topdir;
+
+	debugfs_topdir = debugfs_create_dir("rtw89",
+					    rtwdev->hw->wiphy->debugfsdir);
+
+	rtw89_debugfs_add_rw(read_reg);
+	rtw89_debugfs_add_w(write_reg);
+	rtw89_debugfs_add_rw(read_rf);
+	rtw89_debugfs_add_w(write_rf);
+	rtw89_debugfs_add_r(rf_reg_dump);
+	rtw89_debugfs_add_rw(mac_reg_dump);
+	rtw89_debugfs_add_rw(mac_mem_dump);
+	rtw89_debugfs_add_rw(mac_dbg_port_dump);
+}
+#endif
+
+#ifdef CONFIG_RTW89_DEBUGMSG
+void __rtw89_debug(struct rtw89_dev *rtwdev,
+		   enum rtw89_debug_mask mask,
+		   const char *fmt, ...)
+{
+	struct va_format vaf = {
+	.fmt = fmt,
+	};
+
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+
+	if (rtw89_debug_mask & mask)
+		dev_printk(KERN_DEBUG, rtwdev->dev, "%pV", &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(__rtw89_debug);
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
new file mode 100644
index 000000000000..04c8af5959dd
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_DEBUG_H__
+#define __RTW89_DEBUG_H__
+
+#include "core.h"
+
+enum rtw89_debug_mask {
+	RTW89_DBG_TXRX = BIT(0),
+	RTW89_DBG_RFK = BIT(1),
+	RTW89_DBG_RFK_TRACK = BIT(2),
+	RTW89_DBG_CFO = BIT(3),
+	RTW89_DBG_TSSI = BIT(4),
+	RTW89_DBG_TXPWR = BIT(5),
+	RTW89_DBG_HCI = BIT(6),
+	RTW89_DBG_RA = BIT(7),
+	RTW89_DBG_REGD = BIT(8),
+	RTW89_DBG_PHY_TRACK = BIT(9),
+	RTW89_DBG_DIG = BIT(10),
+	RTW89_DBG_SER = BIT(11),
+	RTW89_DBG_FW = BIT(12),
+};
+
+enum rtw89_debug_mac_reg_sel {
+	RTW89_DBG_SEL_MAC_00,
+	RTW89_DBG_SEL_MAC_40,
+	RTW89_DBG_SEL_MAC_80,
+	RTW89_DBG_SEL_MAC_C0,
+	RTW89_DBG_SEL_MAC_E0,
+	RTW89_DBG_SEL_BB,
+	RTW89_DBG_SEL_IQK,
+	RTW89_DBG_SEL_RFC,
+};
+
+#ifdef CONFIG_RTW89_DEBUGFS
+void rtw89_debugfs_init(struct rtw89_dev *rtwdev);
+#else
+static inline void rtw89_debugfs_init(struct rtw89_dev *rtwdev) {}
+#endif
+
+#define rtw89_info(rtwdev, a...) dev_info((rtwdev)->dev, ##a)
+#define rtw89_warn(rtwdev, a...) dev_warn((rtwdev)->dev, ##a)
+#define rtw89_err(rtwdev, a...) dev_err((rtwdev)->dev, ##a)
+
+#ifdef CONFIG_RTW89_DEBUGMSG
+extern unsigned int rtw89_debug_mask;
+#define rtw89_debug(rtwdev, a...) __rtw89_debug(rtwdev, ##a)
+
+__printf(3, 4)
+void __rtw89_debug(struct rtw89_dev *rtwdev,
+		   enum rtw89_debug_mask mask,
+		   const char *fmt, ...);
+static inline void rtw89_hex_dump(struct rtw89_dev *rtwdev,
+				  enum rtw89_debug_mask mask,
+				  const char *prefix_str,
+				  const void *buf, size_t len)
+{
+	if (!(rtw89_debug_mask & mask))
+		return;
+
+	print_hex_dump_bytes(prefix_str, DUMP_PREFIX_OFFSET, buf, len);
+}
+#else
+static inline void rtw89_debug(struct rtw89_dev *rtwdev,
+			       enum rtw89_debug_mask mask,
+			       const char *fmt, ...) {}
+static inline void rtw89_hex_dump(struct rtw89_dev *rtwdev,
+				  enum rtw89_debug_mask mask,
+				  const char *prefix_str,
+				  const void *buf, size_t len) {}
+#endif
+
+#endif
-- 
2.21.0

