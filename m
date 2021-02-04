Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53F30EC56
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBDGLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Feb 2021 01:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhBDGLI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Feb 2021 01:11:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD5EC0613D6
        for <linux-wireless@vger.kernel.org>; Wed,  3 Feb 2021 22:10:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c132so1401463pga.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Feb 2021 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ll3s8aJPZrz+UhnuWvqlIOTSBpyJKVwbxKsSXsfaYzM=;
        b=SIc1tGI02dg9xjUK49V+JJ0o1PH3s3JQeCK8gfbynhIHtExaJfAtcXX3+Gz83E9Hkr
         XxjMqGffPh7snNcsxUYXAemCD+LagfZNywvzY5KwCQ9a8v+VgWKNRyYmuGqToLVsAOzd
         OCOw35520vQdO7noEEoBBvXa2woDKAbzZRhhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ll3s8aJPZrz+UhnuWvqlIOTSBpyJKVwbxKsSXsfaYzM=;
        b=SoV1xGYxZWUG6rAd454F5uk32JqmFtnqH66YJb5Fa+k41T5DEWyEC0kNC2Oj9oKhdv
         nqC/oLDQK7PLMFkWLMUtTGOjXP1FW4AbzqPB8q74LE7TSSD7SJw4hn9MeKjsB/VkGuNW
         h8Ex4EraQgm/ucveCR9XPSeGEglOtJBEvhJoz58oYLx8b0JrWbpPe9Wf3fpPmyV6X8Tu
         pjziEPwPOtPyJlMi8SFy+YkTTfXT0mqqzJbj0WI0kmu1ztLYegB8MKYR2h5zjBi0m6lW
         QOI1I+TXA0Sk0OIEYuA+lCmcUkIYyVtfJgLIZo9dBnBXEjRoVA6Dl+o5mLAtS0OS0UoK
         CBHA==
X-Gm-Message-State: AOAM530jYb9bKlfuMCDq8TRdsgxfzSKxPz4ODlKmcw79E3MWZ/T+O8+O
        J15zbFRy9u6Z4dNxK7/THAXkvpSz+kNnrHOv
X-Google-Smtp-Source: ABdhPJz1K4RcHoXb5h3ejfnw3JXA7K/U2Us0McmDN8DHGAgTVJCVKgei85RthlNzIzQuklbuqL+guQ==
X-Received: by 2002:a65:5209:: with SMTP id o9mr7287799pgp.34.1612419028078;
        Wed, 03 Feb 2021 22:10:28 -0800 (PST)
Received: from [192.168.4.200] (107-196-182-50.lightspeed.sntcca.sbcglobal.net. [107.196.182.50])
        by smtp.gmail.com with ESMTPSA id a204sm4521463pfa.49.2021.02.03.22.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 22:10:27 -0800 (PST)
Subject: Re: [PATCH v2] ath11k: Update tx descriptor search index properly
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1612410960-9120-1-git-send-email-periyasa@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <e6d1aaea-8410-3cfb-3308-4722ca8e91ea@eero.com>
Date:   Wed, 3 Feb 2021 22:10:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612410960-9120-1-git-send-email-periyasa@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2/3/21 7:56 PM, Karthikeyan Periyasamy wrote:
> Tx descriptor search index field should be updated with hw peer id
> and not by AST Hash as per the HW/FW recommendation. Incorrect search
> index causes throughput degradation in all scenario for all the
> platforms. so updated the search index field with hw peer id, which
> is a common change applicable for all the platforms. Also no need of these
> configuration for non station type. seen 10% throughput increase in WDS
> traffic with this change.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Thank you for the details.

Peter

