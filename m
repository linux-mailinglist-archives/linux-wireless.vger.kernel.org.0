Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3375FABA1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJKEbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 00:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKEbT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 00:31:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5013857D3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 21:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22182B810CC
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 04:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2180C433D6;
        Tue, 11 Oct 2022 04:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665462675;
        bh=eTCW46MHQduaWM8HF4jpZS4margqI5deX1yNarhMF9k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n4rI2GD7ZIhshWuYwRr3clbBsv9AO1puTKiLcyxIVv9Pl0EYlQtUOnoaBhkWNrcGH
         o25Budunrw3Xzh/03Fj7hGr46obPkjAP+UiA9Wxw2YCOaf+bKIt7ltAmqsfzQKUPrI
         buDXpeGqPEfDAgwQ7tsZSp/Ef/lm591NTKANy+NyC08iUiAepn7/CFo0BMh6I4+cTX
         KfYBuvPE8dtz2vUxLCgixmrhYFqSiYJoWrAjbKjac1ekLNigVaig4cNeq6EpX3Zbmc
         4Tnyb+qlopO19IW+NP+m01kQzchSw8tkkLJoF/A1n6xepEUhHnGdwBAxmAdDqAjt4I
         rwLU/LbYgeoWA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect
In-Reply-To: <0526d034-2cb9-527e-b338-f73db0ed005b@quicinc.com> (Wen Gong's
        message of "Tue, 11 Oct 2022 11:58:58 +0800")
References: <20220928081413.27339-2-quic_wgong@quicinc.com>
        <166542536986.511.1244496445875563981.kvalo@kernel.org>
        <f50c94b9-252f-25ab-4650-bed52762bc4d@quicinc.com>
        <0526d034-2cb9-527e-b338-f73db0ed005b@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 11 Oct 2022 07:31:10 +0300
Message-ID: <87czazoub5.fsf@kernel.org>
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

Wen Gong <quic_wgong@quicinc.com> writes:

> On 10/11/2022 11:53 AM, Wen Gong wrote:
>
>> On 10/11/2022 2:09 AM, Kalle Valo wrote:
>>> Wen Gong <quic_wgong@quicinc.com> wrote:
>>>
>>>> When switch to connect to a new AP for station which is already
>>>> connected
>>>> to an AP, the time cost is too long, it arrives 10 seconds.
>>>>
>>>> The reason is when switch connection, disconnect operation happened on
>>>> the 1st AP, then 11d scan start command sent to firmware, and then a
>>>> new hw scan arrived for the 2nd AP. The 11d scan is running at this
>>>> moment, so the hw scan can not start immediately, it needs to wait
>>>> the 11d scan finished, it increased the time cost of switch AP and
>>>> even happened scan fail as log below after apply the incoming patch.
>>>>
>>>> [ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>> [ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>> [ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>>>
>>>> Change to set 11d state while disconnect, and the 11d scan will be
>>>> started after the new hw scan in ath11k_mac_op_hw_scan(). Then the
>>>> time cost of switching AP is small and not happened scan fail.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI
>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>>
>>>> Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
>>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> I still see warnings:
>>>
>>> [ 3627.691737] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>> [ 3715.435608] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>> [ 3860.333214] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>> [ 4542.000955] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>>> [ 4604.018451] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
>> The failed log is now happened frequently as before, I will change
>> it again to suppress the failed log.
> change typo.
> The failed log is NOT happened frequently as before, I will change it
> again to suppress the failed log.

Please think about this more, ignoring errors doesn't sound like a good
solution.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
