Return-Path: <linux-wireless+bounces-17412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D40A0B5D0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D4A16752C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0722CF0C;
	Mon, 13 Jan 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzHTbNab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21E22CF07;
	Mon, 13 Jan 2025 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768085; cv=none; b=gOp+yWX3yk//fbV0ylN3xURpVOUaPDCywAWz7o9GIz0Ev45GPLB5VBF82joRTRbC8tIf5rx0ttQhx9XmAdpFMpbIO10SLR5VMyh2YWQdDJwQUa46S+CJWVJtcEG2G80bjy+LOEP+UeA2xQRb1xtFKIs6iN8fz2ytyiBieyMK5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768085; c=relaxed/simple;
	bh=+usBpp/aW2WuI3wyOuA9fXlF8fPBXtOJOTl4n2HkZpY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lUJ32r0LVIEPt+G28sfQw8bSkRUR16T3+OAIJijdDY23bKbVXG5tA2wXL9qjbU0ZmWY7JR92pNQOnnhfh97+6h2RK+b+pRDf3pY1cwQRfzRd+LvqhcGBJy9X2zxV+ZgqBGpBtULQdEFOEggnJFpP+wX2wdz5VjXEBz3DZBU9yOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzHTbNab; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283d48so29519565e9.1;
        Mon, 13 Jan 2025 03:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736768082; x=1737372882; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+usBpp/aW2WuI3wyOuA9fXlF8fPBXtOJOTl4n2HkZpY=;
        b=JzHTbNabzwTcA3IfgFnNd/sURHVnxRNcvKn+vEqIgNVTVHYcWl7Pc9XoGvpeoOAt1y
         hHp5+W9P1xMjYcJKDCmXF/v9nf7+Xs6Qchnn+8PIWvUhKBpMUMeHqXUmBlF4LKvtl+Fh
         eKVeYPP2nx8hRyU71u2WYq8cSlnNOMXMOITCbzCLYx2Mmr4p9nAPvifHTzsD7eysoqmC
         yjg5BzJi2TieQ2LiLthHlQs7J9x0J2hN7z8H/emoKn1zW57d91ohGMZfs21ln4uja0dM
         fm7wVX6qGfowivBoKyCKXoLzpB7TE3WTkEc5tRnrd6keFD6Zc9huUe0YD4AmOMjl0asn
         O3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736768082; x=1737372882;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+usBpp/aW2WuI3wyOuA9fXlF8fPBXtOJOTl4n2HkZpY=;
        b=pZHbmKUyJFtjtDAMDMeXytZWOx7JGD3LdsJco9z1KhL7HPbKVdR9iuu4oZK+VuZPqQ
         fGmb5yRqjnaEltr4Y73jUDeJrPv33YWCwxCw2dm8S7gsBt77KIBEjW/ppIUaeqcnMNdS
         jXDTQhq27YlJLb3p6A7PMA24TO6TBNsNqWVZECOAqs6L8nDPI2oR3c0kN2kI5sdD5wVc
         anAzZafi8/RN7w8lzhQA+cMUDxgkl/2C2johmJb9dDoSv4qEOjS3J/Wanm2iKbzqq94a
         6bX+BEQKhqN3nihF7znSLhYyI/lKqocOHymrMWPyReRo/FvnQv1/TVGjTjxPgO5Xayia
         oJlw==
X-Forwarded-Encrypted: i=1; AJvYcCUkJM9ACRiihg83JMg9Lczf0tuGerXZ1JyDpc1yQpUUSQeOHUcVJ9AAmKtNFR53JJQzYTvUZ108+lKZqyoZC0k=@vger.kernel.org, AJvYcCVYTTYBhJKJJR6t0eMH1xJYDVjupIZBnKJggF6Xb6NDqoVxgRqda06gEggFbfd2rizaYZX5ErizzCSoXZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Qn51OxaG2ZDSs84KDvawpsCG0MJV56Ix5iyC8T3rcqgpbxuO
	WqhyhA+0sgkzUSjHY3aQZqTf8AH0q32ia7NOiVxpjleNAxp9bmyH
X-Gm-Gg: ASbGncsf1twY8Y4bZRrrZjXPPnrMnujd9j47TgWtc6RlUcvxxuakZERoahw8UUvuNo6
	2Bw7mxYmYMQ5irdw7Pq+WzXdin9PlIzGuxGWAjYkbolBMWv0hP6Okw8oSM4SnzqeudulxPt1tzk
	OZSnMwJ4yITNYKzgqyK74phWhfa5ew5+QReSqOq5WMwXaml1/zspIsPiCeKzsSMF+Div5rjlDYq
	DgEd5EAszT5KuSX9lIG6jMig3ju9uz6k5/QLH9zzCLe7XPzW6GgpoxLfsPSHCqmYyQr8EKmmV4=
X-Google-Smtp-Source: AGHT+IFupkNx0dLFod1XbLENSafE4AHbOagVfykDLEn84SJo2Wt7Nexd2Y/bmUTy821uCYEf8IHt/g==
X-Received: by 2002:a05:600c:45c3:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-436e26e554cmr155607175e9.24.1736768082293;
        Mon, 13 Jan 2025 03:34:42 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d69sm140008175e9.30.2025.01.13.03.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jan 2025 12:34:41 +0100
Message-Id: <D70WWHYSPEY6.2TEXW2PF1C8SX@gmail.com>
Cc: "Kalle Valo" <quic_kvalo@quicinc.com>, "Jeff Johnson"
 <quic_jjohnson@quicinc.com>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: fix key cache handling
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Aditya Kumar Singh" <quic_adisi@quicinc.com>, "Kalle Valo"
 <kvalo@kernel.org>, "Jeff Johnson" <jjohnson@kernel.org>, "Rameshkumar
 Sundaram" <quic_ramess@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>
In-Reply-To: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>

On Sun Jan 12, 2025 at 6:53 AM CET, Aditya Kumar Singh wrote:
> Currently, an interface is created in the driver during channel assignmen=
t.
> If mac80211 attempts to set a key for an interface before this assignment=
,
> the driver caches the key. Once the interface is created, the driver
> installs the cached key to the hardware. This sequence is exemplified in
> mesh mode operation where the group key is set before channel assignment.
>
> However, in ath12k_mac_update_key_cache(), after caching the key, due to
> incorrect logic, it is deleted from the cache during the subsequent loop
> iteration. As a result, after the interface is created, the driver does n=
ot
> find any cached key, and the key is not installed to the hardware which i=
s
> wrong. This leads to issue in mesh, where broadcast traffic is not
> encrypted over the air.
>
> Fix this issue by adjusting the logic of ath12k_mac_update_key_cache()
> properly.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Fixes: 25e18b9d6b4b ("wifi: ath12k: modify ath12k_mac_op_set_key() for ML=
O")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---
> Changes in v2:
> - Add 2025 Copyright

Tested-by: Nicolas Escande <nico.escande@gmail.com>
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3-03253.1-QCAHKSWPL_SILICONZ-29
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

