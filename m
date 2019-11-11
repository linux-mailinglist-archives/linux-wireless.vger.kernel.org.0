Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4AFF6F44
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 08:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKH5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 02:57:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfKKH5K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 02:57:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D06B4608CC; Mon, 11 Nov 2019 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573459029;
        bh=S7KBTQ03krYSdg5c3dcqLbjEuC0Jp7OQePSlRrVO7p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HYFWrgGmClU1T9ySkNYxE0bE3Rx/rZSd86HBP3xCFJ1Lra4vd0rYwdc+eWda3c+aL
         jY+Qh9i0WKSqgnHPHsOoSd5gBWvQspmLrSEK5GNBtLOHUpMrjpfTplEBlWyTUAjUjK
         ZE3L07JrWh1iU7VFZDiEMQAkRdX2Xr7Ex88dX70o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 634D66087D;
        Mon, 11 Nov 2019 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573459029;
        bh=S7KBTQ03krYSdg5c3dcqLbjEuC0Jp7OQePSlRrVO7p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HYFWrgGmClU1T9ySkNYxE0bE3Rx/rZSd86HBP3xCFJ1Lra4vd0rYwdc+eWda3c+aL
         jY+Qh9i0WKSqgnHPHsOoSd5gBWvQspmLrSEK5GNBtLOHUpMrjpfTplEBlWyTUAjUjK
         ZE3L07JrWh1iU7VFZDiEMQAkRdX2Xr7Ex88dX70o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Nov 2019 13:27:09 +0530
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [EXT] Re: [PATCH v2 0/2] add Wide Band Scan support
In-Reply-To: <867302d58d3183ce7e2c7afa846027a787579b87.camel@sipsolutions.net>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
 <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
 <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
 <867302d58d3183ce7e2c7afa846027a787579b87.camel@sipsolutions.net>
Message-ID: <6ea305b2ac09c340181623a23cf4180b@codeaurora.org>
X-Sender: murugana@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-05 15:52, Johannes Berg wrote:
> On Tue, 2019-11-05 at 15:51 +0530, Sathishkumar Muruganandam wrote:
>> > Neither of these are scan use cases (at least not that are covered by
>> > nl80211 scan APIs), so that doesn't make sense.
>> >
>> 
>> Actually we had extended the existing 'iw scan' command to do Wide
>> Band Scan using nl80211 scan APIs.
> 
> Yes ... but ... that doesn't address my question.
> 
> How is this related to scanning? It sounds to me like you're just
> (ab)using scan as a somewhat convenient "do some channel hopping" API
> ...
> 

Whether this can be used under "iw offchannel" with 
NL80211_CMD_REMAIN_ON_CHANNEL?

Please provide your comments.

-- 
Thanks,
Sathishkumar
