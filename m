Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5131A13ACB0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgANOzf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 09:55:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANOzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 09:55:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so14122839wmc.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2020 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fhjn0OQpgKU7xlI4qOZBiy3DtcFY/jgxjtTQoPeTYPA=;
        b=IcUlitQwmdeLweA1kERVf2jnxmx45kCHQaAKWmShAEEp3iLGzwt5EXJdcJcjSw9y4/
         SX24FuzFYAx42mUXV4AFkQJStumjMj4+DBpU5YHlt6XeTlqo9F2OlMknyqFoe9bgjl+L
         S/Z3KQXgA90VP3vfViBO831iGh1nl+lTY31yENYxmZjJ9P8dtrw4eIKLXHWspp9Tg82W
         k8blXyj/y1xhPFpnxtacjYePUrBM6NB/fG2LTb7ju8b7niHBJHmKOzjhpNyYwVG0NXb6
         XB1cT66XOSWZcWTnppXFfUKE6b6jS4MCyPdaQFUhqVOoGOy0KWmS1UOLs/4ENt+jwpw/
         YY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fhjn0OQpgKU7xlI4qOZBiy3DtcFY/jgxjtTQoPeTYPA=;
        b=XL9s35Qy2776CQBum1826/anLdQW9ZOVhkEHuIZP/yGGrCw3TL9aQ6E8n9RLdWN3DM
         mozOb7mwWQOSYrLlAs2hgNIdcyo6J9emA2eKhR+hg/G/DZ6CfNiFMBfLRayHdL2yTwkz
         PrH+Vy57PdIgR/Dbp9tAPqecJp+r1l5/MVq8aAbTzFeBaJ53O6icWOM6aJsyQ8KSZA2e
         g/m7+AUjOX86RN47YpAZUNKpjsPYDiMQjPJdDiJQ6N3L1S1rrl84I6oea0iFbCwy5WiQ
         4RdCvQZiLyviyS9+1Cqq4EuVPxYoRsTXrQKCnw83F60+J6mdQHCD1CrWeg8qd2j2l4HR
         oa7Q==
X-Gm-Message-State: APjAAAXiOHPbd/9NPNPwTF0KYqruamDtClDPSEsfE6PVdfAq3uaNNFt6
        llCew0eauUIqcyOH8ZQkEgQ1tEyEA/49iA==
X-Google-Smtp-Source: APXvYqwv3O6hj0AOkID21CcHwyTLlBnMuoAj3ilF/CPGLqGLQwZkNkRGuUrxdjyvmy/tdJ5B07L14A==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr27853469wmb.32.1579013733096;
        Tue, 14 Jan 2020 06:55:33 -0800 (PST)
Received: from [10.0.0.197] (192-164-123-181.hdsl.highway.telekom.at. [192.164.123.181])
        by smtp.gmail.com with ESMTPSA id d16sm21196501wrg.27.2020.01.14.06.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 06:55:32 -0800 (PST)
Subject: Re: Google Summer of Code 2020 - Project ideas page for the Linux
 Foundation online
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Aveek Basu <basu.aveek@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Denis Silakov <silakov@ispras.ru>,
        Gary O'Neall <garysourceauditor@gmail.com>,
        Ira McDonald <blueroofmusic@gmail.com>,
        =?UTF-8?Q?Jan-Simon_M=c3=b6ller?= <jsmoeller@linuxfoundation.org>,
        Jay Berkenbilt <ejb@ql.org>, Jeff Licquia <jeff@licquia.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Mats Wichmann <mats@wichmann.us>,
        Matt Germonprez <germonprez@gmail.com>,
        Michael Sweet <msweet@apple.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Open Printing <printing-architecture@lists.linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Tobias Hoffmann <smilingthax@googlemail.com>,
        Vadim Mutilin <mutilin@ispras.ru>, dl9pf@gmx.de,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <d6d2eb63-e2b5-26f1-34b3-d1b1dd511fe8@gmail.com>
 <CAKXUXMyswP6S7aZCcA6n50PPKb1=KXOd=-fctCsEg+vwByD63w@mail.gmail.com>
 <CAKSHSL40okJrsQv9zHhKwxzZ49C0kct1Nr4=zQu-NYGKp-z83w@mail.gmail.com>
 <CAEnQRZD=GH6s5dkuLxT=MojwuM6WZgL4WZN500yzk=qcjV=_wA@mail.gmail.com>
From:   Till Kamppeter <till.kamppeter@gmail.com>
Message-ID: <5d5190d1-4d76-f669-bc49-f0788152a1a3@gmail.com>
Date:   Tue, 14 Jan 2020 15:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEnQRZD=GH6s5dkuLxT=MojwuM6WZgL4WZN500yzk=qcjV=_wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/01/2020 15:49, Daniel Baluta wrote:
> Hi Aveek,
> 
> I think Lucas was referring to Linux kernel community. There are
> plenty of developers from all companies
> around the world who might have some ideas.
> 
> For example we could send an emal to lkml or kernelnewbies mailinglists.

Perhaps you could contact possible mentors and post on appropriate mailing 
lists. The mentors should contact us then with workgroup (from the already 
listed ones or a new one), project idea descriptions, mentor's name, e-mail 
address, and if they have, Linux Foundation user name. Then we will add them 
with their project or grant them write access to the project idea wiki pages.

    Till
