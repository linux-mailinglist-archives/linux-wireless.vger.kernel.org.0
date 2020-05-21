Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37CC1DCF3A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgEUOKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgEUOKh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 10:10:37 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECECEC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 07:10:36 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id z26so1456261oog.8
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMJeVUM1wAAh22sySV2lmbc3Pmg8bbmB6WxZxgSOH7I=;
        b=a+vr7oSiOtKlE2RJUc+P2EqgCxnPO88D+H8KuQ3dQBaNRmpqGVF3aejCVkDUQ04P2+
         xUe78XGqblMS4lzJA4Q96IYMptjjeziB32ezax4M5R4znV8OOOj8xNfXGYUJMLHSo0JE
         tTVF70LQS9QxVFC/J18vqNEuo1+/THUhFcGb0IZE/Ak6ZV9/jzG5fPrHlcVCzu7FiWf1
         9bAt+mf5woScLZjhr1mt+dJzGr5VuT88jEsCrRm0wIZoBhnpTqzXTH3ejQ24mdaw0DX8
         NbN5pEwqa5Ryxny2rgNVkROApj/l/G5Q7s0dHEAjGeJ/T8srH4+Y79SEvEYhyqzxHPJe
         MbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMJeVUM1wAAh22sySV2lmbc3Pmg8bbmB6WxZxgSOH7I=;
        b=dP8yJCEX8ZldtEvPXD+pEQeTM2/dxjCxD2XfCLooEIrxscidF46OSU3EkLkggg6B9Q
         XNAsTS0+4XVOukIzUfPNq9HaQRiCcyCyUjv+SAbfndi4v86jvJfBqIf7Z5Yh3FX4HuT6
         scLrcvvL8hLI1Ubf4qA1lHi8rq/VMw80kp3MiVYeojCg8IBA8xxVr9lg/Ftnlt9pM+5J
         wjRV7vi2cRNfu+PBR87MEknQDfV4Avk5jFGqZo1U7bzSJ0EFQog4qQ6MBnQSJDtjCa+x
         43BTfZPDFFpcwGM1oTYyG62IZgW4z0BsBRU7I+P7XB/9Z9BXLW//tS47ncb6Zn5POInP
         i/uQ==
X-Gm-Message-State: AOAM5339pDUnNlyXmyp+tM3PHcYGrouRM/T4oUaJnFSSTbvo2jqquu6A
        gRmdmwzolMXrk/HzkqmbbR4=
X-Google-Smtp-Source: ABdhPJzyTFm/CoI4i2cbYOKO5IRZqEaMAqwKMNeC8Eww4nCTPBUs6D8ZHhd3FBJOIShxd+QxtF9asg==
X-Received: by 2002:a4a:9843:: with SMTP id z3mr7517711ooi.31.1590070235121;
        Thu, 21 May 2020 07:10:35 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v24sm1603628otn.59.2020.05.21.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:10:34 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
 <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net>
 <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum>
 <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <462b5428-bd66-a844-9bb3-7113ee9e5ef0@lwfinger.net>
Date:   Thu, 21 May 2020 09:10:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521134011.656381ad@wiggum>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/21/20 6:40 AM, Michael Büsch wrote:
> On Thu, 21 May 2020 12:30:43 +0100
> Rui Salvaterra <rsalvaterra@gmail.com> wrote:
> 
>> Also note that this a PowerPC laptop (iBook G4).
> 
> That's not exactly a modern CPU, but measurements would be useful
> anyway.

Michael,

Thanks for a hearty morning laugh. I needed the endorphins.

I will be able to run some tests using a BCM4312 on an Intel i7 CPU running at 
2.90 GHz. It is a Haswell chip launched is Q3 2013 - a little more modern. My 
setup will be using WPA2 connecting to an AC1750 AP.

Larry

