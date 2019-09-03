Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3639CA674E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICLXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 07:23:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICLXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 07:23:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0EF47607EB; Tue,  3 Sep 2019 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567509788;
        bh=+0GSJRGo/VGsw92g9gSguOhxwGfoTqD1xv49AXXZK20=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FXqViNqrIJD4gh5V7ff9/e+ZLK4h7taDUJ0elMtUjRwUiwRah7Y1/rh/gFFHOfBfT
         nW3IpThaULvzeNx5nQUJOBON98B/cI9DvgzSPc7iHIFLMCeOnzWsxErVUjlzYBRKb+
         QRqNuu6OOf4KR6Uh7qfvwM52nPzQ0dNA/E2TznVQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEF68602A9;
        Tue,  3 Sep 2019 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567509787;
        bh=+0GSJRGo/VGsw92g9gSguOhxwGfoTqD1xv49AXXZK20=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CBn3hqcSxFwVgc9+dFyN7uQ1y2l1aDSsV0i60tL5LUy/gIqV8eWPl56y1wRYrldEi
         mlE0TaOOIs4HhUvzGxmshNUnVyoTNk8XC44mLx0bNok5yFDn04JrJWlejq7nDfYz23
         /fwyCBEqhOyjdR1llX8ma/lxTm5g8hRSXamr4vpM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEF68602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 01/18] iwlwifi: mvm: ftm: make common calib signed
References: <20190821133800.23636-1-luca@coelho.fi>
        <20190821133800.23636-2-luca@coelho.fi>
Date:   Tue, 03 Sep 2019 14:23:04 +0300
In-Reply-To: <20190821133800.23636-2-luca@coelho.fi> (Luca Coelho's message of
        "Wed, 21 Aug 2019 16:37:43 +0300")
Message-ID: <87woeppqsn.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Alex Malamud <alex.malamud@intel.com>
>
> The common calib value should be signed, so use int instead of u16.
>
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

[...]

> @@ -1993,6 +2027,9 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
>  #endif
>  	MVM_DEBUGFS_ADD_FILE(he_sniffer_params, mvm->debugfs_dir, 0600);
>  
> +	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_LTR_GEN2))
> +		MVM_DEBUGFS_ADD_FILE(ltr_config, mvm->debugfs_dir, 0200);

The commit log does not seem to match the code?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
