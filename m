Return-Path: <linux-wireless+bounces-12088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832EA9615F7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0505F1F26277
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D488126F1E;
	Tue, 27 Aug 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcpx0VDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1E64A
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781134; cv=none; b=VEJrXGjEgblSwX4LkKZLJI+vGbdbNDPgR+c3O9VN8dTGzNv6q5m2ezl0M26ETCnXzn8Du+CTn0jktqYUxutE9ARwOQGdIbGPdrgaZBMqaLVIVy+I9aFNvVbLuqnzACSKS8TmsKegPVwEhwzyz5fRVEBPCZRU5KeJTPX9TYiRBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781134; c=relaxed/simple;
	bh=4QMO7DEyVlwsKMafxZeCJ8qyhdfnDoyModcg6p26rYw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Q07tKLS0Gj3ELXnCyDsaXsLb43B8IKpfAjc/ZostPNnbIk1O1beI2S76XMCGQVP/jpVoOBsDyauX5K0eyT2xu8A4V+XN6RpC4wJEWd7i0evr3kIjkgg57QkT6ecHWjd2d7kCEnYTOKAGhoBIMsEVI0b5M+1yBKf73JMpXcD8RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcpx0VDa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso214512366b.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724781130; x=1725385930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYsoyZoQP1D27OMdT7KicV9XFzGuiezGHHNDvT9/LCQ=;
        b=jcpx0VDa4eYx3888xpMXhcifoDV0shE9Hd7eSvB42Swa6QMx4GlAbkQctGAS+7KC6f
         1ExyMUX1nIkm6AKyoeibp/8dJbWeVyRMz63fuKB964N6GcoMHc1TJjVE7hPCq8A5+LNl
         eRw2/8GzZyqwGnNXx43yswwGiOI6nQhBH1nhX08L01lFKZklh6mbYPsqcI3yX2tYOW5Q
         hmdfcW90qvWQnSTwQwOV4NjmHt0ypLpJRQj3nhVlSoxT0/ISPOu+4sLQ/kBl1sRxUld9
         boL+c7QXQ9NXLzq0cGzd3Ns/lEPmzeNL6EBcIJEf8jel3MpUkU+nYaGFGqGOe94BeW8k
         1RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724781130; x=1725385930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYsoyZoQP1D27OMdT7KicV9XFzGuiezGHHNDvT9/LCQ=;
        b=lNEtM4O0+2z4TIbFEGuHt8Xq2Xx6AhzYBo7B1HM9gdKtRvGgvqxcWGhar6gkoMkxtB
         bNY2/8Myi6ekTHpTnpxQScKmeP3FGWMB9c02jwEGb+F3H44Y8s6BnfDXz9nNT7/PCPCN
         yGmbq2GL4fZQvVwqcIRiQ2ptR1GwUDsRKM32C26gm6UBCA5OcFOm4oEdFOHJuDu9+zsX
         4+oAFeif98/qPq2jTywfX3r8DHLG6rV7fN3NxR7qy27Kuxd8tSdAbVlhVhuQtFMPVjMG
         Km92ySMPR8P+S/4KvKA46s6D7sCU4M/FJJtAwdK/7WzZO3WHsTalTa/WJ2zN4tf8aM62
         +huA==
X-Forwarded-Encrypted: i=1; AJvYcCWyrOUwypOP1ge1QOpeVor3lNIssODTqkwRN8rSJEYJHyF3ekvto7XfALlZFXUaTNRuvZgDPwosnCTxk2LT8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKDguCjZQiCta/HpnJA6GQVXm/SlxASO+lj83Pxzc2PGLYLOk
	UvIIwe1rkfivSRvV10Rm7ZVehd7VfwMoLGDZwJrO2DwUtVEz2zLb+ry9xA==
X-Google-Smtp-Source: AGHT+IH5qs59O/HTsT44G18EaM1Yg38sxqGdODr8SKxNy9MRY9vh03KanoA5r5MUt/6sNXf+FV/1/w==
X-Received: by 2002:a05:6402:1ed0:b0:5c0:a8b4:3d92 with SMTP id 4fb4d7f45d1cf-5c0a8b43e12mr7432786a12.27.1724781129543;
        Tue, 27 Aug 2024 10:52:09 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb471bcasm1266858a12.75.2024.08.27.10.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:52:09 -0700 (PDT)
