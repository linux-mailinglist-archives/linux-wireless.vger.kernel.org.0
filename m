Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58763E10F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 20:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiK3T4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiK3T4o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 14:56:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EA56D57
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 11:56:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f7so25520679edc.6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 11:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtGVdTXJWUzvMS++ORoQVZu8EPWYR8GIf3zDc6bBxQg=;
        b=Ugo+JAn0jRxFKl1OeHlmiowlumglKKhQq2le2TDC91mSZN925sFVOZQ26auoYGrccc
         yXYcB3Fi9Qes9jg6nwjaW5LzQz9da1/ToRRl/wG0nCs1Rn34qKwEE/JM9manvxo1fqzw
         Qt+cH+Go0lub1sSxFT3PlJoH6tuw217fFUMQ0oKjj0tgenpvxddUTRwaGiZMFUupfFjx
         Vu+DQjRhIRZc0wGVn2eKCw+l31vk10rYL++0SnFx1WW/3WVBuHmrEu9RQIOYyznHtebM
         wqWkdbnO6LBppgDFyMb29uuZayHeJ8uQy1bQNJW6pfDiDQDiRgmR0J3rJ3H7OHL4MvFs
         WCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtGVdTXJWUzvMS++ORoQVZu8EPWYR8GIf3zDc6bBxQg=;
        b=oeYIcJrWB0zr2tLFTUV4IwKcdDd8hHQD1Yxo2boSdcyahaum2ctEnc2FEoUMYpqcG/
         N18wUvSzc5/aJac/aCAUITq7FCRirySno/sL5lLCSHpjHBVUr6lRyg/5BESlmN434Sum
         z1/FxloyQL6UV4SBM7H+74wS8xXzQgH/uCjTko0U0D+grR8Q891nXk95p0I42KdNTyq6
         frbUFPFZpMO4qpPWwPvhi28BlhtauzFk7LMjUA9nEQp4Snf1f/yl6QTKZq4gBGskWs4t
         Dj+yJzkVLKpkBrX+5bGQtXL1n04j613XFe1AC+YUC8I6gV4JuiIcwvP5ApiD30rdqzqb
         1uhA==
X-Gm-Message-State: ANoB5plB9Xaju6Nf7L8iahcB4MiJvGRnZS5+vOnZA92iYvyYYVPKuz/X
        zuJABcGPWXDW2zfxepe6Izb8WM4H7gmEtKIdtwo=
X-Google-Smtp-Source: AA0mqf7fW6pYtSJ+ZvwOlHXR5YNz0VDZzrXGdEyYBp1mTdow3NycUzFR7kU0/zeQ8H3Dt8PO/hP6LA==
X-Received: by 2002:a05:6402:4c2:b0:461:3ae6:8bf2 with SMTP id n2-20020a05640204c200b004613ae68bf2mr3526270edw.396.1669838201266;
        Wed, 30 Nov 2022 11:56:41 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b007c0985aa6b0sm971561ejg.191.2022.11.30.11.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 11:56:40 -0800 (PST)
Message-ID: <ae610c15-a823-8e64-f55a-81c161961e85@gmail.com>
Date:   Wed, 30 Nov 2022 20:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] wifi: brcmfmac: Check the count value of channel spec
 to prevent out-of-bounds reads
Content-Language: en-US
To:     Minsuk Kang <linuxlovemin@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org
Cc:     arend.vanspriel@broadcom.com, dokyungs@yonsei.ac.kr,
        jisoo.jang@yonsei.ac.kr
References: <20221116142952.518241-1-linuxlovemin@yonsei.ac.kr>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20221116142952.518241-1-linuxlovemin@yonsei.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/2022 3:29 PM, Minsuk Kang wrote:
> This patch fixes slab-out-of-bounds reads in brcmfmac that occur in
> brcmf_construct_chaninfo() and brcmf_enable_bw40_2g() when the count
> value of channel specifications provided by the device is greater than
> the length of 'list->element[]', decided by the size of the 'list'
> allocated with kzalloc(). The patch adds checks that make the functions
> free the buffer and return -EINVAL if that is the case. Note that the
> negative return is handled by the caller, brcmf_setup_wiphybands() or
> brcmf_cfg80211_attach().
> 
> Found by a modified version of syzkaller.
> 
> Crash Report from brcmf_construct_chaninfo():
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in brcmf_setup_wiphybands+0x1238/0x1430
> Read of size 4 at addr ffff888115f24600 by task kworker/0:2/1896
> 
> CPU: 0 PID: 1896 Comm: kworker/0:2 Tainted: G        W  O      5.14.0+ #132
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event

[...]

> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

My earlier review comment is addressed so I am okay with the patch as is.

Regards,
Arend
