Return-Path: <linux-wireless+bounces-27951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977EBD1CEB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD361890CAB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174D19C54E;
	Mon, 13 Oct 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="FqLp6acL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454927934B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340625; cv=none; b=N1ZqmlSYpR34koZ2TjjmqPFiKNrDcKRBD+vP/Ch862KOB3Ga7QaX0hLSkZBD7FL72iNW887cs9Vt0BiHowc5Q0Td6XphIlrSMZaX0NWleLaRG4REIeZaIt/V8HUGWqhbkTxAtoM5KT7zx2u8ZIRIQvQNtHpIVXZ7tZ9U/cPOJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340625; c=relaxed/simple;
	bh=T9N1F/ssv2+Yb4PZMJoCocjOG3Ky+daCqJjUbxs6Wlc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irKcPa925ejPfUtEdGoB+CGNljQqgW2XWN1DG54k1FgyrzSoxREzusN9tD95FwMZ34NXdWbUUNlmp+CwdDorQy39Zf/ZcSitAK1zZ8KXJZnwMMvz4mIOc6syt66Vm73ooW990XUkTpGsp39EzHXXwjUmoNzHgUqyS5QbM4ar0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=FqLp6acL; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1760340622; x=1791876622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T9N1F/ssv2+Yb4PZMJoCocjOG3Ky+daCqJjUbxs6Wlc=;
  b=FqLp6acLqOoUJf7/IvqEH9085Ymz2ZcyVt69ESPdoQXHDRb657uykJ5e
   7p7l3pZSlLGp1XD5/9qxQ3ZXy+ZuXM6CxbmCgnctp62lJH65Y0Mxf+DEV
   CMi40HeHrZpAfbBm4k95fsuDZotLcTBqeT/o7dqBuQgrk0D0WI7dD1ngU
   0=;
X-CSE-ConnectionGUID: ocYOW8omTAGJDCNc8tBYdA==
X-CSE-MsgGUID: LTvFHWwNQQOo8gXs6iu40Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="114287522"
X-IronPort-AV: E=Sophos;i="6.19,224,1754949600"; 
   d="scan'208";a="114287522"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:29:11 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 09:29:09 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 09:29:07 +0200
Date: Mon, 13 Oct 2025 12:58:58 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>,
	<chris@streetlogic.pro>, <linux-wireless@vger.kernel.org>,
	<richard@govivid.ai>, <s311332@gmail.com>, <wahrenst@gmx.net>,
	<wlan-kernel-dev-list@infineon.com>, <johannes@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: fix crash while sending
 Action Frames in standalone AP Mode
Message-ID: <aOyqOnKEnkNqfg9u@ISCN5CG14747PP.infineon.com>
References: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
 <20251009073928.6803-1-gokulkumar.sivakumar@infineon.com>
 <08368241-6b89-49e5-81cf-8e7874c91696@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08368241-6b89-49e5-81cf-8e7874c91696@broadcom.com>
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

