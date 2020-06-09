Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3B1F3298
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 05:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFIDfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 23:35:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27383 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgFIDfO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 23:35:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591673714; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=25EFYaaud0sb33bXqCCib5KV1+P6zoDehpZUWvy12PY=;
 b=KYZAaWkQjA8uz2IK6dyYiZrLyFPoAwFA2gBICZ/CwaYp8cX5LzFN/jvmfR4pAQdl7w9S742m
 alOBQp/75JfylOToPuJ/fxJXaJpkgbKXidp56GDWPlKgDt/Vh4PGOsbuD4ECfWucIyaKsgoz
 ZyLui6NyH5qOhekUHEPt5vrLdy0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5edf0367f1889e857a5d8a8d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 03:35:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C0BDC433CB; Tue,  9 Jun 2020 03:35:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A428DC433C6;
        Tue,  9 Jun 2020 03:35:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Jun 2020 20:35:01 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 00/12] mac80211: add multiple bssid support
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
Message-ID: <dbf176d11cb4110a0a0bf6e29d68c409@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-04 00:09, John Crispin wrote:
> Multiple bssid allows us to share a single beacon amongst several VAPs.
> This essentially safes airtime. This feature is achieved by adding an
> additional IE to the transmitting VAPs beacon. This new IE contains
> the additional SSIDs and their non-inheritance information.
> 
> This series is still missing handling for TIM, which will be sent in a
> follow-up series.
> 
> John Crispin (12):
>   nl80211: add basic multiple bssid support
>   nl80211: add attributes for multiple bssid related settings
>   nl80211: add attributes to set beacon transmit mode
>   mac80211: add multiple bssid support
>   mac80211: add multiple bssid IE parsing
>   mac80211: propagate multi bssid settings when starting an AP
>   mac80211: propagate beacon tx mode to the driver
>   ath11k: pass multiple bssid info to FW when a new vdev is created
>   ath11k: add a struct to pass parameters into ath11k_wmi_vdev_up
>   ath11k: add the multiple bssid IE offset to the beacon template
>   ath11k: set beacon tx mode
>   ath11k: set the multiple bssid hw cap
> 
Great work :)

-Rajkumar
