Return-Path: <linux-wireless+bounces-11719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAE95943E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 07:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587902847A3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 05:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A01547D4;
	Wed, 21 Aug 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TqWuK6zk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39F1667F1
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219312; cv=none; b=TACHdSnSmVu84nglIZWQ2b13ZH5yg2fmSvNLlLsUs11XCkSDCwZQDtD4S997wZ5JO83Wa1KpgqLuFa8fpY2x3wlq8XOF7MQnFBFbrnq/DPFjCn+HSS62u1d2k/gP+//bzxAZFesh65odlfFIk0lNnPpCq6BYs7nFsge/ZkpwsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219312; c=relaxed/simple;
	bh=J8x2jVHv24gpsGk/rvne1vdojygWNGLZKnDuhBA0KeQ=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mlrDYf7ZPrbgN1L0TdVYCjRcJ4C2NFUIsUOkMReQsJx6Qk2DlsoKkc+kcbe0Q4yEhIeMRHYE2+Bby6+u5cmC5D4WoPH16OLJ+Vnf8Lo7aagnwuYx++cXZ6AUnWJr8GthUfJvq4NgUhwJWx1uxpI9AwrIqGQMdWoEuU9L70abjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TqWuK6zk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3717ff2358eso3364793f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724219309; x=1724824109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nP3ueLvKs0/bHziLfGaK4Ey7cdFOtLdT2RqpBOJBVJE=;
        b=TqWuK6zkqVvFGC1BHMq+zP0OjQc7E3mEtmSLCNnMRRPRhXyIavkEFQPmf2JJRV6FC/
         iNbbUPEofsD0CF6MaNToMNtMjTgKLo/UP+0igZ+Jjvzm0yJxzJXttKPyn9g8+5JqkLO+
         Ge+dJdP8GFoCTrutT53wNBdXh7va1JCg+3n+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724219309; x=1724824109;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP3ueLvKs0/bHziLfGaK4Ey7cdFOtLdT2RqpBOJBVJE=;
        b=VxNnN40dQw1FR3GCMvkgWMYrxwCYdpEfhrAYBSOMTyAULp07Xfm3PTkDrI48AyBg48
         Un8eSlsJqy2JzhhOaM1/joO5gipzcygn7Q7Pywg37Y+OIQ/K2QhT+oU474+l97rkAc1l
         MKhjTinu3yLvT53T9zp2Ahv56DxCvosmcDvbfdY+j1beQNL70IqVSr0lsFBqeb1E4Vwb
         xECVC+Z+ili/5i8qgh2mKAUaimzrUgwENNSo8fzl1EFk9Bj5NUU41erF9w7c5IHgQCbi
         NcNcxqepq7cl5zT5qyiEK0r3GRfEicwg3zNWup93qRnovfsId3YDzfaec3yxVTg70vTi
         LJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt7aTZLbq11mcU6ECeleGN39ac6rIOmRCZiABRN3UtdGNuLNkAKIWiLlH3JH11khCLiXtgw5jEDRIcujoK5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpcPqmMaNNcs39QsIOz4tcfHetwv/lhsTqRWkSpy4096rCyKz
	kXff37zEpdcgbxkrUXZJPzoezA+sGb+L+3PMUSZuV7KgJw423mttAPMU0/GWkg==
X-Google-Smtp-Source: AGHT+IF9gb11komyzhf6yHRSBm6Bx0StIFXfTyJUrS6do+skd7QbjRTWFyt+VW82Aiajp3akvAAfJw==
X-Received: by 2002:a05:6000:4593:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-372fd576901mr551215f8f.8.1724219308299;
        Tue, 20 Aug 2024 22:48:28 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947187sm847323366b.166.2024.08.20.22.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 22:48:27 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, <kvalo@kernel.org>, <johannes.berg@intel.com>, <emmanuel.grumbach@intel.com>, <erick.archer@outlook.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Wed, 21 Aug 2024 07:48:27 +0200
Message-ID: <191737a8900.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240821023325.2077399-1-ruanjinjie@huawei.com>
References: <20240821023325.2077399-1-ruanjinjie@huawei.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH -next] wifi: mac80211: Use kvmemdup to simplify the code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 21, 2024 4:26:17 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
>
> No functional change.

Comment below...

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> index d86f28b8bc60..7717d7764d2d 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
> @@ -1611,10 +1611,9 @@ int brcms_ucode_init_buf(struct brcms_info *wl, void 
> **pbuf, u32 idx)
>  if (le32_to_cpu(hdr->idx) == idx) {
>  pdata = wl->fw.fw_bin[i]->data +
>  le32_to_cpu(hdr->offset);
> - *pbuf = kvmalloc(len, GFP_KERNEL);
> + *pbuf = kvmemdup(pdata, len, GFP_KERNEL);
>  if (*pbuf == NULL)
>  goto fail;

This is the only jump to fail: so instead simply return here with -ENOMEM 
and remove the fail: label.

Regards,
Arend

> - memcpy(*pbuf, pdata, len);
>  return 0;
>  }
>  }
> --
> 2.34.1




