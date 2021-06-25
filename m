Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E061F3B412A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFYKNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Jun 2021 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFYKNV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Jun 2021 06:13:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C689C061574
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jun 2021 03:11:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g192so7641528pfb.6
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jun 2021 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WmVAzQvbDduySG7/wgZSbF5qU2c264S8nSaklWMRCn8=;
        b=J/VWvd7L+gxJq4wQL4aZX2Ut0VF8je7+L3ZkoxOXdmFYXf1lmZLpB8+1gxDKSuf/+j
         WnJoZPXIXhvBl7HVNCDCK8LRkMVTeGrbgI6fgnorpTAu4VAeYUfWeyXCTxzFiSV1XMJ3
         6v17ltZtFjcU+9SQhGSpbtrdMY1R6yHLPd4J8n5J1ZVmfOuveN+sLUz8rrJ+lRUm9nuX
         yYdGL9se3c/kb++Rjn+rSGEk0etBKXvn4t0OGBq/Q0GObwOiPPcrKKjP3WHa6R/sdO5q
         ckJzXke8TES+q/MzLCYtOFzLlKsI3IQ+FBfJROZ/ke9fQJZFPb3HpVPrCg7WxV1y+mWH
         rktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WmVAzQvbDduySG7/wgZSbF5qU2c264S8nSaklWMRCn8=;
        b=VpCpl+9jdh818RfLcph9sW1/jKsg26Oj/csfRujMrG4fmxUA2jShNSsG3CjpY9HR6Y
         tpc8rnEs7dSh/zLDYs7DAqK8hbvt7Q0PxbvPk4lP4Kc4Z4yj8mJCGeYxkDGURvxxWinr
         Uimhgs7kwzASw+rttULe/hYXuERDCpCzn1XzcV4r4lWQRjrAOUmGU1nN7DWzevMO24rv
         tzraz/29CmPNg0Aqdo/pf8Awj4MivhQoiOtRZjTNm8qYEW5o4EexFjfAoqncL45jHM4n
         71V3Wu5qDPAbtk5EmBJb1A8U2RxuHawrS16UHu33NNxg1jFIFis8JfGMqhexbGK3HF6N
         YKig==
X-Gm-Message-State: AOAM533atXpqgf4bh9H4VY6oDdK3IOhClQEzyu7wtHa1FYF/sGmOT7VW
        D6KbhIwBATHhyCWjR+AAqxiLLeWHXPYBGotdA8lkM/iHIo0=
X-Google-Smtp-Source: ABdhPJyrOXYtHeTnDrYmBfIVL4U7Kum4ie6Ap/CyXqwWjni5aZayTedgTL2ppKSZe96+Srhe0ezjOpB+U1puivSzQsA=
X-Received: by 2002:aa7:9409:0:b029:303:1db:94d5 with SMTP id
 x9-20020aa794090000b029030301db94d5mr10005642pfo.72.1624615859883; Fri, 25
 Jun 2021 03:10:59 -0700 (PDT)
MIME-Version: 1.0
From:   Sergey Naumov <sknaumov@gmail.com>
Date:   Fri, 25 Jun 2021 13:10:48 +0300
Message-ID: <CAH3pVZOevaoOJ1SOOdiuzajM72WiuZYwURNQ8ky4FyUXNFmqHw@mail.gmail.com>
Subject: iw: some stats are missing from nla_policy
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello.

I'm developing an application that uses libnl to get some wireless
stats and I use iw code as an example.

I noticed that not all parameters are added to nla_policy. For
example, NL80211_STA_INFO_CONNECTED_TIME
(https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/commit/?id=087d778f6f82346debfd275ddbb8f646f9a1a167)
is parsed, but absent from stats_policy.

The question is whether it is done accidentally or deliberately? Is
there some hidden logic not to add attributes to policy? And then why
to use policy at all if some attributes are not checked anyway?

Thanks in advance,
Sergey.
