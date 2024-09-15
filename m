Return-Path: <linux-wireless+bounces-12866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEC9794E0
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 08:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D6B1F2290D
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43621BDCF;
	Sun, 15 Sep 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZzD03Pke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26E199B9
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383053; cv=none; b=bzhwn9hA5VpGiOIaGCJc7k2YXo39SJ+YqPuBn6N1KTKNixyHPEZSfzhdjy0zT/geEUeLTmK/TYwQxY3vkBslAEKPp9e4LNJ5sEsF7MsxPpwSp/XcOZP2/wKvk9+JW+QjHNIuu/448+HCQHPQC6Ynliv5BdyM5fMXzcJYZpKeiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383053; c=relaxed/simple;
	bh=rEmyIRyb8lQu1vOpOZTUou7zsVKMhNaTwYfuJI642tQ=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Nt6k5NcopC14TUCgvDSBDZ/AOTTKiliFoHbkI3ApgNJhXhbs/TE4LuSMiV2ZU5jSCSxvqTb7mAk/p3Pb3uBq6Es80sJDv/N1k3rcHDSf4/K8hLvDiDdIG45/XSxLwPL1OeJD3Nct4oWwMtlRRdP0eby9VxY1xhrvQThrTwjMlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZzD03Pke; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso17761785e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 14 Sep 2024 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726383050; x=1726987850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejmnS563WYTKFurKv1lXQZcHBOVkT0E+DS3cmoKMb24=;
        b=ZzD03PkeIpvLEjRXj/m34K1air+8Xahcl0B6QMmVVRKkyElO3uKT8EdB7c0oj3almN
         OfGQCbks4irLPrgxaKYwQGvA9A8QMc/CSn9UmwSoeOXAvqAdszvjd+DbNw+VL8IDwSiu
         GpQf0exA1NYnpzSEwVIRyCYEpTzTpptJQe7nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726383050; x=1726987850;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejmnS563WYTKFurKv1lXQZcHBOVkT0E+DS3cmoKMb24=;
        b=r4amC4GCjmc2Ma2K6+P2vXpgF3nKL+jXg/YZ+G7mocSPYMO2UoD4N13VvOX7Sx6DQN
         Zfe5bqsQ29j2Vcy1lgvVSTl+heCr5Xrk9chGb+Xo5wyIxYP3O1/P6Vhp8hTBAL2ODUYB
         CkwgaoW1ASxACWGh63U6NNdEQs0JD1mKVZUMeusmY+Ku4nIfyj1bXJ8bsb2shYN825D0
         jL6wN86yZdVjvXGtvWEDevvhRoA0o13iZqnytM+3QGZUaZFxJNM6CoUCkFlIEyFMhvx9
         CPVJzY2jX29MRpfDnbRKctFmQwL/Q5wsKYyNbTFG8r8ndrBetQmYiWHw5e6ekM63970p
         sjAA==
X-Gm-Message-State: AOJu0YxeaNevlg2b9nw1aDSCINeWfcez1+Wst2JKB8abRAKH52tbX60r
	5JsjtD+Gpsw3ho31xRa2Mf4dhZJRA1kK8tVWTzFkzlr/ejWGGlxiaxEKQAJ3Og==
X-Google-Smtp-Source: AGHT+IG0aRsTm0roi1/IpFCkRxMfzU7+pRgSHSnqGW1mXMvrSh6pQZImosBl0LPIOM0o8vJEQPGvMg==
X-Received: by 2002:adf:ae5a:0:b0:371:8dbf:8c1b with SMTP id ffacd0b85a97d-378d61f16f2mr4146486f8f.34.1726383049620;
        Sat, 14 Sep 2024 23:50:49 -0700 (PDT)
Received: from [10.229.42.193] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78044dfsm3887658f8f.94.2024.09.14.23.50.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2024 23:50:49 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>, Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
Date: Sun, 15 Sep 2024 08:50:47 +0200
Message-ID: <191f472c158.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240910-wireless-mainline-v14-3-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-3-9d80fea5326d@wesion.com>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH v14 3/4] wifi: brcmfmac: Add optional lpo clock enable support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 10, 2024 5:05:48 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values that will be
> send to bus when error occurred.
>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 ++--
> .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 ++-
> .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 25 ++++++++++++++++------
> .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++++----
> .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +++
> .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 ++++++++++++-------
> .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 +++
> 7 files changed, 47 insertions(+), 22 deletions(-)



