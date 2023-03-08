Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B604D6B1510
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCHW13 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 17:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCHW12 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 17:27:28 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3424D2886E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 14:27:28 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ks17so228692qvb.6
        for <linux-wireless@vger.kernel.org>; Wed, 08 Mar 2023 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678314447;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEf+AExShPx1OxizK74Vck7+V+R0v3E0oj9U3JcETH0=;
        b=h7IQlCyI96UOeb6sPda8rf7oxx+WhGRkY3yLgYK32Hk5aOVfZ3klreaNkmu91kaSDK
         tNK8Ag9BQ19CRTsoKXKLmiATjGjbvRZDeVvxD8RgyLS/NkskQoN57UIm2jqcoc2UVdic
         8ydZSeZeW8AeNSqHoI+n6XiPgLWPV+vE5Ey5s8539YXvgFIHJzuJYilw2N7FqxIC+fgG
         FEgsmwInh6CSyLYERTnH7xZothyaRKl4YumilRr/kCUhpVQvszQbg1a7rTdrtjFZg4ak
         V4fxgRPquc0aj4PHqRyZmZKuw1nVlwWG5puICHzCJg3oq0EyDbDihZ+x0s3xLl7tSCvi
         yxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678314447;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEf+AExShPx1OxizK74Vck7+V+R0v3E0oj9U3JcETH0=;
        b=0DswnJq1PIaiHoV/IG6kk2htB8d5jf3haBtUfcSEx/1+oqufvGBWCybxhSvkHoGbok
         TkW0my5hXvh8+IO1EcF/AyuLPBZy89smSA2NpSLxRUQgVjJPeS0oEN5hwGtlOO1J7gy7
         Z3e+LgzTKHa9gjEN/9sIwGfCfiLNr3b6ElB3Db9ZG/v235YjOqfwE7gUOKbZIkwwCJia
         hD0vtwE2aOdZsqPMEaHvenOsbLAHIYMRfBP04CqwZ5oaeMzuukCfTxRlvoXpjKLRFbce
         ai/fZu9XwgFgVUY4/DOYL87zi/Oe/AMB8Shcvf7pzhmUbCebhOj5LnGjMDqxuEcDsTTA
         2KVw==
X-Gm-Message-State: AO0yUKWEfPwHXVrhIm6CDoCKjNNUmSvOlqKoliXaqkl2mhMWg7JdeUdP
        /Vz9zNHUvx7hf+7fRF5Vsl1/4ICBIWfOfZw32Oo=
X-Google-Smtp-Source: AK7set+OYr3jB/JOrudWvUqVJO4wn7Kj5p4wSUpRhJaNOvitb+VEqqvl6xX2K48gX/cSaVN1I9JneHTK6FGzoHnDXbw=
X-Received: by 2002:a05:6214:913:b0:56e:ff38:46a2 with SMTP id
 dj19-20020a056214091300b0056eff3846a2mr5307038qvb.10.1678314447349; Wed, 08
 Mar 2023 14:27:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:4750:0:b0:3bf:c45d:f926 with HTTP; Wed, 8 Mar 2023
 14:27:26 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <milleymilley83@gmail.com>
Date:   Wed, 8 Mar 2023 22:27:26 +0000
Message-ID: <CAEuePDHqf3Ccz07XR7DdEBx1ddjmf+ARga_kTn2cWG-AQ8NX0A@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Dear Friend,

How are you today? I have an important message for you just reply to
me and I will send you more details.

Regards
Mr Thaj Xoa
