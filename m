Return-Path: <linux-wireless+bounces-17757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F712A16F40
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761AE3A672F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8AE4689;
	Mon, 20 Jan 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzMOf7cd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624A1DEFD2
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387036; cv=none; b=cF4DPYYPenGddCCgFeP4BUhrIc9cRfU8+uiQSYhjt53QCGZ+oUvzYnXzjACN6V1JyspUGsQigu1Ca1q4VeoCZPkS5wvYWWhq+NX72EDgJhpaDV+H3XTC0udX3e3I433GOqZns0EMIS8mc7daixD/QlG5nfhC8s+lJwBM50pQx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387036; c=relaxed/simple;
	bh=EwM8vHrZfCJAlWd3az/ynReLWW6B1QyqxoDvOuugtXw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FpuhHsWBQ5O48b8MirGJBZrLZINlMbza4hRQV7P4DaaBX95mAqVx5Grfws+7qcI9VOYxaZOglgfOd5J8hQhwLbpwr/tG+4VNZbVtuYIWnjKRrLbWhCcRqrjJm+I5reqy7vQT7Uo0pe7vW5MzqSqOWT1s3IyxdOgw2Xa8r3RL24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzMOf7cd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso47491665e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 07:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737387033; x=1737991833; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwM8vHrZfCJAlWd3az/ynReLWW6B1QyqxoDvOuugtXw=;
        b=HzMOf7cd+6ReeE10P3FYdPcOQwQbw2lsGoRby+25pSAv74vt5670MOhRsvus2cv0I+
         TQSCIfIdbtNF05F1aXqJxyNUPLta/0gGsvkGb/JAf791523o1Mpjgstdd0VGc/Q7kuzv
         uLNwsO7xAI1kZCvEbEI3vLD9ogOYg6MmByLhozrd5Tq3/24OTuBmm+Y8mjLbeJUR2Hl8
         T4tGHYL2QBNuPYA6ExcZNNMoz3bVo2gWpVbkKS6CLwbhqAmWuhn2+dMqZe+EKFs+DrVE
         6XoKilGU1+UeBVcPLgTMbgi1LMeDcQXBc+59aSjoJNOv4uENIpLiflyfRcsWs8pzIQAM
         Fe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387033; x=1737991833;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EwM8vHrZfCJAlWd3az/ynReLWW6B1QyqxoDvOuugtXw=;
        b=Oya3vNGGkUqXwIs8vvTmaIuzTsx4takNWw6uMvNg2rcbx909AKtd6PysI8lzwtWmP/
         cG7HBFnMJ51ychR5FaGmPZTetfNxoPsZp68uSKbXWEEYX5yRY6kYlcGzq5vIu1B+UUb+
         rmLpJT7GramRoLbQMwLsAWNQp6wmJMU0/AInL/LS2X+M4ESw//f08gL3bga09fzUc+cZ
         99mr6AnOSNJow7Eas9mO4fGE4H+dYH/iMN3nT89crzwZ2EoX7YdGpdigwL4Q0vTcxPmU
         zb0bevgljv3lwDKxsJCtJvWlF4wReXfB2Ti5gvQuQkVsHT8dcRZ7eotTfz+LGJue4SGR
         Pt/g==
X-Gm-Message-State: AOJu0Yx4hTIGhe74wGuiKCXQua22U4zLWeQaLYtgfPBfUykdg9WMbmdZ
	KZEu3IBViOZpfd/1rFcox55EQmWuNNJQiyiPGhjtBAh7usk5DLUH
X-Gm-Gg: ASbGncs2bNoLtGNz2X6y7GnFsZtYgg/LrQ+AUeNDBIvp1Gpqbq/nVoDeVSz2/Cj7TDA
	nNVOFrp6rpc3fkGsrnC5RbocPq42fXO3JVpnFBPBJJdnT63X5GCNRTRZ5jqS+FK/Fx0L4Yx3Mcn
	eUlxebRK4HzevFCQ69oJkEyHHdYufAUHS1mQ9RElGnMN8Tr+hNJZuaoXXxVbwf8m1U5KDoyN1Qk
	TPojAg3FXaiMk7SHhUvH5pcA5pXRdG9WhaxJxUA2wxG4C8nwAdG5on7Pkp89tisDTtoeLi0n72+
	QcX70uZZxR9S
X-Google-Smtp-Source: AGHT+IHlyS8zLwt9rBRW+YcPDUyrHptF0iC0oVkb9na2U+vQHP3IKrzOIXgQ21MR6UbQ2DPnb1DKAg==
X-Received: by 2002:a05:600c:1da1:b0:434:a815:2b57 with SMTP id 5b1f17b1804b1-4389141c4ebmr106120285e9.20.1737387032338;
        Mon, 20 Jan 2025 07:30:32 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c6ceasm204514095e9.24.2025.01.20.07.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 07:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jan 2025 16:30:31 +0100
Message-Id: <D770AVPQZXIW.26SXMNNQTQ1PZ@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Steffen Moser"
 <lists@steffen-moser.de>
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via
 DISABLE_KEY"
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>,
 <ath11k@lists.infradead.org>, "Sven Eckelmann" <se@simonwunderlich.de>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250117191455.3395145-1-nico.escande@gmail.com>
 <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>
In-Reply-To: <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>

On Sat Jan 18, 2025 at 11:29 AM CET, Vasanthakumar Thiagarajan wrote:
> Hi Nicolas,
>
> On 1/18/2025 12:44 AM, Nicolas Escande wrote:
> > This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
> >=20
> > This as been reported by multiple people [0] that with this commit,
> > broadcast packets were not being delivered after GTK exchange.
> > Qualcomm seems to have a similar patch [1] confirming the issue.
> >=20
>
> This will re-open https://www.spinics.net/lists/hostap/msg08921.html
> reported by Sven. The recommended ath firmware ABI during GTK re-keying
> is SET_KEY instead of current DEL_KEY followed by SET_KEY. We are looking
> at other options like some marking by mac80211 for the driver to be able
> to identify if the received DEL_KEY is for re-keying. Also I'm curious
> if roaming between secure and non-secure mode is a critical use case.
> If not, we can probably go ahead with this revert as temporary WAR,
> @Sven?
>
> Vasanth

Yes, indeed it will make the original problem appear once again.

But from my standpoint, switching from encrypted to unencrypted traffic wit=
h a
config reload (without an interface restart) is not so frequent of a usecas=
e.

On the otherhand, GTK rekeying is much more frequent. Like once per day wit=
h
hostapd's default parameters. And from our tests it fails around 1/4 of the=
 time
with ath11k. So for every 4 days of operations of an AP running the unrever=
ted
code, you won't have broadcast working for one of them...

I would really like a proper fix from QCA, but in the meantime it seems bes=
t to
revert it IMHO.

