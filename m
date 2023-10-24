Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A137D5EC0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 01:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJXXlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbjJXXk7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 19:40:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9910DA
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 16:40:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6934202b8bdso4901976b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698190857; x=1698795657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4erjW6behH7h7La2Y92I2S1W1eX12+hjajkrQ+7hOI=;
        b=GBMFDutWKtD6NFqd83fWcnrGv+zW3u1TDa21tisGJrVpLreqySxqBTJdhK3YSOj708
         1cZxjAaLMQ6YiWoPUWfGYeKO9zCL4pXGgRPcQfXAVlwWeD5Gs+fCMe5Yd/Og+X49wEvF
         hnbGHcfeWw2cqM5LqT2vfcihYb91pdZXXuptg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698190857; x=1698795657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4erjW6behH7h7La2Y92I2S1W1eX12+hjajkrQ+7hOI=;
        b=PIgM/TWz+VpczYm+1X1Bl1GiRfe+Uv71lrQaPDYRmcmZnhyilvA++KRbWhdoT3qUxY
         h1MnlNmyJq4szyjrIQRCDzpV0pe29iuQj62z2D13yOGNTQDKMzcygYi2ZowodGA8CcO+
         U97uqKJmAeXAxheVmVx9nVggiwtwuVBEJwQcDQpkF3tGKrBL/CGtFigLOKEMcp9wXHoV
         VdaaOC7EhUHSkm3PfHekZJf5vJoxtJ+3banNMGBRjD+dwv/MgEGEIwwyumOQIz/HC+Lj
         kXHO/J/xzNzUzgrG0i59ePTN4Na2pss3P6jDBn++bU7ShI0PwS0wE9jI67aOF+/I6ehb
         rJ9w==
X-Gm-Message-State: AOJu0Ywltlzay+bkN+D8F4AbFk0FlpeNY6Utd3/ON0yu611qFiPNa6iz
        tCOygdbMigvio/et5iGvDi2VPA==
X-Google-Smtp-Source: AGHT+IEEUtIUI+x2mA+3BHVdxrrR1kPGjokc41iSpcSrSrEDxMWFps3gXRmnUlJkquK5ZR3l/iLyyw==
X-Received: by 2002:a05:6a20:938e:b0:17a:eddb:ac6a with SMTP id x14-20020a056a20938e00b0017aeddbac6amr4590988pzh.6.1698190856752;
        Tue, 24 Oct 2023 16:40:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a654141000000b0055c178a8df1sm6470995pgp.94.2023.10.24.16.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:40:56 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:40:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Message-ID: <202310241640.F454441BDF@keescook>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
 <87wmvcxjdy.fsf@kernel.org>
 <90328e09-5e48-4bd0-ac67-62a104b6eb76@quicinc.com>
 <202310241442.0E90AB9@keescook>
 <57a56da6-a86f-4bc3-beb6-8ef6dbbbb3bd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a56da6-a86f-4bc3-beb6-8ef6dbbbb3bd@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 24, 2023 at 04:25:35PM -0700, Jeff Johnson wrote:
> On 10/24/2023 2:43 PM, Kees Cook wrote:
> > On Tue, Oct 24, 2023 at 07:11:51AM -0700, Jeff Johnson wrote:
> > > On 10/24/2023 6:03 AM, Kalle Valo wrote:
> > > > What about using just memcpy() to make it clear it's not really a proper
> > > > string:
> > > > 
> > > > arvif->u.ap.ssid_len = 4;
> > > > memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);
> > > > 
> > > 
> > > In the "changed & BSS_CHANGED_SSID" case that comes soon after this we just
> > > set the length and use memcpy without clearing the rest of the buffer, so
> > > doing the same here, as you suggest, would be consistent.
> > 
> > Ah, please ignore my other email asking about memcpy safety -- I'm
> > reading threads backwards.  :)
> > 
> And I'm replying without first reading through my mail queue

*high five* :)

-- 
Kees Cook
