Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE3714CA4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjE2PDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2PDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 11:03:51 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBC9F
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 08:03:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75affb4d0f9so182397485a.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685372630; x=1687964630;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKqc0+iBhChYWRLd+i2VOE30xoKpG2HHI7h724Oy+cw=;
        b=aa5wQIkAzTkxtx/vKStDOl2QO4ycmzCCwNccbMp8QwD2tko0wU40xI8SZUVDrv0A69
         jrUKMSxC1auQWD8oHBbpozKA67flpBdMVy+0intchZ/euBOmc+P85jZ45e1B9NEVoOjE
         3ZP7KNJ142/7CwCr++GsO+AvXzNoIxLvQlHYfgpmtbdwF7J2sFoEbpvxInRGlupcS3ef
         ydxE8aP+jNHihbgsci26+kh3leR5hyIi+NrK48ZIzXoPUKTgD6z6eYKJ/8W98vnhLNVH
         1Q9lmBffBvdgVA/ILZ3zin3re6sK4WrzIgGgvzPwrjQeoLKOdGh1y5P7O4b5tuRpaLXA
         0FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685372630; x=1687964630;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKqc0+iBhChYWRLd+i2VOE30xoKpG2HHI7h724Oy+cw=;
        b=etAYC6SbflPcS+dN1mcJdUxmFL/AD5DSKEMpjRDZK5LHqJfqxAyoCxbkV67YZvVgQU
         CHPyXU0g/b+pcsYBXzG8OZOMKSXUHC2CYkLk3vahAgc0oz30GVxgaCHVBIo1z4Fj8Cst
         yEsmPMHbln0GJ8U5zY390o7YM8aKsc4Q7aAWzNViRJTReLt9WIviI/i0XPDroFl5jZ0d
         ZghHPzrZYU6bH+9wADDjV+lqYIo9UXacU0ZN7E8bsB86zcjPaFBycvd0mZRM8sHd5X0J
         +AJndAJ4SF0r5DW8zNH63/NRqzXBxLuqTsOgm76dMopWJh2LZjumaad7/0TJiddzNxIY
         ZwJw==
X-Gm-Message-State: AC+VfDy7OZHs07V2lbNzqtGh3hqW6FIOjC8YpnifxXimCsQ4R3/ys1kV
        gZABMae7JRzs7msSgKw66BFBACpjEkai9Z0CbX4=
X-Google-Smtp-Source: ACHHUZ6OwG7fY2aBYqMe1tEPFDr5NZnCql3Ub0YSSaeoOy5LD7IvZf3DrpPZkeJOWIhrZnMJ7asqICBrCaoGDh7Bh1o=
X-Received: by 2002:a05:620a:8f02:b0:75b:23a0:e7c2 with SMTP id
 rh2-20020a05620a8f0200b0075b23a0e7c2mr6418204qkn.35.1685372630056; Mon, 29
 May 2023 08:03:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b8a8:0:b0:3da:172b:b340 with HTTP; Mon, 29 May 2023
 08:03:49 -0700 (PDT)
Reply-To: mansonjohnson@live.com
From:   Manson Johnson <koffiadams2012@gmail.com>
Date:   Mon, 29 May 2023 15:03:49 +0000
Message-ID: <CANXrao048vUfdx07GzmEvEQsMqJb+8f8-jvqFwjb+5WV6HK49Q@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
You didn't respond to my message ?
