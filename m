Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D957C9180
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 01:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjJMXqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 19:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjJMXqi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 19:46:38 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA61EC9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 16:46:36 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DCCFD10006B;
        Fri, 13 Oct 2023 23:46:34 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6E5E313C2B0;
        Fri, 13 Oct 2023 16:46:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6E5E313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1697240793;
        bh=weqrcwIEqqXfduIDVyy5MOLbZOnoOWV9VTOAZu4KLqc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pdLgTpW8jreejzXHSf9LHDTws+yGLtweRDD3jpQelD55af7ca/HoV6wLITGrFUpjr
         dteyRSqDh8DBttfehkRkVXdgwrW6yIISFBI1bpmsKr6KiV50hcaXdDygMZPY0PTvV7
         PpNdjQ666AvIJ1CrV4enn0x+FrYg477Zpkk/bRUI=
Message-ID: <b6b3cf6c-2c5b-fd54-e550-af8ef705214d@candelatech.com>
Date:   Fri, 13 Oct 2023 16:46:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/16] wifi: iwlwifi: updates intended for v6.6 2023-08-30
Content-Language: en-US
To:     gregory.greenman@intel.com, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20230830083104.546619-1-gregory.greenman@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1697240795-Tqa2YqZ9WCtu
X-MDID-O: us5;ut7;1697240795;Tqa2YqZ9WCtu;<greearb@candelatech.com>;21a4e426aab50b16d8e6565b1650ef6d
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/23 01:30, gregory.greenman@intel.com wrote:
> From: Gregory Greenman <gregory.greenman@intel.com>
> 
> Hi,
> 
> This patch set includes iwlwifi patches intended for v6.6.

 From what I can tell, this series didn't get into 6.6.  Is that expected?

Thanks,
Ben

> 
> The changes are:
> * CSA support for MLD and a few CSA fixes
> * kernel-doc fixes
> * a fix for enable_ini module parameter
> * a few fixes and improvements in Rx path
> * several other fixes
> 
> Thanks,
> Gregory
> 
> Emmanuel Grumbach (2):
>    wifi: iwlwifi: mvm: support CSA with MLD
>    wifi: iwlwifi: honor the enable_ini value
> 
> Johannes Berg (13):
>    wifi: iwlwifi: mvm: increase session protection after CSA
>    wifi: iwlwifi: mvm: disconnect long CSA only w/o alternative
>    wifi: iwlwifi: fix some kernel-doc issues
>    wifi: iwlwifi: queue: fix kernel-doc
>    wifi: iwlwifi: dvm: remove kernel-doc warnings
>    wifi: iwlwifi: pcie: fix kernel-doc issues
>    wifi: iwlwifi: mvm: fix kernel-doc
>    wifi: iwlwifi: fw: reconstruct the API/CAPA enum number
>    wifi: iwlwifi: mvm: move RU alloc B2 placement
>    wifi: iwlwifi: mvm: check link more carefully
>    wifi: iwlwifi: mvm: reduce maximum RX A-MPDU size
>    wifi: iwlwifi: pcie: fix RB status reading
>    wifi: iwlwifi: increase number of RX buffers for EHT devices
> 
> Miri Korenblit (1):
>    wifi: iwlwifi: don't use an uninitialized variable
> 
>   drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 10 ++--
>   drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 +--
>   .../net/wireless/intel/iwlwifi/dvm/commands.h | 33 +++++++----
>   drivers/net/wireless/intel/iwlwifi/dvm/dev.h  | 14 +++--
>   drivers/net/wireless/intel/iwlwifi/dvm/rs.h   | 12 ++--
>   drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |  9 +--
>   .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  1 +
>   .../net/wireless/intel/iwlwifi/fw/api/rfi.h   |  7 ++-
>   .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 16 +++--
>   .../net/wireless/intel/iwlwifi/fw/api/txq.h   |  4 +-
>   drivers/net/wireless/intel/iwlwifi/fw/file.h  | 27 ++++++---
>   .../wireless/intel/iwlwifi/fw/notif-wait.h    |  3 +-
>   .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 --
>   .../intel/iwlwifi/iwl-context-info-gen3.h     |  4 +-
>   .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  5 +-
>   drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 51 ++++++----------
>   drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  2 +-
>   .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |  4 +-
>   drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 13 ++--
>   .../net/wireless/intel/iwlwifi/iwl-trans.h    | 13 ++--
>   .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  4 +-
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 ++--
>   .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 -
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 28 ++++++---
>   drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 23 ++++----
>   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  2 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +-
>   .../wireless/intel/iwlwifi/mvm/time-event.h   |  9 ++-
>   .../wireless/intel/iwlwifi/pcie/internal.h    | 59 +++++++++++++------
>   drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
>   .../net/wireless/intel/iwlwifi/pcie/trans.c   | 12 ++--
>   drivers/net/wireless/intel/iwlwifi/queue/tx.h |  6 +-
>   34 files changed, 225 insertions(+), 186 deletions(-)
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


