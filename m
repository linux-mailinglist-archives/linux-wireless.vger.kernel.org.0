Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CBF63EE70
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLAKx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 05:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiLAKxB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 05:53:01 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75374D9A
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 02:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YFaa7YKXSvWLRDXhrY62aVrDz3UmYOdr/qkiXBZuk9w=; b=Su6ZdHYotF5kFvfCFuoAraVUAy
        8dq8a6reTuVno3MUjGSlFDICWKRBOBfAcoSkhaH8pEjqCDtCt7xNcjbFdwg1SLUIaAD6MUefzzzdn
        PMxjZubvCwQRjYQYEkK7Me2A1ULevYexXWqhFfU5tvc03M2VD0n35FsAtVrZjsddpz/w=;
Received: from p200300daa7225c08186973351f2f7021.dip0.t-ipconnect.de ([2003:da:a722:5c08:1869:7335:1f2f:7021] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p0hAW-005deM-BD; Thu, 01 Dec 2022 11:51:52 +0100
Message-ID: <973c3afc-2ea6-ff05-2c61-d047bf69867f@nbd.name>
Date:   Thu, 1 Dec 2022 11:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 5/9] wifi: mt76: mt7996: add MAC support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
 <20221122084554.9494-6-shayne.chen@mediatek.com> <87zgc7mmr8.fsf@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <87zgc7mmr8.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01.12.22 11:39, Kalle Valo wrote:
> Shayne Chen <shayne.chen@mediatek.com> writes:
> 
>> (Split the big patch into smaller intermediate patches by functionality
>> for easier review. Refer to the cover letter for more info.)
>>
>> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> 
> [...]
> 
>> +static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
>> +{
>> +	static const u8 ac_to_tid[] = {
>> +		[IEEE80211_AC_BE] = 0,
>> +		[IEEE80211_AC_BK] = 1,
>> +		[IEEE80211_AC_VI] = 4,
>> +		[IEEE80211_AC_VO] = 6
>> +	};
>> +	struct ieee80211_sta *sta;
>> +	struct mt7996_sta *msta;
>> +	struct rate_info *rate;
>> +	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
>> +	LIST_HEAD(sta_poll_list);
>> +	int i;
>> +
>> +	spin_lock_bh(&dev->sta_poll_lock);
>> +	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
>> +	spin_unlock_bh(&dev->sta_poll_lock);
>> +
>> +	rcu_read_lock();
>> +
>> +	while (true) {
> 
> In upstream we have a preference that there's some kind of limit for
> loops, to avoid neverending loops.
This loop pulls entries from the on-stack sta_poll_list and bails out 
when the list is empty, so it's impossible for it to be neverending.

- Felix
