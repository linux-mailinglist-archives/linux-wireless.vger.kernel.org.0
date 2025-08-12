Return-Path: <linux-wireless+bounces-26313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CCB22737
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 14:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5328E3B79CD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FD1D6AA;
	Tue, 12 Aug 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNUI/gn/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B183C2F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002549; cv=none; b=LR+8wY1YZ0Dp08CZPij9IFDznJ6lWb4br3FkOaFkiI54rwA4FRXlE07NvMN0MJ2iyXjCT95qWHx0EwqNjyLiGqPLCWlc3B5rKMHsEO28ZpSrSnwD8dmUk8erOVc6IxgnlFc5Zc/G6SisXJ9hbah/Gkcj2f05nDd/8xfUoBGFyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002549; c=relaxed/simple;
	bh=42ayFRPT6aNxOO7jhq6Z5xBdQJ5wshjj1ZEEOkKamCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hqNh1JlzXmp5F2IBmJmpYNtQP5WqewtR0syTzggOr/sgk+kPepV3r5lWxy7DDjlJ/8GNgJ7RZdNbK6/mQP9Z3n6ERssHkKmfdylVI/noUe6K8MPKgX0ReoBKTwqswFPJFDyooID+nTZSn/x1XywqDxLY13qSWjdyBEOu0BGs2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNUI/gn/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af934d7c932so711855166b.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755002546; x=1755607346; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42ayFRPT6aNxOO7jhq6Z5xBdQJ5wshjj1ZEEOkKamCc=;
        b=nNUI/gn/ecS3tLreraHxGQ4BtdEY798NdWivjWeV69/mwXGRNwEktbHskImZiTHLYx
         Fb0WSIKKwgpjsAX7jAmuzpzUIQaQ/N/6kOT259pp8Aw75ZrvkYOpJT7M0A1624JeUq7l
         8w0VJm2lsIpPKranQhCgcCZ+75z6rdp3kcqv9ZepdzlCi0eHkU0Uu0CLQHPAWzlm/Egc
         aCY69LW+xfBosSl4edcFd7nUUYYk98/HXQ1hau816dRv/yapN7nNrlspushEcRM+O8ux
         5iEkwEHvBXObsHt6X7cOSe7zufekcmWZmKTiTCtaxwcn6KXdO7jq9GYgsB4NqwzlhcYb
         M1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002546; x=1755607346;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42ayFRPT6aNxOO7jhq6Z5xBdQJ5wshjj1ZEEOkKamCc=;
        b=R8bJKKV6nB9O+QuJ+JOwCZSduICk1vYnn2TBqnnEZU+8sQ9E1G6ZgbUxZvnHdGdIvz
         58sKs1JhzC6NP/K5J9xVI1EC/p6hqJq+72SYdJrnbKzPNYWmfKdmVRk1t+mCeQ8M4puz
         CIFUfV00wrvwHsUBIyzFI1+ClLuPb4j4Anj47yh2XtNH9dnSuBUc+z/DyOvbmnvGSIY3
         gBWkJ7890s10vgkCru9sSdvDWXd/K8GvNj+ibQy15T1axlDhyxjWhEwvC8XOMfzg3hDK
         J9F1s3SJvBixF9JAoLjQTyHUKucsUcB6KuGzKlreZgvykqyn/qOi3Wi+JBA6ZnMZ/k1d
         n5+w==
X-Gm-Message-State: AOJu0YwUq0q75nmAeGjTRd/IeGeRHNwR+txOf7DwB6tPw8Sf+zXOhHLN
	Zi7MJFpDZkalOqRpiDugdZ634snd+E0iVwKfpAZV4Rj/j5AoDIxLdED2
X-Gm-Gg: ASbGnct//3sb225EScX6vTVedCxx7JxbpvEZk3+ogAjGIGb7KPuQCp4MlNnHmpa3WiY
	jVK3QCDn+s41EfyJsXg1ZrR8glI+ak1B3vqyr95nhLcGDS3ssV2gH4EQD0O9UVGStvTmSOWE4CG
	vyHnhryePeKC+e2HsTBY7MHy+AANjNhi5amclY6TVzmt1XWFb0BWyFwQamJ8wV8S0wwEjo+c3xB
	zYzR7AuO9f0CNiq4zvhfDNpDBf6GRvC7L++vxBu145IKqh1daLaVMK1l3/xI+2JYIorHoouyj+o
	60p37/zS8X+6Kiscw7pHg9QQEmNJMq623xFRTQYWgsSVbBjEfO4oW9IfyGL1pKzaSvsdFVDWM1N
	yWue4Dqs8W/v2UI9as874q/hYNIDwHh5tEcJk+nf5
