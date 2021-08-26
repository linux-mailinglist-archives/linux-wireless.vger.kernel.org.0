Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9C3F83A7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhHZIVD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHZIVC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:21:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415EC061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=b8XUGoFPW6vRAEsN3iQ2xKUBOJTnFrxIvxTg5qvp850=;
        t=1629966015; x=1631175615; b=TII6JIq9GdhjcyqD1XhuNgkhrG5jrn/PvQ3XIpzWl1e1fct
        gnR2hkW0p14biniSwG2a3JDCrUlWZIvcYzRB2Si7HclTsNg7MSqdRWkTN2CnbOtRNWp4vvkoT47Hx
        7pjHX9qnP1PXH+rZObhI7jVW5xxwL3HpHYp+0C9Pkd4niDSLCZ5e4eOAr5S11Poc7LOYfDCjDxwWV
        Bod/pSYwdcpYBeFZocLvDfi9H+sdWbCBdOAGZe/eXFAXqszFgMPFnUtAMiyw3xZJmxyCkmE1WYrA7
        T81Xk8NctKcVbJjTYraSVTECFjeEa4jNOrsvr1j44vtep/JUP/R1PNmAFIHAygzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAcK-00G4bP-Ji; Thu, 26 Aug 2021 10:20:08 +0200
Message-ID: <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:20:07 +0200
In-Reply-To: <20210820122041.12157-2-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-2-wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>  struct cfg80211_chan_def {
>  	struct ieee80211_channel *chan;
> @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
>  	u32 center_freq2;
>  	struct ieee80211_edmg edmg;
>  	u16 freq1_offset;
> +	enum nl80211_ap_reg_power power_type;

I'm not sure why this should be in the chandef, there's no way that
anything in cfg80211 is ever using it there, at least in your patches.

> +/**
> + * enum nl80211_ap_reg_power - regulatory power for a Access Point
> + *
> + * @NL80211_REG_UNSET_AP: Access Point has no regulatory power mode
> + * @NL80211_REG_LPI: Indoor Access Point
> + * @NL80211_REG_SP: Standard power Access Point
> + * @NL80211_REG_VLP: Very low power Access Point
> + */
> +enum nl80211_ap_reg_power {
> +	NL80211_REG_UNSET_AP,
> +	NL80211_REG_LPI_AP,
> +	NL80211_REG_SP_AP,
> +	NL80211_REG_VLP_AP,
> +	NL80211_REG_AP_POWER_AFTER_LAST,
> +	NL80211_REG_AP_POWER_MAX =
> +		NL80211_REG_AP_POWER_AFTER_LAST - 1,
> +};

Similarly here (and the other enum), why is this in nl80211 if it's
never used in nl80211?

johannes

