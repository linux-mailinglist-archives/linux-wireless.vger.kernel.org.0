Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E5966C265
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjAPOkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 09:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjAPOkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 09:40:06 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF8315D5
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 06:17:59 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12c8312131fso28999751fac.4
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 06:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lyd/C6UjbX1f7V96wGBoVFdjPohStWpEDmzAPokN/3A=;
        b=ELwzOb2PIix4kcDRVVGx21xPVhWDICdhW/XmzzDBehQVsxqDZUvlmHPUWmgSKGrgwN
         OrCFyQdT6dmADFfIkgJ+1ql0qBcplsH9ZeS6f//v98+q4UJF9GdVLasCUArZr0xw8ay5
         hjA0vYB+uIyBSz5tJzxPka1ELsDxtNJaGLRaLT8UQbb1HeXE0mNBt2tZorwRuGZBLEE2
         PRp7hpZ7VK5rjzRD0Qx0OiUkXm4itZWwkVeHlgO0GcOA9jR2LH6Oylj4E2XGhp98vZ/I
         mxs6XXst2xBhwJ6aapxq2yR4aTsxxEhk9iNBLRWBxk02hPtHNZzWofdc5OJ7vYebynhy
         IyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lyd/C6UjbX1f7V96wGBoVFdjPohStWpEDmzAPokN/3A=;
        b=zH71nvoQhuBcBtLtsQTHlgnLB1LNYvteubcy6eAeecESY+QpbRPGP1v61eVjHxOL6X
         3g6uT60Acb/0k2DQBtReTp8TIcVAWkb3ZnG8mhp3eimns94j/TrqGWxGDAbLOAfq3N32
         vb1Ucefp4imYDcbCLQgrB0vWENWQyOE8zVTYkO/VnJLjayGH9WLeRCwIURqCvMEhIVay
         sBnAOojtusHbTGZgxHPuKP1y3ChXnRTubk9S/ZLMgfqerExfpKOLSrJ2RRiKxnRHvTPL
         4LqkRkugH3uCPvibh/A0FZ99L3kJhROqjE23beH1DHjZeMoP1lZc++YFYOp0drxIi462
         ZqXQ==
X-Gm-Message-State: AFqh2krvdV31AcaJCNOuh06y6rzbiV+kciMO09wyclegWn9qC03MwHV/
        SY13qROfuDaLKQ86qfwbDZU=
X-Google-Smtp-Source: AMrXdXsH2lupGuVb4oMZF7sV64TpLwsS76n8QdsJNCO7N7jH6JhGgSWIPsmyZ/dlRysXbIT49WXCWA==
X-Received: by 2002:a05:6870:2f08:b0:150:ce03:d0fe with SMTP id qj8-20020a0568702f0800b00150ce03d0femr22439247oab.13.1673878662588;
        Mon, 16 Jan 2023 06:17:42 -0800 (PST)
Received: from [192.168.0.108] ([177.157.99.13])
        by smtp.gmail.com with ESMTPSA id s18-20020a056870611200b0014c7958c55bsm14652655oae.42.2023.01.16.06.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 06:17:41 -0800 (PST)
Message-ID: <7ed5b062-73bc-0002-14c8-bda32c5f7866@gmail.com>
Date:   Mon, 16 Jan 2023 11:17:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2023 - Project ideas page for the Linux
 Foundation online
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
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
        Nicholas Mc Guire <der.herr@hofr.at>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Rithvik Patibandla <rithvikp98@gmail.com>,
        Dheeraj Yadav <dhirajyadav135@gmail.com>,
        Deepak Patankar <patankardeepak04@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Bhavna Kosta <bhavnakosta2020@gmail.com>
Cc:     Aveek Basu <basu.aveek@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

the Linux Foundation will apply again as mentoring organization in this 
year's Google Summer of Code.

Note that GSoC 2023 will have a slight difference against last year. Now 
contributors are eligible either when they are newcomers in free 
software OR they are students. This gives more people the chance to do a 
Google Summer of Code project.

All the rest is as last year, especially choice between 2 project sizes 
and flexibility with the end of the coding period.

On January, 2023 the application period for mentoring organizations for 
the Google Summer of Code 2023 will start.

To be successful, we need a rich project idea list so that we will get 
selected by Google.

I have set up a page for project ideas for the Linux Foundation's 
participation in the Google Summer of Code 2023:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2023

Please add your ideas to the sub-page of your work group. Also remove 
project ideas which are already done in one of the previous years or not 
needed any more and make sure that all contact info is up-to-date and 
all links are working.

Make sure to not talk about "students", but about "contributors" 
instead. I have, at least partially, taken care of this when I have 
copied your sub-group pages from last year.

Also make sure to remove the "**To be updated**" phrase after having 
updated your project ideas.

If you have problems mail me with your project ideas and other editing 
wishes.

The ideas list is in the Linux Foundation Wiki. If you want to edit and 
did not have the edit rights already from previous years, please tell me 
and I give you edit rights. I need your Linux Foundation user name for 
that and the e-mail address associated with this account for this.

Please also take into account that the deadline for our application as 
mentoring organization is Feb 7 and after that Google will evaluate the 
applications. So have your ideas (at least most of them, ideas can be 
posted up to the contributor application deadline) in by then to raise 
our chances to get accepted.

Please also tell us if you do not want to participate any more with your 
workgroup, so that we can remove your sub-page.

    Till
