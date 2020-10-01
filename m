Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123428077C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbgJATGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbgJATGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:06:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06414C0613D0
        for <linux-wireless@vger.kernel.org>; Thu,  1 Oct 2020 12:06:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so4786699pgi.1
        for <linux-wireless@vger.kernel.org>; Thu, 01 Oct 2020 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1peGYDAEoGnpc+iW+0DY5ubcEZ1z2VlKHtE5sC8AzFc=;
        b=YNiWNDVBy35qHhUw5HVXO2DSCOTbmemYQlnO48Xkq86M2TJIxb5djfzEQill49kO1n
         F+BYtQE+aOtNF5lOHTB492hIRSvze8oUeIrnsL2DsLPHzeu9OEGjW7Xi6MQHK5Mff1Fu
         geKfja5xsa3yuJzDanh/Yj93LSm6IbQf1mLA3lM0mn0apTT7nCZD7CbbI8Rpz+uZEEEf
         EilozLRyKk4IrwIdLwBqGsgN1fRMfhNPpQyBnOXjLYKx3ii9g9p3WXqqNQbu53noBdsw
         oa1f5QsJgxHR7ztQoZfzJHy54DH3TQbdAUj59bC4YyarDvEGcCwKqHEQhy9w4cKBBzDY
         wUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1peGYDAEoGnpc+iW+0DY5ubcEZ1z2VlKHtE5sC8AzFc=;
        b=uY0TY8hDuNtBUdYy3z/wHb1J8kxduWS6zcVZGiSzrx39MPt+HddUNCQh6YuhDWH/Ot
         4IWSmHymPT8Gyx1cohm9yoQqq3JZR2cAlo2kSJSNn4BYwPHLOubEsJWeqh3Szwk+Yw83
         SWaXUe5TtQQNPcJ7NQoyR9xlIEzfSqHXD4BQiKW4POkWa6t+m7RVhWPYsSoQgqfcr+ZL
         WQrhQ04fOB8Q+HunFNEmMBA2nKTiVaYhCXnk0T+sasTNBkHq5/kSiHiX1rm0kWoa4kVw
         jYK/5zdmZUInVV6fhRHLFNVkysqpYPZioDLHRFHjpEubPXXED+B4bIiDYat7lGZU5PII
         HjLA==
X-Gm-Message-State: AOAM531O+mpUcX7l+OSStut7g5BMKofGtblumSESCBb0RTxYmV3cTUfx
        MSFUHj2DNVOu3NnCLnANaVI=
X-Google-Smtp-Source: ABdhPJwXf+zFq8f6DsrZxK5+7l0nGGhrSVmREK47fUc11dN6mvtHbJZBseTI3/AnohmJpmhSBOPxbQ==
X-Received: by 2002:a05:6a00:844:b029:13f:dd99:d1a4 with SMTP id q4-20020a056a000844b029013fdd99d1a4mr9030546pfk.31.1601579203389;
        Thu, 01 Oct 2020 12:06:43 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id f19sm6317703pfj.25.2020.10.01.12.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:06:42 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:06:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     tehuang@realtek.com
Cc:     kvalo@codeaurora.org, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 3/5] rtw88: add dump firmware fifo support
Message-ID: <20201001190641.GA3723966@ubuntu-m3-large-x86>
References: <20200925061219.23754-1-tehuang@realtek.com>
 <20200925061219.23754-4-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925061219.23754-4-tehuang@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 25, 2020 at 02:12:17PM +0800, tehuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> Rtw88 currently has a function to dump reserved page section of the
