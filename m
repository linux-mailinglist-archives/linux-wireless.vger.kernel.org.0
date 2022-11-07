Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC461F358
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 13:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiKGMcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 07:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKGMcu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 07:32:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B45B25
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 04:32:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB3BCB80DF3
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 12:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2773C433C1;
        Mon,  7 Nov 2022 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667824366;
        bh=79z7VoNd4Ba4clf3ncIBp248alVCCQPhzogLRI4L9XY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cB5bK+ge9ODWcEmNQX+D01bEp3q1Y/300EqiN4836yRQ1prl9mfy8s5RX3Y6RhYNu
         u//pCRpLtv3VEHWn6k3Y1pbThgUlURWv1Tco86IEGZVnB/dSFF6Bbpe7gyP40Ydwnx
         VPTWj6pqTwMUBNmFctBY8g1JFx/QjM9ca/7DFXgGDbcln5b2Ef9yUsyCn96zctERJW
         AlkeuRjWBvlkeFt3eVnWXuY8xlS6IYvs+F/Cd102jPSX6wZ9tYQkPQq4i2+rGv0h23
         34xKvCStTPVqEkzS0+4hujV+PfgSOk6a0lffDqs65C4eYr3iXORf8xZwKbnZQKaqkM
         ++vXVbIBRYvDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: 8852b: change debug mask of message of no TX resource
References: <20221103072517.15284-1-pkshih@realtek.com>
Date:   Mon, 07 Nov 2022 14:32:43 +0200
In-Reply-To: <20221103072517.15284-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Thu, 3 Nov 2022 15:25:17 +0800")
Message-ID: <87sfivt05w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> 8852B has smaller TX FIFO than others in WiFi chip, so it would be buffer
> full frequently, but it doesn't affect TX performance. However, it shows
> verbose debug messages with RTW89_DBG_UNEXP mask that is to show up
> abnormal behavior, so change debug mask to RTW89_DBG_TXRX for 8852B.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/pci.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
> index 07a2e23759f0b..99a254d7ba5ed 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -971,8 +971,10 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>  	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
>  	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
>  	struct rtw89_pci_tx_wd_ring *wd_ring = &tx_ring->wd_ring;
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
>  	u32 bd_cnt, wd_cnt, min_cnt = 0;
>  	struct rtw89_pci_rx_ring *rx_ring;
> +	enum rtw89_debug_mask debug_mask;
>  	u32 cnt;
>  
>  	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
> @@ -996,10 +998,16 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>  	bd_cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
>  	wd_cnt = wd_ring->curr_num;
>  	min_cnt = min(bd_cnt, wd_cnt);
> -	if (min_cnt == 0)
> -		rtw89_debug(rtwdev, rtwpci->low_power ? RTW89_DBG_TXRX : RTW89_DBG_UNEXP,
> +	if (min_cnt == 0) {
> +		if (rtwpci->low_power || chip->chip_id == RTL8852B)
> +			debug_mask = RTW89_DBG_TXRX;
> +		else
> +			debug_mask = RTW89_DBG_UNEXP;
> +
> +		rtw89_debug(rtwdev, debug_mask,
>  			    "still no tx resource after reclaim: wd_cnt=%d bd_cnt=%d\n",
>  			    wd_cnt, bd_cnt);
> +	}

Changing the debug mask like this looks a bit weird to me. At least it
would be good to have a comment in the code explainin why this is done
like this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
