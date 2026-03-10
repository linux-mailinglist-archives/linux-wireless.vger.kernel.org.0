Return-Path: <linux-wireless+bounces-32918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGkJOF5AsGkehgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:01:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 385EF254359
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 760193080FA7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE53A544C;
	Tue, 10 Mar 2026 15:57:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA830F803
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158253; cv=none; b=YuSfImMM8KsfCEd899kWRfSCGNhA7fCT+bJWr+pTmsW6+JWt66S0/zfZCERiEowuEA4smGU8BTxNSa3DA70jWLHdfacCpr5oSh19AbUZ9K0rVObnvzs61EQWnutoOxghkGpqwfJsWZOvw3smrJEPr1L6VET3nie21ZHxd5KjIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158253; c=relaxed/simple;
	bh=qhFQPbjppni7cJsaLUPHdXzEGt6TrKRJdlg5JF0Rh9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XHAso5LBuTcvCJamX4Icb7iXBnkx2UNZx2GQ5/ZdIe7b6fPAenLicuMAy9asNj+zLDeAb08FNDFqI/YtF2i+wRHJFZiOtAWqCF9dRbEJQVfoNiCBadEJfTFp3AUPnZMO7RRt76sPySvnoGKDxFIjYtowMzD1okz3jAMX3WWHD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 15236A0C3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:52:19 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 08CBBA0C2; Tue, 10 Mar 2026 16:52:19 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 9E9E4A04A;
	Tue, 10 Mar 2026 16:52:17 +0100 (CET)
Date: Tue, 10 Mar 2026 16:52:17 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: Guenter Roeck <linux@roeck-us.net>
cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: ensure skb headroom before skb_push
In-Reply-To: <1768df30-cac9-4c55-a8bf-1d927d59029c@roeck-us.net>
Message-ID: <6895624e-22f8-d533-5167-e32de031e369@lysator.liu.se>
References: <097bd417-e1d7-acd4-be05-47b199075013@lysator.liu.se> <1768df30-cac9-4c55-a8bf-1d927d59029c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1930955110-1773157769=:186163"
Content-ID: <f1169d2d-e005-c243-53e5-3b28188c8ffb@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 385EF254359
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lysator.liu.se : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32918-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[astrand@lysator.liu.se,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.972];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lysator.liu.se:mid,liu.se:email]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1930955110-1773157769=:186163
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <b96f2d9c-d805-a53f-0849-99507d14666e@lysator.liu.se>

On Wed, 25 Feb 2026, Guenter Roeck wrote:

> Hi,
> 
> On Wed, Dec 03, 2025 at 08:57:08AM +0100, Peter Åstrand wrote:
> > 
> > This avoids occasional skb_under_panic Oops from wl1271_tx_work. In this case, headroom is
> > less than needed (typically 110 - 94 = 16 bytes).
> > 
> > Signed-off-by: Peter Astrand <astrand@lysator.liu.se>
> > ---
> >  drivers/net/wireless/ti/wlcore/tx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
> > index f76087be2f75..6241866d39df 100644
> > --- a/drivers/net/wireless/ti/wlcore/tx.c
> > +++ b/drivers/net/wireless/ti/wlcore/tx.c
> > @@ -207,6 +207,11 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
> >  	total_blocks = wlcore_hw_calc_tx_blocks(wl, total_len, spare_blocks);
> >  
> >  	if (total_blocks <= wl->tx_blocks_available) {
> > +		if (skb_headroom(skb) < (total_len - skb->len) &&
> > +		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
> > +			wl1271_free_tx_id(wl, id);
> > +			return -EAGAIN;
> > +		}
> 
> An experimental AI code review agent provided the following feedback:
> 
>  If pskb_expand_head() fails, the code returns -EAGAIN. However, in
>  wlcore_tx_work_locked(), a return value of -EAGAIN from
>  wl1271_prepare_tx_frame() is interpreted as the aggregation buffer being full.
>  This causes the code to flush the buffer, put the skb back at the head of the
>  queue, and immediately retry the same skb in a tight while loop.
> 
>  Because wlcore_tx_work_locked() holds wl->mutex, and the retry happens
>  immediately with GFP_ATOMIC, will this result in an infinite loop and a CPU
>  soft lockup? Should this return -ENOMEM instead, so the packet is dropped and
>  the loop terminates?
> 
> I don't understand the code well enough to understand if the AI agent has a
> point or not. Please take a look and let me know if this is a real problem.

From my perspective, this makes sense. We have never seen any CPU soft 
lockup, but perhaps pskb_expand_head() never fails on our systems. ath12k 
also returns -ENOMEM when pskb_expand_head() fails.

Can you submit a patch? 

Best regards,
Peter

--8323329-1930955110-1773157769=:186163--

