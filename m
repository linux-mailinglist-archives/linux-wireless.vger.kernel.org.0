Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E425A6D951A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDFLbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDFLbK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 07:31:10 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E7A2
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 04:31:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54c0dd7e2f3so27213837b3.8
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680780669; x=1683372669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLzykTqVWm3t/NDeaXdniWtVLPRXwLG7qAY5Ysw+X84=;
        b=Y5omSK9/mcLP6rF/H56vc1v3JxCze5CA1xgSdkKNYx8TrENP7H8M0faukE0CZsL6ya
         JNZ9mIvA/c9PA/EE4c0hxLhh5sjPnGC9ytx72UxoprYMQlaHOsZN46BJ7We40yu+HbWy
         kimBlSezI8bxH3QBHL5gs0UTRQeA7QefbxtcXpecIA/yyK4yX39NYA+yliuHpZBZdGDh
         RmNsTHVJqhxfhQAVs5Jx7xhOJFGF1A7xYeC8dc/c0deZF28FWQ7EMv4rEfLAJj0Ok33b
         0Vx4fjqE7in8s/cine+X7K4eR3NDF+lwjJCj/TflEb8of7FNZtsq0bpG6mU+rtAXdMwv
         R2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680780669; x=1683372669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLzykTqVWm3t/NDeaXdniWtVLPRXwLG7qAY5Ysw+X84=;
        b=XEzPBd12tj7pVIn4K134PQItkKsnDjeqS7BCnozvz38saRexNN9WKyg7rvk0HoBfe6
         frUfvEJtk0JeyofHi4xYvR8TIyjsqSM4m+HuuETmyiR9amwJznavYuqyDvovk+WxtCMg
         WKipD04XPAABX4pCUn1KUJoOCJ1HougIb880HPXGdjNmWzVrubk/+E8DfgUi3hULcRZM
         A0TTzgbJHQ4OsWlltZb05Yg1wO4l2h8/hzGNHdePYLA+oxpq6a1LklYWlXR0DkUbcMhW
         SqXA0NdbMkdaRxquXGKDVdrn0dF7ybU+msJdvP/oM5XOWpNF46OeiPEDuniPpfvtgMki
         VGUA==
X-Gm-Message-State: AAQBX9e4jSK1llDLPR4smPkPEKxJRbox2zen9k/JwX1/+WdAMpSsZDc8
        swxztW3EImlikXs5OI5r5JiqDipwqJAgMjL1lNB56lav
X-Google-Smtp-Source: AKy350b3MPlmGiczMi5HswyhYFnKFNXoSXqewOV9CqZXexTaxWolbFtzZ06CpOt4w0zhRfZi8uL0a/xM8tn+4qTST4o=
X-Received: by 2002:a81:af14:0:b0:545:621b:5076 with SMTP id
 n20-20020a81af14000000b00545621b5076mr5559084ywh.2.1680780668879; Thu, 06 Apr
 2023 04:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <72e35b08661be39a97b12896c26496874418950d.camel@realtek.com>
In-Reply-To: <72e35b08661be39a97b12896c26496874418950d.camel@realtek.com>
From:   Josh Boyer <jwboyer@gmail.com>
Date:   Thu, 6 Apr 2023 07:30:58 -0400
Message-ID: <CA+5PVA4SOinJXJRrgXszbOqd5yjhgKqqt0AENyXy0Uae2hm35w@mail.gmail.com>
Subject: Re: pull request: rtw89: update firmware of 8852b and 8852c
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Timlee <timlee@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 6, 2023 at 3:42=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Hi,
>
> Update two firmware of rtw89 driver -- 8852b v0.29.29.1 and 8852c v0.27.5=
6.13.
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit 2e92a49f90f73c8edc44b25c6e669d5e70893c=
90:
>
>   nvidia: update Tu10x and Tu11x signed firmware to support newer Turing =
HW (2023-04-04 08:03:53
> -0400)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git HEAD

Pulled and pushed out.

josh

>
> for you to fetch changes up to 9f7502f1dbb16aea2122004dd607e03ca6a62c0b:
>
>   rtw89: 8852b: update format-1 fw to v0.29.29.1 (2023-04-06 15:32:12 +08=
00)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8852c: update fw to v0.27.56.13
>
> Ping-Ke Shih (1):
>       rtw89: 8852b: update format-1 fw to v0.29.29.1
>
>  rtw89/rtw8852b_fw-1.bin | Bin 1188488 -> 1184992 bytes
>  rtw89/rtw8852c_fw.bin   | Bin 1532656 -> 1532736 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)
>
