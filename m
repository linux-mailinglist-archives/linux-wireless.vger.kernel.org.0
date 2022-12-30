Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690A56593F3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Dec 2022 02:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiL3BCf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Dec 2022 20:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiL3BCe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Dec 2022 20:02:34 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E86376
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 17:02:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so48491655ejb.6
        for <linux-wireless@vger.kernel.org>; Thu, 29 Dec 2022 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tycLNGe2zV3GnXgelO8GUNgiAF+Co3Lc7eFI7APeWH8=;
        b=KWqt4BUKA/3p/uKzZw4e1Eh/x2eemw9jbrY7G8vBhIr3h16MMCHpqh29vJQ0dv3WKG
         /jisC1SJ6Ozh5eiZklfwAZZ+EXU6rQ/mFphZMgwQ0gHUap7mi1Pl3+O1XGL8D1XemzVw
         gA/sVAggf1GEzgB8VxGGT7NSTuN/ccQ/JXnsTFjWjdJNn7TBp/nChrhHJW3U38CeQaHG
         qE/idylrjO2Ja9k/DVrhwL+X/c6n1ShqjEh4R4SAedqeoWp9WgEJJDwpgv4FTq36pM0i
         22LOtZTeNG1uiRNsMeKKK+In/jLY2RjGHfIbed9P9G8IQIOaZMUIpg4AfvEec4YU44IS
         iu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tycLNGe2zV3GnXgelO8GUNgiAF+Co3Lc7eFI7APeWH8=;
        b=X6jiXlajiaUF3nPaMdwtPr33iyyfZQG6G43bxtEramRRY6s1+k0HuqD5qovzFRZg/j
         4/BU8kKmcmwr+ECPFFuR10MkKqzk/GFp7gzrQnPQJeCpz4ORAtqNo+HbnFtbBD9kmp+F
         OVXpRkEoUras/mLZSoemMR0uF5OQMkC6CB0GIBdTqWCibEihrFfv/rYD574WW6zCno9w
         Pmb1X5ajk85zPj+FseTSQkil2jmZD5Ohs5+yFijK7ky9eku0ad4t4dDxCYdXaD+oBoDj
         PZdPSMTEh+0OVguzhJn8K4trPyyrMoOrVFNm82cRoGwQrpurWyhRFN6c5whiV5PbJ+DV
         S86g==
X-Gm-Message-State: AFqh2kpY0PaoFfLPWB0UGLWThV01h+A2hokrQiwZMPM608/XjVM4ETRC
        B0cVRKA1dDHfb7SlZk4kFx2EurFFC/xcF+L+Ridw/A==
X-Google-Smtp-Source: AMrXdXsxbFfy6emzOy4rCk6sMZPvjUzJF5QKzuwD7rQ/YSoPshmepyvuTDh9wMDtTu6OUcTZH4pGGJc1rii5yqt4dPw=
X-Received: by 2002:a17:906:2c45:b0:741:5c0e:1058 with SMTP id
 f5-20020a1709062c4500b007415c0e1058mr1744939ejh.472.1672362151160; Thu, 29
 Dec 2022 17:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20221208121448.2845986-1-shaozhengchao@huawei.com> <167102054878.7997.15438501425115316737.kvalo@kernel.org>
In-Reply-To: <167102054878.7997.15438501425115316737.kvalo@kernel.org>
From:   Info Skymem <info@skymem.com>
Date:   Fri, 30 Dec 2022 02:02:20 +0100
Message-ID: <CAKvd=_gj0H0TQTmshenaebufeCTJfBmA9h75OoPKkJ1wXC5=KA@mail.gmail.com>
Subject: Re: wifi: libertas: fix memory leak in lbs_init_adapter()
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, johannes.berg@intel.com,
        dcbw@redhat.com, linville@tuxdriver.com,
        hs4233@mail.mn-solutions.de, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
thank you for your information.

On our website you can find email addresses of companies and people.
https://www.skymem.info

In short, it=E2=80=99s like Google for emails.

Best regards,
Robert,
Skymem team

On Wed, Dec 14, 2022 at 1:23 PM Kalle Valo <kvalo@kernel.org> wrote:
>
> Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>
> > When kfifo_alloc() failed in lbs_init_adapter(), cmd buffer is not
> > released. Add free memory to processing error path.
> >
> > Fixes: 7919b89c8276 ("libertas: convert libertas driver to use an event=
/cmdresp queue")
> > Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
> Patch applied to wireless-next.git, thanks.
>
> 16a03958618f wifi: libertas: fix memory leak in lbs_init_adapter()
>
> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20221208121448.=
2845986-1-shaozhengchao@huawei.com/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>
>
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev
