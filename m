Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B31C34C6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEDIqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 04:46:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36227 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgEDIqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 04:46:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588581976; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Jz+pJvTLQ/HkY2YmqhaM2ISOFeDq6hV1i1J9IDhxmo0=;
 b=cW+6DrBb4TFiwH1bjbNdFemhCPHWsMGvN7NoVruTrYpjXjHO3jxMcmTjovt6onddQwXDBok9
 LwslaDnQIfO+6eZousJfOnfzQkrZdSKR2VIhH0O/H3eAfbnZJK+uIRwQLm0gzFphvtqf1gCx
 E+iZOvIecj8A4IVC+V0URWjLe00=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafd655.7fd360ec9810-smtp-out-n02;
 Mon, 04 May 2020 08:46:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8DDEC433BA; Mon,  4 May 2020 08:46:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EDB5C433D2;
        Mon,  4 May 2020 08:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EDB5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2020-04-24-2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <4e80b41b8fc03d435d13a9f4fe77d5555b0d7cf9.camel@coelho.fi>
References: <4e80b41b8fc03d435d13a9f4fe77d5555b0d7cf9.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504084612.B8DDEC433BA@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 08:46:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the first batch of patches intended for v5.8.  This includes
> the last two patchsets I sent out.  Usual development work.  More
> details about the contents in the tag description.
> 
> In v2 I replaced the "iwlwifi: move API version lookup to common code"
> patch with v2.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 75e69fb11b40ba1256b14f943c7050682c1f5458:
> 
>   rtw88: 8723d: initialize mac/bb/rf basic functions (2020-04-23 07:47:27 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-04-24-2
> 
> for you to fetch changes up to cbc636557d2d20c4fb808c14df545b3c407a53d6:
> 
>   iwlwifi: debug: set NPK buffer in context info (2020-04-24 16:38:12 +0300)
> 
> ----------------------------------------------------------------
> First set of iwlwifi patches intended for v5.8
> 
> * TX queue debugfs improvements;
> * Support for a few new FW API versions;
> * Remove deprecated scan FW API version;
> * New hw configs and other related changes;
> * Support for NPK buffers in debugging;
> * More debugging fetures;
> * Some other small fixes and clean-ups;
> 
> ----------------------------------------------------------------
> Emmanuel Grumbach (1):
>       iwlwifi: remove fw_monitor module parameter
> 
> Gil Adam (2):
>       iwlwifi: mvm: add framework for specific phy configuration
>       iwlwifi: debug: set NPK buffer in context info
> 
> Ihab Zhaika (2):
>       iwlwifi: add new cards for AX family
>       iwlwifi: update few product names in AX family
> 
> Johannes Berg (6):
>       iwlwifi: pcie: use seq_file for tx_queue debugfs file
>       iwlwifi: pcie: add n_window/ampdu to tx_queue debugfs
>       iwlwifi: pcie: gen2: minor code cleanups in byte table update
>       iwlwifi: mvm: add DCM flag to rate pretty-print
>       iwlwifi: pcie: move iwl_pcie_ctxt_info_alloc_dma() to user
>       iwlwifi: mvm: tell firmware about required LTR delay
> 
> Luca Coelho (4):
>       iwlwifi: remove deprecated and unused iwl_mvm_keyinfo struct
>       iwlwifi: pcie: add cfgs for SoCs with device ID 0x4FD0
>       iwlwifi: pcie: add new structure for Qu devices with medium latency
>       iwlwifi: pcie: add new structs for So devices with long latency
> 
> Mordechay Goodstein (3):
>       iwlwifi: move API version lookup to common code
>       iwlwifi: support version 9 of WOWLAN_GET_STATUS notification
>       iwlwifi: acpi: read TAS table from ACPI and send it to the FW
> 
> Shahar S Matityahu (2):
>       iwlwifi: dbg: support multiple dumps in legacy dump flow
>       iwlwifi: yoyo: support IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT time point
> 
> Tova Mussai (2):
>       iwlwifi: scan: remove support for fw scan api v13
>       iwlwifi: nvm: use iwl_nl80211_band_from_channel_idx
> 
>  drivers/net/wireless/intel/iwlwifi/Makefile              |   3 +-
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |  71 +++++++++++++++++++++++++++++++++++++++--------
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c             |  76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h             |  17 ++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/config.h       |  39 ++++++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/d3.h           |  39 +++++++++++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h      |  15 ++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |  26 ------------------
>  drivers/net/wireless/intel/iwlwifi/fw/api/soc.h          |  12 +++++---
>  drivers/net/wireless/intel/iwlwifi/fw/api/sta.h          |  26 ------------------
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.h              |  11 --------
>  drivers/net/wireless/intel/iwlwifi/fw/file.h             |   1 +
>  drivers/net/wireless/intel/iwlwifi/fw/img.c              |  99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/img.h              |  19 ++-----------
>  drivers/net/wireless/intel/iwlwifi/fw/runtime.h          |  14 +++++++---
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  23 ++++++++++++----
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  26 ++++++++++++------
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |   4 ---
>  drivers/net/wireless/intel/iwlwifi/iwl-modparams.h       |   2 --
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |   3 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/constants.h       |   4 +++
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |  29 +++++++++++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c   |   4 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c   |   4 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c              | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |   1 -
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |   4 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  25 ++---------------
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.c              |   3 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  44 +++--------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  47 ++++++++++++++++---------------
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c      |  15 ++++++++++
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c            |  34 ++++++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |  16 -----------
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c          | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |   8 ++++--
>  37 files changed, 799 insertions(+), 354 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/img.c

Pulled, thanks.

c1070c1c6ceb Merge tag 'iwlwifi-next-for-kalle-2020-04-24-2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/patch/11507893/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
