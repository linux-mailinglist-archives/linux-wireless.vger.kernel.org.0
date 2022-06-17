Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02EF54F677
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 13:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382316AbiFQLLh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382307AbiFQLLf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 07:11:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408C06CA88
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 04:11:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l18so4350783lje.13
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=G/dSTlUqlH2258VvjhhJrMT0OtB618hVwgGDjs7n9i870J11YZQC2fCbflI0c5Dhdt
         MUstXjNrYuDJp786lJze9KH9x/Y0MytV03GmEkcsrXGWTixlIxqKKsHLs8fM3m7lT1SU
         89YBCRlP2MCkxqpMu/sb2Dbde1NCU2xJEZPznAvn3WR7ZEhpi0LXQ7rnU46F7lo1kEnI
         cctspph/UXeMMqAbeEKJN3EuO1EfBCkhsI+ENGXXnmSS5PVmi6r+6BSb6mQnCD7kuQxk
         nxxh5peOLJDNkIhYXY8VoAH4wDrMBcP9dL/D0SFFc2XGOFz/1Vd8kwTdKc2E+5ZF612y
         iigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=563eWjXkrwD++prg5sVSdKDifxmYyJ8rjimb5RhNu/k5g+OsP4HNTRTiHIxzBlLGKo
         YCX/0VKBp0Z8iHAgji4VCcTN8ON/KNiyUEQ/5raUhnKMqW3Ftsu2slMyUdTajEswz/ol
         9vPp0BJCfi20YsK/8M83iZBLQt5o8Nq+ZlFkcspCmlhe5s/lenRtWhFrwmYB/ZDZt5Ps
         sZxVTeRedsGAUig8LML8eDFIF84PjLYhYfcgCUmK1AwFq5f7l60BUatf0jOD0hUNI2Np
         UwHfA/RoMbaPeio+CsryugocrOZi7dA4GSelJI3llqm/IYC77Cb8kkd02cVm5d26u4aq
         gQ5Q==
X-Gm-Message-State: AJIora/A7N52zjOoN1MUi9T3IF6PA1ZF5gGbFhQHIVBYImciGzsQbSRK
        K7BMa5oV7HbeV5dheyV+fdWlLEr8wq/JHzL1JwE=
X-Google-Smtp-Source: AGRyM1tYOIEK9rvirUG4+gF7NsJ6+6XoK4ub+ELWclsgzYPMHN5SGnpC2e4sFZaOT+SRNV3yoC5G5coTyj9avBBksv8=
X-Received: by 2002:a05:651c:1549:b0:257:42aa:2421 with SMTP id
 y9-20020a05651c154900b0025742aa2421mr4762965ljp.151.1655464292704; Fri, 17
 Jun 2022 04:11:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:11:32
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:11:32 -0700
Message-ID: <CACKGxpyoMOts=5RFmMf+deoWONaYxGf5U2n=xN33P+mpZvTx0g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hi   are you available to  speak now
Thanks