X-Google-Smtp-Source: AGHT+IGehJbnB+OBaiScVaVRsVwqbQ2E/AdbTXgEuigH5+pk3WC5SfmkgvYVXVsb8amFtKB0t73rPg==
X-Received: by 2002:a17:907:72c9:b0:af2:7ccd:3429 with SMTP id a640c23a62f3a-af9c634faccmr1446529266b.9.1755002546213;
        Tue, 12 Aug 2025 05:42:26 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3149sm2189511766b.38.2025.08.12.05.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 05:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 14:42:25 +0200
Message-Id: <DC0GHB14QA8H.3K1CYOEI1AXNY@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Steffen Moser"
 <lists@steffen-moser.de>
Subject: Re: [PATCH ath-current v4] wifi: ath11k: fix group data packet
 drops during rekey
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Rameshkumar Sundaram" <rameshkumar.sundaram@oss.qualcomm.com>,
 <ath11k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>

On Sun Aug 10, 2025 at 7:00 PM CEST, Rameshkumar Sundaram wrote:
> During GTK rekey, mac80211 issues a clear key (if the old key exists)
> followed by an install key operation in the same context. This causes
> ath11k to send two WMI commands in quick succession: one to clear the
> old key and another to install the new key in the same slot.
>
> Under certain conditions=E2=80=94especially under high load or time sensi=
tive
> scenarios, firmware may process these commands asynchronously in a way
> that firmware assumes the key is cleared whereas hardware has a valid key=
.
> This inconsistency between hardware and firmware leads to group addressed
> packet drops. Only setting the same key again can restore a valid key in
> firmware and allow packets to be transmitted.
>
> This issue remained latent because the host's clear key commands were
> not effective in firmware until commit 436a4e886598 ("ath11k: clear the
> keys properly via DISABLE_KEY"). That commit enabled the host to
> explicitly clear group keys, which inadvertently exposed the race.
>
> To mitigate this, restrict group key clearing across all modes (AP, STA,
> MESH). During rekey, the new key can simply be set on top of the previous
> one, avoiding the need for a clear followed by a set.
>
> However, in AP mode specifically, permit group key clearing when no
> stations are associated. This exception supports transitions from secure
> modes (e.g., WPA2/WPA3) to open mode, during which all associated peers
> are removed and the group key is cleared as part of the transition.
>
> Add a per-BSS station counter to track the presence of stations during
> set key operations. Also add a reset_group_keys flag to track the key
> re-installation state and avoid repeated installation of the same key
> when the number of connected stations transitions to non-zero within a
> rekey period.
>
> Additionally, for AP and Mesh modes, when the first station associates,
> reinstall the same group key that was last set. This ensures that the
> firmware recovers from any race that may have occurred during a previous
> key clear when no stations were associated.
>
> This change ensures that key clearing is permitted only when no clients
> are connected, avoiding packet loss while enabling dynamic security mode
> transitions.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ=
_LITE-3.6510.41
>
> Reported-by: Steffen Moser <lists@steffen-moser.de>
> Closes: https://lore.kernel.org/linux-wireless/c6366409-9928-4dd7-bf7b-ba=
7fcf20eabf@steffen-moser.de
> Fixes: 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.co=
m>
Hello,

I've just confirmed that this works well for my devices. For the record or =
if
someone else wants to check it, I run an AP with a short rekey interval
(wpa_group_rekey=3D10 in hostapd config) & run a continuous 'arping -b x.x.=
x.x'.
Without the fix I loose broadcast connectivity from the AP to the STA like =
once
every 3-5 rekey. With your fix everything runs smoothly.

Tested-by: Nicolas Escande <nico.escande@gmail.com>
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1

