Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1250C891
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiDWJaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiDWJaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 05:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04901F3E59
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 02:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944E660C8B
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 09:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3603EC385A0;
        Sat, 23 Apr 2022 09:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650706042;
        bh=3H37Rzqk1FeYhFU0BDkTs02vxT4OQtbKSHd2qad04g4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sBWG/lcaiH1iCoWYQ4E9dT/hgN77tKdFs7ZEzHVNPl74ed4+hajgstc8zxh1hQlos
         fZqit9Y/RoqvMNuOFe9lpVROVL739sNBlY2V1hcDM3mfJLBCEK3QH9EjIkqjwpHazP
         /c2o/PCS5dvw3z4rBbPWTF61rcJgnf/QaeMcqQ2V/A8c17psPYrsGTFQD8DDdsbHu2
         sxtkS3lzgqcs8JhsnJ0Q4mseonLXbtBpVJscBhR/t5aVcXGPt19CfuFSD9RxLhje2R
         BQbLUWazoySWOSviKTd10TNwspmIkH8Srwzh8Mfh/0/aAluZJaQu3PrRh8PjvWJWIU
         WbS5FEnBRntvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] ath11k: add support for extended wmi service bit
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220401120948.1312956-2-quic_bqiang@quicinc.com>
References: <20220401120948.1312956-2-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165070603759.959.12335103712357746834.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 09:27:21 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> When the WMI service bits are reported from firmware they are divided into
> multiple segments, with 128 bits in each segment. The first segment is
> processed by ath11k_wmi_service_bitmap_copy(), the second segment is processed
> by ath11k_service_available_event() with WMI_TAG_SERVICE_AVAILABLE_EVENT. When
> the service bit exceed 256 bits, then firmware reports it by tag
> WMI_TAG_ARRAY_UINT32 in WMI_SERVICE_AVAILABLE_EVENTID.
> 
> Currently ath11k does not process the third segment. Upcoming features
> need to know if firmware support is available for the features, so add
> processing of the third segment.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

e2e23a791745 ath11k: add support for extended wmi service bit
652f69ed9c1b ath11k: Add support for SAR

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220401120948.1312956-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

