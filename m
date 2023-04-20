Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441246E94A5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjDTMiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjDTMiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0C61B4
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3C56186A
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8F1C4339B;
        Thu, 20 Apr 2023 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994288;
        bh=bRIqKxs/XmapCuvMwQSaCugpnPI8IU0Apf4d79oPK60=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OkG1Fv7oqefosFhIC8VW7D++kZLu8lk0nkxFnvQqhh73Zq6w+h9eSsJlvGhJIEKPC
         /NTST4nLMCT1khDAGqa2N3JC0t3nAcwxXp5LzgPOXzaTve+LPWuULYJ4Z5PLxrKFkH
         iT1fl152rZAP5qsoHT518Wm7KqgyblpK51Z5/0HwUoqeX0ObtNqHeLLKjyGy4G28kl
         MwpEAOFJPn5HVVK5Tyxj/99yS6h8ghWRfd9sRO5zrTlncmzFE3IYH8YMLyKaRRfqT6
         foacOBefrpOfMbhIuGvfxIhCHRAcmKK2KGstf+kJbAXMuSCXAT0jrlWZYqSOJp7poU
         87zHYj2c0C7iw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230417184145.12593-1-amisha.patel@microchip.com>
References: <20230417184145.12593-1-amisha.patel@microchip.com>
To:     <Amisha.Patel@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Amisha.Patel@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168199428508.31131.1273170742280749933.kvalo@kernel.org>
Date:   Thu, 20 Apr 2023 12:38:07 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Amisha.Patel@microchip.com> wrote:

> Mandatory WFA testcase
> CT_Security_WPA2Personal_STA_RSNEBoundsVerification-AbsentRSNCap,
> performs bounds verfication on Beacon and/or Probe response frames. It
> failed and observed the reason to be absence of cipher suite and AKM
> suite in RSN information. To fix this, enable the RSN flag before extracting RSN
> capabilities.
> 
> Fixes: cd21d99e595e ("wifi: wilc1000: validate pairwise and authentication suite offsets")
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

Please fix your From field, it should be:

From: Amisha Patel <amisha.patel@microchip.com>

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230417184145.12593-1-amisha.patel@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

