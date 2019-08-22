Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39299E70
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbfHVSHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 14:07:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43660 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387517AbfHVSHm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 14:07:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so4099845pgb.10
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2019 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1GH4Oo5zbga04AzGP4KACk4wdL2sGKVVxtvv6c2anC8=;
        b=ZrWBW6tSTvhKXl7GkcHRQ+7b/xlos0dvm6Qz9E3PX5ZG0TfwY1m0nAWsbikqQp0/ac
         l1qrQyqb3ocsSWWVHT/tl2FK79lx8SXRIN53xa+rU58k5QUu1/zXWEWudo14v6+v00pC
         H3zh2a5IZievqx+BdIONlgOewSm/s2PZZjOeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1GH4Oo5zbga04AzGP4KACk4wdL2sGKVVxtvv6c2anC8=;
        b=gFfkL46zMVIVQAAKzE+i4/g9iY2RQ0fZihx0byj9oN5D4cwg3U0yzRjRGq/7OEyCXv
         0BzSxVNlKhO4ujy83o1WPP51e+mR0/nak4vRhH7SrtnTdxLDsi4vYvYwrKKnnmx4SSYi
         huXsJWY6WgNguruT6Ap0mJx2YyP2+9ZLWTdD6spFTDfAD83BnuCyp3AiuWiO5wm4Cdn4
         6gWF2kiQwUEGIOgQ73Z09PtfBganukK8PEiNqq1pwgjscAwiSb3cSzWdCuE3LMwqc89o
         W+mYI7xHQFYmy0U8eMYyFEzMxgCXj20IRN8tB+L6a7GOnhEax6pxrKGApjTWUL3wgRRX
         KHWQ==
X-Gm-Message-State: APjAAAV65IAgBTERi2J3Jj+4jQX3n3FVjS3FpFp8pK6VKUYavSUr7Yf5
        HaMq7NU6Nwaa4kWoqmhL2XifAQ==
X-Google-Smtp-Source: APXvYqxCfN8jblSa2BriLTm1dnfur9lri1ZlfHkGdWVii84CMnyZFTYl/WmOYxyg3XoMEfnrgfW8nA==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr534565pfa.90.1566497261511;
        Thu, 22 Aug 2019 11:07:41 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id i124sm79696pfe.61.2019.08.22.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 11:07:40 -0700 (PDT)
Date:   Thu, 22 Aug 2019 11:07:38 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthew Wang <matthewmwang@chromium.org>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nl80211: add NL80211_CMD_UPDATE_FT_IES to supported
 commands
Message-ID: <20190822180737.GA177276@google.com>
References: <20190822174806.2954-1-matthewmwang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822174806.2954-1-matthewmwang@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 22, 2019 at 10:48:06AM -0700, Matthew Wang wrote:
> Add NL80211_CMD_UPDATE_FT_IES to supported commands. In mac80211 drivers,
> this can be implemented via existing NL80211_CMD_AUTHENTICATE and
> NL80211_ATTR_IE, but non-mac80211 drivers have a separate command for
> this. A driver supports FT if it either is mac80211 or supports this
> command.
> 
> Signed-off-by: Matthew Wang <matthewmwang@chromium.org>

FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> Change-Id: I93e3d09a6d949466d1aea48bff2c3ad862edccc6

Oops :)
