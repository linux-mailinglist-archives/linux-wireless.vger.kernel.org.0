Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC71A203E9D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgFVSB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbgFVSB2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 14:01:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F46EC061573
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 11:01:28 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 64so2882141oti.5
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JPMm5ge4chgnwSRwmYZ3ZuBVHaZpbWtihHCbackhrmE=;
        b=IZDcLpnOA15xdEoK9BKwgkCM5iDoh4pUCkkhactaxszFtlhhUHuP8SU7F8o6oF5Lk9
         pIcF4mmtrMRGkZhuQC9Dmc0k7mdUDVB9yEktII91d/pKP3KvyjR1YHS29doFneD8hj68
         Xay20yiwqd+OsidxQo2DAskxSfrsDEsY5Fk4ju0ez5w10wE5oEWAjvKohwLkan30q7lP
         +CaOkNv3Jeyh7DQu3rCGKSKjx3OAmpjvfH4Y/SD+XZZi5fm5bdWCaBIZ7Lq5c6QggI9q
         HlS7L59qlpRNhiUlZQT0IOv3a9gm+AXhMRxCMlvpDBk8WTfR5jnpvsEbwMLIBmqIrBfm
         PJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPMm5ge4chgnwSRwmYZ3ZuBVHaZpbWtihHCbackhrmE=;
        b=oEJlYJso1efEIqPb34gDbehj7fPaXbp0fzsDvSGzf0YciFGBbzaaw/ObmIk2vr0Z+l
         vyddCz5wt2bulIm4419wZ0l9QEc1Lur9egVEu9G4p5tI1qqPRCPBroy00pN9lSkdO7KF
         glp/HbqsFm4qz7FmOjd2H04vqpeqFsiIyuyigUkhqa/YoDrVRQ4GjLy5t9Q8E4Vzrmpt
         1kG5599nK8sDTBwaaD0FOrGq6EiAKA1KfwygSW3QMzV39MzxyiOfWVnvviXaHv4+fSzd
         IYDV7CKbS+ABU3IEQtHfscHx6vj9BxbRQxV1P9HdbppdU0qXuUHbpwutgn43Vj7QcUJP
         rMIg==
X-Gm-Message-State: AOAM530sQKl9OEElXsiOIXp5EBowpe+RPRTJSbh6QsiYW0+E/ztxnla8
        7rldjUUOb4yrUdjbcabeXeBHB58V
X-Google-Smtp-Source: ABdhPJybkHF10b+dHAU1N72MO827DuC0l7NySDZKl0agNHrKTuAVRD0iVdhCDUbhISJtqtH6JU0JPQ==
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr15096846oov.71.1592848887743;
        Mon, 22 Jun 2020 11:01:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m18sm3590955ooe.12.2020.06.22.11.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 11:01:27 -0700 (PDT)
Subject: Re: [PATCH 1/3] rtl8192cu: Fix deadlock
To:     Reto Schneider <code@reto-schneider.ch>,
        linux-wireless@vger.kernel.org
References: <20200622132113.14508-1-code@reto-schneider.ch>
 <20200622132113.14508-2-code@reto-schneider.ch>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <6f1000a0-7a0a-36c9-21a3-1ea39175d051@lwfinger.net>
Date:   Mon, 22 Jun 2020 13:01:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622132113.14508-2-code@reto-schneider.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/22/20 8:21 AM, Reto Schneider wrote:
> Prevent code from calling itself indirectly, causing the driver to hang
> and consume 100% CPU.
> 
> Without this fix, the following script can bring down a single CPU
> system:
> ```
> while true; do
>    rmmod rtl8192cu
>    modprobe rtl8192cu
> done
> ```
> 
> Signed-off-by: Reto Schneider <code@reto-schneider.ch>

I have one small comment. Patches for the rtlwifi family of drivers have patch 
subjects of the form [PATCH] rtlwifi: rtl8192cu: blah blah. I'll let Kalle 
decide if he wants ignore my comment, manually change the subjects, or request a 
V2. Otherwise all 3 patches are OK.

ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry
