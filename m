Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5E179734
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 18:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgCDRwB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 12:52:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33089 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgCDRwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 12:52:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id f13so3033138ljp.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2020 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n1UjSBvDbHJ+maTOjoxKlXiL3GGXhwx3TS2NQJcHrVU=;
        b=njHjpi+jRyGd4Niag51Guclf35PJHCN+nBz1ni682U49AmDJ1LbWGISSS7cHmv4U1X
         wgL6Bi01W10dBpoSdVvMy7EKpdTA70oX6P0Wr28gVRCDYabHC9WQ5Vr6bW7VJ5QdgO0y
         315MFhaWIs8m5MG6rWAKWrtVXJqpdj/YvPuBKZVPY2RkfvaDE1pyXjaBZr9Nn/9Rex4K
         D69cn3EO1gBarFxeg8dZlSq/7DBpjI5P3l8wXrpGq4CPuPKflY/Rpg1oId2AYYjIWJHs
         g5U4S4vqzLBTFVNVnlINKZCfPGSoSlBWSc21gwjr1gQhkGDD03sMs6mM4wr2b+HI3bzJ
         dk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1UjSBvDbHJ+maTOjoxKlXiL3GGXhwx3TS2NQJcHrVU=;
        b=sthhQdtr1Twr4kfREL01iTT4ZAFtKuQ8FFa9FQA6CKrcgeCawZmLaz3Cqzz14uN8kj
         +DwH1gIPjcDGfDfnzab5mWdQARDoYETq9SGQy2boyhH5KFLNiAHuKoNLcq51XLT06i98
         lSMIIHGKc2wxPID43oPZxlJyy6ZB9Fx8z0bj+yLqxMHpmXSWxUEojpPryJSiWARZwVXI
         w83K0xdh+HPqtXLxYNWpS2EuPrYZFFM3F0lUqJIduSPaZPoDKZf0STu1vIBilhpVn/nK
         1x3AT7iLmKscS9M5FbGNYN378T1HlCoIJBZOHzQj4o5Ck+5aFbUmeD2K7pht3Ov+hqcf
         QEaw==
X-Gm-Message-State: ANhLgQ33sYv9VOSl3YaPT+4RWqwoujtKhJ2uGzOCLQE2Q5KkvD/gXeUg
        ScjKULaQ/YDlmpKBGIXm5buvNNim
X-Google-Smtp-Source: ADFU+vsFZ1TpCAIQ2vIA6ymN53kdYT7BXqAvZjG5g1uG15m0RTtKZZ3d6J/Xi0Gbx0jyCslMk3kRmA==
X-Received: by 2002:a05:651c:94:: with SMTP id 20mr2718556ljq.17.1583344318239;
        Wed, 04 Mar 2020 09:51:58 -0800 (PST)
