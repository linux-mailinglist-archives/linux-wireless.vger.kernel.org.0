Return-Path: <linux-wireless+bounces-38496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B4nGMSwzRmqVLgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:45:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B86176F56F8
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G3376acy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38496-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38496-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7ED23146231
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307B46AEFA;
	Thu,  2 Jul 2026 09:00:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D844657F8
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 09:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982831; cv=none; b=LX9V/U6tOxuXuuLAYQwj9wsLuWJH1oqyJpcID0UNOnzgLH5kDNNvxCL3jaLYQ6G4r82d6SepzjL/6XAEYqTnd2d46yCKVD4VaVl3t5cvymZW6Gng38MNb3O4gYgA7gECIMyM1sKQlD4KaGZ4DgQ18vt9tr3nMjGXvijZdjObhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982831; c=relaxed/simple;
	bh=Sbsb6lIL/NE/wDWeCdsOaBLRIRMz/GZlFGrm9hCwqo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3PYXDYUWWWzoWoAB0SK35z0f23ehJbvQbjVUVapg3xukJvQmXgyU9ui1hW8hJG8tEcrp5oYgCbY30vMNiCo9onqXmujzoYmvJDbeL9HpVT2Idzggmnhtnl1mdA+vmHNep4jey2tLsvuHlvIcF8ktflyIhoxGMudKCnCKypWS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3376acy; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4745492ed3aso972950f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782982828; x=1783587628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rf72hkVbbdWwb9P5XxaucOhOUznb7Z4SYShC8Uf5GQw=;
        b=G3376acycPTbnZfuDjSk0M8RDLdG6GtVf0oWh5IMQ1o5x+NC2DNFZ12bmVvLqEm62D
         Gw1LlA0oGYpaS6u7oMsKo2Gc7ujs4Amy5cYtqeHaZx1/e2rtu0rCgolhKi99kEpfni6b
         n5CQKozzL1tojzagABFdiis0ipxWUiY1mPhbU2KyjmPxX4mTVCNkWfjQpq2rfrACVULs
         auc/L2kTN9/11tKXz+htW+am71Y/ovj2dKp2xbIlmjz53/Byl9XTCxUxJYt73aD0kYfd
         wU0+HVZHI54zsCPaumHoNGYGOPEanaRp8kWKKFHXBD6XU8WNvYgJEKms2ZEt/de7sjK0
         uAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982828; x=1783587628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf72hkVbbdWwb9P5XxaucOhOUznb7Z4SYShC8Uf5GQw=;
        b=TColrJhX/UW6G/5ixK/twl9MWUZv/sTjWgcs+RLYJTKsF/9/zzuFwR84zq5sbUvwNT
         fIXEq/2tunJNa7Eu6KGx/kgNTCE7vuHOEyvaHe+FsAgfByQf9yr3TrMwZgiXDnxKhomH
         UoemJWPK7xu7GgH18bdtdScw3wrD0vRsEFtgifVoF/UksCvXELRlaancU9dOK6XVfxv6
         PYlErGob5OPeLJB1bZEKsh5fALY8AP/zl+1osMPmJLkKbtJFYThWEvG9hinfCFfhLXOl
         AeJcTSl7D67WSFm2Ln+Li5847gkK4uHJnaULPaIwmlikXrAMwooXl21IzfPTyQqfk3Tq
         Ocpg==
X-Forwarded-Encrypted: i=1; AHgh+RpKrqLSIipCTfqq/edp6LG9EbPBuxGnGa9M8+LBa6z7Gkfb3zLibVMh3KHfga/2S2rPcEMGBbqPQVVwyUGnEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqj9AJavRO7Qbl0GExBCjDs7YbIMIABcoXr0WAuupSmQZLniYL
	+3J0q4WmaOctPjgLli6eWOhY0ttRAoCaFfsspfoILdrjAOgr8OEDBekd
