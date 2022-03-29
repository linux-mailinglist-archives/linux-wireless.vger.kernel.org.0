Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B64EB2EA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 19:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiC2RuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbiC2RuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 13:50:05 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F1B5E
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 10:48:21 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id y7so6741535uar.9
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=62zWXSM0STrxC86GRSLMMI5cUpneQ7RYGm4/awmvFTk=;
        b=E2bC+rj9IM73R/TAVkXQAnh0etHRPL3J+dpmlkUrzL2KC00xLbgpC72GBrt8lgOXAJ
         FJJkf6tYUwc4M4645HnivGAWcdXIkh4r4Il6dDwLJdZ1dK4jllVAJORCwWgar0Dza47J
         4sExdKFVlv8ZTXxNo79glittg4nSKQ8NTNMFYhGnCl9E690lefLYJqo6AnszlkxRsnzU
         jMwJhSomz3keJUJDlga5VIPXmyCeXmACoTaoGnU7oWnEPApG1W4Mg/+ezyS85vALCH5g
         CgEj9EqQdOrKOvSTBnCF/8sFIrZaMzgQ0S+RQPWaz285UCaUmzpe3KLc+ATXsuNMBS3T
         koEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=62zWXSM0STrxC86GRSLMMI5cUpneQ7RYGm4/awmvFTk=;
        b=INLb021Rv5lST0M8BQ+EovpoY1gJnCD25t47n83bbDvFLndgo/dMNqjeNiuUOgOz14
         scKQc59X86znyC5WM3hWdTTXD/q/rv4yBJqlMgEP2HdQrTMSyDSeiYL3t9qeNWGY8CY0
         FNGYAI7igLkfSh/BBNOHoaTVjCp3XEfkxiLisy2KZanGU+B80U2ZvCnb7a/zK+1EGPax
         w+cbMuWZFw+7QUibRoNqCV/FzHmfsC6gt64sFwcP+x25MiEpKjDLn2mTe1H1G6Z5GGF+
         w+xEQMMt88APpRPghAWomb3fwZFxDayaLBmrFfylXQCwY8pelQyPwEFgodVsRCxo2OGl
         OM3w==
X-Gm-Message-State: AOAM531Z3WEWxeryZvdwNbe6zVRFD/a1GfaD3CeCl6CmXmx5sGMxBtnS
        bl6dmccIj9hH6JhtEIuWIaCV9TCq6hnPOCocY6Y4WitQahc4
X-Google-Smtp-Source: ABdhPJzsV8Ekl3yK3IoYu9ZnmGyPEviheAaRw5YieM01Jm3Ifvy0BowFO4/E0FGxZ/qIb4mo9q4xhfSVqvMat3sYDq0=
X-Received: by 2002:ab0:69d0:0:b0:345:72b0:ee12 with SMTP id
 u16-20020ab069d0000000b0034572b0ee12mr18192483uaq.78.1648576100347; Tue, 29
 Mar 2022 10:48:20 -0700 (PDT)
MIME-Version: 1.0
From:   Cale Collins <ccollins@gateworks.com>
Date:   Tue, 29 Mar 2022 10:47:44 -0700
Message-ID: <CAG2Q2vXsNmFdeP0RTeybcj4=ByT19FPm40DdeJk44--V99ex7w@mail.gmail.com>
Subject: Patch for "ath: add support for special 0x0 regulatory domain" does
 not enable 5ghz bands on later kernels
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Linux-Wireless,

Recently I found that 5ghz bands were not available for some radios
when using kernels later than 5.4.  I bisected the kernel ultimately
leading me to this post:

https://www.mail-archive.com/ath10k@lists.infradead.org/msg12313.html

I found that recently a patch was added:

https://patchwork.kernel.org/project/linux-wireless/patch/20200527165718.129307-1-briannorris@chromium.org/

I tested this patch, it worked fantastically except when using newer
kernels.  My testing left off at v5.15 (mainline) and 5.15.15, with
the patch applied the regulatory domain setting did not allow for 5ghz
bands.  Is that the intended behavior?

I used WLE900VX radio for this testing.

Apologies for not replying in the original thread, I'm new to this
list and wasn't sure how to go about that.

Mahalo,

Cale Collins
