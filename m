Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E5635829C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhDHMBI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhDHMBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:01:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847FEC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:00:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso2783463wmq.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Apr 2021 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:mime-version:to:subject;
        bh=2A1nGB7ifulsHgzWXWVNyyiNVsCiyJlVkUqNe16y4Yc=;
        b=r1Ac/mJqVkZjtO02697jUHkyi/k6+QrGmBlm7DjSYLBMe6vAv5a9OKRiLcT85vBMig
         JUQReCyR7HryjITg17wboKUxFb7CW5AU6JWlmkA5i2CRttUeQ156/Z97bNWnFeBveLTV
         1a3XVdlXltZIgQ7enhbACVsF1+lH1NVFgsqr94fFdHgByW1RPCMhp8UvLGNzvksoSPJ5
         F6ne7YxL4LVpM9+AtCi3b35UnnNMx00x5o16QhIzjxuPouCQ/Gttpe5HrucAtgGApvbt
         o9TmVK07TqFUAd8dKWypkxY2S9DJssTF6SlOBQ3NJEYNHv/L7LfusTz+YA3ThdCTS5fr
         jdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:mime-version:to:subject;
        bh=2A1nGB7ifulsHgzWXWVNyyiNVsCiyJlVkUqNe16y4Yc=;
        b=P7L3oIaOv42Ja+dEtkHD19CK9iqCpUplWgYXq/H27pwR075xn70orM3/8+m15bWAW0
         FB8Rbbs3ZCg1M6/CsOibvHEWrrccYF4vFOFoI01WbIR3YlJp4SkEs71Whd0V+i7Gn8AN
         xqnYNulP858xGbcbs4zQSByJ2RkJGpicx+BGUMmT8ai9Ov0hsF0/HaoMnW33UuTjOnT0
         +qsUks1DzeFZxz/mQU2lTpnxD5TPx9ib6qLPTt4xySL6K2xdI3b6YlXIa7zdQwwKb0+R
         Q5LowToQc97vf/n2yOG1gqRichCn58LjWeKQiOpFPsv31lyojJFAsQrSBmKN3VOtYyvv
         dJjQ==
X-Gm-Message-State: AOAM530nvt9wCrKOS6tT1Qc0JFKxFVy2Rup1SXx8Xs0mRfomjTQusYrk
        ZF85Bw941PGtJuGtq2j9iUtsdVyCyux1Gw==
X-Google-Smtp-Source: ABdhPJwSY2B0L+Fz2izZYhY1ywmDj8mEolwJUeiALGXWOc+RcM2cwL0mVzie3pLlCaORzyFIDP/dlA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr6457374wma.20.1617883255047;
        Thu, 08 Apr 2021 05:00:55 -0700 (PDT)
Received: from webmail.webmail.com ([196.170.53.230])
        by smtp.gmail.com with ESMTPSA id y31sm3143525wmp.46.2021.04.08.05.00.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:00:54 -0700 (PDT)
Message-ID: <606ef076.1c69fb81.e0bfb.6662@mx.google.com>
Date:   Thu, 08 Apr 2021 05:00:54 -0700 (PDT)
From:   "=?utf-8?b?TWF0dGhldyBBREU=?=" <matadtgtg10021@gmail.com>
X-Google-Original-From: =?utf-8?b?TWF0dGhldyBBREU=?= <matthewadetg@gmail.com>
Content-Type: multipart/mixed; boundary="===============4473127767020981914=="
MIME-Version: 1.0
To:     linux-wireless@vger.kernel.org
X-Priority: 
X-MSMail-Priority: 
Subject: =?utf-8?b?VEUuLSBIRUxMTyBJIEhBVkUgQSBGSU5BTkNJQUwgUFJPUE9TQUwgRk9SIFlPVQ==?=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--===============4473127767020981914==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Cg==

--===============4473127767020981914==--
