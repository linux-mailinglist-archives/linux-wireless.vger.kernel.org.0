Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979FE3893B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfFGLkk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 07:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfFGLkk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 07:40:40 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C94C208E3
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2019 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559907640;
        bh=VLOHAN3KdZNJJOG1SSxuTMJorpZrP6a8ciyQHUoNea0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ff770wxlqCwzM1iRmQaoGrUC7ofYmN9Cv496Lgle2jqC8b3eb6RKwb/R7/P0wXXX2
         gZcd1WeWg1y3w7W/+DucJFhGoAYtnH40ZGT7tgiTRAwgiwKxa0n5iI24+al1L1ClAM
         fJlfp6768N0hu0RYk9gLrB4LuwrcjAelYR+dRiDg=
Received: by mail-qt1-f176.google.com with SMTP id z24so1784193qtj.10
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 04:40:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVL8Pm0n0mswo3YFH2e/xZCbBdbEOVOzMBWoLpLLFzCHJIDCYEm
        ZI/9KmV20xvI8Jnkyr7ELbhAgMtk59XprjjI4ds=
X-Google-Smtp-Source: APXvYqwreirH6jdt2CXsaffRQ3nAWEfm69FMKnxI/7RSZo2Hc7ffnzqEb9S7/jzHXluudmq6DKo6dwV9V4jwxxt5GBk=
X-Received: by 2002:ac8:45c1:: with SMTP id e1mr43564603qto.335.1559907639313;
 Fri, 07 Jun 2019 04:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190528164646.3633-1-siva8118@gmail.com>
In-Reply-To: <20190528164646.3633-1-siva8118@gmail.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 7 Jun 2019 07:40:27 -0400
X-Gmail-Original-Message-ID: <CA+5PVA53iEUgU0K5SLh_YtRzxmVOfqp3MAatQc4SAd3=oY1JZw@mail.gmail.com>
Message-ID: <CA+5PVA53iEUgU0K5SLh_YtRzxmVOfqp3MAatQc4SAd3=oY1JZw@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: rsi: update firmware images for Redpine
 9113 chipset
To:     Siva Rebbagondla <siva8118@gmail.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 28, 2019 at 12:47 PM Siva Rebbagondla <siva8118@gmail.com> wrote:
>
> These images will be loaded by rsi driver based on operating mode.
> Firmware version is 1.6.2
>
> rs9113_ap_bt_dual_mode.rps - AP and BT functionality
> rs9113_wlan_bt_dual_mode.rps - station and BT functionality
> rs9113_wlan_qspi.rps - AP and station functionality
>
> Signed-off-by: Siva Rebbagondla <siva8118@gmail.com>

Applied and pushed out.

josh
