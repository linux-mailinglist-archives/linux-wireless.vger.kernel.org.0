Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28752B833
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiERK5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiERK5T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 06:57:19 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3783253A75
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 03:57:18 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c26so1590874vsl.6
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aD6sJmhRWlpTVYgDySx2h2Vn69aUP+JH8c/uIV9LhQ=;
        b=okouQH+NMTlsBTKbFwaFR/BwO0UoksgscPIBvu1EJf4eWTneQsnCLjKBF5caIBhYWn
         RMQbXqJJxLAfrgkkW5D0nNgiBxIzGXbdTNefawTfi3CnhPu6HDiBYhxGZg6LpeT/lP9k
         ladRVC+1l1vQmfFujzqFtdRsYEqtgolTIap4b8EGFh8vIf6oijzZB1HrjcAdvtG3q1XO
         d1pR34KvB524BgdyLl7CqEV4eNAFeIyJKwVh8ZHwpq7YMDcusPNjajKFHSjZh4604M5j
         xF0ZxcFeqaIjNCWV5cUhKy301FJCCG1SKb+Sx5k1YIUbX4Of4FRhZUiW4Swb4vSa6ncn
         Ic7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aD6sJmhRWlpTVYgDySx2h2Vn69aUP+JH8c/uIV9LhQ=;
        b=ukvOGheilzQRF4rV/zYfGCvSdZa1rYvZBEZaLuJ21LFoN1EUYEKVIpatZFBuzhMbnD
         wF9zjNziXPTeAvUZX9MmfmvXZtC+424830ePv/qvlbfTbfg2Ep6WjELm4JLDi+I2jRCn
         76pY1DPNxje0+Jr+0bW9psbEUUpKXHKCWz9spy3LtyRDgXIV0+3Of7/0qcGsFeDW2hoV
         lWgmiIkeVoO20cLMgvEu+5zpuIFf9PT7P9WVpsL3mc8U76ohKa6ZlUh52hsnuJ6D1LZR
         hK9p9eraqOS+QHAvtrqTsGqkVc3lo/DwBjw2PyNL9iYKkr/nNNH1Wyw1b4bwlrdiWftB
         Tuww==
X-Gm-Message-State: AOAM532gDyhL91Fqkw0Fn/bcU6YDBfCeWCY4y0u5RBSUh9vpGLXM6hH0
        PzdB1T2rvxNediVjdZZ/9rpnUdnflAocmdel7yjDDiRL+v0=
X-Google-Smtp-Source: ABdhPJzg6TiAUdTqTvninpNAkSXje1mC5UsUpDNTi6DZGeF3q3f+CUKh2YCZOT5ezeDhA8i2+qFWIkv2ULeNvg+IhPo=
X-Received: by 2002:a67:d492:0:b0:335:c3fc:f312 with SMTP id
 g18-20020a67d492000000b00335c3fcf312mr2799796vsj.32.1652871437343; Wed, 18
 May 2022 03:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
 <20220516032519.29831-2-ryazanov.s.a@gmail.com> <CAHNKnsS2_vVPZT-PSjNDzfQmyXEaOJNO8MHqVfntN=GSG3P_Ng@mail.gmail.com>
 <87tu9n2t8m.fsf@kernel.org>
In-Reply-To: <87tu9n2t8m.fsf@kernel.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 18 May 2022 13:57:06 +0300
Message-ID: <CAHNKnsT8HfH2E3H61oafYE-nLtv8ZQYkBktCtczTn5JVYgLPRA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ath10k: improve tx status reporting
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?B?T2xkxZlpY2ggSmVkbGnEjWth?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 18, 2022 at 10:30 AM Kalle Valo <kvalo@kernel.org> wrote:
> Sergey Ryazanov <ryazanov.s.a@gmail.com> writes:
>> On Mon, May 16, 2022 at 6:25 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>> --- a/drivers/net/wireless/ath/ath10k/txrx.c
>>> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
>>> @@ -43,6 +43,7 @@ static void ath10k_report_offchan_tx(struct ath10k *ar, struct sk_buff *skb)
>>>  int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>>                          const struct htt_tx_done *tx_done)
>>>  {
>>> +       struct ieee80211_tx_status status;
>>>         struct ath10k *ar = htt->ar;
>>>         struct device *dev = ar->dev;
>>>         struct ieee80211_tx_info *info;
>>> @@ -128,7 +129,16 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>>                 info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>>>         }
>>>
>>> -       ieee80211_tx_status(htt->ar->hw, msdu);
>>> +       memset(&status, 0, sizeof(status));
>>> +       status.skb = msdu;
>>> +       status.info = info;
>>> +
>>> +       rcu_read_lock();
>>> +       if (txq && txq->sta)
>>> +               status.sta = txq->sta;
>>
>> Just noticed that since we do not dereference the txq->sta pointer
>> here, the above code can be simplified to:
>>
>> if (txq)
>>         status.sta = txq->sta;
>>
>> Kalle, should I send V2 or can you change this in your tree?
>
> I changed this in the pending branch, please check my changes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=1bd0c16e10229683fab1dd8adf8c4339992688b7

Exactly what I meant. Thank you!

--
Sergey
