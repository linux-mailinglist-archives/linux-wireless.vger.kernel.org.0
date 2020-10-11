Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865AD28A835
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Oct 2020 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgJKQN1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJKQN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 12:13:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876C7C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 09:13:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ce10so19904321ejc.5
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=g40do8t/7LxpkF2rWDjYsZ9n0f9pwR9vDeQsHsVKyT8=;
        b=GlKsPiQOX0u1E+RJvY9p2KDqxTX5noYXtV5aadop6qe6pkYf0A7FcQzJ1rdYWV9++i
         8/Eg3S5/LUt67XTzC0M2s0IUrQd4qv5SPAB+ysYMLTEjmqN0r/cXo8/snJOOx/AG30xw
         KfvV0DwzZHqtphQNShlX3TIvkijdci5tPCNcIBwH+q1jzkDQDI/JB81jm2fQzyllQ8qD
         oYsFZp3ARXyXU4VNUkSOsT7SNezxKpLiuaasT4Wvvz//nRo3igzsbgZ+wpplejffeSj5
         r383OHGUr6Txldr4hcm1mVDKDII9kMmwqe9KqVfTpxPxfKBPQX8wYQIHXYyQVNVh9ADF
         ZhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g40do8t/7LxpkF2rWDjYsZ9n0f9pwR9vDeQsHsVKyT8=;
        b=DxAdEgj79jjfmNyG6i0Jf/67NlKwHBFa1E17cILvT+/oSz4N92dbIjKKtCYLp9N8Kq
         oZLA2o+RRw6sSyYkBNRl3PqjP18mOAu2tZp/0Bmt0e9CbM7iQaw9JFzxR4xMJeJ0HPZe
         dV6G44FhH2oIYJTLFJ80JgFxSbU4YDzuqmQfpAVErBThGJVzWYcLLsQKSFFu+vMXx2ac
         S/YN/UBtY2QBGEvU7UPlstGw2SUnzQO+4Y3wFlQlZsfFBxXj7lWVaWYeJ9kItYijMLeB
         n4GuZqPa/H6XbN9vTMRhUuVYfGwsw6tvrRFvwhuMTmW7PI5cBHLvYCqUVG1JXne3ahmy
         /RhQ==
X-Gm-Message-State: AOAM533SkFbqe4I7BiNtVLAfyTQPVni+0aFD0cPue3/6eBHepwZJElwR
        teWRtukznRkRn/7pBGi47EvBE6voWVrS8G7VXxVfzXpETBaqEA==
X-Google-Smtp-Source: ABdhPJxJ4XtuuMKrbbmOa5Fg6mGD7qGyGJ+fEDgFTLn/oKFo1l/RmHWt9FHmqw/8cYbLEwsjyTFbatpQ8VmT4YwgWU8=
X-Received: by 2002:a17:906:cb03:: with SMTP id lk3mr23636846ejb.491.1602432805034;
 Sun, 11 Oct 2020 09:13:25 -0700 (PDT)
MIME-Version: 1.0
From:   David Rubio <david.alejandro.rubio@gmail.com>
Date:   Sun, 11 Oct 2020 13:13:14 -0300
Message-ID: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
Subject: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On the kernel 5.9 there's support for the RTL8821CE chipset, but my
variant seems to not be supported:

Oct 11 12:20:39 youmu kernel: rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
Oct 11 12:20:39 youmu kernel: rtw_8821ce 0000:02:00.0: failed to setup
chip efuse info
Oct 11 12:20:39 youmu kernel: rtw_8821ce 0000:02:00.0: failed to setup
chip information


If you need any further information please reply with what steps I should take.
There's no wifi working at all here, and those are all of the messages I get.

Thanks you!
