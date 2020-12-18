Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE052DE9DF
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 20:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbgLRTlz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 14:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgLRTlz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 14:41:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45866C0617A7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 11:41:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v1so1855240pjr.2
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vTy4lGI2YMOaU1LOo0Ca6YZry6iYpOtB7i+T4PcUg2A=;
        b=jCD+aFVXazJo5/FhYwoWM3l0xL0kvfh0ugtyXkKHKIa5RClOjr8fF3M3sZPZIKQ7I5
         8VMQGDfKQenTp6asMQQozGJ0crsWIYdxQ79rDRhtVXL9m8w6yKcKMhya/kU5hyZWkGqy
         9fHcyZKt/hofJ8UX259DTH0TtPhPg+ppG5s9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vTy4lGI2YMOaU1LOo0Ca6YZry6iYpOtB7i+T4PcUg2A=;
        b=jNEzdPaM/eGCnmXEI4yGRDvMLrbj7UYFR+CSZ+yLLjQEK5xRsEzdWRos11q7JpuctH
         Qv6Ni/Q6f2R6Pmf36lDB0l5xeam83rRJNOTa+E7Kh0NNXnU5DsF9XxW5lH6wdb6Wpq68
         xP7UkG6FpES3Wji7fga70UiY9aCncgLO/33AGMBJ30QBsvnYiEfCuMGpNfLW3FSTJKCX
         MgRyySKaISos6RSDHjVGGiI+Oz+ankMfn+rJGO6WFgIqlx47h5jPkqO1EA70w9+2zm4Q
         Ymw5zZ+Oz9PBa2CxGgbTZTgwc9y87j42PqSsYpbPoHdq5mRB5fGPmgloWkP/doQQnz/1
         4rqQ==
X-Gm-Message-State: AOAM5321LmH2yXcPIiGX/dvDwQ5oiw9iuaRNmbghPrENsBfW3w65/tJr
        1uyScsIfYu1Lknr9DUQCYZdEiL+5jOe1dZC2
X-Google-Smtp-Source: ABdhPJzZmHAG60xEF3boTBFWTd5yANVIY0z9bPwBum2DqZKzVQHxPDNsRxHwQMYQTbHxI61M4jpr7Q==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr5762615pjb.162.1608320474608;
        Fri, 18 Dec 2020 11:41:14 -0800 (PST)
Received: from [192.168.4.200] (c-76-102-118-9.hsd1.ca.comcast.net. [76.102.118.9])
        by smtp.gmail.com with ESMTPSA id y69sm9285068pfb.64.2020.12.18.11.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 11:41:14 -0800 (PST)
Subject: Re: [PATCH] ath11k: Update tx descriptor search index properly
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <09bbb2fe-6e1c-9faa-232c-74b5a3a1e71d@eero.com>
Date:   Fri, 18 Dec 2020 11:41:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 12/18/20 7:24 AM, Karthikeyan Periyasamy wrote:
> Tx descriptor search index field should be updated with hw peer id
> and not by AST Hash. Incorrect search index causes throughput degradation
> in all the platforms. so updated the search index field with hw peer id,
> which is a common change applicable for all the platforms.

Could you be more details under what conditions you observed the 
throughput degradation?


Thanks,

Peter

