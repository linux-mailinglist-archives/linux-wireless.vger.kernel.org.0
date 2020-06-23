Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E24204C47
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 10:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgFWIZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 04:25:35 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33784 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731567AbgFWIZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 04:25:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592900734; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kvKztOVhw3WKwnQObTGy6hSQ7A2Ou8m97lYsp9h8S9M=;
 b=YtzOeEXU3Bf66x5luIUy9T+w12XQ3x9o7n1njU7rXNxqIzdCBR9BMVFvlWowH1qbJecDFkWs
 MMMJavzKlFzI3Fzk2CbjVpQRMDFJMxOSifUgdGdHauHzmlvQmgGB989Mm4LE2DdfZBoMskv+
 1rJ0nvIwPhLGNZLX6r1YfyaNLyA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ef1bc73fe1db4db89cbb4fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 08:25:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A522CC433C6; Tue, 23 Jun 2020 08:25:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAB76C433C8;
        Tue, 23 Jun 2020 08:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAB76C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.7 8/8] iwlwifi: mvm: don't call
 iwl_mvm_free_inactive_queue() under RCU
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
References: <iwlwifi.20200403112332.0f49448c133d.I17fd308bc4a9491859c9b112f4eb5d2c3fc18d7d@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200623082523.A522CC433C6@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 08:25:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> iwl_mvm_free_inactive_queue() will sleep in synchronize_net() under
> some circumstances, so don't call it under RCU. There doesn't appear
> to be a need for RCU protection around this particular call.
> 
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

fbb1461ad1d6 iwlwifi: mvm: don't call iwl_mvm_free_inactive_queue() under RCU

-- 
https://patchwork.kernel.org/patch/11472099/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

