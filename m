Return-Path: <linux-wireless+bounces-38270-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hd6QMn8sQmpP1QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38270-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:27:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 425936D77E0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:27:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="K/9M7tDp";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38270-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38270-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41C4B305849E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552373EFD00;
	Mon, 29 Jun 2026 08:21:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6F3DB302
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 08:21:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721299; cv=none; b=Fld97+GH3GeVkh0+ObgC7C6XIGVFd7YCNNdPouhojlC3uQaIgAeXye9RF0yC2BqvuWLZmtiqS5quUG1FR9zkn6F4zigilNLUfcIxwjKx/jQUEzN2s45LoQXOjhwnGtfN9LOB1T2JSSJX3ft9RsSRMn0pA8Ok+WPR8IbSNJ8sbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721299; c=relaxed/simple;
	bh=WKkOSJvb7SAMfwZVZs5gDXezKc15Os3WR3ydDq66nPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mia9y3EdSfZftmY3bLTWBSc9zSG/aB0QFUQLG7xOwO9z2ZAVWX6Kq2WTPU7q33IFQGpiA4yG6hy6Fy0gQGOeDJlu/HJ89ul1vJXN0+ZMJN55w5I/DpPkV9TDiXfldGooCnlPz0rze+egbIQFaMfTviWHdsoOg+Fh4i8gc6gABRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/9M7tDp; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-474560436c3so279482f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782721295; x=1783326095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O70IzUOVgHEP48/yIwhPaJQer5C5JXDJ5C0xc+7HOc4=;
        b=K/9M7tDp87oDMJOn3QZbjg0BMovBvVY2TovKwRn86X4sk7+nk0f62jigqaPG4JITIN
         SR5LKsZnuo6uJyBKd89tUUdlBNqAApBuchTYGoyhoPrPD1iIPRU9flDDY5qx5l9uGqqO
         r8Eqc2AV06tXhCSO+o7HSG9fLoY+wONkh+D75CxcHtd7aS37W6SPy//44M3I5zyQzYnv
         G/NjJ5WDzeatwJLBOpfxumogOqR8GBmRVP9PnZbUXecWzgfPe/J2480qjOmTn2TUJ4eX
         gMnTv0BPP9gomgOytewfeq85tKWouuZ8DXXBjUbrGUSF9e00TN25onLnm6Kj5sZocx/p
         XIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782721295; x=1783326095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O70IzUOVgHEP48/yIwhPaJQer5C5JXDJ5C0xc+7HOc4=;
        b=rfMxTvu3GqNHatFFx/RPStJLndy37yFeUeSwZsx5H8FjB6W5pHp6v7VZxVvpwxBUlS
         byhWyH3p1HUMMU4Jr7KoT8oiWMTgXKT4Sh0p6eFOcJaKx9IE2Db1I/sw79gHV/eo5LGO
         bz4ViK59GOXx2eDIUZkCcTx8VZ6OmbII91sktn7gog//95ep89a4Ia9wmaQZ8V77Dk7J
         bwn+L2YoQi38hjD6A59ZP+7ZDzGGk3cnUJ1oL6+Fv+cXKD9f5WKW3xHE2ky9RdifZqy8
         +8SjLbYZ4Mh9zhQAVkdr7cYCnpHHTzlEit4mqCSYvivuZ2uYNp580VC9OB6LP9zDvJJA
         DMrA==
X-Forwarded-Encrypted: i=1; AHgh+RooUYkCrWalFMf98I4o2+r2uMFbWCsM0eHgoTaaTRiOk8ixQZEp3SEFWAUPUnMm0TQYhg3l/ffPUYqlB4Bzvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOr+SyLtRuoE3TjtDvCElh3TwJJoggI6aCEdUyaXZsulH8YS5
	Yb/FW810Gx8rImGSZ8JOy9f2p7dLYeebridOmVS5h2cejeDnG0gIqZmD
