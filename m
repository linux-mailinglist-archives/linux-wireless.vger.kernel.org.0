Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E647882A8
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbjHYItp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbjHYItX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 04:49:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750921BC6
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 01:49:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f9521de4cso420176a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692953360; x=1693558160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eyHKTD14FLDnWYCj+IyXW1cSoL7lQPGe2ABhJrE4KI4=;
        b=VpqhyZvAenpBBNT8kfeVvfPlipci9eqZ92LN/0ib06MjpE3CuF3WY/7tAqQyVpij+K
         SSxumr5loCPoyy9gyAH3ZgwhzGdXzDLtQ05/9OF23OyyrOiUIzIXkTGtNQQ0fm09ltWl
         5k1qHmrditUwM6ypbqfhhBzcri+dHHUOpJpp6mqgVg9oLSXBYnyR5/pds6UUCLNQvR4S
         p7g7xNsKFWn4/A/4GiT3BhCUQzBRc4s5XJorydkKx2S5vlzHMEeG6bGNS/eB7kPRzPih
         zZE3h5X+DrHWHEZydT56DkVXXFVCcphYW9hnAE1Fw6wBLIn6idTC1G36TxkIiI97uiVQ
         h8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953360; x=1693558160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyHKTD14FLDnWYCj+IyXW1cSoL7lQPGe2ABhJrE4KI4=;
        b=UC8+arGNAPyYXQSk1a7gzTQquVT2EVLFALKzt8eEFHcEgYlgVt1/Y47x82SMX7nat/
         H+UMq2g1ZDusxLU8pdGFH/XEqvqoHJ5+yaO+nC5pYbEh1ycAbME3VgwHcBA31X5W6FuZ
         Objt4tBy+XXxOcGkPuMuF3T0zjBCiZN03vK1sydpHUzGlYUY5d/bdySHrXipddEDzy9s
         NBwwXyyInYC7inXsvS6DOmaW5AduW/nrgLHSYcU1/YZ0qwZwaxq1MLSsMKSC3uLSWDzH
         /DBWcqh0tpUa2y09xRX+wCmb5VuBRY863eLKsLetOxxvpOagkp/HEc7N3CvgeH+TPgdK
         y+vg==
X-Gm-Message-State: AOJu0YwvI6chW9k4dxdtxWpnjc0x6pM5Nt//5TAQvqQbBBI8g7Bu5BhC
        v3sWv92Mi/adSlJ4co70G95bE7qFP8NeoqriERY=
X-Google-Smtp-Source: AGHT+IFNhS58BcZqqlwdmM1HcYxXvvfJIg/bZST49yyyZMPbyjAkLvGUZ9mJfuEO3WLjeGwewc6pBsmBZN+vrcg/VrQ=
X-Received: by 2002:a17:90b:703:b0:26d:3d3a:a198 with SMTP id
 s3-20020a17090b070300b0026d3d3aa198mr13266294pjz.42.1692953359843; Fri, 25
 Aug 2023 01:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230818014004.16177-1-pkshih@realtek.com>
