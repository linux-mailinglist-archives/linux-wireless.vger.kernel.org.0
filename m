Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C34D3D84
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiCIXZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 18:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCIXZN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 18:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED361527D1
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646868252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7ymHsgqFEN86o8611pDZsoSVDfvMkyfUVRqrMffFAo=;
        b=fOf6Gt301jLcm+cwF+fH94VjW1sSWkBe2qmd15FkLrMSK1HOHUHhHwecKQ8QQSzTTdIuYu
        r+y8XcKhXOq8438w8L7dLyyYT1FOg+OSiuNg5xNig5YxYDn5mzuprUq6S+1lz9VFlWglxT
        xbT8PswHvu2QMl4peVOhhPWrp4Nfo+M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-FDW6LY1kMVWxpgBuw2GU_Q-1; Wed, 09 Mar 2022 18:24:11 -0500
X-MC-Unique: FDW6LY1kMVWxpgBuw2GU_Q-1
Received: by mail-ej1-f71.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso2088734eje.20
        for <linux-wireless@vger.kernel.org>; Wed, 09 Mar 2022 15:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x7ymHsgqFEN86o8611pDZsoSVDfvMkyfUVRqrMffFAo=;
        b=O89SXbJXteTp0Shzisdc+YenSWlC2WjKlrNMGwyCh6RDYKt1jRm71AHzxnQRSmSVGx
         yo+xIRFXzxCJf+hMObYA+ygEPd37NnDL4MrchVo5V1jevryH2EWx7Ap5Bh1hqsV9BzTK
         15neVfV8jpdEcI3kUJCiFe+Ao9faIxxLfS9SdANaartgGhhKJtEiU3AoCY2H0DPyod2x
         sGwoSX7F00XNWbltp/qEVO2Lua1yKwIBFx5N2cVRqWnAQ0xzbGEOPmqpajm4FCbzmd5m
         n6V1tKd5AVbhUMY7CxszU/J9RICoy4p50B6t/4y7k3NeThwnxym/9EQ6onQtZhW0MxnF
         3oEA==
X-Gm-Message-State: AOAM53171RX50fIZohVbAVfwqmubIS+g6jISn5m16q4+y6hw83NzdBwT
        CKn3XS9PAGonOz0zZ+8SgAWtfrEWGs57AXYQzis9e2zQW3WuLXIMT8rcIdMl0LMHw5/c3Vcd8JA
        DwBOPvnN1Ze/1wM14qrqhjYQEl6g=
X-Received: by 2002:a17:906:c151:b0:6db:2b7f:302f with SMTP id dp17-20020a170906c15100b006db2b7f302fmr1957020ejc.4.1646868250009;
        Wed, 09 Mar 2022 15:24:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0EfvtomTcLzFKRD3f4im90mBpn+xhTpucpI09xBp8ExS1+NKJWAQ4aiF4uahPh9EZViolUw==
X-Received: by 2002:a17:906:c151:b0:6db:2b7f:302f with SMTP id dp17-20020a170906c15100b006db2b7f302fmr1957005ejc.4.1646868249579;
        Wed, 09 Mar 2022 15:24:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y6-20020a056402358600b004166413d27bsm1339194edc.97.2022.03.09.15.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:24:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 22F5D192B84; Thu, 10 Mar 2022 00:24:08 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wenli Looi <wlooi@ucalgary.ca>, Kalle Valo <kvalo@kernel.org>
Cc:     ath9k-devel@qca.qualcomm.com,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: QCN5502 support in ath9k
In-Reply-To: <CAKe_nd3Hc+5u9O0Bd31oFF_mTOJU9bx5hmcS1TkSy0FMtQamBA@mail.gmail.com>
References: <CAKe_nd1jthFhJhojQLXMeU741AoTks74K+J1v5FqS6ABB6gW-Q@mail.gmail.com>
 <87r18d1upk.fsf@kernel.org>
 <CAKe_nd3Hc+5u9O0Bd31oFF_mTOJU9bx5hmcS1TkSy0FMtQamBA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Mar 2022 00:24:08 +0100
Message-ID: <87mthyvhev.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> I've managed to get QCN5502 working in ath9k in a very hacky way, by
> mainly treating it as QCA956x, including the initvals:
>
> https://github.com/openwrt/openwrt/pull/9389
>
> It would be great if anyone could provide comments on the code, as
> well as the ideas for incorporating this cleanly into ath9k (and
> whether there would be interest in doing so).

I certainly wouldn't mind merging this support if it can be implemented
in a clean way; we'd have to be sure it doesn't break anything on
existing devices, of course.

You'll have to split out the code to co-exist with the ar9003. My
immediate thought would be that it would be a mistake to employ too
clever tricks to maximise code reuse. By all means, try to reuse as much
code as possible, but I'd rather take a bit of code duplication than end
up with something that works in non-obvious ways :)

Hope that helps!

-Toke

