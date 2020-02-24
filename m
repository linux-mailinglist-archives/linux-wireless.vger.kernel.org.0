Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6157C16ACBA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 18:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBXRMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 12:12:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44493 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXRMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 12:12:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so9622672oia.11
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2020 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+GNuxHUjS1OhTeWUDOCxGd3U/53gljl7oUhXw24H0I=;
        b=f7fb43DqDz9qnbeVe2H2n/FsvSMFdvJjNW1n2odYLX2kcji3SPgifqGCSTBvCjR1v0
         HSzeBsGRgxiNJehbEBJghJ21Pd9DoyKENjpOeiWKg5VgMQRACjn+HgvmR52soISMcPCr
         7ANvwhfgp31sMKpHA87aylRX7CuSKwCWXYx08JjlJfjbnRh8cND2jb35/WMLClXRp/UB
         p8A7UpqPqY5SesIMH2ad+HY3nHfLPE6cB7SyXuRTdmxI/B5Qi4UZf0Exm0GVe9oaVGXu
         bfApgwd+l4sOLxLaovGgiHkvlWoXRa4rQbPYxzKxs0tQ/QpR758tQwv+T5GXA/EcGBCt
         qEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+GNuxHUjS1OhTeWUDOCxGd3U/53gljl7oUhXw24H0I=;
        b=uI0igyoU0ZHMqoeULIm1OtYd2lS0HoXkRbQ3kNjAsphuiB0LiXZUD5KbpDZ6Yq2S7d
         RYG2qi6VLhCuFCztnBzWeqlU+UjmdEf73QVBaV/k1KQ9Loy6BOyCdnTefD+KY5Ii7dwN
         IAmAjjTf6TG674qwZhuStxafnQpZxinHxMGPpgbC7og/qtOX9NfMkYqlGiBAA9Tt/lfk
         VjEhn/8rPO4SCUJ6Q7k2gQfYnRVJWW2oPx7BqxFSgVkG1y1H9+iWAFcDmCZ58Xw6XmtL
         qYb8ZWwYugLHx+Cw3VSomzDtMwO6RUU+Fnrh7W1+CVI4Gcj42JIFeiEl+uP+TMWXURni
         83yg==
X-Gm-Message-State: APjAAAW7BTdNwTUyR4rpuOF62O4x2Dp6AxeEEsKKyd1VqmdCT/vwxUf6
        nQB2ofMWMCTihJbrZMDnQIJ/d2ZO
X-Google-Smtp-Source: APXvYqyvZ4yPOrCoCNYLWrOF1mkqenY2K3UNiKzNTbX4I7B6mTS64dSwLqLBR3jD51oM/0jee+E0RQ==
X-Received: by 2002:aca:120e:: with SMTP id 14mr26880ois.135.1582564336069;
        Mon, 24 Feb 2020 09:12:16 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w20sm4593482otj.21.2020.02.24.09.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 09:12:15 -0800 (PST)
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        Johannes Berg <johannes.berg@intel.com>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
Date:   Mon, 24 Feb 2020 10:56:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 2/24/20 3:19 AM, Johannes Berg wrote:
> As Jouni points out, there's really no need for this, since the
> RSN pre-authentication frames are normal data frames, not port
> control frames (locally).

Using control port for pre-auth frame TX/RX allows userspace to skip 
setting up a raw socket and associated bpf filters.  This greatly 
simplifies the rx/tx path and uses less resources as well.

So to me this patch set seemed like a good idea...  We (iwd) don't have 
plans to support pre-auth in AP mode in the near future, so this revert 
doesn't really affect us.  I do wonder what is the actual concern to 
warrant a revert?

Regards,
-Denis