X-Gm-Gg: AfdE7clwlWP6HNFpGH3DnI5rRnqIHGQUy1pJdJrL1kDx+dSGIbpPzL5zkDYFGKKWjrr
	32EBXdEXoKM+YWgUuzU529B3uxUEiL5X8tSRiQWF9zdjCLc0ODvZgGTv5si2ObqZStwF1bQxhR6
	DMvafUJKfHVzPRdnEt9YYTytqy3O/KLEXkApT7fjZM3C6czdOtvw0cgkmDjZXIkZPucV9xA+7gE
	uTP1Drng/pdU3GF44bKtiA5KoNc7u6ETMt66Ng09a+bxNIX1IsagwoIhtORk6wSj139a0Oh6cMA
	zBkuGUN8yyrM47JH0c9vY0mdgkXEpcE9GegKLAUOBj7Um7ojTDlKnCS6NOI6FWekuk85LESzhOi
	RY6o0KDi2cj3bVQooYcM0yLqlZvAcoZ56s+6nxjryTMbr1wAV1LvyS8NUoRseHoMAw2FNqwFPNg
	ev1ZBwPBYKn8HnhdJQMeW+5N/nem3+ecJOK5/Q/Swc88tuxZu8Z2sIU1HVhfLpNS8K6MFBIfKbt
	toWuEWwSMxrI9qf
X-Received: by 2002:a05:6000:2086:b0:471:9fd4:743 with SMTP id ffacd0b85a97d-4719fe34b54mr10424948f8f.45.1782721294866;
        Mon, 29 Jun 2026 01:21:34 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fccca2781sm23118806f8f.6.2026.06.29.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:21:34 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:21:33 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Andrew LaMarche <andrewjlamarche@gmail.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: ath12k: support calibration-variant from
 device tree
Message-ID: <rh6uz6bqetobowyrist7hhytdu32v2azvuambenyzofur3tjyj@wghfgwtmjj53>
References: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
 <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
 <dc8c9c9c-dc85-40dd-9313-845a808a35f4@oss.qualcomm.com>
 <3B9D1FBE-37D0-4902-8C0C-8AB57C1310A5@gmail.com>
 <23fr45actdrqt6rp6fozcaugyk3egs5zm7imschl7gyuuj6cme@3pvdhqv7xvkq>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23fr45actdrqt6rp6fozcaugyk3egs5zm7imschl7gyuuj6cme@3pvdhqv7xvkq>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrewjlamarche@gmail.com,m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38270-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestvanhoecke@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wghfgwtmjj53:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 425936D77E0

On Mon, Jun 15, 2026 at 03:36:50PM +0200, Ernest Van Hoecke wrote:
> On Wed, May 27, 2026 at 05:01:51PM -0400, Andrew LaMarche wrote:
> > Ack on the deprecation of qcom,ath12k-calibration-variant in favor of the
> > generic qcom,calibration-variant. 
> > 
> > However, drivers/net/wireless/ath/ath12k/core.c still misses the logic to 
> > actually load in the BDF, which this patch also accomplishes. I don’t see that
> > in the Qualcomm-authored series you linked. Perhaps a v2 to address this?
> > 
> > Andrew
> > 
> > > On May 27, 2026, at 3:52 PM, Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:
> > > 
> > > On 5/27/2026 9:12 AM, Andrew LaMarche wrote:
> > >> Hi,
> > >> 
> > >> A kind ping here. I’m not sure why this functionality is missing in the first place, but it is needed for loading caldata from the device tree.
> > > 
> > > Your patch duplicates functionality in the Qualcomm authored series:
> > > https://msgid.link/20250228184214.337119-1-quic_rajkbhag@quicinc.com
> > > 
> > > And note the upstream device bindings for ath10k and ath11k only support the
> > > generic binding qcom,calibration-variant.
> > > 
> > > There are no longer any generation-specific bindings, see:
> > > https://msgid.link/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org
> > > 
> > > /jeff
> > 
> 
> Hi Jeff,
> Hi Andrew,
> 
> We also need this functionality, and as Andrew noted, the patch series
> from Qualcomm does not actually address this.
> 
> I believe some confusion arose because the patch series mentions the
> "qcom,calibration-variant" DT property, but it does nothing to implement
> this in the driver. In that series it only exists within a schema file:
> Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
> 
> Our need for this property was previously discussed here, and for now I
> don't see a way forward without it:
> https://lore.kernel.org/all/77vowy4ax4cl6dlc45i2q3fjmwn3q676wqghq267tmbix7773b@27h5t66mflur/
> 
> Thanks a lot for your work here.
> 
> Best regards,
> Ernest
> 

Hi Andrew,

Are you planning to send a v2 of this?

If not, I'm considering sending a version of this with the
qcom,calibration-variant binding to move this forward.

Thanks for your work here!

Kind regards,
Ernest


