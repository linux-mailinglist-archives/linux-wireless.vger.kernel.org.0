Return-Path: <linux-wireless+bounces-37986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWPzNmmyOWrdwQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 00:08:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D66B292E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 00:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=h2wOfdWR;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="d jVgDwe";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37986-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37986-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A14FB3030754
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13B37B002;
	Mon, 22 Jun 2026 22:08:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A57348C7B;
	Mon, 22 Jun 2026 22:08:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166109; cv=none; b=gOgE/aIjB2LbIZP62kfoe+x/uhgw2DvUP1rpYMUkDf/7qWbOtvo3T6afHl0K0uv6w7TU5o3og9nIUjSO2Eukm2FP2k6mbw7KsAkKsVWMP9NOP2MZv3Tyhn0/LYNb9OKNPImIRpO/vZNVQUv0DL0I4BtrJpVdTlF9nm7F6FC56Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166109; c=relaxed/simple;
	bh=cAMszgx5Fex6SF1BAzROg2EuI/9SrWSdciR3fR97dv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgAWoIIViF/+TBGuM1pigkFcHiOzSfyKt/MLVPfvpL9cEBUHgsnrTiYWl+xVTQ15UXuK8XYMGv9KQPU0JQ3ibv2vSpO6GzlroA3wI5Er2+4PzUazb8jC6TtSa5UWUjBSLoz+4WvqLLYjTKgXQfneUUZx+WxM7b5kJJgObjDgyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=h2wOfdWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djVgDwe8; arc=none smtp.client-ip=202.12.124.151
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BBBA01D000F8;
	Mon, 22 Jun 2026 18:08:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 18:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782166105;
	 x=1782252505; bh=aePkQjGQu+YPsOWr++gYmU3NbJPlCwiidf9kOEVP8qs=; b=
	h2wOfdWRXfMtqHdeLxElxXOB6tc5rRB9y5vXbeUpmHWU3XDgJ3uxkT65o0+xCZqx
	0LIxD8/ligPoxSgFis+Rph38xK5jdEGiUl3NHM0xtic82lU30UdG6ZuWB2IoO/8u
	9NqURy8KgMedxfObUaNnSn3syk4aW8wkO9YtFN+MS16/UEEBN+d90kQg7fSQh95R
	90t6fh0zF9gVcAkXw3E9tzZSejVo9icgTHzsejbR4EyZrqsBUr4VIF6ojLsEaNLT
	Kxn7M5HnOrDJqhE3iAt3JdGgfID07DXFFc40ZSburY/dkepxLM1/aOJSz2bB7Ks8
	BpQooVSXQw5doXDibpcxdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782166105; x=
	1782252505; bh=aePkQjGQu+YPsOWr++gYmU3NbJPlCwiidf9kOEVP8qs=; b=d
	jVgDwe8fhKZx50Si7f5mJLdL0E0rm76bUH/9P2DNeeC4HqW797DHLOSOE776EKeU
	2pXYxuqSoeO8Te6aoFjnIxEoPamjiT/6sBsRTOYX/6mDVD4MxHlIBynho5VCuWTB
	+1wckEXDjNXj17SGhAW7d3x2VHH9yqvX4FdvLKue3jaenXFwgwuuM+zZBwEjv+Jc
	uGczv4Zq5GTYALO3qYwV2yKMWvoGWD1M6rgAershGiBz71PrEbAngULTHB1IZmaj
	2sXWQ1ft3b+2Rla3fb19bgHfPTov0tfzrL7qgxG2fhvgOMexR9nqMDPTg2qFCa11
	q2ULwQ5JYDJmpa4JJ7EsQ==
X-ME-Sender: <xms:WLI5as388WQSxAdWCWpKWmXmTsHrjJBq9BJLEXt9Ih1P4TE3dYaN2w>
    <xme:WLI5avOiI2ILKScsvd1OJqo4ivO5rdBxwW8y-spr1Q_9nFqAi8U5mLREHSxOIdQ30
    h5h8y3rlaH1hRsrrYVnYm24UOfrdfYHQKvzO5Avwf8_pGVBdpD8_Q>
X-ME-Received: <xmr:WLI5akbBL4lLDC5gMOrGgb0tVEroWUcPPB5XMUN3y-LMn9aAxqUFYYf1cr4>
X-ME-Proxy-Cause: dmFkZTF0ec7bWNTJ4dpCl7l9+0ECFQ3bgfPAi09+/jLI+RM2LOSskW7kp3FOx7LYEF+nWE
    EuQloCpn3ysspX8LYulsIBXIlZnA26gO957f2eq+Ac0bNVQRC0R1RrxqF2FEvrfnz1MWnH
    G71l7qvQVXUZxdOiUrnRMPxpagI1YORu7T/bf7QcoFlGm6CkIOi9gKNFyQpr7rLwltIAzu
    QLBHcz6DSeCYPxfCsptOFWZolwBo9GmEAwRMiM499w64pC5k3ePPyD1/i1brvy63P5PmVw
    axpA85TA/YVWB4zfcW//ryNKRMCp532KQvvwDh6PyIh6PJDCsE0AUxCp9d2lZkens55Nrf
    oUGz2R1ETI5E3F4lYLWTwEw77ftcIXvmCV3ZMd8XX2xw79xtJBiuyoUVDpdxa4LR7BRsl2
    abBaooQFYcRPWaISNvoylZ3ux927qHkTBkjr5yQPBa6ndbjk91mXihjxpiiauwZNgs1PCw
    3QOVD3BszNyNSSUZHTR0ZpeQLQv/LEx6CQH+J/EvSR1sjMuXB+udl1qX1Zsf7awnc9QFNv
    /lr9dVTL82O74eomKcf/0bU3iNYKUdPeSWjqbZOTQPutsnaKLrclRrEcVwd79fmiWNtlKq
    bRcodXrr0XBO6rI6lI9ycqfC6F3a7TMvK6oBk9rshCxy6Ies8xkgUQDu/V4Q
