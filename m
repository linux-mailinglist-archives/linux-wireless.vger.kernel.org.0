Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8896E1540C3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 09:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgBFI6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Feb 2020 03:58:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33400 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFI6N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Feb 2020 03:58:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so6155221wrt.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2020 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rqRO2t5leOuWXWXKq0CYaHScEne0D0q9iV8ZionQC/g=;
        b=cjSd8ug3HDuCNaU6baZR0o5ENMjpuVpV1npUvHqSu3x5Al72U+QnuBY6dtVgBsdwmW
         yb+Ru2QGqoyepUVk7xf+mt6hfYAmS9QJM7dXofKXJajINK+adeq9c5e11tHeSo5hL5ZU
         ++TxIGCJ68U1BHRgfzs9ZjixJ5FSGYLoychn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rqRO2t5leOuWXWXKq0CYaHScEne0D0q9iV8ZionQC/g=;
        b=nL+fKgiLRnMH2cqfvlmmXti0E7sBUDZQpdo1ej0H+Xoo3EsQ37iifPxT6yFkXPQb9K
         mrG7GRbMb8UMqX9334vmR+8xa3jB/Q+S07JkWaid9QeQazFDZ1agLzjM/Ewp0rH8H2fq
         BEWVRmKVD3neCFRlZwYqnugAYJH6hvt4sjqWsiom3fw9JsaSyhHYDFMq1DqdADBH9bGS
         Oe7s9/vq6O/PXruWWLPwuuCh+eSQala2CuPAblNHuZdNnJTDp21gDpOQQQwS9aQaoasv
         nf5S8ekZe2/poClRY2VnJyBCMjhdZKTmb1i6B2PO+CUATnuB8kag+BNS12G7QFCv6uFy
         qZNA==
X-Gm-Message-State: APjAAAU7GLYCe4gAQPm/G6z1Xe/Ec4hbMUKhQdAFSxGqv/HbCTvnCP1X
        S+TI7tKA1yXbzkGvU/Db6qCc/w==
X-Google-Smtp-Source: APXvYqwWpOsL0vkANDOEvE5V0aXs0Rz/Y7BUHCZb4EqIK6fydiGobzePunYFHD6UYA1xPLNfljw24A==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr2686015wru.154.1580979490860;
        Thu, 06 Feb 2020 00:58:10 -0800 (PST)
Received: from [10.176.68.75] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id n3sm2769091wmc.27.2020.02.06.00.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 00:58:10 -0800 (PST)
Subject: Re: [PATCH V2 1/3] nl80211: add support for setting fixed HE
 rate/gi/ltf
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>
References: <20200204103514.18111-1-john@phrozen.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <4bf4c267-bfc2-1a04-f2d6-541f086e72c0@broadcom.com>
Date:   Thu, 6 Feb 2020 09:58:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204103514.18111-1-john@phrozen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/4/2020 11:35 AM, John Crispin wrote:
> From: Miles Hu <milehu@codeaurora.org>
> 
> This patch adds the nl80211 structs, definitions, policies and parsing
> code required to pass fixed HE rate, gi and ltf settings.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> ---
> Changes in V2
> * add more policies
> * reoder enums
> * remove incorrect he_cap from ieee80211_supported_band

Not seeing the change listed above or am I missing something?

Regards,
Arend

> * remove _WARN from policy
> 
>   include/net/cfg80211.h       |   3 +
>   include/uapi/linux/nl80211.h |  28 +++++++++
>   net/wireless/nl80211.c       | 117 ++++++++++++++++++++++++++++++++++-
>   3 files changed, 146 insertions(+), 2 deletions(-)
