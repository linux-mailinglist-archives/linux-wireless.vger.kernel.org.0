Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B404A3520
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfH3KpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:45:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51275 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3KpM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:45:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so6796001wmi.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xLGQ3hVTKCJKegctd6/X5+X/zkJtRzTbfyaKEOC953Y=;
        b=PE3buGdBlOrx36sBI4xENbQmzID71/75lIMc4zn1OQ8avSQkCpareAyTuslk+Y0t35
         nfv00ncV3OpYjza8jArImm2d190MRYx/leR8Sr9uevJ8VoNdq4raEHPnjudma2/3keEm
         LXRGtzAtSIV+CxBcPkh8KNmJ4eC5OcgHOqrsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLGQ3hVTKCJKegctd6/X5+X/zkJtRzTbfyaKEOC953Y=;
        b=B3oLyWFG375ZoQwdV83RyjONIuMiqSoWriNRDFxVSMJn6sIm+vgqtz3+nvHNnf1Ndh
         vKsEogmcQcE4s23UlduMjg7fFd1etqys8osYSUhsK9LrhKhrU8DET3vMuob7/r+KRE79
         F74gIvaOigrWOUqFB9ydbVjR5SIb0dGXKsPtPnAsaQTCnUiSiEQgdEF6V/EvFJGyD7TF
         D5IvBb0BFRJPn5oKZ4yY4/3CWt+DMMhs7U7yrujKYRjVzdCfPtjQ43SCXj9nneHk5slD
         TLlva88suJUacmqnregcXuEyS1sJOumjpbnt+gBqRFGPaKdCtzaCiVAOdIl4AVNsK4QE
         bneg==
X-Gm-Message-State: APjAAAXyukFNQGH5T5afReyw4z7mXHrYkhPMumaS77+8tvLSNvrvwMhH
        +UljLvz4fElGgkqQEVrlr3slKw==
X-Google-Smtp-Source: APXvYqy95Aa+fTl0knltKu2lDYehXzjT+WGBANIUWzdMHxuaiBRRzB6yhZ5VUsAP+c1MHyYJQKLTjg==
X-Received: by 2002:a7b:cb52:: with SMTP id v18mr9596798wmj.37.1567161910679;
        Fri, 30 Aug 2019 03:45:10 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id h23sm7269866wml.43.2019.08.30.03.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 03:45:10 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: Convert 6 GHz channel frequency to channel
 number
To:     Amar Singhal <asinghal@codeaurora.org>, johannes@sipsolutions.net,
        jouni@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
References: <1567117290-19295-1-git-send-email-asinghal@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <544cab9b-8914-370d-c8a9-407ce88f6f32@broadcom.com>
Date:   Fri, 30 Aug 2019 12:45:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567117290-19295-1-git-send-email-asinghal@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/2019 12:21 AM, Amar Singhal wrote:
> Enhance function ieee80211_frequency_to_channel by adding 6 GHz
> channels.

This look very similar to what I submitted earlier:

https://patchwork.kernel.org/patch/11073197/

Regards,
Arend
