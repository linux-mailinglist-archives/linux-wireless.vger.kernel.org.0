Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D0E66CF54
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 20:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjAPTHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 14:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjAPTHL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 14:07:11 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5BA2798D
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 11:07:11 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1442977d77dso29768983fac.6
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esDaIOInnqed0ckJymkIEEwtPruzGqE9cGn3mSJwAug=;
        b=pn17XO5D6BhiHbNY5w+YI0vS7ZNCWY9WshvcQTW/eJGuKystGES3pJh76LhgTYUCeh
         2pPt4kG3vmYvPrAWOB8wiNnjVPsCOTd9VQRL5w7x+8dD9OvgjOBaCi/vO3WyncIKXIkv
         Jv7TiFJLsEGxGY851k9n2Q2Q299Ud8m2gu27vhGMdWIjYO1axC9fIGDmovEuL8/+p6H2
         OEMc/KGb//NGgttxuZ6V4pVV+ZoCYrG7zKNa4CQdBr7umsBtAQkBl1tnmfciNbCQs6lH
         GsSUGR0mxx+VmSemdzVd75WTAIzFDy2oB7ByFs+Ddl5KeOUK7qcpBmUIMPExx0DcdnXz
         S4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esDaIOInnqed0ckJymkIEEwtPruzGqE9cGn3mSJwAug=;
        b=MGKM+WqXfMz5OgkxIgiH4orAL13t5ZYT0vL3i4qY3f12vx1IRk3BwyeGSEzfxmALGT
         e4Fmg3W5gfkcrzTBRVg3ww/n4JH17a6DyeLQSPToraZ8fLr/3+glkNPlT9QBgNhemxbN
         Zl5G6PBSiMGxZHbPeswI7vpFsZmRszRM8NOPNlRsTtqdxHQ+bV3oBn+pYXX5IJTHiM7Z
         AZ56+JGQcriDQPmnduYF1jYZTNW1zSmM48VRlyjnoscIKupHWpPNzDEV24ow8suAWPnd
         m1/TEP6ZyoVdHhfloq7ySyQ20wIsB92DUzrb5PU9ca9FLh0CSi3VHvK6iwzt6Mz4odqo
         CSLA==
X-Gm-Message-State: AFqh2kriKbaUwWnEigQ6LY+bdFWld4k6irT5V+FdY/qbGNS+7Vi6R0m4
        5JYxPMZm9RiKmvBdd1iDurk=
X-Google-Smtp-Source: AMrXdXuoWyUGY7TVBZUTG5x7GWGZOnSvMjWXtvWBif6P3+BMX/Hpb373ZbN0UBIiBrhQV3cmfffa4w==
X-Received: by 2002:a05:6870:6988:b0:15f:5509:99f9 with SMTP id my8-20020a056870698800b0015f550999f9mr477414oab.39.1673896029649;
        Mon, 16 Jan 2023 11:07:09 -0800 (PST)
Received: from [192.168.0.108] ([177.157.99.13])
        by smtp.gmail.com with ESMTPSA id t18-20020a056870e75200b0014866eb34cesm173894oak.48.2023.01.16.11.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 11:07:09 -0800 (PST)
Message-ID: <69be55b0-2c9d-4bdb-28ab-650516546a58@gmail.com>
Date:   Mon, 16 Jan 2023 16:06:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Google Summer of Code 2023 - Project ideas page for the Linux
 Foundation online
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Jeff Licquia <jeff@licquia.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Open Printing <printing-architecture@lists.linux-foundation.org>,
        dl9pf@gmx.de, Mats Wichmann <mats@wichmann.us>,
        =?UTF-8?Q?Jan-Simon_M=c3=b6ller?= <jsmoeller@linuxfoundation.org>,
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
        Gary O'Neall <garysourceauditor@gmail.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Rithvik Patibandla <rithvikp98@gmail.com>,
        Dheeraj Yadav <dhirajyadav135@gmail.com>,
        Deepak Patankar <patankardeepak04@gmail.com>,
        Bhavna Kosta <bhavnakosta2020@gmail.com>,
        Aveek Basu <basu.aveek@gmail.com>
References: <7ed5b062-73bc-0002-14c8-bda32c5f7866@gmail.com>
 <CAP-5=fVDc8FBzDJiNHXsuynr0f-5bQcHD0qJHcrbpKkx7Y5arw@mail.gmail.com>
From:   Till Kamppeter <till.kamppeter@gmail.com>
In-Reply-To: <CAP-5=fVDc8FBzDJiNHXsuynr0f-5bQcHD0qJHcrbpKkx7Y5arw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/01/2023 14:28, Ian Rogers wrote:
> Hi Till,
> 
> This is great news! Could you clarify the "newcomers in free software"
> a bit. Is it the same as last year? Last year we had somebody working
> in a closed source environment who applied because they had only a few
> years experience and had never sent patches to LKML. We also had
> somebody working for a tech giant but in a managerial role, who wanted
> to work on some open source software. Beside the challenge of trying
> to fit open source work in with a day job, we decided that the
> candidates didn't fit the idea of newcomer and so weren't eligible for
> the GSoC funding. We offered to help them outside of GSoC but none
> accepted that.
> 
> Thanks,
> Ian

"Newcomer" means newcomer in free software coding not newcomer in IT in 
general, so people who have only worked in closed-source before or 
people who were only managing in open-source but not coding are 
eligible. I assume, but do not know, that Googlers will google for free 
software coding activity (e. g. commits in project repositories) to 
determine whether a contributor is eligible.

There is also a rule that one contributor can be GSoC contributor a 
maximum of 2 times, but I do not know whether this is also valid for 
newcomers, as with the first participation you got already free software 
experience and a certain commit history. Perhaps a 1-year experience is 
still tolerated.

So your last year's candidates should be eligible.

    Till
