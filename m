Return-Path: <linux-wireless+bounces-33595-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIJuFo1svWnL9gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33595-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 16:49:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D42DCDF5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3D4630098BE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329673CCFC2;
	Fri, 20 Mar 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqsD+V0e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994183CD8BB
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021768; cv=none; b=M3PlFmc1Ih8AznprV1dycWFTEwNouKFqs6BkfqI7OTlqubD4HTMbk3zozPJCkNet+SvAy++X/LEsLJGW6OBjSAGUe01FFOVZpuBw8mkNpRSZgNnV+q3qq8CMNjrNG/2SBvKlS1hf1H3oaVZq7JP3qdiqKZjYCAV3YfW5t27+jqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021768; c=relaxed/simple;
	bh=5bNAXGs4cIMFl6Jp32gKXXVAunXQc+McFM1c11Lf6k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKg+K3FOvNZWf0Dh8YW8GRegBLfcvEsJZphuk89Lq+uAKif680SOOH9YvlVNq9hr3Q8LtA+6FJakObhPniY1zhYojYB6pGjcnp+LZR1FkqgZmS7fAkWGSsLqFkLZJ8dvmRgqWZfrmhFuccY3AWS93wlsXKXxxTT/rG7S7H2yzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqsD+V0e; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so2315590eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774021762; x=1774626562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1noh5STaRC1HybhuYlkIMhR1r7TUdhM17pEfO/82ZhA=;
        b=TqsD+V0efLCtHkR1v28WRt0ZjiiW/DszxVXs02Ss3Npx+nBeLDXahfbuKHiLDCTLSe
         inyjk1ptvRR6l54nMhspWFgyvXYAUxbWUYiolNYh9Qa1qGeooZziXfx+RfI9uXO2njsA
         PIpZtIu7oWFT6pEsus+o8J8qjU+m5TpUDuoHorrWyc0ytHXUY8FhseaZTO8w+V5uKNYY
         a7o8ojWZZeV2eg031HmOhxAtE60w6Jg0HANc8MKeFab2GPPV44poRCB9TV1I26WLeYov
         WLaN85UITDG7rFc9tb0RrZC4GSNptfEm1lkkFmW71Hpg0Y6NXP4QijvMFvn72cUC5MRc
         tQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021762; x=1774626562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1noh5STaRC1HybhuYlkIMhR1r7TUdhM17pEfO/82ZhA=;
        b=ltTh62r/DkCilsGCsGxJEtvj0ZaNEH6dgP+RfBYfgLhl6/0tJrztPyPJ4lOtuazopV
         YrLfH0wmw/o5WEu+QWrTdOP9AYoH0Gij1aI8Xsk09c41T1aFy2X32cMAD/btlV5zoWz5
         RO1SjKw5Cl8hBUkqpensv2QATgXY89kl58QEsPqQi9PdHIpZ67y3yNQXPQ6tY7Q9ag/5
         fAAe119Udh9kbx3WFFlgkETF7aM70Hya40Wb1qaefHYgTewalvPq2HAYemJoNNsqxYvT
         4yJzaaYhqbya3+Ocu7AWezINtFniYBJJWWQginE3AuTWd2CJnunK309VZOj+JQAiuaNf
         TOPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqSTE9PD7Q0IliMeAR+vRb+aYhIuK7psh7wFjip3JRKLh6abn+L1YEhtIm7TazoBUFeiJ8syo+zQqTEydltg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8f6kyUzoguR0AJoK8j+SZe3DusxnAt8LP6ymU6SXBR5HC5n8
	AuRAJRWm7FFTg6JdmFxM4yXY52dlQBfz0Pjk92rNCfucvMk8F3uZqPI=
X-Gm-Gg: ATEYQzypTlWy8QF/Pkt2jCEel+vD/dxEAbhzWhXknbaAAfzu6ahDTW3VJsyM/TBkerI
	UCc4F9hQY7IZ2Xa3aoZRV/rTIHoXOD4HGyOFAbo+9Vf9oyIl9X+H3D/i4e5z/G/yaexKBbNrmIN
	+yfYTqtButEbDlZJPLxD1mE3WVyS7zlfCIhLC0K//U9DNGXcVPMNzDEFEZvEe3NojLCtvj4Fb/i
	rSPVQRzaQNQCtS/UvOEfTQsOIKfjx850nMGe6eTsSKolgkCsemMEP4upeAjZjCkASCb4aaBynHd
	ndevahLzJtEelimvBYE02iV8gdE+dtVFLDnkShx9r5SRBEbmHzTSQWDAPRa8mg2jpFvOkM2IadT
	zyIwBC1NiUjVTQiJdSHNfXLIOU8tpX2enAd0ZwSTgDfU/xEPWuyMcfSRUgGsEFsiIGhwATWNPUM
	TVdfoFnxZetXBNBSoKHOOwjTzNg4ZjleE4Tm9hZ/dublVmvUqMRn4Q4RsL/Fc0PwIbmeMgDER32
	OUxpZ9X2mk7RSqJyaVYHpEotjgi
