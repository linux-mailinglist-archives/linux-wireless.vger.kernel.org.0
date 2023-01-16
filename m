Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9226E66CDEB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjAPRs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 12:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAPRsb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 12:48:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181659E5D
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 09:29:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so3386490wms.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vFEdG4hZRNnb4TDMsbhgN6UgmDGqBzjCbhxPvvZjagc=;
        b=fR1yCdSTFzAVNSvEwijNOpExgw2C6ts7X2dHno0/whtdFAYgF2KLMUuKMKDH9eLCpH
         ysXOsgj6iPfKgwKUXP0jGUM390IkgPIC39CN84ZTxXwg2jtZewvVMkEK3CVkmnVG1quY
         CV2N3DAw+AxfhkDQ7utCjEzRVUnoALb9/TIuQgCj1LbJENmhsLM2+2Tg/1w/9aEK8Eed
         vw6LosyXQ9cRfybhWkWsynL56+zFs60kQzU8DUnuWBvYMocMR79x3+BuGaonvV/Ka0XY
         IAUbn3B1qBVSMxOS9EUC4xg6QEfhjyrFQVwIN+MYwuopTjoJOg5Fq2orHgApi/geKG8D
         sCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFEdG4hZRNnb4TDMsbhgN6UgmDGqBzjCbhxPvvZjagc=;
        b=oQA96KDiMdYImyJMBRLZ6iJzw+lse584gZeXK/N9rPZtzdCMXXuwcR8aIeKFMgmKSj
         ggZ+6aYIUTZwUBVORk+8fdLnMzPazMbp8YQP27h36U8KXB0JlJld5s6ghl9bI3qIu8ZL
         jF8sm4+jy1dmUZVRMImTdmh4+v+auJeTKWIFprA+bpiiWLM4ydSvmwF+EmrkPlzkA3gt
         mtj29Qi+eUItNgegOLDo5zxaZWA6Q5740bvZiTDuW4tEZIorB2XgPSJMrvbOlWJiL6Hz
         cpOzwzXfGvtkc/bPdNjWFzBa22gU6nmJzI8dYfNmy+5uGu9Fvy8c9omxfYYuEmDSZFbu
         rMfg==
X-Gm-Message-State: AFqh2kruLBfBez9hMJwq9ntWb7RRHEFobZJb4dvCegEhFNI0IA52m4wq
        EcZBzR8eSPvyIOfgVwEGyZDFrr82rqeM5NuyPp2O5A==
X-Google-Smtp-Source: AMrXdXu2eZNn+WLsKqXMvG2Dli8c0xp5U4oEuJi4CEGxYcAcyhvQuqayNCpXxsOFTfnPECuEOHclUETlyuc25AHSLQ4=
X-Received: by 2002:a1c:7404:0:b0:3da:b40f:c734 with SMTP id
 p4-20020a1c7404000000b003dab40fc734mr21729wmc.115.1673890147872; Mon, 16 Jan
 2023 09:29:07 -0800 (PST)
MIME-Version: 1.0
References: <7ed5b062-73bc-0002-14c8-bda32c5f7866@gmail.com>
In-Reply-To: <7ed5b062-73bc-0002-14c8-bda32c5f7866@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 Jan 2023 09:28:55 -0800
Message-ID: <CAP-5=fVDc8FBzDJiNHXsuynr0f-5bQcHD0qJHcrbpKkx7Y5arw@mail.gmail.com>
Subject: Re: Google Summer of Code 2023 - Project ideas page for the Linux
 Foundation online
To:     Till Kamppeter <till.kamppeter@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Jeff Licquia <jeff@licquia.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Open Printing <printing-architecture@lists.linux-foundation.org>,
        dl9pf@gmx.de, Mats Wichmann <mats@wichmann.us>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <jsmoeller@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Vadim Mutilin <mutilin@ispras.ru>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ira McDonald <blueroofmusic@gmail.com>,
        Michael Sweet <msweet@msweet.org>,
        Tobias Hoffmann <smilingthax@googlemail.com>,
        Jay Berkenbilt <ejb@ql.org>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Matt Germonprez <germonprez@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Gary O'Neall" <garysourceauditor@gmail.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Rithvik Patibandla <rithvikp98@gmail.com>,
        Dheeraj Yadav <dhirajyadav135@gmail.com>,
        Deepak Patankar <patankardeepak04@gmail.com>,
        Bhavna Kosta <bhavnakosta2020@gmail.com>,
        Aveek Basu <basu.aveek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 16, 2023 at 6:17 AM Till Kamppeter <till.kamppeter@gmail.com> wrote:
>
> Hi,
>
> the Linux Foundation will apply again as mentoring organization in this
> year's Google Summer of Code.
>
> Note that GSoC 2023 will have a slight difference against last year. Now
> contributors are eligible either when they are newcomers in free
> software OR they are students. This gives more people the chance to do a
> Google Summer of Code project.

Hi Till,

This is great news! Could you clarify the "newcomers in free software"
a bit. Is it the same as last year? Last year we had somebody working
in a closed source environment who applied because they had only a few
years experience and had never sent patches to LKML. We also had
somebody working for a tech giant but in a managerial role, who wanted
to work on some open source software. Beside the challenge of trying
to fit open source work in with a day job, we decided that the
candidates didn't fit the idea of newcomer and so weren't eligible for
the GSoC funding. We offered to help them outside of GSoC but none
accepted that.

Thanks,
Ian

> All the rest is as last year, especially choice between 2 project sizes
> and flexibility with the end of the coding period.
>
> On January, 2023 the application period for mentoring organizations for
> the Google Summer of Code 2023 will start.
>
> To be successful, we need a rich project idea list so that we will get
> selected by Google.
>
> I have set up a page for project ideas for the Linux Foundation's
> participation in the Google Summer of Code 2023:
>
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2023
>
> Please add your ideas to the sub-page of your work group. Also remove
> project ideas which are already done in one of the previous years or not
> needed any more and make sure that all contact info is up-to-date and
> all links are working.
>
> Make sure to not talk about "students", but about "contributors"
> instead. I have, at least partially, taken care of this when I have
> copied your sub-group pages from last year.
>
> Also make sure to remove the "**To be updated**" phrase after having
> updated your project ideas.
>
> If you have problems mail me with your project ideas and other editing
> wishes.
>
> The ideas list is in the Linux Foundation Wiki. If you want to edit and
> did not have the edit rights already from previous years, please tell me
> and I give you edit rights. I need your Linux Foundation user name for
> that and the e-mail address associated with this account for this.
>
> Please also take into account that the deadline for our application as
> mentoring organization is Feb 7 and after that Google will evaluate the
> applications. So have your ideas (at least most of them, ideas can be
> posted up to the contributor application deadline) in by then to raise
> our chances to get accepted.
>
> Please also tell us if you do not want to participate any more with your
> workgroup, so that we can remove your sub-page.
>
>     Till
