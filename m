Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAB7B584A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbjJBQxw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjJBQxu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 12:53:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86B8E1
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 09:53:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1933EC433C8;
        Mon,  2 Oct 2023 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265627;
        bh=oTuYt4RKTX5vllByYPk/pwJSTZDswhr00Q277HMhn70=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hFf9DP4T4MLMSB0Z2Q2Wl1QtBGIGcckftF1zzpfwVx5bLlx+W6MTaVN1+FKwoka5g
         AQnfy1+M99FqKxmxzOKXWk53iohWqEl//EbRXQZwr+YhPMWvMZCHSHewcxX8rNt83Q
         EfSfLFPAzY/1ehQCbWeDJ9Q8+Kgjr7+sV4AB6V1Bfc10HmFY6pmc4G0Ybmze6YCnse
         UmffHpasUAgXUj4fDab3vjHJgo6KjXzywJD3MYqHWHJgfZjEeIqFb71iRAC+G+AVxi
         CbyeuKzO1V36mfv5y6d/bsyexhXXuD4bbb6CeI3P3C5YFwBxqpujS+M1Y5kVA72jYj
         mvfNEU+rls9qw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add keep backward compatibility of PHY mode
 to
 avoid firmware crash
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230913105757.17744-1-quic_wgong@quicinc.com>
References: <20230913105757.17744-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626562397.3936351.5793272402512844617.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:53:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> In a special WCN7855 firmware release the EHT (IEEE 802.11be) support has
> been disabled for size reduction. Currently ath12k always enables EHT PHY
> mode during vdev start but with the special firmware that will cause a
> firmware crash during vdev start in firmware initialisation. This is
> because the firmware will use the EHT mode to allocate resources but as
> the EHT mode is not available in the firmware, there's an internal
> conflict and the firmware will crash.
> 
> To fix the crash check the WMI_TLV_SERVICE_11BE flag to see if the firmware
> supports EHT. If EHT is not supported downgrade the PHY mode to HE
> (IEEE 802.11ax).
> 
> This does not impact QCN9274, because WMI_SERVICE_11BE is always enabled
> for QCN9274, then eht_cap->has_eht will always set for it, and the logic
> of this patch will not take effect and the PHY mode will not down grade
> for it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

972754bfeec4 wifi: ath12k: add keep backward compatibility of PHY mode to avoid firmware crash

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230913105757.17744-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

