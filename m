Return-Path: <linux-wireless+bounces-26053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D51DB15A04
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A147B1BA7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502A1F1537;
	Wed, 30 Jul 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PalwN3RM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21A1F12F4
	for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861941; cv=none; b=u2Cen8N07XmZZBGXEsYamjlk7+SObmkofkibIZwRoR38j+OiRMO+U8iJhCxv4guBbRnSskXtKqWjcZ7QxlKD18Iy7yvz21NUT6OqZQ7tkvcT3BAkPRRQuHgCtrdt4WHVVAYbUx1WZ7g1s2vcMN7ONER0lMvzHBU9MsN6xHnBprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861941; c=relaxed/simple;
	bh=6l1gAO/UvA1KSMRC0e4WN8jJW7JgF3A+xKhsibHchD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C2ZuXGQmuI9z/KdPNMBBVvu2q/0jawJG2S7suPWwtIFFwW4Vzk0rsCe4UH35yDvEPA13lNuXNQWI06MsKC880Xx3XfcH/0WVuKyjBIsqOke/MlYWybDmBNwkE9l+2hSjP99p1/K3nLt3Zj4w4r4fCJhfIPoRto5lmZyGDnzuuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PalwN3RM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b77b8750acso419857f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753861938; x=1754466738; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l1gAO/UvA1KSMRC0e4WN8jJW7JgF3A+xKhsibHchD0=;
        b=PalwN3RMJNjM8sDhG9Wxb8ARgZlum0Qv/0GJ0SpfdziWSxYsjQPwu+412wbHrhp/dv
         S4MWtV4hVXZ3hT9gPLHRVw15DDnB0bVTRFjn0lgcftlE83LKtOnkZCORVnuvEZJlUrzJ
         WpUvIMIH+OheS2yurrnWiPT7FuVPHsWRwDsXE+FpSXxhZAsJm1VXCE3t7IBJaMseIpgt
         Dft1y99APNOGDsc1xE5ctRkem1+oI1EIajPgZMq6h6Yqfm9zhMhz7OeAKX0Q9H4KqWhM
         nrMWqtIyzk9ceB2kUJuJpkZ1QiG1Id660NXc5fKGnge/BYq6vpsbqFYRdUmK7sWig4z9
         Mq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753861938; x=1754466738;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6l1gAO/UvA1KSMRC0e4WN8jJW7JgF3A+xKhsibHchD0=;
        b=XanvBiAoApzFrOy7wh5waU/VEwPYYwQQ2MO7ta4ZGzaDJC9YXgrTrTUMX2gKF2ZJ03
         /BTwSZjIXLekmGZ9vrwluv8dLZywUfQvEjqLRgy5ftFcVOogeir601qngEdrSlK41N17
         qH1jvFWYVV5PjT6GFUrQUlME6tMvqY5dWc3sYQEdFIdFmMVEHsRnT3oPE4pA2zyGREkz
         CV3MXZWRSjbHNBbX1sBZEUwWFIMstErrmcTZ/77x9O+/4IzJp0bITCmz9ArcReCCxYLv
         V/Ks/CV0VPAuzIe0y/6UQ60l+Jdg16qiJzg5oID/Rld/jvcYttrQqcgcKFXIFlz53iKd
         QrdA==
X-Forwarded-Encrypted: i=1; AJvYcCUeOXpUyVzgqL/WMWUCfVciKlzeMI+X6KvgbEnkcHNiRt7XXFVkFqfEwgFQRPpla5zNz+a+ebPu77Lv6vQUsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FK7+WchjHNAC+3tHhbW7KHmctMqyd7AbA0AAqdUlVzQ1dPVw
	mHrIjxeOLyY3L4dO5XbPGzSXcUZgDI5Cf7VCRMepRmmm3doQilcTr9aT
X-Gm-Gg: ASbGncvxZMhhdIVoJTYOpeTMfFRKfmTSWOpVwGCJjayLFo/nh9DilAOv8I/ZbtSCh5j
	9Hu8lc1sHotTPS67pLzzljlaJY9ZCaqTyFrHVShrfwn6Yokwb9Xu8Da9UsSweJnM4S4dw9nPN0y
	xXwWCfL57NleqCS316dBnNR+s41WnSpcPO6CajSEwyyamDCFvqZtmv2lQDM5w/WN6WUWN3G5gub
	Q3ZfsOEmac8y6YC1OFg/njZLGae+eyc0Q4mFV+cYL6qIoD0qhCPixzfO58fOPj9UBPMY4aB3KTf
	6ArGt3MargQAbYpL1a6YHJYZRPIv2aLzk4otK/rSm3IJ0aomM71uNmvFQTpXIwQYovGp60pwMDS
	KrAzoohTViBOOtlmQueZlmp+Plxsw9l4KB9G5nF+U
X-Google-Smtp-Source: AGHT+IEpfcshaEmI74+FRPGDA4WifzJapnTiLXEYiP3DH31K2fBVogP/EMh4TPJeVT8GPBF/IKYPlA==
X-Received: by 2002:a5d:588c:0:b0:3b7:8842:89f5 with SMTP id ffacd0b85a97d-3b78e3d5a20mr5041589f8f.1.1753861937650;
        Wed, 30 Jul 2025 00:52:17 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c1b8sm14750871f8f.56.2025.07.30.00.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 09:52:16 +0200
Message-Id: <DBP862N3JBT3.2NRSJ8BECF0YI@gmail.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: Missing BEACON_LOSS event
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Alexander Wilhelm" <alexander.wilhelm@westermo.com>, "Jeff Johnson"
 <jjohnson@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <aIjGvT+yQkZf8/Xs@FUE-ALEWI-WINX>
In-Reply-To: <aIjGvT+yQkZf8/Xs@FUE-ALEWI-WINX>

On Tue Jul 29, 2025 at 3:03 PM CEST, Alexander Wilhelm wrote:
> Hello devs,
>
> can someone help with the following issue?
>
> I'm using a QCN9074-based device in STA mode, connected to an access poin=
t. When
> the AP is powered off (without sending a deauthentication frame), the cli=
ent
> remains indefinitely associated. There is no disconnect, no beacon loss e=
vent,
> and the RSSI remains stuck at the last known value.
[...]
> From what I can tell, the function `ath11k_mac_handle_beacon_miss()` exis=
ts and
> is wired up via `ath11k_roam_event()`, but the firmware never seems to se=
nd
> `WMI_ROAM_EVENTID`, so the handler is never triggered.
>
> Is this expected behavior? Does the firmware need to be configured differ=
ently
> to enable beacon miss detection in STA mode? Or is this a known limitatio=
n? Any
> help or clarification would be appreciated.

Hello,

I've brought this up already on the ath11k/ath12k list:
https://lore.kernel.org/ath12k/CZA2NS7J83D4.18SU6W9R96KPY@gmail.com/
To my knowlege, nothing upstream has been posted so far by QCA.

In non mainline sources there is a patch to support ath12k:
https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.w=
lan_host_opensource.3.0/patches/ath12k/897-wifi-ath12k-Add-support-for-STA-=
mode-to-trigger.patch
My guess is that ath11k works the same way.

It would be great if QCA people could mainline this, it seems like a small
enough and isolated feature that could be pushed without side effects.=20

>
>
> Best regards
> Alexander Wilhelm


