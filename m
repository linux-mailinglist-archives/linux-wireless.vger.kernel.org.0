Return-Path: <linux-wireless+bounces-36789-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO3VM4IJEGpqSwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36789-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:45:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CC5B024A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C010E300DDFF
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 07:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96523A5439;
	Fri, 22 May 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf/t7jKs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAF1E49F;
	Fri, 22 May 2026 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435851; cv=none; b=JmdE1YMcJ0FClapmEqIkRYfXKDtinkT6wF+Zspu8knzliKPDQoDaWSwNMXok4fY/KqQz83E9AABFREL9GG5o+7VTkbu35eh05Zxq7N4FTwA9TpuFkeCj90rHXOg3yIFK+cWBUu9qgsLdYTi0av3UU95JAVffSIyK+gg2jWMzjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435851; c=relaxed/simple;
	bh=5bHFpjEEFUoqVuL5uo5C5zJNjk2npHys5cbdOrqnQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni0f77zWSIDnzOE0a3pjICutsJ6OhXU3XeU2OHYjO1vn0ljPtL1IImmLF38R/ng1q/1BMUJp36hxewXkfpa54nVc3DEJ0znyYT/7TMO91NivR2/hayOh+jPznII6HB3ykjjisn0doEIBJ4wWyXxWg9A8vwe1WB1kNXyZqgMObc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf/t7jKs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D331F00A3D;
	Fri, 22 May 2026 07:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779435849;
	bh=VrXF29bFOvYEg9sO118+umVcO0JfkNNCWZdK/cFtHow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vf/t7jKsSIO+qe+6tRxPYGoD9FkkGxUyqleh8qsf5JEmI5yAFfQfd6bWqmNwSLqFE
	 JC1TPXCMF1wNkSklStK+IGJs47944uD9x7MBKjfQgdgfl8tW7eoK4r0LozYPT16OSk
	 zNL62XYTRBBIGmsJRtf6asAsSmE3/aCIv1kBwwLpDZLof0FtkOLEOa5exGdWXmuxUt
	 bFE0ONHq/F/EWqPTTVS6/mUik8viyElQpIT1jkmP/iY6duPIpIsWC4+qVlonn0dS0k
	 TONP00VWjfoGsNyvjSJiz5gWGYonLoCjznbVnwQF8PFC5pFQxJhMGJy2Tk71iGze9o
	 NxaiQGYc4GsMw==
Date: Fri, 22 May 2026 13:13:51 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
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
	dikshita.agarwal@oss.qualcomm.com, bod@kernel.org,
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 00/16] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <ahAJN_GEmKHA5tn3@sumit-xelite>
References: <20260518072856.22790-1-sumit.garg@kernel.org>
 <bc3eb187-d0a4-40ce-b72c-1724b33e28ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3eb187-d0a4-40ce-b72c-1724b33e28ea@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36789-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 7E8CC5B024A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:27:05AM -0700, Jeff Johnson wrote:
> On 5/18/2026 12:28 AM, Sumit Garg wrote:
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
> > - Patch #5-#14: migrates all client drivers to generic PAS service.
> > - Patch #15: drops legacy PAS SCM exported APIs.
> > 
> > The patch-set is based on v7.1-rc4 tag and can be found in git tree here
> > [2].
> > 
> > Merge strategy:
> > 
> > It is expected due to APIs dependency, the entire patch-set to go via
> > the Qcom tree. All other subsystem maintainers, it will be great if I
> > can get acks for the corresponding subsystem patches.
> > 
> > [1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v6
> > 
> > ---
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
> > Sumit Garg (15):
> >   firmware: qcom: Add a generic PAS service
> >   firmware: qcom_scm: Migrate to generic PAS service
> >   firmware: qcom: Add a PAS TEE service
> >   remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
> >   remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
> >   soc: qcom: mdtloader: Switch to generic PAS TZ APIs
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
> >  arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  35 ++
> >  drivers/firmware/qcom/Kconfig                 |  21 +-
> >  drivers/firmware/qcom/Makefile                |   2 +
> >  drivers/firmware/qcom/qcom_pas.c              | 291 +++++++++++
> >  drivers/firmware/qcom/qcom_pas.h              |  50 ++
> >  drivers/firmware/qcom/qcom_pas_tee.c          | 476 ++++++++++++++++++
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
> >  28 files changed, 1119 insertions(+), 320 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.c
> >  create mode 100644 drivers/firmware/qcom/qcom_pas.h
> >  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> >  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> > 
> 
> In my automation I do bisection builds and it fails when I bisect.

Thanks for this report. It's really rather a directly dependency of
qcom_q6v5_pas on mdt_loader. Switching them individually is causing this
git bisection problem. I don't see any other way to fix this apart from
mergging patch 5/16 and 7/16. Will do that for v7.

> 
> At "remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs":
> 
> ../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_load':
> ../drivers/remoteproc/qcom_q6v5_pas.c:244:44: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
>   244 |                 ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
>       |                                         ~~~^~~~~~~~~~~~~
>       |                                            |
>       |                                            struct qcom_pas_context *
> In file included from ../drivers/remoteproc/qcom_q6v5_pas.c:27:
> ../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
>    23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
>       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_start':
> ../drivers/remoteproc/qcom_q6v5_pas.c:322:36: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
>   322 |         ret = qcom_mdt_pas_load(pas->pas_ctx, pas->firmware, rproc->firmware,
>       |                                 ~~~^~~~~~~~~
>       |                                    |
>       |                                    struct qcom_pas_context *
> ../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
>    23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
>       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> make[5]: *** [../scripts/Makefile.build:289: drivers/remoteproc/qcom_q6v5_pas.o] Error 1
> 
> 
> At "remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs":
> 
> ../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_load':
> ../drivers/remoteproc/qcom_q6v5_pas.c:244:44: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
>   244 |                 ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
>       |                                         ~~~^~~~~~~~~~~~~
>       |                                            |
>       |                                            struct qcom_pas_context *
> In file included from ../drivers/remoteproc/qcom_q6v5_pas.c:27:
> ../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
>    23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
>       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_start':
> ../drivers/remoteproc/qcom_q6v5_pas.c:322:36: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
>   322 |         ret = qcom_mdt_pas_load(pas->pas_ctx, pas->firmware, rproc->firmware,
>       |                                 ~~~^~~~~~~~~
>       |                                    |
>       |                                    struct qcom_pas_context *
> ../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
>    23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
>       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> make[5]: *** [../scripts/Makefile.build:289: drivers/remoteproc/qcom_q6v5_pas.o] Error 1
> 
> 
> This is because the 5/16 patch depends upon changes in the 7/16 patch.

It is rather because of direct dependency of 5/16 on 7/16, I will merge
them both.

-Sumit

