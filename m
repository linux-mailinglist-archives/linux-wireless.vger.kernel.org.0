Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC821F4A5A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 02:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgFJAZ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 20:25:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62355 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbgFJAZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 20:25:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591748756; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Sjs7aqO/Uq4zHDq9mzyvKnW1+H8FVQcNYuTrCV+bXd4=;
 b=tp9IGK5B8vJtg9VA9ynJ+0uqasejo3mPJReVhu7ZX83HRQdIbSu2BcDWlrVHHuT4tD5YkTMB
 Fx5lnv1sRQQIiOQaeIQ+oLt0YR8KS2hYqgaA7Q1OfH9X0AAkjPB/2uW6oou2UX9DFWG3NqHJ
 uBHRIV7RwNiMEqZMoHfHEmovpwk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5ee028930206ad41d1792b96 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 00:25:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1154EC433CB; Wed, 10 Jun 2020 00:25:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A4CFC433CA;
        Wed, 10 Jun 2020 00:25:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jun 2020 17:25:54 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 01/12] nl80211: add basic multiple bssid support
In-Reply-To: <20200604070952.15481-2-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
 <20200604070952.15481-2-john@phrozen.org>
Message-ID: <95d452bacbeba285c9dad7f037f78078@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-04 00:09, John Crispin wrote:
[...]
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -663,6 +663,10 @@ const struct nla_policy
> nl80211_policy[NUM_NL80211_ATTR] = {
>  	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
>  	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
>  	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 
> 100),
> +	[NL80211_ATTR_MULTI_BSSID_MODE] = NLA_POLICY_RANGE(NLA_U8,
> +					NL80211_MULTIPLE_BSSID_LEGACY,
> +					NL80211_MULTIPLE_BSSID_NON_TRANSMITTED),
> +	[NL80211_ATTR_MULTI_BSSID_PARENT] = { .type = NLA_U32 },
> 
If it is read as u8, better define as NLA_U8.

>  };
> 
>  /* policy for the key attributes */
> @@ -3756,6 +3760,16 @@ static int nl80211_new_interface(struct sk_buff
> *skb, struct genl_info *info)
>  	if (err < 0)
>  		return err;
> 
> +	if (info->attrs[NL80211_ATTR_MULTI_BSSID_MODE])
> +		params.multi_bssid_mode =
> +			nla_get_u8(info->attrs[NL80211_ATTR_MULTI_BSSID_MODE]);
> +	if (info->attrs[NL80211_ATTR_MULTI_BSSID_PARENT])
> +		params.multi_bssid_parent =
> +			nla_get_u8(info->attrs[NL80211_ATTR_MULTI_BSSID_PARENT]);
> +	if (params.multi_bssid_mode == NL80211_MULTIPLE_BSSID_NON_TRANSMITTED 
> &&
> +	    !params.multi_bssid_parent)
> +		return -EOPNOTSUPP;
> +
Are you expecting BSSID or ifindex in multi_bssid_parent? If it is 
ifindex, it can be 0. no

-Rajkumar
