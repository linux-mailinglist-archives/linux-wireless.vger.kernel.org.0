Return-Path: <linux-wireless+bounces-21114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C395A79CA4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218173B4163
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16423F273;
	Thu,  3 Apr 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="riYps+6s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89C223331
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664281; cv=none; b=PW8/8QgAZNBSZkVDvhI9CRV1IBGQg2z58NtJ7OqJdGSBas+Q/1JdHFAc85rtNHavLvFwqUAntKPTzvChz0EhZW+c7TT36Y9K42p7NaOtG+vjG6GcdL82v+r+2pU7Zi8pVLIYE/n6lKhl1OJ7rMVijc+74NFhUsHU1vwpEH0Z7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664281; c=relaxed/simple;
	bh=vJ0Do/5yInpJts5TcS9oFarGP2cYAYOdQDj3i6kaNC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzEBnIF1KLCU2zr3g7f+G4XOi4uNGMigMg4rw+zvOSo3w5dDFiptUZ4Sh2ek0MYm/r8PP18Rj5WpZHie5bLrro99+QgVzGL2XmFRRcWmTKo3zDZBY3y3MVr565Ek8UUulxr16ikiOzOpq/Io4SVFqlsGXHxed57XCnF5cuTouyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=riYps+6s; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c091b54aaso5420191fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743664278; x=1744269078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ0Do/5yInpJts5TcS9oFarGP2cYAYOdQDj3i6kaNC8=;
        b=riYps+6sKJPSvRgNGshxMnSp0eYbkkbCMuLByP48sowp/ixmosWHsFey7dzgyiHwEy
         JGpIucDX3a16ZATLwQ1OkfFwq1vHTrAE2XIAGsHy4y4vM09N8q9RHPeHkH1jPCh5O8sT
         TN92hj+RqjgYOjIfbA+U/i6DKsBKWgutvh0Bd9T24zsfQ082k+9He3XLM+SDgtPL1w/V
         nUVN3JPq3wDtUDC9DtGfPPasLmpNMM6Wz6uLdwv6Jeey2rQy8sj3xPNxe6D2f8FxEoql
         ouAtd77f/tvehFO/8kqi8VVRnK11ZOE+zuKzWjH5pWk7Wvp121PgcsGgvJs6QrB9B+iK
         mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743664278; x=1744269078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ0Do/5yInpJts5TcS9oFarGP2cYAYOdQDj3i6kaNC8=;
        b=De5pAZ40Th9/uGYoQo0WvQgwdSFVPrzOa2pKAn8c4FRg06ON9Uk20UQHeblf7eqa7d
         S706DwBqtXOFhdRIbkrBimrwKY0rnepZ+1qpc/IntpZ7j/pLea8OtHHIDnY1ETkeymn/
         HTfuvbhaMTB9cZrcc67aBoV0Br2tIVoiyYtWgnVKl0kvtGvbzCJhPQ0wyVHoaJQrByzA
         v5yPbI/dRRIUbWeSe5CcoWRDTyVonzgd/EPH3erR+CkbAR4PajlnAMG2YUktCo0oisNq
         XaSTuProfGp8XNoYT6Y13wrG7sxC7PRfZk95B1+r+uI9fL8p4pkYzJdnCHjWlm9KFCAD
         mrhw==
X-Forwarded-Encrypted: i=1; AJvYcCUKp686N2DLVjoGYufM2X4kuKp+VOz0g0IKFPb3sfSxuSs8hIncBCTTsJ2IUDAVs2wL+9KwMPt0JmzDSUbuUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4GB8uZArXL8QCGK8+syOPrYbD3Dk7Z5JomHKIQEqojeXocKQ0
	HlQvZJepJBY+tP/1xPrOtUto3DugvF4WHds9X+UY30Zaq3mfBy2hfZl81XQjljfbxBW5pvVcGvc
	VhyfvWnrLrAmcaMtkKggHfLpvQSOipZaAfhB6+Q==
X-Gm-Gg: ASbGncvyv3UwKYv8vumUsTy8D6QuhCoMuX1SrQZxRWthP+LS0LsTWVUG2Gpe3VHW+Qr
	YK0LlwspZa4Ru4W9PqMZzCVVSc3LSKZhK+4HVsLNaYUwhwZRaRJd+EpQT4x5S+Sj5t1FxbYfvZo
	IJXbsQyQhd2EBbgZoo4nZlxTRd71QrIz4pXVVPXDD04vLwMWs3qo/FxhCH
X-Google-Smtp-Source: AGHT+IFkpl28huUxLnkOG8+JoZRPAuyoYj8fAmCyXd4tv38/gNFXW7fiJiUp5ulgWcmnVTNmKGEylZ2WlPrLdyIQcMA=
X-Received: by 2002:a05:651c:1475:b0:30c:7a7:e87c with SMTP id
 38308e7fff4ca-30ef91e9c23mr19952681fa.35.1743664277849; Thu, 03 Apr 2025
 00:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402132634.18065-1-johan+linaro@kernel.org>
In-Reply-To: <20250402132634.18065-1-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 09:11:07 +0200
X-Gm-Features: AQ5f1JoNoWRTnOEMbH9dyhhofmJuk8_vYCLRQWl_3nQ0kPEBcd2NI2XoNIkV_Zo
Message-ID: <CAMRc=Mfpm8=q1mkfNfjPtogbh1S9PKU+w_2yMP+oE_Gj7-qemQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jonas Gorski <jonas.gorski@gmail.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 3:27=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The PCI pwrctrl framework was renamed after being merged, but the
> Kconfig symbols still reflect the old name ("pwrctl" without an "r").
>
> This leads to people not knowing how to refer to the framework in
> writing, inconsistencies in module naming, etc.
>
> Let's rename also the Kconfig symbols before this gets any worse.
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm re-adding the tag here as otherwise b4 will only pick it up for
patch 4/4 on v2 of the series.

Bartosz

