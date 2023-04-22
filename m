Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC96EB61E
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Apr 2023 02:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjDVAFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 20:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjDVAFR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 20:05:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB802212F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 17:05:16 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-18777914805so13860518fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 17:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682121915; x=1684713915;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YL1SLPo3YbLuC2v47HggCAKWIJ5vWc/sJO+qhAWyFjM=;
        b=dE/B9Ve4nBwkCh1JxClTx/CKcIxG/7Ir89bTziXDezaJG2q70U4FCAwGGiS3Fzx5Mt
         DCTpgkIetc/w/+D6CYxrgMFtxbWv0bHzRZQugwc/250RUV2CtRZMLBpXbRJF/S5dXzJD
         XTtJU9v6yHKglfdghUxKJEw5K+GkJEcjvTpr7Dvv2Xmhcr53gTn8PBt8hI/ovtIDSMhe
         RDunTCvKNzYLqJysEAwtMb1+MEZt1AuCfQMQsHqBjY1ZSAIoZ/44UdkX4IdnBSZE7dTD
         GG2OMO5o5a0wmhZuCTnRK/tAH8Wge4WfAKmucmqml7UlJGUkxRgMeH143XKqT3Gw2GdA
         o7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682121915; x=1684713915;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL1SLPo3YbLuC2v47HggCAKWIJ5vWc/sJO+qhAWyFjM=;
        b=ivRYHIL3ZsjfGwuyfTIyYwEE1ns1QDqsrLJvBGd5e7TJYIfRiztZ25TmdMtt6bVEKX
         ntbTptnpOEEGVtBRVJXdK7QLET8rXgOo8H3N61tY5wxoqhtL8MhkqLfYcbVssYgYyulS
         S8kAicfpxnjmRDdp4Kd6MDikLe/gybm4ij3Ru9EPqqS5XZvyZ4Q9LIewDtlcQx+hRceB
         kc/AyD/SxJJHDubvtX3F8RIJ1rEQ1HMpHkykDa9aiGCt+AG+/aKxCwQPfaJDRGQET3/B
         lhZwy/nmlgU5rriTI+hwprNlCQx5N7hf5+4Ye4ACv3Pc0j3Q0x76aCUIWYaM57X6lq2t
         ac8Q==
X-Gm-Message-State: AAQBX9e4NAxZ3b6gtIb8rf8B7K9H55069/yMBCmiex9c+5+I7rQ2CLKE
        bdLJu2gOC7jFP+grOViTkF3m7xKnFzs=
X-Google-Smtp-Source: AKy350Z8KaQO7x8wUJqYDgWg0kgleMNYgJ8rjKcLyKAX8cJNaWCXGkl21VtZlQK4QoKl+QYfl4+fSQ==
X-Received: by 2002:a05:6870:659e:b0:188:1b8:33ee with SMTP id fp30-20020a056870659e00b0018801b833eemr5535533oab.21.1682121915651;
        Fri, 21 Apr 2023 17:05:15 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v20-20020a056870365400b0016e8726f0d4sm2291160oak.3.2023.04.21.17.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 17:05:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <19d8ea51-d37a-5446-fd7c-716e7e8b1aef@lwfinger.net>
Date:   Fri, 21 Apr 2023 19:05:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: NetworkManager cant connect on Macbook Pro7,1
Content-Language: en-US
To:     Pogprogrammer <spikey@rslp.org>
References: <50BB827E-7437-4E25-9F5F-636115EF2D20@rslp.org>
Cc:     b43-dev <b43-dev@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <50BB827E-7437-4E25-9F5F-636115EF2D20@rslp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/21/23 18:11, Pogprogrammer wrote:
> Hello, I installed b43 and I get the error that DMA is not supported and it will be switched to PIO. This was a bug on kernel 2.6, but I am using 6.1+. My mac is partially supported according to http://linuxwireless.sipsolutions.net/en/users/Drivers/b43/ and that may be part of the problem, but:
> I am on void linux and networkmanager can identify all the networks but if I connect I get errors like "not found network" or maybe "bad password".
> This is a fresh install and sometimes certain daemons just arent running, so here is my list:
> Dbus, dhcpcd, NetworkManager, udevd, wpa_supplicant as well as the agetty-tty[1-6].
> 
> _______________________________________________
> b43-dev mailing list
> b43-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/b43-dev

Your description of the problem is not terribly coherent, thus I will be 
requesting some more information.

DMA should be supported. It certainly works on my PowerBook G4 with a ppc32 
processor. I expect that a MacBook 7.1 has an Intel processor. If not, please 
enlighted me.

I would like you to run the command 'dmesg > dmesg.txt' and post dmesg.txt on 
some site where I can read it.

The b43 devices are certainly slow as compared to modern devices, but the one on 
my PowerBook certainly works.

Larry

