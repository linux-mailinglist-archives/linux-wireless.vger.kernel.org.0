Return-Path: <linux-wireless+bounces-15415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76E9CFEE0
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC4B2705A
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E816631C;
	Sat, 16 Nov 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcPhvwXf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC7A47
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731761515; cv=none; b=IPkoURSG8yQKIXeNYjylvl4kUH346QBPk5Tpecdol5jP+1nHF6OpAW5IK6TQxeBpgyzrvGMCuU0cYkGxhJizfxhmSh8O9C1JamuLrQ2zTNgXGCFzGwjZFYhneebo4YmkyTHL4xDUt3fxxImp6BDweYyZ8gStmAPqkLBYecvqLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731761515; c=relaxed/simple;
	bh=gc645Fqa6qgDAAXRDmGCyal4u71PxNRjXFB8kh8iuwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zgg3qwfBgBiLTTnKeYc6n5gzD6w8ZccqS5YLh3kNOiHvMzC9WmTm6Ct2H/KRLr85NVDgxdJMzEX9aFAUgrlVyjID+NSPHuTgSr0jVA7WzSkqxJlohSJ9Qe6CvmYPgIVycJOeWM/xKVkzyplzj3qbSb+6Y+vnRd20jA01sRqj/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcPhvwXf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea499f264fso71152a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731761513; x=1732366313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc645Fqa6qgDAAXRDmGCyal4u71PxNRjXFB8kh8iuwc=;
        b=dcPhvwXf8hFViIbrHz+MWJLIQNn4s4OjTcLATbL+c1Kx/2vVfXmhW0d2EvRXAKtar7
         UmAd1S4K9Z6R2TM8UtBE8zNnwVCMcUEG/2/4VqDblVXR16r+MbCqTPCLBPNVeyYlgqAx
         e7Nvg/Bw/2vRI/gWXTdm54geYxyDoLCCAFPVMXxRagMoh2HbkMwvhsiBhtdQLfkPetWz
         vDetd0RTb7RP7nQNEzQxw/xeJgL65xQ4cSKacdqVTBBySGk2OLKRR/9spUVIXuhsrmKy
         hg72k7cRSigUDEGqKqnDHEXH3dQbT61z+6xj52doou5BMZAS60QZTri7a5U0/9+gsD/q
         gnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731761513; x=1732366313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc645Fqa6qgDAAXRDmGCyal4u71PxNRjXFB8kh8iuwc=;
        b=JL+ub2WP97StVSlv0IuPJ2ElHlfIXWI9N0wf2n6uRiYTnDJ2CHhRTqrxsKTwpgqNUb
         ZERBa/lEe/hFcoUJ+uMXmK1g4TGweHYiINmAOUUHcCrNK10cTO0D6qbU9j7HsA3vPQYZ
         o0PixvNk7Qcg407bitko3vI2b/zul1mEj/DxDkLEjhdEao0f9yfpvVfblaax35r6AKhg
         NkUgI0JYWk7BFZiWiI/q+HCYpZJ5HaYWoThcZMaYHQvR20MF9cMuZWpKU8d/i6kijhQv
         1jrabZ8PH0yt35Eykzpri5mdUAyJtsz5H4qBgjvXJbPKkQxzjk0v7PAyxoAIFdI21Jcw
         KPeQ==
X-Gm-Message-State: AOJu0Yz5fV7Ix34Xre15I7OgNAgSWZAqqCWRSAPaoTyWJNITYvIxZnyW
	YEtFuPsy/oUI4jMs3dtbbyuw8N4rvk3JWkSJ3qsQ+r1CIBi99VQc10Qi/EAcUdrPI/fAgTVLx7I
	2fBfkEw1zEHwSaAkQT0xwE8gN51eA7wMfjrCaIA==
X-Google-Smtp-Source: AGHT+IHGreIYzr2bJ/6W0ODmIX4Ny1M/rNgdyZsolUqt32ukNk6xZFUGNGfFW46QzU0yzTgTg2okmGJunKWq7j63Lf0=
X-Received: by 2002:a17:90b:4d08:b0:2e9:20d8:414c with SMTP id
 98e67ed59e1d1-2e9fe62d772mr15300927a91.5.1731761513234; Sat, 16 Nov 2024
 04:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPGdDAmPp80VEZ0TG=cS3QAYKqELHfqChid0wYZ7eLAENFY86Q@mail.gmail.com>
 <2dcd4763853b4645bab7911482209de6@realtek.com>
In-Reply-To: <2dcd4763853b4645bab7911482209de6@realtek.com>
From: Ivan Bulatovic <combuster@gmail.com>
Date: Sat, 16 Nov 2024 13:51:42 +0100
Message-ID: <CAPGdDAkCh81SYsZiCM8pEn8hEpsT19H1DkBx5Tr4A5a+uThhhQ@mail.gmail.com>
Subject: Re: wireless-regdb: Updated regulatory rules for Serbia (RS) fails to load
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch works for me Ping-Ke, cfg80211 doesn't return the error any more
when RS is set.

Thanks,

Ivan


On Sat, Nov 16, 2024 at 9:30=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Ivan Bulatovic <combuster@gmail.com> wrote:
> >
> > since commit b44edb2eaf3a917fbd7005f05c6faa202c984152 regulatory.db
> > fails to load when country is set to RS with message:
> >
> > kernel: cfg80211: Invalid regulatory domain detected: RS.
> >
> > Offending lines are:
> >
> > 1646: (5725 - 5850 @ 80), (24), DFS, AUTO-BW
> > 1647: (5850 - 5875 @ 80), (24), AUTO-BW
> >
> > OpenWRT is impacted, but I can reproduce this on Linux also.
> >
>
> I sent a patch [1] to correct this. Could you please give it a try and ac=
k the patch if
> it works to you?
>
> Thanks.
> Ping-Ke
>
> [1] https://lore.kernel.org/linux-wireless/20241116082417.8720-1-pkshih@g=
mail.com/T/#u
>

