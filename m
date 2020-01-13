Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD7139054
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 12:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMLp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 06:45:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgAMLp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 06:45:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so8247884wrr.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2020 03:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j25aHBrSp+PLnNYwGkDcs4cVtf83TIUnbNmAIRsjS30=;
        b=VgTqATzrt4L2HUHFPg2Jc/sxNNwnyFyZ0GQz0luk/jgQoXAR+k12ihlHinHScYcIew
         tYVg8MkHAn4cuB3FzYw71x8L5ByndFd32BTb9Y4YPElE7kLSnQv0ZRlIx8cDh5TZwa1C
         e+57il2Yb7TIzMpXvV/VO8G8VmEyFjK0c4ldGe5XbX+Yw5Hy97jt8qj0OviDpbpXIVGf
         rmaLFq0cJwmbzLHolRvawypVYWZ0GvRM5BVMVxO3flcB5EQ10dEswIHBGxAg9CyVAhMA
         EFlOYCML2jm7L9QJNnHdclaCTTlkRof0x+CrdcG4q5/kW6r87ddNAgeaCWqMNouP0SUM
         sDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j25aHBrSp+PLnNYwGkDcs4cVtf83TIUnbNmAIRsjS30=;
        b=oCyXvZ0a9vjol8lsrUeB1hw/WrtdhlDtjIcCOH7IRP0Qpervmq5+/t8kkw6+sLYv1U
         qWWLJIHC9Sh3Um+1iqj7iv1E01P/tttEGLUvz8WNMQOkjROVgRI5ghvezuRqxBilABAh
         1U9/lrfEHwFK5n+klSgc5bSL1vayxc9J2aFpK6O6v5qvQ/aW2GXTur5YWEqj5hg7FV91
         fouM30klHZR21Zj5N3297L0EgFPzoAzLdMGN2RgC9K22+DTK4WibxoGkZCM9SCFWgcmL
         Tc8ZWh2io3eEfLpN5wA+ec3z4fkcSwcpAbe0Wz86QiDjjLyPGaedr/EIDd4V+SScEgX8
         8RtA==
X-Gm-Message-State: APjAAAVJJL4vQHDis17O8e2cTVskUBLfBtztCXfuq67UAesk9ac7AXkm
        vcwPCpotw1hxiJPzk0kvc8UwzA==
X-Google-Smtp-Source: APXvYqx57pBPhr5pgOEGXkEkMcfaUsez0zdLAk8K+9p0joCHdqGJiqcGV7xYsa+Ooyzuhqu8r+D2pw==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr17529362wrn.386.1578915926630;
        Mon, 13 Jan 2020 03:45:26 -0800 (PST)
Received: from [10.202.0.7] (d5152e8e2.static.telenet.be. [81.82.232.226])
        by smtp.gmail.com with ESMTPSA id n14sm13469749wmi.26.2020.01.13.03.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 03:45:25 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Allow userspace to reset IBSS stations to fix
 aggregation issue
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
References: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <a7fac744-8894-ec2a-7d94-68f4f3f8500c@ncentric.com>
Date:   Mon, 13 Jan 2020 12:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 03.01.20 11:34, Nicolas Cavallari wrote:
> I encountered the same issue in an IBSS-RSN network, where quick reboot
> of a station would cause issues with aggregation because the kernel is
> not aware of the reboot.
>
> I figured out that since wpa_supplicant already detect reboots, the
> simplest way to fix it would be for wpa_supplicant to reset the entire
> state of the station in the kernel, instead of just resetting keys and
> port.
>
> This means extending NL80211_CMD_DEL_STATION to work in IBSS mode too,
> just like it does in mesh point mode.
>
> Changes:
> 	v2: Use a nl80211 feature flag instead of patching every driver.
>
>
I'm more than happy to give this a thorough test on dozens of devices 
offshore

which I suspect are suffering from this issue as they sail in-out of range,

but as a new flag is defined in nl80211.h, is anything additional 
required at wpa_sup side to use this?

If yes, please also provide a patch for that to me directly. (based on 
 >= v2.9)

Thanks,

Koen

