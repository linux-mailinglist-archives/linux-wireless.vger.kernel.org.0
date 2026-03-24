Return-Path: <linux-wireless+bounces-33788-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGAUFQ7YwmllmgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33788-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 19:29:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD231AD9C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 996DC3046573
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909D3A5E60;
	Tue, 24 Mar 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si9eJvV+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CA3A543A
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376948; cv=none; b=R/QkMdLF3+ENfxOjtWCUk5J5mhJBz0CB030BpSQIp93fEX6O6WUUfGjVxAqdLnwW+1BVmfKhR2gQHRVh/AYwDHv3Qhaw2/QBedZQU/up+mDGgOvp7uToVyofOR6sk1y49+GLYo+vkWrbpDbhXyzNSLhdbuUy6xoe+Q41nLMe4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376948; c=relaxed/simple;
	bh=sGV42ckhq/fpPos7s40zEY8GgVxzQ5KkyRYafuhMkVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWvgZ5H2et/s3OR6pAI8znB+aL6ebt3h5LfnW350fzBmsTBxlTtxPfZaFWM3rNkB1ZFU9wjWHPCntEL2agOq3Vi30Gl1AG2uts4oKOIc5LgGstToeoGFyNfs1O9H1RzTbX3RZBVIB7DUp2rIMdo3PmVLgqYYSMjk8aVmCWfyias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si9eJvV+; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so7060683eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376943; x=1774981743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VMp4SS5F3P0M1XmfAAhBrmRFWjAnWFpCGzWfd4HYYM=;
        b=Si9eJvV+wG0pnnZly81arvtokXngiSJgE/XgfsZU0Na9vPRu1tvrCqZ5gqQTszzY9/
         032LyVYrZnVEd4UKxSHn0Z165a3Qet4sl4NI6QZKTOi0iGw76cf5qnPA+3A269FBtEbO
         X8IG2rfQIw23UnZTxgg45+ntz6F8eXhFjajIyGjtE7JtE3Wg2TD9OJNAtOCmcdtlhfbU
         ya9WTgIOxj8eSdM6rrvcXtsPY8dF+sci+K4nwf8a20oNAbYR3/cQfrlkJS8GFvuJSH/4
         RE5GcvNB6Xsxnq6lcQLcP124p6e1Qq1ggzu6EALemizIC3Pqm2IVd9C1Thh5N862IMIZ
         8P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376943; x=1774981743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VMp4SS5F3P0M1XmfAAhBrmRFWjAnWFpCGzWfd4HYYM=;
        b=IE5uVGEMXrKEZ3hNfhoPR+tnz8j1dstPeP3S+G+03JvkaH7bFGwgETiQm+RPTdXOhx
         WaoSli07tMv8AI+9DFtdWHcjYqwreptLRgcK2Vjv+xdGgR1b0/vMILyg7H+azKESUJQG
         UnaVfhZd61eC+r96m62l4HxJqKZbN8OyKR1HH3xz97yCoepfhk4ctWnkq4jR181xJgZh
         BtqTLGSPQ8wwV5RjPCVDTb3EsxlqRL5A8CVk/a31yK1pNIB0yjGWp2Vxnd3wYApTxl8V
         eG1lQVAzHShR84CIZFfjgcxPwVURAARsYGuUmXDKdPIcdh6FJkG1rcbFGXAz59laUo6n
         p3+w==
X-Forwarded-Encrypted: i=1; AJvYcCXFAeZ6f2wbe1LE6xrBx+yO0jYMmpehSFjMPYkH9TOu5ICIT1p3lZTKs7VccZTCfoKDeFvThMP3AVXLwvDX6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZDQUQSOZkdWuBx6jK0WZ7FIIse39yeRm97RlOykAgOqtHEVR
	H88zCJ6w4uUPyQXlMIWERhyqa/8WMMGhjM23GFcwhjA+/dk9fjUEC5s=
