Return-Path: <linux-wireless+bounces-13766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C28996261
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738352841BE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ECD187FF2;
	Wed,  9 Oct 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Woekskbq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2221178CC5
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462346; cv=none; b=iyc/1C8LRz3qg2XFqJ747n7TMV0L7lY64IMH8Cc9OtHa+kpnv+k9XMRVg58UcEes10O+MzkS+PXTkil2F/vtCE4ezGVuighza86hgUfgjPtKWIC3Es4JdxZaZbnTEuApg4Chs4gZosHuVTKCsuPaD5hlETjpLLUyYRgAmLUmOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462346; c=relaxed/simple;
	bh=NGMRGCmKorB9h3VMalUupB456+qTD0rV5nQOgIVkf4A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fRBA8iP23OysVBqAdt3EYg9pWQZN8nrvv8PPjRrdSZiewzmHXevhV42nLs7vViqicUqemNg0ngFp392gTZnH2AExmJ2m4mBZC8ioZSlVRMlZ6Ti79SXLB4BMbZ4CWLJQSLRaMAmebTbci5OXsgQnFB0jBJA6VQjvNVgYLIL8A6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Woekskbq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43058268d91so7973425e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2024 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728462343; x=1729067143; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLJVWehmFbOOxGZYpNzLo94Hs3PFFYW5teQQXPK7uLQ=;
        b=WoekskbqsMfYinhS1i6r0dI05mepbo0VCYHYCCRgwzLxdy46LMhAR3xSFiBCSonfjv
         pPSmw34H1PJVYghDWJqo/lGspz4JcYnNM9eWvDZX7YsSlbWGWcuFfHvCA6abQIHh4QRV
         Gjsv2e60xymFkg62eOQ3jDRP9ISkXmmrWrfsbWfam6q/JnrIH3xptqAgnlEeUI1BluEu
         0TUq0o+Gx3k3ZraVZ7l0ckzRX+vgcCXbP9I4QRh69nJnpyglL6l2GZijZQr7xmKDopbh
         yVpKipKCie4eFYsUhJgpQuC5xCTSU7f7oZbosSq4Yh4Dc11sV6EELdY6KoHS5snZnV1e
         cM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462343; x=1729067143;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aLJVWehmFbOOxGZYpNzLo94Hs3PFFYW5teQQXPK7uLQ=;
        b=FN6PZRXnaa8stTF9pIqBmfvCMCbhIyg470QR4xbpKo0MDMC6qkhnvIIT10t+S/WQeM
         YPS6Jgbov8qG+vXmTVvaHqxQvvuO9Hi+c8Hqr+MPHZxM1j3S0QwrQDoYaMc4WuarWeeE
         N4FlGFMroV7sIq40o+oBcRAY9XH9v4oO1ilyueqNdUahFDrVbvbUmNzdTCOSgmirBgiz
         mxkSwd3SiS3HetvR0oNsAK/xKC7F0MvZHJjFuewhkIsvV2Q6LyLdvfF3owknIckhTseB
         nEcafQnaA7jutcTHBcYp1BiK3+ddZVAorfT/tIwPEWJ2pTMVgRu3+lKBEGfMYtIErI/j
         NEbg==
X-Gm-Message-State: AOJu0YxOwsuKcW6pHaK+U4K/2pBiPYSjoWsPxAqGfOW9Br+4BcYTa6gF
	KcDsweEWd2nk0vJJ3cQE6ZfYEfR4Mm7tAq46JNZrDxQBS7JUWdCn
X-Google-Smtp-Source: AGHT+IGaeKaBN/+yVM5/82DOl5S9YcoWJ5/O5SoqGkr+H4MgcLO9os/k5x/8836Up417G2gPyPEoWg==
X-Received: by 2002:a05:600c:4f52:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-430ccf4c22dmr13919255e9.16.1728462342941;
        Wed, 09 Oct 2024 01:25:42 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d445sm12590565e9.44.2024.10.09.01.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 01:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 10:25:41 +0200
Message-Id: <D4R4RHZM9GWX.2V6MHL6HW9YG3@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] wifi: ath12k: some fixes and clean up for
 monitor mode
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Kang Yang" <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241008073534.1195-1-quic_kangyang@quicinc.com>
In-Reply-To: <20241008073534.1195-1-quic_kangyang@quicinc.com>

On Tue Oct 8, 2024 at 9:35 AM CEST, Kang Yang wrote:
> This patch set does some fixes and clean up for monitor mode.
>
> v2: rebase on tag: ath-202410072115.
>
> Kang Yang (11):
>   wifi: ath12k: remove unused variable monitor_present
>   wifi: ath12k: optimize storage size for struct ath12k
>   wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
>   wifi: ath12k: fix struct hal_rx_ppdu_start
>   wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
>   wifi: ath12k: fix struct hal_rx_mpdu_start
>   wifi: ath12k: properly handling the state variables of monitor mode
>   wifi: ath12k: delete NSS and TX power setting for monitor vdev
>   wifi: ath12k: use tail MSDU to get MSDU information
>   wifi: ath12k: fix A-MSDU indication in monitor mode
>   wifi: ath12k: delete mon reap timer
>
>  drivers/net/wireless/ath/ath12k/core.c   |   5 ++
>  drivers/net/wireless/ath/ath12k/core.h   |  23 +++--
>  drivers/net/wireless/ath/ath12k/dp.c     |  25 ------
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 108 ++++++++++++-----------
>  drivers/net/wireless/ath/ath12k/hal_rx.h |  53 ++++++-----
>  drivers/net/wireless/ath/ath12k/mac.c    |  24 +++--
>  6 files changed, 114 insertions(+), 124 deletions(-)
>
>
> base-commit: b9545f4570fcfebe982439de7c9106e55b4bf756

Hello,

Two quick questions there:
 - If monitor works for wcn7850 shouldn't you set supports_monitor=3Dtrue i=
n hw.c
   Or does it still require more work for it work ?
 - This whole series seems to have been tested only with wcn7850 and not qc=
n9274
   Is it still not supported on qcn9274 ?

Thanks

