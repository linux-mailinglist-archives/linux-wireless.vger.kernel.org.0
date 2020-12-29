Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761842E6D31
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 03:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgL2COo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 21:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgL2COg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 21:14:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C9C061793
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 18:13:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 91so12917410wrj.7
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 18:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqOSr1W+rz9VXkwF2yiLYjnBy0UuXLJbQbcPvrRbHZk=;
        b=suVPYidBAIQfFCBM/VXpbsYxXwjtSSrIe4F71DeCdznntLjQGpohClnuZM+YnvKKIu
         70NcZ9blluQezurfPARb2cKq6gNo2kzz93zbqQDAPxjml9Ha+imsTYDy8NN6i5hIylIw
         Cje8774BOSACA8RV1tImuV3GK/R8mEpGLyRe3yLZ+BBl9+EB+hGKbin5MVzGV9+d+mMI
         lou7o2LcSiUBxksj7HjCinJ3nUNY4qeP/TkZqQuRSsNws+1n6xorN1FFhmKBndqHTKRd
         rlhbZvERwwUilo6ofNJKRnjEc2EsqZk3Mw+kymF56xtn2FPzR4xzX+RMvU+bENzRLpn5
         I+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqOSr1W+rz9VXkwF2yiLYjnBy0UuXLJbQbcPvrRbHZk=;
        b=cx1eADEEith939FEa2JRFL/iMAbnNdlLs4fhCSsJLvRP4b029lt5htaNoMHEle/jSu
         iaZ8IcGrXzR5uJD43JSWSIQbRm+qXz/J5nd6Sw7SWRJsAJcxoAVm83JfC2UKiCnpAmuL
         su/nVT0gXgzM8c68a/NyuYXbsVNZ6G8Xg/DBbtLDiHf9Zrre+05rKJBMUhkRXrMS2AKT
         xc0Melnr7kQWoffrfmMBcenGIKBGlF22OlZgrnQe++fu0P9pW5hjJvsmfo7eLxpFxwbK
         ShLBzb28Cql/RmDsEJtJ6axPhLbwYecJcIx+sqpsBXjqOcsZYudYbmIo/zcRONChCkRz
         BnCw==
X-Gm-Message-State: AOAM533CaI7cuMef+IGyARy+Hrf07U9FUhnwNPFTInzqPM6g2iOB1DNn
        E37XtIAewXcDHZFM0IFupz8QLg==
X-Google-Smtp-Source: ABdhPJyB5qUYiJt1NR9q+NIaIJFrCBkivGQv1tSkfK4X6mCc48YLDFmuFiDWx1mnaIxYAZCcGoz+YQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr51639125wrt.223.1609208035163;
        Mon, 28 Dec 2020 18:13:55 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n14sm1393123wmi.1.2020.12.28.18.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 18:13:54 -0800 (PST)
Subject: Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace offload in suspend
To:     kernel test robot <lkp@intel.com>, kvalo@codeaurora.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shawn.guo@linaro.org, benl@squareup.com,
        loic.poulain@linaro.org
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
 <202012290547.6ryYf96B-lkp@intel.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org>
Date:   Tue, 29 Dec 2020 02:15:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <202012290547.6ryYf96B-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/12/2020 21:49, kernel test robot wrote:
> [auto build test ERROR on wireless-drivers-next/master]

hmm

works against this

* 77da2c99eca0 - (tag: ath-202012180905, ath.git/master) Add 
localversion-wireless-testing-ath (11 days ago)
