Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A45244CC7
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHNQhQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 12:37:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61212 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHNQhN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 12:37:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597423032; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Z/OS8t1bV43NVOmy/9zoz8afuEySCPn6fROSfMWNYr4=; b=BB2KF+2bNmNtzG5iqOH2RRRCUFfup3/+6ZLb3igB38H6BmiAbrz5SRSsKQA7IOFMb6fLNyws
 SzD7UZf0sZwAvzlbvdaEN/2EQ8R3I7XPmg3hLdT6JJLN2EnO4zSitBA2Wjz1+Tz2EkaZiRpu
 Cq2s6okCfjRNeP7/Zk/B3f9hzcA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f36bd9ecbcd42bdee6d3407 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 16:36:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C858AC433CA; Fri, 14 Aug 2020 16:36:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64038C433C9;
        Fri, 14 Aug 2020 16:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64038C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ath10k: add fw coredump for sdio when firmware assert
References: <1569310030-834-1-git-send-email-wgong@codeaurora.org>
        <1569310030-834-3-git-send-email-wgong@codeaurora.org>
Date:   Fri, 14 Aug 2020 19:36:42 +0300
In-Reply-To: <1569310030-834-3-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Tue, 24 Sep 2019 15:27:10 +0800")
Message-ID: <87mu2xkwv9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> When firmware assert, it need coredump to analyze, this patch will
> collect the register and memory info for sdio chip.
>
> The coredump configuration is different between PCIE and SDIO for
> the same reversion, so this patch add bus type to distinguish PCIE
> and SDIO chip for coredump.
>
> It has 2 type to dump firmware: fastdump and slowdump. Fastdump is
> not support in old version firmware, if this, ath10k will select
> slowdump for it. If firmware support fastdump, ath10k will select
> fastdump for it. Version WLAN.RMH.4.4.1-00017-QCARMSWPZ-2 of
> firmware begin to support fastdump.
>
> For slow dump, ath10k_sdio_hif_diag_read can not be used, the diag
> window has a limit value, it is 4 bytes and the dump's buffer length
> is larger than it, it will trigger error. So this patch add
> ath10k_sdio_read_mem to read 4 bytes for each time.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00018-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

I did some changes in the pending branch, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=de03e26479e2cf5f3e1753bda517f44910457036

Also please send dmesg output from a firmware crash, I'll add it to the
commit log as an example.

> +static void ath10k_sdio_check_fw_reg(struct ath10k *ar, u32 *fast_dump)
> +{
> +	u32 param;
> +
> +	ath10k_sdio_read_host_interest_value(ar, HI_ITEM(hi_option_flag2), &param);
> +
> +	*fast_dump = ((param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW)
> +			     == HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW);
> +
> +	ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio hi_option_flag2 %x\n", param);
> +}

I renamed this ath10k_sdio_is_fast_dump_supported() which returns a
boolean. Also I changed all fast_dump variables to a boolean.

> +static void ath10k_sdio_dump_memory(struct ath10k *ar,
> +				    struct ath10k_fw_crash_data *crash_data,
> +				    u32 fast_dump)
> +{
> +	const struct ath10k_hw_mem_layout *mem_layout;
> +	const struct ath10k_mem_region *current_region;
> +	struct ath10k_dump_ram_data_hdr *hdr;
> +	u32 count;
> +	size_t buf_len;
> +	int ret, i;
> +	u8 *buf;
> +
> +	if (!crash_data)
> +		return;
> +
> +	mem_layout = ath10k_coredump_get_mem_layout(ar);
> +	if (!mem_layout)
> +		return;
> +
> +	current_region = &mem_layout->region_table.regions[0];
> +
> +	buf = crash_data->ramdump_buf;
> +	buf_len = crash_data->ramdump_buf_len;
> +
> +	memset(buf, 0, buf_len);
> +
> +	for (i = 0; i < mem_layout->region_table.size; i++) {
> +		count = 0;
> +
> +		if (current_region->len > buf_len) {
> +			ath10k_warn(ar, "memory region %s size %d is larger that remaining ramdump buffer size %zu\n",
> +				    current_region->name,
> +				    current_region->len,
> +				    buf_len);
> +			break;
> +		}
> +
> +		/* Reserve space for the header. */
> +		hdr = (void *)buf;
> +		buf += sizeof(*hdr);
> +		buf_len -= sizeof(*hdr);
> +
> +		ret = ath10k_sdio_dump_memory_generic(ar, current_region, buf, fast_dump);
> +
> +		ath10k_err(ar, "dump mem, name:%s, type:%d, start:0x%x, len:0x%x, size:%d, ret:0x%x\n",
> +			   current_region->name,
> +			   current_region->type,
> +			   current_region->start,
> +			   current_region->len,
> +			   current_region->section_table.size,
> +			   ret);

This error print looks like a debug message, so I removed it. If you
need it, let me know.

> +void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
> +{
> +	struct ath10k_fw_crash_data *crash_data;
> +	char guid[UUID_STRING_LEN + 1];
> +	u32 fast_dump = 0;
> +
> +	ath10k_err(ar, "begin fw dump\n");

This also looks like a debug message so I removed it.

> +	ath10k_sdio_check_fw_reg(ar, &fast_dump);
> +
> +	if (fast_dump)
> +		ar->bmi.done_sent = false;

I did some refactoring in patch "ath10k: move enable_pll_clk call to
ath10k_core_start()" (submitted separately) so that I could change this
to ath10k_bmi_start().

> --- a/drivers/net/wireless/ath/ath10k/targaddrs.h
> +++ b/drivers/net/wireless/ath/ath10k/targaddrs.h
> @@ -334,6 +334,16 @@ struct host_interest {
>  #define HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_FW_ACK (1 << 17)
>  
>  /*
> + * If both SDIO_CRASH_DUMP_ENHANCEMENT_HOST and SDIO_CRASH_DUMP_ENHANCEMENT_FW
> + * flags are set, then crashdump upload will be done using the BMI host/target
> + * communication channel.
> + */
> +/* HOST to support using BMI dump FW memory when hit assert */
> +#define HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_HOST 0x400

Added empty line here.

> +/* FW to support using BMI dump FW memory when hit assert */
> +#define HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW   0x800
> +
> +/*
>   * CONSOLE FLAGS
>   *
>   * Bit Range  Meaning

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
