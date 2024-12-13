Return-Path: <linux-wireless+bounces-16374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766769F0C43
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A0B28205D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE338DC0;
	Fri, 13 Dec 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g6uh2Dao"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37D1C3C0F
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093059; cv=none; b=CVZdyx2fQEK23vb13a90hMAtO169gvIxewHIDmhgRfY7SA0DEkQlMT7QPfQfoKFPCmg7GmLpR/7uybickt25MWo5f/SBbwO9nzAxziO5nQxAHhjYbQyQgwcxi92K7428FVkqvv+VxGlNTjo+8wubCm2aBBLVRkj/OKSceK8I4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093059; c=relaxed/simple;
	bh=PKDUULVAMXns0jfJsLVTDdJ791zKbT5H6xg5jxQ3GtA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tKdPs15AnRvwodokLAPsQ/mBmmZHEe9YPasUV+Tc7TSKimsS99SmiszTfrkIsmsXMPxpsgme+pK/CFHZqJz06+DqIUypkZdz1x+jw2/g0lsGSIabT4jmb6UrBPVfHBp4aNUxGHZN3kgQHq3ANCFldec2LwHtyxy6Rc7sjs99qdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g6uh2Dao; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa679ad4265so538345566b.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 04:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734093055; x=1734697855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKDUULVAMXns0jfJsLVTDdJ791zKbT5H6xg5jxQ3GtA=;
        b=g6uh2DaoYXqDk6c85HBUJS63y4PLPgJKLmG3t6Jfyb3Ebs9rP+0YfFHhDfpLHLMvPD
         EeJABbdarub7PN9RZzAwG7rGe5xMoQBj871QWRkD4qvShuA2qduAPaM3SK9V/ziXhibL
         7CSnVMKrmA5ZHgffq8xBJMUipmQpaDXl60xlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093055; x=1734697855;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKDUULVAMXns0jfJsLVTDdJ791zKbT5H6xg5jxQ3GtA=;
        b=H0D1afay3PyxL9fVF3Qe4RlDnyyytFDWYTf3NbWOjGHsVppQA+Hj1BVHKGk/pYEn6h
         9/xvofZjoGk1R2EeELBu+MI0cBNfPMk05Lj6d2iiE/nE0LGQF/X/ulSuJZU7NopKENxJ
         XlUrPCeKoLz/s1uKJxnUe91CvrrJv10W8W6jbrsJljZ1C42tKVm0eD0pjABETd+S5Zg0
         I7PhqdB+NpL2mgAEjj3g9SK/qSljeFTK8T5YIJE5tOGUeENkXrvNWwpfjXFzHajm/QoY
         NL7NxXbjXlF3t9pdik5lNbgugOOoVdWGyLE0DTMNfJ0+S5DI3exeanlZLdUpPQxXbrOc
         RvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS+ZjuYhu59x2SNFrBq/wh3gtx/7GwfToNeWDdO8swd/F5pTJdwCA40bfp0fU0hvReHZbqPy60sWKRru54bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtKAfGHdgLwWZ81/V5fYJmx5OSYB/U2K0HF3P53ccLTshDb1o
	jIFg3nD9t8rkm74lIa01xgwxYyDL5WlyHKA5+fg8KJ1UgBE9EBRl9L545j4QLnA8Nq26X5ARyot
	Pew==
X-Gm-Gg: ASbGnctWqch49BYwN1pbnjer4k+QCmT99xjarUTWQEuxZiUkm2HpI8S0K62oJFmMbmA
	X9JFMsyNzsIkinXlUeQKnZyk9kSLou9jFsi/Mcex2oY/C8W1gvWkI0RXA8TH99zrBJ4CpA/af6K
	L3iWL8mixRI2glcTj/+rPo10k5x6Nx+wRWZQWz3mhcgrRyUGzFFPnafDciy1lMh2l1rskS2j+zt
	E4uPBiHh/Ehk/yp+oOx3Sr/nwBv6o+nVdYymKu7Rc0LmCmp5gY56n3b8xfuetHCZyXzVQ7X4auo
	97J8S/rvHgXuSKWpxo8=
X-Google-Smtp-Source: AGHT+IGW3eefhRqIgjibYM85/YaHYF7RzRPB6gQTjk/RpN4nD9nWvHYTCSy36DIuyLkWGXwXueH7/Q==
X-Received: by 2002:a17:906:1342:b0:aab:8311:951f with SMTP id a640c23a62f3a-aab8311966bmr190048166b.6.1734093055335;
        Fri, 13 Dec 2024 04:30:55 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699487854sm590958366b.13.2024.12.13.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:30:54 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
Date: Fri, 13 Dec 2024 13:30:55 +0100
Message-ID: <193c0002418.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20241210070441.836362-1-dmantipov@yandex.ru>
References: <20241210070441.836362-1-dmantipov@yandex.ru>
User-Agent: AquaMail/1.54.0 (build: 105400535)
Subject: Re: [PATCH] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 10, 2024 8:04:45 AM Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'wlc_phy_iqcal_gainparams_nphy()', add gain range check to WARN()
> instead of possible out-of-bounds 'tbl_iqcal_gainparams_nphy' access.
> Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 3 +++
> 1 file changed, 3 insertions(+)



