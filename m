Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9761242770
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHLJZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 05:25:52 -0400
Received: from mail.w1.fi ([212.71.239.96]:51338 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbgHLJZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 05:25:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 546EA119DD;
        Wed, 12 Aug 2020 09:25:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id umUOe7D2X-bP; Wed, 12 Aug 2020 09:25:48 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 12 Aug 2020 12:23:34 +0300
Date:   Wed, 12 Aug 2020 12:23:34 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
Message-ID: <20200812092334.GA17878@w1.fi>
References: <20200810090126.mtu3uocpcjg5se5e@pali>
 <20200812083600.6zxdf5pfktdzggd6@pali>
 <87lfik1av8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfik1av8.fsf@toke.dk>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 12, 2020 at 11:17:47AM +0200, Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:
> > Could somebody react and provide some details when fixes would be
> > available for ath9k and ath10k Linux drivers? And what is current state
> > of this issue for Linux?
> >
> > I'm looking at ath9k and ath10k git trees [1] [2] [3] and I do not see
> > there any change which could be related to CVE-2020-3702.
> 
> How about these, from March:
> 
> a0761a301746 ("mac80211: drop data frames without key on encrypted links")
> ce2e1ca70307 ("mac80211: Check port authorization in the ieee80211_tx_dequeue() case")
> b16798f5b907 ("mac80211: mark station unauthorized before key removal")

Those cover most of the identified issues for drivers using mac80211
(e.g., ath9k and ath10k; though, I don't remember whether I actually
ever managed to reproduce this with ath10k in practice). I have couple
of additional ath9k-specific patches that cover additional lower layer
paths for this. I hope to get those out after confirming they work with
the current kernel tree snapshot.

-- 
Jouni Malinen                                            PGP id EFC895FA
