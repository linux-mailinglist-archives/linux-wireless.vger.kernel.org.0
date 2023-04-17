Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B56E4B74
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDQO17 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQO16 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007A5B9B
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E11661C01
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 14:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C88C433EF;
        Mon, 17 Apr 2023 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681741676;
        bh=kQ89RqR3vyMHs4lrtUkl49TDqulexyeGzMps29u9i8U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RoZMxYBJCt4tV0PkQVsOpIk/LjcoX+J4yKwBWuOaDj0xNrFh3VrBxocDCrapDBjZx
         nOQYdel0IRW8pZKEGP1CJcChCHhj6QJYE8/6ZgnkrLfh/ushW8rcc7oDdcBatGdp9Z
         LgZhTtmYgwrRNQ5G2pRkqmIMUOIp5EoNeotfnEzvQzsegy1NGeuIInNZRBwWd2Es9P
         Ch0yhkwuE7HoFasuZ4Kn8mudEGTYDEGSgPj9/8dN9UNUJmkVsrZhMGVU/ms3qiyoxx
         K7yGrOnSnXSxYYSr/pSZPVLDXlNdQLkkizhnOVeyXG3MojakSZRtVHh5omkNcVt88b
         OZmWZrDXUbPJw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: send WMI_PEER_REORDER_QUEUE_SETUP_CMDID when ADDBA session starts
References: <20230404070158.3368530-1-quic_cjhuang@quicinc.com>
Date:   Mon, 17 Apr 2023 17:27:50 +0300
In-Reply-To: <20230404070158.3368530-1-quic_cjhuang@quicinc.com> (Carl Huang's
        message of "Tue, 4 Apr 2023 15:01:58 +0800")
Message-ID: <87cz42wpll.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> writes:

> Low receive throughput is seen on WCN7850 because ADDBA related
> parameters are not updated to firmware when receive ADDBA session starts.
>
> Fix it by sending WMI_PEER_REORDER_QUEUE_SETUP_CMDID again to firmware
> to update the ADDBA related parameters for chips which have false
> reoq_lut_support in hw_params. For chips which have true reoq_lut_support
> in hw_params don't need this command to send to firmware.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index e78478a5b978..256e4cbfae54 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -977,6 +977,9 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
>  			ath12k_warn(ab, "failed to update reo for rx tid %d\n", tid);
>  			return ret;
>  		}
> +		if (!ab->hw_params->reoq_lut_support)
> +			ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac,
> +								     paddr, tid, 1, ba_win_sz);
>  
>  		return ret;
>  	}

This added new warnings:

drivers/net/wireless/ath/ath12k/dp_rx.c:981: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath12k/dp_rx.c:982: line length of 95 exceeds 90 columns

I fixed them in the pending branch. There was also no warning message if
ath12k_wmi_peer_rx_reorder_queue_setup() fails, I added that as well:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=750111a1341bba3b4f679ff97891fb1943f3643c

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
