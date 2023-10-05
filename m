Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433587BAF1D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 01:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJEXHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJEXFB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 19:05:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1469D54
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 16:00:43 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d84d883c1b6so2445958276.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Oct 2023 16:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696546843; x=1697151643; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELqXQhhE2TVks6UnTerwP6cHjTosmhlhsfEbFjORISo=;
        b=Xh4gA5N7AtkaGslUYdImZrASZXs+4VomP/KJwTHNRHsm/XdywVGFwxhSX8d1IGIA52
         BeGddfZDIMfvq56OddvdLGNEmOOB9269HGRjytHKVbi3JPlQ+CT0zoccW3hdMNEvCRdU
         bWAATSrJSLHLvFnbkL3uyJrygpeI6JHzHG1eaeVClEWYcg7y+yuXVEeuUIcSAEf1yzdx
         soIuUzAuv3+1AmEK66vG/slj48CGzSDuMVg3ZUWZt4gLY+ZphR3l4Rd3Be76TPJoXk+m
         I605Q4HVTjjcteqRooxwxWm9fkpNDKR/pjDVVv8APB5YC/2DBweNjKcaMjRBzRZC7tNv
         nfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696546843; x=1697151643;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELqXQhhE2TVks6UnTerwP6cHjTosmhlhsfEbFjORISo=;
        b=PmNPsp1NykwlbBZbw/yv3H1xaRNBrVwc/eUQSa70Qy+u8b8Jo5VFVOlv+Wy1CBa7Ij
         UXxVUsXpGtF4o3VPsxoe6E0GXQt//8hVFxtzpT99tafzyapG/sLyKP57YlrwPlkkBxY0
         hptXSos72oPdDuwiXlx+9xaOYffYuUJRcM7f7Pa7RxTMwRYKv+8WdgZ8WtcrAgsz94/3
         sgT3cV/rNtpeSIDuIOtlX3lYA+FhiKDwJNkc80xUGcGtAmbpmvyDYQrdU4rWnMmXjrm+
         Jpq5lWhucyDtNOnyxmBF4PbD+UrVoEGf7KMChGU1TYbYAjFxA9J9Y0ufzxoQeNX8ZJVK
         07jA==
X-Gm-Message-State: AOJu0Yw7yvMFQL16JzH/VsV9LTBG0fEOptwrHfYynQqlN7aqSd76x+nC
        5wMs8bv+lkunNOCXmuVjOK7mfjgumGB2lTP4yk8=
X-Google-Smtp-Source: AGHT+IH80x+ZvLp98Ba3B+bxQyoknROQNbj1LNsvq/hR7ZQWqrcZoYLva1r1zNE3/EaAuLEmUHF25hM68414XpUJCcI=
X-Received: by 2002:a25:25ce:0:b0:d74:6cb3:bb77 with SMTP id
 l197-20020a2525ce000000b00d746cb3bb77mr2966008ybl.28.1696546842846; Thu, 05
 Oct 2023 16:00:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:33cd:b0:348:529a:ff4f with HTTP; Thu, 5 Oct 2023
 16:00:42 -0700 (PDT)
Reply-To: tchalimbenson@gmail.com
From:   Benson Tchalim <adamqeeru@gmail.com>
Date:   Thu, 5 Oct 2023 23:00:42 +0000
Message-ID: <CAAeRsS=yASNBgfxbn--AjZTVxWxCWFaEQuF7GXecULLakSc5Cw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
I sent you an email but since then no response from you.
