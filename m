Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335D07D67A8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjJYJ5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYJ5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 05:57:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50891B4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 02:57:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0969CC433C8;
        Wed, 25 Oct 2023 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698227839;
        bh=XH0mySti5cO3fR7h0L9DVAHGidW+BOWuspUP3B9M5QE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ln2oYs7bnaxB3alqOBqNDzqsH1x6WiC4huVQ0Q0UNpHmYlBlFjYWvfvxPGEhp6XoN
         Wh0IGqJiS1I0dVCeaDBQy9zUqr/LumfroUHrg7uKAUr7GbnJN4lKVy+0zDrw8Uhh+q
         GRnbW0VyAKaP+yFSNIls/dUeNtEvM8x4oPC6KIoIspVHXlPyFfDkqQAFol6HS8ysaw
         F7tOTb72p0uxd2VxyyMbAgVoTgeGu0FNrEqNOPfZeICuYhM2wWD+cvofhMcaGxpxxj
         CvafzzKPwmP/TMZGU+Y0jhqSwlhaUBeAMszfRZ76l9v/zQQM6+/1/vdUxpd/TYyqI5
         EYLDIcYLjlMAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: rename the wmi_sc naming convention to
 wmi_ab
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231018153008.29820-2-quic_periyasa@quicinc.com>
References: <20231018153008.29820-2-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822783577.891844.18069802184068494913.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 09:57:17 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> In WMI layer module, the identifier wmi_sc is used to represent
> an instance of ath12k_wmi_base structure. However, within ath12k,
> the convention is to use "ab" to represent an SoC "base" struct.
> So change the all instances of wmi_sc to wmi_ab.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

25ebf4c3c141 wifi: ath12k: rename the wmi_sc naming convention to wmi_ab
cda8607e824b wifi: ath12k: rename the sc naming convention to ab

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018153008.29820-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

