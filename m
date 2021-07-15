Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAB13CA899
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbhGOTBu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbhGOTA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 15:00:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B95C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 11:57:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cu14so4773619pjb.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jul 2021 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpqK/+JnT/yu+43Wp/CTAn4yU0zaOH0GM3Vf86wiOOg=;
        b=B6T3ffeP6Gfm1546QQw/hH4JWosP8ijd1SUp9Gzpol1VC9nyyxAzy5gJEIX9GB+L53
         9j9szL8+00cJbXC4ibOub3nxCUd7MSJ0AYVRVIjLa2c8iCF7K3PAH99bLMJmd/YALcFA
         JSiP0nMuKurGshm7n60hzbG934RLGoH6DzOCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpqK/+JnT/yu+43Wp/CTAn4yU0zaOH0GM3Vf86wiOOg=;
        b=VOE+Jg4OGP262huMo9KyqnzD7z9fmp+gxpelhpmJddYPbJHqLlcKEtiiUs5KPOSDJL
         540faQDy8uxCiDenUyhjiFI20z6440v+JPBN56F8AoemaRtGnu3yawgvRtoy7ao0adhP
         kT5PY61IY2Zepz0jqUjnqO74OJVrSTIZ4uqcL9Bko4Z1TeQ5w0cXWZZLWcJ/MQ8ZE1KN
         K+OxgbP+4jsPBovvi8doBFGfof8rSTO0luSjJrjjt+235FxX9zEW0YU93lnklV9yXcd2
         pYfa8rMezX196Cs5YItTiKY5Qd+/poPMCIu+zrM0gL06GFNRIIz1d+FwLJqKKNR+lQit
         aobw==
X-Gm-Message-State: AOAM533nEW2tRwm1ZR/TISgwLhVqlpaXYvu9OvZoOLEEPTvu1RBsUST5
        BbV9OiarFAkVAjbeMFfb1hNLGg==
X-Google-Smtp-Source: ABdhPJxA6CkuT2I4U6XIvHhxltf1pE+P+YvTq2Efk8xWVgyogQShVA1GFQfapGoXHqoSxo9UN4Dnbw==
X-Received: by 2002:a17:902:6bc7:b029:129:20c4:1c33 with SMTP id m7-20020a1709026bc7b029012920c41c33mr4671212plt.52.1626375427690;
        Thu, 15 Jul 2021 11:57:07 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3f42:6b4d:93b8:910b])
        by smtp.gmail.com with ESMTPSA id w69sm7501651pfc.58.2021.07.15.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:57:06 -0700 (PDT)
Date:   Thu, 15 Jul 2021 11:57:04 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 03/24] rtw89: add core and trx files
Message-ID: <YPCFABiygQbiMqcB@google.com>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-4-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618064625.14131-4-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 18, 2021 at 02:46:04PM +0800, Ping-Ke Shih wrote:
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -0,0 +1,2359 @@
> +static void rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
> +				     struct rtw89_traffic_stats *stats)
> +{
...
> +	stats->tx_avg_len = (u32)(stats->tx_cnt ? stats->tx_unicast / stats->tx_cnt : 0);
> +	stats->rx_avg_len = (u32)(stats->rx_cnt ? stats->rx_unicast / stats->rx_cnt : 0);

You're doing 64-bit division which isn't supported on all architectures.
You need a do_div()-based solution here, like:

	stats->tx_avg_len = stats->tx_cnt
			    ? DIV_ROUND_DOWN_ULL(stats->tx_unicast, stats->tx_cnt)
			    : 0;
	stats->rx_avg_len = stats->rx_cnt
			    ? DIV_ROUND_DOWN_ULL(stats->rx_unicast, stats->rx_cnt)
			    : 0;

Brian