X-Gm-Gg: ATEYQzz4ijkEery6HG0Mn4qSX8FBAqzHlN8CTpTfaRRl7LxprlhGQYsmoTY6nvPnIWY
	L4/QSe2vXiwn9sM38P+Mtk9MBBjqfafGZ9EaOxzCbC6gk3/ge82N91eYxUIqF+CyPQgpxwo0/Gc
	I2Jsz5fxl6wCQmnZZciErVZVe9cJo2PNeYbyWQhkpwHAZrEagXPqtl5fHULs848HsTdbxqI7lkW
	aoPLPZ8UHfVegx8kNqOk+dOScBazIap6lwJ7RJetypl4OInBZl4swNvakIWixP2oIzVyx1mnFS7
	7FGqQ3tC8aKf7eUY7DXsCkCe7sFU1zLOEoFXNQmGnszXHhNo4cJ5YOPWe5gY89QvXAqsq6Fyma5
	av8YyVDWgnAV8NZIYzyn54omqRMU862FnJQlnAzNPxX4s92ackhjEgFtBPYjmE7dZoFwhivG9Dd
	07TkIsex6xCqo+rd7HSOjvANX/VLIru6FT+pn19pur8931xi/gJI3auPC9nDNdobtmyrvdcTC6n
	48d60tQIP8DzSZW+qNI/uCRlDsg
X-Received: by 2002:a05:7300:7b90:b0:2b0:48f7:837d with SMTP id 5a478bee46e88-2c15d2dfa68mr213205eec.11.1774376942754;
        Tue, 24 Mar 2026 11:29:02 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c299sm15827125eec.6.2026.03.24.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:29:02 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:29:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 08/13] bnxt: use snapshot in bnxt_cfg_rx_mode
Message-ID: <acLX7XCmoc-tFCbD@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-9-sdf@fomichev.me>
 <CACKFLi=j7DO_d46jwZnmZ=OfmkoFA3AXUoX4nmF0tQuYt5Y3UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=j7DO_d46jwZnmZ=OfmkoFA3AXUoX4nmF0tQuYt5Y3UQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33788-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BAD231AD9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/23, Michael Chan wrote:
> On Thu, Mar 19, 2026 at 6:25 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> > we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
> > use uc/mc snapshots and move its call in bnxt_sp_task to the
> > section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> > bnxt_set_rx_mode.
> >
> > 0: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/
> >
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 225217b32e4b..12265bd7fda4 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -11039,7 +11039,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
> >         return rc;
> >  }
> >
> > -static int bnxt_cfg_rx_mode(struct bnxt *);
> > +static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *,
> > +                           struct netdev_hw_addr_list *);
> >  static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
> >                                  const struct netdev_hw_addr_list *);
> >
> > @@ -11135,7 +11136,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
> >                 vnic->rx_mask |= mask;
> >         }
> >
> > -       rc = bnxt_cfg_rx_mode(bp);
> > +       rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
> >         if (rc)
> >                 goto err_out;
> >
> > @@ -13610,11 +13611,12 @@ static void bnxt_set_rx_mode(struct net_device *dev,
> >         if (mask != vnic->rx_mask || uc_update || mc_update) {
> >                 vnic->rx_mask = mask;
> >
> > -               bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
> > +               bnxt_cfg_rx_mode(bp, uc, mc);
> >         }
> >  }
> >
> > -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> > +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
> > +                           struct netdev_hw_addr_list *mc)
> >  {
> >         struct net_device *dev = bp->dev;
> >         struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
> > @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
> >         bool uc_update;
> >
> >         netif_addr_lock_bh(dev);
> > -       uc_update = bnxt_uc_list_updated(bp, &dev->uc);
> > +       uc_update = bnxt_uc_list_updated(bp, uc);
> 
> Will the uc list snapshot change between bnxt_set_rx_mode() and
> bnxt_cfg_rx_mode() with the direct call now?  In the original deferred
> update implementation, the uc list can change and that's why we check
> in both functions.

The snapshot is gonna be the same for bnxt_set_rx_mode->bnxt_cfg_rx_mode path.

So you're saying that it's ok to remove the one in bnxt_cfg_rx_mode
because it's called either from bnxt_set_rx_mode (with a new list) or,
explicitly, via the BNXT_RX_MASK_SP_EVENT retry mechanism (where we know
that we need to redo the updates anyway)?

This makes me wonder whether I need to push the retrying mechanism to
the core stack... Right now, if some of the allocations in wq handler
fail, we just give up, maybe I should handle it better. And I can plug
the signal from the driver (make ndo_set_rx_mode_async return int)
in the same retry mechanism.

