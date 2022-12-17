Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839B64F8F6
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 13:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiLQMaI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 07:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQMaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 07:30:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCAD13D25
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 04:30:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so11981213ejc.2
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 04:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iuiyyd7GoFVF4xZSQAWs1vVZKRTeVEe6ZTxSu488lZc=;
        b=j6KyCyNrWIDZBYmzjaHbx+m9cOIrrmYSg3qhAkewOQgNngO9YgzMSrYVyNma67TQnF
         yoGWYGEscipc+ahGyZnQtopfljtlGz09AYjDP6OzP21FhCgQLbx/yJeK3vuqzR6uTlP2
         iGbpY+SpQgLnnVjRQovfEFpAGkBoqTLoJQ1KcfdDS0TJ2MO65VHpLATxWgUOzbBnw35R
         freLES551HFIUDdObr2jhqCoSxX9xbjLrjUAXYeIPa0z7xQJOH+3tI2J2Pk2p07UjqkT
         hwEqYSg+7h9qWuQeQ2JUmk9QdlPFbbS/MmsS1yxknZc1sy7NBOtp4kNFYogwsj1CkM8d
         wYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuiyyd7GoFVF4xZSQAWs1vVZKRTeVEe6ZTxSu488lZc=;
        b=GNqhFecv8G74E/LV2zbROtCZ6EUn6CMuvrq2mwjmquNfU5trDCHjbpKJjOFCHJ20L2
         r83O1Q1IgyEcHl+0832QnhwnJF3UaCs0H8ix5/qzurtPHgNWvXF1nZimz7c2nM37tds9
         L6BdgVjDRfvHM2oIb4nqrlDaSu/KHIRjXw1D894yHXmp/tarm65jU5T+RnCGnbpP0Mc1
         PblQmlGjNL5T9/mzveAjltvcy4lBmrv+0kBRjDJIq79JXvu0jyjHjZQ9M0kygXed+H/k
         M8fAh09FSxlwMBAtQUO8VJRS7E1nB8IH2zrxCxUXt1i9GeonBiPVUrdEfQB7k4J6xG7i
         47xA==
X-Gm-Message-State: ANoB5pkXjrE6cloi4bShw8N7SXyPfe96PkCrGtfat4bD8b9jkz49qPe4
        EI72dwCu9YdfbIOEkNlSRAo=
X-Google-Smtp-Source: AA0mqf5J/h9UepJ+Vt0kbR1XeXpN+NfgJL+MviC/447puKQO2LfygK/YptbqE08jFoQSHStXlhR6Yw==
X-Received: by 2002:a17:906:bc58:b0:7c0:fd1a:79f0 with SMTP id s24-20020a170906bc5800b007c0fd1a79f0mr30141750ejv.21.1671280203583;
        Sat, 17 Dec 2022 04:30:03 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id mh11-20020a170906eb8b00b007ad69e9d34dsm1949305ejb.54.2022.12.17.04.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 04:30:02 -0800 (PST)
Message-ID: <7d08e5bc-6365-d65d-d5d5-17c67aece96c@gmail.com>
Date:   Sat, 17 Dec 2022 14:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 4/5] wifi: rtl8xxxu: Support new chip RTL8188EU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
 <b4137e88-f4b8-b5a3-58da-cba10a66d5ae@gmail.com>
 <f1add579e990fbc339bf47b69774b4c0ca669cb9.camel@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <f1add579e990fbc339bf47b69774b4c0ca669cb9.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/12/2022 15:00, Ping-Ke Shih wrote:
