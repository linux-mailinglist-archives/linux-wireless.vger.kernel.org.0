Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2421D954B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgESL3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgESL3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:29:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC683C08C5C0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 04:29:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so6402672pfb.10
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m4bpJgcZVSxvKz7SUPl/kNfRjinxWx+k6EzLwOIoyaA=;
        b=WLVVVhN7Wvglz2rw3NiojZp6shhRD0W5H4SHT1x7wtv7jZIGZnEx0Tjaa3KvH66Bys
         uD3ytw+gQIwktMRUhq+3sWoHK/3AaFJatuTIRqKIiuLVrAR/D7eIgWzs6yNkg5LayYw1
         Cb7t1YTkvQGu70HTZ5OCGzUw5Y5qRPqfi+8D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4bpJgcZVSxvKz7SUPl/kNfRjinxWx+k6EzLwOIoyaA=;
        b=qGBQ9AckN/mKbrng/3mhc+fJrmKhh/v1RUPS/nNi9wpbc9yVFKdbBd2qAsIRO5ell3
         82HtsX6WBZefRbipTY0lfMCIQ7khOwhCLvzXDHHsFjpwuNiit9ovV27ewB9sTPUXAl9K
         zjiPnnxcBBqdqoblrr2EW6oHaGR/WqErwy4aHApxFS7KaRDXxfdTsHhWOUiU6wKDMSrh
         RFfQa2MDSwpSL6zkv7zb+KTIHmK+brgx6ifgH+931lA5C5qJSw/Vc5PtuahGdWYJJP/1
         /3EOqxY4SKlGPiKkmYnO9RuWyCBuF/6ej10+QHU5qz5KHIN9aPhRl5xiQQ+ZR88dAF76
         eOsQ==
X-Gm-Message-State: AOAM533DTg8x1jotNj/gMO4XXwt27+tBNWHr0nypIe7P0OGl0SgXo1Sz
        lXXaae0JXPVBODx4ngRume7/RA==
X-Google-Smtp-Source: ABdhPJw49JC098Nzv9UmYmGFFRsrkt0AlMHZceNi2HvvZuaG9uZLelXf59F+pI1l6AUHGXHqSJ+2CQ==
X-Received: by 2002:a05:6a00:150e:: with SMTP id q14mr1478556pfu.325.1589887781334;
        Tue, 19 May 2020 04:29:41 -0700 (PDT)
Received: from [10.230.34.187] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id t5sm9680904pgp.80.2020.05.19.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 04:29:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] brcmfmac: increase dcmd maximum buffer size
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
 <20200519110951.88998-5-chi-hsien.lin@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8d74b434-abdb-cbfd-ae21-5c083011375b@broadcom.com>
Date:   Tue, 19 May 2020 13:29:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519110951.88998-5-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/19/2020 1:09 PM, Chi-Hsien Lin wrote:
> From: Double Lo <double.lo@cypress.com>
> 
> Increase dcmd maximum buffer size to match firmware configuration for
> new chips.

 From the description I was expecting BRCMF_DCMD_MAXLEN to be increased 
but that is not the case. Please explain the need for the 
ROUND_UP_MARGIN. Is it always needed or just on some platforms?

Regards,
Arend
