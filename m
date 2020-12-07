Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD25A2D1312
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 15:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgLGOFW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 09:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGOFW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 09:05:22 -0500
Date:   Mon, 7 Dec 2020 15:04:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607349881;
        bh=vdkKebf8gEXL8ONlu/UAMvJi/xFSl6aR1tW/dS93hxk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNk1/K5Og77Fs+dBKJJsgjtk6QEM/f1jLRRMGu3yhL9YzX8dAOGM1tWatcAWwAnBO
         OugBVGEvbY4qa+WlPqGm4V4TtTv2+kbV4RR3f6ia8BW4ulVoMEqwm/L4dwJpc9jZea
         OPRwFUAOE8PBJ/kYw/3KQZp3JjonSVb64EUT/ar+pNpsRDeSI9G8l4anc+cANcn0ZD
         hiyljk/xsXHybQF8Soxy/ab7aVn5+tLwKsTM/46jMUvJ0u0JaV48xqAf1QgebaoRJm
         pdknJyQ4wsPJffc7lqDo4MyNdjMzNpc6MaG2h3bpm5xKU6KuEU0gSvI2GdBsr4NrR4
         qGzXsdBoV46IA==
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jouni Malinen <j@w1.fi>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
Message-ID: <20201207140438.as2i7kwquhdxqn53@pali>
References: <20200810090126.mtu3uocpcjg5se5e@pali>
 <20200812083600.6zxdf5pfktdzggd6@pali>
 <87lfik1av8.fsf@toke.dk>
 <20200812092334.GA17878@w1.fi>
 <20201007082502.3da6rw2bkudilqaq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007082502.3da6rw2bkudilqaq@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wednesday 07 October 2020 10:25:02 Pali Rohár wrote:
> On Wednesday 12 August 2020 12:23:34 Jouni Malinen wrote:
> > On Wed, Aug 12, 2020 at 11:17:47AM +0200, Toke Høiland-Jørgensen wrote:
> > > Pali Rohár <pali@kernel.org> writes:
> > > > Could somebody react and provide some details when fixes would be
> > > > available for ath9k and ath10k Linux drivers? And what is current state
> > > > of this issue for Linux?
> > > >
> > > > I'm looking at ath9k and ath10k git trees [1] [2] [3] and I do not see
> > > > there any change which could be related to CVE-2020-3702.
> > > 
> > > How about these, from March:
> > > 
> > > a0761a301746 ("mac80211: drop data frames without key on encrypted links")
> > > ce2e1ca70307 ("mac80211: Check port authorization in the ieee80211_tx_dequeue() case")
> > > b16798f5b907 ("mac80211: mark station unauthorized before key removal")
> > 
> > Those cover most of the identified issues for drivers using mac80211
> > (e.g., ath9k and ath10k; though, I don't remember whether I actually
> > ever managed to reproduce this with ath10k in practice). I have couple
> > of additional ath9k-specific patches that cover additional lower layer
> > paths for this. I hope to get those out after confirming they work with
> > the current kernel tree snapshot.
> 
> Hello! Could you please share your ath9k patches which address this issue?

Hello! Has somebody fixes this security issue in ath9k driver? About
4 months passed and if this issue is not fixed, could you please share
at least incomplete / WIP patches? I would like to look at it and have
this issue finally fixed.
