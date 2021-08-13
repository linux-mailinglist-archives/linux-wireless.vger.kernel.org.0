Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A73EB263
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 10:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhHMIN5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 04:13:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:13504 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbhHMIN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 04:13:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628842411; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=wBGHTJ10sptczyAv1wSDcQxlqoupZwcFkpRzgxG+WkQ=;
 b=GPl4BftHL5UfprMcgc4qarEPLLmy7tyRoH6SYk1vfUQciWJicrhvPL5+DjNFI1cgP3anKYUy
 lUXuiuwN6AkhT1qwyC7McpjF3EGqfEXLpyiPnwrJWaiMW31eVHpvJ6QFAT8HExG1uadocrDz
 H43GoAJ9Ti1O/E/Crp4M+5H5r0I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 611629a6b3873958f5acba85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 08:13:26
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70445C433F1; Fri, 13 Aug 2021 08:13:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E951AC433D3;
        Fri, 13 Aug 2021 08:13:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Aug 2021 16:13:24 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-10-wgong@codeaurora.org>
 (sfid-20210517_222034_029448_A9A89D57)
 <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
 <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
 <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
Message-ID: <bdbef7e30bf8d84049cd60a6350836e1@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-13 15:19, Johannes Berg wrote:
> On Fri, 2021-07-30 at 18:47 +0800, Wen Gong wrote:
>> 
>> > And then two more questions:
>> >
>> > 1) Could this information change? Should we track it in beacons?
>> >
>> 
>> The information is from AP side, it should be not changed untill the 
>> AP
>> restart.
>> If someone want to change configure of AP, the AP should restart and
>> then take effect by my understand.
>> Is it have some case for this information change?
> 
> No, I guess that's fine then, I just didn't know.
> 
>> > 2) Should we at least check it again from the protected beacon or such
>> > after association, so we don't blindly trust the probe response or
>> > beacon (received during scan, not validated) at least when BIGTK is in
>> > use?
>> 
>> May we add support for BIGTK in future with another patch?
> 
> We already have BIGTK support in mac80211, so if we don't do that now
> we're almost certainly not going to do it, so I'd really prefer if you
> did it here, or if a separate patch still did it now.
> 
>> The info(pwr_reduction and tx_pwr_env) is used by lower driver such as
>> ath11k.
> 
> Sure.
> 
>> If the info changed after association, then how to notify lower 
>> driver?
>> Do it like below in ieee80211_rx_mgmt_beacon()?
>> And use BSS_CHANGED_TXPOWER or a new enum in ieee80211_bss_change?
> 
> Yeah, dunno. Are the drivers assuming now it's set once you get to
> associated state?

yes, driver need this info while associate process.

> 
> johannes
