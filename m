Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0F20329B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFVI5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFVI53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 04:57:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C877C061794
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 01:57:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so13838862wrm.4
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J4lfWpFtkSTGVdNtchR7+MHywh1qNorm1P4Y/FaQAwE=;
        b=YioTbgmW5TF6bSQVm3QSLQjD/VUoBKGQ2dN7FwEoogVjoqCftwaqYWQEYFmqf82aDX
         jbzBzNVu2Bqa2SEnqiYpoCQKvQ3vEEjX0BVETR0CcmZBkLbQsF9rT/+O7PgUep7IxfxY
         FzDgGKfcwv/C4GxTFWlLL1sgMBlQ0aGp6Tu8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4lfWpFtkSTGVdNtchR7+MHywh1qNorm1P4Y/FaQAwE=;
        b=KxL12zB497zcJTU4KrBXUJtNQkgTPVFpqjnDj9EkggI1/4eIM7QfmRx0Gl6Itte0S4
         8Eer3iTm6t88RYnimv6Cp5qzgkuh2iYft3EvS0Fh3sa3ML+zfnzIAQA6svOjfCKUQbUT
         Rs+XZP5Cm+US/aR7FodEDgIYgkcSCPMYrDzXDBa9Om0Ds2USPd/7xn+qFe9tXrti7UfN
         jEAnpE0Y4TTq7zEc6nrGJmO+sKV1Sx7lHB8weOq5uE4gE3DLWjzqrYW5SeTx+mbE8Z1W
         9qdjFRv3vv1cJSFsB1S32ExHGpOKg/eN3yXKwD+WRBn+zLjfpph/5TzCh9MdNemURtDc
         zEGA==
X-Gm-Message-State: AOAM5328QyRvH2ivWMgIdOiwhCRpn7pvFLsQDiIE2FSxdaU4RVmyk8Pu
        FR2yhxNnez0z95U2UrXuiNzIpA==
X-Google-Smtp-Source: ABdhPJyPdpIn8waja1u5KQI/XAU3p5sdzEz/0/hehExiIhuOZNb5u+X8uDWloJuUWoHekTYCHGmc4w==
X-Received: by 2002:adf:8168:: with SMTP id 95mr17246724wrm.104.1592816247742;
        Mon, 22 Jun 2020 01:57:27 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id b81sm17286589wmc.5.2020.06.22.01.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 01:57:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] brcmfmac: Set pacing shift before transmitting skb to
 bus
To:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
References: <20200622020721.498-1-wright.feng@cypress.com>
 <20200622020721.498-3-wright.feng@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <83f89386-f5ae-91ef-d135-a1a0c9a55acb@broadcom.com>
Date:   Mon, 22 Jun 2020 10:57:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622020721.498-3-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/22/2020 4:07 AM, Wright Feng wrote:
> Linux 3.6 introduces TSQ which has a per socket threshold for TCP Tx
> packet to reduce latency. In flow control mode, host driver enqueues skb
> in hanger and TCP doesn't push new skb frees until host frees the skb when
> receiving fwstatus event. So set pacing shift 8 to send them as a single
> large aggregate frame to the bus layer.
> 
> 43455 TX TCP throughput in FC mode 2 on Linux 5.4.18
> sk_pacing_shift : Throughput
> 10: 190 Mbps
>   9: 216 Mbps
>   8: 233 Mbps (Max throughput)
>   7: 233 Mpbs

In this patch the pacing shift update is done irrespective of the FC 
mode so I would like to see similar measurements for the other FC mode 
configurations.

Regards,
Arend
