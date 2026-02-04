Return-Path: <linux-wireless+bounces-31526-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHQXF5oug2mxjAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31526-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:33:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE108E52F6
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AA743013681
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54BA3ACEED;
	Wed,  4 Feb 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frcGj+nB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8222BE02C
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204818; cv=pass; b=VfeL0Od3/InFp9M8mSuAkJj4IWF89nvM8r14/rx7/DSNOOk1EK8YznvwaWUOu+yUPynUmd8T2Y20EUQgRPZei3NN7bUTrCC8y3805VmFnnZ6lPp7R5Ot4mSFhHw0fn8u3feDpwqDMZPKdOf6D0BVBKlSDJ2cAGYyPNkQ3kFgQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204818; c=relaxed/simple;
	bh=T9jxaJfX11xsWywPIVlT3TarHXQ848bLYMFCDSKl4O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu6JtzC7s/6ZAR6lSFZ0jgIKaHQrIHNq5ai8eFFT/spD0VXIFP1CSlbp8s7XjqEn+MUc+hkY/yspwF5TPZo0I2/2S2UX4V45gM2TEmBc6HkX5TBcdVwZAeEl4MS9TRdrbpVdGJ8rs781Wl3ZlZqE2UaGjLBiTyesthARk4kPXuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frcGj+nB; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64965ee303dso788947d50.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 03:33:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770204817; cv=none;
        d=google.com; s=arc-20240605;
        b=ejUf4TdjCNjlfCJBQSqu3W/7ZNrFP8lih5A7R7E1ByFY9jCKhfIYC0cFlytsCKRPSu
         ZahfUJRHZiBkMX643wxRfAAV39lFMgzGy9F7z+5MDNlJ/2pfQ+Ja6EWnXlOqZd3J8kpw
         rGKTWhznyzfj8p4glzqcaL6i/j23ktktO2EoWAorXJPsE8OsAWSVGHykUc/a7LDVZjER
         xHzb0JyxlXhvLlkYnhimqpEF23x5TOSWQBJQlP1jWbmgbUYVHiMWRKKpr0qwpBXe1L14
         QhXIehUryUOBRPqrpgVUxnRIXJi6tk8JzH9Pko5Dx92Kb6wYEGzB9FC3vQftHIbSIBPA
         m5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T9jxaJfX11xsWywPIVlT3TarHXQ848bLYMFCDSKl4O0=;
        fh=8IAy5qup0a2EY8QRGpBSpKR+Jn4fWjWAV5x6xozgXOQ=;
        b=VbPpNi0tKhKCro3Zyai1GS6fjexCEB4JwF1DeSAR1eEIm5Pa04rPBglHAebmArIWrT
         CL/jf3ABNalfKWpjfbLWl/LXPqv1Zvl/E/RS6mWEoML7UFDVkakRpKthv1E+PWrzaoXV
         1puBJbf9Ca1am71IzGWj33qUIGTaxjm6aZJ0Nu22xTMeVyvMlUuANyEDs4ZT4EjVlvXf
         +Y1Duf2F8B1Kmv0wdhhRYUPxqtY0FzPARIN9Ym+zG7hB5vfmuo1Lef5iUbUPzPhiGRJ7
         U92Cg9MkzVAd0ZoKNovhkJYRwKJLCCjC1Www9St/xvQR06UuttD0ZcUF02fqLmwozWb0
         EDOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770204817; x=1770809617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9jxaJfX11xsWywPIVlT3TarHXQ848bLYMFCDSKl4O0=;
        b=frcGj+nBLUsbg0VWDg3kbUFYPveai78C3ESQe8OA0hq6PhIwjmuccEgegCIa9kD5yA
         ACW8m0OkxvdcOB6D0N7CmA8zANFQpEaCcsH4QzfYDzyw7sSi/JtkLmgQ/ARfdwBMS65Y
         ZUj+DBG14lw0dYbyCeXFJAlpxhU3hiWD538XA++SU5EW3l4zc2jt6fYf3siJn2bHUhrG
         As1f538LZq39ENxsdawfZD7c/IMmpZCt4EOqsEEfGW5pubRXSQ+LqB6daQY50pMtqlad
         QZeaGyWPyADV2+6BNWDt1Xz1jFqZwucGPwVARtnXwBk1MPgzSPFohVBdYrBmSdTxXE+m
         0Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770204817; x=1770809617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T9jxaJfX11xsWywPIVlT3TarHXQ848bLYMFCDSKl4O0=;
        b=EbCUGlvMzKRibsFmsonBaF9X+ovZSFrpQy47p9PvTIuN6LfiUEwLN71rtuejuhW6qp
         9GCYyYLh5+bm+Hu3Vm2shN1UsRmWCcTvjx3xvBmZ9wUvsN+j+roBy3aNs6G7oj7ODHhO
         dtdCtsuOdbyZBUNMuhTjb0ORzzVz4pZ4pG/Dca8g9bFek29JrZcI3tLeivRMhYn6zaks
         qfFA0vM2jQoDFfs/v4OADMLJVn0/CNejla3gFj1TLZqg+vAY4U4UWmHomSsKIojbKTfH
         ANtvQd73aJjy31bBIXrPxwCVD4mVts/HkadpcmzgGeXrFhLdNr5N4xSKiJHVpfQahJA4
         YhWg==
