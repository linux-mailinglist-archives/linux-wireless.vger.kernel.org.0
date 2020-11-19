Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6532B9BCD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 21:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgKSUC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgKSUC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 15:02:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD59C0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 12:02:27 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so7837541wmb.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Byum6qV893Xpawog7+D8XTJB1Lt/Fhd8GCtgU9ZgIqU=;
        b=Zy1I5IMR6Wt/dDm9Th2vSf7DCO0r2d3fVAWUHrpjp+6PKpCqJ7txeLMR04zRppm4Gr
         ARvquS1S9X1tJPfBS7BumkZQGCg/8qo3D4rJ60nznWCZtNan7W2EkzQgn2csqEejy8U7
         J5U071uz/9njNI6WIMGgiFnHkd8oom8gnwLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Byum6qV893Xpawog7+D8XTJB1Lt/Fhd8GCtgU9ZgIqU=;
        b=d9XReKikWCr4zFatLRuI2g/G7iO4UbfxE36iSJ9l41itd4KcYXSDkyZyFNq7jtuVZm
         xC9n8SQrd3UQ5xfOKxWh0cV0OlkYom0EvNtC7byOEF0mkLpSHv25Q9PBteg9yYcTqy2t
         bAuCItbcTAdfAxIIbP3Qd4fQ4BJX1pT63ZcKDtexQXmUs4aXXC1CX7L68MKtnjzs1GK6
         9KM/MH9OAUCNZQKsvxciPhRiAb1lshJfDBshNGktQtsuI07N+0GVjvW7l3yRVazZc519
         LCPm4yDfIUsJepO/2PDiqV9YpozG0ZtQ4vdjpW8Hpf4zFzbVtT5zM8tlrvGZViVzwbSU
         7ArA==
X-Gm-Message-State: AOAM531wi2W2SQzYFgppgVkIXgyZoXLJ0mC/hrjS6r2A28iss5oy4aHy
        Ru0Z8rnwIm5IZd/cpQ8DjgpDL5JcEIZk9hUNJ755SQ==
X-Google-Smtp-Source: ABdhPJyml7CLKq4jIELX36nLstCIRmUJJ7atf/pyLlaVoa5zwn0/F+BnLhAP0rlR1e4m1SfkrxttfosgHa6lYhk14cM=
X-Received: by 2002:a1c:103:: with SMTP id 3mr6020786wmb.81.1605816146302;
 Thu, 19 Nov 2020 12:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20201106100708.4609-1-cjhuang@codeaurora.org> <20201106100708.4609-4-cjhuang@codeaurora.org>
In-Reply-To: <20201106100708.4609-4-cjhuang@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Thu, 19 Nov 2020 12:02:16 -0800
Message-ID: <CACTWRwtRfgaHXYMAttNwptHxCA7k6r+G_sC0=oyHZxjYb-GeWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ath10k: allow dynamic SAR power limits via common API
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>, kuabhs@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
This patch looks good to me, there is one small nit, If the maintainer
can take care of it then probably we don't need a new rev.

> @@ -329,6 +336,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>                 .fw_diag_ce_download = true,
>                 .tx_stats_over_pktlog = false,
>                 .supports_peer_stats_info = true,
> +               .dynamic_sar_support = true,
>         },
Orthogonal to this patch, other people might probably differ, I guess
putting dynamic sar support as a firmware feature capability should be
more scalable and then we don't need a structure table for each
firmware. This might hold for other firmware features as well.

> +       ath10k_dbg(ar, ATH10K_DBG_MAC, "mac txpower 2g:%d 5g:%d\n",
> +                  tx_power_2g, tx_power_5g);
just a nit: space after colon. This might throw a warning in checkpatch.pl

-Abhishek
