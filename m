Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D833A6EEB5A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbjDZAO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 20:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjDZAO5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 20:14:57 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE88A5A
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 17:14:56 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6a5eea94963so6199259a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682468096; x=1685060096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dHIxYfqlvG5lVLwt2OXQGNRVrrdNI5Pksh5M42AIBsY=;
        b=dIV6Dp3+YMLtH8NMvMF8DGsrC4gi3OG6RyF11H8HFNOxndYfUfdjsyEOwNaUDIdqU4
         S9nYetc6wyAaUdm6pU0uZ9+08miV6r7a+UquD/lq0yHrLX3AsuFzxWtECDoV95f4Cyv/
         jgUQ8f9ru7Ix2K/jIVo1u4lojSS4wAc2lpjMT46TsdxHZZEexDNjOlGaHlEArSuTmip0
         fb1Lx15EpO9Jg2Rans+ayqwM2o9kWx8yI4W6IOaC03S7Vqrm3OMVRq6g6uZ0UuOEBO0K
         4dnkydhFl19MID25vCvstYnkp/r9lD0GCxzXB4h55QF4KhQWW9IOEfHaH10xvYn6arkX
         67ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682468096; x=1685060096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHIxYfqlvG5lVLwt2OXQGNRVrrdNI5Pksh5M42AIBsY=;
        b=LdT4t7ySW5SXG8B4n/2JBqFhkD2TxWKXbti+I5MAlZ/fMPPtr+0FCHj8L3jNnvCLM0
         T10ec5MtNQN/lzLzxirR+10ncwQqwtP3zLDxMDm0k6Dp2bXj2D78wlxIB5dpBdFlXgi8
         d2PFU0hFEqyhVI6zvMC8XkUDtO+a798npa0L8VJX11cR9meIxKvpNjyGjo9LUujASSFV
         ZiAs4/pOVywU/60FL8FdqWDosEzBqyZN9JyMYkCYnjcvkhQpcAf8gJZ4hpoUMht/lpUL
         sTzOaD0nVU2po2iMUd0VZ4x/r9ER9yFykund71ZzDfy/r+i1MYryeB9V3VUzpixKWTVY
         jTSA==
X-Gm-Message-State: AAQBX9d7M8oBuFZ+rQCzYjCzN1xCWRKpVzEBrVcE8Sd/8ra8YPQ3/Ddz
        aKLrnrXffduSnYuGDNFoZ4Y=
X-Google-Smtp-Source: AKy350YCJTLIuPDRcYi/1NhFTYWse9MqBKk9GxaJDqwiALy2uC2yshgG/CTYRdu1/ex4T+mqMTgLRg==
X-Received: by 2002:a9d:7e95:0:b0:6a5:fdac:a6e5 with SMTP id m21-20020a9d7e95000000b006a5fdaca6e5mr10024294otp.29.1682468095912;
        Tue, 25 Apr 2023 17:14:55 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006a42e87aee4sm6256763oto.32.2023.04.25.17.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:14:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <716d9146-605e-b370-b3e2-ded0849cddeb@lwfinger.net>
Date:   Tue, 25 Apr 2023 19:14:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Macbook pro 7,1
Content-Language: en-US
To:     Pogprogrammer <spikey@rslp.org>, b43-dev@lists.infradead.org
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <63806E6D-2230-44FA-9DAE-0790F35C9F6C@rslp.org>
 <54db8ecb-b817-eda9-09ff-adbd54806c95@lwfinger.net>
 <726093C0-6877-4427-B7FF-9DACE88B9982@rslp.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <726093C0-6877-4427-B7FF-9DACE88B9982@rslp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/25/23 17:30, Pogprogrammer wrote:
> Additionally, my dmesg is available on anonfiles. I'm pretty sure I sent you a link before as well but it may be down by now.
> 
> https://anonfiles.com/Y2Ad37n8z6
> 

I forgot to tell you that anonfiles tried to install all manner of extensions 
into Google Chrome. As far as I am concerned, that site is malware!!

Larry

