Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E61B54F8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 08:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgDWGx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 02:53:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWGxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 02:53:25 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jRVjf-0003hu-8l
        for linux-wireless@vger.kernel.org; Thu, 23 Apr 2020 06:53:23 +0000
Received: by mail-pl1-f200.google.com with SMTP id d4so3932870plr.18
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 23:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Brn70UkrdEH9wF8l6cReBO011o8Fv5QqqLg/eGvIrCI=;
        b=f9s2KHQD8at1tAfcr19oJd8bacCxcZPYKtxFITnj+ZRjNgSenzBCaDYKna2pu27E7t
         RqsyTvud9h1x6bQrU/Dlcl1j2ekTh6AN4/zowDK18V+0T3mFyFbtbavd2v4IHTQ6Wr67
         7dhgINKYDQgfXhy5+HkwDHMwawNdUPVcsNjl/aGTAiL6KhoRqhdZ3VZhgUUQCo+HDREd
         Cp2tKX3/xQox6mfydShwSYqusXZb4KjC7RHRVE5iDhelU3UDY+HDPUFjRLt7IUC/ekEt
         tbM8iOWoWdDEY36c6vpHspXyw42kVt9ex2VrEV9MSvb1pdjuK+sGueYE7DCsA3I6ieob
         KyQQ==
X-Gm-Message-State: AGi0PuYgiyYfOjdIwn0EkFzf44o326QVL3LKDpYUsbK3r1Z+Dinl52Pv
        UHIMk9Jcx6hIf2ddpqPH3SOrWY2P9tHAGOETCjgqnmbMNFEEcuWcWYA6/pD1gKW5oOs3E1RoUTJ
        idyjMsusrngMZa0mp3YYHNl+8GKDalkDtHeyYoKWcTFe9
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr2202450plc.209.1587624801891;
        Wed, 22 Apr 2020 23:53:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJjjevu44Y1bDstf34odxPmWbk2i8mHMY4lhgtg04FGkpDdcGX8ckb4H8mS0HyeJuNBf7IfnQ==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr2202437plc.209.1587624801597;
        Wed, 22 Apr 2020 23:53:21 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id n9sm1289198pjt.29.2020.04.22.23.53.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 23:53:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] rtw88: Use udelay instead of usleep in atomic context
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87h7xan1cy.fsf@kamboji.qca.qualcomm.com>
Date:   Thu, 23 Apr 2020 14:53:18 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D2ACB475-AE1A-41D1-BEB9-1FC30DA13AE8@canonical.com>
References: <20200423063811.2636-1-kai.heng.feng@canonical.com>
 <20200423063811.2636-2-kai.heng.feng@canonical.com>
 <87h7xan1cy.fsf@kamboji.qca.qualcomm.com>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Apr 23, 2020, at 14:49, Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> 
>> It's incorrect to use usleep in atomic context.
>> 
>> Switch to a macro which uses udelay instead of usleep to prevent the issue.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> This fixes a regression, right? So there should be a Fixes line.

Yes, but the regression commit isn't in Linus' tree, so the sha1 may change.

Kai-Heng

> 
> Also I can't take this until patch 1 is in my tree. And I don't know who
> takes iopoll.h patches.
> 
> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

