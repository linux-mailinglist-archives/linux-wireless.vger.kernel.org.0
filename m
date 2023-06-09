Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6165872A176
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFIRmR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjFIRmP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 13:42:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BDF35B5
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 10:42:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-777a6ebb542so85071539f.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jun 2023 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686332522; x=1688924522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WH76zqrenLLRU4W8LhvZYi9PSsVioQ+x5GUbNwlick=;
        b=RmtFayTsh4XJVrVmpZNZe8tEtm1JuOMEEJvvpOrv76BOZv6b5Uoe1z8hxb1Ajy5tVc
         993QugpmD2JIQMp8ysP4C3qIFz1QULTkhaj4u7oA0xtML4/8chtGYFTyBJilzHG5nMvE
         8/RflVemJii5ujd3iu9pvJ+vL6XKdV1Un72KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332522; x=1688924522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WH76zqrenLLRU4W8LhvZYi9PSsVioQ+x5GUbNwlick=;
        b=NqSBltNtF6hfOB12XiGBUEQYHJxYZMrhFuCSoVPPevCWthy9Zu0hyJLCigLeU5fW6Q
         ZuSH8TloSL5YK2oqyCoqj0jqFv02dT5QbzMSnST7Y5+KLm18Wzw0H//aMJi+TncNAzvY
         eCpuotKSWzRuoksFbiLUTeZUqtKxg3o/je81rx+we2FyqDL35LgmZF5Eqi9Qj2McLxlK
         IPxQCm0EWEtF+0EPe6TKOj7nDwP1x35urF94JW896jLSPh+wNvKuSL2ZQrmlWt3i/rO4
         1e0+/kDP4xp0RBteg32g8hcXgDImeU2sUPpmdvmlP6qK54KXqFj4ezoxOSZNU2s4RzF5
         Bb/w==
X-Gm-Message-State: AC+VfDzzId9bIv4WslenRLDKkeUJDzL+UwlgJqEzyHf3UtGBp+UAdSRH
        rWbTNYGuNfMy7z6dGH+Ug0R+T5/7dTOwAlhr2I2b/w==
X-Google-Smtp-Source: ACHHUZ5tcn0SDgMLFFvev/k4QmQfCwN6bBEVv5LtQYgZyeTQYk91kQAFXrT/mFmQSRXpntXkkUOakQeTVn4JM/1Ae/g=
X-Received: by 2002:a92:d690:0:b0:33b:c914:a771 with SMTP id
 p16-20020a92d690000000b0033bc914a771mr1926446iln.6.1686332522428; Fri, 09 Jun
 2023 10:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230609103651.313194-1-treapking@chromium.org> <87o7lohq9e.fsf@kernel.org>
In-Reply-To: <87o7lohq9e.fsf@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Sat, 10 Jun 2023 01:41:51 +0800
Message-ID: <CAEXTbpdDsoghsxbJqszx0OWWw1o9D8p9f_9-4OgOM-a-w7OzSA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Replace RX workqueues with kthreads
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Fri, Jun 9, 2023 at 6:41=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Pin-yen Lin <treapking@chromium.org> writes:
>
> > This improves the RX throughput likely by better locality for the work
> > loads.
> >
> > We tested this patch on Mediatek MT8173 Chromebooks, and it shows ~80%
> > Rx throughput improvement on high data rate test cases.
>
> 80%? That's huge from so small patch like this! What are the before and
> after numbers?

I realized that I might have over-simplified the background and the
impact of this patch...

The short answer to the question is that the throughput improved from
100 mbps to 180 mbps. The test was run on ChromeOS's v5.15 kernel
fork. More detailed test setting is mentioned in [1].

However, the throughput of the same test case on our v4.19 kernel is
320 mbps. That is, we observed a 320 mbps --> 100 mbps regression when
we tried to update the kernel version. This patch is more like a
mitigation of the regression. It improves the throughput, even though
it is still not as good as the older kernel.

That being said, this patch does improve the throughput, so we think
this patch can be landed into the mainline kernel.

Best regards,
Pin-yen

[1]: https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
