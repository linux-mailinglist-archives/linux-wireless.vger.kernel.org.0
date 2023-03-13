Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0481F6B7949
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCMNoo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCMNon (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:44:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C485617E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 404CBB81116
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E607C433D2;
        Mon, 13 Mar 2023 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715078;
        bh=nZV7g9Gds4xB3stKS3oXsSZOBzqP3aP3v5CbIFR+MO8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VC0nS95yxG+7+vC4/2GrJzBBmvfDcs4Yx5gCPSbxdiw/Ch3vp4vFHdy/psP6kZYTl
         Ezgxp2eTKrpF0vujIBtZVOiDFK1InmMbG5LUO+X6Se26x14sGe/kDu4XNmzX8Wla88
         eeEK+LR9UFAWVz8+ka5bknF4OegRsTZK6ApHn7Gqe3yqLdITrFEpywF5Vaeg4Pbx6x
         NYMGqFUcX8hOSZjwhbGeJak1H2Y9v5fXwjL5MAQTv+YoV08nu/luniFU0AImfNzlb5
         zy5TjL5B3qK2frSvfhr36L+o/7ZasDt2weFbcS5eADVM9DT0nKrimNmS9o0OwRpjNr
         KUBn8EEC4yy+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: qtnfmac: use struct_size and size_sub for
 payload
 length
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230307230212.3735818-1-jacob.e.keller@intel.com>
References: <20230307230212.3735818-1-jacob.e.keller@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871507575.31347.8375689322848521976.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:44:37 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> wrote:

> Replace the calculations for the payload length in
> qtnf_cmd_band_fill_iftype with struct_size() and size_sub(). While
> the payload length does not get directly passed to an allocation function,
> the performed calculation is still calculating the size of a flexible array
> structure (minus the size of a header structure).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Igor Mitsyanko <imitsyanko@quantenna.com>
> Cc: Sergey Matyukevich <geomatsi@gmail.com>

Patch applied to wireless-next.git, thanks.

84e9e2102bdc wifi: qtnfmac: use struct_size and size_sub for payload length

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230307230212.3735818-1-jacob.e.keller@intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

