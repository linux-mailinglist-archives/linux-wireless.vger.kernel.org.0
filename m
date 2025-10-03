Return-Path: <linux-wireless+bounces-27801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F84BB76E2
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2CA3A5A76
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334E3C1F;
	Fri,  3 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gaYoDZpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD0286884
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507225; cv=none; b=X0NvaQmR9VcxEMuU26SOdG7Z/ww7DM5YV8rn7zMNd99ZMynYWspc8fSMjqwCGYtsK8Mg00O/REQlVkNLLAGcKPaD90/QTZi82pmiHCrnAqcGFE/CwgTY4yq1e3ejSX2r9F9qLlzG4yAy6lR1r1oDyPVlkC6/FxeOgUDocR9O06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507225; c=relaxed/simple;
	bh=qeBXk6ZxCgM8dte0UkFnj58GTDcppJ1R34Pxrk8rISM=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tP07dkB8FoRFxCa1kiq+Aq8PoTdSD9xXVYylzG3tb4aYWCZPK+0HsLsqbgYyfhhp8VTNdBcqBIVS5mrVJYZ4IW5x27lnqZso0z+9ZYGc5OdT64KlfqaIng7+0g7OptKfXA++lOwj1i+DPPnDod7RquzJ17zXI6VlO4hpSwO4lRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gaYoDZpI; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4dfbab4fb0dso29913651cf.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 09:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507223; x=1760112023;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIRz7gWQ1Xu5Iai6JSmMimzSEA8Q3m4VGxXaY2xiIFs=;
        b=b3wnDKrS+chFpRmt9aHYAVOVqqcwq+wd+DuK/aGyawna/wgXRyXLEovG0tRevuxZ/K
         UrMlxPfwq7h9Xt3LUpmPi/kD/MzWav83Mv6dzin+W6014a13FCB4mNHuU+cK8X0r8+zp
         7gvNYGRgAqIpc+XaL8VtGUDDpf8VaA0hQasytdOnucGiDbcIs9+rJd6hMK/cdd7tsB+4
         L9dEMSlCbGN9UF0Aq0hz314QkFx+77hgs9jhSjzsh1KVQN8lXm3SfZ1nTatKLtb04NaK
         dx4TNkeqm09ndZ01PrK8pd+BZYnmXBZaa1wBCIR17+wBVDw6LJUuiEazAyDYDcIYZyRj
         R6aA==
X-Forwarded-Encrypted: i=1; AJvYcCWbnEV+8XJOPQpBE56A7zbi6WRXTzt9wLBJIp32W9v8yzDQ6+I1BvraGMQtFPiZSgl/tvccpHA+QaLgEw3tmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3erTN0qPd9w5Ypj+i4p/IflGAeBCRGk1dCeVjYzG6Wy3Ljr++
	ozc0IyLkuxf8beULhXamlac98VA+TbjvAT2x4cKzkCSjDQlfeFk/pc04qgPTITG+UKw1VEFT6oN
	aRu4k2Ui97MBnntN65mOnwLbKV5xpNJtBPMaBTjgIEE2inaBf5iJmJSLsALj7YIIKlKgXoXRTwq
	1DPZtAM8zuKaVurZusEa/9Du0GrR6RAA8zaJ5+LLnVB3ENyEuzUXNDQ6jnXAZHDB59uzYgZFTrl
	ZKLtWurBLo+HM2K8JfFlzUq5+Su
X-Gm-Gg: ASbGncuwQaTCmHfNIq3xfRtepI4VF48765EiW4PUhITM913vK7RWopnRaOOvOYNeeLm
	05aq3IuLmkpCEmuO1lu/76kn8Vo5xjUmAu8og2O3SKpNYXQ78NwF6UiiCeI2zLb1p5spzSzqSBn
	9zZWs7WdXVeIGJFk/hEOuGpCeXD1nOwRw0pFNsLiuhGs4gX80Du1/BNzbJQgF98xLaUL+yrtzIT
	29KOZQHtgaMQd2sccwICkr9rYjiL41nDtPsnvyCsbdHWsbxmv3/MIKftHJlEkTCzkf0US2RWVk2
	Fu6J5qvlrx4CpqgYG2AYXMIFJX7qyobzcjvYbvmVxqc2xImzZjFAOFWI7oUnHsYclRf5enIQYnO
	Y8XBI1y0rLE1UcHx31VzyM6NePxp5LeHCuEMSj28b8C35/MC97ewKerJ/CtC9aSndFjB/k1wFzJ
	zxsdw8cgIW
