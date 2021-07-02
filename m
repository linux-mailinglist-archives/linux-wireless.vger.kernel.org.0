Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0903B9CE3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 09:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhGBHZy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 03:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBHZw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 03:25:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70650C061762
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jul 2021 00:23:20 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lzDW2-0003zh-8d; Fri, 02 Jul 2021 09:23:10 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lzDW0-0001zL-UF; Fri, 02 Jul 2021 09:23:08 +0200
Date:   Fri, 2 Jul 2021 09:23:08 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 04/24] rtw89: add debug files
Message-ID: <20210702072308.GA4184@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-5-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210618064625.14131-5-pkshih@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:14:56 up 123 days, 16:50, 124 users,  load average: 0.28, 0.36,
 0.31
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 18, 2021 at 02:46:05PM +0800, Ping-Ke Shih wrote:
> To recognize issues happened in field, two debug methods, debug message and
> debugfs, are added.
> 
> The debug messages are written to kernel log, and four levels can be chosen
> according to the cases -- debug, info, warn and err.
> 
> Debugfs is used to read and write registers and driver status.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/debug.c | 2404 ++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/debug.h |   77 +
>  2 files changed, 2481 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw89/debug.c
>  create mode 100644 drivers/net/wireless/realtek/rtw89/debug.h
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
> new file mode 100644
> index 000000000000..03d2d2eb813d
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -0,0 +1,2404 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright(c) 2019-2020  Realtek Corporation
> + */
> +
> +#include "coex.h"
> +#include "debug.h"
> +#include "fw.h"
> +#include "mac.h"
> +#include "ps.h"
> +#include "reg.h"
> +#include "sar.h"
> +
> +#ifdef CONFIG_RTW89_DEBUGMSG
> +unsigned int rtw89_debug_mask;
> +EXPORT_SYMBOL(rtw89_debug_mask);
> +module_param_named(debug_mask, rtw89_debug_mask, uint, 0644);
> +MODULE_PARM_DESC(debug_mask, "Debugging mask");
> +#endif


For dynamic debugging we usually use ethtool msglvl.
Please, convert all dev_err/warn/inf.... to netif_ counterparts

