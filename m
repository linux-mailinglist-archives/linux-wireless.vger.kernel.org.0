Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7C1D1ACD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbgEMQQQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 12:16:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53655 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389486AbgEMQQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 12:16:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589386574; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=luXiI6BpFOBtdVmbMtnPN3o+rfZBF9PrkMebwllUVKM=;
 b=wqGWzRFotKjOiC49C65i6O1MJjvgrDabOJT2UU9Dl5NLxAfmIGE0Co4/CmhnhtAzl/dN+U/U
 EGx/RrhtANM+CHWs0cQZhf1ydBHumXzQdugwehbGEVu8dUBfH9yIxSRD81VyWFKUuUbCz35y
 gXAY4bG5+QPZvdZrPc8TjKk+sX4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc1d3b.7f10515b0df8-smtp-out-n01;
 Wed, 13 May 2020 16:15:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 089FFC433D2; Wed, 13 May 2020 16:15:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D2F9C433F2;
        Wed, 13 May 2020 16:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D2F9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2020-05-08
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <8d6ec060c5a7513bc2f9ad617455ec76e48ac6d6.camel@coelho.fi>
References: <8d6ec060c5a7513bc2f9ad617455ec76e48ac6d6.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200513161554.089FFC433D2@smtp.codeaurora.org>
Date:   Wed, 13 May 2020 16:15:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the second batch of patches intended for v5.8.  This includes
> the last three patchsets I sent out.  Usual development work.  More
> details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 790709f249728640faa4eff38286a9feb34fed81:
> 
>   net: relax SO_TXTIME CAP_NET_ADMIN check (2020-05-07 18:17:32 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-05-08
> 
> for you to fetch changes up to d3d2674cc6ff10e89bfbace7b943c09fb9052cca:
> 
>   iwlwifi: dbg_ini: differentiate ax210 hw with same hw type (2020-05-08 09:53:12 +0300)
> 
> ----------------------------------------------------------------
> Second set of iwlwifi patches intended for v5.8
> 
> * Support new FW APIs;
> * Remove some old and unused features;
> * HW configuration rework continues;
> * Some queues rework by Johannes;
> * Enable A-AMSDU in low  latency;
> * Some debugging fixes;
> * Some other small fixes and clean-ups;
> 
> ----------------------------------------------------------------
> Avraham Stern (1):
>       iwlwifi: mvm: add support for range request command version 9
> 
> Emmanuel Grumbach (4):
>       iwlwifi: remove antenna_coupling module parameter
>       iwlwifi: mvm: stop supporting swcrypto and bt_coex_active module parameters
>       iwlwifi: mvm: remove iwlmvm's tfd_q_hang_detect module parameter
>       iwlwifi: move iwl_set_soc_latency to iwl-drv to be used by other op_modes
> 
> Johannes Berg (10):
>       iwlwifi: fw api: fix PHY data 2/3 position
>       iwlwifi: pcie: allocate much smaller byte-count table
>       iwlwifi: mvm: attempt to allocate smaller queues
>       iwlwifi: dbg: mark a variable __maybe_unused
>       iwlwifi: pcie: remove some dead code
>       iwlwifi: pcie: gen2: use DMA pool for byte-count tables
>       iwlwifi: use longer queues for 256-BA
>       iwlwifi: mvm: don't transmit on unallocated queue
>       iwlwifi: remove outdated copyright print/module statement
>       iwlwifi: pcie: skip fragmented receive buffers
> 
> Liad Kaufman (1):
>       iwlwifi: dbg_ini: differentiate ax210 hw with same hw type
> 
> Luca Coelho (8):
>       iwlwifi: bump FW API to 55 for AX devices
>       iwlwifi: mvm: initialize iwl_dev_tx_power_cmd to zero
>       iwlwifi: mvm: add IML/ROM information to the assertion dumps
>       iwlwifi: pcie: remove outdated comment about PCI RTPM reference
>       iwlwifi: pcie: remove mangling for iwl_ax101_cfg_qu_hr
>       iwlwifi: pcie: convert QnJ with Hr to the device table
>       iwlwifi: pcie: remove occurrences of 22000 in the FW name defines
>       iwlwifi: pcie: convert all AX101 devices to the device tables
> 
> Mordechay Goodstein (8):
>       iwlwifi: yoyo: add support for parsing SHARED_MEM_ALLOC version 4
>       iwlwifi: yoyo: use hweight_long instead of bit manipulating
>       iwlwifi: yoyo: don't access TLV before verifying len
>       iwlwifi: avoid debug max amsdu config overwriting itself
>       iwlwifi: yoyo: add D3 resume timepoint
>       iwlwifi: yoyo: remove magic number
>       iwlwifi: dump api version in yaml format
>       iwlwifi: tx: enable A-MSDU in low latency mode
> 
> Shahar S Matityahu (1):
>       iwlwifi: dbg: set debug descriptor to NULL outside of iwl_fw_free_dump_desc
> 
> Shaul Triebitz (1):
>       iwlwifi: mvm: set properly station flags in STA_HE_CTXT_CMD
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c         | 104 ++++++++++++++++++++++++++++++++++++++++------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/dvm/dev.h           |   3 +--
>  drivers/net/wireless/intel/iwlwifi/dvm/main.c          |  11 ++--------
>  drivers/net/wireless/intel/iwlwifi/dvm/rs.c            |  11 +---------
>  drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   5 +++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/debug.h      |  14 ++++++------
>  drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |  14 ++++++------
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |  99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
>  drivers/net/wireless/intel/iwlwifi/fw/debugfs.c        | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/intel/iwlwifi/fw/error-dump.h     |  13 +++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/init.c           |  55 +++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   6 ++++--
>  drivers/net/wireless/intel/iwlwifi/fw/smem.c           |  14 ++++++++----
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  15 ++++++++-----
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |  44 ++++++++++++++++++-------------------
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |  14 +++---------
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.h           |   7 +++---
>  drivers/net/wireless/intel/iwlwifi/iwl-fh.h            |   7 +++---
>  drivers/net/wireless/intel/iwlwifi/iwl-modparams.h     |   8 ++-----
>  drivers/net/wireless/intel/iwlwifi/iwl-prph.h          |  11 +++++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/coex.c          |   7 +++---
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |  34 +++++++++++++----------------
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |  11 ++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  67 ++++++++++++++++++++++++++++++++++++++++++++++-----------
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c            |  53 ++++-----------------------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  56 +++++++++++++++++++++++------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   8 ++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  13 +++--------
>  drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  15 +++++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |  51 +++++++++++++++++++++++++++----------------
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c            |  11 ++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |  29 +++++++++++++++++++------
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 111 +++++++++++++++++++++++++++-------------------------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |   5 ++++-
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  32 ++++++++++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  19 ++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c      |  33 +++++++++++++++++++---------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  12 +++++------
>  39 files changed, 761 insertions(+), 475 deletions(-)

Pulled, thanks.

c73fb4d33e1d Merge tag 'iwlwifi-next-for-kalle-2020-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/patch/11535781/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
