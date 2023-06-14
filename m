Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD507301AD
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjFNOXX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbjFNOXT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 10:23:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1021FE4
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 07:23:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977e0fbd742so106222266b.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686752596; x=1689344596;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f6KV74UfGAzM8eXVX9MpCBGMpP92nQDTWLq1NYjh0/M=;
        b=nk4xX519MuF5cvSKyEMDyEHEiQkpo00BOFasSUB6Kq7r1TzBmGe5Qeet5BZ5c9EGNR
         aHUCExvWr7F2gMhZwScBEP6lBP1QqGDzmLQKWFC5sJf8fURLUOccjphyHoyMNtpomkkI
         DfqKqu6CC47Mf8OFU3Xj97smC8lxps8LYwNa+DlVEtE05RHfsutPPUDFkhoAFKYLwzE1
         gGRVsqrP2F0aHOG2ske/puSq0KouhdD9Ks1Btlmr6LWcJNQiYdfxnMqWA5fOJKs+lc1B
         yCUsvrWffi83trg9b58mt4tgmoV64tTsNlCOkrb9BKnVXDiE6U3nSIM+yjv/3D0plJW0
         3Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752596; x=1689344596;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6KV74UfGAzM8eXVX9MpCBGMpP92nQDTWLq1NYjh0/M=;
        b=W48jAVmsNLQpt9lenGEwpMblbsA56vLe9taWFK/gRFi7nrK9QeNRj+FsXwZBVcgmTT
         E3usjxI05BMaEmQZwch8CbgBmbVQsqvGwQQSW6Et2SDYOcLrChAprCCsPKtxZgQ4CBGG
         T4E17Oyz1iBPaH84M4TR7vDwits5/1ajkzd1q5h1B1lC+yBrWdB7Z7UYKWHRUqAi8ZLW
         qDIkZxwF/81FdMuhs2T6uylrTV3y3AH9tAKPBRlAEPsTrw+uNC2PFUdD0Sy4lLFS1ia8
         GLy0U1l3IzjeP2Gv2O5NxD17+RRWUcAyH5hLtb/Xdt9gh4b1m5oGgEhyFUmCzY+1ZtJ0
         wCjQ==
X-Gm-Message-State: AC+VfDxOL4ctkB9IZ5tUDvr/miVSKvvWf489qTrEYcELy+2xr++oPPBM
        sXjg2t4CVq8Npy0PSdvZAvA/ToQXA4lV36Sovpw=
X-Google-Smtp-Source: ACHHUZ7tV997HpRVvMYFqciu0KMrQzg2YoNU0mGB1Z5X+PhIUltQKQAta8RoiP2i6sLOp5n7cHNuzIKOJMphs3eBt3o=
X-Received: by 2002:a17:906:ee82:b0:96a:ca96:3e49 with SMTP id
 wt2-20020a170906ee8200b0096aca963e49mr16952024ejb.13.1686752596243; Wed, 14
 Jun 2023 07:23:16 -0700 (PDT)
MIME-Version: 1.0
From:   Clover Baker <clover.onedatasolution123@gmail.com>
Date:   Wed, 14 Jun 2023 09:23:01 -0500
Message-ID: <CADkOh=L4yN3iV1vkgM6p59z-0o0yDNE+6rKYmnMp2DH1or10qA@mail.gmail.com>
Subject: RE: Registered IMS Attendees Email Lists
To:     Clover Baker <clover.onedatasolution123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring the International Microwave
Symposium Attendees Email List-2023? Which Includes Complete Contact
Details And Verified Email Address.

Number of Contacts :-10,365
Cost :- USD- 1523

Kind Regards,
Clover Baker
Marketing Coordinator
