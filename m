Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B676F1E0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjHCSbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHCSbb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 14:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C723110
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 11:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 009E661E48
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 18:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EC9C433C8;
        Thu,  3 Aug 2023 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691087489;
        bh=mkGPjy+loIDmO8JmcO7/O86tOi7CGEUCjA4ltV55Hfs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Zgw6ELPJCZc7fbnwSBRJTI6ShjVQ9Hmtk1FN8xIh3E5JaSyTFDA1FkJ11SM9swqAy
         wW86a77DkN81aTI3TMl9kNwhEcrSJuQkGZb2JnyBvTLWxNb/hdoOYYVEr7FA44ytfm
         I3sQtwdK2x9DNbCI3m4GxoAjHJNf/oi39PKoRGANUkGNxKSqkw07qNpCe+e+1cIftG
         xpbzz3L+8YX4YI2YQjUCvByBmTglM94V6sO/p5EMnJmRns+PjDLg7/34RUY/eT3jaH
         R7B2mM54KguC06mgTcZ0e5AyQPqNe+7n709NEknyo5+vsrv2dHkBHWWxbpRhpfHSwL
         EyBuvoNmTe75A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     mhi@lists.linux.dev, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/3] bus: mhi: host: allow MHI client drivers to
 provide the firmware via a pointer
References: <20230727100430.3603551-1-kvalo@kernel.org>
        <20230727100430.3603551-2-kvalo@kernel.org>
        <20230802110110.GD57374@thinkpad>
Date:   Thu, 03 Aug 2023 21:31:51 +0300
In-Reply-To: <20230802110110.GD57374@thinkpad> (Manivannan Sadhasivam's
        message of "Wed, 2 Aug 2023 16:31:10 +0530")
Message-ID: <877cqcyo2w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <mani@kernel.org> writes:

> On Thu, Jul 27, 2023 at 01:04:28PM +0300, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> Currently MHI loads the firmware image from the path provided by client
>> devices. ath11k needs to support firmware image embedded along with meta data
>> (named as firmware-2.bin). So allow the client driver to request the firmware
>> file from user space on it's own and provide the firmware image data and size
>> to MHI via a pointer struct mhi_controller::fw_data.
>> 
>> This is an optional feature, if fw_data is NULL MHI load the firmware using the
>> name from struct mhi_controller::fw_image string as before.
>> 
>> Tested with ath11k and WCN6855 hw2.0.
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> I can apply this for 6.6 and then you can merge ath11k changes for
> 6.7.

Yeah, to keep things simple please apply patch 1 for v6.6. Then I'll
apply patches 2-3 for v6.7 (after fixing Jeff's findings).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
