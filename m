Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233FA2D6B4B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 00:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbgLJW61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 17:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgLJWzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 17:55:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17BC0619D6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 14:42:32 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c79so5560208pfc.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 14:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zj7O+2GPMtNHh1VwpqxRgZhr5C1chINLeB/L32si7wM=;
        b=TDmRoAL40IcqoZTwQUAALcKuC511BEzpC3bCxxbefXmo5cWc2ec371dO9NHwvrbwS1
         4u5JBuZ4ZAhNsaP7sGoEiaodrNhQxw3LT/xLB+pDf4GGd2FUWnuybUJyoewOndtOufec
         0dHnCi2lRzd74SnlmZC7VQVQ+jYPJtPvbOiVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zj7O+2GPMtNHh1VwpqxRgZhr5C1chINLeB/L32si7wM=;
        b=IvCOOa+sGBGpMec2flxt6tJMEpsB/Bs+NBnToJWKxIwPJPwIXnzkU6zayF+lDo1EjF
         hfdFYc8ga+gJGEcNpOBdKYbGSCzmHrkt8m/+Yb6gCS2/MRB6/9QtZYUdua7fablS/r/Z
         93/qe55poR3eDuOnqDaF1XmaHcwuO+7NCdBAsBZgm2D4L5axIb+nC83facnQPP0qDUNX
         a3TfHozBJ0sfsiZ/hpQ7uAZeWRAIgvMAQtpOcV6suUu/vhM0Z50dmNfj6klwxeObufHe
         EYXcoIwxg+6olo3Za/Kyh9Eg+1uHbEfbDSXkDBWrzxqQw3PK/pqhqEeF+V/j3x2jI0hB
         BJUg==
X-Gm-Message-State: AOAM532t7JqOBOmy3oF5zWyZgHOWJlbP55TBcPmMlNQEmCcbo4EhzjlH
        dyB1akkFYMlcM/dnqQL0ucwwJkVeL3Y+xQ==
X-Google-Smtp-Source: ABdhPJwIKjaoulhKhKh1ZHV+ZTsnXT6XA4d878XxHG2jyQRw3dORxlDD/ho6/xvLMmChgr3RPUI8eg==
X-Received: by 2002:a62:6c2:0:b029:19e:b63a:91e9 with SMTP id 185-20020a6206c20000b029019eb63a91e9mr5375126pfg.79.1607637889089;
        Thu, 10 Dec 2020 14:04:49 -0800 (PST)
Received: from [192.168.4.200] (c-76-102-118-9.hsd1.ca.comcast.net. [76.102.118.9])
        by smtp.gmail.com with ESMTPSA id p6sm7731196pjt.13.2020.12.10.14.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:04:48 -0800 (PST)
Subject: Re: [PATCH 5/6] ath11k: pci: disable VDD4BLOW
To:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
 <1607609124-17250-6-git-send-email-kvalo@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <d9b860d3-4ccc-f16c-9b0c-e0e7a0646e64@eero.com>
Date:   Thu, 10 Dec 2020 14:04:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607609124-17250-6-git-send-email-kvalo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 12/10/20 6:05 AM, Kalle Valo wrote:
> From: Carl Huang <cjhuang@codeaurora.org>
>
> It's recommended to disable VDD4BLOW during initialisation.

Can you explain more about "recommended by whom and why"?


Thanks,

Peter

