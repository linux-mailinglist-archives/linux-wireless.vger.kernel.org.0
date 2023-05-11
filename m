Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35346FF1E6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbjEKMxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbjEKMxJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 08:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F4114
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 05:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6AF60B6C
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 12:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F30C433EF;
        Thu, 11 May 2023 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683809587;
        bh=vrwNv8UOHd9zmQ4WDUTtr6XR07Kn+EBqJVB9zZpIN2w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LZLl1CNRbsT/Js0loh5B5yTGOPhExVLknynOVRZO08/2ShQY145YAQ9ZApnLEZxvA
         glVm5I8nrZH4qnlyQw9WLuW+vvwJ+FnBcu5DttH5f8zpyqnuDusIgkJDqxUgv8CJmr
         RSFK/7S3aC0WMITtn2VBUdAyb5d5T69mmGV3mRd51Dh9toUpGDHITAYUBWKHXPU9Fk
         hclftY2IXePUvq3zs5rqquRr5nXeQea4cVc+KAblb9gh84sbWRGOTQSGVQSf+2Z89r
         8bMmGcVW/4oI19048iX6USbbGT6n3OEPu8DF7F6q+LGSYgcwzk+73ss8geDN3LZotg
         NcuUBIq5oa4wg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: wilc1000: fix for absent RSN capabilities WFA testcase
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230421181005.4865-1-amisha.patel@microchip.com>
References: <20230421181005.4865-1-amisha.patel@microchip.com>
To:     <Amisha.Patel@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Amisha.Patel@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168380958442.27145.12281975791155071322.kvalo@kernel.org>
Date:   Thu, 11 May 2023 12:53:06 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Amisha.Patel@microchip.com> wrote:

> From: Amisha Patel <amisha.patel@microchip.com>
> 
> Mandatory WFA testcase
> CT_Security_WPA2Personal_STA_RSNEBoundsVerification-AbsentRSNCap,
> performs bounds verfication on Beacon and/or Probe response frames. It
> failed and observed the reason to be absence of cipher suite and AKM
> suite in RSN information. To fix this, enable the RSN flag before extracting RSN
> capabilities.
> 
> Fixes: cd21d99e595e ("wifi: wilc1000: validate pairwise and authentication suite offsets")
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

Patch applied to wireless-next.git, thanks.

9ce4bb09123e wifi: wilc1000: fix for absent RSN capabilities WFA testcase

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230421181005.4865-1-amisha.patel@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

