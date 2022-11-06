Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35AC61E21D
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 13:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKFMi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 07:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKFMi1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 07:38:27 -0500
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC06C69
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 04:38:24 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1667738302; bh=tMUvvs0rznmjAk75FG/6PwHdwldmrPOqhOv6vqz3FFM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MT7bW8EDFGSwIoCjiZcgwm8m23FaDczHL7jwMQjAJpQ7H3A9ytGFqVyDULQwRpNGQ
         iiwXpFt35Au08MENN+bkDF8b57TwGoA+dxoh1zk89b4A2s8RAaVLuJZksFxS4JFp1R
         hRCI5XISP/PrrrXMnwlKcvCKyISHlzTDrgS4YgGKzybxhmpvSDZZ/07D65uEWBg1Yn
         Ztd2VG3kj50vkr42ypwIUDKy0HDCfHg1J4x52t2T8uYxSzgBnAw7KxJKAG83UMOjH4
         YDkhYkv3t06ibR4hVNW1aMRTp6Me/Ue5myEa8YgISfVs1iQm7rETwq/U+zjHli8bPu
         RZfOpsFVbhyMg==
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     bjlockie@lockie.ca, johannes@sipsolutions.net, nbd@nbd.name
Subject: Re: [PATCH wireless] wifi: mac8021: fix possible oob access in
 ieee80211_get_rate_duration
In-Reply-To: <08b259df20d9e61c5b852bf8b96db7272dbb1767.1667730476.git.lorenzo@kernel.org>
References: <08b259df20d9e61c5b852bf8b96db7272dbb1767.1667730476.git.lorenzo@kernel.org>
Date:   Sun, 06 Nov 2022 13:38:21 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mt94w94y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix possible out-of-bound access in ieee80211_get_rate_duration routine
> as reported by the following UBSAN report:
>
> UBSAN: array-index-out-of-bounds in net/mac80211/airtime.c:455:47
> index 15 is out of range for type 'u16 [12]'
> CPU: 2 PID: 217 Comm: kworker/u32:10 Not tainted 6.1.0-060100rc3-generic
> Hardware name: Acer Aspire TC-281/Aspire TC-281, BIOS R01-A2 07/18/2017
> Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
> Call Trace:
>  <TASK>
>  show_stack+0x4e/0x61
>  dump_stack_lvl+0x4a/0x6f
>  dump_stack+0x10/0x18
>  ubsan_epilogue+0x9/0x43
>  __ubsan_handle_out_of_bounds.cold+0x42/0x47
> ieee80211_get_rate_duration.constprop.0+0x22f/0x2a0 [mac80211]
>  ? ieee80211_tx_status_ext+0x32e/0x640 [mac80211]
>  ieee80211_calc_rx_airtime+0xda/0x120 [mac80211]
>  ieee80211_calc_tx_airtime+0xb4/0x100 [mac80211]
>  mt76x02_send_tx_status+0x266/0x480 [mt76x02_lib]
>  mt76x02_tx_status_data+0x52/0x80 [mt76x02_lib]
>  mt76u_tx_status_data+0x67/0xd0 [mt76_usb]
>  process_one_work+0x225/0x400
>  worker_thread+0x50/0x3e0
>  ? process_one_work+0x400/0x400
>  kthread+0xe9/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>
> Reported-by: bjlockie@lockie.ca
> Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from mt76")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/mac80211/airtime.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> index 2e66598fac79..4ed05988131d 100644
> --- a/net/mac80211/airtime.c
> +++ b/net/mac80211/airtime.c
> @@ -452,6 +452,9 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
>  			 (status->encoding == RX_ENC_HE && streams > 8)))
>  		return 0;
>  
> +	if (WARN_ON_ONCE(idx >= MCS_GROUP_RATES))
> +		return 0;
> +

So presumably this is something that can actually happen in real usage,
so should we really warn? Or was the driver also fixed to not trigger
this?

-Toke
