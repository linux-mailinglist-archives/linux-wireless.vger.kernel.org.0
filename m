Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407863DB705
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhG3KQI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 06:16:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51098 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238274AbhG3KQH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 06:16:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627640163; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TaCpOqrOFZuMA47LguCMiBbgEddGbjLL2Omm1v9zSrk=;
 b=K2+lJsqVcdegHISSjuubsKbNxS5m078XN3WFe9sSR5a4a/sqnEv16HGIoOw1lngqKgng1CUR
 84B+ncAp4t+D+GgSLN1gjdYURK7gf9r0t5JwoUxi++7PKJpDlkvr1mbB6jI0x7U/0ZBlQJ5R
 8KfIEikoK+GyaJveyFpSa2VyvV0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6103d16238fa9bfe9c93ea65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 10:16:02
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D362C433D3; Fri, 30 Jul 2021 10:16:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CFD6C433F1;
        Fri, 30 Jul 2021 10:16:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Jul 2021 18:16:01 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 7/9] mac80211: add parse transmit power envelope element
In-Reply-To: <ed5566ab47d271b845635b5c731938f333ee96b6.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-8-wgong@codeaurora.org>
 (sfid-20210517_222024_817809_7D68677B)
 <ed5566ab47d271b845635b5c731938f333ee96b6.camel@sipsolutions.net>
Message-ID: <80b779458e0edfb9c0f7194116b35286@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-07-23 17:33, Johannes Berg wrote:
> On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
>> This patch is to add the transmit power envelope element parse in
>> _ieee802_11_parse_elems_crc(), it maybe have more than one transmit
>> power envelope element in a beacon.
> 
> This is really hard to read.
> 
> I'm sure you're aware of
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_messages
> 
> Also, FWIW, "This patch" language is pointless. We all know we're
> talking about a patch. Or maybe even not, we may be reading the commit
> later on.

will change it.
> 
>> +		case WLAN_EID_TX_POWER_ENVELOPE:
>> +			if (elems->tx_pwr_env_num >=
>> ARRAY_SIZE(elems->tx_pwr_env))
>> +				break;
>> 
> 
> Seems to me this should do some validation on the actual element? It at
> least has to have _one_ octet, afaict?
> 

will change it.
> johannes
