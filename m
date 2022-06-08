Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139425431C1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbiFHNqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbiFHNqo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 09:46:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8F2789A5
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 06:46:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so18347970pjt.4
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jun 2022 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5qhdiuPG2azU5M0qVLOQEvO3YubHAplKI2SWdC6ZWiw=;
        b=BO0u3hqfMTwVervrNwBa1bA96YBVioTs0E5Rj+M04itu2ndsV6XH23Lv6IIhNSVRjC
         Yxsxz1W2PnKw3A45sl3M9VX2BKj4gyI4sK+mnB/M7peTzuid5Ji7CRWoTlPCBWbDajY9
         QYGy3qmjM2gvgDIaKujCvLB3aPMrmYEHSOis5XFmwZSY3DGbaWp2eZvJMvKREnZZMEMA
         oy/4WrVEJwLnLN1A9JCYS0aD+SQti7lY3+xxGcf8ww60qZiH9tZ9AV8J1CVO0TY5bBWB
         RaW6qDleAztft4Q/whcqjmok9jTrHmvKrUDvN86rNKSNfRGXeR8vTvduJOQ7L7aRvNyc
         XU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5qhdiuPG2azU5M0qVLOQEvO3YubHAplKI2SWdC6ZWiw=;
        b=Nc/m0LdieaaVPTeZhHNbnFBaqlP5og6wOMauO17ld+OZMe1bemu+Zl24X3l+o8MGBZ
         adRDzJPXBbOtomseTS2RvP/FLYAtWPOIhVzB/qvSPJ4ZMXhax1RGeWPrPvxxFShkwFII
         W6xEHYeHiubfhGUqIP8cxMs4Gm3h5uauwQY7JnXydBUc/vGyUHTUBXKVUB/ZZe4McUYK
         sFWARRQhLoy2/VLagttchO3XLeFNn9ar+BZwpG/SiXzKVbFVm7TERPWIRFw33aPXGGwI
         1ZKG8WRMI14W1h8HPDq5WQQSJ2tJChuwe8XxU1t+WA44Ne7IZGdQhzNtvBQRStBH3EWD
         3hUw==
X-Gm-Message-State: AOAM532hTlrDUG82dz0NxTkA3AZSCRZranvtVs7OMDLl4EoZ0r68dhaS
        ULUOVOcjgOY9Xo7Q7a3fFiL7xa6qRXX3UBfkYgw=
X-Google-Smtp-Source: ABdhPJwd5duXOpnjJ0yZoOpYdyf8T+bS1k5x5Ta1hBoCZ3pGELN8JCoSACxYqlYeZsSVYoo+Ew23xsCZKbTeuY5p0pU=
X-Received: by 2002:a17:903:2488:b0:163:b2c0:7efe with SMTP id
 p8-20020a170903248800b00163b2c07efemr33550059plw.164.1654695999175; Wed, 08
 Jun 2022 06:46:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4f49:0:0:0:0 with HTTP; Wed, 8 Jun 2022 06:46:38
 -0700 (PDT)
Reply-To: jessthwaiteandjoe@gmail.com
From:   "Jess & Joe Thwaite" <giftbasseyibor@gmail.com>
Date:   Wed, 8 Jun 2022 06:46:38 -0700
Message-ID: <CA+SUxHCX5bfi01w366V=gUeq0F3-sgv3NnQfpHcWewd2gfm3OQ@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello,

I have an urgent matter to discuss with you that needs your immediate
attention and response. Reply now for MORE details

Best wishes
Jess & Joe Thwaite
