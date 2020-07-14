Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4036921EBE7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgGNIwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 04:52:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61517 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgGNIwu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 04:52:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594716769; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=6fV91jsaVlx04iaWlfIxUem9x/HG5zEzeRVZO+D6KHs=; b=sdlrrQ0GZUBma3kLiC4rcMi/MwFQf8LttArbqMi8E2sL/MoHC0jl3uFfXE8mjE2JTEielh7o
 sYCTWvDw9MdJFeono1568Ma+w5+xjeud5NKKDULm076VfrHb3jCMsY2+wGcKmwUYqYmZ93Kw
 2pqGZOGmJjTM4wtPOIRfCqtdiL4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f0d7261e3bee12510347979 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 08:52:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 557B7C433CB; Tue, 14 Jul 2020 08:52:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3102C43387;
        Tue, 14 Jul 2020 08:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3102C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: Re: [PATCH] iwlwifi: Make some Killer Wireless-AC 1550 cards working again
References: <20200702150552.9734-1-alessio.bonfiglio@mail.polimi.it>
Date:   Tue, 14 Jul 2020 11:52:38 +0300
In-Reply-To: <20200702150552.9734-1-alessio.bonfiglio@mail.polimi.it> (Alessio
        Bonfiglio's message of "Thu, 2 Jul 2020 17:05:52 +0200")
Message-ID: <87imeqcwbt.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it> writes:

> Fix the regression introduced by commit c8685937d07f ("iwlwifi: move pu devices to new table") by add the ids and the configurations of two missing Killer 1550 cards in order to make these cards being configured and working correctly again (following the new table convention).
> Resolve bug 208141 ("Wireless ac 9560 not working kernel 5.7.2", https://bugzilla.kernel.org/show_bug.cgi?id=208141).

Max 72 chars per line, please word wrap your commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
