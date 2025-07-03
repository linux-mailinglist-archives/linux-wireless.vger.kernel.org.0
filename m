Return-Path: <linux-wireless+bounces-24800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8AAF8073
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 20:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAF31CA05AC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDCC2900AA;
	Thu,  3 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b19e5lwl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23332DE6EE;
	Thu,  3 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568322; cv=none; b=rDWbDTpijSjuCJMuOixmj7fglXYfo0Tx12+QAjsaBJZ5WuGOglaywlYNg3GqGXcve1mKaAjrR+Cm1NIzZ2OXjTVnwbVIe3mDLaXUVgIRY6r9QVFew9zzMSC9tvjxiW9AzxVkNSWJJC0hg+9v2P+m16EmscLjcJDCrH1Ad9HTNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568322; c=relaxed/simple;
	bh=y1ibFcHZ3Gp2zMIJAUNfr3OLUuofICdR6lY4OC1LOpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZN9I5aSDmH7M0Mc8iJ54BbuR+fgPlm0eX/U4wRAx4soxggQaPivj4Q2eLVdD6p3rnxdwt61uM2th1ZbpnDGnNEJfczuMo/9FBSM+QkZH1rnaxUmuZH2sggUWzJ79tZVwWLZPK5/n3O66huxMZX2TVUvSdIl68XTkFvWxXYp64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b19e5lwl; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-708d90aa8f9so1086597b3.3;
        Thu, 03 Jul 2025 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568320; x=1752173120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1ibFcHZ3Gp2zMIJAUNfr3OLUuofICdR6lY4OC1LOpg=;
        b=b19e5lwlscwQainWcfJaMPy0IcwsGRXdFZa5+sjrueQ27lJaR/mSEeGoZWygV22xQX
         uKXytGwiFU/GOSzq5AANfFvML11J81XO/zZFQjc+vDvBkKId5cTRUBexOohE9ixFs1QI
         9bnGXSq0dhfF6dzmi/nO1JMagGTfAPIuwD6vvyv6nEbG1vkkuU/AUs+att2PQp+TE6YT
         del+N95H2KLij9sqSpdma/Y9dfdURw9JBJtoAazQc46aNRdK0xtKnCm3Iws9Pdv0sjTw
         efBOwo6BKczKc3WYEFW7VHb3bv0wz3ZiQRobiukyiTKngFRGeoltnEAHQ7v2q3gvNLk+
         QkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568320; x=1752173120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1ibFcHZ3Gp2zMIJAUNfr3OLUuofICdR6lY4OC1LOpg=;
        b=hHZLaVe4duNikuJWxaV8ectPon9jaqZA+HVw40Yvv4xxkVhmEKMbaIfrohj7lZcPX2
         J4tjgaXq+VPOmlcjxMAT5qYF6C8yjSE8XctmR/LT2oXkINBW561tKr9m8YJvzdf0nUG4
         drNXOi4Itk9YuUmKOLOPUXTh/8VQwLeA1gC2ZF9qbVWVPu9CGh54xjI3VZhIhB+HM2+B
         reR454C57kzgMzKgeTP06rc4qM9/Nxl2pwknFgkID6QJiCHjoYXjBA8oUqsfEtzuuchI
         YjD/1/L4PAfUJIgjwTAgYH8TEdjmw39jcgjaXqpRZzgXdlT+AsLXTDPaof/e/TULxLI/
         7O7A==
X-Forwarded-Encrypted: i=1; AJvYcCVoW0e/iaX8QDIDSKyAFwSzsoMF+N/zc4mtVQt7jhL64dUc59mcZvynWx7T1Mz60Aq9HuQvRaZp2WxtMds=@vger.kernel.org, AJvYcCWVfkHMDeSE6HDwMC+Lflm3TpW9QQfMq57REjn03TKkZDzD7gixo12FZOJ1R6K7VOxB0eExj5c4NISmmQU/idQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECt4IoG4SMXetv5k68/cPCZ+nbAs+U/1Xr/NCatBnkVOoHx8Z
	q5jGZUcPXhI+l9kzqUeImflmnNOkpIEzA+F7SL7daITddetC7nb2FbKTXiHNI0sCAEw07fnJmv6
	YuwR9ejd9rzHr+vEeMefKU27BfZe5M4I=
X-Gm-Gg: ASbGnctzLkZrQ1nmH/QRmKcN4otf457VxA22HJQ16PzqsNUxFTyFSM48Li63n5iyrk8
	iTd9rnsnArtfJUAyBZpJZs8JOt+7+eYHJTOoMqAAUEUB3+hGh6JT2y8Mqe4UgyzdUZB6n5kaeZu
	FDJm/5c4pUy8yCs+HDOUGPPVU3OgxjFs8xDdReLuC2ksx1HtS1Z1B1uZWCr4RMWvH1jLbQkQsHD
	CHDqS0O+qMAlg==
X-Google-Smtp-Source: AGHT+IETh+dtwHH1oQ6RDkj71gx9dRfVQ1cl9MyjEm5vYfcjUtxAw+hOLZg2KSK0HxkTOIcr1LYq8P/WUFL4eiM78gU=
X-Received: by 2002:a05:690c:3501:b0:710:f74b:61ab with SMTP id
 00721157ae682-7164d357a9bmr111373057b3.9.1751568319629; Thu, 03 Jul 2025
 11:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
 <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com> <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com>
 <1f13328a55c54fb49d8ca1dd72bc5de23f161ac8.camel@sipsolutions.net>
 <6ecced8b962cf3a6f5056a87aa3442c49941e74c.camel@sipsolutions.net>
 <CAF3JpA7ZeG5uxLJr1NQBBzF=UZRi4sj4TSfBw=Pvx7xb1NCqTw@mail.gmail.com> <5fda29626ca04e7c2ad46ca4a3d0eb1d992789d9.camel@sipsolutions.net>
In-Reply-To: <5fda29626ca04e7c2ad46ca4a3d0eb1d992789d9.camel@sipsolutions.net>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Thu, 3 Jul 2025 11:45:08 -0700
X-Gm-Features: Ac12FXw2hciaDGGmicqLi-QwVnR0XzGOoZpgR7-KTUS52QJWhiCxZTmjAb3lcmo
Message-ID: <CAF3JpA5NX4s5XrUvOfVg59oOmfFMHoZ0e5+yHynRYifbPY05Mw@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nicolas Escande <nico.escande@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 9:54=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> I think it'd make more sense to go the other way around and list the
> bandwidths that are _valid_ here, even if I don't see it getting
> extended any time soon (anyone working on TVHT? ;-) )
>
> But in some way I also have a feeling we _should_ be able to reject this
> in cfg80211 already - although it seems that right now we cannot. Hmm. I
> guess better to have this validation here now than fail/WARN, but then
> I'd like a positive list of allowed values, rather than forbidden ones.

Thank you for the feedback.

I agree it is clearer to apply a positive list of valid channel widths rath=
er
than excluding specific ones. I will update v2 accordingly, and drop
NL80211_CHAN_WIDTH_20_NOHT from the current patch as well. This ensures onl=
y
the valid set is accepted, while preventing the WARN_ON from being triggere=
d.

Best regards,
Moonhee

