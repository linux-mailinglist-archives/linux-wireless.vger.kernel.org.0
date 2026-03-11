Return-Path: <linux-wireless+bounces-32955-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJN+DVQLsWldqAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32955-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:27:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB95225CD26
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3964E302FE79
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F62364E8D;
	Wed, 11 Mar 2026 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="VWYoyxCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E584B652
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210449; cv=none; b=rfdvCLmO1P2MNEjqG+H+sJYrDVgdiClqveQi8336HTjfoSnp9hQB7GExgtyo2mPq4u+Q+SgUYX4G9TROTjgPgfetv0vQeScgUQzzIxQenE7f3NRGVbOdIfiRiQ4GsS620OwgDw3tSoOOSVS36pgaxF8AoaYtCSsSeN1oqT4e51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210449; c=relaxed/simple;
	bh=l9WdCjgWTXjc8sA+wjFpO3wdVM7VRYpMh7+t4n2DT5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkzJLp+41wbluelcUEKIBSzsGcmz2leCU2xoOjkYjkoKInaYwsydWpTCPJjmdI3mTdj256UsXpLYxPkbmyaVAyJE8AySePbNCexh9BZDB2WOyNRu9FdfdgQeHytKaR0cZZzOoTBLehUWfBn8Uhb+ezxPbN0Qpc82VB9PcBJk+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=VWYoyxCl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c73c990a9cdso419599a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773210448; x=1773815248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBTo0O60Zz+jb8MIW+AwV+kSnqRzfyBSlaSgBJsQ1qo=;
        b=VWYoyxClhEGdSGfI9xmLdXmd5e0hnFNXNCp6AQcpbiB/hSNXDFqLuSdI+7dJdDz+2J
         /4Eas48x4m9C+VvHkJvKwpdvWM2HdPOS0MpDCwakHr9/RLBCnhFPDtL9HltDjxRQRYRw
         ffm3UH7Hkf9yrhQANd80kAoV7C8Ppng9v0dhFh+gxNzgrP8vqVp26vqDUWM4dj2m1YEr
         2Y30BkKDZJWN4DZzWvmnUl5d3gd0g7QPXqneUvkdyTfhh0MttWlvV1uIqheO7DXrndJW
         9x9/XfLwuZ6IsU+b/hfRpCQhI+QxZT/yP7yE2x4fnIbkMh3dqzhvo1+21eOqlJ56eeZs
         tfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773210448; x=1773815248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBTo0O60Zz+jb8MIW+AwV+kSnqRzfyBSlaSgBJsQ1qo=;
        b=Ca4xE+kvU1F53h5qiisQsjurnyPEAMsDFISRD7WOB0J0YH1hVzUo3OjluCVretmvbr
         dLItro8wJGsYFCP8u841AzK3E7c3ZY+XXj+cmTzPO9WdTx+C1szzf8kRLgCsw/AqAbCI
         s2IgSJb83NmPLmeoNlKwJ/FGaW4u6ZkJ5RKfYBzXNYrU8HbXliogAwojZzb2JVkNgVp1
         LhcGx7NkWuAgN2OJPLkpNVCdDz7blB7sbzBbwW8wQED6cEQ16EVvo81czzVOciyLGDl+
         n/qmdnTzg9NwKJqEjIKsXEiURcazP1Gre7d8SadzRptpgrY4A2msRUDBjKf/sg8YZQby
         0mPg==
X-Gm-Message-State: AOJu0YzEnWbS34quij254XLX7zX1V4O6NLw6zIWzPrHYBYt0fzKR2PMR
	bLu9xK3CzY/PJicSwa9rqB7jjPPV93+3AllYu2P5CshXbOyd2m1VTmrgfjfmxjD0LCA/lgox1jL
	GcM05
X-Gm-Gg: ATEYQzzYsZgeUD4ktVlicV1aA/Slj3Rc18VTiNkKaQBYQcELDvJCfjFQh4/SHodc/4E
	YLR1tSh88EoTRP9XCI83Ltl0Y3aHqGHxKw3SanGpb3BiuZyHylfaQTpYB01VUjSLDY9rOLF7rUf
	wh69ZffMW5JuPl67Wmy4Bcuv7YS/l4Db05CtGDTkPSFsq/ukPRlzNseJ4FSU6Kv7Bzy/F1FkO9j
	Dylbxx37zZyDI3hNYvELXRBSOxZXpx2963Nst1So+qTCX3deeFGZYCEqPI82Oyt1zqjXySi8UkA
	S000m9HH40D1lvb+enwd89f3J/t1XpDRNV1bslpSoCdHS2F0/wf4fJ2jqUpjoVP5eT7qvgmvaAa
	d8rbBUq+J3N/mH9ix5UfiTeadoQ9K8tmU0qTgQgBxyCy64Xn3kx7r0IF0Pqwshow0Wp8MPvO6z5
	YOmtuc30utm0MQRZ1lkeP7k38C/NWX0vVIpxUioM3/YsT1laW3j7Xx60pNFBZTrtmIsPxwo6T73
	uPgzgZfQv4W875n2CdoUDA=
X-Received: by 2002:a05:6a21:6f07:b0:398:795c:26c7 with SMTP id adf61e73a8af0-398c5e6ced7mr1391948637.3.1773210447848;
        Tue, 10 Mar 2026 23:27:27 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92ff3sm1074453a12.17.2026.03.10.23.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:27:27 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:27:24 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: cfg80211: init S1G properly when
 creating chandef
Message-ID: <ks6jtroa4bbjdgokubqxu7bmjpj6pvsj4zpwlix4n4i7lq7hec@2xuwcjbjazwh>
References: <20260311061800.517849-1-lachlan.hodges@morsemicro.com>
 <62057e8c13c4b6358dcb42bd639aec2996cf2bca.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62057e8c13c4b6358dcb42bd639aec2996cf2bca.camel@sipsolutions.net>
X-Rspamd-Queue-Id: CB95225CD26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32955-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 07:24:00AM +0100, Johannes Berg wrote:
> On Wed, 2026-03-11 at 17:18 +1100, Lachlan Hodges wrote:
> > When emulating channel contexts, the first chandef passed to the
> > driver when starting an interface is the local->dflt_chandef
> > via ieee80211_calc_hw_conf_chan(). This means that currently an
> > S1G driver will be given a chandef with a width of 20MHz. This will
> > lead to either the driver or firmware rejecting this configuration
> > and a non-zero ret code - leading to a WARN within
> > ieee80211_hw_conf_init().
> > 
> > In the case of emulation, ensure we initialise with a width of
> > 1MHz for S1G channels such that the default chandef is valid.
> 
> I haven't had my morning tea ;-)

That was a fast reply ^.^

> But the commit message feels to me like it's conflating cfg80211 and
> mac80211 concepts? You change cfg80211 - but then start out saying "when
> emulating" which happens in mac80211?
 
Yea good point, it's probably makes more sense to simply say what
it is which is we aren't initialising the chandef properly for an S1G
channel. Will send a v2.

lachlan

