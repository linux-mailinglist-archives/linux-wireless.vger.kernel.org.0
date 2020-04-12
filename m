Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C961A5E18
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLKoz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Apr 2020 06:44:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55081 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDLKoz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Apr 2020 06:44:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id h2so6857206wmb.4
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ooRMipQkQ5yE3CsfOz8ve+utn0iksaAuNVYdxZfPtc=;
        b=SD12RIoAK3m413gi8XB1IR1qDFg8H1beaaHOHj236R6zwCyvwvMatH1O3/DoRyw0gI
         xivSrmXtGVSbbLWRnNwb+bNHCafOrJFpFceCeDefTilWCew67PlZEly3rNWE2OWodfSC
         +K0Om/FJWfAlEj8m4fu3agmTDEzvbV1p5PTjpUPxPXF6nkBPVk4QwFre6HOqWdLgPx08
         0/29eFJixcdgRq8U3mt0JXhY3yUWeM/kxS2Y3A7xxWCTgMV0ZgejabmYj7BhYYnrcQmC
         nj+EbaA0jwhDIYxPRbwpnoIKyNT9JHw9sufTU8UYEZW7g3xYg0cER1DvybsnP6wnRQvh
         UOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ooRMipQkQ5yE3CsfOz8ve+utn0iksaAuNVYdxZfPtc=;
        b=ix1l/kdIlesWF8lH0NTZW2PBaFow+0oc2Ev4UEeBzWjMhY34kyoE/yQR+nOU/fhZFy
         GfsoxlYaCAW93HklfnVtoZn17b5xM1/P2zbzWeIpdywZAsc1Vd3nob30bT/erTlr83nv
         DTxFJSLEohpoHWQSiqD429e3iLfCa4DBqhDSeFc3EnovT1x6QwHjlX2diGlr4VUdVksn
         tLoX1eDSDu9jpYbsd99gza/o/BzoxXOssW14Z2Ngrm7DLfO6IixBS2ZNvFou8ZU+v1m+
         Tl/9+5JpGMGadhMh2f+Sd6c/N8rP/lCCwSyh67tflk6MAvGthGSSItk1FDKCI7DRtfWT
         16FQ==
X-Gm-Message-State: AGi0PubY/CD5oJbsRa0UM2KnED7wmQp3TrDuqxFKfat1QHl228DqKgwY
        CBAJzYzK+xBC6rtfr1cZw2T2qZIp
X-Google-Smtp-Source: APiQypLeICqc1ka+I+wo4sQJAkgzOo9B3pTSfS9DNRlcDThyr4FG2pkHz1VtfbAYdrGVuGK18jOb7w==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr13468014wmc.124.1586688294309;
        Sun, 12 Apr 2020 03:44:54 -0700 (PDT)
Received: from [192.168.43.18] (92.40.249.57.threembb.co.uk. [92.40.249.57])
        by smtp.gmail.com with ESMTPSA id z3sm9645510wma.22.2020.04.12.03.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 03:44:53 -0700 (PDT)
Subject: Re: [PATCH] staging: vt6656: formulate rspinf values into tables
From:   Malcolm Priestley <tvboxspy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
References: <311b59f0-4098-b5a1-6a50-53568b81377c@gmail.com>
Message-ID: <9e1475f9-8d74-7e7a-82ad-2441880fad77@gmail.com>
Date:   Sun, 12 Apr 2020 11:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <311b59f0-4098-b5a1-6a50-53568b81377c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop this patch v2 sent

Regards

Malcolm
