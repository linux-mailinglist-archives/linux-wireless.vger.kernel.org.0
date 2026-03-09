Return-Path: <linux-wireless+bounces-32729-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCXxBg1QrmnUCAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32729-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 05:43:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137F233B7A
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 05:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65480301C8BC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AC2BE043;
	Mon,  9 Mar 2026 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="MwHhjlNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B31A5BB4
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773031426; cv=none; b=TxodX42/8qKafqS3T17HSBHLiw+Ue1cnZz5oeDfI8IDCtBgPErynjLibho3wOMzxPx6zSjnSGAhot4GnQpElf+LWKmbX46Ka5Hzbvm+2KzGe8bqIQ8suTQRPbB1b2AUQXbkzQJvYn/bnw8qrVgGJPa7fxeWeNmcNkeInVojAPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773031426; c=relaxed/simple;
	bh=KePqdlst8AQ6Ue2pLqAOHNBcgwAKGQugyW0CP83K82c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYLcJCU4oHHH31o9c7zjCQVmdSKvo802yX/52B/XvQoSQ6TCLL3aQRfKINgVU8nQNcQHQkEygTW+jsFLH22M0Z8bXfjtSFb1Z5wm9W1vAuLc3KmQjlCGSmLMmfTmjYG4DALV28MT59JPWF4a0oJxp5YC2xC5LJvhmGShCWAnBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=MwHhjlNP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so2109051b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2026 21:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773031414; x=1773636214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELfxXudIehrQo3lvO8ZkiWfX2bEY/n/ofHgxIFeg/4A=;
        b=MwHhjlNPwkL/lCj1gd6d4Ij5S51Btd95LtqiH1YaQs9w6lnzcZFy3AazEKwxblrZYT
         Do/d748cuQgPnESvT/8qtGw8tXhdd03ioIMOssmsrSJ9Ol1wxQLCOzuXEzzumCjPiOTP
         o4DoFOA69iJ73gf9PE0XGaao0Pv6B/KAok4OLB2OPHc1+pBMt1ZTPl3XXS2QEwQvzS7I
         iC9EPhzGf6HSms63/KCtU6mtrrmHGNhJMyj55J2Yom9rqkndEv+qkRTRSiEjQbfiepvj
         KxCa4utTfCLLGUY7A+UstNempgCbTudUC7lEfnDgQrYinA2oZOfE4LRmBTpliZjKDlji
         5czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773031414; x=1773636214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELfxXudIehrQo3lvO8ZkiWfX2bEY/n/ofHgxIFeg/4A=;
        b=aUtH6XiIPpxWHw9rfXRPuqwVxlkTMJmJUKRgU+WrgAiYMLQvUgox4MwVKRzoAHFdAK
         DOSR3DXpQl2F6m9lw3PW8JSU4M3HL5DkoEU2DR5Igvb3D5KB8g6jz27DPcJhl4hhmDMi
         9eAR2g4v5+eeeG+BxLi9zBNE6DNDniv7dE/LbOIAaq7NFsRwQKiPf1B3YmVCkN+9GvSo
         o4ajpsoRC6tsvns1TbZeK0Mb7BAxS/74MRnBEIySsLDa2jhZUsz4Qxdoph2dujarDlQk
         bzGrhooSW2V95ONY89xw4JNsz5pt7venEKZzIfUjhqCSkATKuh0TCTFMAULFCItPWxCC
         5iQw==
X-Forwarded-Encrypted: i=1; AJvYcCVsJuZUDwamZ2Bl5isMwZfiFin/apP0YpZ80y5Ws8VLjUMRJCgahQuMYEpi//cwlxcBhyJpbhCfJWvrnYaP2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHtNNiUmw9dEOmBlMuCxUghitcWA6KcTrjM+iVdk2RIcDPKNr
	ouFe0IaqBe9aAFRjtzDjU7xxiL2dxGeKXOEa43bpBDhZv38Nh6Y/rpHQ21q9JcboOO4=
