Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1839F127
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFHIop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 04:44:45 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:45695 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhFHIop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 04:44:45 -0400
Received: by mail-pl1-f179.google.com with SMTP id 11so10239489plk.12
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJLi9BhF+LiFNRjDPUmJyFD+uMa3FNUXRrTewLNrVvg=;
        b=YMoMPkMzOdknJkSCxwrfnQEJUlQOFnyOHCQzuM95FAikMw17xO5CkI7DnGQWvpePhy
         XxDgvGdX8FRI8djNwwzQ7KOcx/RQs2VQaAxqfSKaN06V//NtAWan16kdgU5OE6SqBb8C
         ihVX3vQ68wzkcx4Dml+4iD8QA7nAs0oO9Rpk0RB7zVDtVyaK4tKXgBBwafA0pGr5o25/
         koZyZgkjp+yVFENOFMmC7Lz28RqOs3Fl5fPmha5nU3A6O33gkD1ktW4MnalPgjMu+YJr
         sqXHrhWoKrDLoqcLzYhnOb+tpkUheWGMjBakQkpCngjbqQQalohxSyXFWx5yC+yAP+/Y
         B0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJLi9BhF+LiFNRjDPUmJyFD+uMa3FNUXRrTewLNrVvg=;
        b=EuLsZBXaR4NkfUmS4HBTFL/q+sJlUWVec9xaBKsIRTUhoOhiN1kIlY7w6izzaw0wc5
         wj1iedM8QBPN2LebFtGI16LMROZmFU3mSLyU1zTkoEUibNMVEcNqOQPgKzitTaYxFIuT
         uq6NKBB2r3sB/svMQqk99AX3Akq2BFR+/VFj62iVxIAbhrJFAEq3UuddrAF3APf/9u94
         sfoXQk6p2TOkNsMUmjrfk/h/0E+IiuIMiDnnEQl1WyiseBqp/lu7xQMthXGwIy4lHaRr
         zMJ/0f9dZMhL/x9NVIMBgM0htFBpK7YL4BUzQGP6+0/lXb1tXcGdMmU83VyuPkGHPi7+
         3WTA==
X-Gm-Message-State: AOAM532UcgbJoOjxnYKkrxGT1vcu8SuVZZIZZ9wdRpZyB4vStN1LgAR0
        5GFmCIc8vDx1qIkrs0uHC6WZdthFuyYjlfpcLHRTzw==
X-Google-Smtp-Source: ABdhPJxfMNAjLkZ52tEdGM+okCpTDfBp5W9UFvvIcwnSj3aSgX/KMogzksKup7OrSz/9H1ZbgCA4RY2iwMR+km9+6dQ=
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr24579215pju.205.1623141713015;
 Tue, 08 Jun 2021 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210608040241.10658-1-ryazanov.s.a@gmail.com> <20210608040241.10658-9-ryazanov.s.a@gmail.com>
In-Reply-To: <20210608040241.10658-9-ryazanov.s.a@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 8 Jun 2021 10:51:03 +0200
Message-ID: <CAMZdPi-24bQUKWQK7fnuOdD85dSqys9-twUggbrbZUAGvOnRKA@mail.gmail.com>
Subject: Re: [PATCH 08/10] net: wwan: core: implement TIOCINQ ioctl
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 8 Jun 2021 at 06:02, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>
> It is quite common for a userpace program to fetch the buffered amount
> of data in the rx queue to avoid the read block. Implement the TIOCINQ
> ioctl to make the migration to the WWAN port usage smooth.
>
> Despite the fact that the read call will return no more data than the
> size of a first skb in the queue, TIOCINQ returns the entire amount of
> buffered data (sum of all queued skbs). This is done to prevent the
> breaking of programs that optimize reading, avoiding it if the buffered
> amount of data is too small.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
