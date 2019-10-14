Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D558D5EFA
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfJNJcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:32:46 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:53046 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfJNJcq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=0L45GlhkktQrKg5sqENX0zgxlTtsJeYFJSFk9fVXcQ0=;
        b=JJ9pEUIuzzOH6ClOxim6VJlmA0Jrzmes+UhH975Jtppvjzkal10clUrAh6mfidjlA6RqowU02eBZ8isxlwX1qhVefXd9TqVMC/AbdNA7w6FFvOjE3WbGDmH0qsFO6rMp2wel5jY4OmIeuDBVkVSh6Dr6QJJKmKMpBqPyrGaWW+g=;
Subject: Re: [RFC PATCH 0/2] ath10k: provide survey info as accumulated data
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, vnaralas@codeaurora.org,
        linux-wireless@vger.kernel.org
References: <20190918124259.17804-1-sven@narfation.org>
 <9a9ec99b-9643-7288-eed5-b549a9fe1487@newmedia-net.de>
 <1614044.H5m0Cyd3Ly@bentobox>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <c51d8bce-d51d-fe77-d756-036f719eb4f4@newmedia-net.de>
Date:   Mon, 14 Oct 2019 11:32:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1614044.H5m0Cyd3Ly@bentobox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1iJwiK-0001m7-82; Mon, 14 Oct 2019 11:32:28 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

10.4 has additional 64 bit cycle counters. see wmi_pdev_bss_chan_info_event

the standard 32 cycle counters do individual wrap around as far as i know

Am 14.10.2019 um 09:07 schrieb Sven Eckelmann:
> On Monday, 14 October 2019 00:15:20 CEST Sebastian Gottschall wrote:
>> i checked your patch on 10.4 based chipsets with 9984. the values are
>> now looking bogus and wrong at all. busy and active time time in ms does
>> increase in hours each second
>> the problem seem to be that your patch is 10.2.4 only related.
>> ath_clean_survey does not trigger on 10.4 so the values double itself
>> each time the event raises since you add the full values and not just a
>> delta on top
> Thanks for the feedback. So we have now a firmware 10.2.4 which is 
> counting
> busy + active up and has wraparound problems. And then we have a 10.4 
> firmware
> (on QCA9888 and QCA4019) which is clearing everything as expected with
> WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR  and then we have some 10.4 
> firmware (one
> QCA9984) which behaves more like ath 10.2.4 firmware but is marked as
> ATH10K_HW_CC_WRAP_SHIFTED_EACH like the QCA4019.
>
> So I have no idea how to fix this when QCA4019 and QCA9984 are currently
> marked the same but behave differently. Does somebody have a overview 
> how the
> different HW versions should behave or is there some special bit in 
> the data
> reported by the firmware which can be used to evaluate the expected 
> behavior?
>
> Kind regards,
>     Sven