X-Gm-Gg: ATEYQzxGhdN5orHBAiW5e09/T/TTrf6pB7ToPKfkl4XjBu2oQbxy5/p6BLaGK+ogjR4
	X2yNy7e5lf/OsRzNOfqmYhzd0rr6bZj69htpRiVb3Zjra7mohtKPR4yLa6D+X32ndbMFqBlr9My
	kr6rLLINgTroyILhv05VZL5j85E4AkNECb0YnbJ2K7SMJF7zADAVW5bPpDgsFFDaGgtvi9IHJWc
	or9ZBOeB+RHERKVzXjX0viNlX1e29C3CxOrGU+MsiV+QNXM4xyEtUUtgRUzy3yez17pvNA4ZoEG
	KwemLwNA/ekeeMueX6t7tVoNJfW0Da0bpt5jTp9SPXETmfBdBoV7k9fRu4pg/Syhb43xdprtWyA
	yw50HHnTX3CKkM9G2ztoLK+Kq2EVGMgPRiZqzkNuYzPQ+5T7SppPXqdJXC9RMHIwmlvG2G0DnbN
	r931nBuoSGGEcKiR7AFtcIR3YT1cccIQQehesnJfXe3Opo49QNSHz4C5RrjmY1pIhD
X-Received: by 2002:a05:6a00:849:b0:81b:8872:ae10 with SMTP id d2e1a72fcca58-829a2b54ca3mr9498356b3a.0.1773031414361;
        Sun, 08 Mar 2026 21:43:34 -0700 (PDT)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b702sm8741003b3a.20.2026.03.08.21.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:43:34 -0700 (PDT)
Date: Mon, 9 Mar 2026 15:43:30 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, 
	Arien Judge <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
Message-ID: <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 7137F233B7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32729-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 10:04:53AM +0100, Johannes Berg wrote:
> On Fri, 2026-02-27 at 15:10 +1100, Lachlan Hodges wrote:
> > 
> > +static int mm81x_mac_ops_hw_scan(struct ieee80211_hw *hw,
> > +				 struct ieee80211_vif *vif,
> > +				 struct ieee80211_scan_request *hw_req)
> > +{
> > +	int ret = 0;
> > +	struct mm81x *mm = hw->priv;
> > +	struct cfg80211_scan_request *req = &hw_req->req;
> > +	struct mm81x_hw_scan_params *params;
> > +	struct ieee80211_channel **chans = hw_req->req.channels;
> > +
> 
> > +	mutex_lock(&mm->lock);
> 
> Seeing this, I wonder about two things:
> 
>  1) Do you even need a mutex, given that the wiphy mutex covers all of
>     this pretty much? I can say from experience that a _lot_ of things
>     get quite significantly simpler without a separate driver mutex.

Gave this a look and you are right, wiphy mutex covers pretty much
everything so will just remove.

>  2) Are you going to incur the wrath of mm/ folks, where instances of
>     'struct mm_struct' are commonly called 'mm'? I can find a few
>     examples of others (struct drm_buddy *mm, struct mqd_manager *mm),
>     but you'd double the instances.

This.. is definitely something I did not think of. I have no issue with
renaming to something else.. maybe mx? I'm not sure.

> > +	/*
> > +	 * mm81x only support changing/setting the channel
> > +	 * when we create an interface.
> > +	 */
> > +	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
> > +		mm81x_err(mm, "Changing channel via chanctx not supported");
> 
> Wait, what, why do you have chanctx support then? This seems highly
> questionable, how do you not run into this all the time?
>
> If it just has a single, wouldn't the chanctx emulation suit the driver
> better, and that'd make this more obvious? Hmm, but you _do_ support
> multiple vifs? I'm confused.

We originally used chanctx emulation.. but I suppose in an effort to
be "modern" we use chanctx. It's probably best to switch back to the
chanctx emulation anyway. As for why we don't run into this is due
to no channel switch support yet, iirc mac80211 I think needs a minor
tweak to work with S1G (which further reinforces the idea that we
should just emulate chanctx)

--

Thanks for the review. On the other thread [1] you mentioned sending a
pull request once reviews settle down, as per the documentation in [2]
(which I should have read earlier... :) ), can we confirm that this means
we are to submit subsequent patchset revisions in the same per-file
format until everyone is happy with the driver, and then raise the PR?

[1] https://lore.kernel.org/linux-wireless/b71d0932b10b5c446681cef588cfcf6f869f3fca.camel@sipsolutions.net/
[2] https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#new-driver

lachlan

