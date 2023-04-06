Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C746D9B82
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbjDFPBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjDFPBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 11:01:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012A93D3
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 08:01:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lj25so2100693ejb.11
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112; t=1680793295; x=1683385295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37FfXzGDRcsKcLWZUZxZlcs73mWDdx7xIQOHMu60oIY=;
        b=YAgbDWMjG0rBpdJro39qFtzdKa3VQAwCJFBUtyayEvh9VMRy5QAy+6M/LUhCwYzyUR
         k4K9fg4NMRxhWDnzJYBwe+9uvt0QK5b/1IbKh1rrvb8BYy5iYmu8plBkEpcUvcBPHIT+
         aPus1hcGowhLzXyX4yx6yv9m5J7tNl44EKeQmN6EwY8BMtvQUaOx0lluxCK+y/a/kR+c
         x0uDhb1XUYdembj/DuE1jwdHqCmYFGC5pToM6C4FjYBq1aNoSOXpkPFsHj3IVo7WUfDO
         c3atZkKaPngvP+5zZys0OhfDnLwLQ62Z+W+WxZPJUcKeNY450C3+wr/AJc9eh45W7SMa
         /sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793295; x=1683385295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37FfXzGDRcsKcLWZUZxZlcs73mWDdx7xIQOHMu60oIY=;
        b=JaJVyuorTRQ7iqSR8A89LIGmvzQJiQoqVzX3A1xfRfTVP5QQUVFnzodcwJByoXHHSK
         +m/xUUBGWmeT5/MH0X5af0QxMy6cjimiL4mge7n9zu4G5FFpCn9RNYdNdxVJoiIk46xt
         nZtR810/IfO4cvwudoZODGT3+FkGObIRNx+aKI+xpZ8Jw79mTvACCfRSA/BsRO4IebV2
         p+QxgMjqtCP5FzkYn9jyH2bEobpYyvoxgBrXq8wcpWzSNOLvWvQRkFx57q1TpH7JGFXb
         O/Zn3xEImfuKo9KEocEbj77Lsp7oGJFoERvngOGRgsupy/CqeDngY3R1q0BJCX9VyvmR
         T11Q==
X-Gm-Message-State: AAQBX9d7tr39SjRZzeBWAQ8LBMhXj//lD80CQ+H7Wi+8MqgBZIOoeyZb
        akQb66jZfZwamlO0/W5ZPFCA00BMu+EgDg/4Umpz8w==
X-Google-Smtp-Source: AKy350ZMm0NKtJKWxwH9FnEUREL24PHX9DZAZLGKOb2VW5bDs8p/lBuZsN/vVFzL0IV07ZHQY2JpPCwsBscrraUDmT0=
X-Received: by 2002:a17:907:8b8a:b0:932:39bf:d36e with SMTP id
 tb10-20020a1709078b8a00b0093239bfd36emr3513195ejc.11.1680793295693; Thu, 06
 Apr 2023 08:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221207150008.111743-2-yangyingliang@huawei.com> <167172559861.8231.3944096616079868507.kvalo@kernel.org>
In-Reply-To: <167172559861.8231.3944096616079868507.kvalo@kernel.org>
From:   Info Skymem <info@skymem.com>
Date:   Thu, 6 Apr 2023 17:01:19 +0200
Message-ID: <CAKvd=_i73Sz0+MeYL=qchiAtpUN8Zv2WZTBX9iDU0vEE9wKM_g@mail.gmail.com>
Subject: Re: [v2,1/4] wifi: libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kalle Valo, Yang Yingliang, and Libertas-dev team,

Thank you for your hard work on the recent patches. I'd like to
introduce you to our website, https://www.skymem.info, an email
finding tool that can help you expand your network and connect with
potential collaborators. You can use it like Google for emails.

Here are the advantages of using Skymem for your networking needs:
1. Endless search of emails and domains.
2. Creation of an email list using an advanced filter.
3. Price per email over 10 times lower than that of competitors.

We believe Skymem could be a valuable resource for you in building
connections within the wireless and kernel development communities.

Best regards,

Robert
Skymem Team
https://www.skymem.info

On Thu, Dec 22, 2022 at 5:28=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> > It is not allowed to call kfree_skb() from hardware interrupt
> > context or with interrupts being disabled. So replace kfree_skb()
> > with dev_kfree_skb_irq() under spin_lock_irqsave(). Compile
> > tested only.
> >
> > Fixes: fc75122fabb5 ("libertas_tf: use irqsave() in USB's complete call=
back")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>
> 4 patches applied to wireless-next.git, thanks.
>
> 9388ce97b982 wifi: libertas_tf: don't call kfree_skb() under spin_lock_ir=
qsave()
> 3968e81ba644 wifi: libertas: if_usb: don't call kfree_skb() under spin_lo=
ck_irqsave()
> f393df151540 wifi: libertas: main: don't call kfree_skb() under spin_lock=
_irqsave()
> 708a49a64237 wifi: libertas: cmdresp: don't call kfree_skb() under spin_l=
ock_irqsave()
>
> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20221207150008.=
111743-2-yangyingliang@huawei.com/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>
>
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev
