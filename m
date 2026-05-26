Return-Path: <linux-wireless+bounces-36902-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA2NACLIFWpNbQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36902-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 18:19:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2D15D98DE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E03F2305220A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F03B0AF7;
	Tue, 26 May 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpQ4xLvT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FC3B0AF3;
	Tue, 26 May 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812015; cv=none; b=f3MfrkLmZ5wBRVR+uD19Wfj3bJOhUo7JwvFTWDqeAM17tOqYcUpq6MDG8dm9YSwp58Fv7JIMTvrxeZYfw6Z0+5RDgPmQ9odzEZtrg8SdTBUBBLNvHROPZYqgiBuXDEQ4ijU0M8i0cmd2csPDp98qI4ju1Sf33UdFn9Hsx+i8fMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812015; c=relaxed/simple;
	bh=xW7mQnwXGedcSKCCtrk1aQP/FL3phBCCx5+Hkemnwac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNSpMQpPsN7jvvBuLP065QSTefo8xdkX18U3h2fl/Oz/Qdn2Chr7gfE/893lddsd96ZrZgenVF4pii8auqwmCwnpQFt3+bV+568//4ePhWAWViwsuvyG+9NvRPScrB1UoFcbaihf64P2b7CM8uvIhRJvMNyi9i02LbyaKxPN8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpQ4xLvT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B75F1F000E9;
	Tue, 26 May 2026 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812013;
	bh=HoQ502gwpeiNp5KJxRq0pIgzkr0RP/tEx2RDysEICWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OpQ4xLvTA4MJ2XS4/Vzdju1ys4yv/uQ85topgEYflLbhAA+30vT7ARUmzmvcB/T77
	 s1M3fGkNAq2adWMicf7Qw3bch7WWAf11yxvEGYj8io1m1Rs94FPDZ6bzh3UvkO5Owy
	 5SMqjHw6gSZfdvJZOi+Qk+Sw6+qwprY11fe6oU5YpprUv9BPObJ16z4A8NQ21DAsBo
	 BFgwbdoLUSLINdcXBiS25P4kP2OcrQgYYHLpItpcamJFTyGyVJQhyNYTsnMLowV6/9
	 wXK0teGW1H8GSpIOWjz1Q0VXcoLj3vt0G/R8kD1l8WeX61h64NZ3Nq79MJ28Z5pDRC
	 GqjLQst7v2aYw==
Date: Tue, 26 May 2026 21:43:19 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: bod@kernel.org
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com, mchehab@kernel.org,
	elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jjohnson@kernel.org, mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v7 00/15] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <ahXGn4wrEozWd_Ur@sumit-xelite>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
 <177975399325.14006.12128272008783925649.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177975399325.14006.12128272008783925649.b4-reply@b4>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36902-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B2D15D98DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey Brian,

On Tue, May 26, 2026 at 01:06:33AM +0100, bod@kernel.org wrote:
> On 2026-05-22 17:29 +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> > 
> > OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> > support these non-standard SCM calls. And even for newer architectures
> > using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> > calls either with FF-A requirements coming in. And with both OP-TEE
> > and QTEE drivers well integrated in the TEE subsystem, it makes further
> > sense to reuse the TEE bus client drivers infrastructure.
> > 
> > The added benefit of TEE bus infrastructure is that there is support
> > for discoverable/enumerable services. With that client drivers don't
> > have to manually invoke a special SCM call to know the service status.
> > 
> > So enable the generic Peripheral Authentication Service (PAS) provided
> > by the firmware. It acts as the common layer with different TZ
> > backends plugged in whether it's an SCM implementation or a proper
> > TEE bus based PAS service implementation.
> > 
> > The TEE PAS service ABI is designed to be extensible with additional API
> > as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> > extensions of the PAS service needed while still maintaining backwards
> > compatibility.
> > 
> > Currently OP-TEE support is being added to provide the backend PAS
> > service implementation which can be found as part of this PR [1].
> > This implementation has been tested on Kodiak/RB3Gen2 board with lemans
> > EVK board being the next target. In addition to that WIN/IPQ targets
> > planning to use OP-TEE will use this service too. Surely the backwards
> > compatibility is maintained and tested for SCM backend.
> > 
> > Note that kernel PAS service support while running in EL2 is at parity
> > among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
> > on proper IOMMU support being worked out on the PAS client end.
> > 
> > Patch summary:
> > - Patch #1: adds Kodiak EL2 overlay since boot stack with TF-A/OP-TEE
> >   only allow UEFI and Linux to boot in EL2.
> > - Patch #2: adds generic PAS service.
> > - Patch #3: migrates SCM backend to generic PAS service.
> > - Patch #4: adds TEE/OP-TEE backend for generic PAS service.
> > - Patch #5-#13: migrates all client drivers to generic PAS service.
> > - Patch #14: drops legacy PAS SCM exported APIs.
> > 
> > The patch-set is based on qcom tree tip [2] and can be found in git tree
> > here [3].
> > 
> > Merge strategy:
> > 
> > It is expected due to APIs dependency, the entire patch-set to go via
> > the Qcom tree. All other subsystem maintainers, it will be great if I
> > can get acks for the corresponding subsystem patches.

It looks like you missed this merge strategy part of the cover letter.

