Return-Path: <linux-wireless+bounces-5712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EEF893BAF
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BEA1C2083F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB13FB1E;
	Mon,  1 Apr 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef2lS3dt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F33F8F1
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979946; cv=none; b=M/UgtSoW7+/8NInWstMV3VTNjdCPf9c6pm8/Ngj5x0Jnkd5n0DqWOX74+KUNNrOS3xPwYCim7D9INB6fP87TV89TTLkmR1XRxQlxH+YuqKvN9A308c12J1t1cOL0ayG8eDGnnlJlri/7gHh6NnyeUlRoSvGYIxQcUhR0Y953Z6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979946; c=relaxed/simple;
	bh=zlybI7TmVWzDbySNWChtftKc6XXWuwRXyTLO9Q0AR7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZszla2MqyrlOZ1KlhB2Qu6HH2fCB70hhGOZijY4Ut2WIs9ME2cT8EBD0X6CfiPFqng4+EHt/Io4znKSgrklj6rbrUpqj1eRYPsN6QltA6YlbVeUkeqDtkDTzOFvMtsYX4IFPmfAn13nUnKdEA29VxdwkIlcMJhMpPcuwrAzRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef2lS3dt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46a7208eedso522379466b.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Apr 2024 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711979943; x=1712584743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eXMcE47Ulq/Wa5XVWw+GY92rlwTaptPUs5eih6zWRKc=;
        b=ef2lS3dtdRj4f9U3VdWkOAsqwil28bGOB/e0IxKZLr+0AEvUEeXQGAxkbFwCO4XtXT
         TGWQri3B0DpMFMc/Nckx/fgKmjFndfXMe6Ky4Dl5leviN5QyCnvNiAhynEChlT+PZyJw
         NKgbDni9hq5SwjqEQLK++FCCln5S0sWv4oxApe7A5hD/b19Li3pD9Zdy3gE9Ifc+tSIB
         uh17u6lEVjyeqJ7LCjGUfEHCGb4BHHS8RZfpGs6ND9JSUTqkqrwJnddXLjxhFbTvTp6X
         FLl9NaFGBhs1XPsGYsDl3wkl+riUzihM4EsRu6kcgUQxIC41a879PhskjZkxUQNJ29e8
         4CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711979943; x=1712584743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXMcE47Ulq/Wa5XVWw+GY92rlwTaptPUs5eih6zWRKc=;
        b=s3E/raA7fygeAiUUvMqp2CAtmOv14daQiD6QTjLfX7gK3RPQgezTUTrTL4lGlfL5td
         w6iVWTkJvpi+c2SB39nA2ENOhhjTcFwpVBJnlLTb6gKib4hFaSA0O0dvrx2iuRNGfz+T
         RyYJCEs6Z8kVYM27MAQjKOIRtWeXKy+L9mbIA4yst/+I69rzF15b+M0YdZyoKKKzy9Y6
         d0LCoHRiT3h7qyo10wpO/u9JM0YNw3wiLjupxoEd9N+P45GxmhxV8cFuQxNco9PmcQWT
         su8lMJJ/c5Lu2mwg73+87TBjzyNZ903Gd+RghckdtgHiheys0bnzioO6VhM80NX+FdQ4
         r24A==
X-Gm-Message-State: AOJu0Yw90fSWnde0V9bKFShyVEO6D4b3VMwnYi4vXFY5pmjW1FNIemaz
	6SG5/5Je8aoJG6G7tAhFNlQVYnKhxrmdR5f3QBWfQJRpvUI1eIhNELBUn8xrRCQDflAMIx6FFKM
	3qGDfssw7j3ivwMW112EyaPIaUh8=
X-Google-Smtp-Source: AGHT+IHNzR0b/SKQFR9FfXu8ASm4tHI4P3swXOTFlirTNwV+0Ecp79FK0aTPe6QWOB68b+AiS1dnCH3juBilG0WBc6M=
X-Received: by 2002:a17:906:a417:b0:a4e:7f72:77cb with SMTP id
 l23-20020a170906a41700b00a4e7f7277cbmr99968ejz.38.1711979943296; Mon, 01 Apr
 2024 06:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327001131.4028431-1-greearb@candelatech.com>
In-Reply-To: <20240327001131.4028431-1-greearb@candelatech.com>
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 1 Apr 2024 14:58:27 +0100
Message-ID: <CAAMvbhGHe4PM5M=JJZRQ2m5_aVZ=4DPG76MT+q5qi3HA+7_wzQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7915: Emulate chanctx methods.
To: greearb@candelatech.com
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi.
I have used this patch, and it fixes wifi for the mediatek board i
have. the BPI-R3.
Please add it to wireless-next, 6.9-rc

Feel free to add:
Tested-by: James Courtier-Dutton <james.dutton@gmail.com>

Kind Regards

James


On Wed, 27 Mar 2024 at 00:11, <greearb@candelatech.com> wrote:
>
> From: Ben Greear <greearb@candelatech.com>
>
> Looks like this was missed in the initial patch that made
> the conversion to the emulated chanctx drivers.
>
> Fixes: commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> index a246d11d9811..fadb8e62092c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -2050,6 +2050,10 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
>  #endif
>
>  const struct ieee80211_ops mt7915_ops = {
> +       .add_chanctx = ieee80211_emulate_add_chanctx,
> +       .remove_chanctx = ieee80211_emulate_remove_chanctx,
> +       .change_chanctx = ieee80211_emulate_change_chanctx,
> +       .switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
>         .tx = mt7915_tx,
>         .start = mt7915_start,
>         .stop = mt7915_stop,
> --
> 2.42.0
>
>

