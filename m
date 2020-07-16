Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259B7221FC3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgGPJf0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgGPJfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 05:35:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1195C061755
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 02:35:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so6319639wrp.7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XUO9JXkEJR59K4RUhFWCLjMinRXiG6LQMsKOWeJeIzQ=;
        b=QyaCdwTtu1MzStz8EE4zB+rEwIwjJZ0VYfmGF53GFe5/1AaT4f72s/A5ZlRDdhCP1A
         5jydxUaotQ0+9+FKkonEggqLCM6m1NKWLgxkk0mp9/Bl2i1V6IwCuJcFV+uYl1uESCXm
         grXo6T1ef1YwrUWAOf94OpcgkxX717AvLMJa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XUO9JXkEJR59K4RUhFWCLjMinRXiG6LQMsKOWeJeIzQ=;
        b=tdEBqmh8BXUOCKZqtun+MmWRuNYXy/4NXxHIW3Vz2KRr3NfsoNQ05MQIEHOUUI+PiC
         7P8bbIHyWcWdbCK+6EwcD1FAWnQxUZnP0CIOlKzbmJE+vp6WjhACinBlUSQUKtJ3A9zM
         e2a0USeEnfH+95CDvYV5OMUo79s6Uw/2O53gzUlncXnATnFjRgmUQwF/J9Nc6cE3aRw+
         LxFEnHKX8hqrBWvGyNRNW4wlGaexhOUL6iIiEQ5A7oykDaAdza0T6HamKqUfkZM6nU1F
         1hPk9Lqw1NJgljK2crQi5OUIy/t3nhwrrFAZDN2Dxo4lBDzBG28Bvb7d+QN9tDm0kbHN
         YOLA==
X-Gm-Message-State: AOAM530h9nJdhwMXNnXX5lJGz4tlZ9FOeOqgr1d87+BW2YxtaF0+qucH
        sWynSfqGZhHe1XzbBs1zqcau1n9avCjEQP217Z0cU2m2taNNOUMb3Ou/Lh+IsU51p8KPP/oksE1
        UN39GNPBND2AkH6VYEnmJPlpde8tVQf0GB+Hnph1ID3RF5PyEIrPmKegiiOpZpDwA9nUlwHha2N
        CUJRTDHLw7BV9ONrU5
X-Google-Smtp-Source: ABdhPJzEhMVKI5vDFEbHNjQ1cDMTRl2Wsv+dinihfqaAQKR872ERYN04AUes7wjQB5Xg26tmucX5FA==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr4132225wrw.111.1594892122772;
        Thu, 16 Jul 2020 02:35:22 -0700 (PDT)
Received: from [10.230.34.187] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id y6sm8063725wrr.74.2020.07.16.02.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 02:35:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Unsolicited broadcast probe resp support
To:     Aloka Dixit <alokad@codeaurora.org>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20200715230514.26792-1-alokad@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8b8a5ec5-52e3-50e8-08e6-dc2ee20ec1bf@broadcom.com>
Date:   Thu, 16 Jul 2020 11:35:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715230514.26792-1-alokad@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/16/2020 1:05 AM, Aloka Dixit wrote:
> Unsolicited broadcast probe response tranmission is used for in-band
> discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
> fast passive scanning).
> 
> v3: Rebased. Removed check for 6Ghz, drivers should add that check.

I have not seen any comments in v2 so could you motivate this removal. 
It is a sanity check that is always needed so doing it in the nl80211 
api seems the proper place.

Regards,
Arend
