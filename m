Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA401E27CD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgEZQ64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 12:58:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54358 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbgEZQ64 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 12:58:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590512335; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0DXDuu5iyz3eCJtwVBnAaQBUjL3vC7O2k9XkvmUHAjA=;
 b=iGbZGP3AUCmrrdD0MzK9ranLGRwGqpxIe3reCLMSRatSx8IWAZvMLtVTMrJJBsriYECCT58z
 BZH8+zB6eagYar3XNLkKthrpoIYzyeVT6vVGUW4sGEdbNFIW2A/6L3iNJEnFFBYq+FQswoPP
 Ry1HOKoWeSDNiR7tuXCUa/59RRI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ecd4ac72c54998475254d27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 16:58:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B290C433C9; Tue, 26 May 2020 16:58:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA16FC433C6;
        Tue, 26 May 2020 16:58:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 09:58:45 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] cfg80211: propagate iftype HE 6 GHz capability
In-Reply-To: <8cf15557-2400-0893-9846-f091df7bc457@broadcom.com>
References: <1590467491-21187-1-git-send-email-rmanohar@codeaurora.org>
 <8cf15557-2400-0893-9846-f091df7bc457@broadcom.com>
Message-ID: <333b640fcb70004c70918356efdd035b@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-26 01:10, Arend Van Spriel wrote:
> On 5/26/2020 6:31 AM, Rajkumar Manoharan wrote:
>> Advertise per interface HE 6 GHz band capability to user space
>> which will be used to build IEs.
> 
> I am missing the bigger picture here. It should really be determined
> by the band in which the interface type is operating, right? Can you
> refer to patches on the hostap mailing list relying on this one?
> 
HE capabilities are exposed to user space via NL80211_BAND_IFTYPE_ATTR_*
as each iftype has different set of capabilities. My last series of 
hostapd
6 GHz changes are depending on HT/VHT capability for IE and config 
validation.
Planning to get rid of such dependency by announcing 6 GHz capability by 
driver
and use it in hostapd. Will post hostapd changes sooner.

-Rajkumar

