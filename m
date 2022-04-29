Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8B514606
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355195AbiD2J4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357100AbiD2J4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 05:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A406DF5A;
        Fri, 29 Apr 2022 02:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15EF362279;
        Fri, 29 Apr 2022 09:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCE5C385A7;
        Fri, 29 Apr 2022 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651225974;
        bh=4dX3RZKOAnpU33fOLqblNxRSAKqlEVe0S6NJCykWw3g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PV+lTtIAj27xwe/KlxXM8OCFDfRtERz2sAgqWHIvCZ9/Yfk1MLe3MT/5VT+rvQoGy
         T/bt4tEQ8GI72joQDVBWouhGtI8vSosrPPcqM3yamjxAG9JZzrfcybY9+co3dT5+I7
         zMw57GgGEgc3MANlJJa0TVJJKlfLUSdPxjX8WaoyKuUNf4xUA9KNq4tda0OjNmYYUN
         lFJUp16QdS1giYeyAOfD6asLvGGYYdTdQSRC1WOLldVF0ftLlLOCHjrM5ABTN79NKm
         p6FQgAwUYX9LPhqdc54orx1tPnPDp9WeWOT/rzUqDmc5OaO+4jNzht2eIpX89bfdFf
         N3jx6PkslIDGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v6 4/9] ath11k: Add register access logic for WCN6750
References: <20220427111848.9257-1-quic_mpubbise@quicinc.com>
        <20220427111848.9257-5-quic_mpubbise@quicinc.com>
        <87pml2g1c7.fsf@kernel.org>
        <6e607455-e42a-a591-f58b-b3b2c83ea2cc@quicinc.com>
Date:   Fri, 29 Apr 2022 12:52:49 +0300
In-Reply-To: <6e607455-e42a-a591-f58b-b3b2c83ea2cc@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 27 Apr 2022 18:56:33 +0530")
Message-ID: <87h76cdxn2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

>>> @@ -704,11 +718,26 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>>   {
>>>   	struct ath11k_base *ab;
>>>   	struct ath11k_pci *ab_pci;
>>> +	const struct ath11k_bus_params *bus_params;
>>>   	u32 soc_hw_version_major, soc_hw_version_minor, addr;
>>>   	int ret;
>>>   +	switch (pci_dev->device) {
>>> +	case QCA6390_DEVICE_ID:
>>> +	case WCN6855_DEVICE_ID:
>>> +		bus_params = &ath11k_pci_bus_params_qca6390;
>>> +		break;
>>> +	case QCN9074_DEVICE_ID:
>>> +		bus_params = &ath11k_pci_bus_params_qcn9074;
>>> +		break;
>>
>> Now you are making bus_params device specific, that's not really the
>> point of bus params. They are supposed to be _bus_ specific parameters.
>>
>> Can't you use hw_params like I mentioned in the review?
>>
>
> Even without this patch, as of today, bus_params is already device
> specific with QCN9074 changing the static_window_map in bus_params to
> true in ath11k_pci_probe().

Yeah, that's a mistake which slipped in review.

> And if we have to move these device specific bus_params to hw_parmas,
> then bus_params can be pretty much removed completely with the changes
> that WCN6750 bring in. Any thoughts on this? I can make the changes
> that can get along with WCN6750 series.

My original idea with bus_params was to there are bus specific
parameters and that way we could simplify hw_params. Clearly that's not
working and I agree with you, bus_params should be removed. So it would
be good if you can do that in the next patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
