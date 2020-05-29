Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961951E856F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgE2Rna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:43:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18247 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2Rn3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:43:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590774209; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TbO+rBsr9Ixmjz1T+Z3h21qBvvXh+HJ7gGCh8PUYN4Q=;
 b=TakJsgiLT/8km68m36toPjDHwR9p4ym9w3n8/ivJtQvrSRmFWmUNd0lh90zrcxGIn33qsKO6
 sqyRKV3S8RZy2+S3VdYk2YhLMYwRTC+PLhQYQNIsfuJPAV1ERsI/91mxabx1c+nwhfZNCo9q
 AbU1Dkdi50C42N4iC41YyQ+4tlI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed149ba3131442d955b7432 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:43:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AAC06C433CB; Fri, 29 May 2020 17:43:21 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52D36C433CA;
        Fri, 29 May 2020 17:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52D36C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2020-05-29
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <28366747f660fca49a5abef38b8be1cd93af005d.camel@coelho.fi>
References: <28366747f660fca49a5abef38b8be1cd93af005d.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529174321.AAC06C433CB@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:43:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the third batch of patches intended for v5.8.  This includes
> the last patchset I sent out.  Usual development work.  More details
> about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 50ce4c099bebf56be86c9448f7f4bcd34f33663c:
> 
>   sctp: fix typo sctp_ulpevent_nofity_peer_addr_change (2020-05-27 15:08:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-05-29
> 
> for you to fetch changes up to e6d4318c049574dcfa040725903add2790cfbd7b:
> 
>   iwlwifi: bump FW API to 56 for AX devices (2020-05-29 10:32:46 +0300)
> 
> ----------------------------------------------------------------
> Third set of iwlwifi patches intended for v5.8
> 
> * Update range request API;
> * Add ACPI DSM support;
> * Support enabling 5.2GHz bands in Indonesia via ACPI;
> * Bump FW API version to 56;
> * TX queues refactoring started;
> * Fix one memory leak;
> * Some other small fixes and clean-ups;
> 
> ----------------------------------------------------------------
> Avraham Stern (1):
>       iwlwifi: mvm: add support for range request version 10
> 
> Gil Adam (2):
>       iwlwifi: acpi: support device specific method (DSM)
>       iwlwifi: acpi: evaluate dsm to enable 5.2 bands in Indonesia
> 
> Haim Dreyfuss (2):
>       iwlwifi: set NO_HE if the regulatory domain forbids it
>       iwlwifi: pcie: don't count on the FW to set persistence mode
> 
> Johannes Berg (1):
>       iwlwifi: pcie: gen3: indicate 8k/12k RB size to device
> 
> Luca Coelho (1):
>       iwlwifi: bump FW API to 56 for AX devices
> 
> Mordechay Goodstein (3):
>       iwlwifi: pcie: keep trans instead of trans_pcie in iwl_txq
>       iwlwifi: move iwl_txq and substructures to a common trans header
>       iwlwifi: move txq-specific from trans_pcie to common trans
> 
> Sharon (1):
>       iwlwifi: mvm: fix aux station leak
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c               |  99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |  22 ++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/location.h       |  14 +++++-----
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  34 ++++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |  12 +++++++--
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         |   5 ++++
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h             | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |  42 +++++++++++++++++++++++++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c                |  43 ++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          |   5 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c               |  18 +++++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.h               |   6 ++---
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  10 ++++++-
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c        |   6 ++---
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h         | 121 ++-----------------------------------------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c               |   6 ++---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  11 ++++----
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |  47 +++++++++++++--------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c          |  70 +++++++++++++++++++++++--------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c               | 120 ++++++++++++++++++++++++++++++++++++++++++------------------------------------------
>  21 files changed, 524 insertions(+), 297 deletions(-)

Pulled, thanks.

6bb986e940dc Merge tag 'iwlwifi-next-for-kalle-2020-05-29' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/patch/11577945/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

