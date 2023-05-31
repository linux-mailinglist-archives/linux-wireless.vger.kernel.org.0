Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FCD71886C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEaRZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjEaRZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 13:25:49 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AFC139
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 10:25:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6af70ff2761so14279a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685553946; x=1688145946;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=gq8uuaWi3tjBb8lgBaKn6O9xIMVUcRbjpgftfQvNfoXTtdwstl4CjlfbnE9DNMzzLx
         w4H3LphAyAVMTXGNBo8mnU46wS/t6x5ZJ9WilMkH1ozfl2Nkc3Ou+B/YTXyzqJTtqdgx
         bucKfGTJegE6yNJNU5gPhC6Q1WA4d3gzRjb3mYdRkhHbhtL2WcM5yETsoldzA6dVRedM
         LI6x+idBXSyt+0psBxM3rv1KIUTsHMLxzw3L0Q2vdETAVFXyp4l8wg3RKtfWP0GKzIzI
         I49t/qrqQGIKbnCDq5fFBNnbElE95BCG8b1yDwuP0bo6GSIzxpRg290A2r782Z4+ewfP
         X9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553946; x=1688145946;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=kvBBZ7zSqJllvFDvptDUOBvDF8jxLyyuVkzHQEtRuC97/oNgkLdcJhhH0EA40BVCdx
         PvsRPLd+MYOOPuFyws4337ABXILqH2Fq+lT9m0tG0ALcSQ6lFSiwqntxaFGBMk+69hEh
         w2bdALqM38lL6+uo4lXLr/wUTpcAh/dcMIvm5J/dQtRmi/GowNS3kIGbraWYlLAyJlN/
         diY+cYz+PvAdZQn4oByiSeyfhku6O0pVnvjdGx6yrCyuaBtpbCUWnvDwtfJkzklFiWKS
         /2BIx4NpK7nnYqhDXJBZrKPfuvTG7cu7zpksjjU/uT4jS3Cio3Zxo1lAi3MEFTEVn0IK
         mUeA==
X-Gm-Message-State: AC+VfDyPZQ6AxGwqY4WIDgPA5I89lY9bSwF0dZ0o20SsE7Fyim60YujK
        GX6oqWc5Kk32mXXaJgVrJU4nfa7U6d7SJmUu9WQ=
X-Google-Smtp-Source: ACHHUZ7sv2mwDrvp8Mw2bkLt3rlVmtYly/b+EU/j+f4gdbLNSSvftCHILVQTe4f3cXu9xSU5TdGLOaRr/NKC42OPJNU=
X-Received: by 2002:a05:6870:b145:b0:187:e563:77b9 with SMTP id
 a5-20020a056870b14500b00187e56377b9mr4816660oal.45.1685553946215; Wed, 31 May
 2023 10:25:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:282:b0:121:df1:6e37 with HTTP; Wed, 31 May 2023
 10:25:45 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <prettypercious@gmail.com>
Date:   Wed, 31 May 2023 19:25:45 +0200
Message-ID: <CAF8i-5GoC1b3-5e=MtmaagY_rudw5qs9O=fY2JMHym6=r4v8Fw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
