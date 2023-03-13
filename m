Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F66B7704
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 12:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCML63 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCML6N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 07:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8BCA1B
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 04:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438A1611EE
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 11:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D52C433EF;
        Mon, 13 Mar 2023 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678708684;
        bh=Ha+uIvMW2/aH+2RENi0pSqMhBNN0v4raq7eSuJJCzDg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HBjkqun+WSCebGwLAXx7PyQI9o/dP+6thfamDb6RszxlD/Mg609tNorCCtkjqc4eg
         XsO7xMxFJkvShfoFO6pvqXvQ0/cpIDaMZxcQ5qvejpSji4me1xquP5ECzWCB6OY89i
         7xOcvBq/XXdh1fVNHddLJaML7l8Hu0L3mAzSbvD+nWtB8v80vGVYMkWxPj/FKQCwsN
         p75fod5vYXyoBBr8wMutm0mlBHhoU2/1hAP9S6v1J2w2AS7874iI/1a19dglbKDo1h
         760MD8PVIr5RtaXzntVlsYOXOYiYUfTvepnbHQUcvC+bTcuhoAgSGcX6JMrNdvoQGX
         yRxY0w4NVljzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wifi: ath11k: use proper regulatory reference for
 bands
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230110121024.14051-2-quic_adisi@quicinc.com>
References: <20230110121024.14051-2-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167870868163.13654.11725738349567591401.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 11:58:03 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Currently, during regulatory event, 2 GHz/5 GHz is referred
> to as 2G/5G including variable names. However, there is no
> such entity as 2G or 5G.
> 
> Re-name such occurences to its proper name. No functional changes.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

25e289e1f52e wifi: ath11k: use proper regulatory reference for bands
91fa00fa6922 wifi: ath11k: add support to parse new WMI event for 6 GHz
e238e62ba886 wifi: ath11k: add debug prints in regulatory WMI event processing

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230110121024.14051-2-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

