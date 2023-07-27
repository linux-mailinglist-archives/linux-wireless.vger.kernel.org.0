Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F204376508C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjG0KHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjG0KHl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 06:07:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590DF13D
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 03:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBBA361E02
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D641C433C8;
        Thu, 27 Jul 2023 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690452459;
        bh=4B7J3DgvOBHGo6p3m1Nd1vpZc8QRGoaL/MdCOq/oGho=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YwNloGl6NwR7YLPFl1+21K5endW0UBtm/9XPXImzx/v5aBkoHS0KfYT1dBLhARGGd
         o0k6NDeaRhzm6jexbkg7CBtTz8FssBkMl/3mZC6z6+OpR2g1iQAXOuEyPrwzhH07qp
         5odZrJJ3eVR0M6iVH6yA3NwauvI70+hHoeMH3zEsOUMOM7/WJ1aVjbyKJITpFwCf2F
         /xF2A1OQCTBRJ42N4ax40vF6mv3G9pRKGZ26b46++NcWBe+PrzpW0GBPy2mF96P/P/
         Mw26MohcRDPUyudVtYEMZheDhRv/pKWf6FbttuyF724jjupxn0qEpZpkKhe0iotC0h
         xPkof6Yq2nabA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     <mhi@lists.linux.dev>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] bus: mhi: host: allow MHI client drivers to
 provide the firmware via a pointer
References: <20230530141813.29333-1-kvalo@kernel.org>
        <20230530141813.29333-2-kvalo@kernel.org>
        <6494e9f5-a4df-c058-49bb-1ebfeca5a91d@quicinc.com>
Date:   Thu, 27 Jul 2023 13:07:36 +0300
In-Reply-To: <6494e9f5-a4df-c058-49bb-1ebfeca5a91d@quicinc.com> (Jeffrey
        Hugo's message of "Fri, 2 Jun 2023 11:17:22 -0600")
Message-ID: <877cql1xcn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -299,6 +299,10 @@ struct mhi_controller_config {
>>    * @iova_start: IOMMU starting address for data (required)
>>    * @iova_stop: IOMMU stop address for data (required)
>>    * @fw_image: Firmware image name for normal booting (optional)
>> + * @fw_data: Firmware image data content for normal booting, used only
>> + *           if fw_image is NULL (optional)
>
> It looks like your implementation requires fbc_download to be set, and
> while you mention that for fw_sz, you don't mention it here.  While I
> think this would be useful for non-fbc usecases, we don't have that
> use currently.

Thanks for the review. I submitted v4 to fix this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
