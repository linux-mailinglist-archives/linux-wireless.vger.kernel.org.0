Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E205F35720A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbhDGQS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDGQS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 12:18:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92435C061756
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 09:18:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t22so6294115pgu.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Apr 2021 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i4I5dtBIlPg4tLUu7MrbY6e8JWEuxRneUypscy5Rvhs=;
        b=tKUEJxP7prEW1SfeeTyF/6GnPYSZ2yYGi6g+3Ol8+zjiuQCCAucEUJRSK9SK5j2+Ks
         EF7gVWxDD3ZwlC1esvKXNWQVUrfKcjfBDjQyNlypgA8WgzYcniMFGVnDDDE/XAVQPBpJ
         Q8q7VVOFtKvIKgyCguNENHt5xVCJgFrWzUjaD2OimxwylwjzPIxIpGR320cmwRb/kUO7
         oaOo5dtj7uPM4tSreIZ32ZfZ6JY+hn9aAqgrXMPXN0zey/f+4X10vV4K8+ZSZA3gy+lp
         5Jti8x0FONCuEDqPvtFITPvPBqaCUE/0S7bPUslkKMKEWwOv3s3Kfrgvc6rXcu1YvXz9
         ZDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i4I5dtBIlPg4tLUu7MrbY6e8JWEuxRneUypscy5Rvhs=;
        b=o11o2MZ03isRwbmWXSh6388qGYzOzSKBtWtewE4wXQM48LSOlXS+mBp4Sij86x9AvU
         VsNPcAMo6qXIMKq06ytNSJHJUrnoszZi108huO2Siaa/OUuG9gI1BXfGCLTK15PLJXX4
         skkvEDwUw/IH2oyEJ0DxwZ6rLTAJFNGdt1rf3zm8J+ETBEQhXMo8dizJ/A/lUVE8N+7y
         KOVCG3iWSYmP1iGn9rO807mGyHTj38P31YnAB6qvsoIfK6T/jT//5yg2L1DJjdKUzn88
         /NPV8ky9Lhxbjq/Rbqjv4EAjWrOKs70LPSXS55+kEY5VT7QsprpQ6km9WZWxtnnFBhPS
         LcMg==
X-Gm-Message-State: AOAM532A46AXlFrfBrU6eLkTLetpicAe2tqc6pvdhRY07y5R0d1poABu
        6KYUY01FPyPsBNLEdd25X855ZQHX3M0sdy0i
X-Google-Smtp-Source: ABdhPJwctVhNiWOKtQG9PSpvpT0P0p8+OvtHh7X3qYBPq4WuV7boVQ3SKrcy0jKbo0FnKU3r4M2++Q==
X-Received: by 2002:a63:531b:: with SMTP id h27mr3982846pgb.395.1617812325151;
        Wed, 07 Apr 2021 09:18:45 -0700 (PDT)
Received: from carbon ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id q66sm6086576pja.27.2021.04.07.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:18:44 -0700 (PDT)
Date:   Thu, 8 Apr 2021 00:18:40 +0800
From:   Du Cheng <ducheng2@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: wireless: convert WARN_ON() to pr_warn() in
 cfg80211_sme_connect
Message-ID: <YG3bYPSB7Guv/KEe@carbon>
References: <20210407021903.384158-1-ducheng2@gmail.com>
 <YG1JDsaRpws1FkzI@kroah.com>
 <YG3UGW+rLM52/t2V@carbon>
 <043656c28804db4f8c3dfc9eae5a599ac3a357c7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <043656c28804db4f8c3dfc9eae5a599ac3a357c7.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Le Wed, Apr 07, 2021 at 05:51:05PM +0200, Johannes Berg a écrit :
> Hi,
> 
> > I have spent some time to understand the netlink subsystem as a IPC mechanism.
> > What I have now is a reliable sequence of steps to reproduce the crash, by
> > condensing the syzkaller C reproducer:
> > [link to reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1414c997900000]
> > 
> > * hwsim80211_create_device (sendmsg: HWSIM_CMD_NEW_RADIO)
> > * nl80211_set_interface (sendmsg: NL80211_CMD_SET_INTERFACE)
> > * set_interface_state (ioctl: SIOCSIFFLAGS)
> > * nl80211_join_ibss (sendmsg: NL80211_CMD_JOIN_IBSS)
> > * sendmsg: NL80211_CMD_SET_INTERFACE
> > * 1st sendmsg: NL80211_CMD_CONNECT
> > * 2nd sendmsg: NL80211_CMD_CONNECT <- this triggers the WARN_ON(wdev->conn)
> > * (if kernel not panic yet) more sendmsg: NL80211_CMD_CONNECT ...
> > 
> > If the code skips WARN_ON() and instead returns -EINPROGRESS, user application
> > will receive error from the following recv(sock, ...). User application can hence
> > choose to handle this error accordingly while kernel soldiers on without panicking.
> > 
> > If dev_warn() is added, for every subsequent NL80211_CMD_CONNECT, the console is
> > flooded with the printout.
> > 
> > Maybe it is ok to silently return -EINPROGRESS for the 2nd NL80211_CMD_CONNECT
> > and beyond.
> > 
> 
> Yeah, I think the right thing to do is to just drop the WARN_ON
> entirely. In fact, I can't really seem to figure out now why it was
> added there (even if I probably did that myself), nothing else seems to
> prevent getting to this code path multiple times directly one after
> another.
> 
> johannes
> 
Hi Johannes,

Thanks for your input! I will send a v2 that drops the WARN_ON().

Regards,
Du Cheng
