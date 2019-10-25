Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5965AE4532
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437721AbfJYIFH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 04:05:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437690AbfJYIFH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 04:05:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8930260EC7; Fri, 25 Oct 2019 08:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571990706;
        bh=EIKJA5d4pKdF5zL1wI2IS/dnsr0D4a012iLGkQujEMg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=McrQfKeM/B2UWo0dgvx42nzsRSVE2l0JLEQd/SQ468Afi5EuKXHykMN4aVzHRyLk5
         znfv3tYx0udGMd5d0sykP8pJ0OWntH7Itr79eCuAjlV8i7g0RBXQ1xc78Fyj1lJuAM
         gsHgWMLu8QV39VXiXxGMDnSU9J8ePvpgYw7cR1HM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7ADD260FEC;
        Fri, 25 Oct 2019 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571990699;
        bh=EIKJA5d4pKdF5zL1wI2IS/dnsr0D4a012iLGkQujEMg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=etb0wMznvFunUkJIXLcedWVVXuAsq7bG2pv4Hn6s1uqsj8INfJjo3YauHTtktQeae
         1w2qnuTWwpsgTea7XsdxAxxigpZg0pUnLaEE8JoTpi2oWjvcX+4v8EcMODkmKou4jP
         pL+aZUb5zOG0IMXUKWPh9OFX8Z6dQJE7LQTmNkVs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7ADD260FEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 07/12] iwlwifi: mvm: don't skip mgmt tid when flushing all tids
References: <20191020085545.16407-1-luca@coelho.fi>
        <20191020085545.16407-6-luca@coelho.fi>
Date:   Fri, 25 Oct 2019 11:04:56 +0300
In-Reply-To: <20191020085545.16407-6-luca@coelho.fi> (Luca Coelho's message of
        "Sun, 20 Oct 2019 11:55:40 +0300")
Message-ID: <87r231p7x3.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Haim Dreyfuss <haim.dreyfuss@intel.com>
>
> There are various of flows which require tids flushing
> (disconnection, suspend, etc...).
> Currently, when the driver instructs the FW to flush
> he masks all the data tids(0-7).
> However, the driver doesn't set the management tid (#15)
> which cause the FW not to flush it.
> When the FW tries to remove the mgmt queue he throws an assert
> since it is not an empty queue.
> instead of just set only the data tids set everything and let
> the FW ignore the invalid tids.
>
> Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> -		ret = iwl_mvm_flush_sta_tids(mvm, flush_arg, 0xFF, 0) ? : count;
> +		ret = iwl_mvm_flush_sta_tids(mvm, flush_arg, 0xFFFF, 0)

[...]

> -			iwl_mvm_flush_sta_tids(mvm, i, 0xFF, 0);
> +			iwl_mvm_flush_sta_tids(mvm, i, 0xFFFF, 0);

[...]

> -					      0xff | BIT(IWL_MGMT_TID), flags);
> +					      0xffff, flags);

If, instead of magic values, you had a proper define this would be a
simple change. Hint hint ;)

No need to change anything, but something to keep in mind.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
