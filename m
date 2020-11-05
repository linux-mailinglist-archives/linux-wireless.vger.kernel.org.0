Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21B2A7F1D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 13:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKEMzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 07:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKEMzD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 07:55:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6AFC0613CF;
        Thu,  5 Nov 2020 04:55:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w13so2417691eju.13;
        Thu, 05 Nov 2020 04:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdb4a75nDYFWhXtJEBTR4K/6mw5ONd63rLzUkBKXiIE=;
        b=DK2YPwEYBzHKcbuvAewPh2ubypxtnn47SEtlGdzykfkQgnGkJ0glK3T4UFluf2Bd00
         woQDDU+m9maOfSPy4Eo7NicIKsybrf8ZvEBfkCy0WDnWcmQ71CVgyaZVeo8bmVwBtMRR
         ICax/jgLnPiKntLS/rnBCLLfrZQ8pCPa5vdpL4QKYZTCRJgXsq/zI5BXAexFyjaa0dXB
         wwvuYSIXiZsdq43mZhgsROx6lAHwI5FPfEJMU6RoCjmOpB3jzjrWpPyI3QpNH5gsJVf0
         GYEHwqjD4biBtzVauiuG92fo2P29bUhxV8qcrCAP0t9YbKQnzoz83YMiL69UTSxC9ymM
         eK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdb4a75nDYFWhXtJEBTR4K/6mw5ONd63rLzUkBKXiIE=;
        b=bAXy96rT5X6Gz2LOWQfmQSLbOQoZeSvvAOpgzTOj5DtGVZRV6GubbbyJQUuUlgL7V8
         BN2XOWwaB0QZLk4YvPffhsE6SxXTo9WKroHUMeF1pRD5tgSdleJ9YEA15kZUc9ZTNEh7
         vBI9aTFAGxwzudPPmz/Bmj4nor/zw/+vYxC23CevwEPJC/66tdpgWpnlU4brqV3EdvVx
         8zZa79O/SoleHZHH/lAmQM0qMQy64MwENhJ/vF2vjB3IfMIdmveYzf9MRmUCDejvQrYz
         x1sUDrTwUxe4HTdi7Fs2qeMWFwDqpKRMrj/Ni78CaNQE4hbz7Sri/dc/AiUXn0GtptuR
         lcgQ==
X-Gm-Message-State: AOAM5317ikTmPeCLQRkMP6xTn/VO6y9WFt8ENuzhidyDRYKVXeGazVtl
        vAZp8dNjDDrw5dAtYvxn1qRWi0Mi9WKtlw==
X-Google-Smtp-Source: ABdhPJyPS+uIl9TDoSmI2PgxG0jiPd8m3YJVJk/F2cVj9oVZvuwgQLQSTsFyWzMmyqWxz+Y+G0q4JA==
X-Received: by 2002:a17:906:a149:: with SMTP id bu9mr2064502ejb.115.1604580901961;
        Thu, 05 Nov 2020 04:55:01 -0800 (PST)
Received: from ?IPv6:2a02:a44f:d2f0:0:7cde:5457:f7ce:ec3c? (2a02-a44f-d2f0-0-7cde-5457-f7ce-ec3c.fixed6.kpn.net. [2a02:a44f:d2f0:0:7cde:5457:f7ce:ec3c])
        by smtp.gmail.com with ESMTPSA id d20sm860807edz.14.2020.11.05.04.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 04:55:01 -0800 (PST)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to
 tail in __free_pages_core()"
To:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <d6fb1e30-0d19-9af3-337b-69ff11c2fc6c@suse.cz>
 <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
From:   Pavel Procopiuc <pavel.procopiuc@gmail.com>
Message-ID: <225718f1-c4b0-8683-427a-059148a39350@gmail.com>
Date:   Thu, 5 Nov 2020 13:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8ACA82DB-D2FE-4599-8A01-D42218FDE1E5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Op 05.11.2020 om 12:13 schreef David Hildenbrand:
> It depends in which order memory is exposed to MM, which might depend on other factors in some configurations.
> 
> This smells like it exposes an existing bug. Can you reproduce also with zone shuffling enabled?

So just to make sure I understand you correctly, you'd like to see if the problem with ath11k driver on my hardware 
persists when I boot pristine 5.10-rc2 kernel (without reverting commit 7fef431be9c9ac255838a9578331567b9dba4477) and 
with page_alloc.shuffle=1, right?
