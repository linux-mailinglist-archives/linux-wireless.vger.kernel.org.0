Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57E036B904
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhDZSfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbhDZSfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 14:35:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF17C061574
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 11:34:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14so22654028pjl.5
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fChEAFSpvZNveTdQdLa3oAq8ZMG1cJwjWniaZqHZHv0=;
        b=BabLBNRveu4M0B80gM0DB6gUuSe0nKn3AcjXKKd2wbGcE7FSLPGi7eufVFoBisLN7D
         Wl/KKcP89/FxdQNte5t/+WBiR7pJS8h2rOn+Gi7eKJmEM5MEcMyHgddwGSkVL9iJNNlj
         A19A5T/aBo216CQ3BYsOeq63gTGHRZo9ykqGtOeVh1gbTLvYJzsc2v8xw2iA+DvYD/VV
         HdLkM9kyTkcweKI8Cmb4o7IRclEOdDgZxlQlzwiDERWr3U0pngqcCNbxo1k1lspV8pg2
         37wRshs7tAzXLZ4vUZr/3eBjQKmlvjxF6T7q60IlICe7o6HyZ46UXwmMmfGm0BJvByPL
         H9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fChEAFSpvZNveTdQdLa3oAq8ZMG1cJwjWniaZqHZHv0=;
        b=k015F3tCTKQ9Lx8cpln1fb5WHZJL+z+ZZfE4NNQB28001dyT0MWRxrghT5he6fGZn1
         9t9G8yKwLfgCS8v5ehfyRLRVomu6wqIkJYAXMO8qBSAIyUWmRXMxFiPFx7dDCSXNe82O
         4U3tnP27XpBf4aRcjjn/AshvKL7bMHA7n8US+Ent9Wi28vQNi5SPaGF4fn8cxtO5qsIB
         KCY14Y5jx2xj9ZSUr3+2f8w13bJC/m2H9aOx65HMXxnBAy5qvTZUJmB2o1HiYIPpPOoR
         b4UVF0z8wHqvXpCZranY+R6FhvzBSb4/gsZ2wUI5Y0qkQDOrqa6kMIieEnJaRZjWW+Yp
         EBKQ==
X-Gm-Message-State: AOAM5317FHMjU46GSobMoym9KNMXTvtmdvp3qvlFUS3LOMXhP3h59LGy
        n5ze3k6MdHIb+yFTnX5Pquo=
X-Google-Smtp-Source: ABdhPJwyib5pYN+zn3u8d1ru0IUITH70Ir+EC/jUKrt1w9uoWOWRnSzB5E8gCkMnJ+/odqwtT15L8w==
X-Received: by 2002:a17:902:b582:b029:ed:562a:6f52 with SMTP id a2-20020a170902b582b02900ed562a6f52mr14197pls.73.1619462068746;
        Mon, 26 Apr 2021 11:34:28 -0700 (PDT)
Received: from localhost.localdomain ([198.148.102.224])
        by smtp.gmail.com with ESMTPSA id jx20sm115038pjb.41.2021.04.26.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:34:28 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     hdegoede@redhat.com
Cc:     gregkh@linuxfoundation.org, johannes.berg@intel.com,
        linux-wireless@vger.kernel.org, ross.schm.dev@gmail.com
Subject: Re: [PATCH 1/1] staging: rtl8723bs: Move wiphy setup to after reading the regulatory settings from the chip
Date:   Tue, 27 Apr 2021 02:34:06 +0800
Message-Id: <20210426183406.13055-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210201152956.370186-2-hdegoede@redhat.com>
References: <20210201152956.370186-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, "cfg80211: Save the regulatory domain when setting custom
regulatory" "cfg80211: Save the regulatory domain with a lock" cause
rtl8723bs not work problem.
I see upstream rtl8723bs driver "staging: rtl8723bs: Move wiphy setup
to after reading the regulatory" "staging: rtl8723bs: fix wireless
regulatory API misuse" fix problem.

I use rtl8723bs v5.2.17.1_26955.20180307_COEX20180201-6f52 driver, no
the "rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));"

https://github.com/youling257/rockchip_wlan/blob/v5.2.17.1/rtl8723bs/os_dep/linux/ioctl_cfg80211.h#L234
int rtw_wdev_alloc(_adapter *padapter, struct wiphy *wiphy);

https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h#L91
int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);

https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/os_dep/sdio_intf.c#L333
https://github.com/youling257/rockchip_wlan/blob/v5.2.17.1/rtl8723bs/os_dep/linux/sdio_intf.c#L645

I want to fix rtl8723bs v5.2.17 not work problem, can you help me?
