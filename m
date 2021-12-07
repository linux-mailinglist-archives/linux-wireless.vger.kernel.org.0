Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3871946C0DB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhLGQn3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 11:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLGQn3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 11:43:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E611C061574
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 08:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5887B81858
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 16:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DACEC341C1;
        Tue,  7 Dec 2021 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638895195;
        bh=1spnHwy4th204lc7pdZzCubOOyR435yRFE5cuojtAT4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AnkrF1MHMmZ3aeaNmmg4u3PjbksJowuUf70GOulIAYKB01Z4QpjfOgz05Lm0aGI0I
         8Lr/eLqjdBGQTL9buA4OodT0pNF78KGJxS+vrfcfGgsgfjWpAk7oDAkudDJ9BUe2G/
         ciJnovd8VHowdEvTqLJhMB0li/rnBYigxuQllFprkRbZ67dLrlY4XSNobtGEHBHfaP
         HJV5flOf1gw5ar+GxLrALmpT8yWtywyE8g1rOXTVzCo7bVgCuguvorvFNCXx6Q5ucW
         5A4VbJ63vsSWiSkEu5aoA9EV8M9wonxZSErl7Oe4iMM/vNxMRLY13Q3PAxoXdy5WCe
         5MfR9NvpEnsYA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv2 1/2] ath11k: add dbring debug support
References: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
Date:   Tue, 07 Dec 2021 18:39:49 +0200
In-Reply-To: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
        (Venkateswara Naralasetty's message of "Fri, 19 Nov 2021 14:38:20
        +0530")
Message-ID: <8735n4nzca.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> writes:

> Target copies spectral report and CFR report through dbring to
> host for further processing. This mechanism involves ring and
> buffer management in the Host, FW, and uCode, where improper
> tail pointer update issues are seen.
>
> This dbring debug support help to debug such issues by tracking
> head and tail pointer movement along with the timestamp at which
> each buffer is received and replenished.
>
> Usage:
>
> echo <module_id> <val> > /sys/kernel/debug/ath11k/ipq8074_2/
> mac0/enable_dbr_debug
>
> module_id: 0 for spectral and 1 for CFR
> val: 0 - disable, 1 - enable.
>
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

The commit log is really minimal and is not really describing the whole
implementation. For example, I see that you create a new directory
debugfs and the commit log mentions nothing about that.

What about other hardware like QCA6390 or WCN6855? You mention nothing
about those, how are they affected?

And to be honest, I'm not sure if this debug feature is really worth to
have in upstream due to the extra complexity it creates.

Also usually it's a good idea to have the fix first in the patchset and
then extra patches after the fixes. That way it's easy to take the fixes
and skip the extra patches.

Few comments when I was skimming this over:

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -442,6 +442,7 @@ struct ath11k_debug {
>  	u32 pktlog_peer_valid;
>  	u8 pktlog_peer_addr[ETH_ALEN];
>  	u32 rx_filter;
> +	struct ath11k_db_module_debug *module_debug[WMI_DIRECT_BUF_MAX];

module_debug is not really a descriptive name for a field.

> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> @@ -50,6 +50,45 @@ static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
>  	"MONITOR_DEST_RING",
>  };
>  
> +void ath11k_dbring_add_debug_entry(struct ath11k *ar,
> +				   enum wmi_direct_buffer_module id,
> +				   enum ath11k_db_ring_dbg_event event,
> +				   struct hal_srng *srng)
> +{

The style used in ath11k is that the second word describes the filename
the function is in. So this should be something like
ath11k_debugfs_add_dbring_entry().

> +	struct ath11k_db_module_debug *db_module_debug;

Similar naming for structs, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
