Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6F58F713
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiHKEzM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 00:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHKEzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 00:55:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2266A52
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 21:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 94EA7CE1847
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 04:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B8DC433C1;
        Thu, 11 Aug 2022 04:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660193706;
        bh=/R2TqnSbJxIKcKa+IbinmolWAkYLruxSVtFn4OWCcyY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WFOVVX2frp7skqJVZdYNdgVfcnyS4xe11ThfefQRrJia8Jj5IExfC3jnYibQgP8E8
         cprFCleAL77SAeIyvAoSV3QXFVCc4sg3iqH5TAbzAofE69QN6bXj6ldVqPWeqBItIA
         E1U+uC3hWpWcyx1NzAnCUCG/HIdXt1MgTNRKOfHxtnE0BMKnxP+jVkFiX2M/K8rGbH
         R5CFjUswiAILe4AqqtIqSoKlXw9mkA2PbctQl+S88cKSWWhnm+WYYCKn/0T5etPDxo
         eVIAGRV0+b14IbXit4+0RG4qzENJn5HyMJqTEBYdZitBNqERRcHYbkcpmWhyzxsOKL
         Nz5mRE1CdezAQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org,
        Claudiu.Beznea@microchip.com, Sripad.Balwadgi@microchip.com,
        mwalle@kernel.org
Subject: Re: [PATCH v3] wifi: wilc1000: fix DMA on stack objects
References: <20220809075749.62752-1-ajay.kathat@microchip.com>
        <b1e606e7a36fb900bbc664bbd585ff6a@walle.cc>
Date:   Thu, 11 Aug 2022 07:55:01 +0300
In-Reply-To: <b1e606e7a36fb900bbc664bbd585ff6a@walle.cc> (Michael Walle's
        message of "Wed, 10 Aug 2022 14:07:52 +0200")
Message-ID: <87k07fgz16.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Michael Walle <michael@walle.cc> writes:

> Am 2022-08-09 09:57, schrieb Ajay.Kathat@microchip.com:
>> Sometimes 'wilc_sdio_cmd53' is called with addresses pointing to an
>> object on the stack. Use dynamically allocated memory for cmd53 instead
>> of stack address which is not DMA'able.
>>
>> Fixes: 5625f965d764 ("wilc1000: move wilc driver out of staging")
>> Reported-by: Michael Walle <mwalle@kernel.org>
>> Suggested-by: Michael Walle <mwalle@kernel.org>
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>
> Thanks!
>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Tested-by: Michael Walle <mwalle@kernel.org>

Thanks Michael. My plan is to take this to the wireless tree, seems
important enough fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
