Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3E6A7165
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCAQkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjCAQkL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 11:40:11 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506164207
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 08:40:10 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id e21so11264868oie.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Mar 2023 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V43RfGWNvfYtyRL+xfD6ynmwoFzxk99Ylmrno9tc4a4=;
        b=SjNdvPboKtJSZjRrxGVGvlTBcn1m5D+K7yVqkgP16w8/+85+td9x9Hi1uRhFQ7ggKw
         207SxUa43LYMejmkPQxklCB9JHOMI/uR1CGUG0dibj0N8HL87vHgiyO7oNoA1DH7T8Xm
         ZFcXbN7C6dE5xpp+vz1J5B22RKi9gnP1PJv3UGSVvPOSGVYp8/xx810ZBdR1hhd/AgJp
         Z5MhY9IUYeHikUct4z/RB1OLBHcMMklKLtsCqTOyxvrQO57sKSO8OPWupdmGDcxEjXek
         bGlwyXj/21bZQDK6/Y+p+ZaPNMGGC9H1xVhMZuj1B+F60ks2I1vUj1dzYmoD+NP9igDV
         9XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V43RfGWNvfYtyRL+xfD6ynmwoFzxk99Ylmrno9tc4a4=;
        b=UZkOUnv4hi5UVl0RIOs+RBC1uLVQHYen5rnoKVPIW53ENCR3Mx4SA5zxDI/2YYXJGE
         0kf0AtO9tnZsTvie4SnZc1I1DkI8/3Tv8cKrjF/Ze8XrakrUe+LU/5UAqSmI4EvBJ4tf
         0oCtBeRNP2LS3lobvMBWusXOunM11mvNFOt3THN9qjNORvYoB+lcK/5v1/JtEch8bRU1
         RFH9sLh7cdv8O7s5mAQrdukgXk3RNgJPXfvn6INfqG3+FwFwyF+fZolyqY/hu7Hdddms
         9jibcqDk9kBa19Hlujc+441WOtE0sq1hiC4hYiE3UGG92tEKmOzhTQbAkFIsWZllxWw9
         dodw==
X-Gm-Message-State: AO0yUKW6IQthwoEMO9ltkPHskShqiSEe/tuedoTETlIoR57wi2WDEQuz
        2/nvm+oxcDhKL0FiSbzP/wckE3UzB6k=
X-Google-Smtp-Source: AK7set/REaUTG0UmQWDXoAgbmDJ8pAr5z5K1YHX7SIObXw4hE50n6PzuGrXkXqHHESfiTH39Ya6XRQ==
X-Received: by 2002:a05:6808:115:b0:37f:cc3d:a342 with SMTP id b21-20020a056808011500b0037fcc3da342mr3535336oie.1.1677688809381;
        Wed, 01 Mar 2023 08:40:09 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r7-20020acaf307000000b00383ef567cfdsm5864652oih.21.2023.03.01.08.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 08:40:09 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8f436927-7587-028d-fc1e-4a3103e0e866@lwfinger.net>
Date:   Wed, 1 Mar 2023 10:40:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Hangs with NetworkManager and rtw8723_de with kernel 6.1
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>,
        linux-wireless@vger.kernel.org
References: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <b8fa3770-7164-e6bf-4d8d-8ba8fd78057c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/1/23 00:26, François Valenduc wrote:
> systemrescue recently switched from kernel 5.15 to kernel 6.1 and NetworkManager 
> started to hangs at startup. This seems to be linked to my wifi card 
> (RTL8723DE). I am also able to reproduce the problem under gentoo with the same 
> versions for NetworkManager and linux-firmware than those used in systemrescue 
> (1.42.2 and 20230210). Under gentoo, the problem appears with kernel 6.1.14 and 
> 6.2.1. I am able to use NetworkManager and systemrescue without problem on 
> another computer which has another wifi card.
> 
> Does anybody have a solution to this problem ?

François,

Without any log information regarding the specific hang, it will be difficult to 
debug this issue.

Have you installed the drivers from the rtw88 repo at GitHub.com? If so, they 
may be interfering with the drivers in the kernel. You can test to see if this 
is the problem by doing an edit of the command line while booting. When GRUB is 
showing the kernel you wish to boot, press "e". This should bring up a minimal 
editor. Scroll down until you find the stanza pertaining to the kernel you are 
booting. It will start with "menuentry 'xxxxx'", where the x's are replaced with 
the description of the kernel you want.

Once you find that entry, scroll down to the line that starts with "linuxefi" or 
"linux", then move to the end of that line, and add 
"rd.driver.blacklist=rtw_8723de" to blacklist the driver from GitHub, or
"rd.driver.blacklist=rtw88_8723de" to blacklist the kernel version. Once you 
have added the new info, press the F10 key yo continue the boot.

If one of those lets the computer boot, add that driver to a blacklist file in 
/usr/lib/modprobe.d/, or wherever your distro keeps the modprobe.d directory.

If neither work, then report back, and we will try to get a dump of the logs 
when the hand happens.

Larry

