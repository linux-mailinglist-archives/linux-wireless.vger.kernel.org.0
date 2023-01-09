Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1091E662812
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 15:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjAIOGf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 09:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjAIOF5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 09:05:57 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B261EF0F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 06:05:54 -0800 (PST)
Message-ID: <d28c6340-7ad2-d7f6-939d-3a1a057cb7da@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673273151;
        bh=4NGAakIbuen1X1A4D+gVp+ybsFKBfg8XIHb2/10NUww=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=j8RoYYRllBwdlALKhSb21I4ts4c6WMArTKpJeLwVpAFwngnCHqvoOt+uqYbqNIbmi
         4JFHGCcbtgre5wVSwZCvRlpakyoleZacPRxJpF6bg0OktJ4nuPSNa5/lkfgmFqJX6X
         mc1JDQfTBa5yukN6AYhy5iyY1NEQEMtZ+klOmmNI=
Date:   Mon, 9 Jan 2023 15:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH] wifi: mac80211: change initialize for sk_buff in
 ieee80211_tx_dequeue()
To:     Guenter Roeck <linux@roeck-us.net>,
        Wen Gong <quic_wgong@quicinc.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20221212083607.21536-1-quic_wgong@quicinc.com>
 <20230105052647.GA2477583@roeck-us.net>
Content-Language: en-US
In-Reply-To: <20230105052647.GA2477583@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.01.23 06:26, Guenter Roeck wrote:
> On Mon, Dec 12, 2022 at 03:36:07AM -0500, Wen Gong wrote:
>> The sk_buff is only set to NULL when initialize, sometimes it will goto
>> label "begin" after ieee80211_free_txskb(), then it points to a sk_buff
>> which is already freed. If it run into the "goto out" after arrived to
>> label "begin", then it will return a sk_buff which is freed, it is a
>> risk for use-after-free.
>>
>> Fixes: ded4698b58cb ("mac80211: run late dequeue late tx handlers without holding fq->lock")
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> 
> I don't see any progress on this patch. Is there a problem with it ?
> Did it get lost ?
> 

Looks ok for me. But I just noticed that my patch
https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/

should also fix the issue as an unintended side effect.

Alexander

> Thanks,
> Guenter
> 
>> ---
>>   net/mac80211/tx.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>>
>> base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
>>
>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> index 2171cd1ca807..0b23cc9ab9c7 100644
>> --- a/net/mac80211/tx.c
>> +++ b/net/mac80211/tx.c
>> @@ -3776,7 +3776,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>>   	struct ieee80211_local *local = hw_to_local(hw);
>>   	struct txq_info *txqi = container_of(txq, struct txq_info, txq);
>>   	struct ieee80211_hdr *hdr;
>> -	struct sk_buff *skb = NULL;
>> +	struct sk_buff *skb;
>>   	struct fq *fq = &local->fq;
>>   	struct fq_tin *tin = &txqi->tin;
>>   	struct ieee80211_tx_info *info;
>> @@ -3790,6 +3790,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>>   		return NULL;
>>   
>>   begin:
>> +	skb = NULL;
>> +
>>   	spin_lock_bh(&fq->lock);
>>   
>>   	if (test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ||

