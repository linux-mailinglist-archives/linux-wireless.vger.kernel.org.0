Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77E6F1FFC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 23:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjD1VLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjD1VLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 17:11:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F89E69
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:11:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so1320765e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682716306; x=1685308306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iM8uBSqU+7JHnkbotyqVt5sn59Mc9+aZrKWATgZvX5g=;
        b=AempnN3kGgD+8ezkSDHMF+fAz13uKdILvKLX0Pt6+YaU0cwV9p/iSGCSE+ONvCa2Lm
         v7229Nolm7ClMpXzqgjzQSmhNCOHQ8YLElAozFJdbNTJ0bquZo6vliZ1EF3hNtZo1O8S
         J91GWOSBERWB/+DWWF/jJXqXdHqRKwCbxFTumgEMp/G2nrxh/taXlD9Ddg11Uf8A8uya
         YhyxvwcWannJDx/jfoNlnr3oaRArqDTRk3ZLqxpe+36cNNYN8+jtpvCYr5fyhsEyFlCq
         gI2K2esDwrt0OVz1HmhrWEMMg1uq0PLOIRc8te8PYc6Mz13ox6twGav7DIhlc2jKmXfu
         1xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682716306; x=1685308306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM8uBSqU+7JHnkbotyqVt5sn59Mc9+aZrKWATgZvX5g=;
        b=PTjVnfGJw6ECIMx9HlDF1JXTNUeXK7jKDfSp8E65Yk8SGLoE4+wkw0o20nI2tE5ELK
         aQ0GIh6myHpUSYwyyCY6mgXPH6Urg/tEGqVrtDvHDinuRUmD71PEEZ/JPUqiHGmCn8Xq
         dl4yPFUqaFnDoapXYUWJtGfYhXsf/oOmU8Sk+akBbyXPZ/yjcQQ60bsiyeN58JtMbeKe
         edUFpOB30kFr2EIMEPW3nQq4RZvw4mMYTzyqEfd5+Jenz2LH3kgZTLbWLt3/A72/iJ72
         lg61igAAW3z5dgvhs03Izr0ZIRT8leXasiv5OfCTpjU1vE06uCG3opG6K+I9sDqHgFQ0
         Ci2Q==
X-Gm-Message-State: AC+VfDzG4nvrY7AFJFacjGKi42t9dv5FUelC8th1sVTyHmLoNgdweQ6+
        B5MEieSydTPhxczMVtj92+4=
X-Google-Smtp-Source: ACHHUZ4bVU8UFNu5IWQPuP5Trnwy9/PbHdWuZTfEns6baXfQqNfWkCe48rd0P8Gu8EzKXczMMJ2MnA==
X-Received: by 2002:a05:6000:136a:b0:304:79c1:725d with SMTP id q10-20020a056000136a00b0030479c1725dmr4699466wrz.45.1682716305504;
        Fri, 28 Apr 2023 14:11:45 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id m18-20020adffa12000000b003047297a5e8sm15284002wrr.54.2023.04.28.14.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 14:11:45 -0700 (PDT)
Message-ID: <c2e57571-4fc4-69ef-f8a1-049bf2eca9ed@gmail.com>
Date:   Sat, 29 Apr 2023 00:11:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <90102fa5-5065-9598-d21f-3624629a0cb5@gmail.com>
 <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <867b2c35f606434bb82ecc17d0fd9336@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/04/2023 09:21, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, April 26, 2023 1:28 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH] wifi: rtl8xxxu: Support new chip RTL8192FU
>>
>> This is a newer chip, similar to the RTL8710BU in that it uses the same
>> PHY status structs.
>>
>> Features: 2.4 GHz, b/g/n mode, 2T2R, 300 Mbps.
>>
>> It can allegedly have Bluetooth, but that's not implemented here.
>>
>> This chip can have many RFE (RF front end) types, of which type 5 is
>> the only one tested. Many of the other types need different
>> initialisation tables. They can be added if someone wants them.
>>
>> The vendor driver v5.8.6.2_35538.20191028_COEX20190910-0d02 from
>> https://github.com/BrightX/rtl8192fu was used as reference.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/Kconfig |    3 +-
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   47 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |    3 +-
>>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 2081 +++++++++++++++++
>>  .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |    1 +
>>  .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |    1 +
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  104 +-
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   15 +
>>  8 files changed, 2225 insertions(+), 30 deletions(-)
>>  create mode 100644 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
>>
> 
> [...]
> 
>> +static void rtl8192fu_config_kfree(struct rtl8xxxu_priv *priv, u8 channel)
>> +{
>> +       u8 bb_gain[3] = { EFUSE_UNDEFINED, EFUSE_UNDEFINED, EFUSE_UNDEFINED };
>> +       u8 bb_gain_path_mask[2] = { 0x0f, 0xf0 };
>> +       enum rtl8xxxu_rfpath rfpath;
>> +       u8 bb_gain_for_path;
>> +       u8 channel_idx;
>> +
>> +       if (channel >= 1 && channel <= 3)
>> +               channel_idx = 0;
>> +       if (channel >= 4 && channel <= 9)
>> +               channel_idx = 1;
>> +       if (channel >= 10 && channel <= 14)
>> +               channel_idx = 2;
>> +
>> +       rtl8xxxu_read_efuse8(priv, 0x1ee, &bb_gain[1]);
>> +       rtl8xxxu_read_efuse8(priv, 0x1ec, &bb_gain[0]);
>> +       rtl8xxxu_read_efuse8(priv, 0x1ea, &bb_gain[2]);
> 
> Can you define these fields in struct rtl8192fu_efuse, and access via
> the struct? 
> 

They are not in the efuse map. These are "physical" efuse addresses.
I don't know what that means, as I have not studied the efuse stuff.

> 
>> +
>> +       if (bb_gain[1] == EFUSE_UNDEFINED)
>> +               return;
>> +
>> +       if (bb_gain[0] == EFUSE_UNDEFINED)
>> +               bb_gain[0] = bb_gain[1];
>> +
>> +       if (bb_gain[2] == EFUSE_UNDEFINED)
>> +               bb_gain[2] = bb_gain[1];
>> +
>> +       for (rfpath = RF_A; rfpath < priv->rf_paths; rfpath++) {
>> +               /* power_trim based on 55[19:14] */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_55,
>> +                                         BIT(5), 1);
>> +
>> +               /* enable 55[14] for 0.5db step */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, 0xf5, BIT(18), 1);
> 
> #define RF6052_REG_GAIN_CTRL 0x55
> 
>> +
>> +               /* enter power_trim debug mode */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_DF,
>> +                                         BIT(7), 1);
>> +
>> +               /* write enable */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_WE_LUT, BIT(7), 1);
>> +
>> +               bb_gain_for_path = (bb_gain[channel_idx] & bb_gain_path_mask[rfpath])
>> +                                >> __ffs(bb_gain_path_mask[rfpath]);
> 
> Normally, putting operator >> in tail, but this statement is so long.
> How about this?
> 
> 		bb_gain_for_path = (bb_gain[channel_idx] & bb_gain_path_mask[rfpath]);
> 		bb_gain_for_path >>= __ffs(bb_gain_path_mask[rfpath]);
> 

