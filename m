Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81C565D281
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jan 2023 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjADMYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Jan 2023 07:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjADMY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Jan 2023 07:24:28 -0500
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38A27A
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 04:24:25 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1672835063; bh=IQ6BUtaweM9xtjUfw4eK9Wo0sAFIDVudY5SyeUBdr/Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ByRW3CedrslP6oLfom04Us+vSmGOk0CDZMk2sOLdAw1vj/MXAohSpW0oBqU5mfNFF
         nnpV5fB94wek0e4tz3E/ws3+SwY7ThW/Sw26UUU+4QB8JmduYmn6e4BiymWdeg0loS
         SVTg4y37BcDBhj37UBsf5xpaMlkJiU/jSXv4fGVTMJonezFw+zyDAym/rtT1cGvhBY
         NP8I4bKKd6jhGPu3rNUXg26AfHi5MsyPKIir2yG+k9ylQ01suCtMF6u+9orUSawQ0p
         kdEYFkaJnj4IIr1X25sOTsx731DD41u1Xifg/6MHA2WJ82//pp40GPRkKzVJlC9CAt
         GaUtmem1+1COg==
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH] ath9k: Fix potential stack-out-of-bounds write in
 ath9k_wmi_rsp_callback()
In-Reply-To: <20230104042147.1419030-1-linuxlovemin@yonsei.ac.kr>
References: <20230104042147.1419030-1-linuxlovemin@yonsei.ac.kr>
Date:   Wed, 04 Jan 2023 13:24:23 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h6x632tk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> writes:

> Fix a stack-out-of-bounds write that occurs in a WMI response callback
> function that is called after a timeout occurs in ath9k_wmi_cmd().
> The callback writes to wmi->cmd_rsp_buf, a stack-allocated buffer that
> could no longer be valid when a timeout occurs. Checking seq_no is
> insufficient as the bug can occur between the timeout and the next WMI
> command. Add wmi->timedout to check whether a timeout occurred.
>
> Found by a modified version of syzkaller.
>
> BUG: KASAN: stack-out-of-bounds in ath9k_wmi_ctrl_rx
> Write of size 4
> Call Trace:
>  memcpy
>  ath9k_wmi_ctrl_rx
>  ath9k_htc_rx_msg
>  ath9k_hif_usb_reg_in_cb
>  __usb_hcd_giveback_urb
>  usb_hcd_giveback_urb
>  dummy_timer
>  call_timer_fn
>  run_timer_softirq
>  __do_softirq
>  irq_exit_rcu
>  sysvec_apic_timer_interrupt
>
> Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> ---
>  drivers/net/wireless/ath/ath9k/wmi.c | 5 ++++-
>  drivers/net/wireless/ath/ath9k/wmi.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
> index f315c54bd3ac..f46cbecc12e3 100644
> --- a/drivers/net/wireless/ath/ath9k/wmi.c
> +++ b/drivers/net/wireless/ath/ath9k/wmi.c
> @@ -234,7 +234,8 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
>  
>  	/* Check if there has been a timeout. */
>  	spin_lock_irqsave(&wmi->wmi_lock, flags);
> -	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id) {
> +	if (be16_to_cpu(hdr->seq_no) != wmi->last_seq_id ||
> +	    wmi->timedout) {
>  		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
>  		goto free_skb;
>  	}
> @@ -290,6 +291,7 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
>  
>  	spin_lock_irqsave(&wmi->wmi_lock, flags);
>  	wmi->last_seq_id = wmi->tx_seq_id;
> +	wmi->timedout = false;
>  	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
>  
>  	return htc_send_epid(wmi->htc, skb, wmi->ctrl_epid);
> @@ -341,6 +343,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
>  	if (!time_left) {
>  		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
>  			wmi_cmd_to_name(cmd_id));
> +		wmi->timedout = true;

Instead of introducing a new 'timedout' field, why not just reset
last_seq_id to 0 here? That way the existing check should trigger the
abort in ath9k_wmi_ctrl_rx()... 

-Toke
