Return-Path: <linux-wireless+bounces-26058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC001B15E1C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 12:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534807A5FA2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4822FDE6;
	Wed, 30 Jul 2025 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr+iYfrG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2E376;
	Wed, 30 Jul 2025 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871246; cv=none; b=QkFq0mjSpKV7TFGSSwr14helW3tBEPSAUIlgArFtKIy+BujmiEIQFh+6jIP6LUpng78Yx4q/BA6RGy9vqK9g9FUbOVsmsLTeBF+4MyFX82P4tU5XRhUHs2jndGdk23TkCGgWrROtuLNUeALh2bjBAtXISJZ5zyfOFXP8twugHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871246; c=relaxed/simple;
	bh=eF3WqIIC5wYET+Scxxi6n3ZR4q0PcqI/QKYbd8y2naU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X84/RvLsB/VMdcOLDZcwMJ8gN9ObRZsVL1Idqujv7GcC9Jt4FNXSz0h+I+45axdQLRx4B1ml1HKBIGtHzsG0gmHpqoHKVcrPCUFwF3VQFCOGajXbD/mOiRSROAkh15V1iedzDYsH0MhTAfc9n36I9U9j5E90duzo+IXj8SmAsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr+iYfrG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so725778a12.1;
        Wed, 30 Jul 2025 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753871244; x=1754476044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JwDimZENQ6BRYQRivihWAM+pyOTBEBO4Xpawz0YeaA=;
        b=Pr+iYfrGWgRAXdboKlaMWEBwGkcIFA3D7ZlQcWbIeRyA3VIvQtctpuR6HZYL0fnHB0
         pQkNnrm/QsXaUbPABfgO2sN8BNWduHZGyT51Sg8BdcsL96cZVQpl1/a47nVcJ7p9zHZ/
         5Nsi4BDZ5FsMMt2Mbdn2b87mUJCLwuMkXjatnX5CgzgWrHulzLcpULxc5FAr39xdaAwN
         rc2lK6oO9XKNB/nKrW/xgHTOcF3UCzb45YlT4NJkYUzsyZfnbaVawx8xLdhEVdJ3VV0L
         LAJSIPVe0bzQ1zFS7BmCYtvsx+nsF0BOyFERGNqpQnmmbrHeztq92L3IK6wX/4aNam/o
         nICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753871244; x=1754476044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JwDimZENQ6BRYQRivihWAM+pyOTBEBO4Xpawz0YeaA=;
        b=n/fGFK7dXkLjsZ6L1rCg9+eRTvtgAS1916HQIpLPTimmI/BcoywkfUf3GMd01E7uGL
         9gtM2pFXhF8QfUKtCC3Klxma1+dUeBIeQU1ZazeMt5kauePXPWBMkDtrcL/BeG+ZKYU4
         MuJrNi/dWRhJIHuHDheRei0qap/i1Jy+N+qGqs9zinpKHsWw5qcH3qm7msTy+YCz7Yju
         bMBJ0NDOaYHZFnblt6Y5y4UheH+bNrflfPd6UZUZ4VOBh2eAEczJvXOZrujWNknmOmlc
         YaTeTOLttviNLXQpmj6h/ALO0XYRJ/UD4T3YDlZHz9WVvhvY3GG2fWiFP6jHj4EzKic6
         6H2A==
X-Forwarded-Encrypted: i=1; AJvYcCUHrbSQBAsjReOJxaDDKguEA1fb/8efjLbeCf2AfsBu+3O3Rh6ZfGbwO5ioFoCmzu5teQffciOBAEsgpXyONzc=@vger.kernel.org, AJvYcCWuShaLedN7a4qpJVN87jeYBUPRJzyXjp8sK+yJGncjPEMinUaFx05LWGvkiKas/qXHJNFJ//3tmZ1fzAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JTJeseLCvMqaTt9C+GoBxWRNFnNcGG04G57RenT881OVr+sk
	3baBaYC3toChUQ7v/TEVKomIv3WCwm5+MAVwVxL1Y+iMb2PPwFgUKkKuddw86UaQvevPnXdYPkU
	Q1GmqR11KGTwAtdc79kd8Y5tFn+VTquA=
X-Gm-Gg: ASbGncuzUQGkZzH7s4CfX4GNN/xm6fu18Lp7M1j2/Tcg1VClMmsGtDfg6jlv9SUXtFK
	GaUCw9FK8Sza1GqrQQVxzyrzfLhzEriyGsuIwsqBa6IKmH+Cxv6o6sftx4NZATWs29kE7hkWay5
	FEYdeoOGBEp26PqjeWeY+QgG1LlV6LTgENWmLJY2DpaGuKa8CAv7c+M3xUTkctEzfSRaV8KepQ0
	1PG
X-Google-Smtp-Source: AGHT+IGmCiJUv7xHnfE4I+rbXXA1tynSa+9MFrnx38xonR0gPR1/pDHCnn5RcOKP/H+fnJKJytSwSSmf4MeSz9peCBk=
X-Received: by 2002:a17:90b:3f44:b0:31f:232:1fa4 with SMTP id
 98e67ed59e1d1-31f28c9d0d4mr10353989a91.8.1753871244487; Wed, 30 Jul 2025
 03:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729152924.2462423-1-arnd@kernel.org>
In-Reply-To: <20250729152924.2462423-1-arnd@kernel.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Wed, 30 Jul 2025 12:27:12 +0200
X-Gm-Features: Ac12FXwWqDbK7oWALr9l0gC5L8v5UZUMUduHAH3u-H0QngVFvVHKDYQ-Q2GlkaA
Message-ID: <CAMhs-H9+fYEq1DuJOTsePZ=odhFV+66yzi8vqcga4jxjny3Uuw@mail.gmail.com>
Subject: Re: [PATCH] wifi: rt2800: select CONFIG_RT2X00_LIB as needed
To: Arnd Bergmann <arnd@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Johannes Berg <johannes.berg@intel.com>, 
	Rosen Penev <rosenp@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 5:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The rt2800 specific code requires the more general library code:
>
> ERROR: modpost: "rt2x00queue_get_entry" [drivers/net/wireless/ralink/rt2x=
00/rt2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_dmastart" [drivers/net/wireless/ralink/rt2x00/=
rt2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_dmadone" [drivers/net/wireless/ralink/rt2x00/r=
t2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_rxdone" [drivers/net/wireless/ralink/rt2x00/rt=
2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_txdone_nomatch" [drivers/net/wireless/ralink/r=
t2x00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00lib_txdone" [drivers/net/wireless/ralink/rt2x00/rt=
2800lib.ko] undefined!
> ERROR: modpost: "rt2x00queue_get_entry" [drivers/net/wireless/ralink/rt2x=
00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00lib_get_bssidx" [drivers/net/wireless/ralink/rt2x0=
0/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00mac_conf_tx" [drivers/net/wireless/ralink/rt2x00/r=
t2800lib.ko] undefined!
> ERROR: modpost: "rt2x00lib_txdone_noinfo" [drivers/net/wireless/ralink/rt=
2x00/rt2800lib.ko] undefined!
>
> Select the symbol to avoid this build failure.
>
> Fixes: 7f6109086c9e ("wifi: rt2800: move 2x00soc to 2800soc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

