Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A355285A68
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgJGIZG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 04:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgJGIZG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 04:25:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A532083B;
        Wed,  7 Oct 2020 08:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602059106;
        bh=xgXZxLF7Q2kKnEhr4N2izN2RLVvieC97CGQtepl2njA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDALeaB5VU+AEVDyEHri7H+8+mANo17LvgKTcmfEDO6OL88YnXloylZ24qEGUfOG9
         Ko3yYzWuMGeOqk9wLzhum2zS+9e310KQ0kWZTi+7xgLT2GJKe0rPnsLqPfg7cxnbed
         1GW35z3O5Ibvr/bRBbvdOceMUm/9U4xKxZ7j7J8A=
Received: by pali.im (Postfix)
        id 25A664F1; Wed,  7 Oct 2020 10:25:03 +0200 (CEST)
Date:   Wed, 7 Oct 2020 10:25:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jouni Malinen <j@w1.fi>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
Message-ID: <20201007082502.3da6rw2bkudilqaq@pali>
References: <20200810090126.mtu3uocpcjg5se5e@pali>
 <20200812083600.6zxdf5pfktdzggd6@pali>
 <87lfik1av8.fsf@toke.dk>
 <20200812092334.GA17878@w1.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812092334.GA17878@w1.fi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wednesday 12 August 2020 12:23:34 Jouni Malinen wrote:
> On Wed, Aug 12, 2020 at 11:17:47AM +0200, Toke Høiland-Jørgensen wrote:
> > Pali Rohár <pali@kernel.org> writes:
> > > Could somebody react and provide some details when fixes would be
> > > available for ath9k and ath10k Linux drivers? And what is current state
> > > of this issue for Linux?
> > >
> > > I'm looking at ath9k and ath10k git trees [1] [2] [3] and I do not see
> > > there any change which could be related to CVE-2020-3702.
> > 
> > How about these, from March:
> > 
> > a0761a301746 ("mac80211: drop data frames without key on encrypted links")
> > ce2e1ca70307 ("mac80211: Check port authorization in the ieee80211_tx_dequeue() case")
> > b16798f5b907 ("mac80211: mark station unauthorized before key removal")
> 
> Those cover most of the identified issues for drivers using mac80211
> (e.g., ath9k and ath10k; though, I don't remember whether I actually
> ever managed to reproduce this with ath10k in practice). I have couple
> of additional ath9k-specific patches that cover additional lower layer
> paths for this. I hope to get those out after confirming they work with
> the current kernel tree snapshot.

Hello! Could you please share your ath9k patches which address this issue?
