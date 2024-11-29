Return-Path: <linux-wireless+bounces-15806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFF9DECB8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 21:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0768A280F74
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DCF13AA35;
	Fri, 29 Nov 2024 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="r6LZEjV1";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="gSE15N72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD514D430
	for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912519; cv=none; b=X+2/hF/PipMTDFO90AZyJ20XWMPuXaRxRcNFHy5FzPn0aMNHFN0Kz2GIZ5cy77u8oyX97H1ISbbqQf/tzy6SQWs/ztnbCTQMMRbv5qgVotJE2UlQRPoGnHgKWQpPJHJ+aWW2ki9nvXLiJ6O8mC639ZEW/QskvyDNAeaD+Caaa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912519; c=relaxed/simple;
	bh=aGDvme90kra/854MU3oFLqBqzJ3x+zm28GSw+g1bjTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GunKa6Nmql5oAxZTDfvJtjFpr4ZkR6+AjkY+/gOE3OGJViBJkKdk5RjiPK5l7vFTiha7slnUsnzW2kHUq/JKCeP8uxKQ/gL8n3A+azOTUrOfk76mY1vMRXzpen2XZKOtw8FJqIQSdhR7PrpjMFIOzeS5FA1iUc0DDgDvqeNk6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=r6LZEjV1 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=gSE15N72; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732913415; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=+IctVdeL53Qnwh11oA+U96b5MaLBOX2K54knitT6yn0=; b=r6LZEjV1b/7X2kIVJEl5qGoOhX
	gTfZlKlJvVdrSgy2qnLIeb4NqijLZVPo0Om32B/rE3LSLdJKhATI8hvFs1I1KGRR6v5pKSECFjMw+
	JgrNiSw1CsmR5R0BBtVEkz/WxGM+g1VV2S4bfWUGugxYuakoSt0V7Z1anc6ncpcTi6wBGsMBT1RBu
	Syon6gH9oac+L4Xq/VEDeLV65jOPPoOgCNflqQ8xi9cGObIEZ3PiWaxJuHua7fq01BPRBu6nT3zw9
	DTQHe3+PO1OrxNEG2wdlZf7fCGo7ZKocHvGW3JaLA0ukzzRHUu9qHnzQSqG+SNoMUEv55GT028WxS
	rcSwPT1w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732912515; h=from : subject
 : to : message-id : date;
 bh=+IctVdeL53Qnwh11oA+U96b5MaLBOX2K54knitT6yn0=;
 b=gSE15N72ECNsflQanrwMfbkEbwoP9pWsEh0a1LmAhudGjsAtKhu+UmidJ6/67NVovPAaT
 oVn/bCLR1hCCaffXjujtWuRg4Xb+W2mozdAHqce6KQTVDk0+IGTQwe4zm0nQM6ljrpdO4EY
 HvQRlmsvaakCaJrna0iRLvvC8kNXJTSDOMryYanUXZo4UT7R5plTS63IvJdppZsHEg+GLJi
 3HYqlUmjKgyfNz8Hxctu9a4uSap+YSWIzIlOdklqhh915oT1+Q/r+4mJgdOUEILscO+whQw
 wgJrO4tZZmV06pCBUL0THpZU28hvth5Ucj0ZOCl2vcUyBYh4iOs9S13c9Y2Q==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tH3vp-TRjzld-Ag; Fri, 29 Nov 2024 16:33:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tH3vp-4o5NDgrmzk3-oOOG; Fri, 29 Nov 2024 16:33:25 +0000
Date: Fri, 29 Nov 2024 17:31:58 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: James Prestwood <prestwoj@gmail.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Subject: Re: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
Message-ID: <Z0nsfoiPOHiKIXvH@pilgrim>
References: <cover.1732293922.git.repk@triplefau.lt>
 <20215f63-e2e6-4f9a-bbbe-d7535c5ce9d2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20215f63-e2e6-4f9a-bbbe-d7535c5ce9d2@gmail.com>
X-Smtpcorp-Track: IBozaR4ZYTWg.HQ16rUlMDzQi.83MiLwIotJv
Feedback-ID: 510616m:510616apGKSTK:510616sMuY_9l13u
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi James,

