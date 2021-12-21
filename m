Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0673847BDC9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhLUJ6B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 04:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhLUJ6A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 04:58:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F07C061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 01:58:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45C42614B7
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 09:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A519FC36AE2;
        Tue, 21 Dec 2021 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640080679;
        bh=3B3BEE++w2lQuM6+elGAcYKeVc5hHSDFiICQ+o8ABmE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b880flp0fmDACiSsvBcTAFvRZh0K+PGUueG0Kfb+v85b0cGTOsDuG4CXUDR62R9EF
         kVeubXHZrvKqbg5CQHi9swcGpzElGBSIKrGl7NtPWpHC+llR6p5gmugLQfhavDlhbd
         Q4Yv9Lr6ed22vRQMdeHLmWAnqljOXM39+Ur+MUqWQrGC9h0CcVq9UVvNXRVS8IqTeP
         HMwazhZiynynA9q9gbg7FQZHLfdnupZzFUmD40j4jw0ArQ+yQj+dvwSa0E2zysONcd
         0oX2H43hxJN+61ZHmOCKDNN1FE31iGp4jF4vwxsVggkcx0Hbladbd4pfq66inM7BeK
         YCkQ0NMmaF11A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     P Praneesh <quic_ppranees@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] ath11k: add LDPC FEC type in 802.11 radiotap header
References: <1638294648-844-3-git-send-email-quic_ppranees@quicinc.com>
        <164002780766.16553.11348226804666046524.kvalo@kernel.org>
        <534d1f71596289581e9229c3087e2ac2f7528ebe.camel@sipsolutions.net>
Date:   Tue, 21 Dec 2021 11:57:54 +0200
In-Reply-To: <534d1f71596289581e9229c3087e2ac2f7528ebe.camel@sipsolutions.net>
        (Johannes Berg's message of "Mon, 20 Dec 2021 20:59:09 +0100")
Message-ID: <87ee669t5p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2021-12-20 at 19:16 +0000, Kalle Valo wrote:
>> P Praneesh <quic_ppranees@quicinc.com> wrote:
>> 
>> > LDPC is one the FEC type advertised in msdu_start info2 for HT packet
>> > type. Hence, add hardware specific callback for fetching LDPC
>> > support from msdu start and enable RX_ENC_FLAG_LDPC flag while passing
>> > rx status to mac80211.
>> > 
>> > Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
>> > 
>> > Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> 
>> Depends on:
>> 
>> 57553c3a6cfe ("mac80211: fix FEC flag in radio tap header")
>
> Technically, you could apply it, it just won't be very useful until you
> have both together.

Ok, thanks. But to keep things simple I'll still wait for the mac80211
patch to land ath-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
