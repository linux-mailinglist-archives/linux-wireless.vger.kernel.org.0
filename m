Return-Path: <linux-wireless+bounces-134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF827FAF19
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 01:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEFEB2104E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF041875;
	Tue, 28 Nov 2023 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GNluDj37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB621B8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 16:34:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-285d32c6f07so1248016a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131671; x=1701736471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GcVqTQw8m82AWs/bM0FSCPyGHvrEjXN+2g9CIkLzcQ=;
        b=GNluDj37zVD74g3JJOgPYd9rlpNSH7h+hKQOozL1J0TQaVqoD+kNBgdWiV/YNosUm1
         GzMdFn3eobA83BvJJXL6Zg2h09SIbY68byaxgp0GfVVZgCXscg4kaYoJXLaeQ5fgFd9D
         UgO/Gc6ZcKwTkdv6LOo8oFu4VStkK/TH+GVE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131671; x=1701736471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GcVqTQw8m82AWs/bM0FSCPyGHvrEjXN+2g9CIkLzcQ=;
        b=tMwtBNk5MIr++J2wlMMTI3yHhf16bb0gAB1HowuIVsLe3unNI1rdKzTQ5p+VmI8goN
         btwTXc7EKZVCW4z4WTTbDpovz45FlZq4q7Wnh6W5P1AZ/zbJUp4ir8sOQWoJn+GAk1W0
         sJ7VmUwhTNs5+Cz7qp/lQ+wvg9807zDnXbpw6PLtGX5fKVFa/aqTfdIH2IursNy2ZT9+
         +uDLcsjmlEBBtnJ+LILZj4tPohk+GO1LPJ3NcuNTVzR4HNSbgyoFkoJNldpMdHYW8OLw
         UgWzzgTmOyBh7HQ+GTQ5hydF5FzQGTPKYEKAQ+vJ8BV0EUVwZHBde2khIrPN5Ep0NNC4
         0k1Q==
X-Gm-Message-State: AOJu0YxdO0DIY/qJLaROPOsWVlT7/dXjENdR9rhoPyCjRqABGCwkz6WN
	trefoAe6uNw4YdIUaMHZAiBcXA==
X-Google-Smtp-Source: AGHT+IEg9YpgUHIsAkHdMiZvyAgRVEYWc790jPMLYF5li9yRb7+pLe8zebCBHBpg3vbwButtn+Zb/Q==
X-Received: by 2002:a17:90b:4ad0:b0:27c:f80a:2c8a with SMTP id mh16-20020a17090b4ad000b0027cf80a2c8amr13008909pjb.0.1701131671211;
        Mon, 27 Nov 2023 16:34:31 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001cc31dcec49sm8903085plb.146.2023.11.27.16.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:34:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kees Cook <keescook@chromium.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Will Deacon <will@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] uapi: propagate __struct_group() attributes to the container union
Date: Mon, 27 Nov 2023 16:34:27 -0800
Message-Id: <170113166294.1670814.14494797449586768583.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120110607.98956-1-dmantipov@yandex.ru>
References: <20231120110607.98956-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 Nov 2023 14:05:08 +0300, Dmitry Antipov wrote:
> Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON()
> in an old and unmaintained wil6210 wireless driver. The problem comes from
> the structure packing rules of old ARM ABI ('-mabi=apcs-gnu'). For example,
> the following structure is packed to 18 bytes instead of 16:
> 
> struct poorly_packed {
>         unsigned int a;
>         unsigned int b;
>         unsigned short c;
>         union {
>                 struct {
>                         unsigned short d;
>                         unsigned int e;
>                 } __attribute__((packed));
>                 struct {
>                         unsigned short d;
>                         unsigned int e;
>                 } __attribute__((packed)) inner;
>         };
> } __attribute__((packed));
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] uapi: propagate __struct_group() attributes to the container union
      https://git.kernel.org/kees/c/4e86f32a13af

Take care,

-- 
Kees Cook


