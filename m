Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50B0361338
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhDOT6f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhDOT6e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 15:58:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF8C061756
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 12:58:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso13316758pjh.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sXhSKr29wpd6a6qt/mh96odcNcbPE2aK/Q6BgI+4t6E=;
        b=XK3D3dRhy2wdHg/aLihejMVK1Jpk1OaBdYzJasCCqg0zFBlARjGV0nVO9m5LE5hDBx
         15tN0CoyPl0n4NfcgPD9Vm5bQmJIpMtYXqYr26Rcl0+RpjAK/dvrP4vV2aNKJtW99SaE
         jauyFE7jIvcYQhahEsj4A+rQJTL2nVQ8nq0NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXhSKr29wpd6a6qt/mh96odcNcbPE2aK/Q6BgI+4t6E=;
        b=ctvGY8vPzk3Z8k08dBIgAC1F+Yj3AoFaiPHwCliH+B9B8rEY8SlEjMawUcHRZSMWM1
         Bnn4VqvLSD3SBxs+Tgi+1lF2s1VAly12dWU41LaTSCkaZLEU9bYXomlcFXFiWQMpd5pd
         UBnPLbUVHYj6p6luzvNGbiRrS8sv2IfzJnGaP/UFOS1WGmNUKIf2Lai67bI3Z/16aDRa
         byDedSB7P0gsn87C0b7QM1fqw3ggvMadcdG3zwMbZKjqE6PFIHdqpE+RdyuhR1l3uEFc
         TAvbVCPyjDQuvVqLCXcUft5z00/fL03jbaZPuqJwFL6RBATxYwmj+mm54vE5KnZ9vl+m
         d+yw==
X-Gm-Message-State: AOAM533ggspyJRRWYzMRkzicaLz2HM3U4gfaJz4IPcE+ZRWl08MPozq2
        2IQXUgO0eDBqkcC4uRsavIIHDlaM6t2m/Q==
X-Google-Smtp-Source: ABdhPJwcUdlJJtXYWk8IbTEMfWRkjKZmaPrvDax7npIZsC0vXr9zpHNelJm+tfVS3fQY6P4lxEBpJQ==
X-Received: by 2002:a17:902:9b97:b029:eb:7a1b:5b88 with SMTP id y23-20020a1709029b97b02900eb7a1b5b88mr4516835plp.77.1618516690371;
        Thu, 15 Apr 2021 12:58:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm2936028pfi.0.2021.04.15.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:58:09 -0700 (PDT)
Date:   Thu, 15 Apr 2021 12:58:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] wl3501_cs: Fix out-of-bounds warnings in
 wl3501_mgmt_join
Message-ID: <202104151257.DC4DA20@keescook>
References: <cover.1618442265.git.gustavoars@kernel.org>
 <1fbaf516da763b50edac47d792a9145aa4482e29.1618442265.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fbaf516da763b50edac47d792a9145aa4482e29.1618442265.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 14, 2021 at 06:45:15PM -0500, Gustavo A. R. Silva wrote:
> Fix the following out-of-bounds warnings by adding a new structure
> wl3501_req instead of duplicating the same members in structure
> wl3501_join_req and wl3501_scan_confirm:
> 
> arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [39, 108] from the object at 'sig' is out of the bounds of referenced subobject 'beacon_period' with type 'short unsigned int' at offset 36 [-Warray-bounds]
> arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [25, 95] from the object at 'sig' is out of the bounds of referenced subobject 'beacon_period' with type 'short unsigned int' at offset 22 [-Warray-bounds]
> 
> Refactor the code, accordingly:
> 
> $ pahole -C wl3501_req drivers/net/wireless/wl3501_cs.o
> struct wl3501_req {
>         u16                        beacon_period;        /*     0     2 */
>         u16                        dtim_period;          /*     2     2 */
>         u16                        cap_info;             /*     4     2 */
>         u8                         bss_type;             /*     6     1 */
>         u8                         bssid[6];             /*     7     6 */
>         struct iw_mgmt_essid_pset  ssid;                 /*    13    34 */
>         struct iw_mgmt_ds_pset     ds_pset;              /*    47     3 */
>         struct iw_mgmt_cf_pset     cf_pset;              /*    50     8 */
>         struct iw_mgmt_ibss_pset   ibss_pset;            /*    58     4 */
>         struct iw_mgmt_data_rset   bss_basic_rset;       /*    62    10 */
> 
>         /* size: 72, cachelines: 2, members: 10 */
>         /* last cacheline: 8 bytes */
> };
> 
> $ pahole -C wl3501_join_req drivers/net/wireless/wl3501_cs.o
> struct wl3501_join_req {
>         u16                        next_blk;             /*     0     2 */
>         u8                         sig_id;               /*     2     1 */
>         u8                         reserved;             /*     3     1 */
>         struct iw_mgmt_data_rset   operational_rset;     /*     4    10 */
>         u16                        reserved2;            /*    14     2 */
>         u16                        timeout;              /*    16     2 */
>         u16                        probe_delay;          /*    18     2 */
>         u8                         timestamp[8];         /*    20     8 */
>         u8                         local_time[8];        /*    28     8 */
>         struct wl3501_req          req;                  /*    36    72 */
> 
>         /* size: 108, cachelines: 2, members: 10 */
>         /* last cacheline: 44 bytes */
> };
> 
> $ pahole -C wl3501_scan_confirm drivers/net/wireless/wl3501_cs.o
> struct wl3501_scan_confirm {
>         u16                        next_blk;             /*     0     2 */
>         u8                         sig_id;               /*     2     1 */
>         u8                         reserved;             /*     3     1 */
>         u16                        status;               /*     4     2 */
>         char                       timestamp[8];         /*     6     8 */
>         char                       localtime[8];         /*    14     8 */
>         struct wl3501_req          req;                  /*    22    72 */
>         /* --- cacheline 1 boundary (64 bytes) was 30 bytes ago --- */
>         u8                         rssi;                 /*    94     1 */
> 
>         /* size: 96, cachelines: 2, members: 8 */
>         /* padding: 1 */
>         /* last cacheline: 32 bytes */
> };
> 
> The problem is that the original code is trying to copy data into a
> bunch of struct members adjacent to each other in a single call to
> memcpy(). Now that a new struct wl3501_req enclosing all those adjacent
> members is introduced, memcpy() doesn't overrun the length of
> &sig.beacon_period and &this->bss_set[i].beacon_period, because the
> address of the new struct object _req_ is used as the destination,
> instead.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/109
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Awesome! Thank you for this solution.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
