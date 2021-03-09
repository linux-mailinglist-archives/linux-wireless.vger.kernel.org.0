Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC333317D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 23:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCIW06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 17:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhCIW0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 17:26:49 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A96C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  9 Mar 2021 14:26:49 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id w32so575104ott.6
        for <linux-wireless@vger.kernel.org>; Tue, 09 Mar 2021 14:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5nXPGR+PMw3liu29J5fa6jmssnVIBZf6AwkY90tdU4g=;
        b=BVU+6+mujIRz8JlhSAgVota2H/KucFz1ofXKMhVXZsNleIajlcawHw+dh8qqFL67tu
         MipDVpRote0JalVKujmlrW/YLDC4vBsoxTY2nir3WIWL5NFwBcgJRcPkLJVUQzgWLj5O
         zA8/A/bIc/afLZMi7FOJ40cKM34NwDHeWXXLBsJlE8LG7T6ek4/IEnjMCpIDmDch01mw
         nROw3wjXyRuxwENnFHcVqc0nK68VAM//uGofZG/0Q/2b0LROsf7iQmGuw98tZufs/JVU
         U7JFtUFcDqJJ/AqOthGRS7lBA7bkg29BZ3sQvuZ+GwNueHeBzCrx6F/746dI995NUp6b
         YMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:cc:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5nXPGR+PMw3liu29J5fa6jmssnVIBZf6AwkY90tdU4g=;
        b=eyW0T/EQbnlbVXcs6wbQOBG0wpLkOrBAhgZix/FrI3WCy46XLymoHgxeklMMBqZdrA
         bkTTr+quiTGSJWYNO7Dg/7dVIvkb1b2yh1Goa8eWS5mVQvYM9bNtVuzEXvefShztEqLj
         Qiy8l/5J+c8t+wy/B1eim7eJ1CSAUquHLoKRYzy8TSnWfbFhaaFTvz5yEOB53bFjQqE4
         5ectK9j82TfJFtMIFZAHYFeb06jA0KD/NW0yeRyAXThv236MPaBHjhAEgLarAmoA9NrA
         Q7xHtYnkm4cnG1RfDiW+Le7R1nQFJwlI9laA1WxGHuw023OZeEyLs5r3KKh/a5/G4CXr
         5DSg==
X-Gm-Message-State: AOAM5336pAZGIHjMhRVprYDAgi1rWHs5SY+4SSBOYF5m1P5dSrucZtrr
        YUqK4TwK7xSwYFqBWoVo/74=
X-Google-Smtp-Source: ABdhPJyoYejCesq5M8uitwHiMQQNKmNzU1Ji1OYPP+vC8pm7ItUoHZ0R8L6XF4q8YhmmSDt15lX6Zg==
X-Received: by 2002:a9d:5907:: with SMTP id t7mr267247oth.105.1615328808509;
        Tue, 09 Mar 2021 14:26:48 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id a6sm3739754otb.41.2021.03.09.14.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:26:47 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [b43] ssh bug
To:     Evan Foss <evanfoss@gmail.com>
References: <CAM2RGhR89fcuPwkNxmiynU6qocjM85ROBA0M+Fw3y9VR-Mh2Pw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        b43-dev <b43-dev@lists.infradead.org>
Message-ID: <b99457e9-c562-45a8-40f8-fafbbda8fd2c@lwfinger.net>
Date:   Tue, 9 Mar 2021 16:26:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAM2RGhR89fcuPwkNxmiynU6qocjM85ROBA0M+Fw3y9VR-Mh2Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/9/21 6:18 AM, Evan Foss wrote:
> Hi B43-dev,
> 
> I am having trouble with the wifi card in my macbook pro 2012. It's a
> BCM4331 and it hangs on ssh sessions.
> 
> I noticed it documented here.
> https://wiki.archlinux.org/index.php/broadcom_wireless#SSH_freeze_for_BCM4331_with_b43
> 
> Is there some testing I could contribute to help fix this?

Evan,

I do not have that card, thus I cannot test with that chip.

Given the age of the chips driven by b43, it is hard to imagine that there are 
any undisclosed proprietary secrets buried in the code. Broadcom should open 
source these old drivers.

What are the symptoms of the frozen sessions? Is there anything in particular 
that you are doing when it freezes? Does the freeze require rebooting either of 
the machines in question? Is anything logged in the dmesg output of either machine?

One useful test would be to run Wireshark to capture the data on the network 
interface. That capture file might have information that you would not want to 
share, but you should be able to supply only the last few packets.

A macbook of that vintage should be able to run wl. That may be your best option.

Larry


