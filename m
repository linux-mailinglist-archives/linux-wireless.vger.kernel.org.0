Return-Path: <linux-wireless+bounces-9856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EFF923FD1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671701C22E24
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA226AE4;
	Tue,  2 Jul 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW3PXgof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D08BA2D;
	Tue,  2 Jul 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928960; cv=none; b=CoqjbKUy/By3EUkTQEGl2V8eAYxBhd43Ch/1/Se9LqrY7WjtnclEJZkxseqOBXenEk/QIKZa9aqmFv7n1fvBSZSOBiMDxfoCyIJYnQmURV1q8zWz4pO5C6wQXXWlmAD/1r6ZWC2JszmB0iMDjEpOhaYe/1KnpWESIQN7xpxu374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928960; c=relaxed/simple;
	bh=rvLq1+m8vg5sjoU1mr41s2ejjDcYQZEP8b81SL/Ncv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2ef0tjIdvY8iCUrSbVs1alRnCktXUBfUmci6ZCWKCH8pEZJj8Qh54oumWctbHZzbhaAEGSmZ002ZQOO9CwCK2NHFIDKCh14niaNitWfX2q5YTUWxDjQgbQrbzbGPERLlFV6F+oTaf37TTnotHsu+zYvyTRJ/2nXnMIagUNokv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW3PXgof; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c84df0e2f4so2936989a91.1;
        Tue, 02 Jul 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719928958; x=1720533758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UHRR9paF0c3vAEmjr04Xd/MVPuaCgs2m6+t9yEgF4PI=;
        b=mW3PXgofSdXwU4pk9LBA7TB19bl1YqGmHu2fHsddKyF7O0QSGL/ZrR03NcFa3syT8U
         NK8ji504Xvi8ONZSnuP8ufKB0GvgdsdiT3eqabBWD0FEK6oPDvxLmaD0Y2IRQAtdRzbu
         BXwbFMcu5ZUABrXh4Vre/9sLIATdjBn7xFKEOhdb1FvI2CwGB7bIXKhh6gPWWprJ/7YR
         PiIoB6Bj3WIA6NuaQ+VRipz34M0G6yeXCH+/V1EO1P+8jjWdaWjZV5L2U2jGa5PlyHxK
         ayttVFS3ooSw+SUyqYsmJloWmjht3bLIMYKTOYAbkYXHw/CrMxZS/EHNEHnL+wl8D7I3
         Aajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928958; x=1720533758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHRR9paF0c3vAEmjr04Xd/MVPuaCgs2m6+t9yEgF4PI=;
        b=T5ZNurz/qpSKurFJutLkN1IRlFlEKIhSsc2/ZpXK8FrjXrpU0JrPNb3TjCo2rBvC64
         hk/1SUAQ2lGXonqbLP/85RNsX4Kdc62rMZ79aSBTrLM64Q8Mk22zsYzU/nVy7+HljdCb
         roN0oXIKevFUm+M6QoIL4OJ5VqBNfOM9TzM1SMbzK3FZkzxoScG+LxG9nDOWWi5OuJsz
         o+SElxgkxmmGjY756eQPomH89WgI5NyBukuNoowq75GjXWNdtSSEL7sl+t2CI38hrCzg
         I5sFuWfmK69FWTB0qE5XGSgXymHuP1HHxV4wh7Xh2mp0ZIFO4MwKq1lvMl2sgDiQOoOh
         AO+g==
X-Forwarded-Encrypted: i=1; AJvYcCXEqtWL8DGnqL6yVOP1rVybkhIUX2rue2ps8yv8W9vhFPonqSGcgxx/JgyL4HnOzywxzPMdIaAGdpJ+lh3DppXQ6TvHtL3387XSxZolfmYMIxKQC/9XuRTf9GufPYtstmb5/ABS96ccPEGjHaAjl8qnU15TGRARNwORFG9Vnb1zUujeWrArr5KhkweraT8=
X-Gm-Message-State: AOJu0Ywe3vJZyueOlXGrIZW4co6PHTnQ0ffoI0QiF6R5FrgoIbW1YTTh
	/dD/rhRuYbF4DZIMgix2MhGDqOCAXluWrYgNKnm3ABtJ6X8cEMl9fUEdn09W1qBkdJ+DPg5HBGZ
	yphFgCgTo+/Cy8Bf8L2fJVVIeNq4=
X-Google-Smtp-Source: AGHT+IGr1IVhpma/X7cSGsV5+8epSN8AW4SxOgaesf6/u7RkxgP+qDb+mA8xG/CFotsUpvIlfd9npkCfvELtxOAGNQo=
X-Received: by 2002:a17:90b:3543:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2c96abdcad1mr769838a91.9.1719928957854; Tue, 02 Jul 2024
 07:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702122450.2213833-1-suhui@nfschina.com>
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 2 Jul 2024 16:02:25 +0200
Message-ID: <CAOiHx=n5rfCBkO8wfqpa=UgL==Ty9=s1f=roVHiaFy2acQOHtw@mail.gmail.com>
Subject: Re: [PATCH wireless 0/9] wifi: cfg80211: avoid some garbage values
To: Su Hui <suhui@nfschina.com>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org, johannes.berg@intel.com, 
	kees@kernel.org, a@bayrepo.ru, quic_alokad@quicinc.com, zyytlz.wz@163.com, 
	marcan@marcan.st, petr.tesarik.ext@huawei.com, duoming@zju.edu.cn, 
	colin.i.king@gmail.com, u.kleine-koenig@pengutronix.de, 
	quic_jjohnson@quicinc.com, linville@tuxdriver.com, pieterpg@broadcom.com, 
	meuleman@broadcom.com, frankyl@broadcom.com, stanley.hsu@cypress.com, 
	wright.feng@cypress.com, ian.lin@infineon.com, chi-hsien.lin@cypress.com, 
	zajec5@gmail.com, antonio@open-mesh.com, franky.lin@broadcom.com, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 2 Jul 2024 at 14:50, Su Hui <suhui@nfschina.com> wrote:
>
> Clang static checker (scan-build) has some warnings as follows.
>
> included from drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c:16
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h:123:2:
> warning:Assigned value is garbage or undefined [core.uninitialized.Assign]
>   123 |         __le32 data_le = cpu_to_le32(*data);
>       |         ^~~~~~~~~~~~~~   ~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c:138:3:warning
> Value stored to 'err' is never read [deadcode.DeadStores]
>
> There are some functions like brcmf_fil_{cmd,iovar,basscfg}_int_get()
> which read the value of its parameter, but some callers have not
> initialized these parameters which will be read. And this patchset fixes
> these problems.

The core issue here seems to be that
brcmf_fil_{cmd,iovar,basscfg}_int_get() function (needlessly?) read
from *data.

So instead of forcing all callers of
brcmf_fil_{cmd,iovar,basscfg}_int_get() to initialize *data first, I
suggest changing brcmf_fil_{cmd,iovar,basscfg}_int_get() to just not
read from it.

I see no reason why they should care about what the previous value
was, since they are supposed to overwrite it anyway.

Best Regards,
Jonas

