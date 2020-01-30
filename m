Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842D814D6A0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 07:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA3GiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 01:38:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38811 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgA3GiQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 01:38:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so2129505oth.5
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 22:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nik2OjSznrKVRxuOJvZTFJvTIBWa7SKXUYQr+GdNIxs=;
        b=gYSJlStrsjK4ZcVkypxHfs7Yra7JgSN/MSvYG5/zb2NIlt8FbRtLqmFpWMfmmSR2SR
         VTbtP/BdrOrFOh5jYS+i9gD1KoyXsEFht/nq3Ijamg4DLLRXq1Zy47Edf7M1bZdWPEAF
         tjJPwvJzDcAox9qoVS8bTE7dDN4SxcCxL4IKOV3CBDp0p1b3aI3YRzlUtZIszly/BBpy
         FVd6gewO+fKGJvIdt+J2cu43Jm56QlsokarPtQPoDuc4LsAN/B1yVXnGeGk+hrEHx9WB
         lVoHT4Gqz9mqBjDEanjcB6aVeafvPBVMpFRkJi/w5VHXAKN5Pggrxq8307w/vrRIlX1z
         LaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nik2OjSznrKVRxuOJvZTFJvTIBWa7SKXUYQr+GdNIxs=;
        b=U/iuB2AD668nDScOXsO8dVii6GUDppU7Gcni8FaKPoPdIA8U3nd+kl/Y1Tp9wXJoYt
         WrjRUznyqwop7ojPLpLLD/a/wLS2YYm3oszq23ziQHWm6ENJ7WJI8I/ldOBtjEB0fPQ3
         98/3Ahio0djBQNFPmbBhatawb6vQhRwynwT3tOeXyx3ZDahEneJLvolqe5C8TQxdEN2k
         2QwKAr5paOhlL244FN70ZkS/6/F9jWYJsVrnsWTU9WGM+L0iEF3b/PxLnkmLB0gKiiWf
         NF4cx7gPab+veSN+XJJSA6IAsg7XUIdR4D6+OBEX91Gwns92mEkDAZYp1VwVSczLyYx0
         n9HA==
X-Gm-Message-State: APjAAAU8CkMaoeofDriSyJWEId79bWw9yTOAZ7vsPuHXmqZld/Dz/AXw
        EX1btFHkOn8DOIvynBtlwP4bJlgh2t2xc9OKN6xmdA==
X-Google-Smtp-Source: APXvYqzVqvYcRWPprjhwydhJqhDBXJF4leSrbkwngiZjfv5+kjE0N/QTJ3145YLJPuJio+ntRCs4OtwXlgGZhIiPH7Q=
X-Received: by 2002:a05:6830:1218:: with SMTP id r24mr2508840otp.144.1580366293794;
 Wed, 29 Jan 2020 22:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20200130053112.28162-1-yhchuang@realtek.com> <20200130053112.28162-3-yhchuang@realtek.com>
