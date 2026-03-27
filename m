Return-Path: <linux-wireless+bounces-34068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IewN5x9xmlTLAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:52:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59517344977
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB7E3020FF4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAA3BA225;
	Fri, 27 Mar 2026 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="y2P70J8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1463B4EB7
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615934; cv=none; b=NdTjerMu5TFvS1mb/YGoAsV03LQwXenqLNQOkuXfEa29tIK0rElp7GQo4rT8A2PvQhcDhVnj/EUOuC4dQpPq1RHAsSNunqLRD/HLJQ3A33mj1v15UQsVRwN95vCrqFgFriZmu/+PRAiQgVuJ/JNYwH5OHRT2I+KCvMFpbu7fisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615934; c=relaxed/simple;
	bh=DS7KYOSJXh80izl0l+f3xyWwE+kJdg5oD4aAPqZTzHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONYIo4XedzTbS+rM7wvEcHfebHVnN72P+HCCoAQdYMPKWMivm6mjPVPHSm3n7nQij342wzwqDloR8edDtSBobSQj4Zrc4aDDFo9VwNS5gdhc5ScWRzGLMsJ9+5wLGP3E0wPg5Z588GtWZvB6dKmtZ4aoug4nOyZQmDdf+DiAOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=y2P70J8Y; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33558 invoked from network); 27 Mar 2026 13:52:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774615926; bh=yP9ahuvnZGAo2DTIFZZpkdKoZiOsGosd+/A2k3hrLRs=;
          h=From:To:Cc:Subject;
          b=y2P70J8YKHmS+6HSl1HfVxJxoI+Q8MkbT/tkh9fu/9JPtPNAzHuHUddgxfaARBkmQ
           SqfZYXPa0HSGQM0SYzxf/YdnqZzWrBh06HBuPnj1wTLT8l4Ol+1yTYj0lSVTwzHmPp
           ngeNjWNzWbMcDBodF+sPjiYK5f3o9xIG2FkwKnnWeD/1k7RW/hLig57rDhSYLT3gBG
           pI06LqonTeRvWNlHNVu1VequIxCm426uMyWeG2sNelFi0ny7+ciHSxG5z4mLXxsLFX
           gTQ0HlqQmuLYxsgsf+3NT6tBuL0aFp/OB5jvtM7/eOunTWPWPtErRpgfqnkYAsebYx
           1/kvZJxE3OweQ==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <jackmanb@google.com>; 27 Mar 2026 13:52:06 +0100
Date: Fri, 27 Mar 2026 13:52:05 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: 3945-mac: Fix GFP flags in allocation loop
Message-ID: <20260327125205.GA18460@wp.pl>
References: <20260327-iwlegacy-gfp-fix-v1-1-b83e4db0bd66@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-iwlegacy-gfp-fix-v1-1-b83e4db0bd66@google.com>
X-WP-MailID: f61bfe942f5fc86cfa921f5e51a31b3d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kbMB]                               
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34068-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[wp.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wp.pl:dkim,wp.pl:email,wp.pl:mid]
X-Rspamd-Queue-Id: 59517344977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:30:07PM +0000, Brendan Jackman wrote:
> Do not latch these flags, they should be re-evaluated for each
> iteration of the loop.
> 
> Concretely, rxq->free_count is incremented during the loop so the
> __GFP_NOWARN decision may be stale. There may be other reasons to
> require the re-evaluation too.
> 
> Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Link: https://lore.kernel.org/all/20260327115739.GB16800@wp.pl/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
> Transparency note: I am 100% taking Stanislaw's word for this. The bug
> being fixed here hasn't been reproduced and I don't have a way to test
> this patch at all. It does seem to make sense to me though and, well,
> Stanislaw is the mantainer :)
> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index c148654aa9533..e8ae6687c08ec 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -979,9 +979,10 @@ il3945_rx_allocate(struct il_priv *il, gfp_t priority)
>  	struct page *page;
>  	dma_addr_t page_dma;
>  	unsigned long flags;
> -	gfp_t gfp_mask = priority;
>  
>  	while (1) {
> +		gfp_t gfp_mask = priority;
> +
>  		spin_lock_irqsave(&rxq->lock, flags);
>  		if (list_empty(&rxq->rx_used)) {
>  			spin_unlock_irqrestore(&rxq->lock, flags);
> 
> ---
> base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
> change-id: 20260327-iwlegacy-gfp-fix-d553e3340b4f
> 
> Best regards,
> -- 
> Brendan Jackman <jackmanb@google.com>
> 

