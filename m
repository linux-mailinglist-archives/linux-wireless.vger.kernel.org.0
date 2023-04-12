Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA64A6DF020
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDLJTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLJTJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 05:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB99768F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 02:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAEC060F78
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 09:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C112C4339B;
        Wed, 12 Apr 2023 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681291147;
        bh=bzUvRwr59wVHRCDw1b7h2SYW2FjX9c1LwaIMpXjxMC0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gR3sR1H8RAfDkkf3k9GB1vF9MrG4JOn8jsLuLs+DXzFSTyURE39ukj8p13W5O6IAW
         gb73EdhiBQ/2dqB0XQ0Cc3iSHdhcwX7nOJ/619pzVD9u4XlJDid4L3LLCIuY5hcsie
         70eRKsuDXqhuN9iStOK3Dpg//AIUTyMTo1idEYwGi/z+34dS3WL9/NLR9pkHTntJBr
         66m8xpAkB9RaluqcO9fOLby1Zj774yqnrDwGI2BmvIM/NzhB8V8CtrijCnLWGIyGqv
         h6INV4zfsVPl0SgQ0o5O8Xm4jpvP9Zan2FahSkfyqhZOx9uUp8jXOR9QJxAkGSRyQT
         7wPpzcHGViZ9w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: Re: [PATCH v2 06/11] wifi: ath12k: prepare EHT peer assoc parameters
References: <20230403225146.14139-1-quic_alokad@quicinc.com>
        <20230403225146.14139-7-quic_alokad@quicinc.com>
        <b3282c7d-07c5-8657-fca2-c286f82cb235@quicinc.com>
Date:   Wed, 12 Apr 2023 12:19:03 +0300
In-Reply-To: <b3282c7d-07c5-8657-fca2-c286f82cb235@quicinc.com> (Aloka Dixit's
        message of "Mon, 10 Apr 2023 09:22:53 -0700")
Message-ID: <87r0sp8nlk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> On 4/3/2023 3:51 PM, Aloka Dixit wrote:
>
>> Add new parameters and prepare the association data for an EHT peer.
>> MCS data uses the format described in IEEE P802.11be/D2.0, May 2022,
>> 9.4.2.313.4, convert it into the format expected by the firmware.
>>
>> +	case IEEE80211_STA_RX_BW_320:
>> +		bw = &eht_cap->eht_mcs_nss_supp.bw._320;
>> +		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
>> +				       bw->rx_tx_mcs9_max_nss,
>> +				       bw->rx_tx_mcs11_max_nss,
>> +				       bw->rx_tx_mcs13_max_nss,
>> +				       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_320],
>> +				       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_320]);
>> +		arg->peer_eht_mcs_count++;
>> +		fallthrough;
>> +
>> +	case IEEE80211_STA_RX_BW_160:
>> +		bw = &eht_cap->eht_mcs_nss_supp.bw._160;
>> +		ath12k_mac_set_eht_mcs(bw->rx_tx_mcs9_max_nss,
>> +				       bw->rx_tx_mcs9_max_nss,
>> +				       bw->rx_tx_mcs11_max_nss,
>> +				       bw->rx_tx_mcs13_max_nss,
>> +				       &rx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_160],
>> +				       &tx_mcs[WMI_EHTCAP_TXRX_MCS_NSS_IDX_160]);
>> +		fallthrough;
>> +
>
> 'arg->peer_eht_mcs_count++' is missing for 160 MHz case.
> Should I send a follow-up now for the series or wait for comments on
> the remaining part for some time.

Sending a new version sounds like the best.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
