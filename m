Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53928C72E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 04:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgJMChP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 22:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgJMChP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 22:37:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A65C0613D0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Oct 2020 19:37:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id q136so19720202oic.8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Oct 2020 19:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hnZm7+NemRtc523oCSv+oQAlf0UUwC+LPXX6CC6LNis=;
        b=XLf/2d0bX5huGhtnm7jZyIdUggPSJzA9c5gJgAKmFza/9xjcvyWx671p4bILAn7cIg
         onb5qme3MK/3U1k2+69UUkRlnR7hCdsnpKcKUpAANpxMQS283uwCiJb1vYgdgqYVeyWZ
         staOptfKo14K28uglxdJVGCqKqwnI2rAeQ9dalMHoe0diWKc2dRDVR6/EZ8MvOD7m2Rj
         HaGBxZG8CkBfE0bPto/Vdma/RQgxg3JwokmRPwC2atcwGiH5436e4w1/eYfy2qh/9tON
         C/IaOwHF0b9JTs22qIexjjLxhqQH8yyPY/qHkAwerQOThf1lbQcATCQPUjuwnzvSW29b
         pESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hnZm7+NemRtc523oCSv+oQAlf0UUwC+LPXX6CC6LNis=;
        b=stx3zVmAHDV513Dz86Vg79o1cx0JeeXh6YZQTAQ22bSCY8qxLspipZfeQcg9QyrKA8
         Muj7yo0yV2415AtRKfGiNWUwD2CcKm5pxgl87cxCh8NWqgHtnZDzevzjsOvFRQ+qFLAb
         1hVyQ9So9v1YmeJTVkHBkoAZCSibUg3kcW57MQajzS8rBAJua9n9CxUu5JwrTdn0+NrS
         iP90N0c5yqM8tAUXhUvYel0T4sHTtQNKOV8QHtGPzbJpMaBkxr6GBHSHdwLPZtK6CuHz
         EXYXWtDVMyH97FiaYh6KFBcXA6geTCEz2O9QWlBVTd4T6RIEVMf0diaRfXJvmq1dwLEY
         LKPg==
X-Gm-Message-State: AOAM533Wk3+rr7zDAjs5mSee1BQAApgPDNjvJ/u9HG0tXperPNAomg94
        5bnduN9Ym1DV20ZphGZr2Cg=
X-Google-Smtp-Source: ABdhPJxJ9HOsFXEr0JMGFS74hZN0yR198o4h4vIymdsxFiOYf7wRFDLIVDaYE5uaBXUsJocjbqzHuA==
X-Received: by 2002:aca:5047:: with SMTP id e68mr11904844oib.175.1602556634400;
        Mon, 12 Oct 2020 19:37:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l109sm9486653otc.10.2020.10.12.19.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 19:37:13 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Andy Huang <tehuang@realtek.com>,
        'Brian Norris' <briannorris@chromium.org>,
        David Rubio <david.alejandro.rubio@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
Date:   Mon, 12 Oct 2020 21:37:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <362f154dff1b4d6f88503af813eae406@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/20 9:11 PM, Andy Huang wrote:
> The support for RFE type 2 of 8821ce, the patches are ready, but we need to do some verifications. After the verification it will be upload.
> 
> Tzu-En
> 
> -----Original Message-----
> From: Brian Norris <briannorris@chromium.org>
> Sent: Tuesday, October 13, 2020 2:13 AM
> To: David Rubio <david.alejandro.rubio@gmail.com>
> Cc: linux-wireless <linux-wireless@vger.kernel.org>; Yan-Hsuan Chuang <tony0620emma@gmail.com>; Kai-Heng Feng <kai.heng.feng@canonical.com>
> Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
> 
> On Sun, Oct 11, 2020 at 9:13 AM David Rubio <david.alejandro.rubio@gmail.com> wrote:
>> Oct 11 12:20:39 youmu kernel: rtw_8821ce 0000:02:00.0: rfe 2 isn't
>> supported
> 
> I'm not sure anything changed since the last time this came up:
> 
> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82@realtek.com/
> 
> I think this needs somebody from Realtek to look, or else ignore the objections and merge the sub-optimal (trivial) patch. I'm not sure of the ramifications of doing the latter.
> 

Once the patches are uploaded, I will merge them with rtw88 at GitHub.

Larry

