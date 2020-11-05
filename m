Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3450D2A7AF9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 10:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKEJrx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 04:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEJrw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 04:47:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F47AC0613CF;
        Thu,  5 Nov 2020 01:47:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t11so817454edj.13;
        Thu, 05 Nov 2020 01:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g7zM1eeP2rwptjvhJ7BsBBwb50bwWq0IMTLYduyJskk=;
        b=EEYVRrHPBllYaZgmEUEwVjl24vH8Qwk8wgAotlnUgpD4hKTHxoX5mydUgJzIbtHOMn
         1QiD+wff2YVVvRsBILzWmVWkuuP84i3Xng5afGX62WDK8pzjIMSWu4zojqBEdr/7cZas
         yJxyLMsGS3lNh0XMsfKS/SjrfoSsc3v1haDa6R9SbtQV7hfCEJqMY87enBBdr49fF3s3
         xR8/lFTWC8sut/yfhhInKYk58irEnMC0YoaqOV2OFNH7g/i/FqZt01OzbUsLjS2/O8mV
         J5Vyrz8ulRuDLCoPTuOKP7twaUrs7tHEoQtKuxrNn+TB2zN+AWR4W5qJ/lAVPi4tSsZy
         VTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7zM1eeP2rwptjvhJ7BsBBwb50bwWq0IMTLYduyJskk=;
        b=PG+5g9obDXqVh7+HD592jBTKe8h6ivk57ChrzJxmeYJogxwjRbSWJgpbnDp5sMSqOQ
         EhmxOQk8/NNZL1cPfWN7FK6z6EQZk1l8IRJAgBLH22CIgddLiVjfw0wrexVNJywVuKVK
         a1STWVIae2FdEI5QE8V4MfjfhDYMK0MwCEde1orInceKOrXmwM59COCJWS9mqPKqmxo2
         xMYK9DQinpg8XazFJ39yFv23emELlFFc0gv51S372OibDjBnhpmMTgV+LPzB8o72BgF5
         V3urmKMs1wdpsexNuxXaWOoi3bJ+1QBvW2Gbpr60qh8o14pZSZ1rAV7XFH+2oQQgsZsG
         xhXw==
X-Gm-Message-State: AOAM533kx3Gml/dO3bzKYZcAy6UEU/YW3G+NssI1PBcrBEsTi+IJItPZ
        NrfuJ3fZq3Shtp2nZlileL9q704zC9ugfw==
X-Google-Smtp-Source: ABdhPJwuArAx6JAAAismoWXHLH5yq4GWzdVqgvZowjzwfhZr0yCQdlJoN5h323FpY3MVHv7CVjvD1A==
X-Received: by 2002:a05:6402:142c:: with SMTP id c12mr1730494edx.41.1604569671023;
        Thu, 05 Nov 2020 01:47:51 -0800 (PST)
Received: from ?IPv6:2a02:a44f:d2f0:0:7cde:5457:f7ce:ec3c? (2a02-a44f-d2f0-0-7cde-5457-f7ce-ec3c.fixed6.kpn.net. [2a02:a44f:d2f0:0:7cde:5457:f7ce:ec3c])
        by smtp.gmail.com with ESMTPSA id 22sm621952ejw.27.2020.11.05.01.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 01:47:50 -0800 (PST)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     Kalle Valo <kvalo@codeaurora.org>, david@redhat.com
Cc:     ath11k@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <fa22cf0f-3bac-add6-8c71-6f6cad5206d8@gmail.com>
 <87lffjodu7.fsf@codeaurora.org>
 <fa338986-8de4-fde1-6805-d46793c947e4@gmail.com>
 <c9cc0ec6-4dda-2608-3575-0e6dfb6d0852@gmail.com>
 <87ft5rszcs.fsf@codeaurora.org> <87ft5qsem9.fsf@codeaurora.org>
 <f99862f4-9b3a-03e5-cd26-1de6136f9e46@gmail.com>
 <87blgdscxd.fsf@codeaurora.org>
 <229c31e7-9aff-18e6-a6db-be7b46331173@gmail.com>
 <87361onphy.fsf_-_@codeaurora.org>
From:   Pavel Procopiuc <pavel.procopiuc@gmail.com>
Message-ID: <b9312d0b-1219-edda-0333-debb8e7b32e7@gmail.com>
Date:   Thu, 5 Nov 2020 10:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87361onphy.fsf_-_@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Op 05.11.2020 om 10:04 schreef Kalle Valo:
> Oh, very interesting. Thanks a lot for the bisection, otherwise we would
> have never found out whats causing this.
> 
> David & mm folks: Pavel noticed that his QCA6390 Wi-Fi 6 device (driver
> ath11k) failed on v5.10-rc1. After bisecting he found that the commit
> below causes the regression. I have not been able to reproduce this and
> for me QCA6390 works fine. I don't know if this needs a specific kernel
> configuration or what's the difference between our setups.
> 
> Any ideas what might cause this and how to fix it?
> 
> Full discussion: http://lists.infradead.org/pipermail/ath11k/2020-November/000501.html
> 
> commit 7fef431be9c9ac255838a9578331567b9dba4477
> Author:     David Hildenbrand <david@redhat.com>
> AuthorDate: Thu Oct 15 20:09:35 2020 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Fri Oct 16 11:11:18 2020 -0700
> 
>      mm/page_alloc: place pages to tail in __free_pages_core()

This is my kernel config, for the reference: https://gist.github.com/twistedfall/455885024c56587fc5a0f4b2784612e8
