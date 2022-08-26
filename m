Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F1E5A30D5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiHZVMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZVMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 17:12:46 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40937E589E
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 14:12:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 202so2427601pgc.8
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc;
        bh=POG5+eCcsauVD5ngyl48W7k4XbDPBYvyvSVLVpFK9S8=;
        b=Wm2X5SjF/lTm0nvY3up9ZmGv9evW33v612YUheyVFH0/q1AiEKL2yEzgnsxL5d63mN
         r6huin4zz586UQizoFNYFp3OhTf1JuS8s82mI3+C9Bq3+wjaiVmXRn3fvqosTmMxPxs8
         QqQIQ59xjJR2hx/RulseFiUlEGMnplW5ym5P11VFAM1H7kcXvuVz71ubShwnmL8uh0tP
         y2qNkpVbmS34efX7MM2mTr+F6L/GvreYBP/oFHhOK5tbaZ094SBE7VgHTCbQoRhiWFeY
         TBhWB98Xy70HJzB+g2dPLCAV5B/VhTZE7c3YDwTp+3ptWwpaJuBKMryNgXGWt2Ae0l4h
         WH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc;
        bh=POG5+eCcsauVD5ngyl48W7k4XbDPBYvyvSVLVpFK9S8=;
        b=XZ4Z/De33jfzeT4BRSxES1qnLHdpKo+RKRsizRA4/SVZnDMKhdY7w7t2WNaY4hw9yw
         e3rhCmnK/KFW6Pba5/hLGPf1VHUTUipUJwRsFQzAcNJyZd0Z3TsW/OXLpEGvhsnnlTqZ
         flH4HVRplhCpe6Sa0irRoYCH2egdlnWEBkmZVn4u6MY2mv/F8fJQyth7e8MCdC0Gh8K0
         Agk4zU+CCy1XAoxjMXB+PHx4Pl75+DyY1cVVll4RskmclJC86i/MU/rvsKz+N9inALgd
         p1oqRjVByLibtr2XJ8yZJN2Lnc4E+lL9bUCjvANuyzY2AvGWZbKhDV8eq1nX+15ehAnz
         wqTw==
X-Gm-Message-State: ACgBeo3OC1oKDo0acYwbNU2MQA2HeTZcsAKZm1gv5xZHQSF8DPX3pCas
        NNY0AcBOMC6Xfkxhqu59bA2z89h7N24=
X-Google-Smtp-Source: AA6agR6a/mRlnXk+xS+u5GktLjP2e/zNvcrZT3SnwPxR+oiTHIRyfLVS67fAGYzEJEuFm+y9lP2HOg==
X-Received: by 2002:a63:1459:0:b0:411:b06f:646f with SMTP id 25-20020a631459000000b00411b06f646fmr4697564pgu.338.1661548364500;
        Fri, 26 Aug 2022 14:12:44 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001728eb339e2sm2052564plh.286.2022.08.26.14.12.43
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:12:44 -0700 (PDT)
Message-ID: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
Subject: Automatically adding OCI in mac80211
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Aug 2022 14:12:43 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'll preface this with some background:

Long ago support for multiple authenticated BSS's was removed due to
its complexity. CMD_AUTHENTICATE now changes state/channel, and is not
recoverable if authentication fails (i.e. disconnect). The spec
actually allows/intends for multiple authentications to be supported
and FT specifically can really benefit from this.

As a workaround we started playing around with using
CMD_FRAME/offchannel for authentication, bypassing the kernels state.
This works, and we can authenticate, fail, try another BSS etc. all
without the kernel knowing, then proceed to association.

The small problem is dealing with OCV. Prior, we would call
CMD_AUTHENTICATE (channel changes), then GET_INTERFACE in order to
obtain the channel/operating class to build the OCI element. Now, since
authentication is done offchannel we cannot use GET_INTERFACE. Deriving
the OCI based on capabilities is certainly possible, after all this is
what the kernel does, but rather than trying to mirror/maintain that
code I thought it would be great if the kernel could append the OCI
automatically to the association request. This would also save a round
trip since GET_INTERFACE wouldn't be needed.

Does this sound reasonable?

Thanks,
James


