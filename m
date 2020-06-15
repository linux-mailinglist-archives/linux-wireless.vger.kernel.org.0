Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662711F9E50
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgFORZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 13:25:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61823 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbgFORZT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 13:25:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592241919; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=T9K+WPQhgS3+VpXR+AG2QZq0FlTr89iovMq5SiliMnQ=;
 b=gyahwNGsODO1t/38JYYvZnKmAQMMkEWt9W2bjQaxG4EYZZocgcgca/MN2GTNpZAXtAvpqp42
 f6qRxvprSbb62RlfG3AM5JMVXvMIAWWiKCJ0oxsY5P7PTTgnU32R6THjUc4XnK6iB/+II2GG
 dyTkTuDlLb6Mfxs4uVZ/BLWf7DI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5ee7aefec4bb4f886d1af2bb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 17:25:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B18E4C43391; Mon, 15 Jun 2020 17:25:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BF42C433CB;
        Mon, 15 Jun 2020 17:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BF42C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2020-06-11
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <b09ebb1abe0c884d31884fc16e52ed47e8a3796f.camel@coelho.fi>
References: <b09ebb1abe0c884d31884fc16e52ed47e8a3796f.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200615172517.B18E4C43391@smtp.codeaurora.org>
Date:   Mon, 15 Jun 2020 17:25:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's the first batch of patches intended for v5.9.  This contains
> only patches that were sent by the community.  I have decided to apply
> community patches directly to iwlwifi-next without going through our
> internal tree first, so the turnaround is shorter.  I apply them in
> parallel to our internal tree so we get the benefits of our CI
> infrastructure as well.  Kbuildbot has also reported success.  More
> details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit 1806c13dc2532090d742ce03847b22367fb20ad6:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-05-31 17:48:46 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2020-06-11
> 
> for you to fetch changes up to e00c6d8d491b3b8b93eeac1aae51c78a5217cde6:
> 
>   net: wireless: intel: fix wiki website url (2020-06-10 15:25:42 +0300)
> 
> ----------------------------------------------------------------
> First set of patches intended for v5.9
> 
> * Fix links to wiki;
> * Some preparations for gcc-10;
> * Make FW reconfiguration quieter by not using warn level;
> * Some other small fixes and clean-up;
> 
> ----------------------------------------------------------------
> Alexander Wetzel (1):
>       iwlwifi: Extended Key ID support for mvm and dvm
> 
> Arnd Bergmann (1):
>       iwlwifi: mvm: fix gcc-10 zero-length-bounds warning
> 
> Ben Greear (1):
>       iwlwifi: mvm: Fix avg-power report
> 
> Chris Down (1):
>       iwlwifi: Don't IWL_WARN on FW reconfiguration
> 
> Colin Ian King (1):
>       iwlwifi: mvm: remove redundant assignment to variable ret
> 
> Flavio Suligoi (1):
>       net: wireless: intel: fix wiki website url
> 
> Gustavo A. R. Silva (1):
>       iwlwifi: Replace zero-length array with flexible-array
> 
> Luca Ceresoli (1):
>       iwlwifi: fix config variable name in comment
> 
> YueHaibing (1):
>       iwlwifi: mvm: Remove unused inline function iwl_mvm_tid_to_ac_queue
> 
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c      |  2 +-
>  drivers/net/wireless/intel/iwlwifi/Kconfig          |  2 +-
>  drivers/net/wireless/intel/iwlwifi/dvm/commands.h   | 12 ++++++------
>  drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c   |  1 +
>  drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h |  4 ++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h      | 14 +++++++-------
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c         |  2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/debugfs.c     |  2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-config.h     |  2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h    |  2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-trans.h      |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   | 10 +++++++++-
>  drivers/net/wireless/intel/iwlwifi/mvm/rs.c         |  2 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c        |  8 --------
>  14 files changed, 33 insertions(+), 32 deletions(-)

Pulled, thanks.

a15a20acc980 Merge tag 'iwlwifi-next-for-kalle-2020-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

-- 
https://patchwork.kernel.org/patch/11599563/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

