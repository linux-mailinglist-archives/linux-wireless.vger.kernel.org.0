Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29721AFB18
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 16:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDSOIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDSOIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 10:08:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70598C061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 07:08:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so8754732wrx.4
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZLLEpCD9H8d5LRNzUZJcqAKJ3Rc0jHIalb3+VLXQypE=;
        b=Pe3OCKEN9ryGroIfKUXdabgrE+tYzK4zFX9HdBGDpFt9QDpKlLJkxhK+6vzMpkyISA
         bHFymdrcHOztCPJxgM0+it23eWucOwGOZqoZFkIHMSKVYMBuDJOKDBcSbYZl19Ncqc3w
         WcVZn7yk6TlguGIZNysMtGQoof4qMlaVS39EeLYzRLU7h/BGqtNhGXksszH16Bkkmkn1
         sU9J5jxDravCQV7zeUZX3ZqjWxdft9lSEiY9emK7CJwGV21EHQ+w2T6YW9XPMureTYUZ
         aIID4vuIUl8JSnwb64jeqlJ2BmrTM94tXQ7fjdGEvFqOzoK6he96shQg6RlrplzEWN4M
         RzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZLLEpCD9H8d5LRNzUZJcqAKJ3Rc0jHIalb3+VLXQypE=;
        b=mqQeDOUiRtHWcJwUXr7PL248lhakxVd4oudl4CSVGXlH4E9JVugi6bZEb5GCN4CaSl
         KV1+qQ4mT7+pDib+Y5w8jayFiW42uNIzN9HfftZfpej1tJ7YnWbDIz44mGYNm7AZXBBO
         RqZBCSUOnoKrNyDrvU6s0J38PxjAO9/3R5YaTD9PX0poHg7SSFPkk5rZmWsDOhCWvgzG
         aEjbLBvtlhRLeQyvs4CW9TeqpsRIrb7w5k/eoWhqUUVNu0gpc59IalRC9qCqDvPcnj2v
         C7cE00nBlTAmHiz/ox+qUgR997f64HMXzZHbwntH2+0yhtHwoP+GXgAVsrKS9tWtlfVo
         FWRA==
X-Gm-Message-State: AGi0PuZ1UDWVNlN1pN44shtvnY7yMq/sDBPPb58jLegrKTQtG0LdldVp
        zfhl1P9T8KV7Jc8pFwE=
X-Google-Smtp-Source: APiQypKjcSRAoS8ku+R38Ww6BPe2e8hd0Cs9rRLeaZlyqUdgJK0XnkL5ach4hPcrFUljpZHgUAviKg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr5807724wrs.311.1587305289900;
        Sun, 19 Apr 2020 07:08:09 -0700 (PDT)
Received: from [192.168.25.100] (ip-178-203-18-50.hsi10.unitymediagroup.de. [178.203.18.50])
        by smtp.googlemail.com with ESMTPSA id 5sm15866212wmg.34.2020.04.19.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 07:08:09 -0700 (PDT)
Subject: Re: [Bug] carl9170 + wpa_supplicant: P2P mode doesn't work with
 separate interfaces
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     chunkeey@googlemail.com, j@w1.fi, linux-wireless@vger.kernel.org
References: <3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
 <8972271.5nXPVzACVl@debian64>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <9fb16dd0-4dda-c3cc-7e67-686e2ad002e6@googlemail.com>
Date:   Sun, 19 Apr 2020 16:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8972271.5nXPVzACVl@debian64>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 18.04.20 um 18:30 schrieb Christian Lamparter:
> Hi,
>
> On Saturday, 18 April 2020 13:20:27 CEST Frank Schäfer wrote:
>> I'm currently testing Miraclecast
>> (https://github.com/albfan/miraclecast), an open source
>> Wifi-Display/Miracast implementation.
>> In one of my setups, I'm using a carl9170 device as sink, which fails
>> with the following debugging output:
>>
> It's been a very long time. But I do remember meddling with P2P. Part of the
> reason is that the carl9170 driver needed these virtual interfaces initialized
> in a specific order.
>
> So for P2P GO+CLIENT, you would have to initialize the P2P-GO interface first
> and the P2P Client interface second. Which is backwards of what the wpa_supplicant
> does.
>
> Same is true for STA+AP (Repeater). The AP has to start first before the STA
> can be brought up (Also the STA must not interfere with channel operations, as
> the fast channel change feature doesn't work right on the AR9170 Hardware).
>
> This is documented in the driver:
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/carl9170/main.c#n625>
>
> and was changed as part of this commit:
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/carl9170/main.c?id=7f878b0d96e6b3bd27d736fb2fb7e3cc94b16b26>
>
> that identifies the wpa_supplicant commit
> ["nl80211: Automatically use concurrent P2P if possible"] as the reason.
>
> So since this broke, something must have changed since 2012 I guess.
> But I need more details, before I can do something.
Please let me know what you need. :)

Regards,
Frank

> Regards,
> Christian
>