> On Tue, 2022-12-13 at 19:31 +0200, Bitterblue Smith wrote:
>> From: Jes Sorensen <Jes.Sorensen@gmail.com>
>>
>> This chip is found in cheap USB devices from TP-Link, D-Link, etc.
>>
>> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
>>
>> Chip versions older than "I cut" need software rate control. That will
>> be in the next commit. Until then MCS7 is used for all data frames.
>>
>> The "I cut" chips are not supported. They require different firmware
>> and initialisation tables. Support can be added if someone has the
>> hardware to test it.
>>
>> Co-developed-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Co-developed-by: Taehee Yoo <ap420073@gmail.com>
>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>> Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Co-developed-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> So this patch is 52 of the 57 patches found here, squashed together:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git/log/drivers/net/wireless/realtek/rtl8xxxu?h=rtl8xxxu-8188eu
>>
>> Starting from c3f84ded6f76 ("rtl8xxxu: Accept firmware signature 0x88e0")
>> up to a9b05c059510 ("rtl8xxxu: Add rpt_sel entry to struct rtl8xxxu_rxdesc16").
>>
>> These patches were not needed:
>> 3170622ccb61 ("rtl8xxxu: Detect 8188eu parts correctly")
>> 8fb5bc92bce0 ("rtl8xxxu: Initialize GPIO settings for 8188eu")
>> 6ab646adb585 ("rtl8xxxu: Implement rtl8188e_set_tx_power()")
>> 2ccd1f1fc480 ("rtl8xxxu: properly detect RTL8188EU devices")
>> 809a2e000cab ("rtl8xxxu: Do not set auto rate fallback on 8188eu")
>>
>> On top of that, I made various changes required for today's kernel,
>> plus changes to match the newer vendor driver more closely, plus some
>> bug fixes.
>>
>> v2:
>>  - Implement suggestions from Ping-Ke Shih:
>>    - Add __packed to struct rtl8188eu_efuse.
>>    - Use u32p_replace_bits() in rtl8188eu_config_channel().
>>    - Make fw_name const char*.
>>    - Use the masks defined in patch 3/5 in rtl8188e_cck_rssi().
>>  - Use u32_get_bits() in assignment to bit field priv->pi_enabled.
>>  - Remove the efuse dumping code. It's not needed after patch 1/5.
>>  - Update the module description.
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    2 +-
>>  .../net/wireless/realtek/rtl8xxxu/Makefile    |    3 +-
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   67 +-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 1286 +++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    4 +-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  201 ++-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   40 +-
>>  7 files changed, 1578 insertions(+), 25 deletions(-)
>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>>
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index 15bb2b5211a8..29f5dbee16b0 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -36,6 +36,7 @@
>>  
>>  #define TX_TOTAL_PAGE_NUM		0xf8
>>  #define TX_TOTAL_PAGE_NUM_8188F		0xf7
>> +#define TX_TOTAL_PAGE_NUM_8188E		0xa9
>>  #define TX_TOTAL_PAGE_NUM_8192E		0xf3
>>  #define TX_TOTAL_PAGE_NUM_8723B		0xf7
>>  /* (HPQ + LPQ + NPQ + PUBQ) = TX_TOTAL_PAGE_NUM */
>> @@ -49,6 +50,11 @@
>>  #define TX_PAGE_NUM_LO_PQ_8188F		0x02
>>  #define TX_PAGE_NUM_NORM_PQ_8188F	0x02
>>  
>> +#define TX_PAGE_NUM_PUBQ_8188E		0x47
>> +#define TX_PAGE_NUM_HI_PQ_8188E		0x29
>> +#define TX_PAGE_NUM_LO_PQ_8188E		0x1c
>> +#define TX_PAGE_NUM_NORM_PQ_8188E	0x1c
>> +
>>  #define TX_PAGE_NUM_PUBQ_8192E		0xe7
>>  #define TX_PAGE_NUM_HI_PQ_8192E		0x08
>>  #define TX_PAGE_NUM_LO_PQ_8192E		0x0c
>> @@ -153,7 +159,8 @@ struct rtl8xxxu_rxdesc16 {
>>  	u32 htc:1;
>>  	u32 eosp:1;
>>  	u32 bssidfit:2;
>> -	u32 reserved1:16;
>> +	u32 rpt_sel:2;		/* 8188e */
>> +	u32 reserved1:14;
>>  	u32 unicastwake:1;
>>  	u32 magicwake:1;
>>  
>> @@ -211,7 +218,8 @@ struct rtl8xxxu_rxdesc16 {
>>  
>>  	u32 magicwake:1;
>>  	u32 unicastwake:1;
>> -	u32 reserved1:16;
>> +	u32 reserved1:14;
>> +	u32 rpt_sel:2;		/* 8188e */
>>  	u32 bssidfit:2;
>>  	u32 eosp:1;
>>  	u32 htc:1;
> 
> Missing __packed on this struct.
> However, it has existed, so maybe you can review struct and 
> use another patch to add __packed.
> 
Sure, I can add it later. There are several structs which technically
should have __packed, but they happen to work anyway.

> 
>> @@ -502,6 +510,8 @@ struct rtl8xxxu_txdesc40 {
>>  #define TXDESC_AMPDU_DENSITY_SHIFT	20
>>  #define TXDESC40_BT_INT			BIT(23)
>>  #define TXDESC40_GID_SHIFT		24
>> +#define TXDESC_ANTENNA_SELECT_A		BIT(24)
>> +#define TXDESC_ANTENNA_SELECT_B		BIT(25)
>>  
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>> new file mode 100644
>> index 000000000000..587555da9bce
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
>>
> 
> [...]
> 
>> +static int rtl8188eu_identify_chip(struct rtl8xxxu_priv *priv)
>> +{
>> +	struct device *dev = &priv->udev->dev;
>> +	u32 sys_cfg, vendor;
>> +	int ret = 0;
>> +
>> +	strscpy(priv->chip_name, "8188EU", sizeof(priv->chip_name));
>> +	priv->rtl_chip = RTL8188E;
>> +	priv->rf_paths = 1;
>> +	priv->rx_paths = 1;
>> +	priv->tx_paths = 1;
>> +	priv->has_wifi = 1;
>> +
>> +	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
>> +	priv->chip_cut = u32_get_bits(sys_cfg, SYS_CFG_CHIP_VERSION_MASK);
>> +	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
>> +		dev_info(dev, "Unsupported test chip\n");
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * TODO: At a glance, I cut requires a different firmware,
>> +	 * different initialisation tables, and no software rate
>> +	 * control. The vendor driver is not configured to handle
>> +	 * I cut chips by default. Are there any in the wild?
>> +	 */
>> +	if (priv->chip_cut == 8) {
>> +		dev_info(dev, "RTL8188EU cut I is not supported. Please complain about it at 
>> linux-wireless@vger.kernel.org.\n");
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
> 
> nit: Since you don't need any error handling, just return -EOPNOTSUPP;
> 
Okay.

> >> +	}
>> +
>> +	vendor = sys_cfg & SYS_CFG_VENDOR_ID;
>> +	rtl8xxxu_identify_vendor_1bit(priv, vendor);
>> +
>> +	ret = rtl8xxxu_config_endpoints_no_sie(priv);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
> 
> [...]
> 
> 

