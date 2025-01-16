Return-Path: <linux-wireless+bounces-17607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C75A13D8E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A30188D685
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DDC22A80E;
	Thu, 16 Jan 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NH8912f1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA17143736
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041002; cv=none; b=JE9R4b5fcFXVWW0lb8GbF37HtioWawWkG1ELW+qHZnHDqDEd+9sJukC2G6QVYFxC8iXPsTU/5OaQ1GBdblJX8Z74cR9XGleCy+x9m9cgBt/4K9DqefKtZ8ZPd4awVD1TPyCdnnw+XnW2aexEgb15OQVLqhlFWHV9etiwQSJQBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041002; c=relaxed/simple;
	bh=wOYJydZ05zexni5iCmfbSnSKDO8udCBwJm1DUOZXF3o=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Dq93BL44K4/TOmg52dKJqyfhBFmdbG5fLMFy+8pF1ptiL8gKrS7e3ccLY/YKcS+ICwT1KaWcomknalHDu5ArqnzuDMbsujRrngfwc8ettvKrrthtFUeECbAWDvVbimU5W+5+e87Z+aTcjJHhrdOJmWrXYmP/FnLaZYbxi25kG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NH8912f1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso208386166b.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 07:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737040999; x=1737645799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t6OHZijaEdtQho17KfYpalcxu3KfEafC4rmSzrPeQ4=;
        b=NH8912f1Pi3udf+12n0TL4K/vPDE2DttHNlZDb0kkXlpZJag+sP/yx5zRFsSdRKY15
         hH+mC7vK0mX7hW2VRwIq11Aoyl5PXrmJSMqOGSAEBslEbRfr0QXas5QyhS00DfZQR3oM
         fsfl+v+pRz19hMJ9JmXFvgXhHdoHwe0GgBk0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040999; x=1737645799;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t6OHZijaEdtQho17KfYpalcxu3KfEafC4rmSzrPeQ4=;
        b=WS+2AsHNbuNW4kAYH3yfrNs3efQ1rE/kHecSoQMqlsYAFCUP3ESBOqKEn0wVwvImAT
         5At9GqxwxWW2h3pexXbVflLt+Od8jVOjAU1fUOjiF/06nte7Ks1FGyv+jT5u1tlurJS7
         0nrU8iZAzdQ2M3IX2YWKEh/83KsuSGNzRay9wGdZpRy5n2IZon0///wKiK8gKs7LEKe9
         lwyabGvWymwKK+RgfM5WzCdHSYbDaLOD92Mkj7jtWU0wEFQZIG6i6Lf/NOm1lj72nVvX
         V9cKhYQsucB/lwgSWJ2aR/Zs5AcjVTYaazI/XvVA4Ld3Runyn4htK7OaOfawTIPLL99W
         4QpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWFZrYK/+rx85XcS1+pkkLmimU6pCScuJchUjIrS749EBI4zI1gu1cNP74132wO3wsDuVBdxJLOTpI8LG7MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFJ0NhfjPERKyKczAkdoX8Ek4f/aDx2/x2sGJG9WrGqK9NeDu
	33UpGOwFE+hEOekCeeu67zkRwxrd1Ephz54DPtmXnQ0+44RiO1WEjtywYbb5asJy7MtJ4Ggc+JK
	AN0dk
X-Gm-Gg: ASbGncsc1AH5olmo1a+ECCeyWxY9mvvFTWlJZFshFuN8SELtnILFRWiZ6/M7nm4mksa
	Yq/XEz0e2cOYcW/Ni9OEG0Z7yIyUb7B7eT95ck5LNk8zZK/UUMsKWg7P2Z/52YJVn1z/V8DxgOd
	SHAor7R6WhlmjarNxgWLFj/Jv1hXLmQukPs00kxJlq8JCqp4sPqEs9HgybFZAyKK5d2D2Dwx2lN
	MJ4cNJXNzRbIf86fRUXlrVCsyNK8oAo2TWQMIQl1pCgUhyWej5bzVztxH0jDEI79AHjIRcc6H3t
	RQxX/SXMxtGD3a/pPdY=
X-Google-Smtp-Source: AGHT+IESZHCMVm/ihlphauAy9omKbUvnYD/SIOp2AGMrCDzz4cC6qEyYek2Bns5dZEV3bLMLeDlScg==
X-Received: by 2002:a17:907:2cc4:b0:aae:ec01:2de4 with SMTP id a640c23a62f3a-ab2ab5f52efmr3024980066b.30.1737040999293;
        Thu, 16 Jan 2025 07:23:19 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1914sm10348766b.57.2025.01.16.07.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:23:18 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <stable@vger.kernel.org>
Date: Thu, 16 Jan 2025 16:23:18 +0100
Message-ID: <1946fb62e70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250116132240.731039-1-marcel.hamer@windriver.com>
References: <20250116132240.731039-1-marcel.hamer@windriver.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v3] wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 16, 2025 2:22:55 PM Marcel Hamer <marcel.hamer@windriver.com> wrote:

> On removal of the device or unloading of the kernel module a potential NULL
> pointer dereference occurs.
>
> The following sequence deletes the interface:
>
>  brcmf_detach()
>    brcmf_remove_interface()
>      brcmf_del_if()
>
> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
>
> After brcmf_remove_interface() call the brcmf_proto_detach() function is
> called providing the following sequence:
>
>  brcmf_detach()
>    brcmf_proto_detach()
>      brcmf_proto_msgbuf_detach()
>        brcmf_flowring_detach()
>          brcmf_msgbuf_delete_flowring()
>            brcmf_msgbuf_remove_flowring()
>              brcmf_flowring_delete()
>                brcmf_get_ifp()
>                brcmf_txfinalize()
>
> Since brcmf_get_ip() can and actually will return NULL in this case the
> call to brcmf_txfinalize() will result in a NULL pointer dereference inside
> brcmf_txfinalize() when trying to update ifp->ndev->stats.tx_errors.
>
> This will only happen if a flowring still has an skb.
>
> Although the NULL pointer dereference has only been seen when trying to
> update the tx statistic, all other uses of the ifp pointer have been
> guarded as well with an early return if ifp is NULL.
>
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>

> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Link: 
> https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/



