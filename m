Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA16C4736
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCVKG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCVKGU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 06:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB028532B8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 03:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACC761FEC
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40265C433D2;
        Wed, 22 Mar 2023 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679479579;
        bh=CsjaIYS2qGvXc8fSVyo4ENm6K5YOcQPAEp8BXkXVdM0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=A0utQ/9PBLEOFiAptg6qkqdK3uZraY0rWphgly/ewcl+wL//YoZ97+MNsMcz+OYbX
         jeR5iRCYDil1WCvMhUSCEwvRxTq8IoO9tlOgA5Qt45T/DDowolVZ2zJ5LSyDKd4nPh
         qIhQJaWGbPw11BQN+Q/glqhmjjLz6p6vWdCkKTuMHUujJJ7agR1/on+dmteedR4jnr
         GhHQD5PdG+Ycb4gOFbGxOv/AvRiWIVgClMrtG6dWXN3r6dbIbtjJV4ckuLOcBPBhhv
         UDphR+uhwm5t7y0kgZ/0zs8dgzsZFdinol8l7GYfxX5ms5e2K61383tVYKqmkTkTg+
         CS8baoRcAGyow==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Identify DFS channel when sending scan
 channel
 list command
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230316041144.7770-1-quic_bqiang@quicinc.com>
References: <20230316041144.7770-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167947957332.29931.14263672557733620301.kvalo@kernel.org>
Date:   Wed, 22 Mar 2023 10:06:18 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> WMI_CHAN_INFO_DFS flag should be set when configuring a DFS channel
> included in scan channel list. Without it, firmware will not send a
> probe request frame which is needed in connection to an AP configured
> with hidden SSID/network_id. So fix this to allow probe request frames
> to be sent in cases where a beacon frame has been seen on the channel
> first.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4c26033d75e4 wifi: ath12k: Identify DFS channel when sending scan channel list command

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230316041144.7770-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

