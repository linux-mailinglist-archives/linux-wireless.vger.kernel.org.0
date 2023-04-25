Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35256EE944
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjDYUzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjDYUzC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 16:55:02 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E314F4D
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 13:55:01 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6a5e7482961so2654263a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682456100; x=1685048100;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gC5oGO9f22IB3HcxCfqxv94q9h27SKxCh5uDMEn5eTo=;
        b=aK5owQQuAfm3D3SARcVWHJP3yM3C0Q3KTy92YZ1tYzBzaqT03rq19FlLPnUZ7DVU3t
         ysSMsRuNUUimGRxp2japbe1ydw9GKotlz5b5jXzQpeJ+C3L3aJwiufNO8CzSK7tKedek
         B/dlBbKuOPOyCRTpDlwPWRehmlk9E6RjoA0otUBc18feLG6iido/Bxr+8M8kBt1r3o4L
         oKP6vqzSFo8lrmxO+ZDwkPzP9kEkUj+Ty7ozA76onq2yZAIJQNOJgGwNzzASpRBXBJIh
         cmvw81i9PtsdXB3x+buLHNFqjPpIzCKcf1wQR31SIBO61xgB3siEfE005hBx7TePHgyr
         KqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456100; x=1685048100;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gC5oGO9f22IB3HcxCfqxv94q9h27SKxCh5uDMEn5eTo=;
        b=eDHHaLNtd69sJW8BLnaqG1RBvw7WFevVRgRg0G7iBxOWhwfW229vEuh070pfCjLwej
         sA5LqZQ+Erp2ltfEyXKfaYOgtIpOKUI+f+ykbpYxSIYfCuoAQXXMAFZLymjUGWzBUKaC
         VeZu6SCt4/2Of/apHDOv7S3kzHnQdp9Pr7xeDmPQzh0Olj6hWgKHNpGehQwoUahdMNuv
         IsEJ7aAlJAY7LSE1HDS3TdSKXtqkoVYaKy2J4z2+cts5CH5Gyiq0aOm3eN1+IAT7M21J
         ctR4yBidXKuvi+o4s+sJ6i58HQuQoRYRthv4GnCk7yKQyr7+RDieggE0gDx/tdDfYL/v
         ftjA==
X-Gm-Message-State: AAQBX9f1xq5O7HU6YlCfseOdqEO/3aGHidljvbyl3BHcCOYSEWzyPEry
        HKE8GR5+WFq8DiGHCUqvz+QxE6uRkgI=
X-Google-Smtp-Source: AKy350Y/DmZ3s+v7GMMJn9LTkVTrsup1biL+WxrzvM8tcweetBPRh8+9PYCx3/0J8cP/Syv9bNUjtQ==
X-Received: by 2002:a05:6870:468f:b0:18a:ff22:1fa9 with SMTP id a15-20020a056870468f00b0018aff221fa9mr11373137oap.3.1682456100420;
        Tue, 25 Apr 2023 13:55:00 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id m21-20020a056870a41500b0018459cc0f52sm5924636oal.24.2023.04.25.13.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 13:55:00 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <54db8ecb-b817-eda9-09ff-adbd54806c95@lwfinger.net>
Date:   Tue, 25 Apr 2023 15:54:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Macbook pro 7,1
Content-Language: en-US
To:     b43-dev@lists.infradead.org, Pogprogrammer <spikey@rslp.org>
References: <63806E6D-2230-44FA-9DAE-0790F35C9F6C@rslp.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <63806E6D-2230-44FA-9DAE-0790F35C9F6C@rslp.org>
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

On 4/25/23 12:22, Pogprogrammer wrote:
> Hello,
> I contacted this forum earlier and I installed devuan. Initially it worked on kernel 5.10 when I installed b43-installer and just set it up. However after reinstalling due to unrelated inconveiniences, it is unable to scan for wifi networks. Dmesg contains no relevant information except DMA RX timeout and another timeout waiting for bitmask 01800000 on register 0F90 to clear. The logs then show that the driver was loaded with a feature called PNLS, qnd it loaded version 784.2.
> 
> Under uname it is debian 5.10.162-1 on 5.10.0-21-amd64 kernel.

The list b43-dev used to be a good place to ask questions like this, but 
linux-wireless@vger.kernel.org is better now. I have sent this reply to that list.

I understand that devuan is Debian without systemd. As modern wireless is highly 
dependent on systemd, are you sure that everything is setup correctly?

The output about 783.2 implies that the firmware was loaded, but those error 
messages are of concern.

Please run the command 'lspci -nn' and post the output. That will tell us what 
device you actually have,

You say that dmesg has no relevant information, but I would like to see for 
myself. Please run the command 'dmesg > dmesg.txt', post dmesg.txt to some site 
like https://pastebin.com/, and post the link to the file in the next E-mail here.

Larry




