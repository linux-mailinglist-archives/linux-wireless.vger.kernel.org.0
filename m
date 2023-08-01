Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF776B7F5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjHAOs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjHAOs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD4912B
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690901261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDFlIiQrElZ4oItn1kXIvNi24PeRJ+jUaah30LuHPpQ=;
        b=jEjvn3u90kMFLj1c/qeJPllhFGq5XetXScu+Ofe3JKICJQb1xfBxMXVfUd3ULHfm+Mgkcp
        +BkgSpHvnp3pFCjM0hqnmJi2FLa+zVOeESr/QWgT9vCwzdRD59lO8wvX3PGhWcPFEsLxbU
        dg3nOE0i6M6cR/dne2Ky0J6RZGHFt1A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-VCTnquGhN4iADrQ538eY3Q-1; Tue, 01 Aug 2023 10:47:39 -0400
X-MC-Unique: VCTnquGhN4iADrQ538eY3Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso416688066b.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 07:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901257; x=1691506057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDFlIiQrElZ4oItn1kXIvNi24PeRJ+jUaah30LuHPpQ=;
        b=cszYlpMdEZerVE5hAhKvxewluAoty32Z81srk+bbY66DxafT9Xh+7dzFjUjjUjPnf0
         kb44l7X0CqID/86rPDWqVFAdOk90DRETFcQdtO1vT/jQZvQXoEhfQ/u4Ue/kqWxgUFAD
         vfXBrGFQk0YJnPND7tSIifxYN/KRrxQ8KeOvO5JBOxTkDd3FuYC0zwqS0p1v+P+IKCXy
         WqRuIpMnIFyPg0DN5FIQ/ljX3gO+FSBAVDdET+IUBRbc7WUV2LRL7pTN17UfPZxTdoOu
         2qGGG40uFrcSOXxNdjKq1VEDSE3dhV9kqiHXdbQWh5ZxdnfYl3+JnxG1yCYpAW1mHis7
         g1Ug==
X-Gm-Message-State: ABy/qLYZOmz/u3i1lzDX60dpJx9kaKgipLC+2b+v/Yjk/79y9lOKmw8w
        IYUlGHt5hzonSYhlmJbeJAwIhJ6/YHNBr9r/dbHg0qBaqomI4hzLhrxweZVt12y7Ha587lOnYDZ
        XZBV/p20qGASYkCmTMPVcFbuHixc=
X-Received: by 2002:a17:907:2cd2:b0:991:d2a8:658a with SMTP id hg18-20020a1709072cd200b00991d2a8658amr2565124ejc.34.1690901257831;
        Tue, 01 Aug 2023 07:47:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlET+V6ff7GLEVqm2QdIiFq3kLaPkmNQTdZ6KlD25vtgFKja7pQnny8W0M8VGC8cXSBPUFlRuQ==
X-Received: by 2002:a17:907:2cd2:b0:991:d2a8:658a with SMTP id hg18-20020a1709072cd200b00991d2a8658amr2565106ejc.34.1690901257468;
        Tue, 01 Aug 2023 07:47:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id gl13-20020a170906e0cd00b00982d0563b11sm7693890ejb.197.2023.08.01.07.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:47:36 -0700 (PDT)
Message-ID: <57b9d6c8-557f-fbd7-0069-c84691a76ff4@redhat.com>
Date:   Tue, 1 Aug 2023 16:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: brcmfmac: Fix field-spanning write in
 brcmf_scan_params_v2_to_v1()
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Kees Cook <keescook@chromium.org>
References: <20230729140500.27892-1-hdegoede@redhat.com>
 <169090065747.212423.9892152660352726427.kvalo@kernel.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <169090065747.212423.9892152660352726427.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 8/1/23 16:37, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Using brcmfmac with 6.5-rc3 on a brcmfmac43241b4-sdio triggers
>> a backtrace caused by the following field-spanning error:
>>
>> memcpy: detected field-spanning write (size 120) of single field
>>   "&params_le->channel_list[0]" at
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size 2)
>>
>> Fix this by replacing the channel_list[1] declaration at the end of
>> the struct with a flexible array declaration.
>>
>> Most users of struct brcmf_scan_params_le calculate the size to alloc
>> using the size of the non flex-array part of the struct + needed extra
>> space, so they do not care about sizeof(struct brcmf_scan_params_le).
>>
>> brcmf_notify_escan_complete() however uses the struct on the stack,
>> expecting there to be room for at least 1 entry in the channel-list
>> to store the special -1 abort channel-id.
>>
>> To make this work use an anonymous union with a padding member
>> added + the actual channel_list flexible array.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Does the driver still work even if this warning is printed? I'm wondering
> should I take this to wireless or wireless-next. Also a review from Broadcom
> would be really good.

It works fine, but it logs an oops / backtrace.

Note I did test the patch on a device where the warning was triggered and the warning is gone and wifi association still works.

So there is a slight preference to get this as a fix into 6.5 from my side.

> What about a Fixes tag? 

This is caused by the new field-spanning wtire checks enabled recently, so there is not really a brcmfmac commit to point to as the culprit.

Regards,

Hans

 

