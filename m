Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54CB45946D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhKVSCL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 13:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhKVSCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 13:02:11 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463EC061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 09:59:04 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id l22so83913660lfg.7
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Gko20DS1AZDMNnuAhnKTds8S3OUfVzVKr6Ai4EtHDgY=;
        b=od268HEAyAG6omdAhFW36mjc+TQ3DOz2cZ8OcvJm1lKz/WouAcejdRomllgHKMaZRi
         PdDmbb9RFd+SRMWfqH0wjG9RFdRqg/ba7WI5A9vpJQkKAMO4vpSBFi9R1pL7Xq8vh/ps
         0+bLK4rKKizIU3ewRtyWAuTo0KiifRnXSHzFh1IWltuJvQqfo1EG48WKJdqG6aipbeOj
         34lYIQ+vrgGXv1GLgDfgOzVvGRp7D04rSYgpg3RP64F1UWUyoGX4uW2Hzxghxbd83FJf
         wwrvjlZxgE0MrSD4UdnNPh4puVamS1iI8OL0jXtZTzR48k9gUV21fE7K8MpuBVMt+rNX
         6NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Gko20DS1AZDMNnuAhnKTds8S3OUfVzVKr6Ai4EtHDgY=;
        b=wkEouTvD42qAt1IfFaBXvHWdm5GHYFycyMfi5AbyolZfHgOAWS30CuVwJrj2Pxf+JY
         0o3mKubTkI0lJ0DQc5rACVeLkfUldzoYSImfkVvnarcsjTNdbIUIaBFuOIMFf5FiC8GB
         Pq9fE7ldHnHi3L7tM1RjnBekb8VHMM06G6erHGF0I0YerPGyv+etw4ptZMLxfyaIIEjg
         UC5UxrOOXGQmNCgtFZvk3SVti/B2ASWP083YKpcL3xHv2Md0mBd2dCuhR2aXYFMnho9c
         yf2wfUvZSeeCB8sBJHVT3DvdILoAoR76I17D2z7+ieji8VmmrQMV/9Coz7eZn+Qv+Bwd
         gOsw==
X-Gm-Message-State: AOAM532dSYlZ8MvSAgsOn2z0acfrGKC6pA6kyO0p4barfCi4DgU6thCm
        2wzsztg8W7CSmLDd8BeKTj9VskclYKptkQ==
X-Google-Smtp-Source: ABdhPJyGxpAfOgl9P8QMQ82zXTMzVAq8nHh2+R7/htbbbXz33Hxw+Mec7Zc6ARRsZxV2tIqb0XPoOQ==
X-Received: by 2002:ac2:4d29:: with SMTP id h9mr58142252lfk.633.1637603942278;
        Mon, 22 Nov 2021 09:59:02 -0800 (PST)
Received: from [192.168.8.100] ([176.59.41.199])
        by smtp.gmail.com with ESMTPSA id c34sm1036390lfv.83.2021.11.22.09.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 09:59:01 -0800 (PST)
Subject: Re: [PATCH v2] ath11k: add read variant from SMBIOS for download
 board data
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wen Gong <quic_wgong@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20211118100033.8384-1-quic_wgong@quicinc.com>
 <163759171706.17469.3004620526954131593.kvalo@codeaurora.org>
From:   Mark Herbert <mark.herbert42@gmail.com>
Message-ID: <f237c04d-6574-ec9a-ebca-65d2d9ff9edd@gmail.com>
Date:   Mon, 22 Nov 2021 20:58:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <163759171706.17469.3004620526954131593.kvalo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tried this on Dell XPS 13 9310

Maybe this patch is good for 6855, but 6390 in Dell seems to be killed 
completely with it. Reverting it makes things work again.

[    5.537034] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb 
board_id 0xff soc_id 0xffffffff
[    5.537038] ath11k_pci 0000:72:00.0: fw_version 0x101c06cc 
fw_build_timestamp 2020-06-24 19:50 fw_build_id
[    5.537236] ath11k_pci 0000:72:00.0: failed to fetch board data for 
bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from 
ath11k/QCA6390/hw2.0/board-2.bin
[    5.537255] ath11k_pci 0000:72:00.0: failed to fetch board-2.bin or 
board.bin from QCA6390/hw2.0
[    5.537257] ath11k_pci 0000:72:00.0: qmi failed to fetch board file: -2
[    5.537258] ath11k_pci 0000:72:00.0: failed to load board data file: -2

On 22.11.2021 17:35, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
>> This is to read variant from SMBIOS such as read from DT, the variant
>> string will be used to one part of string which used to search board
>> data from board-2.bin.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> Patch applied to ath-next branch of ath.git, thanks.
>
> 46e46db313a2 ath11k: add read variant from SMBIOS for download board data
>
