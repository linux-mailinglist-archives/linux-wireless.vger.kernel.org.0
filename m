Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84AA6CA2F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfGRHpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 03:45:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfGRHpZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 03:45:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A906CC057E3C;
        Thu, 18 Jul 2019 07:45:24 +0000 (UTC)
Received: from localhost (unknown [10.40.205.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0DAC5D9CC;
        Thu, 18 Jul 2019 07:45:23 +0000 (UTC)
Date:   Thu, 18 Jul 2019 09:45:23 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: Re: [PATCH] mac80211: don't warn about CW params when not using them
Message-ID: <20190718074522.GA13713@redhat.com>
References: <20190718015712.197499-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718015712.197499-1-briannorris@chromium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 18 Jul 2019 07:45:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 17, 2019 at 06:57:12PM -0700, Brian Norris wrote:
> ieee80211_set_wmm_default() normally sets up the initial CW min/max for
> each queue, except that it skips doing this if the driver doesn't
> support ->conf_tx. We still end up calling drv_conf_tx() in some cases
> (e.g., ieee80211_reconfig()), which also still won't do anything
> useful...except it complains here about the invalid CW parameters.
> 
> Let's just skip the WARN if we weren't going to do anything useful with
> the parameters.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Noticed because rtw88 does not currently implement .conf_tx()
> 
> I think there are several ways to slice this one. I picked one fix,
> which may not be the best one.

Fix looks fine for me. However I think rtw88 should implement
drv_conf_tx() because parameters can be different on different
network setups and maybe more important WMM/AC parameters become
quite recently part of ETSI regulatory.

Stanislaw 
