Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689E974EC67
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGKLMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 07:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGKLMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 07:12:44 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D018D
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Dd+7wNioSMr7f6iy1H0hUOUn4CdjNtwL/S3FkoiVhz0=; b=hjhgaxNuJLhNikHs63JLRoWYLv
        3YshzsRxup/o7RFKvdaUvX1t5weypZRxIgdChs40ecAQZnRZ4IhD2w5c70rs7RjhjPePfumIVObg1
        f1FmupwlKahpobHSRwVfYSjwPL4XJExZCbDd2TGiP76k7JI56qWHLHsdOQS3WKtN7Nx8=;
Received: from p4ff134dd.dip0.t-ipconnect.de ([79.241.52.221] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qJBI7-00Gtjt-CV; Tue, 11 Jul 2023 13:12:23 +0200
Message-ID: <4bb71d8a-daf1-5f60-daf0-44aa8afcfdc3@nbd.name>
Date:   Tue, 11 Jul 2023 13:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
Content-Language: en-US
To:     Nicolas Escande <nico.escande@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rg?= =?UTF-8?Q?ensen?= 
        <toke@toke.dk>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse> <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
 <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
 <809500b6-4eec-7a5e-5930-00e7eeebcc5e@leemhuis.info>
 <CTYNAK10A6AJ.1I4W9V78VG1NB@syracuse>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CTYNAK10A6AJ.1I4W9V78VG1NB@syracuse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.07.23 18:50, Nicolas Escande wrote:
> On Mon Jul 10, 2023 at 1:32 PM CEST, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 16.06.23 09:45, Nicolas Escande wrote:
>> > On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thorsten Leemhuis) wrote:
>> >> On 10.06.23 08:44, Bagas Sanjaya wrote:
>> >>> On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
>> >>>>
>> >>>> As user of the mesh part of mac80211 on multiple products at work let me say
>> >>>> thank you for all the work you do on wifi, especially on 80211s, and especially
>> >>>> the recent improvements you made for mesh fast RX/TX & cross vendor AMSDU compat
>> >>>>
>> >>>> We upgraded our kernel from an older (5.15) to a newer 6.4. The problem is STP 
>> >>>> doesn't work anymore and alas we use it for now (for the better or worse).
>> >>>>
>> >>>> What I gathered so far from my setup:
>> >>>>  - we use ath9k & ath10k
>> >>>>  - in my case STP frames are received as regular packet and not as amsdu
>> >>>>  - the received packets have a wrong length of 44 in tcpdump
>> >>>>    (instead of 38 with our previous kernel)
>> >>>>  - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes packet
>> >>>>    this makes llc_rcv() discard the frames & breaks STP
>> >>>>
>> >>>> >From bisecting the culprit seems to be 986e43b19ae9176093da35e0a844e65c8bf9ede7
>> >>>> (wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)
>> >>>>
>> >>>> I guess that your changes to handle both ampdu subframes & normal frames in the
>> >>>> same datapath ends up putting a wrong skb->len for STP (multicast) frames ?
>> >>>> Honestly I don't understand enough of the 80211 internals & spec to pinpoint the
>> >>>> exact problem.
>> >>>>
>> >>>> It seems this change was already in the 6.3 kernel so I guess someone should
>> >>>> have seen it before (but I didn't find anything..) ? Maybe I missed something...
>> >>>>
>> >>>> Anyway I'm happy to provide more info or try anything you throw at me.
>> >> [...]
>> >> Hmmm, Felix did not reply. But let's ignore that for now.
>> > 
>> > I haven't seen mails from felix on the list for a few days, I'm guessing he's
>> > unavailable for now but I'll hapilly wait.
>>
>> Still no progress. Hmmm. Are you still okay with that? I've seen no
>> other reports about this, so waiting is somewhat (albeit not completely)
>> fine for me if it is for you.
> I'm not so surprised no one else reported it, using STP on wifi (and 802.11s) is
> not a really common thing to do, to be honest (and STP on wifi is unreliable).
> Even though some openwrt guys do it for sure, I'm guessing their kernel version
> is lagging behind...
>>
>> But in any case it might be good if you could recheck 6.5-rc1.
> Testing on 6.5 as a whole won't be as easy for me as testing a single patch on
> top of 6.4. I'll do my best to try but from what I saw nothing got merged that
> would even remotely help me on this issue.
> 
> I am not loosing hope that Felix or someone that understands this stuff better
> finds the time to look into this. I'm guessing it's the summer vacation effet.

Sorry for the delay. This should fix the regression, please test.
I will submit it for 6.5 soon.
---
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -580,6 +580,8 @@ int ieee80211_strip_8023_mesh_hdr(struct
  		hdrlen += ETH_ALEN + 2;
  	else if (!pskb_may_pull(skb, hdrlen))
  		return -EINVAL;
+	else
+		payload.eth.h_proto = htons(skb->len - hdrlen);

  	mesh_addr = skb->data + sizeof(payload.eth) + ETH_ALEN;
  	switch (payload.flags & MESH_FLAGS_AE) {


