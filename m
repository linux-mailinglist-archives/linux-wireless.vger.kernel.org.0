Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDB2A0213
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 11:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgJ3KEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 06:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3KET (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 06:04:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5EDC0613D2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 03:04:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w14so5766566wrs.9
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQH8tfnS5gABqR+rI2vYNKDqWdjjH0cmP3e9KTBgftU=;
        b=B9rJTdT06fBjkoaC4E33GsRL6XklEaCtgE6RSNGKr1R6NIN6tshFsvlrm73+qDotTs
         TgtMR2VLSrECST5bfnSTgKL7Wgi9dLvx0b+wOp98ZwTdU4Ui8lhbwxRwAvAFaXlLlBUv
         kIF79xh7rAnLeAmFUb7OH8iS2qmajJB6f90j1t67g5Zqi8ZvFcvZqslE0Nw79PSToAvD
         N9OdQRnS+ec6wQ18zcvo4xYOB+MrwDVlSeHj5ODLObBC4OqIgDsKYG4VpZ7Zwf1s+0XG
         E8uv8pTzD1YjF2GLDWWylcwx+GDZ++SmMtTJoKDLvlekOLEjOvRKbLbn1NSmNnF0g7r5
         ocZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQH8tfnS5gABqR+rI2vYNKDqWdjjH0cmP3e9KTBgftU=;
        b=LjkQbaWdClf4u11wLHb5I+TWQjiSVrEvdCq50SpvP3fwIzkJyY01iHtIs2Us+wHdwK
         xgJLfwk7WJepSv3gtK2kGJ8/hcN0suDyZ3douLBD4n+TTyLH+sbqrDNb+looVs97Vi8v
         EjUGIINwRanJg90NpXQ81HbrKIcCdcVqv7XxlURD/Ny0Y58l8mssOniWxF8bg+lGPikO
         GRmx3fq+jMDm8R7y6Cj1kbAGs70CWbwYgCmdWUYaQsIxNW+N/vlCyrk9QqYoHB4fyrQf
         uVo0W8Z3kDnd/wwPP8+mG0v/LY91jdSaDYMCB7Oq1Nki0k/7jwIFC5oIqsCt/nfjv3yP
         sH2A==
X-Gm-Message-State: AOAM531QWql3Txxfv50SNiliI61cbFLBH8fvZR8g4mpgZw2ijZ6QaeK0
        yFUgjalelgnCTf2FqsJTKfKsslkQsX6HBA==
X-Google-Smtp-Source: ABdhPJyiqwsuWF8oCOJ2p5mgrL1UOBEF3qjVNKqZ9hb80Q/uxO4LXY5WvIi3i2M6psl12Cn+2MTVIQ==
X-Received: by 2002:a5d:40c3:: with SMTP id b3mr2187416wrq.157.1604052256376;
        Fri, 30 Oct 2020 03:04:16 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id h8sm7699531wro.14.2020.10.30.03.04.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 03:04:15 -0700 (PDT)
Subject: Re: [PATCH v2 19/39] docs: ABI: stable: make files ReST compatible
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        xen-devel@lists.xenproject.org
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
 <467a0dfbcdf00db710a629d3fe4a2563750339d8.1604042072.git.mchehab+huawei@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bc393307-d7dc-1666-f25c-6d756ebf5993@linaro.org>
Date:   Fri, 30 Oct 2020 10:04:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <467a0dfbcdf00db710a629d3fe4a2563750339d8.1604042072.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 30/10/2020 07:40, Mauro Carvalho Chehab wrote:
> Several entries at the stable ABI files won't parse if we pass
> them directly to the ReST output.
> 
> Adjust them, in order to allow adding their contents as-is at
> the stable ABI book.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/ABI/stable/firewire-cdev        |  4 +
>   Documentation/ABI/stable/sysfs-acpi-pmprofile | 22 +++--
>   Documentation/ABI/stable/sysfs-bus-firewire   |  3 +
>   Documentation/ABI/stable/sysfs-bus-nvmem      | 19 ++--

for nvmem parts:

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   Documentation/ABI/stable/sysfs-bus-usb        |  6 +-
>   .../ABI/stable/sysfs-class-backlight          |  1 +
>   .../ABI/stable/sysfs-class-infiniband         | 93 +++++++++++++------
>   Documentation/ABI/stable/sysfs-class-rfkill   | 13 ++-
>   Documentation/ABI/stable/sysfs-class-tpm      | 90 +++++++++---------
>   Documentation/ABI/stable/sysfs-devices        |  5 +-
>   Documentation/ABI/stable/sysfs-driver-ib_srp  |  1 +
>   .../ABI/stable/sysfs-firmware-efi-vars        |  4 +
>   .../ABI/stable/sysfs-firmware-opal-dump       |  5 +
>   .../ABI/stable/sysfs-firmware-opal-elog       |  2 +
>   Documentation/ABI/stable/sysfs-hypervisor-xen |  3 +
>   Documentation/ABI/stable/vdso                 |  5 +-
>   16 files changed, 176 insertions(+), 100 deletions(-)
> 
