Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1F4329DB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 00:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJRWvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 18:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 18:51:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E6C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 15:49:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m42so10040244wms.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NejxxJSVx+N7WvGawaw2wRKa17AkR5l45WNynzXJxIc=;
        b=kFwG9hhEfiyn5qL4AtyLPH6/YRyGVuELvA2RsTgWZfm5O5Zx3kdQ0Qcncb4L6zJ9Wo
         mydxoF5pm0+5N25rmAFOX22I+n79BdsNYP12gkzC279VNuL2y9ibN3rMOxNT4roTnd2z
         2CBgGP35EB6JPgv/j7THBGq5qZ787DCcQQXEWUIhOLiT420anb//jI8ab7ZrFEG9Jqqw
         IkyG/4HEL3+C+Rc6wn4ytg5tZTrWBSZ/tr2b448V6bAvLrH8brmS9ABNMLkBG1xlE2re
         DhWE0klMX2ojW75tXVQ0WYr+fiEkJs0a8rtL7IKWGVPO/c1tvWyEOEoOEniiw45Vvjor
         BamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NejxxJSVx+N7WvGawaw2wRKa17AkR5l45WNynzXJxIc=;
        b=teIDmhYsLny3bqe3KcnhfmgOukC8YC/bPKXqvfbPyVaDstn5DTlooWhzURts0hIrn4
         mDvxGmJKXhIJHWPaQxPLvzKyLwwPfxYkznlEAtEpi/jnYE6ZorI85GxqXWIgJn7Nqz16
         y7bm5kX/+iIDk1YTT82fVz82vXmNMWjHljWs0LcH4dQBebJYRzETLBD1f1QTTffp0iIa
         nRPWBNBz7uq0rSJe81YfhskTjvUWcJOuqTZc9vAXM6+em8+sAvvgAUTc7xGa41bI/hjW
         tiFQm/dXXVskIkb2a2FEkcYKM7NHNmRh9nAFEWQ7Zk/SfjWYSQtJfBPyR1wE59gKbY+0
         MqeA==
X-Gm-Message-State: AOAM530I9UwBdAiCWiydfd+u0QSui917EGF+pI/rSGqPaa9XxYLVKwW0
        A3Bz+RmCHbsHVVK6xBfs28/swtFoG3cdyg==
X-Google-Smtp-Source: ABdhPJzjn0PXrS+w/lE3q2cg0o9jV6Hxd1kFNZ9dsDIOUn/zwGq2uywPCagu48bvvS/xJ09Y4CMdqg==
X-Received: by 2002:a7b:c393:: with SMTP id s19mr1939169wmj.13.1634597368719;
        Mon, 18 Oct 2021 15:49:28 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r9sm13204450wrn.95.2021.10.18.15.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:49:27 -0700 (PDT)
Message-ID: <d2128789-646f-1e02-0dd2-a9ac14b37cf7@linaro.org>
Date:   Mon, 18 Oct 2021 23:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/2] wcn36xx: Correct band/freq reporting on RX
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1634554678-7993-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/10/2021 11:57, Loic Poulain wrote:
>   	    ieee80211_is_probe_resp(hdr->frame_control))
>   		status.boottime_ns = ktime_get_boottime_ns();

I think this is dangling in your tree, doesn't apply cleanly for me anyway

Other than that

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
