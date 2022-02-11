Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBC4B2CB8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiBKSVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 13:21:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiBKSVm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 13:21:42 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9813A
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 10:21:40 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g19-20020a9d6213000000b005ab7489371aso6667176otj.6
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=M16F5aGzZ1kbTmJuT4wby65u+Ln9J/gQAC3GkM+k1tI=;
        b=FAB15dTXMU7F/IHEjX4z18foQsyQM5vAmRDyQIMoB5GQF2Knhg3+M1SGNo5si6XvhF
         y61KMoZkuiB+n2ZGajDl0rmhbdajlHPR/29monNysDA5IVMNJMXyW0w7UkHgdMTWC245
         49Cck10L4x89RWyz5qa7c2N/ByuMSZKiYq3kESE44+yNhIyVRLvx8aF6WhlgyFATLkuY
         KuKJqp7CPiW6GDrqfVmdxRJPwzwgAl3uN/VGsOEw3478hpVHMxLJ/W/7t8njvqq5Az/6
         85rFFvmL2MGth56VSNoGo5JBfmEjUC69/1qo/0SkuQ12jNagv5WTDTiU1bVF1zDPtntq
         4Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=M16F5aGzZ1kbTmJuT4wby65u+Ln9J/gQAC3GkM+k1tI=;
        b=rAT2qc6qUmPNOffS05MzNNRoXJf7GkmSfx9ehHbpQ5u+NdreHqUntPJeedl7YM3tVl
         cAi220g7oXplO0aCxoylA6RukoUYY0iY9Z6bxbCA6CHn30cy8T8rMKxJQtcVDdhr0dSo
         qs+WpT7+1C0fUD2WOU98pe2EDNR87a9hPauOYKA0avLwCltjcRSv/G4J0V1ESed/KTYB
         uCPfptX/Mzz0AE8XpxjpPTWlN2GWZFAwsa/GGfAcrJPKY59BWQ0lV2XSnlj4AtFgEuYU
         8qcwwyEoNPKfi+11tcPnBcHTxow/DWvHN+OqzIRuEi2CX2OuAXeHiPzXbp3YbDcMBBzb
         KmgA==
X-Gm-Message-State: AOAM530a3sV/hXYZbeQdGm45GZKXWyB8vEeTacwqozrn8U+p+FxFxh5x
        vauYDmMW7GVXopseqjBorbc=
X-Google-Smtp-Source: ABdhPJxf6bWY8udnrG6SWo8BzDjHoKd1gEanagUXgOSjvXyF0thh8FPx50HvX2wUX/srtPLurcZ1nQ==
X-Received: by 2002:a05:6830:2b20:: with SMTP id l32mr1101022otv.333.1644603699743;
        Fri, 11 Feb 2022 10:21:39 -0800 (PST)
Received: from [192.168.0.141] ([177.25.176.248])
        by smtp.gmail.com with ESMTPSA id bj8sm10282312oib.20.2022.02.11.10.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 10:21:38 -0800 (PST)
Message-ID: <7e4a5cc9-5804-552e-6f84-edd41401bcd6@gmail.com>
Date:   Fri, 11 Feb 2022 15:21:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: REMINDER: Google Summer of Code 2022 - Project ideas page for the
 Linux Foundation online
Content-Language: en-US
From:   Till Kamppeter <till.kamppeter@gmail.com>
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
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Rithvik Patibandla <rithvikp98@gmail.com>,
        Dheeraj Yadav <dhirajyadav135@gmail.com>,
        Deepak Patankar <patankardeepak04@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Bhavna Kosta <bhavnakosta2020@gmail.com>,
        Danny Brennan <mdannyb11@gmail.com>,
        Lois A DeLong <lad278@nyu.edu>,
        Jonathan Beri <jberi@golioth.io>,
        Brett Preston <bpreston@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vit Prajzler <vit@golioth.io>
Cc:     Aveek Basu <basu.aveek@gmail.com>
References: <802c5ec0-dc3b-bab9-20f5-59be612a46f8@gmail.com>
In-Reply-To: <802c5ec0-dc3b-bab9-20f5-59be612a46f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

some weeks ago, I asked you all to post your project ideas on our Wiki 
pages (see below).

As the application time window for the organizations has started and 
when it will end on Feb 21, Google will start evaluating and selecting 
the orgs, I am reminding you to update your sub-groups page with the 
current project information and also update everything what is needed, 
especially talk about "contributors" and not "students" when talking 
about the people who are coding, and also check your IRC channel 
references because of the (semi-)demise of Freenode.

Please also remove the "Still needs to get updated!!" on your 
workgroup's page.

And for each idea tell whether it is for a half-time or full-time project.

Also note the more and the better described ideas are posted, the better 
are our chances to get accepted. You can remove (and also change or add) 
projects later.

As an example, have a look at

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022-openprinting-projects

    Till


On 26/01/2022 16:08, Till Kamppeter wrote:
> Hi,
> 
> the Linux Foundation will apply again as mentoring organization in this 
> year's Google Summer of Code.
> 
> Note that GSoC 2022 will be different again, code contributors do not 
> need to be students, choice between 3-month´s full-time or half-time 
> projects, more flexibility of when coding takes place.
> 
> On February 7, 2022 the application period for mentoring organizations 
> for the Google Summer of Code 2022 will start.
> 
> To be successful, we need a rich project idea list so that we will get 
> selected by Google.
> 
> I have set up a page for project ideas for the Linux Foundation's 
> participation in the Google Summer of Code 2022:
> 
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022
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
> Also make sure to remove the "**Still needs to get updated!!**" phrase 
> after having updated your project ideas.
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
> mentoring organization is Feb 21 and after that Google will evaluate the 
> applications. So have your ideas (at least most of them, ideas can be 
> posted up to the student application deadline) in by then to raise our 
> chances to get accepted.
> 
> Please also tell us if you do not want to participate any more with your 
> workgroup, so that we can remove your sub-page.
> 
>     Till
