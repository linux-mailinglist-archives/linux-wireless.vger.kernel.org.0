Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A35780D6
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiGRLeY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGRLeY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 07:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E7B1EF
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 04:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A1761329
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 11:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26BC341CA;
        Mon, 18 Jul 2022 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658144058;
        bh=p2DnW6dkt3LhjszpEp8PBnTVMIwvYhQzs5XOixnZxMI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Qnd/pJhS1rcRqcILySkhqW7UMMlDX6I3mET3NDZUs0u1SQ/tWqGB9MvRQf/yMV/zz
         JkRu2x20ufOHl98sPHsFeIjaT+7QfQ50Rpabu9CgnpK9bcDlcz8IzB/LLiOoB2JnM3
         88xuD6SXRskepiT0RNMxXKJoAJdRaegseWqbYW7ogub+Us+/d8ENKjNQCyjRnl6nog
         Zvx6aiDks44QUZjAn/YJOtqb264ozHW9aY680WYFd2XUtFD7JU79KPUYD79eAtBjUk
         AfknbXDAaMOans8ma+XNm/s3o6D35zIHrhUJDGtgyUH3hV4t5lZdAElkHiVnacY1d8
         mzmS8A6LYQsCw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2022-07-11
References: <b85651ee-d469-aff9-e351-c65868be34f3@nbd.name>
Date:   Mon, 18 Jul 2022 14:34:14 +0300
In-Reply-To: <b85651ee-d469-aff9-e351-c65868be34f3@nbd.name> (Felix Fietkau's
        message of "Mon, 11 Jul 2022 13:45:31 +0200")
Message-ID: <87bktmslhl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.20
>
> - Felix
>
> The following changes since commit 58b6259d820d63c2adf1c7541b54cce5a2ae6073:
>
>   wifi: mac80211_hwsim: add back erroneously removed cast (2022-07-11 13:16:30 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-07-11
>
> for you to fetch changes up to 454b768f9ba653d65968c1ef29d2d4aa477147ea:
>
>   mt76: mt7921: Let PCI core handle power state and use pm_sleep_ptr() (2022-07-11 13:40:03 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.20
>
> - preparation for new chipset support
> - fixes
> - VHT/HE related improvements
> - ACPI SAR support
>
> ----------------------------------------------------------------

Manually pulled, thanks. There were trivial mac80211 API changes in
start_ap() and stop_ap(), I fixed those during commit.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
