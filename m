Return-Path: <linux-wireless+bounces-34171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAVjEFkiymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:12:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC573564A7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D954E304ADB9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53039E182;
	Mon, 30 Mar 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWwAMHbX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3288292B44;
	Mon, 30 Mar 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854537; cv=none; b=vDNL3+qDNt0vxKPQ6WkLksI2WAMe3GBikAsSzG6VtPek7nK5qAR9D8eU5CgO9r5ZVFUbtWB/p+iECZv/IjwOjC5CRM1/evRQzhwfXwBxr8Vy0BSafvBp+gRkWz7aXzd5H8cLOb3wfh9tvv3gjzNgGEJk5JoF64XE/CqvJC+5kFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854537; c=relaxed/simple;
	bh=/jDwCS37ClQxnMNZi4IpdtAvb0wwJQBYhYWpxA7NdaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuNNaZ9Q1/LbtJsMGydPVKlJEIz3+kd8u9J1OkORbMntEM+Bgl4gC8ywBtGF0CD1fjLIBpcTMOAG4OfbdO+DLb7HRVxWUUHMvdDoUYE5D+Iah0ASiaARO3+ZGoZtSKX8HtZOGeAw0gb4ZgrlDm8JquG3mftcAU1+tIqDcFe/rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWwAMHbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37DEC4CEF7;
	Mon, 30 Mar 2026 07:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774854537;
	bh=/jDwCS37ClQxnMNZi4IpdtAvb0wwJQBYhYWpxA7NdaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWwAMHbXhHOam7pxS91Eazmz+hUaoDAf2swLU3Xxq0gOap3WbmlYuHlA7Lt16iHk/
	 okQRjsC54iUTWRm7vbYcOl63AQeNSP1MNEgw1swjH48UQtjagL+B86CXREPNJzOwOq
	 Cp8lf0iFOXffdYv5f1ZGoX72EDi3p7JUGh67peAHFMO9Q/7XBtMWuezArFeYv8+qt4
	 fgq1SWLpceGxYsLEgK9CZjwsuKJFx4nOY6DeWoYA4vzLl8bC5lMBjrcNcnMwUkRVKt
	 CDc0Q5JxKQzahwBZXb6knpLrYwg3kt1+XvW2qSNHe45aTGMzshmNSA4zgJNCA3qG5D
	 kMXWwGLdrpl2w==
Date: Mon, 30 Mar 2026 12:38:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, andersson@kernel.org,
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
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
Message-ID: <acohdYeKYSDQrKUZ@sumit-xelite>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
 <acE-kAi2tkPh2qie@sumit-xelite>
 <5c5b49aa-7819-44c6-b5f7-19ec780d73fa@kernel.org>
 <2e55bdc3-54a1-4f18-b9ad-fe03f21fc4da@oss.qualcomm.com>
 <a0a7269d-7a09-4a78-a4b0-b39b67bc253b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a7269d-7a09-4a78-a4b0-b39b67bc253b@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34171-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DC573564A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 02:56:40PM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2026 15:26, Konrad Dybcio wrote:
> >>>
> >>> This pattern has been carried from the PAS API contract among kernel
> >>> clients and the SCM PAS service earlier. The clients don't hold a
> >>> reference to the PAS data like underlying platform or TEE device etc.
> >>> Hence the need to have a global data pointer to hold reference to the
> >>> ops data structure registered by drivers having different lifetime of
> >>> devices. Also, the PAS APIs can be called from very different client
> >>> driver contexts.
> >>>
> >>> Surely, avoiding global data is always better given a better alternative
> >>> is there. Do you have any better alternative proposal here?
> >>
> >> Why it cannot be part of the context?
> >>
> >> Look at your API, e.g.:
> >> qcom_pas_init_image(). It takes struct qcom_pas_context which should
> >> contain the ops.

Have a look at all other PAS client APIs, the context isn't something
that each client takes a reference and pass it on for every PAS
invocation. And changing the PAS API contract for kernel clients is out
of scope of this patch-set.

> > 
> > This would make the client have to select the ops. The whole point is to
> > avoid that, since the client has no clue (and is supposed not to have any).
> 
> Yeah, I see. The problem is that this patchset just keeps growing the
> singletons so except existing 'struct qcom_scm *__scm' in qcom_scm.c,
> this one brings at least three new: 'ops_ptr', 'qcom_pas_ops_scm' and
> 'qcom_pas_ops_tee'.

Not sure how you equate ops structure __pointer__ to the ops structure
itself. Can you enlighten me how in the rest of the kernel ops data
structures are shared among independent modules registering on different
bus types?

> 
> I don't think you need all four in total, but only one which will hold
> whatever pointers are necessary.

Your arguments seems to be in favour of the existing monolithic SCM
driver design but you need to understand that's not how underlying TZ
services are implemented. The PAS service in TZ has nothing to do with
the ICE service for inline crypto as an example.

Please go through the motivation of this patch-set and the corresponding
OP-TEE implementation as TZ which is all open source.

-Sumit

