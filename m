Return-Path: <linux-wireless+bounces-38878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XDY1Kv5pUmomPgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 18:06:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F4D742208
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 18:06:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lgr4/5Ac";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38878-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38878-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 506CD3016032
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A523C65E0;
	Sat, 11 Jul 2026 16:03:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CA225417;
	Sat, 11 Jul 2026 16:03:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785831; cv=none; b=d7Q2F477KxccD7cjggeScPnv17UMAdqI8pKVc7WdsNVJQG+ODI0Dixi2HOqjIu4y+JaOSeJPnxoz+re7rbSaaHAQihJPbMEWlT3kB5sCbcGZULBdFxAbaL/naBq/CywJ94kR8mKlPZkVR7ylOysgJCetJIuSocRrrhpP43+vgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785831; c=relaxed/simple;
	bh=UKL31b/qHA8fpKfVVznWMhJSrg2YG2le+SMoyYnJ+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLOi7wGUQ9DP8MLMq/LI5syywlbmJzqUHvrd2s5EGzms0JHRaT76EFWvAPkdMuv0CKl7R7hbCgfi74MSluk7g4tNkQfRE10bt0POsiSnfZ/oZdm1Nz5hQE1lEyseENV6IUXGPWw49M+/sC/dqph4reKsxNYTXPtYurXZd+3UAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgr4/5Ac; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABAD1F000E9;
	Sat, 11 Jul 2026 16:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783785830;
	bh=LCSrKy3yKc9O23s4OGvQ6iul5x3Q05f94mW04VT5aSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lgr4/5Ac9NnZQdqqiVrKCJpWWgAusTqDLrHRheuoQ78w/r/6Qc+PK2Lws6bG+R2yi
	 6V50H/wVABcT/CyLxk6TIAZDUa7Cyg23Harw7HG0v0PF0GTimw3aYNUi/H+RiVlu/y
	 yqpMktemrmhB4FB69SqXSAu5mIIpaTjpubt8bGRPFe1KX8efFtzRTUpG73Pu59pAAi
	 q1Ql+LMOMAk96AHMmYU2rbsu/ul8SQdedlQuXzkxr12zlvEV+1yQHrYfui1tjwxcuZ
	 +tze2p2HJct0YDzFidRikUePqpcmca1CQWZeLCOh0s0uWhlZyGRxXp4MGv939L8E4k
	 KoIz+btJ8J24g==
Date: Sat, 11 Jul 2026 11:03:45 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, 
	sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, 
	abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, 
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, 
	mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, 
	mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, 
	pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, 
	vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, 
	amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, 
	apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service
 support
Message-ID: <alJn2M2Wu4FH7HUM@baldur>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <178362521364.2422497.1305957434056184382.b4-ty@kernel.org>
 <alDhkHVnzReCgU6H@sumit-xelite>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alDhkHVnzReCgU6H@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[48];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@os
 s.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38878-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,baldur:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17F4D742208

On Fri, Jul 10, 2026 at 05:42:00PM +0530, Sumit Garg wrote:
> Hi Bjorn,
> 
> On Thu, Jul 09, 2026 at 02:32:39PM -0500, Bjorn Andersson wrote:
> > 
> > On Thu, 02 Jul 2026 17:28:16 +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > Qcom platforms has the legacy of using non-standard SCM calls
> > > splintered over the various kernel drivers. These SCM calls aren't
> > > compliant with the standard SMC calling conventions which is a
> > > prerequisite to enable migration to the FF-A specifications from Arm.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [01/14] firmware: qcom: Add a generic PAS service
> >         commit: 08314e7c2c38b9ae6a5e01c58ed10a950859404d
> > [02/14] firmware: qcom_scm: Migrate to generic PAS service
> >         commit: 5c1a2975d23c51c01aca51945d0f10a4ee4c9020
> > [03/14] firmware: qcom: Add a PAS TEE service
> >         commit: b6f7978da0c4d26fe465aa6634f5a0b48f900de0
> > [14/14] MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
> >         commit: 6701259025d49139131a0eb2257659a066dcca22
> > 
> > This is available as an immutable branch, for other subsystems to pull at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org
> > 
> > 
> > [04/14] remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
> >         commit: 254030af0d81b12b7624d9ce85c6bdd3171629c6
> > [05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
> >         commit: f3b1357673ddb37ae8b9a8fe44df73cbd2a519c5
> > [06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
> >         commit: ea3b5245f5deba916320b32a8e6510a74c034c17
> > [07/14] remoteproc: qcom: Select QCOM_PAS generic service
> >         commit: c4383254ac7a529736577e304176a10371c2ee0b
> > 
> 
> Thanks for picking the partial set although I expected for you to pick
> the entire set given acks from all the other subsystem maintainers. Let
> me know how we should proceed further.
> 

That would be desirable, so that I can also merge the cleanup patch at
the tail end there.

I did miss Dmitry's ack on the drm patch - that one I could have merged,
but I don't see acks from media and net maintainers. I'm fine either way
(them providing acks, or merging the immutable branch and respective
change).

As you can see Jeff did the latter already. Thanks Jeff!

This leaves us with the cleanup patch (13), which I think we can pick
for v7.3-rc2.

Regards,
Bjorn

