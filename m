Return-Path: <linux-wireless+bounces-438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB64805F60
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 21:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071A61C20CF6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57D6DD15;
	Tue,  5 Dec 2023 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JG4DvRLt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE605183
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 12:26:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d075392ff6so1326645ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 Dec 2023 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701807996; x=1702412796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z74VK0/+6LO3YLMu3vX1pNpETdyfXDf+myVrrbMuLo=;
        b=JG4DvRLtvWmVfw20cYFSjcl9zNlGRd5KelOqqOfkJcHjsr4Yu1GcbZ4/alONixRIXf
         5gbOwbAObvGJwsYT5xBNidZrPOUWZgPGAXagnIxjP69lc208iXywdIz+wucnnAOb2mu5
         0BAItnq4Al82m2lexHOwqDZyfi/tzBkA0miRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701807996; x=1702412796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z74VK0/+6LO3YLMu3vX1pNpETdyfXDf+myVrrbMuLo=;
        b=a8NtzFKxipUdAee6kYkFr4AXA4SS58Y4xXymJTeZSQJ4/b1mnGZ/KVMm8Z1R81JaKR
         EFDbrniDbwi5F3E48Wb2C4unJeZ1oRiGyi3uGbTNUiKII0rLF8MdfQXRQOJu0o/uu2nJ
         1VdGP65Xoo9PmCPRYqACVfb4NbGA8uPO0Vtrayi4WcNvXCkk1GKLpbpG7UTQGDcBzYg0
         BTpBfbaLdsulS3cHzGzE8c3HQaGqqhyVky9MQ/9N6mvpuIo+JGe+5xaMDW1CcZFwC11c
         nU5Wr917tdayhtm3+/nP53fva8W8IjnH5B6wjyL9L4UNh+x78HDmTJOwS0vpd+bvBfHP
         J85g==
X-Gm-Message-State: AOJu0YxWqH2D1d98DtZSC50i87PSs+JB/DYwtlT+e/IERGUz9oRa78Pt
	gq1998+Z/6EBAmaoZNGnmgN85g==
X-Google-Smtp-Source: AGHT+IHukR9UvjD9j4+NWOK/ZZO7ah/LCGSa2/TGIMPKzLjm0beERmGnqBUyNqFynnETTlRIEgT0Dw==
X-Received: by 2002:a17:902:f545:b0:1d0:b3c4:a269 with SMTP id h5-20020a170902f54500b001d0b3c4a269mr2255897plf.13.1701807996133;
        Tue, 05 Dec 2023 12:26:36 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5038:905b:ae7e:e6da])
        by smtp.gmail.com with UTF8SMTPSA id y11-20020a170902700b00b001cc29ffcd96sm4156496plk.192.2023.12.05.12.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 12:26:35 -0800 (PST)
Date: Tue, 5 Dec 2023 12:26:32 -0800
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: added extra delay for firmware ready.
Message-ID: <ZW-HeGCvxpqzBukB@google.com>
References: <20231128082544.613179-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128082544.613179-1-yu-hao.lin@nxp.com>

On Tue, Nov 28, 2023 at 04:25:44PM +0800, David Lin wrote:
> For SDIO IW416, in a corner case FW may return ready before complete full
> initialization.
> Command timeout may occur at driver load after reboot.

Do you have any idea why? Is it specific to this chip and/or firmware?
I'm hesitant to add magic sleeps to everything, just because you have
one buggy chip/firmware.

If it's a known issue with a single chip, it seems like you should add a
flag to struct mwifiex_sdio_device / mwifiex_sdio_sd8978.

Brian

> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

