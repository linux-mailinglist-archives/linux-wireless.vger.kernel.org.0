Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2867B5370
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbjJBMth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 08:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbjJBMte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 08:49:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CAFCC2
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 05:49:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40662119cd0so88505e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Oct 2023 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696250965; x=1696855765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDLvwoAl09xn/ODnoM44OyqQjxJOIWQGJH/GqYuQ4IQ=;
        b=32huvWoTtQmkH8X+8aFW4MTBV/FJ2J5hlJWuiJ6pNrp490tONyw2P3a7gWYd1WKxn0
         68Ye3I5hBxWTHMqg3IsAtQawidGh3h59YBaJGesgnaH9uP+L2sq3CSlF3TB4rKgl+k+W
         bD70AfF1JIppBQrWwXHm35IC/FG5cQDQVdiK+gWuLMbcYJ/ncJmJWQa+R8U4+bwIrJjr
         YZCWqceq4umTE/pn7zPcAh/Xy4ir2VeLEJ0pbWFoGeMj/FnR6i/2X5yG0Yr+MsNkSBRf
         d+s3Pn787XeJW5+t/nkYbbLFvNqHuhNjOLGlE4riQ4+lFUA7AUOzdCd7RP6UqzMMLh08
         TpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250965; x=1696855765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDLvwoAl09xn/ODnoM44OyqQjxJOIWQGJH/GqYuQ4IQ=;
        b=Vl60Ts8MJDTtze2C7bSiLlHcfSJD4z32gJa6nVfY/4NwAfpoSvfDwWYyMVbi6m0HCU
         PO0nRpGK45gFmzGMLoTXK373upiC8xIk3kfTHo28QjBmzMfa3yqm1pO9quwRwBllCctn
         7LwN9nsxfbkmYf/L8Gd5916usul8DW7GCIfEwV1GW3ZO24haQ2YTqaafnRn0b5VePBTh
         FnTOATL15/ayHuKAdnnHFmebwsp3RfqQ17oJl8sOsrOz1T3Sw9wx7CC5NKnBsqLEM0dN
         3yBRoHr9J59trHp6euyAXg9BJTyYwl1H9Iln9gYA6QtTWYDnbGYD8Q8in9Hv+C7YMg1/
         HBWg==
X-Gm-Message-State: AOJu0YyEgeMrpvdX162viuGFShgZi1wqxSLEZ9gFxKsX+zJcNcrY+8hv
        DPECCjpbL7zTM2qw068CHQHm8Eud8J5GzZiVAWnNAw==
X-Google-Smtp-Source: AGHT+IFkChCr2dgLSNOTtye7/v4YH4Dpn5ajICXk8XtivhRpaTZ37y6Wo/8M6Uei3pQOh65cVLbvNiLxzGIYrb/VTeA=
X-Received: by 2002:a05:600c:4688:b0:405:35bf:7362 with SMTP id
 p8-20020a05600c468800b0040535bf7362mr113965wmo.0.1696250964910; Mon, 02 Oct
 2023 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com> <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com> <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
 <651abb07.050a0220.5435c.9eae@mx.google.com>
In-Reply-To: <651abb07.050a0220.5435c.9eae@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 2 Oct 2023 14:49:11 +0200
Message-ID: <CANn89iLHMOh9Axt3xquzPjx0Dfn6obmSZJFSpzH51TKAN_nPqQ@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 2, 2023 at 2:43=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> On Mon, Oct 02, 2023 at 02:35:22PM +0200, Eric Dumazet wrote:
> > On Mon, Oct 2, 2023 at 2:29=E2=80=AFPM Christian Marangi <ansuelsmth@gm=
ail.com> wrote:
> >
> > > Ehhh the idea here was to reduce code duplication since the very same
> > > test will be done in stmmac. So I guess this code cleanup is a NACK a=
nd
> > > I have to duplicate the test in the stmmac driver.
> >
> > I simply wanted to add a comment in front of this function/helper,
> > advising not using it unless absolutely needed.
> >
> > Thus my question "In which context is it safe to call this helper ?"
> >
> > As long as it was private with a driver, I did not mind.
> >
> > But if made public in include/linux/netdevice.h, I would rather not
> > have to explain
> > to future users why it can be problematic.
>
> Oh ok!
>
> We have plenty of case similar to this. (example some clock API very
> internal that should not be used normally or regmap related)
>
> I will include some comments warning that this should not be used in
> normal circumstances and other warnings. If you have suggestion on what
> to add feel free to write them.
>
> Any clue on how to proceed with the sge driver?
>

I would remove use of this helper for something with no race ?

Feel free to submit this :

(Alternative would be to change napi_schedule() to return a boolean)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c
b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 2e9a74fe0970df333226b80af8716f30865c01b7..09d0e6aa4db982e3488e0c28bed=
33e83453801d0
100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct
*napi, int budget)
        return work_done;
 }

-/*
- * Returns true if the device is already scheduled for polling.
- */
-static inline int napi_is_scheduled(struct napi_struct *napi)
-{
-       return test_bit(NAPI_STATE_SCHED, &napi->state);
-}
-
 /**
  *     process_pure_responses - process pure responses from a response que=
ue
  *     @adap: the adapter
@@ -2674,9 +2666,9 @@ static int rspq_check_napi(struct sge_qset *qs)
 {
        struct sge_rspq *q =3D &qs->rspq;

-       if (!napi_is_scheduled(&qs->napi) &&
-           is_new_response(&q->desc[q->cidx], q)) {
-               napi_schedule(&qs->napi);
+       if (is_new_response(&q->desc[q->cidx], q) &&
+           napi_schedule_prep(&qs->napi)) {
+               __napi_schedule(&qs->napi);
                return 1;
        }
        return 0;
