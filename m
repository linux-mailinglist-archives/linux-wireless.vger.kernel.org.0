Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1454E7140
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354158AbiCYKdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 06:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358952AbiCYKdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 06:33:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7827CA0EE
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6947CB827EA
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 10:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D44C340F0;
        Fri, 25 Mar 2022 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648204304;
        bh=EjVkXtA8bWYwusJ7cnkFZ2L4T3qiD5nWqRzmc3b8aFo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YjRXe6utk4e+5Pbr+48He5pXRe4KJKA3Z8ZOtnsD9V7aiRT6u6+saPdQtE8JmVACB
         Axko06qR4ouVedWMqRvQM4L4md/zOjJFO2/K56JWB2geTFEyl9k19Xc7B8WgUeeWH1
         FsUna5k3w52DfwVAwr6ezPcrZwvfEFQyyEcQ0z9RgeNPinECZhOy0KCo6tPcwbcWVr
         G6fIwgZzQvXwfEFt9ZUh0MQz4bgy1+TNhBGVRq3R0quZylcmRhNK8qPGcdC+409RZK
         +2Axf+h5Mkp9vmSSAmDVnaphOdjj4NmiXwsjijDQcqHlho8dVAU2ez6C8PzJLOvdyI
         OAeQettzwZNvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] ath11k: Add peer rhash table support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1644036628-5334-1-git-send-email-quic_periyasa@quicinc.com>
References: <1644036628-5334-1-git-send-email-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164820430111.12637.15917942567266663243.kvalo@kernel.org>
Date:   Fri, 25 Mar 2022 10:31:43 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> When more clients (128) are connected, the UL data traffic
> KPI measurement is low compared to single client. This issue
> is due to more CPU cycles spent on the peer lookup operation
> with more clients. So reduce the peer lookup operation by
> modifying the linear based lookup operation into the rhash
> based lookup operation. This improve the peak throughput
> measurement. Since this is a software algorithm change, it is
> applicable for all the platforms.
> 
> TCP UL 128 Clients test case Observation (64bit system):
> Previous: ~550 Mbps
> Now     : ~860 Mbps
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7b0c70d92a43 ath11k: Add peer rhash table support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1644036628-5334-1-git-send-email-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