On 10/12, Arend van Spriel wrote:
> On 10/9/2025 9:39 AM, Gokul Sivakumar wrote:
> > Currently, whenever there is a need to transmit an Action frame,
> > the brcmfmac driver always uses the P2P vif to send the "actframe" IOVAR to
> > firmware. The P2P interfaces were available when wpa_supplicant is managing
> > the wlan interface.
> > 
> > However, the P2P interfaces are not created/initialized when only hostapd
> > is managing the wlan interface. And if hostapd receives an ANQP Query REQ
> > Action frame even from an un-associated STA, the brcmfmac driver tries
> > to use an uninitialized P2P vif pointer for sending the IOVAR to firmware.
> > This NULL pointer dereferencing triggers a driver crash.
> > 
> >   [ 1417.074538] Unable to handle kernel NULL pointer dereference at virtual
> >   address 0000000000000000
> >   [...]
> >   [ 1417.075188] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
> >   [...]
> >   [ 1417.075653] Call trace:
> >   [ 1417.075662]  brcmf_p2p_send_action_frame+0x23c/0xc58 [brcmfmac]
> >   [ 1417.075738]  brcmf_cfg80211_mgmt_tx+0x304/0x5c0 [brcmfmac]
> >   [ 1417.075810]  cfg80211_mlme_mgmt_tx+0x1b0/0x428 [cfg80211]
> >   [ 1417.076067]  nl80211_tx_mgmt+0x238/0x388 [cfg80211]
> >   [ 1417.076281]  genl_family_rcv_msg_doit+0xe0/0x158
> >   [ 1417.076302]  genl_rcv_msg+0x220/0x2a0
> >   [ 1417.076317]  netlink_rcv_skb+0x68/0x140
> >   [ 1417.076330]  genl_rcv+0x40/0x60
> >   [ 1417.076343]  netlink_unicast+0x330/0x3b8
> >   [ 1417.076357]  netlink_sendmsg+0x19c/0x3f8
> >   [ 1417.076370]  __sock_sendmsg+0x64/0xc0
> >   [ 1417.076391]  ____sys_sendmsg+0x268/0x2a0
> >   [ 1417.076408]  ___sys_sendmsg+0xb8/0x118
> >   [ 1417.076427]  __sys_sendmsg+0x90/0xf8
> >   [ 1417.076445]  __arm64_sys_sendmsg+0x2c/0x40
> >   [ 1417.076465]  invoke_syscall+0x50/0x120
> >   [ 1417.076486]  el0_svc_common.constprop.0+0x48/0xf0
> >   [ 1417.076506]  do_el0_svc+0x24/0x38
> >   [ 1417.076525]  el0_svc+0x30/0x100
> >   [ 1417.076548]  el0t_64_sync_handler+0x100/0x130
> >   [ 1417.076569]  el0t_64_sync+0x190/0x198
> >   [ 1417.076589] Code: f9401e80 aa1603e2 f9403be1 5280e483 (f9400000)
> > 
> > Fix this, by always using the vif corresponding to the wdev on which the
> > Action frame Transmission request was initiated by the userspace. This way,
> > even if P2P vif is not available, the IOVAR is sent to firmware on AP vif
> > and the ANQP Query RESP Action frame is transmitted without crashing the
> > driver.
> > 
> > Remove init_completion() for "send_af_done" from brcmf_p2p_create_p2pdev()
> > and do it in brcmf_p2p_tx_action_frame() instead of reinit_completion().
> > Because the formar function would not get executed when hostapd is managing
> > wlan interface, and so it is not safe to do reinit_completion() without any
> > prior init_completion().
> > 
> > And in the brcmf_p2p_tx_action_frame() function, the condition check for
> > P2P Presence response frame is not needed, since the wpa_supplicant is
> > properly sending the P2P Presense Response frame on the P2P-GO vif instead
> > of the P2P-Device vif.
> 
> Thanks, Gokul
> 
> Looks good. Respecting the vif provided by userspace is a better
> approach. So the actual issue is that hostapd does not create the
> P2P-Device interface, which is why I suggested to fallback on the
> primary vif. Overlooked the fact that we are doing a init_completion()
> in brcmf_p2p_create_p2pdev() which is needed for the action frame
> transmit. I have some comment on theat init_completion() change you made
> (see below).
> 
> Still would prefer to move the action frame transmit (afx) functionality
> out of the p2p source file, but that can be a separate rework.

I agree. The action frame transmission funcationality should properly work
for STA and AP mode, irrespective of P2P being enabled/disabled. So this
functionality needs to be cleaned up.

> > Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
> > Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> > ---
> >   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  3 +-
> >   .../broadcom/brcm80211/brcmfmac/p2p.c         | 28 ++++++-------------
> >   .../broadcom/brcm80211/brcmfmac/p2p.h         |  3 +-
> >   3 files changed, 11 insertions(+), 23 deletions(-)
> [...]
> 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > index 0dc9d28cd77b..c7c40dc3be08 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> 
> [...]
> 
> > @@ -1538,28 +1539,20 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
> >    * The WLC_E_ACTION_FRAME_COMPLETE event will be received when the action
> >    * frame is transmitted.
> >    */
> > -static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
> > +static s32 brcmf_p2p_tx_action_frame(struct brcmf_if *ifp,
> > +                                  struct brcmf_p2p_info *p2p,
> >                                    struct brcmf_fil_af_params_le *af_params)
> >   {
> >       struct brcmf_pub *drvr = p2p->cfg->pub;
> > -     struct brcmf_cfg80211_vif *vif;
> > -     struct brcmf_p2p_action_frame *p2p_af;
> >       s32 err = 0;
> > 
> >       brcmf_dbg(TRACE, "Enter\n");
> > 
> > -     reinit_completion(&p2p->send_af_done);
> > +     init_completion(&p2p->send_af_done);
> 
> I think we should not do this here. It used to be init_completion() here
> but the kernel API changed introducing the reinit_completion() to make
> explicit distinction between init and reinit. So I would suggest to do
> the init_completion() in brcmf_p2p_attach() which is always invoked and
> leave the reinit_completion() here.

That works too. Will create an updated v2 patch after making this change
and submit it for the wireless tree instead of wireless-next.

