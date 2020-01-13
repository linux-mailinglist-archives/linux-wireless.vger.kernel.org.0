Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30D6139D15
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgAMXEc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 18:04:32 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39003 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAMXEc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 18:04:32 -0500
Received: by mail-wr1-f42.google.com with SMTP id y11so10362528wrt.6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2020 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xqHS/fn2w7FvGQjFFROgmOytV6uly0ybWXeoXJYw4BI=;
        b=YnMAr1HDCYztWl01kn2DaluktirdxP53GuuM7DzlfhBdwe1aRAOjtyL5QwiX2hJzdm
         PPWKGyiMuMQ1Y6hOoNBWJMayZVTCZIB08H0xVgIBJXlZgM5iD/n+wECyEOnnDnwMpeKg
         pcP7g3g4A4qypPg9r0PA1TwgHtJ1EnXyHHe/vCuT+Rn14i/yhGThHA2wKI9pX6BZCSoV
         PqqSHidlYNa56zguDsI8MZgHOyAJnue2sv5HvKvBWTfbscUutRSvLpvxYKtPimkLtZIl
         smmMj9VOpMcv2Z34166mcCJwaUZJpnTMa2O2y+xojbXqU6/7MKDuRCYm9GPPGa03RCuZ
         1Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xqHS/fn2w7FvGQjFFROgmOytV6uly0ybWXeoXJYw4BI=;
        b=dVr2rO9PnchjE37IOqA5r57sLZvPfP9I52qwcskxCDhnKThvs50qP3WoU1c94hayv8
         tLjrH/OLa8T7T/EfH3NAtfyqszpXYJYN9UXW7Xp81eqBMBRPbzyZR+mT/YLiSEOHT1DW
         NEy0c+YNTnekM27YblcEhCTElOKBDT5wHSfBa7AEmr+CoIgob4x8IFaSnpv7W7BPXQlh
         5KYle2P9fpCGsBJQXfe8qsZ8FpSq7e1soG1Lprwio/0ZwfCs4UHinNlxArsH7oMSOSnh
         FHoWu6eBvOvJb5kVGEAfZLHH0S91EStDVDZGlpsdHa1fLtzkEO8y3QflQ+Up8QaUI5S7
         Jm2w==
X-Gm-Message-State: APjAAAXFn9Bts9irfK8903DSvQOWj7ErsngIXIxefEvpJKnoa6cWt3/3
        mhu52LOCdYPFvAgdm7gwBdY=
X-Google-Smtp-Source: APXvYqyXvpxTUixg9xc5qYA9fY1dFCbeZUziP/qUGXxRECoM6dVoBJYbV/iYbu4rBjvuJYhA1JuFkg==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr21092792wrn.155.1578956670411;
        Mon, 13 Jan 2020 15:04:30 -0800 (PST)
Received: from [10.0.0.197] (192-164-123-181.hdsl.highway.telekom.at. [192.164.123.181])
        by smtp.gmail.com with ESMTPSA id i11sm17288395wrs.10.2020.01.13.15.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 15:04:29 -0800 (PST)
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
        Michael Sweet <msweet@apple.com>,
        Tobias Hoffmann <smilingthax@googlemail.com>,
        Jay Berkenbilt <ejb@ql.org>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Matt Germonprez <germonprez@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Gary O'Neall <garysourceauditor@gmail.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Aveek Basu <basu.aveek@gmail.com>
Message-ID: <d6d2eb63-e2b5-26f1-34b3-d1b1dd511fe8@gmail.com>
Date:   Tue, 14 Jan 2020 00:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Tomorrow the application period for mentoring organizations for the Google 
Summer of Code 2020 will start.

To be successful, we need a rich project idea list so that we will get selected 
by Google.

I have set up a page for project ideas for the Linux Foundation's participation 
in the Google Summer of Code 2020:

https://wiki.linuxfoundation.org/gsoc/google-summer-code-2020

Please add your ideas to the sub-page of your work group. Also remove project 
ideas which are already done in one of the previous years or not needed any more 
and make sure that all contact info is up-to-date and all links are working.

If you have problems mail me with your project ideas and other editing wishes.

The ideas list is in the Linux Foundation Wiki. If you want to edit and did not 
have the edit rights already from previous years, please tell me and I give you 
edit rights. I need your Linux Foundation user name for that and the e-mail 
address associated with this account for this.

Please also take into account that the deadline for our application as mentoring 
organization is Feb 5 and after that Google will evaluate the applications. So 
have your ideas (at least most of them, ideas can be posted up to the student 
application deadline) in by then to raise our chances to get accepted.

    Till
