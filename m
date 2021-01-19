Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9E2FBF0A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbhASSbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 13:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbhASSbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 13:31:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87BC061573
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 10:30:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hs11so27598149ejc.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=g9SgOlxYVvQ5SykEbLqivdPZ1RRrVaUEDGfu6tDXXes=;
        b=Azp8/6cplfyE/Ul9u9ni5oDuy7+6hd05JizMm7DgY5rDm/gK2VBNGkiQ32Pe+GPe1n
         lcNFg0/AGfsnlj/Rk5EgQKn2cx9Mn/9VMCANm5LZlR1eELNLBNXV7cXyYVNUIKBSPeKC
         frFYH5a8snAI0Jf1yhFBkFRFeiR1ofQkoC2V5slx2j2Lbk7tFgnLcgizxb7xiMUK+81E
         +PLhC9ea0ZDaoU4UzgEzn0l3Z9V2uNv8cZcmM+AMMsrZNQ0Wr0TWF4hlcRrPv5RAejVt
         Glio2ZfVxkQrDnSfq8B7eD0dFurqAVj1ny8sCPXGrmbOtlfNYavNx5pHtTH8WGla+J3h
         TzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=g9SgOlxYVvQ5SykEbLqivdPZ1RRrVaUEDGfu6tDXXes=;
        b=XwZql5sDGrSTwHaHK5jfP2vYhk5tPhP0+AysEZ7tYYH5wZ08bsESI2YInHgUGm83p1
         K4yyb7gq+jfV4cPt3vJxb4x5+nTPmcE2g6Rg1ca96Xhsj2VJKu+6qnwlMcGf6d+HvQXZ
         Y+GWxrprnvHAWfsp+sXgEnnnNKC7tTsjucSPnG8ie3w6Ze/N/UI8YThmGuV9Xnq+4+BC
         nzAS8VPUslBfmNfG0RXJjStag8B20l/vpLhvXhmiSO/13dk4PWlA++jvQ0kDT1mLbLb8
         8hiiU9ZCKXIMijjzAi+59P+YwFXQMZp82YApT78/zP1ZG9BZXiiddCXhaqeFycYCVrZM
         g8GQ==
X-Gm-Message-State: AOAM530jecyXIvLv08ga1wfVmLBexqXsLvXKGwzCC/+LNCBTPJYKm6on
        /ueGkQAsRQFmMmnvFY2rKgw=
X-Google-Smtp-Source: ABdhPJyHZDeewQ5pXc0Gjy9Dfb6mggZQcVEspM4XKAt55fPWiG0zt+wvc2DwnQgVtEkzBvyDyR2vwQ==
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr3964792ejn.214.1611081056673;
        Tue, 19 Jan 2021 10:30:56 -0800 (PST)
Received: from [10.0.0.15] (80-89-109-210.hdsl.highway.telekom.at. [80.89.109.210])
        by smtp.gmail.com with ESMTPSA id fi14sm11171048ejb.53.2021.01.19.10.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:30:55 -0800 (PST)
From:   Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2020 - Project ideas page for the Linux
 Foundation online
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Jeff Licquia <jeff@licquia.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Open Printing <printing-architecture@lists.linux-foundation.org>,
        dl9pf@gmx.de, Mats Wichmann <mats@wichmann.us>,
        Denis Silakov <silakov@ispras.ru>,
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
        Deepak Patankar <patankardeepak04@gmail.com>
Cc:     Aveek Basu <basu.aveek@gmail.com>
Message-ID: <5ea4c46e-bd90-8a94-e2d1-4c908269fac4@gmail.com>
Date:   Tue, 19 Jan 2021 19:30:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

the Linux Foundation will apply again as mentoring organization in this 
year's Google Summer of Code.

Note that GSoC 2021 will be different, the 3-months student projects 
will be replaced by part-time projects, 6-weeks full-time-equivalent, to 
be done in a 10-week time-window. Stipends are appropriately reduced to 
the half amount, leading to the same per-hour value.

On January 29, 2021 the application period for mentoring organizations 
for the Google Summer of Code 2021 will start.

To be successful, we need a rich project idea list so that we will get 
selected by Google.

I have set up a page for project ideas for the Linux Foundation's 
participation in the Google Summer of Code 2021:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2021

Please add your ideas to the sub-page of your work group. Also remove 
project ideas which are already done in one of the previous years or not 
needed any more and make sure that all contact info is up-to-date and 
all links are working.

If you have problems mail me with your project ideas and other editing 
wishes.

The ideas list is in the Linux Foundation Wiki. If you want to edit and 
did not have the edit rights already from previous years, please tell me 
and I give you edit rights. I need your Linux Foundation user name for 
that and the e-mail address associated with this account for this.

Please also take into account that the deadline for our application as 
mentoring organization is Feb 19 and after that Google will evaluate the 
applications. So have your ideas (at least most of them, ideas can be 
posted up to the student application deadline) in by then to raise our 
chances to get accepted.

Please also tell us if you do not want to participate any more with your 
workgroup, so that we can remove your sub-page.

    Till
