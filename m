Return-Path: <linux-wireless+bounces-16017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9539E8B21
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4223A1636E0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D71C1F31;
	Mon,  9 Dec 2024 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMlMB6zX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F11C1F22
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723023; cv=none; b=K7JPUszjyRSJ7p1UyFN53h8fgvmDXn7rL0kRr0IvvVCCwmf68z/DkroT1UKfwXoFeqbfIB+7+GGmDPShmgoiugifiZV9Oa4my2uy/O/MLwcDTvS2L6Tp3al/CJjeQRiVI20RV/FieTc3bT4pjFGgBXtKZmojYUAOdzdMiKUxoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723023; c=relaxed/simple;
	bh=2XGS5XE2xWUUOq2FbFiSDqlbztXyN40EGyjjOW3tvcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6XB0CluXJ3CR7+KQ19mrdnY+8d0bdZKWhFI8H1MInJVCLUorGW4l4rKt0Dlyi/9cdio7nvt0TvG3DJjDZ/WCLatddx0hDGWZMNXL4fmUC/iQ4i9cH5mFQd7WTEyCTMd5iX3PAbYE3sgvQ17wsDO+f2zE23bi0F9h3ghrE5WcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMlMB6zX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa67af4dc60so133056566b.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Dec 2024 21:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733723020; x=1734327820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvxE9KWeFX/OQsOjGIozVp+veKIzqMmU1Jx+cc8a3is=;
        b=kMlMB6zXnCSRW11XxudyjTvqngpTQBgL5unlvBSnSw+EjWA0EDQPXWAUc6/5IU8XbR
         D6kIuiezLEopksvmuzTNGcMG11r/H2fV0M2XP5JMkFMqFbUg6U+4dwRse8HBrVQcJcR8
         S/5WE5Uw7vCc46i+q/ZLPa0tu3tDrloD5ISeqMtyuNCLtU7FgCUu4vdw2vHhDbZQ+15F
         uowkiXLrd+2gYSN0vfXXu3KIbvDt4vfbonwZI7EoNW/wBT8TRHuOnbSUAnHabjnONavz
         70oa1pW1Ld3Kei2RDeBKrSS32sqtayzR2oEFMfAHx+h4dNITnBAAsPkPqANs4oeeK66V
         uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733723020; x=1734327820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvxE9KWeFX/OQsOjGIozVp+veKIzqMmU1Jx+cc8a3is=;
        b=gB41dbkn5SlCgzqm03iOWbn6AT7Wememh3YeMxhIgF15Tr6awjDteK7HRbLrGXeNNJ
         5HSavZpxprLIReD3GAcCAtEBSZS15X32sV9GxrlJbSBsDsdh9MOuCgX7mze2Ssj9but0
         8EI1gIz2SeG6G4N7Ew8wvHKgsxYkNVjIpMaGGX+qaoNgZzH7aWgWNLxF8pO00dM1rbub
         SoA0E8hn/+EErH76StOlqmiJp50WZAeiz9T6Gy02oNnQgeMInQ/jbUjrWqAYxpeBrz3r
         DUBHhR/FEx723OKFBLJEe5lbm0TydCDqwB4MeVakfuft+SbdAXyNhUq5hkfdl5mARxZ5
         +McQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvCy5Dl8e102KbZ44velREcW5ktVtU2msVMFdRHlhOR8BH2PMQCyhqV9JV+QLpBx5J3gC1VWRbwM3m9Y3yBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQZDJKdUbkBC4WLR7VzA7EJl3YKL9lwH728eC2e+5ZLBHdW4R
	RGqPGxcpysms+0SLoV7D3kj2NyuWhj3vJ+aPqWqeOANifkYFjC1HMufRJtCsK5gC1rO8awYCAOY
	MEQKFKryt6O2kFEuUz/ZhkbW/7Qc=
X-Gm-Gg: ASbGncsUVvRKf7WY/tss0XCSnlQbFU8QljNrfMSj6Y0WxXFQ3KaoaRLfiK7idQYCFqV
	nT7bioRZD7aOXetmhkqsATXt7l2z730o=
X-Google-Smtp-Source: AGHT+IGGePJo+9N4Of4PeXOzooY+Gs9piE89hotQoUrmoId59x6OpJsYaqkpE1HlgA0Tb6qsnt0CfpTgn3festfQL9Y=
X-Received: by 2002:a17:906:3090:b0:aa6:800a:1292 with SMTP id
 a640c23a62f3a-aa6800a1c31mr295375066b.25.1733723019879; Sun, 08 Dec 2024
 21:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021071506.24320-1-pkshih@gmail.com> <CAGb2v64FojDNF+9fhdE5LhMJRYr0Tk9s+uPkVYD=pYsdHLggrA@mail.gmail.com>
In-Reply-To: <CAGb2v64FojDNF+9fhdE5LhMJRYr0Tk9s+uPkVYD=pYsdHLggrA@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 9 Dec 2024 13:43:28 +0800
Message-ID: <CAHrRpu=q-AQyp15iqDyB=6hcPL289BgpQnDRNNDoOEz6FrAFzg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Oman (OM)
To: wens@kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote=EF=BC=9A

> > +       (5490 - 5725 @ 160), (27), DFS
>              ^
>            typo? It says 5470 above.
>
> I can fix it when applying.
>

Sorry for the typo.
Please fix it. Thanks.

