Return-Path: <linux-wireless+bounces-36464-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNYsHloHB2qcqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36464-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:45:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C854EB0F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AFC630664A0
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216C44CAEC;
	Fri, 15 May 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1sm1iK6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028E3CD8AC
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844959; cv=none; b=Updnn8GoffBpMJ/fLNfK1IJNOqXzznVh8r5AZdHAkVLOM3cbfA43hB0S9rhDn1AoCVSXxVMwSLBgL0DsFDQNu6HdY4YN2SjUssbk1+z6l/EpYrUnP2laCNqtU6FXbQH2w9e8qcOpQPm69iZvOznaZOiE6p6MWkNz2IL1UL571Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844959; c=relaxed/simple;
	bh=EYCsbFmRxBnwDhPzDvWjchjVhytxtnTllL2j7/O7c+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUlqRj8Zu7akP9QULd34Zp9gxikdaidKGBRSSArzYbyqXnQ1JGYnh8rLQ5QYvZfQfqL4SRC0WeKWS3uDjyTy7ZkO+/qTQZfYfsoJOUFS5LBrM3eNuDat3HJoGiBUmGOfon++21x2HVdsUhHhtFhLg65bVDzZpmiuBkU2GYpUhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1sm1iK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C9C2BCC7;
	Fri, 15 May 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778844959;
	bh=EYCsbFmRxBnwDhPzDvWjchjVhytxtnTllL2j7/O7c+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1sm1iK6zWzNlrlOPVii/4BNkV69kXt0qOU6wTernkzv4TVLW8LXrFSdj68YThTGZ
	 abwHJeaUnyqYdRUnwXr9pn8Z7xSAkah4axGSwgcmSfIGt5O0O/xv7VI1LCGhKD+tUT
	 Qnc6nZIx/7aemQwZvdiBv7RK9c+TJwMEHcVbfpC0=
Date: Fri, 15 May 2026 13:36:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: security@kernel.org, linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH] wifi: cfg80211: validate common_info length in
 ieee80211_mle_size_ok()
Message-ID: <2026051527-scrooge-oppressor-1500@gregkh>
References: <6a06f87c.643c4978.1f1059.84ae@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a06f87c.643c4978.1f1059.84ae@mx.google.com>
X-Rspamd-Queue-Id: 251C854EB0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36464-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:42:04AM -0700, Alexandru Hossu wrote:
> Hi Greg,
> 
> Here is the fix.

Context matters :)

Also, this isn't in a mergable format, please take a look at the kernel
documentation for how to do this properly.

thanks,

greg k-h

