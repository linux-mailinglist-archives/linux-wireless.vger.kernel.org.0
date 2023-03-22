Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7086C4731
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 11:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCVKFe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVKFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 06:05:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8C1A49A
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 03:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27091B81B8E
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0174DC4339B;
        Wed, 22 Mar 2023 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679479529;
        bh=mwPgbI5uMot2tExBjeYW8wbU82X3BixCLrz25CL5qlk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lkrBCu6+5t0WzdskYOpQi22y1L5S/ZD49eMdnPg+ZNikceOSOUyXfYrKnHSEaA3jE
         gqJR1j9UeHXKxGata9aFLP1+Do8QOCzpdLbCVWIoRtATR+3L0Pm9+Cus+ocZraeNj6
         +0Igz1Z5T0aZ0P8FLzb2c7rGMWYcKqH3V14nmsu2eM0uGwJkGL9R3WEfMV8EMKjmGv
         jFmooW2ymFRqyILvMUJPub4683JZ2HdIwVKV8KponiuU5hQMC4/pkrMio70YXzJ6Ii
         yA57JmCBtrWvbwNPoyF/wDZFtiUpL72xvZYrZNgpZeygxQwh7HHNEBXsXGc862SC+j
         /sR7c1Gf0kUCA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix memory leak in
 ath12k_qmi_driver_event_work()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230315090632.15065-1-quic_rajson@quicinc.com>
References: <20230315090632.15065-1-quic_rajson@quicinc.com>
To:     Rajat Soni <quic_rajson@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167947952529.29931.8146438365392973655.kvalo@kernel.org>
Date:   Wed, 22 Mar 2023 10:05:28 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rajat Soni <quic_rajson@quicinc.com> wrote:

> Currently the buffer pointed by event is not freed in case
> ATH12K_FLAG_UNREGISTERING bit is set, this causes memory leak.
> 
> Add a goto skip instead of return, to ensure event and all the
> list entries are freed properly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

960412bee0ea wifi: ath12k: fix memory leak in ath12k_qmi_driver_event_work()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230315090632.15065-1-quic_rajson@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

