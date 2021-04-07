Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AED3570D6
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353810AbhDGPsE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353783AbhDGPry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 11:47:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9417C06175F
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 08:47:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso1514503pji.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Apr 2021 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yDw8Cbu47cF9tNX/RK1aYzLqwXsoHXfnW9fgbup4o48=;
        b=cAkARtYo8vZy+06yEzcGbFQrkUiHQG8tXfrWfsHIrc5HldQvVA6LPYPYCdDqpOxQHQ
         I9ykS1KZzQ1sgsuZ5qaPVcmTx3CULHmAGz0S/DhZFrF9MmdRHX51TctR5adF6YhuPqgI
         IuCO5/eV1k4i0FXACl+aRJ8Jog3sNBHxMqd7DfzBgGcbiPEJtVVuAHEK7NlQz3PFGjQm
         JMyvoxn46zHC434aayPNbfdgnsHTMp4NMB8sj9+Hc3PqPaJ+bQyOo8OCLWALbjGycph1
         37Nn3esc17v/dwKi87TbV+VhMIXT/GRcaCsqqzYHT+KsP/D+yMDIZDxfbjycuKohkuUa
         +UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yDw8Cbu47cF9tNX/RK1aYzLqwXsoHXfnW9fgbup4o48=;
        b=sa3XUm2Jf/1KbxkiGx+LEkG0z0mU7RD6CCfX97vQwn2RJU6Mp25rPIoWEFciTY7Bie
         q58UsgIgv703IXOFfCyBPzNMdfYcJUSKcNpq41GE/LqsdCzcshbVwW0cJQ0UrPsQ2t+f
         tvYazwwsfoYIBm2M+mlIQ13COF6+8P8JrHn+c/Cj4qYBgKMEnbf7sb+zhpoVzczRpsmE
         MMzarhJq2wyvTJwiC4yulb0Wo040Z8gUoyPWclnGIW3t6674csykeH3G5KHT80bUiW8k
         khRfDsBOI8AHF0Jbbni/fEtXkIRKyR++zBBhz1k+eEYL6wGSQ/R8rzvCcykvmEo9S2H3
         dgfw==
X-Gm-Message-State: AOAM532Kin3k7jHanhLjHqNM0t9O7UA5comocX/KNojOamjFznMDlsVf
        E18DjgJGMhFLUvpLFFTPqljbfkX8fivvxZZa
X-Google-Smtp-Source: ABdhPJzBgXXW3rA3l9tojzLirynERC8Zh8hKLIVZigC6+E80ofcbqXwSc58Bga3HaOuwmCdYTcxejw==
X-Received: by 2002:a17:90b:1483:: with SMTP id js3mr4054872pjb.86.1617810462240;
        Wed, 07 Apr 2021 08:47:42 -0700 (PDT)
Received: from carbon ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id y5sm21621801pfl.191.2021.04.07.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:47:41 -0700 (PDT)
Date:   Wed, 7 Apr 2021 23:47:37 +0800
From:   Du Cheng <ducheng2@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: wireless: convert WARN_ON() to pr_warn() in
 cfg80211_sme_connect
Message-ID: <YG3UGW+rLM52/t2V@carbon>
References: <20210407021903.384158-1-ducheng2@gmail.com>
 <YG1JDsaRpws1FkzI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG1JDsaRpws1FkzI@kroah.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Le Wed, Apr 07, 2021 at 07:54:22AM +0200, Greg Kroah-Hartman a écrit :
> On Wed, Apr 07, 2021 at 10:19:03AM +0800, Du Cheng wrote:
> > A WARN_ON(wdev->conn) would trigger in cfg80211_sme_connect(), if
> > multiple send_msg() system calls are made from the userland, which
> > should be anticipated and handled by the wireless driver. Convert this
> > WARN() to pr_warn to prevent a kernel panic if kernel is configured to
> > "panic on warn".
> > 
> > Bug reported by syzbot.
> > 
> > Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
> > Signed-off-by: Du Cheng <ducheng2@gmail.com>
> > ---
> > link to syzkaller:
> > https://syzkaller.appspot.com/bug?extid=5f9392825de654244975
> > this patch has passed syzbot test.
> >  net/wireless/sme.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> > index 07756ca5e3b5..87a65a4c40ae 100644
> > --- a/net/wireless/sme.c
> > +++ b/net/wireless/sme.c
> > @@ -529,8 +529,10 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
> >  		cfg80211_sme_free(wdev);
> >  	}
> >  
> > -	if (WARN_ON(wdev->conn))
> > +	if (wdev->conn) {
> > +		pr_warn("%s: wdev->conn != NULL, sme connect in progress", __func__);
> 

Hi Greg,

Thanks for the reply.

> You have a real device, please always use 'dev_warn() for stuff like
> this, or the netdev equivalent.  Also no need for __func__ for stuff
> like this, that's just clutter.

If the warning is indeed useful here, I will change the line to dev_warn(),
however I am not sure if it is a good idea to even generate warning output as
the kernel is well able to handle this special case from the userland.
> 
> Also, what can a user do if they get this information?  What does it
> mean to them?  Try making the text more informative.
> 
> thanks,

I have spent some time to understand the netlink subsystem as a IPC mechanism.
What I have now is a reliable sequence of steps to reproduce the crash, by
condensing the syzkaller C reproducer:
[link to reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1414c997900000]

* hwsim80211_create_device (sendmsg: HWSIM_CMD_NEW_RADIO)
* nl80211_set_interface (sendmsg: NL80211_CMD_SET_INTERFACE)
* set_interface_state (ioctl: SIOCSIFFLAGS)
* nl80211_join_ibss (sendmsg: NL80211_CMD_JOIN_IBSS)
* sendmsg: NL80211_CMD_SET_INTERFACE
* 1st sendmsg: NL80211_CMD_CONNECT
* 2nd sendmsg: NL80211_CMD_CONNECT <- this triggers the WARN_ON(wdev->conn)
* (if kernel not panic yet) more sendmsg: NL80211_CMD_CONNECT ...

If the code skips WARN_ON() and instead returns -EINPROGRESS, user application
will receive error from the following recv(sock, ...). User application can hence
choose to handle this error accordingly while kernel soldiers on without panicking.

If dev_warn() is added, for every subsequent NL80211_CMD_CONNECT, the console is
flooded with the printout.

Maybe it is ok to silently return -EINPROGRESS for the 2nd NL80211_CMD_CONNECT
and beyond.
> 
> greg k-h
