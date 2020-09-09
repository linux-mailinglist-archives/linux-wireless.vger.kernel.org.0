Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFE263367
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgIIRDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgIIRDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 13:03:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55871C061573
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 10:03:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so3738663wrw.11
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m51TriszzIYxuc1SWbPfpaHHdSU7aHqiYR8fjdaYfc0=;
        b=2F8wDB7iC7sBmBoIilaMlTVET1TpJBGl78yX2qHZFaOOB0smdz3d1bGFOody3YfAbm
         mIoFCHW4SYJ1E2xMPlkuPMA+v43w2s9peDo/7GDBT4xts+0Q6fqG9riFymEmbSQgOn9h
         d7IfmT90r392jv722FYTJdow5+jZib3InN4n9u+RJinIiw5EFkiP1A9Xt5g3allLaYYT
         LPD4i8dBs9TC7+SsNlW724uM6kwju41WPgRoww7VrbVW6pI5k9okBGE+fVZT54Qk4m4d
         j96Bl4TTnIAZ9IlfCoMacG9YqD/G5g4ZWNEhZxf1K3jnmi/H3blkLjFCzQTBdEmtMPsn
         yiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m51TriszzIYxuc1SWbPfpaHHdSU7aHqiYR8fjdaYfc0=;
        b=C5Hr08h65flMcbeCD4JV7En48F8lWsnXaDCjFxXp8ZMifglTBNDleIgNNWiRY8gtom
         JxoXEXFQZhFef0HRvho9k2RfYy2OsNwEk+jDTxDHST3DC0OkTF0cmppGhe6HjQJvKBcH
         Pqlw8X5T40GYMruOrQPNWkLuClpZzBt3R3DqCAiz1oYw6LENup4r4fFiYQwN3cjH9kSt
         vU45N9Gxtm41tBZYqUgArU6+8zz1O7kfFesSujU5vWdcZ9IJwhEDtU6xY8kq72MNYwv8
         6z0gSvh+lQ29YPoeZqw5l4TzOeiteupHuFsFDjz4glgmZ5M3Ris3GSPiv+W9PcWpxmNk
         u4Rg==
X-Gm-Message-State: AOAM530jMZYtlFNcucO1fBJzGoht5P/56Iw1PG2GXaz+uF6L3eKTSmcJ
        Jf81vIFCD7PngwUoMhMmiyxfOQ==
X-Google-Smtp-Source: ABdhPJwByMKselcFKjbR6JGRtEsKfq9Xj12GWVUsDvN9dE9iRaIfbbYgewsfOgunDtEZV96E9tidVw==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr5083456wrw.101.1599671007128;
        Wed, 09 Sep 2020 10:03:27 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d2sm5544352wro.34.2020.09.09.10.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 10:03:26 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] wcn36xx: Enable VHT when supported
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     shawn.guo@linaro.org, loic.poulain@linaro.org
References: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <01601cdf-66a6-6362-3710-93cc02ba1c89@nexus-software.ie>
Date:   Wed, 9 Sep 2020 18:04:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/09/2020 16:37, Bryan O'Donoghue wrote:
> This series is six in a set of seven to add support for wcn3680 at 802.11ac
> data-rates.
> 
> These two commits have been moved later in the set of commits so that the
> patches to enable advertisement of VHT capabilities happen after all of the
> supporting code has been comitted.
> 

No idea why the rest of the patches haven't turned up on the list

Made it to the wcn36xx list..

http://lists.infradead.org/pipermail/wcn36xx/2020-September/thread.html

I guess I will resend the series but, slower...
