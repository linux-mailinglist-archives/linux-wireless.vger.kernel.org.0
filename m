Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C74255344
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 05:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgH1DVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 23:21:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38253 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgH1DVn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 23:21:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598584902; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=F7TvPtSUDXP1g1CLe1EeWey5ER9XS9KX4Ji30pM/v0w=;
 b=L1tKtqygqqxrOsPGeBqvHdXXDjFLwaMzvzulalub3JU2op5GgXyPSWazk73Yvs/Db0/TGble
 sJ8oayyNvB/p8CIauNE6gq4UxlHpbUzOh4tYCVPNg0WAjkeYlhDaZb7sg+dBwD5Q3FUPJ8ya
 ib/47LswWMKpZXe49Vo6kFKgr2k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f487819630b177c47ce5e12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 03:20:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 606A7C433CA; Fri, 28 Aug 2020 03:20:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1D6AC433C6;
        Fri, 28 Aug 2020 03:20:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Aug 2020 20:20:56 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 4/9] mac80211: add multiple bssid/ema support to bcn
 templating
In-Reply-To: <20200812150050.2683396-5-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
 <20200812150050.2683396-5-john@phrozen.org>
Message-ID: <e1822f692145388684e5c9cca767bbda@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> +static void
> +ieee80211_beacon_add_multiple_bssid_config(struct ieee80211_vif *vif,
> struct sk_buff *skb,
> +					   struct cfg80211_multiple_bssid_data *config)
> +{
> +	u8 *pos = skb_put(skb, 6);
> +
> +	*pos++ = WLAN_EID_EXTENSION;
> +	*pos++ = 4;
> +	*pos++ = WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION;
> +	*pos++ = 2;
> +	*pos++ = vif->bss_conf.multiple_bssid.count;
> +	*pos++ = config->cnt;
> +}
> +

Hi John,
Which field in the IE is this line for : '*pos++ = 2;' ?
This IE should be total 5 bytes with length=3.
