Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF840B688
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhINSJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhINSJJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 14:09:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFD9C061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 11:07:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so289491qkm.13
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=WJiBlxaozEuDEtRZ3b/Y9e+YO9epr6fRsUcQC8+sYzY=;
        b=ue66QzoJlE5nikK5NmBndxDS9hbePQqPNG57lOwLOI6YYqWS81tGdPqBgx+jSwXMsm
         xr4IUYtAAZzhNFPiZTNj9Pc+2SZQkh5/eTL2+ONQOH9xDQYWp5XEOpPwZ8gYs2tD8TPD
         fD2sBJQ40aK4rvK7GN0euYM7T/y/imdmSNtlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WJiBlxaozEuDEtRZ3b/Y9e+YO9epr6fRsUcQC8+sYzY=;
        b=e14jhytcLWoH9tHDsIGKh17GxqZsrg3GOrbb2afg8UYlwi442G3fNuyKYeHs7CZYyg
         qF+Loo8johKfT4OqS17DjyucQfS6FfG4dXZs6aRF8lyZZ51i67jIv4Gw3epxJg5JOjuJ
         DkXRz42gSeC3ACO3YZlcYQ0PUms5Bzz51mdsDMgJVA0/tuN86usJzd95qCGnmXXKxPUb
         OaxVrOTkdq7uKU/idm/f3nHfoxDJ7v/5KCK2aSE0CJM67qq0q38LVRk2GzaRNs+SFjk/
         nTC1V6JNlLYn4ir4H8OA6kAFEsuM2cszTqEkV7ma8fmnzHHDewq/2Bx1x5sn8imaN2ET
         hkKg==
X-Gm-Message-State: AOAM533Nlm+w2QS3NrdLh417lmdEsgNEnzQy88BevZuV0uNuIP3hl+iY
        xCwYnCXJccK3smvSRSfHiBc3YVCKRrsYSQ==
X-Google-Smtp-Source: ABdhPJx5Jeup+tAAqgzUmXMSSmg/QiD79lnqDrcLDf02EImf/PItyINcbzOUSa3qDj4gdmIg0vfgwg==
X-Received: by 2002:a05:620a:81c:: with SMTP id s28mr6187941qks.45.1631642871214;
        Tue, 14 Sep 2021 11:07:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:a482:d150:1965:8294? ([2600:1700:38c5:675f:a482:d150:1965:8294])
        by smtp.gmail.com with ESMTPSA id q22sm6468655qtr.95.2021.09.14.11.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 11:07:50 -0700 (PDT)
Subject: Re: Patch for Atheros QCA6174
To:     Andreas Tepe <andreas.tepe@debitel.net>,
        linux-wireless@vger.kernel.org
References: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
Date:   Tue, 14 Sep 2021 11:07:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/14/21 9:59 AM, Andreas Tepe wrote:
> @@ -426,6 +428,7 @@ static struct country_code_to_enum_rd allCountries[] = {
>          {CTRY_KOREA_ROC, APL9_WORLD, "KR"},
>          {CTRY_KOREA_ROC2, APL2_WORLD, "K2"},
>          {CTRY_KOREA_ROC3, APL9_WORLD, "K3"},
> +       {CTRY_KOREA_ROC, APL10_WORLD, "KR"},
>          {CTRY_KUWAIT, ETSI3_WORLD, "KW"},
>          {CTRY_LATVIA, ETSI1_WORLD, "LV"},
>          {CTRY_LEBANON, NULL1_WORLD, "LB"},

The same country number CTRY_KOREA_ROC(410) cannot be used for different 
regDomainPairs.


Thanks,

Peter

