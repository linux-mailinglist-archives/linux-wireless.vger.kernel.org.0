Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633637EF898
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 21:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjKQUVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjKQUVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 15:21:49 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7656BD6D
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 12:21:46 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so1246194fac.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=healthydataprovider.com; s=google; t=1700252506; x=1700857306; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfBG3wpv71smcZXEDIfsS0xK1hS13iptlrh35h5mv9M=;
        b=TJOm5RXkpcUG0QSlFocAQ/f1QvK4Rl/zcPLEK2jC6xYIB2TmJAQZ7sjOwESWQLzu/8
         QCAjsX3WT4BFX25eapMKz2Gj6u9F7NZ39ARKZihi3wj5Ql1/ys+PCxl+4Z/sw1yQ/Ez+
         AifnL3CVUE9nCtWx7itHx51W0G6M8EiCpEn47IkcQdNL1s55hr7kWkWBklIu+0OKYxLJ
         Mn2Bt9Riu+iArsBlF6OWFz76WX6cm1tn3eBPpLcCKcskLeCOp3ngqsS9FszNSWLYgy+J
         lt5Kf5FgYiv3vXPmfKjRqcbXEZvGsjcpSFG/3WSNJMpUEYmhplvpOkREVmf+gJER6P+Q
         hcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252506; x=1700857306;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfBG3wpv71smcZXEDIfsS0xK1hS13iptlrh35h5mv9M=;
        b=wfR9v7O7yN+gly+46KPFlHj5TXLWsLu0zsG2xIwSrLWpuQvq1v5JbJKUbXTanL0JVs
         Iax7xNE0Y6Hq12RbctPLwJEdZrGDY8Ntksweqr4NL9xt67foLamMZ8RiNZD9jBfBBQdx
         cejbP30M/IK8Z3Tx2KEe2Von8tCjM+pgtE1xwW5CIrIiHwYT8QsbyufY/tx7adhJQUjj
         cjm/1c8GSd7vTlcws0FLilzdOLvGFgrq6FXMSEbUjAgUBgagb1rnUvkYUSO9HghauQj5
         hppcqDpf+gLaYIqVksk9LCIscHZLNUa+INP9x8wkyCWtFRHTQeRgO1o4LkQCteGjCntR
         R8jg==
X-Gm-Message-State: AOJu0YwHoePbr1X5kq4UZYBsm99rRMxrm4kGq4Ybzmk8mxJrwObFupjF
        zJUKXp0TZFHvr005WmhP3YGYwMh3pW5hUBDcxx8fyw==
X-Google-Smtp-Source: AGHT+IFXuqV2numuPfyTJchq2qqdADa2NdqViU2G1+Bb1yZG1XAodN4sxeVSoNGIvHT/P0ItAjJ7ZJy3QFWL+ZHd7GI=
X-Received: by 2002:a05:6870:41d3:b0:1e9:e0f3:d716 with SMTP id
 z19-20020a05687041d300b001e9e0f3d716mr302446oac.37.1700252505699; Fri, 17 Nov
 2023 12:21:45 -0800 (PST)
MIME-Version: 1.0
From:   Rose Frank <rose@healthydataprovider.com>
Date:   Fri, 17 Nov 2023 14:21:34 -0600
Message-ID: <CAEBxSDzim+_W+4PkQVH4sk7thgHu1atoUek0beWcd6=bhH4qqA@mail.gmail.com>
Subject: RE: AWS re:Invent Registrants Email List 2023
To:     Rose Frank <rose@healthydataprovider.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Would you be interested in acquiring the AWS re:Invent Email List?

Number of Contacts: 42,486
Cost: $1,918

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Rose Frank
Marketing Coordinator
