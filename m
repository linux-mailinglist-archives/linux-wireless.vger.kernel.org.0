Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0997A73017
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfGXNkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 09:40:45 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46203 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXNkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 09:40:45 -0400
Received: by mail-ed1-f48.google.com with SMTP id d4so47192746edr.13
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2019 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=7C1kH4C8Ai5623E2wy6X4E5D7ofjJ1zSSTpnn1s4N/8=;
        b=TqNQetPCDe5GUnPKGk8p1JuRQdMIvc0kGkYjiZe4A2MBcbeRjXWm2DX/tvLrCnOhPi
         vinaQdyCBAW6HYyCLnAGF/EhWqku4tI6zr04R0UHc6d+O4DvPiWMt+KBMEYGvChXHFxr
         rdgYnTF5pBtAdXPWHrWKxMNlyFs4Y66oUsnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=7C1kH4C8Ai5623E2wy6X4E5D7ofjJ1zSSTpnn1s4N/8=;
        b=NhGuG5pIQrMpbvdiu9/g7iwQyj02ntnzdD7yTatxS9pD2NFLRlI9wx/VxiVrRYa+zy
         CC6GssNAI74l+Mxj4Uq/FY3uVWt65U5bW/doM5IMM4fZUgp34ivadYx/cNZz/DrY2WML
         OCUAgoTeNzrREvDJJypAeH5tF5RceIXuKejddQo1xHYZ3nT1tWtLxjg+gtZvQ6l1JJ0a
         4DwSIhIqbzo5WAxYXJY/uvIgUdLdCXE61EaXVkUE5Ss5CqUavMFy3HZ0DqMoiNz8YjZW
         ysvU016wrxUGnltFHN+/ub0VlVdEVxm6HxAQHGYs0ZhE2mJQSIjHcNW0lm3s5AKwLfvC
         3vWw==
X-Gm-Message-State: APjAAAWWYCv6nmUUw2iH5qgX+zWah4vncarJnEisOSt2Ftcn1QmG12VV
        86UMd3+a2ILESCzDMvSRxhRoVIewbAQ=
X-Google-Smtp-Source: APXvYqx85ib0zQa41xOQITPoqYl/Z29TQBrOXje05v8+LLUA4rBECpPlK93DiLyGXOAFFzTroc20zw==
X-Received: by 2002:a50:f7c6:: with SMTP id i6mr70878015edn.51.1563975643851;
        Wed, 24 Jul 2019 06:40:43 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id x11sm13016163eda.80.2019.07.24.06.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:40:43 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Date:   Wed, 24 Jul 2019 15:40:41 +0200
Message-ID: <16c243667a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <fbacce3dd78c2154ee21c4f26f76a18a18349f45.camel@sipsolutions.net>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
 <fbacce3dd78c2154ee21c4f26f76a18a18349f45.camel@sipsolutions.net>
User-Agent: AquaMail/1.20.0-1462 (build: 102100002)
Subject: Re: [RFC V2 0/8] nl80211: add 6GHz band support
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On July 24, 2019 11:35:14 AM Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi Arend,
>
>
>
>
> After all the discussion, I think we want this?

I think so yes. Even if it is just informational for user-space it seems to 
make sense for kernel side.

> Care to resend?

Will do.

> I think I want it at least because we shouldn't advertise HT/VHT on 6
> GHz as is (just as part of HE) and that's easier if we have a different
> band enum, for the capability storage...

Right.

>
>> The only place I could find an
>> issue with this is in cfg80211_wext_freq(). Not sure how to deal with
>> that so it is not part of this series.
>
> Just finally break wext and say if you want to use 6 GHz you need to use
> nl80211? :)

Probably is true for he support as well. Not sure. Have not been using wext 
for the last decade ;-)

Regards,
Arend


