Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9826304F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIIPNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgIIL6A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 07:58:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB11C0617A1
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 04:58:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so2063234wme.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7jSgqukA/irKhdEa559NBQhmKNIXlBjc6LRgmjLpnkM=;
        b=H5vdJRukp4bO/YXKUYHJAcSOv5HQugHrMd4cscbXSiDgrq9y/NJGiqHilRgi6t3gJ6
         bimZQ98onb3aKqALWXLFy/pr0cjpL+NIZ95f61rYzjBFkYH3vuVAvu9lne/OEmLmxzr9
         U/sS0oicWOj8nA6fkCBPuYlN4QAh/flkkZmF63vhCMAkpZgYmV6aNv6EjUmGD06B6xBb
         tsRm6NXMNX17sb8DZh2G8elLe7ZoEHTBydgfGh7TRhPSixygjmH1QSskJv9fgtpmLSpK
         jvk7X939kzA6uM8gEbIhdEEO7FPh5WWDEvUOHgKlWKv/8EA7WmkVe9/6J50p5EEzGbgj
         Ul8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jSgqukA/irKhdEa559NBQhmKNIXlBjc6LRgmjLpnkM=;
        b=pzNls2wbc4fJcfQ14nI+cv4mkpZBJ/91gbWhQ6sBr5aJygZTMsLjW56d0hfBoG4huf
         l7EyfWmqqbXY/sWE1oCpdb7lkX6a8W3iO7gIHlSntenM7acA/qJ9bmmP4q+3L6Nj3Smv
         mBN6zEdhxyhdJMiKSbR9bFGsdkohvldH1LlzeiBfyRn4gxf62svqELLpzWnHFFjetcLB
         eBYPj51JFJWaStF6fqe0jGqMQTorPugxGShiC5/UoFfiJ32Lf2c38YEdD5fwh4orO9DS
         mk6UXlQFXcaMJyhaQEKK+wl0ZYQ9tjM6SefnZNjCYYkxd5xmjPiqzDqjF5GuWCFv4hme
         z6FQ==
X-Gm-Message-State: AOAM532DuCjCRYNtBkE3GOEzcK+gJS2VJHQH9Lkgr8oaZeeS34choTil
        Ph5weov95QM3qozu6Sg12i8NTQ==
X-Google-Smtp-Source: ABdhPJxDpmQDrQekzU6KtBAErNMA/WF5nxFXpnVurTTe63/S2MWlGeqChzbNyyihWqwNboMYaGqFvw==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr3190893wmi.130.1599652679093;
        Wed, 09 Sep 2020 04:57:59 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t203sm3475032wmg.43.2020.09.09.04.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:57:58 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] wcn36xx: Add
 wcn36xx_smd_set_sta_default_vht_params()
To:     kernel test robot <lkp@intel.com>, kvalo@codeaurora.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
References: <20200908182437.2870281-3-bryan.odonoghue@linaro.org>
 <202009091528.AlA4r31j%lkp@intel.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <77dc7523-1925-8f3a-2a8f-819682d24f3d@linaro.org>
Date:   Wed, 9 Sep 2020 12:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009091528.AlA4r31j%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09/09/2020 08:23, kernel test robot wrote:
> Hi Bryan,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on wireless-drivers-next/master]
> [also build test WARNING on wireless-drivers/master ath6kl/ath-next v5.9-rc4 next-20200908]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Applies against

ath.git	git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
160b351d75cb - (tag: ath-202009090652, ath.git/master)

but, I don't mind resending after figuring out how to include --base
