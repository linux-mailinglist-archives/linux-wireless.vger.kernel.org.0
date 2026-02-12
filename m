Return-Path: <linux-wireless+bounces-31758-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OA6ItOSjWl54QAAu9opvQ
	(envelope-from <linux-wireless+bounces-31758-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 09:44:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8EC12B7AB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 09:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2189F300BE1E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561681D61BC;
	Thu, 12 Feb 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="CmgeArnm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA417158535
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770885837; cv=none; b=VCCmN+AvkUaPtQHoaUjgnBpYuZD/JuQ9BcPSRBga5rIrFKHaluK+wCea4/agh1UaUABAFL1hV6V0soCCqW9MreeNhOsHhPyyCi8JrfQ1UZ0Rjb+zQ4k3tJgRvC01TBRGfuARxgonSOeNxHWVQ/hhnqb26D/qh5c2yHHQ9bOFFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770885837; c=relaxed/simple;
	bh=GHHfbkEaw3cpzD12CYxJxXshtnvvQtZSelUu/i0WLqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlmH/U5VB7OiNuz7cox+6ZqLjG6SHkGfoxEvN8pqZs0CCDDq5r0nan/Na4X/ABc0azkVEyLJs0IiwckkxaVjwldKzH9RVYXBOAKOtQVxMjgWDjU1KS5TS+Vy6FrOKVJIG8hj8TgOecrGOXUwyLWAPuRe2mEzmFDCx604LJj0X7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=CmgeArnm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaecf9c325so12350375ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 00:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1770885835; x=1771490635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWNiHEZw2DN3xmzh67cRdIkymYQbZfNrvc/HikNc8dk=;
        b=CmgeArnmOGgu0jU4BLUMs1zMXiQsk6kucVozcFKoo6AI2J+FLEJvoXCiNn8mLjyvPA
         L3c6inoODmRnWBuvsE04512DlLpTysUQgZRvc4g7qArAtV5vjOewXmbt9GdYBKo9qOOK
         OUzrWaMqOGsVpcW05uZSmEetJxzzqznZZ/rxnkhRhcm076fN7mAYuNDJ1k7lqdJUtt8E
         3ym9Kx3F2wzCfmML7v6OSLs/h/nMNTFYKm+rAlI7nNOgQJwbRD7mNe5mdNdXR3303q+t
         mlFAvxa+1uX9mEBW0iBJJNtGJVsomKEEudxNWYIdcrVJVmYtMiRcmB9ZwgMwO+q3ICjq
         7tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770885835; x=1771490635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWNiHEZw2DN3xmzh67cRdIkymYQbZfNrvc/HikNc8dk=;
        b=KJCkzK1qik0YgIUbieXxcCd1Ba1czQNSbEEGz+6/529e79jZwM3Vi8Of1VWi6whb+B
         IHIkUap4fvsfENwozz4fW99TXpI3O3oB43mqkT9p/IMk7Mk6w6c95TrJXmHKfI0ewjtX
         Ee1Ud5I+BPI9/oJQsFL5oDvMzF6MXQgu6zlvdjYadkuZdnjl9ZRiZ8X15BDmpDPnaG6O
         dZ66VQiGHThAW8EcKvFYxqWCvQojDtLdWv0IJRAyat0DUJ0VRhbw9uNSpv8US/Iym0N0
         NBAczDBPvNInfffjh70Uu+yP1P2ghFTLlOcdRtiSnh9QIddAcEtqFyrdBaihDAHp9/OW
         tleg==
X-Gm-Message-State: AOJu0YxchLwAT2BRmF9t3tTRyKQaDznb87vehl1diyrU0nr6ef6cbLk3
	ZHoB9VW/a1Vk34hFmJgmZ8mi1r86w4oI2S7VTh+hsXHXzl6KaU31jgWD1yDcL+xkixT3IK8evcg
	WZs0=
X-Gm-Gg: AZuq6aKEBrvtrYY2hxLnemMvS1w8FInOjoj8tN7UDTshRDN7Igzdix2dNjofPVq0b+J
	WVwYANTqPoopuBGu/xrk6L1MqXGn8m8m6obb4svO1GPN9KdivhL3b6QcEbNtOfBKtXbWGAw5lyH
	VxBHtUyL8hq89HlhUEST+PTjT6oUyG5FqgbupdlaSDfPc3CJFStiKagLiB+vQgihYYg3SidLnGY
	5Gru6h8KxBuZqk7cpbPPhQO6vxuAbhDnA7z74gLXj3cROiyg9CqvpPBu/1oLBaihmEtfrHBLXgS
	jnWnxcfijdbHFqfllFEQELlf1oANohM1hZygJoc707n6W+ddX2JxuxEabc3UoOZ0YX7GLqHDt45
	KNf846CHaGZFXNheM9jPVJnnzV9OH6bR5b/PiHF7GZ3XCP7yjaj3APu5+ugyBskiV5Iu8kj9eus
	Z0Hz+KmuMHcqkS+/Lj2Wd2wZhw
X-Received: by 2002:a17:903:22d1:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ab3abf9da7mr16393945ad.23.1770885835168;
        Thu, 12 Feb 2026 00:43:55 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2996503dsm44362215ad.44.2026.02.12.00.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 00:43:54 -0800 (PST)
Date: Thu, 12 Feb 2026 14:13:51 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
	simon@morsemicro.com
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for S1G
 Response Indication Configuration
Message-ID: <20260212084351.aqswgnvnuepun6em@1207>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
 <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
 <20260109040041.tnk7e6uewo24u3tr@1207>
 <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>
 <20260206061139.6fdwaazvk4swpreo@1207>
 <ec999f04a965006dea6bd8e7380996b6fca980b4.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec999f04a965006dea6bd8e7380996b6fca980b4.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31758-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ria.thomas@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9F8EC12B7AB
X-Rspamd-Action: no action

Hi Johannes,

Thanks for the feedback.

> And for the certification test, presumably the choice for testbed STA
> (for certain frames at least, I guess not intended to break the rules
> for cases where there's no/less choice) is not meant to be left to the
> implementation, but rather meant to be set, presumably to check that the
> receiver reacts correctly.

Yes, for certification testing this configuration is intended to verify
that the receiver of the PPDU correctly interprets and acts upon the
Response Indication value set by the transmitter.

> Now that I've described it this way, I think the biggest question I have
> is actually how, if at all, we need this in a non-testing scenario?

This configuration is not expected to be used in any non-testing cases.

> But we still need to decide where it should live, although in
> that case I'd be more willing to accept an interface setting despite
> the lifetime issues.)
> 

We think it makes the most sense to treat Response Indication as an
interface-level setting  as it avoids introducing peer-specific state
that is neither negotiated nor maintained by the protocol.

That said as the response indication is only a test configuration there
is expected to be some changes to the upcoming patches. I would preferably
submit the response indication configuration as a single patch and NDP
ADDBA/DELBA negotiations as a different patch. This would open up two different
new mail chains for two patches which is different from the current one.

Looking forward to hear your thoughts on this.

Ria