Message-ID: <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
Date: Tue, 27 Aug 2024 20:52:07 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
Content-Language: en-US
In-Reply-To: <e365c61d730d4f49915b543dcb0063d5@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 09:06, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> These contain all the logic for the RTL8821AU and RTL8812AU chips.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/rtw8821a.c | 4139 +++++++++++++++++
>>  drivers/net/wireless/realtek/rtw88/rtw8821a.h |  385 ++
>>  2 files changed, 4524 insertions(+)
>>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
>>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
>>

[...]

>> +static int rtw8821a_power_on(struct rtw_dev *rtwdev)
>> +{
> 
> Will the coming RTL8814AU share this flow? If so, we can move this power on
> to main.c/mac.c as rtw_power_on_v1() or something else. 
> 

RTL8814AU will not use these power on/off functions. I'm hoping
it will work with the rtw_power_on/off functions. Right now I only
got as far as filling rtw8814a_table.c.

> If we decide moving power on flow into chip specific files, the duplicate code
> will become more and more. Please think about this. 
> 
> 
>> +       struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>> +       const struct rtw_chip_info *chip = rtwdev->chip;
>> +       struct rtw_efuse *efuse = &rtwdev->efuse;
>> +       struct rtw_hal *hal = &rtwdev->hal;
>> +       int ret;
>> +
>> +       if (test_bit(RTW_FLAG_POWERON, rtwdev->flags))
>> +               return 0;
>> +
>> +       /* Override rtw_chip_efuse_info_setup() */
>> +       if (chip->id == RTW_CHIP_TYPE_8821A)
>> +               efuse->btcoex = rtw_read32_mask(rtwdev, REG_WL_BT_PWR_CTRL,
>> +                                               BIT_BT_FUNC_EN);
>> +
>> +       /* Override rtw_chip_efuse_info_setup() */
>> +       if (chip->id == RTW_CHIP_TYPE_8812A)
>> +               rtw8812a_read_amplifier_type(rtwdev);
>> +
>> +       ret = rtw_hci_setup(rtwdev);
>> +       if (ret) {
>> +               rtw_err(rtwdev, "failed to setup hci\n");
>> +               goto err;
>> +       }
>> +
>> +       /* Revise for U2/U3 switch we can not update RF-A/B reset.
>> +        * Reset after MAC power on to prevent RF R/W error.
>> +        * Is it a right method?
>> +        */
>> +       if (chip->id == RTW_CHIP_TYPE_8812A) {
>> +               rtw_write8(rtwdev, REG_RF_CTRL, 5);
>> +               rtw_write8(rtwdev, REG_RF_CTRL, 7);
>> +               rtw_write8(rtwdev, REG_RF_B_CTRL, 5);
>> +               rtw_write8(rtwdev, REG_RF_B_CTRL, 7);
>> +       }
>> +
>> +       /* If HW didn't go through a complete de-initial procedure,
>> +        * it probably occurs some problem for double initial
>> +        * procedure.
>> +        */
>> +       rtw8812au_hw_reset(rtwdev);
>> +
>> +       ret = rtw8812au_init_power_on(rtwdev);
>> +       if (ret) {
>> +               rtw_err(rtwdev, "failed to power on\n");
>> +               goto err;
>> +       }
>> +
>> +       ret = rtw_set_trx_fifo_info(rtwdev);
>> +       if (ret) {
>> +               rtw_err(rtwdev, "failed to set trx fifo info\n");
>> +               goto err;
>> +       }
>> +
>> +       ret = rtw8821a_llt_init(rtwdev, rtwdev->fifo.rsvd_boundary);
>> +       if (ret) {
>> +               rtw_err(rtwdev, "failed to init llt\n");
>> +               goto err;
>> +       }
>> +
>> +       rtw_write32_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
>> +
>> +       ret = rtw_wait_firmware_completion(rtwdev);
>> +       if (ret) {
>> +               rtw_err(rtwdev, "failed to wait firmware completion\n");
>> +               goto err_off;
>> +       }
>> +
>> +       ret = rtw_download_firmware(rtwdev, &rtwdev->fw);
>> +       if (ret) {
>> +               rtw_err(rtwdev, "failed to download firmware\n");
>> +               goto err_off;
>> +       }
>> +
>> +       rtw_write8(rtwdev, REG_HMETFR, 0xf);
>> +
>> +       rtw_load_table(rtwdev, chip->mac_tbl);
>> +
>> +       rtw8821au_init_queue_reserved_page(rtwdev);
>> +       rtw8821au_init_tx_buffer_boundary(rtwdev);
>> +       rtw8821au_init_queue_priority(rtwdev);
>> +
> 
> Seemingly above flow looks common. Can it share with other chips?
> 

I don't know if any other chips can use this.

> [...]
> 
>> +}
>> +
>> +static u32 rtw8821a_phy_read_rf(struct rtw_dev *rtwdev,
>> +                               enum rtw_rf_path rf_path, u32 addr, u32 mask)
>> +{
> 
> read/write RF functions are also common for chips. Can it share with coming RTL8814A?
> Move this to phy.c as v1?
> 

No, RTL8814A will use rtw_phy_read_rf(), like RTL8822B.

>> +       static const u32 pi_addr[2] = { 0xc00, 0xe00 };
>> +       static const u32 read_addr[2][2] = {
>> +               { REG_SI_READ_A, REG_SI_READ_B },
>> +               { REG_PI_READ_A, REG_PI_READ_B }
>> +       };
> 
> [...]
> 
>> +
>> +static void rtw8821a_query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
>> +                                     struct rtw_rx_pkt_stat *pkt_stat)
>> +{
>> +       struct rtw_dm_info *dm_info = &rtwdev->dm_info;
>> +       struct rtw8821a_phy_status_rpt *phy_sts;
>> +       u8 lna_idx, vga_idx, cck_agc_rpt;
>> +       s8 rx_pwr_db, power_a, power_b;
>> +       const s8 min_rx_power = -120;
>> +       u8 rssi, val, i;
>> +
>> +       phy_sts = (struct rtw8821a_phy_status_rpt *)phy_status;
>> +
>> +       if (pkt_stat->rate <= DESC_RATE11M) {
>> +               cck_agc_rpt = phy_sts->cfosho[0];
>> +               lna_idx = (cck_agc_rpt & 0xE0) >> 5;
>> +               vga_idx = cck_agc_rpt & 0x1F;
> 
> If we remove "#ifdef __LITTLE_ENDIAN" from rtw8821a_phy_status_rpt and define
> bit mask there, additionally define these bit masks and then use u8_get_bits().
>
> By the way, shouldn't the field of 'cfosho[2]' be 'u8' instead of 's8'?
> 

Those bytes mean different things for CCK and for OFDM. I suppose
they need to be s8 for "short CFO" (OFDM) but u8 for "CCK AGC report".
They are s8 in the official driver.

>> +
>> +               if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
>> +                       rx_pwr_db = rtw8821a_cck_rx_pwr(rtwdev, lna_idx, vga_idx);
>> +               else
>> +                       rx_pwr_db = rtw8812a_cck_rx_pwr(rtwdev, lna_idx, vga_idx);
>> +
>> +               pkt_stat->rx_power[RF_PATH_A] = rx_pwr_db;
>> +               pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
>> +               dm_info->rssi[RF_PATH_A] = pkt_stat->rssi;
>> +               pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
>> +               pkt_stat->signal_power = rx_pwr_db;
>> +
>> +               if (rtwdev->chip->id == RTW_CHIP_TYPE_8812A &&
>> +                   !rtwdev->hal.cck_high_power) {
>> +                       if (pkt_stat->rssi >= 80)
>> +                               pkt_stat->rssi = ((pkt_stat->rssi - 80) << 1) +
>> +                                                ((pkt_stat->rssi - 80) >> 1) + 80;
>> +                       else if (pkt_stat->rssi <= 78 && pkt_stat->rssi >= 20)
>> +                               pkt_stat->rssi += 3;
>> +               }
>> +       } else { /* OFDM rate */
>> +               for (i = RF_PATH_A; i < rtwdev->hal.rf_path_num; i++) {
>> +                       val = phy_sts->gain_trsw[i];
>> +                       pkt_stat->rx_power[i] = (val & 0x7F) - 110;
>> +                       rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[i], 1);
>> +                       dm_info->rssi[i] = rssi;
>> +               }
>> +
>> +               pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power,
>> +                                                        rtwdev->hal.rf_path_num);
>> +
>> +               power_a = pkt_stat->rx_power[RF_PATH_A];
>> +               power_b = pkt_stat->rx_power[RF_PATH_B];
>> +               if (rtwdev->hal.rf_path_num == 1)
>> +                       power_b = power_a;
>> +
>> +               pkt_stat->signal_power = max3(power_a, power_b, min_rx_power);
>> +       }
>> +}
>> +
>> +static void rtw8821a_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
>> +                                  struct rtw_rx_pkt_stat *pkt_stat,
>> +                                  struct ieee80211_rx_status *rx_status)
>> +{
>> +       u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
>> +       struct ieee80211_hdr *hdr;
>> +       u8 *phy_status = NULL;
>> +
>> +       memset(pkt_stat, 0, sizeof(*pkt_stat));
>> +
>> +       pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
>> +       pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
>> +       pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
>> +       pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
>> +                             GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
>> +       pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
>> +       pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
>> +       pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
>> +       pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
>> +       pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
>> +       pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
>> +       pkt_stat->ppdu_cnt = 0;
>> +       pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
>> +       pkt_stat->bw = GET_RX_DESC_BW(rx_desc);
> 
> More and more chips use these macros. Please add a patch using struct to 
> access these fields. More, query_rx_desc() are very similar across chips,
> please move them to mac.c or phy.c as a common function.
> 

Why not rx.c?

>> +
>> +       /* drv_info_sz is in unit of 8-bytes */
>> +       pkt_stat->drv_info_sz *= 8;
>> +
>> +       /* c2h cmd pkt's rx/phy status is not interested */
>> +       if (pkt_stat->is_c2h)
>> +               return;
>> +
>> +       hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
>> +                                      pkt_stat->drv_info_sz);
>> +       if (pkt_stat->phy_status) {
>> +               phy_status = rx_desc + desc_sz + pkt_stat->shift;
>> +               rtw8821a_query_phy_status(rtwdev, phy_status, pkt_stat);
>> +       }
>> +
>> +       rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
>> +}
>> +

