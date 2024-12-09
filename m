Return-Path: <linux-wireless+bounces-16033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029CF9E91EC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069B2162A3A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD762185A3;
	Mon,  9 Dec 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlsGc7xp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B39218581;
	Mon,  9 Dec 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742890; cv=none; b=R3y2ALvjma5WJZXbndpBtzlnb2T4X//06fEaUOAVCIlAG8xGR46txXLcWaLp3RxHoTQBMaLTIcvxa+EMhtOPk4U7XYpaWhJYOMSwmukQosiG4HvVwJnN5ND50zfSgte7Q4PW51EYGbF1ufcingWaVulo9B3U2T6Y0w+B0t/2VUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742890; c=relaxed/simple;
	bh=PGOh4xzLiyvh6vHDCj+jzXPBkC0tCU+wNRTaPJafHzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VhpNyafPF3xl6Exvm7rBZnJJGJK62kynVp0KYVQeFwRXpDRHNDoTMW+u3IjXu17eA0YLjYXo8u8VCuqOTEzHsGXnitjMJ4AICOW/TCzTtqpiFyxfV5AomliZktOIKhotRLnwjCY41ybBt+XWVAGyVTC5GfwJByJB6QPllmOmHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlsGc7xp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003943288bso25295081fa.0;
        Mon, 09 Dec 2024 03:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742887; x=1734347687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGOh4xzLiyvh6vHDCj+jzXPBkC0tCU+wNRTaPJafHzI=;
        b=DlsGc7xpcgnwN6DxLtpz2zMhb20tnnXKzG+J92rJcc7lYWfCCTVyUGvt3CoDzleBAP
         tgVO7n4P1nAoMbFXouM8IuxdL8ttSnFoVj4h/SR9ViAHhsT6y+jC2uZlOa58+20xs4HD
         ejaj+2iVuoeLoaicfXJP29ZqnBO2wn3BQ/H2ma4cgER8ym6PDdOrXgaYOSMawGdGrwQW
         FCu72RI/7UWWLUthyjPeML9J9G//uxiuuF6pC002HPNS/M64qJXhZniYifCD1PdB1/ma
         03fqF9LmGHuEihquLd9Xe5P2PTdElxr2r8hz5rl9tta4uHYdTh46D64cUdAoOD24k43W
         tJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742887; x=1734347687;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGOh4xzLiyvh6vHDCj+jzXPBkC0tCU+wNRTaPJafHzI=;
        b=ThpXfqcYkAUm/mV4lnaoKxUPYyyCz3I+2qZhMtSNn+qntEM4RHb1B3GW4e+1Ed3eNX
         EEWw5pFpB/Hc9nEsF2E5bWSlQsWp2L15nPAP0P3ECwaUwFmWztC2XZtzQB4s6zUuafkO
         rf069UA1R9tpDClaWZfOqLC6LjvC5uFVF9v1TRyTtKOpqfwxuTeutaE7JO+Q/UVJKFzK
         rUzUqVa46Tf+of2IKMO92mbY1s2GXich17vXO4WdpzZQ5h1iK1/CeMAPaOW9OxaPW78C
         Om1QLFoEGCaJYC7YLUQvhLMzJZBWYlkbUBtKv86SKqHFU1kxuhjZ/mTtiHI5qODFf2je
         Gx0g==
X-Forwarded-Encrypted: i=1; AJvYcCUZdlGuDFWEW31awejuFeOOTt2BtQnALgln3VDSdJrKjAtosE2WSkzFtmzYKMFlsu436YRHfrMA7GJkLZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2P/hGUr+w9/kZYjN3NwE+TyfGbN3+YJO8atr/5hvq8FfBxzq
	iG5kzM8zrFxN55tYzBsXPRf4nMaVCZ/4VtFiCiyBS+PN0300EldvcquARQ==
X-Gm-Gg: ASbGncs+sTepmbtLGSeuE/jh/HSvl4zGnXya6MK+j1y2XVoV73QUf7enX1cnUYZXs6H
	0hjEPunpiJSVJd2pDAYWL8eDy7Od18hjnyUAF/mMJJJaksZx4DMhHxUujJbNkxT2d4IT4FmlVXr
	iraYADtWXpYcJykKdY3l8IBc6q/TEdQ23ACGUD9/KNhpntcBVmzfsLTXUdddcivmOCJtLXhJCOn
	/DBzytOraLNXx02O2j9YSDV70mM7xUvsgEbnkdels0ezWgoXNtgo3jlxRXG7wZV
X-Google-Smtp-Source: AGHT+IE8FdvLWR8yOPGxthF7hUOJOzsaYqOm4faQrVUBS1PbIsgYRicXu70HS/CEF5ApJxkpvHL6hQ==
X-Received: by 2002:a2e:bea5:0:b0:300:1f2d:97a with SMTP id 38308e7fff4ca-3002f913f79mr42114051fa.16.1733742886588;
        Mon, 09 Dec 2024 03:14:46 -0800 (PST)
Received: from foxbook (adtp43.neoplus.adsl.tpnet.pl. [79.185.227.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30221998b4esm3307801fa.110.2024.12.09.03.14.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Dec 2024 03:14:45 -0800 (PST)
Date: Mon, 9 Dec 2024 12:14:41 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rtw88: missing device IDs in v6.13
Message-ID: <20241209121441.304a9e8b@foxbook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

v6.13 gained support for several new RTL88xx variants, but most patches
with device IDs haven't made it to -rc1, so the drivers are unusable.

Would it be possible to forward these rtw-next commits for the next RC?

7b5ce65d9018 ("wifi: rtw88: 8821au: Add additional devices to the USB_DEVICE list")
1ee6ff9ae3c1 ("wifi: rtw88: 8812au: Add more device IDs")
d4c4903508f9 ("wifi: rtw88: Add additional USB IDs for RTL8812BU")

Thanks,
Michal

