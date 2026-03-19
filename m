Return-Path: <linux-wireless+bounces-33488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLH5CtUcvGlEsQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 16:57:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235E2CE1EC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 16:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7248B304DE9F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992A3E95A3;
	Thu, 19 Mar 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+8mmbCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D83E8C68
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935672; cv=none; b=U8d/LbmjfMlf/l+NpTjBPEp9guZabI8jFULgyeqcm0WeYxSIpCPA8cgiw19koZNWH6n+QaY6zMRWss9yYLDn3E0kXf5oZNTrZhM3zOv+tHtngCrhymaOtU4bwi1JVZgbAM6YGih3lXBpOPw3k/ITVgC8I8WegXFJkMsCWivCVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935672; c=relaxed/simple;
	bh=R8P+nzrGUnHar1fqbHTHhRFzTZN26dppzSbv7zUS0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+252xh+xs21AqBLuYR3klhAf6QXYCqcVxaDUhabVSZC81pjvsUVvIGq3qB17qcQ/sqZC+bQLzHdUhVlpvxqSK3PPDWDRn8TNv0DIbx9vpsSw9LwvTCc5IuKqFWrVV8SftXwQfnKnzzYaNMe4nCWzwutE6PM/o5XrgOZ7TV5ZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+8mmbCo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a62714fe6so548118b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935670; x=1774540470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flkM1UPgnzZIIWUPlhpYdE/CMruOMnml9ArMjCoVGE8=;
        b=m+8mmbCoDRXID1BSDq4Yo8bF2vMzor2WqvMm9Nw0Y2AJ63KQ206DCRziTdiW6BuDBa
         l+3E5e+hcL9SDO6+it1cO13CRo3sa4QYguChCHGKFBQQhZMsvRiNm0vpukn293Wesyw5
         NyhmpGeXMjIp52E4EiVka+WgbJIHq1h2wd1RegjH5L/RoZ29l8se8WoEOvKNAHhmRw1l
         ZSVEx2JAz5+O4cjZI1sVEGiqv0IXjbsOj8VtE0s8fsH3mR1Nho6okKKHAWGpQ6rXOUfK
         atalspuIyLhm79iWEeJCJ4L3dLxGToieE5iZjdmC+/p8rGo1NxzcAFaCVSlx+p11o04x
         S8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935670; x=1774540470;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flkM1UPgnzZIIWUPlhpYdE/CMruOMnml9ArMjCoVGE8=;
        b=TKdFH79LLPhAGDsrPq/TOn11cG9yydL9Jj+XJfunX0L4iAhwJCvFJjJLjsGUeXgybC
         21iLqcTAe8bh/+LNBixSVfFy5f6y38fVQMX0sabxm/4zgmpZA6gBFKNZehSN405Rt60r
         YQy8BtWuqMZxghA97ZQvYLVYt0BVMXXiNxEQbZd2b66AGfHGnIwiZQkZD68QRisKgaQm
         b5R12oyLXZGRI7RBdcQ44wujd19V8XyW42J53QTJfZL2O1xMmrGg0mgO7y8MjwiAjC0k
         NTrgp3/L4WQqndKlQc8ILsLPnkVB3I5Yhb0XzlqdKE13rk4jlKgmHSQQ9kNNamE1TdOy
         SCHg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPslr0Pz0RlTTB2e6ACoktOgOBw+bsbsfVE79fyAuNYboWSpdxmhk7ygFTeabHuDpYGrBseCx+z9pq6IiwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78i90H6FF0w73Qy+G6IiJ3fb16GWN2s1+XzuM4nyLX1yHNvqp
	wRzuiDXJ+MNkXijaar5At9v4qufx9yaBjXgn4TP+K5r0hJVSTPh28+g=
X-Gm-Gg: ATEYQzwunPN46RiFKK3Z1aRWW6YGR34qE2eBzx+nJyYudSker/KnsqyYbYGUqoMBcD7
	cVwH3DCCi+pJK4w9naeU5R+y7ztghGldbifIwfbq9GUwkuCg5kpPDOSBOE8uM8RSZHkv2Fbzccg
	vZ/RUr2TIdNS7o5sA0qctKkFrpqUCylZlexepyge6tZ81fcaEnIpzr1P5fKsRQIi1ESd4tmv+15
	ul4f2c9OyY0nFZmxmru88LdOK1x12MON+X8FSz29lJ2eYBaIS4FukLUKHcujDKXg4PptIe8TrZx
	JSjQkH/A3tFz6yvGqabEgsOX0tBS4prZvi+ZTlO4Jw1owFsWoZKvRq8YQLaWWJZ+3uiHt+hTI/0
	YfqhEtCjDp/93mYO75s9iXmxEx+WeJqEbxucqam1HNglGJ8g4VEnn9P4HTPjTMhRxnmMSbCgNNe
	2l++76z9HbxCn7kPvqtRgjECHD+qzppmu8lC9DHMeIDrFKxPxSkD65A+zeqPHX+m+a3thegQ+4/
	QnRTcHWShAZJ7LaUg==
X-Received: by 2002:a05:6a00:a8c:b0:829:f777:dad4 with SMTP id d2e1a72fcca58-82a7a97b202mr3053986b3a.29.1773935669410;
        Thu, 19 Mar 2026 08:54:29 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb51d1sm7913205b3a.28.2026.03.19.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:54:29 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:54:28 -0700
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
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 08/13] bnxt: use snapshot
 in bnxt_cfg_rx_mode
Message-ID: <abwcNMcZHW0ThCkW@mini-arch>
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
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-9-sdf@fomichev.me>
 <IA3PR11MB89866985981DB64EFEBDF0ACE54FA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89866985981DB64EFEBDF0ACE54FA@IA3PR11MB8986.namprd11.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-33488-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.824];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1235E2CE1EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/19, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Stanislav Fomichev
> > Sent: Wednesday, March 18, 2026 4:03 PM
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
> > skhawaja@google.com; bestswngs@gmail.com; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> > rdma@vger.kernel.org; linux-wireless@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; leon@kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v2 08/13] bnxt: use
> > snapshot in bnxt_cfg_rx_mode
> > 
> > With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> > we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to use
> > uc/mc snapshots and move its call in bnxt_sp_task to the section that
> > resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> > bnxt_set_rx_mode.
> > 
> > 0:
> > https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+
> > 6NZnyoNm90KA@mail.gmail.com/
> > 
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 ++++++++++++++--------
> > -
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> ...
> 
> > -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> > +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct
> > netdev_hw_addr_list *uc,
> > +			    struct netdev_hw_addr_list *mc)
> >  {
> >  	struct net_device *dev = bp->dev;
> >  	struct bnxt_vnic_info *vnic = &bp-
> > >vnic_info[BNXT_VNIC_DEFAULT];
> > @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
> >  	bool uc_update;
> > 
> >  	netif_addr_lock_bh(dev);
> > -	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
> > +	uc_update = bnxt_uc_list_updated(bp, uc);
> >  	netif_addr_unlock_bh(dev);
> > 
> >  	if (!uc_update)
> > @@ -13642,7 +13644,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
> >  	if (netdev_uc_count(dev) > (BNXT_MAX_UC_ADDRS - 1)) {
> >  		vnic->rx_mask |=
> > CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
> This limit check uses the live device list, dev->uc.
> In the new async model, the live list can differ from the snapshot.

Oh, yes, good catch! Will do s/netdev_uc_count/netdev_hw_addr_list_count(uc).

