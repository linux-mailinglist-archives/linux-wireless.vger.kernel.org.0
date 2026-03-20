Return-Path: <linux-wireless+bounces-33553-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBdrKKfrvGkL4gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33553-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 07:39:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 003842D64B5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 07:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D8C730791D5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1A23B62B;
	Fri, 20 Mar 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="CyLgSowD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954332F4A0C
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773988748; cv=none; b=e/Qz0p9TflL6R1TFnkACX6eV/oe13g7VM2C9/rkavXNQ8MBOIiJQGDZcDPgV02O5VMQQeC/zD+zX3URhsZUXyeR/rY5e0GgP89fdSKPAVaDEoRiX/IpRfV1qEDLeKSLuO14LOqHmYwEn+j15CKPicm9O/5AARRK8BQE3c6DgGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773988748; c=relaxed/simple;
	bh=91EGhSoW8O4o2gMGRdZpxZ9ViJIx1AyhdwJZK6aOPek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3NzNjBLqZJRm+4Fi7Ss4CJfrlPwVRDdVBpU4W4WTdcqClzTaTsU4WmBzN9VxK4ziCTzKBVkKrZdyqmvGZwng7Gb+F5TDNO1o9//oPzbCbOnICk3MN3aBQm5fh/9B6mWeJRzpSAxT0bEOHCc8aj5ECkRS7DBX2sk7N6bgINiSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=CyLgSowD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab46931cf1so23019295ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 23:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773988747; x=1774593547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzTcKgJkEZXpc4v4kP7gzA3RdIyUm1soevJ3My5QsO0=;
        b=CyLgSowDoiV6IPjWeFTaTNhfCLxjL+SHk7f7Tmxpcd3Qi76o6nLDoyypH039gieUAf
         WoSM8hqsI8cN3KiBQJ9ZAMbhxY9HRpHOiJeuNK5y6nmkU0zWU+D4jKoLkCViBGBpfy6y
         fSLN2Hq3piUmRa4PKW+DVK1HZpNflTjH9qq/+WIC8RcQYA54mbIflJb/EkSyfdiDdUp+
         m+viM/1DsI2t4hCToAJTDbFsYzSn58En//JKXPPPDpd3yuNlbZVk8J0VZFPFQJARA1f9
         xY5A6Uud2rEPZLUXnQ+8WfMdvwCZvABRiaKSJ4XsWM0ACZqe4ioFTYbIANSrdUbDI3Uy
         q5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773988747; x=1774593547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzTcKgJkEZXpc4v4kP7gzA3RdIyUm1soevJ3My5QsO0=;
        b=e+VtqBybqbpLyYybg086vHBmlJuWcONzwDSXTxBeQXPJjfXwiEilz41zJtNIxjbvjf
         NAd/xVfgWH1j5VFIOI3SJQuY2KIt9ktjMTyw39o3zlwdmvwkywNe8bzwxH2i+H4OAf+M
         3Vr0SCMfj+UqM4GXa8ecRBonGft0W4NCV8bvgaTvyEdCBF4/LmpO/n6Vsru1v3QQ1jBG
         ypfysseqprMhAx3/L6iUJVJhCMXMCZJMqOm5FTGl0uKRv9k3ggoDcmlZKt+2/lT5fy0m
         phP8djFd4LeSXxG04IvpITNfjX2Q9Yn4d2HHMZWS1bjansNB14Hyq4U8xF079sO1B7ll
         aAFw==
X-Forwarded-Encrypted: i=1; AJvYcCUNEntHASR8Ou4VOIy+gF0/E4GDSSmbBP6TFpRLeEZ7VEYBZFRZ6H7UPHU5rFZQkv9f4V6qrx3/1sWB1+O2xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGekn1FiFxbgU+zp+Y7RPzcisRwOHSL44bJzeICLS8UKbXnqW8
	Sr5BW19/yssOc2RM8Bx5B9wGm9EofWmlpyly5tWinwUUr1kGwSPajzbUTCMOj0vRPPA=
