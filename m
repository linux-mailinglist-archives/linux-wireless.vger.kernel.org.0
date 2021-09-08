Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C824034B1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbhIHHDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 03:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbhIHHDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 03:03:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EB7C061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Q0KHHmxu2WaJvT/esI5VxK/+UvFQVdEa/RWMgw4p4NM=;
        t=1631084561; x=1632294161; b=oJmsrEZLy3dr5BKMaXgZ7lGA8zgh9oQSba5t/kKe34/W1+S
        JEEsdmRYtFy8UV2D8Svh0WTcQIBrdKZodPlrCGJIiOfT6djyEc3+AQaosylTyTFd5S1xaYfrbbOsI
        NCNMOeDo4gmRohGfQclWmudMtgbXOs4lJHjFcVnctwmA5eS9kaKOdc1hvCKla1xwmdn5+YaJjJFbO
        aSQcanpZuKhHdOqFcmSCSAK9lwL0kM6upsIJnBTEkeWVptTM6TdkV3BKG49ZpYVabNPHfjz6jxlky
        t4Z7dpW7Basod33HNhnIaMFIbj6lhcZnaumAFmork8hs1JFUgqHItbm4Re5qu+wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mNrbT-004EDB-O2;
        Wed, 08 Sep 2021 09:02:39 +0200
Message-ID: <55cfbf94d90c678501b4144484348bd9ebd005fa.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: AP mode driver offload for FILS association
 crypto
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Subrat Mishra <subratm@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Wed, 08 Sep 2021 09:02:38 +0200
In-Reply-To: <1631083922-24136-1-git-send-email-subratm@codeaurora.org>
References: <1631083922-24136-1-git-send-email-subratm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +	TP_STRUCT__entry(WIPHY_ENTRY
> +			 NETDEV_ENTRY
> +			 __array(u8, macaddr, ETH_ALEN)
> +			 __field(u8, kek_len)
> +	),
> +	TP_fast_assign(WIPHY_ASSIGN;
> +		       NETDEV_ASSIGN;
> +		       FILS_AAD_ASSIGN(fils_aad);
> +	),

I don't think we typically do the alignment like that?
johannes

