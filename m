Return-Path: <linux-wireless+bounces-7605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5688C4818
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD0A284238
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4E7489;
	Mon, 13 May 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="makZExos"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E078283
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631416; cv=none; b=eW6utAmIx3AqzziW3M1fTyUrA1uWIkIFkbHvb7MHekW/KFvrFy4M9wvZCfhHy3imXkBI2whRcHAXZhcw7LK3J0O5OgjsYmA7TBmp8v2EVQiWEgeYce60X75oCXuqZt+YnkDBRuryccEJBkRnkIW4YPJN52dlw/QLKc/x1eDBHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631416; c=relaxed/simple;
	bh=cLQLJ1FpnagjYn3H/klb3R7atZ71hPTNq0d4ckxGLkU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Oucoj6sTncvvxf0bTp7XDoZ/G3g+AW4l3VHA1+xshcB1m65aP0a8R9LZjLnhHHdx63ytcSaI4tE2N8uz7vgFGtf7TfdWMCAFpLE+vDYkcaEEJmdf+7RG8d7LOaNGpUfU1m/SauAVJY9c4Du7VX/4dnz8QxwvLLv1hmWFQdAzFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=makZExos; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4200ee78f34so19192585e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715631413; x=1716236213; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLQLJ1FpnagjYn3H/klb3R7atZ71hPTNq0d4ckxGLkU=;
        b=makZExosnsKEP9KOG1T9KXISN0ItRwZ4kQ8rg63YJDQzmrqXitfr8G1BSVUdpr34iu
         X39xh9MrI+iEd2974P8NXmdP3jiP+9L+sCJ+i3HCQJUsC5sPgdYOfwBs849ro5nhHoiO
         UexTqdTmLxYKc/E7iP1qGhF+eNcsj6FUjWhL7Gor9DmAuhMFCyCLFPS0P/EGeYxP0gYq
         aE3QFG4VkP6773Tbm3nHyAAwBvos/AiGBqzTIaoIsl6viVE3VYyGHJffLW4JyJYYQDqX
         5SNmkoJ7lh8Recd2OTMlmYCmmIlWsTLdvYLmiCa3pMNghdpc0o8t2RVmUN0RSdxO1Sa1
         ZSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715631413; x=1716236213;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cLQLJ1FpnagjYn3H/klb3R7atZ71hPTNq0d4ckxGLkU=;
        b=uw2xNxK6Bk+QCd26AEOysP46njKGHrnX7UykLlCRFHwXN0gRNg3I3m6cNWMlOhoOiO
         3yKr2j+NRUeWb420d/0KIi7d39p1+dqrEknP5oZsF7t/5/fDaSAJDY7+4thvWo9Z3aPQ
         KUqch/KBabkJISvEVyRmY7qSOd/vuTAkguY/D8sH/AvMf+VaEOMWNz8SsrXZxLhhrV9a
         mngnkRRx4a7WcGg2ZfB+LkrESq3ECNVpz0ambTAY6+Gx9rSL7kxWjl03ZsKFkgCWZ54k
         bT5zyajXIRVw4zekSI2ZITLwGs7qfsSoVysVxWt8aARsbJJ5ZCFwt9Qnf4aiuRLwKeXk
         Cm1Q==
X-Gm-Message-State: AOJu0YwH+xwE8K6oGWat/PswDsRxTn9i6VD+s/NlhiVYeS69b+TldTCK
	TZvPXEnGFGQQCENBjKJl1hqUtLajfowiOFN08YUfitKlzD1mwt8m
X-Google-Smtp-Source: AGHT+IGP4MRFzLIDSLIPIIrAg1UfaJt72YHqZsOvUFlHMvpGkEtztc1r5GKkaFHy8IEwnPzW9rVcsg==
X-Received: by 2002:a05:600c:198a:b0:41a:c92:d323 with SMTP id 5b1f17b1804b1-41feaa38afcmr79083725e9.10.1715631413251;
        Mon, 13 May 2024 13:16:53 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd11ef80esm165443105e9.39.2024.05.13.13.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 13:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 May 2024 22:16:52 +0200
Message-Id: <D18SKUBJSHK2.17RQSKX4XB5JP@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Add Dynamic VLAN support
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Muna Sinada" <quic_msinada@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20240506231752.942567-1-quic_msinada@quicinc.com>
In-Reply-To: <20240506231752.942567-1-quic_msinada@quicinc.com>

On Tue May 7, 2024 at 1:17 AM CEST, Muna Sinada wrote:
> Add support for dynamic VLAN. VLAN group traffic is encapsulated and
> encrypted in mac80211 and driver needs to set flags for the VLAN group
> traffic to skip hardware encapsulation and encryption.
>
> VLAN group traffic utilizes ext MSDU and HTT Metadata to set
> encapsulation type to RAW and encryption type to OPEN in order to
> inform firmware to skip hardware encapsulation and encryption.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-3
>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Reviewed-by: Nicolas Escande <nico.escande@gmail.com>

