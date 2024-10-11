Return-Path: <linux-wireless+bounces-13899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75799AD24
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676921C221E9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACBD1D0E01;
	Fri, 11 Oct 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcN3NMNi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B51CFEB8
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676568; cv=none; b=eL0SJ+f845Y0ER75p/eC4i8UsYlz6+xQd5DjiXWyfCjxifZqd4JyU8Qedf0TrBQfCdhDk+vJ688PUreyZneZrPbvmhhrTAOvu0xQHnCKXHpONU2/w1udrcJLSbdupzgHwvDbIPo9PdzIHF0zhurKiIbD6lrfOU4zNbdDUwvd2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676568; c=relaxed/simple;
	bh=xyB6hC9WYmNA5mHaU5sWAYhVXz9xfxddBiUwxXxutds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adk89D2PYQR+Zv0epqNGNwpe4dw0ClynPm/WE2iSQGYYcsoa7Fh77NbgQl+g67qzczad1ctVPwC/Dz0T/nl2jr+aYY5cHKk+GWsBnblH3X80wZEVCvvNaLobQoxsqsSQveiWZbdvsUtTjvam5FYbkIHK2/I7XzsXxG+DhdV0XxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcN3NMNi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e41bd08bso28314377b3.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676566; x=1729281366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzkwMAg6+CiFWUUuQQfXSj4t0rL3nCp7xSJYRuQ7Uw0=;
        b=QcN3NMNiG3/LogMQbreAyvqmcpJrYqpaE9VUvUOAAyWpsMTTYs/K53h0qHnvWMKfYX
         eFEBA0bH675hmEPFmOADtK/9XPOAI9sKRuIO6AmfaK+kzYFjNyhOVdd0xWL+kipT4BOz
         Mv0B/1teaFHtUd1mgS+LpAVBL+yZ8KKxY7lZ89AXx7RCUVTXEML1HRTJNw/8aUka/7nR
         KNF4DwYjbSIg6eGUI+bUp1ELnTPmgGU0U9GBoYd/xF2UIdiP4IVQUiU3vgQZ1coqHq8H
         XzSliLIs/75JTOymCWesXMa+er/xQ018rW/4g29bZYLFevFD4bvWQshvRaMv5CiSdOXP
         TteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676566; x=1729281366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzkwMAg6+CiFWUUuQQfXSj4t0rL3nCp7xSJYRuQ7Uw0=;
        b=aZZXBBBY9EV0Nu+lTWaE+UX7AB6c4mfhBL/mvqetFFVav9E4Xvc6DYIKuv2QCVtfzc
         mpXrBgs2E088aFT8UGX9gUC9Pq/UA8seC1wdokGfu5GtDPIZESVAQ9tz1DF6lFN3Fv0a
         fPMc31Wpmnd1U3QjAZ1Xoa1fZYSy6VlFv4P/S3GuE+inNsCu5KyUzMhTILGH37ZnqSzS
         51VUTcXbvYwbh2v8NI7A6MZL5y/CFY8IQmqIE+g+x8ndWJ/Kihvjxw5qN03MLlgF15CW
         UPzlcdI+R5kYcrf/lWgLOFJie+tBXwaOek2pV/KqiiZiepT3/Dd0iWXjjQ98ZOasrT5Z
         mFqg==
X-Gm-Message-State: AOJu0YzxI5mq6WvhL66PR/09Opkjxqd2ZpkNqmCDChfC5EHZKeQbODGT
	Pm7PhDvNyhhZQJAsuhy0zunw75YNVaL+VvZ/qcA7h3gLyoVOD/yMZOxtdIJ4XisJGxHMF6iBSMD
	LNNS5hsQ7/+wEhPTMtOsSSUwmMFQ=
X-Google-Smtp-Source: AGHT+IGBE3m442OFPSFKIaD4s0w8oiH4KtHXqYGlMve49hpZt99OpEGH0k4+wFc+tMHavAeVzI/ao2/e/TaXhvsJpuc=
X-Received: by 2002:a05:690c:2b0c:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6e36415b8dbmr5703777b3.20.1728676565763; Fri, 11 Oct 2024
 12:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180716.139894-1-rosenp@gmail.com> <a60830f2-0a2b-48a8-a8d9-762983ff6fe2@quicinc.com>
In-Reply-To: <a60830f2-0a2b-48a8-a8d9-762983ff6fe2@quicinc.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 11 Oct 2024 12:55:54 -0700
Message-ID: <CAKxU2N8mb5HG3+8HFsPZwcMwiN4tF=dKpfFydXyPeYTUkNcKgg@mail.gmail.com>
Subject: Re: [PATCH 0/2] wifi: ath5k: add two PCI IDs
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, toke@toke.dk, 
	nbd@nbd.name, yangshiji66@outlook.com, hauke@hauke-m.de, jirislaby@kernel.org, 
	mickflemm@gmail.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:00=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 9/30/2024 11:07 AM, Rosen Penev wrote:
> > These have been hanging around OpenWrt and never upstreamed for some
> > reason.
> >
> > Rosen Penev (2):
> >   wifi: ath5k: add PCI ID for SX76X
> >   wifi: ath5k: add PCI ID for Arcadyan devices
> >
> >  drivers/net/wireless/ath/ath5k/pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Does the upstream driver handle these devices ok, or does actual support
> require patches that are present in OpenWrt?
No, there's no specific OpenWrt handling for these devices.