Looks good. I didn't think of that.

>> +
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
>> +                                         0x70000, channel_idx * 2);
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
>> +                                         0x3f, bb_gain_for_path);
>> +
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
>> +                                         0x70000, channel_idx * 2 + 1);
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_TXPA_G3,
>> +                                         0x3f, bb_gain_for_path);
>> +
>> +               /* leave power_trim debug mode */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_UNKNOWN_DF,
>> +                                         BIT(7), 0);
>> +
>> +               /* write disable */
>> +               rtl8xxxu_write_rfreg_mask(priv, rfpath, RF6052_REG_WE_LUT, BIT(7), 0);
>> +       }
>> +}
>> +
> 
> [...]
> 
>> +static void rtl8192fu_init_phy_bb(struct rtl8xxxu_priv *priv)
>> +{
>> +       /* Enable BB and RF */
>> +       rtl8xxxu_write16_set(priv, REG_SYS_FUNC,
>> +                            SYS_FUNC_BBRSTB | SYS_FUNC_BB_GLB_RSTN);
>> +
>> +       rtl8xxxu_write8(priv, REG_RF_CTRL, RF_ENABLE | RF_RSTB | RF_SDMRSTB);
>> +
>> +       /* To Fix MAC loopback mode fail. */
>> +       rtl8xxxu_write8(priv, REG_LDOHCI12_CTRL, 0xf);
>> +       rtl8xxxu_write8(priv, 0x15, 0xe9);
> 
> #define REG_SYS_SWR_CTRL2 0x14
> 
> You can use REG_SYS_SWR_CTRL2 + 1 here.
> 
>> +
>> +       rtl8xxxu_init_phy_regs(priv, rtl8192fu_phy_init_table);
>> +
>> +       rtl8xxxu_init_phy_regs(priv, rtl8192f_agc_table);
>> +}
>> +
> 
> [...]
> 
>> +static int rtl8192fu_iqk_path_a(struct rtl8xxxu_priv *priv)
>> +{
>> +       u32 reg_eac, reg_e94, reg_e9c, val32;
>> +       u32 rf_0x58_i, rf_0x58_q;
>> +       u8 rfe = priv->rfe_type;
>> +       int result = 0;
>> +       int ktime, i;
>> +
>> +       /* Leave IQK mode */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
>> +       rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
> 
> #define REG_ANAPWR1 0xd94
> 
>> +       rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(4), 1);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
>> +       if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12)
>> +               val32 = 0x30;
>> +       else
>> +               val32 = 0xe9;
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, val32);
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +
>> +       /* path-A IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x18008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x8214000f);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28140000);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
>> +
>> +       /* LO calibration setting */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x00e62911);
>> +
>> +       /* One shot, path A LOK & IQK */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
>> +
>> +       mdelay(15);
>> +
>> +       ktime = 0;
>> +       while (rtl8xxxu_read32(priv, 0xe98) == 0 && ktime < 21) {
> 
> #define REG_IQK_RTP_TXA 0xe98
> 
>> +               mdelay(5);
>> +               ktime += 5;
>> +       }
>> +
>> +       /* Check failed */
>> +       reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +       reg_e94 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
>> +       reg_e9c = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
>> +
>> +       /* reload 0xdf and CCK_IND off */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_WE_LUT, BIT(4), 1);
>> +
>> +       val32 = rtl8xxxu_read_rfreg(priv, RF_A, 0x58);
> 
> #define RF6052_REG_TXMOD 0x58
> 
>> +       rf_0x58_i = u32_get_bits(val32, 0xfc000);
>> +       rf_0x58_q = u32_get_bits(val32, 0x003f0);
>> +
>> +       for (i = 0; i < 8; i++) {
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_TXPA_G3,
>> +                                         0x1c000, i);
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_TXPA_G3,
>> +                                         0x00fc0, rf_0x58_i);
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_TXPA_G3,
>> +                                         0x0003f, rf_0x58_q);
>> +       }
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_AC, BIT(14), 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_WE_LUT, BIT(4), 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, 0x00810, 0);
>> +
>> +       if (!(reg_eac & BIT(28)) &&
>> +           ((reg_e94 & 0x03ff0000) != 0x01420000) &&
>> +           ((reg_e9c & 0x03ff0000) != 0x00420000))
>> +               result |= 0x01;
>> +
>> +       return result;
>> +}
>> +
>> +static int rtl8192fu_rx_iqk_path_a(struct rtl8xxxu_priv *priv)
>> +{
>> +       u32 reg_ea4, reg_eac, reg_e94, reg_e9c, val32;
>> +       int result = 0;
>> +       int ktime;
>> +
>> +       /* Leave IQK mode */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       /* PA/PAD control by 0x56, and set = 0x0 */
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
>> +       rtl8xxxu_write_rfreg(priv, RF_A, 0x35, 0);
> 
> #define RF6052_REG_GAIN_P1  0x35
> #define RF6052_REG_PAD_TXG 0x56
> #define RF6052_REG_GAIN_CCA 0xdf
> 
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, 0x27);
>> +
>> +       /* Enter IQK mode */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +
>> +       /* path-A IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x18008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x82160027);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28160000);
>> +
>> +       /* Tx IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
>> +
>> +       /* LO calibration setting */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0086a911);
>> +
>> +       /* One shot, path A LOK & IQK */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
>> +
>> +       mdelay(15);
>> +
>> +       ktime = 0;
>> +       while (rtl8xxxu_read32(priv, 0xe98) == 0 && ktime < 21) {
> 
> #define REG_IQK_RTP_TXA 0xe98
> 
>> +               mdelay(5);
>> +               ktime += 5;
>> +       }
>> +
>> +       /* Check failed */
>> +       reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +       reg_e94 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
>> +       reg_e9c = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
>> +
>> +       if (!(reg_eac & BIT(28)) &&
>> +           ((reg_e94 & 0x03ff0000) != 0x01420000) &&
>> +           ((reg_e9c & 0x03ff0000) != 0x00420000)) {
>> +               result |= 0x01;
>> +       } else { /* If TX not OK, ignore RX */
>> +               /* PA/PAD controlled by 0x0 */
>> +               rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF,
>> +                                         BIT(11), 0);
>> +
>> +               return result;
>> +       }
>> +
>> +       val32 = 0x80007c00 | (reg_e94 & 0x3ff0000) | ((reg_e9c & 0x3ff0000) >> 16);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK, val32);
>> +
>> +       /* Modify RX IQK mode table */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       /* PA/PAD control by 0x56, and set = 0x0 */
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
>> +       rtl8xxxu_write_rfreg(priv, RF_A, 0x35, 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_56, 0x003ff, 0x1e0);
>> +
>> +       rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
>> +       rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
>> +       rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
>> +
>> +       /* Enter IQK mode */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +
>> +       /* path-A IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x18008c1c);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_PI_A, 0x82170000);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_PI_A, 0x28170000);
>> +
>> +       /* RX IQK setting */
>> +       rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
>> +
>> +       /* LO calibration setting */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0046a8d1);
>> +
>> +       /* One shot, path A LOK & IQK */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
>> +
>> +       mdelay(15);
>> +
>> +       ktime = 0;
>> +       while (rtl8xxxu_read32(priv, 0xea8) == 0 && ktime < 21) {
> 
> #define REG_IQK_RTP_RXA 0xea8
> 
>> +               mdelay(5);
>> +               ktime += 5;
>> +       }
>> +
>> +       /* Check failed */
>> +       reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +       reg_ea4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
>> +
>> +       /* Leave IQK mode */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_A, RF6052_REG_UNKNOWN_DF, BIT(11), 0);
>> +       rtl8xxxu_write_rfreg(priv, RF_A, 0x35, 0x02000);
>> +
>> +       if (!(reg_eac & BIT(27)) &&
>> +           ((reg_ea4 & 0x03ff0000) != 0x01320000) &&
>> +           ((reg_eac & 0x03ff0000) != 0x00360000))
>> +               result |= 0x02;
>> +
>> +       return result;
>> +}
>> +
>> +static int rtl8192fu_iqk_path_b(struct rtl8xxxu_priv *priv)
>> +{
>> +       u32 reg_eac, reg_eb4, reg_ebc, val32;
>> +       u32 rf_0x58_i, rf_0x58_q;
>> +       u8 rfe = priv->rfe_type;
>> +       int result = 0;
>> +       int ktime, i;
>> +
>> +       /* PA/PAD controlled by 0x0 */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
>> +       rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
>> +       rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(4), 1);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
>> +       if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12)
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56,
>> +                                         0x003ff, 0x30);
>> +       else
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56,
>> +                                         0x00fff, 0xe9);
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +
>> +       /* Path B IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x18008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_PI_B, 0x8214000F);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_PI_B, 0x28140000);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK, 0x01007c00);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
>> +
>> +       /* LO calibration setting */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x00e62911);
>> +
>> +       /* One shot, path B LOK & IQK */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
>> +
>> +       mdelay(15);
>> +
>> +       ktime = 0;
>> +       while (rtl8xxxu_read32(priv, 0xeb8) == 0 && ktime < 21) {
> 
> #define REG_IQK_RTP_TXB 0xeb8
> 
>> +               mdelay(5);
>> +               ktime += 5;
>> +       }
>> +
>> +       /* Check failed */
>> +       reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +       reg_eb4 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_B);
>> +       reg_ebc = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_B);
>> +
>> +       /* reload 0xdf and CCK_IND off */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_WE_LUT, BIT(4), 1);
>> +
>> +       val32 = rtl8xxxu_read_rfreg(priv, RF_B, 0x58);
>> +       rf_0x58_i = u32_get_bits(val32, 0xfc000);
>> +       rf_0x58_q = u32_get_bits(val32, 0x003f0);
>> +
>> +       for (i = 0; i < 8; i++) {
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_TXPA_G3,
>> +                                         0x1c000, i);
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_TXPA_G3,
>> +                                         0x00fc0, rf_0x58_i);
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_TXPA_G3,
>> +                                         0x0003f, rf_0x58_q);
>> +       }
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_AC, BIT(14), 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_WE_LUT, BIT(4), 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, 0x00810, 0);
>> +
>> +       if (!(reg_eac & BIT(31)) &&
>> +           ((reg_eb4 & 0x03ff0000) != 0x01420000) &&
>> +           ((reg_ebc & 0x03ff0000) != 0x00420000))
>> +               result |= 0x01;
>> +       else
>> +               dev_warn(&priv->udev->dev, "%s: Path B IQK failed!\n",
>> +                        __func__);
>> +
>> +       return result;
>> +}
>> +
>> +static int rtl8192fu_rx_iqk_path_b(struct rtl8xxxu_priv *priv)
>> +{
>> +       u32 reg_eac, reg_eb4, reg_ebc, reg_ec4, reg_ecc, val32;
>> +       int result = 0;
>> +       int ktime;
>> +
>> +       /* Leave IQK mode */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
>> +       rtl8xxxu_write_rfreg(priv, RF_B, 0x35, 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x003ff, 0x67);
>> +
>> +       rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
>> +       rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
>> +       rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +
>> +       /* path-B IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x18008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x38008c1c);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_PI_B, 0x82160027);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_PI_B, 0x28160000);
>> +
>> +       /* LO calibration setting */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0086a911);
>> +
>> +       /* One shot, path A LOK & IQK */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
>> +
>> +       mdelay(15);
>> +
>> +       ktime = 0;
>> +       while (rtl8xxxu_read32(priv, 0xeb8) == 0 && ktime < 21) {
>> +               mdelay(5);
>> +               ktime += 5;
>> +       }
>> +
>> +       /* Check failed */
>> +       reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +       reg_eb4 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_B);
>> +       reg_ebc = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_B);
>> +
>> +       if (!(reg_eac & BIT(31)) &&
>> +           ((reg_eb4 & 0x03ff0000) != 0x01420000) &&
>> +           ((reg_ebc & 0x03ff0000) != 0x00420000)) {
>> +               result |= 0x01;
>> +       } else {
>> +               /* PA/PAD controlled by 0x0 */
>> +               rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +               rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF,
>> +                                         BIT(11), 0);
>> +
>> +               return result;
>> +       }
>> +
>> +       val32 = 0x80007c00 | (reg_eb4 & 0x03ff0000) | ((reg_ebc >> 16) & 0x03ff);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK, val32);
>> +
>> +       /* Modify RX IQK mode table */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 1);
>> +       rtl8xxxu_write_rfreg(priv, RF_B, 0x35, 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 1);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_56, 0x003ff, 0x1e0);
>> +
>> +       rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xccf000c0);
>> +       rtl8xxxu_write32(priv, 0xd94, 0x44ffbb44);
>> +       rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x00400040);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005403);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000804e4);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04203400);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000000);
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +
>> +       /* Path B IQK setting */
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_A, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_TONE_B, 0x38008c1c);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_TONE_B, 0x18008c1c);
>> +
>> +       rtl8xxxu_write32(priv, REG_TX_IQK_PI_B, 0x82170000);
>> +       rtl8xxxu_write32(priv, REG_RX_IQK_PI_B, 0x28170000);
>> +
>> +       /* IQK setting */
>> +       rtl8xxxu_write32(priv, REG_RX_IQK, 0x01004800);
>> +
>> +       /* LO calibration setting */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_RSP, 0x0046a911);
>> +
>> +       /* One shot, path A LOK & IQK */
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xfa005800);
>> +       rtl8xxxu_write32(priv, REG_IQK_AGC_PTS, 0xf8005800);
>> +
>> +       mdelay(15);
>> +
>> +       ktime = 0;
>> +       while (rtl8xxxu_read32(priv, 0xec8) == 0 && ktime < 21) {
> 
> #define REG_IQK_RTP_RXB 0xec8
> 
>> +               mdelay(5);
>> +               ktime += 5;
>> +       }
>> +
>> +       reg_eac = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +       reg_ec4 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_B_2);
>> +       reg_ecc = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_B_2);
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
>> +
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(11), 0);
>> +       rtl8xxxu_write_rfreg_mask(priv, RF_B, RF6052_REG_UNKNOWN_DF, BIT(1), 0);
>> +       rtl8xxxu_write_rfreg(priv, RF_B, 0x35, 0x02000);
>> +
>> +       if (!(reg_eac & BIT(30)) &&
>> +           ((reg_ec4 & 0x03ff0000) != 0x01320000) &&
>> +           ((reg_ecc & 0x03ff0000) != 0x00360000))
>> +               result |= 0x02;
>> +       else
>> +               dev_warn(&priv->udev->dev, "%s: Path B RX IQK failed!\n",
>> +                        __func__);
>> +
>> +       return result;
>> +}
>> +
>> +static void rtl8192fu_phy_iqcalibrate(struct rtl8xxxu_priv *priv,
>> +                                     int result[][8], int t)
>> +{
>> +       static const u32 adda_regs[2] = {
>> +               0xd94, REG_RX_WAIT_CCA
>> +       };
>> +       static const u32 iqk_mac_regs[RTL8XXXU_MAC_REGS] = {
>> +               REG_TXPAUSE, REG_BEACON_CTRL,
>> +               REG_BEACON_CTRL_1, REG_GPIO_MUXCFG
>> +       };
>> +       static const u32 iqk_bb_regs[RTL8XXXU_BB_REGS] = {
>> +               REG_OFDM0_TRX_PATH_ENABLE, REG_OFDM0_TR_MUX_PAR,
>> +               REG_FPGA0_XCD_RF_SW_CTRL, REG_CONFIG_ANT_A, REG_CONFIG_ANT_B,
>> +               REG_DPDT_CTRL, REG_RFE_CTRL_ANTA_SRC,
>> +               0x938, REG_CCK0_AFE_SETTING
>> +       };
> 
> #define REG_RFE_CTRL_ANT_SRC2 0x938
> 
>> +       u32 rx_initial_gain_a, rx_initial_gain_b;
>> +       struct device *dev = &priv->udev->dev;
>> +       int path_a_ok, path_b_ok;
>> +       u8 rfe = priv->rfe_type;
>> +       int retry = 2;
>> +       u32 i, val32;
>> +
>> +       /*
>> +        * Note: IQ calibration must be performed after loading
>> +        *       PHY_REG.txt , and radio_a, radio_b.txt
>> +        */
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rx_initial_gain_a = rtl8xxxu_read32(priv, REG_OFDM0_XA_AGC_CORE1);
>> +       rx_initial_gain_b = rtl8xxxu_read32(priv, REG_OFDM0_XB_AGC_CORE1);
>> +
>> +       if (t == 0) {
>> +               /* Save ADDA parameters, turn Path A ADDA on */
>> +               rtl8xxxu_save_regs(priv, adda_regs, priv->adda_backup,
>> +                                  ARRAY_SIZE(adda_regs));
>> +               rtl8xxxu_save_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
>> +               rtl8xxxu_save_regs(priv, iqk_bb_regs,
>> +                                  priv->bb_backup, RTL8XXXU_BB_REGS);
>> +       }
>> +
>> +       /* Instead of rtl8xxxu_path_adda_on */
>> +       rtl8xxxu_write32_set(priv, REG_FPGA0_XCD_RF_PARM, BIT(31));
>> +
>> +       /* MAC settings */
>> +       rtl8xxxu_write8(priv, REG_TXPAUSE, 0xff);
>> +       rtl8xxxu_write8_clear(priv, REG_GPIO_MUXCFG, GPIO_MUXCFG_IO_SEL_ENBT);
>> +
>> +       if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12) {
>> +               /* in ePA IQK, rfe_func_config & SW both pull down */
>> +               /* path A */
>> +               rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC, 0xF, 0x7);
>> +               rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x1, 0x0);
>> +
>> +               rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC, 0xF00, 0x7);
>> +               rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x4, 0x0);
>> +
>> +               rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC, 0xF000, 0x7);
>> +               rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x8, 0x0);
>> +
>> +               /* path B */
>> +               rtl8xxxu_write32_mask(priv, 0x938, 0xF0, 0x7);
>> +               rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x20000, 0x0);
>> +
>> +               rtl8xxxu_write32_mask(priv, 0x938, 0xF0000, 0x7);
>> +               rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x100000, 0x0);
>> +
>> +               rtl8xxxu_write32_mask(priv, 0x93c, 0xF000, 0x7);
> 
> #define REG_RFE_CTRL_ANT_SRC3 0x93c
> 
>> +               rtl8xxxu_write32_mask(priv, REG_DPDT_CTRL, 0x8000000, 0x0);
>> +       }
>> +
>> +       if (priv->rf_paths > 1) {
>> +               /* path B standby */
>> +               rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x000000);
>> +               rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_AC, 0x10000);
>> +               rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0x808000);
>> +       }
>> +
>> +       for (i = 0; i < retry; i++) {
>> +               path_a_ok = rtl8192fu_iqk_path_a(priv);
>> +
>> +               if (path_a_ok == 0x01) {
>> +                       val32 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_A);
>> +                       result[t][0] = (val32 >> 16) & 0x3ff;
>> +
>> +                       val32 = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_A);
>> +                       result[t][1] = (val32 >> 16) & 0x3ff;
>> +                       break;
>> +               } else {
>> +                       result[t][0] = 0x100;
>> +                       result[t][1] = 0x0;
>> +               }
>> +       }
>> +
>> +       for (i = 0; i < retry; i++) {
>> +               path_a_ok = rtl8192fu_rx_iqk_path_a(priv);
>> +
>> +               if (path_a_ok == 0x03) {
>> +                       val32 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_A_2);
>> +                       result[t][2] = (val32 >> 16) & 0x3ff;
>> +
>> +                       val32 = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_A_2);
>> +                       result[t][3] = (val32 >> 16) & 0x3ff;
>> +                       break;
>> +               } else {
>> +                       result[t][2] = 0x100;
>> +                       result[t][3] = 0x0;
>> +               }
>> +       }
>> +
>> +       if (!path_a_ok)
>> +               dev_warn(dev, "%s: Path A IQK failed!\n", __func__);
>> +
>> +       if (priv->rf_paths > 1) {
>> +               for (i = 0; i < retry; i++) {
>> +                       path_b_ok = rtl8192fu_iqk_path_b(priv);
>> +
>> +                       if (path_b_ok == 0x01) {
>> +                               val32 = rtl8xxxu_read32(priv, REG_TX_POWER_BEFORE_IQK_B);
>> +                               result[t][4] = (val32 >> 16) & 0x3ff;
>> +
>> +                               val32 = rtl8xxxu_read32(priv, REG_TX_POWER_AFTER_IQK_B);
>> +                               result[t][5] = (val32 >> 16) & 0x3ff;
>> +                               break;
>> +                       } else {
>> +                               result[t][4] = 0x100;
>> +                               result[t][5] = 0x0;
>> +                       }
>> +               }
>> +
>> +               for (i = 0; i < retry; i++) {
>> +                       path_b_ok = rtl8192fu_rx_iqk_path_b(priv);
>> +
>> +                       if (path_b_ok == 0x03) {
>> +                               val32 = rtl8xxxu_read32(priv, REG_RX_POWER_BEFORE_IQK_B_2);
>> +                               result[t][6] = (val32 >> 16) & 0x3ff;
>> +
>> +                               val32 = rtl8xxxu_read32(priv, REG_RX_POWER_AFTER_IQK_B_2);
>> +                               result[t][7] = (val32 >> 16) & 0x3ff;
>> +                               break;
>> +                       } else {
>> +                               result[t][6] = 0x100;
>> +                               result[t][7] = 0x0;
>> +                       }
>> +               }
>> +
>> +               if (!path_b_ok)
>> +                       dev_warn(dev, "%s: Path B IQK failed!\n", __func__);
>> +       }
>> +
>> +       /* Back to BB mode, load original value */
>> +       rtl8xxxu_write32_mask(priv, REG_FPGA0_IQK, 0xffffff00, 0);
>> +
>> +       rtl8xxxu_write32(priv, REG_FPGA0_ANALOG4, 0xcc0000c0);
>> +
>> +       rtl8xxxu_write32(priv, 0xd94, 0x44bbbb44);
>> +       rtl8xxxu_write32(priv, REG_RX_WAIT_CCA, 0x80408040);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TRX_PATH_ENABLE, 0x6f005433);
>> +       rtl8xxxu_write32(priv, REG_OFDM0_TR_MUX_PAR, 0x000004e4);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XCD_RF_SW_CTRL, 0x04003400);
>> +       rtl8xxxu_write32(priv, REG_FPGA0_XA_HSSI_PARM1, 0x01000100);
>> +
>> +       /* Reload ADDA power saving parameters */
>> +       rtl8xxxu_restore_regs(priv, adda_regs, priv->adda_backup,
>> +                             ARRAY_SIZE(adda_regs));
>> +
>> +       /* Reload MAC parameters */
>> +       rtl8xxxu_restore_mac_regs(priv, iqk_mac_regs, priv->mac_backup);
>> +
>> +       /* Reload BB parameters */
>> +       rtl8xxxu_restore_regs(priv, iqk_bb_regs, priv->bb_backup, RTL8XXXU_BB_REGS);
>> +
>> +       rtl8xxxu_write32_clear(priv, REG_FPGA0_XCD_RF_PARM, BIT(31));
>> +
>> +       /* Restore RX initial gain */
>> +       rtl8xxxu_write32_mask(priv, REG_OFDM0_XA_AGC_CORE1, 0xff, 0x50);
>> +       rtl8xxxu_write32_mask(priv, REG_OFDM0_XA_AGC_CORE1, 0xff,
>> +                             rx_initial_gain_a & 0xff);
>> +       if (priv->rf_paths > 1) {
>> +               rtl8xxxu_write32_mask(priv, REG_OFDM0_XB_AGC_CORE1, 0xff, 0x50);
>> +               rtl8xxxu_write32_mask(priv, REG_OFDM0_XB_AGC_CORE1, 0xff,
>> +                                     rx_initial_gain_b & 0xff);
>> +       }
>> +}
>> +
>> +static void rtl8192fu_phy_iq_calibrate(struct rtl8xxxu_priv *priv)
>> +{
>> +       s32 reg_e94, reg_e9c, reg_ea4, reg_eac;
>> +       s32 reg_eb4, reg_ebc, reg_ec4, reg_ecc;
>> +       struct device *dev = &priv->udev->dev;
>> +       u32 path_a_0xdf, path_a_0x35;
>> +       u32 path_b_0xdf, path_b_0x35;
>> +       bool path_a_ok, path_b_ok;
>> +       u8 rfe = priv->rfe_type;
>> +       u32 rfe_path_select;
>> +       int result[4][8]; /* last is final result */
>> +       int i, candidate;
>> +       s32 reg_tmp = 0;
>> +       bool simu;
>> +       u32 val32;
>> +
>> +       rfe_path_select = rtl8xxxu_read32(priv, REG_RFE_PATH_SELECT);
>> +
>> +       path_a_0xdf = rtl8xxxu_read_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF);
>> +       path_a_0x35 = rtl8xxxu_read_rfreg(priv, RF_A, 0x35);
>> +       path_b_0xdf = rtl8xxxu_read_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF);
>> +       path_b_0x35 = rtl8xxxu_read_rfreg(priv, RF_B, 0x35);
>> +
>> +       memset(result, 0, sizeof(result));
>> +       candidate = -1;
>> +
>> +       path_a_ok = false;
>> +       path_b_ok = false;
>> +
>> +       for (i = 0; i < 3; i++) {
>> +               rtl8192fu_phy_iqcalibrate(priv, result, i);
>> +
>> +               if (i == 1) {
>> +                       simu = rtl8xxxu_gen2_simularity_compare(priv, result, 0, 1);
>> +                       if (simu) {
>> +                               candidate = 0;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               if (i == 2) {
>> +                       simu = rtl8xxxu_gen2_simularity_compare(priv, result, 0, 2);
>> +                       if (simu) {
>> +                               candidate = 0;
>> +                               break;
>> +                       }
>> +
>> +                       simu = rtl8xxxu_gen2_simularity_compare(priv, result, 1, 2);
>> +                       if (simu) {
>> +                               candidate = 1;
>> +                       } else {
>> +                               for (i = 0; i < 8; i++)
>> +                                       reg_tmp += result[3][i];
>> +
>> +                               if (reg_tmp)
>> +                                       candidate = 3;
>> +                               else
>> +                                       candidate = -1;
>> +                       }
>> +               }
>> +       }
>> +
>> +       if (candidate >= 0) {
>> +               reg_e94 = result[candidate][0];
>> +               reg_e9c = result[candidate][1];
>> +               reg_ea4 = result[candidate][2];
>> +               reg_eac = result[candidate][3];
>> +               reg_eb4 = result[candidate][4];
>> +               reg_ebc = result[candidate][5];
>> +               reg_ec4 = result[candidate][6];
>> +               reg_ecc = result[candidate][7];
>> +
>> +               dev_dbg(dev, "%s: candidate is %x\n", __func__, candidate);
>> +               dev_dbg(dev, "%s: e94=%x e9c=%x ea4=%x eac=%x eb4=%x ebc=%x ec4=%x ecc=%c\n",
>> +                       __func__, reg_e94, reg_e9c, reg_ea4, reg_eac,
>> +                       reg_eb4, reg_ebc, reg_ec4, reg_ecc);
>> +
>> +               path_a_ok = true;
>> +               path_b_ok = true;
>> +       }
>> +
>> +       rtl8xxxu_write32_mask(priv, REG_TX_IQK_TONE_A, 0x3ff00000, 0x100);
>> +       rtl8xxxu_write32_mask(priv, 0xe20, 0x3ff, 0);
> 
> #define REG_NP_ANTA 0xe20
> 
>> +       rtl8xxxu_write32_mask(priv, REG_TX_IQK_TONE_B, 0x3ff00000, 0x100);
>> +       rtl8xxxu_write32_mask(priv, REG_TAP_UPD_97F, 0x3ff, 0);
>> +
>> +       if (candidate >= 0) {
>> +               if (reg_e94)
>> +                       rtl8xxxu_fill_iqk_matrix_a(priv, path_a_ok, result,
>> +                                                  candidate, (reg_ea4 == 0));
>> +
>> +               if (reg_eb4)
>> +                       rtl8xxxu_fill_iqk_matrix_b(priv, path_b_ok, result,
>> +                                                  candidate, (reg_ec4 == 0));
>> +       }
>> +
>> +       rtl8xxxu_write_rfreg(priv, RF_A, RF6052_REG_UNKNOWN_DF, path_a_0xdf);
>> +       rtl8xxxu_write_rfreg(priv, RF_A, 0x35, path_a_0x35);
>> +       rtl8xxxu_write_rfreg(priv, RF_B, RF6052_REG_UNKNOWN_DF, path_b_0xdf);
>> +       rtl8xxxu_write_rfreg(priv, RF_B, 0x35, path_b_0x35);
>> +
>> +       if (rfe == 7 || rfe == 8 || rfe == 9 || rfe == 12) {
>> +               rtl8xxxu_write32_set(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x70000);
>> +               rtl8xxxu_write32_clear(priv, REG_LEDCFG0, 0x6c00000);
>> +               rtl8xxxu_write32_set(priv, REG_PAD_CTRL1, BIT(29) | BIT(28));
>> +               rtl8xxxu_write32_clear(priv, REG_SW_GPIO_SHARE_CTRL_0,
>> +                                      0x600000 | BIT(4));
>> +
>> +               /*
>> +                * Originally:
>> +                * odm_set_bb_reg(dm, R_0x944, BIT(11) | 0x1F, 0x3F);
>> +                *
>> +                * It clears bit 11 and sets bits 0..4. The mask doesn't cover
>> +                * bit 5 so it's not modified. Is that what it's supposed to
>> +                * accomplish?
>> +                */
>> +               val32 = rtl8xxxu_read32(priv, REG_RFE_BUFFER);
>> +               val32 &= ~BIT(11);
>> +               val32 |= 0x1f;
>> +               rtl8xxxu_write32(priv, REG_RFE_BUFFER, val32);
>> +
>> +               if (rfe == 7) {
>> +                       rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC,
>> +                                             0xfffff, 0x23200);
>> +                       rtl8xxxu_write32_mask(priv, 0x938, 0xfffff, 0x23200);
>> +                       rtl8xxxu_write32_mask(priv, 0x934, 0xf000, 0x3);
>> +                       rtl8xxxu_write32_mask(priv, 0x93c, 0xf000, 0x3);
>> +               } else {
>> +                       rtl8xxxu_write32_mask(priv, REG_RFE_CTRL_ANTA_SRC,
>> +                                             0xfffff, 0x22200);
>> +                       rtl8xxxu_write32_mask(priv, 0x938, 0xfffff, 0x22200);
>> +                       rtl8xxxu_write32_mask(priv, 0x934, 0xf000, 0x2);
> 
> #define REG_RFE_CTRL_ANT_SRC1 0x934
> 
>> +                       rtl8xxxu_write32_mask(priv, 0x93c, 0xf000, 0x2);
>> +               }
>> +
>> +               rtl8xxxu_write32_clear(priv, 0x968, BIT(2));
> 
> #define REG_REF_OPT62 0x968
> >> +
>> +               if (rfe == 7)
>> +                       rtl8xxxu_write32(priv, 0x920, 0x03000003);
> 
> #define REG_REF_OPT 0x920
> 
>> +
>> +               rtl8xxxu_write32(priv, REG_RFE_PATH_SELECT, rfe_path_select);
>> +       }
>> +}
>> +
>> +static void rtl8192fu_disabled_to_emu(struct rtl8xxxu_priv *priv)
>> +{
>> +       rtl8xxxu_write16_clear(priv, REG_APS_FSMCO,
>> +                              APS_FSMCO_HW_POWERDOWN | APS_FSMCO_HW_SUSPEND);
>> +
>> +       rtl8xxxu_write32_clear(priv, REG_GPIO_INTM, BIT(16));
>> +
>> +       rtl8xxxu_write16_clear(priv, REG_APS_FSMCO,
>> +                              APS_FSMCO_PCIE | APS_FSMCO_HW_SUSPEND);
>> +}
>> +
>> +static int rtl8192fu_emu_to_active(struct rtl8xxxu_priv *priv)
>> +{
>> +       u32 val32;
>> +       u16 val16;
>> +       int count;
>> +
>> +       /* enable LDOA12 MACRO block for all interface */
>> +       rtl8xxxu_write8_set(priv, REG_LDOA15_CTRL, LDOA15_ENABLE);
>> +
>> +       /* disable BT_GPS_SEL pins */
>> +       rtl8xxxu_write32_clear(priv, REG_PAD_CTRL1, BIT(28));
>> +
>> +       mdelay(1);
>> +
>> +       /* release analog Ips to digital */
>> +       rtl8xxxu_write8_clear(priv, REG_SYS_ISO_CTRL, SYS_ISO_ANALOG_IPS);
>> +
>> +       val16 = APS_FSMCO_PCIE | APS_FSMCO_HW_SUSPEND | APS_FSMCO_SW_LPS;
>> +       rtl8xxxu_write16_clear(priv, REG_APS_FSMCO, val16);
>> +
>> +       /* wait till 0x04[17] = 1 power ready */
>> +       for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
>> +               val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
>> +               if (val32 & BIT(17))
>> +                       break;
>> +
>> +               udelay(10);
>> +       }
>> +
>> +       if (!count)
>> +               return -EBUSY;
>> +
>> +       rtl8xxxu_write32_set(priv, REG_APS_FSMCO, APS_FSMCO_WLON_RESET);
>> +
>> +       for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
>> +               val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
>> +               if ((val32 & (APS_FSMCO_MAC_ENABLE | APS_FSMCO_MAC_OFF)) == 0)
>> +                       break;
>> +
>> +               udelay(10);
>> +       }
>> +
>> +       if (!count)
>> +               return -EBUSY;
>> +
>> +       /* SWR OCP enable */
>> +       rtl8xxxu_write32_set(priv, REG_AFE_MISC, BIT(18));
>> +
>> +       rtl8xxxu_write16_clear(priv, REG_APS_FSMCO, APS_FSMCO_HW_POWERDOWN);
>> +
>> +       rtl8xxxu_write16_clear(priv, REG_APS_FSMCO,
>> +                              APS_FSMCO_PCIE | APS_FSMCO_HW_SUSPEND);
>> +
>> +       /* 0x7c[31]=1, LDO has max output capability */
>> +       rtl8xxxu_write32_set(priv, REG_LDO_SW_CTRL, BIT(31));
>> +
>> +       rtl8xxxu_write16_set(priv, REG_APS_FSMCO, APS_FSMCO_MAC_ENABLE);
>> +
>> +       for (count = RTL8XXXU_MAX_REG_POLL; count; count--) {
>> +               val32 = rtl8xxxu_read32(priv, REG_APS_FSMCO);
>> +               if ((val32 & APS_FSMCO_MAC_ENABLE) == 0)
>> +                       break;
>> +
>> +               udelay(10);
>> +       }
>> +
>> +       if (!count)
>> +               return -EBUSY;
>> +
>> +       /* Enable WL control XTAL setting */
>> +       rtl8xxxu_write8_set(priv, REG_AFE_MISC, AFE_MISC_WL_XTAL_CTRL);
>> +
>> +       /* Enable falling edge triggering interrupt */
>> +       rtl8xxxu_write16_set(priv, REG_GPIO_INTM, GPIO_INTM_EDGE_TRIG_IRQ);
>> +
>> +       /* Enable GPIO9 data mode */
>> +       rtl8xxxu_write16_clear(priv, REG_GPIO_IO_SEL_2, GPIO_IO_SEL_2_GPIO09_IRQ);
>> +
>> +       /* Enable GPIO9 input mode */
>> +       rtl8xxxu_write16_clear(priv, REG_GPIO_IO_SEL_2, GPIO_IO_SEL_2_GPIO09_INPUT);
>> +
>> +       /* Enable HSISR GPIO[C:0] interrupt */
>> +       rtl8xxxu_write8_set(priv, REG_HSIMR, BIT(0));
>> +
>> +       /* RF HW ON/OFF Enable */
>> +       rtl8xxxu_write8_clear(priv, REG_MULTI_FUNC_CTRL, MULTI_WIFI_HW_ROF_EN);
>> +
>> +       /* Register Lock Disable */
>> +       rtl8xxxu_write8_set(priv, REG_RSV_CTRL, BIT(7));
>> +
>> +       /* For GPIO9 internal pull high setting */
>> +       rtl8xxxu_write16_set(priv, REG_MULTI_FUNC_CTRL, BIT(14));
>> +
>> +       /* reset RF path S1 */
>> +       rtl8xxxu_write8(priv, REG_RF_CTRL, 0);
>> +
>> +       /* reset RF path S0 */
>> +       rtl8xxxu_write8(priv, 0x7b, 0);
> 
> #define REG_AFE_CTRL4 0x78
> 
> use REG_AFE_CTRL4 + 3 for 0x7b
> 
>> +
>> +       /* enable RF path S1 */
>> +       rtl8xxxu_write8(priv, REG_RF_CTRL, RF_SDMRSTB | RF_RSTB | RF_ENABLE);
>> +
>> +       /* enable RF path S0 */
>> +       rtl8xxxu_write8(priv, 0x7b, RF_SDMRSTB | RF_RSTB | RF_ENABLE);
>> +
>> +       /* AFE_Ctrl */
>> +       rtl8xxxu_write8_set(priv, 0x97, BIT(5));
> 
> #define REG_RSVD_1 0x97
> 
>> +
>> +       /* AFE_Ctrl */
>> +       rtl8xxxu_write8(priv, 0xdc, 0xcc);
> 
> #define REG_RSVD_4 0xdc
> 
> The name looks not so meaningful, but designers did give it as is.
> 
>> +
>> +       /* AFE_Ctrl 0x24[4:3]=00 for xtal gmn */
>> +       rtl8xxxu_write8_clear(priv, REG_AFE_XTAL_CTRL, BIT(4) | BIT(3));
>> +
>> +       /* GPIO_A[31:0] Pull down software register */
>> +       rtl8xxxu_write32(priv, 0x1050, 0xffffffff);
> 
> #define REG_GPIO_A0 0x1050
> 
>> +
>> +       /* GPIO_B[7:0] Pull down software register */
>> +       rtl8xxxu_write8(priv, 0x105b, 0xff);
> 
> #define REG_GPIO_B0 0x105b
> 
>> +
>> +       /* Register Lock Enable */
>> +       rtl8xxxu_write8_clear(priv, REG_RSV_CTRL, BIT(7));
>> +
>> +       return 0;
>> +}
>> +
> 
> [...]
> 
>> @@ -2842,10 +2864,14 @@ void rtl8xxxu_fill_iqk_matrix_b(struct rtl8xxxu_priv *priv, bool iqk_ok,
>>
>>         reg = (result[candidate][7] >> 6) & 0xf;
>>
>> -       val32 = rtl8xxxu_read32(priv, REG_OFDM0_AGCR_SSI_TABLE);
>> -       val32 &= ~0x0000f000;
>> -       val32 |= (reg << 12);
>> -       rtl8xxxu_write32(priv, REG_OFDM0_AGCR_SSI_TABLE, val32);
>> +       if (priv->rtl_chip == RTL8192F) {
>> +               val32 = rtl8xxxu_write32_mask(priv, 0xca8, 0x000000f0, reg);
> 
> Setting val32 to return value isn't reasonable. 
> 
> #dfine REG_RXIQB_EXT 0xca8
> 
>> +       } else {
>> +               val32 = rtl8xxxu_read32(priv, REG_OFDM0_AGCR_SSI_TABLE);
>> +               val32 &= ~0x0000f000;
>> +               val32 |= (reg << 12);
>> +               rtl8xxxu_write32(priv, REG_OFDM0_AGCR_SSI_TABLE, val32);
>> +       }
>>  }
>>
> 
> [...]
> 
> I lookup register document for uncertain addresses, but this isn't a simple
> copy-paste thing, so I may mess something. Please tell me if something look weird.

Thank you for the names!

I wonder about these:

#define REG_IQK_RTP_TXA 0xe98
#define REG_IQK_RTP_RXA 0xea8
#define REG_IQK_RTP_TXB 0xeb8
#define REG_IQK_RTP_RXB 0xec8

Should they be REG_IQK_RPT_... for "report"?

And these:

#define REG_REF_OPT62 0x968
#define REG_REF_OPT 0x920

Should they be REG_RFE_... ?

> 
> Ping-Ke
> 

