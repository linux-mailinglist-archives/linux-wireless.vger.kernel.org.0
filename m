Return-Path: <linux-wireless+bounces-37550-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mHHaFs+CJ2qpyQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37550-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 05:04:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5765BF61
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 05:04:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ouZp1fRc;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37550-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37550-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AF33301F7A8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 03:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988083469E0;
	Tue,  9 Jun 2026 03:04:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D684071DF;
	Tue,  9 Jun 2026 03:04:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974283; cv=none; b=tU8YS2EzCyUm16P64p13yZ6KkftlFxVJl8NMnxJKZgxfalndROQNwAWwfD5dB0Rt7irNE7eVBDv4FnPo7wnLMQndSYHwBKljLbskbeg4UD+cZULEC2DBXv578zzrrgJU1/9WRWMwEpn/M2mhuAIAsF5fbUPbXYQ3u6J0SFJZn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974283; c=relaxed/simple;
	bh=yVoGTjwqbsGhqDmyNl4VIBapHM7wIP1YE9nW5TAH7FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyxpZisJZ1fUHwrqYEV38JoNAVfFASrkKsQyuqZs7ctkBpBNxFULyjRC2lGvi8U4rPjtreVOQCveov4kNx0xAg4QrYVt5Xla23d+FcX1z7ag7js1B8iwtNyFtPIzgV3IeLck5p0winCXhSD+8LK8h0xL1yoYjM2gecmgRp5AyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouZp1fRc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6241F00893;
	Tue,  9 Jun 2026 03:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780974282;
	bh=5myXXeDCn5YVmIBgFVer+wIhNkBS248w938HxQWUeXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouZp1fRcPQ/DaYVMHo8ivh9mNFLKsdlvnJsWyTFWnr8N+QkAHMa/OJwopdRkKpjLL
	 IWeJM8USUMEIPOz2EfqlSyLljjU4KloeKw5MMw7rMerBFs1OFq+j9fpddGM/Ijct8G
	 cRmusTWLaaLz5aJOD7pq08kUQgU1qe9+8q08dz0GcmZIVO8rbuZ1FQjvZ8hIovKErV
	 aUrjzISO0FYMvZMlvPhMNohJ+vCeglUrqUMOtUMdDzSInMzCPWFHdFOpfoXm/rAQGX
	 tqz4AXZUgU6KseCMGRQskG12td3D1EeKxIX7pD8unvJQdbsxER6tc45K44ejOdGLUu
	 UvvgTlpjVH/nQ==
Date: Mon, 8 Jun 2026 22:04:38 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Kerigan Creighton <kerigancreighton@gmail.com>, linux-wireless@vger.kernel.org, loic.poulain@oss.qualcomm.com, 
	wcn36xx@lists.infradead.org, mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] remoteproc: qcom_wcnss_iris: Add support for
 WCN3610
Message-ID: <aieCcYXkmDqfb0Bj@baldur>
References: <20260306004344.10968-1-kerigancreighton@gmail.com>
 <20260306004344.10968-3-kerigancreighton@gmail.com>
 <4f94c20c-d06f-48e5-95fb-5380c84a1b99@kernel.org>
 <ecad737b-ea4c-4f32-b519-f338cfd6d48e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecad737b-ea4c-4f32-b519-f338cfd6d48e@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37550-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:krzk@kernel.org,m:kerigancreighton@gmail.com,m:linux-wireless@vger.kernel.org,m:loic.poulain@oss.qualcomm.com,m:wcn36xx@lists.infradead.org,m:mathieu.poirier@linaro.org,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,oss.qualcomm.com,lists.infradead.org,linaro.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baldur:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3A5765BF61

On Fri, Jun 05, 2026 at 05:33:22PM -0700, Jeff Johnson wrote:
> On 3/5/2026 11:25 PM, Krzysztof Kozlowski wrote:
> > On 06/03/2026 01:43, Kerigan Creighton wrote:
> >> WCN3610 has the same regulator requirements as
> >> WCN3620, so in qcom_wcnss_iris, we can use wcn3620_data.
> >>
> >> A separate compatible is needed for WCN3610 because the
> >> wcn36xx driver uses it for chip-specific configuration.
> >> Specifically, it sets BTC (Bluetooth Coexistence) CFGs,
> >> disables ENABLE_DYNAMIC_RA_START_RATE, and disables
> >> STA_POWERSAVE for this specific chip for stable
> >> functionality.
> > 
> > This goes to the binding description where you describe the hardware,
> > how I asked.
> > 
> > Please wrap commit message according to Linux coding style / submission
> > process (neither too early nor over the limit):
> > https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> This series is sitting in my patchwork queue.
> Based upon Krzysztof's comments there should be a v4 that moves some
> descriptive text from 2/3 to 1/3.
> 
> Bjorn: Once v4 lands, do you want to take this series or should I?
> (Need to know if I should wait for ACK of 2/3 or give ACK for 3/3).
> 

I don't see any build-time dependencies between patch {1,2} and {3}. So
I'd suggest that I pick the two remoteproc patches and you pick the WiFi
patch.

Regards,
Bjorn

> /jeff

