Return-Path: <linux-wireless+bounces-5413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435588F1A7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 23:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B360029540A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E560F152513;
	Wed, 27 Mar 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SKjXdEBS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453D150982
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577529; cv=none; b=dVkNaTs5uRwffML3N6Jhyj82+TV1BCSmaZZa/ITwbYo2y7Nr2s7GyQBEG9mbBZEY3qNk3zHkLudHyyoU35OGv/8vioahalCK05AWt85RXIlXvBoXODEIxJjM10gnBkqRmYSTyf+q1opQiGT21YDCYRQ7JuP7hRjXbyARMqAwRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577529; c=relaxed/simple;
	bh=QZLP7u+caeUR3iJITDUAX8zGdORC5PfaD4ZzdtS38QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/cE3HwJbS9XXXtXLF5Up8lmg9m5wNVheJta9PY93onnrv82xFSn1+rF2Kg7q6WTmGnjfbGsvE5vGNjOnvYMbPjn7urN9+IPwbjVwd9SUT5fi30QQo5CzGVCLvtk0AXpiFAfGzWQi5xtqOvy0wYs1XlbdPiqGSQxxzXAZXWHrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SKjXdEBS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0f3052145so3458685ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711577528; x=1712182328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZLP7u+caeUR3iJITDUAX8zGdORC5PfaD4ZzdtS38QA=;
        b=SKjXdEBSyfO3Yx+b4SyqTVMojyPyQdwFdIIMDUBnJ3FXucUB8YftVWlfpGxEKarCgT
         Ilx139v9CYMoU/yBngvA2kZIZ6e3y/TdJyVny/YIl9nUydbYjnHwiQ4XlQ9H2xmG2T/9
         P8MlhNeILpD05dJ2rJ6qgbU96cCexA+KzPIX3nN4n3KEYbzr07fbzBQHiuTZEKESj8s7
         bm2U19kAiqnTSOgW5AH/hZrB4qLKp5O0WbOZN0lo3pbtiw5DwWiEmQ/dTd8r6c8dPA2u
         IwnbwImpLKztLsLfF8ykASL4YnFY4kh5ujSZ7z6p1uRHh1dd2yDfnksVgDBPLlZW83Ig
         /ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577528; x=1712182328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZLP7u+caeUR3iJITDUAX8zGdORC5PfaD4ZzdtS38QA=;
        b=le1uHQrcFf/kttW8ef4Ujksy+Oyt1C65XdqSmMjEA1eNMKPyraCEp4xh08h932AH9R
         TcAjU5h1gPEbOUWbJvkWSXdTQ4IJWi8YxYd4URNf3i/9LPU1HYMNaWvnlkBU+UTJmuZj
         07i7HnVWJbGH9woGegoEp3fk6S8DT/FmaPUK0VHarkVe0XqCNc5thRReGEAlzM6QlMQo
         57hnjK619XucVOoyCnlvVg90CM7+4u5m1E45C+uivIeETjbPKSMA01VgG9WYbZu3+NuU
         ROEpKNh7IQa1nDqYrmXRB+v+KE2lmQIELrHuvcrg8PZ6Y0qmbyfeZ9vOvGGzsoqZs44u
         rlLQ==
X-Gm-Message-State: AOJu0YzFtsckNWkOh81wT+jQdXVp2pTwNKACvmtHyqMk7QWRVRspK3qF
	xfzxcYiHomCw0+P6vcdjp4CB4GAZ39EZOsAhi+JQfmxr4KCK6MMMOoU+fQepbXWtc07WejNMUKt
	fufCD8TnnTt8TavF8rLVFS4drYC8=
X-Google-Smtp-Source: AGHT+IGK2OsOXalVbOR0m5FxO6BnO7KPJe+LpyBAo4Wsnu/RRXH1iUaD6JvPs2KbuKnyWdaqNQCYQIMED4wYO3b5p/E=
X-Received: by 2002:a17:903:2286:b0:1e1:ffa9:b849 with SMTP id
 b6-20020a170903228600b001e1ffa9b849mr1129266plh.66.1711577527751; Wed, 27 Mar
 2024 15:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327004155.7172-1-pkshih@realtek.com>
In-Reply-To: <20240327004155.7172-1-pkshih@realtek.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 27 Mar 2024 23:11:56 +0100
Message-ID: <CAFBinCB5SiP3r-iK3ENUSxsdzaKQ+ZEjAcY0Mn7di54rABRewA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: rtw88: station mode only for SDIO chips
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:43=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Since only station mode has been tested on SDIO chips, only keep it suppo=
rt
> for SDIO chips to reflect correct supported features.
>
> Link: https://lore.kernel.org/linux-wireless/87wmpu1do6.fsf@kernel.org/T/=
#t
> Link: https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649=
bfa24225@lexina.in/
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

