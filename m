Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FFB15BC3B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgBMJ5E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:57:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46960 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgBMJ5E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:57:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so5814962wrl.13
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Li09EdzO5jbBmqdxavOWp4SyVF96q3h2o5vuIVijUo=;
        b=huzQpsCfA3LC2iTFIXi2I9Ty8lp51GYtXQ7NdWZ6JHTHbgEVmUJ5irzSN0B4WGU7aa
         6uQljHtDFoH0UUGNMqKibFOpaONkMnKSqov/scmt0Uei61dIQrVS0CE9es1r9kzEY+C8
         IOTsIxNWz+kolIyA5sOf9A17kG4K28Jl6Zy3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Li09EdzO5jbBmqdxavOWp4SyVF96q3h2o5vuIVijUo=;
        b=EnzGfv/74XVdidYLvWnCaohOrFo6dXhuPjlMArqrOqs+pcWE+VvQwazVtveeZeK5Nk
         YxPcB2v0UhSy1vfam+4tgewYpXo9mSJ8anOWKFXAS/SwjzPcVTA9GOMWT4bCaY/wRmOy
         fRXxUrB7s7JcDMteQPim1J8sPA4PCTDpszMusw3RapCFUGfmB9j/8HJ2KamJlrZxThkv
         MDwZrPkrU9tqcPoOQtU1ApHwWFn+Bag3dKdU9++DT0Z/3mWHA4K6xo6okFyI4zEux7xu
         GVJlXn+sGaB+hYpUWcZVlR0x3qsy1r9lZpTu360RzhcdgEIbR3Fu1KEssDpXe2DxgJJB
         EbKQ==
X-Gm-Message-State: APjAAAXuXIrQ5f/3SyKRJiPFq3IMF6MZiO+KRQ6RkF9ww4u8yHgwFWt9
        lsc/gfEjxrqJAmJYhz/AGpLUKw==
X-Google-Smtp-Source: APXvYqy1z3LMx6AlWYzHAfX5wVpJaPc5owv9fD7CCrF+IgOUSa6onPfj7hORcNSfYXXYmWLUYqK+rA==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr19968440wro.22.1581587822317;
        Thu, 13 Feb 2020 01:57:02 -0800 (PST)
Received: from [10.176.68.75] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id t13sm2184951wrw.19.2020.02.13.01.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 01:57:01 -0800 (PST)
Subject: Re: [PATCH] rtw88: set WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL, mac80211
 supports it
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        anbeltra@microsoft.com
References: <20200213050819.13467-1-yhchuang@realtek.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <3121eb67-f303-01e4-a006-a39947381175@broadcom.com>
Date:   Thu, 13 Feb 2020 10:56:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213050819.13467-1-yhchuang@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2/13/2020 6:08 AM, yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Set wiphy flag WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL, because mac80211
> actually supports it. With the flag set, driver can accept ROC
> event from wpa_supplicant or some other user space tools.

This does not seem right. mac80211 does set this flag itself when the 
driver provides remain_on_channel callback. Does that mean you already 
have that callback? This patch is either wrong or unnecessary.

Regards,
Arend
