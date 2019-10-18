Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392E9DBDFB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409550AbfJRHCe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 03:02:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38462 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfJRHCe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 03:02:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so7674253qta.5
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KsSLgRJmUZhLeDsO9zE0FQ0xWgEhUiiwV2u0di5PoM=;
        b=ZNlJQz61Mw38cg475LWjZLK516n/Pfe8ejUK/ezOh4rAve494mHGw+wjaf5LoOxoo2
         PFNzTUU2oAGNRabimovAQwVERvrIqVzTpwRtqEPzKrzCDD9Dd1cM5IgJ5olsjUB/0utu
         bGZR5msltOxufA+fouUQ7fJPd8gNthr/+t+sCe6TH0OXdEikHUCNodr8KX8GG3YtT6Mi
         WyZpCpNsYxp2SwT3bfCe7a5OrWuEceKzLVesJ47fM3EkCEX8aNlEFW86har0u6gdiRHT
         qSDilg2kFXQItmW8p8ngAqKuyH8w4y19+hRFtd44zTUES41JL03/woXWmH3HwCb8Ftmc
         +KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KsSLgRJmUZhLeDsO9zE0FQ0xWgEhUiiwV2u0di5PoM=;
        b=nAdrfnuB4pPR9vEwkl6Ur82vFgONjajx9He0TKgEZYp0hwbdCPxJ8CwA9zG2XutjDZ
         39MaxUt11r76bd/Fp2Jgt+zfooNMeI/rtrRgNUFzh6+r2aBBq+3jpxXC4/8LMESxPU69
         d/Kb8jsffIfMUrvZxA+L4EKWRELSzjwYcJOU7sfXtI1RDFh0/WJAOby6ZVQGtqX7hA+o
         +rKZMCmYKkFlgBkD7ijRj0Uc71l6UajnEdo94ai9SaKr293/vS8JUzM7RpqwbKIXFjRP
         qodMAoH01DNuOW0O1x794GWZRazhDizZoXISLSnpVI54iygWEixBTk04xX+YmUQtV5aS
         OS5w==
X-Gm-Message-State: APjAAAWNe/dmFr+/g9oTl1LLF83XSpPgW1Wex4smukcmtPczYtn8xLVS
        d/1GSziGt9A/cIAnLGH/CEQuyX0qIOqevX3GeHB9yA==
X-Google-Smtp-Source: APXvYqy1dMZvXnleYPmJypInZMQ59h6Z5V6w4LYAlUj1YqBHM5rqaD4iV6wDr9nBq0mYOAUvknU08V9nQP01Y2WmA+8=
X-Received: by 2002:a0c:b929:: with SMTP id u41mr8202501qvf.37.1571382151467;
 Fri, 18 Oct 2019 00:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-7-yhchuang@realtek.com>
In-Reply-To: <20191016123301.2649-7-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 18 Oct 2019 15:02:20 +0800
Message-ID: <CAB4CAwenD-=cHs7QZWaePE0LjYYtyi96dwgz3xCpQT+HLpr3yQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] rtw88: add phy_info debugfs to show Tx/Rx physical status
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 8:33 PM <yhchuang@realtek.com> wrote:
>
> From: Tsang-Shian Lin <thlin@realtek.com>
>
> This commit adds several Tx/Rx physical information to phy_info
> debugfs for 8822B/8822C. By this debugfs, we can know physical
> information, such as Tx/Rx rate, RSSI, EVM,SNR, etc. The
> information is gotten from the packets of Tx/Rx path. It has
> no impact for the performance of 8822B/8822C.
>
> In the fields, we may meet different kinds of problems, but
> we may have no professional instrument to check them. At
> this moment, this debugfs is a good tool, and it may provide
> useful information for debug.
>
> Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>
> v1 -> v2
>   * No change
>
> @@ -528,10 +556,16 @@ struct rtw_rx_pkt_stat {
>         s8 rx_power[RTW_RF_PATH_MAX];
>         u8 rssi;
>         u8 rxsc;
> +       s8 rx_snr[RTW_RF_PATH_MAX];
> +       u8 rx_evm[RTW_RF_PATH_MAX];
> +       s8 cfo_tail[RTW_RF_PATH_MAX];
> +
>         struct rtw_sta_info *si;
>         struct ieee80211_vif *vif;
>  };
>
> +DECLARE_EWMA(tp, 10, 2);
> +
>  struct rtw_traffic_stats {
>         /* units in bytes */
>         u64 tx_unicast;
> @@ -853,6 +860,34 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
>         pkt_stat->signal_power = max3(pkt_stat->rx_power[RF_PATH_A],
>                                       pkt_stat->rx_power[RF_PATH_B],
>                                       min_rx_power);
> +
> +       dm_info->curr_rx_rate = pkt_stat->rate;
> +
> +       pkt_stat->rx_evm[RF_PATH_A] = GET_PHY_STAT_P1_RXEVM_A(phy_status);
> +       pkt_stat->rx_evm[RF_PATH_B] = GET_PHY_STAT_P1_RXEVM_B(phy_status);
> +
> +       pkt_stat->rx_snr[RF_PATH_A] = GET_PHY_STAT_P1_RXSNR_A(phy_status);
> +       pkt_stat->rx_snr[RF_PATH_B] = GET_PHY_STAT_P1_RXSNR_B(phy_status);
> +
> +       pkt_stat->cfo_tail[RF_PATH_A] = GET_PHY_STAT_P1_CFO_TAIL_A(phy_status);
> +       pkt_stat->cfo_tail[RF_PATH_B] = GET_PHY_STAT_P1_CFO_TAIL_B(phy_status);
> +
> +       for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
> +               rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
> +               dm_info->rssi[path] = rssi;
> +               dm_info->rx_snr[path] = pkt_stat->rx_snr[path] >> 1;
> +               dm_info->cfo_tail[path] = (pkt_stat->cfo_tail[path] * 5) >> 1;
> +
> +               rx_evm = pkt_stat->rx_evm[path];
> +
> +               if (rx_evm < 0) {
> +                       evm_dbm = ((u8)-rx_evm >> 1);
> +
> +                       if (evm_dbm == 64)

Does the 64 means the S8_MAX >> 1 or something else?
Can you give a more straightforward expression for EVM boundary check?
Same for the following rtw8822c.c

> +                               evm_dbm = 0;
> +               }
> +               dm_info->rx_evm_dbm[path] = evm_dbm;
> +       }
>  }
>
> --
> 2.17.1
>
