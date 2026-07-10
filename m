Return-Path: <linux-wireless+bounces-38849-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G64jJGniUGr57QIAu9opvQ
	(envelope-from <linux-wireless+bounces-38849-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 14:15:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429273AA43
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 14:15:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YsHYXBoU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38849-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38849-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B41F30478C7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6B413249;
	Fri, 10 Jul 2026 12:12:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AA199931;
	Fri, 10 Jul 2026 12:12:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685539; cv=none; b=Db7kNDbc96aRn2HfKJIx3J4C4D9sBCdal0OPq/V8b1/RI2s8w2riNLkCy8rOig/TJuyIGwwdLB/GtpwCM3DlYnoAAvxflM7SXlGJfKyiBWzHp6JQuIfN1iFbAbFSbiVpw6e+G3VoWribTiBnZeMYSbHDX0umYapIPrN3PXSwf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685539; c=relaxed/simple;
	bh=nVuv/Hu964f3n0QjnsdrXirjEZ9hx5LnS/ajlZNJqtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laflhZwtvVqRLPXlGolV0FtQs+1ldgU2u7qgrD1S4cqnYEXr6jhNCTPt4vRVJAiBdJexnfva4jntJ6ZA+2qMiiUQGCYvTG6NVr6WzWttLnZrqdT1zrlSwGbBvy41q/qGKJin0kZXui6iW7zEURKsuhuiB98hefxLyOMNvpsIaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsHYXBoU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2EC1F000E9;
	Fri, 10 Jul 2026 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783685538;
	bh=2mX5s+LgF61GsTT2jOOQtbwBRT5YocgNpg7DpK7Idac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YsHYXBoUwEO/JD7uEwImzg3mv7r4evHYn6bmm/BpwFz7s+/PEwFuAjQwpC9NLZTD1
	 uJiaFsewk7OWDBXeUTrZRYi3CisEgF1I2aAOEqad225cY6f/P7our9/zVZA9xwWjUf
	 gWh99RMEJrfxKFrTpFsWA2bi+SyaLc9Cd6P8qCO0megJ5ZRuh7ZlTI3YW53k+vUyvV
	 8QEaTaE63VVnw+8W2DmuU+gHjLUFXUvjCp4nuKuqEckoC1l5cvi2RdnxTeafSuYftb
	 uui7ecoebrEKYvZpeR5W9/axJDkt1zUqKM0o3phcWbkxcx2zEVQaPpW16AabvYVH6k
	 mcLVwF5Hg+7vA==
Date: Fri, 10 Jul 2026 17:42:00 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com, sean@poorly.run,
	akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com, marijn.suijten@somainline.org,
	airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
	bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
	mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
	op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service
 support
Message-ID: <alDhkHVnzReCgU6H@sumit-xelite>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <178362521364.2422497.1305957434056184382.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178362521364.2422497.1305957434056184382.b4-ty@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[48];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss
 .qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38849-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sumit-xelite:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3429273AA43

Hi Bjorn,

On Thu, Jul 09, 2026 at 02:32:39PM -0500, Bjorn Andersson wrote:
> 
> On Thu, 02 Jul 2026 17:28:16 +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Qcom platforms has the legacy of using non-standard SCM calls
> > splintered over the various kernel drivers. These SCM calls aren't
> > compliant with the standard SMC calling conventions which is a
> > prerequisite to enable migration to the FF-A specifications from Arm.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/14] firmware: qcom: Add a generic PAS service
>         commit: 08314e7c2c38b9ae6a5e01c58ed10a950859404d
> [02/14] firmware: qcom_scm: Migrate to generic PAS service
>         commit: 5c1a2975d23c51c01aca51945d0f10a4ee4c9020
> [03/14] firmware: qcom: Add a PAS TEE service
>         commit: b6f7978da0c4d26fe465aa6634f5a0b48f900de0
> [14/14] MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
>         commit: 6701259025d49139131a0eb2257659a066dcca22
> 
> This is available as an immutable branch, for other subsystems to pull at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org
> 
> 
> [04/14] remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
>         commit: 254030af0d81b12b7624d9ce85c6bdd3171629c6
> [05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
>         commit: f3b1357673ddb37ae8b9a8fe44df73cbd2a519c5
> [06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
>         commit: ea3b5245f5deba916320b32a8e6510a74c034c17
> [07/14] remoteproc: qcom: Select QCOM_PAS generic service
>         commit: c4383254ac7a529736577e304176a10371c2ee0b
> 

Thanks for picking the partial set although I expected for you to pick
the entire set given acks from all the other subsystem maintainers. Let
me know how we should proceed further.

-Sumit

