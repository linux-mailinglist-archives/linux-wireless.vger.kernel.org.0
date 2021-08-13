Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549673EB2DB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhHMIsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 04:48:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56134 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239720AbhHMIsj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 04:48:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628844493; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=U5Vjp8FNKLyKkd6CIz80ylnWZ/KwDvvPahUsp8EwovQ=;
 b=P8WqwDu7IYlNtvAY/3/fZS/gdGJFRzOv7fe6WQQ8tPEAB/Cyg8n2WgdoBKoJjOuW2+bml/7u
 HG6MjJ/Sp9JmxwOaukhDZPs5UpOdzx0qaViV4djV1cY1BpECfYanND0M9UGVjmfAruYlXWEo
 Dyz29CaKlrtGqhnO+uPlAaFWVq8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 611631bd7ee6040977638398 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 08:47:57
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E4EEC43217; Fri, 13 Aug 2021 08:47:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 986BCC4338A;
        Fri, 13 Aug 2021 08:47:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Aug 2021 16:47:55 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-10-wgong@codeaurora.org>
 (sfid-20210517_222034_029448_A9A89D57)
 <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
 <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
 <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
 <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
Message-ID: <a056e32d4911400fb0822bf02167e91c@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-13 15:25, Johannes Berg wrote:
> On Fri, 2021-08-13 at 09:19 +0200, Johannes Berg wrote:
>> 
>> > > 2) Should we at least check it again from the protected beacon or such
>> > > after association, so we don't blindly trust the probe response or
>> > > beacon (received during scan, not validated) at least when BIGTK is in
>> > > use?
>> >
>> > May we add support for BIGTK in future with another patch?
>> 
>> We already have BIGTK support in mac80211, so if we don't do that now
>> we're almost certainly not going to do it, so I'd really prefer if you
>> did it here, or if a separate patch still did it now.
> 
> Actually, I should say though - the question was more whether we even
> need/want that, rather than whether we can do it later or not.
> 
> If we should protect this data/information then IMHO we should do it
> now, but it's not clear to me that we should, given that we also don't
> have encrypted association response and we still take information from
> there too, etc.
> 
> johannes
I prefer to add a new enum(not use BSS_CHANGED_TXPOWER),e.g, 
BSS_CHANGED_PWR_ENV.
And add check in ieee80211_rx_mgmt_beacon() as well as 
ieee80211_handle_pwr_constr(),
when the value of pwr_reduction or content of elems.tx_pwr_env changed,
save the pwr_reduction and elems.tx_pwr_env to ieee80211_bss_conf, and 
notify lower
driver with BSS_CHANGED_PWR_ENV, then lower driver will do next action.
