Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1328160C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgJBPG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbgJBPG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 11:06:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94CC0613D0
        for <linux-wireless@vger.kernel.org>; Fri,  2 Oct 2020 08:06:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j16so98829oij.4
        for <linux-wireless@vger.kernel.org>; Fri, 02 Oct 2020 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rsRczXaryCfx7sLjXs2dcAlLbhPtvdFL4s4bTJc5az4=;
        b=hzkVDmI/9EeO82t7wiFXyFcSAWfqicKQplxGyHomcZavwLBwh2TmNeHUHfGfDqZSfb
         unEljH85+GUh2ejjabmCU9zUn9LxXkTqlZRQTv6mk/gYB0KX4GCrZOP7nEar5pDt0p6y
         THzBtoZGGvo0vCWbSKBqDQniRZ5R2Ox7U74YQjnKuGrzsxsNaKNxJM8sKu+T1CpclIFI
         bdVKjlwie9ihqcZq7tQ3tm9XZLrAKclct13m+r8txlspfRTfpwG4U0Bh1zy6UguRHSUe
         rVlDNg27sWBvwLVskAMJjFUfsBv8a7MTlpaEgwvj+dnaaVeal3ANy7kP969WV/VJPPj8
         PbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsRczXaryCfx7sLjXs2dcAlLbhPtvdFL4s4bTJc5az4=;
        b=XXPzClTCRtfeJ/idq/h0SM4r9rlAJD4sZICuukr+Ppib5Z41kI/5OQze72oGZJRKqy
         IiclNAv35samuVwMr6241JK+GdEKSVLNdhzK2iq113+mxhdY770SidjuolQbaCUZTp5r
         e9aSDNH+tJd+rU9jU3QuMtviyPmKNn2jSWC0nijBjOeXNsfu/slRtLVNacBgzKHr1ihE
         nnBu5gXy4GPFj7EljxLrbwBcWnT5AO7cuykEGfXOmgRGr3o7y/PbVgUatdtKOlX6NmL0
         jRPpJVBEdq3QcRdFjpjj3/5BA5OmEYsKj6wfjQVpiE8dtDlxJ3+56c/tszbySnpg8TNo
         LI0Q==
X-Gm-Message-State: AOAM533u8Dgs4m3gs3cHjFa7d/pZiIj1OK5mGWFdHr7DugBSmQLRuawe
        V8lw7O3xbELSpKZ1qKvXvJaOztwOmE8=
X-Google-Smtp-Source: ABdhPJzoKSCP2X6uEOl1LS6mE93d2sRCWgiPwXIcGEzYNPKa9+T1mczE67ZsJarTb52LkkJxx43V7w==
X-Received: by 2002:aca:a815:: with SMTP id r21mr1461657oie.79.1601651187027;
        Fri, 02 Oct 2020 08:06:27 -0700 (PDT)
Received: from ?IPv6:2605:6000:1025:4ecf::1e3f? ([2605:6000:1025:4ecf::1e3f])
        by smtp.googlemail.com with ESMTPSA id f2sm298113ots.64.2020.10.02.08.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 08:06:26 -0700 (PDT)
Subject: Re: [RFCv3 3/3] nl80211: Send large new_wiphy events
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190906154303.9303-1-denkenz@gmail.com>
 <20190906154303.9303-3-denkenz@gmail.com>
 <127c19b1855302a467a1bdbf2f25f625a0254d9e.camel@sipsolutions.net>
 <f48bdad3-f9f8-20b7-b6ff-6248368a7ae1@gmail.com>
 <0b12af1b27954f62a5ce715f95176d1f0ff393a3.camel@sipsolutions.net>
 <d97f7b4b-6508-4773-b13d-dab052349f47@gmail.com>
 <bfeef8bd4711a954e2f4c399a09855ad7d97371c.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <e35703cc-6e09-e79d-17f1-2fd490edb83b@gmail.com>
Date:   Fri, 2 Oct 2020 09:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <bfeef8bd4711a954e2f4c399a09855ad7d97371c.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 9/28/20 6:14 AM, Johannes Berg wrote:
> 
>> Ah, now I see what you want.  Sure I will take care of this in v4.
> 
> I just remembered this because of Martin Willi's patch, and see now that
> I actually just did the first patch of this series again while looking
> into it ...
> 
> Did you ever make a v4 of this?

No. Got distracted by other work and never revisited this.

Regards,
-Denis
