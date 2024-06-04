Return-Path: <linux-wireless+bounces-8480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E105F8FAF3E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 11:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E281C20CF7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381613A415;
	Tue,  4 Jun 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swZUxvTw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85B14372F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494591; cv=none; b=gdpEBZ3YnmkodnVsL2qdMW84ARf2Lqe92kUl90+qyH4fLFXiObGt27hyaJ1wdT+v2JIKqXcNgYTdATdq1AUyMlTkmgVrFmk9WZeK7iafQCK/1iofRLFZ/30KqrwLIwXCB5pNBGFUxYzZCeePizkGgZfqLixXIajH6v2gqNeCY4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494591; c=relaxed/simple;
	bh=i9WJOAP6ErRW8I87gS3tgrcxNTYxqU3BYox9LVFDh5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCU9j0nQ3Udx7qWMq5+iEY+4Bguvfh1cAZ5aordLQupFqhfXFspqET/CdC6QnOT0jfnexjiSS2EH9MW6CatTEHV8NTKthZog14Q9N/THVOk1iZJkhryInsZrzwvSnoahwXbg3wehw2bWA77T9p5D9FN1qW7yiKvVY1z/NGONULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swZUxvTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E86C4AF08
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717494590;
	bh=i9WJOAP6ErRW8I87gS3tgrcxNTYxqU3BYox9LVFDh5c=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=swZUxvTwjS+TP5F/3bJ7dEE0dulfu0Nskq48igVvbiIuNqxP4Mzz+I2zbOPj9wfW3
	 9wldhutkdK7mWfFlWchW0aqHtrTItQ5Nlr8Sg/EWHWdKFDs3yQjVlp9e+t0vSqaVM3
	 OOjPHwyoiAtZvAP6GUOrTyd7UE8jUuHUWqzAbnFc4qmMS3flSIKRUQNKD4z2RiOwfg
	 defMOEX7tTWGjyIqhj1jL0wRJz8HJsBLXC0aTBkhUUbxaveaxyRp+WBRGaKMCnlrw5
	 7VQNbns4sP6nMg5nIAuAh3PXvYe1VpS9o2UXBjBxQcGLU4bJN6XIkMqAs+ZwwGv52W
	 g3Aw+x03BUTxA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eab0bc74cdso22286191fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 02:49:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyr3PCXXFb1L/Tuq9HHW1NErJR1212N0A/n27HnrFUAgTDhFrQv
	iyGzDyiyeTeCQcdeeNMu2mrxdJ+D1JJvEda1faU7nSFfim0SV/7X6S3F/V8aTH+hRdzfVuqYqkU
	7sKuBUQv9W65GMe/RFLYWnhh5Ook=
X-Google-Smtp-Source: AGHT+IENPzGi8f6N03iIQSrlvxbuHk+91oLEXsqKPAhfDP5z61AsIWZSfpAnG7GgQPflPnsHQ3l/SZfjoMKQlmzCsDc=
X-Received: by 2002:a2e:9290:0:b0:2ea:59a1:2810 with SMTP id
 38308e7fff4ca-2ea951de677mr75010031fa.48.1717494589218; Tue, 04 Jun 2024
 02:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com> <20240603060930.99039-1-pkshih@realtek.com>
In-Reply-To: <20240603060930.99039-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Jun 2024 17:49:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v670CH3oNhwasHM0Vke+Gg+kSkf7hYL1ofE+dsui-L7_rQ@mail.gmail.com>
Message-ID: <CAGb2v670CH3oNhwasHM0Vke+Gg+kSkf7hYL1ofE+dsui-L7_rQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] wireless-regdb: Update regulatory info for Morocco
 (MA) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:09=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> The publication of the Decision ANRT/DG/N07/2021 of May 2021 amending
> and supplementing the technical conditions for the use of radio
> installations composed of low power and short range devices [2], which
> ANNEX 5 defines p.i.r.e. conditions of 5925 - 6425 MHz are 200 mW and 25 =
mW
> for indoor only and indoor/outdoor respectively.
>
> [1] https://www.anrt.ma/en/lagence/actualites/wifi-6e-now-authorized-moro=
cco
> [2] https://www.anrt.ma/sites/default/files/decision_a2fp_-vf-_mod_07.05.=
2021.pdf?csrt=3D14818568393101165775
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

For the changes in this patch,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index adfcce15e3a7..59d7549ce604 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1133,10 +1133,13 @@ country LV: DFS-ETSI
>         # 60 GHz band channels 1-4 (ETSI EN 302 567)
>         (57000 - 66000 @ 2160), (40)
>
> +# Source:
> +# https://www.anrt.ma/sites/default/files/decision_a2fp_-vf-_mod_07.05.2=
021.pdf?csrt=3D14818568393101165775
>  country MA: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (20), AUTO-BW
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW

Note: this range requires TPC, so it should be removed.


ChenYu

> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
>  # MC as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 8=
93)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 4=
40)
> --
> 2.25.1
>

