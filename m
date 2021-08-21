Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA38E3F38F7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhHUGXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 02:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhHUGXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 02:23:08 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59DEC061575
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 23:22:29 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z128so22888123ybc.10
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 23:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCbieat/IK0zv/ueyt7/6tbSLD6+n9Q6rFFsOfnCC9E=;
        b=V6lFLQAOB6zp4WZbn1ASKXVzTstml3kHc368x6Dkuv63rZKFJSzQ/wJJZgoVVBduBv
         92irkdBpVKQJAEKmOYgvWTPkhwppZ8GYfpv0cXvtF6BapGE35GU+OpkuikuJCxmWcfVb
         Hhgtyy9emg1oGWqpogsNdcLfaqXgQK+ILuh/tM82oGC9uOBo1F5S8IUj3oh4lPNK8DI7
         SBWgf14/FeXC4PXLDM/5f3gkXLWV5Kx3yRfvMasCpdj17zq0wrt8Cft3ET3/5KW5mFq5
         D+Fej4sjR/pgwD67PoeLxmEOo6xYMxtBqMG4YZILb6BuYTVEuoSKYTHz24q5mRSO4hKD
         piBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCbieat/IK0zv/ueyt7/6tbSLD6+n9Q6rFFsOfnCC9E=;
        b=fjLwjx7xgMKY4OPer2MQNnv8SXRy3HnXK/2DYe11ncc3tdXeTagEk4NIv/2e6Nlimr
         RIr0C/L9kHQtTM43zVt4kxSYO1xx1+w9r4rRH1cLMgZ7yQCCFcbFMI/KtrPdJa3WTAKW
         xnD+dzr2RBBq2+9S70Rsm+vjBxKwGU3nRPq6kksUP/cTuWh2JKtjFQwaGN5noZlUiyGa
         y3wiZl3782TMYo+3GhFQ4/ji2KzKpgexHhKQcf+NjPS4eARpA7l5Z96rmlEgudC1yj+r
         gg3kt1yKVJ5erlrjZ9g3jPEKLNXgLLid4i2zh0dtnvI9x3sBnMZqAyYaAMG0fqMM3ph/
         LmOg==
X-Gm-Message-State: AOAM530cbCvtxsYm7yjs+lAA25pSxwYNX57kPEV8B/R7O4Q2zWcP+VG7
        yXvI1pnfCZgAa8yvlRvDSY/U+W3uJkqYV2AsgAm0M5fcvhZWG8Ht
X-Google-Smtp-Source: ABdhPJwzBYShQc2tDbUF3OiZtRc7ihxYV1bEo/lYB8Bba9KZBQK0SyCXn1DJW+VOuiEy1YI1Iu0v5WuzaXK/xIlHWy8=
X-Received: by 2002:a25:c9c5:: with SMTP id z188mr30659553ybf.223.1629526949052;
 Fri, 20 Aug 2021 23:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com>
 <480c17405d7735bed3148c3085f93e3d278acadd.camel@sipsolutions.net>
In-Reply-To: <480c17405d7735bed3148c3085f93e3d278acadd.camel@sipsolutions.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 21 Aug 2021 00:22:13 -0600
Message-ID: <CAJCQCtQqqrN2-AApnOwbTQYxARA5GEfiTPKQDoEmYKdSm0Jhxw@mail.gmail.com>
Subject: Re: 5.14-rc3 lockdep warning, iwlwifi 9560
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Filed a bug
https://bugzilla.kernel.org/show_bug.cgi?id=214123


Chris Murphy
