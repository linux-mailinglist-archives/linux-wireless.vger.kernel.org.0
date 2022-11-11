Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD29E6259B1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 12:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiKKLoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Nov 2022 06:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKLo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Nov 2022 06:44:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88013F4D
        for <linux-wireless@vger.kernel.org>; Fri, 11 Nov 2022 03:44:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so2991197wmg.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Nov 2022 03:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jg6ZLD8fiw3RZ0xzdplxIP2yMm5V3QqfNz4akGU+S0k=;
        b=R0rdNYyR9W619Eg52+zca0AA7HJC99RUj08rcCogsOmlHr5vPsILltUCRquQjtUTFJ
         SBVaFgEwVzRSehdR7ssQWegtRPx6iT7Lg+AfchLl9ZGvxd/F25cvxVBwxg7GIsHGv8Va
         LjpZQD98XbrQh0qBn5hBTMUXgQjnEzhcZo1RbqO21vhc8ejIEeOeC2X7iT4pcdcpxFrV
         rowwwkUa3rKQdykuE0XANcVZvdj+yrDgJLPkH+Z0wZl4c8J/ruHaX+0drwW7oer0w7Xj
         PRSYsiAFIrvQ1fVbKjhPTh32r99nSWsb2QHSN7VWJhbop9y8OS6+gJuMEJeJYzlYVZuC
         EQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg6ZLD8fiw3RZ0xzdplxIP2yMm5V3QqfNz4akGU+S0k=;
        b=Eu+icsUpmbeRUvtgNlhufLyPD6Oj88bx09eQRLVi2NVe+VXb/fg9nWrcBf6IkvjV70
         E4NIH2otXDuhLMwpFN8j/wAXCF2EjNsnnWmtUk2wPWr+6oFr6n4KfABSv5+jvGvH/Eq4
         0SnLOVSu5vW0HMmq2h+ms7Ck2HMKTDAOB0YLW31h6diHsZk25nLpnV06xYVLknxZ//rM
         oEnGA1Vr9CYYLAKBQelRSOB7ImI7ieww+LOyNJzDBt8udcv1NrPilMpRVXgAPddzb4Kj
         Mdqc+BszxWx5kgz8odLTbXYns8QlG8U5+lZgaXflHMpiLm/SG/UNbXbEYzinnVblm8qv
         1HJA==
X-Gm-Message-State: ANoB5pmbm8rbNG2xwVyj0NB0EZYkhYr+w9jEVaKN7wWsOqCF49Ufxkz/
        QiNvis1jVwf1VPKegyELdaj7Mq2+tjc=
X-Google-Smtp-Source: AA0mqf4yU16bc+usGSOKxsokofsc2IrmWL3cTiRgtoRZg3WC4f3bilQsyAvVtrABrHxpBZML74xqjA==
X-Received: by 2002:a05:600c:602a:b0:3cf:b2b1:3c7 with SMTP id az42-20020a05600c602a00b003cfb2b103c7mr948923wmb.176.1668167064926;
        Fri, 11 Nov 2022 03:44:24 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b0022e6178bd84sm1718581wrt.8.2022.11.11.03.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 03:44:24 -0800 (PST)
Message-ID: <7e035479-0508-f349-1d6b-6754b428fba9@gmail.com>
Date:   Fri, 11 Nov 2022 13:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/3] wifi: rtl8xxxu: Name some bits used in burst init
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
Content-Language: en-US
In-Reply-To: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/11/2022 15:58, Bitterblue Smith wrote:
> Use descriptive names instead of magic numbers.
> 
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>  - Change the commit message.
> ---

I forgot to say that these patches should be applied after my other patches:
"[PATCH v2 1/3] wifi: rtl8xxxu: Move burst init to a function"

