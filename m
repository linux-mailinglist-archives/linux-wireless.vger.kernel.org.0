Return-Path: <linux-wireless+bounces-25233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B05B00ED4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070E31CA7725
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D72BE05F;
	Thu, 10 Jul 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bon5ixg6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B392C15B4;
	Thu, 10 Jul 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187244; cv=none; b=WE4V6R4a2UWvlxS+HKk9ujcv+tV6XFpJZymXKoODTsnSKB9cPDCtMAXmBJcmHuCKQeXMQshF9fFIcE8UP43MxaFAO5DIvhcELTuKxbYCLRoGiSmJosD+FCf+wuoDyYT+rrii2gL/KJsivJyHfb/ei4bKST6Z7MvexAPUAu/hVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187244; c=relaxed/simple;
	bh=cIe1qk8PCGjwjKUd9+5zO4gFU4yuU+qvc/NnFG3HtSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPbmJL/NB+KXl9iyPlkpXsWbt7mMr55cdh9wYjT09tYVhSvcCFzc1v6zWR5ZE8IzcMXrwvZ01fPYY+7LcrpfYKhiV9pHHYN8YdDepmcYXoWriuWI6TDqvxdKxe8rNbUD4eLyEiDRYL2feUjy7eRWRQ/QdVUhRlQvocHLkBfV5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bon5ixg6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81a7d90835so1269535276.1;
        Thu, 10 Jul 2025 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752187241; x=1752792041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjEHzcojVOquMjpcLqm6cVK36uSQ8Eu5COVGkmUWzN4=;
        b=bon5ixg61Ih96qM5uVDzZVg2CsQQjvYAfqFSZfkUONKRWVW7n9U3O+TC5S5TpY6hZO
         8R5sWDzMsHSmCRSblS+VYZCCAcPsHyWfjYzbsCIj9DCNa7SMYVDQlxMFjtZMLHsZt4Po
         djyHo6vl50g2J+dktW6DCld4lJBvbv2+5Oq8nURR89ZEgH6DfxGoFplE0SKSHJiIagzk
         mGxSyl+aKD3XFU789raD3rvqippyctjU4zUT7UFjIKYChDLeUBEme/74zM64awlqe1XF
         BJ3ULO2nt2r0lAcbjpZ/Oj9qqTGejV4REW4UOyam3al6mmZ1l8XNWunG4tSAiuw253Vh
         WCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187241; x=1752792041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjEHzcojVOquMjpcLqm6cVK36uSQ8Eu5COVGkmUWzN4=;
        b=KsfFtktB2bEtT4oEf0HvRnXd86Elya3dhmFIZAXob856ANt7Y3y27k5Z0875q6jmbm
         lumpmKVMdKuCseVnH4jwYbcHdv5qF0hcRHR8EpeC6a2qe9d4oiMdpMXtz9KsyzwkuB2D
         mPmbLG2eJnl2dvaNs3c+y4BPMhjH1Qo9Qgei/thb7ydHZPOauPweCcybAnoZ0OaOeBFN
         3kbYXEOG6ck7ULI2T67zozwbIW6cvsySt4LosXOGHVlSTfmDLhrwex0LivznEGezs7XK
         oZOX0nSkW9/YJEI0hYh5brNCtjRXnUbYL6LvuCX3H0l7dg1fZAPg3g4szD+61pJ7cLKZ
         ATqg==
X-Forwarded-Encrypted: i=1; AJvYcCV/63yMqnri/pe9gcWkUXrXJkEKF2E9Th9I6yxKYetgRGTuEc4T933+QbR+pO3l57/lLK1hMS0EO4mKzA==@vger.kernel.org, AJvYcCVL7yZ1CkO/1DQKR8GEfbpY2JUScqqrGljy+0axJfgH8CC5HRc4vnWGamHFdN/ARbGwuuJLccRK8Ine@vger.kernel.org, AJvYcCWLInyjfgkG3hmCucUzXEQReuWXLUTgrryGdE7JPcQpFpJ4KVDh9+BG41Oi+d9CnlQ7fqecOf2spdqGpmfD@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmGgPouje9jvPLdKzUp0yHg5koa4jcLFU9QMRXS0MSlJ0EpDk
	+Stx/sTJ8Kw0TRLV//uhNid61z9oRiuuSjHv1hP4p+Z65TlowWmPDwVsoT1nr8EaewBa8k2xpcD
	mIcbtRHkt2lZ6b93mdSA+LYbeugMX4zcD9yYc
X-Gm-Gg: ASbGncumF6tlBDFlAwyfxobvhAj1ROseKJ9/Ea4HQPwTSYuYf4SzsNDM5t3MNCfVXd4
	ofcA/dQdY7dLZh/GJ5zAp3T/9U8QKnY/JLTYq6kF6WCCXA1cPh+b/c6345yqnNzvPo59sHA/Nmv
	Nw1Sh/wM8pPF5BtPWoWaYKnfvnZS6S1QFuIDmTMGxcuIF7LPDJrX1VwQociHL+yMeGzd04VIP82
	GRGAdHpyEP/FQgoEZbb
X-Google-Smtp-Source: AGHT+IEcq/nuQELJt2SqXJKHpdDPbGMsj7TkPRuHpdotlpq8FmL8miL36Xx2WEXiLy0vPD9zntYMqNZ5ly1AAjSx8HI=
X-Received: by 2002:a05:690c:3805:b0:70d:f3bb:a731 with SMTP id
 00721157ae682-717d78bfc7dmr16423417b3.9.1752187241474; Thu, 10 Jul 2025
 15:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710200820.262295-1-rosenp@gmail.com> <20250710200820.262295-8-rosenp@gmail.com>
 <d8b0abb2-1a12-42bf-aafd-4cd1e21babd6@kernel.org>
In-Reply-To: <d8b0abb2-1a12-42bf-aafd-4cd1e21babd6@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 10 Jul 2025 15:40:30 -0700
X-Gm-Features: Ac12FXwR-CsOo2JS8-K-DTfqed89LUEmhHHewOheVSMf_oSCLFqU7Yfw7qzFLM8
Message-ID: <CAKxU2N-c2tHBYWBM+FJGqdSaqzw9u0O8e0G7AVqk6b0QdRnPTw@mail.gmail.com>
Subject: Re: [PATCHv3 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:40=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/07/2025 22:08, Rosen Penev wrote:
> > Add device-tree bindings for the RT2800 SOC wifi device found in older
> > Ralink/Mediatek devices.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/ralink,rt2800.yaml  | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/rali=
nk,rt2800.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt28=
00.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
> > new file mode 100644
> > index 000000000000..8c13b25bd8b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
>
> Filename should match compatible. You were already changing something
> here...
hrm? that makes no sense. Various drivers have multiple compatible lines.
>
> Best regards,
> Krzysztof

