Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0059761E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiHQSwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiHQSwE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 14:52:04 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECD837F97
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 11:52:02 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11c4d7d4683so2976937fac.8
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=rTpBCMVtKmuntK/NfZbgoM8v6fhzpXVJF5UY94PY7Uc=;
        b=h0R81qX0LeB4TV+823LHVBpaA6d1AjamTa01Ww4zU/DRCpRBwB01PsGJDv0N/0p1dX
         X17Sjm3VJjWzK9F99mLps/YIHciCXGd/1wHCsmUCOxWxsH3xOioool67m4p5QW5Lp1c6
         fNTEdO7JrfKn7NxsaDigIhSNl23mgTuwLgp0QFa0qSf2XWiS+cXzoyh+79Gjxos/rvT6
         XPUg9l4w4EHpJzfAT+bmCx+aPRFtTnNYfXG5/i84Z7g/lJ0K4jFvXRXS9xPVOhNfeIXt
         d2BDtpzztiJVkD7kAxOI44NxESMr2QDOU3OTx49jSG58vHbCcKPv/Ao82+zrHFZ8urAd
         KSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=rTpBCMVtKmuntK/NfZbgoM8v6fhzpXVJF5UY94PY7Uc=;
        b=cZXcH9YQv0vdnA6VOQW60ngAPNhAQFeUIVosT+Yj6A8JhXIfPNbt+EK+dUrNEhxjeG
         L/lskrMYv5HH4CS4yfwbKhBwUA4p5x9dT1WS65qVLNlLSZDf+tdafr5PHA/CHVZafVfq
         /2NhSR+mXQ1uzAejrEQEpRh6G5/9d5aHuf1ammArLst39mdtDTG9sSgJ7IBESZYPlC2c
         xIRBtVMhX7DiqAOvSNBUrA/vxE8eqQQZB23zGUSc57pSA8BPJHv4ELuNHz7YOxhRRlsV
         PYD3mpgkrBYO1DREzuk+18rX8b3KEAH4B3CPax8/efG6DPmx12/fppOPeHOqp3ZGmp0X
         SF1A==
X-Gm-Message-State: ACgBeo3gmPl4/KrWKY+9YAcfr0JrliPxBI+TGQNW54tRCH7VQgfhISxV
        89koxfr/SvOxtrz0tL/5N5mcOsAckS8ONZkTLMqXbvsNPk0=
X-Google-Smtp-Source: AA6agR6iM0U3rG2peuZNwFM2ZTh1W0tLhF8Rj8ZRUN3vhwPkU/PDU+oNL46/auPm1PUoFpJsJ8XEfZp+c9UJ4X/me4w=
X-Received: by 2002:a05:6870:b682:b0:11b:d4d1:45bb with SMTP id
 cy2-20020a056870b68200b0011bd4d145bbmr2320260oab.241.1660762321225; Wed, 17
 Aug 2022 11:52:01 -0700 (PDT)
MIME-Version: 1.0
From:   Agus Isas <isasmendi.agus@gmail.com>
Date:   Wed, 17 Aug 2022 19:51:50 +0100
Message-ID: <CAE95GxXXq_-H0jmwiV5YMNFQCfE8feG0sPeLw_P50Zn9D7Yq6Q@mail.gmail.com>
Subject: [ RTW88 driver ] - P2P support
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Wireless Team:

I am reaching out to you to ask for any roadmap or intentions to add
P2P support to the RTW88 driver

Kind regards
Agustin Isasmendi
