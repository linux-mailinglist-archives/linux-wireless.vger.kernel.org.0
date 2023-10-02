Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDD7B5817
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjJBQOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjJBQON (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 12:14:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D4A107
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 09:14:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438F6C433C8;
        Mon,  2 Oct 2023 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263246;
        bh=MYOcq/f37Tq8zr3wS1nmV9Ey9mP0nvdOGbnwCPOj3us=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GNwgRm0r7jmfum3leufEBafPwyYNDz167/l+uHgvFczF8zshQbHEOQm1FyhqWRf6m
         WUvowLKez2k1F1+lHdeoXMhnKgEVqUom0C/n8MfiycQAddXzDSXYQSck8Rppus6bf5
         bWukMlKW6CYr0T7er60YH4Che0fs9raCQWuc68wSTT+NNoWNS0UGu4C8bUalsypQOu
         ntrWAdz9E9AAkpVZ7JQHZYoQPYYefVW13wjeIgIPIe0DvfaN6Q8Xyr7jj6luR8REmV
         18GFscmhjmYWJjOYcg/p16H9OUsI135ih7M0YuYKWMiwZYY6ZOjTwOs1GdbEvY56tN
         p7fd18a14EIyw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add read variant from SMBIOS for download
 board
 data
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230905105637.10230-1-quic_wgong@quicinc.com>
References: <20230905105637.10230-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626324327.3936351.13611584406343769411.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:14:05 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> This is to read variant from SMBIOS such as read from DT, the variant
> string will be used to one part of string which used to search board
> data from board-2.bin.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7d9832e3b538 wifi: ath12k: add read variant from SMBIOS for download board data

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905105637.10230-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

