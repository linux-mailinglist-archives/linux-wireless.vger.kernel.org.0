Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2401048844B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 16:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiAHPqE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 10:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiAHPqE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 10:46:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95221C061401
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 07:46:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l10so17295546wrh.7
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+nUfroBA5dnOzmQt6qJzThSCFeTi3yMn552LUIzKkMI=;
        b=j0dA03crvqc2AxJFJDkwJuC7YsdxUkaH/jV/JJN2Jos9wA8mafZmV9kfK6HJHTy0UY
         X8br4266acaPNh1woC8ksjCXQK1PG3eJaicmEAXCKOEusp0LVvDlapC7+Euv4s8aZtn+
         +XieI3k/YTKmvyI0mHHmEfmk6eE6jH9E+nuMXHMicU7CDwNDwTINw6B0A5l2nXgbSykI
         c3Lo9sIJa1X/Brwir/lUb7YBRcwHL75fePHupfCFoLdOYb9D2UDO9aBqwAQwhkDDFaVS
         F9f2Ck0x5FSmel60zo9cmpHjk7kM2S2iQvZxJcQFiJR2g59J5maGpkTuSdFAhKKc8zrr
         XOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+nUfroBA5dnOzmQt6qJzThSCFeTi3yMn552LUIzKkMI=;
        b=SLMuZ1pqGKkvYsVtNyvEyZ2HkcnZKzv1HdfuWCFjEu0X3izxRBLvL1BLyXG3brofJV
         h4h5HgeWzZj5Pv7jWk7ygEROnN1CLuNUH45tvfx+gi6UYfsBQpBBzAZnRIA4UNcMd+Nu
         D+MZ2HU0i/cxNAzfw0NvFnflt6wmeDugWiwkkPNFNVmZW3L3ZdWjGRaocAbJ/kugGWUM
         eR+EMpDgyxSVIhYBwDqkxq3T0VJK4YAYw7FQzg2j1pnCMtDbhMI17RI6HAUSoROUGSU7
         4Emv5sqgZuMJGoIhtbdWoIEfDinp1Sb0cU+cLwuX2nXJzKsdt4rvnGFzrfAuWfdUvE3g
         eqcw==
X-Gm-Message-State: AOAM531/s61BAyo1McacGuhXxIYBFAgSZjkg1Jsg1/NuSCAjAqiHIceL
        LKjP50fA/Npf1NB5Ja5aqCOkIg==
X-Google-Smtp-Source: ABdhPJxrmoC2/r3N4ofOHzLqqYiSFPiGjG8H0UCP9omFngTKn6nvFQSOKG7w/shWu9mAyve08cUnMw==
X-Received: by 2002:a5d:6842:: with SMTP id o2mr55917500wrw.615.1641656762100;
        Sat, 08 Jan 2022 07:46:02 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x8sm1855348wmj.44.2022.01.08.07.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 07:46:01 -0800 (PST)
Message-ID: <6c44bf59-3ee9-3055-c2c6-cf497a39ca05@linaro.org>
Date:   Sat, 8 Jan 2022 15:48:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 3/4] wcn36xx: Track SNR and RSSI for each RX frame
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        loic.poulain@linaro.org, benl@squareup.com
References: <20220107153323.1807905-4-bryan.odonoghue@linaro.org>
 <202201081611.NwbnsnbW-lkp@intel.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <202201081611.NwbnsnbW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/01/2022 08:41, kernel test robot wrote:
> ret -= ENOMEM;

nice catch
