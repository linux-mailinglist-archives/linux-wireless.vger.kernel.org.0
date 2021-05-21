Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2821338BCB1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 05:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhEUDBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 23:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhEUDBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 23:01:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE63C061574
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 20:00:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v14so10466704pgi.6
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BxFTMzI9Q+sJB2Gi3erL1JWnsyLn0t1aWKqAvTeYXE=;
        b=U0u/gAfwtMUcWxX8UI9fIlUaU8NGYgDOMpaWeJ0YP5A8yjHfcWRkLYhPV84RwDN9Lr
         CsMTBDmVv4+Kce0+oReufR3d+nhDfHQCNtiWjQRxGDJ2gD93kWAlEy8VtXWTyha/8ZuQ
         CBoNnhUEoxeZjqB7+WXx7LuxQPQmmSGKElGFnfH3WcAqnhOlebplqZVmWJtfFnvHUENI
         sg1dMkoZrEMOeRAVl3ba0AgLkV8HEGTPyhmEDaPZ46WkJTza6HQOABzOyRE1fsPR9ZzF
         jPcbmJR67KP8tCgLjFP6ISzBindCxWC/feXHVIelrtyTnN2rhdcf6ixwDyqNmQk6HiWi
         Np3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BxFTMzI9Q+sJB2Gi3erL1JWnsyLn0t1aWKqAvTeYXE=;
        b=bWLyhZjUgDj+DMyOrQL6mjK6XE/77fBbwjYgRCZwK4ARPt5Ow276L1kQm9TclXEUni
         G3zmnH89ELY9uhYKIDU37Ykuggqq58Mct/OomLlAJesthVhIgMg31hKDQXvYPrTuzZZf
         rj1L8CfUPRk+iYEXtqZYzX3mIzpneVWzA9SRHeXywUbqhiBLZwLJ38WGyyjXP2t5PEpS
         6dYk0b6t2nDmOFRGtZN/6tBNT8EZj6QQ4bSuPu8z7JMcbuspR85SafuQzwWlZIM0HFtw
         BGN6Qz59tom/4SyhY2SSG9r3FbzyGl4vqNNcu/++sFy2gjBrkJHuxs86a5jxveQddI7G
         hBkQ==
X-Gm-Message-State: AOAM5330bIGLPr5gZP1Uc5hxk09T0JNXs5SITDFgSwI8U5D3Ao5CwGyf
        0c7bIBp8zn192gHw3dLMXt8=
X-Google-Smtp-Source: ABdhPJxpszlZVycidE0/xcTWgGA0U2iA5AMJz2QRNgijmKZg567NesxzhM5h3KMUC+9KHsRAo/zfVQ==
X-Received: by 2002:a63:e058:: with SMTP id n24mr7493353pgj.91.1621566015139;
        Thu, 20 May 2021 20:00:15 -0700 (PDT)
Received: from yguoaz-VirtualBox.hz.ali.com ([106.11.30.42])
        by smtp.googlemail.com with ESMTPSA id s23sm7642701pjg.15.2021.05.20.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 20:00:14 -0700 (PDT)
From:   Yiyuan GUO <yguoaz@gmail.com>
X-Google-Original-From: Yiyuan GUO <yguoaz@cse.ust.hk>
To:     yguoaz@gmail.com
Cc:     amitkarwar@gmail.com, briannorris@chromium.org,
        ganapathi017@gmail.com, huxinming820@gmail.com,
        linux-wireless@vger.kernel.org, sharvari.harisangam@nxp.com,
        yguoaz@cse.ust.hk
Subject: Re: [PATCH] mwifiex: protect against divide by zero in mwifiex_set_ibss_params
Date:   Fri, 21 May 2021 11:00:07 +0800
Message-Id: <20210521030007.8609-1-yguoaz@cse.ust.hk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521024834.8354-1-yguoaz@cse.ust.hk>
References: <20210521024834.8354-1-yguoaz@cse.ust.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bug is also reported in the bug tracker:
https://bugzilla.kernel.org/show_bug.cgi?id=212993
