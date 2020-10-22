Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD202961EA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508483AbgJVPxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504685AbgJVPxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 11:53:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C496C0613CE
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 08:53:13 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j7so2189010oie.12
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Md8Jk5bh4wsnPKEUJYbBUcJk/tz1yk6JnQBHHVfPL5Q=;
        b=KU5K33HWhRrLremf0cTs3WbiJeMOEDtATmXiwf+4KuamrZvPPlHUq5aVpEApPwziNB
         koZCIymEZ7D538x6+0qfyRkPIl7WzhSkF8++KSGHBycchKMAk+CuZ13B82sl5NHtLLrq
         ySmWVNuSkt6W7P+Mct1qLSRv77vvEvULH4YPP4GnEfdLqtDcMOknPVh41VFVbo0TwQGJ
         kbB136lsXDVDa03xgxe4e1lmaxN6VkNkWVd2UgnAvJk7aMNYofrMDjXsrsUuyrbNImuE
         Ge4anA50jGo8G6/am5ZvOUm70Bnjb0lLbP8LvmV252CcGAHWhzy/cp5R0SE7jNUfURJG
         C1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Md8Jk5bh4wsnPKEUJYbBUcJk/tz1yk6JnQBHHVfPL5Q=;
        b=XRnbHLnJ8YWrmnyvNwrfRzDTyGE/Q9ES8GwPT9KvEuPcB4++2ekJc/8NrUeo1Ou4Cv
         qDyA1m9G9yFTK/N503GoWCOV+tSowYvRLwOukQmT/vChSXofDmZLc/6cocuAms5ZpaFg
         GlhBR19+EHbXO1r6WTX/dnvvFZWUu55lM9HOli54LCTKCQwiKQ1+1zPRVRimD8shD/uj
         2Z6rjF+JqNnaZKGhdara+tz1OkJXz1BCuIF3dHGO8FKIh72w1flRK9NLyZbzutfbZLQ4
         cizrjsXqwLNimw/ybx5qZsu3F9sLQwW3zv4qxzDb1vk2nMEOy5e/L4oAUIAlvFIhnnei
         rQnQ==
X-Gm-Message-State: AOAM532kDeknYC/xEE9Rty7a3Msxn+pteDvSEyTzcmvdPmHc6OnBtYMR
        PCnFx6CI8Qqw6clEKI8vKes=
X-Google-Smtp-Source: ABdhPJxQfbC1M2EGe3txVtUzc43pN5sftMUWYMxOCwiv6mw971qUMO+Uy28nGmgroyS7WIEUzCm4mg==
X-Received: by 2002:aca:48c4:: with SMTP id v187mr2016205oia.71.1603381993060;
        Thu, 22 Oct 2020 08:53:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id j21sm496149otq.18.2020.10.22.08.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 08:53:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     David Rubio <david.alejandro.rubio@gmail.com>,
        Andy Huang <tehuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com>
 <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
 <87h7qrq4p5.fsf@tynnyri.adurom.net>
 <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
 <87a6we7qna.fsf@codeaurora.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <fae0b720-bc94-b380-baa0-08a3286fb2cf@lwfinger.net>
Date:   Thu, 22 Oct 2020 10:53:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <87a6we7qna.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/22/20 12:53 AM, Kalle Valo wrote:
> Ok, I will drop the patch then. But it would be really nice to enable
> even some level of support for rfe 2, can't we find some solution? Like
> disabling 2.4 GHz band for that rfe or something?

The E-mail from Realtek 
(https://marc.info/?l=linux-wireless&m=160255510004938&w=2) says that the 
patches are ready; however, they need to do some "verification". To me (without 
proof), that implies a regulatory problem, and it is better that we not enable 
rfe 2 without the official patches.

I hope those patches will be forthcoming very soon.

Larry
