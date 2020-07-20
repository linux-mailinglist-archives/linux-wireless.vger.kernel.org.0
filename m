Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4254D2262BC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgGTPDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgGTPDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 11:03:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727C7C061794
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jul 2020 08:03:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so18172327wrp.7
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jul 2020 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WsZ3b5EwA+XYQ8T9G5wJcefwB0ujsGqeq6v3Egs7+Ho=;
        b=yI3IJWEJIKD+ADPNjTuaegdrqgDg6pFT8Acs+AoLi1GhE3GzaJyn6QTju346cepQUL
         qrKkKdbPvACmtXW/etJVFvIG/uqtXHK02htGZ31mY3b4gwx6A8WBB+vELmM409i86OXP
         PnX51ep4jhgOhER6fmVdNRnInEg0Q7SndPM8q5p9giqgNIHr/QLBcnNHfWxIY/5/9h3h
         NxkRk2OaVwdev8+7+KbyJdP/3im7GFgygYfly0LattGpIGo7xiHDBp8kIo0BMfuXL8xP
         yOGLsAf7qLKZJNWhiDhdWgr5fJDOPfaUnow3WaE4wal1w4SG/8U33MTp/XH8q9swiYqq
         Bekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WsZ3b5EwA+XYQ8T9G5wJcefwB0ujsGqeq6v3Egs7+Ho=;
        b=AEpUgVgcvBypkLTf9VxTgmQ71G8CsEAprs8Lau4QQo8At+qDYk9B0sllh+MLRkA1dD
         ZiemuHfvZYu3YZHZmWAXK9gUyYmuDYko7OxyvCzWGU0NrKzXIaLVSDM8ww6BO//kZQAo
         yANr5b5KAZu0yE4+jFkk56jxRNvwR5ApwUj5qnmrESYANBs44K7vYt3VIn7P7Sm51MBi
         9yZ6RATUf6VBXE+4MaPJLweiCFeE2Zpd3kC96C3ZoZhi697xVyPwAJSRwehKC0dwCURA
         O5vysmXTKpm5WOoQXUpc8aet2nypGF6SgyXCpNJuUxzgri6/qjx/sTRTmGa6sokLMvGC
         x5VQ==
X-Gm-Message-State: AOAM531VRlVBEBv0KLajCk6XM6Grq6tXFLkj5sgFnEMBI1AcGXXoH/2p
        FrAxFjdbCiuolP+lR9m4vFhz0hQHRZg=
X-Google-Smtp-Source: ABdhPJx2udXdLYC3OBvwUxSdxVGGoR/au69dx75tlUGf4OdR5os1xLssrPAHHh9YBm76IuVgcy4Czg==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr23352558wrt.191.1595257429835;
        Mon, 20 Jul 2020 08:03:49 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z10sm33643676wrm.21.2020.07.20.08.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 08:03:49 -0700 (PDT)
Subject: Re: [PATCH 1/4] wcn36xx: Fix multiple AMPDU sessions support
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <190b95a9-a5cd-f009-b696-31922198b47d@linaro.org>
Date:   Mon, 20 Jul 2020 16:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/06/2020 14:46, Loic Poulain wrote:
> Several AMPDU sessions can be started, e.g. for different TIDs.
> Currently the driver does not take care of the session ID when
> requesting block-ack (statically set to 0), which leads to never
> block-acked packet with sessions other than 0.
> 
> Fix this by saving the session id when creating the ba session and
> use it in subsequent ba operations.
> 
> This issue can be reproduced with iperf in two steps (tid 0 strem
> then tid 6 stream).
> 
> 1.0 iperf -s                                # wcn36xx side
> 1.1 iperf -c ${IP_ADDR}                     # host side
> 
> Then
> 
> 2.0 iperf -s -u -S 0xC0                     # wcn36xx side
> 2.1 iperf -c ${IP_ADDR} -u -S 0xC0 -l 2000  # host side
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---

Getting a few checkpatch errors here

CHECK: No space is necessary after a cast
#44: FILE: drivers/net/wireless/ath/wcn36xx/smd.c:2112:
+	rsp = (struct wcn36xx_hal_add_ba_session_rsp_msg *) buf;

WARNING: Comparisons should place the constant on the right side of the test
#45: FILE: drivers/net/wireless/ath/wcn36xx/smd.c:2113:
+	if (WCN36XX_FW_MSG_RESULT_SUCCESS != rsp->status)

total: 0 errors, 1 warnings, 1 checks, 116 lines checked


