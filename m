Return-Path: <linux-wireless+bounces-25450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1DB0549E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7450618913A1
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0BB271A9D;
	Tue, 15 Jul 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQpJQdZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E425CC64;
	Tue, 15 Jul 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567589; cv=none; b=k2JaOw8m9iyBECbH3qFvyka/ze7by7ZV6k+74d1UCQpz7+65m2jsY4K6tr3/TS9NNZJnhoKep3WmISgMhg5CZRmsmj8E1vmHplEQyQY5RW5Pw38JruBEDbwa3d+VaI/CreGm2GWWnZztMP/8c3Zge3s1A3U1mwsUhym+m1llE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567589; c=relaxed/simple;
	bh=i+Cmub0UhfsbSvX2WeZeJNXshxEeR0Ut06hjAGnLJQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzLYWJtRfhdfO0w44C2ddtZORYSkziibkugELMRRotPEpFxyldA3RV5fG17m5tp+5TggOAxl8OTUB4ndi2hWA6KxOYU9FNaz9GY/CqLzgbj+fCiZM4sozWwcNhxvnqAu4MS3vxrGAWkvWrzdyEVxuH7I8vJ+m3W7TWN+VgrEos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQpJQdZ9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31e076f714so4942084a12.0;
        Tue, 15 Jul 2025 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752567587; x=1753172387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd3Q7e8yxSyHuD7DdiU5ycutPk9NojNxmVh9qMkLmQ8=;
        b=VQpJQdZ9kYpLJLvnQzqd6nhMRahAmDWcEqf6s9X+JqctwfOwtdRJ+1ZNCMfAzlxNHj
         2t8rLKHu8SETtf2QGUhnCn1klXeFRUbpxhrJKYWpnILTOi6tnG8f0xj9XGUyyS36+24o
         vf1HFDRZlGychWQpE5F6oy2FGYpvyJUSIAahL9a0FIHOQwjCbcIHhsGk59WHzy6cRDN7
         GLDtifn13kVFBaHA+E3xVcEyQgp6R0whHy3JZm8N9z2Z+uN8xLUVs/PyG6sMRi++SfiY
         kzIAlT/4EaWOgWUkF74Rpw8fyQ8O4v9V9F9XWz7gMXjWQ4ImMPTGEpjB/jAFbdbI7jT7
         fLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567587; x=1753172387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd3Q7e8yxSyHuD7DdiU5ycutPk9NojNxmVh9qMkLmQ8=;
        b=TWiTQ/TLHEy7vzEzKV/yy3uK14na+nJ6mAHpnzxD+i9JclTb4x6ctZyVFujOMs8At2
         Ph3zqe6hLp3Q6UGNgLNxrWz66QgxGYMJskkDNBRN+5600OHnINH6v7G519ijKpvbxQvP
         Y/+RdG2bQXb8XxrARNnAg09qPbgUuFdi/Uz6U9E4iR8IfolzjrK6Az0IJbKU5AvB4b+2
         2wXcP2q60TwpDA8WVHG7rbsOJHPzhphlwmDgNS25zhRqwAQ5x7ZKleDMYXVqKkfu7qdO
         ILuEKTC4IgQwCRns804qAxpD9m003GbjgXnn8VdSIgqnR8iE5bZMAZqELHiHlZnbQLGj
         l2ag==
X-Forwarded-Encrypted: i=1; AJvYcCU8XoHIMyhoB+/v9Qocm+5IuaudfKwlFpZ4mVH8uY0SBfslrEUyZUqujH66jCxFP6lj7gCYTgvDsSZKL5GW@vger.kernel.org, AJvYcCVct1ZHbBR0XD2Z+hICKER8z+45ZGuV0PsDDhahRAARJbGfL3k3k8TRsjTGYjI0hEnZowlqzBH0KkTq@vger.kernel.org, AJvYcCXZrS+5CDuBRKnlI0BaeVTg4d0K+ue3NDSMtP9oVvmxXoLn1UTD2paLNdszFYoGo0Wcdp8MjwLQIG5v/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkGe3yQ+D6FRuMmbYL4JqavZgjV2CzqnXfIcs4AFZuC80AEwJ
	we2IHc+Jm1COEX9kqBJx0FvDyrZIFyieqC3gx1/jST6RERPYA6q6QrklOmxgRRq5Nzg87+V/U78
	NdInO/8SsTY7nqwmL3nw60m9UdU4NDDE=
X-Gm-Gg: ASbGncvCtRpTjw/HiSbMmM6k94W/adS93Hj/JqCOpMrW6ozrik8P+bxaWwptZ3/XPEe
	9WhXfpwDcxtEyS/hIHVNeIccPup+ya+rtsMKwU+wlAcNhs9ONgALiMxkpO7DSl+gGOT3QQPp+Kv
	DKHmWM75hggrqqUAp7WxOowN8xh1xZTi3RMuWjoC7RrjgXAq0RR++vtSY59S123Hul2/lWtXFDN
	1Ck
X-Google-Smtp-Source: AGHT+IGWXqaNFBkxVhxjoAh37jIlv8IOlz+RFpSYTmKmB9oiEiFNbWlyvsTEKG4zuAWGwP4uJ+VRZLGBGphF2VcEpBY=
X-Received: by 2002:a17:90b:17ca:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-31c8f9ba0f7mr4097681a91.11.1752567586749; Tue, 15 Jul 2025
 01:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712210448.429318-1-rosenp@gmail.com> <20250712210448.429318-2-rosenp@gmail.com>
In-Reply-To: <20250712210448.429318-2-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 15 Jul 2025 10:19:34 +0200
X-Gm-Features: Ac12FXxwU_5cXPbe6k9-QU1wlgWyLzCeGzXcdBi-Vlkd5rOu3WF_rrVJJ5NIIf4
Message-ID: <CAMhs-H9NuX6m0zOM+6ZcX5r0aq_oxbYkbpCTAB4sT6sea4=Osg@mail.gmail.com>
Subject: Re: [PATCHv4 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
To: Rosen Penev <rosenp@gmail.com>
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

On Sat, Jul 12, 2025 at 11:05=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> While this driver is for a specific arch, there is nothing preventing it
> from being compiled on other platforms.
>
> Allows the various bots to test compilation and complain if a patch is
> bad.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

