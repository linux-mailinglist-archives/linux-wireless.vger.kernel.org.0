Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5D67A33
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGMNC7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 09:02:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35532 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMNC7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 09:02:59 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hmHg2-0005rZ-BU
        for linux-wireless@vger.kernel.org; Sat, 13 Jul 2019 13:02:58 +0000
Received: by mail-io1-f72.google.com with SMTP id f22so14160574ioh.22
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jul 2019 06:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tU+x96g/vSnmBezVc42bke8XpBT4hQ9LXRrDqA+3cKo=;
        b=hvYHH70iQz+BWj26boS67kEzIzAf5JsH7E6LkDCpav5iY7hqiexuQA7W2neF84NUbK
         VJmxc8wiZIEAzYSx5eXOlB/psjFDh6o5+uM7GSw6TYE4N7kzvT+5lRgw6QRifRtyGd3z
         IiXKSVRvEW+ZRHxPLYdXGdREjSqPdY0fDOSCldXDuFIEw6KvE6XaHRV882wSl/FvNyA2
         fvtnPvOq7/8BuFYM/1wlof2XwaE+l1Z1PzIIMtSFRwXKYra2HO9SwZ8gwapewQQJ33Fh
         jCH0/8SfyYqberu9KKO9Gc1fA5mgvfTe8Z0lODMxbEOPKL/NfX9OfrXfSNtGAQC2HLJ2
         T7aQ==
X-Gm-Message-State: APjAAAUT2KikTj3LnJ6HpHnjyZEGdeZWpwc787W4yrVIfAs69TuTE7sg
        /TGLasGj23jH6NUcKcta8c9Hdr83WQjV+Q5+EtWhQ+WDsfhWiKbgvno9hmsZ7+bhwLFekCBdlqO
        DgRDu3aj18ydzv8ggWmICCXiSx4bWfhcRoICFXkDMHION
X-Received: by 2002:a6b:b593:: with SMTP id e141mr16507042iof.203.1563022977154;
        Sat, 13 Jul 2019 06:02:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHCgYszZmuGCwFtb1rkY96An+yyT/F0SDQ35OOmYipkwRrbn8MV/liQzRWB6TBFht7nv7lAw==
X-Received: by 2002:a6b:b593:: with SMTP id e141mr16507012iof.203.1563022976823;
        Sat, 13 Jul 2019 06:02:56 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:31dd:dc66:96d:f1eb])
        by smtp.gmail.com with ESMTPSA id k2sm8556113iom.50.2019.07.13.06.02.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 06:02:55 -0700 (PDT)
Date:   Sat, 13 Jul 2019 08:02:53 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Martin Willi <martin@strongswan.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Henrik Laxhuber <henrik@laxhuber.com>
Subject: Re: [PATCH] wireless-regdb: Fix overlapping ranges for Switzerland
 and Liechtenstein
Message-ID: <20190713130253.GH5418@ubuntu-xps13>
References: <20190702141944.25902-1-martin@strongswan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702141944.25902-1-martin@strongswan.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 02, 2019 at 04:19:44PM +0200, Martin Willi wrote:
> The commit referenced below changes the 5GHz frequency range 5250-5330
> to 5150-5330, making that range overlapping with the existing range
> 5170-5250. This imposes DFS limitations and a reduced maximum power
> level for the range 5170-5250.
> 
> The change of the frequency range seems not intentional. Instead the
> commit should have changed the 5170-5250 range to 5150-5250, and the
> 5250-5330 range to 5250-5350 (see [1]).
> 
> [1] https://www.ofcomnet.ch/api/rir/1010/05
> 
> Fixes: 957a7cff72a3 ("wireless-regdb: update regulatory rules for Switzerland (CH), and Liechtenstein (LI) on 5GHz")
> Signed-off-by: Martin Willi <martin@strongswan.org>

Applied, thanks!