> > 
> > [1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=for-next
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v7
> > 
> > ---
> > Changes in v7:
> > - Rebased to qcom tree (for-next branch) tip.
> > - Merged patch #5 and #7 due to build dependency.
> > - Disabled modem for kodiak EL2 as it isn't tested yet.
> > - Fix an issue found out by sashiko-bot for patch #4.
> 
> This whole series needs to be broken up into different parts and sent in
> smaller chunks landing the core changes into the firmware, the drivers and
> finally the dts.

The DTS EL2 change for Kodiak is totally independent one and that's why
it's the first one in this series which can be picked independently.

> 
> For example applying the Iris stuff is impossible until the remoteproc
> stuff lands.
> 
> Instead of sending one giant series which no one maintainer can apply send
> a number of series where one posts a dependency on the other.

The subsystem changes like for Iris are just about renaming of the
firmware APIs to be used which is moving away from SCM specific API to
the generic PAS API. I don't think there is any clean way to merge the
API renaming changes independently of when the new API gets introduced.

> 
> Lumping the TEE stuff in with video encoder, wifi, dts is spanning too many
> things and makes merging a NAK.
> 
> Break this up into logical chunks and sequence a one series on top of the
> other - accpeting that you might, likely will have to keep on top of the
> various series and resend/rebase as things get merged.

I tried my best for the logical split of the patches here keeping the
subsystems changes to very minimal required (only renaming firmware
APIs). I would be open to any further suggestions.

However, if you are happy with firmware APIs renaming for the media
subsystem then it will be nice to get ack from you. I hope Bjorn can
then pickup the entire series.

-Sumit

> 
> > Changes in v6:
> > - Rebased to v7.1-rc4 tag.
> > - Patch #14: fixed ret error print.
> > - Add Kconfig descriptions for PAS symbols such that they are visible
> >   in menuconfig to update.
> > 
> > Changes in v5:
> > - Incorporated misc. comments from Mukesh.
> > - Split up patch #11 into 2 to add an independent commit for passing
> >   proper PAS ID to set_remote_state API.
> > - Picked up tags.
> > 
> > Changes in v4:
> > - Incorporate misc. comments on patch #4.
> > - Picked up an ack for patch #10.
> > - Clarify in cover letter about state of media support.
> > 
> > Changes in v3:
> > - Incorporated some style and misc. comments for patch #2, #3 and #4.
> > - Add QCOM_PAS Kconfig dependency for various subsystems.
> > - Switch from pseudo TA to proper TA invoke commands.
> > 
> > Changes in v2:
> > - Fixed kernel doc warnings.
> > - Polish commit message and comments for patch #2.
> > - Pass proper PAS ID in set_remote_state API for media firmware drivers.
> > - Added Maintainer entry and dropped MODULE_AUTHOR.
> > 
> > Mukesh Ojha (1):
> >   arm64: dts: qcom: kodiak: Add EL2 overlay
> > 
> > Sumit Garg (14):
> >   firmware: qcom: Add a generic PAS service
> >   firmware: qcom_scm: Migrate to generic PAS service
> >   firmware: qcom: Add a PAS TEE service
> >   remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
> >   remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
> >   remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
> >   remoteproc: qcom: Select QCOM_PAS generic service
> >   drm/msm: Switch to generic PAS TZ APIs
> >   media: qcom: Switch to generic PAS TZ APIs
> >   media: qcom: Pass proper PAS ID to set_remote_state API
> >   net: ipa: Switch to generic PAS TZ APIs
> >   wifi: ath12k: Switch to generic PAS TZ APIs
> >   firmware: qcom_scm: Remove SCM PAS wrappers
> >   MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
> > 
> >  MAINTAINERS                                   |   9 +
> >  arch/arm64/boot/dts/qcom/Makefile             |   2 +
> >  arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  39 ++
> >  drivers/firmware/qcom/Kconfig                 |  21 +-
> >  drivers/firmware/qcom/Makefile                |   2 +
> >  drivers/firmware/qcom/qcom_pas.c              | 291 +++++++++++
> >  drivers/firmware/qcom/qcom_pas.h              |  50 ++
> >  drivers/firmware/qcom/qcom_pas_tee.c          | 477 ++++++++++++++++++
> >  drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
> >  drivers/gpu/drm/msm/Kconfig                   |   1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
> >  drivers/media/platform/qcom/iris/Kconfig      |  25 +-
> >  .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
> >  drivers/media/platform/qcom/venus/Kconfig     |   1 +
> >  drivers/media/platform/qcom/venus/firmware.c  |  11 +-
> >  drivers/net/ipa/Kconfig                       |   2 +-
> >  drivers/net/ipa/ipa_main.c                    |  13 +-
> >  drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
> >  drivers/net/wireless/ath/ath12k/ahb.c         |  10 +-
> >  drivers/remoteproc/Kconfig                    |   4 +-
> >  drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
> >  drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
> >  drivers/remoteproc/qcom_wcnss.c               |  12 +-
> >  drivers/soc/qcom/mdt_loader.c                 |  12 +-
> >  include/linux/firmware/qcom/qcom_pas.h        |  43 ++
> >  include/linux/firmware/qcom/qcom_scm.h        |  29 --
> >  include/linux/soc/qcom/mdt_loader.h           |   6 +-
> >  28 files changed, 1124 insertions(+), 320 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.c
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.h
> >  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> >  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> > 
> > -- 
> > 2.51.0
> > 
> > 
> 
> 

