Return-Path: <linux-wireless+bounces-29125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B06C6D5D0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C06C335F1E6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DA280339;
	Wed, 19 Nov 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ5sgxj8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FE2EF65B
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539799; cv=none; b=bK1t1v3A3xsGt7Fdfg2+DBtJUR9sMx+ntoAiuEWrmlmU4JIRnnF134r1xrGo1CbFmVWBlsRuaUEqMpc+Uh5P/kmpOdYnQHlWzzaNsDk7Wy/yLoam/YHOGL7lQhcld8czLNR4kQlGc0sOrUhD+OqslRcaKl0EH1Nkh58xPNnYUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539799; c=relaxed/simple;
	bh=7KXRYpJkWJZQ9A1K7/LhsK4rygGf/YCjrD0wGLFgJOo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NC/X0MQQuVhI8aC5283ITRyAPFxrF4ILRPNaUBGrAstD9TvVJkFWlBpwa0s3QeqRqahhnW7VrYZC+awPnGv5hNF00huJm5IZGnSs+Iv3B+ayl0v7SKuHi2CA0MKdC6+lNg0nV2RMoDSru5Ak+L3QSb9BtFjBShZi+mvkQbd/GE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ5sgxj8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so5943588a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763539797; x=1764144597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a39qS9THoZoyW40hqoMxyri1LtTdUt2BE8ZMUdYz3xI=;
        b=PJ5sgxj8cZBL0rTYmUSNxKwbkZmnnRtEe6VnQqIfFy4oDke/v5bGu00vOZNDvl9LKv
         Qdqod+tPjwH24y6hGthaXG9RsNTqZePfKYYErXRdsKQPhw4YrGW+AYwySkEkSUI9Vkur
         L5xn5dY2/mK1NKEwd6FsqwmFjbi5hBLi6jdmAV9h+OSdMc+Db8TiL/hEkq+EncLbQUZA
         hqylgnpCPI4BysO/lV9XWOu5UUUhH4hHk5brwMuntwJT+d/DW+mhPJi4cDizu65RMncw
         eS2bzTvCpxF3jHpsuygLiwrT8GZXgUsUyfYV3mt4Q9vLFh6UhNGKU8nsLxMHovFfu3Y+
         9fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539797; x=1764144597;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a39qS9THoZoyW40hqoMxyri1LtTdUt2BE8ZMUdYz3xI=;
        b=oYqCFVEdJKXnS37G1+zfP7AuddGK956xyELiMo2LBsq0ep+lq77zjb7g6toIisflxy
         /5b05TK/89+mL2A3dWMaWG2qtDfA6LH/Tb9Y5lH3/PrAZ8dpVkr591QhQNRvM8WH/Tiu
         zx9f71nUTmL8+dqsKTEaA/294sO8V6PzvPUUZ6zSh0pG15MWNiCdQIdoWatAnUyx1rYv
         +2HLUZh20Cef3c7y/1WRNI+3qSDYqUWTombh4J8u9BYlrG93wkRMYMASJ+c2ig4jTbWL
         GomDEe4Ym2YM8BG20RPUVBqZ4CCRyA6Vw0eZiaq5yLTxzZHQ873oVUuOIWyDVxEM/U8f
         213A==
X-Forwarded-Encrypted: i=1; AJvYcCXfZg3XwnaGlFyS8lWB1hpr/opAhh9Ymy9ftQXhXbRDkl3c5E80uTQfAaWjNKMX18+8WWOlR8KROaX6+MLAag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwImED1y7PJZq45Rv1wzXP5MU87m6gH/P3ADrLfN7mnEFnyZyKr
	+jDoVyXwN7RRVZzn+MZkOGJ8HKFC3+zE920HZRC0wbWr6ijV9bYvwOCVS4wlo+qBT5Ga8he51OM
	0h2hvjRHNLyHxVq7H8Kj2ON2+r7tXWw==