X-ME-Proxy: <xmx:WLI5alyt7IP6sRAyRpvvUcj9Mc8IJmsAP6AetS94c-obX-2QzHoLKg>
    <xmx:WLI5arOZRuXLS6JEXPBDI4Sk7XcnHATO2wk5JrIVq4WrY9TpPgnvSw>
    <xmx:WLI5asfil11ha1DueledzbFmW5Xg2opIWnhezxh6_F-_oFE42x8CgQ>
    <xmx:WLI5aoRjyImPz_b0H7GMmX2MR8syyYc8mvrYnxFu1yc0TXarC-cR6w>
    <xmx:WbI5amjt19OXgvB606HT8Rgl-OTy44CL78JWx9jS310UkI7BeVCg41HQ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 18:08:23 -0400 (EDT)
Date: Mon, 22 Jun 2026 16:08:22 -0600
From: Alex Williamson <alex@shazbot.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 bhelgaas@google.com, jjohnson@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 mhi@lists.linux.dev, alex@shazbot.org
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <20260622160822.09350246@shazbot.org>
In-Reply-To: <4wmbans3ae5ayxqvs3wwn4hg3r3dcjuugmw2akoihvry35bq6k@k5lm6zjrp44l>
References: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
	<20260618063309.9536-1-jtornosm@redhat.com>
	<4wmbans3ae5ayxqvs3wwn4hg3r3dcjuugmw2akoihvry35bq6k@k5lm6zjrp44l>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37986-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:jtornosm@redhat.com,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B7D66B292E

On Mon, 22 Jun 2026 18:22:39 +0200
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Thu, Jun 18, 2026 at 08:33:08AM +0200, Jose Ignacio Tornos Martinez wr=
ote:
> > Hi Mani,
> >=20
> > Let me clarify the exact scenario and where the reset is necessary:
> >=20
> > * For the commented WiFi devices (WCN6855/WCN7850):
> >=20
> > Standard VFIO passthrough flow (this works fine):
> >   1. Unbind native driver (ath11k/ath12k/MHI)
> >   2. Bind vfio-pci driver
> >   3. Assign device to VM
> >   4. VM boots, loads its own driver =E2=86=92 device works perfectly
> >   5. VM shuts down cleanly =E2=86=92 device can be reassigned =E2=86=92=
 works fine
> >=20
> > The problem occurs with unclean VM termination:
> >   1. VM crashes or is force-terminated
> >   2. VFIO tries to reset the device before reassignment
> >   3. Without a working PCI reset method, reset fails
> >   4. Device stuck in undefined state =E2=86=92 cannot be reassigned to =
another VM
> >  =20
> >      Unbinding the driver again doesn't help because the device hardware
> >      itself is in a bad state. From hypervisor:
> >      $ lspci -vvv -s 0000:03:00.0
> >         03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff)=
 (prog-if ff)
> >             !!! Unknown header type 7f
> >      And a full host power-cycle is necessary to recover.
> >       =20
>=20
> Can you try the global reset available in the WLAN device BAR space?
>=20
> WCN6855: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree=
/drivers/net/wireless/ath/ath11k/pci.c#n193
> WCN7850: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree=
/drivers/net/wireless/ath/ath12k/pci.c#n182
>=20
> > * For the commented modem devices (SDX62/SDX65):=20
> >=20
> > Even worse because it fails during the first VM boot without proper res=
et
> > capability, standard VFIO passthrough flow:
> >   1. Unbind native driver (MHI)
> >   2. Bind vfio-pci driver
> >   3. Assign device to VM
> >   4. VM boots, loads its own driver and crashes:
> >      [   24.024165] mhi mhi0: Device failed to enter MHI Ready
> >      [   24.024168] mhi mhi0: MHI did not enter READY state
> >     =20
> >      Unbind/rebind attempts fail:
> >      [  352.643601] mhi mhi0: Requested to power ON
> >      [  352.643611] mhi mhi0: Power on setup success
> >      [  373.442954] mhi mhi0: Device failed to clear MHI Reset
> >      [  373.442970] mhi mhi0: MHI did not enter READY state
> >      And requires a full host power cycle to recover,
> >      even outside of VFIO scenarios.
> >=20
> > * MHI Host driver's remove callback may handle clean software state
> > teardown, but it doesn't provide a PCI reset capability that VFIO can
> > invoke. VFIO needs a reset method registered in the PCI reset hierarchy
> > (device_specific, pm, flr, bus, etc.). VFIO invokes this reset both dur=
ing
> > initial device binding (before the VM starts) and when reassigning the
> > device between VMs - without a working reset method, the device cannot
> > reach a clean state for initialization.
> >  =20
>=20
> Likewise, there is a SoC reset available in the modem BAR space. You can =
try it:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/=
bus/mhi/host/main.c#n178
>=20
> If these works, then you can hook these in the device_specific reset call=
back.


These look promising as simple flows to implement in a device specific
reset: save command register, set memory enable, ioremap BAR space,
match read/write/delay sequences of reset function and caller, iounmap,
restore command.

Note the delay in this latter reset is in the caller.  It's also
surprising that none of these implement a read to flush the posted
write that initiates the reset.  I wonder if that contributes to the 2s
delay in the latter example.

Also it appears these reset the internal state, but not the PCI state,
which is fine for our purposes, and certainly more confidence inspiring
than the D3hot heuristics.  Thanks,

Alex

