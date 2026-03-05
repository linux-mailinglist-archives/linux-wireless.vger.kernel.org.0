Return-Path: <linux-wireless+bounces-32567-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPWaKPa0qWkZCwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32567-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:53:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17350215963
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D00953012CF2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745863D5675;
	Thu,  5 Mar 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="yjfLtIO8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC98313540
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729578; cv=none; b=jbdznZOQjy4KB8dcYCFBgOGJrScz5C2/IebsB2ftXfkZWe+OgfBV0Y0Zu7V8mTytS6Y2lL15nZ2S/x0IdIdMxc6TVF/QMnDLOJAIzW974QWEth+hlCYwmYWQmYnDPGD0KT9cBJB5cKmPmhCgK/Bik1C2JozwwarkOgmwsvFjCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729578; c=relaxed/simple;
	bh=lPd3xRfvHNfLIITtOH+GVXIOfyrNlvjQZbC9rkyCTAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXzy7Ma7PStPl3eg6/mbXSsVmaeRBDoJeuc1ujjN1vHnicmAmP+CaKwPlQ8kMmxERILtxhbRXzXE0GzLC4FRlDgFsedTkqcpjBTyFJyLPzXI0bTPGh9rM4CU/IwtWf7sQ0AqL6Mc8uV73HuXnIupes27uEk05d6ZLCSkoM9Lrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=yjfLtIO8; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 3648 invoked from network); 5 Mar 2026 17:52:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1772729572; bh=nceW5alBsceTqsHbyHEzTPEtOGIiCOQeWI18n7irs4s=;
          h=From:To:Cc:Subject;
          b=yjfLtIO82yWWGrGfJJKkOyGgY6YMAghLBA0DPoVtoRr0txyusYsRE2erOvh6epnV9
           SfdGLtnq5Z10wg4I0P1ww0xWOeXk/OLwE3ABPO8jW9YudoEgRVQmRnScs2O8a4z0Ld
           L0x9eaU7bGwPww/KP4U1vsKJnwgmnZGpoSx1tnlTNNZUUPdoOSFYyTayxfm9D67sju
           O7QSSbYUzAVxrCLWIJ9SK8Krfj518PCqho/5PYkwSU6K3Ke17jA12Jp5z4fNR/RUwA
           E7yczLQnmUJK6rj+jOX1MX8m3bmNaOv0UkDKP6T6Xo54eOM3s2eE22B0eXk+tmc3FH
           Nm41AGQXONXcQ==
Received: from 77-236-11-252.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.252])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <johan@kernel.org>; 5 Mar 2026 17:52:52 +0100
Date: Thu, 5 Mar 2026 17:52:52 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johan Hovold <johan@kernel.org>
Cc: linux-wireless@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Hin-Tak Leung <hintak.leung@gmail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] wifi: rt2x00: drop redundant device reference
Message-ID: <20260305165252.GA77369@wp.pl>
References: <20260305110713.17725-1-johan@kernel.org>
 <20260305110713.17725-11-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305110713.17725-11-johan@kernel.org>
X-WP-MailID: 7399742c24ade6edd38c91daa616f014
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0TOR]                               
X-Rspamd-Queue-Id: 17350215963
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32567-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:dkim,wp.pl:email,wp.pl:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:07:10PM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index 54599cad78f9..83d00b6baf64 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -802,14 +802,12 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
>  	struct rt2x00_dev *rt2x00dev;
>  	int retval;
>  
> -	usb_dev = usb_get_dev(usb_dev);
>  	usb_reset_device(usb_dev);
>  
>  	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
>  	if (!hw) {
>  		rt2x00_probe_err("Failed to allocate hardware\n");
> -		retval = -ENOMEM;
> -		goto exit_put_device;
> +		return -ENOMEM;
>  	}
>  
>  	usb_set_intfdata(usb_intf, hw);
> @@ -851,10 +849,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
>  
>  exit_free_device:
>  	ieee80211_free_hw(hw);
> -
> -exit_put_device:
> -	usb_put_dev(usb_dev);
> -
>  	usb_set_intfdata(usb_intf, NULL);
>  
>  	return retval;
> @@ -873,11 +867,7 @@ void rt2x00usb_disconnect(struct usb_interface *usb_intf)
>  	rt2x00usb_free_reg(rt2x00dev);
>  	ieee80211_free_hw(hw);
>  
> -	/*
> -	 * Free the USB device data.
> -	 */
>  	usb_set_intfdata(usb_intf, NULL);
> -	usb_put_dev(interface_to_usbdev(usb_intf));
>  }
>  EXPORT_SYMBOL_GPL(rt2x00usb_disconnect);
>  
> -- 
> 2.52.0
> 

