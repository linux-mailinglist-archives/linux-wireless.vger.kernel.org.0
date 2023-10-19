Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0BD7CF479
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjJSJxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 05:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 05:53:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F528106
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 02:53:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F408C433C7;
        Thu, 19 Oct 2023 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697709219;
        bh=WuLlGEqjoehEfby0RKfxXzF4AUhxhkyRp8krWGQEpZw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=s/uuqQTKKeHSMWcRTOKEW+/NOuualBhDX/EUDLCUVsgLv/q5krD3HNZh6VGksGylO
         /Np7pFuyBI/6ReQXP+5LI0VGc6hHWyVCJ3ak2vVKNx3PI3iMf78CT27i+ZPMFmzYXm
         irFSN8VX6zHM85Y31JoWew53VvB+ODxvIc9qqoce4EgMrS3wftGkTI6weF0kkE8xnv
         Wc4sBDBOrGPeaWywc/fF+0u++Fgg1lXHQm+5PpSKHGNQ2NPGEAUg1jvClUO3EauWUr
         UMQvuegGf8s5NY4UTC/B7Gmep5vNROb9zwXNmPal6uQ8uV2c8zIN8WGphxVKMqAyJr
         x6Fe5kyCH+2Ag==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <mhi@lists.linux.dev>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
References: <20230727100430.3603551-1-kvalo@kernel.org>
        <20230727100430.3603551-3-kvalo@kernel.org>
        <d86d8f47-dbb2-1da6-794a-c020c317b4b5@quicinc.com>
Date:   Thu, 19 Oct 2023 12:53:36 +0300
In-Reply-To: <d86d8f47-dbb2-1da6-794a-c020c317b4b5@quicinc.com> (Jeff
        Johnson's message of "Thu, 27 Jul 2023 09:47:21 -0700")
Message-ID: <87ttqn0wgv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/27/2023 3:04 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> Simple refactoring to make it easier to add firmware-2.bin support
>> in the
>> following patch.
>> Earlier ath11k_qmi_m3_load() supported changing m3.bin contents
>> while ath11k is
>> running. But that's not going to actually work, m3.bin is supposed to the be
>
> nit: s/to the be/to be the/

Fixed in the pending branch, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
