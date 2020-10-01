Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED442807A9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbgJATXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:23:39 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:37163 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgJATXj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:23:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601580218; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ycRtdUp0FKZyQR37ZZrumKL04v5JcjkVqgZXS1ZHWsA=;
 b=FqiiPqytuI32vqhzNt6vOCCRANkd7nliVfyatRUiql9vdExx20Vj/xWFefF+eAYPW9cybSEJ
 wD/IDHSXmgYKiAsZ4+7ZIzRDn6dkSjzNFLDm0/89sf92Mn+VLhH5lMOdH4VrIAk1Q657WcC6
 UBWukqf5WGa1uXfGC6OpE0RFvrw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f762cb97df1a00ff811c586 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:23:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9F2F9C433F1; Thu,  1 Oct 2020 19:23:36 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21852C433CA;
        Thu,  1 Oct 2020 19:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21852C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2020-09-30-2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <37fbfd7f89c31b39c4eb9a72e9729c71834c0ba0.camel@coelho.fi>
References: <37fbfd7f89c31b39c4eb9a72e9729c71834c0ba0.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001192336.9F2F9C433F1@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 19:23:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the first batch of patches intended for v5.10.  This includes all
> the patchsets I sent out for v5.10.  Usual development work.  More
> details about the contents in the tag description.
> 
> In this new version the change-id's are removed and Link tags are added instea
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 1d2a85382282e7c77cbde5650335c3ffc6073fa1:
> 
>   wl3501_cs: Remove unnecessary NULL check (2020-09-29 11:25:30 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-09-30-2
> 
> for you to fetch changes up to 870f39bc9deb07024ed5afccdb03f91c6c104d4e:
> 
>   iwlwifi: bump FW API to 57 for AX devices (2020-10-01 22:02:29 +0300)
> 
> ----------------------------------------------------------------
> iwlwifi patches intended for v5.10
> 
> * Protected TWT implementation;
> * Support disabling 5.8GHz channels via ACPI;
> * Support VHT extended NSS capability;
> * A few fixes in the datapath;
> * Enable TWT by default;
> * Support new PPAG FW command version
> * Move some trans code around for better abstraction;
> * Some clean-ups in the ACPI code;
> * A fix for AP mode;
> * Updates in the ACPI code to support new tables and FW versions;
> * FTM updates;
> * A bit of reorganiztion in the queue code;
> * A few debugging infra improvements;
> * Add support for new GTK rekeying;
> * A fix in the scanning code;
> * Support for some new cards;
> * Some updates for new or changed FW APIs;
> * Some new FW API command version implementations;
> * Some other small fixes and clean-ups;
> 
> ----------------------------------------------------------------
> Andrei Otcheretianski (2):
>       iwlwifi: mvm: Don't install CMAC/GMAC key in AP mode
>       iwlwifi: use correct group for alive notification
> 
> Avraham Stern (7):
>       iwlwifi: mvm: add an option to add PASN station
>       iwlwifi: mvm: add support for range request command ver 11
>       iwlwifi: mvm: add support for responder dynamic config command version 3
>       iwlwifi: mvm: location: set the HLTK when PASN station is added
>       iwlwifi: mvm: responder: allow to set only the HLTK for an associated station
>       iwlwifi: mvm: initiator: add option for adding a PASN responder
>       iwlwifi: mvm: ignore the scan duration parameter
> 
> Ayala Beker (1):
>       iwlwifi: mvm: clear all scan UIDs
> 
> Dan Halperin (2):
>       iwlwifi: mvm: add support for new version of WOWLAN_TKIP_SETTING_API_S
>       iwlwifi: mvm: add support for new WOWLAN_TSC_RSC_PARAM version
> 
> Emmanuel Grumbach (1):
>       iwlwifi: mvm: split a print to avoid a WARNING in ROC
> 
> Gil Adam (4):
>       iwlwifi: acpi: evaluate dsm to disable 5.8GHz channels
>       iwlwifi: acpi: support ppag table command v2
>       iwlwifi: regulatory: regulatory capabilities api change
>       iwlwifi: thermal: support new temperature measurement API
> 
> Golan Ben Ami (1):
>       iwlwifi: enable twt by default
> 
> Ihab Zhaika (2):
>       iwlwifi: add new cards for AX201 family
>       iwlwifi: add new cards for MA family
> 
> Ilan Peer (1):
>       iwlwifi: mvm: Add FTM initiator RTT smoothing logic
> 
> Johannes Berg (6):
>       iwlwifi: mvm: rs-fw: handle VHT extended NSS capability
>       iwlwifi: mvm: use CHECKSUM_COMPLETE
>       iwlwifi: mvm: d3: support GCMP ciphers
>       iwlwifi: align RX status flags with firmware
>       iwlwifi: mvm: d3: parse wowlan status version 11
>       iwlwifi: api: fix u32 -> __le32
> 
> Luca Coelho (12):
>       iwlwifi: dbg: remove IWL_FW_INI_TIME_POINT_WDG_TIMEOUT
>       iwlwifi: don't export acpi functions unnecessarily
>       iwlwifi: remove iwl_validate_sar_geo_profile() export
>       iwlwifi: acpi: remove dummy definition of iwl_sar_set_profile()
>       iwlwifi: add a common struct for all iwl_tx_power_cmd versions
>       iwlwifi: acpi: prepare SAR profile selection code for multiple sizes
>       iwlwifi: support REDUCE_TX_POWER_CMD version 6
>       iwlwifi: acpi: rename geo structs to contain versioning
>       iwlwifi: support version 3 of GEO_TX_POWER_LIMIT
>       iwlwifi: mvm: remove redundant log in iwl_mvm_tvqm_enable_txq()
>       iwlwifi: support version 5 of the alive notification
>       iwlwifi: bump FW API to 57 for AX devices
> 
> Mordechay Goodstein (22):
>       iwlwifi: sta: defer ADDBA transmit in case reclaimed SN != next SN
>       iwlwifi: msix: limit max RX queues for 9000 family
>       iwlwifi: wowlan: adapt to wowlan status API version 10
>       iwlwifi: fw: move assert descriptor parser to common code
>       iwlwifi: iwl-trans: move all txcmd init to trans alloc
>       iwlwifi: move bc_pool to a common trans header
>       iwlwifi: iwl-trans: move tfd to trans layer
>       iwlwifi: move bc_table_dword to a common trans header
>       iwlwifi: dbg: add dumping special device memory
>       iwl-trans: move dev_cmd_offs, page_offs to a common trans header
>       iwlwifi: mvm: remove redundant support_umac_log field
>       iwlwifi: rs: set RTS protection for all non legacy rates
>       iwlwifi: acpi: in non acpi compilations remove iwl_sar_geo_init
>       iwlwifi: fw: add default value for iwl_fw_lookup_cmd_ver
>       iwlwifi: remove wide_cmd_header field
>       iwlwifi: move all bus-independent TX functions to common code
>       iwlwifi: dbg: remove no filter condition
>       iwlwifi: dbg: run init_cfg function once per driver load
>       iwlwifi: phy-ctxt: add new API VER 3 for phy context cmd
>       iwlwifi: pcie: make iwl_pcie_txq_update_byte_cnt_tbl bus independent
>       iwlwifi: dbg: add debug host notification (DHN) time point
>       iwlwifi: yoyo: add support for internal buffer allocation in D3
> 
> Naftali Goldstein (1):
>       iwlwifi: mvm: process ba-notifications also when sta rcu is invalid
> 
> Nathan Errera (2):
>       iwlwifi: mvm: support new KEK KCK api
>       iwlwifi: mvm: support more GTK rekeying algorithms
> 
> Roee Goldfiner (1):
>       iwlwifi: add new card for MA family
> 
> Sara Sharon (1):
>       iwlwifi: mvm: add d3 prints
> 
> Shaul Triebitz (3):
>       iwlwifi: mvm: add PROTECTED_TWT firmware API
>       iwlwifi: mvm: set PROTECTED_TWT in MAC data policy
>       iwlwifi: mvm: set PROTECTED_TWT feature if supported by firmware
> 
>  drivers/net/wireless/intel/iwlwifi/Makefile            |    1 +
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |   68 ++++-
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |   72 ++---
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |   58 ++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/alive.h      |   25 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/commands.h   |   10 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/d3.h         |   82 ++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   32 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/location.h   |  231 +++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/mac.h        |   16 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |   32 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/phy.h        |   13 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/power.h      |  133 ++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/rs.h         |   11 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |   29 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h         |    7 +-
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |   56 ++++
>  drivers/net/wireless/intel/iwlwifi/fw/error-dump.h     |   14 +
>  drivers/net/wireless/intel/iwlwifi/fw/file.h           |    3 +-
>  drivers/net/wireless/intel/iwlwifi/fw/img.c            |   55 +++-
>  drivers/net/wireless/intel/iwlwifi/fw/img.h            |    8 +-
>  drivers/net/wireless/intel/iwlwifi/fw/init.c           |    3 +-
>  drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |    3 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h        |   13 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |   26 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-debug.h         |    6 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |   98 +++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h     |    2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |   78 ++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |   34 ++-
>  drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |    8 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  273 ++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  363 ++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |  205 ++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  356 +++++++++++++++-------
>  drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c      |   12 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |   64 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   51 +++-
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |   18 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c      |  126 +++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |   24 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |    6 +
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |   85 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c          |   70 ++---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |   53 +++-
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.h           |    3 +
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c            |   78 ++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |   77 +++--
>  drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |   46 +--
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    2 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c          |   34 ++-
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |  158 +---------
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |    2 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    4 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  132 ++------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      | 1089 +----------------------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  535 ++++----------------------------
>  drivers/net/wireless/intel/iwlwifi/queue/tx.c          | 1529 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/queue/tx.h          |  230 ++++++++++++++
>  59 files changed, 4358 insertions(+), 2494 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h

Pulled, thanks.

855f69fc05a1 Merge tag 'iwlwifi-next-for-kalle-2020-09-30-2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/patch/11812357/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

