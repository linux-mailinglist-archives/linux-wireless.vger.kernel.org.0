Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6348A1EDBD9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFDDqX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgFDDqW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 23:46:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C606C08C5C0
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 20:46:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b7so1725498pju.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AKUvLro9S597CUdKLkHtfULaMJzReX6aR4Vd+jg9MWw=;
        b=hKAsiTFpLHHgYk7uxEc64hy/HUaA1WkUjC8d9BKcLM3A/W0jWDjCQVcYLc0TzJIb6c
         CVvGbgMTwJtWW3d38WnReaNXfUDB6Z7+PjsIdPE8tJzwBE5kkiQFZuUsHl9gXF2t3hNz
         P/mhkULSwbWlOZpcliQwUyTPCPRZerjJhSiPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AKUvLro9S597CUdKLkHtfULaMJzReX6aR4Vd+jg9MWw=;
        b=Om3dlLAfFODw2LGHmhq3755LEQ9zzeGSxm6r0CBsY84vXOPWKPMzMc/N4SdBdPxPZK
         gKg4lWhABxdaVo8h3THO2UWM2fapG4jewwJQrHm2x4PyNyWiH0Tum0/EYz2npsdYgAe+
         JGNzvOqI03PgghZ0yVBk7N7gt0XqCbFCLW3wLPH9bqs5jq5pwOi0AFNKZVYXCFJufAE4
         oUOmViNSTG1Ml2pAPQ5aVnPgfm9+9m4vKTYNTyWn5a8VHqDZBch6HPN6R/KPGeNf2QfK
         KvvQnpAZTWMWOFxX8K5V/6Rl7j/RJlC6yr6Kd9UD926T/U7NcOs35qnB+tomcZfeuBFi
         AkmA==
X-Gm-Message-State: AOAM530HMXmlG6xfhHaowhfzR7IiYjwOSVRSke16k//R39xpups2c1OQ
        wSC0LcJfWHmtaVj5cLLTGqySXg==
X-Google-Smtp-Source: ABdhPJwgOC5Nh6YRgoFEBFoD4RiNjZ8EE9ykV4UyBnz631Lr2h8YJbe7vzR1a+QiANBM9x+EA79IfA==
X-Received: by 2002:a17:90a:2461:: with SMTP id h88mr3702337pje.180.1591242379970;
        Wed, 03 Jun 2020 20:46:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a5sm3056506pfi.41.2020.06.03.20.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 20:46:18 -0700 (PDT)
Date:   Wed, 3 Jun 2020 20:46:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 08/10] checkpatch: Remove awareness of
 uninitialized_var() macro
Message-ID: <202006032046.96A726426@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-9-keescook@chromium.org>
 <ff9087b0571e1fc499bd8a4c9fd99bfc0357f245.camel@perches.com>
 <202006031838.55722640DC@keescook>
 <6f921002478544217903ee4bfbe3c400e169687f.camel@perches.com>
 <202006031944.9551FAA68E@keescook>
 <CA+icZUVg24VrpPgMdfsgPa+Wckci9XkzKUdtwhVB3ZW96uZOWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVg24VrpPgMdfsgPa+Wckci9XkzKUdtwhVB3ZW96uZOWw@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 04, 2020 at 04:53:34AM +0200, Sedat Dilek wrote:
> can you push that change also to kees/linux.git#kspp/uninit/v5.7/macro ?

Done! :)

-- 
Kees Cook
