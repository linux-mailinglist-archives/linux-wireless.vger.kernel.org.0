Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABA3BDB3F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGFQUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 12:20:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37566 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 12:20:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1m0nlW-0002y7-DT
        for linux-wireless@vger.kernel.org; Tue, 06 Jul 2021 16:17:42 +0000
Received: by mail-io1-f69.google.com with SMTP id v2-20020a5d94020000b02905058dc6c376so10851093ion.6
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jul 2021 09:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y58+WFdKQ9ESnlf7u6fi1DEq4jbngpeqAuSz2CU3Kb0=;
        b=ukugu/0xDQ21y1RQTtykqdXv3HNjcgxO9ZnH0/my/eG6FZiP0WFEkqS2idQHDhosLo
         6PEBBbIUS6IFepXIpzWFHdKcxvK1+qMzp5GhZy/qvUjlbllzbCYvGy8w5sQIRSzS7+pb
         rbS9idPgCLKcmEh/jn3Cz6wl+dSgzih5VhDr69bm1SxWPSYL71e7m+2FerIELhZlbQ8+
         Wstsqi+NbZPSKn+s9WuBxq3yFMzETOCMvIc0MSvDs8g2GBvpsPzgfq94Xj1Tq9ab4/TT
         jYTzWlz3E6zBcrLnKa7QyE/oVB3yKEzEXASBS1bE2IGqf48WF3XZb5dgD1lo4V0vFouW
         rDmw==
X-Gm-Message-State: AOAM531KbAczLU8QluzmcRUXRYLpD4PCmxW7KR8Hv6xUtt7FoZxOgd6a
        kKD+BZI/I1++4ZVUbOHWKR3I3VZUCO7zS1OLt2fWt7oHUf4pc0mvdhheSzKMzm1rAnZQTOIE9Yy
        pn4mwkATfDZl/tH5DjyWPlcsJKNAHiKueOBnsXeBuvmTf
X-Received: by 2002:a6b:5a16:: with SMTP id o22mr16884125iob.101.1625588261461;
        Tue, 06 Jul 2021 09:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxATEB3HZyUWq1/2Hz5298NkTB2xtZOarjixFljPlknytPEmXKaYfKG6IQLr4j7RQ4fLbF+w==
X-Received: by 2002:a6b:5a16:: with SMTP id o22mr16884111iob.101.1625588261222;
        Tue, 06 Jul 2021 09:17:41 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:defe:f101:dc1c:6a12])
        by smtp.gmail.com with ESMTPSA id d13sm8277555ilv.34.2021.07.06.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:17:40 -0700 (PDT)
Date:   Tue, 6 Jul 2021 11:17:39 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     mj888@mail.co.uk, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: update 5725-5850 MHz rule for GB
Message-ID: <YOSCI2bhylSuW8GH@ubuntu-x1>
References: <20210608141341.86462-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608141341.86462-1-seth.forshee@canonical.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 08, 2021 at 09:13:41AM -0500, Seth Forshee wrote:
> Based on the latest IR 2030 update [1], update this range to cover
> 5725-5850 MHz rather than 5725-5875 MHz, increase the max EIRP to
> 200 mW, remove the DFS requirement, and add NO-OUTDOOR.
> 
> [1] https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied.
