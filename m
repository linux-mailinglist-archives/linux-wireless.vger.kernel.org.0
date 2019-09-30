Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E79C2359
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfI3OcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 10:32:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3OcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 10:32:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so11574757wrm.12
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaiwoo-ai.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WsRuBaqX1VkD6i604aTPqFxsokkqBx3/4rkIvJfeAb0=;
        b=eKrcmaAa4RvvOr7Es+cga/54ytmmO328X6SHS18X5R/EMy6Gv74pErXwB2lluUH37J
         fdUdXopRYJHJL/zk2HgBB/FcANM+J2HXvoAGteZJryW/ekCbIdaCd1M4vQL0U1Xax3a3
         FD6aYLSan0mMqmaaWial318YTp3cjJ8hcKJrmfueyLj1wyYmT7abxWH8XFfAKhZwgzK3
         p1i7+10dYVeSFyNIRFdJ7Hdd1/cYkgo39f7aIfat/wEqcmZbgwXQondgW5heIp3+1xwH
         hO83nlHuuRaymSgDPKkZ3NgMcM/WJR1ewgRU9O0s364HjJUn5Oczv1YAgAv0tTY67bHc
         qnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WsRuBaqX1VkD6i604aTPqFxsokkqBx3/4rkIvJfeAb0=;
        b=b9AyCRl3/ey8x/e6hlixNGgukogNtsSjtVcZGfl69p4yD6eU6nXp3l3vbuqIuHwKFm
         G1kZci7rSOYHnvMc4UtkADuarZZVXfBFnBzTEOaSEULqrnDFc6zFLUS5EJiLh7kMmQFQ
         Ajuk6aRgjtTgRaK8jHjH6X/34m6vk3IcxF8+hXKILjaBzp+PU2ssB/suAW4yjy/slVi+
         8kzop0EVJA4J/YJWR1Gp/g40uOQ8wVmfO1meV9M8lfMVo8MWvpjfw85o+XBMzTBZKq04
         0t9TFOx6XHdeZZDg4H5hmpb80q6M0TnityMJA24NhnqynHXqeYRO/4mBXbLZ57Pj53Ql
         wSmQ==
X-Gm-Message-State: APjAAAXyar4GN98/my/LCYoWcrYPjxduAmgX18ID5d8yItEw5r/WpQrf
        IgFTvoe4YQiQn4UlWGz4vx6DzCL4COE=
X-Google-Smtp-Source: APXvYqzUApY8QHHeBZvySVVaqb/IwM/L4BRGZkFwOgr53JaeW/j6AEXo76aKVCcGr2M2y82vV0+Ztg==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr662428wrm.178.1569853927474;
        Mon, 30 Sep 2019 07:32:07 -0700 (PDT)
Received: from [10.93.0.228] (net-93-145-117-10.cust.vodafonedsl.it. [93.145.117.10])
        by smtp.gmail.com with ESMTPSA id u4sm23587120wmg.41.2019.09.30.07.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 07:32:06 -0700 (PDT)
Subject: Re: [PATCH] ath10k: Fix offchannel tx failure when no
 ath10k_mac_tx_frm_has_freq
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <1508284992-3574-1-git-send-email-greearb@candelatech.com>
From:   Antonio Quartulli <antonio.quartulli@kaiwoo.ai>
Openpgp: preference=signencrypt
Autocrypt: addr=antonio.quartulli@kaiwoo.ai; keydata=
 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
 BT5NrmAI
Message-ID: <ba256006-b42b-0dee-4eb7-093da5885341@kaiwoo.ai>
Date:   Mon, 30 Sep 2019 16:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1508284992-3574-1-git-send-email-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 18/10/2017 02:03, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This bug appears to have been added between 4.0 (which works for us),
> and 4.4, which does not work.
> 
> I think this is because the tx-offchannel logic gets in a loop when
> ath10k_mac_tx_frm_has_freq(ar) is false, so pkt is never actually
> sent to the firmware for transmit.
> 
> This patch fixes the problem on 4.9 for me, and now HS20 clients
> can work again with my firmware.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>

I have been struggling to send offchannels mgmt frames since a while, as
I was always getting:

[18099.253732] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e3780
[18102.293686] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e3780
[18105.333653] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e3780
[18108.373712] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e3780
[18111.413687] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e36c0
[18114.453726] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e3f00
[18117.493773] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e36c0
[18120.533631] ath10k_pci 0000:01:00.0: timed out waiting for offchannel
skb cf0e3f00

After digging through the ath10k patchwork I have found this patch which
touches exactly the code I was trying to debug.

After applying this set of changes, I can confirm that sending
offchannel frames works again like a charm.

I have tested only one fw though: ver 10.4-3.5.3-00057.

It's a bummer that this trivial but critical patch is not yet merged
upstream :-(


Tested-by: Antonio Quartulli <antonio.quartulli@kaiwoo.ai>


-- 
Antonio Quartulli
Kaiwoo.ai
