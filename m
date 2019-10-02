Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59AC477B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfJBGFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:05:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfJBGFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:05:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0B3D61728; Wed,  2 Oct 2019 06:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569996337;
        bh=DF+HW6wwmJzYoEIrxyHBzQsB32Vt++k7jcLNJ4FIdkQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TaJk2PjroQBJnnxISNMqNzo8+NH/9buRv5Ov8ia4195It4HQcP7Z9iEzSP1pnyJvK
         A48XwfqfqELzcG5+y6AlKyFO5DkYeWxl8DbXErvopo2qIkch5uQo3AJNnCIgXBz4aK
         Ei03eyaWWUV50LD70Ez6Bpk47oGVsHB7o2r7jePg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2D7661728;
        Wed,  2 Oct 2019 06:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569996337;
        bh=DF+HW6wwmJzYoEIrxyHBzQsB32Vt++k7jcLNJ4FIdkQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TaJk2PjroQBJnnxISNMqNzo8+NH/9buRv5Ov8ia4195It4HQcP7Z9iEzSP1pnyJvK
         A48XwfqfqELzcG5+y6AlKyFO5DkYeWxl8DbXErvopo2qIkch5uQo3AJNnCIgXBz4aK
         Ei03eyaWWUV50LD70Ez6Bpk47oGVsHB7o2r7jePg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2D7661728
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Antonio Quartulli <antonio.quartulli@kaiwoo.ai>
Cc:     greearb@candelatech.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: Fix offchannel tx failure when no ath10k_mac_tx_frm_has_freq
References: <1508284992-3574-1-git-send-email-greearb@candelatech.com>
        <ba256006-b42b-0dee-4eb7-093da5885341@kaiwoo.ai>
Date:   Wed, 02 Oct 2019 09:05:33 +0300
In-Reply-To: <ba256006-b42b-0dee-4eb7-093da5885341@kaiwoo.ai> (Antonio
        Quartulli's message of "Mon, 30 Sep 2019 16:29:32 +0200")
Message-ID: <87tv8r3cnm.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Antonio Quartulli <antonio.quartulli@kaiwoo.ai> writes:

> Hi,
>
> On 18/10/2017 02:03, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>> 
>> This bug appears to have been added between 4.0 (which works for us),
>> and 4.4, which does not work.
>> 
>> I think this is because the tx-offchannel logic gets in a loop when
>> ath10k_mac_tx_frm_has_freq(ar) is false, so pkt is never actually
>> sent to the firmware for transmit.
>> 
>> This patch fixes the problem on 4.9 for me, and now HS20 clients
>> can work again with my firmware.
>> 
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>
> I have been struggling to send offchannels mgmt frames since a while, as
> I was always getting:
>
> [18099.253732] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e3780
> [18102.293686] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e3780
> [18105.333653] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e3780
> [18108.373712] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e3780
> [18111.413687] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e36c0
> [18114.453726] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e3f00
> [18117.493773] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e36c0
> [18120.533631] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
> skb cf0e3f00
>
> After digging through the ath10k patchwork I have found this patch which
> touches exactly the code I was trying to debug.
>
> After applying this set of changes, I can confirm that sending
> offchannel frames works again like a charm.
>
> I have tested only one fw though: ver 10.4-3.5.3-00057.
>
> It's a bummer that this trivial but critical patch is not yet merged
> upstream :-(

Ben has it's own firmware and own hacks in kernel so I can't apply them
without testing, and it's just very difficult for me to find time to
test anything right now.

> Tested-by: Antonio Quartulli <antonio.quartulli@kaiwoo.ai>

Thanks! What hardware did you test this? I'll add that to the commit
log.

The patch also had some conflicts which I fixed in the pending branch,
please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bdc657dd0c0cb7163fcf39b94e664e3d9409140e

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
