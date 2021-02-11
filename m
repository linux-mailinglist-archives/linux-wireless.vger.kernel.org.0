Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81483319273
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBKSoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 13:44:19 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:43488 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhBKSoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 13:44:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613069023; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cQptLyON9U2G+vRnI2tsRBaLld38NhT8NGEZR/ysDU0=;
 b=ivr3Ki/rG+mXBe+U1AiTM1xNVbybQRjE2r/ayqIRvK/T+HcOIJUFrxW2LkV2/2k2yC00iroW
 Yssgx1R6TyC3RzMX7S8TrlKxoR6pE0t3/XEH5iJug8fT1zO9+Fk9f3tqwEO0leEqb8HYXiN/
 CK+P9BgwK6WQpFDB3l4xhEdgOkY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60257ac534db06ef799c799e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 18:43:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9B7AC433C6; Thu, 11 Feb 2021 18:43:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FEA4C433ED;
        Thu, 11 Feb 2021 18:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FEA4C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2021-02-10
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <8fc242539c12e702080789efd0e2f333d2c13bfd.camel@coelho.fi>
References: <8fc242539c12e702080789efd0e2f333d2c13bfd.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210211184316.A9B7AC433C6@smtp.codeaurora.org>
Date:   Thu, 11 Feb 2021 18:43:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the second batch of patches intended for v5.12.  This includes
> the four last patchsets I sent out for v5.12.  Usual development work.
> More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 8e79106a7dbbfcb9e87644d0ee1d038670fba844:
> 
>   rtlwifi: rtl8821ae: phy: Simplify bool comparison (2021-02-10 09:39:35 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-02-10
> 
> for you to fetch changes up to 000735e5dbbb739ca3742413858c1d9cac899e10:
> 
>   iwlwifi: bump FW API to 62 for AX devices (2021-02-11 01:58:23 +0200)
> 
> ----------------------------------------------------------------
> Second set of iwlwifi patches intended for v5.12
> 
> * Add some device IDs that got lost in a rebase;
> * A bunch of fixes in the PPAG code;
> * A few fixes in the debugging framework;
> * Fix a couple of potential crashes in error paths;
> * More HW IDs for new HW;
> * Add one more value to the device configuration code;
> * Support new scan config FW API;
> * Some more CSA fixes;
> * Support for RF interference mitigation (RFI);
> * Improvements in the NVM flows;
> * Bump the FW API support version;
> * Implement support for PNVM from BIOS;
> * Fix PM status when a FW crash happens;
> * Some other small fixes, clean-ups and improvements.
> 
> ----------------------------------------------------------------
> Abhishek Naik (1):
>       iwlwifi: mvm: Check ret code for iwl_mvm_load_nvm_to_nic
> 
> Emmanuel Grumbach (7):
>       iwlwifi: mvm: enhance a print in CSA flows
>       iwlwifi: pcie: NULLify pointers after free
>       iwlwifi: pcie: don't crash when rx queues aren't allocated in interrupt
>       iwlwifi: mvm: register to mac80211 last
>       iwlwifi: mvm: simplify iwl_mvm_dbgfs_register
>       iwlwifi: mvm: isolate the get nvm flow
>       iwlwifi: mvm: get NVM later in the mvm_start flow
> 
> Golan Ben Ami (1):
>       iwlwifi: mvm: reduce the print severity of failing getting NIC temp
> 
> Gregory Greenman (2):
>       iwlwifi: mvm: add RFI-M support
>       iwlwifi: acpi: add support for DSM RFI
> 
> Haim Dreyfuss (1):
>       iwlwifi: acpi: don't return valid pointer as an ERR_PTR
> 
> Ihab Zhaika (1):
>       iwlwifi: add new cards for So and Qu family
> 
> Ilan Peer (1):
>       iwlwifi: mvm: Support SCAN_CFG_CMD version 5
> 
> Johannes Berg (6):
>       iwlwifi: pcie: don't disable interrupts for reg_lock
>       iwlwifi: mvm: remove useless iwl_mvm_resume_d3() function
>       iwlwifi: api: clean up some documentation/bits
>       iwlwifi: remove flags argument for nic_access
>       iwlwifi: remove max_vht_ampdu_exponent config parameter
>       iwlwifi: remove max_ht_ampdu_exponent config parameter
> 
> Luca Coelho (11):
>       iwlwifi: pcie: add a few missing entries for So with Hr
>       iwlwifi: acpi: fix PPAG table sizes
>       iwlwifi: mvm: fix the type we use in the PPAG table validity checks
>       iwlwifi: mvm: store PPAG enabled/disabled flag properly
>       iwlwifi: mvm: send stored PPAG command instead of local
>       iwlwifi: mvm: assign SAR table revision to the command later
>       iwlwifi: pnvm: set the PNVM again if it was already loaded
>       iwlwifi: pnvm: increment the pointer before checking the TLV
>       iwlwifi: pnvm: move file loading code to a separate function
>       iwlwifi: pnvm: implement reading PNVM from UEFI
>       iwlwifi: bump FW API to 62 for AX devices
> 
> Matti Gottlieb (4):
>       iwlwifi: pcie: Change Ma device ID
>       iwlwifi: pcie: add CDB bit to the device configuration parsing
>       iwlwifi: pcie: add AX201 and AX211 radio modules for Ma devices
>       iwlwifi: pcie: define FW_RESET_TIMEOUT for clarity
> 
> Miri Korenblit (1):
>       iwlwifi:mvm: Add support for version 2 of the LARI_CONFIG_CHANGE command.
> 
> Mordechay Goodstein (4):
>       iwlwifi: when HW has rate offload don't look at control field
>       iwlwifi: dbg: remove unsupported regions
>       iwlwifi: dbg: add op_mode callback for collecting debug data.
>       iwlwifi: queue: add fake tx time point
> 
> Mukesh Sisodiya (1):
>       iwlwifi: correction of group-id once sending REPLY_ERROR
> 
> Naftali Goldstein (1):
>       iwlwifi: declare support for triggered SU/MU beamforming feedback
> 
> Ravi Darsi (1):
>       iwlwifi: mvm: global PM mode does not reset after FW crash
> 
> Sara Sharon (1):
>       iwlwifi: mvm: don't check if CSA event is running before removing
> 
> Shaul Triebitz (1):
>       iwlmvm: set properly NIC_NOT_ACK_ENABLED flag
> 
> Takashi Iwai (1):
>       iwlwifi: dbg: Mark ucode tlv data as const
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/1000.c            |   8 ++--
>  drivers/net/wireless/intel/iwlwifi/cfg/2000.c            |  14 +++----
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |  43 ++++++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/cfg/5000.c            |   8 ++--
>  drivers/net/wireless/intel/iwlwifi/cfg/6000.c            |  20 ++++------
>  drivers/net/wireless/intel/iwlwifi/cfg/7000.c            |   3 +-
>  drivers/net/wireless/intel/iwlwifi/cfg/8000.c            |   6 +--
>  drivers/net/wireless/intel/iwlwifi/cfg/9000.c            |   1 -
>  drivers/net/wireless/intel/iwlwifi/dvm/main.c            |  10 ++---
>  drivers/net/wireless/intel/iwlwifi/dvm/tt.c              |   7 ++--
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c             |  50 ++++++++++++++++++------
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h             |  24 +++++++++---
>  drivers/net/wireless/intel/iwlwifi/fw/api/commands.h     |  12 +++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/location.h     |   7 +++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/mac.h          |   5 +++
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h      |  15 +++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h          |  60 +++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |   5 ++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h           |   4 +-
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |  54 ++++++++++++--------------
>  drivers/net/wireless/intel/iwlwifi/fw/file.h             |   1 +
>  drivers/net/wireless/intel/iwlwifi/fw/pnvm.c             | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  14 ++++---
>  drivers/net/wireless/intel/iwlwifi/iwl-csr.h             |   2 +
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  86 ++++++++++++++++++++++++++++++------------
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h         |   6 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |   2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c    |   2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-io.c              |  46 +++++++++--------------
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |   6 +--
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h       |   1 +
>  drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h         |  14 ++++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.c           |   7 +++-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |  14 +++----
>  drivers/net/wireless/intel/iwlwifi/mvm/Makefile          |   1 +
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |   8 +---
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c         |  90 +++++++++++++++++++++++++++++++++++++-------
>  drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h          |   3 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c              | 116 +++++++++++++++++++++++++++++++++++++++++++-------------
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |  19 +++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |  15 ++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  79 +++++++++++++++++++++++++++-----------
>  drivers/net/wireless/intel/iwlwifi/mvm/rfi.c             | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  14 ++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/time-event.c      |   3 --
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c              |   2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c              |  22 ++++++-----
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  21 ++++++-----
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c            | 188 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c             |  16 +++++---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c     |   8 +++-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c          |  54 +++++++++++++-------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |   5 +--
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c             |  27 ++++++-------
>  drivers/net/wireless/intel/iwlwifi/queue/tx.c            |   4 ++
>  55 files changed, 1116 insertions(+), 444 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c

Pulled, thanks.

30357f6a47e0 Merge tag 'iwlwifi-next-for-kalle-2021-02-10' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8fc242539c12e702080789efd0e2f333d2c13bfd.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

