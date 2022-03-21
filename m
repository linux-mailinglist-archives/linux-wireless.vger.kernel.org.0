Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3107F4E2511
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 12:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiCULOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 07:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiCULOt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 07:14:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F283B016
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 04:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F97BCE176A
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 11:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C377C340E8;
        Mon, 21 Mar 2022 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647861200;
        bh=37HumeelAmj+a06ozPKOjEhe/rB5AW/qq4uImdHyqvg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cC+io+UwGcOs7TEL75cKfjk0/lfmZcSzdQfWaGJkYYXmN8frE9usrd5HMe0qAnmoD
         pYtdnOIMDQ+iH26QTTsnfHV2tXupHnKjysnCcCAmzQl2X7qYvF64A+tDgQ+sOQ+aid
         z0ZQm+hxHRrMDFjgxJB/QeuVlXjLMJT16RLPSAzv16Yos+SnOGC1x9HnFm/qZ/xZXq
         uBkTR+18coUpSUE8lGOQLIdCrov04WctaKoNso4ALEAaHowNXwTJAbHj29PmbyQYLk
         gi76yduy9oxOaJKD552y9u5uO146E5fC6jchVkM/UVfzovPFX52pYDXby48kQirZow
         oe69kDTONvRYA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/3] ath11k: add support muti-type regdb data for WCN6855
References: <20220319023543.14288-1-quic_wgong@quicinc.com>
Date:   Mon, 21 Mar 2022 13:13:14 +0200
In-Reply-To: <20220319023543.14288-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Fri, 18 Mar 2022 22:35:40 -0400")
Message-ID: <87v8w7mud1.fsf@kernel.org>
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

> Add enum value ATH11K_BD_IE_REGDB and enum type ath11k_bd_ie_regdb_type
> for regdb data, the board-2.bin will include both board data and regdb
> files.

In the pending branch this conflicted with your varian changes:

<<<<<<< current
		ath11k_dbg(ab, ATH11K_DBG_BOOT,
			   "failed to fetch board data for %s from %s\n",
=======
		ath11k_err(ab,
			   "failed to fetch %s for %s from %s\n",
			   ath11k_bd_ie_type_str(ie_id_match),
>>>>>>> patched

I used ath11k_err() for now, but I suspect I need to change it to
ath11k_dbg(). Will no better after some testing and review.

--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -954,7 +954,10 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
                return ret;
        }
 
-       ret = ath11k_core_fetch_board_data_api_n(ab, bd, fallback_boardname);
+       ret = ath11k_core_fetch_board_data_api_n(ab, bd, fallback_boardname,
+                                                ATH11K_BD_IE_BOARD,
+                                                ATH11K_BD_IE_BOARD_NAME,
+                                                ATH11K_BD_IE_BOARD_DATA);
        if (!ret)
                goto success;

This was an easy compilation fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
