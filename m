Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C457D21ED44
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGNJyJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 05:54:09 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45341 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgGNJyJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 05:54:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594720448; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gYJPMD27Ece0VvwB1l0XVqKr/E+yxXw2Ofr2jXc1fsA=; b=EMbb+JNLblsBvXU36C4FTlp0hLV79hR12qc6Zy5S+H17TOMx//4HnWtdv15pCdQtERh1lNZB
 ATYV44isgAjafIxHZ6NX0Aaf/fp46FSSF/61ZC9Ps8W+AG1I3M9jdXtKxiqT5acS7ePcWDns
 vLtTkBSFBRJ5644qkU3J2BvKhCw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f0d80c010127684905ba057 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 09:54:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F240C433C8; Tue, 14 Jul 2020 09:54:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB0C3C433CA;
        Tue, 14 Jul 2020 09:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB0C3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Subject: Re: [PATCH v2] iwlwifi: Make some Killer Wireless-AC 1550 cards work again
References: <87imeqcwbt.fsf@tynnyri.adurom.net>
        <20200714091911.4442-1-alessio.bonfiglio@mail.polimi.it>
Date:   Tue, 14 Jul 2020 12:54:03 +0300
In-Reply-To: <20200714091911.4442-1-alessio.bonfiglio@mail.polimi.it> (Alessio
        Bonfiglio's message of "Tue, 14 Jul 2020 11:19:11 +0200")
Message-ID: <877dv6cthg.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it> writes:

> Fix the regression introduced by commit c8685937d07f ("iwlwifi: move
> pu devices to new table") by adding the ids and the configurations of
> two missing Killer 1550 cards in order to configure and let them work
> correctly again (following the new table convention).
> Resolve bug 208141 ("Wireless ac 9560 not working kernel 5.7.2",
> https://bugzilla.kernel.org/show_bug.cgi?id=208141).
>
> Fixes: c8685937d07f ("iwlwifi: move pu devices to new table")
> Signed-off-by: Alessio Bonfiglio <alessio.bonfiglio@mail.polimi.it>

Luca, should I take this to v5.8?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
