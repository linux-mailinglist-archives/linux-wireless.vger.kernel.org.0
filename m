Return-Path: <linux-wireless+bounces-33263-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LvUHcBkt2kMQwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33263-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:02:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77590293BD3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E38730028DB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D8309EFA;
	Mon, 16 Mar 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaY9HkVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496C2DE702;
	Mon, 16 Mar 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626546; cv=none; b=bda71OqaRw/56iijCXvOSdf8TBl4gpGB7SiAOHBZUBXphXMpQyrmBxcVbOSVx9DA4nNnjmXSMKsfjMKfHGRvFp1mOvYFvAfnPQwpcDARbZLa1d++DY922tbtGCDPU9IeXZvR8yFrEqtVJjanOqYpI2Oo+QvcH0SPoF/ujlBKAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626546; c=relaxed/simple;
	bh=kkXUNwiD69Xpf87E5BcMyOtlNTMPeQ7/lEHjHLgRL+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/JhU8K7rphWRiYlmYtHhijyCL0H46MHWJoAJJBJAWlZvb0T02gnWshqtbfiiKcxOPkK0OKzpdI1zN5f8VZ5E1XdzOpCbQfyYEVOkCCZcJov6GbIxLIJHSYqYmN56fmKrTWLSulDLGezxM9liThq8omAlerZmI9ahe1ry7RoOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaY9HkVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C2DC2BC9E;
	Mon, 16 Mar 2026 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773626545;
	bh=kkXUNwiD69Xpf87E5BcMyOtlNTMPeQ7/lEHjHLgRL+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaY9HkVEV6krRsQgLxwkiO7yZMgrlVrPpLXeYQAR7IAx5MDR7TUwQaFz5V5qBSv+A
	 3YoimJldxSYQPdNcTuf1q8DiCAdq3vsH/5xg42nBbHksinhtYNfrYPZega6m4y/sYo
	 dSVfROBNQjnwOQiwv2Iv9yfHYtnCcqA+93lxvlHWuuM58XLuXbmq+J2EL7r6iTqBTr
	 Zn8z8tWJ2xCvEIfT8gIb/4uorPM0rZ/envKWWfSJ/4LQJZFfI5sEgx7a5FPCeNQBPE
	 96u6lp0SEhMsftM3FyXouu+2DSxMYqsHHr06OStUhqnzmBbQFyHf9bdRGjM036xEQk
	 f7OGCBrm7fLPg==
Date: Sun, 15 Mar 2026 21:02:19 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, konradybcio@kernel.org, 
	linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Group QMI service IDs into the QMI header
Message-ID: <abdkE2qWX5Amf5Jo@baldur>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <9cc7638f-1232-4cb7-b4d7-cdac66a2f4ba@oss.qualcomm.com>
 <3283cbae-4100-484c-9b00-1d7111c62456@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3283cbae-4100-484c-9b00-1d7111c62456@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33263-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 77590293BD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 01:09:08AM +0100, Daniel Lezcano wrote:
> On 3/10/26 00:50, Jeff Johnson wrote:
> > On 3/9/2026 4:03 PM, Daniel Lezcano wrote:
> > > The different subsystems implementing the QMI service protocol are
> > > using their own definition of the service id. It is not a problem but
> > > it results on having those duplicated with different names but the
> > > same value and without consistency in their name.
> > > 
> > > It makes more sense to unify their names and move the definitions in
> 
> [ ... ]
> 
> > prefix for wireless drivers is simply wifi: <driver>:
> > so s/net: drivers: wireless:/wifi:/
> 
> Noted, thanks
> 
> > >    remoteproc: qcom: Use the unified QMI service ID instead of defining
> > >      it locally
> > >    slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of
> > >      defining it locally
> > >    soc: qcom: pdr: Use the unified QMI service ID instead of defining it
> > >      locally
> > >    ALSA: usb-audio: qcom: Use the unified QMI service ID instead of
> > >      defining it locally
> > >    samples: qmi: Use the unified QMI service ID instead of defining it
> > >      locally
> > > 
> > >   drivers/net/ipa/ipa_qmi.c                      |  6 ++----
> > >   drivers/net/wireless/ath/ath10k/qmi.c          |  2 +-
> > >   drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h |  1 -
> > >   drivers/net/wireless/ath/ath11k/qmi.c          |  2 +-
> > >   drivers/net/wireless/ath/ath11k/qmi.h          |  1 -
> > >   drivers/net/wireless/ath/ath12k/qmi.c          |  2 +-
> > >   drivers/net/wireless/ath/ath12k/qmi.h          |  1 -
> > >   drivers/remoteproc/qcom_sysmon.c               |  2 +-
> > >   drivers/slimbus/qcom-ngd-ctrl.c                |  5 ++---
> > >   drivers/soc/qcom/pdr_interface.c               |  4 ++--
> > >   drivers/soc/qcom/pdr_internal.h                |  3 ---
> > >   drivers/soc/qcom/qcom_pd_mapper.c              |  2 +-
> > >   include/linux/soc/qcom/qmi.h                   | 12 ++++++++++++
> > >   samples/qmi/qmi_sample_client.c                |  2 +-
> > >   sound/usb/qcom/qc_audio_offload.c              |  2 +-
> > >   sound/usb/qcom/usb_audio_qmi_v01.h             |  1 -
> > 
> > You are touching a lot of subsystems with a single series.
> > How do you plan on having these land?
> > Do you have a maintainer who will take all of these through their tree?
> 
> Yes I thought Bjorn or Konrad would take them with the acked-by from the
> different subsystems

As we haven't received any such acks, I pulled patch 1 into an immutable
branch and pushed it here:

  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com

Other maintainers can use this to pull respective changes, or you can
repost the individual patches with this (or follow up once it's in
-rc1).

Regards,
Bjorn

