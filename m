Return-Path: <linux-wireless+bounces-37124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP16DfeOGWpTxggAu9opvQ
	(envelope-from <linux-wireless+bounces-37124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 15:04:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83742602A1F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 15:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAACD304A8EF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2E239E76;
	Fri, 29 May 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3HhoUKR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139801E7C12;
	Fri, 29 May 2026 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059768; cv=none; b=amX1z/I181LsImE9srklGKSnhzq24W3aCG2g1y99Gi8o7o6HGqKNaeU5zGC29weuEeQqF/fyl+UTl3NoXMnXL2qP2JLBpmtVNzJ/FkPBuE1v6P29FYIquUWOG9a0JwYZ1xHC1ZmM7/s7CLd+VVXLN9ISoYLMq4tTAMdWEepOMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059768; c=relaxed/simple;
	bh=ApQz1V5CNU9O9EyceeC74ecs8b38MRpfa33XpuXW5mI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ps9VXsqyKftbQpcKIUKS3fsi4nMkfbn1bLr8GC69D30TWPyZIp6evV9blVCGfbVgBLzIqrYGgSwZ7QzieJSvFF9HzWdSVuL+p5MyC+ziNtC6D6rbnCYtwIK5IbulP26/rEfHPxUq/qZmIdwLG0xipnFrkgjbIIDtDu0fFwXCC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3HhoUKR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757FE1F00893;
	Fri, 29 May 2026 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780059767;
	bh=66jwmabnss1wzjbJ/pG7HLmk7a00oOo/dxDfODb4vpU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=E3HhoUKR/eThbMY+4+yrcHlS/pZyyLblbZn4d5+FNHlnJnEnizR352OFGeJTuCB/1
	 fPEhuVfPJmr4NEfbWTKB0lHtHEPAjdcvACXXpCx8RwZZRfBH9Xpv2JHt6LoD9t2vyQ
	 Io2fAnOB/CXyhFowtOqWtinEWkqw5c0UX/yWQw18xPOEGp/Gd0FCB9W66tKyyJWy/1
	 sK0LuTYiEzwtdlVVDZH5dlH/pOkreTi1ZRDeUqQsJRzzEO8ivUCJK5DZjcWDYOJaym
	 KFKrbDa46wfJC+p6Ioenp6HPCLM48/ac5dlXEfTJJyrJN1gstWyZUyrvcTU02aRhNh
	 he+jdftUvhVKg==
From: Srinivas Kandagatla <srini@kernel.org>
To: konradybcio@kernel.org, andersson@kernel.org, 
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kees Cook <kees@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/4] Use the QMI service IDs from the QMI
 header
Message-Id: <178005976216.10291.3509337895172854457.b4-ty@kernel.org>
Date: Fri, 29 May 2026 14:02:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37124-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 83742602A1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 16 Mar 2026 18:14:10 +0100, Daniel Lezcano wrote:
> The different subsystems implementing the QMI service protocol are
> using their own definition of the service id. It is not a problem but
> it results on having those duplicated with different names but the
> same value and without consistency in their name.
> 
> The QMI service IDs are defined in the qmi.h header file. Use those
> instead of defining the IDs in the protocol implementation file. It
> will result in unifying and providing a consistent way to represent
> the supported protocols.
> 
> [...]

Applied, thanks!

[3/4] slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of defining it locally
      commit: 05f3f5984121e1956867b309c76a750c1d4c9682

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


