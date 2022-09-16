Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A025BAC7D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiIPLdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiIPLdE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 07:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3988FAA4D5
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663327978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTSicISb1hk/TLAXdbdqNbzNjpLc473fH+wL/mqgf/Q=;
        b=WOzSCZyeKMcUMEZkiCvhRLvzihbmGgQB3bQACbH0tcogDk9ZswO1HzgLUCO+8so/jLHfO4
        7/u1YrfnyUJy29V5Vdvd+fQmAJ3AgDJqQSDbx5r0v2TKNmDy+9puajko8amOFoUUJVtAtR
        iHNoFUdlwq9q0svzUHfzCaZnS5S5ub8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-PO85gsVKOUCwBYYm3CZpXA-1; Fri, 16 Sep 2022 07:32:57 -0400
X-MC-Unique: PO85gsVKOUCwBYYm3CZpXA-1
Received: by mail-ed1-f72.google.com with SMTP id y9-20020a056402270900b00451dfbbc9b2so10291547edd.12
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 04:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BTSicISb1hk/TLAXdbdqNbzNjpLc473fH+wL/mqgf/Q=;
        b=n7GlcIy08kwlN0/EAotUXVYCqvfkQX9jVcbwYkBX3yZnagXS3DtR/XJh8kdjWAdpSj
         ypeLgAXJMsZQdsfxWnFwrszDDHjKTEN04Zh3gjadV2YIAywb8TOgyUzQNrUBH2wKwG+q
         lmYaSmGl7h6z7kGE6LvJkJU8snbHx2QZGf3ThsBBcJmU3sIzxk+3ytpj46aJha4Y/1gx
         0Wo1Ce+TxuxMgxiKMFM/3owmh1XURwlmGtOfMjku2kkH4FiO1iu+MRCpxRwJsfYXZrhx
         rsLbyZheckc7WbVXUsj7xt28E9w9ZJQse4xvDViAs2VOzY1M7+FFczqFIXIlpxo+lASk
         BW8Q==
X-Gm-Message-State: ACrzQf1+mTWN0OrGQz6+U3ACU5kCfnl5kbs5aaJJE04PdO8mmKEQn5hG
        XxKqpNHNK6k/2Hw0GwlvsZFqNUsbrcY5qNQrly27s70uaTfA+EXXRCVYjQ762h8d5Spslh8gf7f
        IYcNutE1QmzNUeUCEIjA1ajanvkg=
X-Received: by 2002:a05:6402:3489:b0:451:a859:8a4f with SMTP id v9-20020a056402348900b00451a8598a4fmr3536696edc.279.1663327976100;
        Fri, 16 Sep 2022 04:32:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4epeadLG+4P+oIQ/aX5/HS0cZ6uTuO5Zu4erzuvtU8nPTnGgxgCXnliKuCv6kSFmVsKA4YnQ==
X-Received: by 2002:a05:6402:3489:b0:451:a859:8a4f with SMTP id v9-20020a056402348900b00451a8598a4fmr3536684edc.279.1663327975937;
        Fri, 16 Sep 2022 04:32:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402185700b0044f0a2b9363sm13041742edy.41.2022.09.16.04.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 04:32:55 -0700 (PDT)
Message-ID: <fe792366-26b8-882e-c5e3-4e124a21e768@redhat.com>
Date:   Fri, 16 Sep 2022 13:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/1] wifi: rt2x00: Fix "Error - Attempt to send packet
 over invalid queue 2"
Content-Language: en-US
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20220908173618.155291-1-hdegoede@redhat.com>
 <20220908173618.155291-2-hdegoede@redhat.com> <20220915185608.GA10590@wp.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220915185608.GA10590@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 9/15/22 20:56, Stanislaw Gruszka wrote:
> On Thu, Sep 08, 2022 at 07:36:18PM +0200, Hans de Goede wrote:
>> Even though ieee80211_hw.queues is set to 2, the ralink rt2x00 driver
>> is seeing tx skbs submitted to it with the queue-id set to 2 / set to
>> IEEE80211_AC_BE on a rt2500 card when associating with an access-point.
> 
> I'm impressed you have still working rt2500 card :-)

I recently become the owner of a Turion64 based MSI S270 laptop to test
some kernel code I was refactoring on. This has a mini-pci rt2500 card,
which indeed still works after this fix.

The thing has 2G RAM and even runs a Fedora 37 beta but the CPU is
quite slow and gets pretty toasty.

>> This causes rt2x00queue_get_tx_queue() to return NULL and the following
>> error to be logged: "ieee80211 phy0: rt2x00mac_tx: Error - Attempt to
>> send packet over invalid queue 2", after which association with the AP
>> fails.
>>
>> This patch works around this by mapping QID_AC_BE and QID_AC_BK
>> to QID_AC_VI when there are only 2 tx_queues.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks.

Regards,

Hans

