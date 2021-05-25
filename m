Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25638F695
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 02:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhEYAEJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 May 2021 20:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEYAEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 May 2021 20:04:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F4C061756
        for <linux-wireless@vger.kernel.org>; Mon, 24 May 2021 17:02:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y76so19406604oia.6
        for <linux-wireless@vger.kernel.org>; Mon, 24 May 2021 17:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uXglOqURRz1A5d92czYMw1SlUdZb3nV/HzOS6sPVRBM=;
        b=fbYWGXbhpA8kbWxTIQNM4m48hHz5sANn/MRVUKaPbKgVQYMv70cEpLUV+TMlQ6Oxrc
         LJwRpM7ijJdg+uMF/qyxN3UsQGjj/Vt3UqKOsjP3Rlfuuqlv0m9mEv1KzrCUhbaT2SND
         wU2Hccj8ZKKzRQtpdo11YMiWds9rp7aQM2aSD5/bbNlXdJLI1FPUTjGJzQCFoQdiWbnM
         5xH12rNQ1gaHj5g3wPWgYfK6Qb3sUA+uyBRi0YEr/GB/UzhqceFg/D3y1+fVoDWJZH04
         tUNDbQpEeje83uBxf/LjuWrkzJKs/L+7QyoRSYE594cHjOMAOgOe9S97VmeKbJ7rIe/z
         qcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uXglOqURRz1A5d92czYMw1SlUdZb3nV/HzOS6sPVRBM=;
        b=i8EHrW8VA2i0pehdimOqbxRpUjDPNXVa/JVEkka7lHhg9qNgSZNWYKOn3juO5ptB2Z
         ojprWv7CwDcqZto2m8ekO0MZCGOESW6pgUrwgquXgimq/RxOBD4+FWvRqug1jfqvjbod
         7xYoV4yt/AJZNwClzG+VuyrFRVW/ofg395JGMj0tcx0oHXHeCQYqZVsTm2N4/MZrj3uQ
         es4CZrufi4RiOtG1xqEMWV7SE0o0X0IxliAQYwg6LPhBL96TDvtZO3ZvXMmGNKSYbfQP
         Y6MqGt7/eExDtPoxrRz1mflaKcnZVdrYmPaDOszmIdsHZL22cg72lus6TpV5Ea8COQA4
         GOfQ==
X-Gm-Message-State: AOAM5302JRkiuFzvpnW+z6anHgxB8i469jS+6RVUKrl09PI+xSEMd1Ix
        wVS39l/cTXQz4iCwB06ZKCTLItjyY8i7Jw==
X-Google-Smtp-Source: ABdhPJx8wQcjldacI9p4pqMaggffVRhHYOzYFSGwIEK64cLSj7y6Bwxl2CJSTV1i37aVZmut74GeFQ==
X-Received: by 2002:a54:4694:: with SMTP id k20mr12690563oic.134.1621900947714;
        Mon, 24 May 2021 17:02:27 -0700 (PDT)
Received: from [192.168.50.240] (c-73-94-106-141.hsd1.mn.comcast.net. [73.94.106.141])
        by smtp.gmail.com with ESMTPSA id w13sm2932981otp.10.2021.05.24.17.02.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 17:02:27 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
From:   Mark Nelson <mark.a.nelson@gmail.com>
Subject: iwlwifi: understanding potential firmware regression
Message-ID: <de4c5734-f9f6-b492-0e3d-4ff814a4b6cf@gmail.com>
Date:   Mon, 24 May 2021 19:02:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Folks,

I've been fighting with an Intel branded ax200 160MHz Rev=0x340 for 
several hours today.  This is on Ubuntu 20.04 setup with the standard 
ubuntu 5.8.0-53-generic kernel.  Out of the gate I was seeing timeout 
(-110) errors in various places in dmesg (The exact error depends on the 
firmware version and module options, but always seemed to be some 
manifestation of the same general problem).  One example with the 
default iwlwifi-cc-a0-55.ucode firmware:

iwlwifi 0000:03:00.0: Failed to set soc latency: -110

but potentially also:

iwlwifi 0000:03:00.0: PHY ctxt cmd error. ret=-110

After many failed attempts and a ton of trial and error, I was able to 
get the driver loaded but only under very specific conditions:

1) The firmware must be iwlwifi-cc-a0-48.ucode (48.4fa0041f.0) or older. 
  All more recent versions I tried beginning with iwlwifi-cc-a0-50.ucode 
would result in the same errors (including on the ubuntu 5.10 oem kernels).

2) iwlwifi-cc-a0-48 and older would only load with iwlmvm power_scheme=1 
set as an option in /etc/modprobe.d/iwlwifi.conf.

That was enough to get the driver to load, but several other iwlwifi 
options appear to be required to avoid instability and tainted kernels: 
swcrypto=0 power_save=0.  At one point I was still having issues with tx 
fifo queue flushing, but that may have been related to using 
backport-iwlwifi-dkms which I've since removed.

For now, I wanted to document the progress and fix for posterity and 
also ask a question:  Is a changelog for the iwlwifi firmware revisions 
posted anywhere?  The primary issue I was facing today seems to be 
related to some change that occurred between iwlwifi-cc-a0-48 and 
iwlwifi-cc-a0-50.  So far I have had very little luck tracking down 
what's different.

Thanks,
Mark
