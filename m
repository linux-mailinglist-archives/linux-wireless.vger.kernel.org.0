Return-Path: <linux-wireless+bounces-9684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A691B9B0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FA31F21985
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265614532C;
	Fri, 28 Jun 2024 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+QV+aaI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F24146599
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562938; cv=none; b=l+NiFKfg+ve15tVqwpjOqcFxIstNMJIS4f/wC2n6LzIFrI96EBIZO0ND7CeTTKuZhbdS8qO2o99EP0M2gOQpZmb9fMx4/oWd3RHwNop+ml5nxGPkP0vWjN+ulNoog/+EOZgWK80q1/ZYoLCB4ZgdWBske/yGgLjECVhzDz1fP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562938; c=relaxed/simple;
	bh=crLTz1c1AmA1Zrl/Lc0Dxy5Jh4oZQcyygTWZdMs5yNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCzxTyuY+86ENT8KItwm2Xm3ZfC0ayNEg2J+dtPKRRLFkyGiBDLlZB0bIzZDn/oSRbEeoF1w0PGDPiO9vWHJ+4Gs08yeD/w+gaXoUDlkYqJA8Lo3CALzdE26zN7fuOYSw6Q43XEiqweSETOCPzh5p2/PfJHQGw0Q369ykyb3J5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+QV+aaI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso2570245e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719562935; x=1720167735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iLumAAOtFBvsHpsP3dUUUzzug2afUihyt6mM/795q4=;
        b=D+QV+aaIpWr5woI7xX1LAed06kHkeXGfC3BVLNSB4WLxZhFIonnmztHTzb0bgprtXB
         WfrFSTKUp2wHGRB7PdL0IwWIAdd4ereMuIk/IINfpTZDFJhYH7wPXPBRH7Al1BNDHqU3
         axW+oWQBu/ydRRm22crCVS+IE7fWvZzgzENECJn4iZmL07DuYqK6LQMXUM8ndiDvekmH
         4d+Ax9pNR46hs3vg3AbqqxHNaKHTo5LERGssiGwttotop+df+BOr2DKtoOwiFrrEO2vi
         QE3vE465TNCnEb9YUvn+zHIF7FT1LnSn3NG5zRvvRCgissNFOZ22LF4KnPCDVq2NodCx
         JxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562935; x=1720167735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iLumAAOtFBvsHpsP3dUUUzzug2afUihyt6mM/795q4=;
        b=myhuwoctqbDxKylvSjMz5vCNNiNc6L2Gqol/DdD4H+suUsNnZgi70ejcsA3Bn4jj9n
         omUhwik0VQjdJR25SxJFHCQYcQLEaEUZGxZGzGYgBq1TBIVFO6sHd20EO4ovHSEJSsRn
         KmdPs0Dp/tTASgqGqY8lNJHzgUAt02RPFRPBo9klNfEc5vS5dEDwvY3BB66ko0VZv6Wt
         x3d3mctuqLf/JCe+r5pToT6ODBQxEOEE+iAdL1zLbk2yO/2FVsXh9AeVQ0e0wqGeFlRL
         5DE6bnjwwfNJC8iLSu0Z1/IIp6VcOWdci080R3V/Wm8b8zP0qspqJC1flZYgzWtEf3Hs
         aghA==
X-Gm-Message-State: AOJu0YzT/vLruQTK/qlQpyOPOwi+fLvkt/xlW43JkelZVanjkfDrPVV6
	kTG3HwWwsdjkTg4iwREZIwv7/HKTdr3JWfeklE9gZddNpKcksrkgf5PzN92FxSTZMbkIAJzqZQ+
	n
X-Google-Smtp-Source: AGHT+IGBucHdkuDKMQ6DSRWOJOV5ZyBVxKbIQm5EuC/EJ/VdLJlaNUhjjO0R9VBwl14uIozB0iSfcA==
X-Received: by 2002:a05:600c:4311:b0:425:6bc4:c006 with SMTP id 5b1f17b1804b1-4256bc4c2d2mr10955275e9.16.1719562935204;
        Fri, 28 Jun 2024 01:22:15 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af376f5sm24085485e9.6.2024.06.28.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:22:14 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:22:13 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH 01/43] wifi: nxpwifi: add 11ac.c
Message-ID: <Zn5ytQtySds3Ix9g@linaro.org>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621075208.513497-2-yu-hao.lin@nxp.com>

On 24-06-21 15:51:26, David Lin wrote:
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Hi David,

Please read the ./Documentation/process/submitting-patches.rst

Just a hint. There is no commit message.

> ---
>  drivers/net/wireless/nxp/nxpwifi/11ac.c | 366 ++++++++++++++++++++++++
>  1 file changed, 366 insertions(+)
>  create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
> 
> diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
> new file mode 100644
> index 000000000000..3e14ee602cdc
> --- /dev/null
> +++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP Wireless LAN device driver: 802.11ac
> + *
> + * Copyright 2011-2024 NXP
> + */

[...]

