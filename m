Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529C7508D76
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355821AbiDTQiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380668AbiDTQiu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 12:38:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29040E5F
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 09:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FFBCB82025
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 16:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18445C385A4;
        Wed, 20 Apr 2022 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472548;
        bh=X4OCNceuUdOmJ6pHXdidkIToDf/6iJZO1Nwm8PptHCw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rOhxEadSAFSWOFJVT7fk3pfeQ3evZubnWGtIHe4A7ipZ6q8GeclA862PbFaudVDMB
         iFDOsiM5HPJoF3xRKI7VNL9c/GQ7W76boIdIId4KbcZ5upi/2SzueW0t8+TOHHNi12
         c2X7YPabhshOTZ+8bwN+mgOavnL88FIMfjH6E7JAx+dk/tNDLsqhQVeagiW1KmSU7Q
         +V/nnVIjGcChcYyGJ7yhhGuBLAdz7A1ipyKuW2rIlC2howJa5udeTPeJtPfQoilAmQ
         ErIOxzmh6VZg+ug0MFNq6zuMTEmVtnis+8mloVP+zh/Jwm6FnbAwWLGa+Pw9s1Y2Xg
         X7OzPpWqRx/OA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] ath11k: Add support for SAR
References: <20220401120948.1312956-1-quic_bqiang@quicinc.com>
        <20220401120948.1312956-3-quic_bqiang@quicinc.com>
        <cb07aa82-2971-69dd-bf80-ff7f0cff4569@quicinc.com>
Date:   Wed, 20 Apr 2022 19:35:45 +0300
In-Reply-To: <cb07aa82-2971-69dd-bf80-ff7f0cff4569@quicinc.com> (Jeff
        Johnson's message of "Fri, 1 Apr 2022 12:06:44 -0700")
Message-ID: <87czhbogpq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/1/2022 5:09 AM, Baochen Qiang wrote:
>> ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops,
>> and this function is called when user space application
>> calls NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR
>> type and frequency ranges to wiphy so user space can query
>> SAR capabilities.
>
> I find this commit text very confusing since it uses "present simple"
> tense instead of "imperative" tense so it comes across as describing
> what the driver did prior to the patch instead of what the driver is
> supposed to do after the patch is applied.
>
> The patch itself LGTM.

I tried to improve the commit log, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6b0778eaea60533a8b48df2d890543a48b590f55

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
