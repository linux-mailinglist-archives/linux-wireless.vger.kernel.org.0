Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9393A6A88
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 17:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhFNPhS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhFNPgu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 11:36:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD861C0617AF
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jun 2021 08:34:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so226592wms.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jun 2021 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l2r3lTNujXPT1Pt3lY5Wn6NzvguvrLiLnynNFlWVFnI=;
        b=mV63KMMpYNa+/oNAxcuPguybi0NLXwqj+8a3Tz1EPkBbnkQuHwU8gW4ObB5zMbJ3OC
         zD6hgrAhKu8NqNuHgz3BR8KTFHbCgSZEcmT3yaR5hcmuHd0Dnj/MiwdEeTHwg+mXbjD6
         684l7YuthWQZUIewvZfEpJSYQ9SmHzqq3C9sdEki44B0Y4/ZJ2ddCETUUGQgC/i5v1Ts
         uh1Ol5MlkoCHvYLiRpGUClKgRmeGaA1pLGljIwgvFH1Vy9zd23aliFeEAWsj37FeOGeo
         CO3JZBd9T1kK9nIdPe72FWklvAC1NavZlflr3W2D1EiZXx6v+McUJPAbmoUpeGE5b7Wn
         j15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l2r3lTNujXPT1Pt3lY5Wn6NzvguvrLiLnynNFlWVFnI=;
        b=kusVs960jXBBt+bYVpkCHQ6D6W7BwH1pbdbZxS3uCrf0snWUD9zse+rCVt660HXByw
         lExtUCMdf6ZzTToFdbqW97zzSBQwNhsgeovQsX+I1Hc9egrlsV4tcBUVjO61ayOR42gw
         2cgiENL3vWJcthWFTjrvXiBxTMddz8KlEPS7psyIY1KRWDLngxhl1Yy+4dMsvE1HlBgg
         MCvX/pVmIgrX6rQKp2xVDlz0RvMRFGMA9yWmceAiILMxHAJzAltjA9BwVLcNyWqhDJBc
         1r8qyDaxZLUav7095LgXMg7eaCRfny/9kK1nLJ0yRoii5jlxuRIiOOYPNVelpkH1Wpte
         jX2Q==
X-Gm-Message-State: AOAM532hB92vy5ShVNkp3JoXhOr3o9JXDghTyBuC07ygYio6o42LJaG5
        KaeqakmAV/G/e0l32u2ji5pCAg==
X-Google-Smtp-Source: ABdhPJyJnA3ETEQXZGqrcMGk5mshBEPnViV9GmmBbZGN8iEZgnujIbwAY5NVZepMYYazWgCOCax5eg==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr17123585wmq.164.1623684881364;
        Mon, 14 Jun 2021 08:34:41 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u7sm19497231wrt.18.2021.06.14.08.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 08:34:40 -0700 (PDT)
Subject: Re: [PATCH v6 01/12] wcn36xx: Return result of set_power_params in
 suspend
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
References: <20210605011140.2004643-2-bryan.odonoghue@linaro.org>
 <20210614151850.9DCE7C433D3@smtp.codeaurora.org>
 <87mtrsmprx.fsf@tynnyri.adurom.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <eaceab2f-baf6-4843-ac9a-cad4870c70bf@linaro.org>
Date:   Mon, 14 Jun 2021 16:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87mtrsmprx.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/06/2021 16:25, Kalle Valo wrote:
> BTW, I'm not sure about CONFIG_IPV6 checks but they looked minor so I
> applied these anyway. But can you check them anyway and send a followup
> patch if my hunch is correct?

np
