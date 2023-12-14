Return-Path: <linux-wireless+bounces-773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE581249C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 02:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F307D1C20864
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355D656;
	Thu, 14 Dec 2023 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hknRTgIu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80247E0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 17:32:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6d2399b9f54so82599b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 17:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702517567; x=1703122367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/u5xPLWvkIaRrhFnI+H4oirck7C5zzyjkMINIlx0no=;
        b=hknRTgIul0DPU+MYp7Xv55KyKUt+Pdr/k6CHm2nwMPAKnGnYv1+UCSYKj3vXvzlaZJ
         x3cMRPivxpdL3cTmRuxfNndSzueJSBhpx8iAl8tOV7J32kMNjnSFi0o9KX5VKkC3Zva6
         zKFiwXPnm5aCqFg1CY8Z8UtrlaEeqrssiPTto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517567; x=1703122367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/u5xPLWvkIaRrhFnI+H4oirck7C5zzyjkMINIlx0no=;
        b=amHJczJ4vW9wVutaETSSZO9PeFj85lDl/3lpCNOJuvlB4FziDmCjdL0jHDiaiAQO9Z
         xIzpfc1/bEvZdItyJ5H8EVMDgl58xrtgxFzzld+7ohqjLHvkSGRItWF0yE+51hRZHqFJ
         DZLOaZ3l86dOLz2nYzVPJTmBO6/YWe5zMV49HrxaWO4XI8p015A1OZCM61NB5QBrGavf
         5Oebx7PCES1+P/pmYh5H2kv8Y7QzBbVvVOJngd6r61y5q9IH3OSZ1e5KZwGtRNPsrAGt
         Qgq9dZKR2gd8DAFoD1EOb1b8MT4Cg/22OBJJM9lLEKvY2tqkvsdcsibH+jmuKZm6FhYc
         U1hA==
X-Gm-Message-State: AOJu0YzJ1yIonwV06i26L671NF5kxbc2gkFZgLIJ4qvizRbshGx6OqJs
	BMWFQA60mu0ClAE7Fm2SwLMRpLWpD/UX/w0hdpU=
X-Google-Smtp-Source: AGHT+IHnO4D8I+58arYWW137uvBUVvhl9xXiLGPY/CsbGcLzUXflPD8J354RvBdlqMAU+/bcP/gmew==
X-Received: by 2002:a05:6a00:4613:b0:6cd:dc48:1fff with SMTP id ko19-20020a056a00461300b006cddc481fffmr13032446pfb.0.1702517566997;
        Wed, 13 Dec 2023 17:32:46 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:17f:673b:ab18:3603])
        by smtp.gmail.com with UTF8SMTPSA id r26-20020aa78b9a000000b006cbed878df6sm10590515pfd.7.2023.12.13.17.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:32:46 -0800 (PST)
Date: Wed, 13 Dec 2023 17:32:45 -0800
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: add extra delay for firmware ready
Message-ID: <ZXpbPYWsMvntaICv@google.com>
References: <20231208234029.2197-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234029.2197-1-yu-hao.lin@nxp.com>

On Sat, Dec 09, 2023 at 07:40:29AM +0800, David Lin wrote:
> For SDIO IW416, due to a bug, FW may return ready before complete
> full initialization.
> Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Cc: stable@vger.kernel.org

Acked-by: Brian Norris <briannorris@chromium.org>

