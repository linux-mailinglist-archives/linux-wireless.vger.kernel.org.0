Return-Path: <linux-wireless+bounces-31435-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK40Or8UgGn52QIAu9opvQ
	(envelope-from <linux-wireless+bounces-31435-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 04:06:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21886C7F6A
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 04:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D7C03001073
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9876221579F;
	Mon,  2 Feb 2026 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1A7ej3a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0755A1400C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001593; cv=pass; b=INRx0kI/DMgkYUpbvwwiO0Jff5MnIgpIuzRdR8FwYztLm8tAowdpWMbfTFHFfNgWx+B+FNRfF4HYiMJyTHKEzwcon+ZI2cu38H9mCLu7YossLYvBfGIwSQhCM+KFK0v3ykzFyRiSWblYrVNjSlfmt4qtatpmPHcnSyglLS07CbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001593; c=relaxed/simple;
	bh=5TrjZbWRR4jI57TTQz+L+x0CUVcBy2s9cTfgwjd7qMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTLSFooUJswb8ReGxFJH21OB4tVCnGIZTaAPIKjes0KCCBc9RPyCtT+QW7Tjg00138AyaygyBh/vG7VcFE1F5UcqkevNRc2LtsJZMCOeK0Ofc4MWCCS112ijV94miyMjlN/Wd8aq3unffD9w04TiZTFVdcGRMY7HQnKBS6dWIVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1A7ej3a; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-658b7d13f09so7248852a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 19:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770001590; cv=none;
        d=google.com; s=arc-20240605;
        b=aRBEpqxc+yQvTLMRH42LGAnhcgdcB5DO3G+eHnD7y+5ghZTRasNOBwjj19TqCYP0MQ
         gjxkPsbeSk87hLfZoj/pWtPrR/fqCklHqyIG/EWrt/tUH7FOOqG4K++Mp2dLs9e3hodL
         p2lVf0UmdDi6qNDZHDlTJyTq9ealaL/i8tzeceJgBZKfeCDeOdroCBO6bk0KdkI4iO9c
         qU+o6EQJfXosKyNwWhMjThW4dRBOT5xL0ETcLiGr9Q0D/N0KWWnQFm33TgrLd+x8DPR+
         vkEmatVCJuM9McKJLCSWM4keoCw+d8DDSu7ecIWt4gDTdakWDeYck667mX2/RFX03Ne3
         XawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=COETjjbFF+LevxkcCjI2dliwuZzCjoZh9t1BqAtEzd4=;
        fh=Q7sqFmIfRJsGT+kVHG6GVl/vgjD99uKaXy6DSoBk2p4=;
        b=E45ZT58TgKeO47HBun/21JVPbQGUXc4VbP5ejMuvDe3OSe8ok5Ta1Q2ycQsUZCfRXq
         5K0xQ7uOpRaRSIx44X2enzu0lafAa31rzeU7LmBr5mVVhQUEzU2AhetWQ1/EBX3FnV+j
         mr8WmtY7GccIZ2z3ahfKRZBBibQdIsD1YQHbCPg06H5dJscKJUFDcBGCmRkfpDrNv9uS
         1p+pJMI6OWPibieCK/vg0+dQb2d0Wi1g2CGn7aU7agvgZU3ejiJiahzNFbOAhWR6wZNn
         y2CnWqsREqhjAaKoof5QrBAi+Bxh3SV7qxUI98/pm7fhTH8lJbt49XT5hQl0H4w917O4
         zGOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770001590; x=1770606390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COETjjbFF+LevxkcCjI2dliwuZzCjoZh9t1BqAtEzd4=;
        b=i1A7ej3aOic6HMbzP2adPpah4e5i0YlilOA1w6WX+BpstBo21OdO6V8Hfi99fQqxFl
         kFIX9rbNNrJdNhhjDll9ftyuFU5w2xpetpI54kShOlODz2/35CfxrAuDV/dHv0p0ybfE
         ifZutNgeY8h3cY1JP7qPHO2Q4gWR2Ez7wfWQBFctWvyuw5YZU0UF0mc7c9EuNadg+jFg
         23cVG6HnM6GpIBnne0oFsyOQZuY36ZmtgbEu+Mh8g79GCCSg7mR354iFX/WrLXXToPN5
         PrmBKZ2P9kLnnd3JK0t+EUZQaB9lwqO7gKBVsxv69Rav2TE9EhzLbal4YT2NrF0PJCpH
         9L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770001590; x=1770606390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COETjjbFF+LevxkcCjI2dliwuZzCjoZh9t1BqAtEzd4=;
        b=tRXPi4zWXFAqvF/NYMnJ4UeO48gx1kkmKoTXHELG5r8XaYjts7u6+2C8mou4KC31Bm
         4TqgccQgcX2yk2iRT/taJVB70KTZWoqeToGkiEzbD1d6qXftkiaF0qDcR4gBfWCTOVWM
         T1tkF4OTkv3lmBbA8Z9CkrUltUPKrmTN4HNCqPWkqlwV5Og0e6EgbFGdjnEsNzChgPWa
         s+mNu4xE9hATzlyB9Pn7/5y8GMCaaYXiBpFMX1jJWC68toHoUVTFA6IO257ovp8Y7CRm
         L4N/85bSyYOi58a3Jezjl/XZ5XjzZkFjf0nArUCjejcbOjE15oGmXgUyjP7ZTnay+NNo
         0YEg==
X-Forwarded-Encrypted: i=1; AJvYcCWdvVdKFMlZ4u1RIEdFA1z2VqXeCReCwjhNCAplkKW3wmV899i2fK1QCEkR97uA+KayEueobVkUcEEcet5/ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuza4m71Y9X/6JzahqKXpB0EAmUko2GA0vbkho5NGbWklQ7RQI
	AcmfbHMG732YtBbpgMQJytuCEN6tefrzyGmqXWfXD+C4Wb2gHPcMg7gZ+8Z14KORG68n1JMHF6o
	h4EdoeWOidcJQD2ayPhDkDuP7sJichm3eiOFO
X-Gm-Gg: AZuq6aLSGdmubHlwoGuRjJuB6IioZvVS0yU4DYfQbEUSkeystAy0vtTfyKU9/mIrDHO
	oTIFxG+omULtuZ8uU517BPhKC//WA2a0E1KjTHjlf5NW0/Bn5UwHiFfDjkmkNZT/rW0tMO5vtsL
	CMq+3MzqbT1B50m3+QsLa3nsyelCOltqUiQoTqTXPhi6BazZlk3rLnRxbJuBe5FC8hUc2XdmwFM
	fPP8K6O2hWdsIeKLhAr1c//9RjRgHqp/Mm9Ux7y7k9w5PIfLhqhW6ng7VpV+j3YEoqFMcM=
X-Received: by 2002:a05:6402:210b:b0:64b:572e:6ba8 with SMTP id
 4fb4d7f45d1cf-658de5adc90mr6548802a12.32.1770001590186; Sun, 01 Feb 2026
 19:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128074236.965019-1-wens@kernel.org>
In-Reply-To: <20260128074236.965019-1-wens@kernel.org>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 2 Feb 2026 11:06:19 +0800
X-Gm-Features: AZwV_QjgUltB7sREOUuqoW3RQ8oS0gPCr9qiGxGalraqZYhMcfBG91hxb9xNz_0
Message-ID: <CAHrRpumYeNObHDtHi7YNj_bd+ixMewfOP8bKpX2PbUPL5LUfpA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Canada (CA)
 for 2025
To: Chen-Yu Tsai <wens@kernel.org>
Cc: druth@google.com, Ping-Ke Shih <pkshih@realtek.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31435-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 21886C7F6A
X-Rspamd-Action: no action

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Canada issued a new revision of its regulatory standards for 2.4 GHz
> and 5 GHz license-exempt local area network devices - RSS-247.
>
> Update the rules to match the new version. Fix up band boundaries and
> power limit values and units to match the text.
>
> Note: the database is supposed to have values for e.i.r.p.. Most
> regulatory documents specify e.i.r.p. as well, except for FCC ones and
> any regions that have rules based on FCC ones.
>
> Details about the changes and justification for them are as follows.
>
> - 2.4 GHz band boundary aligned to actual text instead of WiFi channels
>
> - 2.4 GHz band changed from 30 dBm (1W) to 4 W
>   section 6.3.2 explicitly states e.i.r.p. limit at 4 W.
>
> - 5.15 ~ 5.25 GHz band power limit unit changed to mW
>   section 7.3.1.2 explicitly states e.i.r.p. limit at 200 mW.
>
> - 5.25 ~ 5.35 GHz band power limit changed to 500 mW
>   section 7.3.2.2 states e.i.r.p. limit at 1 W, but requires TPC for
>   e.i.r.p. above 500 mW. As the database nor Linux implements TPC,
>   the 500 mW limit is chosen.
>
> - 5.4 ~ 5.725 GHz band combined and power limit unit changed to mW
>   the new revision removed the restriction 5.6 ~ 5.65 GHz usage.
>   the two existing rules are combined to cover the whole band,
>   and the upper boundary has been increased to 5.73 GHz to cover
>   the whole WiFi channel and make it easier to write the rule,
>   like how the US rules are written.
>
>   section 7.3.3.2 states e.i.r.p. limit at 1 W, but requires TPC for
>   e.i.r.p. above 500 mW. As the database nor Linux implements TPC,
>   the 500 mW limit is chosen.
>
> - 5.725 ~ 5.85 GHz boundaries aligned and limit changed from 30 dBm (1W)
>   to 4 W; AUTO-BW added for combined usage with next band.
>
>   section 7.3.4.3 states maximum conducted power limit at 1 W, but no
>   explicit e.i.r.p. limit is given.
>
>   apply "e.i.r.p. = max conducted power + 6 dBi" conversion, arriving
>   at roughly 4 W. This aligns with the ratio for the 2.4 GHz band.
>
> - 5.85 ~ 5.895 GHz band newly opened in this revision
>   section 7.3.5.3 states maximum e.i.r.p. for indoor clients at 1 W or
>   30 dBm, with maximum e.i.r.p. spectral density at 14 dBm / MHz.
>
>   Apply spectral density limit at 20 MHz channel width, arriving at
>   roughly 27 dBm e.i.r.p. limit.
>
>   While the limit comes from the "indoor clients" rule, it is the lowest
>   limit of all the types, hence it should be applicable without any
>   restrictions.
>
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

All content is consistent with the description in RSS-247.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

