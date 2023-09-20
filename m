Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FA7A8FB9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 01:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjITXH7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 19:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjITXH7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 19:07:59 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81677A3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:07:53 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1d6b5292aebso193194fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695251272; x=1695856072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGwpZPVEORkxfW1VbT3l7BERzQg7QGbMxJQ8TdJTA+4=;
        b=AcWrhqJQ47NG3xJ3uRrti7+2vmjcakOlhxH6xBQlNGWhgmVxjplxO0z7kPOxCIChph
         a8vvoG63muPZS0RXtTveeB9kBbpWsRrwkR4WCZjsmek0bNHXtPXL+5CY/G8HjQ+6Of+F
         mpaHBythwbocXczY1zJv6RCT7b1zQkkzpilZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695251272; x=1695856072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGwpZPVEORkxfW1VbT3l7BERzQg7QGbMxJQ8TdJTA+4=;
        b=BCC+Hqn9pc4rH/qyOCLruDWCCqWGO34jZkdmsR3H3/FxyWg73ka6dI1MmPIMr/+t3u
         SfdNr/pAGk8IH0s+hoHmK5xkvsjcAKodDNh1HA6JrYDDkZJRSqT5rJOY4zrp1WSV7FQL
         fgvA33Rnk7KJPSxG0ZFMVrx/TYJHSLKvKX1UyH2K/43xFcVuOQu1J3NUyQzZmzQVkdS+
         eZTI0efmHFEhMBJBLfN0sJdRQ7cKDV8JL/vGIOk7pMGrS7COnx7fWcFmxUVC44Fnm4Mi
         tCgj/uaM13UmOk3VVYVEelH2Z8+783dsJwguDdbjSAMCYIXs53nxhwDoZRlbLQ5r54/+
         +hbg==
X-Gm-Message-State: AOJu0YyGMZ1wc2pEawbr5NBgTx60eyR7NIMTFlxW6HhLtnUvLZe/hJmb
        ujNg4zgeWHOSdxc/NEsdl2LAGFoYyBh0hrxTqNaCGw==
X-Google-Smtp-Source: AGHT+IEssm67PP+7GPig2eLjq79CN2xbNLkm4Zvxrq1N4ay5HbaNCMAPnRH9T75pxLMhMzjZXg5kTQ==
X-Received: by 2002:a05:6871:49cc:b0:1dc:723d:b8d0 with SMTP id ty12-20020a05687149cc00b001dc723db8d0mr364311oab.27.1695251272340;
        Wed, 20 Sep 2023 16:07:52 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:23d5:c394:2c98:ffcf])
        by smtp.gmail.com with UTF8SMTPSA id d12-20020aa7814c000000b0066a2e8431a0sm57254pfn.183.2023.09.20.16.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 16:07:51 -0700 (PDT)
Date:   Wed, 20 Sep 2023 16:07:49 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     =?iso-8859-1?Q?V=EDctor?= Gonzalo 
        <victor.gonzalo@anddroptable.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: use MODULE_FIRMWARE to add firmware files
 metadata
Message-ID: <ZQt7RS+FdOtkH0c6@google.com>
References: <20230914211938.28395-1-victor.gonzalo@anddroptable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914211938.28395-1-victor.gonzalo@anddroptable.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 15, 2023 at 12:19:38AM +0300, Víctor Gonzalo wrote:
> The mwifiex_pcie driver is missing the MODULE_FIRMWARE macro to
> add the firmware files needed to the module metadata.
> 
> Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>
> ---
>  drivers/net/wireless/marvell/mwifiex/pcie.c | 6 ++++++
>  1 file changed, 6 insertions(+)

FWIW, when reviewing the other sub-drivers, I noticed sdio.c is missing
an entry for SD8801_DEFAULT_FW_NAME. Mind sending a patch?

For this:

Acked-by: Brian Norris <briannorris@chromium.org>
