Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F654A5ABA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 11:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiBAK4b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 05:56:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46984 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiBAK4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 05:56:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 604B8B82D4C
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 10:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F6C340EB;
        Tue,  1 Feb 2022 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643712988;
        bh=SpC38fS8iFbLq0u6UuKQwO4knvRRZ3wf4OOgc0c9GdA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bsWh8gGu1VOy5fdcgyyjMVKwQpOhwzjGPFAC0fH6C7oho5EKzP4+cLdZMjxpNPcc6
         TtxMBuGWDVIzBJuvgP4Hfryeoo/ptXSdTgAHhWtOc3EUsl2v/WK5B+COr5TH30Ap5z
         g5ohi4ni46ZQ5suMM9kRb2IJ4NNoAl4B1ZsRs24LWvw/0UFv6Qdv0U6ZHT50+qY82f
         ywK0IOp3C/EGX+B3TUn3wo77shBs1ABqvQrEtUfnO7HSD2r68wJuqWVrXJK5A7CWlo
         WWCMSLFx36FhPOjduG0ViUsWZ0Ut1ByafixB78a+KciROCoAGbPgEOkm+ZZXmVXLJd
         OtZAKrneLpEOg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] ath11k: Add debugfs interface to configure firmware
 debug
 log level
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1642405103-32302-1-git-send-email-quic_seevalam@quicinc.com>
References: <1642405103-32302-1-git-send-email-quic_seevalam@quicinc.com>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164371298346.12561.4258328175713727016.kvalo@kernel.org>
Date:   Tue,  1 Feb 2022 10:56:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seevalamuthu Mariappan <quic_seevalam@quicinc.com> wrote:

> Add debugfs interface "fw_dbglog_config" to configure firmware log level.
> Configuration is done via WMI command WMI_DBGLOG_CFG_CMDID.
> 
> Command to configure,
> echo "<dbglog_param> <values>" >
> /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
> 
> where dbglog_param can be,
>   1) WMI_DEBUG_LOG_PARAM_LOG_LEVEL - configure log level for a given module
>      here, <values> = <0xaaaa00bb>, 'aaaa' - module id and 'bb' - loglevel
>   2) WMI_DEBUG_LOG_PARAM_VDEV_ENABLE - enable debug log for a given vdev
>      here, <values> = vdev_id
>   3) WMI_DEBUG_LOG_PARAM_VDEV_DISABLE - disable debug log for a given vdev
>      except ERROR logs
>      here, <values> = vdev_id
>   4) WMI_DEBUG_LOG_PARAM_VDEV_ENABLE_BITMAP - set vdev enable bitmap
>        here, <values> = vdev_enable_bitmap
>   5) WMI_DEBUG_LOG_PARAM_MOD_ENABLE_BITMAP - set a given log level to all the
>      modules specified in the module bitmap. Command to configure for this log param,
> 
>      $ echo "5 <values> <module_id_index> <is_end>" >
>          /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
>      here,
>                 <values> = <0xaaaaaaaa000000bb>, 'aaaaaaaa' - module bitmap and
>                           'bb' - loglevel
>                 <module_id_index> = index of module bitmap. Max module id is 512.
>                                     So, module_id_index is 0-15.
>                 <is_end> = to indicate if more configuration to follow.
> 
>   6) WMI_DEBUG_LOG_PARAM_WOW_MOD_ENABLE_BITMAP - Wow mode specific logging enable.
>      Command to configure for this log param,
> 
>       $ echo "6 <values> <module_id_index> <is_end>" >
>           /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
>       here,
>                  <values> = <0xaaaaaaaa000000bb>, 'aaaaaaaa' - module bitmap and
>                               'bb' - loglevel
>                  <module_id_index> = index of module bitmap. Max module id is 512.
>                                      So, module_id_index is 0-15.
>                  <is_end> = to indicate if more configuration to follow.
> 
> Sample command usage,
> 
> To enable module WLAN_MODULE_WMI and log level ATH11K_FW_DBGLOG_VERBOSE,
> echo "1 0x10001" > /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
> 
> To enable module bit map from 32 to 63 and log level ATH11K_FW_DBGLOG_VERBOSE,
> echo "5 0xffffffff00000001 1 1" > /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f295ad912910 ath11k: Add debugfs interface to configure firmware debug log level

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1642405103-32302-1-git-send-email-quic_seevalam@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

