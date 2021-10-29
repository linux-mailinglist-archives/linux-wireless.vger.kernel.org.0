Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A985E43F3FF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 02:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ2Ama (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhJ2Am3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 20:42:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DABC061714
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 17:40:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p40so2760495pfh.8
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/3/zU2CXtqxH4uObJNtO1IPDFEIaX70RwRGvT/y3Q8=;
        b=XtSaEE6gibGxlYqbVm1J4DQGTHkIDfTkcxnBXMWXB6kh7UTjqNoB6wOmzUpEmB/i4K
         pjqKE0Bl+Hr4LixkEhWebb94v8uSg6pHYTX8gETORbPSRimnuUI33kAOVTJGtjoj9vIt
         tJduRpPvcv8jHE4n4yt/BzJqXjZFxG+bpMDhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/3/zU2CXtqxH4uObJNtO1IPDFEIaX70RwRGvT/y3Q8=;
        b=sS0VgTyBH/NJHMGYdTqVPqrXDHGqEeqdy+IVVeF+liYLXk6XWGNSQDe8UXbtMJ0ajf
         3SjHPzsdMi2WcmzPZcENP5I1emWVRVxTdd835tLRk1c9GhyMisNSkm60ei2B/jJU1uP4
         NOn+UiJc6CgkhpQZnqK1v0FFQeeXejNgYZm9TjctamljeJJGUwbHMXuYmvnZmITFhNAt
         Zv/SK71BavQ6gCPFY/TL97EfMpmtF0rPF0iTwS9o8Vuy+6p+1S54zB0fBs4KXjtIg2Ua
         G3Dr2DoiWzyIJpLZDav6r6Qz7SheyVA4IMeZVbZerZniAKzXnTrd+2pfSKL6WnJ30yLj
         oqvQ==
X-Gm-Message-State: AOAM533vBFBh+JRtiKfl6dfySHdcQ3i5Ho9BdDN7gplArvFJFimgXXn8
        OSfCQD3Llm3dP18WIHUWIzjIOg==
X-Google-Smtp-Source: ABdhPJxK3mBHFLkooF9WIEqiTF2Lo7tSsk/o+Jjxn7VPMabG7lfc3Wh4mZV8CdT9Mh9cnStkmAw2kA==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr5679692pgv.425.1635468000985;
        Thu, 28 Oct 2021 17:40:00 -0700 (PDT)
Received: from benl-m5lvdt.local ([2600:6c50:4d00:cd01:14ac:e7eb:3ffb:f82f])
        by smtp.gmail.com with ESMTPSA id me18sm4025703pjb.33.2021.10.28.17.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 17:40:00 -0700 (PDT)
Subject: Re: [PATCH 2/2] wcn36xx: fix RX BD rate mapping for 5GHz legacy rates
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211028223131.897548-1-benl@squareup.com>
 <20211028223131.897548-2-benl@squareup.com>
 <b3473977-5bb6-06df-55c3-85f08a29a964@linaro.org>
From:   Benjamin Li <benl@squareup.com>
Message-ID: <631a3ab4-56d9-5c1d-be53-c885747e3f7b@squareup.com>
Date:   Thu, 28 Oct 2021 17:39:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b3473977-5bb6-06df-55c3-85f08a29a964@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/28/21 5:30 PM, Bryan O'Donoghue wrote:
> On 28/10/2021 23:31, Benjamin Li wrote:
>> -            status.rate_idx >= sband->n_bitrates) {
> This fix was applied because we were getting a negative index
> 
> If you want to remove that, you'll need to do something about this
> 
> status.rate_idx -= 4;

Hmm... so you're saying there's a FW bug where sometimes we get
bd->rate_id = 0-7 (leading to status.rate_idx = 0-3) on a 5GHz
channel?

static const struct wcn36xx_rate wcn36xx_rate_table[] = {
    /* 11b rates */
    {  10, 0, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
    {  20, 1, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
    {  55, 2, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },
    { 110, 3, RX_ENC_LEGACY, 0, RATE_INFO_BW_20 },

    /* 11b SP (short preamble) */
    {  10, 0, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
    {  20, 1, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
    {  55, 2, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },
    { 110, 3, RX_ENC_LEGACY, RX_ENC_FLAG_SHORTPRE, RATE_INFO_BW_20 },

It sounds like we should WARN and drop the frame in that case. If
you agree I'll send a v2.

> 
> ---
> bod
