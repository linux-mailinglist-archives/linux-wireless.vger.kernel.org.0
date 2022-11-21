Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA06329B5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 17:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKUQh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKUQhH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 11:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BBD53B4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669048535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uey9BFIixQm3jWN0lqHsZfoFIxzEui2/+ljprIZsSVk=;
        b=euZoWVfKAIy70rx9X9u3kMhxNpBAkse78PxeTLd4MVJTu5E4p5Pxa+HN4GicAHKLdLuStc
        27iX+5dP4VDMO+WUf8UvxVfVOxGsbiCeRo3vCxL5QSLRr1y/umcV8qL4/R4250QgiwQgsX
        mx80/R841V9B2mc19szu6vbpZt/+eTI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-5YS2s6JpOlqeERe2Z70ADg-1; Mon, 21 Nov 2022 11:35:33 -0500
X-MC-Unique: 5YS2s6JpOlqeERe2Z70ADg-1
Received: by mail-pl1-f197.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so9721468plh.12
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uey9BFIixQm3jWN0lqHsZfoFIxzEui2/+ljprIZsSVk=;
        b=UqaXANW5EZyWd55+/qWdXYnERpimb6ion8qMNQIzZNf60fS/nyPGp1x3vqZ1aSHYp5
         OSdlo+C/iMlJ51NogZ4i99zGvSGjSP1ySW1e00ZIjkCL22bns7SBZk7H+tkjai0DVrtc
         EK/9kik3RATlU5Lz7jic5NX7RKtCu3ZvaeHlKpoK6F7nylyaVLSZBpB657SORL2N0yMR
         qDCdwL4mXs5IPfrj4VzptAbD9HHhFe7ZrUENpzDUuTm7EKuDcLZkXFoyYyUUnxXDvivh
         8ykYz0kqtI97F7Qs1E7E+W8eDq3mf9Jppf4NvRg6pzIFxi4gT5dJDf0bqz4c/q/j6Ryy
         Jwtw==
X-Gm-Message-State: ANoB5pknRLVkfGCLxk4TTvRwz6eXSqVTUHNDWWlAOum7V8xCBKpOJgwR
        4MhQJDkVcWwkdsFqFQGr6ZjwQlWbiW4+YfsxfzjmqRhu8tgeff/BupNOftQjWjlzVDv+BPy5E1Z
        nLBNlK1/9toloeueDkOeVvAUaneQc9YisBy+j4+ikCaM=
X-Received: by 2002:a63:4b24:0:b0:476:e640:d016 with SMTP id y36-20020a634b24000000b00476e640d016mr18242048pga.205.1669048532469;
        Mon, 21 Nov 2022 08:35:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7A3cpC0Y768q6n1BR2+cjhQQLfduwmt/qipZb46MWH2KWTEDz0/0nve5ZsdnK6jxmJPLAACt67UFW/baEpj4U=
X-Received: by 2002:a63:4b24:0:b0:476:e640:d016 with SMTP id
 y36-20020a634b24000000b00476e640d016mr18242036pga.205.1669048532227; Mon, 21
 Nov 2022 08:35:32 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
 <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
 <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
 <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net> <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
In-Reply-To: <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 21 Nov 2022 17:35:20 +0100
Message-ID: <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 21, 2022 at 12:08 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com=
> wrote:
> > the fw 74 seems to be a different issue - could you post more info abou=
t
> > separately?

This was my fault: I was checking many different things, and I checked
this with an outdated kernel. With latest wireless tree and fw-74 it
works fine, both with the patch from this thread and without it. Sorry
for the noise.

So I will wait  for this patch to be posted so I can backport it to
RHEL, but using fw-74 also fixes the issue, as you said.

Thanks

--=20
=C3=8D=C3=B1igo Huguet