In-Reply-To: <20200130053112.28162-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 30 Jan 2020 14:38:02 +0800
Message-ID: <CAB4CAwfNn=cZdy9kXtv0=B0O2QF0Tb3iT3bKN46KQqnw8qA18Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtw88: 8822c: modify rf protection setting
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jan 30, 2020 at 1:31 PM <yhchuang@realtek.com> wrote:
>
> From: Chien-Hsun Liao <ben.liao@realtek.com>
>
> According to some experiments, the original RF register protection
> setting of 8822c cannot perfectly make sure that there is no hardware
> PI write (direct) during direct write. Modify the setting so that the
> hardware block of PI would be turned off via rtw8822c_rstb_3wire()
> during the direct write, to avoid RF register racing.
>
> Note that 8822b uses SIPI write (indirect), so 8822b does not
> have such problem.
>
> Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>
>
> v1 -> v2
>  * Add more descriptions
>
>  drivers/net/wireless/realtek/rtw88/phy.c      | 10 ----------
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 15 +++++++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.h |  5 +++++
>  3 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
> index eea9d888fbf1..8793dd22188f 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -749,20 +749,10 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
>         direct_addr = base_addr[rf_path] + (addr << 2);
>         mask &= RFREG_MASK;
>
> -       if (addr == RF_CFGCH) {
> -               rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, DISABLE_PI);
> -               rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, DISABLE_PI);
> -       }
> -
>         rtw_write32_mask(rtwdev, direct_addr, mask, data);
>
>         udelay(1);
>
> -       if (addr == RF_CFGCH) {
> -               rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, ENABLE_PI);
> -               rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, ENABLE_PI);
> -       }
> -
>         return true;
>  }
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index 4c416d603b33..fb621881fbd1 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -1289,6 +1289,17 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
>         return 0;
>  }
>
> +static void rtw8822c_rstb_3wire(struct rtw_dev *rtwdev, bool enable)
> +{
> +       if (enable) {
> +               rtw_write32_mask(rtwdev, REG_RSTB, BIT_RSTB_3WIRE, 0x1);
> +               rtw_write32_mask(rtwdev, REG_ANAPAR_A, BIT_ANAPAR_UPDATE, 0x1);
> +               rtw_write32_mask(rtwdev, REG_ANAPAR_B, BIT_ANAPAR_UPDATE, 0x1);
> +       } else {
> +               rtw_write32_mask(rtwdev, REG_RSTB, BIT_RSTB_3WIRE, 0x0);
> +       }
> +}
> +
>  static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
>  {
>  #define RF18_BAND_MASK         (BIT(16) | BIT(9) | BIT(8))
> @@ -1337,6 +1348,8 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
>                 break;
>         }
>
> +       rtw8822c_rstb_3wire(rtwdev, false);
> +
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, 0x04, 0x01);
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, 0x1f, 0x12);
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, 0xfffff, rf_rxbb);
> @@ -1349,6 +1362,8 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
>
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, rf_reg18);
>         rtw_write_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK, rf_reg18);
> +
> +       rtw8822c_rstb_3wire(rtwdev, true);
>  }
>
>  static void rtw8822c_toggle_igi(struct rtw_dev *rtwdev)
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
> index abd9f300bedd..dfd8662a0c0e 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
> @@ -190,6 +190,8 @@ const struct rtw_table name ## _tbl = {                     \
>  #define BIT_3WIRE_TX_EN                BIT(0)
>  #define BIT_3WIRE_RX_EN                BIT(1)
>  #define BIT_3WIRE_PI_ON                BIT(28)
> +#define REG_ANAPAR_A   0x1830
> +#define BIT_ANAPAR_UPDATE      BIT(29)
>  #define REG_RXAGCCTL0  0x18ac
>  #define BITS_RXAGC_CCK         GENMASK(15, 12)
>  #define BITS_RXAGC_OFDM                GENMASK(8, 4)
> @@ -223,6 +225,8 @@ const struct rtw_table name ## _tbl = {                     \
>  #define BIT_CCK_BLK_EN         BIT(1)
>  #define BIT_CCK_OFDM_BLK_EN    (BIT(0) | BIT(1))
>  #define REG_CCAMSK     0x1c80
> +#define REG_RSTB       0x1c90
> +#define BIT_RSTB_3WIRE         BIT(8)
>  #define REG_RX_BREAK   0x1d2c
>  #define BIT_COM_RX_GCK_EN      BIT(31)
>  #define REG_RXFNCTL    0x1d30
> @@ -243,6 +247,7 @@ const struct rtw_table name ## _tbl = {                     \
>  #define REG_OFDM_TXCNT 0x2de0
>  #define REG_ORITXCODE2 0x4100
>  #define REG_3WIRE2     0x410c
> +#define REG_ANAPAR_B   0x4130
>  #define REG_RXAGCCTL   0x41ac
>  #define REG_DCKB_I_0   0x41bc
>  #define REG_DCKB_I_1   0x41c0
> --
> 2.17.1
>
