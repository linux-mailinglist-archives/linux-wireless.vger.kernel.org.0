Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3F4D4243
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbiCJINt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 03:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiCJINr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 03:13:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFF6384
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 00:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1324F61B2D
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7B2C340E8;
        Thu, 10 Mar 2022 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646899965;
        bh=Y1ctv1TnCkh7mgHyERO8uAQvrjaWCyFyRyDdJXsAbRI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JOwXy1tr7NDiHU3Pj6C4UHx4eDwO5B6qGIP45oBluySYP5Pg8XzVsvJzX3EVZ/C79
         dXHMJNiDlXvq4EjErKJDerDNd7zV9CprHk3vEUr0DgVL+Bmb9z3fMyW7UL0PV5/0zC
         zVq80LF89glOuc4jRNLk0FCa6C6Bj5iCS02XDAQcmCcIRsXjBN/Q7nEjKls9omOqip
         EK4i+vErLLnwGF807grYiCmpXucmEC2eXKyuCfuRhBUlLhCv0eSaUQaJrAN6aoPwzF
         Ga4Oy2wELTBqzuRpFTV9nTKmhkiGhq/96QcKsqhpr/3uEEw0U9UGFGqpMzIA6I+xa2
         veDQDmcI1ctTw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] ath11k: add read variant from SMBIOS for download board data
References: <20211220064829.17557-1-quic_wgong@quicinc.com>
        <20211220064829.17557-3-quic_wgong@quicinc.com>
Date:   Thu, 10 Mar 2022 10:12:40 +0200
In-Reply-To: <20211220064829.17557-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Mon, 20 Dec 2021 01:48:29 -0500")
Message-ID: <87wnh2ql8n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +static void ath11k_core_check_bdfext(const struct dmi_header *hdr, void *data)
> +{
> +	struct ath11k_base *ab = data;
> +	const char *bdf_ext;
> +	const char *magic = ATH11K_SMBIOS_BDF_EXT_MAGIC;
> +	u8 bdf_enabled;
> +	int i;
> +	size_t len;
> +
> +	if (ab->qmi.target.bdf_ext[0] != '\0')
> +		return;
> +
> +	if (hdr->type != ATH11K_SMBIOS_BDF_EXT_TYPE)
> +		return;
> +
> +	if (hdr->length != ATH11K_SMBIOS_BDF_EXT_LENGTH) {
> +		ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +			   "wrong smbios bdf ext type length (%d).\n",
> +			   hdr->length);
> +		return;
> +	}
> +
> +	bdf_enabled = *((u8 *)hdr + ATH11K_SMBIOS_BDF_EXT_OFFSET);
> +	if (!bdf_enabled) {
> +		ath11k_dbg(ab, ATH11K_DBG_BOOT, "bdf variant name not found.\n");
> +		return;
> +	}
> +
> +	/* Only one string exists (per spec) */
> +	bdf_ext = (char *)hdr + hdr->length;

A proper struct is preferred over pointer arithmetic. For example
something like this:

struct ath11k_smbios_bdf {
        struct dmi_header hdr;
        u32 padding;
        u8 bdf_enabled;
        u8 bdf_ext[ATH11K_SMBIOS_BDF_EXT_MAX_LEN];
}

I'm not sure if I got the offsets right, but I hope you get the idea
anyway.

> +
> +	if (memcmp(bdf_ext, magic, strlen(magic)) != 0) {
> +		ath11k_dbg(ab, ATH11K_DBG_BOOT,
> +			   "bdf variant magic does not match.\n");
> +		return;
> +	}
> +
> +	len = strlen(bdf_ext);

What if bdf_ext is not null terminated? Wouldn't strnlen() with
ATH11K_SMBIOS_BDF_EXT_MAX_LEN would be safer?

> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -971,7 +971,18 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
>  			  struct ath11k_board_data *bd);
>  void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
>  int ath11k_core_check_dt(struct ath11k_base *ath11k);
> +/* SMBIOS type containing Board Data File Name Extension */
> +#define ATH11K_SMBIOS_BDF_EXT_TYPE 0xF8
>  
> +/* SMBIOS type structure length (excluding strings-set) */
> +#define ATH11K_SMBIOS_BDF_EXT_LENGTH 0x9
> +
> +/* Offset pointing to Board Data File Name Extension */
> +#define ATH11K_SMBIOS_BDF_EXT_OFFSET 0x8
> +
> +/* The magic used by QCA spec */
> +#define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
> +int ath11k_core_check_smbios(struct ath11k_base *ab);
>  void ath11k_core_halt(struct ath11k *ar);
>  int ath11k_core_resume(struct ath11k_base *ab);
>  int ath11k_core_suspend(struct ath11k_base *ab);

Please don't mix defines and function declarations, so move defines up
in the file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
