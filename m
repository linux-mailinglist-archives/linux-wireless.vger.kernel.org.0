Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC901B64F5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfIRNpE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 09:45:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfIRNpD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 09:45:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C252660364; Wed, 18 Sep 2019 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568814302;
        bh=eGY3eld6Fw7wIMSHDmpahPNMKGlKeflNpx89TJV5ceQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZDOoxBstxJ37Hxm21UqIlWr/RuflPElsROpaJxmVz9sOmJVAq9DJ3N5Y8bWJnhp8+
         x7iTT+ewqAocFoYfea2sjOAV4tjPS2y63k0+fvJ9EhQCoACo7C5wqpKBM0oKz2zzWh
         tX+eSVtsHSPPGpetBS5Or85CzbMCT3YJ+tsN5It0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DE126133A;
        Wed, 18 Sep 2019 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568814302;
        bh=eGY3eld6Fw7wIMSHDmpahPNMKGlKeflNpx89TJV5ceQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=CNhjcR2uPZ/2TglrDOcGV39aZjs7u4Evh5Cx8p4J60NCrgMGFxfiPeYGvkoE6pi0q
         6i3N1uuPI8g52rHNnIvVMypT76ht4MOxae0zFfdvXeCOZfNOmiO4LdYcMSWkSTyih4
         Z9Jop5zpDgBPmAL8JS9XOeTcYgedt13/ON6rhF6A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DE126133A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: correct wmi_tlv command params to enable
 pktlog for WCN3990
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1558087516-666-3-git-send-email-aambure@codeaurora.org>
References: <1558087516-666-3-git-send-email-aambure@codeaurora.org>
To:     Abhishek Ambure <aambure@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Abhishek Ambure <aambure@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190918134502.C252660364@smtp.codeaurora.org>
Date:   Wed, 18 Sep 2019 13:45:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Abhishek Ambure <aambure@codeaurora.org> wrote:

> PKT log enable command expects pdev id in enable params which is missing
> in current configuration. Fill pdev id in pkt log enable wmi command for
> correct configuration.
> 
> Fixes: ca996ec56608 ("ath10k: implement wmi-tlv backend")
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00963-QCAHLSWMTPL-1
> 
> Signed-off-by: Abhishek Ambure <aambure@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

How do I know this doesn't break QCA6174/QCA9377?

-- 
https://patchwork.kernel.org/patch/10947635/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