[...]

>> +static void rtw8821a_iqk_tx_vdf_true(struct rtw_dev *rtwdev, u32 cal,
>> +                                    bool *tx0iqkok,
>> +                                    int tx_x0[CAL_NUM_8821A],
>> +                                    int tx_y0[CAL_NUM_8821A])
>> +{
>> +       u32 cal_retry, delay_count, iqk_ready, tx_fail;
>> +       int tx_dt[3], vdf_y[3], vdf_x[3];
>> +       int k;
>> +
>> +       for (k = 0; k <= 2; k++) {
> 
> '< 3' would be more intuitive, because 'k' is index of array.
> 
>> +               switch (k) {
>> +               case 0:
>> +                       /* TX_Tone_idx[9:0], TxK_Mask[29] TX_Tone = 16 */
>> +                       rtw_write32(rtwdev, 0xc80, 0x18008c38);
>> +                       /* RX_Tone_idx[9:0], RxK_Mask[29] */
>> +                       rtw_write32(rtwdev, 0xc84, 0x38008c38);
>> +                       rtw_write32_mask(rtwdev, 0xce8, BIT(31), 0x0);
>> +                       break;
>> +               case 1:
>> +                       rtw_write32_mask(rtwdev, 0xc80, BIT(28), 0x0);
>> +                       rtw_write32_mask(rtwdev, 0xc84, BIT(28), 0x0);
>> +                       rtw_write32_mask(rtwdev, 0xce8, BIT(31), 0x0);
>> +                       break;
>> +               case 2:
>> +                       rtw_dbg(rtwdev, RTW_DBG_RFK,
>> +                               "vdf_y[1] = %x vdf_y[0] = %x\n",
>> +                               vdf_y[1] >> 21 & 0x00007ff,
>> +                               vdf_y[0] >> 21 & 0x00007ff);
>> +
>> +                       rtw_dbg(rtwdev, RTW_DBG_RFK,
>> +                               "vdf_x[1] = %x vdf_x[0] = %x\n",
>> +                               vdf_x[1] >> 21 & 0x00007ff,
>> +                               vdf_x[0] >> 21 & 0x00007ff);
>> +
>> +                       tx_dt[cal] = (vdf_y[1] >> 20) - (vdf_y[0] >> 20);
>> +                       tx_dt[cal] = (16 * tx_dt[cal]) * 10000 / 15708;
>> +                       tx_dt[cal] = (tx_dt[cal] >> 1) + (tx_dt[cal] & BIT(0));
>> +
>> +                       /* TX_Tone_idx[9:0], TxK_Mask[29] TX_Tone = 16 */
>> +                       rtw_write32(rtwdev, 0xc80, 0x18008c20);
>> +                       /* RX_Tone_idx[9:0], RxK_Mask[29] */
>> +                       rtw_write32(rtwdev, 0xc84, 0x38008c20);
>> +                       rtw_write32_mask(rtwdev, 0xce8, BIT(31), 0x1);
>> +                       rtw_write32_mask(rtwdev, 0xce8, 0x3fff0000,
>> +                                        tx_dt[cal] & 0x00003fff);
>> +                       break;
>> +               }
>> +
>> +               rtw_write32(rtwdev, REG_RFECTL_A, 0x00100000);
>> +               cal_retry = 0;
>> +               while (1) {
> 
> Can we replace 'while()' by 'for (cal_retry = 0; cal_retry < 10; cal_retry++)'?
> 

I think so.

>> +                       /* one shot */
>> +                       rtw_write32(rtwdev, 0x980, 0xfa000000);
>> +                       rtw_write32(rtwdev, 0x980, 0xf8000000);
>> +
>> +                       mdelay(10);
>> +
>> +                       rtw_write32(rtwdev, REG_RFECTL_A, 0x00000000);
>> +
>> +                       delay_count = 0;
>> +                       while (1) {
> 

[...]

>> +               if (delay_count < 20) { /* If 20ms No Result, then cal_retry++ */
>> +                       /* ============TXIQK Check============== */
>> +                       tx0_fail = rtw_read32_mask(rtwdev, 0xd00, BIT(12));
>> +                       tx1_fail = rtw_read32_mask(rtwdev, 0xd40, BIT(12));
> 
> Can you collect undefined register addresses? I can try to lookup them in one go. 
> 

Here are the addresses I could find and a few bits/bit masks:

0x765
0x90c
0x978
        31, 0x03ff8000, 0x000007ff
0x97c
        31
0x980
0x984
0xa0a
0xc00
        0xf
0xc5c
        GENMASK(26, 24)
0xce8
        31, 0x3fff0000
0xd00
        10, 11, 12, 0x07ff0000
0xd40
        10, 11, 12
0xe00
0xe5c
        GENMASK(26, 24)
0xe80
0xe84
0xe88
0xe8c
0xe90
        7
0xe94
        0
0xec4
        18, 29
0xec8
        29
0xecc
0xed4
0xee8
0xf008
        3, 4
0xf050

And some RF registers: 0x8, 0x58, 0x65, 0x8f

[...]

>> +
>> +const struct rtw_chip_info rtw8812a_hw_spec = {
> 
> Is it possible moving 8812a to individual file?
> Since you have rtw8812au.c and rtw8821au.c. 
> 

I think it is possible. But most of the code is common to both chips.
Only the IQ calibration could be moved.

Another possibility is to move rtw8812au.c into rtw8821au.c and have
only one module handle both chips.

>> +       .ops = &rtw8821a_ops,
>> +       .id = RTW_CHIP_TYPE_8812A,
>> +       .fw_name = "rtw88/rtw8812a_fw.bin",
>> +       .wlan_cpu = RTW_WCPU_11N,
>> +       .tx_pkt_desc_sz = 40,
>> +       .tx_buf_desc_sz = 16,
>> +       .rx_pkt_desc_sz = 24,
>> +       .rx_buf_desc_sz = 8,
>> +       .phy_efuse_size = 512,
>> +       .log_efuse_size = 512,
>> +       .ptct_efuse_size = 96 + 1, /* TODO or just 18? */
>> +       .txff_size = 131072,
>> +       .rxff_size = 16128,
>> +       .rsvd_drv_pg_num = 9,
>> +       .txgi_factor = 1,
>> +       .is_pwr_by_rate_dec = true,
>> +       .max_power_index = 0x3f,
>> +       .csi_buf_pg_num = 0,
>> +       .band = RTW_BAND_2G | RTW_BAND_5G,
>> +       .page_size = 512,
>> +       .dig_min = 0x20,
>> +       .ht_supported = true,
>> +       .vht_supported = true,
>> +       .lps_deep_mode_supported = 0,
>> +       .sys_func_en = 0xFD,
>> +       .pwr_on_seq = card_enable_flow_8812a,
>> +       .pwr_off_seq = card_disable_flow_8812a,
>> +       .page_table = page_table_8812a,
>> +       .rqpn_table = rqpn_table_8821a,
>> +       .prioq_addrs = &prioq_addrs_8821a,
>> +       .intf_table = &phy_para_table_8821a,
>> +       .dig = rtw8821a_dig,
>> +       .rf_sipi_addr = {REG_LSSI_WRITE_A, REG_LSSI_WRITE_B},
>> +       .ltecoex_addr = NULL,
>> +       .mac_tbl = &rtw8812a_mac_tbl,
>> +       .agc_tbl = &rtw8812a_agc_tbl,
>> +       .bb_tbl = &rtw8812a_bb_tbl,
>> +       .rf_tbl = {&rtw8812a_rf_a_tbl, &rtw8812a_rf_b_tbl},
>> +       .rfe_defs = rtw8812a_rfe_defs,
>> +       .rfe_defs_size = ARRAY_SIZE(rtw8812a_rfe_defs),
>> +       .rx_ldpc = false,
>> +       .hw_feature_report = false,
>> +       .c2h_ra_report_size = 4,
>> +       .old_datarate_fb_limit = true,
>> +       .usb_tx_agg_desc_num = 1,
>> +       .iqk_threshold = 8,
>> +       .ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
>> +       .max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
>> +
>> +       .coex_para_ver = 0, /* no coex code in 8812au driver */
>> +       .bt_desired_ver = 0,
>> +       .scbd_support = false,
>> +       .new_scbd10_def = false,
>> +       .ble_hid_profile_support = false,
>> +       .wl_mimo_ps_support = false,
>> +       .pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
>> +       .bt_rssi_type = COEX_BTRSSI_RATIO,
>> +       .ant_isolation = 15,
>> +       .rssi_tolerance = 2,
>> +       .wl_rssi_step = wl_rssi_step_8821a,
>> +       .bt_rssi_step = bt_rssi_step_8821a,
>> +       .table_sant_num = 0,
>> +       .table_sant = NULL,
>> +       .table_nsant_num = 0,
>> +       .table_nsant = NULL,
>> +       .tdma_sant_num = 0,
>> +       .tdma_sant = NULL,
>> +       .tdma_nsant_num = 0,
>> +       .tdma_nsant = NULL,
>> +       .wl_rf_para_num = ARRAY_SIZE(rf_para_tx_8821a),
>> +       .wl_rf_para_tx = rf_para_tx_8821a,
>> +       .wl_rf_para_rx = rf_para_rx_8821a,
>> +       .bt_afh_span_bw20 = 0x20,
>> +       .bt_afh_span_bw40 = 0x30,
>> +       .afh_5g_num = 0,
>> +       .afh_5g = NULL,
>> +
>> +       .coex_info_hw_regs_num = 0,
>> +       .coex_info_hw_regs = NULL,
>> +};
>> +EXPORT_SYMBOL(rtw8812a_hw_spec);
>> +
>> +MODULE_FIRMWARE("rtw88/rtw8821a_fw.bin");
>> +MODULE_FIRMWARE("rtw88/rtw8812a_fw.bin");
>> +
>> +MODULE_AUTHOR("Realtek Corporation");
>> +MODULE_DESCRIPTION("Realtek 802.11ac wireless 8821a/8811a/8812a driver");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.h
>> b/drivers/net/wireless/realtek/rtw88/rtw8821a.h
>> new file mode 100644
>> index 000000000000..7f1c2d2eb6d2
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.h
>> @@ -0,0 +1,385 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>> +/* Copyright(c) 2018-2019  Realtek Corporation
> 
> Year 2024
> 
>> + */
>> +
>> +#ifndef __RTW8821A_H__
>> +#define __RTW8821A_H__
>> +
>> +#include <asm/byteorder.h>
>> +
>> +struct rtw8821au_efuse {
>> +       u8 res4[48];                    /* 0xd0 */
>> +       u8 vid[2];                      /* 0x100 */
>> +       u8 pid[2];
>> +       u8 res8[3];
>> +       u8 mac_addr[ETH_ALEN];          /* 0x107 */
>> +       u8 res9[243];
>> +};
> 
> __packed
> 
>> +
>> +struct rtw8812au_efuse {
>> +       u8 vid[2];                      /* 0xd0 */
>> +       u8 pid[2];                      /* 0xd2 */
>> +       u8 res0[3];
>> +       u8 mac_addr[ETH_ALEN];          /* 0xd7 */
>> +       u8 res1[291];
>> +};
> 
> __packed
> 
> [...]
> 
>> +#define WLAN_SIFS_CFG  (WLAN_SIFS_CCK_CONT_TX | \
>> +                       (WLAN_SIFS_OFDM_CONT_TX << BIT_SHIFT_SIFS_OFDM_CTX) | \
>> +                       (WLAN_SIFS_CCK_TRX << BIT_SHIFT_SIFS_CCK_TRX) | \
>> +                       (WLAN_SIFS_OFDM_TRX << BIT_SHIFT_SIFS_OFDM_TRX))
> 
> BIT_SHIFT_SIFS_OFDM_CTX is defined in reg.h, so this header file should
> include reg.h. Because every header file should be included independently. 
> 
>> +
>> +#define WLAN_TBTT_TIME (WLAN_TBTT_PROHIBIT |\
>> +                       (WLAN_TBTT_HOLD_TIME << BIT_SHIFT_TBTT_HOLD_TIME_AP))
>> +
>> +#define WLAN_NAV_CFG           (WLAN_RDG_NAV | (WLAN_TXOP_NAV << 16))
>> +#define WLAN_RX_TSF_CFG                (WLAN_CCK_RX_TSF | (WLAN_OFDM_RX_TSF) << 8)
>> +#define WLAN_PRE_TXCNT_TIME_TH                 0x1E4
>> +
>> +struct rtw8821a_phy_status_rpt {
>> +       /* DWORD 0 */
>> +       u8 gain_trsw[2]; /* path-A and path-B { TRSW, gain[6:0] } */
>> +       u8 chl_num_lsb; /* channel number[7:0] */
>> +#ifdef __LITTLE_ENDIAN
>> +       u8 chl_num_msb:2; /* channel number[9:8] */
>> +       u8 sub_chnl:4; /* sub-channel location[3:0] */
>> +       u8 r_rfmod:2; /* RF mode[1:0] */
>> +#else
>> +       u8 r_rfmod:2;
>> +       u8 sub_chnl:4;
>> +       u8 chl_num_msb:2;
>> +#endif
> 
> Not prefer "#ifdef __LITTLE_ENDIAN" style, because we have never verified
> big endian part. Prefer to define mask and access them via u8_get_bits() and
> its friends.
> 

None of the members inside #ifdef __LITLLE_ENDIAN are used
in this driver. Do I still have to define all the masks?

> 
>> +
>> +       /* DWORD 1 */
>> +       u8 pwdb_all; /* CCK signal quality / OFDM pwdb all */
>> +       s8 cfosho[2]; /* CCK AGC report and CCK_BB_Power */
>> +                     /* OFDM path-A and path-B short CFO */
>> +#ifdef __LITTLE_ENDIAN
>> +       u8 resvd_0:6;
>> +       u8 bt_rf_ch_msb:2; /* 8812A: 2'b0 8814A: bt rf channel keep[7:6] */
> 
> Will you share this struct with 8814A? If not please remove comments related to 8814A.
> 

Yes, it uses the same struct.

>> +#else
>> +       u8 bt_rf_ch_msb:2;
>> +       u8 resvd_0:6;
>> +#endif
> 
> [...]
> 
> 
>> +
>> +#define REG_SYS_CTRL                           0x000
>> +#define BIT_FEN_EN                             BIT(26)
>> +#define REG_APS_FSMCO                          0x04
>> +#define  APS_FSMCO_MAC_ENABLE                  BIT(8)
>> +#define  APS_FSMCO_MAC_OFF                     BIT(9)
>> +#define  APS_FSMCO_HW_POWERDOWN                        BIT(15)
>> +#define REG_ACLK_MON                           0x3e
>> +#define REG_RF_B_CTRL                          0x76
>> +#define REG_HIMR0                              0xb0
>> +#define REG_HISR0                              0xb4
>> +#define REG_HIMR1                              0xb8
>> +#define REG_HISR1                              0xbc
> 
> [...]
> 
> Can't we move all of these registers (including what I delete) into reg.h?
> 

I think so.

