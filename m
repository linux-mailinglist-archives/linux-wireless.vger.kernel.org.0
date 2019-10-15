Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC2D7317
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJOKXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 06:23:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44095 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfJOKXy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 06:23:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so18606578qkk.11
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiFTh2EPuAUilSBW5ORtAUE6MmP+CQvo3ee4BGaXRP8=;
        b=U45dslVBzK6iRCuucnnbxu4+GCuSzO3Ei/0ucSX4K8EjANTVkf+iAPpMN6gwUCsgbo
         WmN2/0o4wBrGPENc7soFUzNydyHN9ikjkH8Sem6xPn5EzKId+TdO5I9lcSoD2pdW7rqe
         z09CkC8vjZLHYFE1wb6DZjaOVNuhScy8HgKqEC03WzclEbfJ3AoJMNBkkiQy0S15jjAT
         WnOSonWmS0HGUY93F0brGMrQfhdIa3cglZn1wh+WCWJmT4MU3g9L5J69YbosFrW6THnv
         l8pdVRF1Z2hXBaDs0xlvyiWKYv0QyvrfYFp2Xh+WBT1t/mnobB13ND8ciCtwT78Y3n5Z
         tjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiFTh2EPuAUilSBW5ORtAUE6MmP+CQvo3ee4BGaXRP8=;
        b=duBEGKi9/gko0z9goZ6/6azgaEfCKJlQFWSCYgsRbfoHvaNPtJvPD/qaXJ2cEZBnnU
         Jt3WANcW6dWpPLPbEFFP88DPLU7fBUPAneugqdNBc0Oki2ffY6swxY/Nz5kxcx6Rulh1
         Qd/5kHMATn3iMr8JpiIYoIX6V30pqi1jaGrQh/2DndGTGUFaqvzGOJljWVtzYMMr3P4Y
         GORs67FhX3vU8RK4cguXeZdJFnpiX1S9Zj3yU1M7m9AgpnT2fVl8Df7Kp5kuN078Yj/R
         fuSNVJ/dUzVfLXKEnFyS8pOUDqVG4dbdfGmWJTe0pHOFOXDnnG4v/CZ7bRHsa8/4SWdk
         38Kg==
X-Gm-Message-State: APjAAAWq7LKs+vMDlEgwRbsd5pUfID50qT9H+Ov+g5BtBGlnTsSE8Zb3
        gjY016da14nFKkNRFT8RkU8g9PlUJLFQ3mC4RW5g0w==
X-Google-Smtp-Source: APXvYqzGTN80R3a4qRjY873LTjorS2tyON7Y6AGjgssje3QxI7bcUcplUcJW2iGLhsDqXnHFEVIKcGyQzcQzDeMU+j4=
X-Received: by 2002:a37:5f46:: with SMTP id t67mr33208312qkb.220.1571135032293;
 Tue, 15 Oct 2019 03:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191015101608.4566-1-chiu@endlessm.com>
In-Reply-To: <20191015101608.4566-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 15 Oct 2019 18:23:41 +0800
Message-ID: <CAB4CAwecqN5G348+OW0k=h_QaKahTo_Mb9E+pFCP=GjTLJjpMA@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: fix connection failure issue after warm reboot
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 15, 2019 at 6:16 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> ---
> 2.23.0
>
Please ignore this message since it's not properly titled and no
detail description.
Sorry for inconvenience.

Chris
