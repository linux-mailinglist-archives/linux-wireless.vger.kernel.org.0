Return-Path: <linux-wireless+bounces-7895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D98E8CAB62
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B1B1C214C3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD775E099;
	Tue, 21 May 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBwG+Be9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19485473D
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285701; cv=none; b=p8ZOoX33DDtOcm8fG4mviIgwVo6tUPey+7xiEro2/JZRfu3QwB9YQuPPLWJ+Cg8FBj91chTepnRtiJoWgJowJIh9LEps6zP/tOnrQPIsKHM/OdCQUUn/1cF888zFTDpgfndInDbVs6e/OqtCSqyfDY5f0rVX46Kijy72Om/2074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285701; c=relaxed/simple;
	bh=eSvaMBIbPocMUUAl2gCaybx5KCg+piZs3ZrESkEh/t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD5vBOzmVA2U8XPEIY+FnhlUXP0Pb9DgHXI4xTd5qrrPdmdX97OHTG+NWOqWL4TYyC+b8W9sabx+XffpgMmbSDHYgZDI0AF4WG7sgXz3aoj/ytKYDnedmivPH5QaERMtqc/oVnGioPtpqJMRk3UJKrSys5F0vZVOUx/EdeAe/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBwG+Be9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43e1e98aaf0so20417141cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716285699; x=1716890499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05P/WlwWKKhut6I1eqLgXZLr7T/6QQDhvGE0vkqsqJo=;
        b=RBwG+Be9ISsaQ9wSEh5/7UhbNY26zueVmxaSRIwPcub+SFxb2Kpwc9C6GoYx4pUwHS
         IGvJk/ZQ7zrlTC0VhKbpd5/Akik4LiOOAl7XUH8xMq/GpERYeonlifxAGH2E+0HCkRVU
         9/YVsFB4kGs9prmVZREu5rViJ6Xp7axxWQnY9NL3Cxm3N02cqSJ6fVuhgJNPdko/H/eq
         DKVW7NTQ6MoPe1uZKfVulGfwDTgEPaebagIu7gIeyq2igu618c7vz9m9+8XVRuPLbTfu
         8MC8bdyQVQpWRFF+i1CaWLn/DDcDT4e3ZSU+10gkCLSLM8i2syOq7uz+NGuBYmaUyctx
         eTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285699; x=1716890499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05P/WlwWKKhut6I1eqLgXZLr7T/6QQDhvGE0vkqsqJo=;
        b=LmB2p9gJ2KNM9FWxJeDBsA7x1kz6Y4QG7jf8q1AR5t5sd8cj8e9J16EC33T/jpDMuN
         Ann0mcqjGB75dcR8fGO/Fzbzp4BOW2YaRukMJR5P4QguzDbcNC9qnv3MrTkxD4ZCb+6m
         3I3FSKaJ02sAUTcrOhns7fjYyYBNV+1ENLTAk5xGqNiQq3JwTA+ihDjehRDOWdyz2zkh
         McuC+LRVvLatu3nhLksK73xy1owiEflV2Oj6hWSZp9F6I+YBsqn8c6pryKe0ioW50eGJ
         lEu7tk4NOR6ila3GMuDvzG/xrWNwFQ0B+tdbJNwmB8ePdE0yXbACNgS5KiDxYMqq5Tad
         jz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSFGeLk7zdEneEl8fPgeMaej7rAcAVz04sqt8N0NWBbY+/ibp76/kU4GKoIlAln+tfC9D0Cuz3z6yUYl1J/kgck3klB4JovA99I/aiQeE=
X-Gm-Message-State: AOJu0YzuExZx6ErT/DsnptqjdiVWWBPwVGOfv8aDNoNBiRUBgdNnBoYo
	5eNRkX0anO3PwOKJL5khRi7se3rZm7zwFfNkP4MGBHkvlmw1sjSkTMXGF9iiAi3YAB3uqrADPev
	H/PtvnPTJhMv2GHeb8m/4ieLYvnJ5XWVbfgYaJflvHdLye0tsDok=
X-Google-Smtp-Source: AGHT+IHBg8oA+nkRXQ2kYvjQcVJRCg+dFqmIUTocHTkS2BlcGovr4ox8u9dBOyyUejfPP8YcSa3ykxFw12tBsBCGjcA=
X-Received: by 2002:a17:90b:4d8d:b0:2bd:69ce:1966 with SMTP id
 98e67ed59e1d1-2bd69ce2345mr5713134a91.29.1716285678586; Tue, 21 May 2024
 03:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-6-99a6d32b1e5e@linaro.org> <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
In-Reply-To: <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 13:01:05 +0300
Message-ID: <CAA8EJppLtsQmjC93_zPSqeWAk9vM_ZVF96pcWLRHHpm4KrY2cg@mail.gmail.com>
Subject: Re: [PATCH 06/12] remoteproc: qcom_q6v5_pas: switch to mbn files by default
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, wcn36xx@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 12:49, <neil.armstrong@linaro.org> wrote:
>
> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> > We have been pushing userspace to use mbn files by default for ages.
> > As a preparation for making the firmware-name optional, make the driver
> > use .mbn instead of .mdt files by default.
>
> I think we should have a mechanism to fallback to .mdt since downstream
> uses split mdt on the devices filesystem.
>
> Perhaps only specify .firmware_name = "adsp" and add a list of allowed extension
> it will try in a loop ?

Such loops can cause unnecessary delays if the
CONFIG_FW_LOADER_USER_HELPER is enabled.
Since it is not possible to use vendor's firmware partition as is (you
have to either bind-mount a subdir or use a plenty of symlinks) one
might as well symlink .mbn to .mdt file.
Another option is to explicitly specify something like `firmware-name
= "./adsp.mdt";'

But yes, this whole series is a balance of pros and cons, as it was
discussed last week.

-- 
With best wishes
Dmitry

