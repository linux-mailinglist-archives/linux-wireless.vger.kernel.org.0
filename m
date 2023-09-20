Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3A7A833D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjITNYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjITNYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:24:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584CAC
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:24:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90ADC433C9;
        Wed, 20 Sep 2023 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216279;
        bh=RwL3dL2/nzqtTW9xS47chqHQeFCLtHtSkPRtK73J8UI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eRDoAeClGwjnXpGQTpftuBnk/x61KsR8isNBmuwdC78r2e6QRu/MTa1L2n599MYCN
         jHW/gy2U3zlOQ3wKYw7863hcGnKa8IkUVVscgTYoF8PTcUFCmO3fbLNlOk5nFwIui8
         U10S77ytegjjPXJvgg1586thw2fGgiLgTcCqx775p5cg+/KgwqA43kznnTqSvrSez/
         7mn8Dt9VXtOSqmCt39wPn0orq/Mt00EGCWFfKgyQ1PaecyTAHf1WR8EmbzrGu0nXJj
         zDgZAi9Yot2XG5uB2BtEvZ690BR5qrHOV/OBJEeWLtqXHQkyp6LftqC1BimVsfRJkv
         6YyYLnRJnjaUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band
 in
 EHT PHY capability for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230828040420.2165-1-quic_wgong@quicinc.com>
References: <20230828040420.2165-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521627689.1118199.8777112577980679434.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:24:38 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> 320 MHz bandwidth is reported only for single PHY mode for WCN7850, get it
> from WMI_HOST_HW_MODE_SINGLE ath12k_wmi_caps_ext_params and report it for
> 6 GHz band.
> 
> After this patch, "iw list" shows 320 MHz support for WCN7850:
> 
> EHT Iftypes: managed
>         EHT PHY Capabilities: (0xe26f090010768800):
>                 320MHz in 6GHz Supported
>         EHT bw=320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
>         EHT bw=320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
>         EHT bw=320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d4e244c85e45 wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY capability for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230828040420.2165-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

