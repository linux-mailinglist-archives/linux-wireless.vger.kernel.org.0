Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFC13AC9C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 15:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgANOuB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 09:50:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55515 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgANOuA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 09:50:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so14107992wmj.5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2020 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaOhAZj47epTCdn4cs/FH6YiWO63fzhtUgFb6q7Vyoo=;
        b=cOBwcBVkHENBZF3+Y1dspIK6/Ga3yDdnTSXStxqjPkZ5S7gICMu11gcaLUeghjTPSg
         viK95Y0U9JCAPw4NKjIPiE4s9fgppad9JpEYyK18b1IcQEFUY0PqsffuVtHrKxtJUe1U
         uiIpvDGYoGvLTk0ORhYE8c/+TTCY4SA945Tn23wpc//ym2H2YmPerIoRg49wxZw+fUrV
         bhk6mFM1BDJ49pGsvBTBLPgzEQrWw3FzX4fds2FiLqNCtyFAI0RulkOeuLqy2Fpwb7Kf
         Af5LgPSQABKTs2irl7mLr6imEQdWU+G3zMbKIfwK7F4ckCaruuq2XVqKJsUM5kD/3TUQ
         rtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaOhAZj47epTCdn4cs/FH6YiWO63fzhtUgFb6q7Vyoo=;
        b=NfLJ5PRMdt9Co/JSl8vyAeO8OkFBLHB/RWPuWtc4xlgd18lGeKD3vrTdfBr2bVRmY7
         KZ3ZM3H5BHcy7XPWiePjvqqtcOpgPtKWvEJfIt5G6oIvFoHQMvYkJtkQ5p2QJDLz1OPh
         +gGEbNbioVSTVXXqOJW6pUICrCxjBhMm8VmZ6kdUuQqJHO2Sm84fwyhoWh7CaKz50Pb0
         bHHZO9Cxh+9gSRquD3tPlcgkYIGt6LneKhHpffACVbNkqJYZDjNR8lBKSeddX2JfJzlH
         hQz2Hp6yV1/sTHPdbN/pMl7LBIUrs5sH8xbY71ocGc1dEORWWSjTUjF9IAaoqJeNfYd8
         tHXw==
X-Gm-Message-State: APjAAAW5BahQ6PbYoW3trwkk81UAlTnphLWSNTn8XkgjguVRgdh2HkRw
        gf3y75tXcMmh5WJUnWOT+0H0BwoCYrfBGKe3CEk=
X-Google-Smtp-Source: APXvYqycqqH/oHqpYnvxpRorQlyTMIh5g/aIdw81GxleZYOWe+JMtaS+u2Hp5y2fum8qOiNCL9eJ7yalkd06rrxxoEY=
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr26596259wmj.39.1579013399194;
 Tue, 14 Jan 2020 06:49:59 -0800 (PST)
MIME-Version: 1.0
References: <d6d2eb63-e2b5-26f1-34b3-d1b1dd511fe8@gmail.com>
 <CAKXUXMyswP6S7aZCcA6n50PPKb1=KXOd=-fctCsEg+vwByD63w@mail.gmail.com> <CAKSHSL40okJrsQv9zHhKwxzZ49C0kct1Nr4=zQu-NYGKp-z83w@mail.gmail.com>
In-Reply-To: <CAKSHSL40okJrsQv9zHhKwxzZ49C0kct1Nr4=zQu-NYGKp-z83w@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 14 Jan 2020 16:49:47 +0200
Message-ID: <CAEnQRZD=GH6s5dkuLxT=MojwuM6WZgL4WZN500yzk=qcjV=_wA@mail.gmail.com>
Subject: Re: Google Summer of Code 2020 - Project ideas page for the Linux
 Foundation online
To:     Aveek Basu <basu.aveek@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Till Kamppeter <till.kamppeter@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Denis Silakov <silakov@ispras.ru>,
        "Gary O'Neall" <garysourceauditor@gmail.com>,
        Ira McDonald <blueroofmusic@gmail.com>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <jsmoeller@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aveek,

I think Lucas was referring to Linux kernel community. There are
plenty of developers from all companies
around the world who might have some ideas.

For example we could send an emal to lkml or kernelnewbies mailinglists.

On Tue, Jan 14, 2020 at 4:29 PM Aveek Basu <basu.aveek@gmail.com> wrote:
>
> Hi Lukas,
>
> Folks from the kernel groups are already copied in this email.
>
> Regards,
> Aveek
>
> On Tue, Jan 14, 2020 at 4:57 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> Hi Till,
>>
>> I would suggest to also reach out to the kernel workflows group. I have seen various good ideas for student projects, which are more suitable for students and have larger impact on kernel development than many topics that I would provide.
>>
>> What do you think?
>>
>> Lukas
>>
>> Till Kamppeter <till.kamppeter@gmail.com> schrieb am Mo., 13. Jan. 2020 um 23:04:
>>>
>>> Hi,
>>>
>>> Tomorrow the application period for mentoring organizations for the Google
>>> Summer of Code 2020 will start.
>>>
>>> To be successful, we need a rich project idea list so that we will get selected
>>> by Google.
>>>
>>> I have set up a page for project ideas for the Linux Foundation's participation
>>> in the Google Summer of Code 2020:
>>>
>>> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2020
>>>
>>> Please add your ideas to the sub-page of your work group. Also remove project
>>> ideas which are already done in one of the previous years or not needed any more
>>> and make sure that all contact info is up-to-date and all links are working.
>>>
>>> If you have problems mail me with your project ideas and other editing wishes.
>>>
>>> The ideas list is in the Linux Foundation Wiki. If you want to edit and did not
>>> have the edit rights already from previous years, please tell me and I give you
>>> edit rights. I need your Linux Foundation user name for that and the e-mail
>>> address associated with this account for this.
>>>
>>> Please also take into account that the deadline for our application as mentoring
>>> organization is Feb 5 and after that Google will evaluate the applications. So
>>> have your ideas (at least most of them, ideas can be posted up to the student
>>> application deadline) in by then to raise our chances to get accepted.
>>>
>>>     Till
>
>
>
> --
>
> Regards,
> Aveek
