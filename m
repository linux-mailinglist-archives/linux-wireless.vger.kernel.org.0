Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F55FC0D1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJLGlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 02:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJLGlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 02:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBEF4D818
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 23:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96929B8166B
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 06:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D460C433C1;
        Wed, 12 Oct 2022 06:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665556909;
        bh=VpGvA92+eNn2z/51V0SAMekoYf0jBIGTRdYI6T6dEbQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DBOKB49/xTPht4HW8y7vGwtK8ajIGafaNfSgOjKbGaOee4PYXDJuiaXQ9tK6zq0Bx
         chDQQStdxOdmiywhZzN2L5tP6EV29yjy59TNFeVztNsRLFyWs/w+UAd5rVHB36f9Yi
         un+N6cJXhIpNCi9WRwhHYwd5ifpohVNb5Wv+oEzS9v5lu9M2fX+jRurURsFzyEVgmt
         UzveL0dum7nuiUFAB6n4IEwQ9TMcCRj5F61iT+oZnaPu1Hj0RQJlAPGZE0i8uEOEx6
         w1kxu+BzvXPMPGZzcPvIjQLxYAYSg23BpB5aUND0rKfYNz3ujF+n0URESzYl0YV0ca
         rXEn6aimvEk/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: add support to configure channel dwell time
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221007051130.6067-1-quic_mpubbise@quicinc.com>
References: <20221007051130.6067-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166555690629.24262.3012196197075046477.kvalo@kernel.org>
Date:   Wed, 12 Oct 2022 06:41:48 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Add support to configure channel dwell time during scan.
> Dwell time help to stay on the channel for a specified duration
> during scan and aid userspace in finding WiFi networks. Very
> useful in passive scans where longer dwell times are needed
> to find the WiFi networks.
> 
> Configure channel dwell time from duration of the scan request
> received from mac80211 when the duration is non-zero. When the
> scan request does not have duration value, use the default ones,
> the current implementation.
> 
> Advertise corresponding feature flag NL80211_EXT_FEATURE_SET_SCAN_DWELL
> to enable the feature.
> 
> Change is applicable for all ath11k hardware.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c362daa213cd wifi: ath11k: add support to configure channel dwell time

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221007051130.6067-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

