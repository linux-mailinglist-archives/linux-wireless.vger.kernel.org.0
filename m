Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6919D99E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbgDCO7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 10:59:16 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34544 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403795AbgDCO7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 10:59:16 -0400
Received: by mail-qv1-f65.google.com with SMTP id s18so3722122qvn.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S+tGP5HEQU+qdgYRujb6LZCoHXaMk8z2+FPqvaZ7ufM=;
        b=pHwCviw2g0zcFIO3GAUTv0QsB/UPupClsmBvfFWkcQlKMTl86J22suGPKY6KlQB0eO
         5IOPEnF5ZnY+NcFuZroTS/NLgLGDSrWFTFtosufmHaFEEfVH2mfH0o13I/Yj5IHA1qsN
         WsnmCaZhgRbT3/yR4cWNdJCEr73Ni4svJgrlQhpfl1Pke/k6LoHS26QjpeohPCiDv8RE
         huMt5qWTq+XokczmpAOFOJfUI4MqcATClrlP0kUBb8tD+uN8jkfA1Gxym76ilLzJXCFu
         zFKBX1+w1SQzWPk9eR8cosNLH6E19F2rswGrtTfMpZ9qs2a+A6sNcfIlzKC9iCHy99nn
         sRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=S+tGP5HEQU+qdgYRujb6LZCoHXaMk8z2+FPqvaZ7ufM=;
        b=pf1+juw3bvHSDRLNgm86muNP/JVKNRwZXn9wA+4zwz+brHqhYVdWTz1WeQo1S55g7N
         asAkTynzVSht8S/FShbU51OWKPj/HM9Jn2m4AXUUoSK4myRUoM8W/FK0VFcSK+zvgwqb
         vTUedI6Pc+C2YQyHhzRpUX1jSJPGtT4uJYKyceA92pIlNpCQi8jkl9/OuamqvZD0/6on
         8DdLyLLhjSwwkUfdm61Th09zFGnXy4kZ2epw/Nq6aWzTCzt1h+001StnDOvI442/ICHA
         jKzafY8K0e3vUtpvn0R4Lncw6x4rVSmABNFE+VbpLS74Jk0byPgnh9Bt7UaxhsY3SdBH
         2GJQ==
X-Gm-Message-State: AGi0PuZTtBFJd1wNI9kibJrGo68h0xdnKhVquK0ZW9aSwaQye73/spWm
        69f4QUJIUjIocEsh21RIoE0=
X-Google-Smtp-Source: APiQypJkW3rxqDtCh/5h9bF9x7CMI25YPnxXOgp9KAfPiQZvncGoyDh87JICDWImdY+1vEUNM01ZlA==
X-Received: by 2002:ad4:47cd:: with SMTP id p13mr8877036qvw.123.1585925955438;
        Fri, 03 Apr 2020 07:59:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id r34sm6759229qtk.89.2020.04.03.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:59:14 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:59:13 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
Message-ID: <20200403145913.GD162390@mtj.duckdns.org>
References: <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
 <20200324182358.GD162390@mtj.duckdns.org>
 <02b42d9f-7ba3-bb7e-36a6-5e141d37d75d@cypress.com>
 <20200325140814.GI162390@mtj.duckdns.org>
 <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <c1192351-6f72-6f82-bb2b-9f91266d8aab@cypress.com>
 <20200325151234.GL162390@mtj.duckdns.org>
 <342a1c26-16e6-d824-e421-5f4785f905b8@cypress.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <342a1c26-16e6-d824-e421-5f4785f905b8@cypress.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 27, 2020 at 05:14:29PM +0800, Wright Feng wrote:
> 
> 
> Tejun Heo 於 3/25/2020 11:12 PM 寫道:
> > Hello,
> > 
> > On Wed, Mar 25, 2020 at 11:06:33PM +0800, Wright Feng wrote:
> > > I was trying do that, but the comment of alloc_oredered_workqueue shows that
> > > only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful, so...
> > > 
> > > I will measure the throughput with "alloc_ordered_workqueue(NAME,
> > > WQ_HIGHPRI, ...)" to see if WQ_HIGHPRI works with alloc_ordered_workqueue.
> > > Thanks for the suggestion.
> > > 
> > > ---
> > > /**
> > >   * alloc_ordered_workqueue - allocate an ordered workqueue
> > >   * @fmt: printf format for the name of the workqueue
> > >   * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
> > >   * @args...: args for @fmt
> > 
> > Yeah, I think the comment is outdated. If it doesn't work as expected, please
> > let me know.
> > 
> It works as expected. With alloc_oredered_workqueue(..., WQ_HIGHPRI, ...),
> the nice value is -20 and throughput result with 43455(11ac) on 1 core 1.6
> Ghz platform is
> Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
> With    WQ_HIGHPRI TX/RX: 293/321 (mbps)

Will update the comment. Thanks.

-- 
tejun
