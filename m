Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFAF64AEA0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 05:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiLMEVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 23:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLMEVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 23:21:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86B41E70C
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 20:21:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q7so14372990wrr.8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 20:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVFU4dsgg1U4BeR24tu6IcwUR3eI4MB9800Mu2dnfxA=;
        b=VXmOUG/R2yzEa8slA6AGWG1Hm5Z6jnIszsJRYD3wLZQSAZ4RR+A9UT8CjKzR+AK3WU
         slL8OUz7Ij/IHkkZHKzXoLKp2fkxqObakR5ikf2l0JMQLhVy7Yd6uFu68byyms3h230y
         obWzhuTHbpuoJWFvbrZrX156t1FlAbpbt88nESx0uGHswOCeyJquA3fxL8gAzBMkowGV
         GHEJmzlUmLS0Nc0vj/KywM5aPegq5/i0UoibkHgPVHCfvl3inNyA7ah9Pqr0xI4Lcp/m
         /eIwcBFWcer9EFdPqL/Gmia0h+QvntMRCoYszFRbBhvLW1Gktl8pjkECoHxASVAKkIdo
         0Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVFU4dsgg1U4BeR24tu6IcwUR3eI4MB9800Mu2dnfxA=;
        b=7u3+xMTe/WMkqaLZO7yIcA51GZFUw41Z/RvHG1xRRY3r5D4YOa0uhN6QM0t65+m/xs
         NAmCBX6CxYBoGOKN8Xvp+1iUrgud9Sp5nutcu6s8gCpoHU/fxdcS1GVA/krgez89lVnR
         TMAHTXf6NoMdGj1d5s2Pvt3/B1Q0tERFyCQ9g/2GCfSKbA/zspg7iGAAOfYkkGxyM/dU
         7g4RQa8HpxmsgYkSnYvDjbRrk3fPEmFXvC7gABEs6WRvkuQWx9hSqLHq4PLWEz3pZpN/
         hFxL0gD0ni1kffu4xsb9gR+hcFAUeG4YyinF/QaUr8GdPf63lH4rOpVyvjmrTug/QZI5
         aeyw==
X-Gm-Message-State: ANoB5pkwWhHjJf/FrMWpgHqwmkd9CfKqpdYrlI4J2TfrKSytSeXyZ08H
        Cz1s+bSTzji2KJu4OXEZM30=
X-Google-Smtp-Source: AA0mqf6kLo2zpXiqzIdoIjR3wgfKswrbQ/+UuirltrKsSfAPgs6f1uUxKyIonGtZPgD8SM7kveGKfw==
X-Received: by 2002:a5d:570b:0:b0:242:5d8e:6c35 with SMTP id a11-20020a5d570b000000b002425d8e6c35mr11289831wrv.28.1670905269143;
        Mon, 12 Dec 2022 20:21:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d5112000000b0024207478de3sm10290747wrt.93.2022.12.12.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 20:21:08 -0800 (PST)
Date:   Tue, 13 Dec 2022 07:21:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] rtw89: add Realtek 802.11ax driver
Message-ID: <Y5f9sUhoY/vqy0cQ@kadam>
References: <Y5dJymTl15fBnQtV@kili>
 <e87d10cd962d4d118b86a280f986f6ef@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87d10cd962d4d118b86a280f986f6ef@realtek.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 13, 2022 at 12:46:22AM +0000, Ping-Ke Shih wrote:
> 
> 
> > -----Original Message-----
> > From: Dan Carpenter <error27@gmail.com>
> > Sent: Monday, December 12, 2022 11:34 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: linux-wireless@vger.kernel.org
> > Subject: [bug report] rtw89: add Realtek 802.11ax driver
> > 
> > Hello Ping-Ke Shih,
> > 
> > The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
> > 11, 2021, leads to the following potential issue (just from reading
> > the code):
> > 
> > drivers/net/wireless/realtek/rtw89/core.h
> >     3878 static inline u32
> >     3879 rtw89_read32_mask(struct rtw89_dev *rtwdev, u32 addr, u32 mask)
> >     3880 {
> >     3881         u32 shift = __ffs(mask);
> >     3882         u32 orig;
> >     3883         u32 ret;
> >     3884
> >     3885         orig = rtw89_read32(rtwdev, addr);
> > --> 3886         ret = (orig & mask) >> shift;
> > 
> > I think this line should be:
> > 
> > 	ret = (orig & mask) >> (shift - 1);
> > 
> > A typical mask here is 0xff so __ffs() is 1 because the first bit is
> > set.  This code will do: ret = (orig & 0xff) >> 1;  I think it should be
> > ret = (orig & 0xff) >> 0;
> > 
> > If the mask was 0xff00 I would expect >> 8 instead of >> 9 etc.
> 
> ffs(0xff)=1 and __ffs(0xff)=0, so I think original is correct.

Oh, wow.  You're right.  I hadn't realized it worked like that.

Sorry!

regards,
dan carpenter

