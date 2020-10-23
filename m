Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73F2978B8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Oct 2020 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755457AbgJWVOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Oct 2020 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbgJWVOi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Oct 2020 17:14:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95615C0613CE
        for <linux-wireless@vger.kernel.org>; Fri, 23 Oct 2020 14:14:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 126so2023724pfu.4
        for <linux-wireless@vger.kernel.org>; Fri, 23 Oct 2020 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P71T+Kpg5MOgFYOFRnTK618HMq/o9mo5YBqH2dbrEgk=;
        b=BoCnvYihRsvf35k33Ps/dVRA9Y3Dl0jPf3SGgthL3mIWSUqEYByU0UApC7WFMiJWs6
         DzLcvBB5f04SZ6tUIXJBvNGp/oLDhsKR/2/DdDY9n2KWxclMjN+Qd/Be6c+2lHsjKHe1
         lSU9/kxdwgYdMrW2+dTjUTiRTGdqwVw9KOlUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P71T+Kpg5MOgFYOFRnTK618HMq/o9mo5YBqH2dbrEgk=;
        b=r9CfKtpmdD9nOEpqKm6bs4aOfGKfTHK3Y3UVc7QfsmDLE5S1vOj5hDq7DVW3sZsROb
         cKlvV98QoqCF+yKTGoS2UefaMnmOhv3FdSH/rRxwxwu4JVakv+C8NsNO3WVzC9R9aEIa
         5rnJAcnbwP4zKnYgaJeBjYRWxCJScdn0vbt9gXSv8ipt1RB0z2d/+ZRx7IWumvbtrpnh
         blL4E3TEgU3RsLxm4d/kkNxQ3fdzvLd5zqdNeHQ4Nyzs7eur5t2pX+tfziwVhQjA/aHE
         F7Mxkq2OWWxMxXl4pbwe3K+iGMgXOJS2yJJhAkbnI2UUSYL283TJN7DkeHsnsvlFQ2e2
         +rYQ==
X-Gm-Message-State: AOAM533gem5N5s0sBPRrEzFwVb+8qzPUyQ7BFBEaZ6L+kPG7HYT7Aosp
        gDA12zYyiZYzaoAdAve4JxLLhw==
X-Google-Smtp-Source: ABdhPJxrOAkGB9aD7alcvtCbkZ2rgme5I/bNKCZ/OLr4HSQXnwm7bkykoEAaG8Pn02QRaHgPU+9j1A==
X-Received: by 2002:aa7:8681:0:b029:153:7c2e:6ff5 with SMTP id d1-20020aa786810000b02901537c2e6ff5mr863359pfo.57.1603487676178;
        Fri, 23 Oct 2020 14:14:36 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with ESMTPSA id bg11sm3578914pjb.49.2020.10.23.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 14:14:35 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     dianders@chromium.org
Cc:     ath10k@lists.infradead.org, briannorris@chromium.org,
        kuabhs@chromium.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pillair@codeaurora.org
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
Date:   Fri, 23 Oct 2020 21:13:50 +0000
Message-Id: <20201023211350.740528-1-kuabhs@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com>
References: <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Additionally tested on ath10k based non-QMI platform

Tested-on: QCA6174 HW3.2 WLAN.RM.4.4.1-00157-QCARMSWPZ-1
Tested-by: Abhishek Kumar <kuabhs@chromium.org>

-Abhishek
