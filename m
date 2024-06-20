Return-Path: <linux-wireless+bounces-9331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A169110A0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740A028D62E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC931BB6A0;
	Thu, 20 Jun 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij0v3GqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B62230F
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907211; cv=none; b=YVrr83CQgDpgZJvOjWydNNkKrobZlYxbgjF+HVSYWXZ+eXTxIfmSwTXFGIbReo0pSs7ytkv3pu0/FzDGRkuq9al0T9Rye7RLBJoSNFsVmNOM78AJvGq9RTLsgD8XOJ5O2v8N5rml3mMt4FH9LnQBL06eZajTKfs/dpCKGQXEM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907211; c=relaxed/simple;
	bh=6ZJdD4ybzNc76R9gwsq2nRbDqzcxIlzCgoJ4V134Vvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM6iO4Ut+ZAqx1hEwvjo0PeEkIe4VesFvDruTyARtIgQRhu7iA/ANGlGoFrGT6Je2arWRFgE8vWsOPAWxE1sNLWa7mMwrvYiTt8PRVS3g4//vAK5bUcgkJYBTweNq/xwMPeGxnL6TRW60cTvqlccvi51OrxgEZGEijmyIo09xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij0v3GqM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso1671087e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907208; x=1719512008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OtNp8JhheNWYpbOZ05YfvTkAASAMi2HGoejQ/QS4w=;
        b=Ij0v3GqMzq2mdAzNvFQhdr2msaXKbXM5HS3gQENcZYAQnaoUmRY44gNdBQ06wsOvg+
         QkuN3ss0EkxpDZBaX9ssUovr8egU8dJAGRTOBSkRQMI5BTKv3cfMeVVO22OLhaJLo77m
         0jQfjfynvwXbwkdItXbzWrysRPlUQYzdmDL1YTljC7P4n3SGXUCb4ltHuefXNBd+smM1
         BYjtbbQbx3bc1AiJkGm5s9ddH2651FThL6sbN6hTzvR6yBLW+qCAHK3rdYe2dU6gQz4x
         AjaKzex4F7KMeljRaKmuuEo7Q/RXJylxIDz7L1venu8RITkZBEUDfTPxQoO08K7b3hbW
         Ap1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907208; x=1719512008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6OtNp8JhheNWYpbOZ05YfvTkAASAMi2HGoejQ/QS4w=;
        b=Ipq/edAEBlgJtUmHGLd8GaSuoQXuk1I0iYzK1s0ZRi1pDVCRL+0eCbC/mEaXL8X5N8
         6dDJDiBSr8SA0OodwKvkAiK7lpYuMhLKhrNgY4ev8zLf5GCCmMO08424vw+tqcIoXVPk
         F9qkTq6KgZqQbel1OheMsXd7mLZp1IbRKDTDvRJY9QRZAHM9EUNoOrZg5SYXDk0ivGGY
         mGgY6nRjc5N2cSTL9RT3JBtv1Tisd2ducoztZxN5uxZWA0ghNilig+pfINR1uK96oaUB
         Hy9v9n/mpbImbWG5qf7NB0p+JmOTNoygrbrZUL1D8pfiPdw6SG+i+KK9Rnp2kaET+AE2
         0bOw==
X-Gm-Message-State: AOJu0Yy6w77c3kidOTnDrPWv6PuWShompR5PTmDMu1lR5J4IAUqqQJHc
	+FHa75MSegFbb8OeD3CuMYkAlSrXDJWGSYW2pnBaZ0swJTYhaWmEyAyleinv6gCYjsuNwwB9D2U
	bSTWgfhfcx30Xqu30b3aZBSDZOXRN5GOo
X-Google-Smtp-Source: AGHT+IG7gZBnyNaeJiw/sUD0vDY4+dbghelCwSVm35kNAgxYlvngXr4XN0A1XbZ9wNA3SoseChxQAgTWGKcSWoDkvyc=
X-Received: by 2002:a05:6512:76:b0:52c:84a7:f9d5 with SMTP id
 2adb3069b0e04-52ccaa5a0abmr3659313e87.69.1718907207402; Thu, 20 Jun 2024
 11:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFED-jnTOkH6BwUAUnTvr9SSqrwV-2fUCuwywwt+JOKQJx__ew@mail.gmail.com>
In-Reply-To: <CAFED-jnTOkH6BwUAUnTvr9SSqrwV-2fUCuwywwt+JOKQJx__ew@mail.gmail.com>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Thu, 20 Jun 2024 20:13:15 +0200
Message-ID: <CAFED-j=_DRXb6+dTGRaBGGtD_efrCw1BPC2CvLfZpRxoPVQB_g@mail.gmail.com>
Subject: Re: Intel BE200 - mld/mlo supplicant testing
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 20 cze 2024 o 20:10 Janusz Dziedzic <janusz.dziedzic@gmail.com>
napisa=C5=82(a):
>
> Hello,
>
> Just check:
>  -  6.10.0-rc4-next-20240619
>  - latest supplicant
>
> Seems supplicant report:
>
nl80211: EML Capability: 0x0 MLD Capability: 0x0
nl80211: EML Capability: 0x0 MLD Capability: 0x0


>
> WIPHY_FLAG_SUPPORTS_MLO
I see only hwsim set it today.

My iwl firmware:
loaded firmware version 90.38c93dbc.0 gl-c0-fm-c0-90.ucode op_mode iwlmvm

So, question here - how could I use Intel BE200 with MLO/MLD?
Do I need some test firmware/driver?
Or just set WIPHY_FLAG_SUPPORTS_MLO with FW I already have?

BR
Janusz


--=20
Janusz Dziedzic

