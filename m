Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1549D245
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 20:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiAZTIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 14:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiAZTIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 14:08:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B9C06161C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jan 2022 11:08:16 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so221847otv.13
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jan 2022 11:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=eifJcP1vUklgqMJfWvWhbBdkSpkR36FFTgBnF5hnnB8=;
        b=hXLFtO0VoZFTLQgyH2J1H/xuqC8zEtAomTkYNWUk3LHmO6VqdVwfc/Maz1v6vuJxvi
         ieg/TWunkq01TuCAhz1294e/HOWm2LxtDgpsNv5xcK4Q4EJsE1dNSGRZNh4+JvQPE3MR
         ONDAkdOcC4DJH6GGix8pzsiQqoSg64BgkWzJTz1A2/5if9z5rgjI31ylwHLDkBhMvXjc
         meIWIIj0dm+X4+21jtLvpYKtPtny8VfR23urvm/+KZUmtC3+pndL0uZD7AxOBO8fkfjp
         V2zrndqsoNuvck0X0cQQDDIc5jtj9GPYSJ3nV03lZb48ez7Is4C6IvbmZBu/9zTzZyjq
         4EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=eifJcP1vUklgqMJfWvWhbBdkSpkR36FFTgBnF5hnnB8=;
        b=qBbmXau12AlcOnaASLPnAOBTSmQBuq6+MQh+RJJTHZGyRZN3hJSi5zIBA0kwyE9BTJ
         u/0IKqvSqIWl2DTU0wIWOyuF232GuvdIH99kctcaUQbykh5VHdL2jB2d9ZlPTmTeA/AT
         OLv6uSQrSQbJBRpz09ztEp1pNdmwQVbl0Zi8DMMTq433la5YDhZevH4LZ5rF5t4riWGD
         JhO+U0MxG+eLw4RELZDKyw5ntuqazBbXXFow/JkCAhKLUsivl9USD7nllUvZcZRWiuSP
         JG5cfLo/yzlbp+rksz8QVi/u1bCiED1mjWlXHOpNTwGWyUQK8fwddMiZV3lL/xbOUM7+
         3Q3Q==
X-Gm-Message-State: AOAM532zHK6pVxiTn18cQEcUJbMOO7FYuH5y+Ap+6VLNmAh/s/Ii1+ME
        fpLP0aK/yUHYdS/WuklDmOI=
X-Google-Smtp-Source: ABdhPJwXK7u+4alRBS5QYxnXadJ0hjtqpBnIwj8qIxgbsFAp38lkcURh1P0BqBQe1sWBRPDIpGsJCg==
X-Received: by 2002:a05:6830:2709:: with SMTP id j9mr155954otu.7.1643224095239;
        Wed, 26 Jan 2022 11:08:15 -0800 (PST)
Received: from [192.168.0.141] ([177.79.124.142])
        by smtp.gmail.com with ESMTPSA id 127sm6270050oih.8.2022.01.26.11.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 11:08:14 -0800 (PST)
Message-ID: <802c5ec0-dc3b-bab9-20f5-59be612a46f8@gmail.com>
Date:   Wed, 26 Jan 2022 16:08:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2022 - Project ideas page for the Linux
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
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

the Linux Foundation will apply again as mentoring organization in this 
year's Google Summer of Code.

Note that GSoC 2022 will be different again, code contributors do not 
need to be students, choice between 3-month´s full-time or half-time 
projects, more flexibility of when coding takes place.

On February 7, 2022 the application period for mentoring organizations 
for the Google Summer of Code 2022 will start.

To be successful, we need a rich project idea list so that we will get 
selected by Google.

I have set up a page for project ideas for the Linux Foundation's 
participation in the Google Summer of Code 2022:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022

Please add your ideas to the sub-page of your work group. Also remove 
project ideas which are already done in one of the previous years or not 
needed any more and make sure that all contact info is up-to-date and 
all links are working.

Make sure to not talk about "students", but about "contributors" 
instead. I have, at least partially, taken care of this when I have 
copied your sub-group pages from last year.

Also make sure to remove the "**Still needs to get updated!!**" phrase 
after having updated your project ideas.

If you have problems mail me with your project ideas and other editing 
wishes.

The ideas list is in the Linux Foundation Wiki. If you want to edit and 
did not have the edit rights already from previous years, please tell me 
and I give you edit rights. I need your Linux Foundation user name for 
that and the e-mail address associated with this account for this.

Please also take into account that the deadline for our application as 
mentoring organization is Feb 21 and after that Google will evaluate the 
applications. So have your ideas (at least most of them, ideas can be 
posted up to the student application deadline) in by then to raise our 
chances to get accepted.

Please also tell us if you do not want to participate any more with your 
workgroup, so that we can remove your sub-page.

    Till
