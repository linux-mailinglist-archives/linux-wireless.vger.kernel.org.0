Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC12983AA
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Oct 2020 22:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418862AbgJYVXQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Oct 2020 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418845AbgJYVXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Oct 2020 17:23:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD3C061755
        for <linux-wireless@vger.kernel.org>; Sun, 25 Oct 2020 14:23:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lt2so2004397pjb.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Oct 2020 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOM8/Sh8H0UFshDCLI54VqF83MZ6U64KCLxXmfo7yFM=;
        b=N1ow8ZS95GmwGgvacVqdtXUlKIqJEj1NprUG6EH8fTa7NQwLRzTCgnQNdVRuXHa/fN
         b8N3oCWD4bXzZ0nqm8mqBBwNwZIWaIKjEv9Y4mXfiJqYrxqNjbYr5qUXp2PR0TLC0ISW
         bWjjImjb7Fiv4QrE1065Rv6FgVg+kSACpavePzz5lhYNvkrTftZYjoPaliia3eUQB0gJ
         Ieup3PxwkGotWd2PoGafSWkydomHIjCHW2Te5S+IwLMVQOJk0fMf1y2JFXFShR27EDbp
         yj+mt/JxjNZogHgbaFBaxbiC2LFIAKdhTmF+Dxatsuu3QOrDgh26fbKD/iBDojZMqo1M
         DZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOM8/Sh8H0UFshDCLI54VqF83MZ6U64KCLxXmfo7yFM=;
        b=XwYQIEWGevMYUPB0RRZQxXike163fWixSv8qmT5PF2w+QC8W75voFojn+ncNb5LmXQ
         IXcnDgpnj4RJzK4g4j83R/DWYTD5b61VntiVJ13QwFwq04qjP61siR8sATifYYQF4lZB
         /KKQXmIZ9FP4Qy1jawd+XUEjzVwz9U1c0opHrHj9B1dmzv6E/hQKzKCnFcmxdN26BYpt
         ZhGotRhh1vyu6HnstrPmtmmdyEi9q7Falhj2vsqFZ3/XvJhow4XNwaMUYB5ABsknLL94
         4r510uwf1p7vjDCXyTBCj82K0kbNQ4sHX45y05k/+vtYx/0BWZqnu3gbon2XQoDI3uPO
         Fkmg==
X-Gm-Message-State: AOAM532zS82KzAqpxuh5phc9/eI6tzC3V/3sdciWPdR4ceVUbU1pIa6i
        TUrBh8ooCTpRbEmmtE0P7wAo7g==
X-Google-Smtp-Source: ABdhPJxvwiEttnt7EtFWp+e9gn/IOSMGXvHavpAOMH4OtdiOeitekKREmXic9hCY+j840tRsYnmxFA==
X-Received: by 2002:a17:90b:3851:: with SMTP id nl17mr2899666pjb.103.1603660992737;
        Sun, 25 Oct 2020 14:23:12 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m2sm4656602pfh.44.2020.10.25.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:23:12 -0700 (PDT)
Date:   Sun, 25 Oct 2020 14:23:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH 2/3] libnetlink: add nl_print_policy() helper
Message-ID: <20201025142304.3f7deea6@hermes.local>
In-Reply-To: <20200824175108.53101-2-johannes@sipsolutions.net>
References: <20200824175108.53101-1-johannes@sipsolutions.net>
        <20200824175108.53101-2-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 24 Aug 2020 19:51:07 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> This prints out the data from the given nested attribute
> to the given FILE pointer, interpreting the firmware that
> the kernel has for showing netlink policies.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

This patch causes warnings from iproute2 build on Debian stable.
Please fix.

    CC       libnetlink.o
libnetlink.c:33: warning: "__aligned" redefined
 #define __aligned(x)  __attribute__((aligned(x)))
 
In file included from /usr/include/bsd/string.h:39,
                 from ../include/utils.h:13,
                 from libnetlink.c:31:
/usr/include/bsd/sys/cdefs.h:128: note: this is the location of the previous definition
 #  define __aligned(x) __attribute__((__aligned__(x)))
 