X-Gm-Gg: ASbGnctLgTkEUC+s+rMRAFfbfiGeYqGTljWTU+nXjrn4AxVNmlJfxRpJbWVsHjf4DXl
	ZKomYaFVURxcr0WMERzvmVYGZeZVrnpmQNO4NYZmnpgm49JbuUEpUiDj/ro+zVc++0M88NEVgAK
	ycTEKzDeyXPcGxYL2EnsxCF5RNwCyBoO73qZvWBv80ZzqIfuVPIRlfD8OX+m5/2IB/E4Dfbqt+e
	PqSn9RdDN56O9e9B2mA2zNWYZ69c4Y9o0cwppnQIIxClIT5ouZ2e4mZjvS+n/HJed4ZyASF4ciS
	WlY=
X-Google-Smtp-Source: AGHT+IGRwjPAZWI/LkmCbmFjssIGAPewHIFhCSWpNS3Ld2uk5GBPL1IBVqYl8F3Cww50AryvRZGDWVS+bLrBXzVMrm4=
X-Received: by 2002:a17:90b:2244:b0:32e:7c34:70cf with SMTP id
 98e67ed59e1d1-343fa754977mr21837353a91.36.1763539796542; Wed, 19 Nov 2025
 00:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Wed, 19 Nov 2025 09:09:44 +0100
X-Gm-Features: AWmQ_bl44G0Px-nO8xsutIR7OZVzuzXJR2Pttj_Gy95HLVR9iwbtIHW4E_siwJM
Message-ID: <CAKEyCaD8RMqPvwZOxgwAT4G=h-M94ToxoSdYwCjfvZMiM8mB-g@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After this change, IPQ8074 crashes in STA mode:

[  165.110962] qcom-q6v5-wcss-pil cd00000.q6v5_wcss: fatal error received:
[  165.110962] QC Image Version:
QC_IMAGE_VERSION_STRING=WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
[  165.110962] Image Variant : IMAGE_VARIANT_STRING=8074.wlanfw.eval_v2Q
[  165.110962]
[  165.110962] wal_tx_control.c:823 Assertion 0 failedparam0 :zero,
param1 :zero, param2 :zero.
[  165.110962] Thread ID      : 0x00000062  Thread name    : WLAN RT1
Process ID     : 0
[  165.110962] Register:
[  165.110962] SP : 0x4bfd5ce8
[  165.110962] FP : 0x4bfd5cf0
[  165.110962] PC : 0x4b107f58
[  165.110962] SSR : 0x00000008
[  165.110962] BADVA : 0x00020000
[  165.110962] LR : 0x4b1076f4
[  165.110962]
[  165.110962] Stack Dump
[  165.110962] from : 0x4bfd5ce8
[  165.110962] to   : 0x4bfd62c0
[  165.110962]
[  165.157843] remoteproc remoteproc0: crash detected in
cd00000.q6v5_wcss: type fatal error
[  165.180083] remoteproc remoteproc0: handling crash #1 in cd00000.q6v5_wcss
[  165.188416] remoteproc remoteproc0: recovering cd00000.q6v5_wcss
[  165.221076] remoteproc remoteproc0: stopped remote processor
cd00000.q6v5_wcss
[  165.485399] ath11k c000000.wifi: failed to send WMI_PEER_SET_PARAM cmd
[  165.485443] ath11k c000000.wifi: failed to setup peer SMPS for vdev 0: -108
[  165.490829] ath11k c000000.wifi: Failed to send WMI_TWT_ENABLE_CMDID
[  165.497736] ath11k c000000.wifi: Failed to send
WMI_BSS_COLOR_CHANGE_ENABLE_CMDID
[  165.504283] ath11k c000000.wifi: failed to enable bss color change
on vdev 0: -108
[  165.511671] ath11k c000000.wifi: Failed to send
WMI_OBSS_COLOR_COLLISION_DET_CONFIG_CMDID
[  165.519136] ath11k c000000.wifi: failed to set bss color collision
on vdev 0: -108

Regards,

