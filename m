Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E582AABB7
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Nov 2020 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgKHPGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Nov 2020 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgKHPGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Nov 2020 10:06:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6BC0613CF
        for <linux-wireless@vger.kernel.org>; Sun,  8 Nov 2020 07:06:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r186so4676745pgr.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Nov 2020 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GP5jWQ2vG+HK/v7Rhb8YTkyKejYspST0Y6G1eWcxNyc=;
        b=DzAcUxs9rbjq/S+XubAGc47LeEmjDZhE5TUioxxqo7hW/jumPMg0F0WZdTOxJ3ijqk
         3k7FinFELps9wfVYFglG8Z7HO+NKZspJnoHW9KLFyfhJ4yop7jRXh+dBBujm+iQuTWnx
         yp/EjQdLLywSnhrOQQVEaq3b5pq1bQutbFcr3szlN8xgarWWzLNGZJx4CKRdDW7koyHQ
         hafi9Q77XTeBT2+7+rkjyix7we02fi4YYz7dQmLKED1qYqjfCRzYgrgTopbEWjhqiWJt
         Vv/SEjAiarWH+oky7TlupdPa2JSJzgCdyhTdOsmsEj21+r8zuM/WD4Spk1ESiF8Uy/NA
         r19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GP5jWQ2vG+HK/v7Rhb8YTkyKejYspST0Y6G1eWcxNyc=;
        b=uhPanuyFZOboiBDJ8GE6ZXkJb/2P985rx0LEsJfiEfyt5CmnXbJ3gmRPZP4bws11Hr
         C07bs3GSX5C2KCqcXTnuBWAOolFvzfqT45CV7P4B0VNW+7ojp3+2EWgoIi20wMaOEKoz
         Wt6a54TTNYu6zOhbU/df8HsfcMerQwZo0eX48bu34HnGGntVU6rj9I26HTVED6k+oRib
         qTty9+uNy8wPotF6ymEP0Q3YOE/Ki1tLvYhdXEqsSI+1lkXnMgseekAWxKmrynLrGDEx
         10jbttzCblDdqQ+iPBaRHzigOD2xGK27uGsO+vYE5tcbBFks7ZE3o5PLvGN+xun8BxlX
         4cmw==
X-Gm-Message-State: AOAM5316BSOxET7Qmq/Ja3iaSVxCdhFl02XF4x33qETeR7iuUnFLSsp9
        VTla8nd2N+GLENtLSk5KfSxDtV3kF0R5/zO5yEI8moRrFMKPvA==
X-Google-Smtp-Source: ABdhPJynmQdyjzauTH8bM5Wyy2iz62bLSNMjpt7DXZ5NEO0L0lnhWfWTp6k4hkOy3Ts4iE2qwN6QBcvVca4Mb+29AhY=
X-Received: by 2002:a65:60d8:: with SMTP id r24mr4520515pgv.152.1604848001868;
 Sun, 08 Nov 2020 07:06:41 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?TWF0w7rFoSBWbMSNZWs=?= <matus.vlcek@gmail.com>
Date:   Sun, 8 Nov 2020 16:06:26 +0100
Message-ID: <CACkr=P0bsSj4bb+QVXtW+nkqktG0FZaF5NM=ijfb_VpQ0ckeFA@mail.gmail.com>
Subject: [ath9k_htc] Send ACK according to BSSID
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
I found this email in wireless.wiki.kernel and I hope it's the right
one for asking questions about ath9k drivers. I've been having a
problem for a few weeks already.

I'm doing a project to modify ath9k_htc driver to be able to make
virtual access points for individual devices. That's why, I'm looking
for the part of the driver code, which handles sending ACK to
connected devices according to BSSID addresses. I've already gone
through a big part of the code, but I couldn't find this part.

Don't you possibly know which part of the ath9k driver code handles ACK?

Thank you very much for an answer.
