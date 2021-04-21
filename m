Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE7366F00
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhDUPWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 11:22:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbhDUPWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 11:22:23 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lZEfl-0006sd-GV
        for linux-wireless@vger.kernel.org; Wed, 21 Apr 2021 15:21:49 +0000
Received: by mail-oo1-f69.google.com with SMTP id a22-20020a4ab7960000b02901f243657c21so1323902oop.16
        for <linux-wireless@vger.kernel.org>; Wed, 21 Apr 2021 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AUyCYdEEYIlEnakSduhyM/fC90b5efBH2B0s/8y+mdo=;
        b=Ng1/GYYnsW6zVelN7MyNCBxUQ9CK9acNlLNaWMrRMZxLRg+Gxqji76CyO3bYsWbTdH
         Y++pHbrzrcWE8h0E/IHKdGGJoE1Mu0RWurWggUGSKzu4IZmddkuW9u5CUQEcrm3mlvpX
         2hP/WC7RR8wH1tmhLf88jZuMPxmZEI6f3XivwcrbnnRio1NDraMnKONzyuvAtVH1hN2/
         EZhGta5cQpQsLHvo1tqqJPCKHORYKFr0YbTWZS7x2AM98yQSXEkLYHmskDuGryzNRb5F
         Poa4UkuQL6j+W1fb/sAHTcp3AZ74RTRevVHHAmrw8zkRU4viM2eL4FK+cf1AD195y/a1
         Ukmw==
X-Gm-Message-State: AOAM530+1UfOGeeImSVxikVKL2qTMlaU+o5gBhl1NN328xnGIzZq9dED
        ZoUtJQ/tP+gSB8w2jtDFzqg8lFEVQJfmHUh4YEJAA5PQUc1TAJHps/cJxQmUJFmgOec+ZyphY2p
        DEoVOOk8EtYZNVqXt5iWZar1WQEj2mWAVx4BWxuJyfTXy
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr23609745otu.52.1619018508550;
        Wed, 21 Apr 2021 08:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE2LTG1ZElObptDidKDAw6LdfO04J6URIULr5FjhubibM3yqae/Pq4pQgqRdmhtARotlWUlQ==
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr23609733otu.52.1619018508357;
        Wed, 21 Apr 2021 08:21:48 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:c9e3:db4e:41b9:a83e])
        by smtp.gmail.com with ESMTPSA id c14sm499471oov.21.2021.04.21.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:21:47 -0700 (PDT)
Date:   Wed, 21 Apr 2021 10:21:47 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     =?utf-8?Q?Jos=C3=A9_Daniel_Rodr=C3=ADguez?= 
        <josedanielr@yandex.com>,
        WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: Re: [PATCH] wireless-regdb: re-add source url and info for CU
Message-ID: <YIBDCz7+guQ+V01C@ubuntu-x1>
References: <20210407220054.9347-1-xose.vazquez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407220054.9347-1-xose.vazquez@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 08, 2021 at 12:00:54AM +0200, Xose Vazquez Perez wrote:
> Handy to find modifications or new rules.
> 
> Cc: José Daniel Rodríguez <josedanielr@yandex.com>
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
> Cc: REGDB ML <wireless-regdb@lists.infradead.org>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

Applied, thanks!
