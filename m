Return-Path: <linux-wireless+bounces-14205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7F9A3730
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16756282F8D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67DB16D4E6;
	Fri, 18 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="hsNQSm3u";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="jOgT6PNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CC13D51E
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236740; cv=none; b=TRt3YC6E4z+fbHIGhvDzCOraJ0tPmGbLy+QKjZcT+/vv1Lu+sLS4x90RTAJyOxxdTUMc+/cQM9gyhyV/2aEv28LF1TXweCkjP2DeRFXCxZel6Lfa5lo8xsgEm8fXGvwjRRQ72GyjAZNDDXeX8RBpic97OmE2cFaE04g/djIhR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236740; c=relaxed/simple;
	bh=ZhaL1Kv0REb9l4nfCMKxPrXkvaeya1vprE3n5Ut4Scs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6AkA6i7rwYbIJGyctJvB4WXxetNX9IUR0jZB4iMEMaEzTCnnj/kdEOf05DK432joIPh494pFShnlyqC4pWgUs2/8C09CzhXK/F4GOfgagQZ/gLSSE+pF1aFGF+wWw7CozK6jzpq6BcQQEwiBmIiqm7MEFMOe2wpcmhtLGcRMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=hsNQSm3u; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=jOgT6PNV; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729237636; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=8PDd4QTcUgUWvTz38ShhzLJf4muGLCDzjQvYxmLqn1k=; b=hsNQSm3uXzD8QohZTGAZsxEkth
	C0+uT6McK7eeX67rrHTkWJhn62nhSKgbr3eFiQugfocvl+Qp7ve0xj42HxpVGU9gHYBIqnAQD49hG
	JD1aJlV2UH14NKWTQOG0hFndWeH64eAzNSWtyj7p8luvlm5t6Uf0pUbH5jEZU9sHxa4LYQD36L0XP
	Pqhyr7cMOawev8ILBC+/gxOqT97LEryakTjdG4r/d2SndLXAZtJ3pDWUOfVBa3dN4g2MdQEDrTWjp
	QT+xO4DNmqjmpgRQlT/MRPHujBWux/oU8YSTkKK7TwhmSsQS/Oz/LmPDbXspebgUZuLj2kMtGXS8e
	lUF9lFmw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729236736; h=from : subject
 : to : message-id : date;
 bh=8PDd4QTcUgUWvTz38ShhzLJf4muGLCDzjQvYxmLqn1k=;
 b=jOgT6PNV/tyF2U4+byqH4RZF9+03cCNL/ivWHmSB604gs+vM64zK2Zmm+NDxi/NqamdEC
 GAk01wvuzL1IhqUmy2hcXTlRUy1rAfeT9yfoHm6HzaL9y4GLktKI244bsLUtZYVU+bjZBrO
 4qRrKpG+KTqdzi2/sZlr2xgQzpXhkvFs1TRM0XBpPz/2b4jN2wkJyCTKacdRf1tEFcbaXKu
 wj9PXfz7r9ZWunSBl+m5By5uAamlNdkdFUSnU5nmrInvwdACivY1zLMl+I6HYRbTbjqu/fw
 Yh+ghj7sqKZPk80DDyD6vwHB5kl2VbeqcjQlcoWDIdBb5zOx4U4C4HeJ+U+Q==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t1hSn-TRjyG1-4L; Fri, 18 Oct 2024 07:31:57 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t1hSm-FnQW0hPkgPp-nZ6G; Fri, 18 Oct 2024 07:31:56 +0000
Date: Fri, 18 Oct 2024 09:32:07 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>
Subject: Re: [PATCH 1/2] wifi: ath10k: Implement ieee80211 flush_sta callback
Message-ID: <ZxIO90syOrMCD-_e@pilgrim>
References: <cover.1728741827.git.repk@triplefau.lt>
 <481540132c62b16f6d823b7556c11a0ce68f5c58.1728741827.git.repk@triplefau.lt>
 <f9422f76-4a9f-4b37-8a4e-271b1344668d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9422f76-4a9f-4b37-8a4e-271b1344668d@quicinc.com>
X-Smtpcorp-Track: wFSRigpFwAiI.5nf-VOt_y_WI.AOWs0QTl7UI
Feedback-ID: 510616m:510616apGKSTK:510616ssHRJDegKN
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Thu, Oct 17, 2024 at 02:19:51PM -0700, Jeff Johnson wrote:
> On 10/12/2024 7:13 AM, Remi Pommarel wrote:
> > When a STA reassociates, mac80211's _sta_info_move_state() waits for all
> > pending frame to be flushed before removing the key (so that no frame
> > get sent unencrypted after key removable [0]). When a driver does not
> > implement the flush_sta callback, ieee80211_flush_queues() is called
> > instead which effectively stops the whole queue until it is completely
> > drained.
> > 
> > The ath10k driver configure all STAs of one vdev to share the same
> > queue. So when flushing one STA this is the whole vdev queue that is
> > blocked until completely drained causing Tx to other STA to also stall
> > this whole time.
> > 
> > One easy way to reproduce the issue is to connect two STAs (STA0 and
> > STA1) to an ath10k AP. While Generating a bunch of traffic from AP to
> > STA0 (e.g. fping -l -p 20 <STA0-IP>) disconnect STA0 from AP without
> > clean disassociation (e.g. remove power, reboot -f). Then as soon as
> > STA0 is effectively disconnected from AP (either after inactivity
> > timeout or forced with iw dev AP station del STA0), its queues get
> > flushed using ieee80211_flush_queues(). This causes STA1 to suffer a
> > connectivity stall for about 5 seconds (see ATH10K_FLUSH_TIMEOUT_HZ).
> > 
> > Implement a flush_sta callback in ath10k to wait only for a specific
> > STA pending frames to be drained (without stopping the whole HW queue)
> > to fix that.
> > 
> > [0]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> > 
> > Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
> 
> checkpatch.pl reports:
> WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

It has been reported on mailing list should I put the thread link here ?

> 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  drivers/net/wireless/ath/ath10k/core.h   |  4 +++
> >  drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
> >  drivers/net/wireless/ath/ath10k/htt_tx.c | 32 ++++++++++++++++++
> >  drivers/net/wireless/ath/ath10k/mac.c    | 43 +++++++++++++++++++++++-
> >  drivers/net/wireless/ath/ath10k/txrx.c   |  3 ++
> >  5 files changed, 85 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> > index 446dca74f06a..4709e4887efc 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.h
> > +++ b/drivers/net/wireless/ath/ath10k/core.h
> > @@ -558,6 +558,10 @@ struct ath10k_sta {
> >  	u8 rate_ctrl[ATH10K_TID_MAX];
> >  	u32 rate_code[ATH10K_TID_MAX];
> >  	int rtscts[ATH10K_TID_MAX];
> > +	/* protects num_fw_queued */
> > +	spinlock_t sta_tx_lock;
> > +	wait_queue_head_t empty_tx_wq;
> > +	unsigned int num_fw_queued;
> 
> is there a reason to prefer a spinlocked value instead of using an atomic without additional locking?

No reason except to mimic what is done for num_pending. Can move that to
atomic if needed be.

Thanks,

-- 
Remi

