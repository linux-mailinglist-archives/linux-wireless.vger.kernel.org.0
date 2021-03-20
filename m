Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D527342CCE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Mar 2021 13:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCTMj2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Mar 2021 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhCTMjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Mar 2021 08:39:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE243C061762
        for <linux-wireless@vger.kernel.org>; Sat, 20 Mar 2021 05:39:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 12so6851632wmf.5
        for <linux-wireless@vger.kernel.org>; Sat, 20 Mar 2021 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UbCSqTWpADea4Qpj64GSBd4Fyu7PfGfXvdh3FJ6m81M=;
        b=SLAo1HNkq+G7xvLZSx9YVfEBh2kA541LzdZM3Wapa8ifqX0d5BOF+oMCwJEbUreWlr
         E5AKIIOsZLoyoYDjFc3ROIkLd1aJf69iN8Zyb6gflpCT0znsCjiXlISGTga44ATHdYQH
         wBrOhC7F1783OZMETmLSz361anPHumoyMRtPLpcGlEW/QH+DgzpT6jzjqOOJjAR1ah/m
         csMU7OAbmsQr4ObXemTdOhUoA8FdWbWqVV2oACrnD1c6pZAtxN3JmsVev1ifP/lsUH4A
         zPzKRdkHLj3XBH74Ih+3SDsZsYs3MAtfxwj8EF8fegicftMlgd0oR5iLrm0v+B0aWQpa
         ZsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbCSqTWpADea4Qpj64GSBd4Fyu7PfGfXvdh3FJ6m81M=;
        b=ApUqeNezAvWEEp4/IKn7Cf/Ic33bst74Kj98oHOeZ6DFaTLVPxwWCPFcoLGwSQ0SWD
         u/pW27xk+JBtPUkLe9ad9d10PLIPQt2XCrqcFyUIPZXknvvYSUWOQlEPTeoawzrhx4nb
         VBOcrPv89aaUJmcB80mESTN6DzMuAEwwiaBgIiQ+EfgNlttc2kG1RCqaJGLhufmnGrji
         LNmHiKkSgTD2cxA6NajXPGb+ZxJpgW3ZHrTOIMJxxRiwJoz1kwUaGC/0Q26re1N0S4vj
         Hk7LDth+uzWE34k2IOQEK+mZuvLt+ZPYBgvl1HfoxLMFoCoUyh40hecYf5bW5r3dblL/
         /78A==
X-Gm-Message-State: AOAM5300psMZpWflkfwa9WBFpe9WjoBw5+nIaGwnHOuvPVhA11WHb4v4
        ML/LBJsGzTFVjKfnS9ITGK/CoQ==
X-Google-Smtp-Source: ABdhPJyyRNYCFe6xES40bgtcU52pCGTl+CgHBXrLZ1aCAvpeHfVublwbnryCJSne4nHXvjnJBAujZA==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr1429157wmq.96.1616243958434;
        Sat, 20 Mar 2021 05:39:18 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j9sm10334016wmi.24.2021.03.20.05.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 05:39:17 -0700 (PDT)
Subject: Re: [PATCH v3 02/12] wcn36xx: Run suspend for the first ieee80211_vif
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
 <20210319161520.3590510-3-bryan.odonoghue@linaro.org>
 <CAMZdPi8ahq61qOxyjci4KyMANGxSt2oey2y1U=NNOKs1Mu+sPw@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <db054d84-b1d3-090e-b15f-96cb1bc46fcb@linaro.org>
Date:   Sat, 20 Mar 2021 12:40:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAMZdPi8ahq61qOxyjci4KyMANGxSt2oey2y1U=NNOKs1Mu+sPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/03/2021 16:57, Loic Poulain wrote:
> You mean connection can only be maintained (offloaded) in suspend for
> only one vif? 

Just the one ip.

If so maybe what you want to retrieve is the first
> client-associated vif and not the first vif.

Hmm, yeah OK I can see how it might be the case you need to do that.

---
bod

