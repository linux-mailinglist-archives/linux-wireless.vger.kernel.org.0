Return-Path: <linux-wireless+bounces-4448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D88749DE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 09:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548F31C213FB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865E270CAA;
	Thu,  7 Mar 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="cJShu0by"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF6657D5
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800779; cv=none; b=P3KqrFrYY2Y/0d6sSo9USKSx1OeYxOzugWfuGPoo0lML4IaML5elYRkwEV66npR3YJ0c21QvjoJhlJ66971uCIZzjz0Gilt+8m52EB2eLFmapnfS9FTWTQZ2g9f2juyWoqCwRv4yn6x2PIEt3QbWbpZcDnLPbcgbxZuLnaozr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800779; c=relaxed/simple;
	bh=hS8zu4sRYSZWgtYsgxH06GASLmu07y/0dobyT5SPg6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVFNaf5f3uTdwH1zbnw4iRMkCKq7YZd2Lxt41oVeSs6rGkSNddGLWGKlCq84K8cE6/XHGKs7FAAmxJaigVB/5mF10+dZPzyrrlL3UVXvXYmEq5eIh7XY1w21MLZfihzE0Dfi7PpPP2PPiVJyrrOpnqx+m0n/okZH/KX/4bQiePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=cJShu0by; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2997a92e23bso351040a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Mar 2024 00:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1709800777; x=1710405577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS8zu4sRYSZWgtYsgxH06GASLmu07y/0dobyT5SPg6U=;
        b=cJShu0bywpR69DEgMheGIQtf7FiaYZjQybyX65efDlN4n3g7QSmY+qccBNGJsuMEXE
         UEK6LzecOSEvFJ+bBIPcNMjLwPVB42gaYcBVOevjqZxnT7u4PrzAj0k+T1JwkAzpessQ
         ExudqK8HxQbcvpvlU60zn9aUFhLEI3HidVxDLpikQqIToG7di/h0SJjr+FA+cZenQdhm
         M9o9ALqzVQ2oykhWd9Wm6ZlNxNpHKh7yCPDS4j0oQ8k3tyxd9v5mQO+fbRnC4gD2Nihh
         Sd8f+clFv7GSh3XqMRsFRrShqthzJB55vLxzMOr8oraM/W3mF2JSgXbZA0zjVW576hRi
         tAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800777; x=1710405577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS8zu4sRYSZWgtYsgxH06GASLmu07y/0dobyT5SPg6U=;
        b=fILd/e19V+gtZJCpXg+9sORDfy6itx1K0aD6pLHxaxHNqJvFmnkf5iR68S2Dlm19wJ
         XONHh/emQPx2ifi+ugDWPftcLXK3NKM1NvB29/VVr05MVcaeZpSpxPJwY/O0tqHq2Qtc
         m3qSstf0oE4Ubv/niIGf92zfKij/TULYD9ENMNqulA1YQr/pihCzlmqEFW2cEPaxiVMt
         HDJl5Kq+MwAqoSpVO1IJVz/+bb6ouOj5fDXvkS39poRMatTJ9rj4VCRt20MSEvsvNBMO
         X+AnzyQpTINYh+SJvb+dYFZ0TYuYb2Z9frzzqwRZGXoQVrgNFtTmHc+KqjG6CgCVTql9
         QxDg==
X-Forwarded-Encrypted: i=1; AJvYcCWpbM054XWeb8oeW+7DwmXzRY0U/4+EHkCn12MOy1PI+vHVW7g+mQceFFue10dk5OCaKGmjEb4BtpCbihIV53bc4HT1Nqnyl16sGAruwsg=
X-Gm-Message-State: AOJu0YyC/LtKatkdpKq24b9SgIntOMNSQoycpnFE8loS1mX4heJSjq08
	RTrNYuiEl6zpn36t1C7/b9NIuZft7qCRgRZDsB+uJKk66DQRFtVAzSEK/mJNH2uolTGpMShwNgu
	S59ZVIztcoVolx7D+8UzqDxuJRTQCRj6O3zL20w==
X-Google-Smtp-Source: AGHT+IFtYoz85x+BrsyL3WDeniAwghS6EjRoEeJUdL1XSOqljGL47ACIuTJtfbK74x/u65ZmTCLctG2MbKAUjQXLWiY=
X-Received: by 2002:a17:90a:9b02:b0:299:2807:1eb1 with SMTP id
 f2-20020a17090a9b0200b0029928071eb1mr16879947pjp.34.1709800777227; Thu, 07
 Mar 2024 00:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
In-Reply-To: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 7 Mar 2024 09:39:26 +0100
Message-ID: <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
Subject: Re: New staging repos for ath1*k firmware
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>, 
	ath12k <ath12k@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, Kalle Valo <quic_kvalo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 8:23=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
>
> Historically, prior to being incorporated into the linux-firmware
> project, firmware for kernel.org ath1*k drivers has been first published
> to Kalle's GitHub:
> https://github.com/kvalo/ath10k-firmware
> https://github.com/kvalo/ath11k-firmware
> (ath12k firmware was pushed to the ath11k-firmware repo on a temporary
> basis in anticipation of this move)
>
> But in order to have repos with multiple maintainers, as well as to have
> a hosting platform with more control, we have moved to CodeLinaro:
> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>
> Note that most people should not care about this -- normally you should
> use the firmware that is in the official linux-firmware repo:
> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
>
> You should only need to access the staging repos if you need a previous
> version to work around an issue, or if you are testing new firmware that
> is supposed to fix a problem that you've reported.
>
> Please let Kalle & I know if you have any issues with these new repos!

Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as well?

We have added IPQ6018 support to OpenWrt but we are forced to use the old 2=
.4
firmware since anything newer is crashing on IPQ6018, we had the same issue=
 on
IPQ8074 but it was fixed with 2.9.0.1 firmware.

Even for IPQ8074, there is newer 2.9.0.1 firmware that is only
available as part of
QSDK and the community would benefit from being able to use it.

Ideally, ath11k-firmware would at least contain the same blobs as the QUIC =
repo:
https://github.com/quic/upstream-wifi-fw.git

Regards,
Robert
>
> /jeff
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

