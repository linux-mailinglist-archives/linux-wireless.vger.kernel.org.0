Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4309E43C3C7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhJ0HYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:24:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47929 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhJ0HYd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:24:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635319328; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Ra3qJoInrWp9FfiMrs676zU4ImbX4fBoQCRbZ5UntJI=;
 b=jGoxHdbPYW5DDpKcCm4JOsT2w9+Pecs+MhORusbl4g1S0pODRybKfqgon4AvBaskxSqfZbXY
 7xlxGBPHzcidogVaUF1V5MY3Jk36XxBRbtat7x/jSWvkG0dp8D6ApdwiadG4gpFutYO9upba
 doCGTuNpS+9q75XxYJNFn2gCui4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6178fe1b67f107c611e77791 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:22:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6E93C43460; Wed, 27 Oct 2021 07:22:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BED3FC4338F;
        Wed, 27 Oct 2021 07:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BED3FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2021-10-22
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <7a4bc2129d69ef7c5ae30f26aa81363d80d5a769.camel@coelho.fi>
References: <7a4bc2129d69ef7c5ae30f26aa81363d80d5a769.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163531931803.30745.3035891628376359987.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:22:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's my first pull request for v5.16 with the four patchsets I sent
> earlier.  This is all normal development, new features, bugfixes and
> cleanups.  More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 9bc0b1aa8b7e54d62082749fc5404660690d17ce:
> 
>   Merge tag 'mt76-for-kvalo-2021-10-20' of https://github.com/nbd168/wireless (2021-10-20 19:08:25 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-10-22
> 
> for you to fetch changes up to 2c5769e358b7b436f4e848f134d2bbac6010a490:
> 
>   iwlwifi: pnvm: print out the version properly (2021-10-22 10:54:18 +0300)
> 
> ----------------------------------------------------------------
> iwlwifi patches for v5.16
> 
> * Support for 160MHz in ranging measurements;
> * Some fixes in HE capabilities;
> * Fixes in vendor specific capabilities;
> * Add the PC of both processors in error dumps;
> * Small fix in TDLS;
> * Code to sanitize firmware dumps;
> * Updates for new FW rate and flags format;
> * Continue implementation of new rate and flags format in the FW APIs;
> * Some fixes for BZ family initialization;
> * Fix session protection in some scenarios;
> * Some debugging improvements;
> * Fix BT-coex priority;
> * Improve PS-poll timeout detection;
> * Some other small fixes, clean-ups and improvements.
> 
> ----------------------------------------------------------------
> Avraham Stern (1):
>       iwlwifi: mvm: add support for 160Mhz in ranging measurements
> 
> Gregory Greenman (1):
>       iwlwifi: mvm: improve log when processing CSA
> 
> Johannes Berg (20):
>       iwlwifi: mvm: fix ieee80211_get_he_iftype_cap() iftype
>       iwlwifi: mvm: disable RX-diversity in powersave
>       iwlwifi: add vendor specific capabilities for some RFs
>       iwlwifi: add some missing kernel-doc in struct iwl_fw
>       iwlwifi: api: remove unused RX status bits
>       iwlwifi: remove MODULE_AUTHOR() statements
>       iwlwifi: remove contact information
>       iwlwifi: fix fw/img.c license statement
>       iwlwifi: api: fix struct iwl_wowlan_status_v7 kernel-doc
>       iwlwifi: mvm: correct sta-state logic for TDLS
>       iwlwifi: fw dump: add infrastructure for dump scrubbing
>       iwlwifi: parse debug exclude data from firmware file
>       iwlwifi: mvm: scrub key material in firmware dumps
>       iwlwifi: remove redundant iwl_finish_nic_init() argument
>       iwlwifi: mvm: remove session protection after auth/assoc
>       iwlwifi: allow rate-limited error messages
>       iwlwifi: mvm: reduce WARN_ON() in TX status path
>       iwlwifi: pcie: try to grab NIC access early
>       iwlwifi: mvm: set BT-coex high priority for 802.1X/4-way-HS
>       iwlwifi: pnvm: print out the version properly
> 
> Luca Coelho (2):
>       iwlwifi: mvm: Support new rate_n_flags for REPLY_RX_MPDU_CMD and RX_NO_DATA_NOTIF
>       iwlwifi: mvm: remove csi from iwl_mvm_pass_packet_to_mac80211()
> 
> Matti Gottlieb (3):
>       iwlwifi: Add support for getting rf id with blank otp
>       iwlwifi: Add support for more BZ HWs
>       iwlwifi: Start scratch debug register for Bz family
> 
> Miri Korenblit (11):
>       iwlwifi: mvm: Remove antenna c references
>       iwlwifi: mvm: update definitions due to new rate & flags
>       iwlwifi: mvm: add definitions for new rate & flags
>       iwlwifi: mvm: convert old rate & flags to the new format.
>       iwlwifi: mvm: Support version 3 of tlc_update_notif.
>       iwlwifi: mvm: Support new version of ranging response notification
>       iwlwifi: mvm: Add support for new rate_n_flags in tx_cmd.
>       iwlwifi: mvm: Support new version of BEACON_TEMPLATE_CMD.
>       iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions
>       iwlwifi: mvm: Add RTS and CTS flags to iwl_tx_cmd_flags.
>       iwlwifi: mvm: Read acpi dsm to get channel activation bitmap
> 
> Mordechay Goodstein (1):
>       iwlwifi: mvm: add lmac/umac PC info in case of error
> 
> Mukesh Sisodiya (1):
>       iwlwifi: yoyo: fw debug config from context info and preset
> 
> Roee Goldfiner (2):
>       iwlwifi: BZ Family BUS_MASTER_DISABLE_REQ code duplication
>       iwlwifi: BZ Family SW reset support
> 
> Rotem Saado (2):
>       iwlwifi: dbg: treat dbgc allocation failure when tlv is missing
>       iwlwifi: dbg: treat non active regions as unsupported regions
> 
> Sara Sharon (1):
>       iwlwifi: mvm: set inactivity timeouts also for PS-poll
> 
> Yaara Baruch (2):
>       iwlwifi: add new killer devices to the driver
>       iwlwifi: add new device id 7F70
> 
>  drivers/net/wireless/intel/iwlwifi/Makefile                |   2 +-
>  drivers/net/wireless/intel/iwlwifi/cfg/1000.c              |   5 --
>  drivers/net/wireless/intel/iwlwifi/cfg/2000.c              |   5 --
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |  31 +++++++++++
>  drivers/net/wireless/intel/iwlwifi/cfg/5000.c              |   5 --
>  drivers/net/wireless/intel/iwlwifi/cfg/6000.c              |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/agn.h               |  11 ++--
>  drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c           |   4 --
>  drivers/net/wireless/intel/iwlwifi/dvm/dev.h               |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/devices.c           |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/led.c               |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/led.h               |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/lib.c               |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c          |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/main.c              |   6 ---
>  drivers/net/wireless/intel/iwlwifi/dvm/power.c             |   4 --
>  drivers/net/wireless/intel/iwlwifi/dvm/power.h             |   4 --
>  drivers/net/wireless/intel/iwlwifi/dvm/rs.c                |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/rs.h                |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/rx.c                |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/rxon.c              |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/scan.c              |   4 --
>  drivers/net/wireless/intel/iwlwifi/dvm/sta.c               |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/tt.c                |   4 --
>  drivers/net/wireless/intel/iwlwifi/dvm/tt.h                |   4 --
>  drivers/net/wireless/intel/iwlwifi/dvm/tx.c                |   5 --
>  drivers/net/wireless/intel/iwlwifi/dvm/ucode.c             |   5 --
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |   3 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/d3.h             |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h        |  57 +++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/debug.h          |  18 +++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/location.h       |  10 ++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/mac.h            |   3 ++
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  23 +++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/rs.h             | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h             |  31 ++++-------
>  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h             |  40 +++++++++++----
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c                |  46 +++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/dump.c               |   9 +++-
>  drivers/net/wireless/intel/iwlwifi/fw/error-dump.h         |   4 --
>  drivers/net/wireless/intel/iwlwifi/fw/file.h               |  10 ++++
>  drivers/net/wireless/intel/iwlwifi/fw/img.c                |  58 ++-------------------
>  drivers/net/wireless/intel/iwlwifi/fw/img.h                |  12 +++++
>  drivers/net/wireless/intel/iwlwifi/fw/init.c               |   6 ++-
>  drivers/net/wireless/intel/iwlwifi/fw/paging.c             |   4 +-
>  drivers/net/wireless/intel/iwlwifi/fw/pnvm.c               |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/rs.c                 | 252 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/runtime.h            |   5 ++
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h            |   8 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-csr.h               |   7 +++
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c           | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h           |   2 +
>  drivers/net/wireless/intel/iwlwifi/iwl-debug.c             |  24 ++++++---
>  drivers/net/wireless/intel/iwlwifi/iwl-debug.h             |  26 ++++++----
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h     |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h       |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h  |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h      |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h    |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c          |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h          |   5 --
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  44 +++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.h               |   3 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c       |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-io.c                |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-io.h                |   5 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         |  17 +++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-prph.h              |  36 +++++++++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h             |  30 +++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c           |  19 +++----
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |  15 +++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c     |  15 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c                |  36 +++++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c          |  38 +++++++++++---
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          | 204 ++++++++++++++++++++++++++++++++++++++++++++-----------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h               |  13 ++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c               | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/power.c             |  28 +++++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c             |  16 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.c                | 182 ++++++++++++++++++++++-------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.h                |  17 -------
>  drivers/net/wireless/intel/iwlwifi/mvm/rx.c                |  39 +++++++-------
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c              | 119 +++++++++++++++++++++++++------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c              |   2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c                | 117 ++++++++++++++++++++++++++++++++----------
>  drivers/net/wireless/intel/iwlwifi/mvm/utils.c             |  54 +++++++++++---------
>  drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   4 ++
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c              | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  38 +++-----------
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |  45 +++++++++++-----
>  91 files changed, 1959 insertions(+), 780 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/rs.c

Pulled, thanks.

de904d80aaec Merge tag 'iwlwifi-next-for-kalle-2021-10-22' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7a4bc2129d69ef7c5ae30f26aa81363d80d5a769.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

