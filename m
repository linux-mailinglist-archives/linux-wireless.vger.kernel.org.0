Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6C6714B1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 08:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjARHPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 02:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjARHO6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 02:14:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0B75731
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 22:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E1E616C4
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 06:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAF1C433D2;
        Wed, 18 Jan 2023 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674023942;
        bh=IW4RxImM0AEh/L0YOiXTQp515dc31h+RKJMCNMFwJMU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dEmaKn7kToJUnZ4FvaM5vXUatlXjdTRHM8N4FSzb4Xw6t8sdPA4FdBUnaOdM35Z7A
         cWMfL1klYX7JsiEnsfLimsaAndsm31uQyWFZtK6heF+HZcu5m0ULZtcc/qfYa37k+j
         5OAmA9r4B9hkH+whbL1+8RpTPa2SOUMw2t5ftlGb/pwib9GyEAe1Eh2bYxePPz8bwj
         ITG5ewryNucEpp+5k4Jn9gHZZD2iWTjrMttVmfcWHLkhWRWW+AWSpr6BNQ+y119quL
         i+0QicRsCEXHMxleqWw8YZrSWOTl+q0x2PTSLnRyvy75CL/NMqbKAdrREXWuQKcjSQ
         qqCnF9homck9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: Fix incorrect qmi_file_type enum values
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221223050646.27785-2-quic_dinek@quicinc.com>
References: <20221223050646.27785-2-quic_dinek@quicinc.com>
To:     Dinesh Karthikeyan <quic_dinek@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167402394013.24104.16832782680191250462.kvalo@kernel.org>
Date:   Wed, 18 Jan 2023 06:39:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dinesh Karthikeyan <quic_dinek@quicinc.com> wrote:

> Enum value for caldata in QMI_WLANFW_BDF_DOWNLOAD_REQ_V01 is set as 1
> which is reserved for BDF_TYPE_ELF. The expected qmi_file_type value
> for caldata is 2.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

27d7e348efb3 wifi: ath12k: Fix incorrect qmi_file_type enum values
42982259e9b7 wifi: ath12k: Add new qmi_bdf_type to handle caldata
801fc159e30d wifi: ath12k: Add support to read EEPROM caldata

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221223050646.27785-2-quic_dinek@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