Received: from [192.168.1.238] (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id n2sm14621629ljj.1.2020.03.04.09.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 09:51:57 -0800 (PST)
Subject: Re: [PATCH RFT] ath10k: add QCA9377 sdio hw_param item
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1569507867-19547-1-git-send-email-kvalo@codeaurora.org>
 <7BB79E29-0ACF-45FB-B802-E4B2F5CA0DFE@gmail.com>
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
Message-ID: <03d244cd-3205-6c95-c43e-99bc0135b50a@gmail.com>
Date:   Wed, 4 Mar 2020 18:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <7BB79E29-0ACF-45FB-B802-E4B2F5CA0DFE@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 3/2/20 12:45 PM, Christian Hewitt wrote:
> 
>> On 26 Sep 2019, at 6:24 pm, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> From: Erik Stromdahl <erik.stromdahl@gmail.com>
>>
>> Add hardware parameters for QCA9377 sdio devices, it's now properly supported.
>>
>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> ---
>>
>> I don't have any working QCA9377 SDIO hardware so I would appreciate any
>> test reports. This should apply cleanly to ath.git master branch (at least to
>> tag ath-201909230832):
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=master
>>
>> drivers/net/wireless/ath/ath10k/core.c | 27 +++++++++++++++++++++++++++
>> drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
>> 2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
>> index 36c62d66c19e..e5572d4b6ae9 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -539,6 +539,33 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>> 		.tx_stats_over_pktlog = false,
>> 	},
>> 	{
>> +		.id = QCA9377_HW_1_1_DEV_VERSION,
>> +		.dev_id = QCA9377_1_0_DEVICE_ID,
>> +		.bus = ATH10K_BUS_SDIO,
>> +		.name = "qca9377 hw1.1 sdio",
>> +		.patch_load_addr = QCA9377_HW_1_0_PATCH_LOAD_ADDR,
>> +		.uart_pin = 19,
>> +		.otp_exe_param = 0,
>> +		.channel_counters_freq_hz = 88000,
>> +		.max_probe_resp_desc_thres = 0,
>> +		.cal_data_len = 8124,
>> +		.fw = {
>> +			.dir = QCA9377_HW_1_0_FW_DIR,
>> +			.board = QCA9377_HW_1_0_BOARD_DATA_FILE,
>> +			.board_size = QCA9377_BOARD_DATA_SZ,
>> +			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
>> +		},
>> +		.hw_ops = &qca6174_ops,
>> +		.hw_clk = qca6174_clk,
>> +		.target_cpu_freq = 176000000,
>> +		.decap_align_bytes = 4,
>> +		.n_cipher_suites = 8,
>> +		.num_peers = TARGET_QCA9377_HL_NUM_PEERS,
>> +		.ast_skid_limit = 0x10,
>> +		.num_wds_entries = 0x20,
>> +		.uart_pin_workaround = true,
>> +	},
>> +	{
>> 		.id = QCA4019_HW_1_0_DEV_VERSION,
>> 		.dev_id = 0,
>> 		.bus = ATH10K_BUS_AHB,
>> diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
>> index 2ae57c1de7b5..ddb1d23ec6de 100644
>> --- a/drivers/net/wireless/ath/ath10k/hw.h
>> +++ b/drivers/net/wireless/ath/ath10k/hw.h
>> @@ -768,6 +768,9 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
>> #define TARGET_HL_TLV_AST_SKID_LIMIT		16
>> #define TARGET_HL_TLV_NUM_WDS_ENTRIES		2
>>
>> +/* Target specific defines for QCA9377 high latency firmware */
>> +#define TARGET_QCA9377_HL_NUM_PEERS		15
>> +
>> /* Diagnostic Window */
>> #define CE_DIAG_PIPE	7
>>
> 
> Tested and working fine using Linux 5.6-rc3 and SDIO firmware from [1].
> 
> [    5.391369] ath10k_sdio mmc2:0001:1: qca9377 hw1.1 sdio target 0x05020001 chip_id 0x00000000 sub 0000:0000
> [    5.391379] ath10k_sdio mmc2:0001:1: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> [    5.391632] ath10k_sdio mmc2:0001:1: firmware ver WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32 7746e551
> [    5.624198] ath10k_sdio mmc2:0001:1: failed to fetch board data for bus=sdio,vendor=0271,device=0701,subsystem-vendor=0000,subsystem-device=0000 from ath10k/QCA9377/hw1.0/board-2.bin
> [    5.624473] ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A crc32 544289f7
> [    6.775882] ath10k_sdio mmc2:0001:1: htt-ver 3.32 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
> [    6.854066] ath: EEPROM regdomain sanitized
> [    6.854073] ath: EEPROM regdomain: 0x64
> [    6.854075] ath: EEPROM indicates we should expect a direct regpair map
> [    6.854082] ath: Country alpha2 being used: 00
> [    6.854083] ath: Regpair used: 0x64
> [    8.444189] ath: EEPROM regdomain: 0x8114
> [    8.444194] ath: EEPROM indicates we should expect a country code
> [    8.444196] ath: doing EEPROM country->regdmn map search
> [    8.444198] ath: country maps to regdmn code: 0x37
> [    8.444201] ath: Country alpha2 being used: DE
> [    8.444203] ath: Regpair used: 0x37
> [    8.444206] ath: regdomain 0x8114 dynamically updated by country element
> 
> The test device is an Amlogic S905D STB device from O2.cz that I have just submitted a working device-tree for [2].
> 
> If you need a QCA9377 test device, I have a duplicate/spare of the box and would be happy to post it.
> 
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> 
> [1] https://github.com/chewitt/qca-firmware
> [2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=249525
> 

I have received a lot of questions lately about this patch (why it has not been integrated).
It is actually the only missing piece in order to have working QCA9377 support on mainline.

Unless there is a good reason not to add it, I think it should be integrated.

--
Erik
