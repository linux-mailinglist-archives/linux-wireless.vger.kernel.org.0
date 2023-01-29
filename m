Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3367FE1D
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Jan 2023 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjA2KQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Jan 2023 05:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjA2KQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Jan 2023 05:16:38 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BF2332F
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 02:16:35 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q6so832816ior.12
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g5IBe5UTsevcTshAgBB76XBrtyBK5HUE5XKUcKD5N2Y=;
        b=d/7QcExYJWf+2g08OyQESgzl1Y4KwsFydsM723Cdv7v0U50wCpiqi1ZoaAiLIAnLco
         pL7TCKCk+h7AvqrQEoaw89hrptqW3MSqjdNKu3Imvd0J+u2F7KvD4PJoxooxlV43GkXo
         d1O3214Ee4OVgKwKezqPzM5vokApicDmRk06+cGoXAAfYnPJ7BVqcIl8SI9Zh0iSzrpP
         PRzjb1hq77GlRnB5H2/iExnN0gMh6lPZSOES4TWLJvjmMNbaBK+SiDmEbr7kDhkfWdJb
         OdzlX9GVsLyR3vAPPtR5JNdKcB5rLgcuI+r38FDNXtZK0cTPAdc0cdq5ig+/bHdaY8jT
         bpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5IBe5UTsevcTshAgBB76XBrtyBK5HUE5XKUcKD5N2Y=;
        b=O6FzpXcjqakYB8Ofev5dNwTXuQy2EzSWqaVv7vZZsNjegDF8ANaw6EKWJRlnI8A/w+
         g3fVojlZL66C+vvdMeqb4QeRRqmkMkVQ8PAVfybIN8uffRxMbS7Bv3gKsrZHfjZv7nEd
         HAE9L+mCgFkbd/BQFPL2tFRcpXEJd5puMVRaWXI07LDkumqEr88lgBq+SV1mGdGeaGL6
         5fxqCy9RCNeFtJ2MXD73oMje7Ii0eKTB/ZPPaRvvXFlJ+NVaI2BAS85XrxNdIao7C0lT
         zuJzpH5HoeMcAMO4JrHl/kROpDI9FVX7BABmrw2yz60JNDqg4n8Bdn2uZhxBv4M/WLRR
         p62w==
X-Gm-Message-State: AFqh2kpsjGtKHvKTCQqpk4BL0ieKn8sb/O91UCcGEOZ2RrGmVSlT1RHf
        lO1ikNhmI/+kmeSuaJw4wSzwRlxeY3+/cFcTgj9pm4qdPKo=
X-Google-Smtp-Source: AMrXdXsLPnmnRvggdbLOveEy/yAnWbOjxSvYGvOp/3Mt3qL1hs9KP9YdxzW3c7HtDRyqc5bCd5mmXnoGu6agpXNOpmA=
X-Received: by 2002:a02:a993:0:b0:39e:8a0f:90e6 with SMTP id
 q19-20020a02a993000000b0039e8a0f90e6mr5326921jam.43.1674987395013; Sun, 29
 Jan 2023 02:16:35 -0800 (PST)
MIME-Version: 1.0
From:   Eugene Konev <uejikov@gmail.com>
Date:   Sun, 29 Jan 2023 17:16:23 +0700
Message-ID: <CAO7DJoDCV_NnKqR==GYmtFnMdJrbEvz7UzTQjydWPs4RnaCkpQ@mail.gmail.com>
Subject: wireless-regdb: Regulatory rules for Russia (RU) on 5GHz
To:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current regulatory rules for using 5GHz bands in Russia are the following:
5150-5350 MHz: Max EIRP spectral density 20 mW/MHz, max EIRP 200 mWt,
indoor use only, automatic transmit power control.
5650-5850 MHz: Max EIRP spectral density 20 mW/MHz, max EIRP 200 mW,
indoor use only, automatic transmit power control.
(rules in russian: https://docs.cntd.ru/document/902048009?section=text)

Does automatic transmit power control requirement means that DFS
should be enabled on both bands? If so, which DFS region should be
assigned? DFS-ETSI?

-- 
Eugene Konev
