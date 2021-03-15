Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD77B33BF8C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 16:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCOPO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhCOPOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 11:14:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFAC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 08:14:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso20505540wmq.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RUvePBBhxzF7wMfmevD5hG0lC6SANJu1Q9CbQ94+254=;
        b=WBCrjOuSfJtfiUIVaJxfBrU5xiccxPrJQWEOderCsmAZFU0PNzxrd/fkU1Y/JIypt7
         BHtmkt8yhIwHJYJyWctEVYeenvRrn9yVwKUs/UauGWidnt7YwSndz3J7jUomQOaKfwvf
         TEnBMTzC+7k8LRSn9RaWZdhPBac98TsdwqKAgvhQeKAT4JYmP88kJYALzjA9bVnqPNFu
         deTC1FITuQqzGsQVrSVpyAhVHMPCRWzaK64p5/Vj5LU9/cc8s8kuXWHssstu61gFsdXo
         6mkY1kb7YyH5DHcw0sQP16hwiAULJIPjiB1PiHmSAApXE5dm1epWf+/Y7OABwBA6EWOr
         zfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUvePBBhxzF7wMfmevD5hG0lC6SANJu1Q9CbQ94+254=;
        b=L8992dy8KPAYeROae8rLUSyIUma8mmqMRe4KAOlfZoHOir/JF4qZ9PnP2zx+c+3q5D
         yAgGLSs2clPy0yQCjzdsita4t6BzS73an76N4Nzl1WLAuED3fs4gMmkJ8o3qayF9gpHM
         dXy8mTI3akAVRd1oGjNuVAJU15PcH7JxorUq44jzcO7zDlSME2O/4jiDiti98p/Hq4Px
         tndjoChpvGnAZWptX25vFsw0gcrIPfhqWDI8j6udOOwrOPVNtfXYHRJt1S5eeyrOolAB
         of3VsmajNhPV7IadjLKSwecPFOQjYU5bsbBMPQuBLzHfTRjmOwUTsZ6j/gcwLPZcp3ct
         x/UA==
X-Gm-Message-State: AOAM5337VK/L6FHNv7W/EOF5wjv7Tbv0B4jqZGeuzITCMmYiwSngpIMk
        PoINZD3Z9tHeuhmf74LWiMgxhIr0r8nIR7U9
X-Google-Smtp-Source: ABdhPJy9TKMsawEEoZPVyq1Zs3SCxqBXa60/8DYhFhcq+HpsFH7DuC9VjNWAzm9q5mRm83v95lstmA==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr171289wma.39.1615821293386;
        Mon, 15 Mar 2021 08:14:53 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t14sm19727899wru.64.2021.03.15.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:14:52 -0700 (PDT)
Subject: Re: [PATCH v2 06/12] wcn36xx: Add ipv6 namespace offload in suspend
To:     kernel test robot <lkp@intel.com>, kvalo@codeaurora.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shawn.guo@linaro.org, benl@squareup.com,
        loic.poulain@linaro.org, bjorn.andersson@linaro.org
References: <20210315120937.2512341-7-bryan.odonoghue@linaro.org>
 <202103152217.bBCw97Sq-lkp@intel.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <4e4fc2cf-c864-3997-540d-8ec674caf51d@linaro.org>
Date:   Mon, 15 Mar 2021 15:16:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202103152217.bBCw97Sq-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/03/2021 14:18, kernel test robot wrote:
> Reported-by: kernel test robot<lkp@intel.com>

I should ifdef this function for CONFIG_IPV6.

I'll include that in V3 once I've left this set here long enough comments
