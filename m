Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A091896BB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCRIRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 04:17:21 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38413 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCRIRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 04:17:21 -0400
Received: by mail-pf1-f181.google.com with SMTP id z5so13494818pfn.5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2020 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZRxCb54YtVPdnjbxPlyqOejvruVjAjlLM5iy26STCOo=;
        b=L6kG6NiQpbShK8wVo7GA6yBtSrv50uQiz8wYrvzgDb40LVTr7YO3YO41RE7eqJUWRn
         FVEpX1oIgYIVCevAP+x+bqjYCbzv+sob4xPd3xx29IsDJYz2Zzpy9mRjPZNrRqIFzwLf
         jIsvOz+7umMb0yt3iz0WlcI/92o3lqK7ioNoP5MKG+Pil5zuPp8NnNSL+0SuEn+XudsK
         gzlDlVrmDPe39V6oxrJUHaMyDhm/reDUU4FXM6WM/XEGbLHAnWo9+6knUeMej3/+xHfh
         LsL+pniTOqKusST3nOfCy8XGN09TLdA4b7T50W8sDQCKia1IYYBwHV4V3Sprjgmdwsga
         qPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZRxCb54YtVPdnjbxPlyqOejvruVjAjlLM5iy26STCOo=;
        b=NsRB0KzaviLyZO6mDOyzUZq/nmVhbzsR2Z9dFXygL4ifyqhZgPy+bPGxRtELYLz1o1
         fpi6qZHClyDMl/heGnRhVPwhYGxkM+Q3VkmKNTpvWAvRPMWsjuiMlUmLwNBx5WAkbDIE
         pKApWh5BT8EXOsQh1r8JmTLa7nGjjBxZYQdA2uCuSEBLfbmpDkT8PmEiAKYrpmFGVdT4
         5Ap2my1aWbyubIATIra1FUkuUB4RX1yUqwVZqZHa9YnS+p1jRcAFe03sX0eaQPNA7K62
         5uQc94y/m5bCr4XbYmkNfqKcaUfVRv//y9oY5fJsU/NwgYNR7yTUS8YxR87FzyHctLdz
         jSdw==
X-Gm-Message-State: ANhLgQ2LWp6hYikstQHZlw+fOgDkDIpp4J/LLo30LB2HGnSvl0SfnZlv
        EM7Av9UZNWWKWZpVZnQHDGljEOzy
X-Google-Smtp-Source: ADFU+vvkGbppZTDezFyeCpQZl2KGS7+hFpbqE9qntDmWvJxEWVRXsMWaU1Y7ivmuAeRZp5Xxr5cT+A==
X-Received: by 2002:a63:2356:: with SMTP id u22mr3247004pgm.245.1584519440000;
        Wed, 18 Mar 2020 01:17:20 -0700 (PDT)
Received: from ?IPv6:2409:11:53c0:1f00:1d44:eee2:d619:f95b? ([2409:11:53c0:1f00:1d44:eee2:d619:f95b])
        by smtp.gmail.com with ESMTPSA id h132sm5642335pfe.118.2020.03.18.01.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 01:17:19 -0700 (PDT)
Subject: Re: Simulate Radio wave interference
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
From:   Masashi Honma <masashi.honma@gmail.com>
Message-ID: <90e89fa2-6f60-9275-ef59-0b1f8f8aeb31@gmail.com>
Date:   Wed, 18 Mar 2020 17:17:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fb4be9f4353193a789e4a6cdc4b35c096d2efd7f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020/03/17 0:42, Johannes Berg wrote:
> Hi,
> 
> It's a bit over three years ago you wrote this, so perhaps you won't
> really remember, but I'm not sure I can make sense of the code and
> wanted to ask if you can help out.

Please give me some time to answer.

Regards,
Masashi Honma.