In-Reply-To: <20230818014004.16177-1-pkshih@realtek.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 25 Aug 2023 10:49:08 +0200
Message-ID: <CAOiHx=mo1WUYKKb5HtiPg0fiomem-QBqR2g9385tuEc-v_889A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: limit reorder_buf_filtered <=64 to avoid
 shift-out-of-bounds UBSAN warning
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Sun, 20 Aug 2023 at 13:20, Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> The commit 06470f7468c8 ("mac80211: add API to allow filtering frames in BA sessions")
> adds reorder_buf_filtered to mark frames filtered by firmware, and it can
> only work correctly if hw.max_rx_aggregation_subframes <= 64 because
> maximum BlockAck is 64 at that moment.
>
> However, new HE or EHT devices can support BlockAck number up to 256 or
> 1024, and leads UBSAN warning:
>
>  UBSAN: shift-out-of-bounds in net/mac80211/rx.c:1129:39
>  shift exponent 215 is too large for 64-bit type 'long long unsigned int'
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl+0x48/0x70
>   dump_stack+0x10/0x20
>   __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
>   ieee80211_release_reorder_frame.constprop.0.cold+0x64/0x69 [mac80211]
>   ieee80211_sta_reorder_release+0x9c/0x400 [mac80211]
>   ieee80211_prepare_and_rx_handle+0x1234/0x1420 [mac80211]
>   ? __pfx_jhash+0x10/0x10
>   ? rht_key_get_hash.isra.0+0x19/0x30 [mac80211]
>   ieee80211_rx_list+0xaef/0xf60 [mac80211]
>   ? kfree_skbmem+0x58/0xb0
>   ? rtw89_vif_rx_stats_iter+0x2bb/0x2e1 [rtw89_core]
>   ieee80211_rx_napi+0x53/0xd0 [mac80211]
>
> Since only old hardware that supports <=64 BlockAck uses
> ieee80211_mark_rx_ba_filtered_frames(), limit the use as it is, so add a
> WARN_ONCE() and comment to note to avoid using this function if hardware
> capability is not suitable.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  include/net/mac80211.h |  1 +
>  net/mac80211/rx.c      | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 3a8a2d2c58c3..2a55ae932c56 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -6612,6 +6612,7 @@ void ieee80211_stop_rx_ba_session(struct ieee80211_vif *vif, u16 ba_rx_bitmap,
>   * marks frames marked in the bitmap as having been filtered. Afterwards, it
>   * checks if any frames in the window starting from @ssn can now be released
>   * (in case they were only waiting for frames that were filtered.)
> + * (Only work correctly if @max_rx_aggregation_subframes <= 64 frames)
>   */
>  void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
>                                           u16 ssn, u64 filtered,
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 4f707d2a160f..0af2599c17e8 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -1083,7 +1083,8 @@ static inline bool ieee80211_rx_reorder_ready(struct tid_ampdu_rx *tid_agg_rx,
>         struct sk_buff *tail = skb_peek_tail(frames);
>         struct ieee80211_rx_status *status;
>
> -       if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
> +       if (tid_agg_rx->reorder_buf_filtered &&
> +           tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))

While it will silence the UBSAN warning, unless you know why the code
was written this way it will look like a pointless micro-optimization.

So I suggest changing the condition to

       if (index < BITS_PER_LONG_LONG &&
           tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))

to make it more obvious what the intention of the extra condition is.

>                 return true;
>
>         if (!tail)
> @@ -1124,7 +1125,8 @@ static void ieee80211_release_reorder_frame(struct ieee80211_sub_if_data *sdata,
>         }
>
>  no_frame:
> -       tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
> +       if (tid_agg_rx->reorder_buf_filtered)
> +               tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);

likewise

>         tid_agg_rx->head_seq_num = ieee80211_sn_inc(tid_agg_rx->head_seq_num);
>  }
>
> @@ -4264,6 +4266,7 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
>                                           u16 ssn, u64 filtered,
>                                           u16 received_mpdus)
>  {
> +       struct ieee80211_local *local;
>         struct sta_info *sta;
>         struct tid_ampdu_rx *tid_agg_rx;
>         struct sk_buff_head frames;
> @@ -4281,6 +4284,11 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
>
>         sta = container_of(pubsta, struct sta_info, sta);
>
> +       local = sta->sdata->local;
> +       WARN_ONCE(local->hw.max_rx_aggregation_subframes > 64,
> +                 "RX BA marker can't support max_rx_aggregation_subframes %u > 64\n",
> +                 local->hw.max_rx_aggregation_subframes);

And maybe use BITS_PER_LONG_LONG here as well.

Or introduce your own macro. Not sure what's nicer.

> +
>         if (!ieee80211_rx_data_set_sta(&rx, sta, -1))
>                 return;
>
> --
> 2.25.1
>

Regards,
Jonas
