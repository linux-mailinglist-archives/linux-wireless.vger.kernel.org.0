Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CEE7317FB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjFOL6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 07:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245381AbjFOL6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 07:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36533AAE
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 04:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3262362E05
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 11:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B263C433C8;
        Thu, 15 Jun 2023 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829911;
        bh=gSsUQv6QcWREjEXlxHDwH17Cf4vOtWTj2MxWO/6SmwQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tl7KXn3xsbb6LzemF/96AG3syv4nIR8y6armLhv/y+IKfLVBA3wn5qVlVd2OJYrw0
         ahTVX8SWWPo440HQ2gFTSQQb0kehBX5oWkxN0+5BbtdvMJm5B+2UkCl2yXyDcGRoTH
         NvrjgW2fyw5t+z93zMz1yfAPjSKRQjqdjlWviNisBxQEaaNa3sKv6xkY56k/UzLA93
         dn3o+07BAvnZboks7HJctwF3mCjnxdNbURP2T+1aXSveVyVcMPpba1W7SbFO6U6/gH
         8N37+crOjrXlytmtgPB9nR3v2XDnyheCgtuP22D8A6lQK5Mqbk+teWWUAeRMptBy+v
         jMvH4tOLBVP+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: Re: [PATCH v4 04/11] wifi: ath12k: propagate EHT capabilities to userspace
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
        <20230602235820.23912-5-quic_alokad@quicinc.com>
Date:   Thu, 15 Jun 2023 14:51:47 +0300
In-Reply-To: <20230602235820.23912-5-quic_alokad@quicinc.com> (Aloka Dixit's
        message of "Fri, 2 Jun 2023 16:58:13 -0700")
Message-ID: <87pm5xaqp8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> Propagate EHT capabilities to the userspace using a new member
> 'eht_cap' in structure ieee80211_sband_iftype_data.
>
> MCS-NSS capabilities are copied depending on the supported bandwidths
> for the given band.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu<quic_pradeepc@quicinc.com>

[...]

> +static void ath12k_mac_copy_eht_ppet_ru(u32 ppet, u8 ppe_thres[], int ru)
> +{
> +	int i;
> +	u32 val = 0;
> +	u8 ppet_size_ru = IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE * 2;
> +	u8 bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
> +
> +	u32p_replace_bits(&val, ppet >> (ru * ppet_size_ru),
> +			  GENMASK(ppet_size_ru - 1, 0));
> +
> +	val = ((val >> IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE) & GENMASK(2, 0)) |
> +	      ((val & GENMASK(2, 0)) << IEEE80211_EHT_PPE_THRES_INFO_PPET_SIZE);

This shifting of val looks weird. I didn't check the spec, what does it
do? Is there any cleaner way to do this? And should have a define for
GENMASK(2, 0)?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
