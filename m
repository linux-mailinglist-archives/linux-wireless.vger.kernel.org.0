Return-Path: <linux-wireless+bounces-21218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC53A7EF88
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C043B6D1B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDFE221D88;
	Mon,  7 Apr 2025 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T+1blWtA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CB1EF0A1;
	Mon,  7 Apr 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059894; cv=none; b=hZ5HtYYBMu0IKEQ1V/bG01BfxnDGnot1M6AYyac55BqNFRLhczDEEbG98+nXdiZTdkJ8RNrlDN16NGiq4f9K+kqNL4jaDf50TKjlextSdVQFnLAizLVy0WUWcX6YRiW96M99KearHvIFJzg5lNZMIeBY4XuiRDHqzzCsBkJkoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059894; c=relaxed/simple;
	bh=G5uP7XPUQhSzLLH8UfxXZM/eGXXHzeObBp2N9j2yJtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn/aGuD9SJSDVxPTzUEX5AMXJsYuzUZvUe2fH+Iii30z1PUYi1eFFjG8x33imbS0lOWARPMaZJD13ry948DLuyWds2mwEQfgCe+iTpMq7o0vZs7QSZYHKcowziMxYU3LO59No22q69fNbphz61fsh+7EgWh5B3Sl0mHEu5htJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=T+1blWtA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22435603572so45649345ad.1;
        Mon, 07 Apr 2025 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744059892; x=1744664692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjEuDsYSQYIFtKozQixkgJ48XkY++Le1XcPNNG/znKI=;
        b=T+1blWtA24hvKqapGKEKDfBgY20FnDlVz+Rn68gemLAvRIY48Sp+u3g7giBfyYmuL7
         9AssRSlq2+dBEcSmUHWpocMwp6ZfTMpAhtwlgjUwX9u8h+ZuA9ecR8vUSSajjvw/CnYN
         uVT4vWtDVl0ahKA1ew9R3eK+kYoKiB0zMBQPo3fTiGFhbpD+C5XroV2GzKu5GfPdAv1h
         YIrnRrkKmLa59eIfh7TAVi15TLVYfHej1Brkuy1LMIzJTzHxJXhabfwhuIGMFy9HUJeY
         xR4pca1EmrTtewtRhOKSNUOIMhLXe58TvOk5MhRgHe8KRdHYw7A6lJ3IfVNbRZjcvoqJ
         vAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744059892; x=1744664692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjEuDsYSQYIFtKozQixkgJ48XkY++Le1XcPNNG/znKI=;
        b=Sk5Bosk/f0Z/zimLJEbgfDOQ4DqUduYyDYLhx37X6nUSQA89gfWSh9VLQEunA53age
         WvNiwiMqIXjcCmd2Bf0Tqma70m+sQraWQP/fm1o58eujG6YpYc2w+FC8p0dbEgcuLX4M
         svaHTltO1PqgHMqpvsI0re4SqqI9v41pN7fxuHgY4+5G8cXX8frT4fZ4Tnv9UeAa6FvQ
         oa0wG/ouiUAr5IU8LMktVOeCNi9spG84dSw1ajkcDLCESgxrylaf0P1aVQN0HqqwyMW1
         0iJjCYKA7fYor/QSCdE9bybiMfbVvuwwRv+ZIM4KhPogaA76R6i1cUwsxWXDTGoq61cx
         495w==
X-Forwarded-Encrypted: i=1; AJvYcCVHD7tv/yNVuqUkA9iEu/3153Sbl6xfTCgpbkLVpqM5+UmhHj7+ClfOMXwDy7/3jb7ciCWq9zdiLsc2tMo=@vger.kernel.org, AJvYcCWhCfBzlM/X9DQZh5jOjSJ5llToDNQGhPNJdlhVvZa66fyFvlKatVWUTMBdmcb3rX8nRHQlHQiVC9KBmp46qu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfoK96UqBpoYw78/wJPp638oUUC2RPbzz1mlmGAwkDm7BVnEV
	yXZSgY8d6tWVSlYYfIc0qxqSogXYnaZWJ4hXtY7POMIN7GWPr3ZNwx4Enpf4wRFu6nCtkV2d9Jp
	4T8H7P0QVSlTPTw4uw9VoAxnVLfVcIyvp
X-Gm-Gg: ASbGncsiHOX/wu97OYB4LDs6uy9hkcJ3U/UiHROXF7zDlOrynrEJAAUm5PHOBbXJux+
	oDJ3CVHPDNuS52WjrjRMVga6F+aQuLAvUAR6EbuXPOt0CisSKTkQ/HrwoNQJ66wDtt8koi0lXjE
	6tiaZsvYV53TS32RSEB4pUJJIc96zq3JARhvVBkdZR+e3gGLL5Cg4nR9gPSoU=
X-Google-Smtp-Source: AGHT+IHH5RMcyXoke2jciSka6ApKKu5PaRcMFCyvwlM+9FhNJj7Gsbcz5Irffj5p7yNZ6rp1qnSYGHbGKPjzHlpkikg=
X-Received: by 2002:a17:902:ec8a:b0:224:3c9:19ae with SMTP id
 d9443c01a7336-22a8a8cedb3mr188635745ad.34.1744059891810; Mon, 07 Apr 2025
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402160310.996141-1-zhen.xin@nokia-sbell.com> <9d908c7c77684260818470225b8a0980@realtek.com>
In-Reply-To: <9d908c7c77684260818470225b8a0980@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 7 Apr 2025 23:04:40 +0200
X-Gm-Features: ATxdqUHdwlTYqa-87bWtMFU8vcYwUQsHhYog4COWy0x487fj0A6vMNEqROGKoBc
Message-ID: <CAFBinCD6fcTaJ3VE-0HBv=Vd_yhkqAgMH_8v9MVV1UMCO5m6vw@mail.gmail.com>
Subject: Re: [RFC -v1] wifi: rtw88: sdio: Tx status for management frames
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zhen XIN <zhen.xin@nokia-sbell.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ping-Ke,

On Mon, Apr 7, 2025 at 5:30=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Hi Martin,
>
> I replied original mail, because I think discussion would be clearer.
makes sense, thank you!

[...]
> > @@ -1195,7 +1195,7 @@ static void rtw_sdio_indicate_tx_status(struct rt=
w_dev *rtwdev,
> >         skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
> >
> >         /* enqueue to wait for tx report */
> > -       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
> > +       if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS && queue <=3D =
RTW_TX_QUEUE_VO) {
>
> Is this because you have seen "failed to get tx report"?
> Have you tried to increasing RTW_TX_PROBE_TIMEOUT?
>
> If it still can't get TX report, we might take this workaround with comme=
nts
> to mention why we need it. Or a local variable with proper naming to poin=
t out
> this, like
>
>         bool queue_has_no_tx_report =3D queue > RTW_TX_QUEUE_VO;
>
>
> By the way, USB behavior is very like to SDIO, but TX report seems to wor=
k well.
On my RTL8822CS I can confirm your thought:
I don't notice any extra "failed to get tx report" messages regardless
of whether I have "&& queue <=3D RTW_TX_QUEUE_VO" or not.


Best regards,
Martin

