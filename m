Return-Path: <linux-wireless+bounces-31601-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CASlOqXUhGlo5gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31601-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:34:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8CF5FB3
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 488AB301C916
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9622BE64F;
	Thu,  5 Feb 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRgqxnvW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3A13A258;
	Thu,  5 Feb 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312867; cv=none; b=kZgoxDKlNz7ZsPBw7QNH4p9r359CI1FDEvwJZrimUW6tka0Le/aVAeXKI9g6YvdmbVCre7rJ0Mxvq2AWX7kPEVKRxoRKuWHMen0hnG9g+Dwom2De0pJux/k3bnEoFTHvVCAzzQtABwrSz4uIomnq+1xrK63uvVAuhnuyeslh1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312867; c=relaxed/simple;
	bh=4P9nWuTA9SDx3l2KUcFQvPPD8VWHgdAZvIN+fmuFiuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvRzUl6OaA8HH+grkm+HrWkgP/KtI8yN5ag6lyIvVqDboyurPh+NSPsSf9fiDRWRxxbsvb8cDnNMAQnIykEyNBw7dm9pmdrdVXIwpnz06ouyXw6wCcZOG2OVZrtMU6sVh4jZCxcDzUacLN5Umm40RQ9I8vx5cE8jLAcTLxZSe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRgqxnvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A1DC4CEF7;
	Thu,  5 Feb 2026 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770312866;
	bh=4P9nWuTA9SDx3l2KUcFQvPPD8VWHgdAZvIN+fmuFiuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRgqxnvW41dysbTkcgcf5BgK+YwQNHsxZTZaaB96L7oIIyev7I20LKsbdmJwwwaPK
	 2cKab8GqpjIlAk8a4WTO4NXozkjozNEjiTF72ua7NtEF+3EuEcTlwyORowTiu13c/r
	 5HlDVufan73JFZ1hxbY1UwVqgeFeXdLRkll/eOVg=
Date: Thu, 5 Feb 2026 18:34:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dhyan K Prajapati <dhyan19022009@gmail.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: Re: [PATCH v3 wireless] mac80211: fix NULL pointer dereference in
 monitor mode
Message-ID: <2026020502-upgrade-booth-8e4d@gregkh>
References: <20260205172313.16652-1-dhyaan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205172313.16652-1-dhyaan19022009@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31601-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66D8CF5FB3
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:53:12PM +0530, Dhyan K Prajapati wrote:
> From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
> 
> Signed-off-by: dhyaan19022009-hue <dhyaan19022009@gmail.com>
> ---
>  net/mac80211/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index b05e313c7..190222c26 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
>  	case NL80211_IFTYPE_MONITOR:
>  		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
>  			return;
> +		if (!link->conf->bss)
> +			return;
>  		break;
>  	default:
>  		break;
> -- 
> 2.43.0
> 
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

