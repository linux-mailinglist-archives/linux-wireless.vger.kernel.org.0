Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E3037AE1C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEKSMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKSMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:12:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4130C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 11:11:33 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v22so14969187oic.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aH9kVAJXkwaxX/GNZLKBuR2D6QcV31ThYLhoCIM17dI=;
        b=Lj+pLY/hmdeKwz69ucMn663n+aZR6c0D3Tew84HZPwtor7Ok7xQxvGEMSI9GKEq3hx
         xSFIXXWY50Wy0EcfoxY8fHdgg/Q4Otef3DgcHfNML9NMKdpDq1xoYLfOs+3Fgc487yV+
         3/7mSLmdXVZqasvtn8DYfk54e/9MyB1je+mRvcf2wCDSBli+B0cg5pln8LeOGis+u+kv
         tKix0gF09jHe3lwIsK8Kf+RXlaYaL0gMAbu4oo6xjOE8pwtmtGLGrNMHRps35XOZ6NUO
         wTO7uzF5TuxWcNfqIr5qcVB/bjRuVL+DdWQQGJ7qTtCuzSvoX0mKe3mZaxd7i9VXcQNL
         PS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aH9kVAJXkwaxX/GNZLKBuR2D6QcV31ThYLhoCIM17dI=;
        b=VDMAuz59sVCpS2+g4UmX0xymtleHGeMqFjT1ez30/hoHlsn0p35e0mdbi3b33WJjm0
         8hkVXq4aTVKwqg6jYnLfEMSTp6Uyc4QCzirPQ/BC9NOKrrHW8TyRaozoVcF7nasZFrto
         KKdjRB3Z6RrnVgdaTTtfu9nsuTkehTLXguMemJ21J0Bwu01G8LKOOztUVLU8IdZhmbKT
         Ju3ItYRXKTqrA0is8gq7uocGkHEt+1pgzzJ9rI8WgJq66ze+zaVfrz+w3uZz/WmEYgvs
         MVn1n8ajf9Wv9VF+n02JggN7cQuP/TfhYkjsVB/Kr5kBdzccd5O2r+emrxw9EWfyIsBJ
         wu0g==
X-Gm-Message-State: AOAM533gQ21yZPujwAwD5cNh7FSpFymZVo2vtYEyq9qrweXsWqeyYt9O
        fsEz0AqbL/CTq4y9T5L0fjyxQN4sPMg=
X-Google-Smtp-Source: ABdhPJwDadO/X3zIcmZEydh5nIHC+UOJSyhMElTtSDmHMzOrR4a1wYl1Pr1TFKMeGDNV6fAs5WomBQ==
X-Received: by 2002:aca:d90a:: with SMTP id q10mr4510125oig.63.1620756693041;
        Tue, 11 May 2021 11:11:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z6sm2440595oiz.39.2021.05.11.11.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 11:11:32 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: RFE4 support for rtw88_8821ce
To:     Luis Ortega Pinillos <lupaorpi22@gmail.com>,
        linux-wireless@vger.kernel.org
References: <db18a90633e0c7149f25f591251df55f0f292a4a.camel@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3dbc8525-5ebd-ba4f-d57a-7d46f5cd1ca6@lwfinger.net>
Date:   Tue, 11 May 2021 13:11:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <db18a90633e0c7149f25f591251df55f0f292a4a.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/1/20 2:15 PM, Luis Ortega Pinillos wrote:
> Hello!
> The rtw88_8821ce driver doesn't support the rfe4 variant of this wifi
> chip.
> 
> [   29.951453] rtw_8821ce 0000:01:00.0: enabling device (0000 -> 0003)
> [   30.131013] rtw_8821ce 0000:01:00.0: Firmware version 24.5.0, H2C
> version 12
> [   30.149773] rtw_8821ce 0000:01:00.0: rfe 4 isn't supported
> [   30.149872] rtw_8821ce 0000:01:00.0: failed to setup chip efuse info
> [   30.149873] rtw_8821ce 0000:01:00.0: failed to setup chip
> information
> 
> My laptop is an Asus M509DA.

My contact at Realtek just sent me the following:
"I'd like to let you know that I don't forget this thing, and my colleague is
working on this. If there's any update, I'll let you know. Please wait a while."

Larry


