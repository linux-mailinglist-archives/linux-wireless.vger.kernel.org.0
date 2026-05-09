Return-Path: <linux-wireless+bounces-36136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PPJG6cJ/2mv1QAAu9opvQ
	(envelope-from <linux-wireless+bounces-36136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 12:17:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20B4FF2D7
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E670D30056D9
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B93A0EB3;
	Sat,  9 May 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Zg8+2tq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8C237BE84
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321620; cv=none; b=CR8Cf+2kSZlNGUR41KuuVd8z60vAE6p9HfvA7atvilJ9pJUxYNURC2dwi0ljSXEb5UpjVtDzLgp5sMG7+RUIUKxDK3ebBv3rvNp49TWHZw2JXX3nEcK41oo4B9/5G6lebywmfnpLCV9q6R8L3yAGwwF7LWCTjkznhhqWwVz8VXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321620; c=relaxed/simple;
	bh=9bxNQaqsDNMu6TKjidxrJlXeWZkeA13IKD/dWzkKxEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwjh3WpmEzSifPeidsspwVk0Xz18UoNlBICbiLDQNT4MUlguxw13iCdTGlczxxgtuNblhaXzd13xvQ/DaotoFJJzeKyaH0mVqxpmyQid1mTXwRGh0K8j6F6KLrPVeOYNNdmNIl5uygGK4HxyVrKmmbZbyj/1ijyZMMm9yG7d4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Zg8+2tq0; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 5859 invoked from network); 9 May 2026 12:13:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1778321607; bh=jIdxinbdgJMMMfk7uVVnJm1N47P2HSHNC1jvpWELkwU=;
          h=From:To:Cc:Subject;
          b=Zg8+2tq0ONfEVN9Jncw8nxb4Qt2J9J3h6Sgu53UEUK7iRWK6nG/pVkDx2eNtSpR1S
           LSkl4IloYNJ0PBRMhmdNsxMq7fCT2ACTSBdwlIj6BO8NwSMeACxAByCPSsrJ0XDnEv
           hvG9mr7PFHw5zGvOromMQN8hBwwgVrmZUQdYLTOOTb8X4CSshTghFle4c0tnk7yecJ
           HAam4mfUslAvzzR+t15CJGQ80ohgMxefk4lOi4BHvi19WUc/1GwVH59GQC5chzyCEl
           hH9YNMxe4bVAxH6CirtIzUpTKvZDVC11Rh8C+D6YaIkZHLthR4pDexEIcg4VB7P7qB
           zjFE2Ewp1No6Q==
Received: from 77-236-5-241.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.241])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 9 May 2026 12:13:27 +0200
Date: Sat, 9 May 2026 12:13:26 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless-next] wifi: rt2x00: allocate anchor with
 rt2x00dev
Message-ID: <20260509101326.GA2170@wp.pl>
References: <20260430232206.141461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430232206.141461-1-rosenp@gmail.com>
X-WP-MailID: e19a3bbd0e37514d669a47517fbefaec
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UXNx]                               
X-Rspamd-Queue-Id: BE20B4FF2D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36136-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[wp.pl];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,wp.pl:mid,wp.pl:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On Thu, Apr 30, 2026 at 04:22:06PM -0700, Rosen Penev wrote:
> Instead of being creative with devm, allocate with rt2x00dev by using a
> flexible array member. Simplifies code slightly.

I think this patch is more creative. Using a flexible array member
is less conventional than the current approach of allocating separately
and storing a pointer. But OK, lets get rid of 9 LOC.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> It's worth noting that in 25369b22223d1c56e42a0cd4ac9137349d5a898e , the
> proper device was set to the devm call as it seems there was confusion
> there.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  3 ++-
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 11 +----------
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> index 665887e9b118..7d313e86d3f2 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> @@ -1009,11 +1009,12 @@ struct rt2x00_dev {
>  	/* Extra TX headroom required for alignment purposes. */
>  	unsigned int extra_tx_headroom;
> 
> -	struct usb_anchor *anchor;
>  	unsigned int num_proto_errs;
> 
>  	/* Clock for System On Chip devices. */
>  	struct clk *clk;
> +
> +	struct usb_anchor anchor[];
>  };
> 
>  struct rt2x00_bar_list_entry {
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index 174d89b0b1d7..47e427ea8622 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -804,7 +804,7 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
> 
>  	usb_reset_device(usb_dev);
> 
> -	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> +	hw = ieee80211_alloc_hw(struct_size(rt2x00dev, anchor, 1), ops->hw);
>  	if (!hw) {
>  		rt2x00_probe_err("Failed to allocate hardware\n");
>  		return -ENOMEM;
> @@ -826,13 +826,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
>  	if (retval)
>  		goto exit_free_device;
> 
> -	rt2x00dev->anchor = devm_kmalloc(&usb_intf->dev,
> -					sizeof(struct usb_anchor),
> -					GFP_KERNEL);
> -	if (!rt2x00dev->anchor) {
> -		retval = -ENOMEM;
> -		goto exit_free_reg;
> -	}
>  	init_usb_anchor(rt2x00dev->anchor);
> 
>  	retval = rt2x00lib_probe_dev(rt2x00dev);
> @@ -843,8 +836,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
> 
>  exit_free_anchor:
>  	usb_kill_anchored_urbs(rt2x00dev->anchor);
> -
> -exit_free_reg:
>  	rt2x00usb_free_reg(rt2x00dev);
> 
>  exit_free_device:
> --
> 2.54.0
> 

