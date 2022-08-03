Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263F4588FC1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Aug 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiHCPvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Aug 2022 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiHCPvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Aug 2022 11:51:32 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FECE092
        for <linux-wireless@vger.kernel.org>; Wed,  3 Aug 2022 08:51:01 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id 5so7142034uay.5
        for <linux-wireless@vger.kernel.org>; Wed, 03 Aug 2022 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pwy0C0AlAVnIZaPB2N2mM/GuLDYg6nuX90RHsXQRaY=;
        b=UHDl0fkl10i0mfB7pb2+VgogMb3FzcpdX+UThgog9vi1SM31wfO+boUQRnMHbbzk4q
         f0CgLyc7s6FgW3dlPDiUuPsarrALHizoMxxUsgWeJJSDPDGZ23jOxdzC80LOktWCMTbo
         GAfr0t0h/D6vsUYUG3MifAwqdcnqYjWy9U4pfT79JBkGIxf+dzlKbTsvckeMt3birbbn
         Zf+eZt7yLSJb2gTpzj3XwP1baDcvltsnTPKGggQGnu8G+oAwCUkzy/0UZIw7kGt3lg1r
         lQCZJqzZWZ79fHoBm+PPDqO4kemcteablbWZONtzvWaiDYAAKyqOe4JllA00+Vse44Ug
         F+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pwy0C0AlAVnIZaPB2N2mM/GuLDYg6nuX90RHsXQRaY=;
        b=sJP+AWd5xhZgWFSXMx/ZjimT/tyo1sKhWfGZ4d6JTEPEjwxyjvSlxaMmjbAvYX+WaP
         smBW+P439nfXLDKjNUwwrj9yI63zNBhS0+alK1KN+5Ij3AWmD+3gi+5PhjfS+VlDbQ3/
         vSpffbnx++rog7hvo8rZJ5uID9B60aRNrydPsoAikwQEE7qlA7ZTvFTwLISs2NFkfbFb
         i5fIMtB86CAGt9m8ReSM632K4hozvAON7UoGNugi8+HWP367TGO1Zq7TRafN2HKfPbyt
         cxQSme6zpNh2sHO6Jy8N9o4cpP7w2YslVo24eJbjS2SreCZD2d7aYTWBmP8zz4Rk7SEL
         34wg==
X-Gm-Message-State: ACgBeo1yMWkouSxaBa1GbX6lNkmo5Hwu1LtZHAwsQ6n0X1Qn0ZzAVXse
        CPDE1dE9FZSQk7LE0EZwaLyPfLyfl/e8EIgyMYA=
X-Google-Smtp-Source: AA6agR7TMMykQr5gzEg+40Ngw26fbps0bOKZZUekwu/AlKyKFk0yzp330XV6by+GskEU/y+OmxaO23NOa3GcC2zLlUk=
X-Received: by 2002:ab0:49a9:0:b0:387:71ed:915c with SMTP id
 e38-20020ab049a9000000b0038771ed915cmr4872828uad.85.1659541860873; Wed, 03
 Aug 2022 08:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220226045047.643695-1-mikezackles@gmail.com>
 <c09a353b-8e52-6d9d-a3c6-743e4e6f444b@mail.uni-paderborn.de> <871qtyj6b6.fsf@kernel.org>
In-Reply-To: <871qtyj6b6.fsf@kernel.org>
From:   Zachary Michaels <mikezackles@gmail.com>
Date:   Wed, 3 Aug 2022 08:50:17 -0700
Message-ID: <CAN+PumF3JfmwVh_7BffLza+v7iD58QsxanCvbCrS1ztSt=XjNw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Make missed beacon timeout configurable
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dennis Baurichter <dennisba@mail.uni-paderborn.de>,
        linux-wireless@vger.kernel.org, Troy Volin <tmvolin@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Why not just increase the default beacon timeout value?

I made it a parameter because I was under the vague impression that a
larger timeout wouldn't be ideal on a well-behaved network, but this
isn't my area of expertise. I just thought this would be the most
conservative change since it would support identical default
operation.

Thanks for taking a look.
