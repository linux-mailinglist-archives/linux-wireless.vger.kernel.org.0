Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DD4E246A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 11:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346370AbiCUKfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243217AbiCUKfO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 06:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653249CB0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 03:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D511661333
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E7AC340E8;
        Mon, 21 Mar 2022 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647858827;
        bh=JzwYf4qi3jqHOtC1dcLE0Loyi01CQES8KWgUsJ3jSd0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WvGZ9SyFzXS65SqaeACEZBpZZhM3dxBtc2furnYhhe6JgpmcMQTrD4jaeoVRtdeKe
         vLzemCWfoWa9i0aEtHOsXO67+skWTJFSlaYpq+4cC/XJ42utTwvH8xxFl5JIEza2A8
         j7eee0ixGI/aJyOdH/NNntbzqL8vbBz5CsAk7TrpABMIRLCT6PqyLFm3qe8zK/2zZk
         Hc7HM8x+fcR+5IO5jP9ZgBB0PoKqYR2lEzGx4bJbMYHlYhP8R1FlD+pQrjspZO0fwb
         /CRnVRBO0ndhEJUlEdEClXJY5JNoTI7YmH2J8M3w/UFP2y8yjYRYEga5uD4YNkYF/2
         qjGk9Nq5BwuXw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] ath11k: add read variant from SMBIOS for download board data
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
        <20220315104721.26649-3-quic_wgong@quicinc.com>
Date:   Mon, 21 Mar 2022 12:33:44 +0200
In-Reply-To: <20220315104721.26649-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 15 Mar 2022 06:47:21 -0400")
Message-ID: <874k3roarb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> This is to read variant from SMBIOS such as read from DT, the variant
> string will be used to one part of string which used to search board
> data from board-2.bin.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +	/* Copy extension name without magic prefix */
> +	if (strscpy(ab->qmi.target.bdf_ext, smbios->bdf_ext + strlen(magic),
> +		    sizeof(ab->qmi.target.bdf_ext)) < 0) {
> +		ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +			   "bdf variant string is longer than the buffer can accommodate\n");
> +		return;
> +	}

In the pending branch I changed this a bit to follow the style used in
ath11k:

@@ -548,8 +548,9 @@ static void ath11k_core_check_bdfext(const struct dmi_header *hdr, void *data)
        struct ath11k_base *ab = data;
        const char *magic = ATH11K_SMBIOS_BDF_EXT_MAGIC;
        struct ath11k_smbios_bdf *smbios = (struct ath11k_smbios_bdf *)hdr;
-       int i;
+       ssize_t copied;
        size_t len;
+       int i;
 
        if (ab->qmi.target.bdf_ext[0] != '\0')
                return;
@@ -587,8 +588,9 @@ static void ath11k_core_check_bdfext(const struct dmi_header *hdr, void *data)
        }
 
        /* Copy extension name without magic prefix */
-       if (strscpy(ab->qmi.target.bdf_ext, smbios->bdf_ext + strlen(magic),
-                   sizeof(ab->qmi.target.bdf_ext)) < 0) {
+       copied = strscpy(ab->qmi.target.bdf_ext, smbios->bdf_ext + strlen(magic),
+                        sizeof(ab->qmi.target.bdf_ext));
+       if (copied < 0) {
                ath11k_dbg(ab, ATH11K_DBG_BOOT,
                           "bdf variant string is longer than the buffer can accommodate\n");
                return;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
