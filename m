Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB052B37F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiERHaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiERHaL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 03:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A55D1B9
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 00:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E685EB81EB1
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 07:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6157C34113;
        Wed, 18 May 2022 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652859007;
        bh=+zhe42QWlOeLYawRxZmuopv435lwPm0NJK4t2EQvtbg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BQgKbMW8o5UfMeC9g0Wy8YBi41Mm8ZMQDmvfkL6RtWo+DLlC7i3aLFZcsWxFJ9VbC
         PECKIZCsG0fRgoHVE8f8NPhzdaAJaiDq22hXbm/hF1QaRVkmyrrK7Rts7kfTeGL7lc
         jk/NpzPwU/KeJe/cxbr4qKBt7lMKcKIAqOJFqiJtFElu0ekLc4u9U+sXtWf2/IKdlE
         A1UTZYy8XGdc3rruRVBw4KOpt6+0scBxhGbSFh87zwaBO88xXWAJ7IByoPgNhsMt1i
         gQDQ6VfaTRo+iHU2G0rLXlMJjkUoYCpeJJLPAhd+fA827K0Rc4W480+iyD86l1KEWn
         E0HN9Ebf6CwXQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?utf-8?Q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Subject: Re: [PATCH 1/4] ath10k: improve tx status reporting
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
        <20220516032519.29831-2-ryazanov.s.a@gmail.com>
        <CAHNKnsS2_vVPZT-PSjNDzfQmyXEaOJNO8MHqVfntN=GSG3P_Ng@mail.gmail.com>
Date:   Wed, 18 May 2022 10:30:01 +0300
In-Reply-To: <CAHNKnsS2_vVPZT-PSjNDzfQmyXEaOJNO8MHqVfntN=GSG3P_Ng@mail.gmail.com>
        (Sergey Ryazanov's message of "Mon, 16 May 2022 23:57:34 +0300")
Message-ID: <87tu9n2t8m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Ryazanov <ryazanov.s.a@gmail.com> writes:
> On Mon, May 16, 2022 at 6:25 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
>> --- a/drivers/net/wireless/ath/ath10k/txrx.c
>> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
>> @@ -43,6 +43,7 @@ static void ath10k_report_offchan_tx(struct ath10k *ar, struct sk_buff *skb)
>>  int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>                          const struct htt_tx_done *tx_done)
>>  {
>> +       struct ieee80211_tx_status status;
>>         struct ath10k *ar = htt->ar;
>>         struct device *dev = ar->dev;
>>         struct ieee80211_tx_info *info;
>> @@ -128,7 +129,16 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>                 info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>>         }
>>
>> -       ieee80211_tx_status(htt->ar->hw, msdu);
>> +       memset(&status, 0, sizeof(status));
>> +       status.skb = msdu;
>> +       status.info = info;
>> +
>> +       rcu_read_lock();
>> +       if (txq && txq->sta)
>> +               status.sta = txq->sta;
>
> Just noticed that since we do not dereference the txq->sta pointer
> here, the above code can be simplified to:
>
> if (txq)
>         status.sta = txq->sta;
>
> Kalle, should I send V2 or can you change this in your tree?

I changed this in the pending branch, please check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=1bd0c16e10229683fab1dd8adf8c4339992688b7

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
