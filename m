Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DEE7AD620
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjIYKfl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjIYKfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 06:35:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F112A3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 03:35:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB1C433C7;
        Mon, 25 Sep 2023 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695638131;
        bh=JZ5uv7t3glsM4ahkV+/PvSpGadJDXXdYDes3y5CsZvw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Z7XVDPn+pa81kYHkfG6+EBiBPK7Gu0vXzK8g4NL73MvnyROpKTEvV57tn9Gk9MM53
         1w56wgFpsMSshWTkJJ7cPIvY5eDaMJxyqfoCm3l/zMUgtMn9HnBOMLTKxUEa+HObVz
         rXdxTREakbPDDxF2x3QPRQjUTKoTv170y1mOEwwwQ1goonEFmmwqFdELfc5SOoARKW
         mCN3UkVCGxsnF32lRKSItr5E2Z4YQHVoKoWJKy+iIhifOvI0/xFK0qMxC9q+LUfQmK
         lkpMWiDfd6lkvSOXsjgQbtxv2JecMbFQd4NjloXzUn+nt9WD+D9Nbsc7c+sWn9LUB8
         PW7GvoznMta6Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Wen Gong <quic_wgong@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Subject: Re: [PATCH v6 03/13] wifi: ath11k: fix a possible dead lock caused
 by ab->base_lock
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
        <20230920082349.29111-4-quic_wgong@quicinc.com>
        <f9f0b511-74ce-4c3b-afdf-6352faae2ddb@quicinc.com>
Date:   Mon, 25 Sep 2023 13:35:27 +0300
In-Reply-To: <f9f0b511-74ce-4c3b-afdf-6352faae2ddb@quicinc.com> (Jeff
        Johnson's message of "Thu, 21 Sep 2023 12:54:02 -0700")
Message-ID: <871qema6c0.fsf@kernel.org>
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

> On 9/20/2023 1:23 AM, Wen Gong wrote:
>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>> spin_lock/spin_unlock are used in ath11k_reg_chan_list_event to
>> acquire/release ab->base_lock, for now this is safe because that
>
> Kalle, can you s/, for/. For/ when you pull into pending?

Yes, will do. BTW to save time for simple edits like this I don't always
reply to you, I just do the edit the silently. In case you wonder if why
I don't reply.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