X-Gm-Gg: ATEYQzw/3xlcMVdIA9r5jHET8WylEbVUkfpG/rO7zl6jxGefzgoljOLfZZZqt5x6F3o
	sRf16MCuLK5nuuLkLwuR+VY+P/YbvP3vEXzXtJggyPlxUvP+C7ewz/o79fv1VfRIhWqPFJJlt/K
	4MCuW9OT6d3DsxBP4LRQ2NyWhjmzeBDbGmj0fk8HiMzBz15TwPYzDH099N0pUXdMOZJlTLRKSTi
	iyvojFg2vSzVFkujGL742cokivx9Td/7aEo7mwxcVonmaGOAbt2Ga2FjdqlhDiaZ70hjirDg4F1
	x5uS/vpS2raT0kxd5lDp3KtP4eXVwR7f6fPH2vzzpGJWXlHMrBo6GlIOJEGWiSbZmqLnTuT7OAF
	IGTs/uJU+pdbHZN/mWdQxgd18OUlNdgs5XA8enwZfoOPDtZCCMmnaPp18FDfKgW9eoV7TWWqadG
	Xdo1JVtnHb2XmQC933B9gJGODrWV05wM3vgnHat0XC8yaDY0OKPpPuKbDLdrkCRe5E
X-Received: by 2002:a17:902:d2c9:b0:2b0:52dc:f1c1 with SMTP id d9443c01a7336-2b0827bd48fmr16571475ad.16.1773988746880;
        Thu, 19 Mar 2026 23:39:06 -0700 (PDT)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08351686csm11925245ad.8.2026.03.19.23.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 23:39:06 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:39:03 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, 
	Arien Judge <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
Message-ID: <x2c5mvplhtdfl7u2m54roosjtxjhzab2kq6tpqmehbmauiwvi2@gsktg3ztlhng>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
 <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
 <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
 <zcuk2lw4crrx77pel7rjzy6g4dae77psra3sfiytto4ap3b2nt@io3xv6gob7dz>
 <888ab7ed9c72d19765e87f00b17dd95963cbca18.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888ab7ed9c72d19765e87f00b17dd95963cbca18.camel@sipsolutions.net>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33553-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 003842D64B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > We expect to see some larger features - including monitor mode, and
> > mesh in the near to mid-term future within the driver itself, but the
> > core development will still remain in mac80211 & cfg80211 as we
> > extend the S1G implementation.
> 
> Sounds like there would be quite some co-development with cfg/mac and
> the driver

Thinking about this a bit further, the initial items on the todo
list are more or less as follows:

1. hostapd support (mostly unrelated, some minor tweaks to hwsim)
2. Rx reporting - mainly mac and cfg with some minor driver changes
   + usermode aswell
3. iw and iwinfo support (again, unrelated)
4. extend regulatory support - this will be a big challenge and once
   again mostly cfg and mac

So most driver work would just be plumbing through any required
changes for the above, no large features in the near future.

> which is probably simpler if I apply driver patches too,
> otherwise you have to synchronise pull requests to when I apply patches
> to my tree? OTOH, to pass the bot checks you already have to do that
> anyway, unless sending cfg/mac/driver patches in one series, which also
> isn't great since it ends to bury the cfg/mac patches.

Initially that works with us if you apply the patches :). Obviously,
once supports get a bit more mature and the work is deocupled the goal
would be to send you pull requests. Let's go with patches to you now,
and if that works out to not be ideal we can move to pull requests

> > As for workflows, we are still figuring that out for ourselves.
> 
> I'd prefer if you could create an account on patchwork.kernel.org, and
> then I can automatically delegate patches to this driver to you. Whether
> or not you then re-assign them to me in patchwork or collect them and
> send a pull request is somewhat secondary, but the latter obviously
> makes things a bit simpler for me. If you _are_ going to do that longer
> term than just the initial driver, probably should document a T: entry
> in the maintainers file too.

I have made an account with the user "lhodges" on patchwork - no
issues with that. We haven't got a public tree tracking wireless-next
yet. Nothing necessarily blocking that except internal processes, I
assume there's no issue adding it later?

lachlan

