Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E963B775E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jun 2021 19:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhF2RrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Jun 2021 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhF2RrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Jun 2021 13:47:23 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD397C061760
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jun 2021 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wm96ttAfqELqdoCeZXAh41t/Wo5Pn1VIhdGSoa8LxTw=; b=k53iBDt+7zoyPjhPdqETsaZByg
        JOlxyBtElFQOOs9Lcx3y4EH7/i+6WcYxFrLd59hnFzwBm0P8DnGjlqntdTWKANXBFN0lA6/6Nm7zH
        HsPiqNFtlNnV5KosozksVvkq6EUkzNvb3/jjihuL55QdrrC3UrU4sHaofH+h0cuGbE7I=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lyHn3-0000B5-QS; Tue, 29 Jun 2021 19:44:53 +0200
To:     Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1623164855-15910-1-git-send-email-mkenna@codeaurora.org>
 <1623164855-15910-2-git-send-email-mkenna@codeaurora.org>
 <f14e6e6b81978ace4580774981a7e032b4001182.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 1/3] nl80211: Add support for beacon tx mode
Message-ID: <0e3d0abd-a895-77d8-d3a6-ef6d2616b7db@nbd.name>
Date:   Tue, 29 Jun 2021 19:44:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f14e6e6b81978ace4580774981a7e032b4001182.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-23 13:16, Johannes Berg wrote:
> First, I'd like to see some input from other vendors - is this useful?
> 
> I have no objections to it and it comes with an in-kernel driver, so I'm
> inclined to accept it, but maybe we should have other modes, etc.?
I haven't seen any config option like this outside of QCA stuff.
It seems to me that before getting merged, the documentation should at
least cover when and why the *user* would configure this implementation
detail, instead of having the driver/fw make a reasonable decision on
its own.

- Felix
