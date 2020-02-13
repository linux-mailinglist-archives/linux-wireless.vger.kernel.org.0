Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54515BBC3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgBMJgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:36:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgBMJgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:36:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so5754224wrt.6
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 01:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tX5rJKBAp2Qxh3U8HlZbaGn5I6znsXHyFtFR1sVBDKU=;
        b=YwWqDf2uFNsCbDflv75bdKzadzcupzRDjQiTWuhWL1rQ+FE2tMHoxZFfXiUBepgogY
         yZInsOXB9mevVp9yBDT7oFT/rbMv9Jgf1MUYlhS4f1q62k8eaQBELNwOMUqk6+UFCRoa
         uTbC5z66FthY/MpM4V73FD+qzLTk+Gt/exnV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tX5rJKBAp2Qxh3U8HlZbaGn5I6znsXHyFtFR1sVBDKU=;
        b=WYWbR/1ydXDP/tvU8JPxiPN71x2vYwTE8bAfEZ2EvJTY492EdSJSiZUdCxAVSCajXL
         qbwb90EhFQVDlnR5G9FBKioimN/a0zkEi7NuSAVYTgzEkv+8TgvCCO2pseSLRCH+WXja
         7g51Q3Zw/Y4S+PyA8jNrHpGNmr6mQ3af14i0aLZWnq5Z/DMgSn0+43l+JNEhSjnmmMYB
         hKO+1BpxI6co5nE3/w09XzXEd+E8/S+zMTYZgAnb2RSxcaJT9Ay2AOvUYF1JSQfzUDpj
         WJcVrQoAHvpcc7AcqF7SiM1XguZCXm7PfyZvMwQ27z6A7wxpCudllV/y8zpLIlZW6ewX
         oP7w==
X-Gm-Message-State: APjAAAWIevJzg7uK5U8Ih8HzU39lST3syjqeBASaGbT/Fy3EmhJFhR9c
        1YdSoxdpw53dHvhI0wE2PcYQ3LfvrouMaQ==
X-Google-Smtp-Source: APXvYqyG8VmFC6ccVupYuXJlhVd6QOurJ4+Vz68AI+zcTDy3fUxpBs4yNmCUw+LeMMW1BqXtIr7qKw==
X-Received: by 2002:a5d:6388:: with SMTP id p8mr20534034wru.299.1581586578248;
        Thu, 13 Feb 2020 01:36:18 -0800 (PST)
Received: from [10.176.68.75] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 133sm2346064wme.32.2020.02.13.01.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 01:36:17 -0800 (PST)
Subject: Re: [PATCH 5/6] brcmfmac: add USB autosuspend feature support
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
 <1581583476-60155-6-git-send-email-chi-hsien.lin@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <6c7ab88b-658c-369e-7290-57f0c9bbb03f@broadcom.com>
Date:   Thu, 13 Feb 2020 10:36:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1581583476-60155-6-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/13/2020 9:44 AM, Chi-Hsien Lin wrote:
> From: Wright Feng <wright.feng@cypress.com>
> 
> We add enable dynamic suspend(autosuspend) support in host driver. It
> can let platform cut down idle power consumption. To support autosuspend
> feature in host driver. Kernel need to be build with CONFIG_USB_SUSPEND
> and autosuspend need to be turn on.

You really have to explain why you are killing WOWL here!? I can come up 
with a reason, but better you do the explaining ;-)

Regards,
Arend
