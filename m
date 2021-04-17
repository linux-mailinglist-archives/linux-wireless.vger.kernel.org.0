Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4519C362E93
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhDQIjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 04:39:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33992 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhDQIjU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 04:39:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618648734; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=zQEVJ1m+JJRoDlriwUkb8Qe9bHT7Phq3Eru5Uoirr6E=;
 b=OMfhLdLFypHp++yXRNj+4yUQMCX8rCW+k8+CP8v//+h2rLf5adMk7z2rpCyZtana1w222AeL
 q7FXi3h+pkjPanwFeIttoT5xt/96RFaAukbLNs5B6GI5sXqLSEw1zgUxLP6edShiIm0ZLy5W
 Z6GCJIj+gg/he/rTuW8WcFyN154=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 607a9e9e2cbba88980c4a1f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 08:38:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77AB7C43462; Sat, 17 Apr 2021 08:38:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57D92C433C6;
        Sat, 17 Apr 2021 08:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57D92C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2021-04-12-v2
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3bc5f697c8ec26e66009a84a93253758229c6407.camel@coelho.fi>
References: <3bc5f697c8ec26e66009a84a93253758229c6407.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417083853.77AB7C43462@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 08:38:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's v2 of the first batch of patches intended for v5.13.  This
> includes the four last patchsets I sent out for v5.13 with the usual
> development work.  In v2 I dropped the mei series.  More details about
> the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 5871d0c6b8ea805916c3135d0c53b095315bc674:
> 
>   ionic: return -EFAULT if copy_to_user() fails (2021-04-13 15:08:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-04-12-v2
> 
> for you to fetch changes up to 7c81a025054cd0aeeeaf17aba2e9757f0a6a38a1:
> 
>   iwlwifi: dbg: disable ini debug in 9000 family and below (2021-04-14 12:07:21 +0300)
> 
> ----------------------------------------------------------------
> iwlwifi patches for v5.13
> 
> * Add support for new FTM FW APIs;
> * Some CSA fixes;
> * Support for new HW family and other HW detection fixes;
> * Robustness improvement in the HW detection code;
> * One fix in PMF;
> * Some new regulatory features;
> * Support for passive scan in 6GHz;
> * Some improvements in the sync queue implementation;
> * Support for new devices;
> * Support for a new FW API command version;
> * Some locking fixes;
> * Bump the FW API version support for AX devices;
> * Some other small fixes, clean-ups and improvements.
> 
> ----------------------------------------------------------------
> Avraham Stern (3):
>       iwlwifi: mvm: support range request command version 12
>       iwlwifi: mvm: responder: support responder config command version 8
>       iwlwifi: mvm: when associated with PMF, use protected NDP ranging negotiation
> 
> Emmanuel Grumbach (5):
>       iwlwifi: mvm: don't allow CSA if we haven't been fully associated
>       iwlwifi: remove TCM events
>       iwlwifi: don't warn if we can't wait for empty tx queues
>       iwlwifi: mvm: don't disconnect immediately if we don't hear beacons after CSA
>       iwlwifi: mvm: don't WARN if we can't remove a time event
> 
> Harish Mitty (1):
>       iwlwifi: mvm: refactor ACPI DSM evaluation function
> 
> Ilan Peer (1):
>       iwlwifi: mvm: Add support for 6GHz passive scan
> 
> Johannes Berg (10):
>       iwlwifi: pcie: avoid unnecessarily taking spinlock
>       iwlwifi: pcie: normally grab NIC access for inflight-hcmd
>       iwlwifi: pcie: make cfg vs. trans_cfg more robust
>       iwlwifi: mvm: write queue_sync_state only for sync
>       iwlwifi: mvm: clean up queue sync implementation
>       iwlwifi: remove remaining software checksum code
>       iwlwifi: mvm: don't lock mutex in RCU critical section
>       iwlwifi: warn on SKB free w/o op-mode
>       iwlwifi: trans/pcie: defer transport initialisation
>       iwlwifi: fw: print out trigger delay when collecting data
> 
> Luca Coelho (1):
>       iwlwifi: bump FW API to 63 for AX devices
> 
> Matti Gottlieb (2):
>       iwlwifi: pcie: Add support for Bz Family
>       iwlwifi: pcie: Change ma product string name
> 
> Miri Korenblit (3):
>       iwlwifi: mvm: enable PPAG in China
>       iwlwifi: mvm: support BIOS enable/disable for 11ax in Ukraine
>       iwlwifi: mvm: add support for version 3 of LARI_CONFIG_CHANGE command.
> 
> Mordechay Goodstein (7):
>       iwlwifi: pcie: clear only FH bits handle in the interrupt
>       iwlwifi: move iwl_configure_rxq to be used by other op_modes
>       iwlwifi: queue: avoid memory leak in reset flow
>       iwlwifi: mvm: remove PS from lower rates.
>       iwlwifi: pcie: merge napi_poll_msix functions
>       iwlwifi: pcie: add ISR debug info for msix debug
>       iwlwifi: rs-fw: don't support stbc for HE 160
> 
> Mukesh Sisodiya (1):
>       iwlwifi: dbg: disable ini debug in 9000 family and below
> 
> Ravi Darsi (1):
>       iwlwifi: mvm: Use IWL_INFO in fw_reset_handshake()
> 
> Roee Goldfiner (1):
>       iwlwifi: mvm: umac error table mismatch
> 
> Sara Sharon (1):
>       iwlwifi: mvm: enable TX on new CSA channel before disconnecting
> 
> ybaruch (5):
>       iwlwifi: change step in so-gf struct
>       iwlwifi: change name to AX 211 and 411 family
>       iwlwifi: add 160Mhz to killer 1550 name
>       iwlwifi: add ax201 killer device
>       iwlwifi: add new so-gf device
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  72 ++++++++++++++++++++++++++---
>  drivers/net/wireless/intel/iwlwifi/cfg/9000.c          |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c           |  78 +++++++++++++++++++++++++++++---
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |  13 +++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  20 ++++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/power.h      |  22 ++++-----
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h         |  30 -------------
>  drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       |   8 ++++
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c            |   4 +-
>  drivers/net/wireless/intel/iwlwifi/fw/file.h           |   3 ++
>  drivers/net/wireless/intel/iwlwifi/fw/img.h            |   5 ++-
>  drivers/net/wireless/intel/iwlwifi/fw/init.c           |  59 ++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/fw/runtime.h        |   1 +
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  12 ++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |   3 ++
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |   5 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h       |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.c         |  91 +++++++++++++++++++++----------------
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |   6 ++-
>  drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |  11 +++++
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c            |   2 +
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |  10 ++---
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  85 ++++++++++++++++++++++++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |  27 +++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c            | 232 +++++++++++++++++++++++++++-------------------------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  59 ++++++++++++++++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |  12 ++---
>  drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  20 ++++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.c            |   6 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |  58 +++++-------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c          | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c           |  10 ++---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.h           |  38 ++++++++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |  27 +++++++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/utils.c         |  18 +-------
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c          |  80 ++++++++++++++++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  68 ++++++++++++----------------
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   8 ++--
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |   5 +++
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c           |  80 ++++++++++++---------------------
>  drivers/net/wireless/intel/iwlwifi/queue/tx.c          |  41 ++++-------------
>  drivers/net/wireless/intel/iwlwifi/queue/tx.h          |   3 +-
>  44 files changed, 1102 insertions(+), 541 deletions(-)

Pulled, thanks.

197b9c152bad Merge tag 'iwlwifi-next-for-kalle-2021-04-12-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3bc5f697c8ec26e66009a84a93253758229c6407.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

