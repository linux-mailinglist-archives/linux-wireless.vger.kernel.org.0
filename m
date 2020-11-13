Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFED32B1822
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKMJWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 04:22:08 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:13150 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMJWI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 04:22:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605259327; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sm8Lb/nbp/rub7yuT2kse8lP7ErjqjYxEd2mJpyDxFU=;
 b=p98eASdEBFiQSvuQgi84scTsA89aN36Djn/McFCeyUL3nchomZOmZAZhL8M9yaIE9CztZZ9y
 8W0e0BCcvzbBgXB1MjzUa/0mk+e8UO4rMPHupl0VVhaYv2Qb6axkXX1qdlXmoMMsKImHzQKC
 u8HE1A4+0syk3dtH8xwHjym8W0A=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fae502840d4446125549421 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 09:21:44
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 525E7C43382; Fri, 13 Nov 2020 09:21:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5663C433C8;
        Fri, 13 Nov 2020 09:21:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Nov 2020 17:21:43 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
In-Reply-To: <e4bd954afa503835e072ef71aa61c59e04ecbc40.camel@sipsolutions.net>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
 <07179008e9369bc81e152009ca85191d@codeaurora.org>
 <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
 <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
 <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
 <83dd20def685d303106f285400367b6e@codeaurora.org>
 <798cea679ae1df5a2ab9b59dd81c8e2b3ca2d6e3.camel@sipsolutions.net>
 <30e2e578983e4df447e0c26c5bba0aba@codeaurora.org>
 <0e60e4cdc036a5ef7394848d212a6e3f499c386f.camel@sipsolutions.net>
 <256c487bb8c8c191a88d806e6125296e@codeaurora.org>
 <365b1abcfd043a3b0c356ec9f8c7c44acd5a79d2.camel@sipsolutions.net>
 <6caaa87ba3f37bd424e92d03c2340689@codeaurora.org>
 <e4bd954afa503835e072ef71aa61c59e04ecbc40.camel@sipsolutions.net>
Message-ID: <bc1db8cd25acd698ec586ed11c9865ac@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-13 17:10, Johannes Berg wrote:
> On Fri, 2020-11-13 at 17:09 +0800, Wen Gong wrote:
>> On 2020-11-13 16:51, Johannes Berg wrote:
>> > On Fri, 2020-11-13 at 16:51 +0800, Wen Gong wrote:
>> >
>> > > yes.
>> > > It can add check with supp_rates[band] of ieee80211_sta for
>> > > NL80211_IFTYPE_STATION type.
>> > > for others, check with sdata->vif.bss_conf.basic_rates
>> >
>> > Right.
>> >
>> > Though, might need to check that only if there's no TDLS station or
>> > something?
>> >
>> yes, I think it should do like that for TDLS:
>> test_sta_flag(sta, WLAN_STA_TDLS_PEER)
> 
> Yes but you have to iterate all the stations and check they belong to
> the interface and all that I think?
> 
Maybe not need.
if NL80211_IFTYPE_STATION and NON-WLAN_STA_TDLS_PEER, it has only 1 
station for the ieee80211_vif
by my understand.
> johannes
