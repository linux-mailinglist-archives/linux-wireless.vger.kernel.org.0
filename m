Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7150516AF74
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBXSli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 13:41:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36437 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBXSli (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 13:41:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so9693093otq.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2020 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXQ23Qr+I74q0vmU9rxCtm/ASvQdqjaJ1Y8tx0MnwbI=;
        b=UtA7Z7ubCU2DNjyZlKo1Raqagm/lfI0e9XFBC6tCL3h7ybBKOOBdjQ1Lh7r7L8kYDM
         uWBp147PTTfChnaLzv8y0B3va0GMNBc5zAdqQdnevLJKoVXfNi0c7L5l0vfYY7G2q2e0
         ZPMJTcue4PL+jZ8jFv5S5EwLPn8S0bvmvqkZtNUIxdY2V9PgbnBN80fd1Flds5l54CE3
         UBh+w6NuXn6UE67TYV4ARGea7EZ6A8EGDDs431CwvB9Lda9/vZNE1cl3lDwoKxRviF5z
         JCNgHnAmus1yO3Thl34NRNJYqzmxd7x6Q0Qb4tfoYQHLtGyC6BUkfMms9+3xoQw5rasR
         QLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXQ23Qr+I74q0vmU9rxCtm/ASvQdqjaJ1Y8tx0MnwbI=;
        b=huXyDVnlNRcrhg+CfaYYD4GiDqJ/fIxe/mqg7nrACh9oPESrL1VTmUs+MptoWtU5mM
         /XP0YGIdcpQJkdVzMDFXh4d6xx11tTREPMNjVovy72UmVsh/jDJtRhWMl5zyd5ufcztO
         Iy1RwdWqg7G6YvnTRlBJX8KrOALH4Qr2uhmbd7FDFsA6z95Ap1Dm1qJ9Sku1fcJgQMwA
         SoGksAgI72KMpnV/f2F9dHdJ9rNbnmux9ypsr5NMu7gRrACXw6BQetXhvQAbi9Zq+AGp
         MKaOsaEjJ3OK+GAWbIGOqdOfcPp25nFGa9Vmzq0bh5cMAlSoB7yWQoGuiA2Xvl775lD9
         T2tg==
X-Gm-Message-State: APjAAAXxkYw90CmGIO2l0c3/aVFZkVABHsFjo60UQGWFO5P1lKQTyIvv
        wUOaJBcYCbGzjsMDxI2h7NHs23ps
X-Google-Smtp-Source: APXvYqw0gA1o52ujp2gjC80nvk3tqNLkDfOllM2n7sRRXVxTtudl0b/69jzqbLW+MOEdXbzLfOflBA==
X-Received: by 2002:a9d:22:: with SMTP id 31mr38820361ota.173.1582569695953;
        Mon, 24 Feb 2020 10:41:35 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x135sm4304022oix.20.2020.02.24.10.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 10:41:35 -0800 (PST)
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
 <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
 <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
Date:   Mon, 24 Feb 2020 12:26:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 2/24/20 12:26 PM, Johannes Berg wrote:
> On Mon, 2020-02-24 at 10:56 -0600, Denis Kenzior wrote:
> 
>> So to me this patch set seemed like a good idea...  We (iwd) don't have
>> plans to support pre-auth in AP mode in the near future, so this revert
>> doesn't really affect us.  I do wonder what is the actual concern to
>> warrant a revert?
> 
> These are two entirely different things, preauth is simply real data as
> far as the local system is concerned. It's not related to controlled
> port operation at all, which this nl80211 API is about.

I can understand this argument, but from what I remember, one of the 
goals of the control port API was to make this legacy 'special data 
packet' processing unnecessary for userspace.  In other words userspace 
wouldn't need to establish raw sockets.  Hence my question, what is the 
actual concern here?

> 
> FWIW, you may have seen Markus's patch to remove preauth from the RX as
> well, this won't work as is, but I'm still a bit on the fence as to
> whether I'll force you into the right model or not (i.e. clear the
> existing capability bit in mac80211, and introduce a new one that
> doesn't report preauth over nl80211). For RX, however, the difference
> isn't really that much of a big deal, so maybe just make it optional.

We're actually quite happy with the current model.  So I'd like to keep 
things as they are.

Regards,
-Denis
