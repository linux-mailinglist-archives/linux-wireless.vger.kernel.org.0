Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB62192BF2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 16:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCYPMi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 11:12:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39497 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYPMi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 11:12:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id b62so2884188qkf.6
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LfshdQ//MCk6Yzdu7QZwqgCkOwmbPXFn6X37Z0DjJ4E=;
        b=Ixl+sDr5f3IjRgbMzC85OxPpcaJWDVq1WxcDVIYGhGIfT3ZHWtp8xgI4D1R3V+QUjK
         6ZVeB4uZ4zWeVhnNab5tOdakJAXRv9KytV6eB0bZ1QOViMEevzhJJ9C3tOhOdI3gYfQU
         rtsEcEePs6ccUUgqSPtU6hNwX78CruU8s0fQEnwexsp6QfdeR2TF64FQxT7H+I0EGiNx
         jM2FUoMiRHVrlJ7cfTSmFxwAYpPp3JcfRhNr4UCL1uKMxKGSgngN4eY6cb9I8F45IvGE
         l1PpGChq66D6AELGlN7WmJ7QKAMRXzXw6diKpuWsMfCHE/j9e0I+4m1UM1Pr+cQ5L06I
         dOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LfshdQ//MCk6Yzdu7QZwqgCkOwmbPXFn6X37Z0DjJ4E=;
        b=VlpUIS/0Y/g+RmC7DfQmW1rLkkti4VbwaZbBPYILzWUf3q3uMq6a4eXmr/yugd4lJo
         nyRVw5V6a/iDqnligfbpFGdn3BsQVgRsCecOrFYv4hldYkxlxwo0Y69mTsREtPuWfWcZ
         Z7YssuIATkaPZHmipZwy0NXddHM8ccBR0hqBYVjsham73iyaIxRSWAvmJjz8uv+dcsqd
         MHwiO64CDXbmeDC913OUcYBW8W+AygsbTyzwDTrlTjprsvKuHl/SVWrGHw7u/5rbSJeA
         BicTAbmz9DZN0DJ4nKbY9wGUk6nxm2o++hsDwCJmDTjmZifDpzXOrheda0Bie35NB7jf
         B0xg==
X-Gm-Message-State: ANhLgQ3wkis0ZIVLnuHqqr3JfdUc997Q3wjTBBVbCH12CLaDDCmDqB0k
        HHz4qsShqMhZK5IPaLaGyzQ=
X-Google-Smtp-Source: ADFU+vvTkkwo3ybpz/6gpmBPqeONsyV/fmBf0vMcSF3HtEFhuCmee1/07dC9AJYi+RzKKmz33IE2jA==
X-Received: by 2002:a37:a183:: with SMTP id k125mr3222897qke.335.1585149157385;
        Wed, 25 Mar 2020 08:12:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8d4])
        by smtp.gmail.com with ESMTPSA id m92sm16838071qtd.94.2020.03.25.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:12:35 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:12:34 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
Message-ID: <20200325151234.GL162390@mtj.duckdns.org>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
 <20200324182358.GD162390@mtj.duckdns.org>
 <02b42d9f-7ba3-bb7e-36a6-5e141d37d75d@cypress.com>
 <20200325140814.GI162390@mtj.duckdns.org>
 <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <c1192351-6f72-6f82-bb2b-9f91266d8aab@cypress.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1192351-6f72-6f82-bb2b-9f91266d8aab@cypress.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

On Wed, Mar 25, 2020 at 11:06:33PM +0800, Wright Feng wrote:
> I was trying do that, but the comment of alloc_oredered_workqueue shows that
> only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful, so...
> 
> I will measure the throughput with "alloc_ordered_workqueue(NAME,
> WQ_HIGHPRI, ...)" to see if WQ_HIGHPRI works with alloc_ordered_workqueue.
> Thanks for the suggestion.
> 
> ---
> /**
>  * alloc_ordered_workqueue - allocate an ordered workqueue
>  * @fmt: printf format for the name of the workqueue
>  * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
>  * @args...: args for @fmt

Yeah, I think the comment is outdated. If it doesn't work as expected, please
let me know.

-- 
tejun
