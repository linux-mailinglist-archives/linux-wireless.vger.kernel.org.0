Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9E2533A8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHZP12 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 11:27:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21692 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgHZP11 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 11:27:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598455646; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YnCDr3uEUo3ZVXmAwA0rgiN0TQLk30sZ/Rnd4akc0bY=; b=eWm+XGIAD70cYV7fQcNnlwCrHVW807g6JS1+OqKFP4vl3dFR8+sEeFdUcqqtHh8OBPtqBgZF
 dHughuSLup1LQ0zv64TKoqVw9LaGAYWsw60cOhddDpjv+P11iehPVEr/COL2sy4bFI1cX1Yg
 wC4/eujvgu65qjmXaiO1kOzMCMk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f467f5ea0b245e36fba4c22 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 15:27:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7BE36C433C6; Wed, 26 Aug 2020 15:27:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 215B5C433CA;
        Wed, 26 Aug 2020 15:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 215B5C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org
Subject: Re: [PATCH 00/36] wcn36xx: Add support for WCN3680 802.11ac
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
Date:   Wed, 26 Aug 2020 18:27:17 +0300
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 3 Aug 2020 04:10:56 +0100")
Message-ID: <87r1rt77hm.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> This series adds support for the 802.11ac data-rates available on the WCN3680.

To review 36 patches is just too much, so I'm going to take this in
smaller pieces.

In the future please limit the patchset size:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#maximum_of_7-12_patches_per_patchset

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
