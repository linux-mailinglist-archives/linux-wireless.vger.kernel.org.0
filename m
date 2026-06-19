Return-Path: <linux-wireless+bounces-37923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +tbOCCJZNWqLtgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 16:58:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD16A6888
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 16:58:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b="zlM90/qC";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37923-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37923-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC03130180B2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3027467F;
	Fri, 19 Jun 2026 14:58:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9962DC32C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 14:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881118; cv=none; b=YvG5Ww5zghvlFQS0p+UJ8JQhghz1cUWTvn0GSYMoTcrG2FVJe4+X76UAkpiqpbi1lYF/xsc80XOxYcrB/Tb8zI3a1/62A1hYwylYPCD2UplKo6EjNUlw9mX+BblPMpG16QR7iqqfdc7gqGLwU06gcM6SSn5w00BIN/eZrhknjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881118; c=relaxed/simple;
	bh=NyrScO0dVhsACym1fuSEanidTYHc8ErpZjn2GEDMaOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0pwpvPwRqlRQ6xuQVpUII5LcFMF/3ZPDkfhlb7T3xF+kLX8HoDH+lszOSzEhdfPbTwSnh2nWJ96aOEcnayxgT0L/626G3K99V0RZb8tm85QAsy/laNSN69RM/Fl1E40HpQN5Bf90dqA5vPEf/N01dhbDYQak5igupXT0IvkAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=zlM90/qC; arc=none smtp.client-ip=212.77.101.9
Received: (wp-smtpd smtp.wp.pl 14198 invoked from network); 19 Jun 2026 16:31:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1781879515; bh=bzmFSpOZzFRmYN5ZZP9uYyPTRaSCgyKCPlBppCnsT2Y=;
          h=From:To:Cc:Subject;
          b=zlM90/qCL/UfNlVhvtPmLU6t2hZ445V3dKgJs/dpYyovkuYI5ILXYhH7D35FYrRGL
           EgSKvYkL02ZBSrhWHhrwMrek4ZkGgv20+D4UHZARUBwZ3jdGJ7Xz+SXAt9tzdNP8b+
           C8uxNJO/PtruJHSzDFQIqiBe/qKbssn/Jwx7kcp7Tik6iR5Qnnv/OQlrvwmoRPnx8O
           xkF7EVjENcmwM9znw/tnAVO5U8fakZaVBZ2Mo8xW/8hLlO+gdl7VRBtlzR7isNmv1a
           3/X6Yhs7p8PjFownw2OgZIPksiOF8S79ya7Xy9wAPgaIKB/9vwLkIT4wRdEyaIAxbm
           qEcLHvEESj2kA==
Received: from 77-236-11-197.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.197])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <runyu.xiao@seu.edu.cn>; 19 Jun 2026 16:31:54 +0200
Date: Fri, 19 Jun 2026 16:31:49 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Gertjan van Wingerde <gwingerde@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Ivo van Doorn <IvDoorn@gmail.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: rt2x00: avoid full teardown before work
 setup in probe
Message-ID: <20260619143149.GA61690@wp.pl>
References: <20260619073104.1809161-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619073104.1809161-1-runyu.xiao@seu.edu.cn>
X-WP-MailID: d787dc5315198eeb299b0b41783dca5e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [MeLR]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37923-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,tuxdriver.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:gwingerde@gmail.com,m:linville@tuxdriver.com,m:IvDoorn@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[wp.pl];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wp.pl:dkim,wp.pl:mid,wp.pl:from_mime,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CAD16A6888

Hi, 

On Fri, Jun 19, 2026 at 03:31:04PM +0800, Runyu Xiao wrote:
> rt2x00lib_probe_dev() uses the full rt2x00lib_remove_dev() teardown for
> all probe failures. However, drv_data allocation and workqueue allocation
> can fail before intf_work, autowakeup_work and sleep_work have been
> initialized.
> 
> Do not enter the full remove path until the probe has reached the point
> where those work items are set up. Return directly for drv_data allocation
> failure, and use a small early cleanup path for workqueue allocation
> failure.
>
> This issue was found by our static analysis tool and then confirmed by
> manual review of rt2x00lib_probe_dev() and rt2x00lib_remove_dev(). The
> early probe exits should not call a common teardown path that assumes the
> later work setup has already completed.
> 
> A QEMU PoC forced alloc_ordered_workqueue() to fail before the work
> initializers are reached. The resulting fail path entered
> rt2x00lib_remove_dev(), and DEBUG_OBJECTS reported invalid work drains with
> rt2x00lib_probe_dev() and rt2x00lib_remove_dev() in the stack.

Thanks for finding and fixing those bugs. The patch looks fine, but I think
it could be a bit simpler, see the comments below.

> Fixes: 1ebbc48520a0 ("rt2x00: Introduce concept of driver data in struct rt2x00_dev.")
> Fixes: 0439f5367c8d ("rt2x00: Move TX/RX work into dedicated workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> index f8a6f9c968a1..847b64e586f6 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> @@ -1382,7 +1382,7 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
>  			                      GFP_KERNEL);
>  		if (!rt2x00dev->drv_data) {
>  			retval = -ENOMEM;
> -			goto exit;
> +			return retval;

This can be just "return -ENOMEM;"

>  		}
>  	}
>  
> @@ -1416,7 +1416,7 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
>  	    alloc_ordered_workqueue("%s", 0, wiphy_name(rt2x00dev->hw->wiphy));
>  	if (!rt2x00dev->workqueue) {
>  		retval = -ENOMEM;
> -		goto exit;
> +		goto exit_free_drv_data;
>  	}
>  
>  	INIT_WORK(&rt2x00dev->intf_work, rt2x00lib_intf_scheduled);
I think should be sufficient to move INIT_*WORK's lines before
alloc_ordered_workqueue() to avoid cancel_*_work_sync() on uninitialized data.
And other de-init code from rt2x00lib_remove_dev() should work fine at this
point.

Regards
Stanislaw
> @@ -1488,6 +1488,14 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
>  exit:
>  	rt2x00lib_remove_dev(rt2x00dev);
>  
> +	return retval;
> +
> +exit_free_drv_data:
> +	clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
> +
> +	kfree(rt2x00dev->drv_data);
> +	rt2x00dev->drv_data = NULL;
> +
>  	return retval;
>  }
>  EXPORT_SYMBOL_GPL(rt2x00lib_probe_dev);
> -- 
> 2.34.1
> 

