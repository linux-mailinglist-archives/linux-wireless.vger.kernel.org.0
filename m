Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F303EB343
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhHMJRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 05:17:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52842 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238823AbhHMJRU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 05:17:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628846214; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fx6grdp4Bl6eyW5Q7Xj5xAn+VMkAsb769KNlsKMiU7o=;
 b=CZEKdxnj1qQkEKFzshzz4l2e/5Y1VrW6UI67LA13P1ZDerc4d9+xPjXRm7YJvfxmTpO0qVx+
 uPR5deSQCxM991Pr3n2mUpogKudaPdPbisVsK1zwuChq9dfq4wEjvyb+RE7igIXquI+TPuov
 52lQxYGnqsLaWvcJ8Ph2aX2Qm8Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6116388566ff1079040dafa9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Aug 2021 09:16:53
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 547A9C4338A; Fri, 13 Aug 2021 09:16:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D944AC433F1;
        Fri, 13 Aug 2021 09:16:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Aug 2021 17:16:51 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <f61cdc7bae2dd2a645e164ca143b9db402472559.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-10-wgong@codeaurora.org>
 (sfid-20210517_222034_029448_A9A89D57)
 <d9491db4ece67ac78eb39a1078b91a106770fbb0.camel@sipsolutions.net>
 <1126f8d996e895ae048092b3f8aad19b@codeaurora.org>
 <38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net>
 <1273cc1a399a7457c3d908648a7651c8fe9b93f3.camel@sipsolutions.net>
 <a056e32d4911400fb0822bf02167e91c@codeaurora.org>
 <f61cdc7bae2dd2a645e164ca143b9db402472559.camel@sipsolutions.net>
Message-ID: <465b6b8535fc17ae51ee2f3116af87bb@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-13 16:53, Johannes Berg wrote:
> On Fri, 2021-08-13 at 16:47 +0800, Wen Gong wrote:
>> > > > > 2) Should we at least check it again from the protected beacon or such
>> > > > > after association, so we don't blindly trust the probe response or
>> > > > > beacon (received during scan, not validated) at least when BIGTK is in
>> > > > > use?
>> > > >
>> > > > May we add support for BIGTK in future with another patch?
>> > >
>> > > We already have BIGTK support in mac80211, so if we don't do that now
>> > > we're almost certainly not going to do it, so I'd really prefer if you
>> > > did it here, or if a separate patch still did it now.
>> >
>> > Actually, I should say though - the question was more whether we even
>> > need/want that, rather than whether we can do it later or not.
>> >
>> > If we should protect this data/information then IMHO we should do it
>> > now, but it's not clear to me that we should, given that we also don't
>> > have encrypted association response and we still take information from
>> > there too, etc.
>> >
>> > johannes
>> I prefer to add a new enum(not use BSS_CHANGED_TXPOWER),e.g,
>> BSS_CHANGED_PWR_ENV.
>> And add check in ieee80211_rx_mgmt_beacon() as well as
>> ieee80211_handle_pwr_constr(),
>> when the value of pwr_reduction or content of elems.tx_pwr_env 
>> changed,
>> save the pwr_reduction and elems.tx_pwr_env to ieee80211_bss_conf, and
>> notify lower
>> driver with BSS_CHANGED_PWR_ENV, then lower driver will do next 
>> action.
>> 
> I don't really have any objection to this, but OTOH it feels like
> drivers will probably not really listen to this if it can only happen
> due to BIGTK?
yes, it should have some flag/logic to check whether it is BIGTK.
If you know it, you can tell me. :)
> 
> And if we always defer this until the first beacon, that also feels
> wrong and bad?
It can not defer this untill the 1st beacon which pass BIGTK verify.
Lower driver need this info to set power before TX data include EAPOL.
> 
> I'm not sure what the right answer here is, TBH.
> 
> Maybe the right answer is to indeed ignore beacon protection for this,
> and do exactly what you did here, and say that the TX power envelope
> thing is just not meant to be protected, because the protection is 
> meant
> to protect the connection etc. and not the performance (and 
> regulatory?)
Yes, the lower driver also have the max power limit itself. If power 
calulated
from the fake beacon is bigger than the max power limit, then it will be
ignored.
> 
> Do we get this *only* in the beacon, or also in the association
> response? If it's also in the association response we could use the 
> data
> from *there*, and basically say that the association response might 
> need
> some protection (later) anyway?
> 
The Transmit Power Envelope is not existed in the assoc response, it is 
existed
in beacon. So it can not use assoc response.

beacon:
IEEE 802.11 wireless LAN
     Fixed parameters (12 bytes)
         Timestamp: 0x0000005070684036
         Beacon Interval: 0.102400 [Seconds]
         Capabilities Information: 0x0511
     Tagged parameters (264 bytes)
         Tag: SSID parameter set: Renhui-6G
         Tag: Supported Rates and BSS Membership Selectors 6.0(B), 9, 
12.0(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
         Tag: Traffic Indication Map (TIM): DTIM 0 of
         Tag: Country Information: Country Code US, Environment Unknown 
(0x04)
         Tag: Power Constraint: 3
         Tag: TPC Report Transmit Power: 17, Link Margin: 0
         Tag: Extended Supported Rates and BSS Membership Selectors BSS 
requires support for direct hashing to elements in SAE, [Mbit/sec]
         Tag: RSN Information
         Tag: Extended Capabilities (11 octets)
         Tag: Transmit Power Envelope
         Tag: Transmit Power Envelope
         Ext Tag: Reserved (55)
         Ext Tag: HE Capabilities (IEEE Std 802.11ax/D2.0)
         Ext Tag: HE Operation (IEEE Std 802.11ax/D2.0)
         Ext Tag: Spatial Reuse Parameter Set
         Ext Tag: MU EDCA Parameter Set
         Ext Tag: 6GHz Band Capabilities

assoc response:
IEEE 802.11 wireless LAN
     Fixed parameters (6 bytes)
         Capabilities Information: 0x0511
         Status code: Successful (0x0000)
         ..00 0000 0001 0001 = Association ID: 0x0011
     Tagged parameters (169 bytes)
         Tag: Supported Rates and BSS Membership Selectors 6.0(B), 9, 
12.0(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
         Tag: Extended Supported Rates and BSS Membership Selectors BSS 
requires support for direct hashing to elements in SAE, [Mbit/sec]
         Tag: Extended Capabilities (11 octets)
         Ext Tag: HE Capabilities (IEEE Std 802.11ax/D2.0)
         Ext Tag: HE Operation (IEEE Std 802.11ax/D2.0)
         Ext Tag: Spatial Reuse Parameter Set
         Ext Tag: MU EDCA Parameter Set
         Ext Tag: 6GHz Band Capabilities

> johannes
