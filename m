Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6F482065
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Dec 2021 22:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbhL3VXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Dec 2021 16:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbhL3VXv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Dec 2021 16:23:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24BAC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=an0afweyr2VUHtZJgtfovotVsZjm4jFi1wkqXDEe85s=;
        t=1640899430; x=1642109030; b=SLQ+qvFj0Ib3HmwaBJENG+M8TX6/wd3B4FppppirylJSQAq
        z4MBeoAMh3n8O/X9twdpC8+IsUUdq9XTwh1i1l48XmpGmxQYVGHxJKBlCUTpj0WUnjMcoHhxLSgKr
        bsdjOLoP+ePTL6zvKrm7GFMFcAvNcsWjWgHN2tT4wAT4K9eHshIPiths/xMcGNBHYw4sZCMZe2aZU
        SUIiPtYsEHlBnE7AH3h1M0I/hhROgbOsr7/r8gSMIrvNUIE3tlH/3GZdnw7URo7sJ+mZr0kM1MGd0
        IlJ5QZCkefS5Dy/TJpxfh66+VioUzSG8gdYN8yLYHEL43uCwoBaMI40YeC1KiL2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n32te-000Fd2-Le;
        Thu, 30 Dec 2021 22:23:38 +0100
Message-ID: <e71124fb6941ceb8022347a19deb954e54f653f3.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] rtw89: limit RX status rate of VHT to MCS 9
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, rgoldwyn@suse.com
Date:   Thu, 30 Dec 2021 22:23:37 +0100
In-Reply-To: <20211230011607.8823-1-pkshih@realtek.com>
References: <20211230011607.8823-1-pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-12-30 at 09:16 +0800, Ping-Ke Shih wrote:
> 8852AE can receive packets with VHT MCS10/11 that is out of specification,
> so mac80211 warns and drops the packets, and it leads low TCP throughput.
> 
>   Rate marked as a VHT rate but data is invalid: MCS: 10, NSS: 2
> 

We already support these in cfg80211 for brcmfmac, arguably we could
just add support in mac80211 instead?

johannes
