Return-Path: <linux-wireless+bounces-34067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGAtL8F8xmnwKgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:49:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F68F3448D1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7192030EB428
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B91377EB0;
	Fri, 27 Mar 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bL61iH9T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E862D978B;
	Fri, 27 Mar 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615535; cv=none; b=Bsx8vrjwJ9w9gr56+T6mJFDSOaqYhe/5IdaTPoyuXB7MAYZXQcEAPtKe8U9xy0Nq60va06i2kwLXbw/JXLQ1ZSY5oZAvymsSEF6hW0zzHsqzNt83axGTFVfJdjxK7Y2n5hKs23sEPwStq+Dfbb2PNM7W92rwHESPD4FjeNAANkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615535; c=relaxed/simple;
	bh=bk+Vi1I2+fCQCAnACoZb3mLNxxgmiEccmZn50IC3yr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCuIHlGCpDSHM7JH/UkBEQ+7CcDjDWk1kjjH4CMQYz9GWED7g3ZoaK7kujTYrt5UKYcBRsEf4L0F/EbVGE8AfWvOpOECd3CsU0ClKD1Vy1qdbneNVgb4O468eSQekN47k9YfJANrklGtS/Vt1s8h79+D4p7fQG3sEr6CgrASvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bL61iH9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3C1C19423;
	Fri, 27 Mar 2026 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774615535;
	bh=bk+Vi1I2+fCQCAnACoZb3mLNxxgmiEccmZn50IC3yr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bL61iH9Tpqn92gq5h6u3WUpjHcGuIiDT7cyrxNjnYzrQ1XF3MQDVGw4Le5W57GpwG
	 rR5qrFbc2y+1NMYr7f3s5s2BI3KHxyu3FVKkJezjKWTA70nn7TVPY70FyXu1DGok+/
	 eQkqDjS/A4V7/XP2TgSI62xbPmLOVqaMSD/5lPHk=
Date: Fri, 27 Mar 2026 13:45:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: [PATCH v2] wifi: rt2x00usb: fix devres lifetime
Message-ID: <2026032700-footless-basil-7bac@gregkh>
References: <20260327113219.1313748-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327113219.1313748-1-johan@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34067-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 1F68F3448D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:32:19PM +0100, Johan Hovold wrote:
> USB drivers bind to USB interfaces and any device managed resources
> should have their lifetime tied to the interface rather than parent USB
> device. This avoids issues like memory leaks when drivers are unbound
> without their devices being physically disconnected (e.g. on probe
> deferral or configuration changes).
> 
> Fix the USB anchor lifetime so that it is released on driver unbind.
> 
> Fixes: 8b4c0009313f ("rt2x00usb: Use usb anchor to manage URB")
> Cc: stable@vger.kernel.org	# 4.7
> Cc: Vishal Thanki <vishalthanki@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index 83d00b6baf64..174d89b0b1d7 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -826,7 +826,7 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
>  	if (retval)
>  		goto exit_free_device;
>  
> -	rt2x00dev->anchor = devm_kmalloc(&usb_dev->dev,
> +	rt2x00dev->anchor = devm_kmalloc(&usb_intf->dev,
>  					sizeof(struct usb_anchor),
>  					GFP_KERNEL);
>  	if (!rt2x00dev->anchor) {
> -- 
> 2.52.0
> 
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

