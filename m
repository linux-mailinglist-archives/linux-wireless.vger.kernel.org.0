Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A364E52DA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 14:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiCWNPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 09:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiCWNPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 09:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 207D4DFF6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648041211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ifuc5oqWU21Io0fAnVVGyPcyUyUccxzM0pDfQGg0di4=;
        b=SAOduq4vPH7rQRzXDWU4tXtGq9f2RSCK4WkW6EitVW1T07oNWOVCMXc9Q9H4fuO9YBq66V
        ayl3DRLZWcnpJ2QU9+qS2T4ypjOHOd2NX7rkcgEMD8NBBu5LCRJw1OSMnZeb6S3FkdrGm4
        EQDMZFncoyDAPeYmElkz0xhhU9kNOMw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-wduDM0fSO1OuH6N6KMn-gw-1; Wed, 23 Mar 2022 09:13:30 -0400
X-MC-Unique: wduDM0fSO1OuH6N6KMn-gw-1
Received: by mail-qt1-f200.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so1105162qtw.20
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ifuc5oqWU21Io0fAnVVGyPcyUyUccxzM0pDfQGg0di4=;
        b=uMZjVC9Thja859t5u6Cu5oeu1OtOmMSyJojj50gzWU6HZuevKl92mzSrubwA2mCfH5
         EFUo4ZFmG//MTdrAnuTH5wq9nUP7hcZ8pHZzWc6nHHIU/CCBvir3ke2lDxFh9uWolbAU
         PDIoM3dCR3RsTEKu1RFzOTR5qtWgBH0o9f6fMkkRz8EH6PExzTOUgcrw4UjYx/qmN7kw
         giM6JPaZ1sITsxW7sCJmzlHIjkmQQ7Xtx+r0pMRa8Ms0pWn+wiwROAtbEgPZcoh/7ZXT
         Rj09MhXp3XvuxwFVZbgkpG+j7vWf7PdB+znhRsEHXYJDspHoMQumFKjyPoP7CI0vBxWx
         owoA==
X-Gm-Message-State: AOAM530CaV9uiMavbjKjDBfyzHH2XZfq02Og1DHupEv3k40jIv5RHdfB
        7Zg9TRVvAG8T7c3E8YsUR5fJ/y6K7xQEPXJx9rl8QDe7Q32AD8NtiO2ZLYIBTty3NdZSPw12XTp
        w3qNVQ8WlN8yI0mdP8hEvMg3NNaA=
X-Received: by 2002:ad4:5f05:0:b0:440:ea8c:c439 with SMTP id fo5-20020ad45f05000000b00440ea8cc439mr22435353qvb.69.1648041210026;
        Wed, 23 Mar 2022 06:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUgNb4wvcfdWZ2zbAFuWeegIGg+k6cziT03ZdV/wBH98ZC0J9cJTusg3OZ0832ZtCJW5BOOA==
X-Received: by 2002:ad4:5f05:0:b0:440:ea8c:c439 with SMTP id fo5-20020ad45f05000000b00440ea8cc439mr22435335qvb.69.1648041209812;
        Wed, 23 Mar 2022 06:13:29 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b202-20020ae9ebd3000000b0067b11d53365sm10517757qkg.47.2022.03.23.06.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:13:28 -0700 (PDT)
Subject: Re: [PATCH] ath9k: initialize arrays at compile time
To:     Joe Perches <joe@perches.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        John Crispin <john@phrozen.org>, toke@toke.dk,
        kvalo@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220320152028.2263518-1-trix@redhat.com>
 <af6042d0-952f-f497-57e7-37fef45a1f76@phrozen.org>
 <233074c3-03dc-cf8b-a597-da0fb5d98be0@newmedia-net.de>
 <7a12fd4599758b8cd5fd376db6c9a950d2ed2094.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c290ae27-9e4a-96ed-d8d6-a8b8bf8d0181@redhat.com>
Date:   Wed, 23 Mar 2022 06:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7a12fd4599758b8cd5fd376db6c9a950d2ed2094.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 3/20/22 10:36 AM, Joe Perches wrote:
> On Sun, 2022-03-20 at 18:17 +0100, Sebastian Gottschall wrote:
>> Am 20.03.2022 um 17:48 schrieb John Crispin:
>>>
>>> On 20.03.22 16:20, trix@redhat.com wrote:
>>>> array[size] = { 0 };
>>> should this not be array[size] = { }; ?!
>>>
>>> If I recall correctly { 0 } will only set the first element of the
>>> struct/array to 0 and leave random data in all others elements
>>>
>>>      John
>> You are right, john
> No.  The patch is fine.
>
> Though generally the newer code in the kernel uses
>
> 	type dec[size] = {};
>
> to initialize stack arrays.
>
> array stack declarations not using 0
>
> $ git grep -P '^\t(?:\w++\s*){1,2}\[\s*\w+\s*\]\s*=\s*\{\s*\};' -- '*.c' | wc -l
> 213
>
> array stack declarations using 0
>
> $ git grep -P '^\t(?:\w++\s*){1,2}\[\s*\w+\s*\]\s*=\s*\{\s*0\s*\};' -- '*.c' | wc -l
> 776
>
> Refer to the c standard section on initialization 6.7.8 subsections 19 and 21
>
> 19
>
> The initialization shall occur in initializer list order, each initializer provided for a
> particular subobject overriding any previously listed initializer for the same subobject
> all subobjects that are not initialized explicitly shall be initialized implicitly the same as
> objects that have static storage duration.
>
> ...
>
> 21
>
> If there are fewer initializers in a brace-enclosed list than there are elements or members
> of an aggregate, or fewer characters in a string literal used to initialize an array of known
> size than there are elements in the array, the remainder of the aggregate shall be
> initialized implicitly the same as objects that have static storage duration.
>
Joe,

Thanks for providing these sections for c reference !

I will update the commit log and replace { 0 } with { }

Tom