X-Received: by 2002:a05:693c:3106:b0:2b7:b7e7:9025 with SMTP id 5a478bee46e88-2c10980a36dmr1639723eec.31.1774021762125;
        Fri, 20 Mar 2026 08:49:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b1b8sm3724371eec.8.2026.03.20.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:49:21 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:49:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
Message-ID: <ab1sgEg9ii3se1Zq@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <IA3PR11MB89865C96824F6518F4A01B9CE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89865C96824F6518F4A01B9CE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33595-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.876];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 438D42DCDF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/20, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Stanislav Fomichev
> > Sent: Friday, March 20, 2026 2:25 AM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> > skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> > michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> > L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> > mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> > johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> > dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> > Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> > skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> > wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> > leon@kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
> > ndo_set_rx_mode_async and dev_rx_mode_work
> > 
> > Add ndo_set_rx_mode_async callback that drivers can implement instead
> > of the legacy ndo_set_rx_mode. The legacy callback runs under the
> > netif_addr_lock spinlock with BHs disabled, preventing drivers from
> > sleeping. The async variant runs from a work queue with rtnl_lock and
> > netdev_lock_ops held, in fully sleepable context.
> > 
> > When __dev_set_rx_mode() sees ndo_set_rx_mode_async, it schedules
> > dev_rx_mode_work instead of calling the driver inline. The work
> > function takes two snapshots of each address list (uc/mc) under the
> > addr_lock, then drops the lock and calls the driver with the work
> > copies. After the driver returns, it reconciles the snapshots back to
> > the real lists under the lock.
> > 
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  Documentation/networking/netdevices.rst |  8 +++
> >  include/linux/netdevice.h               | 20 ++++++
> >  net/core/dev.c                          | 95 +++++++++++++++++++++++-
> > -
> >  3 files changed, 116 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/networking/netdevices.rst
> > b/Documentation/networking/netdevices.rst
> > index 35704d115312..dc83d78d3b27 100644
> > --- a/Documentation/networking/netdevices.rst
> > +++ b/Documentation/networking/netdevices.rst
> > @@ -289,6 +289,14 @@ struct net_device synchronization rules
> >  ndo_set_rx_mode:
> >  	Synchronization: netif_addr_lock spinlock.
> >  	Context: BHs disabled
> 
> ...
> 
> > to
> > +device
> > + * and configure RX filtering.
> > + * @dev: device
> > + *
> > + * When the device doesn't support unicast filtering it is put in
> > +promiscuous
> > + * mode while unicast addresses are present.
> >   */
> >  void __dev_set_rx_mode(struct net_device *dev)  {
> >  	const struct net_device_ops *ops = dev->netdev_ops;
> > 
> >  	/* dev_open will call this function so the list will stay sane.
> > */
> > -	if (!(dev->flags&IFF_UP))
> > +	if (!netif_up_and_present(dev))
> >  		return;
> > 
> > -	if (!netif_device_present(dev))
> > +	if (ops->ndo_set_rx_mode_async) {
> > +		queue_work(rx_mode_wq, &dev->rx_mode_work);
> >  		return;
> This early return skips the legacy core fallback below.
> Before this patch, __dev_set_rx_mode() continued into the
> existing unicast-filter handling when the device did not
> advertise IFF_UNICAST_FLT.
> 
> After this patch, any driver that implements
> ndo_set_rx_mode_async but does not set IFF_UNICAST_FLT
> will never hit that fallback path.

I believe this is addressed later in "net: move promiscuity handling into
dev_rx_mode_work"? That should take care of doing __dev_set_promiscuity
for !IFF_UNICAST_FLT+ndo_set_rx_mode_async. Not sure if there is a
better way to rearrange the chunks in the patches.

        if (ops->ndo_set_rx_mode_async) {
                ...

+		promisc_inc = dev_uc_promisc_update(dev);
+
+		netif_addr_unlock_bh(dev);
+	} else {
+		netif_addr_lock_bh(dev);
+		promisc_inc = dev_uc_promisc_update(dev);
+		netif_addr_unlock_bh(dev);
+	}
+
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
+