> firmware fifo. Reserved page is just part of the firmware fifo, there
> are multiple sections in the firmware fifo for different usages, such as
> firmware rx fifo and tx fifo.
> This commit adds a function to check not only the reserved page section
> but also other parts of the firmware fifo. In addition, we need to dump
> firmware fifo to dump the debug log message if firmware crashes.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/debug.c    |  3 +-
>  drivers/net/wireless/realtek/rtw88/fw.c       | 77 +++++++++++++++----
>  drivers/net/wireless/realtek/rtw88/fw.h       |  3 +-
>  drivers/net/wireless/realtek/rtw88/main.h     | 14 ++++
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  3 +
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  3 +
>  6 files changed, 85 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
> index 985cf5d60615..bff6ce19345a 100644
> --- a/drivers/net/wireless/realtek/rtw88/debug.c
> +++ b/drivers/net/wireless/realtek/rtw88/debug.c
> @@ -229,7 +229,8 @@ static int rtw_debugfs_get_rsvd_page(struct seq_file *m, void *v)
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = rtw_dump_drv_rsvd_page(rtwdev, offset, buf_size, (u32 *)buf);
> +	ret = rtw_fw_dump_fifo(rtwdev, RTW_FW_FIFO_SEL_RSVD_PAGE, offset,
> +			       buf_size, (u32 *)buf);
>  	if (ret) {
>  		rtw_err(rtwdev, "failed to dump rsvd page\n");
>  		vfree(buf);
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> index 6a50bb993caf..042015bc8055 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -1413,29 +1413,16 @@ int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev)
>  	return ret;
>  }
>  
> -int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
> -			   u32 offset, u32 size, u32 *buf)
> +static void rtw_fw_read_fifo_page(struct rtw_dev *rtwdev, u32 offset, u32 size,
> +				  u32 *buf, u32 residue, u16 start_pg)
>  {
> -	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
> -	u32 residue, i;
> -	u16 start_pg;
> +	u32 i;
>  	u16 idx = 0;
>  	u16 ctl;
>  	u8 rcr;
>  
> -	if (size & 0x3) {
> -		rtw_warn(rtwdev, "should be 4-byte aligned\n");
> -		return -EINVAL;
> -	}
> -
> -	offset += fifo->rsvd_boundary << TX_PAGE_SIZE_SHIFT;
> -	residue = offset & (FIFO_PAGE_SIZE - 1);
> -	start_pg = offset >> FIFO_PAGE_SIZE_SHIFT;
> -	start_pg += RSVD_PAGE_START_ADDR;
> -
>  	rcr = rtw_read8(rtwdev, REG_RCR + 2);
>  	ctl = rtw_read16(rtwdev, REG_PKTBUF_DBG_CTRL) & 0xf000;
> -
>  	/* disable rx clock gate */
>  	rtw_write8(rtwdev, REG_RCR, rcr | BIT(3));
>  
> @@ -1457,6 +1444,64 @@ int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
>  out:
>  	rtw_write16(rtwdev, REG_PKTBUF_DBG_CTRL, ctl);
>  	rtw_write8(rtwdev, REG_RCR + 2, rcr);
> +}
> +
> +static void rtw_fw_read_fifo(struct rtw_dev *rtwdev, enum rtw_fw_fifo_sel sel,
> +			     u32 offset, u32 size, u32 *buf)
> +{
> +	struct rtw_chip_info *chip = rtwdev->chip;
> +	u32 start_pg, residue;
> +
> +	if (sel >= RTW_FW_FIFO_MAX) {
> +		rtw_dbg(rtwdev, RTW_DBG_FW, "wrong fw fifo sel\n");
> +		return;
> +	}
> +	if (sel == RTW_FW_FIFO_SEL_RSVD_PAGE)
> +		offset += rtwdev->fifo.rsvd_boundary << TX_PAGE_SIZE_SHIFT;
> +	residue = offset & (FIFO_PAGE_SIZE - 1);
> +	start_pg = (offset >> FIFO_PAGE_SIZE_SHIFT) + chip->fw_fifo_addr[sel];
> +
> +	rtw_fw_read_fifo_page(rtwdev, offset, size, buf, residue, start_pg);
> +}
> +
> +static bool rtw_fw_dump_check_size(struct rtw_dev *rtwdev,
> +				   enum rtw_fw_fifo_sel sel,
> +				   u32 start_addr, u32 size)
> +{
> +	switch (sel) {
> +	case RTW_FW_FIFO_SEL_TX:
> +	case RTW_FW_FIFO_SEL_RX:
> +		if ((start_addr + size) > rtwdev->chip->fw_fifo_addr[sel])
> +			return false;
> +		/*fall through*/
> +	default:
> +		return true;
> +	}
> +}
> +
> +int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
> +		     u32 *buffer)
> +{
> +	if (!rtwdev->chip->fw_fifo_addr) {

This causes a clang warning, which points out it is probably not doing
what you think it is:

drivers/net/wireless/realtek/rtw88/fw.c:1485:21: warning: address of
array 'rtwdev->chip->fw_fifo_addr' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!rtwdev->chip->fw_fifo_addr) {
            ~~~~~~~~~~~~~~~^~~~~~~~~~~~
1 warning generated.

Was fw_fifo_addr[0] intended or should the check just be deleted?

Cheers,
Nathan

> +		rtw_dbg(rtwdev, RTW_DBG_FW, "chip not support dump fw fifo\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (size == 0 || !buffer)
> +		return -EINVAL;
> +
> +	if (size & 0x3) {
> +		rtw_dbg(rtwdev, RTW_DBG_FW, "not 4byte alignment\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!rtw_fw_dump_check_size(rtwdev, fifo_sel, addr, size)) {
> +		rtw_dbg(rtwdev, RTW_DBG_FW, "fw fifo dump size overflow\n");
> +		return -EINVAL;
> +	}
> +
> +	rtw_fw_read_fifo(rtwdev, fifo_sel, addr, size, buffer);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
> index b4e3f755e8fb..9c4863c011ba 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.h
> +++ b/drivers/net/wireless/realtek/rtw88/fw.h
> @@ -16,7 +16,6 @@
>  
>  #define FIFO_PAGE_SIZE_SHIFT		12
>  #define FIFO_PAGE_SIZE			4096
> -#define RSVD_PAGE_START_ADDR		0x780
>  #define FIFO_DUMP_ADDR			0x8000
>  
>  #define DLFW_PAGE_SIZE_SHIFT_LEGACY	12
> @@ -565,5 +564,7 @@ void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
>  void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable);
>  void rtw_fw_h2c_cmd_dbg(struct rtw_dev *rtwdev, u8 *h2c);
>  void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev);
> +int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
> +		     u32 *buffer);
>  
>  #endif
> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
> index 292336387b89..06bdc68555e7 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -1083,6 +1083,17 @@ enum rtw_wlan_cpu {
>  	RTW_WCPU_11N,
>  };
>  
> +enum rtw_fw_fifo_sel {
> +	RTW_FW_FIFO_SEL_TX,
> +	RTW_FW_FIFO_SEL_RX,
> +	RTW_FW_FIFO_SEL_RSVD_PAGE,
> +	RTW_FW_FIFO_SEL_REPORT,
> +	RTW_FW_FIFO_SEL_LLT,
> +	RTW_FW_FIFO_SEL_RXBUF_FW,
> +
> +	RTW_FW_FIFO_MAX,
> +};
> +
>  /* hardware configuration for each IC */
>  struct rtw_chip_info {
>  	struct rtw_chip_ops *ops;
> @@ -1099,6 +1110,7 @@ struct rtw_chip_info {
>  	u32 ptct_efuse_size;
>  	u32 txff_size;
>  	u32 rxff_size;
> +	u32 fw_rxff_size;
>  	u8 band;
>  	u8 page_size;
>  	u8 csi_buf_pg_num;
> @@ -1109,6 +1121,8 @@ struct rtw_chip_info {
>  	bool rx_ldpc;
>  	u8 max_power_index;
>  
> +	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
> +
>  	bool ht_supported;
>  	bool vht_supported;
>  	u8 lps_deep_mode_supported;
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> index b7a98dbbb09c..22d0dd640ac9 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
> @@ -2442,6 +2442,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
>  	.ptct_efuse_size = 96,
>  	.txff_size = 262144,
>  	.rxff_size = 24576,
> +	.fw_rxff_size = 12288,
>  	.txgi_factor = 1,
>  	.is_pwr_by_rate_dec = true,
>  	.max_power_index = 0x3f,
> @@ -2504,6 +2505,8 @@ struct rtw_chip_info rtw8822b_hw_spec = {
>  
>  	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822b),
>  	.coex_info_hw_regs = coex_info_hw_regs_8822b,
> +
> +	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
>  };
>  EXPORT_SYMBOL(rtw8822b_hw_spec);
>  
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index dd216a23fc99..e37300e98517 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -4294,6 +4294,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
>  	.ptct_efuse_size = 124,
>  	.txff_size = 262144,
>  	.rxff_size = 24576,
> +	.fw_rxff_size = 12288,
>  	.txgi_factor = 2,
>  	.is_pwr_by_rate_dec = false,
>  	.max_power_index = 0x7f,
> @@ -4364,6 +4365,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
>  
>  	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822c),
>  	.coex_info_hw_regs = coex_info_hw_regs_8822c,
> +
> +	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
>  };
>  EXPORT_SYMBOL(rtw8822c_hw_spec);
>  
> -- 
> 2.17.1
> 
