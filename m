Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9751D313A26
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 17:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBHQzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 11:55:17 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:30585 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234554AbhBHQyM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 11:54:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612803229; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=u1BEfMErIr52nTI/YnRIphw1LwcFyUW7r5oxsqGWh38=;
 b=alwUG/EmPXjTzZ+Mn3Jg0Uu6YYYGU64Xsrd2MhplG/p4XCoOT9oysJyubU0GzGVLobBDjclP
 535RfBYmG80qjGnJEgNjU7R870yDJWl5WbJlCQsi1/2zEo6om1p3Ybmi8cwlf4qejRbCOV3G
 FB2cR3Hp++pv+xo9vtwzZ5HXLq4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60216c838e43a988b71781ef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 16:53:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8490C43461; Mon,  8 Feb 2021 16:53:23 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFDC8C43462;
        Mon,  8 Feb 2021 16:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFDC8C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2021-02-05
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <274043dd180b451125ab059601416d64a951a9f6.camel@coelho.fi>
References: <274043dd180b451125ab059601416d64a951a9f6.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208165323.A8490C43461@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 16:53:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the first batch of patches intended for v5.12.  This includes
> the four last patchsets I sent out for v5.12.  Usual development work.
> More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 4832bb371c4175ffb506a96accbb08ef2b2466e7:
> 
>   iwl4965: do not process non-QOS frames on txq->sched_retry path (2021-01-25 16:43:27 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-02-05
> 
> for you to fetch changes up to 47ef328c2090cc790c0766094557aedd04ac923f:
> 
>   iwlwifi: pcie: Disable softirqs during Rx queue init (2021-02-05 12:00:13 +0200)
> 
> ----------------------------------------------------------------
> iwlwifi patches intended for v5.12
> 
> * Check FW notification sizes for robustness;
> * Improvements in the NAPI implementation;
> * Implement a workaround for CCA-EXT;
> * Add new FW API support;
> * Fix a CSA bug;
> * Implement PHY integration version parsing;
> * A bit of refactoring;
> * One more CSA bug fix, this time in the AP side;
> * Support for new So devices and a bit of reorg;
> * Per Platform Antenna Gain (PPAG) fixes and improvements;
> * Improvements in the debug framework;
> * Some other clean-ups and small fixes.
> 
> ----------------------------------------------------------------
> Dror Moshe (2):
>       iwlwifi: parse phy integration string from FW TLV
>       iwlwifi: mvm: debugfs for phy-integration-ver
> 
> Emmanuel Grumbach (4):
>       iwlwifi: remove TRANS_PM_OPS
>       iwlwifi: mvm: don't check system_pm_mode without mutex held
>       iwlwifi: mvm: cancel the scan delayed work when scan is aborted
>       iwlwifi: mvm: fix CSA AP side
> 
> Haim Dreyfuss (1):
>       iwlwifi: mvm: don't send commands during suspend\resume transition
> 
> Ilan Peer (1):
>       iwlwifi: pcie: Disable softirqs during Rx queue init
> 
> Johannes Berg (13):
>       iwlwifi: mvm: add notification size checks
>       iwlwifi: mvm: check more notification sizes
>       iwlwifi: mvm: remove debugfs injection limitations
>       iwlwifi: mvm: scan: fix scheduled scan restart handling
>       iwlwifi: mvm: handle CCA-EXT delay firmware notification
>       iwlwifi: pcie: properly implement NAPI
>       iwlwifi: mvm: simplify TX power setting
>       iwlwifi: mvm: debugfs: check length precisely in inject_packet
>       iwlwifi: always allow maximum A-MSDU on newer devices
>       iwlwifi: mvm: advertise BIGTK client support if available
>       iwlwifi: fw api: make hdr a zero-size array again
>       iwlwifi: mvm: slightly clean up rs_fw_set_supp_rates()
>       iwlwifi: mvm: make iwl_mvm_tt_temp_changed() static
> 
> Krishnanand Prabhu (1):
>       iwlwifi: mvm: add explicit check for non-data frames in get Tx rate
> 
> Luca Coelho (12):
>       iwlwifi: bump FW API to 60 for AX devices
>       iwlwifi: move SnJ and So rules to the new tables
>       iwlwifi: add support for SnJ with Jf devices
>       iwlwifi: mvm: move early time-point before nvm_init in non-unified
>       iwlwifi: pcie: add support for SnJ with Hr1
>       iwlwifi: mvm: set enabled in the PPAG command properly
>       iwlwifi: mvm: implement approved list for the PPAG feature
>       iwlwifi: mvm: add HP to the PPAG approved list
>       iwlwifi: mvm: add Samsung to the PPAG approved list
>       iwlwifi: mvm: add Microsoft to the PPAG approved list
>       iwlwifi: mvm: add Asus to the PPAG approved list
>       iwlwifi: bump FW API to 61 for AX devices
> 
> Mordechay Goodstein (9):
>       iwlwifi: mvm: add support for new flush queue response
>       iwl-trans: iwlwifi: move sync NMI logic to trans
>       iwlwifi: dbg: dump paged memory from index 1
>       iwlwifi: tx: move handing sync/async host command to trans
>       iwlwifi: mvm: add IML/ROM information for other HW families
>       iwlwifi: mvm: add triggers for MLME events
>       iwlwifi: fwrt: add suspend/resume time point
>       iwlwifi: mvm: add tx fail time point
>       iwlwifi: mvm: add debugfs entry to trigger a dump as any time-point
> 
> Shaul Triebitz (1):
>       iwlwifi: mvm: csa: do not abort CSA before disconnect
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c        |  58 +++++++++++++++++++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h  |  18 ++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/debug.h     |  15 ++++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/rx.h        |   7 ++-
>  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h        |  28 +++++++++-
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c           |  34 ++++++------
>  drivers/net/wireless/intel/iwlwifi/fw/file.h          |   3 ++
>  drivers/net/wireless/intel/iwlwifi/fw/img.h           |   3 ++
>  drivers/net/wireless/intel/iwlwifi/fw/init.c          |   2 +
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h       |   7 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-drv.c          |  14 +++++
>  drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c |   7 ++-
>  drivers/net/wireless/intel/iwlwifi/iwl-io.c           |  36 +++++++++++++
>  drivers/net/wireless/intel/iwlwifi/iwl-prph.h         |   1 +
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.c        |  18 ++++++-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h        |  33 ++++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c           |  31 +++--------
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c      |  79 ++++++++++++++++++++--------
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c           |  39 +++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c     |  18 +++----
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 114 ++++++++++++++++++++++++++++++++++-------
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h          |  16 ++++--
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c          | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c        |   5 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/rx.c           |  13 +++--
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c         | 125 +++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c         |  12 ++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c          |  23 +++++----
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c           |   8 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c           | 175 +++++++++++++++++++++++++++++++++++++++++++++++---------------
>  drivers/net/wireless/intel/iwlwifi/mvm/utils.c        |  61 +++++++++++++++++++---
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c         | 141 ++++++++++++++++++++++++++++++++++----------------
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h    |  20 ++++----
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c          | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c       |  92 +++++++++------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c     | 125 +--------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/pcie/tx.c          | 150 +++--------------------------------------------------
>  drivers/net/wireless/intel/iwlwifi/queue/tx.c         | 129 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/intel/iwlwifi/queue/tx.h         |   1 +
>  40 files changed, 1389 insertions(+), 738 deletions(-)

Pulled, thanks.

b7e6725df786 Merge tag 'iwlwifi-next-for-kalle-2021-02-05' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/274043dd180b451125ab059601416d64a951a9f6.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

