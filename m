Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68AF5F520E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 11:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJEJvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJEJvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 05:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3E2B26C
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664963470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVnoRHWfL/uXph9fh+9JwKJ/yaZo6gYLYksyFHbNHmw=;
        b=cg4cQrgFHv4iHnrHX/yi1AdnW+Nko6hidlNv+vqZsYzniymAuqMrgf9z7uNqqjF5mZr+l3
        oJYLgoWcvRtm67W+Sl+oLexLhIH17o/IPRf9GsFmsRQxDzWH5D0V0FHoGnZhm44a/1X2YH
        QQA29HIrgUZfSDqY5SBzvTY2dLqXI7Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-NPbh8TxTMdSPgi0RfOwRIQ-1; Wed, 05 Oct 2022 05:51:09 -0400
X-MC-Unique: NPbh8TxTMdSPgi0RfOwRIQ-1
Received: by mail-pf1-f198.google.com with SMTP id a6-20020aa78e86000000b0055f94e0cf93so7146209pfr.20
        for <linux-wireless@vger.kernel.org>; Wed, 05 Oct 2022 02:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVnoRHWfL/uXph9fh+9JwKJ/yaZo6gYLYksyFHbNHmw=;
        b=odIV4s26FiFSGiq/eE0Sw66DIKl1Iw0O5XG/G7AnhMyPES3QOidKS4EETQY6by9MgH
         cuEFZpSLlm07UkqdKTzP2eYTNcInCBJeO+hNaSQOIqPWpUn/14bFmtKEjcMoh0/I8ssi
         zF7PqL+P4DZTpyo+L0kxzOL86UG9N61Z4xTkul1VhnwgFi1fGhVpzgfNFh7QyiyKnH5V
         kKx603KYCQVdp0BR0rAqlufHkvrOok+VXo8gB97mltyHkx7tnAG7DmTY917Y9un1jM4i
         h57YXW2MYeear+Xwg8afJsVwBStl7g5IoF1afAU+ORBtMJW9yTyYz+9M2tru/oby+7dN
         Ta1A==
X-Gm-Message-State: ACrzQf0jWsbItrPkoz7wm5rZktWLgpi1d5/9RkpZvdEZKfxOvHqL1SHv
        pEGvg2ev8Lx5Xb464QVY+ZYrJGrDr9A/vYd+MN2E0lzA3ctsxwIYIrPMSpevU2/L6aHbF8BGcmv
        E5Ry8ys9knKwWUAtMPGXxSjuznov0Nb7WoLMiYz1ben8=
X-Received: by 2002:a05:6a00:80b:b0:545:c0d2:9729 with SMTP id m11-20020a056a00080b00b00545c0d29729mr31839061pfk.66.1664963468055;
        Wed, 05 Oct 2022 02:51:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Fz1y00T7ng7HEj/X2cNDx9rAi25gQaQhbhvgxs7dUKMajX7H77hTgr3IT9SBNoosLAWGkMKemx1e0FBuW+uM=
X-Received: by 2002:a05:6a00:80b:b0:545:c0d2:9729 with SMTP id
 m11-20020a056a00080b00b00545c0d29729mr31839038pfk.66.1664963467795; Wed, 05
 Oct 2022 02:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
In-Reply-To: <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 5 Oct 2022 11:50:56 +0200
Message-ID: <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 5, 2022 at 11:35 AM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Fri, 2022-09-09 at 12:41 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > With an AC9560 installed on a system with Quasar (11th gen processor,
> > in my case) we're getting a firmware crash as soon as you try to do
> > something with the card. The problem doesn't happen with the card
> > installed in older platforms (8th / 9th gen), and it neither happens
> > with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any other
> > newer version.
> >
> > I've tried different versions of kernel and firmware, including the
> > latest kernel and linux-firmware available today, and all of them fail
> > unless I remove all fw files above version 55.
> >
>
> I believe this is a duplicate of
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D214343
>
> which was supposed to be fixed in firmware, but evidently that fix was
> never backported to older images.
>
> Internally, FW commit d8887278 fixed this, so FW version 69 should be
> OK?

I don't think so, we've reproduced it with iwlwifi-QuZ-a0-jf-b0-71.ucode

>
> I'm not sure we can easily workaround it in the driver? Maybe we can
> detect the RF, but that's kind of awkward.
>
> johannes
>


--=20
=C3=8D=C3=B1igo Huguet

