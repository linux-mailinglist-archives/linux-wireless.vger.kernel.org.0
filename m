Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C833B1FE0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWRzI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 13:55:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24306 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWRzH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 13:55:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624470770; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jA8eTpeP5/RWer5hS2D03gGtYcX+XfUATmLR70N7ikk=;
 b=giZ7r3Z4aEAKYrd3J67H9FHdr4rF2qcDZcsHWUF/G+rYBYtokBKNeP8SBM42eNBj8Y9/G6cR
 aCIwusJiUsU7u94E10PO82+0mje3Qv+umOzHTtBwx1TArdXzFXMbwLFSFhdoQwzjX4GIBx/+
 xiRQEoV/sK3lgED7k5x94QJlMLY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60d374db638039e997263e2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 17:52:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA02AC43460; Wed, 23 Jun 2021 17:52:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B368C433F1;
        Wed, 23 Jun 2021 17:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B368C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2021-06-22
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <12cde492bacfa8ae6aa1f02d3c5a0dfa241ac576.camel@coelho.fi>
References: <12cde492bacfa8ae6aa1f02d3c5a0dfa241ac576.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210623175227.AA02AC43460@smtp.codeaurora.org>
Date:   Wed, 23 Jun 2021 17:52:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's my pull request for v5.14 with the four patchesets I sent
> earlier.  This is all normal development, new features, bugfixes and
> cleanups.  More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit adf6a0f8c0a656df3d29403f314bf3e0dbb2dd77:
> 
>   rtl8xxxu: avoid parsing short RX packet (2021-06-19 12:06:09 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-06-22
> 
> for you to fetch changes up to 4c59eac6ac434e08b65edd3d4bef41adfa90f58e:
> 
>   iwlwifi: bump FW API to 64 for AX devices (2021-06-22 16:57:58 +0300)
> 
> ----------------------------------------------------------------
> iwlwifi patches for v5.14
> 
> * Some robustness improvements in the PCI code;
> * Remove some duplicate and unused declarations;
> * Improve PNVM load robustness by increasing the timeout a bit;
> * Support for a new HW;
> * Suport for BIOS control of 11ax enablement in Russia;
> * Support UNII4 enablement from BIOS;
> * Support LMR feedback;
> * Fix in TWT;
> * Some fixes in IML (image loader) DMA handling;
> * Fixes in WoWLAN;
> * Updates in the WoWLAN FW commands;
> * Add one new device to the PCI ID lists;
> * Support reading PNVM from a UEFI variable;
> * Bump the supported FW API version;
> * Some other small fixes, clean-ups and improvements.
> 
> ----------------------------------------------------------------
> Abhishek Naik (1):
>       iwlwifi: mvm: Read acpi dsm to get unii4 enable/disable bitmap.
> 
> Avraham Stern (1):
>       iwlwifi: mvm: support LMR feedback
> 
> Emmanuel Grumbach (5):
>       iwlwifi: mvm: support LONG_GROUP for WOWLAN_GET_STATUSES version
>       iwlwifi: mvm: introduce iwl_proto_offload_cmd_v4
>       iwlwifi: mvm: update iwl_wowlan_patterns_cmd
>       iwlwifi: mvm: introduce iwl_wowlan_kek_kck_material_cmd_v4
>       iwlwifi: mvm: introduce iwl_wowlan_get_status_cmd
> 
> Harish Mitty (1):
>       iwlwifi: mvm: Call NMI instead of REPLY_ERROR
> 
> Ilan Peer (1):
>       iwlwifi: mvm: Explicitly stop session protection before unbinding
> 
> Johannes Berg (18):
>       iwlwifi: mvm: don't change band on bound PHY contexts
>       iwlwifi: pcie: handle pcim_iomap_table() failures better
>       iwlwifi: pcie: print interrupt number, not index
>       iwlwifi: pcie: remove CSR_HW_RF_ID_TYPE_CHIP_ID
>       iwlwifi: remove duplicate iwl_ax201_cfg_qu_hr declaration
>       iwlwifi: pcie: identify the RF module
>       iwlwifi: mvm: don't request SMPS in AP mode
>       iwlwifi: mvm: apply RX diversity per PHY context
>       iwlwifi: mvm: honour firmware SMPS requests
>       iwlwifi: correct HE capabilities
>       iwlwifi: pcie: fix some kernel-doc comments
>       iwlwifi: pcie: remove TR/CR tail allocations
>       iwlwifi: pcie: free IML DMA memory allocation
>       iwlwifi: pcie: fix context info freeing
>       iwlwifi: mvm: fill phy_data.d1 for no-data RX
>       iwlwifi: pcie: free some DMA memory earlier
>       iwlwifi: move error dump to fw utils
>       iwlwifi: fw: dump TCM error table if present
> 
> Luca Coelho (8):
>       iwlwifi: mvm: pass the clock type to iwl_mvm_get_sync_time()
>       iwlwifi: mvm: fix indentation in some scan functions
>       iwlwifi: remove unused REMOTE_WAKE_CONFIG_CMD definitions
>       iwlwifi: increase PNVM load timeout
>       iwlwifi: fix NUM_IWL_UCODE_TLV_* definitions to avoid sparse errors
>       iwlwifi: move UEFI code to a separate file
>       iwlwifi: support loading the reduced power table from UEFI
>       iwlwifi: bump FW API to 64 for AX devices
> 
> Matti Gottlieb (1):
>       iwlwifi: pcie: Add support for AX231 radio module with Ma devices
> 
> Miri Korenblit (1):
>       iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia
> 
> Mukesh Sisodiya (1):
>       iwlwifi: yoyo: support region TLV version 2
> 
> Naftali Goldstein (2):
>       iwlwifi: mvm: don't request mac80211 to disable/enable sta's queues
>       iwlwifi: support ver 6 of WOWLAN_CONFIGURATION and ver 10 of WOWLAN_GET_STATUSES
> 
> Shaul Triebitz (2):
>       iwlwifi: mvm: fix error print when session protection ends
>       iwlwifi: advertise broadcast TWT support
> 
> ybaruch (1):
>       iwlwifi: add 9560 killer device
> 
>  drivers/net/wireless/intel/iwlwifi/Makefile                |   3 +-
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |  16 +++-
>  drivers/net/wireless/intel/iwlwifi/cfg/9000.c              |   6 +-
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c               |  50 ++++++++---
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |  10 +++
>  drivers/net/wireless/intel/iwlwifi/fw/api/commands.h       |   5 --
>  drivers/net/wireless/intel/iwlwifi/fw/api/d3.h             | 110 ++++++++++++------------
>  drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h       |  26 ++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h        |   3 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  19 +++++
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c                |  47 ++---------
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.h                |   4 +-
>  drivers/net/wireless/intel/iwlwifi/fw/dump.c               | 418 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/file.h               |  25 ++++--
>  drivers/net/wireless/intel/iwlwifi/fw/pnvm.c               | 120 +++++++++-----------------
>  drivers/net/wireless/intel/iwlwifi/fw/pnvm.h               |   4 +-
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.c               | 262 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h               |  42 ++++++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h            |   6 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |  20 ++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-csr.h               |   5 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c           |  13 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  11 +++
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         | 138 ++++++++++++++++++------------
>  drivers/net/wireless/intel/iwlwifi/iwl-prph.h              |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h             |  20 +++++
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c                | 118 ++++++++++++++++++--------
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c       |   4 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c           |   4 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |   9 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c                |  44 +++++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          |  25 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h               |  20 ++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/offloading.c        |  26 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c               |  40 ++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c          |  26 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c              |  10 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c              |  14 ++--
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c               |   8 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/time-event.c        |  45 +++++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/utils.c             | 357 +++++++----------------------------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  90 +++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c              |  19 +++--
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h         |  24 +++---
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c               |  34 --------
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  78 ++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |  39 ++++++++-
>  47 files changed, 1637 insertions(+), 784 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dump.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/uefi.c
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/uefi.h

Pulled, thanks.

559c664751e5 Merge tag 'iwlwifi-next-for-kalle-2021-06-22' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/12cde492bacfa8ae6aa1f02d3c5a0dfa241ac576.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

