Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621F529E2D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2019 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfEXSia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 May 2019 14:38:30 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41773 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfEXSi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 May 2019 14:38:29 -0400
Received: by mail-ed1-f44.google.com with SMTP id m4so15588602edd.8
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2019 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=SbtAPrUr8IxhgOzUH1Q0AMZ1VmG9wH+iYfRy6q93L6k=;
        b=FYgVEfYLoJcXJR62nLwwHKI3o8YukC0+3SKgIZlvsSf/AiG1Dj6Ll/CSyaRpVHBYbF
         C0CI27Q9BFcSqb5VL9J7nwOHwkxBA7EBlEBc0eel0ou+66o4iyh5Uc23ord2p+mvIvap
         KVFYx5l56FQom6MRpXFYy5fDA11DblxoIiIcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=SbtAPrUr8IxhgOzUH1Q0AMZ1VmG9wH+iYfRy6q93L6k=;
        b=dUOfeRV8Ta53Un+ynstpZdfgEeloW7AkaPcER9A1YZSk0hvbol6XS08O/DcyvV5bU1
         +JwOqmFkZZVShi9HKVkkzBTCXZ2ZyEZfwbpGVYEfSCnYanK6LyGyhhMs5FK2nWdG5k6B
         go14+nzT766uq8KzFCCqxWZrQdhf4q2yVIsaHCHJ4mVsi9MjgtXczh7CBOJukagEU1mg
         CxLTNFBAM2ft9tuGkehZAs9cUOHVizA0tz7vtVHj9VcVljtqmCfQGflSK215MUKO2JJd
         jQ5fN1cyzIl2NU0v+gsEY37vtPwfX4+J5Skib8arWGrBXW3A2DJ1U6lTXFFMvxHhsR/J
         azXQ==
X-Gm-Message-State: APjAAAXWwG0QcI29xxX7gVcEdkoqwb/AssbkpOTXg+awyBuEOWRyJi5X
        PAQxRvv7akLCvSc9IqUqoHzjjA==
X-Google-Smtp-Source: APXvYqxW9QuuHbIwO961GhNn1mG7Pcc6tKJyi3infVr/4rcUmnlDlOg8stR5Shfs77XmNxHTGl2qyA==
X-Received: by 2002:a50:a522:: with SMTP id y31mr105853040edb.69.1558723107887;
        Fri, 24 May 2019 11:38:27 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id i45sm874042eda.67.2019.05.24.11.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 11:38:26 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Date:   Fri, 24 May 2019 20:38:25 +0200
Message-ID: <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On May 24, 2019 1:56:43 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi Arend,
>
> On Mon, 2019-05-20 at 14:00 +0200, Arend van Spriel wrote:
>> In 802.11ax D4.0 a new band has been proposed. This series contains
>> changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
>> was no overlap in channel number. However, this new band has channel
>> numbers with a range from 1 up to 253.
>
> At the wireless workshop in Prague, we looked at this and sort of
> decided that it'd be better to put all the 6 GHz channels into the 5 GHz
> "band" in nl80211, to avoid all the "5 || 6" since they're really the
> same except for very specific places like scanning.

Would have liked to be there, but attending is no longer an option for me. 
We now have two autistic, non-verbal children and I am the primary 
caregiver for the oldest because my wife can't handle him. Guess I should 
have checked the workshop notes before working on this :-) Do you have URL?

Agree that most functional requirements for 6 GHz are same as 5 GHz. There 
are some 6 GHz specifics about beaconing as well.

> The channel numbers problem came up, of course, but for nl80211 it's not
> that relevant since we deal with frequencies only, and we thought inside
> the kernel it'd be better to disambiguate them with operating classes,
> where needed - only few places really deal with channel numbers to start
> with.
>
> Do you have any reason to think that it's better as a separate band enum

No specific reason. Just that the few cfg80211-based drivers tend to use 
channel number as hwvalue.

> (which I notice you put before 60 GHz thus breaking the API/ABI :P)?

Right. Now I feel wet behind the ears :-p

I will go with 6G being additional 5G range and see how that works for us.

Gr. AvS


