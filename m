Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C166FE446
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEJS5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJS5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 14:57:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7110D3
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 11:57:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso7216438a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683745064; x=1686337064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=puReIHrI1Ezdl53ea1AD3DhE5rnTlND8GWoPqB2mhTA=;
        b=nR6Z9RUFwxhs4Wd52PvBQnU1jE49MZCsIiAK0riNykekPUy8DZCnV8B9ocN6Ercfsm
         mhWGGPoptG8g8IlsPeTD2sR+yBGt82oV78TzRA0vnxzO9TxGPx0xSANeGneBqlCPCI50
         3zRnzpmOiIPAw7OvviO9rsOP/0B2VyrcKHw2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745064; x=1686337064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puReIHrI1Ezdl53ea1AD3DhE5rnTlND8GWoPqB2mhTA=;
        b=lAcAesm6B+2tNv6X8H6uVHPaCJ/YxqB4d6bMfKBkWUq2b32ddEofGy9rQz2f17a6xB
         g8S24Or6Z0etShpqRvfxqaA/k2kzELdWStP87QfkSSbGBvlplNsuBM/IQTmGRPxJRR+B
         WgqAPfJyiTGORll62r1JNC0nMsDyodN0gHu60r3UzXR92ThuyR3B7IpC7MOaWSXU99KQ
         fWPZH0fsfpwwN2nFG7C/ufJP9z0f3GbDTk3TZK5nPT9eXpB6L4Zf+v8YvCcDnIQx8o7T
         LJ//0ss2Yk0NO4UA1ORy5bWS91AE2m27tZtV30mL0glLEobFmq6LOBn0WREktBAXoC4v
         PK/g==
X-Gm-Message-State: AC+VfDyV+2gH1CdhHWaVfGeGFnsqnn/BbtoJrCMRTJT6sDMrxws8L3oB
        Cukgr3DECEcYHkhRefZkUHHnzQ==
X-Google-Smtp-Source: ACHHUZ4pjX0fn2OSny/cPd5pbGNVlB6T4U/Zx5rGFD07h4vQWn/qz+FGljqeSTy32UxvMo7FflHtgQ==
X-Received: by 2002:a17:90a:3841:b0:24e:14a4:9b93 with SMTP id l1-20020a17090a384100b0024e14a49b93mr19056169pjf.43.1683745064075;
        Wed, 10 May 2023 11:57:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:17a2:4d38:332d:67a0])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a195300b0023a84911df2sm22594405pjh.7.2023.05.10.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:57:43 -0700 (PDT)
Date:   Wed, 10 May 2023 11:57:41 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 02/13] wifi: mwifiex: Use default @max_active for
 workqueues
Message-ID: <ZFvpJb9Dh0FCkLQA@google.com>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-3-tj@kernel.org>
 <ZFvd8zcPq4ijSszM@google.com>
 <ZFvfYK-u8suHjPFw@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFvfYK-u8suHjPFw@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 08:16:00AM -1000, Tejun Heo wrote:
> > While I'm here: we're still debugging what's affecting WiFi performance
> > on some of our WiFi systems, but it's possible I'll be turning some of
> > these into struct kthread_worker instead. We can cross that bridge
> > (including potential conflicts) if/when we come to it though.
> 
> Can you elaborate the performance problem you're seeing? I'm working on a
> major update for workqueue to improve its locality behavior, so if you're
> experiencing issues on CPUs w/ multiple L3 caches, it'd be a good test case.

Sure!

Test case: iperf TCP RX (i.e., hits "MWIFIEX_RX_WORK_QUEUE" a lot) at
some of the higher (VHT 80 MHz) data rates.

Hardware: Mediatek MT8173 2xA53 (little) + 2xA72 (big) CPU
(I'm not familiar with its cache details)
+
Marvell SD8897 SDIO WiFi (mwifiex_sdio)

We're looking at a major regression from our 4.19 kernel to a 5.15
kernel (yeah, that's downstream reality). So far, we've found that
performance is:

(1) much better (nearly the same as 4.19) if we add WQ_SYSFS and pin the
work queue to one CPU (doesn't really matter which CPU, as long as it's
not the one loaded with IRQ(?) work)

(2) moderately better if we pin the CPU frequency (e.g., "performance"
cpufreq governor instead of "schedutil")

(3) moderately better (not quite as good as (2)) if we switch a
kthread_worker and don't pin anything.

We tried (2) because we saw a lot more CPU migration on kernel 5.15
(work moves across all 4 CPUs throughout the run; on kernel 4.19 it
mostly switched between 2 CPUs).

We tried (3) suspecting some kind of EAS issue (instead of distributing
our workload onto 4 different kworkers, our work (and therefore our load
calculation) is mostly confined to a single kernel thread). But it still
seems like our issues are more than "just" EAS / cpufreq issues, since
(2) and (3) aren't as good as (1).

NB: there weren't many relevant mwifiex or MTK-SDIO changes in this
range.

So we're still investigating a few other areas, but it does seem like
"locality" (in some sense of the word) is relevant. We'd probably be
open to testing any patches you have, although it's likely we'd have the
easiest time if we can port those to 5.15. We're constantly working on
getting good upstream support for Chromebook chips, but ARM SoC reality
is that it still varies a lot as to how much works upstream on any given
system.

Thanks,
Brian
