Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD943DE8FD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Aug 2021 10:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHCIye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Aug 2021 04:54:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25439 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhHCIyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Aug 2021 04:54:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627980862; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=abStokMOHD5/rkoDLaed2ke3OYy1nFP6XjtCBnzj1nU=;
 b=pySgNT8fBVuKy3RJlxz1E08DdvNjn9EP2V7Lm6HC1L01VUZn7/WZ++41fiuHimWbl0I1czHm
 J1qZI3/mYtEBH1nSVDq1Z4iwIn1CAGENKV3sLsOwWhD7Br0uJ0gLEj1SDTXH5jZxbM/a//Fr
 /x1F9kjgRiZLfMKTYD9lWUvqwcw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61090424e81205dd0aad75a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Aug 2021 08:53:56
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2AAF4C433F1; Tue,  3 Aug 2021 08:53:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6959CC433D3;
        Tue,  3 Aug 2021 08:53:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Aug 2021 16:53:55 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-10-wgong@codeaurora.org>
 (sfid-20210517_222034_029448_A9A89D57)
 <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
 <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
Message-ID: <270e3bd0143564b2e2ec6c359897a507@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi johannes,

Could you see my answer below?
please feel free to point out the mistakes :)

On 2021-07-30 18:47, Wen Gong wrote:
> On 2021-07-23 17:38, Johannes Berg wrote:
>> On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
>>> 
>>> +		if (is_6ghz) {
>>> +			struct ieee802_11_elems elems;
>>> +			struct ieee80211_bss_conf *bss_conf;
>>> +			u8 i, n;
>>> +
>>> +			ieee802_11_parse_elems(ies->data, ies->len, false, &elems,
>>> +					       NULL, NULL);
>>> +			bss_conf = &sdata->vif.bss_conf;
>>> +			bss_conf->pwr_reduction = 0;
>>> +			if (elems.pwr_constr_elem)
>>> +				bss_conf->pwr_reduction = *elems.pwr_constr_elem;
>>> +
>>> +			memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
>>> +			bss_conf->tx_pwr_env_num = elems.tx_pwr_env_num;
>>> +			n = min_t(u8, elems.tx_pwr_env_num,
>>> +				  ARRAY_SIZE(elems.tx_pwr_env));
>> 
>> If anything, that min_t would make sense only if you were actually 
>> using
>> ARRAY_SIZE(bss_conf->tx_pwr_env), but like this it's quite pointless,
>> just checking again if the element parsing was internally consistent?
>> 
>> I'd probably remove it and throw in a
>> 
>> 	BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
>>                      ARRAY_SIZE(elems.tx_pwr_env));
>> 
>> instead.
>> 
>>> +			for (i = 0; i < n; i++)
>>> +				memcpy(&bss_conf->tx_pwr_env[i], elems.tx_pwr_env[i],
>>> +				       elems.tx_pwr_env_len[i]);
>> 
>> You also never validated that the element wasn't too long!
>> 
> will change it.
>> 
>> If you connect to 6 Ghz with this, and then again to another AP that
>> doesn't, you'll have it stuck at the old values. You need to reset at
>> some point (during disconnect).
>> 
> will change to reset it in ieee80211_prep_channel outside is_6ghz{}.
> Then it will be reset for each connection.
>> And then two more questions:
>> 
>> 1) Could this information change? Should we track it in beacons?
>> 
> 
> The information is from AP side, it should be not changed untill the AP 
> restart.
> If someone want to change configure of AP, the AP should restart and
> then take effect by my understand.
> Is it have some case for this information change?
> 
> 
>> 2) Should we at least check it again from the protected beacon or such
>> after association, so we don't blindly trust the probe response or
>> beacon (received during scan, not validated) at least when BIGTK is in
>> use?
> 
> May we add support for BIGTK in future with another patch?
> The info(pwr_reduction and tx_pwr_env) is used by lower driver such as 
> ath11k.
> If the info changed after association, then how to notify lower driver?
> Do it like below in ieee80211_rx_mgmt_beacon()?
> And use BSS_CHANGED_TXPOWER or a new enum in ieee80211_bss_change?
> 
> ieee80211_rx_mgmt_beacon{
> 	changed |= ieee80211_handle_pwr_constr(sdata, chan, mgmt,
> 					       elems.country_elem,
> 					       elems.country_elem_len,
> 					       elems.pwr_constr_elem,
> 					       elems.cisco_dtpc_elem);
> 
> 	ieee80211_bss_info_change_notify(sdata, changed);
> }
> 
>> 
>> johannes
