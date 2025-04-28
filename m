Return-Path: <linux-wireless+bounces-22153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD124A9F6E3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390C21888A37
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50913279900;
	Mon, 28 Apr 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcLaacM9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9218F2FC;
	Mon, 28 Apr 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860224; cv=none; b=dTN6kcdAmt0GJsXHIQ/6KjKBfGsD+i38NMCja7hWkpE+1sV4vHQYVv8uLGu3R7/WlFKInT84C/mhkHqZ/TyqNf88MBmGEAqJ38j7IvD/jUFVvYEDlWf3oCq+u2hOyCogPOponVxeCYXUiof3ltcy6pXg2HYa+DGLcodKMvT3iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860224; c=relaxed/simple;
	bh=vEsR4ZoZHVFT1r5XJ/2XpS3u/EiMbzkKg8Uk1QA3N88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ZTkXt+k+7+4RmH7pGS9/WEpd/btA8lL6na9KOQAhcVduRFJQCByJ9sTg8QG19w4MgYPIZv0t+7GgPt/lO3LPjSoOonVzF66qvkUf53YwZKP2s5endWntRYyqY8JGzQ/xx6SGfKaSNBBeZIPwuof5k/6cVmugAdollw5fENCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcLaacM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9596DC4CEEF;
	Mon, 28 Apr 2025 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745860223;
	bh=vEsR4ZoZHVFT1r5XJ/2XpS3u/EiMbzkKg8Uk1QA3N88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kcLaacM9dSPst3MiSqP7Zm8O+JfMHZjeRGZ39rlcN7LBHq0GLMJ+EEUyQFuEtSvtm
	 bcY9cbZ3Hg9S6nfROUh3IjTDLsIUYHiD5w1KjnpdM1b5JiuxdsUGqD/efTJGEKReeB
	 rcyFVIaC/JXRlvck7+893uvSqhaPNoT+FvbooRlQw45tJ4cR7D14PoNqwNDLzMxh54
	 x7nmNsNp1OG1byl3jEVbi6BI+n53SgLojOhbRy6cww91XNB9kpI7TaOu5jIGlFshQ3
	 0i9Tun+q2sO5IYIa8ko0aJrMFZViov7BADgr21gx2zGYNG4VizlpJU2bWElAy6Tm1i
	 skQ1jyXWiy+Qw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-702599fa7c5so47538427b3.1;
        Mon, 28 Apr 2025 10:10:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULtAaDU7Id5kBs72I+ZxpsnRm/PFWYVPdgKV1G72ys9tzL4KT4iGn3YXAPbeQYMz63qWvNlspeJXIm@vger.kernel.org, AJvYcCXBS4NVevTnGfrvSskKJlPsHi8pCTRPxpfcuER1t7V6cyZpjMnpgo5ZouAsZaz4PfTt6EcJWeq18LUuWG/R@vger.kernel.org, AJvYcCXKdxglZZ2S4KcA3nBFlCnH90mVA5P+xdovBPKi0AFhnYDh9tke4aWTLtv5n901C4Xbmaw1NPD0cuZ9OINDhn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gICgBkxTjB6tDIpQiV+9sD9J8aca0tPLnHFGUzXVI+y26svx
	pM3NJudBbDtnbjFVdScYIM26y/hnXSsArza3xanTb74wQS1trKlF6ByCU4u7mq2tyfJ0Om5CNjH
	gSruPBwoLWyJZ3XhbyrUb3nVuD/8=
X-Google-Smtp-Source: AGHT+IEKXHx9WNrCJ8KbJwQVZLUmzNLo67P14iS+1D+DGqi2anctCFi1gSHert1yRUEn+tb5hg3VJLd15RlOg72/DNw=
X-Received: by 2002:a05:690c:95:b0:6fe:5dba:b190 with SMTP id
 00721157ae682-708418f3551mr216219627b3.11.1745860222795; Mon, 28 Apr 2025
 10:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422175918.585022-1-artur@conclusive.pl> <4854f6a248fdc501d4157339fdb21f9a3ca3097d.camel@sipsolutions.net>
 <9a657c02-b688-4f2f-bb0b-fd25d19a54be@broadcom.com>
In-Reply-To: <9a657c02-b688-4f2f-bb0b-fd25d19a54be@broadcom.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 28 Apr 2025 13:10:11 -0400
X-Gmail-Original-Message-ID: <CA+5PVA76ZT_NEe_xeoc55V0p7M4W8KneAPjUR78ja0q3aBUZ8A@mail.gmail.com>
X-Gm-Features: ATxdqUG6CPojcKu3jjyuLJcZ_srrjoBPqUF0xD-D_e-j-2vGQSSJSpQ2NkABa2Y
Message-ID: <CA+5PVA76ZT_NEe_xeoc55V0p7M4W8KneAPjUR78ja0q3aBUZ8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] wifi: Nordic nRF70 series
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Artur Rojek <artur@conclusive.pl>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Klama <jakub@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>, 
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:46=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> + Josh
>
> On 4/25/2025 8:11 PM, Johannes Berg wrote:
> > On Tue, 2025-04-22 at 19:59 +0200, Artur Rojek wrote:
> >> 1) Nordic gave us permission to upstream the firmware blob [1] require=
d
> >>     to use this driver. As that needs to go through separate
> >>     linux-firmware repository and is subject to different licensing,
> >>     should I try to upstream it in parallel with this series, or does =
it
> >>     need to wait until the kernel driver gets in?
> >
> > I have no idea. Chicken and egg, I guess.

Parallel is fine.

> It used to be a check by the linux-firmware maintainer if the firmware
> blob is referenced in kernel module info. I assume the main linux tree
> is checked and not linux-next.

Eh.  We check for net-new firmware just to make sure we aren't growing
the repo for something that will never be used by an in-tree driver,
but if the driver is in linux-next that's good enough.

josh

