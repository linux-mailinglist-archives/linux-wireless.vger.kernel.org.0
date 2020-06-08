Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED851F1F70
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFHTBg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgFHTBf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 15:01:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372A8C08C5C2
        for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2020 12:01:35 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u23so14548614otq.10
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2020 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+wbeJaHYSrRqQ69U6EyMbluNe6KW4P1vkkx5XbPilVY=;
        b=IV9Ny0q44YHMvhmS40w7dMY5aainTG25U2uzj6C/i5AURnTGfmKP6RKU+AzQwwtsgO
         t/jLuo2TOWsRRYKmCLhzfISgFKJlz2IdrPhVGHZgRW6wmlkVbGc15LSH47IukraiwsdC
         iWEcVAGJdaQMnw0ZZ3gBuuSRqCRCMMRkp3LL8yw9xJ3UH09l4+DDrFm2eGXUraFhjnq4
         0JhRTP+A1xPC00QvU9SsxTGoTjxUDxLQgnnJ+m2XBPvby7UcYl5Us//zNc52N4hnVS2i
         I40apv1oAFD4ZkSOk2qst++C7uGJK82l4AW6y43v/V7ys46b3uaHX08qkorEamAOZhsh
         ElEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+wbeJaHYSrRqQ69U6EyMbluNe6KW4P1vkkx5XbPilVY=;
        b=Qa60kYQMO24YlbViyaDbn0nXWDqsQ3M8fIdW3QfD4Sn7aWbu2XcfNxdhOOnFTBU7/j
         5UCT0piBvaGMHFwdqWODUiOw0EH270Tm2tjvnLS5eHZ6SKIKu6ntWhO/V+HlLk+6Jj4q
         AMQ0Ll0GcBcjvY40T5QLR1C8AQ8flo1/5E1qx0ZLzJAxmVV/6/fHuEXkkiuNNk7Mw26f
         Csqmfwlh/igtaV/XdNhZiOYDSQFcR3u1Tr7EeXD/8cvMMSw5ZsOVgR9ccxwxBuy+hany
         gPPhyVvTlM2CLMu34yF5YKVgkxRkM5TRcTZq03ukcRkB6WAeQ6PhcRRYm0pK8qldIdib
         EtgA==
X-Gm-Message-State: AOAM5314glW7uCO8JPoV56LcjBirV2mR2hcMnek5Ipo1XgXTAM8+ohkt
        ip1LWlnoOZHxpCCsHHHGAPI=
X-Google-Smtp-Source: ABdhPJyOutGVbxhQRvM7UMO2pMK1K2fFbtSlZQolr3UT8S+UxahVUvviPa4AyynUi52n+E4ZNxsRlA==
X-Received: by 2002:a05:6830:6:: with SMTP id c6mr17863386otp.62.1591642894577;
        Mon, 08 Jun 2020 12:01:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h187sm1403091oib.7.2020.06.08.12.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:01:33 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] rtw88: 8821c: Add 8821CE to Kconfig and Makefile
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, tehuang@realtek.com,
        bigeasy@linutronix.de
References: <20200603094218.19942-1-yhchuang@realtek.com>
 <20200603094218.19942-6-yhchuang@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <bec7010d-e979-da0a-0ce1-88fc872c1eec@lwfinger.net>
Date:   Mon, 8 Jun 2020 14:01:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603094218.19942-6-yhchuang@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/3/20 4:42 AM, yhchuang@realtek.com wrote:
> From: Tzu-En Huang <tehuang@realtek.com>
> 
> Since 8821C code is ready, we can build it.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

I added this code to the rtw88 GitHub repository that I maintain. I do not have 
an 8821CE card and have no way to test it; however, there is at least one user.

That user has built the driver and gets the firmware loaded, but runs into the 
following:

[   12.378158] rtw_8821ce 0000:02:00.0: Firmware version 24.5.0, H2C version 12
[   12.404834] rtw_8821ce 0000:02:00.0: rfe 2 isn't supported
[   12.404937] rtw_8821ce 0000:02:00.0: failed to setup chip efuse info
[   12.404939] rtw_8821ce 0000:02:00.0: failed to setup chip information

Any help would be appreciated.

Thanks,

Larry


