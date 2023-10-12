Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881C47C720B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347300AbjJLQH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347325AbjJLQHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 12:07:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82CD7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 09:07:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912F4C433C7;
        Thu, 12 Oct 2023 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126832;
        bh=dlhYPohL4/FHPxTIqvDfTZt4Ty9fnbFTNIRlnAQLq+k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=b95L9ti2UPk1D7FzLoja4z3dl+fgywhvXy7DEQgk7f85NUKthMV3iz5phTOTNsTjH
         fVBXBTeEu3od3PF3a9/1rmFs0Uya66rZ7erF0KqqB8/hyQunYa3KwN5Hinhrh35wHo
         c9+v9pggmieOtHyT0dNaJN7fttbhLir8GrU2hHcs3OXCiHXEcfBvgLipVDoPVd6Ec8
         FB85nZtzU07opREVWteWk9lvYCNS3P5UTW9MlzWJCI2uakff6BPczkpgbvF/EFrW0+
         03KGz2yB+JNRjXnEz8WU3RNoCsiPn/5vfyplS6+3WNw4YXtqmCUY87U3kY7Q1gcqgO
         GcLIeNIz8dOzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: ath12k: configure RDDM size to MHI for
 device
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230721055305.20420-2-quic_wgong@quicinc.com>
References: <20230721055305.20420-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169712682952.3501995.7267871240531688486.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 16:07:11 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> RDDM is Ram Dump Debug Module which is used to debug issues when the
> firmware encounters an error. The rddm_size is needed by the firmware
> while MHI goes to the RDDM state. Provide the size to MHI subsystem so
> that the firmware restart works when the firmware crashes.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

ae3ed72020de wifi: ath12k: configure RDDM size to MHI for device recovery
92448f8718ba wifi: ath12k: add ath12k_qmi_free_resource() for recovery
c42c2b8224c4 wifi: ath12k: fix invalid m3 buffer address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230721055305.20420-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

