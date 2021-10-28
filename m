Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4DB43E242
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJ1Ncd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 09:32:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58814 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhJ1Nc0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 09:32:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635427799; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ow+c8ZGM+PiM/9CvEGoOlWb+BlIonMpcGuG+xXo3kV8=;
 b=S6YPeuofC0cU2D0TxObZ/24U4wSbuiT7I6K0au/pbX2Z1gTrXNWfXQFh30JOj5G5cn5HcMKx
 9md/WUNVB/Syt2yCALTe+VlHPSY0DBgKZZuB8X5RIZLs0vjuohYTRmACUI8KQxtXu/Kkt+ea
 zbz+2NmYHWqW6HJRks9D6kjpTbU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 617aa5c5ff3eb667a7c69a8a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Oct 2021 13:29:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BBCE6C43616; Thu, 28 Oct 2021 13:29:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58750C4360D;
        Thu, 28 Oct 2021 13:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 58750C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: iwlwifi-next 2021-10-28
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <dc1df61337fad1cb5a83789bc78da8b18541ef26.camel@coelho.fi>
References: <dc1df61337fad1cb5a83789bc78da8b18541ef26.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163542777821.5095.17548912813654921520.kvalo@codeaurora.org>
Date:   Thu, 28 Oct 2021 13:29:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's my second pull request for v5.16 with the two patchsets I sent
> earlier, plus one patch for a new HW combination that I sent this
> morning.  I decided to leave out Björns patches, because there are
> still a few things Johannes and I are discussing about them.
> 
> Otherwise this is all normal development, new features, bugfixes and
> cleanups.  More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit a427aca0a931b8c65b47231bbf09e8873b29d554:
> 
>   Merge tag 'mt76-for-kvalo-2021-10-23' of https://github.com/nbd168/wireless (2021-10-27 18:36:30 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-10-28
> 
> for you to fetch changes up to cbaa6aeedee5f92dafa5982eceea2a1f98ce4f7d:
> 
>   iwlwifi: bump FW API to 67 for AX devices (2021-10-28 12:04:12 +0300)
> 
> ----------------------------------------------------------------
> iwlwifi patches for v5.16
> 
> * Support a new ACPI table revision;
> * Improvements in the device selection code;
> * New HW support;
> * Some fixes in the Geographic SAR implementation;
> * Support for WiFi 6E enablement via BIOS;
> * Support FW API version 67;
> * Improve debugging support;
> * Some fixes in session protection;
> * Some other small fixes, clean-ups and improvements.
> 
> ----------------------------------------------------------------
> Ayala Barazani (1):
>       iwlwifi: ACPI: support revision 3 WGDS tables
> 
> Emmanuel Grumbach (1):
>       iwlwifi: mvm: fix some kerneldoc issues
> 
> Gregory Greenman (1):
>       iwlwifi: mvm: update RFI TLV
> 
> Ilan Peer (1):
>       iwlwifi: mvm: Use all Rx chains for roaming scan
> 
> Johannes Berg (10):
>       iwlwifi: pcie: fix killer name matching for AX200
>       iwlwifi: pcie: remove duplicate entry
>       iwlwifi: pcie: refactor dev_info lookup
>       iwlwifi: pcie: remove two duplicate PNJ device entries
>       iwlwifi: pcie: simplify iwl_pci_find_dev_info()
>       iwlwifi: dump host monitor data when NIC doesn't init
>       iwlwifi: fw: uefi: add missing include guards
>       iwlwifi: mvm: d3: use internal data representation
>       iwlwifi: mvm: remove session protection on disassoc
>       iwlwifi: mvm: extend session protection on association
> 
> Luca Coelho (5):
>       iwlwifi: mvm: read 6E enablement flags from DSM and pass to FW
>       iwlwifi: mvm: don't get address of mvm->fwrt just to dereference as a pointer
>       iwlwifi: rename GEO_TX_POWER_LIMIT to PER_CHAIN_LIMIT_OFFSET_CMD
>       iwlwifi: mvm: fix WGDS table print in iwl_mvm_chub_update_mcc()
>       iwlwifi: bump FW API to 67 for AX devices
> 
> Mike Golant (1):
>       iwlwifi: pcie: update sw error interrupt for BZ family
> 
> Mukesh Sisodiya (1):
>       iwlwifi: yoyo: support for ROM usniffer
> 
> Nathan Errera (1):
>       iwlwifi: rename CHANNEL_SWITCH_NOA_NOTIF to CHANNEL_SWITCH_START_NOTIF
> 
> Yaara Baruch (1):
>       iwlwifi: add new pci SoF with JF
> 
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c      |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.c        | 150 ++++++++++++++++++++++++++++-------------
>  drivers/net/wireless/intel/iwlwifi/fw/acpi.h        |  40 ++++++-----
>  drivers/net/wireless/intel/iwlwifi/fw/api/d3.h      |  43 ------------
>  drivers/net/wireless/intel/iwlwifi/fw/api/debug.h   |  17 +++++
>  drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h |  10 +--
>  drivers/net/wireless/intel/iwlwifi/fw/api/phy.h     |   6 +-
>  drivers/net/wireless/intel/iwlwifi/fw/api/power.h   |  55 +++++++++++----
>  drivers/net/wireless/intel/iwlwifi/fw/api/sta.h     |   2 +
>  drivers/net/wireless/intel/iwlwifi/fw/file.h        |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/runtime.h     |   2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/uefi.h        |   5 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-csr.h        |   1 +
>  drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c    |  92 ++++++++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/iwl-io.c         |  46 ++++++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c         | 357 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c         |  72 +++++++++++++++-----
>  drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c   |   6 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   |  67 +++++++++++++------
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |   4 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/nvm.c        |   5 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c        |  10 +--
>  drivers/net/wireless/intel/iwlwifi/mvm/scan.c       |   8 +++
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c       | 149 ++++++++++++++++++++++++++++-------------
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c        |   9 ++-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c     |  45 ++++++++++---
>  26 files changed, 804 insertions(+), 401 deletions(-)

Pulled, thanks.

2619f904b25c Merge tag 'iwlwifi-next-for-kalle-2021-10-28' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/dc1df61337fad1cb5a83789bc78da8b18541ef26.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

