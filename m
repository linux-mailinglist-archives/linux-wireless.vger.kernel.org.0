Return-Path: <linux-wireless+bounces-10226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144393147D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24731C2147E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0D18A944;
	Mon, 15 Jul 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3+qvv7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF54C66
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047121; cv=none; b=DjSrbsdCd904bkKhlda6cCN1ZVz+XMis8tltstVG1YplgLrb2nDNnSk7HoTAfSTmfmI4HrbrjAJWggESRzrw/UVQGVVCzLB5Ps1aGtLO42pphRPeT9dJkKBRtKOCygZ64wZNVTPg/4m8y7da7VJ3acbU8fq9en2eBCJMwCC3buI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047121; c=relaxed/simple;
	bh=625egKUUt0zMijPmUDUf+UR+mQK46NOOSdymowPAlRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hg7U8WbiMG3L4hfRfrA8WP3BsSwoGR1jYzKJ1qRGm1fLTBnUUsj2p3JXjtx2hybKuBLMwo3eRIwFHn4aM2C5WsV3o3DAzHC7YX1gDDjmYoWGn44cOKK235zaJNXG9nER85JHn9xHO6RQIaXAXb/6T9Jojijj7mnRaYfEo7P9+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3+qvv7N; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e035dc23a21so4212223276.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721047119; x=1721651919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sOGd8ILXqtgCUTYOD0O2ztRCepVHNWTEZZrqp4/PJY=;
        b=h3+qvv7NvaWi/aqwpHsn8n0dJZG/x88G/1T02VkT5RMWXiUQeLyqJxEwHVlNbjSMvY
         AQumcClW1JVlITYNtKi+JeMRBEVtBkK373bqcuO6cX7pFTVmiMRVEgTPKgq3K6tHS/2g
         nqRifHQ6vb+Z9a7HR4s48bmIey20RaU8RTImIDXLVKiDdxMyEuvPnlmLF8lQhRowz3dh
         1uPG/JsV5WmcgglK4Vh/VLWTX8fCE9ITsQnNqja7MrJ6luu4q5lChFru6cW6A8vSKvdM
         Tt//Yl6zRio2iUvUebuHapJ1jSXuRvfJsWFjz27+fIvlUC1Rklr/ofPOFOur72N12Y7n
         prJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721047119; x=1721651919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sOGd8ILXqtgCUTYOD0O2ztRCepVHNWTEZZrqp4/PJY=;
        b=KFHFA4+98Lr8WhsG8UKZVgdtoh4smRpny5Xt1MaXbjuW8PWHmKSpRbqi26dFKzqQTf
         72qtVLYcknreGDd5DwWWSxUqC2aFBL4iGTX1QkjAbdtEpEvq3Lp45VD/gJhx1YJDzCQk
         Hbbc/+IBsi690NVT1YXRU3d5OkgJ7YysVosRw2gxPHDHUp68gqG7gjp0PAziWyRmwU5k
         Clf2PmK0Kk1lSJx645NDZ1HYddY+HciVgNdvJNW/acNG3VMKdt+0Fx9veLLpnTFUFpEZ
         SmhH7EhtrVWIhPFLMSX3FRjGyBxxhlgnYNw7q7MxeyinaJkbKYYpwsav7duqe7NIpVZo
         FWHA==
X-Gm-Message-State: AOJu0Yy7Yc2Eu6N7OShgS1Qni9gjPb/bo5SqqEcpFMD61Xw1/tDUUdMa
	00Lz3ftuql3u4gsoFi5gtkxYVRwJdwrAix07BfFIkJSwXHc+pMaR
X-Google-Smtp-Source: AGHT+IFCvcgcaQfGPpFJ9QEedbXDxEOwKx34UtaDypeshbYxYIqQjai83t2PaptEzxeXnuk4AyQlXQ==
X-Received: by 2002:a25:84c4:0:b0:e03:2d88:13a4 with SMTP id 3f1490d57ef6-e041b137102mr21793649276.52.1721047118862;
        Mon, 15 Jul 2024 05:38:38 -0700 (PDT)
Received: from [10.102.4.159] ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619a54e9sm20936986d6.71.2024.07.15.05.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 05:38:38 -0700 (PDT)
Message-ID: <603104a7-a1ea-43c2-b0d5-fd4e46a27fe6@gmail.com>
Date: Mon, 15 Jul 2024 05:38:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath10k: fix invalid VHT parameters
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240711020344.98040-1-quic_bqiang@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240711020344.98040-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baochen,

I've compiled both changes and so far those messages are gone.

Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2

On 7/10/24 7:03 PM, Baochen Qiang wrote:
> supported_vht_mcs_rate_nss1 and supported_vht_mcs_rate_nss2 in host do not
> align with firmware's definitions, resulting in some warnings. Fix them.
>
> Baochen Qiang (2):
>    wifi: ath10k: fix invalid VHT parameters in
>      supported_vht_mcs_rate_nss1
>    wifi: ath10k: fix invalid VHT parameters in
>      supported_vht_mcs_rate_nss2
>
>   drivers/net/wireless/ath/ath10k/mac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

