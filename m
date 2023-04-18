Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8D6E6817
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjDRPa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjDRPa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 11:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539710D8
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681831744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rocOVF8/fhVxh+QBiloSk0v5TX8qruWg7u4j45jgdWM=;
        b=BdipGp9k2R3QaHSBhGaHCx4QbudmjdRz3QaqtqHFifQE2s4V3f3c7Dpt/Xu+7V8r6qPUpk
        yHYPQ32UoAjTSXV+zwGSYozV7wcjVSRSAOkFhoJ6PPdxHfc6un4XfnfKM9jQJf5giSxynH
        JU5xnCyM94HYw8yxD1ouwaSdBoEWk4Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-HUTxN2S5PbCWUGpXxEwOQA-1; Tue, 18 Apr 2023 11:29:03 -0400
X-MC-Unique: HUTxN2S5PbCWUGpXxEwOQA-1
Received: by mail-ej1-f69.google.com with SMTP id vb5-20020a170907d04500b0094f734c6a5dso2775915ejc.12
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 08:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831742; x=1684423742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rocOVF8/fhVxh+QBiloSk0v5TX8qruWg7u4j45jgdWM=;
        b=XLByXzom/VOZte3dMXUi/7OkJ0TmM73LEhFTVDy0IeNGVEOcMmguGdHLHOXdRBa5sT
         OgI7a0lPHQ3DIBeJEVGAmx0x8Qmfj5mPnmktmPUsSKSm2Ta1/x6R6KdwSS1c6cbDwLd4
         pYheix9ZhSBqVYaRsFs2PbAL48fglzitUIvZBangCU+QYGryDoGiNCbfkOkEz6Tcpo/l
         eZlYoh3werV+VnZj4zt83Vf3QBhM5t2icD1VrQal2e9GnFkpRQyOiixc5W2dP74/oqsw
         5Jf7XVLU2calVJOJGnwuwA3LdJG10BzIHKmxGHKvIvL9g/7YHGq23i24yY4z/q7yF/0j
         ykkw==
X-Gm-Message-State: AAQBX9fBJB6s/23TszF/ywasSQoyOJkSrsVYG+JvE6UCSDTXcNqYQ1Nu
        pR1PkHSK7F+Z88aG8e2m/HPdLnHdR/9iBVMwIym0j+SjkXtZ0jmPR5xImKom5HHyciaYsGFx12H
        oydCnp3HavojCg2M9TgcYrPCj0Cs=
X-Received: by 2002:a17:906:e247:b0:94e:e3c3:aebe with SMTP id gq7-20020a170906e24700b0094ee3c3aebemr10897363ejb.0.1681831741854;
        Tue, 18 Apr 2023 08:29:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVsmfdQBRrmMncUjZIbigGfRPclzUiQh76N/9s+/10AyJEdnZEh2naZCwSTD6Gaf0d0yzuYg==
X-Received: by 2002:a17:906:e247:b0:94e:e3c3:aebe with SMTP id gq7-20020a170906e24700b0094ee3c3aebemr10897343ejb.0.1681831741592;
        Tue, 18 Apr 2023 08:29:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090660c300b0094a789256dcsm8142439ejk.111.2023.04.18.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:29:00 -0700 (PDT)
Message-ID: <80b22368-718b-a7d8-eb01-9bb7b4d22742@redhat.com>
Date:   Tue, 18 Apr 2023 17:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: iwlwifi: dvm: Fix memcpy: detected field-spanning
 write backtrace
To:     Johannes Berg <johannes@sipsolutions.net>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20230418132546.45297-1-hdegoede@redhat.com>
 <9619692082caef649e236eb154129e922c46b547.camel@sipsolutions.net>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9619692082caef649e236eb154129e922c46b547.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 4/18/23 16:43, Johannes Berg wrote:
> On Tue, 2023-04-18 at 15:25 +0200, Hans de Goede wrote:
>> A received TKIP key may be up to 32 bytes because it may contain
>> MIC rx/tx keys too. These are not used by iwl and copying these
>> over overflows the iwl_keyinfo.key field.
> 
> Thanks for doing (and more importantly testing) this :)
> 
>> -		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
>> +		/* keyconf may contain MIC rx/tx keys which iwl does not use */
>> +		to_copy = min_t(size_t, sizeof(sta_cmd.key.key), keyconf->keylen);
>> +		memcpy(sta_cmd.key.key, keyconf->key, to_copy);
>>
> 
> I'd kind of argue that just hardcoding 16 is fine here, keylen _looks_
> variable so the compiler can't optimize it away, but in reality keylen
> always must be 32 and sizeof() must be always 16 :)

It is not just the compiler to whom  keylen _looks_ variable,
so to be safe I went with the min_t() check. I think this
also makes the code easier to understand for future readers of
the code.

> But it also really doesn't matter.
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks.

> Should we Cc stable on this?

Yes I think so. I did not add the tag because some subsystems
want that to be left up to the maintainer.

Regards,

Hans


