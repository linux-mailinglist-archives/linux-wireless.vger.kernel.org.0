Return-Path: <linux-wireless+bounces-13405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970798CF3B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E64C1F221EA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A7195FEA;
	Wed,  2 Oct 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="S6VwARbC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD888155735;
	Wed,  2 Oct 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859123; cv=none; b=ZcWlJJDPV35ocZ4Gyq+NCWabpWAutvNuw7eAZoJo6hhT0rRBI8IDjvm9JQS8KpUqZDInfokJs63jFrmw6KfWby9O7K4n72lIga14pHclhvcE4wSlpHyYWDSuffB1aFbe4Xv5zQYnuwgOTNl4u2Fk+hsnBhbg0ChWOQlD4e2Q60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859123; c=relaxed/simple;
	bh=V0WuQjwf9bjtuzKC9uAE+e5JQzbB/Z4Hs8+9j2xL2/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dg+n6M9Yp6G1Ksb8MFeBg5dD5HBmWL8OX9FDzVggtg0BXIYlBgPaN/3D3whrhW8fTSf49QJLUOZHrvm6J1E4baBEj2CnhYWZFghzK9VXlBsBOA1Ka97tZilwOW45LMiaiYygB1f4pA08h2TWLtGp7CX+sf1Hm0LOlDNYWavhyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=S6VwARbC; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1727859110; bh=V0WuQjwf9bjtuzKC9uAE+e5JQzbB/Z4Hs8+9j2xL2/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=S6VwARbCBQLtb8M2ZfsHzzZxsBik3zRbLawj2Av/vado7vj8Pr8YqPrHsYyNNSIdI
	 Xv5Fw/yxuExmGl3p/mxxttZ+rePRNnqUJD5hqh82XZzT7CWUBNG6ZXCALI2Qz9OKE+
	 oNojSaHB97tN8ecWVa5ii60zN4pZ+Zaurl55J07cCZEQaSv5Lo/dqdij9AHCpjmAEq
	 zHsKXFFPZu9l5Y5SJRd3Bu2Mz7tJl9ozS4xbcMTaXx19dEfUYBgDDMluliXeLnYKDb
	 GoYo/IUApWJUuKtqGDPzm2EfRZbGzjuX7ppmaHtpXQ3Mn1hb4FjZ1ccjK9k7yzuEeh
	 JNDwHTDkJOrhw==
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, nbd@nbd.name,
 yangshiji66@outlook.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: return by of_get_mac_address
In-Reply-To: <CAKxU2N9XFJZaVJgQDVNWmsUoJ_WTHdv7ViTs9xFpFWKeY5Woaw@mail.gmail.com>
References: <20240930230425.369534-1-rosenp@gmail.com>
 <87ttdwqlci.fsf@toke.dk>
 <CAKxU2N9XFJZaVJgQDVNWmsUoJ_WTHdv7ViTs9xFpFWKeY5Woaw@mail.gmail.com>
Date: Wed, 02 Oct 2024 10:51:50 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ldz6q449.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> On Tue, Oct 1, 2024 at 1:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@toke.dk> wrote:
>>
>> Rosen Penev <rosenp@gmail.com> writes:
>>
>> > It can return -EPROBE_DEFER when using NVMEM. return it so that it gets
>> > forwarded to _init.
>>
>> What bug, if any, does this fix?
> None that I've seen. But the goal is: if ath9k probes before NVMEM,
> defer so that it can get an NVMEM mac address properly.
>
> I think in OpenWrt there are hacks that force ath9k to probe later, I
> think because of the GPIO driver situation there.

Right. Please include this rationale in the patch description :)

-Toke

