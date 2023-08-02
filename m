Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C976D469
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHBQ6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjHBQ6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2B31722
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1A561377
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 16:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A81C433C8;
        Wed,  2 Aug 2023 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995486;
        bh=tDMJ1+pHyzwwwR9rnXV5McJ0yCrErYjLjZesacbe4Zg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hxg2lrFRjHjv8wAlZgyfbtmVYmRq9tHFWULhicYvlJVOOvLR2UnXBLoTXPiel/xAO
         Ji+4KlBta2TYhOz1YRhMVJQ2gn2h9F5jZa7U2mwYa8fx6ire1NSN9n2NL+n948nwNj
         FAFoOgLfBrUpZ1MLA9zNLG3g1ZH5at6Fqc/7J5qspKI9s3nkwFzlqpZTQT643IFA7E
         6auMyT79ZgmshlDBCGgCdVxrVAfZQATtb3YQgo3fyR7D10XeejO8NlFwdf60hKIu70
         QregPSmqwlKH0qh7BUcn0QvFQxO8XOkswrGlBISrEd159cyE5WFXc5YFNta18rzwvO
         R8bn2JfZEezUg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: avoid array overflow of hw mode for
 preferred_hw_mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714072405.28705-1-quic_wgong@quicinc.com>
References: <20230714072405.28705-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099548389.463701.90643016319296272.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 16:58:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently ath12k define WMI_HOST_HW_MODE_DBS_OR_SBS=5 as max hw mode
> for enum wmi_host_hw_mode_config_type, it is also same for the array
> ath12k_hw_mode_pri_map.
> 
> When tested with new version firmware/board data which support new
> hw mode eMLSR mode with hw mode value 8, it leads overflow usage for
> array ath12k_hw_mode_pri_map in function ath12k_wmi_hw_mode_caps(),
> and then lead preferred_hw_mode changed to 8, and finally function
> ath12k_pull_mac_phy_cap_svc_ready_ext() select the capability of hw
> mode 8, but the capability of eMLSR mode report from firmware does
> not support 2.4 GHz band for WCN7850, so finally 2.4 GHz band is
> disabled.
> 
> Skip the hw mode which exceeds WMI_HOST_HW_MODE_MAX in function
> ath12k_wmi_hw_mode_caps() helps to avoid array overflow, then the 2.4
> GHz band will not be disabled.
> 
> This is to keep compatibility with newer version firmware/board data
> files, this change is still needed after ath12k add eMLSR hw mode 8 in
> array ath12k_hw_mode_pri_map and enum wmi_host_hw_mode_config_type,
> because more hw mode maybe added in next firmware/board data version
> e.g hw mode 9, then it will also lead new array overflow without this
> change.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1e9b1363e2de wifi: ath12k: avoid array overflow of hw mode for preferred_hw_mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714072405.28705-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

