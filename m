Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26099181D9B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgCKQR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:17:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:62409 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730052AbgCKQR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:17:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583943478; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=A4S8vhG4vJWdvWAwY8Q7gjpUv9pC8Paapqg5gbTuHv8=;
 b=baiZIfAOiQOV6pirq76eNFAJ9sEKVHldN3qC/K1xsemjYLYjzRzqGkvfNV6EY6LgzMT/RzKr
 i/ePoLXzQsM5yaS8jLu8Hmrz+1dea76Bvvg862k9SoVC5T7G8VP1ubUGIuGyBC0yckervXuy
 TorfQznsYScSbAWhHkpnUeB/l7I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e690f22.7f9b50c03a40-smtp-out-n02;
 Wed, 11 Mar 2020 16:17:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE683C43636; Wed, 11 Mar 2020 16:17:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BE16C433CB;
        Wed, 11 Mar 2020 16:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BE16C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 2/2] ath11k: Perform per-msdu rx processing
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1581908873-14749-3-git-send-email-srirrama@codeaurora.org>
References: <1581908873-14749-3-git-send-email-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Tamizh Chelvam Raja <tamizhr@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311161738.BE683C43636@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:17:38 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> As Hash based reo destination selection is configured,
> the decapped packets reach different reo destintion rings
> based on the destintaion ring selected for the computed hash (based on
> the 5-tuple {ip src/ip dst/src port/dst port/protocol}) by hw and
> as configured by driver.
> 
> Hence the current implementation of amsdu list based processing after all
> the subframes of amsdu are received (since all msdu's for a pdev are
> received in same reo dest ring), is not applicable here and hence is
> replaced with per msdu based handling as these subframes
> can be received in different reo dest rings.
> 
> Also, as some of the rx descriptor fields might be valid only for the
> first msdu (for ex. received 80211 header, encryption type, etc),
> it might not be useful now as we cannot sync between different
> subframes received in different rings. Hence do not rely on those
> fields and replace them with fieds valid only on per msdu descriptors.
> Also cache other details such as encryption type for a peer so that
> it can be reused when a packet is received from it.
> 
> Co-developed-by: Tamizh Chelvam Raja <tamizhr@codeaurora.org>
> Signed-off-by: Tamizh Chelvam Raja <tamizhr@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

New warnings:

drivers/net/wireless/ath/ath11k/dp_rx.c:2010: multiple assignments should be avoided
drivers/net/wireless/ath/ath11k/dp_rx.c:2160: Please don't use multiple blank lines

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/patch/11385033/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
