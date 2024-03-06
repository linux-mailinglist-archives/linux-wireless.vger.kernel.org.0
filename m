Return-Path: <linux-wireless+bounces-4425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B5873273
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 10:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21311C23153
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE395DF03;
	Wed,  6 Mar 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ny/dSt6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13972328A0
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717014; cv=none; b=BUIdOZYX1Qnxkr3dnTghkDorgSwSK/4ae+LYB/WxG/YiKU7hUicd6RAuBx/D5RlEt0tEmlN4WlzpgQF3WAtLYfCX22BwiM6Y5uOKElZ6cGd/ICq3XHg9u31kXZce75r+iz5GEFSkPfnaFzxxO1O6TuucVR2VAhEoCKA45lCYk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717014; c=relaxed/simple;
	bh=gfCfuORB7Xgy6ox8b2RIpKjH/iyZkWLQuHltLKDy6vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnFhFnirZlpdk37FgL1Sc5EC55swCt0yo2qnVc2C7hV9iDIGRdFvc/eD1aQB7kV0dhj8CP+b4GI15u6YT+nHFkfUd+MZEA+UMQ9xLTY8p6MoGNn4+15QabHlZ+PZTa8tt30Pvip4Y3acp1GYpXt5Kw1I/Jz2TpmqmLPU2gThOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ny/dSt6Q; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so7138798276.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Mar 2024 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709717012; x=1710321812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BE0MVDCXkFfkK14pSEGUiwKD5ySa/rN86aRvUc0sq4M=;
        b=ny/dSt6Qu6epHjhXpHHWOKbUHGaTa4XVu7LVShlrplXvJXg+VILcrZstY85l8A4cmc
         XK7iR+He7kN4foSVE2x+PmLyGQ3SWplzj9MmsFI4/y3MDn8bamrI+e+Pvwh4U51rOSa8
         uKeHQ5ZbbIFCyLkDa3c/o0uTytdJyI+HqPcsmD0HgsEJqt+8g0DOe/XYFDmHIBM0IHiC
         wQGbDC1WGUHhI6gX/8olURCG5u355DfcyPADY4aTkGzbHgrjIUH0/7pY62Ir85GKj1/t
         zsGF7d70M2L2K67QKd9tZQILeZdujfWW0J/4z5zMMZ8lVaAW42k1HBc8gPApJhxLnnSI
         /aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717012; x=1710321812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE0MVDCXkFfkK14pSEGUiwKD5ySa/rN86aRvUc0sq4M=;
        b=aIRPbc765nQ1j8aPUk5UWrh8/YUQr4uNouFP6TNACCkHRNxGfJXm0rlci3kWv6jvAT
         0QU/4Ihq0l0ev3jBvi0wPPO8FPGByVuul4ADO/PkKOgBox9ZHcNxpYOom/00tEebXBKl
         rHAK/MU86v2ESVt3Ih0EDbWyapTBwMjYSa6toqvKnD4xQ7RKiAzjkeefWRQbsQ8xMk7N
         GOhxwOT21tTQS3LK3WHhVQkYHe5b42vGrCEhzfUEFI30xGnqUc3omrUf3yejDaqTRuel
         kNi3p7BSRDhiDeLV5W0hkrXqF40PhW1t5AuZtjUEooNX+N60HWuj8JYP/MDrS6aeYq1l
         RZdg==
X-Forwarded-Encrypted: i=1; AJvYcCUfHetbUVsDLM4d7rusmGoRgquR9kVffC9oFKZ1mlVoinAanXuhyWbnQt3hTjgnsIv2VEWFLT/Vfd+eJcjg1BC5Z9hRGrvvpGAe+6ObqoA=
X-Gm-Message-State: AOJu0YyRiqfnUa+xi/Cy3HHkRCtOcAgkiX8d8EyukAIRygFcm4GmXMRc
	eFDGW11AdTN7FQ9aSMRSziUn0Pb8hmkOMOhytNVu5NX3HH6ffHZIJoSFxkhqv+JjxTnfkhMCIok
	GFIl0spl0VFkWPzutbtODD/QUWbhmnJLnZ+9ARg==
X-Google-Smtp-Source: AGHT+IEqD5hpmdkgRFXRwqrSiHpbvpPVcqtrBIfSxA0UuBRxD8b9BZq6T95tN3G+N2eV2f/C5TL/xEGs2K3EFoUTu2w=
X-Received: by 2002:a25:aa8b:0:b0:dcf:b5b7:c72 with SMTP id
 t11-20020a25aa8b000000b00dcfb5b70c72mr11319092ybi.0.1709717012028; Wed, 06
 Mar 2024 01:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org> <87plw7hgt4.fsf@kernel.org>
In-Reply-To: <87plw7hgt4.fsf@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 11:23:21 +0200
Message-ID: <CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware overrides
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:04, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
> > modem DSP via the TQFTPserv. These MBN files are signed by the device
> > vendor, can only be used with the particular SoC or device.
> >
> > Unfortunately different firmware versions come with different features.
> > For example firmware for SDM845 doesn't use single-chan-info-per-channel
> > feature, while firmware for QRB2210 / QRB4210 requires that feature.
> >
> > Allow board DT files to override the subdir of the fw dir used to lookup
> > the firmware-N.bin file decribing corresponding WiFi firmware.
> > For example, adding firmware-name = "qrb4210" property will make the
> > driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
> > directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes in v2:
> > - Fixed the comment about the default board name being NULL (Kalle)
> > - Expanded commit message to provide examples for firmware paths (Kalle)
> > - Added a note regarding board-2.bin to the commit message (Kalle)
> > - Link to v1: https://lore.kernel.org/r/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org
>
> From my point of view this looks good now but let's see what others say.
> Is there a specific reason why you marked this as RFC still?

No, I just forgot to remove it from the series settings, so you can
consider it as final.

I had one minor question in my head (but that's mostly for patches 3
and 4): in linux-firmware we will have ath10k/WCN3990/hw1.0/qcm2290
and make qrb4210 as a symlink to it. Is that fine from your POV? Or
should we use sensible device names (e.g. qcom-rb1)?




-- 
With best wishes
Dmitry

