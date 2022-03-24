Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8C4E6864
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 19:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352505AbiCXSL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347622AbiCXSLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 14:11:55 -0400
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 88C668933A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 11:10:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1648145423; h=Message-ID: References: In-Reply-To: Subject:
 Subject: Cc: To: To: From: From: Date: Content-Transfer-Encoding:
 Content-Type: MIME-Version: Sender: Sender;
 bh=P7l+F5W+JnfONQ+yGtvPnXcDSOEvZtvC8Ey4H8jwmp0=; b=gfXtElRfarwneGe5BPBTMfs4RAQFWGjssw7TS3iDnSeo8paUUwbGmAcMy7D4M0cZXhmMGe6+
 cDuVjd8jFJyFBzeWrBjjkHE1vJgqYK/SfmuOS6xGCKA3MPbhBj9eBbUYECBdTeJadtThqapg
 oa3CsoEFoI02qbp+LzCi4zC+opY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 623cb40dab3ee5b49f383bd8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Mar 2022 18:10:21
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 297D8C43616; Thu, 24 Mar 2022 18:10:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4B36C4338F;
        Thu, 24 Mar 2022 18:10:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Mar 2022 23:40:20 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <6210385.n8AMQ0p90U@ripper>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org>
 <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
 <6210385.n8AMQ0p90U@ripper>
Message-ID: <3c54fa579046082c6dc30286ab291936@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-10 16:22, Sven Eckelmann wrote:
> On Tuesday, 10 August 2021 10:56:21 CEST Maharaja Kennadyrajan wrote:
>> 1. Staggered mode and 2. Burst mode while bring-up the AP
>> or MESH.
> 
> Why when you bring up mesh or AP when it is actually a global setting 
> for this
> radio/PHY?

[Maha]: yes, it is radio/PHY setting only and it is supported for AP and 
MESH mode now.

> 
> Kind regards,
> 	Sven
