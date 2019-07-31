Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D77BCCC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfGaJTP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 05:19:15 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55282 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfGaJTP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 05:19:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsklL-0004Tl-6x; Wed, 31 Jul 2019 11:19:11 +0200
Message-ID: <428fec1c2dd6f6d9345323f272eef423a214bc39.camel@sipsolutions.net>
Subject: Re: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:19:10 +0200
In-Reply-To: <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
         <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Was waiting for you to address Sergey's feedback, but now that I looked
anyway, I have some of my own. Sorry for the long delay though!

> + * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
> + *	nested attribute with %NL80211_TID_ATTR_* sub-attributes.

Please use NL80211_TID_CONFIG_ATTR_* throughout, also for

> +/* enum nl80211_tid_attr_config - TID specific configuration.

the enum name

> +enum nl80211_tid_attr_config {
> +	__NL80211_TID_ATTR_INVALID,
> +	NL80211_TID_ATTR_CONFIG_TID,
> +	NL80211_TID_ATTR_CONFIG_NOACK,
> +
> +	/* keep last */
> +	__NL80211_TID_ATTR_CONFIG_AFTER_LAST,
> +	NL80211_TID_ATTR_CONFIG_MAX = __NL80211_TID_ATTR_CONFIG_AFTER_LAST - 1

and all the things in it.

Also, as you can see above, the kernel-doc comment isn't formatted
right.


> +	nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
> +			    rem_conf) {
> +		ret = nla_parse_nested_deprecated(attrs, NL80211_TID_ATTR_CONFIG_MAX,
> +						  tid, NULL, NULL);

You shouldn't use _deprecated.

> +		ret = parse_tid_conf(rdev, attrs,
> +				     &tid_config->tid_conf[conf_idx],
> +				     tid_config->peer);

and yeah, this should compile.

johannes