X-Google-Smtp-Source: AGHT+IElvSMqmjLgNJEG1twXebCpa1YfTWL7WZi3Zp0xZvdEIQfLuxMbWyTbXNdPHMzbvwjA8XzWHwx2N83f
X-Received: by 2002:ac8:7e81:0:b0:4e5:6cf8:2a5 with SMTP id d75a77b69052e-4e576adc719mr45349851cf.60.1759507221060;
        Fri, 03 Oct 2025 09:00:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-87775e06ee7sm35792185a.5.2025.10.03.09.00.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:00:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b48635cf06fso281237966b.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Oct 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759507219; x=1760112019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIRz7gWQ1Xu5Iai6JSmMimzSEA8Q3m4VGxXaY2xiIFs=;
        b=gaYoDZpIkBN65CRXfoCodh4X2kbRUfl1m5tjuDLy8byAquc7pp68n8w/it/YEIaBMM
         EzA5Pd9ms3A6F5RgDFVpbLIw8AcwG6JvqSJKfk4s1e53feGhPVb4YbpOBmLyDttZ8h1n
         3LP+Bbu/C9ujN3dd01mGMpNbAorb+hoirPcDk=
X-Forwarded-Encrypted: i=1; AJvYcCWaCiNJNdy8CO4NgozKqS37i8n+S/N6/rAvEjnqJXtMiUYSUHeNEYWNruFwQPHkH8PFSff6J6xr38EBE/UTzA==@vger.kernel.org
X-Received: by 2002:a17:907:1c90:b0:b04:2452:e267 with SMTP id a640c23a62f3a-b49c4394d63mr422922066b.56.1759507219417;
        Fri, 03 Oct 2025 09:00:19 -0700 (PDT)
X-Received: by 2002:a17:907:1c90:b0:b04:2452:e267 with SMTP id a640c23a62f3a-b49c4394d63mr422918566b.56.1759507218910;
        Fri, 03 Oct 2025 09:00:18 -0700 (PDT)
Received: from [192.168.178.31] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a4bdsm467071266b.49.2025.10.03.09.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:00:18 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Richard Reigh <richard@govivid.ai>
CC: <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>, <chris@streetlogic.pro>, <linux-wireless@vger.kernel.org>, <s311332@gmail.com>, <wahrenst@gmx.net>
Date: Fri, 03 Oct 2025 18:00:18 +0200
Message-ID: <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20251002232002.124609-1-richard@govivid.ai>
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action frame handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai>:

> When iPhones query network information via the WiFi settings "i" button,
> the brcmfmac driver crashes with a NULL pointer dereference. This occurs
> because the P2P device vif is not initialized when handling certain action
> frames.

That does make a lot more sense than the line that gdb gave me with my 
driver rebuild attempt.

> Add NULL check for vif before dereferencing in brcmf_p2p_tx_action_frame()
> and return -ENODEV when vif is NULL. Also modify

Now I don't think it is necessary to bail out here. See my suggestion below...

> the retry loop in
> brcmf_p2p_send_action_frame() to stop immediately on permanent failures
> rather than retrying.
>
> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>
> Signed-off-by: Richard Reigh <richard@govivid.ai>
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index 10d9d9c63..2c73156fa 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct 
> brcmf_p2p_info *p2p,
> else
> vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>
> + /* add NULL check */
> + if (!vif) {
> + brcmf_err("vif is NULL, cannot send action frame\n");
> + return -ENODEV;
> + }

Instead of giving up and surrender we can use primary vif, ie. 
p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:

if (!vif) {
        brcmf_dbg(TRACE, "no P2P device setup\n");
        vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
}

Regards,
Arend



