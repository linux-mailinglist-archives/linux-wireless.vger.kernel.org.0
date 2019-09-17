Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE41B536D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 18:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfIQQyJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 12:54:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37074 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfIQQyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 12:54:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so3494227oie.4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fkl5Uz6CO+6SZ9rgr1xpzLXgAD4uYogYiQzsQ8Qmof8=;
        b=Q9Axmgwlv0XCV5OdW7F376JmCHs8tHV4ArzG7ORYWPPj2R6ljxSfzgFUH6wtHtgIp7
         m6k+AeMw5h6GUIzMgMXa0YRR/ACcG//DE7yHXJQE5qpQuIOOzVDs9vL6085CiB1o6X1P
         jt1n7cOzb+an/w6Wm6C+8ums8jxEZtNRO5UEdC17TzQLJKgG/GJ33vyMCwExAiyrEKFo
         EMJihcL8hdX1DSqO6LG6D1xvTq/Y5aLU7dDjqyQ/1qH1DAAl9o7M9dxqiftrBjWKr9GD
         F99R208XfDKD5svc7ydWs3sxX4GaAFNMtjD2HbkOcIa8DRlOM5GsmhsOZMxLR949/MhV
         b7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fkl5Uz6CO+6SZ9rgr1xpzLXgAD4uYogYiQzsQ8Qmof8=;
        b=TcnzkNDKdgP77fxttc6ztrFgpMLGmCX5XclbtYXinCP2n5aDbJrA3Hydfteq4kLmvM
         bBAmwIBSsnBotLnq71PgWXyFJWy3tGZ5f/J5zt3umTi9fuRYiDwpJ4oLogtkXdwcSuKi
         TMa2mhIpC2DYti2JncAGhrJtGeD9avvBDl4LWJjqLkhyKCbMkw/Q0Jwi7/pJfGJAyu0R
         u0iS9y8PXjDzdi5TVvdKKUNZN1NGsiIHciawWILnm6c0/OgQgXFNqUzDG15uMcGnpk7K
         gK7RGl3GbdsiNkcNL7EwiN8tHC46P56qEzwX+vOE9ErXW8NL9Xuumbz+lIb50v+l8VKp
         0VJA==
X-Gm-Message-State: APjAAAXwOu9mlJpWrvmutL4WHh76sk3/VJjlGj3qp7X/2Nazig9v8hcP
        eDD2xaBlW8AScby9MH9VqIJoHSZgLfGtTxqfd4TBtQ==
X-Google-Smtp-Source: APXvYqwAeHJ6ffh1AHRzRHrxcbevNHLDgTMxIoh/NthJ+CJxSI+KcpqLKKcbl8Q8QNXSiF3gRUDDwGguk49LeNUi8hY=
X-Received: by 2002:a05:6808:24a:: with SMTP id m10mr4705976oie.24.1568739247944;
 Tue, 17 Sep 2019 09:54:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Tue, 17 Sep 2019 09:54:07
 -0700 (PDT)
In-Reply-To: <20190917141014.6A1DA602F3@smtp.codeaurora.org>
References: <1564305118-3059-1-git-send-email-pozega.tomislav@gmail.com> <20190917141014.6A1DA602F3@smtp.codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 17 Sep 2019 18:54:07 +0200
Message-ID: <CAKR_QVKtLM7fWs94y_KqndSXmUNTVHO7xqBK3sr5M44DSO_K0g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: use ath10k_pci_soc_ functions for all warm_reset instances
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/09/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
> Tomislav Po=C5=BEega wrote:
>
>> Use ath10k_pci_soc_read32 / ath10k_pci_soc_write32 functions for
>> the rest of warm_reset functions. Until now these have been used
>> only for ath10k_pci_warm_reset_si0, but since they already exist
>> it makes sense to simplify code a bit.
>> Runtime tested with QCA9862.
>>
>> Signed-off-by: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
is this a typo or should've I add your SoB line to that commit? btw
what about this patch it's been sent out quite a several months ago?
https://patchwork.kernel.org/patch/10860301/
