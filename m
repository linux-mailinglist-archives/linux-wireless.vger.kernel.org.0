Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBC7317F5
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjFOL4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbjFOL4b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 07:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755E4EE2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 04:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCD762E05
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 11:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B777C433C8;
        Thu, 15 Jun 2023 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829752;
        bh=yEoY0UYvPFrsskPQGds0JJD8CnZfl/Ux/qTTsuDLoW4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tTr/mA3mSeJUybTsonxyUU6aV587ERVxDbeQEilqsOEEswY789CigLYspxHULZqlE
         nQSkUKi/jgSwe226c4dUft/pztPiaT0MYUhuej9QiWW32P3s/Mup1p85yM8xniYNdc
         8knzZi7x5hhPwTACQhnILosKeV8Dp1Cwg5Ey/BjXyaMAJL0VF/y97jsC/nJJk9eCXP
         Oe22117o35zgykQLOqyxWchGW0uoE2u/iMvffjN61noUwL3Q60sI5Ywx7hTKangxBl
         +dzfcNzmlt7K5s7Jhp9RumneugYINT82IAIfoxdiEET/3nk7QPxJXKx6+rE/zTFFVw
         fk1ntjDQKyDAw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
Subject: Re: [PATCH v4 03/11] wifi: ath12k: WMI support to process EHT capabilities
References: <20230602235820.23912-1-quic_alokad@quicinc.com>
        <20230602235820.23912-4-quic_alokad@quicinc.com>
Date:   Thu, 15 Jun 2023 14:49:08 +0300
In-Reply-To: <20230602235820.23912-4-quic_alokad@quicinc.com> (Aloka Dixit's
        message of "Fri, 2 Jun 2023 16:58:12 -0700")
Message-ID: <87ttv9aqtn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> Add WMI support to process the EHT capabilities passed by
> the firmware. Add required EHT specific definitions in
> structures ath12k_band_cap and ath12k_wmi_svc_rdy_ext_parse.
>
> For single_pdev chip such as WCN7850, only one pdev is created
> and only one hardware is registered to mac80211. This one pdev
> manages both 2.4 GHz radio and 5 GHz/6 GHz radio.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Co-developed-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +struct ath12k_fw_pdev {
> +	u32 pdev_id;
> +	u32 phy_id;
> +	u32 supported_bands;
> +};

So we have now two very similar structures, ath12k_pdev and
ath12k_fw_pdev. It would be good to document above the structs their
purpose. Any ideas what I could add?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
