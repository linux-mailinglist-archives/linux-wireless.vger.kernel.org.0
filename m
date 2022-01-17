Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D624910BF
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 20:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiAQTqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiAQTqq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 14:46:46 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06672C061574
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 11:46:45 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d3so15669827ilr.10
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 11:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetfuse-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to:content-transfer-encoding;
        bh=TTgtXa8BE3vBSJ96tKvjsIjnQVKBRj53pGH768bAQyg=;
        b=NKFY8tj9GONWv7bpUFRI1ttkailW1s4FwHEeTrktgHQbpN4fV40QhVPE3uYZwPMiZp
         LC2j7u7la40xotkYtIaobUJjKUvRTnc5Fp5UrX6MhvU21Q8Tv8EbcxxHDnAww/qC8LqP
         /g0r0DcTL83QPvGOgwbtB1aw2QofK4ntl79E/DvHtj3Ayn2kEFQvoYMefZ3Mu3j70AS4
         CioYESQAJH4/jHHVPwgz//G4UO0IISPVRJy+itAcW58zCHy/5MhdaBbcGzt6L9OOqtoI
         6rH/av4KEhdjSoozClt1D2CbhGYDKENHpOe7jTclUzOtA2KS24nNWTP2ciumvV3ts7gY
         0aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to
         :content-transfer-encoding;
        bh=TTgtXa8BE3vBSJ96tKvjsIjnQVKBRj53pGH768bAQyg=;
        b=XeoCxiQULa2KGJrKGS5LzILslZqDODquSj2riIpSw995EABwVjaKoRNc9euwmy05/V
         JwChR94miFSW6KMU4kLT8AjotJdjHS0xAZhVOYFYcoFOi2SwGlKuuZPjY1wy9GuZKvtI
         Wo7GQBpSkx+pXfERUraNodX0KcFH0nbVkZHobPCYmRAHOMJF0gksOFJneUEdm+lxlE95
         0Bs140YyWpDp21ZztK8yXLnqbFicQ7rsAOc7/f1TXtkf+o6JDJSEHdb1jFOwM/Biop3/
         S66zdBmv7GuBmtVbRO6W0gm4By9PUs2BrOqA+U9WhqXkz+ZC/75RlVierF2P7xshhDnf
         bRmg==
X-Gm-Message-State: AOAM5310IrbjcRSqLYs+fLnodjvWV0GMLsouxPqz+20twT7fkPt0vU0F
        ByqQE22akelIJCnLHaxKRsMdddyYhVzOuw==
X-Google-Smtp-Source: ABdhPJweLovUhpmzmi6A6gE49bzOtbVZoqyqvoY1POnq4Jw4y1zcwvjePFNUckijX5XtjPDRqWjsOQ==
X-Received: by 2002:a05:6e02:180e:: with SMTP id a14mr11492150ilv.300.1642448804526;
        Mon, 17 Jan 2022 11:46:44 -0800 (PST)
Received: from [192.168.1.12] (174-082-179-210.res.spectrum.com. [174.82.179.210])
        by smtp.gmail.com with ESMTPSA id q62sm4274155iod.8.2022.01.17.11.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 11:46:44 -0800 (PST)
Message-ID: <39b8dddb-66cd-7e8f-c5f3-c8ffea39b00e@jetfuse.net>
Date:   Mon, 17 Jan 2022 13:46:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: iwlwifi: AX201 not using 2 receive streams
Content-Language: en-US
From:   Brandon Nielsen <nielsenb@jetfuse.net>
To:     linux-wireless@vger.kernel.org
References: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
Cc:     luciano.coelho@intel.com
In-Reply-To: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/8/22 2:50 PM, Brandon Nielsen wrote:
> I have a system with Intel AX201 not using 2 spatial streams in the RX 
> (download) direction. TX (upload) functions as expected. I'm seeing 
> similar behavior with an AX200 system. I'm seeing the same behavior on 
> 5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a regression. 
> Windows works as expected.
> 
> I have opened bug 215465[0] with some more detail.
> 
> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465

Adding luciano.coelho@intel.com to CC.

Let me know if there is more helpful diagnostic information I can provide.
