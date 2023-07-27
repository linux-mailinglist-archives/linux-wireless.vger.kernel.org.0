Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED5765812
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjG0PyB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 11:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjG0PxE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568DBC
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 08:53:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f0d66652so990990b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473183; x=1691077983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyEHfmIdAZusP8ylrb9Uotw6HIeOEzJpt2mwB5LGftM=;
        b=Qcb8L8Ho6rOn1rC0EiVFDR15Gh9M3knRrx7sGFT9bNXn73IpUcHWtyKa13fEUffXeK
         UtOsTQxVrQm4KgUF6Bbc1cwf4alq6fcsogcAjy7fWRZzjcBGeLPKUvlLclFTldRRCjGi
         Qo84N3OjMXDAmjirE1Idm2pfWEUd1qgnKpFqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473183; x=1691077983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyEHfmIdAZusP8ylrb9Uotw6HIeOEzJpt2mwB5LGftM=;
        b=QePgfM1bEqvWniYoUni5GvNnNM2Ql5JLZGZVWambpU+cyTqSn3y3GfDF1SvTIFX15m
         UxJE4KZWw21NSitzo75X+fSpn/VQT7tnevRZaZJn8U3PBSbsEhm0XA/AeFuFDSFvflmw
         H9VuDaSdC8iuLSv/2ybf7sCq8/qulTp5zUYd9pWukWVrSV4YPSqa5qmuQ9fPJoVSXB3J
         SxFDivaMzBdFJfo8rapyMq494ftG+7kvCqxQuc4EUmqdo/jtbCMrgppi4Ncruu/fHvjg
         1mrnQxXrP6JnUqPq3nG0LePYTTHNVRwVdYKgMjR9V7Z8kI1jOVYOPXwPqPeUiJBsXcw0
         /PYw==
X-Gm-Message-State: ABy/qLbR7jBcxlfr/wvC+/cs9vSDqNhVSp+JmVLlKEiQQozEzMungdJw
        oDe8Ii9UAwMUHFrrW0DawO0cLg==
X-Google-Smtp-Source: APBJJlFoqyR2BKZ04r1FIOAJFPAZ8Ovm5FIqBgpxC7jWT4bd8oyWfIY99FOQVec6GXJfK47I2TYYGw==
X-Received: by 2002:a17:902:dac4:b0:1bb:cd10:8209 with SMTP id q4-20020a170902dac400b001bbcd108209mr5450270plx.50.1690473182764;
        Thu, 27 Jul 2023 08:53:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b89c313185sm1807914plx.205.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:56 -0700
Message-Id: <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710030625.812707-1-azeemshaikh38@gmail.com>
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Mon, 10 Jul 2023 03:06:25 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied, thanks!

[1/1] wifi: mwifiex: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/5469fb73e96d

Best regards,
-- 
Kees Cook

