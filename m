Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33865FAC7A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 08:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJKGSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 02:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJKGSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 02:18:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE9B876B3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 23:18:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b15so11649041pje.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 23:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PL23sMexpwn40kFVUCoq7aeOuxcWfa90L83fdjYFkLY=;
        b=f6DL3dxWhfQZmKFmUHwx772NtYi0pI9Iju4bXuzYcNgU9tZRwWO23ZROjn/BdwYph8
         zS5kHOuhegb7qVyT8JCE/zjOjVJQhGat2ZD/xfafy/Nwct8qKjWTUMZrD0uWLayoRBv2
         rpvXb5DG+C65jUvr+BcKzqEJk7FpvjtXZEWX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PL23sMexpwn40kFVUCoq7aeOuxcWfa90L83fdjYFkLY=;
        b=xBZcaTduvvJuKvycQWy0zFmuCKkKXIqjO9riR/Ze9rjt407nVf1OEPByMeHiyHNQEF
         IrWkfNyyEJIo5WXwPEtZY556cG9YSindQ40Od28xWLUHOjwI78h3R6+fip8cYEZZhvUW
         5f7Ctr+izxw9ZPVXi1ea3DfRVqhU7C/MXiqIEGCoaI3niBW8S5miMBz7+9zEyTsu7F/a
         spbbOZMs6Mdb+sCuuCrrD16mgyHDBxMeyy/z5KO+ZzstURXWGV0I4YXhGRb1Y1fmM9qk
         4qks/NtPrjRnsmUfiYUoeTpbQwtYi3J0XaX4Ox6cXFl1XAgrIqKXiGNOXxrJ5WwbTkiC
         arzw==
X-Gm-Message-State: ACrzQf2LD4RD6dVu/F1jDYgWoOCDCQBHLdNHqxDM1xUiP3U4fo8PW08M
        rNl9T+gglAI8jdKhZ5BG1g1VMRltqFcPpA==
X-Google-Smtp-Source: AMsMyM4LISwAIppjAhD1g2j73VCLB7YWcSS9szvYVpDWrK9Gq7TZ7qkMS3VVH6g/Hn7wVmEdsXnrbg==
X-Received: by 2002:a17:903:32d2:b0:17f:9224:6e11 with SMTP id i18-20020a17090332d200b0017f92246e11mr23387269plr.116.1665469080745;
        Mon, 10 Oct 2022 23:18:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c19-20020a621c13000000b00562b811bb42sm7916863pfc.49.2022.10.10.23.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 23:17:59 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:17:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hawkins Jiawei <yin31149@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [fortify] 54d9469bc5:
 WARNING:at_net/wireless/wext-core.c:#wireless_send_event
Message-ID: <202210102312.1CC8197@keescook>
References: <202210110943.6f16f1ea-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210110943.6f16f1ea-yujie.liu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 11, 2022 at 11:46:21AM +0800, kernel test robot wrote:
> commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 ("fortify: Add run-time WARN for cross-field memcpy()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> [...]
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> [...]
> [   95.913726][   T36] memcpy: detected field-spanning write (size 16) of single field "&compat_event->pointer" at net/wireless/wext-core.c:623 (size 4)

This was fixed with:
e3e6e1d16a4c ("wifi: wext: use flex array destination for memcpy()")

I expect this will land before -rc1 closes, but Johannes will know more
about the schedule.

-- 
Kees Cook
