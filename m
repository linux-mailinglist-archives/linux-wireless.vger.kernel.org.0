Return-Path: <linux-wireless+bounces-20964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C9A75972
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAB7A3866
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B5D19F117;
	Sun, 30 Mar 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GkwJEvEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A519D087
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329347; cv=none; b=O+KWGwxpLScUhQIZe9oB/Tz1ZSSu4pkaVyGMSrrmBQ0rzkaaSOf907vWaSFyJG3ajMmoc4BAtHvv23xONVJi1uI1pMSzm9o5zEe5Lu6jL5cRxt5vZiuQO7MYoWIUt6Vcd5+mfEUxUqEWoVeUHb4YcQyXTAmIxtPgtPz5P/fd8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329347; c=relaxed/simple;
	bh=eZoDJbEllHkfwON8TzwlFyRaZAybs6sJMtNAq5+2UQ8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IfNVT7V/RVKT9K+cdojXmXtyDBIqLBCV4RFCA69bS5n8Q29g2SOxh7QjmoU7rJCUUjz2uRiwzupkoxqrGej5KNexFty2QOBGEZup4dfXE9pYCnwldSDYkU3qIC+nmuvPkY+Ly1Hy0R4rEsDo+fUW46/HyISySBQhulv5k8mNuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GkwJEvEi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so716122566b.1
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743329344; x=1743934144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZoDJbEllHkfwON8TzwlFyRaZAybs6sJMtNAq5+2UQ8=;
        b=GkwJEvEiwFaEAFAvbX7V4Fep1dcfbDO24sLhL05dnkkqb+hBbHHMKojTfQfencA+X6
         28bXhpGE2bZXJeGdhycTOKaWtsnWjN7b3WNHXXum2Vmuahww1icWBnFLSJQd8+Mtov98
         jxeCieH436mcZfXGw4IhPa7KweSSPO2VElGw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329344; x=1743934144;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZoDJbEllHkfwON8TzwlFyRaZAybs6sJMtNAq5+2UQ8=;
        b=XRE3KGKPI5lFPKmD6pJun3K6RMR9wgBzw01f4w5kwe01IzDvbKbGiWclj+1iVLqcJ4
         YSKkE7QnQghc7b+b3PUusLm6cSjxt50xdi2EcM8JLuDhkYNgERYIhDsAr2Mkpji1x2tC
         6yd/osGkylgfdf/w3UiX29VQW1iCMZ8up6G/H6CZ0qG+ujt5e9fTETTeGYTkNw9JAf2k
         ad8S8cbpuYaUK4dMVEBkp4tQrL+pgE6EXC2Gy3h9lPums/I4pIH+9/9F8l3pnW9CZ2JG
         zHA1IZmHgtawJCTQecl9Lwzupy9v52Rz8FRljO3XO7UGj+At27DGFtjzxztub4xggXTX
         U+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJkxvSyQshPxweeYcpP6eV4/MiESqPDfdewUBM8CpVL0DykB6d2UktFjwVsnRaaohzOSXscFfCI+MUAWJ2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IxXiUvJMUBOH3Yv1c6UUBOSJRxS63Q62rPUn7ixswanVMcTS
	WQwCaddZXCgpNqcE7xnRRCIAz2/OSY8q2C2NyRllksztP+whQuTb5tFoGlD2wQ==
X-Gm-Gg: ASbGncsoMPPYCI7Cps1B7RAD0S2jlw5frDQGg0BbIcY3PGP0+ytElhlTd5bM3diuG2D
	SiXVkZhXReM6ywRKllzLqwPYn4i5ivu758QVhvx/peU5CIrey2BM/yHfN1KENo7BriHiZ/NtEux
	hFcaYuYaVpIameG0S4kGjHSBG6iGcBrXSOf7RpZiWj3GPwUI6zkGEdrZsiugiQKwthwnSFTlbk+
	8Fu/1wAIam3mJjGqfxqDQictJ7zqduoi0ysOIbptav1BFeKHicM218RBQK93euo+uZKstMOBGIn
	5+e6pKqGOuzKmT7I3JcsHwjGHfgpbtQIC+mgEywmuFYENSvgnx6EDX7NVRlzuzP6rQUKWxbuz6r
	fpMWX8ViTGrQ0w8al1g==
X-Google-Smtp-Source: AGHT+IFJg4kUKiyT2B8lBy3TjPqrtF5fy65If7k3hF0Wr+PA0SEuX6wBhW6uPj6N1vgCiAhCTdyeDA==
X-Received: by 2002:a17:907:94c6:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac7389edb44mr421471966b.19.1743329344359;
        Sun, 30 Mar 2025 03:09:04 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dd46asm450485666b.160.2025.03.30.03.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 03:09:03 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
CC: <kvalo@kernel.org>, <jeff.johnson@oss.qualcomm.com>, <toke@toke.dk>, <jacobe.zang@wesion.com>, <u.kleine-koenig@baylibre.com>, <megi@xff.cz>, <sebastian.reichel@collabora.com>, <saikrishnag@marvell.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Sun, 30 Mar 2025 12:09:03 +0200
Message-ID: <195e686b618.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250330093505.22370-1-abdun.nihaal@gmail.com>
References: <20250330093505.22370-1-abdun.nihaal@gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] Fix memory leak in brcmf_get_module_param
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On March 30, 2025 11:35:41 AM Abdun Nihaal <abdun.nihaal@gmail.com> wrote:

> The memory allocated for settings is not freed when brcmf_of_probe
> fails. Fix that by freeing settings before returning in error path.
>
> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")

Good catch. Thanks for the fix.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)



