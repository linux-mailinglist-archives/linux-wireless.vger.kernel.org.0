Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68086FB688
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjEHS6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHS6b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 14:58:31 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3855B6;
        Mon,  8 May 2023 11:58:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1962e7284baso7122fac.3;
        Mon, 08 May 2023 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572309; x=1686164309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=khJ7hj8pKzFr6tqyeboXwy6UfhzWTFVnsM5WxLOl67M=;
        b=Zo84P87WI5Ps+SkkrQmvC+jCg+4VfseRp8HtoeRvasjynnkU0vS7bM96JKKunjJwGV
         TrrFf892d1ur2PVpu4/o7OoR87P9BCNdk9HKLTk4kfaCvRN0oeWsFlrVabJQ47LhAlpu
         h0HOKYIovqy9DfzVUzMaK4EJiAW30d0/8h8IQY5FnAEoitXgte4heA1ymkhOFZreQpqK
         AvGUKxrtIn5yBILorWtEAIRSTUgdvtDSkOAKlqzZwZAd/p4HdVDZj2oI1+cjT78gQK6K
         /qCCbeGgTWJf+KplquPJzl0pWwGDtp5o+1vQq2eXNyZikBNCLhx4MpBwx7pILAEn98Sz
         gwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572309; x=1686164309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khJ7hj8pKzFr6tqyeboXwy6UfhzWTFVnsM5WxLOl67M=;
        b=eMGEdqqvy8hdNQQdPXG0oaS3mSIvFThOJiLkR7603Gi397LnODepdCzykR8JbPo2pB
         WCHd4wQgUmUVBJEIHV2xlXJhKqbvlUhSVwhF+ux86bmdEP4xpPx2AMWb/jD4WK+Kvdan
         yZYwXGNB1/zhkx5otvMS1O+TNriFSJwHV/bHe2eq4MrA8Xjq758o421KkvnkjpIMOxDG
         THEkMNh0g0YaSBxm/zVcNkwHpB5z0fyWyhL9md/LcmhtNTFDYp5gN0Gl0wYzqX52O9y/
         FlodPPMVfTkVFAjOzxxHfZQ69SG6+nWteFIv/hgMhwJMMccYRV/T+GGrBJdVCryHZEXT
         59/A==
X-Gm-Message-State: AC+VfDyu1DcpgmX/Fnfl8jxFTJmmsS+2MLTha3fHKrBhTRqSk0kO0qmX
        Kdm8rsCWZxDWM4zISSdK+yA=
X-Google-Smtp-Source: ACHHUZ6qrVcnbOYHKkYyusot+yOC9Ow29ttRwx7lPN1Jp+Xc9r0nKJgHT+eEVd0nRzF1YmOPUPc9QA==
X-Received: by 2002:a05:6870:5141:b0:18e:8a68:fe41 with SMTP id z1-20020a056870514100b0018e8a68fe41mr5507010oak.56.1683572309668;
        Mon, 08 May 2023 11:58:29 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b0017fea9c156esm5248412oal.18.2023.05.08.11.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:58:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <33aff1cc-37f9-88a5-9fd5-5d8db21dc42d@lwfinger.net>
Date:   Mon, 8 May 2023 13:58:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] wifi: rtw88: use work to update rate to avoid RCU warning
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org,
        tony0620emma@gmail.com
Cc:     stable@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20230508085429.46653-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230508085429.46653-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/8/23 03:54, Ping-Ke Shih wrote:
> The ieee80211_ops::sta_rc_update must be atomic, because
> ieee80211_chan_bw_change() holds rcu_read lock while calling
> drv_sta_rc_update(), so create a work to do original things.
> 
>   Voluntary context switch within RCU read-side critical section!
>   WARNING: CPU: 0 PID: 4621 at kernel/rcu/tree_plugin.h:318
>   rcu_note_context_switch+0x571/0x5d0
>   CPU: 0 PID: 4621 Comm: kworker/u16:2 Tainted: G        W  OE
>   Workqueue: phy3 ieee80211_chswitch_work [mac80211]
>   RIP: 0010:rcu_note_context_switch+0x571/0x5d0
>   Call Trace:
>    <TASK>
>    __schedule+0xb0/0x1460
>    ? __mod_timer+0x116/0x360
>    schedule+0x5a/0xc0
>    schedule_timeout+0x87/0x150
>    ? trace_raw_output_tick_stop+0x60/0x60
>    wait_for_completion_timeout+0x7b/0x140
>    usb_start_wait_urb+0x82/0x160 [usbcore
>    usb_control_msg+0xe3/0x140 [usbcore
>    rtw_usb_read+0x88/0xe0 [rtw_usb
>    rtw_usb_read8+0xf/0x10 [rtw_usb
>    rtw_fw_send_h2c_command+0xa0/0x170 [rtw_core
>    rtw_fw_send_ra_info+0xc9/0xf0 [rtw_core
>    drv_sta_rc_update+0x7c/0x160 [mac80211
>    ieee80211_chan_bw_change+0xfb/0x110 [mac80211
>    ieee80211_change_chanctx+0x38/0x130 [mac80211
>    ieee80211_vif_use_reserved_switch+0x34e/0x900 [mac80211
>    ieee80211_link_use_reserved_context+0x88/0xe0 [mac80211
>    ieee80211_chswitch_work+0x95/0x170 [mac80211
>    process_one_work+0x201/0x410
>    worker_thread+0x4a/0x3b0
>    ? process_one_work+0x410/0x410
>    kthread+0xe1/0x110
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x1f/0x30
>    </TASK>
> 
> Cc: stable@vger.kernel.org
> Fixes: c1edc86472fc ("rtw88: add ieee80211:sta_rc_update ops")
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Link: https://lore.kernel.org/linux-wireless/f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net/T/#t
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>   drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
>   drivers/net/wireless/realtek/rtw88/main.c     | 15 +++++++++++++++
>   drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
>   3 files changed, 19 insertions(+), 1 deletion(-)

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

