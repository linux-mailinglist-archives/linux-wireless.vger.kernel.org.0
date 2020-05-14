Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320BC1D25A3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 06:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgENEDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 00:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgENEDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 00:03:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31F1C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 21:03:19 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j2so639287ilr.5
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bEFjjYkZmq/f1odNJLbLiFARlwVSY8mRNc/9WqwFTek=;
        b=e+W1uKmOJLD3HzeMH9THUJ/75VtfsizthKdEp4+xkS1PY7KGIzP5psayHHa0GHb6nj
         L8dIXNthUGYYrLjznWMDT76s+aJAcMwSko+Viox1b+BvyWnjtUjkNuR7/Fa05I34YNJx
         ce1SUdAHS4zc6CMqCfVLzjVDImXnZA+vBSrDCcgFGFGsysnohwEtgj7xtGm3vXOiaMlS
         cQGWDtmDP166QnGeznRcs8kuQe0DgBh8Mh671lFl2E+BoJ/EQmc4i+8gbOQqrTTcfIuL
         kQ7HevZ+Qm46F5oFVomKL2kfZTHCWJpTzw90YAn1DmcCt4t0Ke6aiE2LMdwkodqDzF7U
         FjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=bEFjjYkZmq/f1odNJLbLiFARlwVSY8mRNc/9WqwFTek=;
        b=bLfQE93vdRQJlOAdGqK3PTSgk3WPgETMhYVw2WhDkqpq1K6kNdWRAfwTeqFSX9w5ac
         n3NkoBJiP2kjygF93XioBhzGOtfzChwzF00Reo3za7nY7wSJYlVbTuza4GI6rOhY8GBN
         rbTJGP72rys9aoc4xhaS1sOi3iLQNomcg4haboljOq6/8X/GbPpXaLFZu0YEnEzqvc8t
         I1pnjCgofHbKErZKE+Y0SiG/GSCQLPutxXeHq76AppmQdnx5dRwXrY8S7WuG4q/Kfi+K
         9LV+HNlLJYNqiSDRP3nE1TvBJ4S8Se3gA2vb5Elo9VeGrcJi8Gc4lYw/Gkwm37pQv4j4
         +RUg==
X-Gm-Message-State: AOAM530jN4ljPkv8V48YTTKm5XfwFauJCx3/DfIawlVITPAfVmZZ5Q93
        /GfZo+FGznvL0XYbCq9RY9vjFGMsp87H6i8T6CZVvw==
X-Google-Smtp-Source: ABdhPJw7AJXqvAHc/iWySXYDI/gE2sPQa+do/w4EzI1FM+ZRYfMVWw5zSADQV2wJTShQmJYzcr5WwKKY1Q7gSs1nQxs=
X-Received: by 2002:a92:d188:: with SMTP id z8mr2679190ilz.60.1589428999119;
 Wed, 13 May 2020 21:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSR4cuy-jj=L1Vf4mmZQWALzrFGE19bODa81KnnJ3MkX6jbtg@mail.gmail.com>
In-Reply-To: <CAFSR4cuy-jj=L1Vf4mmZQWALzrFGE19bODa81KnnJ3MkX6jbtg@mail.gmail.com>
From:   Dongyang Zhan <zdyzztq@gmail.com>
Date:   Thu, 14 May 2020 12:03:11 +0800
Message-ID: <CAFSR4cvAPkKzkNUOrifc8_TGno-+GYJ_DxJ5LKu0pt5M-o5HVA@mail.gmail.com>
Subject: Fwd: Potential memory leak bug in rtl8xxxu_tx() by triggering
 usb_submit_urb() failures
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongyang Zhan <zdyzztq@gmail.com>
Date: 2020=E5=B9=B45=E6=9C=883=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=
=882:45
Subject: Potential memory leak bug in rtl8xxxu_tx() by triggering
usb_submit_urb() failures
To: <linux-wireless@vger.kernel.org>


Hi,

I am a security researcher, my name is Dongyang Zhan. I found a potential b=
ug in

/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c in Linux
4.10.17. I hope you can help me to confirm it.

If usb_submit_urb() fails, usb_unanchor_urb cannot free tx_urb->urb,
causing memory consumption bug. This bug is similar with
CVE-2019-19068, which adds usb_free_urb() as bug fix.

Thank you.
