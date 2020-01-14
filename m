Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580E813B08D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgANRJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 12:09:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38355 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgANRJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 12:09:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so12971806wrh.5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2020 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fm+/Vic+e90JHF8LN1IvYqLlrZ++oXc6Gpu0k4fr+as=;
        b=TehOzp4k+Ih/Bdb1nq3nRSIaeA2oWa/vRoGYwN5zVs/a6ZbPEMfw9o9sp3/KlDXlQq
         Mlk3pBwxmPV7Tc/jVDY9+8B6bvbHUU7lKineTQosMkkG0eEyLMG+kfY04RWL9vb3fEqX
         LOiNI09sHcbRUqQQwypoW88ZSeA7kfUA6xEvS3tXQKvpeOZpTf/cDFME5lN6NfvBlWc8
         nrqrsjGvxEB57moH86sDQTgsb53Pdn3AeWygg/RE7IjpINQ+KL7WETf/subQSKfTh3Rw
         SkLAk1wxVZCWgfGa/5wR9mD35EvS1TfkpT0Rn+GpRGA7Jvkguy3/DBjWlEF9WZI0qjnt
         Bp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fm+/Vic+e90JHF8LN1IvYqLlrZ++oXc6Gpu0k4fr+as=;
        b=eg6rp9v12uWcn86tKhK9MXzAAclx0EteNNMplu+sIxnazp7ygjxZoWmx/OJ1zTV6bf
         PISRpDjTKC9Ou3EzJq2mRpINat5ivCzqxFTRai4MF2otsRGzZAe8HxPRASYDQCr6OZ+g
         sRZHeIz9Dg30M7yuLxZX/A81nvinNbkjhaBgLzfU9DhskYRG/Q86plt2Cr4yKjqosVvn
         sQZUwqsfCood51FQ9it9XdnP8GROuEzQAD9W0/XitBiuoxwjhO9AIyjgUqRND/VV4INk
         ZeEKPJIoVVLbAnnnheWY/2N22j5skzPocLLsIXVxC7rrOUM4oVYT1485QYjJY4fSsSJi
         w/3A==
X-Gm-Message-State: APjAAAWYpsHQ+Xaq/N6+vF/F9pPUbdpNePdpXRVcjSN8uolu9MKA7E3y
        pVja9wsRtqSgN9ZxuyQHug/RWYmVhJ0psw==
X-Google-Smtp-Source: APXvYqyBxgQi7nDj7KyqUOrzv+NsO1XnrqcmNfeAcH3lmurQhjfTyZqruywhEj61vhJriE8fn82gUg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr27603310wrv.269.1579021762429;
        Tue, 14 Jan 2020 09:09:22 -0800 (PST)
Received: from [10.0.0.197] (192-164-123-181.hdsl.highway.telekom.at. [192.164.123.181])
        by smtp.gmail.com with ESMTPSA id i10sm20818539wru.16.2020.01.14.09.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 09:09:21 -0800 (PST)
Subject: Re: Google Summer of Code 2020 - Project ideas page for the Linux
 Foundation online
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Aveek Basu <basu.aveek@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Gary O'Neall <garysourceauditor@gmail.com>,
        Ira McDonald <blueroofmusic@gmail.com>,
        =?UTF-8?Q?Jan-Simon_M=c3=b6ller?= <jsmoeller@linuxfoundation.org>,
        Jay Berkenbilt <ejb@ql.org>, Jeff Licquia <jeff@licquia.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Mats Wichmann <mats@wichmann.us>,
        Matt Germonprez <germonprez@gmail.com>,
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
 <alpine.DEB.2.21.2001141558020.6231@hadrien>
 <CAKXUXMy9jXV8dKkCLUCy5VtS1xbOgX67G126dCgW9p3RwxjZXA@mail.gmail.com>
From:   Till Kamppeter <till.kamppeter@gmail.com>
Message-ID: <7f655ea7-f0a2-abac-309f-60a925e85466@gmail.com>
Date:   Tue, 14 Jan 2020 18:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKXUXMy9jXV8dKkCLUCy5VtS1xbOgX67G126dCgW9p3RwxjZXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/01/2020 16:46, Lukas Bulwahn wrote:
> Yes, that is the mailing list I was referring to. I was asking if we
> should explicitly reach out on that mailing list for ideas on GSoC
> student projects. They are discussing topics there that can be nicely
> worked on by students without to much need of deep kernel expertise.
> 
> I am listening on that mailing list, but I have not seen anyone CC
> here being active on the workflows mailing list.
> 
> So, what are the thoughts in actively reaching out to that mailing list?
> 
> Lukas
> 

Please do so. If they like to participate, we can add a Kernel Workflows group 
on the ideas page.

    Till