X-Gm-Gg: AfdE7clL25qZ+Kjjp1sBjQAyl40THTGLDoU7Vb47mRQC6R3q/eEh2HeJANQb8jfvnHg
	QUUxWe2uV+LTy/8Pl3Io4vgvc/K/FMG/HE6QDyETkGOuPib+JVbHvapgvSFr1CdqgWX2YICmNdc
	j+Y+PnTg6jnczSOx+uQsKE21XASF5IE1hcQHMWxd5AXGWLKoNsbeKshTIpnHBF0JfLhy1KDQrpM
	WwhR2mernezaTEWL0NHqbUZSUPkwf498rp8GMmWtS0CXgNtEaVfDGUcevSpL9GAYWNMcznhHe/p
	B9AEfFUPCzWCHLGm1/eouUU/XLh119gOAXaD7fHyW5FgFyR6sMQBUoDE9XcG9l3bN5R3Z9frrmE
	3gyo1EfaSiFSjotlDKqIGFD7L3Ho5/ye+WDJrPCViv05SRkPFMHbk5NQSAD8BoIDjAx0scAdLR8
	TCBLoGQ10drqfyvC+/QShU62wXdXuSGQb6SJwWi4xEHRAScYXGhrB2qdoujINZYVUJxbtwgo/rQ
	jBbGqjvzCrPZSRsRc4IpeqCb0w=
X-Received: by 2002:a05:6000:2087:b0:475:f100:360c with SMTP id ffacd0b85a97d-4775a6d52d5mr8157295f8f.59.1782982827830;
        Thu, 02 Jul 2026 02:00:27 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd46asm6934267f8f.36.2026.07.02.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:00:26 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:00:24 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Andrew LaMarche <andrewjlamarche@gmail.com>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, ath12k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH] dt-bindings: wireless: ath12k: allow calibration variant
 for WCN7850
Message-ID: <zglhxxu6txw2xvz4vcyu32v6722hqppcfvntan5ho32ak2y6tw@2mvfuaoxcvss>
References: <20260701-ath12k-calibration-variant-v1-1-d3eddaabf026@toradex.com>
 <20260702-beneficial-hopeful-binturong-a0bee9@quoll>
 <a0cb02e3-0566-4294-b41c-3b156ecda5e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0cb02e3-0566-4294-b41c-3b156ecda5e0@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38496-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:johannes@sipsolutions.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jjohnson@kernel.org,m:jeff.johnson@oss.qualcomm.com,m:andrewjlamarche@gmail.com,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ernest.vanhoecke@toradex.com,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,kernel.org,oss.qualcomm.com,gmail.com,vger.kernel.org,lists.infradead.org,toradex.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,2mvfuaoxcvss:mid,toradex.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B86176F56F8

On Thu, Jul 02, 2026 at 10:29:51AM +0200, Krzysztof Kozlowski wrote:
> On 02/07/2026 10:27, Krzysztof Kozlowski wrote:
> > On Wed, Jul 01, 2026 at 05:42:24PM +0200, Ernest Van Hoecke wrote:
> >> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >>
> >> qcom,calibration-variant selects board-specific calibration data for
> >> systems where the bus and device IDs are not unique.
> >>
> >> This is not specific to WSI-capable QCN9274 devices. The WSI binding
> >> already allows the property, so allow it in the WCN7850 PCI binding too.
> > 
> > Why? You need to provide reasons WHY do we want this.
> > 

We (Toradex) have SoMs with the SX-PCEBE from Silex, which uses the
WCN7850. Silex provided multiple board files for this to deal with
separate regulatory regions. Thus, we need a mechanism to select which
one to use even though the PCI ID and machines are the same.

> >>
> >> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > 
> > Where is any user of this?
> > 
> 
> Actually I missed your link in changelog section. I still however do not
> understand why these are separate. Separate means they are completely
> independent and thus my question about the user stays.
> 
> Best regards,
> Krzysztof

I agree that they could be one patchset and considered replying there,
but felt it easier to discuss this with the relevant patch already
attached. As the other binding already validates this property there is
no real dependency or ordering problem, and I thought this would ease
review.

Kind regards,
Ernest

