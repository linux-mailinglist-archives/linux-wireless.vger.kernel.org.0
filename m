Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC4456111
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhKRREh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:04:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35866 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233869AbhKRREd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:04:33 -0500
X-UUID: d90a2443bc28435e8f6edee9dc39fc6b-20211119
X-UUID: d90a2443bc28435e8f6edee9dc39fc6b-20211119
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1913938459; Fri, 19 Nov 2021 01:01:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 19 Nov 2021 01:01:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 01:01:28 +0800
Message-ID: <a62950603ba9855834e5593556987f6bf263b562.camel@mediatek.com>
Subject: Re: [PATCH 11/11] mt76: mt7915: poll mib counters every 200ms
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 01:01:28 +0800
In-Reply-To: <20211118164056.2965-11-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
         <20211118164056.2965-11-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-11-18 at 08:40 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Instead of every 500ms, this will do better job of catching wraps
> of 16-bit pkt counters.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> index 3c89c7573015..7cfa6b2abda5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -2390,7 +2390,11 @@ void mt7915_mac_work(struct work_struct *work)
>  	mutex_lock(&mphy->dev->mutex);
>  
>  	mt76_update_survey(mphy);
> -	if (++mphy->mac_work_count == 5) {
> +
> +	/* this method is called about every 100ms.  Some pkt counters
> are 16-bit,
> +	 * so poll every 200ms to keep overflows at a minimum.
> +	 */
> +	if (++mphy->mac_work_count == 2) {
>  		mphy->mac_work_count = 0;
>  
>  		mt7915_mac_update_stats(phy);

I guess we need to do some testing on embedded platform to see it hurts
performance.

Ryder

