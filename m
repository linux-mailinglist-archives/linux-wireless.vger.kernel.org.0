Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822111F99AA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgFOOKP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 10:10:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56297 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgFOOKO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 10:10:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592230213; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1Pf8qgDlo60ZypqXv8y3V9WbP4WNZCQp59/VV7KR3EI=;
 b=bw1TSdEeWjtN/fRBNnmf/Oul+JfpjpcfGotU01BBc//EA3pMrvRRD1oXsSGjXTdiV+8d+P76
 peeDg3oS/ojkEvca/pPNM1A9/uFaxdcevHr6EfgPj1mYnEkTVqKM37Pg3QP2U+iebPzzJb3o
 BEkzMuWEP40EiyqKyOPc6Az+SJU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee7813bad153efa349428a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 14:10:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32F7FC433CB; Mon, 15 Jun 2020 14:10:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26519C433CA;
        Mon, 15 Jun 2020 14:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26519C433CA
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
Message-Id: <20200615141003.32F7FC433CB@smtp.codeaurora.org>
Date:   Mon, 15 Jun 2020 14:10:03 +0000 (UTC)
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

I'll queue this for v5.8.

-- 
https://patchwork.kernel.org/patch/11472099/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

