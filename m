Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFE26181C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgIHRs6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 13:48:58 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:42006 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgIHRsy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 13:48:54 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6C81613C2B1;
        Tue,  8 Sep 2020 10:48:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6C81613C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1599587330;
        bh=R2QZm8VB7bQ0se94qGtTrscUZxR/PTLC+TUOE7ut3Lc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GkrqEuGslGHq54u623e9X2JHcHvwuG/jWa9i8F7dgM+vgs7lyDzkEr7yZQIQsgP0g
         zBlgFzkvkYYT0D2hnk+QNiLOHCQeCDS7rNnvMjVvFDbN/tVk5fNEg7u6GFQ/oguqGd
         1ybKH39odhFoi7xcu1qG3OXQAgl05uyK8RiTYRKY=
Subject: Re: [PATCH,v4] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     Zhi Chen <zhichen@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1578976521-6104-1-git-send-email-zhichen@codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <79a88865-6df5-e7a4-deb6-6025cc9d87e4@candelatech.com>
Date:   Tue, 8 Sep 2020 10:48:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1578976521-6104-1-git-send-email-zhichen@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Just FYI:  I added this patch to my ath10k-ct driver, and a user reported it causes
regressions on his particular 9888 system when using ath10k-ct wave-2 firmware:

[   21.204868] ath10k_pci 0000:00:00.0: qca9888 hw2.0 target 0x01000000 chip_id 0x00000000 sub 0000:0000
[   21.214437] ath10k_pci 0000:00:00.0: kconfig debug 0 debugfs 1 tracing 0 dfs 1 testmode 0
[   21.233298] ath10k_pci 0000:00:00.0: firmware ver 10.4b-ct-9888-tH-13-8c5b2baa2 api 5 features 
mfp,peer-flow-ctrl,txstatus-noack,wmi-10.x-CT,ratemask-CT,regdump-CT,txrate-CT,flush-all-CT,pingpong-CT,ch-regs-CT,nop-CT,htt-mgt-CT,set-special-CT,no-bmiss-CT,tx-rc-CT,cust-stats-CT,txrate2-CT,beacon-cb-CT,wmi-block-ack-CT,wmi-bcn-rc-CT 
crc32 a00b5f36
[   21.596684] ath10k_pci 0000:00:00.0: board_file api 2 bmi_id 0:20 crc32 5bb32c02[   23.546156] ath10k_pci 0000:00:00.0: unsupported HTC service id: 1536

I'll revert this for the 9888 chipset (at least) in my driver, possibly you need to do similar.

https://github.com/greearb/ath10k-ct/issues/153

Thanks,
Ben

On 1/13/20 8:35 PM, Zhi Chen wrote:
> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
> PCIe hung issue was observed on multiple platforms. The issue was reproduced
> when DUT was configured as AP and associated with 50+ STAs.
> 
> For QCA9984/QCA9888, the DMA_BURST_SIZE register controls the AXI burst size
> of the RD/WR access to the HOST MEM.
> 0 - No split , RAW read/write transfer size from MAC is put out on bus
>      as burst length
> 1 - Split at 256 byte boundary
> 2,3 - Reserved
> 
> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
> issue happened. It broke PCIe spec and caused PCIe stuck. So revert
> the default value from 0 to 1.
> 
> Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
>           QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
>           Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040
> 
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
> ---
> v2: restored 10.2 register configuration
> v3: modified commit message
> v4: resolved conflicts
> ---
>   drivers/net/wireless/ath/ath10k/hw.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
> index 21b7a2a..775fd62 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -816,7 +816,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
>   
>   #define TARGET_10_4_TX_DBG_LOG_SIZE		1024
>   #define TARGET_10_4_NUM_WDS_ENTRIES		32
> -#define TARGET_10_4_DMA_BURST_SIZE		0
> +#define TARGET_10_4_DMA_BURST_SIZE		1
>   #define TARGET_10_4_MAC_AGGR_DELIM		0
>   #define TARGET_10_4_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
>   #define TARGET_10_4_VOW_CONFIG			0
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
