Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8376D465
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHBQzJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBQzI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF2119
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E01615C2
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 16:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5A3C433C8;
        Wed,  2 Aug 2023 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995306;
        bh=qdxA9pBPS4Z9MxnRtXeIEl8r2HFOL4kudXJ/rb14Er0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mXmi1FFp6Z+WjzNyOq5aKuBff8NmVE3a/zlPystDO4PU3vGxmrDF2OPktMcul7Onq
         mrOWWOOmAmBWV+Tn0OZocRC6b7SeGr+uhnHQqRrzZ+5FWIRTdMSFlBzaUjjALviS+w
         eLgwB8uF8r1jcDgY6HesOWu9xDhOZXmy1cpWbs2AnyWdKa5dD67MFik/GvMHDQVVZ1
         EmmVwGl1jyXPIao/Rm4k3Xm54Qc6ptY6YPdWFFOuZqf5oP9G3+WaZyexT4mVq9MhU4
         4dt2fpyx/8XsAxHiup6MYeICFXM8lqW+1lu2MW1NAlGbyNZO78wn5MW3iXDZelnIip
         cUBR8jEaFioSA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: correct the data_type from QMI_OPT_FLAG to
 QMI_UNSIGNED_1_BYTE for mlo_capable
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230726093857.3610-1-quic_wgong@quicinc.com>
References: <20230726093857.3610-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099530370.463701.4567477992736594889.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 16:55:05 +0000 (UTC)
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

> Currently, the encoding rule for field mlo_capable in struct
> qmi_wlanfw_host_cap_req_msg_v01 defined in array
> qmi_wlanfw_host_cap_req_msg_v01_ei uses type QMI_OPT_FLAG.
> 
> Unfortunately, all ath12k firmware actually expects this field to be of
> type NON QMI_OPT_FLAG such as QMI_UNSIGNED_1_BYTE/QMI_UNSIGNED_8_BYTE...
> And as a result, firmware is unable to correctly decode the mlo_capable
> field.
> 
> Change the ath12k definition as QMI_UNSIGNED_1_BYTE to match the firmware
> definition so that firmware can correctly parse the mlo_capable info from
> message QMI_WLANFW_HOST_CAP_REQ_V01 at wlan load time.
> 
> This is just an accidental typo and that both WCN7850 and QCN9274 firmwares
> use QMI_UNSIGNED_1_BYTE.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

15c8441dc1ed wifi: ath12k: correct the data_type from QMI_OPT_FLAG to QMI_UNSIGNED_1_BYTE for mlo_capable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230726093857.3610-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

