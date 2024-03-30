Return-Path: <linux-wireless+bounces-5635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A0892964
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 05:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC391C20F6C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C24883C;
	Sat, 30 Mar 2024 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+1uMRMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8779FE
	for <linux-wireless@vger.kernel.org>; Sat, 30 Mar 2024 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711774086; cv=none; b=PCFHwlqUXr3DcQjgkKNyoCMM42WhKiXJYyC2Ixm2KgK+X3ee54xeBs4iGSmxr6E3pZNlfTQ+UmF2ohqzPqgvFJr3yBQwRVMhR48LfTsZVR4HSS3Ed30GquZq4ByJXmw4Y9V4tMB7zMOuuWIIS8LYCXL1X6iiyxfu42Z7YiyQ7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711774086; c=relaxed/simple;
	bh=nOmQV1H9fSp2x3NrALQj4COL96kktnMWzhB6qZiX8aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M48dreyTolvY2cnQgLIZAjXp6uEm0TNSoZJFPvOn3NX33jGh4rbuopaUy3UiQgx/b3SwQEDrAqctPWwBtJS0OZKLq4E+ubZXd8rfLHtesOMaRONXw+IjdWQc7FQGOaJg/33goxAx4COg99paYcS/9XNbipGaA4ij2yDX6ZjqMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+1uMRMx; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2327486276.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711774083; x=1712378883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQUNU9HstbNDcHNvryhhTFYLom8Nu8/8eMQ1j/SNHfY=;
        b=n+1uMRMxRpHwhG8KTbbVJRplyvBND8i+sroyADt9uuGsXcIVPiet/79t2DhVti8yaZ
         JXx3tMNtWdggLvh9aYy49rNtN09DCcJBt55gB9kQD27tAbcS7smMjLOGnNIY62/rs2QK
         P8d0lKce4ndHoWZtmIUEvPoZ2LrLAp1s+Rxbhm8HDMtNoDGKy4vX33CC9MvYByGuoea4
         iL0qxUnVobapkYQ6F399p7WoFHlIprij6tNxx4wwFEZ5PKfwSHoKWGYzYNuD0MkuXuIf
         +gaYRH3sYXk4Dr/uvUUZ24Qz7endvnF+AtHrstT+wrxzeD9D2kfYEVlxgP94U7xW3xGW
         mA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711774083; x=1712378883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQUNU9HstbNDcHNvryhhTFYLom8Nu8/8eMQ1j/SNHfY=;
        b=SeYmUNX6qTVn6sUlGdLFD7/cks5BCo3c4M+O3XIyz+/remT62GPw7p0mS++lMzSW/a
         Ti6tH051iuMoDwP7vOxMgXOIC1uHiIkza7AOh+bG3ww4eDWPwJfmXLcdMi5yyi5euXKS
         whMYSQwln+ycdK507NYHiEbBM9KRerGSgLwiJj9oet7Mi7Mo0fvqxLik0e2i6Ryw8Cem
         ZIvpSk3f4OKT/fgJvnBGuDe4ldrg7m3Lcc1bA6tZPVkrcLuIZjVbGOocqmmAG7E8vOvd
         ADyTmAZCt0u0faYyYreqsISg20uTrf5VanJsLmR19hKehZcpiHed3Q7qfZyRzAi0Zg4O
         tPZA==
X-Forwarded-Encrypted: i=1; AJvYcCUvvAM8dWqUnbi84sxzzWqZj/pojFvWq+GFwB4jOeuwAeafjJG2Icn/zZPw/7n3ocfY001eOogx5aslqVlrwVE1TAr4wyA+7233gkyxStI=
X-Gm-Message-State: AOJu0YylRuSlk5QUcTP02szWS/Ogik/LRrldoYk7vLs739RX0K79yA6p
	vFW3Eepb48IVUpHat1HWVrMsgSU7tc5l8dq1pp2gBd8BUTY5hUlNgOjnezMXegNMMHM+E7Ipecj
	FweWWSAHnTHePepqwjCNvklCcNlEOA2JHk+8vVA==
X-Google-Smtp-Source: AGHT+IFWm8FRcfrc1FaMw38a0VeaKMDMlu7uCNCYORdT1l9V5pI2sSVpSQMKObFG5zVf0CeqF6rlwAr3XTYwJkWkMCE=
X-Received: by 2002:a25:10c4:0:b0:dd1:7a16:7b4 with SMTP id
 187-20020a2510c4000000b00dd17a1607b4mr3520574ybq.31.1711774083391; Fri, 29
 Mar 2024 21:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
In-Reply-To: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Mar 2024 06:47:52 +0200
Message-ID: <CAA8EJprpmC6+ePxw_G6y9YEszndq1VonS1HP=aP9OVHNm42LLw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware overrides
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 10:16, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
> modem DSP via the TQFTPserv. These MBN files are signed by the device
> vendor, can only be used with the particular SoC or device.
>
> Unfortunately different firmware versions come with different features.
> For example firmware for SDM845 doesn't use single-chan-info-per-channel
> feature, while firmware for QRB2210 / QRB4210 requires that feature.
>
> Allow board DT files to override the subdir of the fw dir used to lookup
> the firmware-N.bin file decribing corresponding WiFi firmware.
> For example, adding firmware-name = "qrb4210" property will make the
> driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
> directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Fixed the comment about the default board name being NULL (Kalle)
> - Expanded commit message to provide examples for firmware paths (Kalle)
> - Added a note regarding board-2.bin to the commit message (Kalle)
> - Link to v1: https://lore.kernel.org/r/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org
>
> ---
> Dmitry Baryshkov (4):
>       dt-bindings: net: wireless: ath10k: describe firmware-name property
>       wifi: ath10k: support board-specific firmware overrides
>       arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
>       arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node

Kalle, Jeff, is there anything pending on me on this series?

-- 
With best wishes
Dmitry

