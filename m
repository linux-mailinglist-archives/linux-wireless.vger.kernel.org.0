Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09AE3E7C12
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbhHJPXL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbhHJPXL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 11:23:11 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A66C0613C1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 08:22:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bj40so9703360oib.6
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beegol-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=NCuPkPoVzbCsPo48T3mKWf7yV1XXdHv1+wZ3uY13NQM=;
        b=Qqvq6G5C5iXxx+fXR0G7upFzCqkmxb9QDKC4CKtx9U37bJvtgGqRdKvwjg8EqvapKR
         Q5tbGu4ue7aaYTNx1+/WFT7M9137e7RuzHqwhMpdR0JGmoYTcPg8+vtZy9L62lRbTghm
         aOhXkG4ZTkRmhw7SHQTe+NcPuQR1M6hBYpAoqHG0jkggJtj2GPTv4jOxnzBl0tovidW0
         7YBvdk5wAx10sBVfQYFwt5PQrQhgJaZyfJpueh52aUhv8gN5kbJ3RcyBqCGGrYatLOML
         EDhk2m5HkCOmOWyeBxQ7mOOOiQh/n36bVqUcI0JLbSnpyqx0vgmmyATd7Ryhsu/LrJe8
         k02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NCuPkPoVzbCsPo48T3mKWf7yV1XXdHv1+wZ3uY13NQM=;
        b=kQZV+lJnFaTMd638mqgQbXc8JsbrHyqqZxNBoGPkYuJ01J6/xMblfbNfZEQshvct9/
         NQClVe6WrvEGTHxAEl7wnBPvmNvAnSacFUX20QeOUegpEB6OdySkyKzxrcK/XVdxwTrz
         vC6PgRKJbF5F1r2PDVgkIjCsXhx3i1HfmXY6E/B+/5vEQylg4WG2m+3Fk7dX2BnOQHMd
         TpOSBU1TtlyTMkX/6v+BE/ELPn9YqJY7DA55BJPeW7CzdvMdgb9aJDDBXiaG2nfsR2My
         6TdqFFvWOQS9kXKehhTQcezMzh7RgZ+plX35XapZoUnI/kSo/xRwJUh6sQn9ul0Vm00V
         EyZQ==
X-Gm-Message-State: AOAM532q0DpSCxPH6vPJEceO2H+pyycofrV61ml5w2ngscfd3kOf4Qzy
        Nk3PB5LyyWwcjpqcqa6xivmP5bL/hwdEFSkUzJT0nZuSC5hAi/Vl
X-Google-Smtp-Source: ABdhPJxia662kSkIJw4U8B+2JGOaiaxjiqHEWSyTJqWly3OAdEjUbHw8yssadA1sdvy1EqI1JeBYTrGJugPQlNlxMsE=
X-Received: by 2002:a05:6808:141:: with SMTP id h1mr3946628oie.59.1628608968490;
 Tue, 10 Aug 2021 08:22:48 -0700 (PDT)
MIME-Version: 1.0
From:   Mauricio de Oliveira <mauricio.oliveira@beegol.com>
Date:   Tue, 10 Aug 2021 12:22:37 -0300
Message-ID: <CAGcWnva=JZv5fXctRvVXXKi7FgmcbuBPAKO26o4XGCqRjh7nzg@mail.gmail.com>
Subject: Getting channel stats in multiple drivers
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I wonder what if there is a way to get channel stats from AP
interfaces like the ones
defined in survey_info struct from include/net/cfg80211.h that are
further queried by
utils like iw, in the case of driver implementations that don't fill
those counters
(channel_time_busy, channel_time_rx, channel_time_tx, etc).

I'd like to be able to tell, for instance, how busy the channel is and
how much time the AP
interface spent transmitting in the last second and so on. To the best
of knowledge, the
"survey dump" call in iw is the best way to derive this information,
but for most drivers that
option isn't possible.

So I want to know if there is another way to obtain similar
information (channel occupancy,
interface usage in terms of tx, rx, etc) that is generally more
supported or are the survey_info
fields basically the only option?

Thanks a lot,

Mauricio
