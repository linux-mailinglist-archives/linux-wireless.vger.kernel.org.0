Return-Path: <linux-wireless+bounces-26859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D53B3B3D4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1881C8432F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE92586E8;
	Fri, 29 Aug 2025 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKCcCdbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AB2475D0
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451330; cv=none; b=Rpdo8GHj9prXUcTGkluXaI2pJgMeh58yW7491PA3j5FJoSTDjSIdcxkUboQujBbgL4VZDRIeTyEXYvANuczGgq5WrLB4bdwV7l/hxrpkEXHCXHbYoPuX/VDWEzTHTSChJr7e/REwBYjO6FExQBYYmz6kTAh6hGVzEsnNpyOqB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451330; c=relaxed/simple;
	bh=8kX1TYqSk8CQPzDbg6Pj082Kw54tQC1IglUpvtBYI6M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=krWZ0v6ZCsYxTEfeaWQ28BA6DqXbgxIb3ZQIsmSHqfzAglgg3so72zLtGjKWAeMEqJIq327HYEGqSa5Kh0jExT5OsQXzMO3YiWNOdiQ50EufwdibGWu9/7bifwuO0eLvlqAtjMzimXzVYG5tpidqvEB1vj7gnxUld8dJIOTFGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKCcCdbr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d0dd9c9381so152281f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 00:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756451327; x=1757056127; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5likjX5KYTy4pH0uKgOVW5qBxenMbpMrXCxh1FkUlCg=;
        b=rKCcCdbrNuuaFYWu+WkrrQiakctWstMbc7IjrPnPxsITvVK0Y/BX8eG0C/ZobfBEqX
         IRVfzATz6Y/icxIiTFOaZCNWH0L8UDuXybY3SIX6ihbo+ebrK9zE8yFidwYrmE5x79p+
         3YRSid+q58nIXjbjKiBqhxvhWpC8mPW88vZFoobz6bLdXgd9D6kXc5exMhl/V6+LD0rt
         qHyqObu4AOUDm16jEKQ6EQalR832eJwg4GbMIdZ/Ruuyp2SkOyvj34l+Q6cwfbgb1YSv
         H+sPMan5TYMzQr45AmfGUpoPAUvTAZmX2G0y7BOmfAxtyxP7lNJvRiocJpGI+6diwLhk
         86Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756451327; x=1757056127;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5likjX5KYTy4pH0uKgOVW5qBxenMbpMrXCxh1FkUlCg=;
        b=YFc99KncsurmYqiVEslpEMj2fD9w8p03LuuWfiuTRmOD+nFbW4sp6rKSTF1I5oE7/d
         laJCNoENnidoxMUzdzXiXBD/N7SoKler9ixbrUNGAS69fvmk+kaZQShpvpJWP9mpzQ/k
         0Zo4JchpfK/9FQk40TiIzmHV71VIEI0llerPOBPEBGzzl2p1JrQ8QqPSVHbupaE4QAlN
         Yxg0hN51upiveAVqnG1yOlWYOozeu1vzgEOq8e3BujbJhtLCu6Xknsb+8PbuJukAcioy
         J2e1z0KAm0q/81giNYAj23mHsVY35QbYazyNBRv2ZKuO6tNabAT/91OGQAZ5gAnN84Hm
         cyVg==
X-Forwarded-Encrypted: i=1; AJvYcCXdyWAST3gQdYvR3To3bHRGDnYWLx0DsBYnzsjuKm3+S6UWqJFhzZEk5pVZvTIwUNnB32nTDLNMoiv/usVI7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPH9Y9pm5wcuggclzmhjiqdbfLFN8BARhpTAGB9d5/0v45o8j
	Lg138ah1i4Lwufe8+6qt5IgIsoB6lrgWnK6tRlTwesI6t8RbFR/vCJZuFoZqgCVGOR8=
X-Gm-Gg: ASbGncsTnZ46AlxAcHPW2udo3YRwzYVN+8RkhKWtr5pyinwr5CP6TvJdK4Vq9lS0VxK
	Cx9ibBAZlKh+6zz0p3cR4t3HiiaoDiiUjdPXs4Clx9Swzme4s8l+iB8Hp7PgCjCxcRhObwBx6Jh
	sJPDEOlt66U+ImQCT+Eqm7O9h1CuRMG/mknPh4km/smlJhZ1lX2aHrnk+xbbLV8OYMfAi1ehkP1
	EH8ByjAyvkQU2hfo1AQO2W/j+RJkh7lC+ALNgqJxs29i6w10yzpg9QCWYzZ0bxqpQ90t9TlJTEf
	gkx5Drh+bsM+F72okUHJo0S8Mr9sVECDsTwmh8M8Dprw8vP8TlADyru/aF3xDLHp8+s2/WLzMml
	oO9RuGZssDD2FrpzvUvX5TybMRZ3zTGlc6VxbOg==
