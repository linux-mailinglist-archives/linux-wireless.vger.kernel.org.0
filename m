Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097237977B6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjIGQbf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbjIGQbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A82593C2
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 09:06:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a1af910e0so968266b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694102721; x=1694707521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcyxOSggFnT8Ic9CqC6qcF6Fq10Tfk/L3Y7hgvwEr3E=;
        b=njeSDCVgMRKhgzgSdzFi1QU4BHfz+/+yMoN3v7IQF4Pl+qgpwzcL/AnZaipvTMXgsD
         AfvL+PpeuSsjtCo8eLFUb6qM0HGJN32LUKvTX4vBtru7cQ4oThaFM/DboXhjZuCZsRM9
         qTtOvrr5V1ThTFwfAnuJKzbP7gJ7fELFbo5dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102721; x=1694707521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcyxOSggFnT8Ic9CqC6qcF6Fq10Tfk/L3Y7hgvwEr3E=;
        b=UBS16MmgduCa2BLpgl7ABMarkID0Jqq2MOUGYBYm80QFEc4ANMM0VWUtFJZ0FWWx0n
         DF3JtlxfiZ4lOzK7xTp11reruyHmbkKeeQkq2AWuoDCHFvxevKEnpW+0kKQcStyMMNyJ
         HIfr9Btoq2lN7Q6wpzDJdVNXbUd3HtlaVwcuMb7HbZQGg45mWI0MI5ajKaMlhR5yrf6s
         NNE7fdvwGOV7m37Y91LxWju+X0dhPtGWNdNj3P5oHD+Kt93tZy32Iv94rq5vMk4Ipss8
         rlLm/Jzra0szA2Bj+7y+6H5Q31FOV0rUABGUs/HUUBSGspvowY8+cyzP5xTqmaoAT8vt
         a4Fw==
X-Gm-Message-State: AOJu0YyIWgd9NvCF3N0342QiO0kRRB7O7FliBRXRHMCDQseEsdOYXsBA
        Ba3Y7TxxV/O8tgfPUf6dIcvc9ieH+Wq8w1gXYuwUYZcjOzsk94Dl3WA=
X-Google-Smtp-Source: AGHT+IE1IQmuAu98wfTAfZnH2ci2ShqHzINUOMlkN2e6kVnLPzYtV/ukSH3+yRZnJP0M3HaXc8gD7QD57G7ei/fmKv0=
X-Received: by 2002:a05:6820:284:b0:573:7828:ce53 with SMTP id
 q4-20020a056820028400b005737828ce53mr17148380ood.4.1694077854745; Thu, 07 Sep
 2023 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102940.1120269-1-treapking@chromium.org>
In-Reply-To: <20230906102940.1120269-1-treapking@chromium.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Thu, 7 Sep 2023 11:10:44 +0200
Message-ID: <CABRiz0r8qHgx-4b7QdCj6iz9FDsyChznEHOn5eByVoUYuLa-PQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> -       if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> -                    sizeof(bridge_tunnel_header))) ||
> -           (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> -                    sizeof(rfc1042_header)) &&
> -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
> -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
> +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <= skb->len &&

sizeof(*rx_pkt_hdr)?