> +#ifdef CONFIG_RTW89_DEBUGFS
> +struct rtw89_debugfs_priv {
> +	struct rtw89_dev *rtwdev;
> +	int (*cb_read)(struct seq_file *m, void *v);
> +	ssize_t (*cb_write)(struct file *filp, const char __user *buffer,
> +			    size_t count, loff_t *loff);
> +	union {
> +		u32 cb_data;
> +		struct {
> +			u32 addr;
> +			u8 len;
> +		} read_reg;
> +		struct {
> +			u32 addr;
> +			u32 mask;
> +			u8 path;
> +		} read_rf;
> +		struct {
> +			u8 ss_dbg:1;
> +			u8 dle_dbg:1;
> +			u8 dmac_dbg:1;
> +			u8 cmac_dbg:1;
> +			u8 dbg_port:1;
> +		} dbgpkg_en;
> +		struct {
> +			u32 start;
> +			u32 len;
> +			u8 sel;
> +		} mac_mem;
> +	};
> +};
> +
> +static int rtw89_debugfs_single_show(struct seq_file *m, void *v)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = m->private;
> +
> +	return debugfs_priv->cb_read(m, v);
> +}
> +
> +static ssize_t rtw89_debugfs_single_write(struct file *filp,
> +					  const char __user *buffer,
> +					  size_t count, loff_t *loff)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
> +
> +	return debugfs_priv->cb_write(filp, buffer, count, loff);
> +}
> +
> +static ssize_t rtw89_debugfs_seq_file_write(struct file *filp,
> +					    const char __user *buffer,
> +					    size_t count, loff_t *loff)
> +{
> +	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
> +	struct rtw89_debugfs_priv *debugfs_priv = seqpriv->private;
> +
> +	return debugfs_priv->cb_write(filp, buffer, count, loff);
> +}
> +
> +static int rtw89_debugfs_single_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, rtw89_debugfs_single_show, inode->i_private);
> +}
> +
> +static int rtw89_debugfs_close(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}
> +
> +static const struct file_operations file_ops_single_r = {
> +	.owner = THIS_MODULE,
> +	.open = rtw89_debugfs_single_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static const struct file_operations file_ops_common_rw = {
> +	.owner = THIS_MODULE,
> +	.open = rtw89_debugfs_single_open,
> +	.release = single_release,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.write = rtw89_debugfs_seq_file_write,
> +};
> +
> +static const struct file_operations file_ops_single_w = {
> +	.owner = THIS_MODULE,
> +	.write = rtw89_debugfs_single_write,
> +	.open = simple_open,
> +	.release = rtw89_debugfs_close,
> +};
> +
> +static ssize_t
> +rtw89_debug_priv_read_reg_select(struct file *filp,
> +				 const char __user *user_buf,
> +				 size_t count, loff_t *loff)
> +{
> +	struct seq_file *m = (struct seq_file *)filp->private_data;
> +	struct rtw89_debugfs_priv *debugfs_priv = m->private;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	char buf[32];
> +	size_t buf_size;
> +	u32 addr, len;
> +	int num;
> +
> +	buf_size = min(count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +	num = sscanf(buf, "%x %x", &addr, &len);
> +	if (num != 2) {
> +		rtw89_info(rtwdev, "invalid format: <addr> <len>\n");
> +		return -EINVAL;
> +	}
> +
> +	debugfs_priv->read_reg.addr = addr;
> +	debugfs_priv->read_reg.len = len;
> +
> +	rtw89_info(rtwdev, "select read %d bytes from 0x%08x\n", len, addr);
> +
> +	return count;
> +}
> +
> +static int rtw89_debug_priv_read_reg_get(struct seq_file *m, void *v)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = m->private;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	u32 addr, data;
> +	u8 len;
> +
> +	len = debugfs_priv->read_reg.len;
> +	addr = debugfs_priv->read_reg.addr;
> +
> +	switch (len) {
> +	case 1:
> +		data = rtw89_read8(rtwdev, addr);
> +		break;
> +	case 2:
> +		data = rtw89_read16(rtwdev, addr);
> +		break;
> +	case 4:
> +		data = rtw89_read32(rtwdev, addr);
> +		break;
> +	default:
> +		rtw89_info(rtwdev, "invalid read reg len %d\n", len);
> +		return -EINVAL;
> +	}
> +
> +	seq_printf(m, "get %d bytes at 0x%08x=0x%08x\n", len, addr, data);
> +
> +	return 0;
> +}
> +
> +static ssize_t rtw89_debug_priv_write_reg_set(struct file *filp,
> +					      const char __user *user_buf,
> +					      size_t count, loff_t *loff)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	char buf[32];
> +	size_t buf_size;
> +	u32 addr, val, len;
> +	int num;
> +
> +	buf_size = min(count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +	num = sscanf(buf, "%x %x %x", &addr, &val, &len);
> +	if (num !=  3) {
> +		rtw89_info(rtwdev, "invalid format: <addr> <val> <len>\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (len) {
> +	case 1:
> +		rtw89_info(rtwdev, "reg write8 0x%08x: 0x%02x\n", addr, val);
> +		rtw89_write8(rtwdev, addr, (u8)val);
> +		break;
> +	case 2:
> +		rtw89_info(rtwdev, "reg write16 0x%08x: 0x%04x\n", addr, val);
> +		rtw89_write16(rtwdev, addr, (u16)val);
> +		break;
> +	case 4:
> +		rtw89_info(rtwdev, "reg write32 0x%08x: 0x%08x\n", addr, val);
> +		rtw89_write32(rtwdev, addr, (u32)val);
> +		break;
> +	default:
> +		rtw89_info(rtwdev, "invalid read write len %d\n", len);
> +		break;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t
> +rtw89_debug_priv_read_rf_select(struct file *filp,
> +				const char __user *user_buf,
> +				size_t count, loff_t *loff)
> +{
> +	struct seq_file *m = (struct seq_file *)filp->private_data;
> +	struct rtw89_debugfs_priv *debugfs_priv = m->private;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	char buf[32];
> +	size_t buf_size;
> +	u32 addr, mask;
> +	u8 path;
> +	int num;
> +
> +	buf_size = min(count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +	num = sscanf(buf, "%hhd %x %x", &path, &addr, &mask);
> +	if (num != 3) {
> +		rtw89_info(rtwdev, "invalid format: <path> <addr> <mask>\n");
> +		return -EINVAL;
> +	}
> +
> +	if (path >= rtwdev->chip->rf_path_num) {
> +		rtw89_info(rtwdev, "wrong rf path\n");
> +		return -EINVAL;
> +	}
> +	debugfs_priv->read_rf.addr = addr;
> +	debugfs_priv->read_rf.mask = mask;
> +	debugfs_priv->read_rf.path = path;
> +
> +	rtw89_info(rtwdev, "select read rf path %d from 0x%08x\n", path, addr);
> +
> +	return count;
> +}
> +
> +static int rtw89_debug_priv_read_rf_get(struct seq_file *m, void *v)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = m->private;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	u32 addr, data, mask;
> +	u8 path;
> +
> +	addr = debugfs_priv->read_rf.addr;
> +	mask = debugfs_priv->read_rf.mask;
> +	path = debugfs_priv->read_rf.path;
> +
> +	data = rtw89_read_rf(rtwdev, path, addr, mask);
> +
> +	seq_printf(m, "path %d, rf register 0x%08x=0x%08x\n", path, addr, data);
> +
> +	return 0;
> +}
> +
> +static ssize_t rtw89_debug_priv_write_rf_set(struct file *filp,
> +					     const char __user *user_buf,
> +					     size_t count, loff_t *loff)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	char buf[32];
> +	size_t buf_size;
> +	u32 addr, val, mask;
> +	u8 path;
> +	int num;
> +
> +	buf_size = min(count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +	num = sscanf(buf, "%hhd %x %x %x", &path, &addr, &mask, &val);
> +	if (num != 4) {
> +		rtw89_info(rtwdev, "invalid format: <path> <addr> <mask> <val>\n");
> +		return -EINVAL;
> +	}
> +
> +	if (path >= rtwdev->chip->rf_path_num) {
> +		rtw89_info(rtwdev, "wrong rf path\n");
> +		return -EINVAL;
> +	}
> +
> +	rtw89_info(rtwdev, "path %d, rf register write 0x%08x=0x%08x (mask = 0x%08x)\n",
> +		   path, addr, val, mask);
> +	rtw89_write_rf(rtwdev, path, addr, mask, val);
> +
> +	return count;
> +}
> +
> +static int rtw89_debug_priv_rf_reg_dump_get(struct seq_file *m, void *v)
> +{
> +	struct rtw89_debugfs_priv *debugfs_priv = m->private;
> +	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
> +	u32 addr, offset, data;
> +	u8 path;
> +
> +	for (path = 0; path < chip->rf_path_num; path++) {
> +		seq_printf(m, "RF path %d:\n\n", path);
> +		for (addr = 0; addr < 0x100; addr += 4) {
> +			seq_printf(m, "0x%08x: ", addr);
> +			for (offset = 0; offset < 4; offset++) {
> +				data = rtw89_read_rf(rtwdev, path,
> +						     addr + offset, RFREG_MASK);
> +				seq_printf(m, "0x%05x  ", data);
> +			}
> +			seq_puts(m, "\n");
> +		}
> +		seq_puts(m, "\n");
> +	}
> +
> +	return 0;
> +}

Based on this and other part of this driver I would recommend to use
regmap. It will provide to additional interface for the register
access. And typically for the network devices we have an ethtool
interface for that.

Please, do not reinvent the wheel and use existing frameworks.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
