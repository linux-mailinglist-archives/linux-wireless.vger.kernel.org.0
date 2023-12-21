Return-Path: <linux-wireless+bounces-1126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A881AC4B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 02:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11CCB24833
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44F15AE;
	Thu, 21 Dec 2023 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+yPcHDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7570441A
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a23350cd51cso26836866b.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703122945; x=1703727745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQaeuehoPaO3pr13bWE/WXu451v/qATRA3gTcbFlLWc=;
        b=Q+yPcHDIpe0CSdhvpAlUyS6gxM0/d/QaGUSdYrLPHvka1k7eBN4fmpA/RLqnv4hLtD
         ITbcQNng3isUs/6dFZ2lgtMjobkxpHbPUZh45PdJuL2BeajJCMfmfcGrct2I2k7ZkNtz
         yk66lt5DuznKkDZbz+tYZ0Kk0ZDok82JFD6b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122945; x=1703727745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQaeuehoPaO3pr13bWE/WXu451v/qATRA3gTcbFlLWc=;
        b=S0PW0YClMSDBYIK4OxgKCaxayOQLyVJZC7U6ErG0cPgugSvCc6ZcaBFBkOQrtR2pBM
         pARXcj3fiCaeYMMGQ7O1DywNHrcWAJxOHASMqgRlHRHzce5ob1yjj2KNIUjKlHDTBIwc
         pIEPmal2MbHSO5v42BGtEFEVdZFk/ORg3by9XqR8G+ZJZlzLNh8l+1nsuO1ydP6erDGC
         6VqXURdpH4xjKHZ2RS4vSLDPFtLnKvyCSkAoEcZeJ3tspwEDhAL7ojHAMRbVn2Hvq+Y8
         1UJnNVqhMaYFufcVXPeCaragbt1QUSXED6fnHRex2CQ1O9gipgiwI0FLZov9HOEtQ7i9
         pjJA==
X-Gm-Message-State: AOJu0YxAMDqWC+eQS2klytJ9N8YluAAz1pFsUdFotuWEby5mlGv6cT2I
	mkf9MaXbKO5dwWCQOdXo9FCvt4y1W2gGXHpGSd/CbQ==
X-Google-Smtp-Source: AGHT+IGwkijtB66NjHhQLoaeiJnu6gMtKVSHij7mrnAJfmCPnZYEvGoDE4DlvMp7YiZ3S4VN4Z5ADw==
X-Received: by 2002:a17:906:470f:b0:a23:339a:1fd3 with SMTP id y15-20020a170906470f00b00a23339a1fd3mr3478301ejq.138.1703122945134;
        Wed, 20 Dec 2023 17:42:25 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id su10-20020a17090703ca00b00a269fa43b5asm353769ejb.91.2023.12.20.17.42.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 17:42:23 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so233796f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 17:42:22 -0800 (PST)
X-Received: by 2002:a05:6000:1cd:b0:336:7ddc:79c8 with SMTP id
 t13-20020a05600001cd00b003367ddc79c8mr294876wrx.1.1703122942318; Wed, 20 Dec
 2023 17:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
In-Reply-To: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 20 Dec 2023 17:42:06 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOLPWfS2M9J7CXWSP=dWw=mVOA41Ti_RGd2kRGTfcrinw@mail.gmail.com>
Message-ID: <CA+ASDXOLPWfS2M9J7CXWSP=dWw=mVOA41Ti_RGd2kRGTfcrinw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:02=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
>
> Variable firmware_stat is possilbe to be used without initialization.
>
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/

Acked-by: Brian Norris <briannorris@chromium.org>

