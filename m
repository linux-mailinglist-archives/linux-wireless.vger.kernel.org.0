Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680072FADC8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 00:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbhARXby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 18:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729469AbhARXbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 18:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611012626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KARSxMlqve3lEfjuJrPHxee2UhIN9PMv1TMy/npgiFU=;
        b=Ahu5ZIgaidM5Bji7pH0fjDFVq4v21LwFHUi7mcsFSVMVL+0yD9jaKgYsVzHjTuSm8C1Xeo
        VVEbItGNUAMOeilZNvDFQxwKQTg4wMhVcjXA6PoChuxE0npnXU63px+5Ru+qAhdn9rN8nX
        AEB/T/rXqkZCibPWGh/I8L9hy1RpRWE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-64P4QGK5OLajRX8UcpYs-Q-1; Mon, 18 Jan 2021 18:30:24 -0500
X-MC-Unique: 64P4QGK5OLajRX8UcpYs-Q-1
Received: by mail-yb1-f199.google.com with SMTP id 67so18791593ybh.22
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jan 2021 15:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KARSxMlqve3lEfjuJrPHxee2UhIN9PMv1TMy/npgiFU=;
        b=aT3+FPfHXxg2loVVnAapp00dT0aROBR7rWb0pjPCA2Cim4e8qEd3XvAq0Vj9bDr4Hw
         05TuSs50rs94Ft6UGVUNS9UUj22Mtv6CG/XjJgTfUOs/eUmWBPDwxMeJH54dkfzDXpXM
         Rb1Y3QVhE7ivLViRebfhwEnYNrZ1jwHzmYsnyXnKyfXKlrfKSjJPo2BLhO5E6GW+KmOF
         vp7gBzCqjfAliiiYWY/ik5q+ekFTT0meUY9G8wm/tEZVAgNMXvBuCEwNMAgtfJAxHie2
         EGgnxaF/Rf9dfOu/ekn4Ti6ebZ60qnW41YJi0v+TAKUTA/HcKeyBrbVqw7CoOc/kNMv6
         hZgg==
X-Gm-Message-State: AOAM531mY0fpVBfj7mPZ783yrfALQj7haW5SQfB0a01gGwaEPjUfwapc
        eK00lvafzdHsPMjnlvWiWuOQhpaumFgIkmifUPMiuTknj6to6Metu0vQyhAlhXidS+52hUB+3Px
        qYV+p6ajhz5yBihc587+W1l1p0alu8KI5Ml7gNMmeeac=
X-Received: by 2002:a25:bb93:: with SMTP id y19mr2225675ybg.498.1611012624258;
        Mon, 18 Jan 2021 15:30:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeUupatZsd2q9hbMMRmS7sb9nUieVc9ezV1BoODpHerfi6omV6vjXqrjuYsxMenXUzEnfvtAiahy9ScYQs8d0=
X-Received: by 2002:a25:bb93:: with SMTP id y19mr2225657ybg.498.1611012624054;
 Mon, 18 Jan 2021 15:30:24 -0800 (PST)
MIME-Version: 1.0
References: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
 <20210118085429.3495ee7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210118085429.3495ee7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Tue, 19 Jan 2021 00:30:29 +0100
Message-ID: <CAJ0CqmWJKahSkAnPg3JE_QfmWbvQA5qjEc5=v0svn+4L4yqepg@mail.gmail.com>
Subject: Re: [PATCH wireless-drivers] mt7601u: fix kernel crash unplugging the device
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        matthias_berndt@gmx.de, mozlima@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On Sun, 17 Jan 2021 22:46:01 +0100 Lorenzo Bianconi wrote:
> > Fix the following kernel crash unplugging the usb dongle
> >
> > [...]
> >
> > Fixes: 23377c200b2eb ("mt7601u: fix possible memory leak when the device is disconnected")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> A few words of explanation beyond the stack trace without line info
> would perhaps make the review quicker..
>

Hi Jakub,

right, sorry for that. I will add some more info here so Kalle can add
it to the commit log merging the patch.

"
The following crash log can occur unplugging the usb dongle since,
after the urb poison in mt7601u_free_tx_queue(), usb_submit_urb() will
always fail resulting in a skb kfree while the skb has been already
queued.
Fix the issue enqueuing the skb only if usb_submit_urb() succeed.
"

@Kalle: is it ok or do you prefer to resubmit? (sorry for the noise)

Regards,
Lorenzo




>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>
>

