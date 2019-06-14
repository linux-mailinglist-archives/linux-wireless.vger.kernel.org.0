Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521AC45CE6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfFNMdb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 08:33:31 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41260 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMdb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 08:33:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hblNz-0008DP-D7; Fri, 14 Jun 2019 14:32:51 +0200
Message-ID: <507ecb111701598ed812dda95c18381a7ae9b720.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: add support for the ADDBA extension
 element
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Date:   Fri, 14 Jun 2019 14:32:50 +0200
In-Reply-To: <20190521150259.2414-2-john@phrozen.org>
References: <20190521150259.2414-1-john@phrozen.org>
         <20190521150259.2414-2-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>  
> +#define IEEE80211_ADDBA_EXT_ELEM_ID		0x9f

That doesn't really belong here.

> +#define IEEE80211_ADDBA_EXT_ELEM_ID_LEN		0x01

And that's usually not a define?

> +#define IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK	GENMASK(2, 1)
> +#define IEEE80211_ADDBA_EXT_FRAG_LEVEL_SHIFT	1
> +#define IEEE80211_ADDBA_EXT_NO_FRAG		BIT(0)
> +
> +struct ieee80211_addbaext {
> +	u8 eid;
> +	u8 length;
> +	u8 data;
> +} __packed;

I think we don't typically put the eid/len inside, and then we use
sizeof(struct ...) for the size.

johannes

