Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F288A2655DA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 01:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgIJX5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 19:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIJX5P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 19:57:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20DC061573
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 16:57:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm21so813933pjb.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WscJe6XXZnze7gP+OZzh/5nwlFbeanGYHuWKrIw+k04=;
        b=G9sZXQSlN7kj1Tfg3jBNKWFMWRsruQteageXs5Yy0gSggiMvGf+V1xbhtoRgv7cj7j
         rwV8VWMjKbVMfWBSEZj2UfQlMMtgaceJnA6g1PoNZjFrw5knv2PQK57YsnQNEI1hHQ+L
         M/GAXXEYvZt66ESA6Q+vIOcUWUfzwrtaip+ANgNCv50UsTA2AVWlnZkLot5ei5Nah6vo
         BDLuwjJSUWtfknc5PYWLNEH3keF256kTVQa0S/OAwWxkePUoB/bjIAPM/yfUqDDgFULq
         oa5wWMdOgREC7PmNCRrv4wdBvMpbx+EblY+gXPEciFOm94x9l0qYGqh3AQoyhYmj7t3w
         u9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WscJe6XXZnze7gP+OZzh/5nwlFbeanGYHuWKrIw+k04=;
        b=cvS6+JN1E+Anb64Ryb2rdbuS7sRMRa6iBzeiuQ0YHSPiVlTNGSLtCdOSIvZ1RWntbe
         pg8mG07oqmEzzLtPmEvyrwgWWgomXD2ds8amP9PIML7YB9vrClRPGoDXmJpj4xoxvh/m
         ajxGuYZr3Jo1YUYfcnmmNjt8DzcN+PhpuPxgp+hSqy4Tq5xhtzNZ56+aLaSv0Cfa6KoZ
         y4h8SjSoXuQMjqsSe1g3y1hL21tXfvEHS3PtFLiI4rvrmh096nxjW68lE6Wg1NCDj8G5
         LfqZVqO4V8BM5rceIahJrCtzEXIMBuGUH5EOjmhEWSmFKjTxjCCMdnPXkSncpry9Szx4
         Swwg==
X-Gm-Message-State: AOAM531I/Zf6oxKviP+xQ9557kR0i+Xn2wQuM0yf0oMTrc5n/YozLghS
        +piy8b1IrY5E3QYs70TjpCSD0VrPvio=
X-Google-Smtp-Source: ABdhPJwmLjxNqu9VWs+Xj0QIqJO4O8gCLxDSd4eTKL4ArlhvaiOoHYqQ8K6JZWguznR7T45MmH65RA==
X-Received: by 2002:a17:90a:ab91:: with SMTP id n17mr2312363pjq.84.1599782233650;
        Thu, 10 Sep 2020 16:57:13 -0700 (PDT)
Received: from host-29.home (50-126-102-83.drr01.csby.or.frontiernet.net. [50.126.102.83])
        by smtp.gmail.com with ESMTPSA id m5sm149957pjn.19.2020.09.10.16.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:57:13 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/1] Hwsim crash when receiving cloned frame
Date:   Thu, 10 Sep 2020 16:57:06 -0700
Message-Id: <20200910235707.7732-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am unsure if this is the proper way to fix this problem since it
ends up just dropping the frame when this happens. If 'channel'
*should* be initialized by the time we are receiving frames then
there may be a race somewhere. If its functionally ok for 'channel'
to be NULL, then maybe this fix is alright.

I realize it had been suggested to provide a decoded crash with
a debuggable kernel, but I really dont see how that could provide
any additional information above what is here. Because of this I
sent as an RFC and we can discuss further if needed.


James Prestwood (1):
  mac80211_hwsim: fix crash when receiving frame

 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.2