X-Gm-Message-State: AOJu0YzBxsyvuaHBoxdpKxli+hxVovFhRlKl8Rem+5RRfKwgfnCiQMEY
	jOVVqfb7YV+2SFgGpD6xjmHaPvXfzb/2UAiz216oy0ahRRYFgrQf9Kga4Ik6/LzAq5a7n2q1W/X
	l8ween67vmGWiKYkYH2bnfB4IchkHJR4=
X-Gm-Gg: AZuq6aKuJqpfej03eqZfLkKs/HzfNgGklYxazsv/98ltQQsw3gY8svHxZoEoza6PmPr
	/rzE0/0SxfpinHChv5qPzFHahF4MVk6UwNzgmGePrlNSGQppx9oAeiP7BcOdUIk6Keisd61U8te
	5trjagdYCkX99YrbXcQENqEBHsPONt/uTy/ABJlRPWs9O6OTC8za5q8G3hrGVWrP695oeeW+LIx
	70RU/OBbxSkUHgMpWecKgWklr/bMQrbaxXhhZx2/1Tb19PoN+cX8/5Dn1ZJeUb9PBgqlA==
X-Received: by 2002:a53:edd2:0:b0:63f:31f7:b956 with SMTP id
 956f58d0204a3-649db34b0f9mr1782860d50.27.1770204817481; Wed, 04 Feb 2026
 03:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
 <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
 <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com>
 <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
 <CABFUUZFxH1noKq-=zSTrqpirJtTQ2AA6anb7Pk=BDGC3aTs+Og@mail.gmail.com> <a1989402f65d0a9a696eb85925db98f6b722fc11.camel@sipsolutions.net>
In-Reply-To: <a1989402f65d0a9a696eb85925db98f6b722fc11.camel@sipsolutions.net>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 4 Feb 2026 19:33:26 +0800
X-Gm-Features: AZwV_QhsRK39ip0cECQhjJexKDE466RUKhfAda05VGqAl8WbVjzsHFzzsMQZuBI
Message-ID: <CABFUUZG2pNxwgJzw1hiCj8OL988Ed=2xBhsFuNo09rRLTUF9aw@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31526-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: BE108E52F6
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:29=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Wed, 2026-02-04 at 19:21 +0800, sun jian wrote:
> > >
> > > applies _only_ to signed short, not to signed char?
> > Fair point, thanks. I'll drop this patch.
>
> I've thought the better way to address that warning would be to simply
> use 'int' instead of the enum there, but I forgot where the warning even
> appears. I don't think it's generally with gcc/clang, is it?
>

Right, I only saw it from sparse, not from gcc/clang.

It was reported for net/wireless/nl80211.c at the checks around lines
~5762 and ~10539 in my tree (both are "band < 0 || band >=3D
NUM_NL80211_BANDS" with band coming from nla_type()).

Thanks,
Sun Jian

