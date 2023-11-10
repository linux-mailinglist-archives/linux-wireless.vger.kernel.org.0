Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48D7E80A9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjKJSRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbjKJSQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:35 -0500
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 03:38:21 PST
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA492FEFF
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 03:38:21 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1699615717; bh=+IwBurxvPqAe6pW4WbGM/ZfHCCn6WQeRnVpjBLvJH7Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=urBLSHQ+1KNH/wBWu7BJeThXdvQ+StQA1jEPW0LmHcBOvyPqATbFt8Yb9rdI44mMR
         fLoGckXnY3DogLTtQgVDKaV1R/wW+mBmu+DJrFsHiUwIferNQMygYoiKMyTYi9dUOG
         Swj2c8xYaJ/IAomEzVINMfqmv7u6zl0fKyEbECDS4GE4wUUx4NvMQsugqKxOFwynpP
         Ibx1K9HwQEGj8XlI5pnIX5hvUE2EMFgri/OraPaWsCEUZ5NJo5fdr/oZFP5MyhlFtp
         aBMQkMwwewkd7ZMa7KyIKWF1iippXe+37a/R9Ne9qPeyXV0roiryCaXMDoAuykYs+1
         vGz2BCyyDLPDw==
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH] wifi: ath9k: Fix potential array-index-out-of-bounds
 read in ath9k_htc_txstatus()
In-Reply-To: <20231110064143.1356077-1-linuxlovemin@yonsei.ac.kr>
References: <20231110064143.1356077-1-linuxlovemin@yonsei.ac.kr>
Date:   Fri, 10 Nov 2023 12:28:36 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cywhvod7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> writes:

> Fix an array-index-out-of-bounds read in ath9k_htc_txstatus(). The bug
> occurs when txs->cnt, data from a URB provided by a USB device, is
> bigger than the size of the array txs->txstatus, which is
> HTC_MAX_TX_STATUS. WARN_ON() already checks it, but there is no bug
> handling code after the check. Make the function return if that is the
> case.
>
> Found by a modified version of syzkaller.
>
> UBSAN: array-index-out-of-bounds in htc_drv_txrx.c
> index 13 is out of range for type '__wmi_event_txstatus [12]'
> Call Trace:
>  ath9k_htc_txstatus
>  ath9k_wmi_event_tasklet
>  tasklet_action_common
>  __do_softirq
>  irq_exit_rxu
>  sysvec_apic_timer_interrupt
>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> ---
>  drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> index 800177021baf..c628332f2562 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
> @@ -652,9 +652,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
>  	struct ath9k_htc_tx_event *tx_pend;
>  	int i;
>  
> -	for (i = 0; i < txs->cnt; i++) {
> -		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
> +	if (WARN_ON(txs->cnt > HTC_MAX_TX_STATUS))
> +		return;

Since this is something that can be triggered by a device sending bad
data, this shouldn't be an unbounded WARN_ON(). We could turn it into a
WARN_ON_ONCE(), or just get rid of it entirely...

-Toke