On Tue, Nov 26, 2024 at 04:57:36AM -0800, James Prestwood wrote:
> Hi Remi,
> 
> On 11/22/24 8:48 AM, Remi Pommarel wrote:
> > It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
> > radio silence could be observed followed by the error below on ath10k
> > devices:
> > 
> >   ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0
> > 
> > This is due to how the TX queues are flushed in ath10k. When a STA is
> > removed, mac80211 need to flush queues [1], but because ath10k does not
> > have a lightweight .flush_sta operation, ieee80211_flush_queues() is
> > called instead effectively blocking the whole queue during the drain
> > causing this radio silence. Also because ath10k_flush() waits for all
> > queued to be emptied, not only the flushed ones it could more easily
> > take up to 5 seconds to finish making the whole situation worst.
> > 
> > The first patch of this series adds a .flush_sta operation to flush only
> > specific STA traffic avoiding the need to stop whole queues and should
> > be enough in itself to fix the reported issue.
> > 
> > The second patch of this series is a proposal to improve ath10k_flush so
> > that it will be less likely to timeout waiting for non related queues to
> > drain.
> > 
> > The abose kernel warning could still be observed (e.g. flushing a dead
> > STA) but should be now harmless.
> > 
> > [0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
> > [1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> 
> I saw in the original report that it indicated it was only for AP mode but
> after seeing this and checking some of our clients I saw that this is also
> happening in station mode too. I only have clients on 6.2 and 6.8. I can
> confirm its not occurring on 6.2, but is on 6.8. I also tried your set of
> patches but did not notice any behavior difference with or without them.
> When it happens, its always just after a roam scan, ~4 seconds go by and we
> get the failure followed by a "Connection to AP <mac> lost". Oddly the MAC
> address is all zeros.
> 
> Nov 25 09:09:50 iwd[16256]: src/station.c:station_start_roam() Using cached
> neighbor report for roam
> Nov 25 09:09:54 kernel: ath10k_pci 0000:02:00.0: failed to flush transmit
> queue (skip 0 ar-state 1): 0
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME
> notification Del Station(20)
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_link_notify() event 16 on
> ifindex 7
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME
> notification Deauthenticate(39)
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_deauthenticate_event()
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_mlme_notify() MLME
> notification Disconnect(48)
> Nov 25 09:09:54 iwd[16256]: src/netdev.c:netdev_disconnect_event()
> Nov 25 09:09:54 iwd[16256]: Received Deauthentication event, reason: 4,
> from_ap: false
> Nov 25 09:09:54 kernel: wlan0: Connection to AP 00:00:00:00:00:00 lost
> 
> Other times, the above logs are preceded by this:
> 
> Nov 26 00:25:25 kernel: ath10k_pci 0000:02:00.0: failed to flush sta txq
> (sta ca:55:b8:7a:91:4b skip 0 ar-state 1): 0
> 
> Note, the above logs are with your patches applied. Maybe this is a separate
> issue? Or do you think its related?

Thanks fot the test. Yes this patchset is here only to fix the issue for
AP (this caused AP to stall all traffic for every STA connected to it).
So while this issue is interesting it is not addressed by this patchset.

Out of curiosity I tried to reproduce it currently trying to roam an
ath10k sta back and forth two APs (same SSID/psk, different channels)
and wasn't able to reproduce with wpa_supplicant, didn't try with iwd
though. Or maybe the AP the sta is roaming away from has stopped
responding, in that case I don't know what can be done here as it does
not seem we want to drop pending frames (as we would prefer to deauth
cleanly from AP in main case).

In any case still I think this is a separate issue and it is also way
less critical than the AP one (one STA can create ~4sec DOS to the
entire BSS vs a STA took more time to roam away if AP crashed).

Thanks,

-- 
Remi

> 
> Thanks,
> 
> James
> 
> > 
> > V3:
> >    - Initialize empty to true to fix smatch error
> > 
> > V2:
> >    - Add Closes tag
> >    - Use atomic instead of spinlock for per sta pending frame counter
> >    - Call ath10k_htt_tx_sta_dec_pending within rcu
> >    - Rename pending_per_queue[] to num_pending_per_queue[]
> > 
> > Remi Pommarel (2):
> >    wifi: ath10k: Implement ieee80211 flush_sta callback
> >    wifi: ath10k: Flush only requested txq in ath10k_flush()
> > 
> >   drivers/net/wireless/ath/ath10k/core.h   |  2 +
> >   drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
> >   drivers/net/wireless/ath/ath10k/htt_tx.c | 49 +++++++++++++++-
> >   drivers/net/wireless/ath/ath10k/mac.c    | 75 ++++++++++++++++++++----
> >   drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
> >   5 files changed, 127 insertions(+), 21 deletions(-)
> > 

