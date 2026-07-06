Return-Path: <linux-wireless+bounces-38707-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pHT0JVf9S2rWeAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38707-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:09:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655F714D08
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 21:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=NlfB6i22;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38707-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38707-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7635F304494F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43937C91E;
	Mon,  6 Jul 2026 19:06:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34873939C2
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 19:06:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364783; cv=none; b=oijdr2x6b17v5KV/W0yMOMkOb/UEIYLdCoSZxw90QFHm2400FetyMG5U66fFEpzB1tuUbM1zVRuL4zpBGuOHjrAPU1VFR2d2XoIfautEMxeyFFk27xAMoFF6RKO9zhd+xtsoIY2DbrUwbe0V2y7nu0AibANX0LpVVG9CAyowIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364783; c=relaxed/simple;
	bh=LrCPJ/QtDYKjWEr9SURf8YATGWYUuKmjnMwYpwXzMCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khjvRdcb5YNN4AWjSXOICWn4cSygW12RupJ6AefxYC9fOHN9q8enANt7UwhWlJN7RIgFnEF+gU+NSyqq7hjTXYGbiumlfdBGoxr7gKkH4jifo3sJMfzYCyDNbS/UEpvQl9PUz08WKbZycrXQpN+lY15msvj6FBZ/fBgO7nns61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NlfB6i22; arc=none smtp.client-ip=209.85.160.226
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-51c2a449c57so22509901cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 12:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364781; x=1783969581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUr9XqAW3S0CTUcmm68ll/Tep0fc/YKhDOl7KqLiXcE=;
        b=osXsFOOMUk9+lIITEv5IEM1DAUPEqkEmmdcy6zfKxdwwcOQv2N3JdBx4nNq7dQ6h0t
         Q8nqC3vlBxGVgm8NAsKxZkYbJfRq4Qyjr1qNEdzXm3yNe1ZDiJ2IYB3guB1wJU1eQk9a
         G/3YuufDGazElNKl3Qgne9L/SicAjt2tr7zfQxOOfgGusnGAz00/PXH4Vw9fJHu4/xat
         ujdgL6sUm3IWmXHdws6l48gIhRG1zD61iW+UKfKRuXST2pQxHWrOFqXnXjpWyn2q+iHt
         LuaHBjdnoeuVB8ulFIiSO5WbrjQwSRzG5wnCSDG4tYS7rmZRziLQBpSZ85yhEDf1s5u5
         GUKQ==
X-Gm-Message-State: AOJu0Yych5GKbTWuPIEvuhDHm4L1TXPDL+WiLNqNSHqOJuAhtlRnfUi5
	UL7giHhDSGcnq5HGOtNTUfU7WmvuC0K6SJpcD4nZaH5f61Eu+vPgsgrp4ExM9Ws1Z9dBqjg2bWp
	yARUpC1hGNTK4fxki2H9z2vS9IsM9AbeucLY/bs/L9jw7zVFBitf5HSns6APY0TobTpRabjMnAQ
	PeqMN4XKjr9y3fYxcOHDR16pIcLX/KpT0XciNvL7clYkJSMUFKyJ28mzs2GUJ7VTiLYrmnbIa75
	ysSIVz/vU6H1yGjwuV99bIYJGwu
X-Gm-Gg: AfdE7cllK9PtK8HlodlCrip82oaI7jiAXjwfrCexfggVTAjG8oLkzwq+9BdeCFlKliC
	5hEYE/mbGBYnkstheTMcnVXsUxjFuKHAedKpq8nYJokUNdzzIDYlHB7/aFEc2LCKCOq5mFOMMUV
	z8ZGf3M6izvOiYIt1T60r66RNvmz/7OYRGJO9vAQo0F25115++YUdYRCcUW39WIwTcinrdT5fs7
	2q/jZxpZmjGp1ESscqNkA0ix8zs2APFuQSRsHu3Eu6YK9mT6BX+4ZL1cfFYWdxbEasMFy7YNs7h
	zviNyRw7/8QMSoq1I6fJ9Y9/Os5yi6MKoE9YWYUY1RmCzOt8vs0rXRi91gatrOnujBg7jIV2xe9
	UgTigwsiO5GLLXZ+a/F2uFR5RiGXYG1JW7zwHlFl3Hxj1FCWYX4ZT3GZqaafDUzVOgT3a39wQvv
	R+hfVCOkPY+0+oFRakaTncUKMqVr8TSw0sW/grRuXmLNRrFAktDkur
X-Received: by 2002:a05:622a:38f:b0:51c:241f:a6ef with SMTP id d75a77b69052e-51c748e0424mr22836781cf.70.1783364780629;
        Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51c41cb3621sm4630401cf.13.2026.07.06.12.06.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4f27f49bso274036085a.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783364780; x=1783969580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUr9XqAW3S0CTUcmm68ll/Tep0fc/YKhDOl7KqLiXcE=;
        b=NlfB6i22NWKIeCJ1hDH9oUVUoP2qA8CuRnNUkI4mtMewvFei/+bX9WRf0bBioLP/hY
         pxxqgHRQ+ZehoPmRaIgGuUiXhbapIR2ul9cNysMgJvBSikaS7ajtV8E0T1kS8uqxVCRx
         NQe/fMrkyiUQqOsKxsxlfcqsRvWfYC6ab6cQU=
X-Received: by 2002:a05:620a:688a:b0:915:cf88:1e26 with SMTP id af79cd13be357-92ebb5680f7mr255496585a.48.1783364779763;
        Mon, 06 Jul 2026 12:06:19 -0700 (PDT)
X-Received: by 2002:a05:620a:688a:b0:915:cf88:1e26 with SMTP id af79cd13be357-92ebb5680f7mr255489785a.48.1783364779082;
        Mon, 06 Jul 2026 12:06:19 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800efsm964890985a.4.2026.07.06.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:06:18 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: cyw: fix heap overflow on a short auth frame
Date: Mon,  6 Jul 2026 21:06:11 +0200
Message-ID: <20260706190612.708609-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627131313.3878893-1-maoyixie.tju@gmail.com>
References: <20260627131313.3878893-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38707-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:kaixuan.li@ntu.edu.sg,m:stable@vger.kernel.org,m:arend.vanspriel@broadcom.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1655F714D08

On Sat, 27 Jun 2026 21:13:13 +0800, Maoyi Xie wrote:
> brcmf_notify_auth_frame_rx() takes the frame length from the firmware
> event and copies the frame body with the management header offset
> subtracted:

[...]

> Reject frames shorter than the management header offset before the copy.
>
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Link: https://lore.kernel.org/r/178214417708.2368577.16740907093694208834@maoyixie.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cyw/core.c   | 6 ++++++
>  1 file changed, 6 insertions(+)

Nit: the Link: tag in the commit message is normally added by the
maintainer at apply time, not by the submitter. Please drop it.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

