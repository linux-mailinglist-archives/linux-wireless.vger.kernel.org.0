Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04A286C19
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgJHAeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 20:34:00 -0400
Received: from z5.mailgun.us ([104.130.96.5]:53382 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgJHAeA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 20:34:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602117240; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=biamuavAjnWyPN0pD2k2rAFeZUYWLvOeisw2bML2OgE=;
 b=eSXJoZDq9zOXjaJQB9UW7Ch9fYAgYlp6p6dmeFRibYlCmv/9vzzq8If/FhezKPpjuYc7ehmc
 VuEjCl3gDYILe29deynSFet0s8n+1B2Fn5fCi23hxx3lXKfLdoqj8LlSxKLFzmfdnqVW/SqC
 APgbsUZZRQcxT1e12RR7WiI7FaM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f7e5e77f9168450ea7fe069 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 00:33:59
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FD36C433FE; Thu,  8 Oct 2020 00:33:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDFB6C433CA;
        Thu,  8 Oct 2020 00:33:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Oct 2020 17:33:58 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 2/9] mac80211: add multiple bssid support to interface
 handling
In-Reply-To: <20200812150050.2683396-3-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
 <20200812150050.2683396-3-john@phrozen.org>
Message-ID: <6e914f17bc1fcd57bfb1a0d9f68fe4ad@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> 
>  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
> wireless_dev *wdev)
>  {
> +	struct ieee80211_sub_if_data *sdata;
> +	struct ieee80211_vif *child, *tmp;
> +
> +	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
> +	if (sdata->vif.type == NL80211_IFTYPE_AP) {
Hi John, Observed a NULL ptr dereference error here..

Thanks
Pradeep
