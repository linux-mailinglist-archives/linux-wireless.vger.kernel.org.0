Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63341299B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhITXyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 19:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbhITXwh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 19:52:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A790C0612AC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 10:49:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so32085672wrb.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r41nUBvKpkJxALuDsSht5cDHusBvKgwOyaR4x+2DMgk=;
        b=iyB/2X7yJfWIFS6XVAnqdqZhkFcPgv6vBRc+GT3A4dmZVQnfeYIsEWES2ZF7/GmCtq
         wvWHujM9Ecega9rmx/OPdbmcj1wRc7maTxpvNF5qFyaRlU38GW2u0MBnQkwP754hB6tg
         YWRGUB14hzCbdjsXloejwAoNUHvJ3AYRvrOFRHLvDLSJWpIVo7BCS055/QKgJYh5mhqm
         C9LTUGu5/Th60rLt0BKNjClGKDxIjAjJNhAUOUIK9Zd4VV9coSAtD8td3Sh5kHewNVbW
         95xtPX/0OMbC4v7oua5Bxjy3LGd5uu5uv89KWaOhXPTx58a1B7p7TmJuUOO5HC1f4wnb
         KUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r41nUBvKpkJxALuDsSht5cDHusBvKgwOyaR4x+2DMgk=;
        b=KuHE+oL3oScSZT9vGoxAP5IAJ2h/55CLLHmb0X7r2DKn1KGnYf7v666lCbmhMpCU4Y
         0dSig0pPi5UuO0itUiMFykrevkc7/y2Fqpry1vBGiAlP4m2gsnm7DzvLpcuLQek4ly+6
         AD3DsOOjcBhZktxZhVe2at0Ma29KMtQKw9PSaOvsq+YqLgMS2FZ45iD9UMdwO56zR/MY
         7Ull/xN7F0a261+P2lAdGv+d1rIve9iRv9VY2tnEfZjhuqdeLW7/1QYqrHh4qTZvHUCt
         gKO0WSTb2AVzgnGqaupye1xxVZ5tUxKHeHMbuGNheWCRQ/0FbF8V5rYxBsECIDaell8D
         SgGA==
X-Gm-Message-State: AOAM532DyUCspAWSQGW5ipPfDQXNmqxTU2iZrECIfdrKY1i+VfCWM7bu
        zS45Ab4IzVcJ23sTw+qHNBq4Uudp6Fs=
X-Google-Smtp-Source: ABdhPJwZEEhMC7DuwNUjtHn6hH16Soch/kXoQUBc3TnLXJNO8VabS2z00UXA+CIPW7eXwwe8P7eoQw==
X-Received: by 2002:a1c:7713:: with SMTP id t19mr287551wmi.162.1632160157208;
        Mon, 20 Sep 2021 10:49:17 -0700 (PDT)
Received: from agape.jhs ([5.171.72.213])
        by smtp.gmail.com with ESMTPSA id s14sm16452921wrp.84.2021.09.20.10.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:49:16 -0700 (PDT)
Date:   Mon, 20 Sep 2021 19:49:14 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: rtl8723bs: remove possible deadlock when
 disconnect (v2)
Message-ID: <20210920174912.GA1400@agape.jhs>
References: <20210920145502.155454-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920145502.155454-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Hans,

On Mon, Sep 20, 2021 at 04:55:00PM +0200, Hans de Goede wrote:
> From: Fabio Aiuto <fabioaiuto83@gmail.com>
> 
> when turning off a connection, lockdep complains with the
> following warning (a modprobe has been done but the same
> happens with a disconnection from NetworkManager,
> it's enough to trigger a cfg80211_disconnect call):
> 
> [  682.855867] ======================================================
> [  682.855877] WARNING: possible circular locking dependency detected
> [  682.855887] 5.14.0-rc6+ #16 Tainted: G         C OE
> [  682.855898] ------------------------------------------------------
> [  682.855906] modprobe/1770 is trying to acquire lock:
> [  682.855916] ffffb6d000332b00 (&pxmitpriv->lock){+.-.}-{2:2},
> 		at: rtw_free_stainfo+0x52/0x4a0 [r8723bs]
> [  682.856073]
>                but task is already holding lock:
> [  682.856081] ffffb6d0003336a8 (&pstapriv->sta_hash_lock){+.-.}-{2:2},
> 		at: rtw_free_assoc_resources+0x48/0x110 [r8723bs]
> [  682.856207]
>                which lock already depends on the new lock.
> 
> [  682.856215]
>                the existing dependency chain (in reverse order) is:
<snip>

thank you for working on this, at a first look
the patch series looks good.

I will test it tomorrow.

Thank you,

fabio
