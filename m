Return-Path: <linux-wireless+bounces-24099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2537AD98C9
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jun 2025 01:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA6171EA9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05A2397A4;
	Fri, 13 Jun 2025 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3RrqWAs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A41226D18
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749858659; cv=none; b=oXE5caKDvJ82oRUKU9Ebuz/r6zcjOBBVw8VylAX8AZixAA0gMauTz/bS79nNlyx3U9B2Kim5T0qbTFpMhqFwJL1m7yk5p5g/RJbDCjHuHy/YPYsSgtpunkU9WjVHELy+vL2iBB/GrUy+lEyd4Qubd7wTJ3ajMbxoT2LXRRNSNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749858659; c=relaxed/simple;
	bh=LdXE6OYkaXZYrYp6Y0wOKBUFgRxtH3DTQXfN5rI2/Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DalYIcOruXnSULSHFPlmyVpXnh5UzfR2L5cS2OHW9brTnaUM23ji/Z4/11r3yxnuPI4Ka2z1IzyRrEolICkQLfMc14TX9EJcRmVi2IQVzoxXdv86Gra8krFShsJpCSwFfMxpykxYVKN/dIJcVAhGDcK82WXGbRPiFNRtHs4qt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3RrqWAs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad3400ea3so26213756d6.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749858657; x=1750463457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGrxasFN4jW2BurDn9qw53DwbR+eW9ttEzKRMlrIQBg=;
        b=k3RrqWAsOtLqgegPMzkxt3V33RbVI4yjOuQ9/yIzpLJBsZ9Yqp8g2HokZX8CMVN5qw
         VKpTX9K936b7lPLdZW86pgZWsilsem+8JKoyF1HORrEhq5jzPUCC/7oItSyFhEUC0mKS
         4hRCO5rgbDBHFCpTlFUDOILwXwvRVX1gbU2Z4oLyXH2ZEAsJMux/2OElxgBKnTa/M5GS
         Mn0p9tX8QKe3qKKAC3NRQzfWsGt4bQfdzIoh4SJAN7plYeLsMsMSjpLKDkTWEQKDA7pg
         GG1N29pfpEe1N7E23Z4Nhk3AALM1I1fNoWw4/F+WRgFUs4m2j+hnIDh5mMMeDOqxxpxJ
         87QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749858657; x=1750463457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGrxasFN4jW2BurDn9qw53DwbR+eW9ttEzKRMlrIQBg=;
        b=fLau/UHKHpWe7+txkwnIQc13V1/BKTZretYmlMDo/LA0gmxJHW/P3Xwa9OyjNoGLWo
         /HLq5odMpOquWo55hi23xUPqXzlozU48rTbj0ppL0iQyvm5pC7BHh2WEt1RBcVlBjhPT
         9209tXw0DANh0vHxdHv34n9ACz9Xqc2SvO7tq0LW0briIsBcpBshZ+wD4+9zXVw1XqMh
         +QUs/HE8bvNJhN6WPQvoTKyCzae32lNgWVcUHCseRWUB/vUwGw97dsOnAn5XKd/xArtz
         ggO6YEMC9et2I2jmsaP4aEmzaA7775oAV3lG9+7u62MEoM/my+Q0Guf9ygUrvtmKWowH
         TF8w==
X-Gm-Message-State: AOJu0YyP8t8QpF1Jr+CeG6JgUJB1io/eKWur7iJwU9JIuxBeP2Wugxql
	Faz8f6cIsCXCdGFWuVI4TFn6vO68sOvbZuF8leYGWBer++rBXkYijfdId3iZYJ5WL3vuai/uVqA
	4WoRgjRqxyRNLP9S7x1PcymdEzOd0k58mBQ==
X-Gm-Gg: ASbGncvF6ptfkCgsxA09Dek2JM8L8sD0k7v2+iBM7HToNQaNuD0CYsHGSbL7iTgDjFe
	pdfuP6uzYrQObB6FOWYUTmsF/EokCHqmnGX+k74AYmuQ/br5sh5lcPSQ0WwFuqA3FZQN3Cayplh
	GRdDjXTuhPM76l4sUzIQtXOMVQ53tSfKAjnQmDDaZ3OFU=
X-Google-Smtp-Source: AGHT+IHJGuAci/XSNTxiZCPFot1G2p7HUzS5b2RpQW5J9NwdWIi+GVegLszCYGLHbtYXBAw8nozBKs+kduj7ZHKjeig=
X-Received: by 2002:a05:6214:27e4:b0:6fa:ba15:e7f with SMTP id
 6a1803df08f44-6fb4762f4e1mr21299506d6.9.1749858657289; Fri, 13 Jun 2025
 16:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fkI_Avg3J0a2I4RUHbToL_jANN_JCZNE_5ewsXqzltTRlHZ4gjxoYbKfdDpw1ecNApjjhjqDPtHW0fegPyx3lwIirG_swt6YxkXT3yz_OEY=@pm.me>
In-Reply-To: <fkI_Avg3J0a2I4RUHbToL_jANN_JCZNE_5ewsXqzltTRlHZ4gjxoYbKfdDpw1ecNApjjhjqDPtHW0fegPyx3lwIirG_swt6YxkXT3yz_OEY=@pm.me>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 14 Jun 2025 09:50:45 +1000
X-Gm-Features: AX0GCFskhc_1doX34ZD8VNruoPj7tX41OrEHDYLMv-sWX-MAb_r_NN2349zOJh8
Message-ID: <CAGRGNgUzk+8CpDU6gCMNjkOCgMT1UGnO-CStqQgM7y9UEMrMDQ@mail.gmail.com>
Subject: Re: [FIPS][iwlwifi] AX211 not working on Ubuntu 22.04 with FIPS kernel
To: Noel <ncniles@pm.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Noel,

On Sat, Jun 14, 2025 at 9:00=E2=80=AFAM Noel <ncniles@pm.me> wrote:
>
> Hi all,
>
> I'm running Ubuntu 22.04.5 LTS on a Dell Precision 5490 with an Intel AX2=
11 wireless card:
>
>   PCI ID: 8086:272b (rev 1a)
>   Subsystem: 8086:40f0
>
> The device works fine under the standard Ubuntu kernel (6.8.0-60-generic)=
, but fails to initialize under the FIPS kernel (5.15.0-141-fips). Under th=
e FIPS kernel, no wireless interfaces appear (`iwconfig` shows none), and t=
he `iwlwifi` driver does not load.
>
> From what I can tell, either the `iwlwifi` module or the required firmwar=
e (e.g., iwlwifi-ty-a0-gf-a0-73.ucode) is blocked or not loaded in FIPS mod=
e. The firmware is present in `/lib/firmware`, and works when using the gen=
eric 6.8 kernel. Secure Boot is disabled.

This sounds like a distro packaging or configuration issue, not an
upstream issue. Have you filed a bug with Ubuntu for this?

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

