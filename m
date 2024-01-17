Return-Path: <linux-wireless+bounces-2124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D0F830D9C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 21:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B531F26371
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47424B26;
	Wed, 17 Jan 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UxZSzNfP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0B24A11
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521718; cv=none; b=B7twgwliZ90ufPm9Zge6rxI0O+ApH+zTOcz5uNrwvfXQPM/Ti9DovZSMzmi98JpkAa6cITbahLyZ8RBpRJCLT5qYI9QRbk3thzvkru4CdYQMlXnqP22/xOT34y+ulWomSx1xB/Aw4rEGqZ8KvG3T5vtykGgwKhU4WEyhBW9OWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521718; c=relaxed/simple;
	bh=vTo2KZuIPEY9HMcSjVayb7+G1JYqPCb3WEDckwgFGKs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=OtA30c20KD6uxgWyWo0jhUKCXRZHWJXnxpmh6uo5W2tzvEgXMOmnqo/XaXruGbdHryXx+U+DY1cfNVcn8ANMjMUjzlLPSHZmNlXrZIRPKXBJTxYMDHssfR72dKr+TGYSnxRe/HVAcGc1r4OtgpSakK+KrD6l4midlxmDd5XfaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UxZSzNfP; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4696d3423aeso797892137.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705521714; x=1706126514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTo2KZuIPEY9HMcSjVayb7+G1JYqPCb3WEDckwgFGKs=;
        b=UxZSzNfP+EBIWSY918mgqkNo1zjSq7pYToHvTEaNidqEGE6NUHPoxIFlbbQCxH02TT
         Z4sHm44MDw/xpYwYWh7rKA3mDJsnvC0gMvj4/8wBCcZBhQ0XrN5U5EZIWOKfCwqSet1o
         QYCz5T+8ZlgORCpOZAO7a4xxQ7uwjF+UpsaqpJGIymlF1vcQmsa9zYG4pmqBetHTz46e
         Tej7zJZ3o/zy9XUn7zluF4IdMZq1pe3sXCB02w7jjt5kZVX984bTTII6KhwvSILdxv1K
         uR1Ku5OtW8Nb1Ty7W5ojf5sYhr4jv6pnyqp9v8XqsQm0dv3hLjTJJJltZIGItjrlfhsd
         oI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521714; x=1706126514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTo2KZuIPEY9HMcSjVayb7+G1JYqPCb3WEDckwgFGKs=;
        b=mg9pgAS9+U0mxZ3xbMFUzVQKBbcAZ82bAQ9/IBgWtC3ub2hDpBEi2I1XHQliKFSTtg
         vbw4HbzVgm/0frI8Cek8xN3g0VfiT3hTQJKiLbeauBOa/9LGZ1ULAYpOOoo+5rc1OaSA
         RXZPjSRcsCEBAJBEW46JaC/ZJmndTIbOYJCl9gNAJNgusGZRA4YfEzbHOXlirhzDeqm6
         g6x+MmBg8vA198SQnDoZZSMVZP/9kMTTYnAjmQYEsV63MhivjNjDrjAeWxTdvfaWsYXd
         9h+4CsrevEQ0s7s2gU4Huby3LcdoqPvM2MqNSz2eqq4ewArSBBy5SER19NxZ+IrpG2r3
         xqdg==
X-Gm-Message-State: AOJu0YwjJTH9ePbtU95u//PLEy2f99dvNudCQB1tqNxhNOuphUMW6ijM
	Zmy07FapEC+vRwWph4fwWwYN7k+1c4LI+m9FWObLtgCHGgmilQ==
X-Google-Smtp-Source: AGHT+IEtHWFV6K9Sjs8IxH5+/DRSiGMc44HlzIi9bntn43ynF7/2rESLT5bmQ74VLsAw71rE1s5TYn5pF1FCsNlt6Eo=
X-Received: by 2002:a67:fe4f:0:b0:469:6354:c82c with SMTP id
 m15-20020a67fe4f000000b004696354c82cmr3051575vsr.35.1705521714725; Wed, 17
 Jan 2024 12:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <20240117160748.37682-9-brgl@bgdev.pl>
 <87v87r4yvs.fsf@kernel.org>
In-Reply-To: <87v87r4yvs.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Jan 2024 21:01:43 +0100
Message-ID: <CAMRc=MchrHfC7LTxp0dCtX5AB1TwxTp7Z+tybAtEy1+wLBTJsA@mail.gmail.com>
Subject: Re: [PATCH 8/9] dt-bindings: wireless: ath11k: describe WCN7850
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:07=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the ath11k variant present on the WCN7850 module.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> ath12k supports WCN7850 (a Wi-Fi 7 chipset), not ath11k.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

Eek! Indeed. So most of the ifs in the bindings are not really needed
after all... which is good actually.

Bart

