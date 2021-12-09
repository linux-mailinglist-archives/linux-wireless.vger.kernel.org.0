Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EBD46EC86
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhLIQI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhLIQIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 11:08:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A5C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 08:05:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86511B8254B
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 16:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D5CC004DD;
        Thu,  9 Dec 2021 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639065919;
        bh=R1H1+X2TdX7qLWWKSZ+yPIZbGpjcqddy8hYUbMEIC4c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G5GWGhpc8gyekR9aLYkFOAPe2ylmbVjPnz5Yqr6iRou89jhMY0a8nEn5kPLkLD5+b
         T0/cwfg4nmJhwGrdT286l/5xXJeCQwghyDfc7pzMVFmIipvzxEacnDCTjYjSA1y2xA
         i6S6KXAj8GALRCjDHRchMTgMyevtgfFtw1LVyuB3QI+VYre0E4fkpF+9TiPId0PrGr
         8mTNcRDLyE4j8Aka9u9zxA0a9WrdZQsfwiS3rZCnoEEvgYAn+puaGPCmAb6ILNQ08Y
         ojRLixv63trqbRsZHAuoJRIDFq5OktQ+nfZVVJZ/AZz4ifqipn5sKS9wMNHwiIvoWV
         k6qzRCEK5lz0A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
        <20211011193750.4891-7-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 18:05:14 +0200
In-Reply-To: <20211011193750.4891-7-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:50 -0400")
Message-ID: <87lf0tydad.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Host sets GTK related info to firmware before WoW is enabled, and
> gets rekey replay_count and then disables GTK rekey when WoW quits.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -5850,6 +5850,41 @@ struct wmi_set_arp_ns_offload_cmd {
>  	 */
>  } __packed;
>  
> +#define GTK_OFFLOAD_OPCODE_MASK             0xFF000000
> +#define GTK_OFFLOAD_ENABLE_OPCODE           0x01000000
> +#define GTK_OFFLOAD_DISABLE_OPCODE          0x02000000
> +#define GTK_OFFLOAD_REQUEST_STATUS_OPCODE   0x04000000
> +
> +#define GTK_OFFLOAD_KEK_BYTES       16
> +#define GTK_OFFLOAD_KCK_BYTES       16
> +#define GTK_REPLAY_COUNTER_BYTES    8
> +#define WMI_MAX_KEY_LEN             32
> +#define IGTK_PN_SIZE                6
> +
> +struct wmi_gtk_offload_status_event {
> +	u32 vdev_id;
> +	u32 flags;
> +	u32 refresh_cnt;
> +	u8 replay_counter[GTK_REPLAY_COUNTER_BYTES];
> +	u8 igtk_key_index;
> +	u8 igtk_key_length;
> +	u8 igtk_key_rsc[IGTK_PN_SIZE];
> +	u8 igtk_key[WMI_MAX_KEY_LEN];
> +	u8 gtk_key_index;
> +	u8 gtk_key_length;
> +	u8 gtk_key_rsc[GTK_REPLAY_COUNTER_BYTES];
> +	u8 gtk_key[WMI_MAX_KEY_LEN];
> +} __packed;

[...]

> +	arvif->rekey_data.replay_ctr = le64_to_cpup((__le64 *)ev->replay_counter);
> +	/* supplicant expects big-endian replay counter */
> +	replay_ctr = cpu_to_be64(le64_to_cpup((__le64 *)ev->replay_counter));
> +
> +	ieee80211_gtk_rekey_notify(arvif->vif, arvif->bssid,
> +				   (void *)&replay_ctr, GFP_KERNEL);

Please avoid casting as much possible, and also otherwise this just
looks weird. Isn't ath11k WMI commands and events supposed to be in CPU
endian and the firmware automatically translates them if CPU is little
or big endian? So why do you cast ev->replay_counter to __le64 then?
Wouldn't that break on big endian?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
