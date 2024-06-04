Return-Path: <linux-wireless+bounces-8493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5948FBB83
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9A91F23CA1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8405014A627;
	Tue,  4 Jun 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WmsmXUcH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B714A4D8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525490; cv=none; b=NbxD4498ZSAXegZI0YbghkNhYkUJA+CxmVDCpzZivrkp7ABnjH/uewc1HGXS6m0Mj0nThEDEY2iBB72YfzT9fHRdJ7YM0Sg0FTUm1VCDrldjZ7n47gfHok9tsuSEcDUq9eXBWVVMnZ5wBmT7O9BH2V1gCSH9ZWxFrp3WMAX4cwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525490; c=relaxed/simple;
	bh=o2SN5zEWYP5ck8C2MkkWKldDCJyUDO8w99vyJIIHKlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRStTX+PfZa3mSkVJXyXt9B1vtAuhMStULoZWcmVLGwbzwV849Fbci1kocKEL8xbJpfe7qVFRHPjoG0Skj8Ll0zp/qfKWKhsBaqmeYMYoX2eCTaQj0ZBHhPDxLdiwwmdq1PlPi24la+Xq/ySpRwKQqxdmAxBiHV1pqpq/r+XVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WmsmXUcH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eabd22d441so17351081fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717525486; x=1718130286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YajuiVABIxMlw/Xt1HbUpyxnW+sg47NgMW4NcK3Sjcc=;
        b=WmsmXUcHpBY+mALTdJ+Li6kKYWllXT/etQ0BwojCnZrBvhDYxohTOKOWp5g7AL39Vk
         ZxykjZsTM2gEN9hXi7oITjphGkNyc4BZ3cNJlZPZHdD+uChc3+6P55pTvPZaucLjHqWj
         Ozv+h/Sr7tgMtRBbWVBWo7omFsF4W9U1W6hvYS3r+qAwncxuBOWU8KzmL7TpZeat0yb4
         NtJGTlxg2OVH1C9rMCdvjGR3a1O8+uTh8htbw5uUTJiA74jCJ34unQSF9nzGTnfCRo1Q
         pRfrilZ2P8nwZp14Q4fLc6byXVelLqiS0K3n7Ah04zeqkY7gBDUecUQOXrXl1A3/BeH8
         34XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717525486; x=1718130286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YajuiVABIxMlw/Xt1HbUpyxnW+sg47NgMW4NcK3Sjcc=;
        b=kBhejQkTZnc2Dz2MpsMjC3iDk3G7/1gfmfh/mo3wlesOGokorMUIwI2KD5V5XHYQqs
         /C9w2GR3pS0YSJTSniaNfMDCRGLgwb+nN1lG+bGVjFwHoo2oatSP08oAERp4mISVaAv8
         LOQ7EgJG4VocF2RPJqA2Tra1Y+r/9E1PCiwXZrqDQJsqWI8l8kxElT7kQGhawFXSS+Vs
         kjHpl0F4LHsS7cW5CcEjzB66dj1q+zsRiQRU7v4RBPZbQbeKqNRLgDAmmRLooQdXwi23
         pg8VDWC1uyT0b0AI/QWfGHy48gmZP5UnsxlzHW/yCzkJi15rgiZDvpu8UrgVAJlB8qtJ
         W8EA==
X-Forwarded-Encrypted: i=1; AJvYcCVw1GjtH7CVwc5t0g1ez38rJDVYfSTAfqBQ2ZiVyGos641e935U8MmvVLos+KhKppQzEHjHokfLeCzPRwRkbIvYYRhN3hM/WY7i1dBNwWw=
X-Gm-Message-State: AOJu0Yx2UpaLDw77g3upW9k3cAf+XGanL9iIuBI1PJQFmd3sUtqOrf6P
	6UGx7h75eTQ3frUmCHvCYdwu/nXs3CS6ebVvmaakxDGeBfZkWsyksQz4m7n9iKVFa+OQ6QiIWZZ
	8I9oSOjhRdOwZfU+zN9lwPWsWjw5ElxXtFdPJ+w==
X-Google-Smtp-Source: AGHT+IGLi1e1brdH2UNouYUbAUzN69aAALtAIZxoqynkaIYefJpLBuEQv8MM/AiBkSUTcEg9+r81ijCuWPOmcLI+5Ls=
X-Received: by 2002:a2e:93c7:0:b0:2ea:8f93:a49e with SMTP id
 38308e7fff4ca-2eac7a68282mr575891fa.36.1717525485967; Tue, 04 Jun 2024
 11:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org> <20240604171950.GA731649@bhelgaas>
In-Reply-To: <20240604171950.GA731649@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Jun 2024 20:24:34 +0200
Message-ID: <CAMRc=Mf9SDwo+RzEF8d=2Si3-KQVT_Xf8ew4k6+FQAyvOS+EvQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] power: sequencing: implement the subsystem and
 add first users
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 28, 2024 at 09:03:08PM +0200, Bartosz Golaszewski wrote:
> > Note: I am resending this series in its entirety once more for
> > discussions and reviews. If there won't be any major objections, I'll
> > then start sending individual bits and pieces to appropriate trees.
> >
> > Merging strategy: The DT binding and DTS changes are a no-brainer, they
> > can go through the wireless, regulator and arm-msm trees separately. Th=
e
> > bluetooth and PCI changes have a build-time dependency on the power
> > sequencing code. The bluetooth changes also have a run-time dependency =
on
> > the PCI pwrctl part. In order to get it into next I plan to pick up the
> > power sequencing code into my own tree and maintain it. I can then
> > provide an immutable tag for the BT and PCI trees to pull. I wouldn't
> > stress about the BT runtime dependency as it will be fixed once all
> > changes are in next.
> > ...
>
> > ---
> > base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
> > change-id: 20240527-pwrseq-76fc025248a2
>
> What does this apply to?  I don't know what 6dc544b66971 is; it
> doesn't seem to be in upstream or linux-next.

It's next-20240528 but it also applies to today's next without
conflicts. What do you want me to base the PCI part when resending?

Bart

