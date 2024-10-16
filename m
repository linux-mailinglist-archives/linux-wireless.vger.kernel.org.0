Return-Path: <linux-wireless+bounces-14071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2549A081B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 13:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEDC1C229ED
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E4A2076A9;
	Wed, 16 Oct 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lW4v3yx9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC418C920
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077218; cv=none; b=WGD2ALNSJu96Ljs2AamM1NmOxl/5AMDFCZeSNf3TDdjCaWOeODgRoK9+9gbrVhrSbMp2PbZeFKomUSUwQf7ZWwu6MoJoFJuc/sC0wusclK88p82wIPLXdI245hsboqWeR0z2E9yxfM2sYiQBCdAN6OtaKJaSteYQfFxI0iKdKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077218; c=relaxed/simple;
	bh=MMbOyLTO3wGcAW166+A0Nh8rO8ikdhlxZ3EdZM2YtmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raHmEqsd3evqi6KlHE6NS1jvJPLqk7vCa0BcqT2ncWEgcTV66Nm9vv/0jas9cIMi2YqHB34HrjuvMyv0vH9xHZs2TMysb8Q6jOT4kOGdHJtp7qOd5Sn4E1W0+qFm4fwW4USquzJZJQy22lj+EkZ5TCsW7ZWm/OB2Uc2KFljlMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lW4v3yx9; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29047bec8fso657144276.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729077216; x=1729682016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t35RrnvDQXTH6WlgCiQGNdu+PPMpKHTypuZ5fkXYJTs=;
        b=lW4v3yx93W1CHx3QzUfXgEKy4YShpkbhrLrw1zdYNBrxPpCOuW4B4pdI4LjezKnhQq
         brcsPDoYP3kpsmrG2SvVSxcMsFiQ223iJBm8Dajv4bgrYiffblm48ggMODcddxvaKnG3
         oJqJTQOetUWwHtrrKRuwYM9YAs4N2Ds49vwoNoL00Lb1npILyqicV+7emxXp02sK0E/r
         sz0KMmrJyxB933CkyPJU12UgYzmUaBHlLhxLweH0+HoAKv4mqfPlSB9rNxnOu6L5SixI
         Tc1c4wDEGrRG6jkyQeNXYphEn2mQjaW7KC4YGzSjTY51Pq3/nPJdxd6EHD+oloPpg02v
         5t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729077216; x=1729682016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t35RrnvDQXTH6WlgCiQGNdu+PPMpKHTypuZ5fkXYJTs=;
        b=YB0tJzvuIBLeMHR1A1o+7eN2OscRef+KclubBNqHWSF43m8LbsWSiEWcnuc6LIf8ET
         eN2QAM1+RFEGmQTtfDO0SVU2b6fUSdV2gi+nXxq7Xk6qVkp9Ft9+HK/MSP17lAW+v+9g
         2WRhUrM9GOfovW+bnNEm0iCCqqGL+5EdXk4s7Cg2ZBFMHEbpm2APvERvIB0Xw7OSFA9Z
         vdOHZ6oXRmjaj8y0w7d56E+8NYSo5MeFhXku0cJA7FS3S5AU2q1sTGSUyI4UdgyHdQKz
         YjI7pYiS3jcOevvO9cwowK53XDrxrEOFjPNFa6CTES5LAnlpIneKCDUOqErCoeaeFms4
         G5VA==
X-Forwarded-Encrypted: i=1; AJvYcCXYZ9MeRmxdUzjymmZwCOvAx6hyfaedxg7O/5DgEBvmFybelR7ZzuMpiuMqkA6hawOjGZ7Q961CE7X51NXgyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK5E2Nc+FLBQ3UNbvHHVELxXKly1/Yzquu8C+sxQquyBq28fF
	6+vxuVuGXqcsnWm2C7e48pgNvD//VoQzOWxZiiw44E2oUGbub24nrhJmLhH2uTkwJg7zp3jd+cF
	o2hyzyAL06ni5hSD37899H5YCjA23G5QLvoWKIDvBCH6I9ArZpJg=
X-Google-Smtp-Source: AGHT+IFbaQB1b7uprlpkX9leHepB8/oAO3NTYJHXyEBNTbByJjabNy9Zt6W7LL2bl36doaQxwSWNeBZZmKsWoyLbeNU=
X-Received: by 2002:a05:690c:3587:b0:664:74cd:5548 with SMTP id
 00721157ae682-6e3d34ee5a7mr30758017b3.1.1729077215816; Wed, 16 Oct 2024
 04:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-3-quic_rajkbhag@quicinc.com> <ftvwsizfupm7veg662adnzc6jpulk5shga3xmvbtom3saclnf6@bmatmqw5lp72>
 <gnv7i3m5ooxtyi4ywgq4q5sq3wj6j7xtjx6puuixoulypeiwjo@65wfj657x5ug> <28d9b410-dcf0-4431-81a3-6c33d536d217@kernel.org>
In-Reply-To: <28d9b410-dcf0-4431-81a3-6c33d536d217@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 16 Oct 2024 14:13:24 +0300
Message-ID: <CAA8EJpotk=pgcmFePrqESnpE5edRZVboCs-M9-nPOQcG0xa2Jg@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: add wifi node for IPQ5332
 based RDP441
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 13:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 16/10/2024 12:30, Dmitry Baryshkov wrote:
> > On Wed, Oct 16, 2024 at 08:58:25AM +0200, Krzysztof Kozlowski wrote:
> >> On Tue, Oct 15, 2024 at 11:56:17PM +0530, Raj Kumar Bhagat wrote:
> >>> RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
> >>> device.
> >>>
> >>> Describe and add WiFi node for RDP441. Also, reserve the memory
> >>> required by IPQ5332 firmware.
> >>>
> >>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> >>
> >> Don't send one DTS patch in 22 patchset targetting different subsystem.
> >> Imagine, how wireless maintainers are supposed to apply their bits? 21
> >> commands instead of one command?
> >
> > Huh? b4 shazam -P 1,3-22 should work. Or ideally the DTS should be the
>
> Hm indeed, it wasn't some time ago.
>
> > last one, so applying all other patches should be obvious. As a reviewer
> > I find it troublesome to review bindindings / driver without an actual
> > DTS snippet.
>
> Considering that patchsets for certain subsystem *have to skip DTS* (you
> cannot include DTS in the series), then better get used to such
> inconvenience.

Yes, I'm getting used to that for some of the subsys.


-- 
With best wishes
Dmitry

