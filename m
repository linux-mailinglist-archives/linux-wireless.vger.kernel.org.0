Return-Path: <linux-wireless+bounces-26452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD0B2BC33
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B385F3BF3ED
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7F311C1D;
	Tue, 19 Aug 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="wSNRnY12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE642056
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593488; cv=none; b=huwQIX6Oosz372OJ9FEKn4oasjqA1qQF8ulVUkmZLeQ3waVOCG2alzFh75J0yZwfCBf2TwW+y2rPDGLFYed+nwcRQFjWHxw6SJjRDUWKTEfgehe4HE0XSAFIZDANjabiLfkl3HJK+tQ3PpMdCWHGcmlH40VEUudhb6jeKIKQQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593488; c=relaxed/simple;
	bh=U6LpYnTCfo4Gg+5fyuVTe6zl2UfoAqsiDIH2GpQbPVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJzx2bgk7fW6ttenewHHP0KUoPlKrp0woH3eKsid9y7Xgc3K21z82Gu73NX95bo5S99U0zB+mgycYrDa2T66uF2aYyBq8bJnxZ4cO1oBU+X6f720sPWWeL6Kq3X7N3iKI/LQiA1MRd+LmjMMlH4xuIn0wMT7iAPTnQDK+qzEKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=wSNRnY12; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-50f8b341e40so1243689137.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1755593484; x=1756198284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6LpYnTCfo4Gg+5fyuVTe6zl2UfoAqsiDIH2GpQbPVo=;
        b=wSNRnY12z0XsLZtChX/5ECc6MSlNlxVNRQXJLI09Fox6079v1OmY/+/mBmOai2lZGV
         ynFzTOU48MO/sodtbGQsQUmgnG0Kz9+5lLne9AD3X4wmOaJccM4q4ZUt8UIKNnOwd01S
         aHJfucM6KbTFcIK9ghBMUVpcan3v6LLiHxzUoUSrXI94kDB/EpGz1bIwkSqvdXoXi9u1
         UsksZNDzru2A59WQzaYdkXAeWA1+to8haVf+W2PLTuxshJ/T5COB4/OBtNFi/u0Ukl1c
         i80D6KtUeyvje7udT4IemMUJOmxqo8ji1qacTCmBFSFnKz82Y0igTM1RwQeZRFcANDyZ
         wH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593484; x=1756198284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6LpYnTCfo4Gg+5fyuVTe6zl2UfoAqsiDIH2GpQbPVo=;
        b=A6KwKtHHh6brjQLTRKGSX/t+IWWFGCqVSqq0QL2Vbv/AM5RajjicNCuLStb1AOdV0z
         EQrR7VmRhoElGvjpYewpAShWA4E0VwXj314WIG4mRJCg2CcIAlmDRiNx28SwokQoo28Y
         BCRTSgHH/coyzDF4hfBcz2CJyoBIH2zTKhblRjpPmp3fT1VmnhjD9z+ZkXH3ypTwuCgC
         qeFaME3Z4BcHHW6L29UVwv2sDziYHUhyzpSR8C0nNSvP6sBGekP9lQze3oFLT83txtem
         pwDmxYjWqpHRGX/9XkrGpaDBzz5IGlusK/2JYY16f21CoV9TJ/leiWNk4XqvE5313tdk
         4c3w==
X-Gm-Message-State: AOJu0YzDpD99ZDnTGpIIBFZrTLpmm8CIJNmhsamYjM+ugT7K5k99LOL9
	c6nWXrTy1VUx/pUAzbLcx7VkdsgmcUIzRmY+mPXzkDvWpNetG763261CZIEkkinqy8arOLMB8AI
	xth+puejerIYgF/FFCNsz5d8+SWvlR6TQ1tvBGBwG3w==
X-Gm-Gg: ASbGncu1IF2MXAptxxtPjNn9uWNEP/S4+kYjqD9CadgmpwKpLKxbxUzCHbT7Pl7+Edc
	DzziYyLHWse1ezGFZS4gFs97Waq3U+GQDHxLULluEbjFBRVw4Aaaez5GTYobCEESR8HeuVsFu5Q
	vkkkcxjLqCr14Y0loMkP6ElN/obmhH0K1iAnPwowxXAcFc6ItvqZp7/xvYatSAyjO4kT+oBUUup
	810LTEuaNYqblzfTytc
X-Google-Smtp-Source: AGHT+IHn+JAaOrC4ZPZza2tWcjwOoUJwn4XbVQAwuiSlaZvGn1XN9WfH1oIySLhW2qGqHs++WzaNsKNDoyzdjqTKQUU=
X-Received: by 2002:a05:6102:6a94:b0:4fc:1484:5500 with SMTP id
 ada2fe7eead31-5192442a3aamr426413137.21.1755593483789; Tue, 19 Aug 2025
 01:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com> <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com> <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com> <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
In-Reply-To: <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Tue, 19 Aug 2025 10:50:47 +0200
X-Gm-Features: Ac12FXxD4wigLqYZhtA3A9FdduCE-sHZ7cGeGfRKkrACvF0m42gxMVS7V8_5bwI
Message-ID: <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I Have a question on the same subject but not related to the bug.
I have many identical PCIe WiFi cards on the system and I need to load
a different board-2.bin on each one (1 adapter per frequency band).
Is there any kernel built-in solution for that?
I could not find any, so I had to create a patch that loads a
different board-2.bin for each card based on the pci device address.
I patched ath11k's core.c file so that it reads a string from a text
file in the rootfs (board-2.bin path per wifi card).
If the text file is not found, the driver loads the default file
provided by linux-firmware for all cards, the original behaviour.
Please let me know if there is a better solution for that.
Best regards.
Balsam