X-Google-Smtp-Source: AGHT+IFR2+wVjv3AobOBBrC54sGjT69OldJpGUP7KAETJgETqtFtJUxba6deZ9iBTkyQt1ZKQJxqXg==
X-Received: by 2002:a05:6000:2089:b0:3cb:d8e2:48b2 with SMTP id ffacd0b85a97d-3cbd8e24b73mr9195871f8f.13.1756451326957;
        Fri, 29 Aug 2025 00:08:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34491a65sm2126508f8f.56.2025.08.29.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:08:46 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:08:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] libertas: if_spi, driver for libertas GSPI devices
Message-ID: <aLFR-5CzpMiaqB7P@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello libertas devs,


Ancient commit d2b21f191753 ("libertas: if_spi, driver for libertas
GSPI devices") from Jan 9, 2009 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/wireless/marvell/libertas/if_spi.c:719 if_spi_c2h_cmd()
	error: '__memcpy()' 'priv->resp_buf[i]' copy overflow (2312 vs 2400)

drivers/net/wireless/marvell/libertas/if_spi.c
    670 static int if_spi_c2h_cmd(struct if_spi_card *card)
    671 {
    672         struct lbs_private *priv = card->priv;
    673         unsigned long flags;
    674         int err = 0;
    675         u16 len;
    676         u8 i;
    677 
    678         /*
    679          * We need a buffer big enough to handle whatever people send to
    680          * hw_host_to_card
    681          */
    682         BUILD_BUG_ON(IF_SPI_CMD_BUF_SIZE < LBS_CMD_BUFFER_SIZE);
    683         BUILD_BUG_ON(IF_SPI_CMD_BUF_SIZE < LBS_UPLD_SIZE);
    684 
    685         /*
    686          * It's just annoying if the buffer size isn't a multiple of 4, because
    687          * then we might have len < IF_SPI_CMD_BUF_SIZE but
    688          * ALIGN(len, 4) > IF_SPI_CMD_BUF_SIZE
    689          */
    690         BUILD_BUG_ON(IF_SPI_CMD_BUF_SIZE % 4 != 0);
    691 
    692         /* How many bytes are there to read? */
    693         err = spu_read_u16(card, IF_SPI_SCRATCH_2_REG, &len);
    694         if (err)
    695                 goto out;
    696         if (!len) {
    697                 netdev_err(priv->dev, "%s: error: card has no data for host\n",
    698                            __func__);
    699                 err = -EINVAL;
    700                 goto out;
    701         } else if (len > IF_SPI_CMD_BUF_SIZE) {
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^

The problem is that this is 2400 but ...

    702                 netdev_err(priv->dev,
    703                            "%s: error: response packet too large: %d bytes, but maximum is %d\n",
    704                            __func__, len, IF_SPI_CMD_BUF_SIZE);
    705                 err = -EINVAL;
    706                 goto out;
    707         }
    708 
    709         /* Read the data from the WLAN module into our command buffer */
    710         err = spu_read(card, IF_SPI_CMD_RDWRPORT_REG,
    711                                 card->cmd_buffer, ALIGN(len, 4));
    712         if (err)
    713                 goto out;
    714 
    715         spin_lock_irqsave(&priv->driver_lock, flags);
    716         i = (priv->resp_idx == 0) ? 1 : 0;
    717         BUG_ON(priv->resp_len[i]);
    718         priv->resp_len[i] = len;
--> 719         memcpy(priv->resp_buf[i], card->cmd_buffer, len);
                       ^^^^^^^^^^^^^^^^^

if len is more than LBS_UPLD_SIZE (2312) then it leads to a buffer
overflow here.

    720         lbs_notify_command_response(priv, i);
    721         spin_unlock_irqrestore(&priv->driver_lock, flags);
    722 
    723 out:
    724         if (err)
    725                 netdev_err(priv->dev, "%s: err=%d\n", __func__, err);
    726 
    727         return err;
    728 }

regards,
dan carpenter

